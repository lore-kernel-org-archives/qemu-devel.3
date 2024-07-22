Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8A2C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmiU-0007pb-19; Mon, 22 Jul 2024 02:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVmiP-0007oG-U3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVmiN-0002aE-4g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721630400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktshian8AONxoCFI0etUwKX02Lvshg4WU2F6PXDtg1Q=;
 b=YyUTC+wlKu1LSqZwETsAz9B+SZPNKvN4HiLRE8/8992+hv4bM/nwBpWQsyLi/GReJ9G6AT
 62ptPhAF3nHHt4YSHAyj5s29FSSk8AS/rjgk/oXctiTO4AE0QXDG7Iu+Nkdnt6lBiLUBG6
 LSSB9FMFFV7RDDuMgnRkfy5Mzj2PcTE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-NnEc6SHjNbS3gi9zP9vgSA-1; Mon, 22 Jul 2024 02:39:54 -0400
X-MC-Unique: NnEc6SHjNbS3gi9zP9vgSA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6688b5b40faso122956527b3.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721630393; x=1722235193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ktshian8AONxoCFI0etUwKX02Lvshg4WU2F6PXDtg1Q=;
 b=YqPlt+YlarWu+npvMsc6yKyVI0PU9kzWkZc2ITiT6J0OYSZPHrZEDs6XZO2Z3RE42l
 lqYfRf4d3o1bP95PbbV2O9TEUGyyqaZeC60Oq425V/lU6TNMZiv5olo11zkRVhC2Okrf
 sF/vaK+58x6CM0FyFoCR78yojym4cAaKdmNRzXu7t5A6nLVyWr2tlc8jv6Oxa/cuCDLt
 5gPf40NiKyW+hwikeIkctaJZtgJy+PpHwcwMAdwqfDm2u8rDY3D8shuMMtcYo+u4E3Sv
 X7NSxt57H9OpEHk73APekM6sPCWBLW+EP7fwhRf5SlS3qF7+5xuIG1SvY4XTbnkiwPvn
 jT8w==
X-Gm-Message-State: AOJu0YwN8re2VgFS8ISG9e2d+kLiZ33gQF1c4VxK2Fj5TP/DECaaUDAh
 tv+99RxhayIu+TuJgCywSve/ZjoCq9hPgqcWXaArfJASAUFpsGsha47Gzh6Ldc4xvfQMAT39APO
 bgXKNGCpTBk6RJkaYoHXE93FA3NS8nzvBHp9rE8FbzVk7cpJIhgJAtLe49c1Ebs5HvvAnor6UCF
 VUX4s1ItQTOzL0fkWjxV7ZNlKSkW0=
X-Received: by 2002:a05:6902:1547:b0:e05:fdbe:bbdf with SMTP id
 3f1490d57ef6-e087b33cf2amr5845204276.20.1721630393431; 
 Sun, 21 Jul 2024 23:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH4/yXzrzopc0dybawuQs6acPb1ueqm895Wei9AmQn7WhO86LKxmFKOHeg+teOdhhMbvj1VJ3GYs/mrq0W11c=
X-Received: by 2002:a05:6902:1547:b0:e05:fdbe:bbdf with SMTP id
 3f1490d57ef6-e087b33cf2amr5845180276.20.1721630393147; Sun, 21 Jul 2024
 23:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240613092802.346246-1-demeng@redhat.com>
 <20240613092802.346246-2-demeng@redhat.com>
In-Reply-To: <20240613092802.346246-2-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 22 Jul 2024 09:39:42 +0300
Message-ID: <CAPMcbCrowaQYvbx3qj6MqT0EZadPLXfJcKVkFryY+_BKRXgdGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="00000000000004becc061dd0507e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
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

--00000000000004becc061dd0507e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 12:28=E2=80=AFPM Dehan Meng <demeng@redhat.com> wro=
te:

