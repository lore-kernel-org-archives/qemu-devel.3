Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDB3D12D59
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 21:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAFuf-00047r-Ma; Sun, 10 Nov 2024 16:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuc-00043U-Ln
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:56:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuZ-00047l-Kq
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:56:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so49803355e9.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731275758; x=1731880558;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOADvMyilhJdl701XbZfD35fREWVUG8E1q7FxctgBFw=;
 b=lxmIonQ3lcNmfp89UHOe9Enb8MUEHKEl9x0mwCNW2/G4KBMEOhJr4qv4uu02OGgh+N
 P+sZXJkqVi+UKdLsSIIw6Q20RxoYX6hXvY7ONm7HmWjUKPmwvtatHPSPVYqWQuQ0jLxE
 gK3x9eKlrv1SFIjRL7mTilsCJLaXEi5Qq1CeVuCwu7llF5BzZjKpTW662cZ1iJTg9pTY
 7cxkBc5RDZAiqZYVr8777lHebrnmq4GA9LsxkjHnuDcSZWFjIQslHtBf0t9rPoRRBNV8
 r+gYx8rFweXLbJa3ywqlWKtVCWB7vhDQcy3Rnjew6t2Q0sWw1zGw7NLSIP8nZ+5ko4qT
 mU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731275758; x=1731880558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOADvMyilhJdl701XbZfD35fREWVUG8E1q7FxctgBFw=;
 b=uTS+NaINxE6+mCzMKyh1ao8chQ5Svt+Xru7604KIhXSkZVHgal0WpVsVj0wSXrDltO
 fvd5r48cfI4XTDiRyHaloBl0zNAx6hYn0ngJyi/WutsooooLQq1e6BPlBSiYJUnue7af
 c4co/3E6nThehwWAsN7anOBO6JnDdRrcH2nQzPjX84v/fIOTxLQG5X1v5Nsitvm4Lepl
 oDM3uB4ebHX0yFzEzgY3Jel4YPno5MLbVMi2nEf7Y89uj91WiNihaJg8kgqjSDMM+3Qo
 9NsIaElkumSJ2EVNHa9yRbrA1mkJYofpNnDNcL1a6VzibTWadf1cyxR3SxvOR9S9d6I6
 2Vew==
X-Gm-Message-State: AOJu0YyGgKY2HuWRWiuyF3PwgOGeXXFmsmy0XdpWnGA/YtVPkTuFVCiF
 TnR+xg60nbpwKBeUku5xX+QzOWLdJBfYY8IpZIrZXG4DiGPXTSbakEeEBc4AAsn2/AAUh/ZQs6U
 6DQ==
X-Google-Smtp-Source: AGHT+IEFbjiiwU9zB8jMymdr+GwT/4fjVFw9eHeb3I77suCfG08PD3RNZXvd0DtQ9MK7JtI5WhgbKg==
X-Received: by 2002:a05:6000:385:b0:37d:4a16:81d7 with SMTP id
 ffacd0b85a97d-381f1866abfmr10417155f8f.8.1731275758104; 
 Sun, 10 Nov 2024 13:55:58 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2f731sm523715566b.189.2024.11.10.13.55.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 10 Nov 2024 13:55:57 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v9 16/16] hw/vmapple/virtio-blk: Replace variant types with
 property on base
Date: Sun, 10 Nov 2024 22:55:19 +0100
Message-Id: <20241110215519.49150-17-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241110215519.49150-1-phil@philjordan.eu>
References: <20241110215519.49150-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32d;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This reduces the type hierarchy of the vmapple-virtio-blk-pci-base
type and vmapple-virtio-root/vmapple-virtio-aux leaf types with a single
vmapple-virtio-blk-pci type which exposes a 'variant' enum property
which can be set to 'aux' or 'root'.

This change removes a bunch of device type boilerplate at the cost of
defining a new qapi enum and qdev property type.

Documentation for the vmapple machine type is also updated.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 docs/system/arm/vmapple.rst         |  4 +--
 hw/core/qdev-properties-system.c    |  8 +++++
 hw/vmapple/virtio-blk.c             | 50 +++++++----------------------
 include/hw/qdev-properties-system.h |  6 ++++
 include/hw/vmapple/vmapple.h        |  4 +--
 qapi/virtio.json                    | 14 ++++++++
 6 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
index 67942474b93..efe39b68dc4 100644
--- a/docs/system/arm/vmapple.rst
+++ b/docs/system/arm/vmapple.rst
@@ -56,8 +56,8 @@ to get better interactive access into the target system:
        -drive file="$DISK",if=pflash,format=raw \
        -drive file="$AUX",if=none,id=aux,format=raw \
        -drive file="$DISK",if=none,id=root,format=raw \
-       -device vmapple-virtio-aux,drive=aux \
-       -device vmapple-virtio-root,drive=root \
+       -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
+       -device vmapple-virtio-blk-pci,variant=root,drive=root \
        -netdev user,id=net0,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
        -device virtio-net-pci,netdev=net0
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 35deef05f32..8bf8a3442d6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1239,3 +1239,11 @@ const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
     .set = set_iothread_vq_mapping_list,
     .release = release_iothread_vq_mapping_list,
 };
