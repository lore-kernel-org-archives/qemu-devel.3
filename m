Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA617C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9CX-0002Vb-RO; Thu, 20 Feb 2025 11:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tl9CV-0002Tk-AE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:14:59 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tl9CS-0007Lw-21
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:14:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f26a82d1dso670056f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068094; x=1740672894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPcuP887g9uPdc+DuVuyqpmDVpNdrQdWC0SI6zKSAgE=;
 b=K3hZfRwP8SbfHPw8G7vDlQ2/rOwEytVzZaGJWNAK6FGBe2cj5EVa4r6m+0IcOvqwU4
 E2WlEViuqe/G56SxHpIF6gz2HoVAn9m87BlBoYcfzKYqgtGxgLucC1gKXHihnmI4hp2v
 AnygA6X21DsMEh//uIwpVeWzQ1AFrFa15GcXviIHSs58PN5TjJPt71XlanR4Sr3X4j0T
 ZeY/jxrwzTFcvnElGj/VqN2//RaCX5t73gJ2Qaf6KiB9hi5hA16xJMPJg6Wbgix1eLUU
 Ak55GhQ6U+f3HjDskSqkSl7tzoSJPUGWpWYfaci8DyuLvomNJNHUUY4XkSnoPEcIutAl
 jIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068094; x=1740672894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPcuP887g9uPdc+DuVuyqpmDVpNdrQdWC0SI6zKSAgE=;
 b=f7FLLfSL0TM3jwnz6+TNorrpoMXUXLTUJOkVm2/nFWvZfqCMnJRBxoUatv+qbgcoYs
 gNfphwflE14RW/Z6RWDctchSZB5sKHKZfSp5hUGJUBdOn+soklhx4KUYiaDHjI7Z66/f
 K0/4TXsNQvnKAno7Bg1otfe9ScJ6Ou56MfM0tmL00/yhjIfedFcYQdAae19h3mr18BNv
 Ob7UvuWxwVQ+MC+e7g+EhGnsCRpV0/I19nQN5KUED39IBuZ5qkDUeWhg5m/v7opOHCk0
 PSEkWEpldyKjQQXwZFwweanosOkpY0PoUzY9tBWYgGaW/TMbJf+9MKopWG3OCvkzfHP/
 8dHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGqBJE85MbNUgUshPfEv7S+8Ua5NOA25IwowrLgW7rsOU+nf7XuU0DmU36NBsMYzAQ9MzYKHVZXOm@nongnu.org
X-Gm-Message-State: AOJu0YxIDA1X9i157afMhgFl41+dEvVbo/OY/oqmVVnotlTaqXLpTrIg
 XiK7AenpCdDm2k/ytNa6lZ23GqAxfIwfYsYPd1HZNThtDODXPkZTQGJN3A+S1OI=
X-Gm-Gg: ASbGncuuG1sAQgFtRtqIE17Lagfsl9Ulj6BPGK1Gb7wdf5Hv0qOJo46JxfSZBLPpO4/
 xVhrM7RxIviCHbG5dt1+oB2asvlP4x49kp/Qt5ek6ge6zvXG9M9FiHyFy267c0XlIUoPjINZ76K
 3/bmT22GyfBbuE7eTMIxpNE7auMcKV9BxCT5bMuIwFg+N3J5e7P8nrhb1cKde7Ux8OyfDF9P72Z
 qLlDlG4QxG5aTpJeeJ7OspjniKGnlqVdMVaEQvziV9Lz8+PdfRuJFyg1adc/v9xr+2Ups4LPw0E
 SIfrvkS0Cr0IoixZeyY9FWbkf2zSqpj5fQ==
X-Google-Smtp-Source: AGHT+IEzINUpBd2aCwMxNXFxsaEd5J+Td3+/8WnswiDQTbbHxF2H5B92/rGgvRz14eX08m8nDNpzww==
X-Received: by 2002:a5d:6ac1:0:b0:38f:229a:b48 with SMTP id
 ffacd0b85a97d-38f33f34e0fmr16937055f8f.32.1740068094419; 
 Thu, 20 Feb 2025 08:14:54 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fe1efsm21197741f8f.97.2025.02.20.08.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:14:54 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: philmd@linaro.org, david@redhat.com, peterx@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 2/2] target/arm/kvm-rme: Add DMA remapping for the shared memory
 region
Date: Thu, 20 Feb 2025 16:13:21 +0000
Message-ID: <20250220161320.518450-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220161320.518450-2-jean-philippe@linaro.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x432.google.com
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

In Arm CCA, the guest-physical address space is split in half. The top
half represents memory shared between guest and host, and the bottom
half is private to the guest. From QEMU's point of view, the two halves
are merged into a single region, and pages within this region are
either shared or private.

Addresses used by device DMA can potentially target both halves.
Physical devices assigned to the VM access the top half, until they are
authenticated using features like PCIe CMA-SPDM at which point they can
also access memory private to the guest.

Virtual devices implemented by the host are only allowed to access the
top half. For emulated MMIO, KVM strips the GPA before returning to
QEMU, so the GPA already belongs to QEMU's merged view of guest memory.
However DMA addresses cannot be stripped this way and need special
handling by the VMM:

* When emulating DMA the VMM needs to translate the addresses into its
  merged view. Add an IOMMU memory region on the top half, that
  retargets DMA accesses to the merged sysmem.

* when creating IOMMU mappings for (unauthenticated) VFIO devices, the VMM
  needs to map the top half of guest-physical addresses to the shared pages.
  Install RAM discard listeners that issue IOMMU map and unmap requests
  to IOMMU listeners such as VFIO.

The resulting mtree looks like this:

  address-space: vfio-pci
    0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container
      0000000000000000-000001ffffffffff (prio 0, i/o): alias bus master @realm-dma-region 0000000000000000-000001ffffffffff

  memory-region: realm-dma-region
    0000000000000000-000001ffffffffff (prio 0, i/o): realm-dma-region

There are at least two problems with this approach: given that we use
the PCI bus master address space, a vIOMMU cannot install its own
address space at the moment. And since sysbus devices can't have an
IOMMU at the moment, DMA from non-PCI devices isn't supported.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm_arm.h |  15 +++
 hw/arm/virt.c        |   2 +
 target/arm/kvm-rme.c | 220 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ede6a7138c..13f2d76e2a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -268,6 +268,16 @@ int kvm_arm_rme_vcpu_init(CPUState *cs);
  */
 void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
 
+/**
+ * kvm_arm_rme_setup_gpa
+ * @highest_gpa: highest address of the lower half of the guest address space
+ * @pci_bus: The main PCI bus, for which PCI queries DMA address spaces
+ *
+ * Setup the guest-physical address space for a Realm. Install a memory region
+ * and notifier to manage the shared upper half of the address space.
+ */
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus);
+
 #else
 
 /*
@@ -298,6 +308,11 @@ static inline void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
 {
 }
 
+static inline void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa,
+                                              PCIBus *pci_bus)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d14f54e3be..c28b2cc3ac 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2456,6 +2456,8 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_init_gpa_space(vms->highest_gpa, vms->bus);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index ad099bffbb..f21499f699 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
+#include "hw/pci/pci.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -24,6 +25,35 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
+/*
+ * Realms have a split guest-physical address space: the bottom half is private
+ * to the realm, and the top half is shared with the host. Within QEMU, we use a
+ * merged view of both halves. Most of RAM is private to the guest and not
+ * accessible to us, but the guest shares some pages with us.
+ *
+ * For DMA, devices generally target the shared half (top) of the guest address
+ * space. Only the devices trusted by the guest (using mechanisms like TDISP for
+ * device authentication) can access the bottom half.
+ *
+ * RealmDmaRegion performs remapping of top-half accesses to system memory.
+ */
+struct RealmDmaRegion {
+    IOMMUMemoryRegion parent_obj;
+};
+
+#define TYPE_REALM_DMA_REGION "realm-dma-region"
+OBJECT_DECLARE_SIMPLE_TYPE(RealmDmaRegion, REALM_DMA_REGION)
+OBJECT_DEFINE_SIMPLE_TYPE(RealmDmaRegion, realm_dma_region,
+                          REALM_DMA_REGION, IOMMU_MEMORY_REGION);
+
+typedef struct RealmRamDiscardListener {
+    MemoryRegion *mr;
+    hwaddr offset_within_region;
+    uint64_t granularity;
+    RamDiscardListener listener;
+    QLIST_ENTRY(RealmRamDiscardListener) rrdl_next;
+} RealmRamDiscardListener;
+
 typedef struct {
     hwaddr base;
     hwaddr size;
@@ -39,6 +69,12 @@ struct RmeGuest {
     RmeGuestMeasurementAlgorithm measurement_algo;
 
     RmeRamRegion init_ram;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    QLIST_HEAD(, RealmRamDiscardListener) ram_discard_list;
+    MemoryListener memory_listener;
+    AddressSpace dma_as;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -305,6 +341,7 @@ static void rme_guest_init(Object *obj)
 
 static void rme_guest_finalize(Object *obj)
 {
+    memory_listener_unregister(&rme_guest->memory_listener);
 }
 
 static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
@@ -405,3 +442,186 @@ int kvm_arm_rme_vm_type(MachineState *ms)
     }
     return 0;
 }
