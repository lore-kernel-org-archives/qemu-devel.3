Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C708E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Ic-0007Rs-7y; Fri, 30 Jan 2026 21:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IY-0007LI-6H
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:18 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IT-0000US-Du
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a7a94c6d4fso13029525ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824870; x=1770429670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZCg+s/m9b/nMMAn0vsiLxhr9BOJ5/srz6yP+nxhqz4=;
 b=FJiZoHeOzINBXQhoKFreDXu0tlUNnFkllg/qQBSjbkSlJ8xhwHixbdjzZMtzBPUwKE
 qKTpyerJfW9Cn0upcFXJ5BQkwcD4VAvdmMYh4RS0jpBhNTfqJ16zNVl9upCeyzFV4lkU
 SkKvWLPAawBldA26FWi08syD8dyHq7OFl8/jTZAlzHUy98N7k0L6wRp1OKDHbmmcjVz3
 IqxXpiPjWafag0IkRQDbiIs+UxDWs3UcwKXzHHYaZqcW1RiT1rKGBF7BF6FKUXMipQVQ
 e6PzLZ84cVn+6NudKyiH/cBu1ycGdRSZMtItlZCVND36nFPRSDEPlnXVRalsy6m61WfF
 zLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824870; x=1770429670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZCg+s/m9b/nMMAn0vsiLxhr9BOJ5/srz6yP+nxhqz4=;
 b=TQioX87S2DPAplKwUdFrWQGW9q7+h0UFEiUVB4x/9hkx0ScgTWUO5wCUOL0LVEtCu2
 TJNIiixUwrSILJmZ8vfKUdr2Y+nyN58uicqrs7nWKU1gPc8aMxUQFmVZMJYt5xOiHhpg
 nXorZJbc8FZUYUveOoKR6xodiF9illQXnaL+tikjVR5EhGI8rIw88AUgOvFiiP5lqNYn
 KmAzUpEg6LwEWbaRr/lywdjpkj2FKHTGQOSscD+HNHcv4ln9s5nOiniOxsEv19gV9dLd
 9CZ9zZBXmOkpyJbvHtCtfT/zq0Ab6JfBF/mr2mOgxccxg93eNj+iQhZIXbG1qfpKEqAI
 kgLA==
X-Gm-Message-State: AOJu0YxJaGrOjjLhsHY8/XxTOPC3nBRHoUNKO4vpAn9F0mpaNViNKzzJ
 AZcxoz/4IBlzyYOk12ydVoDg6DzdMOosNKHMikeJsmQGtpS3memY+1RTVKK8OMNrdMTOppzvd2d
 3qwql
X-Gm-Gg: AZuq6aLyroDlWcUuUyK4fdfuiR0F71qZLG4h3b7G2/j0naxj4v4vkWpa2Ep6BuqIW/8
 fLSbcN5yKChJ/G9tnbtnOOv03Wkz3oTWqOeFoJiytgiuz0B3oQiNNgAWBESn0uqUY7MS+/S7iKz
 Kbuxdu52bHPFYiNrRDkpaRkyPKjtsBTLzWXJtxQV2j39B6N6Jz93Wf5txIphOhNL8WAujwgkyno
 K1O6gZKfZw5g604pPVMRLk8QZp6SEUAKELNxdqHFM5N/E34DSfGPsN7iAppyefRkKKMtBx9k2kr
 w7QRtCJjsLzCsIVV0hBwKZvZ0qYEpx68rPviMhLd1nlvZyUuNArkmp/fn7rvGAuxjqBDAIxQdP0
 FoihdBTXx1U/MaAiPJaZfygTAIV5kcd4lxEVTAB/OU7f11FZ7grruWxLL5HgDkOTBNUcC8XBc6Q
 z7YLU55Ci+m+5cAGUYpNxDB6m89yKpGar2dr+3CET9E6rut6xRiYBvM6Nsid3c6gMu
X-Received: by 2002:a17:902:d4c9:b0:2a7:99c9:1086 with SMTP id
 d9443c01a7336-2a8d9a56c95mr47008875ad.47.1769824869937; 
 Fri, 30 Jan 2026 18:01:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/6] hw/virtio/vhost-user: make compilation unit common
Date: Fri, 30 Jan 2026 18:00:58 -0800
Message-ID: <20260131020100.1115203-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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


