using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(code.me.Startup))]
namespace code.me
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
