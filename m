Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E790D65C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVvR8-0000mL-D4; Wed, 17 Dec 2025 12:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.ampelikiotis@virtualopensystems.com>)
 id 1vVvQk-0000gr-5U
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:35:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <t.ampelikiotis@virtualopensystems.com>)
 id 1vVvQg-0002w6-Cm
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:35:17 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso2913226f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=virtualopensystems-com.20230601.gappssmtp.com; s=20230601; t=1765992907;
 x=1766597707; darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zuUE4bSdf7w8aM+p1lZk39FwIRVloWfomWvyRNvv/HU=;
 b=bC8yay7emRzUeI3m2wb+jnS4tvYy7x952RMEiUReFeAU+/15ZE2gm/VkNYmjOurFqZ
 U4i3f3yUEWrodGDXQzGZ1uq4OeG78tqXsTR50MXhhaDuEpKqFByYUAWatwj2c44v6n88
 J6c+Q237DeZD4XizmvlW0EYVRe+TmjLo4tuvEqkg1mWA9jeRA/hhdMo3ebjW7nQGxo6u
 pgaVUmSPR5+X2mGgmwFevFdHI1HGWViaxD9oAgI5bcLhGbr+ytt3UemosFo3yWFxHLkQ
 G3icHLgr7Un/SbuBdl+/CuXjWFSS3znJ9eROXV4v564iOqNEZ9BH6Y+nJ3bTViR0QvME
 ojGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765992907; x=1766597707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuUE4bSdf7w8aM+p1lZk39FwIRVloWfomWvyRNvv/HU=;
 b=EwbWMKv7q9RLpGrWW9mdXO2NWYwr3mjIyVhRncIqM2nXpA2Bx932WLl5ciXBVopgQL
 rvYvMBoG4JL0IULkYF/Q9BvIpPBsIWYSbtFwL+e96U7GEs+FqM3/TSUwpAfFl5yE3RgY
 OU82jlAo1IJR8N2RyGFQXLQv+j1eyWvHr12EOcL7T112p4Ss4gMC+zVjsNU9Qa1lAk66
 BD1mM0HPyPc/mYEVu5QUjCk4nATHMYtURw9ExT/V18hpBQQ+hB5vuF4EjMc2HgRJAQrq
 fy6UmBKkX82upXusgCpC5evYjJdpvcYyRtm1wpobEDzWR6QKKa/v1qoWQ6HiUSjMzaNB
 bZ1w==
X-Gm-Message-State: AOJu0YzPox5rvw+H3VeJLuA4i1GyMvd6W2JR4lfnWD8GKXyP7u0L2AGw
 2KxdTAomQh02O2cB6X5FW4hSj6rpGpkDUCOOsGKFDwOCGQHgQeDoGgL18FLeOuCTmuQ1me26N6B
 3OvFcxts=
X-Gm-Gg: AY/fxX6NSE1AYZGoILaRVaVgt3qV7aKQVXt6VrBSdzmgTESwDwlKYbuWlbB9vj+yKXI
 YBr1BRtl/yJnd9oVJuCnt/OxznWblD3+XUt9780w7R0U1QMeNNg5IITaQscJGrs00i3pxGETTQe
 HN2KySJ62zs0/wbZZvU0cr093v9LTF1vex9AlkvUreXvxIv5S2N+Yk5yGNnx3FyUu115YEZcy6+
 Vt+qbum5KZGZ4qpu8JG6RGQ90SPltvu7eQlRrwjgmfgR0ka+bC+IfabXIqLcKGBttWojCCGu90l
 hl3Pkzat92hJfXsQCgVK7sexCNmSHNlEdyoA5IokPRFW/JHOIDqXvV8ivydtkyIEbbLp7WpgHR6
 6QvUKzrdotuLBbHxjp5wmYQaGhpQB4QM+CVoTvNXgnRV439BmndNcOxPuRDKH8fnkAxj4KcdaBp
 yHiU70Pgo53/jAhgYorx29r6nPpAS26wsNePKRmlf40JgqiiwFUEJatmi7oAad
X-Google-Smtp-Source: AGHT+IHdkvClRAZIUtZvraBqqjy60WQZWTeN/YZHPN7sTUqEeAxXm720rTWxjwq7Xs6kG/FgUqlbGg==
X-Received: by 2002:a05:6000:2307:b0:431:32f:3140 with SMTP id
 ffacd0b85a97d-431032f322amr9430928f8f.12.1765992906691; 
 Wed, 17 Dec 2025 09:35:06 -0800 (PST)
