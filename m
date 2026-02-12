Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15669EEA872
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgO0-0004hj-Vt; Thu, 12 Feb 2026 18:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNy-0004gS-F0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNw-0008BO-AV
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:14 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-824a3ba5222so224596b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770939971; x=1771544771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsSjHgAuxzH7z5UZfo3F29FRTsMy8IItwqoYG77XBoE=;
 b=Y0dXnkYZGeGu4oLZZEftJRpA5qqVcsECGTFzjSqnzWH1XPHOiX/G9f5jBBbio8hIuV
 lZJWs3ZAedv6G/7Qt6x+KZdfwxEt7U24FzgRyzLdUcNvG2rw1Oed/DwtXvB9NlGmCpTK
 t4yv15VgG3vV6ckpMJuuteL8g16oMjfzlbSAbhWVE1QBFk0UpBHp5Ggq7VFf6WSsFUqS
 wc9hyNNIa07CsMwsVAI8HcdUPcDmhNx8gI/nTWbTOqojtM3VgNxEV2Nk9pGcxcad2c/5
 m2DI83d8EzGUulMdlHyQFLB/bNFueithqUOvQ0O882soIp/u8eaBaniJWRsLHK5bUwug
 gTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770939971; x=1771544771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsSjHgAuxzH7z5UZfo3F29FRTsMy8IItwqoYG77XBoE=;
 b=hckB69QLTq8IVXfA3N3NgRV1enQ4qrLPRg/tGgm20ryvp/h0Wz+oybdK/m+SZogvFc
 wXzAvq8J7Z9Buyjr7PNobrBbrt7FeaOQBaaQ5Z7FdOK1R62lF284RVbd/mCpmFc4xZhd
 wigNeOy1cAaqlE2v5dSGjU7/BFiS8q51OS52mTB8uhS5R4HVXmQnQikiNyiUZ+jAKMfS
 0WEMitJWPY6Q7qqRUVeRhZhOpYhLEG9V+hBrYhVcGAszdoQtyEfv37eThOna4ZwovKqu
 Umc/gFsIHqQIMJP/lcJJVZkVzQH+TcfZBKYs2BoRxI/ttnaqKenTVOVf3DE/98BPqLbG
 HrLw==
X-Gm-Message-State: AOJu0Yw7Jq09rPFoaWa7WQy0nQUfDZ5jKVM1Hv0+SKenP70DXjbkrqvn
 sMvr58PkkamVZTZIvTGPFmRZJ+AjgMO6Khg8+Lt0HGkFfMLn+4HUL0wT69mwc9+OZTTnwc3Zatz
 6V/3v
X-Gm-Gg: AZuq6aIF/xeL0YY5gjnHlDKFYosOvSuQ5Mr+Ww7yGC/6yhCo4NRCqFAW0uTDtK5EauK
 s4ge7Ck6RJXfixRnK/HeTlAKFU8deFS6JAawxrapsk9TBJGt1PcqUhLXHIg/BqPghLEqNhxpPkn
 qTwYUtyKhDQZtw6NkDP5DcJgVHnMvWsIZzb19p2yiRB8U3+Rj901xh3TTtdk4Dap6ZPGJqFuNWw
 8TT1GLn3YQsbHPAO8+K8JIind7MezoSzWMCNl4wt5GwgQd80v1ge/Ac8oa9qDiIHy8GK8X9GNJ/
 GNogDUoEUhylX3nkU/lxc7cP9laaeCHDPcxQTxrizWOV1Uz7EBtef3tk1qhWLuolvFjW5SL6tDm
 IcIzfzmjdSQQxH0bxJB1UlcalCfHID4U04dc/RCM3nUDMYGwO+D8/udklQR3uQXT5/7zH7BUQXV
 my9Zi1HtYxcG5bgDvA8WAqXQqQ2UBtMNk1ZHqbDOIGd+OD9TDFmlam8YkKi3cg/xWosgaLE+evp
 Rb5
