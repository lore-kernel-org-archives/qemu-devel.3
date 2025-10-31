Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4135CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErVl-0006h9-CX; Fri, 31 Oct 2025 11:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vErVj-0006gk-JD
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vErVd-0005uY-Aj
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761926263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIBEwGk7G5jnbtn7DgH0FSnLESOoPusLJVHahY03jMo=;
 b=FL3Temgxzpx+qXzJQBxrsCdvwLJVkKfC7OuOSXd2UJ2pheUVNx2gyVao/Kq4Ih5BTJaxLf
 4KCx6Vu+EH3wkNLSbRIHWYbwwN4Bg1HtQkNtXqj5YQjhsHsBNE/Zs0BiWQJg4EsRtPyJFd
 NNri/xI9+qghJwsRPlcqO6at+6t9YIM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-npByKlPJMfSHu6qH42-EKA-1; Fri, 31 Oct 2025 11:56:24 -0400
X-MC-Unique: npByKlPJMfSHu6qH42-EKA-1
X-Mimecast-MFC-AGG-ID: npByKlPJMfSHu6qH42-EKA_1761926184
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88f7eff9d5fso546263885a.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761926183; x=1762530983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIBEwGk7G5jnbtn7DgH0FSnLESOoPusLJVHahY03jMo=;
 b=JMTSXbBzMZM5qPRYvY0GAPbaBnKYJ0oTwbXrt5SFqWF7KBz7JDqK2qQZMpQXyE/z5M
 X98vx1OkJrTEdbJMY/CYKjHMwaduuOoFhEcDvAelGD2BAZf1rofNuUxZqSeR1IITLDeM
 zWSIBCj6BqTvObPRJ4d2qqlJdiw+EFJEGTvzBj/2JPLek66hgUa+JkFEWVNaXE3o6yxG
 89LkUifDiU+MhvXLeXo7ZjHoHJKz49fLqzeIsPDmYAJPmR/dm8Jzgg9v+swIQWTtHNjW
 afCXcwwZrKTWAP2+mbWAQkbdmDcdSBHh4BsEXzcQI2yZv5Da+b6d4yDgiOMjn/nkkENe
 uscA==
X-Gm-Message-State: AOJu0YwpUejYOrmdTQSK5fHrNQGEoBFXlYwlnb5GMkkMgXxY+psi3Qp9
 ZwVXYGDuQYCF5MlxfpvlczkH7AZMAe0ltwBZ2f6lr6aGXZ0KCh3udUW4vU/SY16uLPEZsROq/BO
 P1fjZ8BWKaMipoANdOxfWZ5twUZ59FKOEFZ6WDujjKXM4hE6usMW3lHZ1+l3L/suBglB2Qg3Sb4
 Vpac8nnnMG1fqSG+NBe8jVMRQkaTb4WxFJyJknk5pVW1A=
X-Gm-Gg: ASbGncsyTnxB3nBTOh7fkI8B22nnxF720uSgLbREDo5uTtQzgjVrT9ofh+lmbSuvwps
 x9tnxAed82kiS0cJhou1R0jV/n/HWXPXxK8cqEqeoaD3DLm6xVWm7qM6rE2bMpHbL73t5FUUIgU
 55P+3DOdqRJ+W8IrGkc1AqelOOA6ZFiAuKZDBhH6gJPb4eEL8EZH1jVxrKaTKVXRY1agqlahKfZ
 VjVqS0ShUAyP8D0eTMAZvziq2GGw9uby25YyPGOLH1O+f9L/i2xH4U8rpaL31zQPCdyHXLhvhb+
 GjATACTrs5TSd5rThowh0gRumlRgbV81ghhTeEkxPHmF8d7DVt6ApusFRbNxyRfrqiDaTPIfjXY
 EEYB39rz6p6jfDTKTzJmokMhhdMuv5vJOIHz6M/0o
X-Received: by 2002:a05:620a:371c:b0:8a2:2233:c157 with SMTP id
 af79cd13be357-8ab996873fbmr447824585a.21.1761926183468; 
 Fri, 31 Oct 2025 08:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm8UymuaECRkSMIOQfr0VGVN5mk23DSiLn6fMGHwpr3uz2kC3vIdCuF1D/rvK7ZeXdo+/Edw==
X-Received: by 2002:a05:620a:371c:b0:8a2:2233:c157 with SMTP id
 af79cd13be357-8ab996873fbmr447819385a.21.1761926182773; 
 Fri, 31 Oct 2025 08:56:22 -0700 (PDT)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ac02f84935sm129356885a.38.2025.10.31.08.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:56:22 -0700 (PDT)
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [RFC 2/2] Add vhost-user-can and vhost-user-can-pci devices
Date: Fri, 31 Oct 2025 16:56:17 +0100
Message-ID: <20251031155617.1223248-2-mvaralar@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251031155617.1223248-1-mvaralar@redhat.com>
References: <20251031155617.1223248-1-mvaralar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>

