Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE2C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yPh-0004eq-Pk; Tue, 14 May 2024 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6yPg-0004eU-IT
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:06:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6yPd-0002JO-P2
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:06:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so46983745ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715717172; x=1716321972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGupuRAnds6XBIKYUFC/6KCwoXlCNsfWi1iPd70+UXk=;
 b=nKytrKjI73XmENtQTOpPaiDv9M2fdUMptRkfrFQNuUXLfIY7q8D6um5UlIr5Tvzf5e
 6hxOwPKBV89vFI0Ri5EN5usii4ub1K77h7OM0EUDhK5MKsD7XXwXnqQZwULZuBt34z05
 1bRV5GeXgH7BMKcRAxT6qMFnBdiEolwDf+3Anu12ev/OVnkHanHi29KfHWeHOJN1lnA3
 Ne7YdAGCfv8XvOuMLv5SzQJqsI5wAMrSOROYMNZEKeyn+qVuGIothu86i2rCFlrzjWCF
 h1fE8wfVa0omhyy/h0HZvxom4EGRKbs4QXp0TtaBmjPc69aIVaoSffQ+joinMF3LUPKF
 KZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715717172; x=1716321972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kGupuRAnds6XBIKYUFC/6KCwoXlCNsfWi1iPd70+UXk=;
 b=vtoP8NVTXxeSYvYhTWyfTQjXD6SY70wySbZVvTvS92BWjkXTD2uAUrsIvz69xLsvZV
 H7f0Ltb8P0Zaox7ZDKFezDlplGcyjsk9Rc23x84wdMzXK59Ff1At6+BAOdcIA/f1bpfl
 BfkBYrwvokCGiDz/y/toJMQ7MjLQMC8WB0v0E4zd7lW15InZRE6TwJf+9QeUUtwxN+DA
 CbxImrNDZO29mj9Vy3FstXgKRQJffQ9BnfL8Jf7j4AH79PqUHj+7k04nFNSkL7J1In63
 9Y7gc1eLCC0QVtLO+0IJYfrvUI8emRcTIzEJwI4F81GshtClak+sTdQCphYp5x2Q0FJ4
 kBsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZL6CTxeLpSJVmQORTwdKcUxpLCvZQH+kt8pI0I5Rx4OQ8L+/CcO6+ml/vYjNTaEUwoZG0dpn1UoMqzh+R8vJib/O8jmA=
X-Gm-Message-State: AOJu0YwEDY6o+wYghqJK9fLmZYdTrOreFFkJYLpukKnej0Zc/I5s/GcQ
 xDO79SYttOkw8LnGp0vTPg0ZlKrHMOnwtAPhrF+Fo316JcFivsrKoanYSTZc1Mk=
X-Google-Smtp-Source: AGHT+IHfCDUCnBmDa6+WDXxXgjbnEt0vaWV92uk5YsENgGlQcKNDwnefuNdh1y0NnAMX9VXYDx8uZQ==
X-Received: by 2002:a17:902:bd0b:b0:1eb:4c4a:e1a0 with SMTP id
 d9443c01a7336-1ef43d2e157mr117721275ad.27.1715717171199; 
 Tue, 14 May 2024 13:06:11 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c134ce8sm102158635ad.243.2024.05.14.13.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 13:06:10 -0700 (PDT)
Message-ID: <534156a8-164c-4094-beba-380377460f00@ventanamicro.com>
Date: Tue, 14 May 2024 17:06:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <212e7474-bf56-4699-970e-a4c8c37a68c2@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <212e7474-bf56-4699-970e-a4c8c37a68c2@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

Hi Jason,

On 5/1/24 08:57, Jason Chien wrote:
> Daniel Henrique Barboza 於 2024/3/8 上午 12:03 寫道:
>> From: Tomasz Jeznach<tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>> international process. The latest frozen specifcation can be found
>> at:
>>
>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>>
>> Add the foundation of the device emulation for RISC-V IOMMU, which
>> includes an IOMMU that has no capabilities but MSI interrupt support and
>> fault queue interfaces. We'll add add more features incrementally in the
>> next patches.
>>
>> Co-developed-by: Sebastien Boeuf<seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf<seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/Kconfig         |    4 +
>>   hw/riscv/meson.build     |    1 +
>>   hw/riscv/riscv-iommu.c   | 1492 ++++++++++++++++++++++++++++++++++++++
>>   hw/riscv/riscv-iommu.h   |  141 ++++
>>   hw/riscv/trace-events    |   11 +
>>   hw/riscv/trace.h         |    2 +
>>   include/hw/riscv/iommu.h |   36 +
>>   meson.build              |    1 +
>>   8 files changed, 1688 insertions(+)
>>   create mode 100644 hw/riscv/riscv-iommu.c
>>   create mode 100644 hw/riscv/riscv-iommu.h
>>   create mode 100644 hw/riscv/trace-events
>>   create mode 100644 hw/riscv/trace.h
>>   create mode 100644 include/hw/riscv/iommu.h
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index 5d644eb7b1..faf6a10029 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -1,3 +1,6 @@
>> +config RISCV_IOMMU
>> +    bool
>> +