+
+static int rme_ram_discard_notify(RamDiscardListener *rdl,
+                                  MemoryRegionSection *section,
+                                  bool populate)
+{
+    hwaddr gpa, next;
+    IOMMUTLBEvent event;
+    const hwaddr end = section->offset_within_address_space +
+                       int128_get64(section->size);
+    const hwaddr address_mask = MAKE_64BIT_MASK(0, rme_guest->ipa_bits - 1);
+    RealmRamDiscardListener *rrdl = container_of(rdl, RealmRamDiscardListener,
+                                                 listener);
+
+    assert(rme_guest->dma_region != NULL);
+
+    event.type = populate ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP;
+    event.entry.target_as = &address_space_memory;
+    event.entry.perm = populate ? (IOMMU_RW | IOMMU_POPULATING) : IOMMU_NONE;
+    event.entry.addr_mask = rrdl->granularity - 1;
+
+    assert(end <= address_mask);
+
+    /*
+     * Create IOMMU mappings from the top half of the address space to the RAM
+     * region.
+     */
+    for (gpa = section->offset_within_address_space; gpa < end; gpa = next) {
+        event.entry.iova = gpa + address_mask + 1;
+        event.entry.translated_addr = gpa;
+        memory_region_notify_iommu(IOMMU_MEMORY_REGION(rme_guest->dma_region),
+                                   0, event);
+
+        next = ROUND_UP(gpa + 1, rrdl->granularity);
+        next = MIN(next, end);
+    }
+
+    return 0;
+}
+
+static int rme_ram_discard_notify_populate(RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
+{
+    return rme_ram_discard_notify(rdl, section, /* populate */ true);
+}
+
+static void rme_ram_discard_notify_discard(RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
+{
+    rme_ram_discard_notify(rdl, section, /* populate */ false);
+}
+
+/* Install a RAM discard listener */
+static void rme_listener_region_add(MemoryListener *listener,
+                                    MemoryRegionSection *section)
+{
+    RealmRamDiscardListener *rrdl;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
+
+    if (!rdm) {
+        return;
+    }
+
+    rrdl = g_new0(RealmRamDiscardListener, 1);
+    rrdl->mr = section->mr;
+    rrdl->offset_within_region = section->offset_within_region;
+    rrdl->granularity = ram_discard_manager_get_min_granularity(rdm,
+                                                                section->mr);
+    QLIST_INSERT_HEAD(&rme_guest->ram_discard_list, rrdl, rrdl_next);
+
+    ram_discard_listener_init(&rrdl->listener,
+                              rme_ram_discard_notify_populate,
+                              rme_ram_discard_notify_discard, true);
+    ram_discard_manager_register_listener(rdm, &rrdl->listener, section);
+}
+
+static void rme_listener_region_del(MemoryListener *listener,
+                                    MemoryRegionSection *section)
+{
+    RealmRamDiscardListener *rrdl;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
+
+    if (!rdm) {
+        return;
+    }
+
+    QLIST_FOREACH(rrdl, &rme_guest->ram_discard_list, rrdl_next) {
+        if (MEMORY_REGION(rrdl->mr) == section->mr &&
+            rrdl->offset_within_region == section->offset_within_region) {
+            ram_discard_manager_unregister_listener(rdm, &rrdl->listener);
+            g_free(rrdl);
+            break;
+        }
+    }
+}
+
+static AddressSpace *rme_dma_get_address_space(PCIBus *bus, void *opaque,
+                                               int devfn)
+{
+    return &rme_guest->dma_as;
+}
+
+static const PCIIOMMUOps rme_dma_ops = {
+    .get_address_space = rme_dma_get_address_space,
+};
+
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus)
+{
+    RealmDmaRegion *dma_region;
+    const unsigned int ipa_bits = 64 - clz64(highest_gpa) + 1;
+
+    if (!rme_guest) {
+        return;
+    }
+
+    assert(ipa_bits < 64);
+
+    /*
+     * Setup a DMA translation from the shared top half of the guest-physical
+     * address space to our merged view of RAM.
+     */
+    dma_region = g_new0(RealmDmaRegion, 1);
+
+    memory_region_init_iommu(dma_region, sizeof(*dma_region),
+                             TYPE_REALM_DMA_REGION, OBJECT(rme_guest),
+                             "realm-dma-region", 1ULL << ipa_bits);
+    address_space_init(&rme_guest->dma_as, MEMORY_REGION(dma_region),
+                       TYPE_REALM_DMA_REGION);
+    rme_guest->dma_region = dma_region;
+
+    pci_setup_iommu(pci_bus, &rme_dma_ops, NULL);
+
+    /*
+     * Install notifiers to forward RAM discard changes to the IOMMU notifiers
+     * (ie. tell VFIO to map shared pages and unmap private ones).
+     */
+    rme_guest->memory_listener = (MemoryListener) {
+        .name = "rme",
+        .region_add = rme_listener_region_add,
+        .region_del = rme_listener_region_del,
+    };
+    memory_listener_register(&rme_guest->memory_listener,
+                             &address_space_memory);
+
+    rme_guest->ipa_bits = ipa_bits;
+}
+
+static void realm_dma_region_init(Object *obj)
+{
+}
+
+static IOMMUTLBEntry realm_dma_region_translate(IOMMUMemoryRegion *mr,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flag,
+                                                int iommu_idx)
+{
+    const hwaddr address_mask = MAKE_64BIT_MASK(0, rme_guest->ipa_bits - 1);
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr & address_mask,
+        .addr_mask = address_mask,
+        .perm = IOMMU_RW,
+    };
+
+    return entry;
+}
+
+static void realm_dma_region_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    /* Nothing is shared at boot */
+}
+
+static void realm_dma_region_finalize(Object *obj)
+{
+}
+
+static void realm_dma_region_class_init(ObjectClass *oc, void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(oc);
+
+    imrc->translate = realm_dma_region_translate;
+    imrc->replay = realm_dma_region_replay;
+}
-- 
2.48.1


