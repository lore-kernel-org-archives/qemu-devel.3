Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD48C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt25h-00064F-DS; Fri, 14 Mar 2025 06:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt25L-0005p5-3g
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:16:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt25F-000372-IE
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:16:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22403cbb47fso36657705ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741947363; x=1742552163;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsdw8pAjBTeMk/gQWIVoL0cHkZcubeblaIvJp2xm1+I=;
 b=JKXi9AWj/ft8Ps0hdiGeHE93CdxEyzZ8W5tzZE2lBOCZ6A99F8QekWz+z3Ygt6UBG0
 J+g7TBJr7Eiv41b/3oNPx90DXfJcsAd7YjB2cDJRt2IrtWB2xsnAaRSWZ1OqR+shseeX
 v+L2EKjqwylYEHC9IcfUXAhTVrTbvtniA1D2Lu/ldRXjmAhsmfsEbwRQuHkMZ7LBk1Us
 JOx1I/l49mh1wt4b31owRBSWGraHQvbSH8umQ0wwT2grOryDv6LOiaeakB0Rs0+UyTdj
 C6gXIMOJgbtvzX76AFKbzywtgXHhlFTYSFOGbZUHzoUage1mrQmuUF3B4Vu9gfvtfU8Z
 yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947363; x=1742552163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsdw8pAjBTeMk/gQWIVoL0cHkZcubeblaIvJp2xm1+I=;
 b=tGyvC6qCp8Avqike/cA0C+kI2EWLXGOTXfsWmQGJPNaquQ6076+UypQHvLlPWgO+Pu
 rRkaCGJe3YqhsKp9xHxFcPmJUd44XoiaSO3/8fd0bgc3fPzm7mhqPKq+X5jyRn+G9Ykm
 SFQbXX3l+833MBBvYMGWMFE8NjZccLZDkmXncQfEEAeLSV199v6iZc47px9gQDjmyG3g
 Xr3qNhKVJvhyfxJGo3ina7P5uuNnCyrSg8+hG26R37yDcYBo7LX9a2ES6AspVjXwxlDA
 zdsEICPibWx98M2V9R9oYjGNCKr2erk8Y9LEwbDV4aUFXgYnSu8z7G/fq1mMKOw3/ZX7
 3W8w==
X-Gm-Message-State: AOJu0Ywrnm21R3RJSnykOCYv6GfNkNcpigAyUml08yCLleV4N4+lt8dc
 RERfPaGYEF+xunGwDxa5P6nf/qCkbRXTcQL3eFsNP8ub6RyI+fmWM2QXqy42tbqVQk9LuuuF5MR
 f4QUPpiwUC/Q=
X-Gm-Gg: ASbGncvbZoEgPiiL3N/tp08j1ryz0EkQfm0JCgvs8u0bH/iqWxQqsth95jrmRRWeA6u
 8dImpDvMDXrGmg4E00L1Ru9gbN+XW3eK6z9BkhpmzZrOGOMFILHO65I1TC0MTMHfaTjCKW75vRj
 jDET/StJ9L+eD+X1pPnpnFX0sviDi+kciUvujukaalsmYE0bmFCJ8oErqyE9vmjeoIxJ9pAtkDi
 yfrTmV9hYJuDWWjndAQTujQbnfrmaBFVjaxcLC7j9iKM5t/8sSWZeI1dHYn0DpBMea6RAWNvUub
 Q+nF3nMiGbGq3R5CdkhxQEYdeLZe5W3jLtKYdRhg7GHPMH79oK+nohA/TeLGDM8=
X-Google-Smtp-Source: AGHT+IEmFiqPKYkLM2urxD6vyggJ0nEowwzKUU0S7nrQ+r1BQZfHB2kks+ASZ91x6n7uxYpbWhs6ug==
X-Received: by 2002:a05:6a00:b95:b0:736:3d7c:2368 with SMTP id
 d2e1a72fcca58-73722353269mr2864981b3a.7.1741947363469; 
 Fri, 14 Mar 2025 03:16:03 -0700 (PDT)
Received: from fedora.smartx.com ([103.85.74.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371169549fsm2698898b3a.131.2025.03.14.03.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:16:02 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 3/3] vhost-user: return failure if backend crash when live
 migration
Date: Fri, 14 Mar 2025 06:15:34 -0400
Message-ID: <20250314101535.1059308-4-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250314101535.1059308-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Live migration should be terminated if the backend crashes before
the migration completes.

Since the vhost device will be stopped when VM is stopped before
the end of the live migration, current implementation if vhost
backend died, vhost device's set_status() will not return failure,
live migration won't perceive the disconnection between qemu and
vhost backend, inflight io would be submitted in migration target
host, leading to IO error.

To fix this issue:
1. Add set_status_ext() which has return value for
VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.

2. In set_status_ext(), return failure if the flag `connected`
is false or vhost_dev_stop return failure, which means qemu lost
connection with backend.

Hence migration_completion() will process failure, terminate
migration and restore VM.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
 hw/scsi/vhost-scsi-common.c           | 13 ++++++------
 hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
 hw/virtio/virtio.c                    | 20 +++++++++++++-----
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 include/hw/virtio/virtio.h            |  1 +
 6 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index ae42327cf8..4865786c54 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -204,7 +204,7 @@ err_host_notifiers:
     return ret;
 }
 
