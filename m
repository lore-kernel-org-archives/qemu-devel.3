Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F6C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 13:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNusn-0001Uu-0u; Sun, 30 Jun 2024 09:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sNurP-0001AF-PL; Sun, 30 Jun 2024 09:44:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sNurN-0004T4-Fq; Sun, 30 Jun 2024 09:44:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5295e488248so2696279e87.2; 
 Sun, 30 Jun 2024 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719755090; x=1720359890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FJa1Ma+dODk5xsVH6lB2g/ozZS8NzbwKs7dUywicz+k=;
 b=HfhbUGrOlVNwF8w4idiB3MG0PojxGo+XsYFVDNKD+cFHfqO29/8bfKHXNv3vAksnSQ
 hGQ6zGRPmv7xXTuEyvc8kNY8xxNHxf+qLM042ojPiVBvuNUdWR77SUZj1wDmh2/PglqG
 ocf1mXS63dPV3QsylvtcJh4GI+HFmWkpEBHaCXP1naBD+sZQvC8JwGXg5WeZ8tFHmsNw
 FwMomJ3C4Ar0aw+J944EuIYU4tDVgUzD8xCGGxwJt1E0W6NN19daV+ZgsuLJ2T7mwfZS
 9a7STCO39skqczf4qyl8AZ74yE/X4uYDkY0qFazXQLdUf224BnzmPSI2lB1kZrWjSXh6
 fmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719755090; x=1720359890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJa1Ma+dODk5xsVH6lB2g/ozZS8NzbwKs7dUywicz+k=;
 b=cpqnpPsjY6i09vj15BTFRO7vFHvmJMB3YDS7nRHN+CD7FbMvSLJpWoMMA9DwFxtkaT
 cvMbXewqxyFzbc558xGO6QioWEnhZAEj/EfFz96yCRYumG8HqcgZs6uPXNTQk3mr9BCU
 McYrm9jSZEr/npKN9SMUco6BgLyW3oaLUweNbHmY8ldleYh8cu5CrafgvMm3RQ6rhG9k
 xuJipsvRGXyEt5C8Q6cw/nQVDm4G2oJsnUv/dzV86ZyQv4E9PDcQx3f3wR5b3WsQ0Awv
 kV6+WGNTfkyP5X4jbHHhRzPxAuWKudLLaYCWxk3v71804ccEyMjVpPG8sXijPzLG3txq
 bYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1NJ+njY21F5VqiR02I8gPLhVIIyMsqjfTHNxTrJr3c9ns1Ft8tQJYWI6/WxlsyruCZdVnyqby2hbeTJ6bqwHAwCYPcOs=
X-Gm-Message-State: AOJu0Yw5G6cJzNkhyd9ZVOmDx2nU8mJXMLVPmvg9R+lYBxZlXlRwFYT5
 HNanelJs6/yOlnrW74CXuNoz4xTrP2MiO1Cbkn8pI5gj5KyyA8/iADKc74U6j+k=
X-Google-Smtp-Source: AGHT+IFE/7Z8B3lT/G6jsA0iW7SYPO22Bn2KjIClf6WGTp6wnr6pZnZ6H1lATV5KvQxIWG2cZo3lLQ==
X-Received: by 2002:a05:6512:3194:b0:52e:717c:d8d2 with SMTP id
 2adb3069b0e04-52e8273f721mr2082127e87.63.1719755089664; 
 Sun, 30 Jun 2024 06:44:49 -0700 (PDT)
Received: from localhost.localdomain ([176.194.243.4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab3b3b2sm957861e87.276.2024.06.30.06.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 06:44:49 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mikhail Krasheninnikov <krashmisha@gmail.com>,
 Matwey Kornilov <matwey.kornilov@gmail.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: Implement Virtio Backend for SD/MMC in QEMU
Date: Sun, 30 Jun 2024 13:43:48 +0000
Message-Id: <20240630134348.16830-1-krashmisha@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=krashmisha@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 30 Jun 2024 09:46:15 -0400
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

Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
Linux.

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
CC: qemu-block@nongnu.org
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/Kconfig                           |   5 +
 hw/virtio/meson.build                       |   2 +
 hw/virtio/virtio-mmc-pci.c                  |  85 ++++++++++
 hw/virtio/virtio-mmc.c                      | 165 ++++++++++++++++++++
 hw/virtio/virtio.c                          |   3 +-
 include/hw/virtio/virtio-mmc.h              |  20 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 7 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/virtio-mmc-pci.c
 create mode 100644 hw/virtio/virtio-mmc.c
 create mode 100644 include/hw/virtio/virtio-mmc.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 92c9cf6c96..e5fa7607c4 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -105,3 +105,8 @@ config VHOST_USER_SCMI
     bool
     default y
     depends on VIRTIO && VHOST_USER
+
+config VIRTIO_MMC
+    bool
+    default y
+    depends on VIRTIO
\ No newline at end of file
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 47baf00366..1ff095c5bc 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -41,6 +41,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-use
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MMC', if_true: files('virtio-mmc.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
@@ -68,6 +69,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.
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
diff --git a/hw/virtio/virtio-mmc.c b/hw/virtio/virtio-mmc.c
new file mode 100644
index 0000000000..50bd7113c5
--- /dev/null
+++ b/hw/virtio/virtio-mmc.c
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


