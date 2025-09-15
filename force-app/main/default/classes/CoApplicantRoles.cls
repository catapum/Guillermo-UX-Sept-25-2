global with sharing class CoApplicantRoles implements Callable
{
    // Dispatch actual methods
   public Object call(String action, Map<String, Object> args) {
       
       Map<String, Object> input = (Map<String, Object>)args.get('input');
       Map<String, Object> output = (Map<String, Object>)args.get('output');
       Map<String, Object> options = (Map<String, Object>)args.get('options');

       return invokeMethod(action, input, output, options);
   }

    private Object invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) 
    {
        if(methodName.equals('getCoApplicantRoles')) {
            // this returns the applicant roles
            return GetCoApplicantRoles(inputMap, outMap);
        }   

        return null;
    }
     
    /**
     * Get applicant role, excluding Primary Applicant value
     * @param inputMap input 
     * @param outputMap output from Apex
     * @return outputMap output from Apex to IP
     */
    public Object getCoApplicantRoles(Map<String, Object> inputMap, Map<String, Object> outputMap) {
        List<Map<String, Object>> optionList = new List<Map<String, Object>>();
        
        for (PicklistValueInfo role : [SELECT Label,value FROM PicklistValueInfo WHERE EntityParticle.EntityDefinition.QualifiedApiName = 'Applicant' AND EntityParticle.DeveloperName = 'Role' and isActive = true]) {
            if (!'Primary Applicant'.equals(role.Value)) {
                Map<String, Object> option = new Map<String, Object>();
                option.put('name', role.Value);
                option.put('value', role.Label);
                optionList.add(option);
            }
        }
        outputMap.put('options', optionList);
        return optionList;
    }
}