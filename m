Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A6CF47CD8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFub-0000oG-I5; Thu, 05 Mar 2026 16:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFua-0000nb-Ao
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:12 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuY-0008Ob-Ka
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:12 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so41761545ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744829; x=1773349629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76kT1LLbzqR90+aCRQBHop//yXjVEoX7825LzBvy7WA=;
 b=PKpCaYS+wTXlnrM6OY0kI28q87K/qIvr604w61uJUyTj9TfoF2XgdppwNsuooBDNlO
 BHV/+aM5gAxLUGK7mP3p3R9k0smI6cI4mR87jXm9hqxtMiKTgb+ceMPAlshuqbl96zdp
 W7AIHwzEHYc92qUSRBLyrmFsSmxC3laJojh1Y4bwwi9xXZWZJ7yZda7ygZL/rfFV8IKQ
 +eJceAO9cMhmobXtOU35Oy31VzNj9VY1To62wU3NDcwCD/3eUiKpry6zeIYcQghF5hi6
 E1RHykMtiEvgde2vYo6p2LpaWq7ZIBFOqQZAJRISzfQLtTyYvbZioiRpIA7gVEUU7ADd
 1XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744829; x=1773349629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=76kT1LLbzqR90+aCRQBHop//yXjVEoX7825LzBvy7WA=;
 b=nAtlOMNXGQdgKgmRZ8dD1SMAYyxc3iwesBlVVzNn1z9Pg9AljgEhricbD9aoVCy7Rg
 aT8WJlGn/ernBMRp2LL08UMGl2dX9f1boKII1o2MxVfWvb9JOAjZ99lPlJQoGqjwsr/D
 9KketdYq4/7S/CZkmLq7HeCKaQOoaa5BFtP/P9+rFT29z5rrqj1vE+pNC5UsxXy32wGQ
 9eY+KFiGCaiE03leooRHkc+52CItFeX/x+OryTmHcuYPbJod5Ma4jsZTQnWTHYjkJ9kx
 z42JWrdjZkgE6R8gp4XcH8xsOGL31/1+Nf+kZMsBsabFzjV8VusQzPeUGFXyOnFYes6x
 GqtA==
X-Gm-Message-State: AOJu0Ywi3IpbI5CkXhPjSEUPBPcGkaoShFGVsKgFebks3pxeLuFZGo2o
 9Sb4jatp+Rnj3xDe2zxQpz/9e2ciQBEq0NYtU+XmGBvwVHnArqVIuJo4R4mDr+U0ph5qeEnOEl3
 zdbie
X-Gm-Gg: ATEYQzwr4bbPuKEoYS0lxIFA4BO1SRPjT1HdtiiQ7wcYGsMUQQCuLXn07YRf3wUupvc
 jqH1NPUNtqCKMy7IIOTPnLK8lmU7qLsali/iTD0ayxcB3SMjwwln+fl9tfS2pxpQyWG7nm2HizH
 dhyvt2BJErPuN9Vv8IIaxSWh1n5dxxU2TroLbm1BZ4UXS+aUFe6kMuwwYsTJ7bjXJ1XTSooY8fl
 6Qp7TD+kwdP/s1ZoPWAalv4iKsYcZsQkJhBmfnQ+c0iF86mbjyOIeS7z2zgirleQpNwxGyHCJCi
 KPFjWXGLPqC5N5mTVb+xErA36G8Hc73Br0TICX2mQpTKiAHXETfkn3VJUtssHavbH1RGI+c9rRS
 xJ81OdPuF7fTGXVgifCvjgUZpS2BwI4yx3q2EmgjYXrcal44alK/miMh3YujCQv7Rzil67Nps9+
 ivtwZGczxqLfnyAGZTmCpXRK0Q0/DFSh0Dv5labexxPujJ8dm74j/mGqg9pjELqt+tUpGaVycvZ
 3ZT
X-Received: by 2002:a17:902:dac3:b0:2ae:62c8:771a with SMTP id
 d9443c01a7336-2ae6aa04b60mr63022585ad.5.1772744828913; 
 Thu, 05 Mar 2026 13:07:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 4/6] hw/virtio/vhost-user: make compilation unit common
Date: Thu,  5 Mar 2026 13:06:54 -0800
Message-ID: <20260305210656.2140206-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-5-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index bb8f8eab77e..a8907cca74e 100644
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
@@ -2287,7 +2282,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce65..ae33d403cf7 100644
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


