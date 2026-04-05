Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95520E64016
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvP-0003xa-S7; Sun, 05 Apr 2026 03:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvN-0003wf-SL
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:37 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvM-0007Ls-6e
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:37 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c56aa62931so7205459eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374174; x=1775978974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLtrvafoDrJyXblIjHcl3upLz3DHq6xj+dch2j8+x6I=;
 b=ZCV2QlFGExB45llkySP4a2T2IDl0xcwJhIXhoOdzx2zMJeRnzC5fXVA3qFODG/D407
 HTkmW7KcqA6tQ1C30QeSWP53jGabwH01z2ZBf7uRQkX7eFQ3XjLpRjMxtV8W54Z4Kw8B
 ZYJ5jLukOkQWomSXAO/LGtgG2tGQ5kXXpmXojvp3z0UE5VcQ6jqxSklW3PhjoxJpKf95
 YNboIAJ5LHZTbyoAALNRLyMWYq+25im/DbC/W5hvYMnJeAarEsNkaIJC0R1A1q7SYejF
 gBGCRSHLkvUrerY75XzOg40m1XJ/Ldy5srRppw0+8pon5f9dOOrejTzlGNL9O5+d3Lxg
 dapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374174; x=1775978974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLtrvafoDrJyXblIjHcl3upLz3DHq6xj+dch2j8+x6I=;
 b=Be2Jf3RetRt0HA+LEhuVY0v/1k+w54wA+br6kHnal9ZB80agdtsYrzXGNbIAUlZfsA
 cl/RTa8k+8qgLxpV7BYg7jZet5s1sPWVddmwtf0vfop8Z6B4uV7Of8i3r+qW/ZrZFt7I
 w7OWjcVexHjXw/mLSTQf4Hoa+EpK8JOpl7+dQNUHeY0FVtMqwGt/u4dUQVhyzS3gNw59
 sIh9EMXqm17jf2rSFb9xvwagqoHakuqZJwcifUSX6RejUd1xCMfuDXrouKnVKn4Nja33
 WSSkqhuZmUB3rrHCadsg+ISX94oxpaSUZDhDBrfM+PSkOu1xOckBwb/2imrPkSJD/kr9
 2dwg==
X-Gm-Message-State: AOJu0YzS3NNTzek36uwWuUYvyTbMofD7WCSj6vix3Ruye1KniGrBwQTj
 y+UWO6C/PjMIUbRd9TWkzFj52iJCafc7i221XuFTZYAvdvyTtqFSLOIVvewDLmb8QoQ=
X-Gm-Gg: AeBDievuyop0YQhpA+cbD341AVeUcHMbY+YUvl0f/9pDCwZ8Iq379YqMW1WTV8ZIW8t
 Jb5l5n9gtDbYvLpZo8QAgog6RPfk8dIdBNcN8fKgUa1b2pThXrMeW89PXXmuak7ER1zIBkSQnth
 uqUddwYEYx1j6qXQMeLo76KJ9SdoS9OAAJ6esFoz2KsQf9BwKnrp3tn7DYn4Dz/pzHdg3Lv04Ov
 FkDpPxccuNeyz5LNbxA3TEjdTPsc2d+rzf1khILmJPOL9xtwCjgvFtS5DB4Mt8fsC9338bgGPOW
 vyB/5Xbho5XZ+75uPv5uVm6KudhaorHlFdz9D6xlOmd8DJ8JW6hJSCJiDtNkneE5nXE2RGvaj2Z
 XLBM1GpZQI+SUTw97LSAzdKlKPlCWjUpN9thpJ64sge97izgJ9q36hmiXI1an8d+9OQngpqsqbz
 axyNyFHIA/nP+CeDyxRRt+z8xfzxlXq+wdipNa6YpWb9pdDat10xfxgsCOgee8BRhKstkMeZiyD
 wFdsfzbmFSrVU4JKcdXdqope0k=
X-Received: by 2002:a05:7300:371f:b0:2c5:76d1:7f95 with SMTP id
 5a478bee46e88-2cbfc763331mr4392826eec.28.1775374174457; 
 Sun, 05 Apr 2026 00:29:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:34 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 06/10] vfio: Add device_reset callback to VFIODeviceIOOps
