Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904BBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjR2-0001zb-GN; Fri, 19 Jul 2024 04:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUjQy-0001yz-1S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUjQv-0001rC-1W
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721379464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=op12wuQa/ARTGWMnW9mrvhgQ9c7LFa5BH1rlYTPltws=;
 b=Fl1v/w41xtG1FPAod9kNcj2zOObcg+dbXTA3WTruPllSmLKmP/W+kxADfO6757IfJ+vg0L
 ZXqLtpESP55l59lkE3mLn4uVpIBi/eMhecD+dRvpU6iLP1iq2Bp7ZSOAwH4UfTJvVVLMv2
 EcQqsbvJ+t9X1AUfgkUtHSLVYxgFpM0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-MZdpAvg2MJelV4L8JPcWbQ-1; Fri, 19 Jul 2024 04:57:41 -0400
X-MC-Unique: MZdpAvg2MJelV4L8JPcWbQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-664bc570740so28460247b3.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721379461; x=1721984261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=op12wuQa/ARTGWMnW9mrvhgQ9c7LFa5BH1rlYTPltws=;
 b=kk56g3ivolY9e9qw6vlDRcDKK5PjlO4BqR/NLDN3//L9KpW1T1rdbVdQuNhl4/TCFN
 O5Fz9rAdGmQP9YpCQQcV4ydOJjLhk2MQU8p9T/WsxYxd0q+FQh9xUblzFZ18G6ODRmg8
 P0BqGRecfzJPBwWsj9nKcZmwFLjHC8UWZ5egxxEbauqGamAEDW8ystTIlPmC/lFhXcTY
 gSlUmV3DJY5n0l32EWFwpwIPsCQynUoGHOSXH1cCDV9kE9aqjH7D6QIAHjl5ANrUWStg
 19BPeysvP8ywgskb/P/VGQle3KPpBdN3se4GnxnrRCI6bcuXdtpUNNc3lXtOFvUbX6VV
 +pxA==
X-Gm-Message-State: AOJu0Yw4obWKmCur3xAAmz5JC0Ja4dw3Z/rqlfoFKl2WfaaV9HdgKVvW
 AAYrDR6W3C574q7YUM6m6cwLtB2+XaAgXggvzdL5UXJn1uZXpFr33jzxCpkbqMpjt0kUh8maidX
 BplrKjw5ZRm3Y5Os4Pl28fV/UoQFCU6Rx971ytE10n+Gu6UUGZd+YzzvMBLMpgTRtI6ms+nXeul
 tA1/LLlrWRwrO0OUX1hAgEl9hV6w0=
X-Received: by 2002:a0d:ee41:0:b0:61a:e979:427e with SMTP id
 00721157ae682-666086eabc6mr38901737b3.11.1721379460827; 
 Fri, 19 Jul 2024 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8hoE9eGI+w+g6bFF1JBMOmKVLUOTxW4fANtf9IgHD2S8CVjFV5ssggpMl1dvDQSDwCX7PIfZFm8KVBEiVfI=
X-Received: by 2002:a0d:ee41:0:b0:61a:e979:427e with SMTP id
 00721157ae682-666086eabc6mr38901607b3.11.1721379460460; Fri, 19 Jul 2024
 01:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240613092802.346246-1-demeng@redhat.com>
 <20240613092802.346246-2-demeng@redhat.com>
 <CAPMcbCroa=8mu2g1V80BWpaVNYsbdJ6M0c4EWJxzWiZBg-ozLw@mail.gmail.com>
 <5830d5f2-447d-4c41-a93c-639dd40be474@linaro.org>
In-Reply-To: <5830d5f2-447d-4c41-a93c-639dd40be474@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 11:57:29 +0300
Message-ID: <CAPMcbCr7yrnMVhDeCTOdCEpb38k-z-c-BJYU1oHOCktx1xxVRg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dehan Meng <demeng@redhat.com>, michael.roth@amd.com, 
 Daniel Berrange <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000043cdd9061d95e3c2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000043cdd9061d95e3c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric and Markus,

Do you have any comments about QAPI schema?

Best Regards,
Konstantin Kostiuk.


