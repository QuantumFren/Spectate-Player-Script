if ( CLIENT ) then

    local main = function()

        chat.AddText( Color( 255, 0, 0 ), "[Neuro] ", Color( 0, 255, 0 ), "Spectate Player Script Loaded!" )
        surface.PlaySound( "npc/scanner/scanner_scan1.wav" )

        -- Build the VGUI...

        local frame = vgui.Create( "DFrame" )
        frame:SetSize( 580, 500 )
        frame:Center()
        frame:SetTitle( "Spectate Player Script - Version: Beta" )
        frame:SetIcon( "icon16/shield.png" )
        frame:SetVisible( true )
        frame:SetDraggable( true )
        frame:ShowCloseButton( true )
        frame:SetMouseInputEnabled( true )
        frame:SetKeyboardInputEnabled( true )
        frame:MakePopup()
        frame.Paint = function( _, w, h )

            draw.RoundedBox( 8, 0, 0, w, h, Color( 20, 205, 20, 240 ) )

        end

        -- Add a Player Table...

        local playerTable = vgui.Create( "DListView" )
        playerTable:SetParent( frame )
        playerTable:Dock( FILL )
        playerTable:SetMultiSelect( false )

        playerTable:AddColumn( "Player Name" ):SetWidth( 225 )
        playerTable:AddColumn( "Steam ID" ):SetWidth( 140 )
        playerTable:AddColumn( "Steam ID64" ):SetWidth( 140 )
        playerTable:AddColumn( "Account ID" ):SetWidth( 85 )

        -- Add a Line for Every Player Name, Steam ID, and Steam ID64...

        for _, p in pairs( player.GetAll() ) do

            if ( !p:IsNPC() && !p:IsBot() ) then

                if ( p:Name() != LocalPlayer():Name() ) then

                    playerTable:AddLine( p:Name(), p:SteamID(), p:SteamID64(), p:AccountID() )

                end

            end

        end

        -- Combine the Functions...

        playerTable.OnRowSelected = function( _, index, pnl )

            frame:Hide()

            local selectedPlayer = pnl:GetColumnText( 1 )

            RunConsoleCommand( "say", "!spectate " .. selectedPlayer )

            local selectedPlayerSteamID = pnl:GetColumnText( 2 )
            local selectedPlayerSteamID64 = pnl:GetColumnText( 3 )
            local selectedPlayerAccountID = pnl:GetColumnText( 4 )

            print( "\nSpectating: " .. selectedPlayer )
            print( "\nSteam ID: " .. selectedPlayerSteamID )
            print( "\nSteam ID64: " .. selectedPlayerSteamID64 )
            print( "\nAccount ID: " .. selectedPlayerAccountID )
            print( "\nIndex Row: " .. index )

            chat.AddText( Color( 255, 0, 0 ), "[Neuro] ", Color( 0, 255, 0 ), "Started Spectating!" )

        end

    end

    main()

    -- Spectate Menu Command on Hook...

    hook.Add( "OnPlayerChat", "SpectateCommand", function( _, text )

        text = string.lower( text )

        if ( text == "!spec" || text == "!spectate" || text == "/spec" || text == "/spectate" ) then
            
            main()

        end

    end )

end