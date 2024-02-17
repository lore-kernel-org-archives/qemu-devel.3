Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE18C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 22:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbTD6-0008LL-FU; Sat, 17 Feb 2024 17:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1rbTD2-0008LA-AL
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 17:31:00 -0500
Received: from mailout12.inleed.net ([185.189.50.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>)
 id 1rbTCs-00015g-AX; Sat, 17 Feb 2024 17:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XnRqtgwcxLgI6lIRK+bIuFwHZV/NnejVYe9RfYPE5bg=; b=UDmOb/PkNyB0gaetwHPxeS0Z37
 5BxRY/9c8asbsC4VkXRTT2igdHcqpDuOFxJ/anwrqJDYjVc9WACz4Bfl3ciLXQbPWKWHugdgC/9Kl
 Zn9Z6LElHnJwoEi6T3XF7O5N42s9PkNxhtxP2BonnMBm+Byy4YrOQZv2/zX0j1k9SoOQT7KvcrThH
 3Jmfww9eKw0Io96qDDUk9aoGSKxmMYpK+s8kXka6d7txw8ACwuH/3zp/sibOcIUHWixB2HLM1iyxs
 b2DB0rgW3hhV2JqVe8Go00WdtA/b/OEyLbg+5RbNY33hKltFxsUrJXq9ZYjixw1xibvw2+RvCbQOP
 z4RDippQ==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.97.1)
 (envelope-from <hc981@poolhem.se>) id 1rbTAl-0000000HPDM-3l27;
 Sat, 17 Feb 2024 23:28:39 +0100
Date: Sat, 17 Feb 2024 23:28:24 +0100
From: Henrik Carlqvist <hc981@poolhem.se>
To: Henrik Carlqvist <hc94@poolhem.se>
Cc: samuel.thibault@gnu.org, qemu-devel@nongnu.org
Subject: Ping 2: [PATCH v2] Allowing setting and overriding parameters in
 smb.conf
Message-Id: <20240217232824.3db4c9c7.hc981@poolhem.se>
In-Reply-To: <20230910134812.7fa3a603.hc94@poolhem.se>
References: <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
 <20230802195356.rwibjix3bub7s7qw@begin>
 <20230803010909.723e2c1f.hc981@poolhem.se>
 <20230802231324.b5zk2kf44oqzocel@begin>
 <20230803012602.7c75df75.hc981@poolhem.se>
 <20230802233404.lnpa5owybhvbbkyl@begin>
 <20230803171256.1d39d71f.hc981@poolhem.se>
 <20230910134812.7fa3a603.hc94@poolhem.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=185.189.50.81; envelope-from=hc981@poolhem.se;
 helo=mailout12.inleed.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Still wondering if there are any plans to apply my patch or if you would like
to change anything in the patch?

Being able to set parameters in smb.conf would be really useful these days for
people running old versions of Windows like Windows XP in a qemu guest. Today,
the default settings of Samba has disabled SMBv1 making old versions of
Windows unable to connect to Samba shares.

regards Henrik

On Sun, 10 Sep 2023 13:48:12 +0200
Henrik Carlqvist <hc94@poolhem.se> wrote:

