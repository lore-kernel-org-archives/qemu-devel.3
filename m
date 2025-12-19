Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C831E6689C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiud-0001mK-43; Fri, 19 Dec 2025 17:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuc-0001m4-Jd
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:26 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiua-00053s-K5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:26 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so1918324a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183123; x=1766787923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjDRdqd+e+TYCi+OeSwauNQsmxDgIH4owMF2laRxHAg=;
 b=R+dzKPDoQhPX7owZooAgkExDH1p6EMazlck7BLDb2wfeWryuAhrK58y3FVcZ2+rHOv
 DaRNDmlwjFeWrhUksoFf1QdbRO59uWSPr6Z99bWybb9JEsTqQbBzcKWShIVIpK3MMAYc
 8AzSaEmtzdTATIPb2jEo0UEyTa5wtfW9LYrzvxvgLJHJAeCcZicecpDOQi0iEAeGVSzN
 12Q6H8UQz+p9XOVpYBu60nQXfVL3SksffAI87Bs8OuoXuNECyRtWDTF9Pf6zq6Gwz09R
 2mMPeYALEzk//lGUFy3+ouCy8zhVFXWd59Mv5MEulBch8JrqFYOiNqB7nQk/wHAlro3W
 dI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183123; x=1766787923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjDRdqd+e+TYCi+OeSwauNQsmxDgIH4owMF2laRxHAg=;
 b=CaZ5hKIGzw4zdckFmfRZBXu3p2MS93Qo5yMiPkvUIc5fzVM7AjXdyyiBoOxG7M/hAP
 UkmY4CuCXnef5GqOBMVF9vKg0/GCJuQAcX2D472r3y9Wy+rvTTP+JI5nh1blQzzy08fm
 3qSBiIv3coH/CIRYFKJus/msKccZ/y7ZCBCrfWAPBJQoiHQGzIbphB8dWE0CBOQ2cT0G
 f+Z0Bnrahlgdp7ABoOhUqd5rw6/KmSqL2rcI20WucMTJE3PMy07N9eYFVG75y9zMrylC
 vBdJxeXjJ6j1TRGYPbOAde5P1WW++pI0pwVumO+EYWrkZDEL98ru4AK5y3BDKimgokqu
 ADuw==
X-Gm-Message-State: AOJu0Yxr/V404N+niaFli6HODbdz22V+KFs5CVhYcfxF+lmfAup++RYJ
 f+3ZeAw+mzqorOM7Jn2kQ9DIWS0kNUXOeLKaHXXtPNytJnv4fRJH3+aScXBfkM+n
X-Gm-Gg: AY/fxX4yArHl4sd355PwJGqVuJbg5Hlgdlja7I36vUinVPJ9Ub/1AcWFB2XG8YcRlg4
 L9TSRFeCKKOQs0HT7NO3rTMdqqPP6/LeiynofqrAmV0WNh5laJrDIJBcia6Rc+LeDoNkXQltebN
 +m7IQ1knkNskY41+xHcvkEFHmZTkhhfnDq5/aPQirFRQxoH0MkSzWE/AUGfJ9JnVJXnRe6u6sqG
 aIcwh9olnP0kUU+fTZtTNH+dsmCPTJuDO2n9ImOWqafYGQLoPoEvHuTdGuPE0/AyyfCFrMOv8Q/
 dgu77p54UoNGc6WmGrY2SWpYkX/eX/OBqoRKSGkDBBW/0sHes0YiX/Dp6uU1j9NC1oV/ht+Sxiq
 l0N/p0xr/3P+v+uBcq7z9W65aZwlsurrPZnruEX71X6ltGDLGlnSlA7Z/Ee4e0/S8eb30rfYwJV
 g9W/BfieLgVIuJYN/UtjIQ+6+SIUWU/PXDAK+jQye4b+pzi6WyOyHJJd2O+AV1vrIanlUzIUlR
X-Google-Smtp-Source: AGHT+IEmIcBomE5Pk6YUM8y4RgEwCZB8hFMe/n9525+9GczlzNWBlEiT2s/OVeTnSfyZhPA8GDFBlA==
X-Received: by 2002:a05:6402:3491:b0:649:9159:2432 with SMTP id
 4fb4d7f45d1cf-64b8e94767emr3966978a12.3.1766183122575; 
 Fri, 19 Dec 2025 14:25:22 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:20 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Subject: [RFC PATCH 6/6] hw/arm/smmu-common: add support for multiple
 instances at sysbus
