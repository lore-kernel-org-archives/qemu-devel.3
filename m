Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFD9C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fGo-00084N-OX; Wed, 08 May 2024 07:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fGm-00082O-TW
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:15:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fGe-00023S-Qs
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:15:32 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3216096a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715166921; x=1715771721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=76mH09DdWZFTBqsV2388dcXGRSRWyjhUUIoDI7TQ5mc=;
 b=GOnO3vpvVa/PzBYasftWzQoJI07uYFTfX4+lZ/9zereszgQfnKXDMkb8B3tyfHh9VX
 QjmDWbWyexathguLlxmJJqr5t7Srhk8o0IvdfSodnywi4/kSpXf7X1hO01GagIbcGvtY
 o0qoh0HHpW1isD4NNpEL1pXRSKGriZP8tAt+r/CRiLbnbGESU9am5AGFdSTGalpcCrJ1
 pVqViM/Xb4rG0EsN+yjW2IcqT0vVVPRe2hxCXWIRniQVTDTnWJlavl/XIIHXOC8IJxRL
 3CfeAZH3HTz8M4v5A+viuS74tS4sf3n6tKWTwsGm1D9QiwrJ3wfz69M0MOaihKIBLLZ2
 bXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715166921; x=1715771721;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=76mH09DdWZFTBqsV2388dcXGRSRWyjhUUIoDI7TQ5mc=;
 b=UTt3jVfb1hkbiyyI00+YpZBj3BPRwyNdOaLtwnBWVf6ChArFcsqNLiSLs4+EtETolA
 gP+sKpu/i4mjQ/Z6MDO0/D3wIC/5VOaRRLjR1cd571T8g95f65PSxj5WwNUsBhH8Mm0i
 hPdUPb8IF2V1aTeOAZ48EyqCQU2kJO/eKt7SFVgvmZMnzXcPPG6L9GyNVLvkiD4WjfTA
 GklucIlew6hHLY5Yjju6CtJIZDxk2jlr5jr7/VXuKP0AV1ZaXlqkNb0BpPNtAoIyJjRD
 i6kk1oDyi4eLmqKAFS/B35H7E6UG7XlVKktF4F2/jgsKeU3jAdvZgvfJ4PaviWKYAm7x
 wTdQ==
X-Gm-Message-State: AOJu0YzGjLoOg2LruGA/9YG+sM1OG4IGcH/iA8jQ2jfAKa3wrm6F/MR1
 WBrhyCdZhjPba1Vey/pabjW9UmjIHKRp+pqlYjyht5hxVbGewGV6tPy376OjV+c=
X-Google-Smtp-Source: AGHT+IHs2umH6KuT2ks9v5el1BCKIQQa7Pg83XLhbytugc5fMqhXUpZoljN8gUz2f2xCuNgmtdxJWA==
X-Received: by 2002:a17:90a:d90e:b0:2ae:9176:f928 with SMTP id
 98e67ed59e1d1-2b6165a143amr2053194a91.15.1715166921357; 
 Wed, 08 May 2024 04:15:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 k64-20020a17090a4cc600b002b30ed21a96sm1277732pjh.11.2024.05.08.04.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 04:15:20 -0700 (PDT)
Message-ID: <09dc2e36-741d-44de-aac8-4ed2495eaeb1@ventanamicro.com>
Date: Wed, 8 May 2024 08:15:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Frank,

I'll reply with that I've done so far. Still missing some stuff:

On 5/2/24 08:37, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年3月8日 週五 上午12:04寫道：
>>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
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
>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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

(...)

+{
>> +    const uint32_t ipsr =
>> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
>> +    const uint32_t ivec = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVEC);
>> +    if (s->notify && !(ipsr & (1 << vec))) {
>> +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
>> +    }
> 
> s->notify is assigned to riscv_iommu_pci_notify() only.
> There's no way to assert the wire-signaled interrupt.
> 
> We should also check fctl.WSI before asserting the interrupt.
> 

This implementation does not support wire-signalled interrupts. It supports only
MSI, i.e. capabililities.IGS is always MSI (0). For this reason the code is also
not checking for fctl.WSI.



>> +}
  (...)

