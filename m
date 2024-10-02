Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C191ACF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtCv-0006WO-Dw; Wed, 02 Oct 2024 02:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtCt-0006W6-Rz; Wed, 02 Oct 2024 02:51:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtCr-0002yf-IX; Wed, 02 Oct 2024 02:51:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XJQSt21Z2z4wcy;
 Wed,  2 Oct 2024 16:51:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XJQSq5Bqgz4wcj;
 Wed,  2 Oct 2024 16:51:23 +1000 (AEST)
Message-ID: <42da6640-cd23-4402-bd73-6e9cc006b359@kaod.org>
Date: Wed, 2 Oct 2024 08:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] ppc/spapr: remove deprecated machine pseries-2.7
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
 <20241001092910.1030913-8-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241001092910.1030913-8-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/1/24 11:29, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.7 specific code with this patch for now.
> 
> While at it, also remove pre-2.8-migration hacks introduced for backward
> migration compatibility.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Nice !

Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/spapr.h |  4 --
>   target/ppc/cpu.h            |  5 ---
>   hw/ppc/spapr.c              | 75 -------------------------------------
>   hw/ppc/spapr_pci.c          | 28 --------------
>   target/ppc/cpu_init.c       |  1 -
>   target/ppc/machine.c        | 52 -------------------------
>   6 files changed, 165 deletions(-)
> 
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 3778aac27b..0d40bf48f6 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -84,10 +84,6 @@ struct SpaprPhbState {
>       bool pcie_ecs; /* Allow access to PCIe extended config space? */
>   
>       /* Fields for migration compatibility hacks */
> -    bool pre_2_8_migration;
> -    uint32_t mig_liobn;
> -    hwaddr mig_mem_win_addr, mig_mem_win_size;
> -    hwaddr mig_io_win_addr, mig_io_win_size;
>       bool pre_5_1_assoc;
>   };
>   
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 321ed2da75..cab4a46fc1 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1456,11 +1456,6 @@ struct ArchCPU {
>       opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
>   
>       /* Fields related to migration compatibility hacks */
> -    bool pre_2_8_migration;
> -    target_ulong mig_msr_mask;
> -    uint64_t mig_insns_flags;
> -    uint64_t mig_insns_flags2;
> -    uint32_t mig_nb_BATs;
>       bool pre_2_10_migration;
>       bool pre_3_0_migration;
>       int32_t mig_slb_nr;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d317387b7f..4e8f2a5d8e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5222,81 +5222,6 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 8);
>   
> -/*
> - * pseries-2.7
> - */
> -
> -static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
> -                              uint64_t *buid, hwaddr *pio,
> -                              hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns, Error **errp)
> -{
> -    /* Legacy PHB placement for pseries-2.7 and earlier machine types */
> -    const uint64_t base_buid = 0x800000020000000ULL;
> -    const hwaddr phb_spacing = 0x1000000000ULL; /* 64 GiB */
> -    const hwaddr mmio_offset = 0xa0000000; /* 2 GiB + 512 MiB */
> -    const hwaddr pio_offset = 0x80000000; /* 2 GiB */
> -    const uint32_t max_index = 255;
> -    const hwaddr phb0_alignment = 0x10000000000ULL; /* 1 TiB */
> -
> -    uint64_t ram_top = MACHINE(spapr)->ram_size;
> -    hwaddr phb0_base, phb_base;
> -    int i;
> -
> -    /* Do we have device memory? */
> -    if (MACHINE(spapr)->device_memory) {
> -        /* Can't just use maxram_size, because there may be an
> -         * alignment gap between normal and device memory regions
> -         */
> -        ram_top = MACHINE(spapr)->device_memory->base +
> -            memory_region_size(&MACHINE(spapr)->device_memory->mr);
> -    }
> -
> -    phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
> -
> -    if (index > max_index) {
> -        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
> -                   max_index);
> -        return false;
> -    }
> -
> -    *buid = base_buid + index;
> -    for (i = 0; i < n_dma; ++i) {
> -        liobns[i] = SPAPR_PCI_LIOBN(index, i);
> -    }
> -
> -    phb_base = phb0_base + index * phb_spacing;
> -    *pio = phb_base + pio_offset;
> -    *mmio32 = phb_base + mmio_offset;
> -    /*
> -     * We don't set the 64-bit MMIO window, relying on the PHB's
> -     * fallback behaviour of automatically splitting a large "32-bit"
> -     * window into contiguous 32-bit and 64-bit windows
> -     */
> -
> -    return true;
> -}
> -
> -static void spapr_machine_2_7_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
> -        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
> -    };
> -
> -    spapr_machine_2_8_class_options(mc);
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
> -    mc->default_machine_opts = "modern-hotplug-events=off";
> -    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    smc->phb_placement = phb_placement_2_7;
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 7);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5c0024bef9..a83dc1375b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2101,8 +2101,6 @@ static Property spapr_phb_properties[] = {
>                          (1ULL << 12) | (1ULL << 16)
>                          | (1ULL << 21) | (1ULL << 24)),
>       DEFINE_PROP_UINT32("numa_node", SpaprPhbState, numa_node, -1),
> -    DEFINE_PROP_BOOL("pre-2.8-migration", SpaprPhbState,
> -                     pre_2_8_migration, false),
>       DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
>                        pcie_ecs, true),
>       DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
> @@ -2140,20 +2138,6 @@ static int spapr_pci_pre_save(void *opaque)
>       gpointer key, value;
>       int i;
>   
> -    if (sphb->pre_2_8_migration) {
> -        sphb->mig_liobn = sphb->dma_liobn[0];
> -        sphb->mig_mem_win_addr = sphb->mem_win_addr;
> -        sphb->mig_mem_win_size = sphb->mem_win_size;
> -        sphb->mig_io_win_addr = sphb->io_win_addr;
> -        sphb->mig_io_win_size = sphb->io_win_size;
> -
> -        if ((sphb->mem64_win_size != 0)
> -            && (sphb->mem64_win_addr
> -                == (sphb->mem_win_addr + sphb->mem_win_size))) {
> -            sphb->mig_mem_win_size += sphb->mem64_win_size;
> -        }
> -    }
> -
>       g_free(sphb->msi_devs);
>       sphb->msi_devs = NULL;
>       sphb->msi_devs_num = g_hash_table_size(sphb->msi);
> @@ -2200,13 +2184,6 @@ static int spapr_pci_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> -static bool pre_2_8_migration(void *opaque, int version_id)
> -{
> -    SpaprPhbState *sphb = opaque;
> -
> -    return sphb->pre_2_8_migration;
> -}
> -
>   static const VMStateDescription vmstate_spapr_pci = {
>       .name = "spapr_pci",
>       .version_id = 2,
> @@ -2216,11 +2193,6 @@ static const VMStateDescription vmstate_spapr_pci = {
>       .post_load = spapr_pci_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
> -        VMSTATE_UINT32_TEST(mig_liobn, SpaprPhbState, pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_mem_win_addr, SpaprPhbState, pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_mem_win_size, SpaprPhbState, pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migration),
>           VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
>                                vmstate_spapr_pci_lsi, SpaprPciLsi),
>           VMSTATE_INT32(msi_devs_num, SpaprPhbState),
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 23881d09e9..7768392986 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7452,7 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>   }
>   
>   static Property ppc_cpu_properties[] = {
> -    DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
>       DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
>                        false),
>       DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index d433fd45fc..21bed7c7c8 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -118,13 +118,6 @@ static const VMStateInfo vmstate_info_vsr = {
>   #define VMSTATE_VSR_ARRAY(_f, _s, _n)                             \
>       VMSTATE_VSR_ARRAY_V(_f, _s, _n, 0)
>   
> -static bool cpu_pre_2_8_migration(void *opaque, int version_id)
> -{
> -    PowerPCCPU *cpu = opaque;
> -
> -    return cpu->pre_2_8_migration;
> -}
> -
>   #if defined(TARGET_PPC64)
>   static bool cpu_pre_3_0_migration(void *opaque, int version_id)
>   {
> @@ -139,22 +132,6 @@ static int cpu_pre_save(void *opaque)
>       PowerPCCPU *cpu = opaque;
>       CPUPPCState *env = &cpu->env;
>       int i;
> -    uint64_t insns_compat_mask =
> -        PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB
> -        | PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES
> -        | PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES
> -        | PPC_FLOAT_STFIWX | PPC_FLOAT_EXT
> -        | PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ
> -        | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | PPC_MEM_TLBSYNC
> -        | PPC_64B | PPC_64BX | PPC_ALTIVEC
> -        | PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD;
> -    uint64_t insns_compat_mask2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX
> -        | PPC2_PERM_ISA206 | PPC2_DIVE_ISA206
> -        | PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206
> -        | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207
> -        | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207
> -        | PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_TM
> -        | PPC2_MEM_LWSYNC;
>   
>       env->spr[SPR_LR] = env->lr;
>       env->spr[SPR_CTR] = env->ctr;
> @@ -177,29 +154,6 @@ static int cpu_pre_save(void *opaque)
>           env->spr[SPR_IBAT4U + 2 * i + 1] = env->IBAT[1][i + 4];
>       }
>   
> -    /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
> -    if (cpu->pre_2_8_migration) {
> -        /*
> -         * Mask out bits that got added to msr_mask since the versions
> -         * which stupidly included it in the migration stream.
> -         */
> -        target_ulong metamask = 0
> -#if defined(TARGET_PPC64)
> -            | (1ULL << MSR_TS0)
> -            | (1ULL << MSR_TS1)
> -#endif
> -            ;
> -        cpu->mig_msr_mask = env->msr_mask & ~metamask;
> -        cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
> -        /*
> -         * CPU models supported by old machines all have
> -         * PPC_MEM_TLBIE, so we set it unconditionally to allow
> -         * backward migration from a POWER9 host to a POWER8 host.
> -         */
> -        cpu->mig_insns_flags |= PPC_MEM_TLBIE;
> -        cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
> -        cpu->mig_nb_BATs = env->nb_BATs;
> -    }
>       if (cpu->pre_3_0_migration) {
>           if (cpu->hash64_opts) {
>               cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
> @@ -760,12 +714,6 @@ const VMStateDescription vmstate_ppc_cpu = {
>           /* Backward compatible internal state */
>           VMSTATE_UINTTL(env.hflags_compat_nmsr, PowerPCCPU),
>   
> -        /* Sanity checking */
> -        VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_migration),
> -        VMSTATE_UINT64_TEST(mig_insns_flags2, PowerPCCPU,
> -                            cpu_pre_2_8_migration),
> -        VMSTATE_UINT32_TEST(mig_nb_BATs, PowerPCCPU, cpu_pre_2_8_migration),
>           VMSTATE_END_OF_LIST()
>       },
>       .subsections = (const VMStateDescription * const []) {