On Wed, Jul 17, 2024 at 4:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 13/6/24 13:18, Konstantin Kostiuk wrote:
> > CC: Daniel, Philippe
>
> Having a quick look, no major issue noticed.
>
> Cc'ing Markus/Eric for QAPI schema.
>
> BTW MAINTAINERS likely missing:
>
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d9811458c..af4db698de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3217,10 +3217,11 @@ T: git https://repo.or.cz/qemu/armbru.git
> qapi-next
>   QAPI Schema
>   M: Eric Blake <eblake@redhat.com>
>   M: Markus Armbruster <armbru@redhat.com>
>   S: Supported
>   F: qapi/*.json
> +F: qga/qapi-schema.json
>   T: git https://repo.or.cz/qemu/armbru.git qapi-next
>
> ---
>
> >
> > On Thu, Jun 13, 2024 at 12:28=E2=80=AFPM Dehan Meng <demeng@redhat.com
> > <mailto:demeng@redhat.com>> wrote:
> >
> >     The Route information of the Linux VM needs to be used
> >     by administrators and users when debugging network problems
> >     and troubleshooting.
> >
> >     Signed-off-by: Dehan Meng <demeng@redhat.com <mailto:
> demeng@redhat.com>>
> >     ---
> >       qga/commands-posix.c | 135
> +++++++++++++++++++++++++++++++++++++++++++
> >       qga/commands-win32.c |   6 ++
> >       qga/qapi-schema.json |  71 +++++++++++++++++++++++
> >       3 files changed, 212 insertions(+)
> >
> >     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >     index 7f05996495..b85b3937bf 100644
> >     --- a/qga/commands-posix.c
> >     +++ b/qga/commands-posix.c
> >     @@ -2708,6 +2708,135 @@ GuestCpuStatsList
> >     *qmp_guest_get_cpustats(Error **errp)
> >           return head;
> >       }
> >
> >     +static char *hexToIPAddress(const void *hexValue, int is_ipv6)
> >     +{
> >     +    if (is_ipv6) {
> >     +        char addr[INET6_ADDRSTRLEN];
> >     +        struct in6_addr in6;
> >     +        const char *hexStr =3D (const char *)hexValue;
> >     +        int i;
> >     +
> >     +        for (i =3D 0; i < 16; i++) {
> >     +            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> >     +        }
> >     +        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> >     +
> >     +        return g_strdup(addr);
> >     +    } else {
> >     +        unsigned int hexInt =3D *(unsigned int *)hexValue;
> >     +        unsigned int byte1 =3D (hexInt >> 24) & 0xFF;
> >     +        unsigned int byte2 =3D (hexInt >> 16) & 0xFF;
> >     +        unsigned int byte3 =3D (hexInt >> 8) & 0xFF;
> >     +        unsigned int byte4 =3D hexInt & 0xFF;
> >     +
> >     +        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2,
> >     byte1);
> >     +    }
> >     +}
> >     +
> >     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> >     +{
> >     +    GuestNetworkRouteList *head =3D NULL, **tail =3D &head;
> >     +    const char *routeFiles[] =3D {"/proc/net/route",
> >     "/proc/net/ipv6_route"};
> >     +    FILE *fp;
> >     +    size_t n;
> >     +    char *line =3D NULL;
> >     +    int firstLine;
> >     +    int is_ipv6;
> >     +    int i;
> >     +
> >     +    for (i =3D 0; i < 2; i++) {
> >     +        firstLine =3D 1;
> >     +        is_ipv6 =3D (i =3D=3D 1);
> >     +        fp =3D fopen(routeFiles[i], "r");
> >     +        if (fp =3D=3D NULL) {
> >     +            error_setg_errno(errp, errno, "open(\"%s\")",
> >     routeFiles[i]);
> >     +            free(line);
> >     +            continue;
> >     +        }
> >     +
> >     +        while (getline(&line, &n, fp) !=3D -1) {
> >     +            if (firstLine && !is_ipv6) {
> >     +                firstLine =3D 0;
> >     +                continue;
> >     +            }
> >     +            GuestNetworkRoute *route =3D NULL;
> >     +            GuestNetworkRoute *networkroute;
> >     +            char Iface[IFNAMSIZ];
> >     +            if (is_ipv6) {
> >     +                char Destination[33], Source[33], NextHop[33];
> >     +                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt,
> >     Use, Flags;
> >     +
> >     +                /* Parse the line and extract the values */
> >     +                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x
> >     %32s",
> >     +                           Destination, &DesPrefixlen, Source,
> >     +                           &SrcPrefixlen, NextHop, &Metric, &RefCn=
t,
> >     +                           &Use, &Flags, Iface) !=3D 10) {
> >     +                    continue;
> >     +                }
> >     +
> >     +                route =3D g_new0(GuestNetworkRoute, 1);
> >     +                networkroute =3D route;
> >     +                networkroute->iface =3D g_strdup(Iface);
> >     +                networkroute->destination =3D
> >     hexToIPAddress(Destination, 1);
> >     +                networkroute->metric =3D Metric;
> >     +                networkroute->source =3D hexToIPAddress(Source, 1)=
;
> >     +                networkroute->desprefixlen =3D g_strdup_printf(
> >     +                    "%d", DesPrefixlen
> >     +                );
> >     +                networkroute->srcprefixlen =3D g_strdup_printf(
> >     +                    "%d", SrcPrefixlen
> >     +                );
> >     +                networkroute->nexthop =3D hexToIPAddress(NextHop, =
1);
> >     +                networkroute->has_flags =3D true;
> >     +                networkroute->flags =3D Flags;
> >     +                networkroute->has_refcnt =3D true;
> >     +                networkroute->refcnt =3D RefCnt;
> >     +                networkroute->has_use =3D true;
> >     +                networkroute->use =3D Use;
> >     +                networkroute->version =3D 6;
> >     +            } else {
> >     +                unsigned int Destination, Gateway, Mask, Flags;
> >     +                int RefCnt, Use, Metric, MTU, Window, IRTT;
> >     +
> >     +                /* Parse the line and extract the values */
> >     +                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d=
",
> >     +                           Iface, &Destination, &Gateway, &Flags,
> >     &RefCnt,
> >     +                           &Use, &Metric, &Mask, &MTU, &Window,
> >     &IRTT) !=3D 11) {
> >     +                    continue;
> >     +                }
> >     +
> >     +                route =3D g_new0(GuestNetworkRoute, 1);
> >     +                networkroute =3D route;
> >     +                networkroute->iface =3D g_strdup(Iface);
> >     +                networkroute->destination =3D
> >     hexToIPAddress(&Destination, 0);
> >     +                networkroute->gateway =3D hexToIPAddress(&Gateway,=
 0);
