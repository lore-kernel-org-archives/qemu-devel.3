Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F6BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 07:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYKzi-0008Sd-D2; Mon, 29 Jul 2024 03:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sYKzg-0008SA-UT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sYKze-00083N-Gj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722238829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dcpsx5TY3oz+zcQvy5XsqdH9Syjx/Skhuj8TkmWCPVs=;
 b=fcNZbY3qbBNB7jc2Lp8V26lKl0yRG3j1ERcuC7mw3BEww7U+ckrxNNem1dmcTXcLrrIa0J
 y+fe1LCw6jXoQMa5GTko12I61lOtuWHu2CjkyGX54HqsVied5RxDi988ZKycrytgXWODpK
 k80DYzxZLerxOUcCG4RKIITJzzfjRLk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-sHJKIkpuMaSERrFHirJVxA-1; Mon, 29 Jul 2024 03:40:26 -0400
X-MC-Unique: sHJKIkpuMaSERrFHirJVxA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc691f1f83aso1313069276.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 00:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722238826; x=1722843626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dcpsx5TY3oz+zcQvy5XsqdH9Syjx/Skhuj8TkmWCPVs=;
 b=LYBVm5YXni0RSShODlL3Wt7clxFV+SnhMd8OzVrqEq1xMXXp5BTm04IPH5tNUlxttW
 cUyaPQ28NJN5jmvwwauwBa+Me36I+iHptpBOG5g6gzqGSBxdbHXeIj/CAdkZPN1ApVyq
 ZCd87kiC0/LY3gBRisKwrevPYsQaKQW90SnJkbiNvVMs+NNPMEVlNgNt4lZEWXG4W4Qf
 Jj4cIYYkMLXV1r5BQ9fVi2+XXe5PCIh3TvqvDTmtr2DWTdFX90qkyD5gBX1kVMAxrrJR
 RuUpqulAerI2otLnd/px/t6LyWKJe83H9MYLrzknlYYl0ydzXyH6bJyStRsA8MC/xUsT
 j3Lg==
X-Gm-Message-State: AOJu0YysXHOmjY3DPhWpaHwI3jnGnsZBuUw0JnqY/r9AQjTiryPOABt6
 td9zVjjIgdBjt8mEjSL/aS4VJCKqb0+fn71TgNZeTpUfJofP9hnc2RC0UvqpVyP5c6Osq7xBfRJ
 203/xAwVzmdawXhvOdITkDJvnyfE2UXMA6O+vkm9SAK7aFOrkjaMHVqqRGT0gICTVuqOKuQlIfL
 a5nZNGs1yWzUnylhJMS6hgK7yaf3o=
X-Received: by 2002:a05:6902:2402:b0:e0b:49e0:1422 with SMTP id
 3f1490d57ef6-e0b55989cdbmr5357036276.24.1722238825746; 
 Mon, 29 Jul 2024 00:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQFFRvgFQ8G5TMYNA8Zrh85EsK51K8MCI6wNRzWReB9Xf2brX+nzaBHfA/P1CJmLSkkuqL7nuLP6/fZVG/CL4=
X-Received: by 2002:a05:6902:2402:b0:e0b:49e0:1422 with SMTP id
 3f1490d57ef6-e0b55989cdbmr5357027276.24.1722238825363; Mon, 29 Jul 2024
 00:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240723070251.25575-1-kkostiuk@redhat.com>
 <20240723070251.25575-26-kkostiuk@redhat.com>
 <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
In-Reply-To: <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 29 Jul 2024 10:40:13 +0300
Message-ID: <CAPMcbCpfP-XX0RsTerdrSunb9Z772efCGKf5h2ju7JQdygvDtA@mail.gmail.com>
Subject: Re: [PULL v2 25/25] qga/linux: Add new api 'guest-network-get-route'
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000678fc2061e5df906"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--000000000000678fc2061e5df906
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

How to see the full coverity report? In
https://gitlab.com/qemu-project/qemu/-/artifacts, I see only job.log
Do you expect to fix these errors for the 9.1 release?

Best Regards,
Konstantin Kostiuk.