Add vhost-user-can device, which has been tested with latest
vhost-device-can (see
https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-can) and
the virtio-can driver v6 (see
https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/).

Signed-off-by: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Tested-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
 hw/net/Kconfig                  |  5 +++
 hw/net/can/meson.build          |  3 ++
 hw/net/can/vhost-user-can-pci.c | 69 +++++++++++++++++++++++++++++++++
 hw/net/can/vhost-user-can.c     | 65 +++++++++++++++++++++++++++++++
 include/hw/net/vhost-user-can.h | 26 +++++++++++++
 5 files changed, 168 insertions(+)
 create mode 100644 hw/net/can/vhost-user-can-pci.c
 create mode 100644 hw/net/can/vhost-user-can.c
 create mode 100644 include/hw/net/vhost-user-can.h

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 2b513d6895..c6fe5b4376 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -160,3 +160,8 @@ config CAN_CTUCANFD_PCI
     default y if PCI_DEVICES
     depends on PCI && CAN_CTUCANFD
     select CAN_BUS
+
+config VHOST_USER_CAN
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
index 7382344628..1796a89820 100644
--- a/hw/net/can/meson.build
+++ b/hw/net/can/meson.build
@@ -4,5 +4,8 @@ system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_core.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan_pci.c'))
+system_ss.add(when: 'CONFIG_VHOST_USER_CAN', if_true: files('vhost-user-can.c'))
+system_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_CAN'],
+                      if_true: files('vhost-user-can-pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-can.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-canfd.c'))
diff --git a/hw/net/can/vhost-user-can-pci.c b/hw/net/can/vhost-user-can-pci.c
new file mode 100644
index 0000000000..e525d28ab1
--- /dev/null
+++ b/hw/net/can/vhost-user-can-pci.c
@@ -0,0 +1,69 @@
+/*
+ * Vhost-user CAN virtio device PCI glue
+ *
+ * Copyright (c) 2024 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/net/vhost-user-can.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserCanPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserCan vdev;
+};
+
+typedef struct VHostUserCanPCI VHostUserCanPCI;
+
+#define TYPE_VHOST_USER_CAN_PCI "vhost-user-can-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserCanPCI, VHOST_USER_CAN_PCI,
+                         TYPE_VHOST_USER_CAN_PCI)
+
+static void vhost_user_can_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserCanPCI *dev = VHOST_USER_CAN_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_can_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_can_pci_realize;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_SERIAL_CANBUS;
+}
+
+static void vhost_user_can_pci_instance_init(Object *obj)
+{
+    VHostUserCanPCI *dev = VHOST_USER_CAN_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_CAN);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_can_pci_info = {
+    .base_name = TYPE_VHOST_USER_CAN_PCI,
+    .non_transitional_name = "vhost-user-can-pci",
+    .instance_size = sizeof(VHostUserCanPCI),
+    .instance_init = vhost_user_can_pci_instance_init,
+    .class_init = vhost_user_can_pci_class_init,
+};
+
+static void vhost_user_can_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_can_pci_info);
+}
+
+type_init(vhost_user_can_pci_register);
diff --git a/hw/net/can/vhost-user-can.c b/hw/net/can/vhost-user-can.c
new file mode 100644
index 0000000000..acab1f64ee
--- /dev/null
+++ b/hw/net/can/vhost-user-can.c
@@ -0,0 +1,65 @@
+/*
+ * Vhost-user CAN virtio device
+ *
+ * Copyright (c) 2024 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
+ *
+ * Simple wrapper of the generic vhost-user-device.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/net/vhost-user-can.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_can.h"
+
+static const VMStateDescription vu_can_vmstate = {
+    .name = "vhost-user-can",
+    .unmigratable = 1,
+};
+
+static const Property vcan_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+};
+
+static void vu_can_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_CAN;
+    vub->num_vqs = 3;
+    vub->config_size = sizeof(struct virtio_can_config);
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_can_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_can_vmstate;
+    device_class_set_props(dc, vcan_properties);
+    device_class_set_parent_realize(dc, vu_can_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo vu_can_info = {
+    .name = TYPE_VHOST_USER_CAN,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserCan),
+    .class_init = vu_can_class_init,
+};
+
+static void vu_can_register_types(void)
+{
+    type_register_static(&vu_can_info);
+}
+
+type_init(vu_can_register_types)
diff --git a/include/hw/net/vhost-user-can.h b/include/hw/net/vhost-user-can.h
new file mode 100644
index 0000000000..38bc261ce7
--- /dev/null
+++ b/include/hw/net/vhost-user-can.h
@@ -0,0 +1,26 @@
+/*
+ * Vhost-user Can virtio device
+ *
+ * Copyright (c) 2024 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_CAN_H
+#define QEMU_VHOST_USER_CAN_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_CAN "vhost-user-can"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserCan, VHOST_USER_CAN)
+
+struct VHostUserCan {
+    /*< private >*/
+    VHostUserBase parent;
+    /*< public >*/
+};
+
+#endif /* QEMU_VHOST_USER_CAN_H */
-- 
2.42.0