> >     +                networkroute->mask =3D hexToIPAddress(&Mask, 0);
> >     +                networkroute->metric =3D Metric;
> >     +                networkroute->has_flags =3D true;
> >     +                networkroute->flags =3D Flags;
> >     +                networkroute->has_refcnt =3D true;
> >     +                networkroute->refcnt =3D RefCnt;
> >     +                networkroute->has_use =3D true;
> >     +                networkroute->use =3D Use;
> >     +                networkroute->has_mtu =3D true;
> >     +                networkroute->mtu =3D MTU;
> >     +                networkroute->has_window =3D true;
> >     +                networkroute->window =3D Window;
> >     +                networkroute->has_irtt =3D true;
> >     +                networkroute->irtt =3D IRTT;
> >     +                networkroute->version =3D 4;
> >     +            }
> >     +
> >     +            QAPI_LIST_APPEND(tail, route);
> >     +        }
> >     +
> >     +        free(line);
> >     +        fclose(fp);
> >     +    }
> >     +
> >     +    return head;
> >     +}
> >     +
> >       #else /* defined(__linux__) */
> >
> >       void qmp_guest_suspend_disk(Error **errp)
> >     @@ -3079,6 +3208,12 @@ GuestCpuStatsList
> >     *qmp_guest_get_cpustats(Error **errp)
> >           return NULL;
> >       }
> >
> >     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> >     +{
> >     +    error_setg(errp, QERR_UNSUPPORTED);
> >     +    return NULL;
> >     +}
> >     +
> >       #endif /* CONFIG_FSFREEZE */
> >
> >       #if !defined(CONFIG_FSTRIM)
> >     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> >     index 0d1b836e87..91289bc9ab 100644
> >     --- a/qga/commands-win32.c
> >     +++ b/qga/commands-win32.c
> >     @@ -2517,3 +2517,9 @@ GuestCpuStatsList
> >     *qmp_guest_get_cpustats(Error **errp)
> >           error_setg(errp, QERR_UNSUPPORTED);
> >           return NULL;
> >       }
> >     +
> >     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> >     +{
> >     +    error_setg(errp, QERR_UNSUPPORTED);
> >     +    return NULL;
> >     +}
> >     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >     index b3de1fb6b3..1c2ee9f3c6 100644
> >     --- a/qga/qapi-schema.json
> >     +++ b/qga/qapi-schema.json
> >     @@ -1800,3 +1800,74 @@
> >       { 'command': 'guest-get-cpustats',
> >         'returns': ['GuestCpuStats']
> >       }
> >     +
> >     +##
> >     +# @GuestNetworkRoute:
> >     +#
> >     +# Route information, currently, only linux supported.
> >     +#
> >     +# @iface: The destination network or host's egress network
> >     interface in the routing table
> >     +#
> >     +# @destination: The IP address of the target network or host, The
> >     final destination of the packet
> >     +#
> >     +# @metric: Route metric
> >     +#
> >     +# @gateway: The IP address of the next hop router
> >     +#
> >     +# @mask: Subnet Mask (IPv4 only)
> >     +#
> >     +# @irtt: Initial round-trip delay (not for windows, IPv4 only)
> >     +#
> >     +# @flags: Route flags (not for windows)
> >     +#
> >     +# @refcnt: The route's reference count (not for windows)
> >     +#
> >     +# @use: Route usage count (not for windows)
> >     +#
> >     +# @window: TCP window size, used for flow control (not for windows=
,
> >     IPv4 only)
> >     +#
> >     +# @mtu: Data link layer maximum packet size (not for windows)
> >     +#
> >     +# @desprefixlen: Destination prefix length (for IPv6)
> >     +#
> >     +# @source: Source IP address (for IPv6)
> >     +#
> >     +# @srcprefixlen: Source prefix length (for IPv6)
> >     +#
> >     +# @nexthop: Next hop IP address (for IPv6)
> >     +#
> >     +# @version: IP version (4 or 6)
> >     +#
> >     +# Since: 9.1
> >     +
> >     +##
> >     +{ 'struct': 'GuestNetworkRoute',
> >     +  'data': {'iface': 'str',
> >     +           'destination': 'str',
> >     +           'metric': 'int',
> >     +           '*gateway': 'str',
> >     +           '*mask': 'str',
> >     +           '*irtt': 'int',
> >     +           '*flags': 'uint64',
> >     +           '*refcnt': 'int',
> >     +           '*use': 'int',
> >     +           '*window': 'int',
> >     +           '*mtu': 'int',
> >     +           '*desprefixlen': 'str',
> >     +           '*source': 'str',
> >     +           '*srcprefixlen': 'str',
> >     +           '*nexthop': 'str',
> >     +           'version': 'int'
> >     +           }}
> >     +
> >     +##
> >     +# @guest-network-get-route:
> >     +#
> >     +# Retrieve information about route of network.
> >     +# Returns: List of route info of guest.
> >     +#
> >     +# Since: 9.1
> >     +##
> >     +{ 'command': 'guest-network-get-route',
> >     +  'returns': ['GuestNetworkRoute']
> >     +}
> >     --
> >     2.40.1
> >
>
>