> The Route information of the Linux VM needs to be used
> by administrators and users when debugging network problems
> and troubleshooting.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-posix.c | 135 +++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c |   6 ++
>  qga/qapi-schema.json |  71 +++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7f05996495..b85b3937bf 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2708,6 +2708,135 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      return head;
>  }
>
> +static char *hexToIPAddress(const void *hexValue, int is_ipv6)
> +{
> +    if (is_ipv6) {
> +        char addr[INET6_ADDRSTRLEN];
> +        struct in6_addr in6;
> +        const char *hexStr =3D (const char *)hexValue;
> +        int i;
> +
> +        for (i =3D 0; i < 16; i++) {
> +            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> +        }
> +        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> +
> +        return g_strdup(addr);
> +    } else {
> +        unsigned int hexInt =3D *(unsigned int *)hexValue;
> +        unsigned int byte1 =3D (hexInt >> 24) & 0xFF;
> +        unsigned int byte2 =3D (hexInt >> 16) & 0xFF;
> +        unsigned int byte3 =3D (hexInt >> 8) & 0xFF;
> +        unsigned int byte4 =3D hexInt & 0xFF;
> +
> +        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1=
);
> +    }
> +}
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteList *head =3D NULL, **tail =3D &head;
> +    const char *routeFiles[] =3D {"/proc/net/route",
> "/proc/net/ipv6_route"};
> +    FILE *fp;
> +    size_t n;
> +    char *line =3D NULL;
> +    int firstLine;
> +    int is_ipv6;
> +    int i;
> +
> +    for (i =3D 0; i < 2; i++) {
> +        firstLine =3D 1;
> +        is_ipv6 =3D (i =3D=3D 1);
> +        fp =3D fopen(routeFiles[i], "r");
> +        if (fp =3D=3D NULL) {
> +            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i])=
;
> +            free(line);
> +            continue;
> +        }
> +
> +        while (getline(&line, &n, fp) !=3D -1) {
> +            if (firstLine && !is_ipv6) {
> +                firstLine =3D 0;
> +                continue;
> +            }
> +            GuestNetworkRoute *route =3D NULL;
> +            GuestNetworkRoute *networkroute;
> +            char Iface[IFNAMSIZ];
> +            if (is_ipv6) {
> +                char Destination[33], Source[33], NextHop[33];
> +                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use,
> Flags;
> +
> +                /* Parse the line and extract the values */
> +                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %32s"=
,
> +                           Destination, &DesPrefixlen, Source,
> +                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
> +                           &Use, &Flags, Iface) !=3D 10) {
> +                    continue;
> +                }
> +
> +                route =3D g_new0(GuestNetworkRoute, 1);
> +                networkroute =3D route;
> +                networkroute->iface =3D g_strdup(Iface);
> +                networkroute->destination =3D hexToIPAddress(Destination=
,
> 1);
> +                networkroute->metric =3D Metric;
> +                networkroute->source =3D hexToIPAddress(Source, 1);
> +                networkroute->desprefixlen =3D g_strdup_printf(
> +                    "%d", DesPrefixlen
> +                );
> +                networkroute->srcprefixlen =3D g_strdup_printf(
> +                    "%d", SrcPrefixlen
> +                );
> +                networkroute->nexthop =3D hexToIPAddress(NextHop, 1);
> +                networkroute->has_flags =3D true;
> +                networkroute->flags =3D Flags;
> +                networkroute->has_refcnt =3D true;
> +                networkroute->refcnt =3D RefCnt;
> +                networkroute->has_use =3D true;
> +                networkroute->use =3D Use;
> +                networkroute->version =3D 6;
> +            } else {
> +                unsigned int Destination, Gateway, Mask, Flags;
> +                int RefCnt, Use, Metric, MTU, Window, IRTT;
> +
> +                /* Parse the line and extract the values */
> +                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> +                           Iface, &Destination, &Gateway, &Flags, &RefCn=
t,
> +                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) !=
=3D
> 11) {
> +                    continue;
> +                }
> +
> +                route =3D g_new0(GuestNetworkRoute, 1);
> +                networkroute =3D route;
> +                networkroute->iface =3D g_strdup(Iface);
> +                networkroute->destination =3D hexToIPAddress(&Destinatio=
n,
> 0);
> +                networkroute->gateway =3D hexToIPAddress(&Gateway, 0);
> +                networkroute->mask =3D hexToIPAddress(&Mask, 0);
> +                networkroute->metric =3D Metric;
> +                networkroute->has_flags =3D true;
> +                networkroute->flags =3D Flags;
> +                networkroute->has_refcnt =3D true;
> +                networkroute->refcnt =3D RefCnt;
> +                networkroute->has_use =3D true;
> +                networkroute->use =3D Use;
> +                networkroute->has_mtu =3D true;
> +                networkroute->mtu =3D MTU;
> +                networkroute->has_window =3D true;
> +                networkroute->window =3D Window;
> +                networkroute->has_irtt =3D true;
> +                networkroute->irtt =3D IRTT;
> +                networkroute->version =3D 4;
> +            }
> +
> +            QAPI_LIST_APPEND(tail, route);
> +        }
> +
> +        free(line);
> +        fclose(fp);
> +    }
> +
> +    return head;
> +}
> +
>  #else /* defined(__linux__) */
>
>  void qmp_guest_suspend_disk(Error **errp)
> @@ -3079,6 +3208,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      return NULL;
>  }
>
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
>  #endif /* CONFIG_FSFREEZE */
>
>  #if !defined(CONFIG_FSTRIM)
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0d1b836e87..91289bc9ab 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2517,3 +2517,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      error_setg(errp, QERR_UNSUPPORTED);
>      return NULL;
>  }
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b3de1fb6b3..1c2ee9f3c6 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1800,3 +1800,74 @@
>  { 'command': 'guest-get-cpustats',
>    'returns': ['GuestCpuStats']
>  }
> +
> +##
> +# @GuestNetworkRoute:
> +#
> +# Route information, currently, only linux supported.
> +#
> +# @iface: The destination network or host's egress network interface in
> the routing table
> +#
> +# @destination: The IP address of the target network or host, The final
> destination of the packet
> +#
> +# @metric: Route metric
> +#
> +# @gateway: The IP address of the next hop router
> +#
> +# @mask: Subnet Mask (IPv4 only)
> +#
> +# @irtt: Initial round-trip delay (not for windows, IPv4 only)
> +#
> +# @flags: Route flags (not for windows)
> +#
> +# @refcnt: The route's reference count (not for windows)
> +#
> +# @use: Route usage count (not for windows)
> +#
> +# @window: TCP window size, used for flow control (not for windows, IPv4
> only)
> +#
> +# @mtu: Data link layer maximum packet size (not for windows)
> +#
> +# @desprefixlen: Destination prefix length (for IPv6)
> +#
> +# @source: Source IP address (for IPv6)
> +#
> +# @srcprefixlen: Source prefix length (for IPv6)
> +#
> +# @nexthop: Next hop IP address (for IPv6)
> +#
> +# @version: IP version (4 or 6)
> +#
> +# Since: 9.1
> +
> +##
> +{ 'struct': 'GuestNetworkRoute',
> +  'data': {'iface': 'str',
> +           'destination': 'str',
> +           'metric': 'int',
> +           '*gateway': 'str',
> +           '*mask': 'str',
> +           '*irtt': 'int',
> +           '*flags': 'uint64',
> +           '*refcnt': 'int',
> +           '*use': 'int',
> +           '*window': 'int',
> +           '*mtu': 'int',
> +           '*desprefixlen': 'str',
> +           '*source': 'str',
> +           '*srcprefixlen': 'str',
> +           '*nexthop': 'str',
> +           'version': 'int'
> +           }}
> +
> +##
> +# @guest-network-get-route:
> +#
> +# Retrieve information about route of network.
> +# Returns: List of route info of guest.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'guest-network-get-route',
> +  'returns': ['GuestNetworkRoute']
> +}
> --
> 2.40.1
>
>

