using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using Newtonsoft.Json;

namespace DemoGallery.Service
{
    /// <summary>
    /// Summary description for SubCategoryDemos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class SubCategoryDemos : System.Web.Services.WebService
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json,UseHttpGet = false)]
        public string Get(string id)
        {
            var x = JsonConvert.DeserializeObject<int>(id);
            return
             JsonConvert.SerializeObject(SubCategory.GetAllSubCategoryDemo(x));
        }
    }
}
/*
 * http://stackoverflow.com/questions/2006828/possible-to-invoke-asmx-service-with-parameter-via-url-query-string
 *This must be added to the web.config to get the web service
 * call from the backbone code to work
 <webServices>
      <protocols>
        <add name="HttpGet"/>
      </protocols>
    </webServices>
 */