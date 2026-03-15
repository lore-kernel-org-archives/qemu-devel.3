Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279F8F3027F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 23:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ubz-0007kc-Q2; Sun, 15 Mar 2026 19:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1w1uby-0007k7-Aa
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 19:11:06 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1w1ubw-0006dp-AH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 19:11:06 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c73c990a96dso1421225a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773616262; x=1774221062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BK3QiOXkHy9DVmr/GmN/dXj8oowzRtyTvOsgATq+HoQ=;
 b=T3uOcXRQN0/C08xGiMAXEdBWTd9k/YX+MMHacU7nbdi+bPkPRArfM7lS/XwUBUgj4B
 XZfDrZ0Eiq0BbcN1z+cInTLxESHlKyykN5nwY9gvTZN8F6ZLUQ4/SLQnt+2DGnHPKdWS
 ZdQVAD7xbT5gTBXQCt2mSseosDvKch0rsjMqk2+thnQGISkJD4QWESmyXELCWGkgXdk6
 z/QLdEQbtKlWjnJLWRTZZ2nWrwL45X4JN6js2TaNtN7NOtgCWP6uJXnlOeipLZ1Ftddn
 Uesn2fddPRjL9UmL+pDjat+dJojeIouotgVkV4K5Tnipo52lS6zqrirg7FYBZLH4et/u
 BqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773616262; x=1774221062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BK3QiOXkHy9DVmr/GmN/dXj8oowzRtyTvOsgATq+HoQ=;
 b=kVh2V0qrFVCg4oBN4bh+gYqPoWjxokqOmqkIN5CHeK0dbW9Br+h9apV9RFwLhX6Kt3
 o08ee582SSzu/OGB3QQ7i4WNzN1UA0yKjBX0wG7YrfXeAIzX9u1rowmpqEG7LW6TXy7V
 YF4yeqTW2JcmzHYlW59VmfD04RD/JdN9oqL5oJAAOmoXjMljs2NOJOCYjHYC8OxYlXg2
 pv2DFQAmhR2RwQvONpXdLsqRRt1r26Xh537DXRXuYY21ZmqBvGuOkhGBu8JHLfrm+C6E
 sU+M+ygA4w2nDW+83Ap1jJ8N1R4DyP3T9CKDRZp38/6Y9+lHvqx4IEGZO9LUZgM22Lbn
 3enw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGXTcpG8Zp8+9zpIgOkFgfLAj18BWdCQQ8lckwHtwbTxkWqQbXEOKHH3WTONkeAccbw9xIykzmQac1@nongnu.org
X-Gm-Message-State: AOJu0YwsIh+oZsKZA/Ev4SXYs2Mq9RwmPnvKvHOo5/1AFTP6MuWGtizR
 LWM4ZuRlnvMzh9EgpxOD6yCC+N7UZwt6LiDu6QcY0b7Y/Yr8wgjDFwTK
X-Gm-Gg: ATEYQzxpdO5Zuvh8kwss3S8yIqMZ+CE8xM4G3nrrm0ywrVg3ClrT6ERi3kvlbkEHQkr
 djpV8IaEwtamRgq/07RiC3pTgAtdtl6olR+d0Ql2cXxdKdUo6ujjM4+x8wVSYApnNZGXGAddMYG
 WOJeC8S2UrM+Vk2ADLT0yPJiSrHZZhuWJmtsWGIE5DeSxQjtwGVAiz0J9GYJwnF+lw0it18sTgY
 j7T1cTbiZG1eFVe+p6f3HtMGtLgOw2ni5dLy3ID7NaUeyvjcV0mxCO0QWYP8glvuA0rNY/YAxgs
 h6HFi8x4S5/Xw/dGI11zwwNBkPsuTjRbt+qWSORp0T6CM/Fjqn1QLvFZ+YsBuGAkp3rW8pczUSy
 hYzPND2WLDdcXzha44GvV4ZaqJ7aIopfJ3/R5e+2BkfbqJln3LCpFr6dvCO+NkzJQ+GdA8fuRgl
 xmZ6oGfv68U5s0yweKs5uOtxbMkDoq/bY6c2+0XBFWtCKd6ExlIcipivI/VNudNt2zulmnyDIhw
 8jB5g9KUFVi8O4JvRa5+ouqJUYLfmORkNwS
X-Received: by 2002:a17:902:f647:b0:2b0:5738:9817 with SMTP id
 d9443c01a7336-2b057389adamr14494125ad.31.1773616262291; 
 Sun, 15 Mar 2026 16:11:02 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee9f2sm87593565ad.56.2026.03.15.16.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 16:11:01 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mst@redhat.com, sgarzare@redhat.com, rnorwitz@nvidia.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 alex.bennee@linaro.org, stefanha@redhat.com, mzamazal@redhat.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] vhost-user: Fix stale error logs and return values in
 teardown paths