--00000000000004becc061dd0507e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 12:28=
=E2=80=AFPM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com">demeng@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The Route information of the Linux VM needs to be used<br>
by administrators and users when debugging network problems<br>
and troubleshooting.<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 135 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-win32.c |=C2=A0 =C2=A06 ++<br>
=C2=A0qga/qapi-schema.json |=C2=A0 71 +++++++++++++++++++++++<br>
=C2=A03 files changed, 212 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 7f05996495..b85b3937bf 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -2708,6 +2708,135 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
<br>
+static char *hexToIPAddress(const void *hexValue, int is_ipv6)<br>
+{<br>
+=C2=A0 =C2=A0 if (is_ipv6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char addr[INET6_ADDRSTRLEN];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in6_addr in6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *hexStr =3D (const char *)hexValue;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sscanf(&amp;hexStr[i * 2], &quot=
;%02hhx&quot;, &amp;in6.s6_addr[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet_ntop(AF_INET6, &amp;in6, addr, INET6_ADDR=
STRLEN);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(addr);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int hexInt =3D *(unsigned int *)hexVa=
lue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte1 =3D (hexInt &gt;&gt; 24) &a=
mp; 0xFF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte2 =3D (hexInt &gt;&gt; 16) &a=
mp; 0xFF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte3 =3D (hexInt &gt;&gt; 8) &am=
p; 0xFF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int byte4 =3D hexInt &amp; 0xFF;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup_printf(&quot;%u.%u.%u.%u&quot;=
, byte4, byte3, byte2, byte1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestNetworkRouteList *head =3D NULL, **tail =3D &amp;head;<=
br>
+=C2=A0 =C2=A0 const char *routeFiles[] =3D {&quot;/proc/net/route&quot;, &=
quot;/proc/net/ipv6_route&quot;};<br>
+=C2=A0 =C2=A0 FILE *fp;<br>
+=C2=A0 =C2=A0 size_t n;<br>
+=C2=A0 =C2=A0 char *line =3D NULL;<br>
+=C2=A0 =C2=A0 int firstLine;<br>
+=C2=A0 =C2=A0 int is_ipv6;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 firstLine =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_ipv6 =3D (i =3D=3D 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fopen(routeFiles[i], &quot;r&quot;);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, routeFiles[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (firstLine &amp;&amp; !is_ipv=
6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firstLine =3D 0;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRoute *route =3D NUL=
L;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRoute *networkroute;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char Iface[IFNAMSIZ];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_ipv6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char Destination[3=
3], Source[33], NextHop[33];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int DesPrefixlen, =
SrcPrefixlen, Metric, RefCnt, Use, Flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parse the line =
and extract the values */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(line, &=
quot;%32s %x %32s %x %32s %x %x %x %x %32s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Destination, &amp;DesPrefixlen, Source,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;SrcPrefixlen, NextHop, &amp;Metric, &amp;RefCn=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;Use, &amp;Flags, Iface) !=3D 10) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_new0(G=
uestNetworkRoute, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =3D r=
oute;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;i=
face =3D g_strdup(Iface);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;d=
estination =3D hexToIPAddress(Destination, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;m=
etric =3D Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;s=
ource =3D hexToIPAddress(Source, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;d=
esprefixlen =3D g_strdup_printf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%d&quot;, DesPrefixlen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;s=
rcprefixlen =3D g_strdup_printf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%d&quot;, SrcPrefixlen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;n=
exthop =3D hexToIPAddress(NextHop, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_flags =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;f=
lags =3D Flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_refcnt =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;r=
efcnt =3D RefCnt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_use =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;u=
se =3D Use;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;v=
ersion =3D 6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int Desti=
nation, Gateway, Mask, Flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int RefCnt, Use, M=
etric, MTU, Window, IRTT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parse the line =
and extract the values */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(line, &=
quot;%s %X %X %x %d %d %d %X %d %d %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Iface, &amp;Destination, &amp;Gateway, &amp;Flags, =
&amp;RefCnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;Use, &amp;Metric, &amp;Mask, &amp;MTU, &amp;Wi=
ndow, &amp;IRTT) !=3D 11) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_new0(G=
uestNetworkRoute, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =3D r=
oute;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;i=
face =3D g_strdup(Iface);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;d=
estination =3D hexToIPAddress(&amp;Destination, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;g=
ateway =3D hexToIPAddress(&amp;Gateway, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;m=
ask =3D hexToIPAddress(&amp;Mask, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;m=
etric =3D Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_flags =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;f=
lags =3D Flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_refcnt =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;r=
efcnt =3D RefCnt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_use =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;u=
se =3D Use;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_mtu =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;m=
tu =3D MTU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_window =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;w=
indow =3D Window;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;h=
as_irtt =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;i=
rtt =3D IRTT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;v=
ersion =3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, route);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
+<br>
=C2=A0#else /* defined(__linux__) */<br>
<br>
=C2=A0void qmp_guest_suspend_disk(Error **errp)<br>
@@ -3079,6 +3208,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
=C2=A0#if !defined(CONFIG_FSTRIM)<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 0d1b836e87..91289bc9ab 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2517,3 +2517,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORTED);<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
+<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b3de1fb6b3..1c2ee9f3c6 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1800,3 +1800,74 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestCpuStats&#39;]<br>
=C2=A0}<br>
+<br>
+##<br>
+# @GuestNetworkRoute:<br>
+#<br>
+# Route information, currently, only linux supported.<br>
+#<br>
+# @iface: The destination network or host&#39;s egress network interface i=
n the routing table<br>
+#<br>
+# @destination: The IP address of the target network or host, The final de=
stination of the packet<br>
+#<br>
+# @metric: Route metric<br>
+#<br>
+# @gateway: The IP address of the next hop router<br>
+#<br>
+# @mask: Subnet Mask (IPv4 only)<br>
+#<br>
+# @irtt: Initial round-trip delay (not for windows, IPv4 only)<br>
+#<br>
+# @flags: Route flags (not for windows)<br>
+#<br>
+# @refcnt: The route&#39;s reference count (not for windows)<br>
+#<br>
+# @use: Route usage count (not for windows)<br>
+#<br>
+# @window: TCP window size, used for flow control (not for windows, IPv4 o=
nly)<br>
+#<br>
+# @mtu: Data link layer maximum packet size (not for windows)<br>
+#<br>
+# @desprefixlen: Destination prefix length (for IPv6)<br>
+#<br>
+# @source: Source IP address (for IPv6)<br>
+#<br>
+# @srcprefixlen: Source prefix length (for IPv6)<br>
+#<br>
+# @nexthop: Next hop IP address (for IPv6)<br>
+#<br>
+# @version: IP version (4 or 6)<br>
+#<br>
+# Since: 9.1<br>
+<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNetworkRoute&#39;,<br>
+=C2=A0 &#39;data&#39;: {&#39;iface&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;destination&#39;: &#39;str&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;metric&#39;: &#39;int&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*gateway&#39;: &#39;str&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*mask&#39;: &#39;str&#39;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*irtt&#39;: &#39;int&#39;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*flags&#39;: &#39;uint64&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*refcnt&#39;: &#39;int&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*use&#39;: &#39;int&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*window&#39;: &#39;int&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*mtu&#39;: &#39;int&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*desprefixlen&#39;: &#39;str=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*source&#39;: &#39;str&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*srcprefixlen&#39;: &#39;str=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*nexthop&#39;: &#39;str&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;version&#39;: &#39;int&#39;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}}<br>
+<br>
+##<br>
+# @guest-network-get-route:<br>
+#<br>
+# Retrieve information about route of network.<br>
+# Returns: List of route info of guest.<br>
+#<br>
+# Since: 9.1<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-network-get-route&#39;,<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute&#39;]<br>
+}<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div>

--00000000000004becc061dd0507e--


