Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8567CC48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDCr-0008In-Pa; Wed, 14 Feb 2024 06:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCo-0008IF-Mh
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCe-0006gk-Qq
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9lKsQlMmLuGyggZKeZ7XCTq8rlj+x0MjeMkyLfVkOM=;
 b=CFybhM4vFEL1P4MN15aLB+fENeeM/+i7XI4hnz4OXpBG63tH2t8IxIlHtghfyl1n5cREOF
 /awqrNB3VWRLAW4kad7PU2iHQQEXncx7HgSEC21xbS124coiY7tFCr+kLWcfinFmNeRv+0
 vzx83aHP4+aVdNKRVxfF3k9gAh8O+2M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-jnaXmSSAM4mkQFG5hUoRIQ-1; Wed, 14 Feb 2024 06:13:22 -0500
X-MC-Unique: jnaXmSSAM4mkQFG5hUoRIQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5621580fca5so886467a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909200; x=1708514000;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9lKsQlMmLuGyggZKeZ7XCTq8rlj+x0MjeMkyLfVkOM=;
 b=h9c3HkuLT7gRXuPhqFbcdltCjQZuY7wYdUFOwGp+sRi1qJtDzP3Lfba2AOdocPNdvJ
 RPoqtNMe0VjzLTUKox+dujrQH65MPnFdqftf+Zf1eT82ZuC1XnMGUQ8LDi7x0FfytgTb
 ge7wd0CNElH0zeGkFPsicKFl5Z/uKmLbxGcX3I6/eJwwBNYGlxvDcvyOFtYtyTDxp96u
 Y4y5LKvE6QNbJlr+DI0viRvKiNEjigmWqS80B1wxrBb3I0QSNHnllnnsVK0ZM0FsCVzN
 KST1BEmvsOlJC7MtCH3QO5C64qKd7veiP86t7PLshjSKfDNaa9A1ZrKjKEva702jQULS
 4bmg==
X-Gm-Message-State: AOJu0Yz9U+1haA8XM+ddIRNsm9aWgaggPqa1SydNSm4Sj4rCD27o0WCu
 hK6tWQctZOUZXM3I45YoAAIQ0TF2cZqJn8QJBE3ugdFHEq1pgjFNcibHYkVekeKyQ3EE16LqZx9
 EQPhlI2cngDkQqX4nDqIkxWDBU4w5ybyAynTl8aAUNmmv6E6efpM6o1eXVuMDGnLsA+6gOIho7D
 VnSMGisTD6euVujWr0OfbQmUuPXMrLYQ==
X-Received: by 2002:a05:6402:5286:b0:563:8718:afa7 with SMTP id
 en6-20020a056402528600b005638718afa7mr921548edb.12.1707909200210; 
 Wed, 14 Feb 2024 03:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/1Zd+Bb7B5gGRgQJk4ybXDzHvGWh/eHN6bf3gkT/JL6Y5mtLVSDW5pGs0nRe0D+ieZGuNHg==
X-Received: by 2002:a05:6402:5286:b0:563:8718:afa7 with SMTP id
 en6-20020a056402528600b005638718afa7mr921503edb.12.1707909199536; 
 Wed, 14 Feb 2024 03:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV05hAdgcT62zbbEIECYOQds5tIV7oP97MJGI/zjTrRrcLSciKZj1A7uEpi+gcyvmb5FMyF8n4yvBaiDFgmjegn3Q/Oadj3
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 d6-20020aa7d5c6000000b00563819d224esm345016eds.21.2024.02.14.03.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:18 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/60] virtio: split into vhost-user-base and vhost-user-device
Message-ID: <6275989647efb708f126eb4f880e593792301ed4.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

Lets keep a cleaner split between the base class and the derived
vhost-user-device which we can use for generic vhost-user stubs. This
includes an update to introduce the vq_size property so the number of
entries in a virtq can be defined.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-2-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 hw/virtio/vhost-user-base.c                   | 346 ++++++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  13 +-
 hw/virtio/vhost-user-device.c                 | 338 +----------------
 MAINTAINERS                                   |   6 +
 hw/virtio/meson.build                         |   1 +
 6 files changed, 383 insertions(+), 342 deletions(-)
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 hw/virtio/vhost-user-base.c

diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-base.h
similarity index 71%
rename from include/hw/virtio/vhost-user-device.h
rename to include/hw/virtio/vhost-user-base.h
index 3ddf88a146..51d0968b89 100644
--- a/include/hw/virtio/vhost-user-device.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_VHOST_USER_DEVICE_H
-#define QEMU_VHOST_USER_DEVICE_H
+#ifndef QEMU_VHOST_USER_BASE_H
+#define QEMU_VHOST_USER_BASE_H
 
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
@@ -17,11 +17,13 @@
 OBJECT_DECLARE_TYPE(VHostUserBase, VHostUserBaseClass, VHOST_USER_BASE)
 
 struct VHostUserBase {
-    VirtIODevice parent;
+    VirtIODevice parent_obj;
+
     /* Properties */
     CharBackend chardev;
     uint16_t virtio_id;
     uint32_t num_vqs;
+    uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
     /* State tracking */
     VhostUserState vhost_user;
@@ -31,16 +33,17 @@ struct VHostUserBase {
     bool connected;
 };
 
-    /* needed so we can use the base realize after specialisation
-       tweaks */
+/*
+ * Needed so we can use the base realize after specialisation
+ * tweaks
+ */
 struct VHostUserBaseClass {
-    /*< private >*/
     VirtioDeviceClass parent_class;
-    /*< public >*/
+
     DeviceRealize parent_realize;
 };
 
-/* shared for the benefit of the derived pci class */
+
 #define TYPE_VHOST_USER_DEVICE "vhost-user-device"
 
-#endif /* QEMU_VHOST_USER_DEVICE_H */
+#endif /* QEMU_VHOST_USER_BASE_H */
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
new file mode 100644
index 0000000000..620fa5cb4a
--- /dev/null
+++ b/hw/virtio/vhost-user-base.c
@@ -0,0 +1,346 @@
+/*
+ * Base vhost-user-base implementation. This can be used to derive a
+ * more fully specified vhost-user backend either generically (see
+ * vhost-user-device) or via a specific stub for a device which
+ * encapsulates some fixed parameters.
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-base.h"
+#include "qemu/error-report.h"
+
+static void vub_start(VirtIODevice *vdev)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    int ret, i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&vub->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    vub->vhost_dev.acked_features = vdev->guest_features;
+
+    ret = vhost_dev_start(&vub->vhost_dev, vdev, true);
+    if (ret < 0) {
+        error_report("Error starting vhost-user-base: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here. virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < vub->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&vub->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
+}
+
+static void vub_stop(VirtIODevice *vdev)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&vub->vhost_dev, vdev, true);
+
+    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
+}
+
+static void vub_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    bool should_start = virtio_device_should_start(vdev, status);
+
+    if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vub_start(vdev);
+    } else {
+        vub_stop(vdev);
+    }
+}
+
+/*
+ * For an implementation where everything is delegated to the backend
+ * we don't do anything other than return the full feature set offered
+ * by the daemon (module the reserved feature bit).
+ */
+static uint64_t vub_get_features(VirtIODevice *vdev,
+                                 uint64_t requested_features, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    /* This should be set when the vhost connection initialises */
+    g_assert(vub->vhost_dev.features);
+    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+}
+
+/*
+ * To handle VirtIO config we need to know the size of the config
+ * space. We don't cache the config but re-fetch it from the guest
+ * every time in case something has changed.
+ */
+static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    Error *local_err = NULL;
+
+    /*
+     * There will have been a warning during vhost_dev_init, but lets
+     * assert here as nothing will go right now.
+     */
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    if (vhost_dev_get_config(&vub->vhost_dev, config,
+                             vub->config_size, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * When the daemon signals an update to the config we just need to
+ * signal the guest as we re-read the config on demand above.
+ */
+static int vub_config_notifier(struct vhost_dev *dev)
+{
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+const VhostDevConfigOps vub_config_ops = {
+    .vhost_dev_config_notifier = vub_config_notifier,
+};
+
+static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
+{
+    vhost_user_cleanup(&vub->vhost_user);
+
+    for (int i = 0; i < vub->num_vqs; i++) {
+        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
+        virtio_delete_queue(vq);
+    }
+
+    virtio_cleanup(vdev);
+}
+
+static int vub_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_dev *vhost_dev = &vub->vhost_dev;
+
+    if (vub->connected) {
+        return 0;
+    }
+    vub->connected = true;
+
+    /*
+     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
+     * so we can ping the guest when it updates.
+     */
+    if (vub->vhost_user.supports_config) {
+        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
+    }
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        vub_start(vdev);
+    }
+
+    return 0;
+}
+
+static void vub_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+
+    if (!vub->connected) {
+        return;
+    }
+    vub->connected = false;
+
+    if (vhost_dev_is_started(&vub->vhost_dev)) {
+        vub_stop(vdev);
+    }
+}
+
+static void vub_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vub_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&vub->chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        vub_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void vub_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    int ret;
+
+    if (!vub->chardev.chr) {
+        error_setg(errp, "vhost-user-base: missing chardev");
+        return;
+    }
+
+    if (!vub->virtio_id) {
+        error_setg(errp, "vhost-user-base: need to define device id");
+        return;
+    }
+
+    if (!vub->num_vqs) {
+        vub->num_vqs = 1; /* reasonable default? */
+    }
+
+    if (!vub->vq_size) {
+        vub->vq_size = 64;
+    }
+
+    /*
+     * We can't handle config requests unless we know the size of the
+     * config region, specialisations of the vhost-user-base will be
+     * able to set this.
+     */
+    if (vub->config_size) {
+        vub->vhost_user.supports_config = true;
+    }
+
+    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, vub->virtio_id, vub->config_size);
+
+    /*
+     * Disable guest notifiers, by default all notifications will be via the
+     * asynchronous vhost-user socket.
+     */
+    vdev->use_guest_notifier_mask = false;
+
+    /* Allocate queues */
+    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
+    for (int i = 0; i < vub->num_vqs; i++) {
+        g_ptr_array_add(vub->vqs,
+                        virtio_add_queue(vdev, vub->vq_size,
+                                         vub_handle_output));
+    }
+
+    vub->vhost_dev.nvqs = vub->num_vqs;
+    vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
+
+    /* connect to backend */
+    ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0, errp);
+
+    if (ret < 0) {
+        do_vhost_user_cleanup(vdev, vub);
+    }
+
+    qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
+                             dev, NULL, true);
+}
+
+static void vub_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
+
+    /* This will stop vhost backend if appropriate. */
+    vub_set_status(vdev, 0);
+    vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
+    do_vhost_user_cleanup(vdev, vub);
+}
+
+static void vub_class_init(ObjectClass *klass, void *data)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    vdc->realize = vub_device_realize;
+    vdc->unrealize = vub_device_unrealize;
+    vdc->get_features = vub_get_features;
+    vdc->get_config = vub_get_config;
+    vdc->set_status = vub_set_status;
+}
+
+static const TypeInfo vub_types[] = {
+    {
+        .name = TYPE_VHOST_USER_BASE,
+        .parent = TYPE_VIRTIO_DEVICE,
+        .instance_size = sizeof(VHostUserBase),
+        .class_init = vub_class_init,
+        .class_size = sizeof(VHostUserBaseClass),
+        .abstract = true
+    }
+};
+
+DEFINE_TYPES(vub_types)
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index 41f9b7905b..efaf55d3dd 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -9,21 +9,18 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
-#include "hw/virtio/vhost-user-device.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
+
     VHostUserBase vub;
 };
 
