class CfgPatches 
{
	class mdhAiTracer
	{
		author = "Moerderhoschi";
		name = "MDH AI Tracer";
		url = "http://moerderhoschi.bplaced.net";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		version = "1.20160815";
		versionStr = "1.20160815";
		versionAr[] = {1,20160816};
		authors[] = {};
	};
};

class CfgFunctions
{
	class mdh
	{
		class mdhFunctions
		{
			class mdhAiTracer
			{
				file = "mdhAiTracer\init.sqf";
				postInit = 1;
			};
		};
	};
};

class CfgMods
{
	class mdhAiTracer
	{
		dir = "@mdhAiTracer";
		name = "MDH AI Tracer";
		picture = "mdhAiTracer\mdhAiTracer.paa";
		hidePicture = "true";
		hideName = "true";
		actionName = "Website";
		action = "http://moerderhoschi.bplaced.net";
	};
};