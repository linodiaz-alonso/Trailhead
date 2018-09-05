({
	updateItem: function(component, item) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        
        $A.enqueueAction(action);
    }
})