(...)

>> +
>> +/* IOMMU index for transactions without PASID specified. */
>> +#define RISCV_IOMMU_NOPASID 0
>> +
>> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
>> +{
>> +    const uint32_t ipsr =
>> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
>> +    const uint32_t ivec = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVEC);
>> +    if (s->notify && !(ipsr & (1 << vec))) {
>> +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
>> +    }
>> +}
> The RISC-V IOMMU also supports WSI.
>> +

I mentioned in the review with Frank that this impl does not support WSI, but
it really seems clearer to do the check here nevertheless. I'll add it.


>> +static void riscv_iommu_fault(RISCVIOMMUState *s,
>> +                              struct riscv_iommu_fq_record *ev)
>> +{

(...)

>> +
>> +    /*
>> +     * Check supported device id width (in bits).
>> +     * See IOMMU Specification, Chapter 6. Software guidelines.
>> +     * - if extended device-context format is used:
>> +     *   1LVL: 6, 2LVL: 15, 3LVL: 24
>> +     * - if base device-context format is used:
>> +     *   1LVL: 7, 2LVL: 16, 3LVL: 24
>> +     */
>> +    if (ctx->devid >= (1 << (depth * 9 + 6 + (dc_fmt && depth != 2)))) {
>> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> 
> The cause should be 260 not 258.
> 
>  From the RISC-V IOMMU Architecture Spec v1.0.0 section 2.3:
> If the device_id is wider than that supported by the IOMMU mode, as determined by the following checks then stop and report "Transaction type disallowed" (cause = 260).
> a. ddtp.iommu_mode is 2LVL and DDI[2] is not 0
> b. ddtp.iommu_mode is 1LVL and either DDI[2] is not 0 or DDI[1] is not 0
> 

Changed.

>> +    }
>> +
>> +    /* Device directory tree walk */
>> +    for (; depth-- > 0; ) {
>> +        /*
>> +         * Select device id index bits based on device directory tree level
>> +         * and device context format.
>> +         * See IOMMU Specification, Chapter 2. Data Structures.
>> +         * - if extended device-context format is used:
>> +         *   device index: [23:15][14:6][5:0]
>> +         * - if base device-context format is used:
>> +         *   device index: [23:16][15:7][6:0]
>> +         */
>> +        const int split = depth * 9 + 6 + dc_fmt;
>> +        addr |= ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
>> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
>> +                            MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>> +            return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
>> +        }
>> +        le64_to_cpus(&de);
>> +        if (!(de & RISCV_IOMMU_DDTE_VALID)) {
>> +            /* invalid directory entry */
>> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
>> +        }
>> +        if (de & ~(RISCV_IOMMU_DDTE_PPN | RISCV_IOMMU_DDTE_VALID)) {
>> +            /* reserved bits set */
>> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> 
> The cause should be 259 not 258.
> 
>  From RISC-V IOMMU Architecture Spec v1.0.0 section 2.3.1:
> If any bits or encoding that are reserved for future standard use are set within ddte, stop and report "DDT entry misconfigured" (cause = 259).

Changed

> 
>> +        }
>> +        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
>> +    }
>> +
>> +    /* index into device context entry page */
>> +    addr |= (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
>> +
>> +    memset(&dc, 0, sizeof(dc));
>> +    if (dma_memory_read(s->target_as, addr, &dc, dc_len,
>> +                        MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
>> +        return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
>> +    }
>> +
>> +    /* Set translation context. */
>> +    ctx->tc = le64_to_cpu(dc.tc);
>> +    ctx->ta = le64_to_cpu(dc.ta);
>> +    ctx->msiptp = le64_to_cpu(dc.msiptp);
>> +    ctx->msi_addr_mask = le64_to_cpu(dc.msi_addr_mask);
>> +    ctx->msi_addr_pattern = le64_to_cpu(dc.msi_addr_pattern);
>> +
> According to RISC-V IOMMU Architecture spec v1.0.0 section 2.1.4, we should do some checks for the found device context.

I added a new helper to validate the device context at this point, following
section 2.1.4 steps.

>> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_V)) {
>> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
>> +    }
>> +
>> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
>> +        if (ctx->pasid != RISCV_IOMMU_NOPASID) {
>> +            /* PASID is disabled */
>> +            return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
>> +        }
>> +        return 0;
>> +    }
>> +

