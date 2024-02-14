Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72161C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDD7-0008R6-N6; Wed, 14 Feb 2024 06:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCy-0008K5-Pk
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCu-0006iO-5u
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9XEZxK+Af7maEugy1zdrdEuG4od1VQ/TE0+JgjoQEw=;
 b=RbRSNHWTe2vJ6qjzMuSE62NRf9nM52fkU+BF5GzvMkzz/hJeX+v87rgCsG8hxzG+jU/VI+
 yHXC9/ZdKLC085GbKHfxJb1bfUSxvURe9q0nucbSLtncl4ZuYBhqJ8HDaHMYSX0K/N0mC1
 dcD7NqEvE2GpP8VYGeXyLo24ZaQGOSU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-pltEzKQwNJqYWwpU_Y1O7g-1; Wed, 14 Feb 2024 06:13:36 -0500
X-MC-Unique: pltEzKQwNJqYWwpU_Y1O7g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3d06dd626fso90563666b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909215; x=1708514015;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9XEZxK+Af7maEugy1zdrdEuG4od1VQ/TE0+JgjoQEw=;
 b=MifBtZQ7PiB1nmSURkvr3QKlDxLwd+9Zp+77CIvCqrgdrztuTASomGtzI4jSudcGMV
 LO7fo8OQiwaiVITUr8Rh8YVNcKr1i6YJrF31oTbdxjB3oEnyXaJ6HiK8HAj/y16EqF1I
 0nM/A9xafNqj3dS+c2u6/VcMw0YrbFyRs8Kiaybj6/ogy69pPerilxMwAOrpBjllHjXF
 piSLjFqKddoBKP+vw5lHQNgvaywAKdW7n9tVVAP+4oMCrAuFN4wriKFfONxweRBS/SYj
 UXb9oeM14Hdz7/G/LkHsC7HoH+0UeN7akYnSVibOdk+zx3mYVAWix9R05wGl+6VJaHFZ
 CBRQ==
X-Gm-Message-State: AOJu0Ywy8Xxushem0heEwHJnE+wuQxcpoj1T5S1CE0iiYxRoverxFZ9W
 MPC9Y8LHp7fHuW0ST0iDJ42ghjlhoNItqN+SzJSuZ3rn5XboXeHIW73M5De+9vkygRI5OtA+NH5
 rTwDAAQOz6vaQnvSeMZQK5a/10EKxZm4dDNfBP7FsePFAuDjcC1v8B5avfzwsrEDH7/cV5kizRi
 o8XuSqyChwwArYvmGqwIl/tewYIqSKPw==
X-Received: by 2002:a17:907:105d:b0:a3d:5748:da37 with SMTP id
 oy29-20020a170907105d00b00a3d5748da37mr788226ejb.33.1707909215028; 
 Wed, 14 Feb 2024 03:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3f3TrinlxnYJwOkBQ0+wExqjdlr9R5PdaI2uX4oonmwz9s4666L9cp5Sp06MSIvh7MULjfA==
X-Received: by 2002:a17:907:105d:b0:a3d:5748:da37 with SMTP id
 oy29-20020a170907105d00b00a3d5748da37mr788209ejb.33.1707909214705; 
 Wed, 14 Feb 2024 03:13:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXouETL9yhO/OTaW7oAa45ntjhHGxUw5nak68sdPahQ5H4khTOMvbaVKAhCEK6hYf900ZX0V9x33tv5uThQOL0p7EQKNO6Esc0y9hJbfijOxcRhwZ3LWzp0p8JCoydbhTcB4K+3fZtc+uD6Rm4+tammaKz+BZ5pkrxaJzg=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 dl7-20020a170907944700b00a3d1b41bb48sm1154170ejc.130.2024.02.14.03.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:34 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/60] hw/virtio: add vhost-user-snd and vhost-user-snd-pci
 devices
Message-ID: <4ae0fc18a1dc91bfe3a494292faf3c4c1b2cc16c.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tested with rust-vmm vhost-user-sound daemon:

    RUST_LOG=trace cargo run --bin vhost-user-sound -- --socket /tmp/snd.sock --backend null

Invocation:

    qemu-system-x86_64  \
            -qmp unix:./qmp-sock,server,wait=off  \
            -m 4096 \
            -numa node,memdev=mem \
            -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
            -D qemu.log \
            -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\* \
            -chardev socket,id=vsnd,path=/tmp/snd.sock \
            -device vhost-user-snd-pci,chardev=vsnd,id=snd \
            /path/to/disk

[AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54ae1cdd15fef2d88e9e387a175f099a38c636f4.patch]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20240104210945.1223134-7-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-snd.h | 24 ++++++++++
 hw/virtio/vhost-user-snd-pci.c     | 75 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-snd.c         | 67 ++++++++++++++++++++++++++
 MAINTAINERS                        |  7 +++
 hw/virtio/Kconfig                  |  5 ++
 hw/virtio/meson.build              |  3 ++
 6 files changed, 181 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

diff --git a/include/hw/virtio/vhost-user-snd.h b/include/hw/virtio/vhost-user-snd.h
new file mode 100644
index 0000000000..f9260116a7
--- /dev/null
+++ b/include/hw/virtio/vhost-user-snd.h
@@ -0,0 +1,24 @@
+/*
+ * Vhost-user Sound virtio device
+ *
+ * Copyright (c) 2021 Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_SND_H
+#define QEMU_VHOST_USER_SND_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_SND "vhost-user-snd"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSound, VHOST_USER_SND)
+
+struct VHostUserSound {
+    VHostUserBase parent_obj;
+};
+
+#endif /* QEMU_VHOST_USER_SND_H */
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
new file mode 100644
index 0000000000..d61cfdae63
--- /dev/null
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -0,0 +1,75 @@
+/*
+ * Vhost-user Sound virtio device PCI glue
+ *
+ * Copyright (c) 2023 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-snd.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserSoundPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSound vdev;
+};
+
+typedef struct VHostUserSoundPCI VHostUserSoundPCI;
+
+#define TYPE_VHOST_USER_SND_PCI "vhost-user-snd-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserSoundPCI, VHOST_USER_SND_PCI,
+                         TYPE_VHOST_USER_SND_PCI)
+
+static Property vhost_user_snd_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_snd_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_snd_pci_realize;
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+    device_class_set_props(dc, vhost_user_snd_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
+}
+
+static void vhost_user_snd_pci_instance_init(Object *obj)
+{
+    VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SND);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_snd_pci_info = {
+    .base_name = TYPE_VHOST_USER_SND_PCI,
+    .non_transitional_name = "vhost-user-snd-pci",
+    .instance_size = sizeof(VHostUserSoundPCI),
+    .instance_init = vhost_user_snd_pci_instance_init,
+    .class_init = vhost_user_snd_pci_class_init,
+};
+
+static void vhost_user_snd_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_snd_pci_info);
+}
+
+type_init(vhost_user_snd_pci_register);
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
new file mode 100644
index 0000000000..9a217543f8
--- /dev/null
+++ b/hw/virtio/vhost-user-snd.c
@@ -0,0 +1,67 @@
+/*
+ * Vhost-user snd virtio device
+ *
+ * Copyright (c) 2023 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
+#include "hw/virtio/vhost-user-snd.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_snd.h"
+
+static const VMStateDescription vu_snd_vmstate = {
+    .name = "vhost-user-snd",
+    .unmigratable = 1,
+};
+
+static Property vsnd_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vu_snd_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_SOUND;
+    vub->num_vqs = 4;
+    vub->config_size = sizeof(struct virtio_snd_config);
+    vub->vq_size = 64;
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_snd_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_snd_vmstate;
+    device_class_set_props(dc, vsnd_properties);
+    device_class_set_parent_realize(dc, vu_snd_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+}
+
+static const TypeInfo vu_snd_info = {
+    .name = TYPE_VHOST_USER_SND,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserSound),
+    .class_init = vu_snd_class_init,
+};
+
+static void vu_snd_register_types(void)
+{
+    type_register_static(&vu_snd_info);
+}
+
+type_init(vu_snd_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 2426368c4d..aff5342cb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2342,6 +2342,13 @@ F: hw/virtio/vhost-user-gpio*
 F: include/hw/virtio/vhost-user-gpio.h
 F: tests/qtest/libqos/virtio-gpio.*
 
+vhost-user-snd
+M: Alex Bennée <alex.bennee@linaro.org>
+R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: hw/virtio/vhost-user-snd*
+F: include/hw/virtio/vhost-user-snd.h
+
 vhost-user-scmi
 R: mzamazal@redhat.com
 S: Supported
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 92c9cf6c96..aa63ff7fd4 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -101,6 +101,11 @@ config VHOST_VDPA_DEV
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
 
+config VHOST_USER_SND
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config VHOST_USER_SCMI
     bool
     default y
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 685d586e69..af8abae020 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -24,6 +24,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
@@ -33,6 +34,8 @@ if have_vhost
                          if_true: files('vhost-user-i2c-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
                          if_true: files('vhost-user-rng-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SND'],
+                         if_true: files('vhost-user-snd-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
-- 
MST


