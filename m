Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A23D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpn-0008NJ-Vn; Sun, 03 Nov 2024 19:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpj-00089n-Rr; Sun, 03 Nov 2024 19:20:40 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kph-0002cV-O1; Sun, 03 Nov 2024 19:20:39 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso2293012b3a.1; 
 Sun, 03 Nov 2024 16:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679636; x=1731284436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBKDzu5wBBXzzjomyXMxfzAHh16pPVgxXwJrDHlU3Ok=;
 b=K5Cq4WCC7d18FL9z8TtH11PGLLJaMdsaim3wxBN2D7wvpSj73omfu7ml4YK2XFxG/o
 6xaj6UU+Cdcahm85+1DKAEh/cBTNkDsgabjhQsFZmX++7lLgyxQdziPoFFTjmzgXDpds
 6A67otbcvnpmfHHh/6UYYAWlcbJNAAzjH/mEyuRuuk8+TPnPlsSUJIv4ElN4L5dl9+2h
 YKQu0YTHBnxE8w/c2YrjKIxsZFKWJ0DPwPwGKqSejaY6TNvUKCYV82VhHgl6+fDJLWDl
 jxt4GuL8rKcQiBFIAeuk1gPmHWoM06hwvJxJnsBFZrMTjc2T1x7H1ulfxGlFEckNxlji
 h+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679636; x=1731284436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBKDzu5wBBXzzjomyXMxfzAHh16pPVgxXwJrDHlU3Ok=;
 b=sDt9muFEZy7Nxrpo1WxyRjAFAtZhFkn+1csjgBtcqBgeVD8Cs2zGHjU7obAGxVJSH6
 JHgTfILL/ZrLd/1OpzIJ6xYsMwrfam2wBDqefFwEYMHyIHU98xLT9KiN5UlPhEEoOSqv
 itAaTpJwoqd+zwKajM2gepBYx77glDvOFkEEYj4sundTZA4c9tw+14cYiIFhdC2kQl0j
 c3OYJ/Qqpd894fwGCkoTeYE7N/zGewlvG17UNSA7tCGa5kMS+MCXtPqkfP8fKfuoXgd7
 DJwJDYPRkf08VnIDhpAlepfcODx3sFyKTwVm0xWl+XNypBuJc4uzjs6EngaQr+kHlu7P
 hTaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+YmBEyC+QtWyaqea+XQZZVvfByfr+HT2IAa+zhChGdRQew+K2kuXoUgri0Y/Uhz8EqFRoxmmQg==@nongnu.org
X-Gm-Message-State: AOJu0YwcJw+9i0Cif4dKmaG5nzYKrSmAp7K8TcwJ1a4s1pJN6AkSpUnb
 TGzYF5/fphb81jDIgUePLHFnShaAVashidyBFFtQrNgJICyqyQFlhROgMg==
X-Google-Smtp-Source: AGHT+IEWx7Joryz5xYGwO6gX15/0MeF13f/n1VidfiRjkrXgvXhOXvpKXiyIe3uryht+lKUHEONvOA==
X-Received: by 2002:a05:6a00:3d56:b0:71e:5d1d:1aaf with SMTP id
 d2e1a72fcca58-720b9de1421mr21968644b3a.23.1730679635565; 
 Sun, 03 Nov 2024 16:20:35 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/67] ppc/spapr: remove deprecated machine pseries-2.7
Date: Mon,  4 Nov 2024 10:18:12 +1000
Message-ID: <20241104001900.682660-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.7 specific code with this patch for now.

While at it, also remove pre-2.8-migration and pci/mmio hacks introduced
for backward compatibility.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c              | 75 -------------------------------------
 hw/ppc/spapr_pci.c          | 57 ++++------------------------
 include/hw/pci-host/spapr.h |  4 --
 target/ppc/cpu.h            |  5 ---
 target/ppc/cpu_init.c       |  1 -
 target/ppc/machine.c        | 52 -------------------------
 6 files changed, 7 insertions(+), 187 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9c988b8f6..c89ab89b97 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5203,81 +5203,6 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 8);
 
