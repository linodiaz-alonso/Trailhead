({
	packItem : function(component, event, helper) {
        var btnClicked = event.getSource();          // the button
        var item = component.get("v.item");
        component.set("v.item", item);
        component.set("v.item.Packed__c", true);     // update the checkbox
        btnClicked.set("v.disabled",true);
        
        // Create the new item
        helper.updateItem(component, item);
	},
    
	clickPacked: function(component, event, helper) {
        var item = component.get("v.item");
        var updateItem = component.getEvent("updateItem");
        updateItem.setParams({ "item": item });
        updateItem.fire();
    }
})