-static void vhost_user_blk_stop(VirtIODevice *vdev)
+static int vhost_user_blk_stop(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
     int ret;
 
     if (!s->started_vu) {
-        return;
+        return 0;
     }
     s->started_vu = false;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&s->dev, vdev, true);
+    ret = vhost_dev_stop(&s->dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
+    return ret;
 }
 
-static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
@@ -239,11 +239,11 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
     int ret;
 
     if (!s->connected) {
-        return;
+        return -1;
     }
 
     if (vhost_dev_is_started(&s->dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
@@ -253,9 +253,12 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
             qemu_chr_fe_disconnect(&s->chardev);
         }
     } else {
-        vhost_user_blk_stop(vdev);
+        ret = vhost_user_blk_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
-
+    return 0;
 }
 
 static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
@@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = vhost_user_blk_update_config;
     vdc->set_config = vhost_user_blk_set_config;
     vdc->get_features = vhost_user_blk_get_features;
-    vdc->set_status = vhost_user_blk_set_status;
+    vdc->set_status_ext = vhost_user_blk_set_status;
     vdc->reset = vhost_user_blk_reset;
     vdc->get_vhost = vhost_user_blk_get_vhost;
 }
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 4c8637045d..43525ba46d 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -101,24 +101,25 @@ err_host_notifiers:
     return ret;
 }
 
-void vhost_scsi_common_stop(VHostSCSICommon *vsc)
+int vhost_scsi_common_stop(VHostSCSICommon *vsc)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
-    vhost_dev_stop(&vsc->dev, vdev, true);
+    ret = vhost_dev_stop(&vsc->dev, vdev, true);
 
     if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
-        if (ret < 0) {
-                error_report("vhost guest notifier cleanup failed: %d", ret);
+        int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+        if (r < 0) {
+            error_report("vhost guest notifier cleanup failed: %d", ret);
+            return r;
         }
     }
-    assert(ret >= 0);
 
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
+    return ret;
 }
 
 uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index adb41b9816..8e7efc38f2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
     return ret;
 }
 
-static void vhost_user_scsi_stop(VHostUserSCSI *s)
+static int vhost_user_scsi_stop(VHostUserSCSI *s)
 {
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
 
     if (!s->started_vu) {
-        return;
+        return 0;
     }
     s->started_vu = false;
 
-    vhost_scsi_common_stop(vsc);
+    return vhost_scsi_common_stop(vsc);
 }
 
-static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
     DeviceState *dev = DEVICE(vdev);
@@ -75,11 +75,11 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     int ret;
 
     if (!s->connected) {
-        return;
+        return -1;
     }
 
     if (vhost_dev_is_started(&vsc->dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
@@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
             qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
-        vhost_user_scsi_stop(s);
+        ret = vhost_user_scsi_stop(s);
+        if (ret) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
@@ -399,7 +403,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = vhost_user_scsi_unrealize;
     vdc->get_features = vhost_scsi_common_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
-    vdc->set_status = vhost_user_scsi_set_status;
+    vdc->set_status_ext = vhost_user_scsi_set_status;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
     vdc->reset = vhost_user_scsi_reset;
     vdc->get_vhost = vhost_user_scsi_get_vhost;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5e8d4cab53..fff7cdb35d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     trace_virtio_set_status(vdev, val);
+    int ret = 0;
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
             val & VIRTIO_CONFIG_S_FEATURES_OK) {
-            int ret = virtio_validate_features(vdev);
-
+            ret = virtio_validate_features(vdev);
             if (ret) {
                 return ret;
             }
@@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
         virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
     }
 
-    if (k->set_status) {
+    if (k->set_status_ext) {
+        ret = k->set_status_ext(vdev, val);
+        if (ret) {
+            qemu_log("set %s status to %d failed, old status: %d\n",
+                     vdev->name, val, vdev->status);
+        }
+    } else if (k->set_status) {
         k->set_status(vdev, val);
     }
     vdev->status = val;
 
-    return 0;
+    return ret;
 }
 
 static enum virtio_device_endian virtio_default_endian(void)
@@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, bool running, RunState state)
     }
 
     if (!backend_run) {
-        virtio_set_status(vdev, vdev->status);
+        // the return value was used for stopping VM during migration
+        int ret = virtio_set_status(vdev, vdev->status);
+        if (ret) {
+            return ret;
+        }
     }
     return 0;
 }
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index c5d2c09455..d54d9c916f 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -40,7 +40,7 @@ struct VHostSCSICommon {
 };
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
-void vhost_scsi_common_stop(VHostSCSICommon *vsc);
+int vhost_scsi_common_stop(VHostSCSICommon *vsc);
 char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
                                         DeviceState *dev);
 void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6386910280..c99d56f519 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -187,6 +187,7 @@ struct VirtioDeviceClass {
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
     void (*set_status)(VirtIODevice *vdev, uint8_t val);
+    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
     /* Device must validate queue_index.  */
     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
     /* Device must validate queue_index.  */
-- 
2.48.1


