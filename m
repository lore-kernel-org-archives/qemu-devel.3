Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150A7C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeV-0007SU-IA; Wed, 14 May 2025 07:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdy-0006Y6-22
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAds-0006M6-HJ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K+aWiMff6gtRPihDhzGf8upD/FpK9Yj8qYiZ9/XOlMk=;
 b=RqHqayMQWw0y3hMpT4WszkZ5PquUfy2GRbGUUHN2P5t78DZE20EmmLUR92ph3zg6kMoFm6
 6yhcEpgMgyxDuriGMRqqGY/tVpNG//MPtbUWaNnVy8Kirr7xefW6Oz2/Q++c516sZdB5A4
 iXl56Qyb7Uo6/BCZ121N/svmxXHo2MU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-OUdUxqK0PSGLcIWTAJ47gQ-1; Wed, 14 May 2025 07:51:13 -0400
X-MC-Unique: OUdUxqK0PSGLcIWTAJ47gQ-1
X-Mimecast-MFC-AGG-ID: OUdUxqK0PSGLcIWTAJ47gQ_1747223472
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a1fc08c424so2676688f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223471; x=1747828271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+aWiMff6gtRPihDhzGf8upD/FpK9Yj8qYiZ9/XOlMk=;
 b=mG1QxKhOrbZZN8FJLGb2vScNe7Ur5yzyEy7uC8Mv/IHkC1JiP6khjAOPwf+cYQMto4
 mPUtAg1hkpjxiWLoHsw7MUreZuI43Uwt4b19X0XvUOYCqDHWzfM8YsO3QxR1mpoq9Fom
 bedEXo0+F8Re0W3/iJccr/l0G+bIjqnge05EB1IFbm9biYqo4RCaITRJ6ofx3/nqdrDl
 Hrq6CykqC14AAdR+mrWSCuvD3rHEh8ZNaa9XJzDrz+syOlgGNTJP9ooqFIH/u20/aK3F
 U5EBrxc0CXdIbfp5w5r9YtB6ZGADjTLM33MuZ5ULwCQbSKUq91JHy8U5Be2dmDzz8SeZ
 TZjg==
X-Gm-Message-State: AOJu0Yxd7Vtk/SPtq3tNFMu6k41fdNwR3xeeHGohpD8CPPhY80PIPHnt
 vkJRotx+lG2kFKgQhcuPPac57O1u9xvn+1NGuyuiU9m1MhC9JvC9bXptHcyFW+FNDXywQgpOUxE
 NqYjw0oLw8ymyC/yh5SqS2wunHWxcsvzon7NbP2uKfUzZRrPIE//s0u+hcGAD6L+kXgjm/Xeqg7
 WnMPyCokDVweneExVl1eI7vsBF3KonGg==
X-Gm-Gg: ASbGncswDRmi2KWzXGbfL3aFZNq0MIQdzd/2lNlxFoDfEfIw+DZ/34OloVh877eTLYe
 1Y4PE5iaEwm2PLzAWy89s0TtafuQq6eb2wKe2mVqV5xisyDdjn/3MvWgwMzJJwzyaTwPJ3teKRX
 rRvE5DvB725W7zxrdHF1divPBBoJKV3YhuIy41IdB6f7P0C4HLzqi7IQvmv2hETsd/nTKuWnI1F
 gC1ZjmvjkGvAU/IOrGnfQSsa5YHyf3oWu0R0GHiUT5nLGa4ZNrpMaTzmJnSc5kyacYmS5m68SiQ
 FfiPNg==
X-Received: by 2002:a05:6000:430e:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a349949cbbmr2567194f8f.53.1747223470923; 
 Wed, 14 May 2025 04:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGTI6xIfe+6/sDfikU2yaPh8jPeqaExm24jk6MeyIMK0QpGFQZerTpbsUVJuS6PEAgEqAlZw==
X-Received: by 2002:a05:6000:430e:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a349949cbbmr2567124f8f.53.1747223470261; 
 Wed, 14 May 2025 04:51:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ee95asm19614420f8f.11.2025.05.14.04.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:09 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haoqian He <haoqian.he@smartx.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL 20/27] vhost-user: return failure if backend crash when live
 migration
Message-ID: <bc85aae4204509420f0a4403ca728801170d9351.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Haoqian He <haoqian.he@smartx.com>

