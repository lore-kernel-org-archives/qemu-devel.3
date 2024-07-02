Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F36C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOijx-0007vR-8U; Tue, 02 Jul 2024 15:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sOiji-0007ug-VC; Tue, 02 Jul 2024 15:00:20 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sOije-0000ek-G1; Tue, 02 Jul 2024 15:00:17 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso56898961fa.0; 
 Tue, 02 Jul 2024 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719946809; x=1720551609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu8Geb6Wu8YXfeXNAA9QHexu3Vx5gtAuZ9I8QsmrR5I=;
 b=hu328kVhJQcgxmsdZAOZjEjSH4iYgzF0NLBuPx4dDf6cBlZaxBgkM7LYHyoq8et/0s
 xfnBlpEG5xu3Rk5E+Qh6XYJ1spvkcuTSBfvFU3GJCtjgq5dzIxnDTSJBM6+JzknuaYkk
 cHI8OpO4nX09K2H4A4TNqGdhE4Q4RbIgRiO78xmdyAL4c28HBU5bdACpOrNlwIMvpFfF
 qTIgeCcQsKF6zTUhlxLVGQXKtsioPNPhTisADd/uhcmrOx/yO9msz87Pp/niuZhM4Pn3
 S2NSNMOQsq1EAADo/Mc9V5E6UEbNelnNfJYrnqIYqiUCkz4eDEvVi+EntilVMEfA6b7B
 2Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719946809; x=1720551609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uu8Geb6Wu8YXfeXNAA9QHexu3Vx5gtAuZ9I8QsmrR5I=;
 b=kJsmrNyk7VIIAmyH1Nf4S5aN3x/WDV/A+7IgZN+ihUWhQUOVWQc1jiYIWvF79ovCTc
 jQaTb/eIs9C883W3dydrop2g41CMG9dnZ5L6XHDZN23BFdyIGnuFrBwIfwkAk5GYtgug
 72k+Qa4KcO+fGVI0p/AZCNbTN+ivvsA0skWjGeQTvvef43xUHk0ZXk8S37qtKri3p7aX
 XB/Qi/DtweRrQP9k3ipdZlK0M4aZmYqLl0zg2YmpZHjH43UCiQY1UEV+lk2iLvw3HbKc
 S8G2G6WpeKOOcnQmq1VT34xXMuvABl6iivFDsZ0mrvvg57po92ud5ECiC+Xbg50HoyGt
 6QgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVal0A8r56c3eMKRU2MDB3uE48vFwRf8YVs8wsYz2WtveX7G/JV7ft4GbSFiXRn/16fsY+8IOq/Sfv+mc2KbRavKl4P1qU=
X-Gm-Message-State: AOJu0Yzg6tijz9FA9bc1Sz/GqswVJHCldQfwOGxYj2BfsT5x9JID6OuG
 dgjcV1MEtffZCAmZvW1kO2uJVD6WZjdZErBNsC8syKrEqTC7okFopphdEHSHYOI=
X-Google-Smtp-Source: AGHT+IHNGMaW4f3oxwDjy9x2WrinacwiOmnn/au3epTF32hzViTiUaxtjtgeQOTAiLtrDbFEmwWTxA==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5048 with SMTP id
 38308e7fff4ca-2ee7255542dmr34111281fa.48.1719946808185; 
 Tue, 02 Jul 2024 12:00:08 -0700 (PDT)
Received: from localhost.localdomain ([176.194.243.4])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee6efaa857sm6334291fa.89.2024.07.02.12.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 12:00:07 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mi <krashmisha@gmail.com>, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] virtio: Implement Virtio Backend for SD/MMC in QEMU
Date: Tue,  2 Jul 2024 18:58:42 +0000
Message-Id: <20240702185842.31061-1-krashmisha@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=krashmisha@gmail.com; helo=mail-lj1-x22f.google.com
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

From: Mi <krashmisha@gmail.com>

Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
Linux.

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
CC: qemu-block@nongnu.org
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---

After a feedback, moved virtio.c from virtio core directory to hw/block.
From what I see from the examples of virtio drivers, other files should
be where they are now. Correct me if I'm wrong.

 hw/block/Kconfig                            |   5 +
 hw/block/meson.build                        |   1 +
 hw/block/virtio-mmc.c                       | 165 ++++++++++++++++++++
 hw/virtio/meson.build                       |   1 +
 hw/virtio/virtio-mmc-pci.c                  |  85 ++++++++++
 hw/virtio/virtio.c                          |   3 +-
 include/hw/virtio/virtio-mmc.h              |  20 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 8 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/virtio-mmc.c
 create mode 100644 hw/virtio/virtio-mmc-pci.c
 create mode 100644 include/hw/virtio/virtio-mmc.h

diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9e8f28f982..a3059261fa 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -44,3 +44,8 @@ config VHOST_USER_BLK
 
 config SWIM
     bool
