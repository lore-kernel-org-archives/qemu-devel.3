Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC0D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtJ-0003iS-P4; Sun, 01 Feb 2026 18:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtI-0003iB-OY
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtH-0002t5-4M
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432da746749so2148430f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988601; x=1770593401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLtJ/i/Ej2+3rrcoaflUWytYyH2WFju1TAatGa5vnlY=;
 b=eYa9CD/6RKI1vS+byiaMOSY+QsSTUCyQDpr8R22oU8KB4now0dvzag0xL4eagghBU3
 K3n9arAk72fcRSynQUWoPr4FSU/WNJQchZolkr3c0VfpFmFvemikDQjaKEM6m7/aoUnI
 dHiydfdf/WJWO3kSHmsNyHmdiNDR/RNfjGxJsUeOi3KZfLd3Q71Jwb1pvJcHjA8Ninwp
 lb+zHwTqio48Tlc6dkC4ytlQlsV/a6zwYaPpIrKpYDzWNNNvad23rD01RmBSTcsVUBoy
 /c7NC6o3imTfbSrDyccgxUYAKEpDIHRYf5rf99ZNQTZCygMdYjy+RCqWZ7dLlKo9Kd93
 5qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988601; x=1770593401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLtJ/i/Ej2+3rrcoaflUWytYyH2WFju1TAatGa5vnlY=;
 b=E++LmCpeOnUyY7gZDBbH9UVtRXISlMMiCMZ6+SmUdmkbEq0yiIiOv+YuJdGyEgZ1Fp
 WxoU5xWQ05DURdWuX23Ow4Vu4CAp2Sioo18afI7UvHl7Bj2C24lyYSeeHYHUBx5vM/pF
 i65vX2HN1qWzT1atTWWIx3L65qW5tnKf9tl52FTRHGfpX2QnF8QQqN7SfNdh1fd+jRvZ
 OyR+imXvhVmoLj/3hzF0sis62JaNjboXLBpC+XjK5ZIr/yTj7DLm92uDMMVHN3tzTdkE
 h/3iQHblxgJEPx7bVPdl0ropCg0/8651Ew2l7ewig4OaSo2EbIb7JbhHMzpdwJytFjqP
 a+qQ==
X-Gm-Message-State: AOJu0Yzt/Dhy+degMAOG7zDnlpiZ+FqcIccKqVfF0IcWzGA7dS9MEVdb
 Yrz1p7WyZeul5bKbTxod0iqoT/MJf/Y+tAek9PZJUh3q/uy03YbVPx31BRSBfjg9d3Cby+4qwys
 GUq0VGZQ=
X-Gm-Gg: AZuq6aKC0urc1fjAruzenpbL7VZgjaxwecRYFQ9VguTfNtRBsGQxqQ+HdzT8GWzayYL
 e3p3l+Bb9L26pZ4dlP7/MPiSkOpYpYm8SvyAbl8F8p8zll7dSe2pBD/WAG4IMGvBnU8XeafY4T6
 6jgnnsvZSvQj/SkfweQUKjUe9GtTXAbugIruTjPd7RnUL1RhVQYz7x/E5W5ssQ618aH7mA/1yrt
 Mcav2M+DJoUYN8pxNGGoAMAE6uBSxu9O6TbR47aSrVHkYvo7Hu65v7UsrDGrBBlqy1LBh195RYO
 FTh72Wu8o/GLq6qR184MCz5UfCZijuAPMSezTImE4iHlQ9CzIj3lWeSl2g41+Qd7csGHD+ek5Zg
 1Ii6p6rq4h/NVm9DVCmcM4JdBfn24cpeBgbKgVPI0Ab3mk7mELqYELA8km6OuLcWlJjIPJaWN+m
 5axoju5CQR/3IkuGj/cjGWh5QKwNVGP89PXGNu12654pKaZyKQemoPUcdAU5Ne
X-Received: by 2002:a05:6000:400e:b0:435:8fd6:5949 with SMTP id
 ffacd0b85a97d-435f3abb1c5mr15681095f8f.46.1769988601357; 
 Sun, 01 Feb 2026 15:30:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353f8bsm37568608f8f.39.2026.02.01.15.29.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 05/11] hw/virtio: Reduce virtio_access_is_big_endian() scope
Date: Mon,  2 Feb 2026 00:29:17 +0100
Message-ID: <20260201232924.93399-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

virtio_access_is_big_endian() is only used once in virtio_reset().
Make the VirtIODevice argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 22 +---------------------
 hw/virtio/virtio.c                | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index f3b4d0075b5..c6b76979749 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -16,29 +16,9 @@
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
 
-#include "exec/hwaddr.h"
+#include "qemu/bswap.h"
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-bus.h"
-
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
-}
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1dc60d37cb4..627a929b063 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3233,6 +3233,25 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     return ret;
 }
 
+#if defined(TARGET_PPC64) || defined(TARGET_ARM)
+#define LEGACY_VIRTIO_IS_BIENDIAN 1
+#endif
+
+static bool virtio_access_is_big_endian(const VirtIODevice *vdev)
+{
+#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
+    return virtio_is_big_endian(vdev);
+#elif TARGET_BIG_ENDIAN
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+        return false;
+    }
+    return true;
+#else
+    return false;
+#endif
+}
+
 void virtio_reset(VirtIODevice *vdev)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-- 
2.52.0


