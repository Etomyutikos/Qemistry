<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.0">
    <TriggerPackage/>
    <TimerPackage/>
    <AliasPackage>
        <Alias isActive="yes" isFolder="no">
            <name>testQem</name>
            <script>balQueue = Qemistry.Queue(&quot;balance&quot;, &quot;my_sys.bal&quot;)
balQueue:Add( {
	code = {
		function () echo(&quot;bal 100\n&quot;) end,
		function () my_sys.bal = false; my_sys.eq = true end,
		function () eqQueue:Do() end,
	},
	consumed = &quot;my_sys.bal&quot;
} )
for i = 1, 99 do
	balQueue:Add( function () echo(&quot;bal &quot; .. i .. &quot;\n&quot;) end )
end
balQueue:Add( function () echo(&quot;Final call.\n&quot;) end )

eqQueue = Qemistry.Queue(&quot;eq&quot;, &quot;my_sys.eq&quot;)
eqQueue:Add( function () my_sys.bal = true end )
for i = 1, 99, 2 do
	eqQueue:Add( {code = function () balQueue:Add(&quot;eq &quot; .. i .. &quot;\n&quot;) end, required = function () return my_sys.bal end} )
end
eqQueue:Add( function () balQueue:Do() end )

--display( Qemistry.Queues )
echo(&quot;Test ready.\n&quot;)</script>
            <command></command>
            <packageName></packageName>
            <regex>^tq$</regex>
        </Alias>
        <Alias isActive="yes" isFolder="no">
            <name>balQueue</name>
            <script>balQueue:Do()</script>
            <command></command>
            <packageName></packageName>
            <regex>^bq$</regex>
        </Alias>
        <Alias isActive="yes" isFolder="no">
            <name>eqQueue</name>
            <script>eqQueue:Do()</script>
            <command></command>
            <packageName></packageName>
            <regex>^eq$</regex>
        </Alias>
    </AliasPackage>
    <ActionPackage/>
    <ScriptPackage>
        <Script isActive="yes" isFolder="no">
            <name>Qemistry</name>
            <packageName></packageName>
            <script>if not Qemistry then
	echo(&quot;Qemistry: Loading module...\n&quot;)

	local path = package.path
	local home_dir = getMudletHomeDir()
	local lua_dir = string.format( &quot;%s/%s&quot;, home_dir, [[?.lua]] )
	local init_dir = string.format( &quot;%s/%s&quot;, home_dir, [[?/init.lua]] )
	package.path = string.format( &quot;%s;%s;%s&quot;, path, lua_dir, init_dir )
	
	local okay, content = pcall( require, &quot;qemistry&quot; )
	package.path = path
	if okay then
		Qemistry = content
	else
		error(string.format(&quot;Qemistry: Error loading module: %s\n&quot;, content))
	end

	if Qemistry then
		echo(&quot;Qemistry: Module successfully loaded.\n&quot;)
	end
end</script>
            <eventHandlerList/>
        </Script>
    </ScriptPackage>
    <KeyPackage/>
</MudletPackage>
