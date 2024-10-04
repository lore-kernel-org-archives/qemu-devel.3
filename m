Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6919CFA777
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 13:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhvn-0000W5-Gu; Fri, 04 Oct 2024 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swhvL-0000UG-BV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:00:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swhvH-0007YL-AZ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:00:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so15771725ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728046841; x=1728651641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhzUzKhUBW4MaAinMGXGg/k16YUAfNRiKoE3JTnU57c=;
 b=a0M6HQjxQwD3K+ucKSS0Zz2PBFyE8k69sMBcLV2PtzKbCk+2LK0WWy3Y8MeHv2Yv+3
 YUN/DSdkDPogun10GYlmRbZsimBEomhyvWjXml75teY+YURrYPs1EEKM9fAue52b+kw9
 yocAPC/JoSSl+WGqJQRpuB5LljUUIlsfpKComFR3UmYciiBm8FB1vP4+8JycuuYZqy1D
 1bEsx/pYI1NIele73/7u7wSFkQ7yZMG7BnaYdRiO4MrlfwORlBxXpV/5diEWGI8Is6oo
 T+fxgm9LcZ1celIAN83UFOeQR0x0aOMhFpve9YukwALv7FLL8Ybqy0O3Wp5fMF6R9+z5
 cwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046841; x=1728651641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhzUzKhUBW4MaAinMGXGg/k16YUAfNRiKoE3JTnU57c=;
 b=ddTaw9qNyOE2Mn5V1sid+6Ru5s4ehAil9/RcCdpf3wG0Dw/ql7ZcT3Pbi33XnJLurM
 wnrMYhyVujOjXhru9dqibVDNRU4L3pWeXVOp3iTMajHy9IBMlGu1gtCorRvGFZoc4MgE
 P7dDo9RBsIfFl08GHdcH6ptOe6eaDlHrU8b1OL3iSxlpP1UlYa8/1C/4qPM/FCTE354t
 A+EinPIzE7+bI5EZ8CNt1+2ewj6MUc27Q7RqlKO12s4PWx22pa4A3ofWkf/dKFo62vmW
 qOP6MqfhsATEIJ8/nbXGeneFfjbMwEcjtIeeE6R6703L6fyfAb9uR1GZIPUJojaQ0e2I
 jMQA==
X-Gm-Message-State: AOJu0Yy2mMt4k2o+4IYCCia6QrBCscJSwf1kmkh6EbCYvpTQLvzIA+5T
 6RNLzu6+TL/ksKdHcStxpMbFZVuMcjxivaq9g/NW0D2A8XnCl5LBSAgX3HWOijU=
X-Google-Smtp-Source: AGHT+IGNwG5C63FscsDmsrSttco2E3GLUiwCoQVkD19x/BacuAQ9R/j148VL/nZRcO5qHteU27D8Dg==
X-Received: by 2002:a17:902:d484:b0:20b:8d7f:d13 with SMTP id
 d9443c01a7336-20bff18bcdemr43537065ad.58.1728046840741; 
 Fri, 04 Oct 2024 06:00:40 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20bef802bf6sm23443675ad.297.2024.10.04.06.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 06:00:40 -0700 (PDT)
Message-ID: <30b1d28c-ef1b-4f16-95ad-02a51066061b@ventanamicro.com>
Date: Fri, 4 Oct 2024 10:00:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Andrew Jones <ajones@ventanamicro.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, peter.maydell@linaro.org,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
 <20241002010314.1928515-4-dbarboza@ventanamicro.com>
 <20241003-c10c27e0855533db764a1490@orel>
 <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
 <CAH2o1u6h5nOMuGq8opXQNm6M=D=TrvygmoS+hHwmrgViy3reFA@mail.gmail.com>
 <20241004-2c8c6a6af4d598c78638a091@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241004-2c8c6a6af4d598c78638a091@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 10/4/24 5:33 AM, Andrew Jones wrote:
> On Thu, Oct 03, 2024 at 11:36:00AM GMT, Tomasz Jeznach wrote:
>> On Thu, Oct 3, 2024 at 6:06 AM Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>>
>>>
>>> On 10/3/24 6:26 AM, Andrew Jones wrote:
>>>> On Tue, Oct 01, 2024 at 10:02:58PM GMT, Daniel Henrique Barboza wrote:
>>>> ...
>>>>> +/*
>>>>> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
>>>>> + *
>>>>> + * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
>>>>> + * Both implementation can be merged into single helper function in future.
>>>>> + * Keeping them separate for now, as error reporting and flow specifics are
>>>>> + * sufficiently different for separate implementation.
>>>>> + *
>>>>> + * @s        : IOMMU Device State
>>>>> + * @ctx      : Translation context for device id and process address space id.
>>>>> + * @iotlb    : translation data: physical address and access mode.
>>>>> + * @return   : success or fault cause code.
>>>>> + */
>>>>> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>>>> +    IOMMUTLBEntry *iotlb)
>>>>> +{
>>>>> +    dma_addr_t addr, base;
>>>>> +    uint64_t satp, gatp, pte;
>>>>> +    bool en_s, en_g;
>>>>> +    struct {
>>>>> +        unsigned char step;
>>>>> +        unsigned char levels;
>>>>> +        unsigned char ptidxbits;
>>>>> +        unsigned char ptesize;
>>>>> +    } sc[2];
>>>>> +    /* Translation stage phase */
>>>>> +    enum {
>>>>> +        S_STAGE = 0,
>>>>> +        G_STAGE = 1,
>>>>> +    } pass;
>>>>> +    MemTxResult ret;
>>>>> +
>>>>> +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>>>>> +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
>>>>> +
>>>>> +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
>>>>> +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
>>>>> +
>>>>> +    /*
>>>>> +     * Early check for MSI address match when IOVA == GPA. This check
>>>>> +     * is required to ensure MSI translation is applied in case
>>>>> +     * first-stage translation is set to BARE mode. In this case IOVA
>>>>> +     * provided is a valid GPA. Running translation through page walk
>>>>> +     * second stage translation will incorrectly try to translate GPA
>>>>> +     * to host physical page, likely hitting IOPF.
>>>>> +     */
>>>>
>>>> Why was this comment expanded from the simple
>>>>
>>>> "Early check for MSI address match when IOVA == GPA."
>>>>
>>>> The comment is now incorrect since the check is required even when
>>>> first-stage translation is not BARE. I just skimmed the spec again trying
>>>> to figure out if the removal of '!en_s' is a hack or a fix, and I'm
>>>> inclined to say "fix", but it's an incomplete fix. I found a sentence that
>>>> says
>>>>
>>>> "If the virtual memory scheme selected for first-stage is Bare but the
>>>> scheme for the second-stage is not Bare then the IOVA is a GPA."
>>>>
>>>> which, in a way, defines a GPA to only be a GPA when second-stage is used
>>>> (and all MSI translation specifications refer to GPAs). However, maybe I
>>>> missed it, but I couldn't find any actual reason that the MSI table can't
>>>> be used when first-stage is not BARE and second-stage is (and, of course,
>>>> it makes no difference for single-stage translations to call IOVAs GPAs
>>>> or not).
>>>>
>>>> Now, I also see
>>>>
>>>> "If the virtual memory scheme selected for neither stage is Bare then the
>>>> IOVA is a VA. Two-stage address translation is in effect. The first-stage
>>>> translates the VA to a GPA and the second-stage translates the GPA to a
>>>> SPA."
>>>>
>>>> in the spec, which means we should probably change the removal of '!en_s'
>>>> to '!(en_s && en_g)'. VFIO+irqbypass would still work with that and, when
>>>> Linux learns to support two-stage translation, we wouldn't incorrectly try
>>>> to check for a GVA in the MSI table.
>>>
>>> Ok. It seems to me that we can't rely on the riscv-iommu spec alone to let
>>> us know how to detect if IOVA == GPA, given that one of the main usages
>>> we have ATM (VFIO irqbypass) will use GPAs with S-stage enabled.
>>>
>>> (Note: shouldn't we open a bug against the riscv-iommu spec?)
>>>
>>> I like the idea of ruling out the case where IOVA == VA since that is clear
>>> in the spec. We also know that MSI entries will always contains GPAs.
>>>
>>> This is the change I'm going to make in v9:
>>>
>>>
>>
>> It might be worth it to quote spec definitions of IOVA, GPA, SPA.
>>
>> IOVA: I/O Virtual Address: Virtual address for DMA by devices
>> GPA: Guest Physical Address: An address in the virtualized physical
>> memory space of a virtual machine.
>> SPA: Supervisor Physical Address: Physical address used to access
>> memory and memory-mapped resources.
>>
>>  From IOMMU specification it's pretty clear, an untranslated address is
>> always an IOVA.
>>
>> If you look at the introduction section and section 2.3. "Process to
>> translate an IOVA", translation (if enabled by the device/process
>> context) to GPA, SPA is expressed as:
>>
>> step #17: GPA = FSC[IOVA]
>> step #19: SPA = IOHGATP[GPA]
>>
>> With that, MSI address translations always use GPA as an input
>> (section 2.3.3. "Process to translate addresses of MSIs"), and is done
>> as step #18 of the IOVA translation.
>>
>> And now:
>> If FSC.Mode == Bare, step #17 translation is simple GPA = IOVA
>> If IOHGATP.Mode == Bare, step #19 translation is simple SPA = GPA
>>
>> If both FSC and IOHGATP modes are bare, no address translation is
>> performed, and SPA = GPA = IOVA. However if "MSI page tables are
>> enabled, then the MSI address translation process specified in Section
>> 2.3.3 is invoked".  This was the reason to put the
>> riscv_iommu_msi_check() function before check for pass-through mode
>> check.
>>
>> If FSC.Mode == Bare and untranslated address given to the function
>> riscv_iommu_spa_fetch() is an GPA = IOVA. It could also be SPA if
>> IOHGATP.Mode == Bare, but it is irrelevant for the MSI address
>> translation.  That is the reason to put only the check for !en_s in
>> before riscv_iommu_msi_check() call.
>>
>> I'm aware that VFIO uses S-Stage translation only, but it does not
>> change the hardware logic. For such cases VFIO can provide IMSIC
>> register mappings in S-Stage PT to emulate MSI doorbell registers (if
>> needed). When S-Stage translation is used, an untranslated address
>> processed by the IOMMU hardware is still an IOVA, even if the guest OS
>> / VFIO user treats it as PA.
> 
> This would work for guest interrupt file mappings, but MRIFs won't work
> and the note of the "Device contexts at an IOMMU" section of the AIA spec
> points out that VCPU migration may become more difficult to manage.
> 
>>
>> Modification of the check to include en_g ( !(en_s && en_g) && ,,, )
>> will incorrectly enable MSI address translation for an IOVA address
>> (as defined in IOMMU spec) if G-Stage translation is set to Bare mode.
>>
>> I'd suggest to keep the s/g stage checks here as:
>>        if ((iotlb->perm & IOMMU_WO) && !en_s &&
>>            riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>>            ...
>>        }
>>
>> Hope that helps this discussion.
> 
> Yes, it certainly helps, thank you. It points out that step 17 of "Process
> to translate an IOVA" produces a GPA which is consumed by step 18 for the
> MSI translation (and there's no other way to get to step 18). OIOW, we
> must do a first-stage translation before we check the MSI page table,
> which means we can't do an early MSI check unless we have strictly !en_s.
> 
> This is unfortunate, considering the current state of VFIO+irqbypass and
> the IOMMU driver. I also wonder if it's really necessary. It seems to me
> that the MSI page table should always be checked first when either S-stage
> or G-stage is Bare (so there's only a single-stage of translation) and
> msiptp.MODE is not Off. I can't see what harm could come from that and it
> would give system software the ability to leverage code that already knows
> how to manage single-stage IOMMUs for device assignment.

I agree with all of that. But at the end of the day we need to adhere to the
HW spec as closely as we can, and it's now clear that the assumptions we were
making in this particular check, for the sake of VFIO+irqbypass support, is
sort of spec violation.

I still believe this is something that we would like to discuss in the spec
space, but for now we don't have much to do w.r.t the emulation. If we want
VFIO+irqbypass to work the Linux driver will need to do extra work.

This is what I'll do for v9:

    /*
      * Early check for MSI address match when IOVA == GPA.
      * Note that the (!en_s) condition means that the MSI
      * page table may only be used when guest pages are
      * mapped using the g-stage page table, whether single-
      * or two-stage paging is enabled. It's unavoidable though,
      * because the spec mandates that we do a first-stage
      * translation before we check the MSI page table, which
      * means we can't do an early MSI check unless we have
      * strictly !en_s.
      */
     if (!en_s && (iotlb->perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         return 0;
     }


It also came to my attention today that the kernel support is waiting for
the QEMU pieces to land due to the Red Hat PCI ID we're adding. I'll post
v9 later today or next Monday to see if we can speed things up.


Thanks,

Daniel





> 
> Thanks,
> drew

