Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A696C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeO-0007J9-Bz; Wed, 14 May 2025 07:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe8-0006iL-3b
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe1-0006RC-As
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kC7ms8CkFAeJfPlGtEIrneI+byr9crqmZ1MqZFtR2F4=;
 b=HeDgDoCCDDF9hy4GT12DiLXMlNP6WuJW81IhK4XGp94neRMdXiQNToXchsat4zxcfl1PGd
 HbxQPp3ntde/zfCmMznMb//zQdIwkXgXNl7hOGYh21Iz8TsSK+TQg1rnVefVIKFNT4LRoA
 2kKtLSzkl9IeYBd+5i725lLzVXfnEVw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-gAhHnZ7nNuqxVdAM3NZ4sA-1; Wed, 14 May 2025 07:51:27 -0400
X-MC-Unique: gAhHnZ7nNuqxVdAM3NZ4sA-1
X-Mimecast-MFC-AGG-ID: gAhHnZ7nNuqxVdAM3NZ4sA_1747223486
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a20257c758so2483131f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223485; x=1747828285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kC7ms8CkFAeJfPlGtEIrneI+byr9crqmZ1MqZFtR2F4=;
 b=oPR2oTIPLpk807yI9tS3KTgp6/E3lC8ltVVQ8wDbNfllXtLXnIqqy1cFojBddL6rcE
 ZmL6X2r893JDZSIwgeB1F95/mTXY4JCCJgjrwdz9M7EXXj/W/zD/5cSofD9HKkMFpZTK
 hyLWLHPcWbvMOkMinQRBj1FBkZ/askfCUSIfpbb8ghQJQs0/ByekAwYVzkrWbka9+/qu
 cmsTemkVXo6hmQgQpyyvjbupDzyh8Vrb8ASRhDa+994zFEByymj0hZYqheJHJPu0Kx1Y
 mFwRxRF1Ju0rAUC36zGuwEhkxllwtUPoQGeJOU2GxSn6vW9Yk4D11zN3Kd6l0L6ZCuTI
 aajw==
X-Gm-Message-State: AOJu0YwqBcPhwNy/D8nPyRLhPXtzZnx/n4Xs4gpjlArMPq4XAH9+d5zk
 cFKglKFciRN58sb1ttdo3cdvFbN3VR01biG2PD3OXjdM537+mh69dru5Fu+v0srSgykJfOXmRWq
 ZHibcfouKmRV7nksPheVEE8O2srUu9DB7bw9DIGLt5MVWmqCj3VbbsKSsjHimWagMjEillB2p4C
 q7CgxpNTJhcb3TWLPCtu8GrmzsgCIh7Q==
X-Gm-Gg: ASbGncsMI+neKWhYdyQZaNyoexcXRSaYIMzge8BuACeu2tUrZOVZMvmBFEFmpCTOB0O
 EcfOUg3m5juLpN06vDK229iK1krM98jrKLASTmEz/ars1iJVEfB8mqa3ddPbWifXmSoW0kOLZVw
 a/O6xkloBs4PYKx5sF+amKJkKg7wSeq4BWBQDHF1HrWjslpPUys7XGGw3d7MdLahUqa4HPmI0+h
 +hoWuNAzLYEvbrB9JitQUBkIaT1xPPlx9U1XNe3gjCulwbPO3NXqIU/0eFtwQ+LX7/Zx4YuuTHw
 Pexilw==
X-Received: by 2002:a05:6000:2a6:b0:3a0:7b07:157 with SMTP id
 ffacd0b85a97d-3a34969a0cfmr2899126f8f.9.1747223485535; 
 Wed, 14 May 2025 04:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFyzPRjxLoKwZ+L+YNoJ0/tRzNUQnXUV6Y6M0PnORINRPFx10xSFhkLLvtzNT5K0A+mKaL3Q==
X-Received: by 2002:a05:6000:2a6:b0:3a0:7b07:157 with SMTP id
 ffacd0b85a97d-3a34969a0cfmr2899087f8f.9.1747223485047; 
 Wed, 14 May 2025 04:51:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebd75sm19795850f8f.34.2025.05.14.04.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:24 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 26/27] hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu
 device to allow full control over the PCI device creation
