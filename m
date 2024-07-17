Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66323C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU5AZ-0007E2-J4; Wed, 17 Jul 2024 09:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU5AT-00077V-LI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:58:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU5AR-0007ep-25
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:58:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso45194955e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721224671; x=1721829471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mqogU8R4miles1lAIf6h19VMVK55OmT2QvTS6R2WlE=;
 b=e83HVpkOVVDQzdZ30/wwbbaLHI+Xj/fbQEBs5dRHWE+AXNYhagpewJcbLc71WKgBXI
 Y/3t3zkNss1eRaHpB02wLNcOQBGIxjCfdRzXvg3djEAad+918tXjyJCXL29viT4TSEoK
 LeizQcwCo+/O1gSffGcG+V07HuJrlqO0EhntwEheKK/BgDKJHUm2z8rJ/v6pjc6r0nJM
 XyC9G/PlH/8De3q4DQHmIUu6z0uI5iYCYwmLqTCylwnw+skmEuqD+AAGicbmn7TvbfLg
 q5+jRI2W4PG1CImoNaGT5jKrj/+kjkJo90AopApITkp/50g6EGK6V4oKudOvqodfkA4V
 wqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224671; x=1721829471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mqogU8R4miles1lAIf6h19VMVK55OmT2QvTS6R2WlE=;
 b=Joh4ekefR8z0pjgLKqloIseEAq0KB1Ks+j+tOqy5gbvQKRGqTPstQ+rjiTGxMBPyUq
 S+84TFTO7mVzTGnAv47ZLKSCCK7VeqbzS64ZG4W89SAe5KXdrfh9YF4kaPOmQJ+NtK0C
 9wdP4+/htl4UouVYf5S0mDFTIkYEyQPmG+BG2gVOrUjm++G1bE7+fTi7lTc26ktnJ9BR
 CQ+iinZpLrgUu0XVScSx/Kx6RSuFTsrKX3z7IqD2ZtNiZp1ouW+SzJGiPKqJgZbJhIR6
 GCFzUsl/PEgrPuDFDBlNgkyOWgCm3kStgi9WScvFIne8+jMlnnGJGL3MGiE6t1AyXzyj
 GrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWypaWpEwXkmhGTbBwaa1Cp6M5b9/zhGyyojlgk7r8HiskmcuSLE6nrt0rvcqq8yLX3jwLaVF6D1Hv/FSz06ULWHOd5Bug=
X-Gm-Message-State: AOJu0YzFBzCGLAGFmdTOIMJ3N1fdiYgYQdebjupNMTpbOm62A7tTQ/Px
 3wDufCmlFWtZd4aGmx6PNzvHgG+HiG+70gkCGOdIFoIfJYG3V25DlN6TBdOn1nN53m7ffMcYnmg
 EKuPVtw==
X-Google-Smtp-Source: AGHT+IEr9GjhLoZ+nzcGTMX73rz0dN+wErNlhgh6dvCzmvzD5GpRm6uxdddbxHT76HF4DFgqjwDZXg==
X-Received: by 2002:a05:600c:45d2:b0:426:6241:5eb9 with SMTP id
 5b1f17b1804b1-427c2d00746mr12119385e9.39.1721224670949; 
 Wed, 17 Jul 2024 06:57:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc27asm208666885e9.34.2024.07.17.06.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:57:50 -0700 (PDT)
Message-ID: <5830d5f2-447d-4c41-a93c-639dd40be474@linaro.org>
Date: Wed, 17 Jul 2024 15:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Cc: Dehan Meng <demeng@redhat.com>, michael.roth@amd.com,
 Daniel Berrange <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240613092802.346246-1-demeng@redhat.com>
 <20240613092802.346246-2-demeng@redhat.com>
 <CAPMcbCroa=8mu2g1V80BWpaVNYsbdJ6M0c4EWJxzWiZBg-ozLw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCroa=8mu2g1V80BWpaVNYsbdJ6M0c4EWJxzWiZBg-ozLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 13/6/24 13:18, Konstantin Kostiuk wrote:
> CC: Daniel, Philippe

Having a quick look, no major issue noticed.

Cc'ing Markus/Eric for QAPI schema.