>> +    g_hash_table_unref(ctx_cache);
>> +    *ref = NULL;
>> +
>> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_DTF)) {
> 
> riscv_iommu_ctx_fetch() may return:
> RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED (256)
> RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT (257)
> RISCV_IOMMU_FQ_CAUSE_DDT_INVALID (258)
> RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED (259)
> 
> These faults are reported even when DTF is set to 1.
> We should report these faults regardless of DTF setting.


I created a "riscv_iommu_report_fault()" helper to centralize all the report fault
logic. This helper will check for DTF and, if set, we'll check the 'cause' to see if
we still want the fault to be reported or not. This helper is then used in these 2
instances where we're creating a fault by hand. It's also used extensively in
riscv_iommu_msi_write() to handle all the cases you mentioned above where we
weren't issuing faults.


> 
>> +        struct riscv_iommu_fq_record ev = { 0 };
>> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, fault);
>> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
>> +            RISCV_IOMMU_FQ_TTYPE_UADDR_RD);
>> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, devid);
>> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, pasid);
>> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, !!pasid);
>> +        riscv_iommu_fault(s, &ev);
>> +    }
>> +
>> +    g_free(ctx);
>> +    return NULL;
>> +}
>> +
>> +static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
>> +{
>> +    if (ref) {
>> +        g_hash_table_unref((GHashTable *)ref);
>> +    }
>> +}
>> +
>> +/* Find or allocate address space for a given device */
>> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>> +{
>> +    RISCVIOMMUSpace *as;
>> +
>> +    /* FIXME: PCIe bus remapping for attached endpoints. */
>> +    devid |= s->bus << 8;
>> +
>> +    qemu_mutex_lock(&s->core_lock);
>> +    QLIST_FOREACH(as, &s->spaces, list) {
>> +        if (as->devid == devid) {
>> +            break;
>> +        }
>> +    }
>> +    qemu_mutex_unlock(&s->core_lock);
>> +
>> +    if (as == NULL) {
>> +        char name[64];
>> +        as = g_new0(RISCVIOMMUSpace, 1);
>> +
>> +        as->iommu = s;
>> +        as->devid = devid;
>> +
>> +        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
>> +            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
>> +
>> +        /* IOVA address space, untranslated addresses */
>> +        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
>> +            TYPE_RISCV_IOMMU_MEMORY_REGION,
>> +            OBJECT(as), name, UINT64_MAX);
>> +        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr),
>> +            TYPE_RISCV_IOMMU_PCI);
> 
> Why do we use TYPE_RISCV_IOMMU_PCI as the address space name here?
> 

This is an error. TYPE_RISCV_IOMMU_PCI is the name of the PCI IOMMU device.

Seeing other iommus in QEMU it seems like the name of memory region is a simple
string, e.g. "amd_iommu", and then the name of the address space of the device
is something that includes the device identification.

I'll change this to something like:

         snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
             PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));

         /* IOVA address space, untranslated addresses */
         memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
             TYPE_RISCV_IOMMU_MEMORY_REGION,
             OBJECT(as), "riscv_iommu", UINT64_MAX);
         address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr),
                            name);

>> +
>> +        qemu_mutex_lock(&s->core_lock);

(...)


>> +    }
>> +
>> +    return dma_memory_write(s->target_as, addr, &data, sizeof(data),
>> +        MEMTXATTRS_UNSPECIFIED);
> 
> We should also assert the interrupt when IOFENCE.WSI is true
> and IOMMU is configured with wire-signaled interrupt.


I believe that for the same reason I pointed earlier ("this implementation does not
support wire-signalled interrupts") we're not checking for IOFENCE.WSI here.

> 
>> +}
>> +

(...)

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
> 
> Is it ever possible to have size = 0 or size > 8 write access?
> This should be guarded by .valid.min_access_size and .valid.max_access_size.

Yes. And on this point:


> 

(...)

>> +
>> +static const MemoryRegionOps riscv_iommu_mmio_ops = {
>> +    .read_with_attrs = riscv_iommu_mmio_read,
>> +    .write_with_attrs = riscv_iommu_mmio_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +        .unaligned = false,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +    }
> 
> Spec says:
> "The IOMMU behavior for register accesses where the address is not aligned
> to the size of the access, or if the access spans multiple registers,
> or if the size
> of the access is not 4 bytes or 8 bytes, is UNSPECIFIED."
> 
> Section 6.1. Reading and writing IOMMU registers also says:
> "Registers that are 64-bit wide may be accessed using either a 32-bit
> or a 64-bit access.
> Registers that are 32-bit wide must only be accessed using a 32-bit access."
> 
> Should we limit the access sizes to only 4 and 8 bytes?

