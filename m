Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC7EF47CD7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFjV-0003Us-Cp; Thu, 05 Mar 2026 15:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjI-0003Oy-8x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:32 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjE-0006ft-EA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:30 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so8878560b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744127; x=1773348927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjVg4k8L5YS0+fbIU3cK5+QxAukvdu0K3zvehSjPnuA=;
 b=gQyRl7wkDZW27QxBw/tTfH5BXTwzGnmq3GABnSkVaJ6vQQXuKJubLcSdr5sPI9APFP
 O+VxOg7XRwrnGLOUj3/C//kYYUkLtqBCPphkL3JHGWNSPowIcQuvBc8COgLDjx+okPD1
 OctUMkHE1BS6m+4UrhOyQsAMi19fwr+Oe/OxcKiywsbVVlzi4Y28AY70XDYbeAD+Buin
 2W/pQUG114zlpPnsa+jIIVcI8St70kS2WPU8qCyNIdJZsGEOP08HKbEfDzccDCQE7MId
 A8JEfpyYN18knTShPIBHC4JYGLfo+DgHj+1/+AgBumyV4cz9NGU266VHgmzHVMpZrGx+
 nsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744127; x=1773348927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjVg4k8L5YS0+fbIU3cK5+QxAukvdu0K3zvehSjPnuA=;
 b=f4BTd5cL1MCzsbHA4mDWIkUFXug31Y0aMnNBl1HSgiEgw72mX5vPMgz2alq8ffOZJR
 Qt7myZvxHU72e2hkQYxpJidh6k5me4LvFVn1OYTuBEzz2FFccchHw4K22rJYKaHXydPH
 R38+JRH90wuBUivDDKY4mmloajpyInp5FJM0119L9aXsN32iCfBq2uHD/c3im7UTbotl
 khkFAzjjDDmHzRIMkjKkE9u9KVpEwTO3FBVaWH0I6dBNhFdZVpxa81PjJ6oVltHGhCfx
 BziGvCX5zvb/pwk9zxZHkly00MypLhfFjoAV3Mkmx2TvXQU3Va1snHGv0qrQzzvi2TiH
 peGw==
X-Gm-Message-State: AOJu0Yw9M9X+AcdV7K3Mro0Wo/WjTLcqA7LFZ9zP7GtLH/U1mbcbG/Ff
 eMd+DdRj4v0pHmBJrwCUC+hcs3hDxH8JkZlHMa69DAvcKybZpOM6zEWRMZz1/GgVA30LSUCt17p
 w452U
X-Gm-Gg: ATEYQzwdjm7l5KUnsHA4yH7DrTzsd6m+RkoBhjCVAFiGd5RsOqt4I8E1GmQF22MLqyf
 v7BhhsqbzcwT+9ka4Fy8DJpBtvSoakTbDMXKpQLsLD2w4g0HG5OIY6+ycA1VVJjeptl3EtIlJa5
 SR5Ocl1d7TDI3G5lpPCUwoEKPrhKEgzoRzBpm22JMKEtv7pLVFniFio+jo8ddPg0wvoD/N26WNg
 zoUtS5G5s+H84/UR/42l4Kg6NEDxsXU9i88jbSyXcYnPMjBC6nXlL1v33lFxQNnPGSqNl7aOy8O
 FTcTYIcOtGmL7nrEDjLPC07F95U0Jvf4h2vUlriyZVjjUMDuUOlvxwIPr446EQnyrt/3aj/pPH+
 nAF4hiJmQT47/pWT9EYKrguFG9y0o0Th99ihb7CWMtxT24dP15W1RgaG8k6qeNNSs8pipGP+PnK
 t0eoQlSmYkIk7mYQJsAXQIXqCjfvj6eDwSOFc9yLxzg7XgwNqUDw+SJyF74KjpePveInTagMBQk
 Aun
X-Received: by 2002:a05:6a00:a1b:b0:829:8bb4:1034 with SMTP id
 d2e1a72fcca58-8299aa6d247mr984598b3a.28.1772744126676; 
 Thu, 05 Mar 2026 12:55:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e4fbbd4sm3847454b3a.53.2026.03.05.12.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:55:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/6] hw/virtio: Add virtio_vdev_is_legacy()
Date: Thu,  5 Mar 2026 12:55:15 -0800
Message-ID: <20260305205520.2125218-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
References: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

This simplifies code compared to having
virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-2-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 0f5654f459e..bcab2d18b80 100644
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
2.47.3


