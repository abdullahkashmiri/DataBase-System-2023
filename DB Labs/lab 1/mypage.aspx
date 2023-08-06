
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mypage.aspx.cs" Inherits="WebApplication3.mypage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <asp:Image ID="Image2"  ImageUrl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-3GOCzkV644QlBbCqRQy1bVoabSOTBUNOTtSh3T2AvN36hz323zJEJt2onYlccsTL9Q&usqp=CAU"  runat="server" />
    <h2>Create an Account</h2>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            First Name:
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            Last Name:
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br> <br>
            User Name:
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br><br>
            Password:
            <asp:TextBox ID="Password" TextMode="password" runat="server"></asp:TextBox><br><br>
            Date Of Birth:
           <br>
           <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>


            <br><br>
           
            Country:
            <asp:DropDownList ID="ddlDepartment" runat="server">
            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
            <asp:ListItem Text="Afghanistan" Value="Afg"></asp:ListItem>
            <asp:ListItem Text="China" Value="China"></asp:ListItem>
            <asp:ListItem Text="Bangladesh" Value="Bangladesh"></asp:ListItem>
            <asp:ListItem Text="Denmark" Value="Denmark"></asp:ListItem>
            </asp:DropDownList>
            <br> <br>
             Gender: 
       
            <asp:RadioButton ID="rdMale" GroupName="Gender" runat="server" />
            Male
            <asp:RadioButton ID="rdFemale" GroupName="Gender" runat="server" />
            Female
            <br><br>
   
            <asp:CheckBox ID="chkEnablePrivacy" runat="server" />
                     Enable Privacy:
             <br> <br>
            <asp:Button ID="crtacc" Text="Create Account" runat="server" /> 
        </div>
    </form>
</body>
</html>