(...)

>> +
>> +static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
>> +{
>> +    uint64_t base;
>> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>> +    uint32_t ctrl_clr;
>> +    bool enable = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
>> +    bool active = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
>> +
>> +    if (enable && !active) {
>> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
>> +        s->cq_mask = (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ)) - 1;
>> +        s->cq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
>> +        ctrl_set = RISCV_IOMMU_CQCSR_CQON;
>> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
>> +            RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO;
> cqcsr.fence_w_ip should be set to 0 as well.

Done.


>> +    } else if (!enable && active) {
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
>> +    } else {

(...)

>> +}
>> +
>> +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>> +    uint64_t data, unsigned size, MemTxAttrs attrs)
>> +{
>> +    RISCVIOMMUState *s = opaque;
>> +    uint32_t regb = addr & ~3;
>> +    uint32_t busy = 0;
>> +    uint32_t exec = 0;
>> +
>> +    if (size == 0 || size > 8 || (addr & (size - 1)) != 0) {
>> +        /* Unsupported MMIO alignment or access size */
>> +        return MEMTX_ERROR;
>> +    }
>> +
>> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
>> +        /* Unsupported MMIO access location. */
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +
>> +    /* Track actionable MMIO write. */
>> +    switch (regb) {
> 
> There should be a case for IPSR register.
> 
>  From RISC-V IOMMU Architecture Spec v1.0.0 section 5.18:
> If a bit in ipsr is 1 then a write of 1 to the bit transitions the bit from 1→0. If the conditions to set that bit are still present (See [IPSR_FIELDS]) or if they occur after the bit is cleared then that bit transitions again from 0→1.


A new helper to handle ipsr updates via mmio_write was created.

>> +    case RISCV_IOMMU_REG_DDTP:
>> +    case RISCV_IOMMU_REG_DDTP + 4:
>> +        exec = BIT(RISCV_IOMMU_EXEC_DDTP);

(...)

>> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>> +{
>> +    RISCVIOMMUState *s = RISCV_IOMMU(dev);
>> +
>> +    s->cap = s->version & RISCV_IOMMU_CAP_VERSION;
>> +    if (s->enable_msi) {
>> +        s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>> +    }
>> +    /* Report QEMU target physical address space limits */
>> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
>> +                       TARGET_PHYS_ADDR_SPACE_BITS);
>> +
>> +    /* TODO: method to report supported PASID bits */
>> +    s->pasid_bits = 8; /* restricted to size of MemTxAttrs.pasid */
>> +    s->cap |= RISCV_IOMMU_CAP_PD8;
>> +
>> +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
>> +    s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
>> +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
>> +
>> +    /* register storage */
>> +    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +
>> +     /* Mark all registers read-only */
>> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
>> +
>> +    /*
>> +     * Register complete MMIO space, including MSI/PBA registers.
>> +     * Note, PCIDevice implementation will add overlapping MR for MSI/PBA,
>> +     * managed directly by the PCIDevice implementation.
>> +     */
>> +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_ops, s,
>> +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
>> +
>> +    /* Set power-on register state */
>> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
>> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], s->fctl);
> s->fctl is not initialized.

I believe the idea is to init it as zero. I'll change it to init as zero
explicitly.

>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
>> +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
>> +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],

(...)

>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +        Error **errp)
>> +{
>> +    if (bus->iommu_ops &&
>> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
>> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
>> +    } else if (bus->iommu_ops == NULL) {
>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> The original bus->iommu_op and bus->iommu_opaque will be lost.

Not sure what you meant with 'iommu_op'. We have 'iommu_ops', which is being checked
for NULL before calling pci_setup_iommu().

As for overwriting the original bus->iommu_opaque, I added an extra iommu_opaque == NULL
check. We'll make:

     } else if (!bus->iommu_ops && !bus->iommu_opaque) {
         pci_setup_iommu(bus, &riscv_iommu_ops, iommu);

This will guarantee that we're not overwriting any existing ops or opaque by accident.



Thanks,


Daniel