Live migration should be terminated if the vhost-user backend crashes
before the migration completes.

Specifically, since the vhost device will be stopped when VM is stopped
before the end of the live migration, in current implementation if the
backend crashes, vhost-user device set_status() won't return failure,
live migration won't perceive the disconnection between QEMU and the
backend.

When the VM is migrated to the destination, the inflight IO will be
resubmitted, and if the IO was completed out of order before, it will
cause IO error.

To fix this issue:
1. Add the return value to set_status() for VirtioDeviceClass.
  a. For the vhost-user device, return failure when the backend crashes.
  b. For other virtio devices, always return 0.
2. Return failure if vhost_dev_stop() failed for vhost-user device.

If QEMU loses connection with the vhost-user backend, virtio set_status()
can return failure to the upper layer, migration_completion() can handle
the error, terminate the live migration, and restore the VM, so that
inflight IO can be completed normally.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Message-Id: <20250416024729.3289157-4-haoqian.he@smartx.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-scsi-common.h  |  2 +-
 include/hw/virtio/vhost-vsock-common.h |  2 +-
 include/hw/virtio/virtio.h             |  2 +-
 include/system/vhost-user-backend.h    |  2 +-
 backends/vhost-user.c                  | 20 +++++++++----------
 hw/block/vhost-user-blk.c              | 27 ++++++++++++++------------
 hw/block/virtio-blk.c                  |  5 +++--
 hw/char/virtio-serial-bus.c            |  3 ++-
 hw/display/vhost-user-gpu.c            | 12 +++++++++---
 hw/input/virtio-input.c                |  3 ++-
 hw/net/virtio-net.c                    |  3 ++-
 hw/scsi/vhost-scsi-common.c            | 13 +++++++------
 hw/scsi/vhost-scsi.c                   |  5 +++--
 hw/scsi/vhost-user-scsi.c              | 18 ++++++++++-------
 hw/virtio/vdpa-dev.c                   |  5 +++--
 hw/virtio/vhost-user-base.c            | 23 +++++++++++++---------
 hw/virtio/vhost-user-fs.c              | 23 +++++++++++++---------
 hw/virtio/vhost-user-scmi.c            | 27 +++++++++++++++-----------
 hw/virtio/vhost-user-vsock.c           | 15 +++++++++-----
 hw/virtio/vhost-vsock-common.c         | 12 ++++++------
 hw/virtio/vhost-vsock.c                | 11 ++++++-----
 hw/virtio/virtio-balloon.c             |  3 ++-
 hw/virtio/virtio-crypto.c              |  3 ++-
 hw/virtio/virtio-iommu.c               |  3 ++-
 hw/virtio/virtio-rng.c                 |  5 +++--
 hw/virtio/virtio.c                     | 22 ++++++++++++++-------
 26 files changed, 160 insertions(+), 109 deletions(-)

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
diff --git a/include/hw/virtio/vhost-vsock-common.h b/include/hw/virtio/vhost-vsock-common.h
index 75a74e8a99..01bf6062af 100644
--- a/include/hw/virtio/vhost-vsock-common.h
+++ b/include/hw/virtio/vhost-vsock-common.h
@@ -42,7 +42,7 @@ struct VHostVSockCommon {
 };
 
 int vhost_vsock_common_start(VirtIODevice *vdev);
-void vhost_vsock_common_stop(VirtIODevice *vdev);
+int vhost_vsock_common_stop(VirtIODevice *vdev);
 int vhost_vsock_common_pre_save(void *opaque);
 int vhost_vsock_common_post_load(void *opaque, int version_id);
 void vhost_vsock_common_realize(VirtIODevice *vdev);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7e0c471ea4..214d4a77e9 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -186,7 +186,7 @@ struct VirtioDeviceClass {
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
-    void (*set_status)(VirtIODevice *vdev, uint8_t val);
+    int (*set_status)(VirtIODevice *vdev, uint8_t val);
     /* Device must validate queue_index.  */
     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
     /* Device must validate queue_index.  */
diff --git a/include/system/vhost-user-backend.h b/include/system/vhost-user-backend.h
index 5ed953cd53..5634ebdb2e 100644
--- a/include/system/vhost-user-backend.h
+++ b/include/system/vhost-user-backend.h
@@ -43,6 +43,6 @@ struct VhostUserBackend {
 int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
                                 unsigned nvqs, Error **errp);
 void vhost_user_backend_start(VhostUserBackend *b);
-void vhost_user_backend_stop(VhostUserBackend *b);
+int vhost_user_backend_stop(VhostUserBackend *b);
 
 #endif
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 94274a619d..42845329e7 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -97,30 +97,28 @@ err_host_notifiers:
     vhost_dev_disable_notifiers(&b->dev, b->vdev);
 }
 
