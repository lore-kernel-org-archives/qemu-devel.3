Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B1CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHrx-0007CD-Tb; Fri, 10 Jan 2025 11:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWHrq-0007BY-8D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:28:14 -0500
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWHrn-0007q5-1E
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:28:14 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M3lLh-1tWYqc2LRr-004gJa; Fri, 10 Jan 2025 17:28:05 +0100
Message-ID: <73c3efe6-d8d0-4504-b474-b2328c6817ce@vivier.eu>
Date: Fri, 10 Jan 2025 17:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] linux-user: netlink: add netlink neighbour
 emulation
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
References: <20241227205449.29311-1-deller@kernel.org>
 <20241227205449.29311-6-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241227205449.29311-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/au0VKIF+nCwxRYTTIFAqPE5dna/YD0PYyelAamnTnS8UoVAJKS
 NgAA9kXzneU3TPVkeRB1+d+0NhP6f5eU6aify/CHxSbY0hHzW71mBdhWr2/NWE3yaWQRCiN
 pj880/d7iwqdT4nSziinyc36Hpy48V3WIAKtRtnTqGrlZb+VPTAg8lcAPcrYhmYJYWsz9SG
 oCbuEOeRrNrT1CpuawAJA==
UI-OutboundReport: notjunk:1;M01:P0:J8mXuXd38ig=;YbShQAC30IUcYIlhHtpXz/It1wV
 VCsflraOyhCukQuM3UnVwRYR8hPV2IAS9rw5hev0/oIPx75HFZQFjWxSvB8FYB/rbM9BR8Cl+
 yk04s1BSkQePsUIk50iRK/YIxTIOMXCKsAsDAn+s93VX6cQ7MnvpYRSGoZ8dzcubZZzgP4DON
 uLwvzvU5M/5cqx/H4grvIpTjvb4WBDWsa3TOPyiID4mm1yJIpTyLaukYqfAotwORMMTOvXGzX
 5K3/w/4FUflU5RbzURmhU3B1sRBbCCu56E+ccqk8qMsKnVGYfVHEJcSNdfwWxsFT/UdYYD1+u
 4EVrkG2BpxsD4F+ATePbIDqFhYDgPPpZq4d6LF6G4kV3rDgmunxX741GEPDcrFaGdzd09lNiN
 ogFKQ+KAiNtf6xg3trRA42mdliNWAFNvrjPUpML/Bc+YpkFLLXk3W8UxwpVbphOHHH1nIkOu0
 ctgeQg709Wm1uWehIeWY6fprzL8ELGV72dLpBqMH9qvW63fR0VAO2BRHFTYJDWNuNA9kjPnHw
 Ec2ZtvFz949R+vRQAk5pjSJUImGoa0HorB4776+VOBiIAcIbQCd5AHusFuzwLMXj4lZOvmnlq
 6Rgi1ihS6NBmfIbVI7ZX0oxQ3c8Xc2tmxFvSNrBgDxuH+z8I245QP51UhbRUWehZgIxazO/PG
 0yeZJbkX4okRUeYrw42jMJkihPAEfE43wLhspbEjS9iXH4KDbw9SRdEi/qHQVIkIO2vwrBpbF
 CrnTXgIyE7N/8a8XrRea95LyjQ12Q7j1edYYZR2IdOU4s3kUXGbs19SBhnLvTJwuTkSxqCgOt
 FzI3zmsKjOzeRmT7zSIvTI6s5sf/zMVAP+ZTZsWr2w7WIj+Bg/1/L6EgIOWIQ1CxFg1Ibts/J
 K/b5SMHva6fVmKK4MiI0S5qpyDmAdrqG0DEP4bied5q2F7IitKwc+lo4vS9XU5yjmZUgfn2uy
 D0QtJQCHoc5NsTu6EuklRoc3r2AiSoq2tPUD37t5g2uPRdOMtjCoURrmcRs3ptR6XkhwZP+Ik
 74cXnNSyPDhZdf+UCzvweHybbkom9N1wp+YNDdU
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Le 27/12/2024 à 21:54, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Fixes various warnings in the testsuite while building gupnp:
>   gssdp-net-DEBUG: Failed to send netlink message: Operation not supported
>   gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: 127.0.0.1)
>   gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
>   gupnp-context-DEBUG: Mismatch between host header and host IP (192.168.1.2, expected: 127.0.0.1)
>   gupnp-context-DEBUG: Mismatch between host header and host IP (fe80::01, expected: 127.0.0.1)
>   gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
>   gupnp-context-DEBUG: Failed to parse HOST header from request: Invalid IPv6 address ?[fe80::01%1]? in URI
>   gupnp-context-DEBUG: Failed to parse HOST header from request: Invalid IPv6 address ?[fe80::01%eth0]? in URI
>   gupnp-context-DEBUG: Failed to parse HOST header from request: Could not parse port ?:1? in URI
>   gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)
>   gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
>   gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)
>   gupnp-context-DEBUG: Mismatch between host header and host port (80, expected 4711)
>   gupnp-context-DEBUG: Mismatch between host header and host IP (example.com, expected: ::1)
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/fd-trans.c | 100 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index a86ed2f4b4..a5e6c6b6f2 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -25,12 +25,16 @@
>   #ifdef CONFIG_RTNETLINK
>   #include <linux/rtnetlink.h>
>   #include <linux/if_bridge.h>
> +#include <linux/neighbour.h>
>   #endif
>   #include "qemu.h"
>   #include "user-internals.h"
>   #include "fd-trans.h"
>   #include "signal-common.h"
>   
> +#define NDM_RTA(r)  ((struct rtattr*)(((char*)(r)) + \
> +                    NLMSG_ALIGN(sizeof(struct ndmsg))))
> +
>   enum {
>       QEMU_IFLA_BR_UNSPEC,
>       QEMU_IFLA_BR_FORWARD_DELAY,
> @@ -1210,6 +1214,35 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
>       return 0;
>   }
>   
> +static abi_long host_to_target_data_neigh_rtattr(struct rtattr *rtattr)
> +{
> +    struct nda_cacheinfo *ndac;
> +    uint32_t *u32;
> +
> +    switch (rtattr->rta_type) {
> +    case NDA_UNSPEC:
> +    case NDA_DST:
> +    case NDA_LLADDR:
> +        break;
> +    case NDA_PROBES:
> +        u32 = RTA_DATA(rtattr);
> +        *u32 = tswap32(*u32);
> +        break;
> +    case NDA_CACHEINFO:
> +        ndac = RTA_DATA(rtattr);
> +        ndac->ndm_confirmed = tswap32(ndac->ndm_confirmed);
> +        ndac->ndm_used      = tswap32(ndac->ndm_used);
> +        ndac->ndm_updated   = tswap32(ndac->ndm_updated);
> +        ndac->ndm_refcnt    = tswap32(ndac->ndm_refcnt);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unknown host to target NEIGH type: %d\n",
> +                      rtattr->rta_type);
> +        break;
> +    }
> +    return 0;
> +}
> +
>   static abi_long host_to_target_link_rtattr(struct rtattr *rtattr,
>                                            uint32_t rtattr_len)
>   {
> @@ -1231,12 +1264,20 @@ static abi_long host_to_target_route_rtattr(struct rtattr *rtattr,
>                                             host_to_target_data_route_rtattr);
>   }
>   
> +static abi_long host_to_target_neigh_rtattr(struct rtattr *rtattr,
> +                                         uint32_t rtattr_len)
> +{
> +    return host_to_target_for_each_rtattr(rtattr, rtattr_len,
> +                                          host_to_target_data_neigh_rtattr);
> +}
> +
>   static abi_long host_to_target_data_route(struct nlmsghdr *nlh)
>   {
>       uint32_t nlmsg_len;
>       struct ifinfomsg *ifi;
>       struct ifaddrmsg *ifa;
>       struct rtmsg *rtm;
> +    struct ndmsg *ndm;
>   
>       nlmsg_len = nlh->nlmsg_len;
>       switch (nlh->nlmsg_type) {
> @@ -1263,6 +1304,17 @@ static abi_long host_to_target_data_route(struct nlmsghdr *nlh)
>                                          nlmsg_len - NLMSG_LENGTH(sizeof(*ifa)));
>           }
>           break;
> +    case RTM_NEWNEIGH:
> +    case RTM_DELNEIGH:
> +    case RTM_GETNEIGH:
> +        if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ndm))) {
> +            ndm = NLMSG_DATA(nlh);
> +            ndm->ndm_ifindex = tswap32(ndm->ndm_ifindex);
> +            ndm->ndm_state = tswap16(ndm->ndm_state);
> +            host_to_target_neigh_rtattr(NDM_RTA(ndm),
> +                                    nlmsg_len - NLMSG_LENGTH(sizeof(*ndm)));
> +        }
> +        break;
>       case RTM_NEWROUTE:
>       case RTM_DELROUTE:
>       case RTM_GETROUTE:
> @@ -1410,6 +1462,35 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
>       return 0;
>   }
>   
> +static abi_long target_to_host_data_neigh_rtattr(struct rtattr *rtattr)
> +{
> +    struct nda_cacheinfo *ndac;
> +    uint32_t *u32;
> +
> +    switch (rtattr->rta_type) {
> +    case NDA_UNSPEC:
> +    case NDA_DST:
> +    case NDA_LLADDR:
> +        break;
> +    case NDA_PROBES:
> +        u32 = RTA_DATA(rtattr);
> +        *u32 = tswap32(*u32);
> +        break;
> +    case NDA_CACHEINFO:
> +        ndac = RTA_DATA(rtattr);
> +        ndac->ndm_confirmed = tswap32(ndac->ndm_confirmed);
> +        ndac->ndm_used      = tswap32(ndac->ndm_used);
> +        ndac->ndm_updated   = tswap32(ndac->ndm_updated);
> +        ndac->ndm_refcnt    = tswap32(ndac->ndm_refcnt);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unknown target NEIGH type: %d\n",
> +                      rtattr->rta_type);
> +        break;
> +    }
> +    return 0;
> +}
> +
>   static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
>   {
>       uint32_t *u32;
> @@ -1448,6 +1529,13 @@ static void target_to_host_addr_rtattr(struct rtattr *rtattr,
>                                      target_to_host_data_addr_rtattr);
>   }
>   
> +static void target_to_host_neigh_rtattr(struct rtattr *rtattr,
> +                                     uint32_t rtattr_len)
> +{
> +    target_to_host_for_each_rtattr(rtattr, rtattr_len,
> +                                   target_to_host_data_neigh_rtattr);
> +}
> +
>   static void target_to_host_route_rtattr(struct rtattr *rtattr,
>                                        uint32_t rtattr_len)
>   {
> @@ -1460,6 +1548,7 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
>       struct ifinfomsg *ifi;
>       struct ifaddrmsg *ifa;
>       struct rtmsg *rtm;
> +    struct ndmsg *ndm;
>   
>       switch (nlh->nlmsg_type) {
>       case RTM_NEWLINK:
> @@ -1486,6 +1575,17 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
>                                          NLMSG_LENGTH(sizeof(*ifa)));
>           }
>           break;
> +    case RTM_NEWNEIGH:
> +    case RTM_DELNEIGH:
> +    case RTM_GETNEIGH:
> +        if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ndm))) {
> +            ndm = NLMSG_DATA(nlh);
> +            ndm->ndm_ifindex = tswap32(ndm->ndm_ifindex);
> +            ndm->ndm_state = tswap16(ndm->ndm_state);
> +            target_to_host_neigh_rtattr(NDM_RTA(ndm), nlh->nlmsg_len -
> +                                       NLMSG_LENGTH(sizeof(*ndm)));
> +        }
> +        break;
>       case RTM_NEWROUTE:
>       case RTM_DELROUTE:
>       case RTM_GETROUTE:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

