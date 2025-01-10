Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5513BE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWF3Y-00011i-Q3; Fri, 10 Jan 2025 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWF3X-00011O-8M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:28:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tWF3V-0006S9-BA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:28:06 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MRBWU-1ttQjd3r2S-00JKkr; Fri, 10 Jan 2025 14:27:54 +0100
Message-ID: <c1bf028f-a6bb-43b8-a72d-756838b15866@vivier.eu>
Date: Fri, 10 Jan 2025 14:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
References: <20241227205449.29311-1-deller@kernel.org>
 <20241227205449.29311-4-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241227205449.29311-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QADQF1ge6Ay/f2l64eoUV+7IAWNoSBDmHKxfFfu0O6sJRBpHfwl
 NHzUmjwxe42FgfpSrhXtPxAoUBDmkQ+OO6JYm+VnZXLJsil+WH3oC64BaYNybsdtLqB5U2J
 RFy5e737W1MFCHt/PqQljmjaHycAB3McquCKI1Wd+xAAFO9ozqwgEuzbWOaf8absRll7r0X
 euPAp4lB9a9MxtCUJgN/g==
UI-OutboundReport: notjunk:1;M01:P0:GUDCZT2dOsk=;wOKqRC7LP7NaEE+GR6GqtJ/ENDu
 61k6mnEuKNNYbtsE8wGocRY5t42kAPDQ29Zytvu0mrtZlzXh41i273ct/uHuMqyuXKePceVtT
 gzKl9xe2w7emFhKxtE3efStNVzFAFiU5I1GxqvPcThUjj4Q74od5g0TQHctbmMPCSWJbHq8FM
 O2jTeDf1cg1nBw3XgAYjKLKz4yDteJVGelic06GOF7eceetq3dA11hCH85D124juqpQiDB1q0
 5cL6EV2lPDI+2pjHIJ50sCD1yKraxqrid4eSpvKBw5aGeG55QLvzY2k2Tc8USwJLIHlyCAo10
 k2w6n4WAz6PTrJPcjUZ1Y7Km3y9DN0q0Gy+rlUl80Kn2O1CZfmktvL5i/evo82wvG+Awx/IOW
 2zgPJr77uTcmrB8T9WwoYP8LYs4urwKzyF3M61Q8X2nnAAAK7VDx8ATldqoQ31MRz0XyDh6gd
 6ksgLWj46EN9K1irw0eozG/ou3eb6YwvvKvHm5WOlti2Vnu2GTir75tt9O10kPFKoWFiF3jw7
 akumdYGnlwB63wMSPZ0CGRqAmZUbvxi1HIKLe8v0a+BboTLt/0RRqC/cdZx9bY1GbDSH5gHQb
 zcTU8YXFrzXpjWVf2f593wCm6EiBQTtHlrPzsq1LkwHqT6/86QJVZwg9of7qLoOiv+s6S4YJp
 /hz9406x5HYcAlvv2b2n2FAbMiiYzqAwXHLvt1V/NikFget0Bd591zcHuHoN6v/iur+z5GSGu
 1yHpPckG/V8dX5zwgpOxIzIcB7nls8vHvDSvAR2KWhUnXNpdbDlaRJ8FKXhTlv7NjVzHfiBlO
 GcOkmrDdXo2E0YegrOLX/9oyy8Bf7dxwAGRioFsBTqtckzpqyNi1TpaZE4wJB6MffGuqc9Cu/
 HMYNVcRajOg9T1sjpS0R5ZHfNpvmscFD3nLQQEfK5yT1WeaRjcErz7JrcxD8iLoJSP1Zev1vi
 fetWA/MEoVhRmzM/mVGPvEFsLhY+jHzsDVMS69HIweKzEI+b/YO0/TanrSWeACFAkFV2AW787
 Colu1WjgJTO//CzeJscTG0s2NDG6/BsJPsE3fna
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
> Fixes those warnings:
>   Unsupported host ancillary data: 0/8
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 494323efba..bbe2560927 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1996,6 +1996,18 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                       (void *) &errh->offender, sizeof(errh->offender));
>                   break;
>               }
> +            case IP_PKTINFO:
> +            {
> +                struct in_pktinfo *pkti = data;
> +                struct in_pktinfo *target_pkti = target_data;

I think we need to define a target_in_pktinfo structure.

> +
> +                __put_user(pkti->ipi_ifindex, &target_pkti->ipi_ifindex);
> +                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_spec_dst,
> +                    (void *) &pkti->ipi_spec_dst, sizeof(pkti->ipi_spec_dst));
> +                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_addr,
> +                    (void *) &pkti->ipi_addr, sizeof(pkti->ipi_addr));

Why do you use host_to_target_sockaddr()? The type of ipi_spec_dst and ipi_addr is in_addr.
And in_addr is a __be32 so it doesn't need be translated from host endianness to target endianness.


> +                break;
> +            }
>               default:
>                   goto unimplemented;
>               }

Thanks,
Laurent

