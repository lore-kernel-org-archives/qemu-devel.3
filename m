Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808BF55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6NW-0005F6-O6; Tue, 24 Feb 2026 23:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6NV-0005Ed-JF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6NT-0004Xf-TK
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so55507525e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993198; x=1772597998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXcG9vkcojZNmdSMtnTvaH9pWnFqc8b8gh2qy0TXg9Y=;
 b=MQ+obc9NUW0NEbBN5KOYI2ivDPN5c2f4n0Mf+9edobAU/LGcN4L0vcEu/RqldhIUGE
 UPgDovZj9+xPolpjjrNB2VBmfDep7zSZQ5qI8avZEkL+oLD78+10wTBHc8jKkhLZQSvD
 lcgE7vuA84K963UfSLiE5eseFE9HdQ+OcqTWixdCd6EtENJo5DANLIF4cOhnNZw/JGtz
 0VJSAKMQunF4da/BMNeDN8N0txNzBmRqKrkZTOFxdK4lRYo7WNMK6HpEzxU5lmnZjEOJ
 0bXbe7IP0kod0pYRrmb9O7oJVkOzlYyJnXHgeSi2jeUJCJjBQ6HXtvzv1xKeiQdZiy64
 Df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993198; x=1772597998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dXcG9vkcojZNmdSMtnTvaH9pWnFqc8b8gh2qy0TXg9Y=;
 b=LPIiLG1kDFGDoDOpvKCfN1J6wygctejFhXuxD54owR1hsu5FV/PSYyT402My+eGEXJ
 UyH3+C0RYeLrFoMaB2AK4Rx7B/JdhZunBIL7cOjlwhnODHpJ0Af+sKzJB6jq/zUChSIP
 iw7NBtxXwDApqvNXjXaabYDL0FlctV+5IL3a+H/sZn8xIh3C3i0Ed0okc81tECqj/Wfm
 VHdvPONwafbwEIYlwceuwc3vaU0MkEMrIWGto/uubp3l86wtWmLF5+yY9wQF2qMKG/R7
 nKAySQVkC9qIiNW3KFHAyceQub9qrjbKKwk/0qNr+/G0cRLvPZ4qjjbD6181eWvNDSEU
 sphA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH6/ffCYCMbFOsaHJJNGyAmWBIXVRPJKu1AR6rHrjLROatNuVG4ePqUkesHvL5QFNUKC8Xwuabs1kH@nongnu.org
X-Gm-Message-State: AOJu0Yyz+0G8E15E/kLd9672AW+oQwKdLlQCpfVEtGa+VrmGOb0xcbML
 SUgkZNOG0+xqSfpzHvzjQBMsZwOT/E2Nih6s7pPbcP4rBfc/arccueYjqXjEaf4LzEM=
X-Gm-Gg: ATEYQzxCVRU+2420mbExvBl0rOkLsSGyqi+raU1MycNPmiRvLOCmDs0R2bHrGeKGvan
 PLQp67j2/SfXLgXoOeec+FTQ93HZvSVqZGxdi5kTnluwTSWo08SnHgrXlOf/jb6RZfsdFtgobCs
 gt+FvceQQyi7BLBrGlnCW/RLY4nC5kk+JOeTTgOLSGByc6gUUqca0KKmUmzZ6AMVF66LkDux282
 AtXVYLjCWPH6XEgV7/8y06SWFt7Dzr3oaUKBg75rT2c+CsjZs37MPVYjMfxmUF4h9mzaGPmxSVW
 Q4CUg5OZ73k5BQ0kP7DZfPaE6xoCEC3J8Myyh+w8kazivagpUTskSFRU1cvKKC5bfRm4y2XDpVe
 LmzMS0QpXElbBkyQEKGye9YvHiUekAZc8Z9FWwahnXXIwZHveqlxV6+KLgKT5j9wQFVjKrJoNxX
 8fc4Xtbsh56yx7Z29qsU9dSPWz5pLB85cno4nslhQgt6ErHT+LI176MTNAY6agEiglphKw/d5d
X-Received: by 2002:a05:600c:5020:b0:483:6f37:1b56 with SMTP id
 5b1f17b1804b1-483a95fb268mr238008685e9.10.1771993198332; 
 Tue, 24 Feb 2026 20:19:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf8b6sm2074655e9.20.2026.02.24.20.19.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:19:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/6] hw/virtio: Add virtio_vdev_is_legacy()
Date: Wed, 25 Feb 2026 05:19:42 +0100
Message-ID: <20260225041948.52929-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
References: <20260225041948.52929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This simplifies code compared to having
virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h |  2 +-
 include/hw/virtio/virtio.h        |  7 ++++++-
 hw/virtio/vhost.c                 | 12 +++++-------
 hw/virtio/virtio-pci.c            |  6 +++---
 hw/virtio/virtio.c                |  8 ++++----
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index b58fb6ed7ea..b8aa7a520f5 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -30,7 +30,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_vdev_is_big_endian(vdev);
 #elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (!virtio_vdev_is_legacy(vdev)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
     }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9dd93cf965a..42d20899390 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,9 +468,14 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
+static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
+{
+    return !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+}
+
 static inline bool virtio_vdev_is_big_endian(const VirtIODevice *vdev)
 {
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
         return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b4cdb7762f9..b9dc4ed13ba 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1168,14 +1168,12 @@ static void vhost_log_stop(MemoryListener *listener,
  */
 static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
 {
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return false;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return vdev->device_endian == (HOST_BIG_ENDIAN
+                                       ? VIRTIO_DEVICE_ENDIAN_LITTLE
+                                       : VIRTIO_DEVICE_ENDIAN_BIG);
     }
-#if HOST_BIG_ENDIAN
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
-#else
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
-#endif
+    return false;
 }
 
 static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c7b5a79b936..31b566c6ae3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1449,11 +1449,11 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return proxy->vqs[n].enabled;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return virtio_queue_enabled_legacy(vdev, n);
     }
 
-    return virtio_queue_enabled_legacy(vdev, n);
+    return proxy->vqs[n].enabled;
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d55329525..c0c4599b586 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2753,7 +2753,7 @@ static bool virtio_device_endian_needed(void *opaque)
     VirtIODevice *vdev = opaque;
 
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         return vdev->device_endian != virtio_default_endian();
     }
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
@@ -3460,10 +3460,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
              * to calculate used and avail ring addresses based on the desc
              * address.
              */
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-                virtio_init_region_cache(vdev, i);
-            } else {
+            if (virtio_vdev_is_legacy(vdev)) {
                 virtio_queue_update_rings(vdev, i);
+            } else {
+                virtio_init_region_cache(vdev, i);
             }
 
             if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
-- 
2.52.0


