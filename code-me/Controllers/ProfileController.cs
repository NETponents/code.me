using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Octokit;

namespace code_me.Controllers
{
    public class ProfileController : Controller
    {
        // GET: Profile
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult UserDetails()
        {
            ViewData.Add("user_name", "ARMmaster17");
            ViewData.Add("user_image", "https://avatars3.githubusercontent.com/u/4678601?v=3&s=460");
            
            return View();
        }
    }
}