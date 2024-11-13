Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3BCD462AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEIU-0004NJ-01; Wed, 13 Nov 2024 09:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBEIH-000448-EC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:24:31 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBEIA-00008V-Cd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:24:26 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so613396166b.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731507861; x=1732112661;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcMkBl2S0dMZAxFzlwCzM9xKkwEmpZ4qLMHWQEGwwuQ=;
 b=NUAZgB0ePN3oDWvz9AfJHzK4rDUr25Nfy0izZYMQeqzvxLK1W2CIxsLtih+cvoDDpW
 XspzLSpcFqojySBgbzMCb8xrMShmOrV9k0VdhdNYy0Eyy9XYRYuMgbzeunAldi3NNryD
 BWITkhsf0feczEnfdyxxbcCZmaMRWtgLWTndYvDXTmL2tyGGdWgqQz8eaPPajE7N4M3f
 Sfah8f0+y+6gBOyI6lto3l7zhlS836YkECFuhGbq4CFy0VFeMF5I9Y6RvlxqaP8cjssd
 nntD85XEGRjV+eg8xJl0dco8ZWzb4IqH5mXTU/nbR5Cs2ilsqSMCKj9AV/MtlVu7OzEU
 bJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507861; x=1732112661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcMkBl2S0dMZAxFzlwCzM9xKkwEmpZ4qLMHWQEGwwuQ=;
 b=c5IK8eSMdHTWvovrB+nN0KuOxEnjRUzruvXYCSNMc8Dnge6BNg4cBOdhnwfYdSataa
 spdQbJuVqxFnxvtXlbPjszHOpwtiC8BY0ORgBvijpjyxlMn+Zf+KLyeozbmL95pCllaS
 C4Fk+BMQEOJnYneO8Ea6htyJPWsb199s8FQXOfQ/Yi7wPpMgoYNOvz3kOXUiQNgWC1AF
 Jf2g84H++hqdgtoDnhXhlZQqnfKQugVxu7yRgMaaO8HDWtA0n5OAsPvo5b2N1FBwZtbW
 JD06s9ix23PwTEnWen0CHUUZVweWcr02Hk618x8hh0F6CUmrnU7EBp3ziACXXLJSh+vu
 b7+Q==
X-Gm-Message-State: AOJu0Yw85QeXb5BCa5oPSvPrdsGWsUS2bVYQNTuyiUk1RwFRkK9PUCX4
 d0u1Ty5Hz3nOxG2VMqY4bem1Y80OR6mNVrYHqLapoAgglO8RQMC/aRM98/gY8u4uTnz6p785UX8
 ZoQ==
X-Google-Smtp-Source: AGHT+IH47HSsH5wnlUyN7bTX93Y97kuk7bMHrqtQ8pSK6AteDvuwgVWwHQTrRQylaAnipppI7eCgzA==
X-Received: by 2002:a17:907:31c3:b0:a9e:b471:8006 with SMTP id
 a640c23a62f3a-aa1c57afcd8mr623659466b.43.1731507860964; 
 Wed, 13 Nov 2024 06:24:20 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d76esm7134612a12.9.2024.11.13.06.24.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 06:24:20 -0800 (PST)
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
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v10 13/15] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
Date: Wed, 13 Nov 2024 15:23:41 +0100
Message-Id: <20241113142343.40832-14-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241113142343.40832-1-phil@philjordan.eu>
References: <20241113142343.40832-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::633;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x633.google.com
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

From: Alexander Graf <graf@amazon.com>

Apple has its own virtio-blk PCI device ID where it deviates from the
official virtio-pci spec slightly: It puts a new "apple type"
field at a static offset in config space and introduces a new barrier
command.

This patch first creates a mechanism for virtio-blk downstream classes to
handle unknown commands. It then creates such a downstream class and a new
vmapple-virtio-blk-pci class which support the additional apple type config
identifier as well as the barrier command.

The 'aux' or 'root' device type are selected using the 'variant' property.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v4:

 * Use recommended object type declaration pattern.
 * Correctly log unimplemented code paths.
 * Most header code moved to .c, type name #defines moved to vmapple.h

v5:

 * Corrected handling of potentially unaligned writes to virtio config area.
 * Simplified passing through device variant type to subobject.

v9:

 * Correctly specify class_size for VMAppleVirtIOBlkClass