-/*
- * pseries-2.7
- */
-
-static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
-                              uint64_t *buid, hwaddr *pio,
-                              hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    /* Legacy PHB placement for pseries-2.7 and earlier machine types */
-    const uint64_t base_buid = 0x800000020000000ULL;
-    const hwaddr phb_spacing = 0x1000000000ULL; /* 64 GiB */
-    const hwaddr mmio_offset = 0xa0000000; /* 2 GiB + 512 MiB */
-    const hwaddr pio_offset = 0x80000000; /* 2 GiB */
-    const uint32_t max_index = 255;
-    const hwaddr phb0_alignment = 0x10000000000ULL; /* 1 TiB */
-
-    uint64_t ram_top = MACHINE(spapr)->ram_size;
-    hwaddr phb0_base, phb_base;
-    int i;
-
-    /* Do we have device memory? */
-    if (MACHINE(spapr)->device_memory) {
-        /* Can't just use maxram_size, because there may be an
-         * alignment gap between normal and device memory regions
-         */
-        ram_top = MACHINE(spapr)->device_memory->base +
-            memory_region_size(&MACHINE(spapr)->device_memory->mr);
-    }
-
-    phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
-
-    if (index > max_index) {
-        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
-                   max_index);
-        return false;
-    }
-
-    *buid = base_buid + index;
-    for (i = 0; i < n_dma; ++i) {
-        liobns[i] = SPAPR_PCI_LIOBN(index, i);
-    }
-
-    phb_base = phb0_base + index * phb_spacing;
-    *pio = phb_base + pio_offset;
-    *mmio32 = phb_base + mmio_offset;
-    /*
-     * We don't set the 64-bit MMIO window, relying on the PHB's
-     * fallback behaviour of automatically splitting a large "32-bit"
-     * window into contiguous 32-bit and 64-bit windows
-     */
-
-    return true;
-}
-
-static void spapr_machine_2_7_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
-        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
-    };
-
-    spapr_machine_2_8_class_options(mc);
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
-    mc->default_machine_opts = "modern-hotplug-events=off";
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    smc->phb_placement = phb_placement_2_7;
-}
-
-DEFINE_SPAPR_MACHINE(2, 7);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 8f1964ce52..7e24084673 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1814,30 +1814,15 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     assert(sphb->index != (uint32_t)-1); /* checked in spapr_phb_pre_plug() */
 
-    if (sphb->mem64_win_size != 0) {
-        if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
-            error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PRIx
-                       " (max 2 GiB)", sphb->mem_win_size);
-            return;
-        }
-
-        /* 64-bit window defaults to identity mapping */
-        sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
-    } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
-        /*
-         * For compatibility with old configuration, if no 64-bit MMIO
-         * window is specified, but the ordinary (32-bit) memory
-         * window is specified as > 2GiB, we treat it as a 2GiB 32-bit
-         * window, with a 64-bit MMIO window following on immediately
-         * afterwards
-         */
-        sphb->mem64_win_size = sphb->mem_win_size - SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem64_win_addr = sphb->mem_win_addr + SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem64_win_pciaddr =
-            SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem_win_size = SPAPR_PCI_MEM32_WIN_SIZE;
+    if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
+        error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PRIx
+                   " (max 2 GiB)", sphb->mem_win_size);
+        return;
     }
 