On Thu, Jul 25, 2024 at 1:12=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 23 Jul 2024 at 08:03, Konstantin Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > From: Dehan Meng <demeng@redhat.com>
> >
> > The Route information of the Linux VM needs to be used
> > by administrators and users when debugging network problems
> > and troubleshooting.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > Message-ID: <20240613092802.346246-2-demeng@redhat.com>
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>
> Hi; Coverity points out some potential issues with this commit:
>
> > +static char *hexToIPAddress(const void *hexValue, int is_ipv6)
> > +{
> > +    if (is_ipv6) {
> > +        char addr[INET6_ADDRSTRLEN];
> > +        struct in6_addr in6;
> > +        const char *hexStr =3D (const char *)hexValue;
> > +        int i;
> > +
> > +        for (i =3D 0; i < 16; i++) {
> > +            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
>
> We don't check the sscanf() return value here. (CID 1558558)
>
> > +        }
> > +        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> > +
> > +        return g_strdup(addr);
> > +    } else {
> > +        unsigned int hexInt =3D *(unsigned int *)hexValue;
> > +        unsigned int byte1 =3D (hexInt >> 24) & 0xFF;
> > +        unsigned int byte2 =3D (hexInt >> 16) & 0xFF;
> > +        unsigned int byte3 =3D (hexInt >> 8) & 0xFF;
> > +        unsigned int byte4 =3D hexInt & 0xFF;
> > +
> > +        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2,
> byte1);
> > +    }
> > +}
> > +
> > +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> > +{
> > +    GuestNetworkRouteList *head =3D NULL, **tail =3D &head;
> > +    const char *routeFiles[] =3D {"/proc/net/route",
> "/proc/net/ipv6_route"};
> > +    FILE *fp;
> > +    size_t n;
> > +    char *line =3D NULL;
> > +    int firstLine;
> > +    int is_ipv6;
> > +    int i;
>
> The handling of the getline() buffer in this function doesn't
> seem to be correct (CID 1558559).
>
> Firstly, the manpage says that to get the initial "allocate me
> a buffer", line must be NULL and also n must be 0, but we don't
> initialize n here.
>
> > +    for (i =3D 0; i < 2; i++) {
> > +        firstLine =3D 1;
> > +        is_ipv6 =3D (i =3D=3D 1);
> > +        fp =3D fopen(routeFiles[i], "r");
> > +        if (fp =3D=3D NULL) {
> > +            error_setg_errno(errp, errno, "open(\"%s\")",
> routeFiles[i]);
> > +            free(line);
>
> Here we free() line, but we continue the for() loop. So next
> time around the loop (assuming the second fopen succeeds)
> we'll pass line to getline() and it will be a non-NULL
> pointer to freed memory.
>
> Is this error case supposed to exit the for() loop entirely
> instead of continuing?
>
> Either way, it shouldn't free(line) here I think.
>
> > +            continue;
> > +        }
> > +
> > +        while (getline(&line, &n, fp) !=3D -1) {
> > +            if (firstLine && !is_ipv6) {
> > +                firstLine =3D 0;
> > +                continue;
> > +            }
> > +            GuestNetworkRoute *route =3D NULL;
> > +            GuestNetworkRoute *networkroute;
> > +            char Iface[IFNAMSIZ];
>
> Our coding style says you shouldn't declare variables in the
> middle of a block. Coding style also says variable names are
> lowercase with underscores, not CamelCase. (CamelCase is for
> typenames.)
>
> > +            if (is_ipv6) {
> > +                char Destination[33], Source[33], NextHop[33];
> > +                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use,
> Flags;
> > +
> > +                /* Parse the line and extract the values */
> > +                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s"=
,
> > +                           Destination, &DesPrefixlen, Source,
> > +                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
> > +                           &Use, &Flags, Iface) !=3D 10) {
> > +                    continue;
> > +                }
> > +
> > +                route =3D g_new0(GuestNetworkRoute, 1);
> > +                networkroute =3D route;
>
> Why do we have separate "route" and "networkroute" variables
> here? As far as I can see they are identical and can be merged.
>
> > +                networkroute->iface =3D g_strdup(Iface);
> > +                networkroute->destination =3D hexToIPAddress(Destinati=
on,
> 1);
> > +                networkroute->metric =3D Metric;
> > +                networkroute->source =3D hexToIPAddress(Source, 1);
> > +                networkroute->desprefixlen =3D g_strdup_printf(
> > +                    "%d", DesPrefixlen
> > +                );
> > +                networkroute->srcprefixlen =3D g_strdup_printf(
> > +                    "%d", SrcPrefixlen
> > +                );
> > +                networkroute->nexthop =3D hexToIPAddress(NextHop, 1);
> > +                networkroute->has_flags =3D true;
> > +                networkroute->flags =3D Flags;
> > +                networkroute->has_refcnt =3D true;
> > +                networkroute->refcnt =3D RefCnt;
> > +                networkroute->has_use =3D true;
> > +                networkroute->use =3D Use;
> > +                networkroute->version =3D 6;
> > +            } else {
> > +                unsigned int Destination, Gateway, Mask, Flags;
> > +                int RefCnt, Use, Metric, MTU, Window, IRTT;
> > +
> > +                /* Parse the line and extract the values */
> > +                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> > +                           Iface, &Destination, &Gateway, &Flags,
> &RefCnt,
> > +                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT)
> !=3D 11) {
> > +                    continue;
> > +                }
> > +
> > +                route =3D g_new0(GuestNetworkRoute, 1);
> > +                networkroute =3D route;
> > +                networkroute->iface =3D g_strdup(Iface);
> > +                networkroute->destination =3D
> hexToIPAddress(&Destination, 0);
> > +                networkroute->gateway =3D hexToIPAddress(&Gateway, 0);
> > +                networkroute->mask =3D hexToIPAddress(&Mask, 0);
> > +                networkroute->metric =3D Metric;
> > +                networkroute->has_flags =3D true;
> > +                networkroute->flags =3D Flags;
> > +                networkroute->has_refcnt =3D true;
> > +                networkroute->refcnt =3D RefCnt;
> > +                networkroute->has_use =3D true;
> > +                networkroute->use =3D Use;
> > +                networkroute->has_mtu =3D true;
> > +                networkroute->mtu =3D MTU;
> > +                networkroute->has_window =3D true;
> > +                networkroute->window =3D Window;
> > +                networkroute->has_irtt =3D true;
> > +                networkroute->irtt =3D IRTT;
> > +                networkroute->version =3D 4;
> > +            }
> > +
> > +            QAPI_LIST_APPEND(tail, route);
> > +        }
> > +
> > +        free(line);
>
> Similarly here we free(line) but next time around the for()
> loop we'll pass it to getline anyway.
>
> > +        fclose(fp);
> > +    }
>
> Since getline() will reallocate the buffer as needed, we don't
> need to free it anywhere except right before we exit the
> function, here.
>
> > +
> > +    return head;
> > +}
>
> thanks
> -- PMM
>
>

