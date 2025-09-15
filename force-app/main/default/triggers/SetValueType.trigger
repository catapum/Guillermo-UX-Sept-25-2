trigger SetValueType on AttributeDefinition (before insert, before update) {
    for (AttributeDefinition attDef : Trigger.new) {
        if (attDef.DataType == 'PickList') {
            String picklist = attDef.PicklistId;
            String sql = 'SELECT DataType from AttributePicklist Where id = :picklist';
            AttributePicklist attPickList = (AttributePicklist) Database.query(sql)[0];
            attDef.ValueDescription = attPickList.DataType;
        } else {
            attDef.ValueDescription = attDef.DataType;
        }
    }
}