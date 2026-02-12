Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5385FEEA86F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgO2-0004iX-Kb; Thu, 12 Feb 2026 18:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNy-0004gO-DY
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:14 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNv-0008BG-En
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:13 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso217541b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770939970; x=1771544770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEmb+NuIA92kpdVxEe8MYTCkuvizaCU9Eyv3aVlm5ok=;
 b=JMRz/3Liil+BgWILxGICt2E54KOZhcjo1lYPjGG3fKlnAFnSfntFrLgZugihDbkEbp
 81wbom1rWIpwWlvaICXOusuNUZmP1uihiUG4xBWhVjd3xBcLbnwpO+BoraIPOh8soFn+
 f3UhLnobEuIxM5HOE/A/uTYofKs9j9H5WRuUVmZ3TY22xy2dkcbUeojST0AenzdFfYH2
 SUQ1Mc9pp1l/SfYkAo3gW7ieSNAb30IKNDLhctomWOseb+SGTiTTF9t13Nda9brDnJJ4
 xgAYDQlo6LfhkXGAPX0LKFPwmZsdWG5CvpVDkRdlNTZXzi8WPqpgxcGXrFCEQTbEzebC
 F92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770939970; x=1771544770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gEmb+NuIA92kpdVxEe8MYTCkuvizaCU9Eyv3aVlm5ok=;
 b=MRu85AfBPACyLXV+Q3dWFzwf4zXyFojIdxA+9sUBEHskV8ek9aPDyAqolV+3PpOV4N
 2d7jcoGyfM3Tejyc9K9/XaHdnBbmwygAQ+/XZYSObhyj2MKKCKDlL7ij1DPaZCKsUR5s
 jIvleLnYk/MvPHxEQpIa1r0DwS5WKRpIAqcPiMpOGlMzczER3I856woaRLNwNtcAHKc4
 wHUvTlKd5LasNtgtj6rLWUwjr6PJgDVEMm0Hb5DsPGpJH/1yX/oNHu0AaIrayC+0iumY
 SBcIpGF89m81MNpKpOZRhPs4oM5IMOX7Whty52YzZ3BBaLusguUBjUaPVZB5QGqh3oUu
 6y0g==
X-Gm-Message-State: AOJu0YyICLCuNqfeTnzWDUZexOuy7eM8Kp0/1CYoW+hRsnfByTmifWoT
 LE07T9SVJ9R76PT4ZlSivWKj5GCiTRtOCpXfvJlDJUmVOyUczyZp6Z/T8Oy6KAMyYHOoIwfGyVc
 LQX75
X-Gm-Gg: AZuq6aLGjjaLDyLud1rtIEKGIILOiO6vCBcm/WSIx3gcA2pdRxs3MF8jm1u82e5TQ/l
 50ShN1jW3AksPztryfZDN8CR617ewhsYYrSrNqePx2E6QSyGSsgP8Y0NWO5F0m37XH02jiouuQz
 s9yHbIV9okHbRhVra4KW6O9oW3yWo0sL35ZkEs/iw6nH/isKb7K615lc0fSryD2w73o1UcX9YdW
 ZoGUK+PtE44ZMaGqDUrDnAu9yP3F5FezhpXmQ6B2H7T5+tzZh161lgmq1HfCKaXL4piD/hzSE1R
 gPWZ2KDH+Pj+mQAYz1HNL8JUWZkf/VhmrmobEmVANW3Lz3PbvILrWVyM6wYNIB19BhyoLdJL4J7
 41l5iicCDAkAuIq2vs0JML66z0Z7Kh4KxXt3Z8Ys7AJ0WJLPdHUB/45We/5yniafn0hXnKFozLr
 A9ja4KXALkT3DlaahIgjcg0607BUcdv+Y+MyGmOBbbX5VJ6K4u8LCdYvKUY0tMhpeM5sTaILyhQ
 T2j
X-Received: by 2002:a05:6a21:6f0d:b0:37c:b74c:d8c7 with SMTP id
 adf61e73a8af0-3946a887081mr31448637.22.1770939969849; 
 Thu, 12 Feb 2026 15:46:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1ac0e004sm5609936a12.6.2026.02.12.15.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 15:46:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/virtio: rename virtio_is_big_endian to
 virtio_vdev_is_big_endian
Date: Thu, 12 Feb 2026 15:46:01 -0800
Message-ID: <20260212234602.338131-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Renaming this function removes the confusion with
existing virtio_is_big_endian cpu ops.

Indeed, virtio_vdev_is_big_endian is *not* calling cpu
virtio_is_big_endian everytime.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 2 +-
 include/hw/virtio/virtio.h        | 2 +-
 hw/net/virtio-net.c               | 4 ++--
 hw/virtio/vhost.c                 | 4 ++--
 hw/virtio/virtio-pci.c            | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 324ba907e93..0c5514178e4 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -28,7 +28,7 @@
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
 #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
+    return virtio_vdev_is_big_endian(vdev);
 #elif TARGET_BIG_ENDIAN
     if (virtio_vdev_is_modern(vdev)) {
         return false;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 8f1e4323599..ed1a0967ed8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -478,7 +478,7 @@ static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
     return !virtio_vdev_is_modern(vdev);
 }
 
-static inline bool virtio_is_big_endian(VirtIODevice *vdev)
+static inline bool virtio_vdev_is_big_endian(VirtIODevice *vdev)
 {
     if (virtio_vdev_is_legacy(vdev)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 313d3b88400..ec85e5a949a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -301,7 +301,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
         if (n->needs_vnet_hdr_swap) {
             error_report("backend does not support %s vnet headers; "
                          "falling back on userspace virtio",
-                         virtio_is_big_endian(vdev) ? "BE" : "LE");
+                         virtio_vdev_is_big_endian(vdev) ? "BE" : "LE");
             return;
         }
 
@@ -343,7 +343,7 @@ static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
                                           NetClientState *peer,
                                           bool enable)
 {
-    if (virtio_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return qemu_set_vnet_be(peer, enable);
     } else {
         return qemu_set_vnet_le(peer, enable);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 70a112242b0..1f5e70ad197 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1306,7 +1306,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
 
     if (vhost_needs_vring_endian(vdev)) {
         r = vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                    virtio_is_big_endian(vdev),
+                                                    virtio_vdev_is_big_endian(vdev),
                                                     vhost_vq_index);
         if (r) {
             return r;
@@ -1423,7 +1423,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
      */
     if (vhost_needs_vring_endian(vdev)) {
         vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                !virtio_is_big_endian(vdev),
+                                                !virtio_vdev_is_big_endian(vdev),
                                                 vhost_vq_index);
     }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6126187a164..33c5cec01cd 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -586,13 +586,13 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
         break;
     case 2:
         val = virtio_config_readw(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap16(val);
         }
         break;
     case 4:
         val = virtio_config_readl(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap32(val);
         }
         break;
@@ -625,13 +625,13 @@ static void virtio_pci_config_write(void *opaque, hwaddr addr,
         virtio_config_writeb(vdev, addr, val);
         break;
     case 2:
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap16(val);
         }
         virtio_config_writew(vdev, addr, val);
         break;
     case 4:
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap32(val);
         }
         virtio_config_writel(vdev, addr, val);
-- 
2.47.3


