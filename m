Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825CBD13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 01:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Et2-0000xR-DN; Sun, 27 Oct 2024 21:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t5Et1-0000xD-0i
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 21:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t5Esz-0006aJ-8A
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 21:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730080173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CynaxOTN//0+DDhe1Io3ySWZjITFA3nnmsWC9jNF/1U=;
 b=NUUl50dG54yrwUDQ0wSHxZ8T/TnILqU4dxv/B+MdAp/kRpUKraWm8O8HFlPelFIxhzdRUM
 UUiwuTShMwy/bSqRSYow3XtnPt11v9uX8y0MwUa+bKFEXqMF2/WCnVL+fM75xzyvrrs00V
 6pzk4JkWVPZUviIPS+J/g0Pk00WSTVU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-q-s0T0wGNgSqTI5kbU-_5w-1; Sun, 27 Oct 2024 21:49:31 -0400
X-MC-Unique: q-s0T0wGNgSqTI5kbU-_5w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d603515cfso1821412f8f.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 18:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730080170; x=1730684970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CynaxOTN//0+DDhe1Io3ySWZjITFA3nnmsWC9jNF/1U=;
 b=snvghGcz0kEdgw4tEpzWWN21IsM0oeivJ1ZK+nomb0/3qboYswr7XY+2mgNLjO0Rj8
 R9iLWLIgKjI+0pTkB7aFynyeYxFDcQzIUOJAomGmi5owg/IDmyX0qjn4sIcYryVQ4/3l
 nx0XAKaZqc0R9ZeIpsCko0zz6Kx1xA57YX/2FxFc5LE5/Fb1ZVSyqZmJX6oLL5/sPRdh
 Ld0eMVAMSSaALXiWBHW47sMsHYWVT3ysI8tBsMgihuknWIvIFtWwjKQtyzCgAfVEYQOe
 wY/fWJZbyNTNQyebBx4Z+0iJHqpFtJtoWfsNjqcsQAbWYves0NLt0wqm6y6vKAoq6hUE
 Nrsw==
X-Gm-Message-State: AOJu0Yz7pVPvP9poH3y+ddz10yVhiJSoFyhC2BZPobX8IkbC97+mTCiO
 cXrOPGNPLdVJyV2XsesN3u/MqGLMSJie3K0LE46SzbVRFppue6fP1jPCMGXwjjTaaqv3k6UG5Jd
 +vrgQk6IumeZe+doTbCUjw4u8cBH+tahTpNkXQ0L02gODQ/Rvf/rWcHdJ9gZHj/8HZJUa+wIUBI
 S7RlajNtQI4+nVrA88Pt/gJh6qalc=
X-Received: by 2002:a5d:4e0e:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-380610f7b1dmr4943991f8f.5.1730080169730; 
 Sun, 27 Oct 2024 18:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH+3SnwL3xqjfI2M9k0R7JKiMJ3Yh7cRA3GS78DkrUO/O68MlapE3+8tBHUnx4thNYE966FpkaIEBQJOVZZOU=
X-Received: by 2002:a5d:4e0e:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-380610f7b1dmr4943977f8f.5.1730080169287; Sun, 27 Oct 2024
 18:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241022142948.531325-1-demeng@redhat.com>
 <20241022142948.531325-2-demeng@redhat.com>
 <ZxuTjJvrdIKKT4AC@redhat.com>
In-Reply-To: <ZxuTjJvrdIKKT4AC@redhat.com>
From: Dehan Meng <demeng@redhat.com>
Date: Mon, 28 Oct 2024 09:49:18 +0800
Message-ID: <CA+kPPJzZjAyLO5DWqwiJaZLv50L98q2J1-GJGtXYPivWxV1K+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] qemu-ga: 'Null' check for mandatory parameters
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000ec752c06257fadcc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ec752c06257fadcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

okay, I'll summarize all of the patches. thanks for reviewing.

On Fri, Oct 25, 2024 at 8:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Oct 22, 2024 at 10:29:44PM +0800, Dehan Meng wrote:
> > sscanf return values are checked and add 'Null' check for
> > mandatory parameters.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> > index 51d5e3d927..f0e9cdd27c 100644
> > --- a/qga/commands-linux.c
> > +++ b/qga/commands-linux.c
> > @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue,
> int is_ipv6)
> >          int i;
> >
> >          for (i =3D 0; i < 16; i++) {
> > -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> > +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) !=
=3D
> 1) {
> > +                return NULL;
> > +            }
> >          }
> >          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> >
> > @@ -2164,6 +2166,10 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                  networkroute =3D route;
> >                  networkroute->iface =3D g_strdup(Iface);
> >                  networkroute->destination =3D hexToIPAddress(Destinati=
on,
> 1);
> > +                if (networkroute->destination =3D=3D NULL) {
> > +                    g_free(route);
> > +                    continue;
> > +                }
>
> This still hasn't fixed the leak problems identified in the previous
> review of the last version
>
> >                  networkroute->metric =3D Metric;
> >                  networkroute->source =3D hexToIPAddress(Source, 1);
> >                  networkroute->desprefixlen =3D g_strdup_printf(
> > @@ -2195,6 +2201,10 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                  networkroute =3D route;
> >                  networkroute->iface =3D g_strdup(Iface);
> >                  networkroute->destination =3D
> hexToIPAddress(&Destination, 0);
> > +                if (networkroute->destination =3D=3D NULL) {
> > +                    g_free(route);
> > +                    continue;
> > +                }
> >                  networkroute->gateway =3D hexToIPAddress(&Gateway, 0);
> >                  networkroute->mask =3D hexToIPAddress(&Mask, 0);
> >                  networkroute->metric =3D Metric;
> > --
> > 2.40.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000ec752c06257fadcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">okay, I&#39;ll summarize all of the patches. thanks for re=
viewing.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Oct 25, 2024 at 8:48=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt=
;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 22, =
2024 at 10:29:44PM +0800, Dehan Meng wrote:<br>
&gt; sscanf return values are checked and add &#39;Null&#39; check for<br>
&gt; mandatory parameters.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 12 +++++++++++-<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt; index 51d5e3d927..f0e9cdd27c 100644<br>
&gt; --- a/qga/commands-linux.c<br>
&gt; +++ b/qga/commands-linux.c<br>
&gt; @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue=
, int is_ipv6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sscanf(&amp;hexStr[i * 2], =
&quot;%02hhx&quot;, &amp;in6.s6_addr[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(&amp;hex_str[i *=
 2], &quot;%02hhx&quot;, &amp;in6.s6_addr[i]) !=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet_ntop(AF_INET6, &amp;in6, addr, =
INET6_ADDRSTRLEN);<br>
&gt;=C2=A0 <br>
&gt; @@ -2164,6 +2166,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(Destination, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This still hasn&#39;t fixed the leak problems identified in the previous<br=
>
review of the last version<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;source =3D hexToIPAddress(Source, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;desprefixlen =3D g_strdup_printf(<br>
&gt; @@ -2195,6 +2201,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(&amp;Destination, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;gateway =3D hexToIPAddress(&amp;Gateway, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;mask =3D hexToIPAddress(&amp;Mask, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt; -- <br>
&gt; 2.40.1<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000ec752c06257fadcc--


