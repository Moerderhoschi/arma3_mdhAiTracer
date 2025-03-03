///////////////////////////////////////////////////////////////////////////////////////////////////
// MDH AI TRACER
// MADE BY MOERDERHOSCHI
// ARMED-ASSAULT.DE
// 03.2025
///////////////////////////////////////////////////////////////////////////////////////////////////
0 = [] spawn
{
	if (isDedicated) exitWith {};
	waitUntil {sleep 1; !(isNull player)};
	waitUntil {sleep 1; player == player};

	///////////////////////////////////////////////////////////////////////////////////////////////////
	// DIARYRECORD
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_diary =
	{
		if (isNull player) exitWith {false};
		if(!(player diarySubjectExists "mdhAiTracer")) then
		{
			player createDiarySubject ["mdhAiTracer","MDH AI Tracer"];
			player createDiaryRecord
			[
				"mdhAiTracer",
				[
					"MDH AI Tracer by Moerderhoschi",
					(
						'<br/>MDH AI Tracer is a mod, created by Moerderhoschi for Arma 3.<br/>'
					  + '<br/>'
					  + 'Every AI units magazines get replaced with Tracer variants.<br/>'
					  + '<br/>'
					  + 'If you have any question you can contact me at the official Bohemia Interactive Forum: forums.bistudio.com<br/>'
					  + '<br/>'
					  + '<img image="mdhAiTracer\mdhAiTracer.paa"/><br/>'
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
	
	///////////////////////////////////////////////////////
	// set function
	///////////////////////////////////////////////////////
	_mdhFunction =
	{
		if (isServer) then
		{
			if (missionNameSpace getVariable ["pReplaceAiMagsWithTracer",1] == 1) then
			{
				0 spawn
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
					
								if (count _tracerMags > 0) then
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
		};		
	};

	///////////////////////////////////////////////////////
	// loop
	///////////////////////////////////////////////////////
	sleep 1;

	while {sleep 1; true} do
	{
		sleep random 1;
		0 = [_diary, _mdhFunction] spawn
		{
			waitUntil {!(isNull player)};
			waitUntil {player==player};
			0 = [] call (_this select 0);
			0 = [] call (_this select 1);
		};
		sleep 5;
	};
};