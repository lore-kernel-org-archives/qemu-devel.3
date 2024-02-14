Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C3C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDb-0000jC-DP; Wed, 14 Feb 2024 06:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDQ-0000E4-Id
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDA-0006m5-Ns
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CjRo4fIPTfHOrRBaGJPDLNZ8uI+Q6cMsNY8ttQOPSos=;
 b=KzExtXAVoRQepG9VSqD0/1HLAluiB4POKTxfXEgkKNKms0aoZTw9EAs8YcYyfPhnF8O1BB
 ATHR7Zc9R4KtN4yMQuHu81AeDMr8B6zXbrtwkB44CDdjBHWEaMfVoHN5M7J0GstZgaw2yV
 CYuZ7Ag0Le+vOu/Ny/HfcmliqEukP7s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-vScGgLX9OLqG54Ra7JKCdQ-1; Wed, 14 Feb 2024 06:13:53 -0500
X-MC-Unique: vScGgLX9OLqG54Ra7JKCdQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3d38947c35so39110066b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909231; x=1708514031;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjRo4fIPTfHOrRBaGJPDLNZ8uI+Q6cMsNY8ttQOPSos=;
 b=i8edT1TLm6K7EG83xZb1DaF+D0Dl5OtMXy8+aSZQlpDZTHq5PtMnPImi3mbmoB4zCr
 oqttw0TKJ81QJYw/CUpQytxODv42kOQ5w6TkF0uRfLd4gH+QnuEizAeiT6vc8PSeJjxw
 nDXPHwMM2C9UaS1meWw31MXPnhwiRNV97NMvLPs0/LLTIXvvnYEDMn0nXTU/t2c4VTyG
 2v3v/nMGnirW7HAAVXpXz66DecgmZNUMHiH/taeKkef3HA3w/znkKxBGlpmao+COttU0
 Kn+iY2Z+Y1d41WfzI185MzQVfUOPy1+kP9NMfAUJEIRG2YzjouGMnMKZ0oaP3o7WTRfJ
 xVhw==
X-Gm-Message-State: AOJu0YwwyjJ6R4puz+STDOSVEgJFC9paSYYekwKW2T9PO6b+89Hzt57i
 CndsITmPpg74irKo1IW3BXq8mzv9l6Yuiwz0iWIKzbLexQ2H4eOq/VjYqS+RESgCExI9bgh/fpE
 +OX4wdgllY4D8ECvQTwz03IWIclkgMVr9vXQr01AbeTg+XhUHK1Uzhw6Xe8TEmZMafil4UVsrdy
 dLKxsq6zq8sjVGyBWLwKqykHweR2gwNQ==
X-Received: by 2002:a17:906:495:b0:a3d:1a89:7054 with SMTP id
 f21-20020a170906049500b00a3d1a897054mr1658783eja.39.1707909231350; 
 Wed, 14 Feb 2024 03:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoT6C3Mm5gxupyXuYSncNRUGtqkZuZjVzeO/mpb99YEvPkG3UBltpCyf+nqXWbbECXeia8mA==
X-Received: by 2002:a17:906:495:b0:a3d:1a89:7054 with SMTP id
 f21-20020a170906049500b00a3d1a897054mr1658767eja.39.1707909231010; 
 Wed, 14 Feb 2024 03:13:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXlGC/LtYf/uBYgXMnS3iNHh3O6U/wbqPmc/UWX+AW9oJD7DM3lMySCmtF+sG+brY205s9GSoB2KSeaqKlXLxzR0LRIykaHi2I+46XMtEYQopzc66H39cvutazhfokwgYXVPg2Z3OOgtHAhwrdYMafi3GQDUrSDz3/rZ1k6l7ciw97R8GfZVq777X4BtUY=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vo9-20020a170907a80900b00a3ce268c015sm2037811ejc.48.2024.02.14.03.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:50 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 11/60] hw/virtio: derive vhost-user-input from vhost-user-base
Message-ID: <bad38726e9dc52d840d151a1ba38b5614b521feb.1707909001.git.mst@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Leo Yan <leo.yan@linaro.org>

This patch derives vhost-user-input from vhost-user-base class, so make
the input stub as a simpler boilerplate wrapper.

With the refactoring, vhost-user-input adds the property 'chardev', this
leads to conflict with the vhost-user-input-pci adds the same property.
To resolve the error, remove the duplicate property from
vhost-user-input-pci.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231120043721.50555-5-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-12-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-input.h |   6 +-
 hw/virtio/vhost-user-input-pci.c |   3 -
 hw/virtio/vhost-user-input.c     | 114 +++++--------------------------
 3 files changed, 21 insertions(+), 102 deletions(-)

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index a6c9703644..e69c0aeca3 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
 
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "ui/input.h"
 #include "sysemu/vhost-user-backend.h"
 
