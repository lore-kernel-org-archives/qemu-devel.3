Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBDC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 07:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHISC-0008Mh-TB; Wed, 12 Jun 2024 03:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHISA-0008Eo-Ai
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 03:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHIS8-0007FT-2g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 03:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718177486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+Taj6xBXNiRaN5fbEEavX2U3ZnByo6WDnlAEYgJ0yA=;
 b=KcxTe/kjzxSmfMUae2wDfrqtpBkC3Xfia9ZNLaU6Pxr2I2Kxm6C7aLFv6+DAU/4tkHwMaH
 cVEwFxjKnc87jGkJrGrneaQ4bXPZOc8NOiF+S0oRKLC2Z+/TOZftRMAoJFcqf4deC3yoBQ
 6z4w7xZe9Kr5Y2pS1fqa9P9iYmYUrNs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-6mna12E5MguYr4YTsG1Hug-1; Wed, 12 Jun 2024 03:31:24 -0400
X-MC-Unique: 6mna12E5MguYr4YTsG1Hug-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-62a08273919so97187027b3.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 00:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718177484; x=1718782284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+Taj6xBXNiRaN5fbEEavX2U3ZnByo6WDnlAEYgJ0yA=;
 b=VZiAVuQSFYQBhL3381rqD/C5Xi6WFkPtt/ZcK/IFKlCDWUfyI3aKcgx28NIxPBS2v2
 mKF6ATdHLngjqfq5MUU9jfPphyUyzdONE1V3TOcIFet8l1ww8cjlYP5yhFcy/TijGNJS
 sDoyAZ2GgFzMXN9fU9/LkxsAf4QHDiv13+S73iJOUesOX7+Nk68FPDTErfSpQtWos/iL
 1TDubxlpEHRjflB247wjq48BHqMimTO5at/dEW3q2qM8KvUFg1gUM0k7B3CKWtbPqrb9
 LmXkDt/9hq5MCogOvL3ydrctAlYL0go33+yR/HaKb0t44fBWSSIsvki14hlAvbIBB3Ch
 UQBA==
X-Gm-Message-State: AOJu0YzSmpd+AHHdr8lkNNJwmokCE5BV6FWatfH2xEzYLOCEu0SXY4QB
 WW8zgSDFVUdqkavUw/EUWIoIqa+HBJb09a8yoiuYakYiZW2nEsWqbwMKUJzRlWmtFgL1JDSCqx4
 OHH0ZzOJbMOtIMvktQmxC59btsjcf9Zr1Yqxf0vWPjiNde7aW9O+CZkCiskXQg+Zr9l6wCe4Oe6
 8Whct68egWCpQL+Hy+FIaxsC+qB2w=
X-Received: by 2002:a81:c144:0:b0:61a:ae79:816a with SMTP id
 00721157ae682-62fbb509857mr9209177b3.31.1718177483689; 
 Wed, 12 Jun 2024 00:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7bWgj7DzoK50dKRwCAQe65R5uOPWH2P4m/emfMp/36vZBaVdznkXb2To7v5JdtLci2Z0AGEr91CQ0AkXl908=
X-Received: by 2002:a81:c144:0:b0:61a:ae79:816a with SMTP id
 00721157ae682-62fbb509857mr9209047b3.31.1718177483321; Wed, 12 Jun 2024
 00:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240612043547.282552-1-demeng@redhat.com>
 <20240612043547.282552-2-demeng@redhat.com>