--000000000000678fc2061e5df906
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>How to see the ful=
l coverity report? In <a href=3D"https://gitlab.com/qemu-project/qemu/-/art=
ifacts">https://gitlab.com/qemu-project/qemu/-/artifacts</a>, I see only jo=
b.log</div><div>Do you expect to fix these errors for the 9.1 release? <br>=
</div><div><br></div><div><div><div dir=3D"ltr" class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div>=
<div>Konstantin Kostiuk.</div></div></div></div><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 25, 2=
024 at 1:12=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@li=
naro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Tue, 23 Jul 2024 at 08:03, Konstantin =
Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkosti=
uk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=3D"_b=
lank">demeng@redhat.com</a>&gt;<br>
&gt;<br>
&gt; The Route information of the Linux VM needs to be used<br>
&gt; by administrators and users when debugging network problems<br>
&gt; and troubleshooting.<br>
&gt;<br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.=
com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; Message-ID: &lt;<a href=3D"mailto:20240613092802.346246-2-demeng@redha=
t.com" target=3D"_blank">20240613092802.346246-2-demeng@redhat.com</a>&gt;<=
br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
<br>
Hi; Coverity points out some potential issues with this commit:<br>
<br>
&gt; +static char *hexToIPAddress(const void *hexValue, int is_ipv6)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (is_ipv6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char addr[INET6_ADDRSTRLEN];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in6_addr in6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *hexStr =3D (const char *)hexV=
alue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sscanf(&amp;hexStr[i * 2], =
&quot;%02hhx&quot;, &amp;in6.s6_addr[i]);<br>
<br>
We don&#39;t check the sscanf() return value here. (CID 1558558)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet_ntop(AF_INET6, &amp;in6, addr, INET6=
_ADDRSTRLEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(addr);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int hexInt =3D *(unsigned int *)=
hexValue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte1 =3D (hexInt &gt;&gt; 2=
4) &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte2 =3D (hexInt &gt;&gt; 1=
6) &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte3 =3D (hexInt &gt;&gt; 8=
) &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte4 =3D hexInt &amp; 0xFF;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup_printf(&quot;%u.%u.%u.%u&=
quot;, byte4, byte3, byte2, byte1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GuestNetworkRouteList *head =3D NULL, **tail =3D &amp;h=
ead;<br>
&gt; +=C2=A0 =C2=A0 const char *routeFiles[] =3D {&quot;/proc/net/route&quo=
t;, &quot;/proc/net/ipv6_route&quot;};<br>
&gt; +=C2=A0 =C2=A0 FILE *fp;<br>
&gt; +=C2=A0 =C2=A0 size_t n;<br>
&gt; +=C2=A0 =C2=A0 char *line =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int firstLine;<br>
&gt; +=C2=A0 =C2=A0 int is_ipv6;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
<br>
The handling of the getline() buffer in this function doesn&#39;t<br>
seem to be correct (CID 1558559).<br>
<br>
Firstly, the manpage says that to get the initial &quot;allocate me<br>
a buffer&quot;, line must be NULL and also n must be 0, but we don&#39;t<br=
>
initialize n here.<br>
<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 firstLine =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_ipv6 =3D (i =3D=3D 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fopen(routeFiles[i], &quot;r&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errn=
o, &quot;open(\&quot;%s\&quot;)&quot;, routeFiles[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
<br>
Here we free() line, but we continue the for() loop. So next<br>
time around the loop (assuming the second fopen succeeds)<br>
we&#39;ll pass line to getline() and it will be a non-NULL<br>
pointer to freed memory.<br>
<br>
Is this error case supposed to exit the for() loop entirely<br>
instead of continuing?<br>
<br>
Either way, it shouldn&#39;t free(line) here I think.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=
=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (firstLine &amp;&amp; !i=
s_ipv6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firstLine =3D=
 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRoute *route =
=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRoute *networkr=
oute;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char Iface[IFNAMSIZ];<br>
<br>
Our coding style says you shouldn&#39;t declare variables in the<br>
middle of a block. Coding style also says variable names are<br>
lowercase with underscores, not CamelCase. (CamelCase is for<br>
typenames.)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_ipv6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char Destinat=
ion[33], Source[33], NextHop[33];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int DesPrefix=
len, SrcPrefixlen, Metric, RefCnt, Use, Flags;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parse the =
line and extract the values */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(li=
ne, &quot;%32s %x %32s %x %32s %x %x %x %x %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Destination, &amp;DesPrefixlen, Source,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;SrcPrefixlen, NextHop, &amp;Metric, &amp;R=
efCnt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;Use, &amp;Flags, Iface) !=3D 10) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_n=
ew0(GuestNetworkRoute, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =
=3D route;<br>
<br>
Why do we have separate &quot;route&quot; and &quot;networkroute&quot; vari=
ables<br>
here? As far as I can see they are identical and can be merged.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;iface =3D g_strdup(Iface);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;destination =3D hexToIPAddress(Destination, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;metric =3D Metric;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;source =3D hexToIPAddress(Source, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;desprefixlen =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;%d&quot;, DesPrefixlen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;srcprefixlen =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;%d&quot;, SrcPrefixlen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;nexthop =3D hexToIPAddress(NextHop, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_flags =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;flags =3D Flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_refcnt =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;refcnt =3D RefCnt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_use =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;use =3D Use;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;version =3D 6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int =
Destination, Gateway, Mask, Flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int RefCnt, U=
se, Metric, MTU, Window, IRTT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parse the =
line and extract the values */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(li=
ne, &quot;%s %X %X %x %d %d %d %X %d %d %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Iface, &amp;Destination, &amp;Gateway, &amp;Fla=
gs, &amp;RefCnt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;Use, &amp;Metric, &amp;Mask, &amp;MTU, &am=
p;Window, &amp;IRTT) !=3D 11) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_n=
ew0(GuestNetworkRoute, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =
=3D route;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;iface =3D g_strdup(Iface);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;destination =3D hexToIPAddress(&amp;Destination, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;gateway =3D hexToIPAddress(&amp;Gateway, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;mask =3D hexToIPAddress(&amp;Mask, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;metric =3D Metric;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_flags =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;flags =3D Flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_refcnt =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;refcnt =3D RefCnt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_use =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;use =3D Use;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_mtu =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;mtu =3D MTU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_window =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;window =3D Window;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;has_irtt =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;irtt =3D IRTT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-=
&gt;version =3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, rout=
e);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
<br>
Similarly here we free(line) but next time around the for()<br>
loop we&#39;ll pass it to getline anyway.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Since getline() will reallocate the buffer as needed, we don&#39;t<br>
need to free it anywhere except right before we exit the<br>
function, here.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000678fc2061e5df906--


