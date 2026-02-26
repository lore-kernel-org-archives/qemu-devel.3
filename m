Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE9FFD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiL-0005KP-U8; Thu, 26 Feb 2026 10:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiJ-0005J9-6E
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:43 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiH-0003jN-8T
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43984d7e49bso923876f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121340; x=1772726140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hTymfPw5nmljxwGgSjMdb3hfuVynPpInJ9OQiqTcV8=;
 b=YvQdDFNAd2TwdIkMxqauvxfHvvMi8W552PcL5iuWM+k7PUtX+SdV03bTFA5ENhlDOz
 XOXWcpYOTv+BL8XHrotd++ZaYCignVt+0nA1wBK8Fk9KZgyIPRYo/vAgt2A+9R1z/0zI
 lBIKyahR9I4YZXeQ8RCOASjuldH0Poxn1zGKtfv9mhavnMoPVJBbKREIGl7o+lcBUPGH
 h4pgca5DADOllwgTNs+mqbWZ8xJndA3vGZETA2/wx9GsfasAXKIQj4+GqTZPpKyeBEaO
 ItRtl9RQAt6GPwxdV7k35GJBuFU72hgTVlku8h+/4dzHGF9zzeBhBV9mZydYbgQV7OJD
 YjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121340; x=1772726140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+hTymfPw5nmljxwGgSjMdb3hfuVynPpInJ9OQiqTcV8=;
 b=hhzuYBu8QZ4SpFlCDxbpUUAa+hLcU8rLfAdCkRzRoxQUwS9MjwWvtXh0uvOE1YqUq0
 pSKBtFIricnByYjOQNjaUmPFIJ0NyGowfFxRHGvMQt3l0aLHUcdWCiFK2gvU/IFoEMdp
 YLFXDVeNTInr5SOaPMT5sW1PGLlnddWjfgUosuTq8z1BV0ztTzAqBeHg69RG4zJPYx7f
 f65OLoJDI4LtbEunho2Kdrixyvp36z3nIVmvYypOj+bleVkbELTLwjLl70418ERS/M8W
 CASGcrqxaTBY73+rDOD6UzqsfKaqDHZ+IvKzdJiXxoCR2k8qd4naFwNCANfm4tZXhfJf
 2e0g==
X-Gm-Message-State: AOJu0Yxy5CYz6+/ASxVuJgiMDF1gKFdZIkeCqlAfp5ivM/tsyzq02xaw
 h29TypoEdw+2kVujIavnNM/5SPOs6PE+9PNa7UU45RAakKavwbEWaN0v64V3cxYJovrRwKetTjP
 ZQHaw
X-Gm-Gg: ATEYQzwGnhE9w9GZwOzH8TmgmhNPEPOh1iDQUr35NGd1XJ4m1/Z+sxN1/mkLTYoPJ9j
 M4PfOFTaiMcIFOrQ7xGcdvifE21WYv85n4WQqDxAN8n1IU8HwhTH/yEpRLlyp8CyjtT+BRWyxED
 d0X2aGMMNlyo/ZjgHP1qxz5l6nMSKAv8/PQenXH60Hv8uPvFRT2Nbd1EAwYIdEEBcI1nB8NdtzU
 iQQJsUFz4FEuooDgQl/mzG1nf8yBsMW/u7BMrzR3BSEAe98Aboja9SbR/2wW1b0wiKKTqyDe/LH
 KAEERHjVrlE7VtYFi17h0qBHZtn/R2ff1akCn0CPzjYBvF1GOkgYpNB7vDD8BGFLeOEMibJHsDH
 VE30RT1tg4KxH+MnZ1ItH5X1JZLObp77xGgJ5WGSC2bKjoMH1yXhjAOO/xKrPQvDvlkDAw8W1Dr
 rEC3IqUOPklL0C0fR5BznLrDbOZz8lvgULBAatODSSNhhQApkDd4pAZEvpGfO09Z27vKuCEQ4Lk
 ZpniHBvIbiy90G3ZBRCj4eTqhEdXkHrJADr5XTBSg==
X-Received: by 2002:a05:6000:184d:b0:437:6661:fcc9 with SMTP id
 ffacd0b85a97d-43997f3a499mr5004318f8f.50.1772121339569; 
 Thu, 26 Feb 2026 07:55:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] hw/arm/virt: Add virtio-mmio-transports property
Date: Thu, 26 Feb 2026 15:55:18 +0000
Message-ID: <20260226155535.1171290-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Windows ARM64 guests detect virtio-mmio devices declared in ACPI
tables even when no backend is attached. This causes "Unknown
devices" (ACPI\LNRO0005) to appear in Device Manager.

Until Windows fixes that by supporting, add a new machine
property 'virtio-mmio-transports' to control the number of
virtio-mmio transports instantiated. The default remains
NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
Setting it to 0 allows users to disable virtio-mmio entirely.

Usage: -machine virt,virtio-mmio-transports=0

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Message-id: 20260219173256.152743-1-mbawa@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst |  5 +++++
 hw/arm/virt-acpi-build.c |  2 +-
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h    |  1 +
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f8148b5dcf..fbe3ca9e12 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -226,6 +226,11 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+virtio-mmio-transports
+  Set the number of virtio-mmio transports to create (between 0 and 32;
+  the default is 32).  Unused transports are harmless, but you can
+  use this property to avoid exposing them to the guest if you wish.
+
 x-oem-id
   Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
   table header.
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 544004615d..719d2f994e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1154,7 +1154,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
     virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base, memmap[VIRT_MMIO].size,
                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
-                         0, NUM_VIRTIO_TRANSPORTS);
+                         0, vms->virtio_transports);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 50865e8115..81e700f516 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1208,7 +1208,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      * between kernel versions). For reliable and stable identification
      * of disks users must use UUIDs or similar mechanisms.
      */
-    for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
+    for (i = 0; i < vms->virtio_transports; i++) {
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
@@ -1223,7 +1223,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      * loop influences virtio device to virtio transport assignment, whereas
      * this loop controls how virtio transports are laid out in the dtb.
      */
-    for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
+    for (i = vms->virtio_transports - 1; i >= 0; i--) {
         char *nodename;
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
@@ -2826,6 +2826,36 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     }
 }
 
+static void virt_get_virtio_transports(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint8_t transports = vms->virtio_transports;
+
+    visit_type_uint8(v, name, &transports, errp);
+}
+
+static void virt_set_virtio_transports(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint8_t transports;
+
+    if (!visit_type_uint8(v, name, &transports, errp)) {
+        return;
+    }
+
+    if (transports > NUM_VIRTIO_TRANSPORTS) {
+        error_setg(errp, "virtio-mmio-transports must not exceed %d",
+                   NUM_VIRTIO_TRANSPORTS);
+        return;
+    }
+
+    vms->virtio_transports = transports;
+}
+
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3535,6 +3565,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
+                                   virt_get_virtio_transports,
+                                   virt_set_virtio_transports,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "virtio-mmio-transports",
+                                          "Set the number of virtio-mmio transports to instantiate");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
@@ -3654,6 +3691,8 @@ static void virt_instance_init(Object *obj)
 
     vms->irqmap = a15irqmap;
 
+    vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
+
     virt_flash_create(vms);
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8069422769..dba8ac7f2f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -172,6 +172,7 @@ struct VirtMachineState {
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
+    uint8_t virtio_transports;
     hwaddr highest_gpa;
     DeviceState *gic;
     DeviceState *acpi_dev;
-- 
2.43.0


