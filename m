Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF8BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWH8C-0007Gd-9G; Fri, 10 Jan 2025 10:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWH88-0007FJ-7Z
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:41:00 -0500
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWH86-0007H0-Ai
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:40:59 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUooJ-1twQrb1iyn-00IeYc; Fri, 10 Jan 2025 16:40:50 +0100
Message-ID: <3d5800c5-e5ed-487e-8961-aff914d17582@vivier.eu>
Date: Fri, 10 Jan 2025 16:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] linux-user: netlink: Add missing QEMU_IFLA entries
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
References: <20241227205449.29311-1-deller@kernel.org>
 <20241227205449.29311-7-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241227205449.29311-7-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e9xV/2rqe6xyVJozatlp0vEXAHKgWCRYOdJC2F8iL/hOQNcTqVT
 cicg6olhLd2HVUfjoyLNygKDI1fVpYMBZhGxjJqjdiZmfIjCBifotdn6krWbO0Jj6ubPd1U
 ZyAxlrHhHm6bH3PAdphSDvoLzH6QW/htWPHB/Nx2zrcTvLjvUfV8lvubX7cZLGNOTVtAp4W
 SuRlzvUBZ7lqSgQucZblw==
UI-OutboundReport: notjunk:1;M01:P0:72eDTDwgnxk=;R0qM1Pe937gjHPhmUWmZmXC5PSt
 AZMsfoVdxdSSWfFCve1KezwKYYjQFuuU8y6IGViKsUQ3d1SoY0F6/i6PLhYSLgcypT6y9uFs0
 7JnYY9iUwKr5rK4T6YwHmy4U81dOuHR1hNF5fNQ20ApgjiQ8CSEJ8tywD2ubartPI5bnrsnwO
 DEwiWX7lpcDAPexqhtWMfwVgr6UTgIbsSkJkiEVxwBHjM/XejbjAuQCGtZPPDQjF9Ns+syaBF
 FBd/fawMUR81K619ZpU7UUlNbm+VUAFTE5YN0LQnyeBYDeBqSvvRg1V6LF2Qyu8jz8sseyDJF
 TZgh42is1+p7Xz/jDqk5jZk/7CZ2LiUO+j42DMtbh017ASvJKoeSqtiNQF4WpdkKFSUS/4a+l
 tfBw2lC/Y+JjNaoyYfInhCkIvnyNHIex2af2kuYYIFygVvAPCGSgMtgiNMsjF3NLWK9IUVdN3
 mmzRcXMoNZi4MZFH7RLyaHztH7fUJaHLjeBBbAPg9c18RHiJDssARP5mGl9vGdXE/njtP05nz
 N/BI0/Oq6xInN7zK/TTQLEMfiKvAkB5Mln7x77Mti6vWP98k8BqZp6e01pBK00mt7FcwsLNiv
 7izUBSoeeDowSbp6Kl+ZPNVHpCB9ciUFs5SG9SU3720p6FUC4oZBlWqjWFSY3ootNe/Rab+c4
 4ZRkLYYW6kuAK4R9wEIrtdG6rxfCwv9Qoey9wcpJDAuc5udgJgZ3GcG1WDjFShlb3Ps8jBWHI
 47+BBO/N4a2IxM6HEeHsd+eNn6Pa7QwXobABshr9pbRJ/k7/euPwdKMuSaaKvpYAHTI6GIJmB
 NsTwXugl7IMIHIOVzcXtyZm6SKFx5UFXGyqb/q8jGXOFIcKnIuYghhdUz/CKCe4syNXE6YUGn
 AAclTGm38zIlWCHlImhg1vH+oK7yNExml7Tp0ytaxXwoZ8HT7lt1ymmQx3paiT/OKhd2I43bR
 knSYMBFJZVHSD//xV55lyJpVTsa4ZfvzvNAS4R5xqw9oriaqcz0ASAjmXG2fadt2fS+NPhQq+
 7PMf1+GA5j18XZBwgGEjJrRqh6qVhu9gMswf8aU
Received-SPF: pass client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> This fixes the following qemu warnings when building debian gupnp package:
>   Unknown host QEMU_IFLA type: 61
>   Unknown host QEMU_IFLA type: 58
>   Unknown host QEMU_IFLA type: 59
>   Unknown host QEMU_IFLA type: 60
>   Unknown host QEMU_IFLA type: 32820
> 
> QEMU_IFLA type 32820 is actually NLA_NESTED | QEMU_IFLA_PROP_LIST (a nested
> entry), which is why rta_type needs to be masked with NLA_TYPE_MASK.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/fd-trans.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index a5e6c6b6f2..6a8775bb55 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -145,6 +145,14 @@ enum {
>       QEMU_IFLA_PROTO_DOWN_REASON,
>       QEMU_IFLA_PARENT_DEV_NAME,
>       QEMU_IFLA_PARENT_DEV_BUS_NAME,
> +    QEMU_IFLA_GRO_MAX_SIZE,
> +    QEMU_IFLA_TSO_MAX_SIZE,
> +    QEMU_IFLA_TSO_MAX_SEGS,
> +    QEMU_IFLA_ALLMULTI,
> +    QEMU_IFLA_DEVLINK_PORT,
> +    QEMU_IFLA_GSO_IPV4_MAX_SIZE,
> +    QEMU_IFLA_GRO_IPV4_MAX_SIZE,
> +    QEMU_IFLA_DPLL_PIN,
>       QEMU___IFLA_MAX
>   };
>   
> @@ -986,6 +994,22 @@ static abi_long host_to_target_data_vfinfo_nlattr(struct nlattr *nlattr,
>       return 0;
>   }
>   
> +static abi_long host_to_target_data_prop_nlattr(struct nlattr *nlattr,
> +                                                void *context)
> +{
> +    switch (nlattr->nla_type) {
> +    /* string */
> +    case QEMU_IFLA_ALT_IFNAME:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unknown host PROP type: %d\n",
> +                      nlattr->nla_type);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +
>   static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>   {
>       uint32_t *u32;
> @@ -994,7 +1018,7 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>       struct rtnl_link_ifmap *map;
>       struct linkinfo_context li_context;
>   
> -    switch (rtattr->rta_type) {
> +    switch (rtattr->rta_type & NLA_TYPE_MASK) {
>       /* binary stream */
>       case QEMU_IFLA_ADDRESS:
>       case QEMU_IFLA_BROADCAST:
> @@ -1032,6 +1056,12 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>       case QEMU_IFLA_CARRIER_DOWN_COUNT:
>       case QEMU_IFLA_MIN_MTU:
>       case QEMU_IFLA_MAX_MTU:
> +    case QEMU_IFLA_GRO_MAX_SIZE:
> +    case QEMU_IFLA_TSO_MAX_SIZE:
> +    case QEMU_IFLA_TSO_MAX_SEGS:
> +    case QEMU_IFLA_ALLMULTI:
> +    case QEMU_IFLA_GSO_IPV4_MAX_SIZE:
> +    case QEMU_IFLA_GRO_IPV4_MAX_SIZE:
>           u32 = RTA_DATA(rtattr);
>           *u32 = tswap32(*u32);
>           break;
> @@ -1127,6 +1157,10 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>           return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
>                                                 NULL,
>                                                host_to_target_data_vfinfo_nlattr);
> +    case QEMU_IFLA_PROP_LIST:
> +        return host_to_target_for_each_nlattr(RTA_DATA(rtattr), rtattr->rta_len,
> +                                              NULL,
> +                                             host_to_target_data_prop_nlattr);
>       default:
>           qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA type: %d\n",
>                         rtattr->rta_type);

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