Date: Sun,  5 Apr 2026 00:28:50 -0700
Message-ID: <20260405072857.66484-7-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Route all VFIO_DEVICE_RESET ioctl calls through a new device_reset
io_ops callback, matching the pattern established for region_map and
region_unmap. This allows non-Linux backends to provide their own
reset implementation.

The Linux ioctl backend implements the callback by issuing the
VFIO_DEVICE_RESET ioctl. All existing callsites in pci.c, ccw.c,
ap.c, and migration.c are converted to use the callback.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio/ap.c                  |  4 ++--
 hw/vfio/ccw.c                 |  2 +-
 hw/vfio/device.c              |  8 ++++++++
 hw/vfio/migration.c           |  5 +++--
 hw/vfio/pci.c                 |  6 ++++--
 include/hw/vfio/vfio-device.h | 11 +++++++++++
 6 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 5c8f305653..2f2f17e666 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -290,10 +290,10 @@ static void vfio_ap_reset(DeviceState *dev)
     int ret;
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
-    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
+    ret = vapdev->vdev.io_ops->device_reset(&vapdev->vdev);
     if (ret) {
         error_report("%s: failed to reset %s device: %s", __func__,
-                     vapdev->vdev.name, strerror(errno));
+                     vapdev->vdev.name, strerror(-ret));
     }
 }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ce9c014e6a..330b733b7e 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -242,7 +242,7 @@ static void vfio_ccw_reset(DeviceState *dev)
 {
     VFIOCCWDevice *vcdev = VFIO_CCW(dev);
 
-    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
+    vcdev->vdev.io_ops->device_reset(&vcdev->vdev);
 }
 
 static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 1b703dcbec..cf3953d975 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -657,6 +657,13 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     return ret < 0 ? -errno : ret;
 }
 
+static int vfio_device_io_device_reset(VFIODevice *vbasedev)
+{
+    int ret = ioctl(vbasedev->fd, VFIO_DEVICE_RESET);
+
+    return ret < 0 ? -errno : ret;
+}
+
 static int vfio_device_io_region_map(VFIODevice *vbasedev, VFIORegion *region)
 {
     return vfio_region_mmap_fd(region);
@@ -673,6 +680,7 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .get_region_info = vfio_device_io_get_region_info,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
+    .device_reset = vfio_device_io_device_reset,
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
     .region_map = vfio_device_io_region_map,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 83327b6573..b31253ea90 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -216,9 +216,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
     return 0;
 
 reset_device:
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_RESET)) {
+    ret = vbasedev->io_ops->device_reset(vbasedev);
+    if (ret) {
         hw_error("%s: Failed resetting device, err: %s", vbasedev->name,
-                 strerror(errno));
+                 strerror(-ret));
     }
 
     vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index cf817d9ae7..458b3400cc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3691,7 +3691,8 @@ static void vfio_pci_reset(DeviceState *dev)
 
     if (vdev->vbasedev.reset_works &&
         (vdev->has_flr || !vdev->has_pm_reset) &&
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        vdev->vbasedev.io_ops && vdev->vbasedev.io_ops->device_reset &&
+        !vdev->vbasedev.io_ops->device_reset(&vdev->vbasedev)) {
         trace_vfio_pci_reset_flr(vdev->vbasedev.name);
         goto post_reset;
     }
@@ -3703,7 +3704,8 @@ static void vfio_pci_reset(DeviceState *dev)
 
     /* If nothing else works and the device supports PM reset, use it */
     if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        vdev->vbasedev.io_ops && vdev->vbasedev.io_ops->device_reset &&
+        !vdev->vbasedev.io_ops->device_reset(&vdev->vbasedev)) {
         trace_vfio_pci_reset_pm(vdev->vbasedev.name);
         goto post_reset;
     }
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 1a3b42bcaf..0e6bff774e 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -262,6 +262,17 @@ struct VFIODeviceIOOps {
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                         void *data, bool post);
 
+    /**
+     * @device_reset
+     *
+     * Reset the device.
+     *
+     * @vdev: #VFIODevice to reset
+     *
+     * Returns 0 on success or -errno.
+     */
+    int (*device_reset)(VFIODevice *vdev);
+
     /**
      * @region_map
      *
-- 
2.50.1 (Apple Git-155)


