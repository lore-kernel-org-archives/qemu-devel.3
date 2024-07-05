Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5DC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqDk-0003Gd-OS; Fri, 05 Jul 2024 17:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sPqDj-0003GQ-Pt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:11:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sPqDh-0005NN-Km
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:11:55 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d91e390601so454359b6e.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720213912; x=1720818712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBWZquwUDTsMhD6kpe8vj2ETAMSHV3Jy5bFDy/xKF7M=;
 b=UhemtHwjfoufmr5jmSoeoFYtf1sYuyojkz0Et7RkH1IfKo64qviqJOr2lEo4B7ZBTA
 Oua+hNXp5iQrNd+HCZ7ToarAsjg4bYQcbr+cQcrP7Qq0f+TTUPukGv6Y95JveDm5FSH2
 WXg+UIUljZRwR7uiCqkMsMSuNZRcQ8O7Ym6dmZnl6msFx/9p35MF+j9rvDEY/OKwJ75W
 h+O0yLrZ9Uz/umqBu50vKYNoR+6mOdHeYXWX4mJsRQF6c50H9EZTkFDxxTT67a+ASXOC
 1HYjJRuCLuaN+K/c++vE7LwoUPhEKePdvRC1LsLBk4vbnErser7vreIPySzPkCrTA1H0
 CscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720213912; x=1720818712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBWZquwUDTsMhD6kpe8vj2ETAMSHV3Jy5bFDy/xKF7M=;
 b=ItvjP1j00xwqNtwluSb3hIPiCekQfg5Q4+qUh279Y5LH9ueZVw5KkPCR4mytbBqupU
 kcGrQdIQLethCKxT3mPNev9RO7kyhQnGCo6hL++fZGNe1pwbSnR3ZIx8wWXONDAtVfmQ
 gy1XhXhV1EfRfR9fiZDhKnJVt1Yu7dFCkb+ajkXibBJDNTocs4JeRJpnrUuVZJVirup4
 ShRwv4gwOaSRjwpPT5BRvFXGPhIWcKaX/YN7TmNk3onbZtgMb4WCZVV9R0sTirQ9tShL
 dQ0kpEaKvwk60A1XtX4YOlcIZ97mcNaIFDjOQuz3obmLln4PVFj2frmJ5mixPRltYYw1
 sJSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxpIY1dNuc8q0cjIFldPLueh+Yewedp2E1wF3C5lwlJtdB6Fibarwb9+5cWlhOTXgCRqm0jnzNDgIk5IBFbhpCddIi8c=
X-Gm-Message-State: AOJu0Yx6+f3MksIH0s4ERAhmm/4jZv7BhwPXzCZb2Xl5qBst2Z3iWc5Z
 iMs/OHVzfc7zXCfpxY2gAKKMe5QRPWImupmu3Go7IV0o/95KXm+0rq55DBOuMFU=
X-Google-Smtp-Source: AGHT+IEz8eau+8YysWtcxqMm53xQb5RzZje8TfG/Oijc2P54u12yBdNInY+y+VR7PmTJLi1Q1mVJBg==
X-Received: by 2002:a05:6808:1b2b:b0:3d6:35c7:7172 with SMTP id
 5614622812f47-3d914e9f3eamr6290313b6e.46.1720213911599; 
 Fri, 05 Jul 2024 14:11:51 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b15e0cefcsm686088b3a.166.2024.07.05.14.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 14:11:51 -0700 (PDT)
Message-ID: <a0b303ba-e5b6-4fa1-b9df-b86a1e5652bd@ventanamicro.com>
Date: Fri, 5 Jul 2024 18:11:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] hw/riscv: add RISC-V IOMMU base emulation
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-4-dbarboza@ventanamicro.com>
 <a1be0779-cbb5-42d2-8ced-7567c66f2bd0@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a1be0779-cbb5-42d2-8ced-7567c66f2bd0@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
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

Hi,

On 7/4/24 11:20 AM, Jason Chien wrote:
> Hi Danial,
> 
> On 2024/6/25 上午 04:18, Daniel Henrique Barboza wrote:
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>> international process. The latest frozen specifcation can be found at:
>>
>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>>
>> Add the foundation of the device emulation for RISC-V IOMMU, which
>> includes an IOMMU that has no capabilities but MSI interrupt support and
>> fault queue interfaces. We'll add more features incrementally in the
>> next patches.
>>
>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/Kconfig            |    4 +
>>   hw/riscv/meson.build        |    1 +
>>   hw/riscv/riscv-iommu-bits.h |    2 +
>>   hw/riscv/riscv-iommu.c      | 1641 +++++++++++++++++++++++++++++++++++
>>   hw/riscv/riscv-iommu.h      |  142 +++
>>   hw/riscv/trace-events       |   11 +
>>   hw/riscv/trace.h            |    1 +
>>   include/hw/riscv/iommu.h    |   36 +
>>   meson.build                 |    1 +
>>   9 files changed, 1839 insertions(+)
>>   create mode 100644 hw/riscv/riscv-iommu.c
>>   create mode 100644 hw/riscv/riscv-iommu.h
>>   create mode 100644 hw/riscv/trace-events
>>   create mode 100644 hw/riscv/trace.h
>>   create mode 100644 include/hw/riscv/iommu.h
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index a2030e3a6f..f69d6e3c8e 100644