-typedef struct VHostUserDevicePCI VHostUserDevicePCI;
-
 #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
 
-DECLARE_INSTANCE_CHECKER(VHostUserDevicePCI,
-                         VHOST_USER_DEVICE_PCI,
-                         TYPE_VHOST_USER_DEVICE_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
@@ -39,6 +36,10 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    /* Reason: stop users confusing themselves */
+    dc->user_creatable = false;
+
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 2b028cae08..67aa934710 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -1,7 +1,10 @@
 /*
- * Generic vhost-user stub. This can be used to connect to any
- * vhost-user backend. All configuration details must be handled by
- * the vhost-user daemon itself
+ * Generic vhost-user-device implementation for any vhost-user-backend
+ *
+ * This is a concrete implementation of vhost-user-base which can be
+ * configured via properties. It is useful for development and
+ * prototyping. It expects configuration details (if any) to be
+ * handled by the vhost-user daemon itself.
  *
  * Copyright (c) 2023 Linaro Ltd
  * Author: Alex Bennée <alex.bennee@linaro.org>
@@ -13,329 +16,9 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/vhost-user-device.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
 
-static void vub_start(VirtIODevice *vdev)
-{
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    int ret, i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return;
-    }
-
-    ret = vhost_dev_enable_notifiers(&vub->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", -ret);
-        return;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
-        goto err_host_notifiers;
-    }
-
-    vub->vhost_dev.acked_features = vdev->guest_features;
-
-    ret = vhost_dev_start(&vub->vhost_dev, vdev, true);
-    if (ret < 0) {
-        error_report("Error starting vhost-user-device: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < vub->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&vub->vhost_dev, vdev, i, false);
-    }
-
-    return;
-
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
-}
-
-static void vub_stop(VirtIODevice *vdev)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    vhost_dev_stop(&vub->vhost_dev, vdev, true);
-
-    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
-}
-
-static void vub_set_status(VirtIODevice *vdev, uint8_t status)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    bool should_start = virtio_device_should_start(vdev, status);
-
-    if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
-        return;
-    }
-
-    if (should_start) {
-        vub_start(vdev);
-    } else {
-        vub_stop(vdev);
-    }
-}
-
-/*
- * For an implementation where everything is delegated to the backend
- * we don't do anything other than return the full feature set offered
- * by the daemon (module the reserved feature bit).
- */
-static uint64_t vub_get_features(VirtIODevice *vdev,
-                                 uint64_t requested_features, Error **errp)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    /* This should be set when the vhost connection initialises */
-    g_assert(vub->vhost_dev.features);
-    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
-}
-
-/*
- * To handle VirtIO config we need to know the size of the config
- * space. We don't cache the config but re-fetch it from the guest
- * every time in case something has changed.
- */
-static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    Error *local_err = NULL;
-
-    /*
-     * There will have been a warning during vhost_dev_init, but lets
-     * assert here as nothing will go right now.
-     */
-    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
-
-    if (vhost_dev_get_config(&vub->vhost_dev, config,
-                             vub->config_size, &local_err)) {
-        error_report_err(local_err);
-    }
-}
-
-/*
- * When the daemon signals an update to the config we just need to
- * signal the guest as we re-read the config on demand above.
- */
-static int vub_config_notifier(struct vhost_dev *dev)
-{
-    virtio_notify_config(dev->vdev);
-    return 0;
-}
-
-const VhostDevConfigOps vub_config_ops = {
-    .vhost_dev_config_notifier = vub_config_notifier,
-};
-
-static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /*
-     * Not normally called; it's the daemon that handles the queue;
-     * however virtio's cleanup path can call this.
-     */
-}
-
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
-{
-    vhost_user_cleanup(&vub->vhost_user);
-
-    for (int i = 0; i < vub->num_vqs; i++) {
-        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
-        virtio_delete_queue(vq);
-    }
-
-    virtio_cleanup(vdev);
-}
-
-static int vub_connect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    struct vhost_dev *vhost_dev = &vub->vhost_dev;
-
-    if (vub->connected) {
-        return 0;
-    }
-    vub->connected = true;
-
-    /*
-     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
-     * so we can ping the guest when it updates.
-     */
-    if (vub->vhost_user.supports_config) {
-        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
-    }
-
-    /* restore vhost state */
-    if (virtio_device_started(vdev, vdev->status)) {
-        vub_start(vdev);
-    }
-
-    return 0;
-}
-
-static void vub_disconnect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-
-    if (!vub->connected) {
-        return;
-    }
-    vub->connected = false;
-
-    if (vhost_dev_is_started(&vub->vhost_dev)) {
-        vub_stop(vdev);
-    }
-}
-
-static void vub_event(void *opaque, QEMUChrEvent event)
-{
-    DeviceState *dev = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        if (vub_connect(dev) < 0) {
-            qemu_chr_fe_disconnect(&vub->chardev);
-            return;
-        }
-        break;
-    case CHR_EVENT_CLOSED:
-        vub_disconnect(dev);
-        break;
-    case CHR_EVENT_BREAK:
-    case CHR_EVENT_MUX_IN:
-    case CHR_EVENT_MUX_OUT:
-        /* Ignore */
-        break;
-    }
-}
-
-static void vub_device_realize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
-
-    if (!vub->chardev.chr) {
-        error_setg(errp, "vhost-user-device: missing chardev");
-        return;
-    }
-
-    if (!vub->virtio_id) {
-        error_setg(errp, "vhost-user-device: need to define device id");
-        return;
-    }
-
-    if (!vub->num_vqs) {
-        vub->num_vqs = 1; /* reasonable default? */
-    }
-
-    /*
-     * We can't handle config requests unless we know the size of the
-     * config region, specialisations of the vhost-user-device will be
-     * able to set this.
-     */
-    if (vub->config_size) {
-        vub->vhost_user.supports_config = true;
-    }
-
-    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
-        return;
-    }
-
-    virtio_init(vdev, vub->virtio_id, vub->config_size);
-
-    /*
-     * Disable guest notifiers, by default all notifications will be via the
-     * asynchronous vhost-user socket.
-     */
-    vdev->use_guest_notifier_mask = false;
-
-    /* Allocate queues */
-    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
-        g_ptr_array_add(vub->vqs,
-                        virtio_add_queue(vdev, 4, vub_handle_output));
-    }
-
-    vub->vhost_dev.nvqs = vub->num_vqs;
-    vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
-
-    /* connect to backend */
-    ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-
-    if (ret < 0) {
-        do_vhost_user_cleanup(vdev, vub);
-    }
-
-    qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
-                             dev, NULL, true);
-}
-
-static void vub_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(dev);
-    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
-
-    /* This will stop vhost backend if appropriate. */
-    vub_set_status(vdev, 0);
-    vhost_dev_cleanup(&vub->vhost_dev);
-    g_free(vhost_vqs);
-    do_vhost_user_cleanup(vdev, vub);
-}
-
-static void vub_class_init(ObjectClass *klass, void *data)
-{
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
-
-    vdc->realize = vub_device_realize;
-    vdc->unrealize = vub_device_unrealize;
-    vdc->get_features = vub_get_features;
-    vdc->get_config = vub_get_config;
-    vdc->set_status = vub_set_status;
-}
-
-static const TypeInfo vub_info = {
-    .name = TYPE_VHOST_USER_BASE,
-    .parent = TYPE_VIRTIO_DEVICE,
-    .instance_size = sizeof(VHostUserBase),
-    .class_init = vub_class_init,
-    .class_size = sizeof(VHostUserBaseClass),
-    .abstract = true
-};
-
-
 /*
  * The following is a concrete implementation of the base class which
  * allows the user to define the key parameters via the command line.
@@ -349,6 +32,7 @@ static const VMStateDescription vud_vmstate = {
 static Property vud_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
+    DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
     DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -358,6 +42,9 @@ static void vud_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    /* Reason: stop inexperienced users confusing themselves */
+    dc->user_creatable = false;
+
     device_class_set_props(dc, vud_properties);
     dc->vmsd = &vud_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
@@ -366,14 +53,11 @@ static void vud_class_init(ObjectClass *klass, void *data)
 static const TypeInfo vud_info = {
     .name = TYPE_VHOST_USER_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
-    .instance_size = sizeof(VHostUserBase),
     .class_init = vud_class_init,
-    .class_size = sizeof(VHostUserBaseClass),
 };
 
 static void vu_register_types(void)
 {
-    type_register_static(&vub_info);
     type_register_static(&vud_info);
 }
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898..2426368c4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2319,6 +2319,12 @@ F: include/sysemu/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
+vhost-user-stubs
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: hw/virtio/vhost-user-base.c
+F: hw/virtio/vhost-user-device*
+
 vhost-user-rng
 M: Mathieu Poirier <mathieu.poirier@linaro.org>
 S: Supported
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 47baf00366..3ccddbe950 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,6 +17,7 @@ if have_vhost
   if have_vhost_user
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user-base.c'))
     system_virtio_ss.add(files('vhost-user-device.c'))
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
   endif
-- 
MST


