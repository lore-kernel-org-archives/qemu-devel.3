Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD6CDE007
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcitP-0008U7-VW; Thu, 25 Jun 2026 08:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atish.patra@linux.dev>)
 id 1wcdme-000326-PD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 02:41:57 -0400
Received: from out-177.mta0.migadu.com ([91.218.175.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atish.patra@linux.dev>)
 id 1wcdmc-0007Fy-1S
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 02:41:56 -0400
Message-ID: <af53e02f-1545-4a2b-9583-6b2bc4d17327@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782369707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdNiVikno9zYpcbYUBFasWtslboV2z9+6nM2NOJ2Z6w=;
 b=rdt/N3mZtCSzK6D0sxhU+uo2/NG23aO0NUNhaKXMpumnvbb7IONX2TYP/oc/dZ/aTyGV+s
 bMsGPSiYAsBtumow0ZsrrDyzz+Fj8M1njNJfJVVWZO4T/IKddivxuepQJXpkLDOrX9vXUO
 ozDLXmB/Mr2bAR//szwDmaDc6domyY4=
Date: Wed, 24 Jun 2026 23:41:42 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] target/riscv: Report QEMU CPU archid as 42
To: Charlie Jenkins <thecharlesjenkins@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.177;
 envelope-from=atish.patra@linux.dev; helo=out-177.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Jun 2026 08:09:08 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/24/26 11:26 PM, Charlie Jenkins wrote:
> When a non-vendor CPU is used, report the archid as 42 which has been
> allocated for QEMU in the riscv isa manual [1]. This can help software
> check if it is running in QEMU.
>
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> ---
> This series was original proposed by Palmer Dabbelt [1] with a follow up
> by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.
>
> When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
> marchid will now be reported as 42.
>
>> qemu-system-riscv64 ... -cpu rv64
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
> mmu             : sv57
> mvendorid       : 0x0
> marchid         : 0x2a
> mimpid          : 0x0
> hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
>
> When booting with a vendor CPU like veyron-v1, the proper marchid will
> still appear.
>
>> qemu-system-riscv64 ... -cpu veyron-v1
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
> mmu             : sv48
> mvendorid       : 0x61f
> marchid         : 0x8000000000010000
> mimpid          : 0x111
> hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
>
> [1] https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.com/
> ---
>   target/riscv/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fa497e5e8a..59d63f82c2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -44,6 +44,9 @@
>   #endif
>   
>   /* RISC-V CPU definitions */
> +#define RISCV_CPU_MVENDORID 0
> +#define RISCV_CPU_MARCHID 42
> +#define RISCV_CPU_MIMPID 0
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>                                 RVC, RVS, RVU, RVH, RVG, RVB, 0};
> @@ -1198,6 +1201,12 @@ static void riscv_cpu_init(Object *obj)
>       }
>   #endif
>   
> +    if (!riscv_cpu_is_vendor(obj)) {
> +        RISCV_CPU(obj)->cfg.mvendorid = RISCV_CPU_MVENDORID;
> +        RISCV_CPU(obj)->cfg.marchid = RISCV_CPU_MARCHID;
> +        RISCV_CPU(obj)->cfg.mimpid = RISCV_CPU_MIMPID;
> +    }
> +
>       accel_cpu_instance_init(CPU(obj));
>   }
>   

Thanks for sending the patch.

Reviewed-by: Atish Patra <atish.patra@linux.dev>

> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260624-marchid-80d176b873d8
>
> Best regards,
> --
> - Charlie
>