(...)


>> +/* IOMMU index for transactions without process_id specified. */
>> +#define RISCV_IOMMU_NOPROCID 0
>> +
>> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
>> +{
>> +    const uint32_t fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
>> +    uint32_t ipsr, ivec;
>> +
>> +    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> For WSI, we can assert INTx by invoking pci_set_irq().

For now we're not advertising WSI support because we don't have a way to test it
(riscv-iommu-pci only supports MSI). In fact riscv_iommu_notify() isn't called
for any WSI capable device, at least for now.

I'm finishing some patches where we'll re-introduce riscv-iommu-sys in the 'virt'
machine with WSI. At that point we'll pay more attention with the WSI bits that
we're ignoring for now.

>> +        return;
>> +    }
>> +
>> +    ipsr = riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
>> +    ivec = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVEC);
>> +
>> +    if (!(ipsr & (1 << vec))) {
>> +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
>> +    }
>> +}
>> +

(...)

>> +
>> +/* Check if GPA matches MSI/MRIF pattern. */
>> +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>> +    dma_addr_t gpa)
>> +{
> 
> If IOMMU does not support MSI, that is, s->enable_msi is false, we can return false.
> 

Done.

>> +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=
>> +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
>> +        return false; /* Invalid MSI/MRIF mode */
>> +    }
>> +
>> +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask) {
>> +        return false; /* GPA not in MSI range defined by AIA IMSIC rules. */
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
>> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>> +    IOMMUTLBEntry *iotlb)
>> +{
>> +    /* Early check for MSI address match when IOVA == GPA */
>> +    if (iotlb->perm & IOMMU_WO &&
>> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>> +        iotlb->target_as = &s->trap_as;
>> +        iotlb->translated_addr = iotlb->iova;
>> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
>> +        return 0;
>> +    }
>  From spec 2.3, step 17 and step 18 state that the MSI address translation is always done after the first stage translation is done.

This piece of code isn't doing MSI addr translation. It's preventing the lookup
process by doing an early exit if IOVA==GPA, i.e. there's nothing to translate.

What you described is being done in patch 8 with s-stage and g-stage support.

(...)

>> +/* Redirect MSI write for given GPA. */
>> +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>> +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
>> +    unsigned size, MemTxAttrs attrs)
>> +{
>> +    MemTxResult res;
>> +    dma_addr_t addr;
>> +    uint64_t intn;
>> +    uint32_t n190;
>> +    uint64_t pte[2];
>> +    int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
>> +    int cause;
>> +
>> +    if (!riscv_iommu_msi_check(s, ctx, gpa)) {
> I think we have invoked riscv_iommu_msi_check() before writing to s->trap_as. Do we need this check?


You're right. Removed.

(...)

>> +
>> +    if (data & RISCV_IOMMU_IPSR_PIP) {
>> +        pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
>> +
>> +        if (pqcsr & RISCV_IOMMU_PQCSR_PIE &&
>> +            (pqcsr & RISCV_IOMMU_PQCSR_PQOF ||
>> +             pqcsr & RISCV_IOMMU_PQCSR_PQMF)) {
>> +            ipsr_set |= RISCV_IOMMU_IPSR_PIP;
>> +        } else {
>> +            ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
>> +        }
>> +    } else {
>> +        ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
>> +    }
>> +
>> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
> If the pending bit is cleared, we can deassert the WSI.


I'll make a note to remind about this later when we add WSI support.


(...)


>> +#ifndef HW_RISCV_IOMMU_STATE_H
>> +#define HW_RISCV_IOMMU_STATE_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#include "hw/riscv/iommu.h"
>> +
>> +struct RISCVIOMMUState {
>> +    /*< private >*/
>> +    DeviceState parent_obj;
>> +
>> +    /*< public >*/
>> +    uint32_t version;     /* Reported interface version number */
>> +    uint32_t pasid_bits;  /* process identifier width */
> Do you mind renaming pasid_bits to something like pid_bits to remain consistency?


Done. In fact I also renamed 'pasid' from the first patch to 'pid' as well.


Thanks,

Daniel