@@ -97,9 +99,7 @@ struct VirtIOInputHost {
 };
 
 struct VHostUserInput {
-    VirtIOInput                       parent_obj;
-
-    VhostUserBackend                  *vhost;
+    VHostUserBase parent_obj;
 };
 
 void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event);
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
index b858898a36..3f4761ce88 100644
--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -30,9 +30,6 @@ static void vhost_user_input_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
                                 TYPE_VHOST_USER_INPUT);
-
-    object_property_add_alias(obj, "chardev",
-                              OBJECT(&dev->vhi), "chardev");
 }
 
 static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 4ee3542106..bedec0468c 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -5,83 +5,25 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
-
 #include "hw/virtio/virtio-input.h"
 
-static int vhost_input_config_change(struct vhost_dev *dev)
-{
-    error_report("vhost-user-input: unhandled backend config change");
-    return -1;
-}
-
-static const VhostDevConfigOps config_ops = {
-    .vhost_dev_config_notifier = vhost_input_config_change,
+static Property vinput_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
-static void vhost_input_realize(DeviceState *dev, Error **errp)
+static void vinput_realize(DeviceState *dev, Error **errp)
 {
-    VHostUserInput *vhi = VHOST_USER_INPUT(dev);
-    VirtIOInput *vinput = VIRTIO_INPUT(dev);
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
 
-    vhost_dev_set_config_notifier(&vhi->vhost->dev, &config_ops);
-    vinput->cfg_size = sizeof_field(virtio_input_config, u);
-    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) == -1) {
-        return;
-    }
-}
+    /* Fixed for input device */
+    vub->virtio_id = VIRTIO_ID_INPUT;
+    vub->num_vqs = 2;
+    vub->vq_size = 4;
+    vub->config_size = sizeof(virtio_input_config);
 
-static void vhost_input_change_active(VirtIOInput *vinput)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vinput);
-
-    if (vinput->active) {
-        vhost_user_backend_start(vhi->vhost);
-    } else {
-        vhost_user_backend_stop(vhi->vhost);
-    }
-}
-
-static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
-{
-    VirtIOInput *vinput = VIRTIO_INPUT(vdev);
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    Error *local_err = NULL;
-    int ret;
-
-    memset(config_data, 0, vinput->cfg_size);
-
-    ret = vhost_dev_get_config(&vhi->vhost->dev, config_data, vinput->cfg_size,
-                               &local_err);
-    if (ret) {
-        error_report_err(local_err);
-        return;
-    }
-}
-
-static void vhost_input_set_config(VirtIODevice *vdev,
-                                   const uint8_t *config_data)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    int ret;
-
-    ret = vhost_dev_set_config(&vhi->vhost->dev, config_data,
-                               0, sizeof(virtio_input_config),
-                               VHOST_SET_CONFIG_TYPE_FRONTEND);
-    if (ret) {
-        error_report("vhost-user-input: set device config space failed");
-        return;
-    }
-
-    virtio_notify_config(vdev);
-}
-
-static struct vhost_dev *vhost_input_get_vhost(VirtIODevice *vdev)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    return &vhi->vhost->dev;
+    vubc->parent_realize(dev, errp);
 }
 
 static const VMStateDescription vmstate_vhost_input = {
@@ -91,40 +33,20 @@ static const VMStateDescription vmstate_vhost_input = {
 
 static void vhost_input_class_init(ObjectClass *klass, void *data)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vhost_input;
-    vdc->get_config = vhost_input_get_config;
-    vdc->set_config = vhost_input_set_config;
-    vdc->get_vhost = vhost_input_get_vhost;
-    vic->realize = vhost_input_realize;
-    vic->change_active = vhost_input_change_active;
-}
-
-static void vhost_input_init(Object *obj)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
-
-    vhi->vhost = VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
-    object_property_add_alias(obj, "chardev",
-                              OBJECT(vhi->vhost), "chardev");
-}
-
-static void vhost_input_finalize(Object *obj)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
-
-    object_unref(OBJECT(vhi->vhost));
+    device_class_set_props(dc, vinput_properties);
+    device_class_set_parent_realize(dc, vinput_realize,
+                                    &vubc->parent_realize);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo vhost_input_info = {
     .name          = TYPE_VHOST_USER_INPUT,
-    .parent        = TYPE_VIRTIO_INPUT,
+    .parent        = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserInput),
-    .instance_init = vhost_input_init,
-    .instance_finalize = vhost_input_finalize,
     .class_init    = vhost_input_class_init,
 };
 
-- 
MST