v10:

 * Folded v9 patch 16/16 into this one, changing the device type design to
   provide a single device type with a variant property instead of 2 different
   subtypes for aux and root volumes.
 * Tidied up error reporting for the variant property.

 hw/block/virtio-blk.c               |  19 ++-
 hw/core/qdev-properties-system.c    |   8 ++
 hw/vmapple/Kconfig                  |   3 +
 hw/vmapple/meson.build              |   1 +
 hw/vmapple/virtio-blk.c             | 205 ++++++++++++++++++++++++++++
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/qdev-properties-system.h |   5 +
 include/hw/virtio/virtio-blk.h      |  12 +-
 include/hw/vmapple/vmapple.h        |   2 +
 qapi/virtio.json                    |  14 ++
 10 files changed, 265 insertions(+), 5 deletions(-)
 create mode 100644 hw/vmapple/virtio-blk.c

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9166d7974d4..9e8337bb639 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -50,12 +50,12 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
     req->mr_next = NULL;
 }
 
-static void virtio_blk_free_request(VirtIOBlockReq *req)
+void virtio_blk_free_request(VirtIOBlockReq *req)
 {
     g_free(req);
 }
 
-static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
+void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
 {
     VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
@@ -966,8 +966,18 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         break;
     }
     default:
-        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
-        virtio_blk_free_request(req);
+    {
+        /*
+         * Give subclasses a chance to handle unknown requests. This way the
+         * class lookup is not in the hot path.
+         */
+        VirtIOBlkClass *vbk = VIRTIO_BLK_GET_CLASS(s);
+        if (!vbk->handle_unknown_request ||
+            !vbk->handle_unknown_request(req, mrb, type)) {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
+            virtio_blk_free_request(req);
+        }
+    }
     }
     return 0;
 }
@@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info = {
     .instance_size = sizeof(VirtIOBlock),
     .instance_init = virtio_blk_instance_init,
     .class_init = virtio_blk_class_init,
+    .class_size = sizeof(VirtIOBlkClass),
 };
 
 static void virtio_register_types(void)
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
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 8bbeb9a9237..bcd1be63e3c 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -7,3 +7,6 @@ config VMAPPLE_BDIF
 config VMAPPLE_CFG
     bool
 