+
+config VIRTIO_MMC
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 8aa4dc3893..4fa6e90b5f 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -19,5 +19,6 @@ system_ss.add(when: 'CONFIG_TC58128', if_true: files('tc58128.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c', 'virtio-blk-common.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c', 'virtio-blk-common.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_MMC', if_true: files('virtio-mmc.c'))
 
 subdir('dataplane')
diff --git a/hw/block/virtio-mmc.c b/hw/block/virtio-mmc.c
new file mode 100644
index 0000000000..50bd7113c5
--- /dev/null
+++ b/hw/block/virtio-mmc.c
@@ -0,0 +1,165 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-mmc.h"
+#include "qemu/typedefs.h"
+#include "sysemu/blockdev.h"
+
+typedef struct mmc_req {
+    uint32_t opcode;
+    uint32_t arg;
+} mmc_req;
+
+typedef struct virtio_mmc_req {
+    uint8_t flags;
+
+#define VIRTIO_MMC_REQUEST_DATA BIT(1)
+#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
+#define VIRTIO_MMC_REQUEST_STOP BIT(3)
+#define VIRTIO_MMC_REQUEST_SBC BIT(4)
+
+    mmc_req request;
+
+    uint8_t buf[4096];
+    size_t buf_len;
+
+    mmc_req stop_req;
+    mmc_req sbc_req;
+} virtio_mmc_req;
+
+typedef struct virtio_mmc_resp {
+    uint32_t response[4];
+    int resp_len;
+    uint8_t buf[4096];
+} virtio_mmc_resp;
+
+static void send_command(SDBus *sdbus, mmc_req *mmc_request, uint8_t *response,
+                         virtio_mmc_resp *virtio_resp)
+{
+    SDRequest sdreq;
+    sdreq.cmd = (uint8_t)mmc_request->opcode;
+    sdreq.arg = mmc_request->arg;
+    int resp_len = sdbus_do_command(sdbus, &sdreq, response);
+    virtio_resp->resp_len = resp_len;
+
+    for (int i = 0; i < resp_len / sizeof(uint32_t); i++) {
+        virtio_resp->response[i] = ldl_be_p(&virtio_resp->response[i]);
+    }
+}
+
+static void send_command_without_response(SDBus *sdbus, mmc_req *mmc_request)
+{
+    SDRequest sdreq;
+    sdreq.cmd = (uint8_t)mmc_request->opcode;
+    sdreq.arg = mmc_request->arg;
+    uint8_t response[4];
+    sdbus_do_command(sdbus, &sdreq, response);
+}
+
+static void handle_mmc_request(VirtIODevice *vdev, virtio_mmc_req *virtio_req,
+                               virtio_mmc_resp *virtio_resp)
+{
+    VirtIOMMC *vmmc = VIRTIO_MMC(vdev);
+    SDBus *sdbus = &vmmc->sdbus;
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_SBC) {
+        send_command_without_response(sdbus, &virtio_req->sbc_req);
+    }
+
+    send_command(sdbus, &virtio_req->request,
+    (uint8_t *)virtio_resp->response, virtio_resp);
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_DATA) {
+        if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
+            sdbus_write_data(sdbus, virtio_req->buf, virtio_req->buf_len);
+        } else {
+            sdbus_read_data(sdbus, virtio_resp->buf, virtio_req->buf_len);
+        }
+    }
+
+    if (virtio_req->flags & VIRTIO_MMC_REQUEST_STOP) {
+        send_command_without_response(sdbus, &virtio_req->stop_req);
+    }
+}
+
+static void handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    virtio_mmc_req virtio_req;
+    virtio_mmc_resp virtio_resp;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+    iov_to_buf(elem->out_sg, elem->out_num, 0,
+    &virtio_req, sizeof(virtio_mmc_req));
+
+    handle_mmc_request(vdev, &virtio_req, &virtio_resp);
+
+    iov_from_buf(elem->in_sg, elem->in_num, 0,
+    &virtio_resp, sizeof(virtio_mmc_resp));
+
+    virtqueue_push(vq, elem, 1);
+
+    virtio_notify(vdev, vq);
+}
+
+static void virtio_mmc_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOMMC *vmmc = VIRTIO_MMC(dev);
+
+    virtio_init(vdev, VIRTIO_ID_MMC, 0);
+
+    vmmc->vq = virtio_add_queue(vdev, 1, handle_request);
+
+    BlockBackend *blk = vmmc->blk;
+    if (!blk) {
+        error_setg(errp, "Block backend not found");
+        return;
+    }
+
+    qbus_init(&vmmc->sdbus, sizeof(vmmc->sdbus), TYPE_SD_BUS, dev, "sd-bus");
+    DeviceState *card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card,
+    qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
+}
+
+static void virtio_mmc_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    virtio_cleanup(vdev);
+}
+
+static uint64_t virtio_mmc_get_features(VirtIODevice *vdev,
+                                        uint64_t features, Error **errp)
+{
+    return features;
+}
+
+static void virtio_mmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *k = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    k->realize = virtio_mmc_realize;
+    k->unrealize = virtio_mmc_unrealize;
+    k->get_features = virtio_mmc_get_features;
+}
+
+static const TypeInfo virtio_mmc_info = {
+    .name = TYPE_VIRTIO_MMC,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOMMC),
+    .class_init = virtio_mmc_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_mmc_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 47baf00366..ef05d0d80d 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -68,6 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MMC', if_true: files('virtio-mmc-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
diff --git a/hw/virtio/virtio-mmc-pci.c b/hw/virtio/virtio-mmc-pci.c
new file mode 100644
index 0000000000..f0ed17d03b
--- /dev/null
+++ b/hw/virtio/virtio-mmc-pci.c
@@ -0,0 +1,85 @@
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-mmc.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/typedefs.h"
+#include "qapi/error.h"
+#include "sysemu/block-backend-global-state.h"
+
+typedef struct VirtIOMMCPCI VirtIOMMCPCI;
+
+/*
+ * virtio-mmc-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_MMC_PCI "virtio-mmc-pci-base"
+DECLARE_INSTANCE_CHECKER(VirtIOMMCPCI, VIRTIO_MMC_PCI,
+                         TYPE_VIRTIO_MMC_PCI)
+
+struct VirtIOMMCPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOMMC vdev;
+    BlockBackend *blk;
+};
+
+static void virtio_mmc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOMMCPCI *vmmc = VIRTIO_MMC_PCI(vpci_dev);
+    DeviceState *dev = DEVICE(&vmmc->vdev);
+
+    if (!vmmc->blk) {
+        error_setg(errp, "Drive property not set");
+        return;
+    }
+    VirtIOMMC *vmmc_dev = &vmmc->vdev;
+    vmmc_dev->blk = vmmc->blk;
+    blk_detach_dev(vmmc->blk, DEVICE(vpci_dev));
+
+    qdev_set_parent_bus(dev, BUS(&vpci_dev->bus), errp);
+
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(dev), "realized", true, errp);
+}
+
+static Property virtio_mmc_properties[] = {
+    DEFINE_PROP_DRIVE("drive", VirtIOMMCPCI, blk),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_mmc_pci_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    VirtioPCIClass *virtio_pci_class = VIRTIO_PCI_CLASS(oc);
+    PCIDeviceClass *pci_device_class = PCI_DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, virtio_mmc_properties);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    virtio_pci_class->realize = virtio_mmc_pci_realize;
+
+    pci_device_class->revision = VIRTIO_PCI_ABI_VERSION;
+    pci_device_class->class_id = PCI_CLASS_MEMORY_FLASH;
+}
+
+static void virtio_mmc_pci_instance_init(Object *obj)
+{
+    VirtIOMMCPCI *dev = VIRTIO_MMC_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MMC);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_mmc_pci_info = {
+    .base_name     = TYPE_VIRTIO_MMC_PCI,
+    .generic_name  = "virtio-mmc-pci",
+    .instance_size = sizeof(VirtIOMMCPCI),
+    .class_init    = virtio_mmc_pci_class_init,
+    .instance_init = virtio_mmc_pci_instance_init,
+};
+
+static void virtio_mmc_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_mmc_pci_info);
+}
+
+type_init(virtio_mmc_pci_register)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7549094154..35f00f06aa 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -193,7 +193,8 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
     [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
     [VIRTIO_ID_BT] = "virtio-bluetooth",
-    [VIRTIO_ID_GPIO] = "virtio-gpio"
+    [VIRTIO_ID_GPIO] = "virtio-gpio",
+    [VIRTIO_ID_MMC] = "virtio-mmc",
 };
 
 static const char *virtio_id_to_name(uint16_t device_id)
diff --git a/include/hw/virtio/virtio-mmc.h b/include/hw/virtio/virtio-mmc.h
new file mode 100644
index 0000000000..a68f45d7cb
--- /dev/null
+++ b/include/hw/virtio/virtio-mmc.h
@@ -0,0 +1,20 @@
+#pragma once
+
+#include "hw/virtio/virtio.h"
+#include "hw/sd/sd.h"
+#include "qemu/typedefs.h"
+
+#define VIRTIO_ID_MMC 42
+
+#define TYPE_VIRTIO_MMC "virtio-mmc-device"
+#define VIRTIO_MMC(obj) \
+    OBJECT_CHECK(VirtIOMMC, (obj), TYPE_VIRTIO_MMC)
+#define VIRTIO_MMC_GET_PARENT_CLASS(obj) \
+    OBJECT_GET_PARENT_CLASS(VIRTIO_MMC(obj), TYPE_VIRTIO_MMC)
+
+typedef struct VirtIOMMC {
+    VirtIODevice parent_obj;
+    VirtQueue *vq;
+    SDBus sdbus;
+    BlockBackend *blk;
+} VirtIOMMC;
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 7aa2eb7662..0c67fbf709 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_MMC			42 /* virtio mmc */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1


