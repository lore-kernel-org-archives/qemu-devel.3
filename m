Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BAC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYZ-0005IV-TG; Mon, 12 May 2025 14:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWy-0002YS-Pn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWv-00007D-7v
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1242205b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073131; x=1747677931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH1qfLH+/zCru9XWBwZx/jkW56FRhaJPBlyr85eQl0I=;
 b=mjRt9JKwjx/xxvox1017IKr3UitbboJ0EVx3XY2p1z8gTPdwOSCLpgsD2W4GSEbrm3
 5FKt7IaivDuCfx37QPJs6GFbriYjAeE85XZv9brb9ACf/L+xYbx9bTffMOxanz5m4Z2h
 glO3prIUCQIkWuRQGvcmXecPkS3FupzGG6vmlij1Z8NPhOfdrY+dTBMC9KlQy9zsSGW1
 /JWH+7iKDE/8zTEKf3gLqa4BNQyBkLQGqEwYZu2hWkmFEJmUUUOtvfvmi6ppSYLUrA2m
 QgTrwptxeyQuZ18CyOAkeGa2KeOw+OhEBb7hx7TGS++QY6jK04WMw/KLtvDTfCq09VKo
 zESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073131; x=1747677931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QH1qfLH+/zCru9XWBwZx/jkW56FRhaJPBlyr85eQl0I=;
 b=vo2qKM9pDMmygL1SG5sAmgk1/VIILK/PbYzdeJHW7aLHMl8K/87AuQvnpPD10jaD+w
 /x0+s1gQvdbtrEK2UlhFpXnAlJhmIlm+Dlb/jhvxGXb2mR0gvoMleH1/JOULYo72JP+O
 9r1a3yf+XI399lP9y6RWKqDzFs7BHo5imnX+O4MwIbkQZbveMyJGpeHI1p5H2qkeGwXe
 V/M84vdyFr5Xj5GsI9qK26d4advxEQu+xdqmbo/Z99I9I/HqtjufMjgnRbDeMU+CABBP
 30OrY/gLQYRDiGdQgAlg9ueEzIrX7VjLV1AHuuJsdJQaixs0bVxR33tGT0rGBEf93B6x
 4V0A==
X-Gm-Message-State: AOJu0Yz96xjycba42/zRCDw/6XcPSclxKKJp8L6Vogf9y8R2ROO89nSX
 vq8Mbo5tMd/EOrqA3DxYrV72/Tkit07OAgeIjoZsc6xOKPWiwd77h4qmMoWV9WDaltzWcC6IAtz
 j
X-Gm-Gg: ASbGncu+p6GND/xAJ7rMQ6HJzPtdI6GC38kpRcoWJbIbMmNGLOexSyk0fWPuIrO2Ioo
 BX/RYoCceLILR49XLucZz6FAPxttBl+VVJ0KQ/7BiZIi120xSprs/rGgirmkBYizGk7yx331i2f
 fc+/9GKkCkpzAQaBukOD/RpE1dmxm9RJGgm2OvxzggyxB7CTf57xlGpecdzDCFNvItU5vw/Kqgt
 wr83gdWWj5RkkYD+VQCx41fXlgBhfChoNBC+m2D7RyhL6MicSaiJ7qJy35/6EAJkqBmiwZSBpdt
 no2ruRH9qNuVxaAQWqrYRdQ1/Pr8H5a+B0HJjk1LhOoR74TCsUw=
X-Google-Smtp-Source: AGHT+IE3cGskjzjRojgLkr1I7mB9wKn6lFQ8dcZYSyN1P9AGSzZnigX6VHGug8trK7WU8FJVQVXhIg==
X-Received: by 2002:a17:902:c406:b0:22e:7e00:4288 with SMTP id
 d9443c01a7336-22fc91cb78bmr201982785ad.53.1747073131634; 
 Mon, 12 May 2025 11:05:31 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 22/48] target/arm/helper: remove remaining TARGET_AARCH64
Date: Mon, 12 May 2025 11:04:36 -0700
Message-ID: <20250512180502.2395029-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
we can expose safely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92a975bbf78..aae8554e8f2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -29,6 +29,7 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "accel/tcg/getpc.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
@@ -6565,9 +6566,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10625,9 +10624,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11418,7 +11415,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11530,12 +11526,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 ARMSecuritySpace arm_security_space(CPUARMState *env)
-- 
2.47.2


