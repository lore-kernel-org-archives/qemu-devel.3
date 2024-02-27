Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60776C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf07R-0001Rk-JK; Tue, 27 Feb 2024 11:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rf07K-0001LU-R1; Tue, 27 Feb 2024 11:15:46 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rf07H-0005QN-RV; Tue, 27 Feb 2024 11:15:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TkjJH0C7hz4wyf;
 Wed, 28 Feb 2024 03:15:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkjJF0nSyz4wyh;
 Wed, 28 Feb 2024 03:15:24 +1100 (AEDT)
Message-ID: <c084d751-fc21-4e9f-ab28-fc5889b8d9af@kaod.org>
Date: Tue, 27 Feb 2024 17:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ppc/pnv: Fix pervasive topology calculation for P10
Content-Language: en-US, fr
To: Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20240227144844.23606-1-calebs@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240227144844.23606-1-calebs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=hhKj=KE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Caleb,

On 2/27/24 15:48, Caleb Schlossin wrote:
> Pervasive topology(PIR) calculation for core, thread ID was
> wrong for big cores (SMT8). Fixing for P10.
> 
> Based on: <20240123195005.8965-1-calebs@linux.vnet.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Since the initial patch [1] is not merged yet, you can simply send a v2
with the update. There is still some time before soft freeze [2].

The Subject of this patch [PATCH 2/2] seems to refer to a series. Is
there a patch 1/2 ?

Thanks,

C.



[1] https://lore.kernel.org/all/20240123195005.8965-1-calebs@linux.vnet.ibm.com/
[2] https://wiki.qemu.org/Planning/9.0

> ---
>   hw/ppc/pnv.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2f53883916..aa5aba60b4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1068,12 +1068,23 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
>       }
>   }
>   
> +/*
> + *    0:48  Reserved - Read as zeroes
> + *   49:52  Node ID
> + *   53:55  Chip ID
> + *   56     Reserved - Read as zero
> + *   57:59  Quad ID
> + *   60     Core Chiplet Pair ID
> + *   61:63  Thread/Core Chiplet ID t0-t2
> + *
> + * We only care about the lower bits. uint32_t is fine for the moment.
> + */
>   static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
>                                    uint32_t thread_id)
>   {
>       if (chip->nr_threads == 8) {
> -        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
> -               (thread_id >> 1);
> +        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
> +               ((core_id % 2) << 3) | thread_id;
>       } else {
>           return (chip->chip_id << 8) | (core_id << 2) | thread_id;
>       }


