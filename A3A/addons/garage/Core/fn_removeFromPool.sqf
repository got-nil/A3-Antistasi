/*
    Author: [Håkon]
    [Description]
        removes all checked out vehicles from the vehicle pool

    Arguments:
    0. <Int> Client UID

    Return Value:
    <Bool> succesfull

    Scope: Any
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [HR_GRG_PlayerUID] remoteExecCall ["HR_GRG_fnc_removeFromPool",_recipients];

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
params [["_UID", "", [""]], ["_player", objNull, [objNull]], "", "", ["_vehicle", objNull, [objNull]]];
diag_log _veh;
Trace_1("Removing vehicles from garage with UID: %1", _UID);
if (_UID isEqualTo "") exitWith {false};

//find vehicles to remove
private _toRemove = [];
{
    private _catIndex = _forEachIndex;
    private _hashMap = _x;
    {
        _veh = _hashMap get _x;
        if ((_veh#3) isEqualTo _UID) then {_toRemove pushBack [_catIndex, _x, _veh]};
    } forEach keys _x;
} forEach HR_GRG_Vehicles;

//remove vehicles
{
    //remove vehicle
    _x params ["_catIndex", "_entry"];
    private _cat = HR_GRG_Vehicles#_catIndex;
    private _removedVeh = _cat deleteAt _entry;

    //remove from source registre
    {
        private _index = _x find _entry;
        if (_index != -1) exitWith {
            (HR_GRG_Sources#_forEachIndex) deleteAt _index;
            [_forEachIndex] call HR_GRG_fnc_declairSources;
        };
    }forEach HR_GRG_Sources;

} forEach _toRemove;

//refresh category if client
if (!isNull player) then {
    {
        call HR_GRG_fnc_updateVehicleCount;
        if (ctrlEnabled _x) then {
            [_x, _forEachIndex] call HR_GRG_fnc_reloadCategory;
        };
    } forEach HR_GRG_Cats;
};

//attach death hook for logging purposes
_vehicle addEventHandler ["killed", {
    params ["_unit", "_killer"];
    [text format ["Unit destroyed | Class: %1 | netId: %2 | Killer: %3", typeOf _unit, netId _unit, _killer]] remoteExec ["diag_log"];
}];

//logging is low priority do it after done modifying the pool
{
    (_x#2) params ["_dispName", "_class", "", "_UID"];
    Info_5("By: %1 [%2] | Class: %3 | Type: %4 | netId: %5", name _player, _class, _dispName, _x#1, text (netId _vehicle));
} forEach _toRemove;

true
