Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1265CE8B361
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSJ-0006eu-28; Tue, 03 Feb 2026 15:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSF-0006dE-4p
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:59 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSC-0003Up-S2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a9296b3926so7411895ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152214; x=1770757014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiECesYJ3egJUoiGbW69hBkBfEtGoUsIdKpeOrRz1rs=;
 b=dGjIqn6Fm21dAyGlY/yUFtkDJ3AIJZIY3kWmq+0mfy2K4udkA5qpKjzdOB0SWZ9F9G
 NIAdxm916G6IwDNFP3VP2ohaakItDtcmfPntmbUwN/FybRnD67tcJrOJk1F/88TwkzhF
 1QYIXNq3DfTqEnR+D+LSGOa03s8i5G3FvNm9OFahzmaMAzA+D5MVjWr55F5P00MCYmuH
 sWRG7kvVUlZ6k4TCChpOsl3rPRZHGXMiNphf2MlUo404cXQ+dyhNO/9Ko7WgA7Cew+jP
 Ny8XMN9EIgHmIeOdvI/cDBTPR3t8Se9jyLLyoC3rBzQ6NASO2amN9WQUcxygdDULahyW
 uPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152214; x=1770757014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YiECesYJ3egJUoiGbW69hBkBfEtGoUsIdKpeOrRz1rs=;
 b=AUyJlcfkMepKRNMAvVI6pGh7n28mjpo91kNOxWCOZv7P1DF5Msvq0lRb9hNhRpGLVQ
 cRx1Aqeb+xEDtclMehoq2h2LFcdyMssIkegvaBn7c/z0e1GyVjarpWqxfSEtRx+csDk+
 s3L2cQF4Oln/UERScAxf6T9gFPwSAyvlikHAEHulXviQxf3hagx5JNpi5e+TySwdsTRA
 r2BJEgVJaYIeplrChGT7HG8D+VgGRaiiXplpMhqjh2b7fmvVcZxBwa8i6BXhbcxkK7sG
 INwi5e/i9WdL70y96MqkemQ8hCQ1M+WjmrPOgzUPRAnVOjCcn95Wrqdd8O2wkDoP23Up
 vvzQ==
X-Gm-Message-State: AOJu0Yz46DlcOQ00UG7Qo9T0BLjouRMn27FqTFwqrIwzvvp7sunwaDdo
 o2NFjxD840T5efu4V0d51UB039ALaF3JG8uk5MGt7BzFlb9ruwBatCXpUSnXI3ASukoBoCpetTh
 Kh1UuNhI=
X-Gm-Gg: AZuq6aIlOLXYZhEV6j255bVdEQPBo0JuQdiXjyNqRfMlwBj3Wek4NuWcdvE9a8x9OyO
 LA0xhGY/fZhSQWxOu/oiY2VsjkTXXKlnndHOu5JH1eZzbPwG+KV9wSoL7ohBg2o73if/LWpYoRx
 jftE2q8wAEs6k6XXMTunSOv8zZmh5Kri//eNjm4XHYaX2D29dZiAqFMHqa5hW76LD969XklJgPy
 D2HaJSzHE8LwN14QqNhxMPxIO9i9XT27DAqWHqaT3lcYCJObwLbasHok+roT0st+Fy2U+E4HqoC
 0+xaHp/pSfO1Wp5AmRon/B7ICngJYZxL/haT1rvRaNlwnq7Coqc+K1eUIUYR+VYNnZsNqqWOdNl
 fxmUrEbKAMZF02qP54/CWY6/uMZUSeEkQrxO1wHWw751du647NfOxmnwjYcRcjEvoqhTunV18Xp
 d5JIiMePKT2TUTJyXo7tUujAJvf7HQNNYgpIs9ttYHIdDhGhwLTFKlwNZfPejWmirb
X-Received: by 2002:a17:902:d546:b0:2a9:322e:1964 with SMTP id
 d9443c01a7336-2a933fbba90mr6591315ad.31.1770152214514; 
 Tue, 03 Feb 2026 12:56:54 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 5/9] include/hw/virtio/virtio-access.h: remove target
 specifics define
Date: Tue,  3 Feb 2026 12:56:33 -0800
Message-ID: <20260203205637.3109749-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index f3b4d0075b5..1bea3445979 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,27 +17,27 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "qemu/target-info.h"
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
+    if (target_ppc64() || target_base_arm()) {
+        return virtio_is_big_endian(vdev);
     }
-    return true;
-#else
+
+    if (target_big_endian()) {
+        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+            return false;
+        } else {
+            return true;
+        }
+    }
+
     return false;
-#endif
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.47.3