Message-ID: <f864a3235ea1d1d714b3cde2d9a810ea6344a7b5.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Current amd-iommu model internally creates an AMDVI-PCI device. Here is
a snippet from info qtree:

  bus: main-system-bus
    type System
    dev: amd-iommu, id ""
      xtsup = false
      pci-id = ""
      intremap = "on"
      device-iotlb = false
      pt = true
    ...
    dev: q35-pcihost, id ""
      MCFG = -1 (0xffffffffffffffff)
      pci-hole64-size = 34359738368 (32 GiB)
      below-4g-mem-size = 134217728 (128 MiB)
      above-4g-mem-size = 0 (0 B)
      smm-ranges = true
      x-pci-hole64-fix = true
      x-config-reg-migration-enabled = true
      bypass-iommu = false
      bus: pcie.0
        type PCIE
        dev: AMDVI-PCI, id ""
          addr = 01.0
          romfile = ""
          romsize = 4294967295 (0xffffffff)
          rombar = -1 (0xffffffffffffffff)
          multifunction = false
          x-pcie-lnksta-dllla = true
          x-pcie-extcap-init = true
          failover_pair_id = ""
          acpi-index = 0 (0x0)
          x-pcie-err-unc-mask = true
          x-pcie-ari-nextfn-1 = false
          x-max-bounce-buffer-size = 4096 (4 KiB)
          x-pcie-ext-tag = true
          busnr = 0 (0x0)
          class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)
    ...

This prohibits users from specifying the PCI topology for the amd-iommu device,
which becomes a problem when trying to support VM migration since it does not
guarantee the same enumeration of AMD IOMMU device.

Therefore, allow the 'AMDVI-PCI' device to optionally be pre-created and
associated with a 'amd-iommu' device via a new 'pci-id' parameter on the
latter.

For example:
  -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
  -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \

For backward-compatibility, internally create the AMDVI-PCI device if not
specified on the CLI.

Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20250504170405.12623-2-suravee.suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h  |  3 ++-
 hw/i386/acpi-build.c |  8 +++----
 hw/i386/amd_iommu.c  | 53 ++++++++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 28125130c6..7a28181d9c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -315,7 +315,8 @@ struct AMDVIPCIState {
 
 struct AMDVIState {
     X86IOMMUState iommu;        /* IOMMU bus device             */
-    AMDVIPCIState pci;          /* IOMMU PCI device             */
+    AMDVIPCIState *pci;         /* IOMMU PCI device             */
+    char *pci_id;               /* ID of AMDVI-PCI device, if user created */
 
     uint32_t version;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f40ad062f9..61851cc840 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2333,10 +2333,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
@@ -2368,10 +2368,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2cf7e24a21..f5466fdc98 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -167,11 +167,11 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
     MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci.dev)
+        .requester_id = pci_requester_id(&s->pci->dev)
     };
 
-    if (msi_enabled(&s->pci.dev)) {
-        msg = msi_get_message(&s->pci.dev, 0);
+    if (msi_enabled(&s->pci->dev)) {
+        msg = msi_get_message(&s->pci->dev, 0);
         address_space_stl_le(&address_space_memory, msg.address, msg.data,
                              attrs, NULL);
     }
@@ -239,7 +239,7 @@ static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_IOPF_I | AMDVI_EVENT_IOPF;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /*
@@ -256,7 +256,7 @@ static void amdvi_log_devtab_error(AMDVIState *s, uint16_t devid,
 
     amdvi_encode_event(evt, devid, devtab, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an event trying to access command buffer
@@ -269,7 +269,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
 
     amdvi_encode_event(evt, 0, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an illegal command event
@@ -310,7 +310,7 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_PAGE_TAB_HW_ERROR;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
@@ -1607,7 +1607,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 {
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
 
-    msi_reset(&s->pci.dev);
+    msi_reset(&s->pci->dev);
     amdvi_init(s);
 }
 
@@ -1619,14 +1619,32 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
 
+    if (s->pci_id) {
+        PCIDevice *pdev = NULL;
+        int ret = pci_qdev_find_device(s->pci_id, &pdev);
+
+        if (ret) {
+            error_report("Cannot find PCI device '%s'", s->pci_id);
+            return;
+        }
+
+        if (!object_dynamic_cast(OBJECT(pdev), TYPE_AMD_IOMMU_PCI)) {
+            error_report("Device '%s' must be an AMDVI-PCI device type", s->pci_id);
+            return;
+        }
+
+        s->pci = AMD_IOMMU_PCI(pdev);
+    } else {
+        s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
+        /* This device should take care of IOMMU PCI properties */
+        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
+            return;
+        }
+    }
+
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
-    /* This device should take care of IOMMU PCI properties */
-    if (!qdev_realize(DEVICE(&s->pci), &bus->qbus, errp)) {
-        return;
-    }
-
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
@@ -1663,6 +1681,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
@@ -1670,13 +1689,6 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
     .unmigratable = 1
 };
 
-static void amdvi_sysbus_instance_init(Object *klass)
-{
-    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
-
-    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
-}
-
 static void amdvi_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1696,7 +1708,6 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .instance_init = amdvi_sysbus_instance_init,
     .class_init = amdvi_sysbus_class_init
 };
 
-- 
MST