BTW MAINTAINERS likely missing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..af4db698de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3217,10 +3217,11 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
  QAPI Schema
  M: Eric Blake <eblake@redhat.com>
  M: Markus Armbruster <armbru@redhat.com>
  S: Supported
  F: qapi/*.json
+F: qga/qapi-schema.json
  T: git https://repo.or.cz/qemu/armbru.git qapi-next

---

> 
> On Thu, Jun 13, 2024 at 12:28 PM Dehan Meng <demeng@redhat.com 
> <mailto:demeng@redhat.com>> wrote:
> 
>     The Route information of the Linux VM needs to be used
>     by administrators and users when debugging network problems
>     and troubleshooting.
> 
>     Signed-off-by: Dehan Meng <demeng@redhat.com <mailto:demeng@redhat.com>>
>     ---
>       qga/commands-posix.c | 135 +++++++++++++++++++++++++++++++++++++++++++
>       qga/commands-win32.c |   6 ++
>       qga/qapi-schema.json |  71 +++++++++++++++++++++++
>       3 files changed, 212 insertions(+)
> 
>     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>     index 7f05996495..b85b3937bf 100644
>     --- a/qga/commands-posix.c
>     +++ b/qga/commands-posix.c
>     @@ -2708,6 +2708,135 @@ GuestCpuStatsList
>     *qmp_guest_get_cpustats(Error **errp)
>           return head;
>       }
> 
>     +static char *hexToIPAddress(const void *hexValue, int is_ipv6)
>     +{
>     +    if (is_ipv6) {
>     +        char addr[INET6_ADDRSTRLEN];
>     +        struct in6_addr in6;
>     +        const char *hexStr = (const char *)hexValue;
>     +        int i;
>     +
>     +        for (i = 0; i < 16; i++) {
>     +            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
>     +        }
>     +        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
>     +
>     +        return g_strdup(addr);
>     +    } else {
>     +        unsigned int hexInt = *(unsigned int *)hexValue;
>     +        unsigned int byte1 = (hexInt >> 24) & 0xFF;
>     +        unsigned int byte2 = (hexInt >> 16) & 0xFF;
>     +        unsigned int byte3 = (hexInt >> 8) & 0xFF;
>     +        unsigned int byte4 = hexInt & 0xFF;
>     +
>     +        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2,
>     byte1);
>     +    }
>     +}
>     +
>     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>     +{
>     +    GuestNetworkRouteList *head = NULL, **tail = &head;
>     +    const char *routeFiles[] = {"/proc/net/route",
>     "/proc/net/ipv6_route"};
>     +    FILE *fp;
>     +    size_t n;
>     +    char *line = NULL;
>     +    int firstLine;
>     +    int is_ipv6;
>     +    int i;
>     +
>     +    for (i = 0; i < 2; i++) {
>     +        firstLine = 1;
>     +        is_ipv6 = (i == 1);
>     +        fp = fopen(routeFiles[i], "r");
>     +        if (fp == NULL) {
>     +            error_setg_errno(errp, errno, "open(\"%s\")",
>     routeFiles[i]);
>     +            free(line);
>     +            continue;
>     +        }
>     +
>     +        while (getline(&line, &n, fp) != -1) {
>     +            if (firstLine && !is_ipv6) {
>     +                firstLine = 0;
>     +                continue;
>     +            }
>     +            GuestNetworkRoute *route = NULL;
>     +            GuestNetworkRoute *networkroute;
>     +            char Iface[IFNAMSIZ];
>     +            if (is_ipv6) {
>     +                char Destination[33], Source[33], NextHop[33];
>     +                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt,
>     Use, Flags;
>     +
>     +                /* Parse the line and extract the values */
>     +                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x
>     %32s",
>     +                           Destination, &DesPrefixlen, Source,
>     +                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
>     +                           &Use, &Flags, Iface) != 10) {
>     +                    continue;
>     +                }
>     +
>     +                route = g_new0(GuestNetworkRoute, 1);
>     +                networkroute = route;
>     +                networkroute->iface = g_strdup(Iface);
>     +                networkroute->destination =
>     hexToIPAddress(Destination, 1);
>     +                networkroute->metric = Metric;
>     +                networkroute->source = hexToIPAddress(Source, 1);
>     +                networkroute->desprefixlen = g_strdup_printf(
>     +                    "%d", DesPrefixlen
>     +                );
>     +                networkroute->srcprefixlen = g_strdup_printf(
>     +                    "%d", SrcPrefixlen
>     +                );
>     +                networkroute->nexthop = hexToIPAddress(NextHop, 1);
>     +                networkroute->has_flags = true;
>     +                networkroute->flags = Flags;
>     +                networkroute->has_refcnt = true;
>     +                networkroute->refcnt = RefCnt;
>     +                networkroute->has_use = true;
>     +                networkroute->use = Use;
>     +                networkroute->version = 6;
>     +            } else {
>     +                unsigned int Destination, Gateway, Mask, Flags;
>     +                int RefCnt, Use, Metric, MTU, Window, IRTT;
>     +
>     +                /* Parse the line and extract the values */
>     +                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
>     +                           Iface, &Destination, &Gateway, &Flags,
>     &RefCnt,
>     +                           &Use, &Metric, &Mask, &MTU, &Window,
>     &IRTT) != 11) {
>     +                    continue;
>     +                }
>     +
>     +                route = g_new0(GuestNetworkRoute, 1);
>     +                networkroute = route;
>     +                networkroute->iface = g_strdup(Iface);
>     +                networkroute->destination =
>     hexToIPAddress(&Destination, 0);
>     +                networkroute->gateway = hexToIPAddress(&Gateway, 0);
>     +                networkroute->mask = hexToIPAddress(&Mask, 0);
>     +                networkroute->metric = Metric;
>     +                networkroute->has_flags = true;
>     +                networkroute->flags = Flags;
>     +                networkroute->has_refcnt = true;
>     +                networkroute->refcnt = RefCnt;
>     +                networkroute->has_use = true;
>     +                networkroute->use = Use;
>     +                networkroute->has_mtu = true;
>     +                networkroute->mtu = MTU;
>     +                networkroute->has_window = true;
>     +                networkroute->window = Window;
>     +                networkroute->has_irtt = true;
>     +                networkroute->irtt = IRTT;
>     +                networkroute->version = 4;
>     +            }
>     +
>     +            QAPI_LIST_APPEND(tail, route);
>     +        }
>     +
>     +        free(line);
>     +        fclose(fp);
>     +    }
>     +
>     +    return head;
>     +}
>     +
>       #else /* defined(__linux__) */
> 
>       void qmp_guest_suspend_disk(Error **errp)
>     @@ -3079,6 +3208,12 @@ GuestCpuStatsList
>     *qmp_guest_get_cpustats(Error **errp)
>           return NULL;
>       }
> 
>     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>     +{
>     +    error_setg(errp, QERR_UNSUPPORTED);
>     +    return NULL;
>     +}
>     +
>       #endif /* CONFIG_FSFREEZE */
> 
>       #if !defined(CONFIG_FSTRIM)
>     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>     index 0d1b836e87..91289bc9ab 100644
>     --- a/qga/commands-win32.c
>     +++ b/qga/commands-win32.c
>     @@ -2517,3 +2517,9 @@ GuestCpuStatsList
>     *qmp_guest_get_cpustats(Error **errp)
>           error_setg(errp, QERR_UNSUPPORTED);
>           return NULL;
>       }
>     +
>     +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>     +{
>     +    error_setg(errp, QERR_UNSUPPORTED);
>     +    return NULL;
>     +}
>     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>     index b3de1fb6b3..1c2ee9f3c6 100644
>     --- a/qga/qapi-schema.json
>     +++ b/qga/qapi-schema.json
>     @@ -1800,3 +1800,74 @@
>       { 'command': 'guest-get-cpustats',
>         'returns': ['GuestCpuStats']
>       }
>     +
>     +##
>     +# @GuestNetworkRoute:
>     +#
>     +# Route information, currently, only linux supported.
>     +#
>     +# @iface: The destination network or host's egress network
>     interface in the routing table
>     +#
>     +# @destination: The IP address of the target network or host, The
>     final destination of the packet
>     +#
>     +# @metric: Route metric
>     +#
>     +# @gateway: The IP address of the next hop router
>     +#
>     +# @mask: Subnet Mask (IPv4 only)
>     +#
>     +# @irtt: Initial round-trip delay (not for windows, IPv4 only)
>     +#
>     +# @flags: Route flags (not for windows)
>     +#
>     +# @refcnt: The route's reference count (not for windows)
>     +#
>     +# @use: Route usage count (not for windows)
>     +#
>     +# @window: TCP window size, used for flow control (not for windows,
>     IPv4 only)
>     +#
>     +# @mtu: Data link layer maximum packet size (not for windows)
>     +#
>     +# @desprefixlen: Destination prefix length (for IPv6)
>     +#
>     +# @source: Source IP address (for IPv6)
>     +#
>     +# @srcprefixlen: Source prefix length (for IPv6)
>     +#
>     +# @nexthop: Next hop IP address (for IPv6)
>     +#
>     +# @version: IP version (4 or 6)
>     +#
>     +# Since: 9.1
>     +
>     +##
>     +{ 'struct': 'GuestNetworkRoute',
>     +  'data': {'iface': 'str',
>     +           'destination': 'str',
>     +           'metric': 'int',
>     +           '*gateway': 'str',
>     +           '*mask': 'str',
>     +           '*irtt': 'int',
>     +           '*flags': 'uint64',
>     +           '*refcnt': 'int',
>     +           '*use': 'int',
>     +           '*window': 'int',
>     +           '*mtu': 'int',
>     +           '*desprefixlen': 'str',
>     +           '*source': 'str',
>     +           '*srcprefixlen': 'str',
>     +           '*nexthop': 'str',
>     +           'version': 'int'
>     +           }}
>     +
>     +##
>     +# @guest-network-get-route:
>     +#
>     +# Retrieve information about route of network.
>     +# Returns: List of route info of guest.
>     +#
>     +# Since: 9.1
>     +##
>     +{ 'command': 'guest-network-get-route',
>     +  'returns': ['GuestNetworkRoute']
>     +}
>     -- 
>     2.40.1
> 