--00000000000043cdd9061d95e3c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBFcmljIGFuZCBNYXJrdXMsPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5EbyB5b3UgaGF2ZSBhbnkgY29tbWVudHMgYWJvdXQgUUFQSSBzY2hlbWE/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWdu
YXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxk
aXY+QmVzdCBSZWdhcmRzLDwvZGl2PjxkaXY+S29uc3RhbnRpbiBLb3N0aXVrLjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIEp1bCAxNywgMjAyNCBh
dCA0OjU34oCvUE0gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0OzxhIGhyZWY9Im1haWx0bzpw
aGlsbWRAbGluYXJvLm9yZyI+cGhpbG1kQGxpbmFyby5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPk9uIDEzLzYvMjQgMTM6MTgsIEtvbnN0YW50aW4gS29zdGl1ayB3cm90ZTo8YnI+
DQomZ3Q7IENDOiBEYW5pZWwsIFBoaWxpcHBlPGJyPg0KPGJyPg0KSGF2aW5nIGEgcXVpY2sgbG9v
aywgbm8gbWFqb3IgaXNzdWUgbm90aWNlZC48YnI+DQo8YnI+DQpDYyYjMzk7aW5nIE1hcmt1cy9F
cmljIGZvciBRQVBJIHNjaGVtYS48YnI+DQo8YnI+DQpCVFcgTUFJTlRBSU5FUlMgbGlrZWx5IG1p
c3Npbmc6PGJyPg0KPGJyPg0KLS0gJmd0OzggLS08YnI+DQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUzxicj4NCmluZGV4IDdkOTgxMTQ1OGMuLmFmNGRiNjk4ZGUgMTAwNjQ0
PGJyPg0KLS0tIGEvTUFJTlRBSU5FUlM8YnI+DQorKysgYi9NQUlOVEFJTkVSUzxicj4NCkBAIC0z
MjE3LDEwICszMjE3LDExIEBAIFQ6IGdpdCA8YSBocmVmPSJodHRwczovL3JlcG8ub3IuY3ovcWVt
dS9hcm1icnUuZ2l0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3Jl
cG8ub3IuY3ovcWVtdS9hcm1icnUuZ2l0PC9hPiBxYXBpLW5leHQ8YnI+DQrCoCBRQVBJIFNjaGVt
YTxicj4NCsKgIE06IEVyaWMgQmxha2UgJmx0OzxhIGhyZWY9Im1haWx0bzplYmxha2VAcmVkaGF0
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVibGFrZUByZWRoYXQuY29tPC9hPiZndDs8YnI+DQrCoCBN
OiBNYXJrdXMgQXJtYnJ1c3RlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFybWJydUByZWRoYXQuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YXJtYnJ1QHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NCsKgIFM6IFN1
cHBvcnRlZDxicj4NCsKgIEY6IHFhcGkvKi5qc29uPGJyPg0KK0Y6IHFnYS9xYXBpLXNjaGVtYS5q
c29uPGJyPg0KwqAgVDogZ2l0IDxhIGhyZWY9Imh0dHBzOi8vcmVwby5vci5jei9xZW11L2FybWJy
dS5naXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcmVwby5vci5j
ei9xZW11L2FybWJydS5naXQ8L2E+IHFhcGktbmV4dDxicj4NCjxicj4NCi0tLTxicj4NCjxicj4N
CiZndDsgPGJyPg0KJmd0OyBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAxMjoyOOKAr1BNIERlaGFu
IE1lbmcgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW1lbmdAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPmRlbWVuZ0ByZWRoYXQuY29tPC9hPiA8YnI+DQomZ3Q7ICZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmRlbWVuZ0ByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVtZW5nQHJlZGhhdC5j
b208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBUaGUgUm91
dGUgaW5mb3JtYXRpb24gb2YgdGhlIExpbnV4IFZNIG5lZWRzIHRvIGJlIHVzZWQ8YnI+DQomZ3Q7
wqAgwqAgwqBieSBhZG1pbmlzdHJhdG9ycyBhbmQgdXNlcnMgd2hlbiBkZWJ1Z2dpbmcgbmV0d29y
ayBwcm9ibGVtczxicj4NCiZndDvCoCDCoCDCoGFuZCB0cm91Ymxlc2hvb3RpbmcuPGJyPg0KJmd0
OyA8YnI+DQomZ3Q7wqAgwqAgwqBTaWduZWQtb2ZmLWJ5OiBEZWhhbiBNZW5nICZsdDs8YSBocmVm
PSJtYWlsdG86ZGVtZW5nQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW1lbmdAcmVkaGF0
LmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGVtZW5nQHJlZGhhdC5jb20iIHRh
cmdldD0iX2JsYW5rIj5kZW1lbmdAcmVkaGF0LmNvbTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDvCoCDC
oCDCoC0tLTxicj4NCiZndDvCoCDCoCDCoCDCoHFnYS9jb21tYW5kcy1wb3NpeC5jIHwgMTM1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+DQomZ3Q7wqAgwqAg
wqAgwqBxZ2EvY29tbWFuZHMtd2luMzIuYyB8wqAgwqA2ICsrPGJyPg0KJmd0O8KgIMKgIMKgIMKg
cWdhL3FhcGktc2NoZW1hLmpzb24gfMKgIDcxICsrKysrKysrKysrKysrKysrKysrKysrPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgMyBmaWxlcyBjaGFuZ2VkLCAyMTIgaW5zZXJ0aW9ucygrKTxicj4NCiZn
dDsgPGJyPg0KJmd0O8KgIMKgIMKgZGlmZiAtLWdpdCBhL3FnYS9jb21tYW5kcy1wb3NpeC5jIGIv
cWdhL2NvbW1hbmRzLXBvc2l4LmM8YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCA3ZjA1OTk2NDk1Li5i
ODViMzkzN2JmIDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoC0tLSBhL3FnYS9jb21tYW5kcy1wb3Np
eC5jPGJyPg0KJmd0O8KgIMKgIMKgKysrIGIvcWdhL2NvbW1hbmRzLXBvc2l4LmM8YnI+DQomZ3Q7
wqAgwqAgwqBAQCAtMjcwOCw2ICsyNzA4LDEzNSBAQCBHdWVzdENwdVN0YXRzTGlzdDxicj4NCiZn
dDvCoCDCoCDCoCpxbXBfZ3Vlc3RfZ2V0X2NwdXN0YXRzKEVycm9yICoqZXJycCk8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gaGVhZDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqB9PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIGNoYXIgKmhleFRvSVBBZGRyZXNzKGNvbnN0
IHZvaWQgKmhleFZhbHVlLCBpbnQgaXNfaXB2Nik8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBpZiAoaXNfaXB2Nikgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBjaGFyIGFkZHJbSU5FVDZfQUREUlNUUkxFTl07PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHN0cnVjdCBpbjZfYWRkciBpbjY7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IGNvbnN0IGNoYXIgKmhleFN0ciA9IChjb25zdCBjaGFyICopaGV4VmFsdWU7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIGludCBpOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IDE2OyBpKyspIHs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgc3NjYW5mKCZhbXA7aGV4U3RyW2kgKiAyXSwgJnF1
b3Q7JTAyaGh4JnF1b3Q7LCAmYW1wO2luNi5zNl9hZGRyW2ldKTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBpbmV0X250b3AoQUZf
SU5FVDYsICZhbXA7aW42LCBhZGRyLCBJTkVUNl9BRERSU1RSTEVOKTs8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybiBnX3N0cmR1cChhZGRyKTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgdW5zaWduZWQgaW50IGhleEludCA9ICoodW5zaWduZWQgaW50ICopaGV4VmFsdWU7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHVuc2lnbmVkIGludCBieXRlMSA9IChoZXhJbnQg
Jmd0OyZndDsgMjQpICZhbXA7IDB4RkY7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHVu
c2lnbmVkIGludCBieXRlMiA9IChoZXhJbnQgJmd0OyZndDsgMTYpICZhbXA7IDB4RkY7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHVuc2lnbmVkIGludCBieXRlMyA9IChoZXhJbnQgJmd0
OyZndDsgOCkgJmFtcDsgMHhGRjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgdW5zaWdu
ZWQgaW50IGJ5dGU0ID0gaGV4SW50ICZhbXA7IDB4RkY7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXR1cm4gZ19zdHJkdXBfcHJpbnRmKCZxdW90OyV1
LiV1LiV1LiV1JnF1b3Q7LCBieXRlNCwgYnl0ZTMsIGJ5dGUyLDxicj4NCiZndDvCoCDCoCDCoGJ5
dGUxKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtHdWVzdE5ldHdvcmtSb3V0ZUxpc3QgKnFt
cF9ndWVzdF9uZXR3b3JrX2dldF9yb3V0ZShFcnJvciAqKmVycnApPGJyPg0KJmd0O8KgIMKgIMKg
K3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgR3Vlc3ROZXR3b3JrUm91dGVMaXN0ICpoZWFkID0g
TlVMTCwgKip0YWlsID0gJmFtcDtoZWFkOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjb25zdCBj
aGFyICpyb3V0ZUZpbGVzW10gPSB7JnF1b3Q7L3Byb2MvbmV0L3JvdXRlJnF1b3Q7LDxicj4NCiZn
dDvCoCDCoCDCoCZxdW90Oy9wcm9jL25ldC9pcHY2X3JvdXRlJnF1b3Q7fTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgRklMRSAqZnA7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHNpemVfdCBuOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjaGFyICpsaW5lID0gTlVMTDs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgaW50IGZpcnN0TGluZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaW50IGlzX2lw
djY7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGludCBpOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IDI7IGkrKykgezxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBmaXJzdExpbmUgPSAxOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBpc19pcHY2ID0gKGkgPT0gMSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIGZwID0gZm9wZW4ocm91dGVGaWxlc1tpXSwgJnF1b3Q7ciZxdW90Oyk7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIGlmIChmcCA9PSBOVUxMKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIMKgIMKgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICZxdW90O29wZW4o
XCZxdW90OyVzXCZxdW90OykmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgcm91dGVGaWxlc1tpXSk7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIGZyZWUobGluZSk7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCB3aGlsZSAoZ2V0bGluZSgmYW1wO2xpbmUsICZhbXA7biwgZnApICE9IC0xKSB7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIGlmIChmaXJzdExpbmUgJmFtcDsmYW1wOyAh
aXNfaXB2Nikgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaXJz
dExpbmUgPSAwOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250
aW51ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBHdWVzdE5ldHdvcmtSb3V0ZSAqcm91dGUgPSBOVUxMOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBHdWVzdE5ldHdvcmtSb3V0ZSAqbmV0
d29ya3JvdXRlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjaGFyIElmYWNl
W0lGTkFNU0laXTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGlzX2lw
djYpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2hhciBEZXN0
aW5hdGlvblszM10sIFNvdXJjZVszM10sIE5leHRIb3BbMzNdOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgRGVzUHJlZml4bGVuLCBTcmNQcmVmaXhsZW4sIE1l
dHJpYywgUmVmQ250LDxicj4NCiZndDvCoCDCoCDCoFVzZSwgRmxhZ3M7PGJyPg0KJmd0O8KgIMKg
IMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBQYXJzZSB0
aGUgbGluZSBhbmQgZXh0cmFjdCB0aGUgdmFsdWVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIChzc2NhbmYobGluZSwgJnF1b3Q7JTMycyAleCAlMzJzICV4
ICUzMnMgJXggJXggJXggJXg8YnI+DQomZ3Q7wqAgwqAgwqAlMzJzJnF1b3Q7LDxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERlc3RpbmF0
aW9uLCAmYW1wO0Rlc1ByZWZpeGxlbiwgU291cmNlLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7U3JjUHJlZml4bGVuLCBOZXh0
SG9wLCAmYW1wO01ldHJpYywgJmFtcDtSZWZDbnQsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtVc2UsICZhbXA7RmxhZ3MsIElm
YWNlKSAhPSAxMCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBjb250aW51ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcm91dGUgPSBnX25ldzAoR3Vlc3ROZXR3b3JrUm91dGUsIDEpOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUgPSByb3V0ZTs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtpZmFj
ZSA9IGdfc3RyZHVwKElmYWNlKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgbmV0d29ya3JvdXRlLSZndDtkZXN0aW5hdGlvbiA9PGJyPg0KJmd0O8KgIMKgIMKgaGV4
VG9JUEFkZHJlc3MoRGVzdGluYXRpb24sIDEpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O21ldHJpYyA9IE1ldHJpYzs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtzb3VyY2Ug
PSBoZXhUb0lQQWRkcmVzcyhTb3VyY2UsIDEpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O2Rlc3ByZWZpeGxlbiA9IGdfc3RyZHVwX3By
aW50Zig8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1
b3Q7JWQmcXVvdDssIERlc1ByZWZpeGxlbjxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCApOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBu
ZXR3b3Jrcm91dGUtJmd0O3NyY3ByZWZpeGxlbiA9IGdfc3RyZHVwX3ByaW50Zig8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7JWQmcXVvdDssIFNy
Y1ByZWZpeGxlbjxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCApOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0
O25leHRob3AgPSBoZXhUb0lQQWRkcmVzcyhOZXh0SG9wLCAxKTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtoYXNfZmxhZ3MgPSB0cnVl
Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUt
Jmd0O2ZsYWdzID0gRmxhZ3M7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7aGFzX3JlZmNudCA9IHRydWU7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7cmVmY250ID0gUmVmQ250
Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUt
Jmd0O2hhc191c2UgPSB0cnVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBuZXR3b3Jrcm91dGUtJmd0O3VzZSA9IFVzZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDt2ZXJzaW9uID0gNjs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgaW50IERlc3RpbmF0aW9uLCBHYXRld2F5LCBN
YXNrLCBGbGFnczs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50
IFJlZkNudCwgVXNlLCBNZXRyaWMsIE1UVSwgV2luZG93LCBJUlRUOzxicj4NCiZndDvCoCDCoCDC
oCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogUGFyc2UgdGhl
IGxpbmUgYW5kIGV4dHJhY3QgdGhlIHZhbHVlcyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiAoc3NjYW5mKGxpbmUsICZxdW90OyVzICVYICVYICV4ICVkICVk
ICVkICVYICVkICVkICVkJnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElmYWNlLCAmYW1wO0Rlc3RpbmF0aW9uLCAmYW1wO0dh
dGV3YXksICZhbXA7RmxhZ3MsPGJyPg0KJmd0O8KgIMKgIMKgJmFtcDtSZWZDbnQsPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtV
c2UsICZhbXA7TWV0cmljLCAmYW1wO01hc2ssICZhbXA7TVRVLCAmYW1wO1dpbmRvdyw8YnI+DQom
Z3Q7wqAgwqAgwqAmYW1wO0lSVFQpICE9IDExKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZSA9IGdfbmV3MChHdWVzdE5ldHdvcmtSb3V0ZSwg
MSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0
ZSA9IHJvdXRlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3
b3Jrcm91dGUtJmd0O2lmYWNlID0gZ19zdHJkdXAoSWZhY2UpOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O2Rlc3RpbmF0aW9uID08YnI+
DQomZ3Q7wqAgwqAgwqBoZXhUb0lQQWRkcmVzcygmYW1wO0Rlc3RpbmF0aW9uLCAwKTs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtnYXRl
d2F5ID0gaGV4VG9JUEFkZHJlc3MoJmFtcDtHYXRld2F5LCAwKTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDttYXNrID0gaGV4VG9JUEFk
ZHJlc3MoJmFtcDtNYXNrLCAwKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgbmV0d29ya3JvdXRlLSZndDttZXRyaWMgPSBNZXRyaWM7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7aGFzX2ZsYWdzID0gdHJ1
ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRl
LSZndDtmbGFncyA9IEZsYWdzOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBuZXR3b3Jrcm91dGUtJmd0O2hhc19yZWZjbnQgPSB0cnVlOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O3JlZmNudCA9IFJlZkNu
dDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRl
LSZndDtoYXNfdXNlID0gdHJ1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgbmV0d29ya3JvdXRlLSZndDt1c2UgPSBVc2U7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7aGFzX210dSA9IHRydWU7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7bXR1
ID0gTVRVOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jr
cm91dGUtJmd0O2hhc193aW5kb3cgPSB0cnVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O3dpbmRvdyA9IFdpbmRvdzs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtoYXNfaXJ0
dCA9IHRydWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdv
cmtyb3V0ZS0mZ3Q7aXJ0dCA9IElSVFQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7dmVyc2lvbiA9IDQ7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIFFBUElfTElTVF9BUFBFTkQodGFpbCwgcm91dGUpOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBmcmVlKGxpbmUpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBmY2xvc2UoZnApOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKg
Kzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCByZXR1cm4gaGVhZDs8YnI+DQomZ3Q7wqAgwqAgwqAr
fTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAjZWxzZSAvKiBkZWZpbmVk
KF9fbGludXhfXykgKi88YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoHZvaWQgcW1wX2d1
ZXN0X3N1c3BlbmRfZGlzayhFcnJvciAqKmVycnApPGJyPg0KJmd0O8KgIMKgIMKgQEAgLTMwNzks
NiArMzIwOCwxMiBAQCBHdWVzdENwdVN0YXRzTGlzdDxicj4NCiZndDvCoCDCoCDCoCpxbXBfZ3Vl
c3RfZ2V0X2NwdXN0YXRzKEVycm9yICoqZXJycCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gTlVMTDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAg
wqAgwqArR3Vlc3ROZXR3b3JrUm91dGVMaXN0ICpxbXBfZ3Vlc3RfbmV0d29ya19nZXRfcm91dGUo
RXJyb3IgKiplcnJwKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGVycm9yX3NldGcoZXJycCwgUUVSUl9VTlNVUFBPUlRFRCk7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIHJldHVybiBOVUxMOzxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKgKzxi
cj4NCiZndDvCoCDCoCDCoCDCoCNlbmRpZiAvKiBDT05GSUdfRlNGUkVFWkUgKi88YnI+DQomZ3Q7
IDxicj4NCiZndDvCoCDCoCDCoCDCoCNpZiAhZGVmaW5lZChDT05GSUdfRlNUUklNKTxicj4NCiZn
dDvCoCDCoCDCoGRpZmYgLS1naXQgYS9xZ2EvY29tbWFuZHMtd2luMzIuYyBiL3FnYS9jb21tYW5k
cy13aW4zMi5jPGJyPg0KJmd0O8KgIMKgIMKgaW5kZXggMGQxYjgzNmU4Ny4uOTEyODliYzlhYiAx
MDA2NDQ8YnI+DQomZ3Q7wqAgwqAgwqAtLS0gYS9xZ2EvY29tbWFuZHMtd2luMzIuYzxicj4NCiZn
dDvCoCDCoCDCoCsrKyBiL3FnYS9jb21tYW5kcy13aW4zMi5jPGJyPg0KJmd0O8KgIMKgIMKgQEAg
LTI1MTcsMyArMjUxNyw5IEBAIEd1ZXN0Q3B1U3RhdHNMaXN0PGJyPg0KJmd0O8KgIMKgIMKgKnFt
cF9ndWVzdF9nZXRfY3B1c3RhdHMoRXJyb3IgKiplcnJwKTxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoGVycm9yX3NldGcoZXJycCwgUUVSUl9VTlNVUFBPUlRFRCk7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPg0KJmd0O8KgIMKgIMKgIMKgfTxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArR3Vlc3ROZXR3b3JrUm91dGVMaXN0ICpxbXBfZ3Vlc3Rf
bmV0d29ya19nZXRfcm91dGUoRXJyb3IgKiplcnJwKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIGVycm9yX3NldGcoZXJycCwgUUVSUl9VTlNVUFBPUlRFRCk7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIHJldHVybiBOVUxMOzxicj4NCiZndDvCoCDCoCDCoCt9PGJy
Pg0KJmd0O8KgIMKgIMKgZGlmZiAtLWdpdCBhL3FnYS9xYXBpLXNjaGVtYS5qc29uIGIvcWdhL3Fh
cGktc2NoZW1hLmpzb248YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCBiM2RlMWZiNmIzLi4xYzJlZTlm
M2M2IDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoC0tLSBhL3FnYS9xYXBpLXNjaGVtYS5qc29uPGJy
Pg0KJmd0O8KgIMKgIMKgKysrIGIvcWdhL3FhcGktc2NoZW1hLmpzb248YnI+DQomZ3Q7wqAgwqAg
wqBAQCAtMTgwMCwzICsxODAwLDc0IEBAPGJyPg0KJmd0O8KgIMKgIMKgIMKgeyAmIzM5O2NvbW1h
bmQmIzM5OzogJiMzOTtndWVzdC1nZXQtY3B1c3RhdHMmIzM5Oyw8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAmIzM5O3JldHVybnMmIzM5OzogWyYjMzk7R3Vlc3RDcHVTdGF0cyYjMzk7XTxicj4NCiZn
dDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyMjPGJy
Pg0KJmd0O8KgIMKgIMKgKyMgQEd1ZXN0TmV0d29ya1JvdXRlOjxicj4NCiZndDvCoCDCoCDCoCsj
PGJyPg0KJmd0O8KgIMKgIMKgKyMgUm91dGUgaW5mb3JtYXRpb24sIGN1cnJlbnRseSwgb25seSBs
aW51eCBzdXBwb3J0ZWQuPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBA
aWZhY2U6IFRoZSBkZXN0aW5hdGlvbiBuZXR3b3JrIG9yIGhvc3QmIzM5O3MgZWdyZXNzIG5ldHdv
cms8YnI+DQomZ3Q7wqAgwqAgwqBpbnRlcmZhY2UgaW4gdGhlIHJvdXRpbmcgdGFibGU8YnI+DQom
Z3Q7wqAgwqAgwqArIzxicj4NCiZndDvCoCDCoCDCoCsjIEBkZXN0aW5hdGlvbjogVGhlIElQIGFk
ZHJlc3Mgb2YgdGhlIHRhcmdldCBuZXR3b3JrIG9yIGhvc3QsIFRoZTxicj4NCiZndDvCoCDCoCDC
oGZpbmFsIGRlc3RpbmF0aW9uIG9mIHRoZSBwYWNrZXQ8YnI+DQomZ3Q7wqAgwqAgwqArIzxicj4N
CiZndDvCoCDCoCDCoCsjIEBtZXRyaWM6IFJvdXRlIG1ldHJpYzxicj4NCiZndDvCoCDCoCDCoCsj
PGJyPg0KJmd0O8KgIMKgIMKgKyMgQGdhdGV3YXk6IFRoZSBJUCBhZGRyZXNzIG9mIHRoZSBuZXh0
IGhvcCByb3V0ZXI8YnI+DQomZ3Q7wqAgwqAgwqArIzxicj4NCiZndDvCoCDCoCDCoCsjIEBtYXNr
OiBTdWJuZXQgTWFzayAoSVB2NCBvbmx5KTxicj4NCiZndDvCoCDCoCDCoCsjPGJyPg0KJmd0O8Kg
IMKgIMKgKyMgQGlydHQ6IEluaXRpYWwgcm91bmQtdHJpcCBkZWxheSAobm90IGZvciB3aW5kb3dz
LCBJUHY0IG9ubHkpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBAZmxh
Z3M6IFJvdXRlIGZsYWdzIChub3QgZm9yIHdpbmRvd3MpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+
DQomZ3Q7wqAgwqAgwqArIyBAcmVmY250OiBUaGUgcm91dGUmIzM5O3MgcmVmZXJlbmNlIGNvdW50
IChub3QgZm9yIHdpbmRvd3MpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqAr
IyBAdXNlOiBSb3V0ZSB1c2FnZSBjb3VudCAobm90IGZvciB3aW5kb3dzKTxicj4NCiZndDvCoCDC
oCDCoCsjPGJyPg0KJmd0O8KgIMKgIMKgKyMgQHdpbmRvdzogVENQIHdpbmRvdyBzaXplLCB1c2Vk
IGZvciBmbG93IGNvbnRyb2wgKG5vdCBmb3Igd2luZG93cyw8YnI+DQomZ3Q7wqAgwqAgwqBJUHY0
IG9ubHkpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBAbXR1OiBEYXRh
IGxpbmsgbGF5ZXIgbWF4aW11bSBwYWNrZXQgc2l6ZSAobm90IGZvciB3aW5kb3dzKTxicj4NCiZn
dDvCoCDCoCDCoCsjPGJyPg0KJmd0O8KgIMKgIMKgKyMgQGRlc3ByZWZpeGxlbjogRGVzdGluYXRp
b24gcHJlZml4IGxlbmd0aCAoZm9yIElQdjYpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7
wqAgwqAgwqArIyBAc291cmNlOiBTb3VyY2UgSVAgYWRkcmVzcyAoZm9yIElQdjYpPGJyPg0KJmd0
O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBAc3JjcHJlZml4bGVuOiBTb3VyY2UgcHJl
Zml4IGxlbmd0aCAoZm9yIElQdjYpPGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAg
wqArIyBAbmV4dGhvcDogTmV4dCBob3AgSVAgYWRkcmVzcyAoZm9yIElQdjYpPGJyPg0KJmd0O8Kg
IMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBAdmVyc2lvbjogSVAgdmVyc2lvbiAoNCBvciA2
KTxicj4NCiZndDvCoCDCoCDCoCsjPGJyPg0KJmd0O8KgIMKgIMKgKyMgU2luY2U6IDkuMTxicj4N
CiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArIyM8YnI+DQomZ3Q7wqAgwqAgwqAreyAm
IzM5O3N0cnVjdCYjMzk7OiAmIzM5O0d1ZXN0TmV0d29ya1JvdXRlJiMzOTssPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgICYjMzk7ZGF0YSYjMzk7OiB7JiMzOTtpZmFjZSYjMzk7OiAmIzM5O3N0ciYjMzk7
LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZGVzdGluYXRpb24mIzM5
OzogJiMzOTtzdHImIzM5Oyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAmIzM5
O21ldHJpYyYjMzk7OiAmIzM5O2ludCYjMzk7LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCYjMzk7KmdhdGV3YXkmIzM5OzogJiMzOTtzdHImIzM5Oyw8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgwqAgwqAmIzM5OyptYXNrJiMzOTs6ICYjMzk7c3RyJiMzOTssPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgJiMzOTsqaXJ0dCYjMzk7OiAmIzM5O2ludCYj
Mzk7LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCYjMzk7KmZsYWdzJiMzOTs6
ICYjMzk7dWludDY0JiMzOTssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgJiMz
OTsqcmVmY250JiMzOTs6ICYjMzk7aW50JiMzOTssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgJiMzOTsqdXNlJiMzOTs6ICYjMzk7aW50JiMzOTssPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgJiMzOTsqd2luZG93JiMzOTs6ICYjMzk7aW50JiMzOTssPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgJiMzOTsqbXR1JiMzOTs6ICYjMzk7aW50JiMz
OTssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgJiMzOTsqZGVzcHJlZml4bGVu
JiMzOTs6ICYjMzk7c3RyJiMzOTssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKg
JiMzOTsqc291cmNlJiMzOTs6ICYjMzk7c3RyJiMzOTssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgJiMzOTsqc3JjcHJlZml4bGVuJiMzOTs6ICYjMzk7c3RyJiMzOTssPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgJiMzOTsqbmV4dGhvcCYjMzk7OiAmIzM5O3N0
ciYjMzk7LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCYjMzk7dmVyc2lvbiYj
Mzk7OiAmIzM5O2ludCYjMzk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgfX08
YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyMjPGJyPg0KJmd0O8KgIMKgIMKg
KyMgQGd1ZXN0LW5ldHdvcmstZ2V0LXJvdXRlOjxicj4NCiZndDvCoCDCoCDCoCsjPGJyPg0KJmd0
O8KgIMKgIMKgKyMgUmV0cmlldmUgaW5mb3JtYXRpb24gYWJvdXQgcm91dGUgb2YgbmV0d29yay48
YnI+DQomZ3Q7wqAgwqAgwqArIyBSZXR1cm5zOiBMaXN0IG9mIHJvdXRlIGluZm8gb2YgZ3Vlc3Qu
PGJyPg0KJmd0O8KgIMKgIMKgKyM8YnI+DQomZ3Q7wqAgwqAgwqArIyBTaW5jZTogOS4xPGJyPg0K
Jmd0O8KgIMKgIMKgKyMjPGJyPg0KJmd0O8KgIMKgIMKgK3sgJiMzOTtjb21tYW5kJiMzOTs6ICYj
Mzk7Z3Vlc3QtbmV0d29yay1nZXQtcm91dGUmIzM5Oyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgJiMz
OTtyZXR1cm5zJiMzOTs6IFsmIzM5O0d1ZXN0TmV0d29ya1JvdXRlJiMzOTtdPGJyPg0KJmd0O8Kg
IMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqAtLSA8YnI+DQomZ3Q7wqAgwqAgwqAyLjQwLjE8YnI+
DQomZ3Q7IDxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--00000000000043cdd9061d95e3c2--