Date: Fri, 19 Dec 2025 23:24:39 +0100
Message-ID: <20251219222439.2497195-7-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x534.google.com
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

The patch adds preliminary support for multiple instances of
SMMU on sysbus.
Introduce generic-bus-iommu-id for each IOMMU and check if it used
on init.

For now, each smmu can be created via static configuration in arm/virt.c.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/smmu-common.c         |  7 ++++---
 hw/arm/virt.c                |  3 ++-
 hw/core/bus.c                | 19 ++++++++++++++++---
 hw/virtio/virtio-mmio.c      | 10 +++++++---
 include/hw/arm/smmu-common.h |  3 ++-
 include/hw/qdev-core.h       | 23 ++++++++++++++++++-----
 include/qemu/typedefs.h      |  1 +
 7 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 52ef49d7f6..10a551b5bc 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -981,8 +981,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
-    if (s->generic_primary_bus ) {
-        bus_setup_iommu(s->generic_primary_bus, &bus_smmu_ops, s);
+    if (s->generic_bus) {
+        bus_setup_iommu(s->generic_bus, s->generic_bus_iommu_id, &bus_smmu_ops, s);
         return;
     }
 
@@ -1041,8 +1041,9 @@ static const Property smmu_dev_properties[] = {
     DEFINE_PROP_BOOL("pci_smmu_per_bus", SMMUState, pci_smmu_per_bus, false),
     DEFINE_PROP_LINK("pci-primary-bus", SMMUState, pci_primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
-    DEFINE_PROP_LINK("generic-primary-bus", SMMUState, generic_primary_bus,
+    DEFINE_PROP_LINK("generic-bus", SMMUState, generic_bus,
                      TYPE_BUS, BusState *),
+    DEFINE_PROP_UINT8("generic-bus-iommu-id", SMMUState, generic_bus_iommu_id, 255u),
 };
 
 static void smmu_base_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ff3eb95036..5ee21234aa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1575,8 +1575,9 @@ static void create_smmu_sysbus(VirtMachineState *vms)
     if (!vmc->no_nested_smmu) {
         object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
     }
-    object_property_set_link(OBJECT(dev), "generic-primary-bus", 
+    object_property_set_link(OBJECT(dev), "generic-bus", 
                              OBJECT(sysbus_get_default()), &error_abort);
+    object_property_set_int(OBJECT(dev), "generic-bus-iommu-id", 0u, &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6d1483fdbd..c26a300546 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -80,7 +80,7 @@ bool bus_is_in_reset(BusState *bus)
     return resettable_is_in_reset(OBJECT(bus));
 }
 
-void bus_setup_iommu(BusState *bus, const BusIOMMUOps *ops, void *opaque)
+void bus_setup_iommu(BusState *bus, uint8_t iommu_id, const BusIOMMUOps *ops, void *opaque)
 {
     /*
      * If called, bus_setup_iommu() should provide a minimum set of
@@ -89,8 +89,17 @@ void bus_setup_iommu(BusState *bus, const BusIOMMUOps *ops, void *opaque)
     assert(ops);
     assert(ops->get_address_space);
 
-    bus->iommu_ops = ops;
-    bus->iommu_opaque = opaque;
+    /*
+     * Provided IOMMU index shall be in range of valid values.
+     */
+    assert(iommu_id < (sizeof(bus->iommu) / sizeof(bus->iommu[0])));
+    /*
+     * Allocated entry cannot be used!
+     */
+    assert(!bus->iommu[iommu_id].used);
+
+    bus->iommu[iommu_id].iommu_ops = ops;
+    bus->iommu[iommu_id].iommu_opaque = opaque;
 }
 
 static ResettableState *bus_get_reset_state(Object *obj)
@@ -230,6 +239,10 @@ static void qbus_initfn(Object *obj)
 {
     BusState *bus = BUS(obj);
 
+    for (int i = 0u; i < (sizeof(bus->iommu) / sizeof(bus->iommu[0])); i++) {
+        bus->iommu[i].used = false;
+    }
+
     QTAILQ_INIT(&bus->children);
     object_property_add_link(obj, QDEV_HOTPLUG_HANDLER_PROPERTY,
                              TYPE_HOTPLUG_HANDLER,
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 8f19492e3f..214c090ec8 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -1,3 +1,4 @@
+
 /*
  * Virtio MMIO bindings
  *
@@ -37,6 +38,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 
+#define VIRTIO_SYSBUS_IOMMU_ID (0u)
+
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
@@ -874,13 +877,14 @@ static void virtio_mmio_vmstate_change(DeviceState *d, bool running)
 static AddressSpace *virtio_mmio_get_dma_as(DeviceState *parent)
 {
     // BusState *iommu_bus = qdev_get_parent_bus(parent);
+    const uint32_t iommu_id = VIRTIO_SYSBUS_IOMMU_ID;
     BusState *iommu_bus = sysbus_get_default();
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(parent);
     AddressSpace *as = NULL;
 
-    if (iommu_bus && iommu_bus->iommu_ops) {
-        as = iommu_bus->iommu_ops->get_address_space(
-            iommu_bus, iommu_bus->iommu_opaque, proxy->stream_id);
+    if (iommu_bus && iommu_bus->iommu[iommu_id].iommu_ops) {
+        as = iommu_bus->iommu[iommu_id].iommu_ops->get_address_space(
+                iommu_bus, iommu_bus->iommu[iommu_id].iommu_opaque, proxy->stream_id);
     }
 
     return as ? as : &address_space_memory;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 670ae46930..a44c73cf0c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -171,7 +171,8 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *pci_primary_bus;
     bool pci_smmu_per_bus; /* SMMU is specific to the pci_primary_bus */
-    BusState *generic_primary_bus;
+    BusState *generic_bus;
+    uint8_t generic_bus_iommu_id;
 };
 
 struct SMMUBaseClass {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2092450b90..f766213705 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -386,6 +386,20 @@ typedef struct BusIOMMUOps {
     AddressSpace * (*get_address_space)(BusState *bus, void *opaque, int devid);
 } BusIOMMUOps;
 
+/**
+ * struct BusIOMMU:
+ * @iommu_ops: TODO
+ * @iommu_opaque: TODO
+ * @used: TODO
+ */
+struct BusIOMMU {
+    const BusIOMMUOps *iommu_ops;
+    void *iommu_opaque;
+    bool used;
+};
+
+#define BUS_IOMMU_MAX 10
+
 /**
  * struct BusState:
  * @obj: parent object
@@ -396,8 +410,7 @@ typedef struct BusIOMMUOps {
  * @realized: is the bus itself realized?
  * @full: is the bus full?
  * @num_children: current number of child buses
- * @iommu_ops: TODO
- * @iommu_opaque: TODO
+ * @iommu: TODO
  */
 struct BusState {
     /* private: */
@@ -410,8 +423,7 @@ struct BusState {
     bool realized;
     bool full;
     int num_children;
-    const BusIOMMUOps *iommu_ops;
-    void *iommu_opaque;
+    BusIOMMU iommu[BUS_IOMMU_MAX];
 
     /**
      * @children: an RCU protected QTAILQ, thus readers must use RCU
@@ -958,13 +970,14 @@ bool bus_is_in_reset(BusState *bus);
  * bus_setup_iommu() - Set up IOMMU operations for a bus
  * @bus: the bus to configure
  * @ops: IOMMU operations structure containing callback functions
+ * @iommu_id: TODO
  * @opaque: opaque data passed to IOMMU operation callbacks
  *
  * Configure IOMMU operations for the specified bus. The ops structure
  * must contain at least the get_address_space callback. The opaque
  * parameter is passed through to the operation callbacks.
  */
-void bus_setup_iommu(BusState *bus, const BusIOMMUOps *ops, void *opaque);
+void bus_setup_iommu(BusState *bus, uint8_t iommu_id, const BusIOMMUOps *ops, void *opaque);
 
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4a94af9665..b5d5f534f3 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -34,6 +34,7 @@ typedef struct BlockBackend BlockBackend;
 typedef struct BlockBackendRootState BlockBackendRootState;
 typedef struct BlockDriverState BlockDriverState;
 typedef struct BusClass BusClass;
+typedef struct BusIOMMU BusIOMMU;
 typedef struct BusState BusState;
 typedef struct Chardev Chardev;
 typedef struct Clock Clock;
-- 
2.43.0