X-Received: by 2002:a05:6a20:2d21:b0:38e:9ebe:5267 with SMTP id
 adf61e73a8af0-394673315aemr444713637.57.1770939970664; 
 Thu, 12 Feb 2026 15:46:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1ac0e004sm5609936a12.6.2026.02.12.15.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 15:46:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/virtio: remove virtio_access_is_big_endian
Date: Thu, 12 Feb 2026 15:46:02 -0800
Message-ID: <20260212234602.338131-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
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

Thanks to previous refactoring, we can see more easily it is strictly
equivalent to always call virtio_vdev_is_big_endian.

static inline bool virtio_vdev_is_big_endian(VirtIODevice *vdev)
{
    if (virtio_vdev_is_legacy(vdev)) {
        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
    }
    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
    return false;
}

The key is to understand that vdev->device_endian is initialized as
expected. It always contains cpu endianness, and not
device endianness, ignoring if device is legacy or not.

By default, it's initialized to vdev->device_endian =
virtio_default_endian(), which matches target default endianness.
Then, on virtio_reset, it will be initialized with current_cpu
endianness (if there is one current_cpu).

void virtio_reset() {
    ...
    if (current_cpu) {
        /* Guest initiated reset */
        vdev->device_endian = virtio_current_cpu_endian();
    } else {
        /* System reset */
        vdev->device_endian = virtio_default_endian();
    }

Now, we can see how existing virtio_access_is_big_endian is equivalent
to virtio_vdev_is_big_endian. Let's break the existing function in its 3
variants, and compare that to virtio_vdev_is_big_endian.

static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
- #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
    return virtio_vdev_is_big_endian(vdev);
  This is the exact replacement we did, so equivalent.
- #elif TARGET_BIG_ENDIAN
    if (virtio_vdev_is_modern(vdev)) {
        return false;
    }
    return true;

  we know target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG.
  if (virtio_vdev_is_legacy(vdev)) {
      return VIRTIO_DEVICE_ENDIAN_BIG == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  It's written in opposite style compared to existing code (if legacy vs
  if modern), but it's strictly equivalent.
- #else
    return false;
  we know !target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE.
  if virtio_vdev_is_legacy(vdev) {
    return VIRTIO_DEVICE_ENDIAN_LITTLE == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  So it always return false, as expected.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 42 +++++++++----------------------
 hw/virtio/virtio.c                |  4 +--
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 0c5514178e4..506be642c9f 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -21,27 +21,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_vdev_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_is_modern(vdev)) {
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
-}
-
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stw_be_p(ptr, v);
     } else {
         stw_le_p(ptr, v);
@@ -50,7 +32,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 
 static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stl_be_p(ptr, v);
     } else {
         stl_le_p(ptr, v);
@@ -59,7 +41,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 
 static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stq_be_p(ptr, v);
     } else {
         stq_le_p(ptr, v);
@@ -68,7 +50,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 
 static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return lduw_be_p(ptr);
     } else {
         return lduw_le_p(ptr);
@@ -77,7 +59,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 
 static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldl_be_p(ptr);
     } else {
         return ldl_le_p(ptr);
@@ -86,7 +68,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 
 static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldq_be_p(ptr);
     } else {
         return ldq_le_p(ptr);
@@ -96,9 +78,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap16(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap16(s) : s;
 #endif
 }
 
@@ -110,9 +92,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap32(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap32(s) : s;
 #endif
 }
 
@@ -124,9 +106,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
 static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap64(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap64(s) : s;
 #endif
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b0987e66d5b..2ae238001dc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -222,7 +222,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
                                                MemoryRegionCache *cache,
                                                hwaddr pa)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return lduw_be_phys_cached(cache, pa);
     }
     return lduw_le_phys_cached(cache, pa);
@@ -232,7 +232,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                           MemoryRegionCache *cache,
                                           hwaddr pa, uint16_t value)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stw_be_phys_cached(cache, pa, value);
     } else {
         stw_le_phys_cached(cache, pa, value);
-- 
2.47.3