+    /* 64-bit window defaults to identity mapping */
+    sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
+
     if (spapr_pci_find_phb(spapr, sphb->buid)) {
         SpaprPhbState *s;
 
@@ -2066,8 +2051,6 @@ static Property spapr_phb_properties[] = {
                        (1ULL << 12) | (1ULL << 16)
                        | (1ULL << 21) | (1ULL << 24)),
     DEFINE_PROP_UINT32("numa_node", SpaprPhbState, numa_node, -1),
-    DEFINE_PROP_BOOL("pre-2.8-migration", SpaprPhbState,
-                     pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
                      pcie_ecs, true),
     DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
@@ -2105,20 +2088,6 @@ static int spapr_pci_pre_save(void *opaque)
     gpointer key, value;
     int i;
 
-    if (sphb->pre_2_8_migration) {
-        sphb->mig_liobn = sphb->dma_liobn[0];
-        sphb->mig_mem_win_addr = sphb->mem_win_addr;
-        sphb->mig_mem_win_size = sphb->mem_win_size;
-        sphb->mig_io_win_addr = sphb->io_win_addr;
-        sphb->mig_io_win_size = sphb->io_win_size;
-
-        if ((sphb->mem64_win_size != 0)
-            && (sphb->mem64_win_addr
-                == (sphb->mem_win_addr + sphb->mem_win_size))) {
-            sphb->mig_mem_win_size += sphb->mem64_win_size;
-        }
-    }
-
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = g_hash_table_size(sphb->msi);
@@ -2165,13 +2134,6 @@ static int spapr_pci_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pre_2_8_migration(void *opaque, int version_id)
-{
-    SpaprPhbState *sphb = opaque;
-
-    return sphb->pre_2_8_migration;
-}
-
 static const VMStateDescription vmstate_spapr_pci = {
     .name = "spapr_pci",
     .version_id = 2,
@@ -2181,11 +2143,6 @@ static const VMStateDescription vmstate_spapr_pci = {
     .post_load = spapr_pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
-        VMSTATE_UINT32_TEST(mig_liobn, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_mem_win_addr, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_mem_win_size, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migration),
         VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
                              vmstate_spapr_pci_lsi, SpaprPciLsi),
         VMSTATE_INT32(msi_devs_num, SpaprPhbState),
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 79187e80fd..0db87f1281 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -83,10 +83,6 @@ struct SpaprPhbState {
     bool pcie_ecs; /* Allow access to PCIe extended config space? */
 
     /* Fields for migration compatibility hacks */
-    bool pre_2_8_migration;
-    uint32_t mig_liobn;
-    hwaddr mig_mem_win_addr, mig_mem_win_size;
-    hwaddr mig_io_win_addr, mig_io_win_size;
     bool pre_5_1_assoc;
 };
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f7a2da2bbe..30dba050f6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1457,11 +1457,6 @@ struct ArchCPU {
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
 
     /* Fields related to migration compatibility hacks */
-    bool pre_2_8_migration;
-    target_ulong mig_msr_mask;
-    uint64_t mig_insns_flags;
-    uint64_t mig_insns_flags2;
-    uint32_t mig_nb_BATs;
     bool pre_2_10_migration;
     bool pre_3_0_migration;
     int32_t mig_slb_nr;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9..7768392986 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,7 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 }
 
 static Property ppc_cpu_properties[] = {
-    DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
                      false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d433fd45fc..21bed7c7c8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -118,13 +118,6 @@ static const VMStateInfo vmstate_info_vsr = {
 #define VMSTATE_VSR_ARRAY(_f, _s, _n)                             \
     VMSTATE_VSR_ARRAY_V(_f, _s, _n, 0)
 
-static bool cpu_pre_2_8_migration(void *opaque, int version_id)
-{
-    PowerPCCPU *cpu = opaque;
-
-    return cpu->pre_2_8_migration;
-}
-
 #if defined(TARGET_PPC64)
 static bool cpu_pre_3_0_migration(void *opaque, int version_id)
 {
@@ -139,22 +132,6 @@ static int cpu_pre_save(void *opaque)
     PowerPCCPU *cpu = opaque;
     CPUPPCState *env = &cpu->env;
     int i;
-    uint64_t insns_compat_mask =
-        PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB
-        | PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES
-        | PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES
-        | PPC_FLOAT_STFIWX | PPC_FLOAT_EXT
-        | PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ
-        | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | PPC_MEM_TLBSYNC
-        | PPC_64B | PPC_64BX | PPC_ALTIVEC
-        | PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD;
-    uint64_t insns_compat_mask2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX
-        | PPC2_PERM_ISA206 | PPC2_DIVE_ISA206
-        | PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206
-        | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207
-        | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207
-        | PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_TM
-        | PPC2_MEM_LWSYNC;
 
     env->spr[SPR_LR] = env->lr;
     env->spr[SPR_CTR] = env->ctr;
@@ -177,29 +154,6 @@ static int cpu_pre_save(void *opaque)
         env->spr[SPR_IBAT4U + 2 * i + 1] = env->IBAT[1][i + 4];
     }
 
-    /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
-    if (cpu->pre_2_8_migration) {
-        /*
-         * Mask out bits that got added to msr_mask since the versions
-         * which stupidly included it in the migration stream.
-         */
-        target_ulong metamask = 0
-#if defined(TARGET_PPC64)
-            | (1ULL << MSR_TS0)
-            | (1ULL << MSR_TS1)
-#endif
-            ;
-        cpu->mig_msr_mask = env->msr_mask & ~metamask;
-        cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
-        /*
-         * CPU models supported by old machines all have
-         * PPC_MEM_TLBIE, so we set it unconditionally to allow
-         * backward migration from a POWER9 host to a POWER8 host.
-         */
-        cpu->mig_insns_flags |= PPC_MEM_TLBIE;
-        cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
-        cpu->mig_nb_BATs = env->nb_BATs;
-    }
     if (cpu->pre_3_0_migration) {
         if (cpu->hash64_opts) {
             cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
@@ -760,12 +714,6 @@ const VMStateDescription vmstate_ppc_cpu = {
         /* Backward compatible internal state */
         VMSTATE_UINTTL(env.hflags_compat_nmsr, PowerPCCPU),
 
-        /* Sanity checking */
-        VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_insns_flags2, PowerPCCPU,
-                            cpu_pre_2_8_migration),
-        VMSTATE_UINT32_TEST(mig_nb_BATs, PowerPCCPU, cpu_pre_2_8_migration),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-- 
2.45.2


