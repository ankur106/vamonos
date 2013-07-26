class VarName

    constructor: ({container, @varName, @inputVar, @displayName, @watchable, @watching}) ->
        @$container   = Vamonos.jqueryify(container)
        @displayName ?= @varName
        @inputVar    ?= false
        @watchable   ?= true
        @watching    ?= false

        @watching   &&= @watchable

        if @inputVar
            @$editIndicator = $("<span>", {class: "var-editable", html: "&#x270e;"}).appendTo(@$container)

        if @watchable
            @$watchToggle   = $("<span>", {class: "var-watch", html: "&#x2605;"}).appendTo(@$container)
    
        @$varName           = $("<span>", {class: "var-name", html: @varName + ":"}).appendTo(@$container)


    event: (event, options...) -> switch event
        when "setup"
            [@viz] = options
            @viz.registerVariable(@varName) 
            @viz.setWatchVar(@varName)                    if @watching

        when "editStart"
            @setWatchStatus()
            if @watchable
                @$watchToggle.on("click", => @toggleWatch())
                @$watchToggle.prop("title", "Click to toggle breaking when this variable changes")

            if @inputVar
                @$editIndicator.addClass("var-editing")
                @$editIndicator.prop("title", "Now in edit mode, you can change the contents of this variable")

        when "editStop"
            if @watchable
                @$watchToggle.off("click")
                @$watchToggle.prop("title", "")

            if @inputVar
                @$editIndicator.removeClass("var-editing")
                @$editIndicator.prop("title", "")

        when "displayStart"
            @setWatchStatus()

        when "displayStop"
            @$watchToggle.removeClass("var-watch-active") if @watchable

        when "render"
            [frame] = options
            return unless @watchable
            if frame._snapshotReasons.watchVarsChanged? and @varName in frame._snapshotReasons.watchVarsChanged
                @$watchToggle.addClass("var-watch-active")
            else
                @$watchToggle.removeClass("var-watch-active")

    setWatchStatus: ->
        return unless @watchable
        if @viz.isWatchVar(@varName)
            @$watchToggle.addClass("var-watching")
            @watching = true
        else
            @$watchToggle.removeClass("var-watching")
            @watching = false

    toggleWatch: ->
        return unless @watchable
        if @watching
            @viz.removeWatchVar(@varName)
        else
            @viz.setWatchVar(@varName)
        @setWatchStatus()
        return false
        
Vamonos.export { Widget: { VarName }}