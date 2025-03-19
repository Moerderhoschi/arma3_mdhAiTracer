/////////////////////////////////////////////////////////////////////////////////////////////
// MDH AI TRACER(by Moerderhoschi) - v2025-03-16
// github: https://github.com/Moerderhoschi/arma3_mdhAiTracer
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3437872589
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pReplaceAiMagsWithTracer",99] == 99) then
{
	0 spawn
	{
		_valueCheck = 99;
		_defaultValue = 99;
		_path = 'mdhAiTracer';
		_env  = isServer;

		_diary  = 0;
		_mdhFnc = 0;

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH AI Tracer";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
			
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							'<br/>MDH AI Tracer is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'Every AI units magazines get replaced with Tracer variants.<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhAiTracer.paa"/><br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				{
					if (!(_x getVariable ["mdhReplaceAiMagsWithTracerSet",false])) then
					{
						if (!(_x in allPlayers) && {primaryWeapon _x != ""}) then
						{
							_x setVariable ["mdhReplaceAiMagsWithTracerSet",true];
							_u = _x;
							_tracerMags = [];
							{
								if ("tracer" in (toLowerANSI(_x))) then {_tracerMags pushBack _x};
							} forEach compatibleMagazines [currentWeapon _u, "this"];
				
							if (count _tracerMags != 0) then
							{
								{_u removeMagazines _x} forEach compatibleMagazines [currentWeapon _u, "this"];
								_u addPrimaryWeaponItem _tracerMags#0;
								for "_i" from 1 to 6 do {_u addMagazine _tracerMags#0};
							};
						};
					};
				} forEach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 2.1;
			call _diary;
		};

		sleep (2 + random 2);
		while {missionNameSpace getVariable ["pReplaceAiMagsWithTracer",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep (5 + random 3);
			if (hasInterface) then {call _diary};
		};
	};
};