Yes. We should set min = 4, max = 8, and use min and max to validate the
access  in riscv_iommu_mmio_write().


> 
>> +};
>> +
>> +/*

(...)

>> +
>> +static const MemoryRegionOps riscv_iommu_trap_ops = {
>> +    .read_with_attrs = riscv_iommu_trap_read,
>> +    .write_with_attrs = riscv_iommu_trap_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +        .unaligned = true,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +    }
>> +};

We'll also want set min = 4 and max = 8 in these ops too.

>> +
>> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)

(...)

>> +
>> +    /* Memory region for untranslated MRIF/MSI writes */
>> +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
>> +            "riscv-iommu-trap", ~0ULL);
>> +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
>> +
>> +    /* Device translation context cache */
>> +    s->ctx_cache = g_hash_table_new_full(__ctx_hash, __ctx_equal,
>> +                                         g_free, NULL);
>> +
>> +    s->iommus.le_next = NULL;
>> +    s->iommus.le_prev = NULL;
>> +    QLIST_INIT(&s->spaces);
>> +    qemu_cond_init(&s->core_cond);
>> +    qemu_mutex_init(&s->core_lock);
>> +    qemu_spin_init(&s->regs_lock);
>> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
>> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);
> 
> In our experience, using QEMU thread increases the latency of command
> queue processing,
> which leads to the potential IOMMU fence timeout in the Linux driver
> when using IOMMU with KVM,
> e.g. booting the guest Linux.
> 
> Is it possible to remove the thread from the IOMMU just like ARM, AMD,
> and Intel IOMMU models?

Interesting. We've been using this emulation internally in Ventana, with
KVM and VFIO, and didn't experience this issue. Drew is on CC and can talk
more about it.

That said, I don't mind this change, assuming it's feasible to make it for this
first version.  I'll need to check it how other IOMMUs are doing it.



> 
>> +}
>> +

(...)

