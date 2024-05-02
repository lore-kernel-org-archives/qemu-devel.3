Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808AEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Rh8-0007vm-AE; Thu, 02 May 2024 04:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l4T0=MF=kaod.org=clg@ozlabs.org>)
 id 1s2Rh6-0007uo-L1; Thu, 02 May 2024 04:21:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l4T0=MF=kaod.org=clg@ozlabs.org>)
 id 1s2Rh4-0000B9-SO; Thu, 02 May 2024 04:21:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VVRjG3Lbtz4xFg;
 Thu,  2 May 2024 18:21:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVRjB2LDWz4xM7;
 Thu,  2 May 2024 18:21:17 +1000 (AEST)
Message-ID: <a1e529e9-32b2-438a-b50d-10117296d4e1@kaod.org>
Date: Thu, 2 May 2024 10:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Update Power10's cfam id to use Power10 DD2
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240502062701.1379833-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240502062701.1379833-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=l4T0=MF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/24 08:27, Aditya Gupta wrote:
> Power10 DD1.0 was dropped in:
> 
>      commit 8f054d9ee825 ("ppc: Drop support for POWER9 and POWER10 DD1 chips")
> 
> Use the newer Power10 DD2 chips cfam id.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv.c            | 2 +-
>   tests/qtest/pnv-xscom.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec76..06a4e4d13948 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2090,7 +2090,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
>       static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
>   
> -    k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
> +    k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
>       k->cores_mask = POWER10_CORE_MASK;
>       k->chip_pir = pnv_chip_pir_p10;
>       k->intc_create = pnv_chip_power10_intc_create;
> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
> index 6f62941744a6..5aa1701ea768 100644
> --- a/tests/qtest/pnv-xscom.h
> +++ b/tests/qtest/pnv-xscom.h
> @@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] = {
>           .chip_type  = PNV_CHIP_POWER10,
>           .cpu_model  = "POWER10",
>           .xscom_base = 0x000603fc00000000ull,
> -        .cfam_id    = 0x120da04900008000ull,
> +        .cfam_id    = 0x220da04980000000ull,
>           .first_core = 0x0,
>           .num_i2c    = 4,
>       },