+
+const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
+    .name  = "VMAppleVirtioBlkVariant",
+    .enum_table  = &VMAppleVirtioBlkVariant_lookup,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 40b33bbdac5..f883e65a5de 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -24,6 +24,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 
+#define TYPE_VMAPPLE_VIRTIO_BLK  "vmapple-virtio-blk"
 OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
 
 typedef struct VMAppleVirtIOBlkClass {
@@ -41,14 +42,10 @@ typedef struct VMAppleVirtIOBlk {
 /*
  * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
 OBJECT_DECLARE_SIMPLE_TYPE(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI)
 
 #define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
 
-#define VIRTIO_APPLE_TYPE_ROOT 1
-#define VIRTIO_APPLE_TYPE_AUX  2
-
 static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
                                                       MultiReqBuffer *mrb,
                                                       uint32_t type)
@@ -109,7 +106,7 @@ static const TypeInfo vmapple_virtio_blk_info = {
 struct VMAppleVirtIOBlkPCI {
     VirtIOPCIProxy parent_obj;
     VMAppleVirtIOBlk vdev;
-    uint32_t apple_type;
+    VMAppleVirtioBlkVariant variant;
 };
 
 
@@ -119,6 +116,8 @@ static Property vmapple_virtio_blk_pci_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_VMAPPLE_VIRTIO_BLK_VARIANT("variant", VMAppleVirtIOBlkPCI, variant,
+                                           VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -128,6 +127,12 @@ static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err
     DeviceState *vdev = DEVICE(&dev->vdev);
     VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
 
+    if (dev->variant == VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED) {
+        error_setg(errp, "Device " TYPE_VMAPPLE_VIRTIO_BLK_PCI ": must specify "
+                   "a variant, 'aux' or 'root'");
+        return;
+    }
+
     if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
         conf->num_queues = virtio_pci_optimal_num_queues(0);
     }
@@ -143,7 +148,7 @@ static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err
      */
     virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F_ZONED);
     /* Propagate the apple type down to the virtio-blk device */
-    dev->vdev.apple_type = dev->apple_type;
+    dev->vdev.apple_type = dev->variant;
     /* and spawn the virtio-blk device */
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 
@@ -181,47 +186,16 @@ static void vmapple_virtio_blk_pci_instance_init(Object *obj)
 }
 
 static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info = {
-    .base_name     = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
-    .generic_name  = "vmapple-virtio-blk-pci",
+    .generic_name  = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
     .instance_size = sizeof(VMAppleVirtIOBlkPCI),
     .instance_init = vmapple_virtio_blk_pci_instance_init,
     .class_init    = vmapple_virtio_blk_pci_class_init,
 };
 
-static void vmapple_virtio_root_instance_init(Object *obj)
-{
-    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
-
-    dev->apple_type = VIRTIO_APPLE_TYPE_ROOT;
-}
-
-static const TypeInfo vmapple_virtio_root_info = {
-    .name          = TYPE_VMAPPLE_VIRTIO_ROOT,
-    .parent        = "vmapple-virtio-blk-pci",
-    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
-    .instance_init = vmapple_virtio_root_instance_init,
-};
-
-static void vmapple_virtio_aux_instance_init(Object *obj)
-{
-    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
-
-    dev->apple_type = VIRTIO_APPLE_TYPE_AUX;
-}
-
-static const TypeInfo vmapple_virtio_aux_info = {
-    .name          = TYPE_VMAPPLE_VIRTIO_AUX,
-    .parent        = "vmapple-virtio-blk-pci",
-    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
-    .instance_init = vmapple_virtio_aux_instance_init,
-};
-
 static void vmapple_virtio_blk_register_types(void)
 {
     type_register_static(&vmapple_virtio_blk_info);
     virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
-    type_register_static(&vmapple_virtio_root_info);
-    type_register_static(&vmapple_virtio_aux_info);
 }
 
 type_init(vmapple_virtio_blk_register_types)
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index cdcc63056e5..6e428f3fcad 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -27,6 +27,8 @@ extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
 extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
+extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
+
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -94,4 +96,8 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
     DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
                 IOThreadVirtQueueMappingList *)
 
+#define DEFINE_PROP_VMAPPLE_VIRTIO_BLK_VARIANT(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_vmapple_virtio_blk_variant, \
+                       VMAppleVirtioBlkVariant)
+
 #endif
diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
index b20956e1286..9c1ad1bd8c3 100644
--- a/include/hw/vmapple/vmapple.h
+++ b/include/hw/vmapple/vmapple.h
@@ -18,8 +18,6 @@
 
 #define TYPE_VMAPPLE_CFG "vmapple-cfg"
 
-#define TYPE_VMAPPLE_VIRTIO_BLK  "vmapple-virtio-blk"
-#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
-#define TYPE_VMAPPLE_VIRTIO_AUX  "vmapple-virtio-aux"
+#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci"
 
 #endif /* HW_VMAPPLE_VMAPPLE_H */
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 2529c2d8b20..d351d2166ef 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -992,3 +992,17 @@
 ##
 { 'enum': 'GranuleMode',
   'data': [ '4k', '8k', '16k', '64k', 'host' ] }
+
+##
+# @VMAppleVirtioBlkVariant:
+#
+# @unspecified: The default, not a valid setting.
+#
+# @root: Block device holding the root volume
+#
+# @aux: Block device holding auxiliary data required for boot
+#
+# Since: 9.2
+##
+{ 'enum': 'VMAppleVirtioBlkVariant',
+  'data': [ 'unspecified', 'root', 'aux' ] }
-- 
2.39.3 (Apple Git-145)


