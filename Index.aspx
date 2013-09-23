<%@ Page Language="C#" MasterPageFile="{~/SITEMASTER}" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="{YOURPAGE}" Title="Untitled Page" %>
<script src="Assets/Scripts/jquery-1.7.min.js" type="text/javascript"></script>
<script src="Assets/Scripts/jsrender.js" type="text/javascript"></script>
<script src="Assets/Scripts/jquery.tools.min.js" type="text/javascript"></script>
<script src="Assets/Scripts/jquery-ui.min.js" type="text/javascript"></script>
<script src="Assets/Scripts/bootstrap.js" type="text/javascript"></script>
<script src="Assets/Scripts/bootstrap-alert.js" type="text/javascript"></script>
<script src="Assets/Scripts/modernizr.js" type="text/javascript"></script>
<script src="Assets/Scripts/knockout-2.0.0.js" type="text/javascript"></script>
<script src="Assets/Scripts/knockout.mapping-latest.js" type="text/javascript"></script>
<script src="Assets/Scripts/json2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function() {

        GetJson('<%=DefaultCategory%>', false);

        $('#CategoryWrapper li a').bind('click', function(event) {
            event.preventDefault();
            GetJson($(this).attr('rel'), true);
        });
        
        function GetJson(val, isRebind) {
            var jsonVal = JSON.stringify(val);
            if (!window.location.origin) window.location.origin = window.location.protocol + "//" + window.location.host + "/";
            $.ajax({
                type: 'POST',
                url: window.location.origin + '{whatever path leads to your json}',
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                data: "{\'id\':\'" + jsonVal + "\' }",
                success: function(data, msg) {
                    var json = JSON.parse(data.d);
                    bindModel(json, isRebind);
                },
                error: function(xhr, msg) {
                    //change this to the bootstrap dialog
                }
            });
        }
        var viewModel;
        function bindModel(data, isRebind) {
            if (isRebind != true) {
                viewModel = ko.mapping.fromJS(data);
                ko.applyBindings(viewModel);
            } else {
                ko.mapping.fromJS(data, viewModel);
            }
            //console.log(data)
            $("#SubCategoryWrapper").html($("#_tmplSubCategory").render(viewModel()));
        }
    });
    var i = -1;
    function demoCount() {
        return ++i;
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <header>
        <div>
            <hgroup>
                <h2>Select a category:</h2>
            </hgroup>
        </div>
     </header>
     <section>
    <div class="spacer15"></div>
    <div id="CategoryWrapper">
        <nav>
            <ul>
                <%foreach (var c in Categories){%>
                    <li>
                        <div>
                            <a href="" rel="<%=c.Id%>" class="plainLink">
                                <img src="Assets/Images/Icons/<%=c.Icon %>" style="width:76px; height:76px;" />
                                <p><%=c.Title%></p>
                            </a>
                        </div>
                    </li>
                <%} %>
            </ul>
        </nav>
    </div>
     <div class="spacer15"></div>

     <div id="SubCategoryWrapper"> </div>
     
     
     
        <script id="_tmplSubCategory" type="text/x-jsrender">
            {{for #data tmpl="#_tmplSubCategoryTitle"/}}
        </script>
        <script type="text/x-jquery-tmpl" id="_tmplSubCategoryTitle">
            <section>
                <div class="SubCategoryTitle">
                    <div>{{:Title()}}</div>
                </div>
                <ul>
                  {{for Demos() tmpl="#_tmplDemo"/}}
                 </ul>   
            </section>
        </script>
        <script type="text/x-jquery-tmpl" id="_tmplDemo">
            <li>
               <div class="DemoList">
                <div class="left DemoImage">
                    <a href="detail.aspx?id={{:Id()}}">
                        <img src=""/>
                    </a>
                </div>
                    <div class="left demoDetail">
                        <div><p class="demoTitle"><a href="detail.aspx?id={{:Id()}}" class="plainLink">{{:Title()}}</a></p><div>
                        <div class="demoDescriptionWrapper"><p class="demoDescription">{{:Description()}}</p></div> 
                        <div class="demoModelLink"><a href="detail.aspx?id={{:Id()}}" class="modelLink"><span>View Model</span></a></div>
                    </div>
               </div>
            </li>
            {{if #index%2 == 1 && #index+1 != #parent.data.length}}
                </ul><ul>
            {{/if}}
        </script>
        </section>

</asp:Content>

