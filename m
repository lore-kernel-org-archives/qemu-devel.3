Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF60C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwLM-0000K0-Qc; Mon, 20 Jan 2025 13:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwLL-0000Jm-Bd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:17:47 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tZwLJ-00056F-Dh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:17:47 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MDeAZ-1thOrp0sDf-005kyR; Mon, 20 Jan 2025 19:17:42 +0100
Message-ID: <5d94702a-acdc-411d-8af1-a41a62b3caa4@vivier.eu>
Date: Mon, 20 Jan 2025 19:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] linux-user: netlink: Add emulation of
 IP_MULTICAST_IF
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
References: <20250119044122.9637-1-deller@kernel.org>
 <20250119044122.9637-5-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250119044122.9637-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t4f2JWkLOZC0U25gealj5KV+zpLjbXExwqwCyRxOU7jfld3tOYh
 s5b1Gc+97xNeGSml/+5ww+kOGJ+rfxq8zTUCNjfI/baNK4VJcOQJFpXvsjwpSOriogCVO8r
 FP6AuDAiKV56A5uTdp0WoR+9wiFlKOcbPuXGqi2H62zZeBsjCC5GhFZ5hC0Rt2Dd+7ALRUE
 auW6VTib2EcW1uKMrd29g==
UI-OutboundReport: notjunk:1;M01:P0:IasWuPeuz00=;i4Ub1KaRkQFRqdhvqMsht8LThX2
 hUzsBcrkPKU9HORic+fyqV8AwdJ20HZJcMOLkZWi9uKrKzKkEpF0/7qpZ2rlxz2LKtXFxuC/4
 WGqfvngQibMwpNUq5KiHEwzqtXFD+mpXPvQ4g54CPPffcUBLjXWSYL/0RrxJ9i/xtHFuq4jzQ
 6Gx8E1o8LAbP0iiM3qcx07kgdl+p5vHymA9ttv1uT87A5vUtk3AijdmBsFEhjJD+F1cagXpXx
 y/9Oyvxekl0vshIbvuICL9Fi5QcLBQqlvi8QdrN4/YuK0i4SNyTfXQATcou9a6MXf9JwpgExd
 9QCbwjWspm8nIzqXDleXlD72z8kycAUL+0XosBdAvvgWBnhX7atoaoGa7E+2e5L603wax3IaZ
 iI84gwQ/j2xORSkFANPUK4iKxbtQwunjXa7pO1ow73FeEFOtPcGcL3xWFfWZ9YNzAZ2IUUFBQ
 DuB5QcAwVJcI9yyPQ6pNHZRrOEsBm7mh2RF3GikTOxy+QwQxVZKXKdENpJhrq2xPl+anSdFif
 HOYVDhkNjUJ0+uWGboKnYaoFz863MJTCb31mqyMY5HJX+J5NztV8q7n9aebM9icae0c4FCiUC
 Zxj7v/ZLSIMQFKB1fLoeUM48rgnNuT8AZLp0k/E/30jjn420Jq2oP6/YqWz389ZxlI9xpOmS1
 +Z/msc0+yKbhEGJZYDzJBUs/ySKrBAY0fa9aMDoNYjWsVX6Do1Pv8+SPnl0yIEoWVpEVBcVK9
 5KiVByg7yTC3zhlB48Y1yDFbPze5rp/+xepy+xQqIvp6WA/GIBgk2tvkw4ItifuaAeIpZXQSr
 Hp2OErRiv9D8C0YkS6SH01KAs2iYVqffMYw2NM7hRpqxp/vqY5joqBVasPi6aKNin4OTYi2PH
 FvDLle1NJLQ6wgVG8I11bzB8jCpVk3NqYHBweE7KScY4zWvaddhD+p49JEaDZtLRxGBqtvOW0
 rFMox6z7uWdVFSwEMbqNo4IJJrX6e1lMrG4rSohILfjv9dmPznhmXG8FG2Ktc6OjnsQYnJN1M
 hO5HPq9yCEkQGz4L+ez1lUpMiRLizgQ4ZfP6cpmv4rgav8XCMenbNN6JljrhOUQhcg/+1hXrz
 Sj/IoVywpvfHxz4HM7n3e8FbGqdzv8dVBvLaIPcnCuqiyuAI/9zuac9eEaTix6gVm7g55zqOw
 =
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Le 19/01/2025 à 05:41, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Add IP_MULTICAST_IF and share the code with IP_ADD_MEMBERSHIP / IP_DROP_MEMBERSHIP.
> Sharing the code makes sense, because the manpage of ip(7)  says:
> 
> IP_MULTICAST_IF (since Linux 1.2)
>        Set the local device for a multicast socket.  The argument
>        for setsockopt(2) is an ip_mreqn or (since Linux 3.5)
>        ip_mreq structure similar to IP_ADD_MEMBERSHIP, or an
>        in_addr structure.  (The kernel determines which structure
>        is being passed based on the size passed in optlen.)  For
>        getsockopt(2), the argument is an in_addr structure.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2: (based on feedback by Laurent Vivier)
> - refined commit message and restructure the copying of ip_mreqn fields
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index bbe2560927..4360543e20 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>               }
>               ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
>               break;
> +        case IP_MULTICAST_IF:
>           case IP_ADD_MEMBERSHIP:
>           case IP_DROP_MEMBERSHIP:
>           {
>               struct ip_mreqn ip_mreq;
>               struct target_ip_mreqn *target_smreqn;
> +            int min_size;
> 
>               QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
>                                 sizeof(struct target_ip_mreq));
> 
> -            if (optlen < sizeof (struct target_ip_mreq) ||
> +            if (optname == IP_MULTICAST_IF) {
> +                min_size = sizeof(struct in_addr);
> +            } else {
> +                min_size = sizeof(struct target_ip_mreq);
> +            }
> +            if (optlen < min_size ||
>                   optlen > sizeof (struct target_ip_mreqn)) {
>                   return -TARGET_EINVAL;
>               }
> @@ -2149,7 +2156,9 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                   return -TARGET_EFAULT;
>               }
>               ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
> -            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> +            if (optlen >= sizeof(struct target_ip_mreq)) {
> +                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> +            }
>               if (optlen == sizeof(struct target_ip_mreqn)) {
>                   ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
>                   optlen = sizeof(struct ip_mreqn);

This part above seems to be in the commit message... and is the version 2, is this what you want?

> ---
>   linux-user/syscall.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index df8609b4d8..6ee02383da 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>               }
>               ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
>               break;
> +        case IP_MULTICAST_IF:
>           case IP_ADD_MEMBERSHIP:
>           case IP_DROP_MEMBERSHIP:
>           {
>               struct ip_mreqn ip_mreq;
>               struct target_ip_mreqn *target_smreqn;
> +            int min_size;
>   
>               QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
>                                 sizeof(struct target_ip_mreq));
>   
> -            if (optlen < sizeof (struct target_ip_mreq) ||
> +            if (optname == IP_MULTICAST_IF) {
> +                min_size = sizeof(struct in_addr);
> +            } else {
> +                min_size = sizeof(struct target_ip_mreq);
> +            }
> +            if (optlen < min_size ||
>                   optlen > sizeof (struct target_ip_mreqn)) {
>                   return -TARGET_EINVAL;
>               }
> @@ -2149,13 +2156,14 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                   return -TARGET_EFAULT;
>               }
>               ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
> -            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> -            if (optlen == sizeof(struct target_ip_mreqn)) {
> -                ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
> -                optlen = sizeof(struct ip_mreqn);
> +            if (optlen >= sizeof(struct target_ip_mreq)) {
> +                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
> +                if (optlen >= sizeof(struct target_ip_mreqn)) {
> +                    __put_user(target_smreqn->imr_ifindex, &ip_mreq.imr_ifindex);
> +                    optlen = sizeof(struct ip_mreqn);
> +                }
>               }
>               unlock_user(target_smreqn, optval_addr, 0);
> -
>               ret = get_errno(setsockopt(sockfd, level, optname, &ip_mreq, optlen));
>               break;
>           }

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

