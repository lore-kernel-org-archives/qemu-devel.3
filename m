Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A027E8B363
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSM-0006gW-HI; Tue, 03 Feb 2026 15:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSH-0006e4-F6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:01 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSE-0003VY-1o
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a9004e4239so14763235ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152216; x=1770757016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZCg+s/m9b/nMMAn0vsiLxhr9BOJ5/srz6yP+nxhqz4=;
 b=fssNTX4ukKXBiFhWgCujxq2XCV89f5Mv413ukNXt2m1dlO+dsF+zGygZoJIjZrVHi5
 CIN066+7fqbdNpdUqgJg6p476zdjgmL0CRE3HCFwoO9cLWYdWMM1uuOGIPmcWdMNzEzI
 L6Dx9z/BLmusIGUm41ziHsYDgoMNzb+jCZt/+iKEXGjIgpDZYfVMHC9HRUECiy68uwss
 XdKFdGKDKmm/2wzkfpZPNboZxkBONcj84+bRXsbYCVMZ1mdvObP3dRDI4Zo8Nf8ol24Y
 xsxf3CXNwQh5WKnfzNI17SVJNtNHhQ3sBojo1gRiGwDT3dRJ7XrtQiTJm+KiM2HNqxJJ
 zNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152216; x=1770757016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZCg+s/m9b/nMMAn0vsiLxhr9BOJ5/srz6yP+nxhqz4=;
 b=ETfd3Tymx+pxlMyRhn3u4yw0BeJ/+byk1CAidXC/IX5nWB4EHg+LDQKTtvM18HyOWZ
 cHsusC/NfM9c9ZYwUwmgLxZ7w40ni2dD2bpLusfiyj4kVe0eccoHYRXVLiGkS/daQO4+
 AvjqAqwljbz2ldutpbabxxmizJEy7YnlUfBS+BaYuCdFDY7AQt3Oll/UqlA49th5rOAI
 6lIASYCHOAsbsDmBenT0T/jWSigx1y2uJ2O8LjEHgc4dG7aN7CktbFoB9WSuhhWPzZts
 1uWpQ7y7q1R49nxpzXWo75G4NXkAPLS/wDbziddv9Ds8iPk4kZXoD/md8mlkWeJx1JMw
 xaFQ==
X-Gm-Message-State: AOJu0YzuNcogOQC1Am00zAxlabA/EU2NXWz64t1NPEF2LdLSLQya9mOc
 yFtPX3A6l1RVevG9CZiJtPmKHLhmN/upUoGKZxHiXe6Ke8Yi7MoSA1RxMvEqkVdjrLJlEJRbT0D
 WtIfU9vU=
X-Gm-Gg: AZuq6aJ1c27GlBOOw+AVTn9obopzd9QMTMaDVhvGZwF9/oZM6vDeGZmeEeCRpLBPzNj
 81gSkdkPv4MPPnu+28oaOIplU+aZs1+kz1DG0EFfMNT6FQk7Bb8St2RpfLO+29ICegOJS4gsBkA
 ArXVfZ2vY8Rz97DO92EueaihjrsSpv0F+QT6przw20m1Q+11wbrQjcsBzWz/9YPnpqJUDG3kEtx
 SmG5Y+C4vzVYE9dt4afxCuzCAXuUE315xVVaNc6DRUPvpAmlaUJjd/1VkSD5+t5+L9eaBta9V4R
 KWnNehINOymUja2Mh5M0XnTXFmdQN0CxkFABUBgR2CbM8g6yd/RzJhuIY+qxF4213S80ZlngJPy
 HzDEo5yknhawkvMvQx2S474AmZpEdLL176CYnaDjxfatZP62H7ZcBknwc/5C2Vn3BXF71FU+rPv
 VfTyHLZtC6+Ryw2+eBh9lH0sQHeUKiaTGDZMWFnUmQAkpTcT/FJWDB3wfQvcp5HTvX
X-Received: by 2002:a17:903:37cc:b0:2a7:99c9:1086 with SMTP id
 d9443c01a7336-2a933fd72c5mr6221545ad.47.1770152216329; 
 Tue, 03 Feb 2026 12:56:56 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 7/9] hw/virtio/vhost-user: make compilation unit common
Date: Tue,  3 Feb 2026 12:56:35 -0800
Message-ID: <20260203205637.3109749-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b1..c8a004c6d2d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -44,13 +44,8 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_BACKEND_MAX_FDS     8
 
-#if defined(TARGET_PPC) || defined(TARGET_PPC64)
-#include "hw/ppc/spapr.h"
-#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
-
-#else
+#include "hw/ppc/spapr_common.h"
 #define VHOST_USER_MAX_RAM_SLOTS 512
-#endif
 
 /*
  * Maximum size of virtio device config space
@@ -2280,7 +2275,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887db..ee397aaf196 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,8 +17,7 @@ if have_vhost
   system_virtio_ss.add(files('vhost.c'))
   system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
-    # fixme - this really should be generic
-    specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-- 
2.47.3