-void
+int
 vhost_user_backend_stop(VhostUserBackend *b)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret = 0;
+    int ret;
 
     if (!b->started) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&b->dev, b->vdev, true);
+    ret = vhost_dev_stop(&b->dev, b->vdev, true);
 
-    if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent,
-                                     b->dev.nvqs, false);
-        if (ret < 0) {
-            error_report("vhost guest notifier cleanup failed: %d", ret);
-        }
+    if (k->set_guest_notifiers &&
+        k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false) < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return -1;
     }
-    assert(ret >= 0);
 
     vhost_dev_disable_notifiers(&b->dev, b->vdev);
     b->started = false;
+    return ret;
 }
 
 static void set_chardev(Object *obj, const char *value, Error **errp)
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4bb5ed299e..0eebbcd80d 100644
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
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ea948d18fd..9bab2716c1 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1270,7 +1270,7 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
-static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
+static int virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
@@ -1279,7 +1279,7 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
     }
 
     if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
-        return;
+        return 0;
     }
 
     /* A guest that supports VIRTIO_BLK_F_CONFIG_WCE must be able to send
@@ -1302,6 +1302,7 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
                                    virtio_vdev_has_feature(vdev,
                                                            VIRTIO_BLK_F_WCE));
     }
+    return 0;
 }
 
 static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index eb79f5258b..673c50f0be 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -622,7 +622,7 @@ static void guest_reset(VirtIOSerial *vser)
     }
 }
 
-static void set_status(VirtIODevice *vdev, uint8_t status)
+static int set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOSerial *vser;
     VirtIOSerialPort *port;
@@ -650,6 +650,7 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
             vsc->enable_backend(port, vdev->vm_running);
         }
     }
+    return 0;
 }
 
 static void vser_reset(VirtIODevice *vdev)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 43d4c08a2e..9fc6bbcd2c 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -516,7 +516,7 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
     }
 }
 
-static void
+static int
 vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VhostUserGPU *g = VHOST_USER_GPU(vdev);
@@ -525,18 +525,24 @@ vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
     if (val & VIRTIO_CONFIG_S_DRIVER_OK && vdev->vm_running) {
         if (!vhost_user_gpu_do_set_socket(g, &err)) {
             error_report_err(err);
-            return;
+            return 0;
         }
         vhost_user_backend_start(g->vhost);
     } else {
+        int ret;
+
         /* unblock any wait and stop processing */
         if (g->vhost_gpu_fd != -1) {
             vhost_user_gpu_update_blocked(g, true);
             qemu_chr_fe_deinit(&g->vhost_chr, true);
             g->vhost_gpu_fd = -1;
         }
-        vhost_user_backend_stop(g->vhost);
+        ret = vhost_user_backend_stop(g->vhost);
+        if (ret < 0) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static bool
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 1818cbddc7..a3f554f211 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -189,7 +189,7 @@ static uint64_t virtio_input_get_features(VirtIODevice *vdev, uint64_t f,
     return f;
 }
 
-static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
+static int virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
     VirtIOInput *vinput = VIRTIO_INPUT(vdev);
@@ -202,6 +202,7 @@ static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
+    return 0;
 }
 
 static void virtio_input_reset(VirtIODevice *vdev)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2de037c273..221252e00a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -382,7 +382,7 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
-static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
+static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q;
@@ -437,6 +437,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
             }
         }
     }
+    return 0;
 }
 
 static void virtio_net_set_link_status(NetClientState *nc)
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
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 10fde8eee0..dd4250ebe8 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -114,7 +114,7 @@ static void vhost_scsi_stop(VHostSCSI *s)
     vhost_scsi_common_stop(vsc);
 }
 
-static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
+static int vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VHostSCSI *s = VHOST_SCSI(vdev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
@@ -125,7 +125,7 @@ static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
     }
 
     if (vhost_dev_is_started(&vsc->dev) == start) {
-        return;
+        return 0;
     }
 
     if (start) {
@@ -139,6 +139,7 @@ static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
     } else {
         vhost_scsi_stop(s);
     }