Received: from ritos-ThinkPad-E14-Gen-3.. ([45.66.41.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432448ca8dbsm271418f8f.0.2025.12.17.09.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 09:35:06 -0800 (PST)
From: t.ampelikiotis@virtualopensystems.com
To: qemu-devel@nongnu.org
Cc: a.rigo@virtualopensystems.com, m.paolino@virtualopensystems.com,
 s.raho@virtualopensystems.com, mst@redhat.com, sgarzare@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, kwolf@redhat.com,
 pierrick.bouvier@linaro.org, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, dbassey@redhat.com, mvaralar@redhat.com,
 chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org,
 jsmoeller@linuxfoundation.org
Subject: [PATCH v1] Add vhost-user-console and vhost-user-console-pci devices
Date: Wed, 17 Dec 2025 17:35:01 +0000
Message-ID: <20251217173501.37938-1-t.ampelikiotis@virtualopensystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::432;
 envelope-from=t.ampelikiotis@virtualopensystems.com;
 helo=mail-wr1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add vhost-user-console support enabling console device emulation via
the vhost-user protocol. This allows console handling to be performed
by separate userspace processes such as the rust-vmm
vhost-device-console daemon.

The device is based on vhost-user-base: set the console virtio id,
four queues, the console config layout, and add a PCI wrapper.
Migration is disabled for now.

Tested with rust-vmm vhost-device-console:
- https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-console

Signed-off-by: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>

---

Invocation of rust-vmm device:

    RUST_LOG=trace cargo run --bin vhost-device-console \
                                --socket-path /tmp/console.sock \
                                --console-path <PATH_TO_CONSOLE_FILE>

Invocation of QEMU:

    qemu-system-x86_64  \
        -m 4096 \
        -numa node,memdev=mem \
        -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
        -chardev socket,id=char1,path=/tmp/console.sock \
        -device vhost-user-console-pci,chardev=char1,id=console \
        ...


Acknowledgements:
- This device was developed in the context of AGL (Automotive Grade Linux)
  SDV-EG (Software Defined Vehicles - Expert Group).
- The development was based on the vhost-user-snd QEMU device introduced by the
  following repository:
  https://github.com/epilys/qemu-virtio-snd/tree/vhost-sound

---
 hw/virtio/Kconfig                      |  5 ++
 hw/virtio/meson.build                  |  2 +
 hw/virtio/vhost-user-console-pci.c     | 72 ++++++++++++++++++++++++++
 hw/virtio/vhost-user-console.c         | 65 +++++++++++++++++++++++
 include/hw/virtio/vhost-user-console.h | 24 +++++++++
 5 files changed, 168 insertions(+)
 create mode 100644 hw/virtio/vhost-user-console-pci.c
 create mode 100644 hw/virtio/vhost-user-console.c
 create mode 100644 include/hw/virtio/vhost-user-console.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 10f5c53ac0..9c9dd8d7e3 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -112,6 +112,11 @@ config VHOST_USER_GPIO
     default y
     depends on VIRTIO && VHOST_USER

+config VHOST_USER_CONSOLE
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config VHOST_VDPA_DEV
     bool
     default y
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887d..232178e217 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -61,6 +61,7 @@ system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_CONSOLE', if_true: files('vhost-user-console.c'))

 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
@@ -82,6 +83,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pci.c'))
+virtio_pci_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_CONSOLE'], if_true: files('vhost-user-console-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
diff --git a/hw/virtio/vhost-user-console-pci.c b/hw/virtio/vhost-user-console-pci.c
new file mode 100644
index 0000000000..6c856a3424
--- /dev/null
+++ b/hw/virtio/vhost-user-console-pci.c
@@ -0,0 +1,72 @@
+/*
+ * Vhost-user console virtio device PCI glue
+ *
+ * Copyright (c) 2024-2025 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-console.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserConsolePCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserConsole vdev;
+};
+
+typedef struct VHostUserConsolePCI VHostUserConsolePCI;
+
+#define TYPE_VHOST_USER_CONSOLE_PCI "vhost-user-console-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserConsolePCI, VHOST_USER_CONSOLE_PCI,
+                         TYPE_VHOST_USER_CONSOLE_PCI)
+
+static void vhost_user_console_pci_realize(VirtIOPCIProxy *vpci_dev,
+                                           Error **errp)
+{
+    VHostUserConsolePCI *dev = VHOST_USER_CONSOLE_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_console_pci_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_console_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_console_pci_instance_init(Object *obj)
+{
+    VHostUserConsolePCI *dev = VHOST_USER_CONSOLE_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_CONSOLE);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_console_pci_info = {
+    .base_name = TYPE_VHOST_USER_CONSOLE_PCI,
+    .non_transitional_name = "vhost-user-console-pci",
+    .instance_size = sizeof(VHostUserConsolePCI),
+    .instance_init = vhost_user_console_pci_instance_init,
+    .class_init = vhost_user_console_pci_class_init,
+};
+
+static void vhost_user_console_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_console_pci_info);
+}
+
+type_init(vhost_user_console_pci_register);
diff --git a/hw/virtio/vhost-user-console.c b/hw/virtio/vhost-user-console.c
new file mode 100644
index 0000000000..d1eba5bc34
--- /dev/null
+++ b/hw/virtio/vhost-user-console.c
@@ -0,0 +1,65 @@
+/*
+ * Vhost-user console virtio device
+ *
+ * Copyright (c) 2024-2025 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
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
+#include "hw/virtio/vhost-user-console.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_console.h"
+
+static const VMStateDescription vu_console_vmstate = {
+    .name = "vhost-user-console",
+    .unmigratable = 1,
+};
+
+static const Property vconsole_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+};
+
+static void vu_console_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_CONSOLE;
+    vub->num_vqs = 4;
+    vub->config_size = sizeof(struct virtio_console_config);
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_console_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_console_vmstate;
+    device_class_set_props(dc, vconsole_properties);
+    device_class_set_parent_realize(dc, vu_console_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo vu_console_info = {
+    .name = TYPE_VHOST_USER_CONSOLE,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserConsole),
+    .class_init = vu_console_class_init,
+};
+
+static void vu_console_register_types(void)
+{
+    type_register_static(&vu_console_info);
+}
+
+type_init(vu_console_register_types)
diff --git a/include/hw/virtio/vhost-user-console.h b/include/hw/virtio/vhost-user-console.h
new file mode 100644
index 0000000000..261d62b756
--- /dev/null
+++ b/include/hw/virtio/vhost-user-console.h
@@ -0,0 +1,24 @@
+/*
+ * Vhost-user console virtio device
+ *
+ * Copyright (c) 2024-2025 Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_CONSOLE_H
+#define QEMU_VHOST_USER_CONSOLE_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_CONSOLE "vhost-user-console"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserConsole, VHOST_USER_CONSOLE)
+
+struct VHostUserConsole {
+    VHostUserBase parent;
+};
+
+#endif /* QEMU_VHOST_USER_CONSOLE_H */
--
2.43.0