> I'm just wondering if there are any plans to apply my patch in this version
> or if you would like me to change anything more in the patch? I am aware
> that during this time of the year many have been away on vacation and it has
> also been a new release 8.1 which has blocked any submitted patches but bug
> fixes. However, now might be a good time to push this patch towards master?
> 
> Best regards Henrik
> 
> On Thu, 3 Aug 2023 17:12:56 +0200
> Henrik Carlqvist <hc981@poolhem.se> wrote:
> 
> > From a6dfb322a88965281e3bba00a92f8d5e437bfa95 Mon Sep 17 00:00:00 2001
> > From: Henrik Carlqvist <hc1245@poolhem.se>
> > Date: Thu, 3 Aug 2023 16:52:25 +0200
> > Subject: [PATCH] Allowing setting and overriding parameters in smb.conf,
> >  moving some parameters from the [qemu] section to the [global] section to
> >  allow them to get overridden by custom user settings.
> > 
> > Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> > ---
> > 
> > In this second version of the patch I have moved also the "force user" 
> > parameter to the global section of smb.conf. Even though I do not self see
> > the usefullness of altering that parameter we might just as well give the
> > users the freedom to alter anything in smb.conf. Maybe someone else will
> > see the need to alter that parameter.
> > 
> > Best regards Henrik
> > 
> >  net/slirp.c     | 50 ++++++++++++++++++++++++++++++++++++++++---------
> >  qapi/net.json   |  3 +++
> >  qemu-options.hx | 15 ++++++++++++---
> >  3 files changed, 56 insertions(+), 12 deletions(-)
> > 
> > diff --git a/net/slirp.c b/net/slirp.c
> > index c33b3e02e7..e27d115bc4 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -106,7 +106,8 @@ static int slirp_guestfwd(SlirpState *s, const char
> > *config_str, Error **errp);
> >  
> >  #if defined(CONFIG_SMBD_COMMAND)
> >  static int slirp_smb(SlirpState *s, const char *exported_dir,
> > -                     struct in_addr vserver_addr, Error **errp);
> > +                     struct in_addr vserver_addr, const char *smbparams,
> > +                     Error **errp);
> >  static void slirp_smb_cleanup(SlirpState *s);
> >  #else
> >  static inline void slirp_smb_cleanup(SlirpState *s) { }
> > @@ -424,6 +425,7 @@ static int net_slirp_init(NetClientState *peer, const
> > char *model,
> >                            const char *bootfile, const char *vdhcp_start,
> >                            const char *vnameserver, const char
> >                            *vnameserver6, const char *smb_export, const
> >                            char*vsmbserver,
> > +                          const char *smbparams,
> >                            const char **dnssearch, const char
> >                            *vdomainname, const char *tftp_server_name,
> >                            Error **errp)
> > @@ -678,7 +680,7 @@ static int net_slirp_init(NetClientState *peer, const
> > char *model,
> >      }
> >  #if defined(CONFIG_SMBD_COMMAND)
> >      if (smb_export) {
> > -        if (slirp_smb(s, smb_export, smbsrv, errp) < 0) {
> > +        if (slirp_smb(s, smb_export, smbsrv, smbparams, errp) < 0) {
> >              goto error;
> >          }
> >      }
> > @@ -891,7 +893,8 @@ static void slirp_smb_cleanup(SlirpState *s)
> >  }
> >  
> >  static int slirp_smb(SlirpState* s, const char *exported_dir,
> > -                     struct in_addr vserver_addr, Error **errp)
> > +                     struct in_addr vserver_addr, const char *smbparams,
> > +                     Error **errp)
> >  {
> >      char *smb_conf;
> >      char *smb_cmdline;
> > @@ -950,11 +953,12 @@ static int slirp_smb(SlirpState* s, const char
> > *exported_dir,
> >              "printing = bsd\n"
> >              "disable spoolss = yes\n"
> >              "usershare max shares = 0\n"
> > -            "[qemu]\n"
> > -            "path=%s\n"
> >              "read only=no\n"
> >              "guest ok=yes\n"
> > -            "force user=%s\n",
> > +            "force user=%s\n"
> > +	    "%s"
> > +            "[qemu]\n"
> > +            "path=%s\n",
> >              s->smb_dir,
> >              s->smb_dir,
> >              s->smb_dir,
> > @@ -963,8 +967,9 @@ static int slirp_smb(SlirpState* s, const char
> > *exported_dir,
> >              s->smb_dir,
> >              s->smb_dir,
> >              s->smb_dir,
> > -            exported_dir,
> > -            passwd->pw_name
> > +            passwd->pw_name,
> > +            smbparams,
> > +            exported_dir
> >              );
> >      fclose(f);
> >  
> > @@ -1143,6 +1148,29 @@ static const char **slirp_dnssearch(const
> > StringList*dnsname)
> >      return ret;
> >  }
> >  
> > +static char *slirp_smbparams(const StringList *smbparam)
> > +{
> > +    const StringList *c = smbparam;
> > +    size_t i = 1; /* for string terminating 0 */
> > +    char *ret;
> > +
> > +    while (c) {
> > +        i += strlen(c->value->str);
> > +        i++; /* for \n */
> > +        c = c->next;
> > +    }
> > +    ret = g_malloc(i * sizeof(*ret));
> > +    ret[0]=0; /* Start with empty string */
> > +
> > +    c = smbparam;
> > +    while (c) {
> > +        pstrcat(ret, i * sizeof(*ret), c->value->str);
> > +        pstrcat(ret, i * sizeof(*ret), "\n");
> > +        c = c->next;
> > +    }
> > +    return ret;
> > +}
> > +
> >  int net_init_slirp(const Netdev *netdev, const char *name,
> >                     NetClientState *peer, Error **errp)
> >  {
> > @@ -1151,6 +1179,7 @@ int net_init_slirp(const Netdev *netdev, const char
> > *name,
> >      int ret;
> >      const NetdevUserOptions *user;
> >      const char **dnssearch;
> > +    char *smbparams;
> >      bool ipv4 = true, ipv6 = true;
> >  
> >      assert(netdev->type == NET_CLIENT_DRIVER_USER);
> > @@ -1170,6 +1199,7 @@ int net_init_slirp(const Netdev *netdev, const char
> > *name,
> >             NULL;
> >  
> >      dnssearch = slirp_dnssearch(user->dnssearch);
> > +    smbparams = slirp_smbparams(user->smbparam);
> >  
> >      /* all optional fields are initialized to "all bits zero" */
> >  
> > @@ -1182,7 +1212,8 @@ int net_init_slirp(const Netdev *netdev, const char
> > *name,
> >                           user->ipv6_host, user->hostname, user->tftp,
> >                           user->bootfile, user->dhcpstart,
> >                           user->dns, user->ipv6_dns, user->smb,
> > -                         user->smbserver, dnssearch, user->domainname,
> > +                         user->smbserver, smbparams,
> > +                         dnssearch, user->domainname,
> >                           user->tftp_server_name, errp);
> >  
> >      while (slirp_configs) {
> > @@ -1193,6 +1224,7 @@ int net_init_slirp(const Netdev *netdev, const char
> > *name,
> >  
> >      g_free(vnet);
> >      g_free(dnssearch);
> > +    g_free(smbparams);
> >  
> >      return ret;
> >  }
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 313c8a606e..163091719c 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -156,6 +156,8 @@
> >  #
> >  # @smbserver: IP address of the built-in SMB server
> >  #
> > +# @smbparam: list of parameters with values for smb.conf
> > +#
> >  # @hostfwd: redirect incoming TCP or UDP host connections to guest
> >  #     endpoints
> >  #
> > @@ -186,6 +188,7 @@
> >      '*ipv6-dns':         'str',
> >      '*smb':       'str',
> >      '*smbserver': 'str',
> > +    '*smbparam': ['String'],
> >      '*hostfwd':   ['String'],
> >      '*guestfwd':  ['String'],
> >      '*tftp-server-name': 'str' } }
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 29b98c3d4c..7b92d08c3e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2758,9 +2758,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >      "         [,ipv6=on|off][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
> >      "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]\n"
> >      "        
> >      [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,domainname=domain]\n"
> > -    "        
> > [,tftp=dir][,tftp-server-name=name][,bootfile=f][,hostfwd=rule][,guestfwd
> > =r ule]"+    "        
> > [,tftp=dir][,tftp-server-name=name][,bootfile=f][,hostfwd=rule][,guestfwd
> > =r ule]\n"
> >  #ifndef _WIN32
> > -                                            
> > "[,smb=dir[,smbserver=addr]]\n"+    "        
> > [,smb=dir[,smbserver=addr][,smbparam=parameter=value]]\n"
> >  #endif
> >      "                configure a user mode network backend with ID
> >      'str',\n""                its DHCP server and optional services\n"
> > @@ -3062,7 +3062,7 @@ SRST
> >              |qemu_system| -hda linux.img -boot n -device e1000,netdev=n1
> >              |\\
> >                  -netdev
> >                  user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
> >  
> > -    ``smb=dir[,smbserver=addr]``
> > +    ``smb=dir[,smbserver=addr][,smbparam=parameter=value]``
> >          When using the user mode network stack, activate a built-in SMB
> >          server so that Windows OSes can access to the host files in
> >          ``dir`` transparently. The IP address of the SMB server can be
> > @@ -3081,6 +3081,15 @@ SRST
> >  
> >          Then ``dir`` can be accessed in ``\\smbserver\qemu``.
> >  
> > +        It is possible to set samba parameters in the generated smb.conf
> > +        with one or more ``smbparam=parameter=value``. Example:
> > +
> > +        .. parsed-literal::
> > +
> > +            |qemu_system| -nic user,smb=/tmp,smbparam="read
> > only"=yes,smbparam="server min protocol"=NT1+
> > +        See the man page of smb.conf for a complete listing of
> > parameters.+
> >          Note that a SAMBA server must be installed on the host OS.
> >  
> >      ``hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
> > -- 
> > 2.35.1
> > 