+config VMAPPLE_VIRTIO_BLK
+    bool
+
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index 64b78693a31..bf17cf906c9 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
+system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
new file mode 100644
index 00000000000..9aeb2931922
--- /dev/null
+++ b/hw/vmapple/virtio-blk.c
@@ -0,0 +1,205 @@
+/*
+ * VMApple specific VirtIO Block implementation
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * VMApple uses almost standard VirtIO Block, but with a few key differences:
+ *
+ *  - Different PCI device/vendor ID
+ *  - An additional "type" identifier to differentiate AUX and Root volumes
+ *  - An additional BARRIER command
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vmapple/vmapple.h"
+#include "hw/virtio/virtio-blk.h"
+#include "hw/virtio/virtio-pci.h"
+#include "qemu/bswap.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+
+#define TYPE_VMAPPLE_VIRTIO_BLK  "vmapple-virtio-blk"
+OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
+
+typedef struct VMAppleVirtIOBlkClass {
+    VirtIOBlkClass parent;
+
+    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
+} VMAppleVirtIOBlkClass;
+
+typedef struct VMAppleVirtIOBlk {
+    VirtIOBlock parent_obj;
+
+    uint32_t apple_type;
+} VMAppleVirtIOBlk;
+
+/*
+ * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
+ */
+OBJECT_DECLARE_SIMPLE_TYPE(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI)
+
+#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
+
+static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
+                                                      MultiReqBuffer *mrb,
+                                                      uint32_t type)
+{
+    switch (type) {
+    case VIRTIO_BLK_T_APPLE_BARRIER:
+        qemu_log_mask(LOG_UNIMP, "%s: Barrier requests are currently no-ops\n",
+                      __func__);
+        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
+        virtio_blk_free_request(req);
+        return true;
+    default:
+        return false;
+    }
+}
+
+/*
+ * VMApple virtio-blk uses the same config format as normal virtio, with one
+ * exception: It adds an "apple type" specififer at the same location that
+ * the spec reserves for max_secure_erase_sectors. Let's hook into the
+ * get_config code path here, run it as usual and then patch in the apple type.
+ */
+static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VMAppleVirtIOBlk *dev = VMAPPLE_VIRTIO_BLK(vdev);
+    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
+    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
+
+    vvbk->get_config(vdev, config);
+
+    g_assert(dev->parent_obj.config_size >= endof(struct virtio_blk_config, zoned));
+
+    /* Apple abuses the field for max_secure_erase_sectors as type id */
+    stl_he_p(&blkcfg->max_secure_erase_sectors, dev->apple_type);
+}
+
+static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *data)
+{
+    VirtIOBlkClass *vbk = VIRTIO_BLK_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_CLASS(klass);
+
+    vbk->handle_unknown_request = vmapple_virtio_blk_handle_unknown_request;
+    vvbk->get_config = vdc->get_config;
+    vdc->get_config = vmapple_virtio_blk_get_config;
+}
+
+static const TypeInfo vmapple_virtio_blk_info = {
+    .name          = TYPE_VMAPPLE_VIRTIO_BLK,
+    .parent        = TYPE_VIRTIO_BLK,
+    .instance_size = sizeof(VMAppleVirtIOBlk),
+    .class_size    = sizeof(VMAppleVirtIOBlkClass),
+    .class_init    = vmapple_virtio_blk_class_init,
+};
+
+/* PCI Devices */
+
+struct VMAppleVirtIOBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VMAppleVirtIOBlk vdev;
+    VMAppleVirtioBlkVariant variant;
+};
+
+
+static Property vmapple_virtio_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_VMAPPLE_VIRTIO_BLK_VARIANT("variant", VMAppleVirtIOBlkPCI, variant,
+                                           VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    ERRP_GUARD();
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
+
+    if (dev->variant == VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED) {
+        error_setg(errp, "vmapple virtio block device variant unspecified");
+        error_append_hint(errp,
+                          "Variant property must be set to 'aux' or 'root'.\n"
+                          "Use a regular virtio-blk-pci device instead when "
+                          "neither is applicaple.\n");
+        return;
+    }
+
+    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues = virtio_pci_optimal_num_queues(0);
+    }
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = conf->num_queues + 1;
+    }
+
+    /*
+     * We don't support zones, but we need the additional config space size.
+     * Let's just expose the feature so the rest of the virtio-blk logic
+     * allocates enough space for us. The guest will ignore zones anyway.
+     */
+    virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F_ZONED);
+    /* Propagate the apple type down to the virtio-blk device */
+    dev->vdev.apple_type = dev->variant;
+    /* and spawn the virtio-blk device */
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+
+    /*
+     * The virtio-pci machinery adjusts its vendor/device ID based on whether
+     * we support modern or legacy virtio. Let's patch it back to the Apple
+     * identifiers here.
+     */
+    pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
+    pci_config_set_device_id(vpci_dev->pci_dev.config,
+                             PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
+}
+
+static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
+    k->realize = vmapple_virtio_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_APPLE;
+    pcidev_k->device_id = PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vmapple_virtio_blk_pci_instance_init(Object *obj)
+{
+    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VMAPPLE_VIRTIO_BLK);
+}
+
+static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info = {
+    .generic_name  = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
+    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
+    .instance_init = vmapple_virtio_blk_pci_instance_init,
+    .class_init    = vmapple_virtio_blk_pci_class_init,
+};
+
+static void vmapple_virtio_blk_register_types(void)
+{
+    type_register_static(&vmapple_virtio_blk_info);
+    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
+}
+
+type_init(vmapple_virtio_blk_register_types)
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f1a53fea8d6..33e2898be95 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -191,6 +191,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
 #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
 #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
+#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
 
 #define PCI_VENDOR_ID_SUN                0x108e
 #define PCI_DEVICE_ID_SUN_EBUS           0x1000
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index cdcc63056e5..a1cf6b5b816 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -27,6 +27,7 @@ extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
 extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
+extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -94,4 +95,8 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
     DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
                 IOThreadVirtQueueMappingList *)
 
+#define DEFINE_PROP_VMAPPLE_VIRTIO_BLK_VARIANT(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_vmapple_virtio_blk_variant, \
+                       VMAppleVirtioBlkVariant)
+
 #endif
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5c14110c4b1..28d5046ea6c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -24,7 +24,7 @@
 #include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_BLK "virtio-blk-device"
-OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
+OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
 
 /* This is the last element of the write scatter-gather list */
 struct virtio_blk_inhdr
@@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {
     bool is_write;
 } MultiReqBuffer;
 
+typedef struct VirtIOBlkClass {
+    /*< private >*/
+    VirtioDeviceClass parent;
+    /*< public >*/
+    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer *mrb,
+                                   uint32_t type);
+} VirtIOBlkClass;
+
 void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
+void virtio_blk_free_request(VirtIOBlockReq *req);
+void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
 
 #endif
diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
index 3bba59f5ec7..9c1ad1bd8c3 100644
--- a/include/hw/vmapple/vmapple.h
+++ b/include/hw/vmapple/vmapple.h
@@ -18,4 +18,6 @@
 
 #define TYPE_VMAPPLE_CFG "vmapple-cfg"
 
+#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci"
+
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


