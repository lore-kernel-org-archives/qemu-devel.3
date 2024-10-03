Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A373CF34AC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLXC-0004Ng-R0; Thu, 03 Oct 2024 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swLXB-0004N5-1l
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:06:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swLX9-0008V7-3v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:06:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20ba733b904so8129705ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727960777; x=1728565577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDk5O3koOBHwLkdkaB5GUkRC1q7W8atpr01+8pRvm54=;
 b=fbwSSnb/RZAM0crnYNWrtpqzW0jAMfRflQIQj9NR50ZOTVrvLBaqXaSUZF08Id7QN3
 SONTj9gDMVtQcAAw5uPDf2oPTMBHzer8Wkv9pfzxBolHnujEhkoMe5taH91puamqgduh
 YjleQxFXx1R5STKtSzWwsRgHk/b5ybY1OKtBFFv4Lc4DRxHRe+x2Il8EkLU42LZaQs0f
 9KxrviQz5GoWih8HZOFGDEcbh8kKGFZo12nkf7sssQWNht0k1RwWli19tbR7Mw6hxY5U
 5cF/oP3wB3hF+pJb5IpWLFxn72T1ZqIaFhYlUeaswDF7xSwyUS95SoC4FEQRg6OMUTB+
 vcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727960777; x=1728565577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BDk5O3koOBHwLkdkaB5GUkRC1q7W8atpr01+8pRvm54=;
 b=tH3Ik2L3G5okcdp8xrwt57OdTd2hzc2syFBvx5rSrmazmH5UdHWdS25JEmrygkh9Mu
 aOGLGvpGj/ik0Ueefeqt79Ag4jMTern/+Uk9bnYoiAbVFMZFPgNV23V749xZ3pxMuOid
 o7cV9MQLHbs47Z8s1Zzeh7m9aWL0KLd8E4rcCKW2TEE+2s/iRoiPNTPMGKZEvN8R0+MY
 /t64uXVRJQyy/TIo8fA1AGOZWBsG9TCXPQIODqPUafXTzywI5rMRGko5kS5Tvd225Kml
 b/V3IwqrBMGOchsYP3EUpjv7G3bTOiV/LPhIFH7v05a6XHUblZhd4iDGJp6vZ5nurcu1
 C2uA==
X-Gm-Message-State: AOJu0YwfITDI3AjlZs1+QMT3mfWKq1wxao4rcEwmdrZeu0OWQApEQEkE
 Cr9UHReLcOGx/DLZtjOTMFGxH5Y6C4cj746gOs0KtKLX0J9tlsmh+86VJiS5ly0=
X-Google-Smtp-Source: AGHT+IFjgUKQKG7ft0TwivPI3k8dQzv4zz9XvO4KUdsp9Ei3ieGbIvt8I8g/9H7WYKr3n/pW/Xhczg==
X-Received: by 2002:a17:90a:650c:b0:2e0:94da:bfd2 with SMTP id
 98e67ed59e1d1-2e18450c821mr8255469a91.8.1727960777139; 
 Thu, 03 Oct 2024 06:06:17 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1bfad5debsm1540794a91.9.2024.10.03.06.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 06:06:16 -0700 (PDT)
Message-ID: <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
Date: Thu, 3 Oct 2024 10:06:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, peter.maydell@linaro.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Sebastien Boeuf <seb@rivosinc.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
 <20241002010314.1928515-4-dbarboza@ventanamicro.com>
 <20241003-c10c27e0855533db764a1490@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241003-c10c27e0855533db764a1490@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 10/3/24 6:26 AM, Andrew Jones wrote:
> On Tue, Oct 01, 2024 at 10:02:58PM GMT, Daniel Henrique Barboza wrote:
> ...
>> +/*
>> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
>> + *
>> + * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
>> + * Both implementation can be merged into single helper function in future.
>> + * Keeping them separate for now, as error reporting and flow specifics are
>> + * sufficiently different for separate implementation.
>> + *
>> + * @s        : IOMMU Device State
>> + * @ctx      : Translation context for device id and process address space id.
>> + * @iotlb    : translation data: physical address and access mode.
>> + * @return   : success or fault cause code.
>> + */
>> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>> +    IOMMUTLBEntry *iotlb)
>> +{
>> +    dma_addr_t addr, base;
>> +    uint64_t satp, gatp, pte;
>> +    bool en_s, en_g;
>> +    struct {
>> +        unsigned char step;
>> +        unsigned char levels;
>> +        unsigned char ptidxbits;
>> +        unsigned char ptesize;
>> +    } sc[2];
>> +    /* Translation stage phase */
>> +    enum {
>> +        S_STAGE = 0,
>> +        G_STAGE = 1,
>> +    } pass;
>> +    MemTxResult ret;
>> +
>> +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>> +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
>> +
>> +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
>> +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
>> +
>> +    /*
>> +     * Early check for MSI address match when IOVA == GPA. This check
>> +     * is required to ensure MSI translation is applied in case
>> +     * first-stage translation is set to BARE mode. In this case IOVA
>> +     * provided is a valid GPA. Running translation through page walk
>> +     * second stage translation will incorrectly try to translate GPA
>> +     * to host physical page, likely hitting IOPF.
>> +     */
> 
> Why was this comment expanded from the simple
> 
> "Early check for MSI address match when IOVA == GPA."
> 
> The comment is now incorrect since the check is required even when
> first-stage translation is not BARE. I just skimmed the spec again trying
> to figure out if the removal of '!en_s' is a hack or a fix, and I'm
> inclined to say "fix", but it's an incomplete fix. I found a sentence that
> says
> 
> "If the virtual memory scheme selected for first-stage is Bare but the
> scheme for the second-stage is not Bare then the IOVA is a GPA."
> 
> which, in a way, defines a GPA to only be a GPA when second-stage is used
> (and all MSI translation specifications refer to GPAs). However, maybe I
> missed it, but I couldn't find any actual reason that the MSI table can't
> be used when first-stage is not BARE and second-stage is (and, of course,
> it makes no difference for single-stage translations to call IOVAs GPAs
> or not).
> 
> Now, I also see
> 
> "If the virtual memory scheme selected for neither stage is Bare then the
> IOVA is a VA. Two-stage address translation is in effect. The first-stage
> translates the VA to a GPA and the second-stage translates the GPA to a
> SPA."
> 
> in the spec, which means we should probably change the removal of '!en_s'
> to '!(en_s && en_g)'. VFIO+irqbypass would still work with that and, when
> Linux learns to support two-stage translation, we wouldn't incorrectly try
> to check for a GVA in the MSI table.

Ok. It seems to me that we can't rely on the riscv-iommu spec alone to let
us know how to detect if IOVA == GPA, given that one of the main usages
we have ATM (VFIO irqbypass) will use GPAs with S-stage enabled.

(Note: shouldn't we open a bug against the riscv-iommu spec?)

I like the idea of ruling out the case where IOVA == VA since that is clear
in the spec. We also know that MSI entries will always contains GPAs.

This is the change I'm going to make in v9:


     /*
      * Early check for MSI address match when IOVA == GPA to
      * support VFIO+irqbypass. The riscv-iommu spec doesn't
      * consider the case where a GPA can be produced by S-stage
      * only, but we have real life examples like Linux VFIO that
      * work that way. The spec alone does not provide a reliable
      * way of detecting if IOVA == GPA.
      *
      * The spec is clear about what is a VA: "If the virtual
      * memory scheme selected for neither stage is Bare then
      * the IOVA is a VA", in our case "(en_s && en_g)". We also
      * know that MSI tables will always hold GPAs.
      *
      * Thus the check consists of ruling out VAs and checking
      * the MSI table.
      */
     if (!(en_s && en_g) && (iotlb->perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         return 0;
     }

Tomasz, let me know if you have any opinions against it. I intend to send
the v9 start of next week.


Thanks,


Daniel


> 
> Thanks,
> drew