+    return 0;
 }
 
 static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 8298e8cc6d..25f2d894e7 100644
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
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index dd8837ce4e..d1da40afc8 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -312,7 +312,7 @@ static void vhost_vdpa_device_stop(VirtIODevice *vdev)
     vhost_dev_disable_notifiers(&s->dev, vdev);
 }
 
-static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
     bool should_start = virtio_device_started(vdev, status);
@@ -324,7 +324,7 @@ static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
     }
 
     if (s->started == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
@@ -335,6 +335,7 @@ static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
     } else {
         vhost_vdpa_device_stop(vdev);
     }
+    return 0;
 }
 
 static const Property vhost_vdpa_device_properties[] = {
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 77143320a2..ff67a020b4 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -66,7 +66,7 @@ err_host_notifiers:
     vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
 }
 
-static void vub_stop(VirtIODevice *vdev)
+static int vub_stop(VirtIODevice *vdev)
 {
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -74,34 +74,39 @@ static void vub_stop(VirtIODevice *vdev)
     int ret;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&vub->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vub->vhost_dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
 
     vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
+    return ret;
 }
 
-static void vub_set_status(VirtIODevice *vdev, uint8_t status)
+static int vub_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
 
     if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
         vub_start(vdev);
     } else {
-        vub_stop(vdev);
+        int ret;
+        ret = vub_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 /*
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index f6d1fc8804..e77c69eb12 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -100,7 +100,7 @@ err_host_notifiers:
     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
 }
 
-static void vuf_stop(VirtIODevice *vdev)
+static int vuf_stop(VirtIODevice *vdev)
 {
     VHostUserFS *fs = VHOST_USER_FS(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -108,34 +108,39 @@ static void vuf_stop(VirtIODevice *vdev)
     int ret;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&fs->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&fs->vhost_dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
 
     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
+    return ret;
 }
 
-static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
+static int vuf_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserFS *fs = VHOST_USER_FS(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
 
     if (vhost_dev_is_started(&fs->vhost_dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
         vuf_start(vdev);
     } else {
-        vuf_stop(vdev);
+        int ret;
+        ret = vuf_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static uint64_t vuf_get_features(VirtIODevice *vdev,
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 7a0f622181..f9264c4374 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -83,7 +83,7 @@ err_host_notifiers:
     return ret;
 }
 
-static void vu_scmi_stop(VirtIODevice *vdev)
+static int vu_scmi_stop(VirtIODevice *vdev)
 {
     VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -93,41 +93,46 @@ static void vu_scmi_stop(VirtIODevice *vdev)
 
     /* vhost_dev_is_started() check in the callers is not fully reliable. */
     if (!scmi->started_vu) {
-        return;
+        return 0;
     }
     scmi->started_vu = false;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(vhost_dev, vdev, true);
+    ret = vhost_dev_stop(vhost_dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
     vhost_dev_disable_notifiers(vhost_dev, vdev);
+    return ret;
 }
 
-static void vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
+static int vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
 
     if (!scmi->connected) {
-        return;
+        return -1;
     }
     if (vhost_dev_is_started(&scmi->vhost_dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
         vu_scmi_start(vdev);
     } else {
-        vu_scmi_stop(vdev);
+        int ret;
+        ret = vu_scmi_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static uint64_t vu_scmi_get_features(VirtIODevice *vdev, uint64_t features,
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 2776792f59..993c287348 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -54,23 +54,28 @@ const VhostDevConfigOps vsock_ops = {
     .vhost_dev_config_notifier = vuv_handle_config_change,
 };
 
-static void vuv_set_status(VirtIODevice *vdev, uint8_t status)
+static int vuv_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
+    int ret;
 
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
-        int ret = vhost_vsock_common_start(vdev);
+        ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
-            return;
+            return ret;
         }
     } else {
-        vhost_vsock_common_stop(vdev);
+        ret = vhost_vsock_common_stop(vdev);
+        if (ret < 0) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 static uint64_t vuv_get_features(VirtIODevice *vdev,
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 4b4fbb45cc..c6c44d8989 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -95,7 +95,7 @@ err_host_notifiers:
     return ret;
 }
 
-void vhost_vsock_common_stop(VirtIODevice *vdev)
+int vhost_vsock_common_stop(VirtIODevice *vdev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -103,18 +103,18 @@ void vhost_vsock_common_stop(VirtIODevice *vdev)
     int ret;
 
     if (!k->set_guest_notifiers) {
-        return;
+        return 0;
     }
 
-    vhost_dev_stop(&vvc->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true);
 
-    ret = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
-    if (ret < 0) {
+    if (k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
+        return -1;
     }
 
     vhost_dev_disable_notifiers(&vvc->vhost_dev, vdev);
+    return ret;
 }
 
 
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index b73dc723c2..6e4088831f 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -67,37 +67,38 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
 }
 
 
-static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
+static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
-        return;
+        return 0;
     }
 
     if (should_start) {
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
-            return;
+            return 0;
         }
 
         ret = vhost_vsock_set_running(vdev, 1);
         if (ret < 0) {
             vhost_vsock_common_stop(vdev);
             error_report("Error starting vhost vsock: %d", -ret);
-            return;
+            return 0;
         }
     } else {
         ret = vhost_vsock_set_running(vdev, 0);
         if (ret < 0) {
             error_report("vhost vsock set running failed: %d", ret);
-            return;
+            return 0;
         }
 
         vhost_vsock_common_stop(vdev);
     }
+    return 0;
 }
 
 static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 91510ec2e2..db787d00b3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -958,7 +958,7 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
     s->poison_val = 0;
 }
 