>> +
>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>> +{
>> +    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>> +    AddressSpace *as = NULL;
>> +
>> +    if (pdev && pci_is_iommu(pdev)) {
>> +        return s->target_as;
>> +    }
>> +
>> +    /* Find first registered IOMMU device */
>> +    while (s->iommus.le_prev) {
>> +        s = *(s->iommus.le_prev);
>> +    }
>> +
>> +    /* Find first matching IOMMU */
>> +    while (s != NULL && as == NULL) {
>> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
> 
> For pci_bus_num(),
> riscv_iommu_find_as() can be called at the very early stage
> where software has no chance to enumerate the bus numbers.

I'll see how other IOMMUs are handling their iommu_find_as()


Thanks,


Daniel


> 
> 
> 
> 
>> +        s = s->iommus.le_next;
>> +    }
>> +
>> +    return as ? as : &address_space_memory;
>> +}
>> +
>> +static const PCIIOMMUOps riscv_iommu_ops = {
>> +    .get_address_space = riscv_iommu_find_as,
>> +};
>> +
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
>> +    } else {
>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>> +            pci_bus_num(bus));
>> +    }
>> +}
>> +
>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>> +    MemTxAttrs attrs)
>> +{
>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
>> +}
>> +
>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
>> +{
>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>> +    return 1 << as->iommu->pasid_bits;
>> +}
>> +
>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
>> +{
>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>> +
>> +    imrc->translate = riscv_iommu_memory_region_translate;
>> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
>> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
>> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
>> +}
>> +
>> +static const TypeInfo riscv_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
>> +    .class_init = riscv_iommu_memory_region_init,
>> +};
>> +
>> +static void riscv_iommu_register_mr_types(void)
>> +{
>> +    type_register_static(&riscv_iommu_memory_region_info);
>> +    type_register_static(&riscv_iommu_info);
>> +}
>> +
>> +type_init(riscv_iommu_register_mr_types);
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> new file mode 100644
>> index 0000000000..6f740de690
>> --- /dev/null
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -0,0 +1,141 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_STATE_H
>> +#define HW_RISCV_IOMMU_STATE_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#include "hw/riscv/iommu.h"
>> +
>> +struct RISCVIOMMUState {
>> +    /*< private >*/
>> +    DeviceState parent_obj;
>> +
>> +    /*< public >*/
>> +    uint32_t version;     /* Reported interface version number */
>> +    uint32_t pasid_bits;  /* process identifier width */
>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>> +
>> +    uint64_t cap;         /* IOMMU supported capabilities */
>> +    uint64_t fctl;        /* IOMMU enabled features */
>> +
>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>> +    bool enable_msi;      /* Enable MSI remapping */
>> +
>> +    /* IOMMU Internal State */
>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
>> +
>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
>> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
>> +
>> +    uint32_t cq_mask;     /* Command queue index bit mask */
>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
>> +
>> +    /* interrupt notifier */
>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>> +
>> +    /* IOMMU State Machine */
>> +    QemuThread core_proc; /* Background processing thread */
>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
>> +    QemuCond core_cond;   /* Background processing wake up signal */
>> +    unsigned core_exec;   /* Processing thread execution actions */
>> +
>> +    /* IOMMU target address space */
>> +    AddressSpace *target_as;
>> +    MemoryRegion *target_mr;
>> +
>> +    /* MSI / MRIF access trap */
>> +    AddressSpace trap_as;
>> +    MemoryRegion trap_mr;
>> +
>> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
>> +
>> +    /* MMIO Hardware Interface */
>> +    MemoryRegion regs_mr;
>> +    QemuSpin regs_lock;
>> +    uint8_t *regs_rw;  /* register state (user write) */
>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
>> +    uint8_t *regs_ro;  /* read-only mask */
>> +
>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>> +};
>> +
>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +         Error **errp);
>> +
>> +/* private helpers */
>> +
>> +/* Register helper functions */
>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>> +    unsigned idx, uint32_t set, uint32_t clr)
>> +{
>> +    uint32_t val;
>> +    qemu_spin_lock(&s->regs_lock);
>> +    val = ldl_le_p(s->regs_rw + idx);
>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
>> +    unsigned idx, uint32_t set)
>> +{
>> +    qemu_spin_lock(&s->regs_lock);
>> +    stl_le_p(s->regs_rw + idx, set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +}
>> +
>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
>> +    unsigned idx)
>> +{
>> +    return ldl_le_p(s->regs_rw + idx);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
>> +    unsigned idx, uint64_t set, uint64_t clr)
>> +{
>> +    uint64_t val;
>> +    qemu_spin_lock(&s->regs_lock);
>> +    val = ldq_le_p(s->regs_rw + idx);
>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
>> +    unsigned idx, uint64_t set)
>> +{
>> +    qemu_spin_lock(&s->regs_lock);
>> +    stq_le_p(s->regs_rw + idx, set);
>> +    qemu_spin_unlock(&s->regs_lock);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
>> +    unsigned idx)
>> +{
>> +    return ldq_le_p(s->regs_rw + idx);
>> +}
>> +
>> +
>> +
>> +#endif
>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>> new file mode 100644
>> index 0000000000..42a97caffa
>> --- /dev/null
>> +++ b/hw/riscv/trace-events
>> @@ -0,0 +1,11 @@
>> +# See documentation at docs/devel/tracing.rst
>> +
>> +# riscv-iommu.c
>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
>> new file mode 100644
>> index 0000000000..b88504b750
>> --- /dev/null
>> +++ b/hw/riscv/trace.h
>> @@ -0,0 +1,2 @@
>> +#include "trace/trace-hw_riscv.h"
>> +
>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
>> new file mode 100644
>> index 0000000000..403b365893
>> --- /dev/null
>> +++ b/include/hw/riscv/iommu.h
>> @@ -0,0 +1,36 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_H
>> +#define HW_RISCV_IOMMU_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
>> +
>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>> +
>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>> +
>> +#endif
>> diff --git a/meson.build b/meson.build
>> index c59ca496f2..75e56f3282 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3361,6 +3361,7 @@ if have_system
>>       'hw/rdma',
>>       'hw/rdma/vmw',
>>       'hw/rtc',
>> +    'hw/riscv',
>>       'hw/s390x',
>>       'hw/scsi',
>>       'hw/sd',
>> --
>> 2.43.2
>>
>>

