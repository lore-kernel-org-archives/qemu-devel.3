Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF0EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzZ-0002wL-Mq; Tue, 30 Dec 2025 16:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzX-0002dO-6r
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzV-0002nZ-Bq
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so103358555e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129051; x=1767733851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VR9BV23KQUTf4h5KpNYH7odqkl2T3CFFTAp+5wOs8cc=;
 b=he0PvotGOEJnx1BmHw9OPJCK2fVrV8DDU/ru21WV+3uAJvdJqPAABnbXgxDKoYQtWu
 sczS7yvmn5VimM1kjwcwW49Cv75M5B3jGtvn4X8gHFjp9v88zUdmDqgEogAIvqJpaZHw
 I5VsGCGhBpM0vztlA+WFHXfutx08rh7pHzWdc33INqCwVJNs3cR0oWr+DNi7HlK9zHCB
 B6zKlEkoAcSMlvCmHPvtEaIMfi5UIEigwViM4p4ExCT2DBepwD4sTz8HIXFZBup9dEq+
 KoGkqpiiByOW5ptqIQFJNEJ13ejdKEtZHgsqk6noPvQzgzbZvTWzO8s3yjAZpBoPQjvU
 eflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129051; x=1767733851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VR9BV23KQUTf4h5KpNYH7odqkl2T3CFFTAp+5wOs8cc=;
 b=A5lM1rFOU4aw/bKuk3xfyaLAQ0wg4lIHKemkwElmHehzTm3Oc9ruyIyLr5uGUx2Mke
 wnLJzWm3UnytHdCIgRzHMY08H5GDmIAdCdASqIbnXdofwY6X5eCNYvzGQ6nRvmskeoy6
 o9VSPl4OiSpnFtwJPMPNesMmceKFJFOthOjlN+ltpV3OEb9CYvdWeEn0ojKYok9Yh5nU
 Xp/xkpymaNCBa5qPbq9TFJp+1KxUv7WgcoejzRiMymowWw1kCCPA8pwXFESoCuERgM18
 NAKNo2m6TGe2fM0oy/dETdoaDnwuogkOg/jMBaFKruOLOKlmt9pXOoneijZEUVQhhcVq
 tEuw==
X-Gm-Message-State: AOJu0YyQGe4xhLKlk+CX2RB49/UBZyuKgBQNaVDsPUnVOuOQjOqTWZh8
 AmJJgtidN875x0JeElTHprp05w3upUwZ9oCAe4mVZoJ7V/06lY7aeXsf6RGGl9ZwVsgVNFVk83t
 LX/xQ860=
X-Gm-Gg: AY/fxX6k6qYd39WPwK2GYUndGa4Achm5tbK7SheOmXEoRNTTz64+XiIzPNk4P9uy9vu
 0ziGNazkajBPEWuzu8CjmaDgxVBXXLaWjsjMc5Y7cc5p9eZOTNrZKRyWFFkSfJXvnEmqNp0484Z
 RMdxLzZ84TQe/maWXk1ZTDbldlcmvrdyvzOlD2laFup0zF/QZYKR5Ycx2POUF/gOROMvSQ3cDGq
 AWiZcMcn8iFgCzcpp9AfJ2TOVZK54l4mQ3TdMqXNdfzipQKnGBBjMXgL1NXiavcHr9CWfs9Fyn4
 p2F6ddyNk1liLYpw+d7hy0wXVzhOu1+TSyVRTHiV85rkuIKrwF+pPOMW8pJ5yoU0axGoBHnGX4I
 O4Fb4EDXZTvo3KeV9HuS34IGBK/oUqt0vfUTCRaBLSMFO9KPgARoj/u9M36mhBEjz7HrIf0rQMJ
 HgGB7Mh1peOTAQ3ZJPjtRfVWRxo8+XIKwj7KHqNgjdsaFt34Cyd6S0EmnLzvziMsd9fXKvjJE=
X-Google-Smtp-Source: AGHT+IEl2/NNJCRs0vKuAXFU6DZI23CvkC9GkM/qjznitTCQ2qaHtfBQJc43xewn7+kSAYDECiljbQ==
X-Received: by 2002:a05:600c:5250:b0:479:3a86:dc1b with SMTP id
 5b1f17b1804b1-47d36243a0bmr254354835e9.37.1767129051502; 
 Tue, 30 Dec 2025 13:10:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227casm69791089f8f.15.2025.12.30.13.10.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/34] hw/virtio: Remove unused ldst_phys() helpers
Date: Tue, 30 Dec 2025 22:07:48 +0100
Message-ID: <20251230210757.13803-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

None of the following virtio ldst_phys() inlined helpers are used:

 - virtio_lduw_phys()
 - virtio_ldl_phys[_cached]()
 - virtio_ldq_phys[_cached]()
 - virtio_stw_phys()
 - virtio_stl_phys[_cached]()

Just remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-8-philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 85 -------------------------------
 1 file changed, 85 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042a..c866769cad8 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -39,60 +39,6 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #endif
 }
 
-static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys(dma_as, pa);
-    }
-    return lduw_le_phys(dma_as, pa);
-}
-
-static inline uint32_t virtio_ldl_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys(dma_as, pa);
-    }
-    return ldl_le_phys(dma_as, pa);
-}
-
-static inline uint64_t virtio_ldq_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys(dma_as, pa);
-    }
-    return ldq_le_phys(dma_as, pa);
-}
-
-static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
-                                   uint16_t value)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys(dma_as, pa, value);
-    } else {
-        stw_le_phys(dma_as, pa, value);
-    }
-}
-
-static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
-                                   uint32_t value)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys(dma_as, pa, value);
-    } else {
-        stl_le_phys(dma_as, pa, value);
-    }
-}
-
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
     if (virtio_access_is_big_endian(vdev)) {
@@ -166,26 +112,6 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
     return lduw_le_phys_cached(cache, pa);
 }
 
-static inline uint32_t virtio_ldl_phys_cached(VirtIODevice *vdev,
-                                              MemoryRegionCache *cache,
-                                              hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys_cached(cache, pa);
-    }
-    return ldl_le_phys_cached(cache, pa);
-}
-
-static inline uint64_t virtio_ldq_phys_cached(VirtIODevice *vdev,
-                                              MemoryRegionCache *cache,
-                                              hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys_cached(cache, pa);
-    }
-    return ldq_le_phys_cached(cache, pa);
-}
-
 static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                           MemoryRegionCache *cache,
                                           hwaddr pa, uint16_t value)
@@ -197,17 +123,6 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
     }
 }
 
-static inline void virtio_stl_phys_cached(VirtIODevice *vdev,
-                                          MemoryRegionCache *cache,
-                                          hwaddr pa, uint32_t value)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys_cached(cache, pa, value);
-    } else {
-        stl_le_phys_cached(cache, pa, value);
-    }
-}
-
 static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 {
     *s = virtio_tswap16(vdev, *s);
-- 
2.52.0


