Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D5CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCP-0006qo-Ej; Sun, 14 Jun 2026 15:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCO-0006lt-5B
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCM-0002KR-Ar
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sh5em8AlVrr5g6Oxe+hgEPBbAlPW7zFJt8787kbMrrY=;
 b=dl66ma256pf7frH44ei+YqmWQjK/+P50nUAtjQT5hAvrl7At9isHC6sd2aWsF8wp/c15QC
 B4zgwDtiC3et55J6R0PiuF24mA9Oj4RmfuHEJs0WLXZpTcfgTRiBaoNKT3Zjs1b0Qjrz3u
 XU3JEUhnl4ZrrIuML329/Xa7AEiCBKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-eaWnCby7O6aqfhCG-ZmWmQ-1; Sun, 14 Jun 2026 15:08:44 -0400
X-MC-Unique: eaWnCby7O6aqfhCG-ZmWmQ-1
X-Mimecast-MFC-AGG-ID: eaWnCby7O6aqfhCG-ZmWmQ_1781464123
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so22237295e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464123; x=1782068923; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sh5em8AlVrr5g6Oxe+hgEPBbAlPW7zFJt8787kbMrrY=;
 b=bnEcXKYSKnp1eOa5Tal3cs5H83XI1Tl9eMCWrvwqnixXPqj8qCcZTGd739H7utjM3+
 qWHmzj15plLnxZJydmpjTp7/u6OnvSvyx1kKh3llsrxJ0BmFi/nCshg2H22txmK7WizY
 gXbeVNUbJVBHEJ5UH0bLNDuBTrOO1xM6bLQsOZYIOi2Rd/a56gVQe1i8nd7Y3/7MEO+k
 DpEu40ZEPGQ8RPePZt+B+ZMLo0PZTbNRzYyaE1WqZ+J5olTo4OIVijGv5oVX8YgiGEuH
 n/Kcx6Bcf5HMjmytuw0mYMrjPL1ihE6IOeAhJec1vqGnmpdgmmxKlVPW1czsZ9D07qYr
 xMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464123; x=1782068923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sh5em8AlVrr5g6Oxe+hgEPBbAlPW7zFJt8787kbMrrY=;
 b=jArCypRaAwzJpvhrZTGoOAk0+eXj2eVuczgYbXg6hEYA0V0Ppe6Kkw5A5tapj3lrko
 zCK+/boyXGQ8JFs/4d2/l355PzWWJ88+hZowFTKIA+D7zfF13/E0gPjnjdZtvr5mDjDx
 t32KQ6oOWKGtLmNy6Q+Cj+3+CaAtMwSD+YBdASS/Xz1Hgo2UzoLAEMvrcwi+1iZ2/9jL
 lOJRAlDmKFyq50HW/7//FVMsri+PZO0ikwtLjKSHvxFiIr00CRlIZQB9Djib5Yt180QW
 1lUpkk8laqjXySjayThvtSA6oBYoDDyMwIFuS7IkFZcFjScc8F4irwo4lrqXWoK2JCDh
 69lA==
X-Gm-Message-State: AOJu0Yxm1ll8TTiou8c6iFcsE9q5XMNX+bU7VuxConeYV2eIhVQrj1Ww
 d6Nh1Uc4YqOmRa59Mc3O8xaHZ1b4YuPOdvdhHcKPsNyec1M5ht4vnAizZMTKNkDKS/o5cVB+xVW
 Nsx0ByfQtCwr/Qtui8GsSv72vFK5/uif9FbirY+KoWMNaJFj1+n0XUpRzdU3co+nNeSjShYISrO
 +d+QnsI+uA6vtAxe3RxnYZ8VHlwR9r7S9/JA==
X-Gm-Gg: Acq92OGZqwTmTFXTcYU8cqhilv1e8H1EiHMSnNyzJw5hLMpMx4L7C2fpquezOLp/FD7
 y4jiriG62Wl9tT8p+A02dqkMaeYgG436tG3nJ5VoqAWUODZd4D6Hv7bVa0GVbhgIqorJzYuiAz6
 O3t/Ubq26gT+ftMlNwlWS4uXIYj7zWKLFkZMAkJLl/3RWGuJtBoTybNPfOpBYjf1oeIDVfG/Mvl
 rbKe5BzKdscLE6JjzLrrlkNaGI/7eghhpLO5dSeHQG+wHGy1+jg9Tv2kgBl8LZ3SZ7kP25hPhF/
 ZjPn99IMUwDsNSHB0xVFjyd+VsKIDw9XzxKrtzU4jHwFajw9OuzkTZzBPMrM6uWZF3wq807yfvz
 nwjh+MhcN4gvXsYlVJcl2htb2w+Vdp99E1mqfIa5oM/s=
X-Received: by 2002:a05:600c:3548:b0:490:ea8a:32d0 with SMTP id
 5b1f17b1804b1-490ec501917mr155241245e9.20.1781464122978; 
 Sun, 14 Jun 2026 12:08:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:490:ea8a:32d0 with SMTP id
 5b1f17b1804b1-490ec501917mr155240785e9.20.1781464122343; 
 Sun, 14 Jun 2026 12:08:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037ba81sm178130015e9.15.2026.06.14.12.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:41 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL 069/106] vhost-user: Fix stale error logs and return values in
 teardown paths
Message-ID: <eef8552c474f9ed3a82cf37cf2c5b227521a5f4b.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260315231047.310029-1-visitorckw@gmail.com>
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
index 5c73a58ee0..b2e46eb3f9 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -214,7 +214,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
+    int ret, err;
     bool force_stop = false;
 
     trace_vhost_user_blk_stop_in(vdev);
@@ -234,9 +234,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
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
index 5bbf4a7367..8b62c6c36e 100644
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
MST