Date: Sun, 15 Mar 2026 23:10:47 +0000
Message-ID: <20260315231047.310029-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=visitorckw@gmail.com; helo=mail-pg1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit bc85aae42045 ("vhost-user: return failure if backend crash when
live migration") refactored the set_guest_notifiers error handling but
introduced two regressions across multiple vhost devices.

By moving the function call directly into the if condition, the
subsequent error_report prints the stale ret variable instead of the
actual error code. Additionally, the refactoring hardcoded a return
value of -1 rather than propagating the true error status to the
caller.

Fix these issues by storing the set_guest_notifiers result in a local
err variable.

Fixes: bc85aae42045 ("vhost-user: return failure if backend crash when live migration")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 backends/vhost-user.c          | 8 ++++----
 hw/block/vhost-user-blk.c      | 9 +++++----
 hw/scsi/vhost-scsi-common.c    | 2 +-
 hw/virtio/vhost-user-base.c    | 9 +++++----
 hw/virtio/vhost-user-fs.c      | 9 +++++----
 hw/virtio/vhost-user-scmi.c    | 9 +++++----
 hw/virtio/vhost-vsock-common.c | 9 +++++----
 7 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 42845329e7..380d825023 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -102,7 +102,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
 
     if (!b->started) {
         return 0;
@@ -111,9 +111,9 @@ vhost_user_backend_stop(VhostUserBackend *b)
     ret = vhost_dev_stop(&b->dev, b->vdev, true);
 
     if (k->set_guest_notifiers &&
-        k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+        (err = k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false)) < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
 
     vhost_dev_disable_notifiers(&b->dev, b->vdev);
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e83677..841fda273a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -209,7 +209,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
     bool force_stop = false;
 
     if (!s->started_vu) {
@@ -227,9 +227,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
                        vhost_dev_stop(&s->dev, vdev, true);
 
-    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+    err = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+    if (err < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 0bb4305de6..e19800a0bc 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -113,7 +113,7 @@ int vhost_scsi_common_stop(VHostSCSICommon *vsc)
     if (k->set_guest_notifiers) {
         int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
         if (r < 0) {
-            error_report("vhost guest notifier cleanup failed: %d", ret);
+            error_report("vhost guest notifier cleanup failed: %d", r);
             return r;
         }
     }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 01ab9ca56b..1d9e99b824 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -71,7 +71,7 @@ static int vub_stop(VirtIODevice *vdev)
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
 
     if (!k->set_guest_notifiers) {
         return 0;
@@ -79,9 +79,10 @@ static int vub_stop(VirtIODevice *vdev)
 
     ret = vhost_dev_stop(&vub->vhost_dev, vdev, true);
 
-    if (k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+    err = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
+    if (err < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
 
     vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index ad6fcacf06..209993918a 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -105,7 +105,7 @@ static int vuf_stop(VirtIODevice *vdev)
     VHostUserFS *fs = VHOST_USER_FS(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
 
     if (!k->set_guest_notifiers) {
         return 0;
@@ -113,9 +113,10 @@ static int vuf_stop(VirtIODevice *vdev)
 
     ret = vhost_dev_stop(&fs->vhost_dev, vdev, true);
 
-    if (k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+    err = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+    if (err < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
 
     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index f9264c4374..9470f68c1f 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -89,7 +89,7 @@ static int vu_scmi_stop(VirtIODevice *vdev)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     struct vhost_dev *vhost_dev = &scmi->vhost_dev;
-    int ret;
+    int ret, err;
 
     /* vhost_dev_is_started() check in the callers is not fully reliable. */
     if (!scmi->started_vu) {
@@ -103,9 +103,10 @@ static int vu_scmi_stop(VirtIODevice *vdev)
 
     ret = vhost_dev_stop(vhost_dev, vdev, true);
 
-    if (k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+    err = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
+    if (err < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
     vhost_dev_disable_notifiers(vhost_dev, vdev);
     return ret;
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index b33def900a..b79f4c9ce6 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -100,7 +100,7 @@ int vhost_vsock_common_stop(VirtIODevice *vdev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
 
     if (!k->set_guest_notifiers) {
         return 0;
@@ -108,9 +108,10 @@ int vhost_vsock_common_stop(VirtIODevice *vdev)
 
     ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true);
 
-    if (k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false) < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return -1;
+    err = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
+    if (err < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", err);
+        return err;
     }
 
     vhost_dev_disable_notifiers(&vvc->vhost_dev, vdev);
-- 
2.53.0.851.ga537e3e6e9-goog


