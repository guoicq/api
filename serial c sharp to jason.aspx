
<script type="text/javascript">
    var orderData = <%=Newtonsoft.Json.JsonConvert.SerializeObject(Model, new Newtonsoft.Json.JsonSerializerSettings { ContractResolver = new Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver() })%>;
</script>