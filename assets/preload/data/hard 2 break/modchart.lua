--Modchart by Raltyro :)
local animStep = 0

function tablefind(table,v)
	if #table > 0 then
		for i,v2 in next,table do
			if v2 == v then
				return i
			end
		end
	end
end
-- Easing
function linear(t,b,c,d)
	return c * t / d + b
end
function outCubic(t,b,c,d)
	t = t / d - 1
	return c * (math.pow(t, 3) + 1) + b
end
function inCubic(t, b, c, d)
	t = t / d
	return c * math.pow(t, 3) + b
end
--]]

-- TweenNumber
local tn = {}
local tnv = {}
function tntick()
	local clock = os.clock()
	if #tn > 0 then
		for i,v in next,tn do
			if clock>v[4]+v[5] then
				tnv[v[1]] = v[3]
				if v[7] then
					v[7]()
				end
				table.remove(tn,i)
			else
				tnv[v[1]] = v[6](clock-v[4],v[2],v[3]-v[2],v[5])
			end
		end
	end
end

function tweenNumber(i,stv,v,time,easef,oncomplete)
	if #tn > 0 then
		for i2,v2 in next,tn do
			if v2[1] == i then
				tnv[i] = v2[3]
				table.remove(tn,i2)
			end
		end
	end
	table.insert(tn,{
		i,
		stv,
		v,
		os.clock(),
		time,
		easef,
		oncomplete
	})
end
--]]

tnv.notesshakestrength,tnv.notesshakepower,tnv.notesshakei,tnv.viewshake,tnv.notesangle = 0,0,0,0,0
local viewshakei = 0
function update(dt)
	tntick()
	tnv.notesshakei = math.fmod(tnv.notesshakei+(dt*tnv.notesshakestrength),math.pi*2)
	for i=0,7 do
		setActorX(_G['defaultStrum'..i..'X']+(math.sin((tnv.notesshakei+(i/1.5)))*tnv.notesshakepower),i)
		setActorY(_G['defaultStrum'..i..'Y']+9+(math.cos((tnv.notesshakei+(i/1.5)))*tnv.notesshakepower),i)
		setActorAngle(tnv.notesangle,i)
	end
	setHudAngle(math.sin(os.clock()+viewshakei)*16)
	setHudPosition(math.cos(os.clock()+viewshakei*1.25)*12*tnv.viewshake/1.25,math.sin(os.clock()+viewshakei*1.32)*8*tnv.viewshake/1.25)
	setCamPosition(math.cos(os.clock()+viewshakei*1.25)*12*tnv.viewshake,math.sin(os.clock()+viewshakei*1.32)*8*tnv.viewshake)
end

function animStep0fix()
	if curStep >= 64 and animStep == 1 then
		animStep = 2
		tweenNumber("notesshakestrength",0,8,.01,linear)
		tweenNumber("notesshakepower",0,16,.01,outCubic)
	end
end

local noteswingb = false
function noteswing(b)
	local angle = noteswingb and 45 or -45
	tweenNumber("notesangle",angle,0,.25,b)
	noteswingb = not noteswingb
end

local noteswingt1anim,noteswingt2anim,viewshakeanim = 1,1,1
local nst1anim,nst2anim = 1,1
local noteswingt1 = {104,106,108,110,120,122,124,126,168,170,172,174,190}
local noteswingt2 = {184,186,188}
local viewshaket = {
208,209,210,211,212,213,214,
248,249,250,251,252,253,254,
272,273,274,275,276,277,278,
312,313,314,315,316,317,318,
335,336,337,338,339,340,341,
399,400,401,402,403,404,405,
463,464,465,466,467,468,469,
528,529,530,531,532,533,534,
816,820,824,
944,948,952,
1232,1234,1235,1236,1237,1238,1239,
1296,1297,1298,1299,1300,1301,1302,
1360,1361,1362,1363,1364,1365,1366,
1424,1425,1426,1427,1428,1429,1430
}
local nst1 = {576,960,1024,1084,1152}
local nst2 = {704,992,1056,1120,1184}

function stepHit(step)
	if step >= 60 and animStep == 0 then
		animStep = 1
		tweenNumber("notesshakestrength",24,0,.25,outCubic,animStep0fix)
		tweenNumber("notesshakepower",0,24,.25,outCubic,animStep0fix)
		tweenNumber("viewshake",2.25,0,.25,outCubic,animStep0fix)
		tweenCameraZoomOut(.925,.25,animStep0fix)
	elseif step >= 64 and animStep == 1 then
		animStep = 2
		tweenNumber("notesshakestrength",0,8,.01,outCubic)
		tweenNumber("notesshakepower",0,16,.01,outCubic)
	elseif step >= 1472 and animStep == 2 then
		animStep = 3
		tweenNumber("notesshakestrength",8,0,.75,outCubic)
		tweenNumber("notesshakepower",16,0,.75,outCubic)
	end
	if nst1anim<=#nst1 and step>=nst1[nst1anim] then nst1anim = nst1anim + 1
		tweenNumber("notesshakestrength",8,4,.25,outCubic)
		tweenNumber("notesshakepower",16,8,.25,outCubic)
	end
	if nst2anim<=#nst2 and step>=nst2[nst2anim] then nst2anim = nst2anim + 1
		tweenNumber("notesshakestrength",4,8,.01,outCubic)
		tweenNumber("notesshakepower",8,16,.01,outCubic)
	end
	if viewshakeanim<=#viewshaket and step>=viewshaket[viewshakeanim] then viewshakeanim = viewshakeanim + 1
		tweenNumber("viewshake",1.5,0,.25,outCubic)
		viewshakei = viewshakei + math.random(1,3)
	elseif noteswingt1anim<=#noteswingt1 and step>=noteswingt1[noteswingt1anim] then noteswingt1anim = noteswingt1anim + 1 noteswing(outCubic)
	elseif noteswingt2anim<=#noteswingt2 and step>=noteswingt2[noteswingt2anim] then noteswingt2anim = noteswingt2anim + 1 noteswing(inCubic)end
end