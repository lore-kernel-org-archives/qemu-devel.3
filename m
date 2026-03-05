Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B250F47CDB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFua-0000nx-OY; Thu, 05 Mar 2026 16:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuZ-0000nC-68
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:11 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuX-0008OI-DU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:10 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso3376641a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744828; x=1773349628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkGRHnWZzEkpTkOUXW6elzMRnuyLVvfMOFl+6+n7Ots=;
 b=BPWZdLYLN+z8L2dLtYXsSQtmODF1IhCTtJIVtrq+doxfju2DbXaEnab7Vb4csEvo3x
 onO17OhoDHROuc/jYke/Y2LFvSLvIpxRpH1lG4iHyocWnHsLgaLlObLKcI6LlVIX5iri
 ICexotW2lWeKpciBhWEDecUhMug8KzoAsr+ZWZPIb26j1J674/25Ovj5gWbIyi/wcx8t
 CzZLFYDfMjUcv9MIzdaU0Dmi0QfSVfOqMCku1iFlmSxXA7+IQkrev4mAz0sxAl2tRAgm
 98SNMEZ9CAbTv2FLtuaHDKGx5AAJGx0fxKtkGlPWoTu6QpG6b8nmiEl/M4wREGAV91Ps
 wJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744828; x=1773349628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkGRHnWZzEkpTkOUXW6elzMRnuyLVvfMOFl+6+n7Ots=;
 b=i2UxSccTaFOrB88aUXqoszqGGN5I+GAgZpGAoNUI7mc6DEQgVPjxskWMWjnggN4ACE
 dRuhH5kfjFcT97NStsf91ZQQhvz8/IOkzsI17AzOV2v/uI1Vfg/BvSw6EnC73PKvNuSM
 tKqM3EPNlcWiGO/5zHC9JT9wqElcUyieBMfP7CHUXPu/2MW2jLVcLh0Z3bkk8VzVnTWV
 tlmO89yWu+62VFzTaRX4bw4b+FQdJQHrH/F6d2RCHKr07ehaEDF4Eo426rVVDIAZBgzd
 qE5nt/PUJKr1bRKyQ/PEeOaKmn8DmREvWl6nHaIGvL6GDs2kzCe201MAiN9Q86i55hTI
 c+Wg==
X-Gm-Message-State: AOJu0Yx04ob569ycFKOg8JfX8VlTxV/vZIMEARQVzmVQPjNoUjEBQ5i4
 2wj4xnE3njvrfoFeJn0zykUeZtFQqKDtyC/NWp03okZSO2BlTolUsDTcJPLaHv2JRhvO42+Z1Q2
 PlGur
X-Gm-Gg: ATEYQzxFTMMlb29rxF8MRS584NK3C60RtpuEXfpo15/O8CjU9smUdBMQKOr8XOvD9as
 /ImVz9kUKxVfMXaz3j2cJsJ4uxS4qsW0E8NJ2OMEAORkuhh6KxuicaonYNzfHHZnfKQai6vmF6g
 wlR9HbC57YEDw4DWyP4tUhhbigbCamk3n4Q0b23FsNwH4wPmjHBkMoHMs+r+d85dGXlxDU9MK0V
 /BuvXc/tYpZ2CRkLRevjNJZ1/8SN6LLXK+lOtGcXiAbiTPwAOsA4e5JasYZXZS6Fu+6IOl+N03H
 O7AeihJfDvUnmpfOl02w8sH6N7SmE6eAU4FOKrje+fgf9vYIAgIf/HDfrU4ABO+/0Avy8yCXt07
 /bGrmJmb1Q54HpHSgI4uZLGFunUhe7A2yRuDc98noN/A9vyRQS8s5asT316B2CA6MP7ET7rcO3F
 7PwXD2nyWBeqsGU1ejVCWVowuqJnQ2s/DDK7lBWONr26SVEmfnGLWAWFkEDPPgpq6WqChirSmVb
 Qzq
X-Received: by 2002:a17:903:390f:b0:2ae:7eda:765e with SMTP id
 d9443c01a7336-2ae8015ad19mr9460815ad.17.1772744827836; 
 Thu, 05 Mar 2026 13:07:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 3/6] hw/virtio: Inline virtio_access_is_big_endian()
Date: Thu,  5 Mar 2026 13:06:53 -0800
Message-ID: <20260305210656.2140206-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-4-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 29 ++++++++++++-----------------
 hw/virtio/virtio.c                |  4 ++--
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index e3148c23881..506be642c9f 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -21,14 +21,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-    return virtio_vdev_is_big_endian(vdev);
-}
-
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stw_be_p(ptr, v);
     } else {
         stw_le_p(ptr, v);
@@ -37,7 +32,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 
 static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stl_be_p(ptr, v);
     } else {
         stl_le_p(ptr, v);
@@ -46,7 +41,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 
 static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stq_be_p(ptr, v);
     } else {
         stq_le_p(ptr, v);
@@ -55,7 +50,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 
 static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return lduw_be_p(ptr);
     } else {
         return lduw_le_p(ptr);
@@ -64,7 +59,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 
 static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldl_be_p(ptr);
     } else {
         return ldl_le_p(ptr);
@@ -73,7 +68,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 
 static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldq_be_p(ptr);
     } else {
         return ldq_le_p(ptr);
@@ -83,9 +78,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
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
 
@@ -97,9 +92,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
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
 
@@ -111,9 +106,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
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
index c0c4599b586..22d798e6cdd 100644
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