In-Reply-To: <20240612043547.282552-2-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Jun 2024 10:31:12 +0300
Message-ID: <CAPMcbCpphJ9fWntHim9FYAUFzQastq6BXbYafEzijnSrJyU9tw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000008e0a07061aac5e91"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008e0a07061aac5e91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:36=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> The Route information of the Linux VM needs to be used
> by administrators and users when debugging network problems
> and troubleshooting.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c |  6 ++++
>  qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 6169bbf7a0..ffae88ca69 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2747,6 +2747,73 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      return head;
>  }
>
> +char *hexToIPAddress(unsigned int hexValue, char ipAddress[16]);
> +char *hexToIPAddress(unsigned int hexValue, char ipAddress[16])
> +{
> +    unsigned int byte1 =3D (hexValue >> 24) & 0xFF;
> +    unsigned int byte2 =3D (hexValue >> 16) & 0xFF;
> +    unsigned int byte3 =3D (hexValue >> 8) & 0xFF;
> +    unsigned int byte4 =3D hexValue & 0xFF;
> +
> +    snprintf(ipAddress, 16, "%u.%u.%u.%u", byte4, byte3, byte2, byte1);
> +
> +    return ipAddress;
> +}
> +
> +GuestNetworkRouteStatList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteStatList *head =3D NULL, **tail =3D &head;
> +    const char *routeFile =3D "/proc/net/route";
> +    FILE *fp;
> +    size_t n;
> +    char *line =3D NULL;
> +
> +    fp =3D fopen(routeFile, "r");
> +    if (fp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", routeFile);
> +        return NULL;
> +    }
> +
> +    while (getline(&line, &n, fp) !=3D -1) {
> +        GuestNetworkRouteStat *networkroute;
> +        int i;
> +        char Iface[16];
> +        unsigned int Destination, Gateway, Mask, Flags;
> +        int RefCnt, Use, Metric, MTU, Window, IRTT;
> +
> +        i =3D (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> +                    Iface, &Destination, &Gateway, &Flags, &RefCnt,
> +                    &Use, &Metric, &Mask, &MTU, &Window, &IRTT) =3D=3D 1=
1);
> +        if (i =3D=3D EOF) {
> +            continue;
> +        }
> +
> +        networkroute =3D g_new0(GuestNetworkRouteStat, 1);
> +
> +        char DestAddress[16];
> +        char GateAddress[16];
> +        char MaskAddress[16];
> +
> +        networkroute->iface =3D g_strdup(Iface);
> +        networkroute->destination =3D g_strdup(hexToIPAddress(Destinatio=
n,
> DestAddress));
> +        networkroute->gateway =3D g_strdup(hexToIPAddress(Gateway,
> GateAddress));
> +        networkroute->mask =3D g_strdup(hexToIPAddress(Mask, MaskAddress=
));
> +        networkroute->metric =3D Metric;
> +        networkroute->flags =3D Flags;
> +        networkroute->refcnt =3D RefCnt;
> +        networkroute->use =3D Use;
> +        networkroute->mtu =3D MTU;
> +        networkroute->window =3D Window;
> +        networkroute->irtt =3D IRTT;
> +
> +        QAPI_LIST_APPEND(tail, networkroute);
> +    }
> +
> +    free(line);
> +    fclose(fp);
> +    return head;
> +}
> +
>  #else /* defined(__linux__) */
>
>  void qmp_guest_suspend_disk(Error **errp)
> @@ -3118,6 +3185,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
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
> index 697c65507c..e62c04800a 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
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
> index 876e2a8ea8..195f6cd4e7 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1789,3 +1789,71 @@
>  { 'command': 'guest-get-cpustats',
>    'returns': ['GuestCpuStats']
>  }
> +
> +##
> +# @GuestNetworkRouteStat:
> +#
> +# Route information, currently, only linux supported.
> +#
> +# @iface: The destination network or host's egress network interface in
> the routing table
> +#
> +# @destination: The IP address of the target network or host, The final
> destination of the packet
> +#
> +# @gateway: The IP address of the next hop router
> +#
> +# @mask: Subnet Mask
> +#
> +# @metric: Route metricls
> +#
> +# @flags: Route flags (not for windows)
> +#
> +# @irtt: Initial round-trip delay (not for windows)
> +#
> +# @refcnt: The route's reference count (not for windows)
> +#
> +# @use: Route usage count (not for windows)
> +#
> +# @window: TCP window size, used for flow control (not for windows)
> +#
> +# @mtu: Data link layer maximum packet size (not for windows)
> +#
> +# Since: 9.1
> +
> +##
> +{ 'struct': 'GuestNetworkRouteStat',
> +  'data': {'iface': 'str',
> +           'destination': 'str',
> +           'gateway': 'str',
> +           'metric': 'int',
> +           'mask': 'str',
> +           '*irtt': 'int',
> +           '*flags': 'uint64',
> +           '*refcnt': 'int',
> +           '*use': 'int',
> +           '*window': 'int',
> +           '*mtu': 'int'
> +           }}
> +
> +##
> +# @GuestNetworkRoute:
> +#
> +# Get route information of system.
> +#
> +# @routes: A list of network route information.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'GuestNetworkRoute',
> +  'data': { 'routes': ['GuestNetworkRouteStat'] } }
>

This struct is unused anymore, so remove it and
rename GuestNetworkRouteStat to GuestNetworkRoute.


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
> +  'returns': ['GuestNetworkRouteStat']
> +}
> --
> 2.40.1
>
>