-static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
+static int virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
@@ -988,6 +988,7 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
             qemu_mutex_unlock(&s->free_page_lock);
         }
     }
+    return 0;
 }
 
 static ResettableState *virtio_balloon_get_reset_state(Object *obj)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index e24d6914b6..517f2089c5 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1197,11 +1197,12 @@ static void virtio_crypto_vhost_status(VirtIOCrypto *c, uint8_t status)
     }
 }
 
-static void virtio_crypto_set_status(VirtIODevice *vdev, uint8_t status)
+static int virtio_crypto_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
 
     virtio_crypto_vhost_status(vcrypto, status);
+    return 0;
 }
 
 static void virtio_crypto_guest_notifier_mask(VirtIODevice *vdev, int idx,
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 54060988ef..3500f1b082 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1522,9 +1522,10 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
                                    NULL, NULL, virtio_iommu_put_endpoint);
 }
 
-static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
+static int virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
 {
     trace_virtio_iommu_device_status(status);
+    return 0;
 }
 
 static void virtio_iommu_instance_init(Object *obj)
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index dcb3c71d6a..3df5d2576e 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -159,17 +159,18 @@ static void check_rate_limit(void *opaque)
     vrng->activate_timer = true;
 }
 
-static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
+static int virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIORNG *vrng = VIRTIO_RNG(vdev);
 
     if (!vdev->vm_running) {
-        return;
+        return 0;
     }
     vdev->status = status;
 
     /* Something changed, try to process buffers */
     virtio_rng_process(vrng);
+    return 0;
 }
 
 static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e3b62522ec..1b55d8d8a2 100644
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
@@ -2239,11 +2239,15 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     }
 
     if (k->set_status) {
-        k->set_status(vdev, val);
+        ret = k->set_status(vdev, val);
+        if (ret) {
+            qemu_log("set %s status to %d failed, old status: %d\n",
+                     vdev->name, val, vdev->status);
+        }
     }
     vdev->status = val;
 
-    return 0;
+    return ret;
 }
 
 static enum virtio_device_endian virtio_default_endian(void)
@@ -3419,7 +3423,7 @@ void virtio_cleanup(VirtIODevice *vdev)
     qemu_del_vm_change_state_handler(vdev->vmstate);
 }
 
-static void virtio_vmstate_change(void *opaque, bool running, RunState state)
+static int virtio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3436,8 +3440,12 @@ static void virtio_vmstate_change(void *opaque, bool running, RunState state)
     }
 
     if (!backend_run) {
-        virtio_set_status(vdev, vdev->status);
+        int ret = virtio_set_status(vdev, vdev->status);
+        if (ret) {
+            return ret;
+        }
     }
+    return 0;
 }
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
@@ -3489,7 +3497,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
         vdev->config = NULL;
     }
     vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            virtio_vmstate_change, NULL, vdev);
+            NULL, virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
 }
-- 
MST