--0000000000008e0a07061aac5e91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div><br></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Jun 12, 2024 at 7:36=E2=80=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@re=
dhat.com">demeng@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The Route information of the Linux VM needs to b=
e used<br>
by administrators and users when debugging network problems<br>
and troubleshooting.<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-win32.c |=C2=A0 6 ++++<br>
=C2=A0qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++<b=
r>
=C2=A03 files changed, 147 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 6169bbf7a0..ffae88ca69 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -2747,6 +2747,73 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
<br>
+char *hexToIPAddress(unsigned int hexValue, char ipAddress[16]);<br>
+char *hexToIPAddress(unsigned int hexValue, char ipAddress[16])<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int byte1 =3D (hexValue &gt;&gt; 24) &amp; 0xFF;<br=
>
+=C2=A0 =C2=A0 unsigned int byte2 =3D (hexValue &gt;&gt; 16) &amp; 0xFF;<br=
>
+=C2=A0 =C2=A0 unsigned int byte3 =3D (hexValue &gt;&gt; 8) &amp; 0xFF;<br>
+=C2=A0 =C2=A0 unsigned int byte4 =3D hexValue &amp; 0xFF;<br>
+<br>
+=C2=A0 =C2=A0 snprintf(ipAddress, 16, &quot;%u.%u.%u.%u&quot;, byte4, byte=
3, byte2, byte1);<br>
+<br>
+=C2=A0 =C2=A0 return ipAddress;<br>
+}<br>
+<br>
+GuestNetworkRouteStatList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestNetworkRouteStatList *head =3D NULL, **tail =3D &amp;he=
ad;<br>
+=C2=A0 =C2=A0 const char *routeFile =3D &quot;/proc/net/route&quot;;<br>
+=C2=A0 =C2=A0 FILE *fp;<br>
+=C2=A0 =C2=A0 size_t n;<br>
+=C2=A0 =C2=A0 char *line =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 fp =3D fopen(routeFile, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, routeFile);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRouteStat *networkroute;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char Iface[16];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int Destination, Gateway, Mask, Flags=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int RefCnt, Use, Metric, MTU, Window, IRTT;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D (sscanf(line, &quot;%s %X %X %x %d %d %d=
 %X %d %d %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ifac=
e, &amp;Destination, &amp;Gateway, &amp;Flags, &amp;RefCnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;Use, &amp;Metric, &amp;Mask, &amp;MTU, &amp;Window, &amp;IRTT) =3D=3D 11);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D EOF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =3D g_new0(GuestNetworkRouteStat,=
 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char DestAddress[16];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char GateAddress[16];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char MaskAddress[16];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;iface =3D g_strdup(Iface);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;destination =3D g_strdup(hexT=
oIPAddress(Destination, DestAddress));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;gateway =3D g_strdup(hexToIPA=
ddress(Gateway, GateAddress));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;mask =3D g_strdup(hexToIPAddr=
ess(Mask, MaskAddress));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;metric =3D Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;flags =3D Flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;refcnt =3D RefCnt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;use =3D Use;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;mtu =3D MTU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;window =3D Window;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;irtt =3D IRTT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, networkroute);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
+<br>
=C2=A0#else /* defined(__linux__) */<br>
<br>
=C2=A0void qmp_guest_suspend_disk(Error **errp)<br>
@@ -3118,6 +3185,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
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
index 697c65507c..e62c04800a 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **err=
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
index 876e2a8ea8..195f6cd4e7 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1789,3 +1789,71 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestCpuStats&#39;]<br>
=C2=A0}<br>
+<br>
+##<br>
+# @GuestNetworkRouteStat:<br>
+#<br>
+# Route information, currently, only linux supported.<br>
+#<br>
+# @iface: The destination network or host&#39;s egress network interface i=
n the routing table<br>
+#<br>
+# @destination: The IP address of the target network or host, The final de=
stination of the packet<br>
+#<br>
+# @gateway: The IP address of the next hop router<br>
+#<br>
+# @mask: Subnet Mask<br>
+#<br>
+# @metric: Route metricls<br>
+#<br>
+# @flags: Route flags (not for windows)<br>
+#<br>
+# @irtt: Initial round-trip delay (not for windows)<br>
+#<br>
+# @refcnt: The route&#39;s reference count (not for windows)<br>
+#<br>
+# @use: Route usage count (not for windows)<br>
+#<br>
+# @window: TCP window size, used for flow control (not for windows)<br>
+#<br>
+# @mtu: Data link layer maximum packet size (not for windows)<br>
+#<br>
+# Since: 9.1<br>
+<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNetworkRouteStat&#39;,<br>
+=C2=A0 &#39;data&#39;: {&#39;iface&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;destination&#39;: &#39;str&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;gateway&#39;: &#39;str&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;metric&#39;: &#39;int&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mask&#39;: &#39;str&#39;,<br=
>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*mtu&#39;: &#39;int&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}}<br>
+<br>
+##<br>
+# @GuestNetworkRoute:<br>
+#<br>
+# Get route information of system.<br>
+#<br>
+# @routes: A list of network route information.<br>
+#<br>
+# Since: 9.1<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNetworkRoute&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;routes&#39;: [&#39;GuestNetworkRouteStat&#39=
;] } }<br></blockquote><div><br></div><div>This struct is unused anymore, s=
o remove it and</div><div>rename GuestNetworkRouteStat to GuestNetworkRoute=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRouteStat&#39;]<br>
+}<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>

--0000000000008e0a07061aac5e91--


