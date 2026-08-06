Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BEC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18H-0006m7-5b; Thu, 06 Aug 2026 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18E-0006kC-2T
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18B-0000Ho-Qz
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cad8076b01so30031265ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034382; x=1786639182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LaQaHfv4P6MPUegXLFMZw8cHU7pJYmdlkVEOwBnBYgg=;
 b=j2jB4lBlGpdWd9TH9GJtUlesZiKkoUfQAH7YGpX2onvpvFJfRs1OqC9/DIJVZcPZKt
 Ifiy7Cc7m1qN19CkC99a1JWY2fEvfWKabirZKLezKALs2LYblimeYMAwVrXaiopF97ON
 fDAiAAWcZRl3NImXnilxh+In2Pvtwq/tgJ9p3CeIOICFwjHs52GUhMw4WTrCISAoX4fY
 uCnIDjBW5KDpb/Q9DsKDONjiq5kMy/BswEmxWmVthu+b9Ay1LLtIYVUjnIfayResxHon
 6PSYAYjlocjxD1iZB4z9I5+T2EvS6i07EWe5SWe+VlpZinRX804L1gU66oLY26g8TlSS
 FPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034382; x=1786639182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LaQaHfv4P6MPUegXLFMZw8cHU7pJYmdlkVEOwBnBYgg=;
 b=e0QFttPI3O1dOrvBoGvyrU9UXcgbpfdKPDE++9kvT8Q3D3De5H7ViCLrUHQZRTZaku
 DylPW2bqLQT8PHjQfyTdYMERqUScpIaDpfQbajlUVJIa/GySKfmzf+W8nFz25ufN3/XH
 AWRXOyymultiAaL3wAoNT1yAaAErGQY5P+5ZQYeOM54L6JfTtC8R2ZAZXSH6dqmzt83N
 2p5Gsd6lu1G+sqvUtQEa7HA64rjcXoTzc1llYFkxAHwmmWqDJi3fjKwOhibECfCMkyF3
 SNWvs3vbskiWZPi6WTvyHhyGRfvWvx9dVzzmIG7XxOYBR6xnRIx0VjzT9gLxNYaNP6wz
 Jb4g==
X-Gm-Message-State: AOJu0YwZc8TFfzDtztECI/B16+Ypx7YebPXIUUZwXrTUaZVoSzHkS6WJ
 U8cJJ6Bx+SEhUTBuvLEfAMbaFxA5CPkxWPPrGMXjbtsJ4eyrkWaFbCMYR2meE5qjOnyyGWoNJ7M
 gGpE8
X-Gm-Gg: AR+sD10jcxIHNSiOrYMaCyNMJfXUBn6Dh/13WdhjCmiXDXcUlw4xD67mJIK4NcQmN2r
 7anx9JmElgLgV3g+BsqFpGr1Yh9l7zv1FF2/rCgRO5qK25BLv+Pa3nhFLle4iFiN1mDR8ovYWGo
 NqrU4oN2IwIMh4Y+0njPpUs4JWEnxy38qXUMZP44K/ExhVdmFqIAACuVcmvUMcJLLRknHx+PpIO
 VKgBEngW250S8ckO+0ovZaKHgIUH6MisSHgDHpYLM0HN0LlBGzVR1ftzqNqfCtbhaaWOYCqqKa6
 8EarcpUSzT/f2Dud98p1ncEZlQOEfHRhN7T9gBXpRKfPPO/HmVaGpHQVoe2TrANxzZWBupia5t4
 DQ9tXUWKQlE5SJPc/yF15eUgzWUiLDSTqODTj9Z0FgVN3ncwMGbwJJGUu8G6M5O69Ub5YRKoNOI
 xsbJyxiTzXDPC8xrxToCUxXYBHgmptqJkMOT73D31ZOHFVHmLn53I2jPzHNzPwRp4cwitmXfE/g
 zKIKEW8xCtRnKfD+yR6
X-Received: by 2002:a17:902:fdad:b0:2bf:9760:b94d with SMTP id
 d9443c01a7336-2d0ca7fd072mr206644015ad.15.1786034382419; 
 Thu, 06 Aug 2026 09:39:42 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/7] target/arm: Pass ARMCPU to aarch64_aa32_a57_init
Date: Thu,  6 Aug 2026 09:39:34 -0700
Message-ID: <20260806163939.328201-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

There's no reason to pass Object when ARMCPU is more appropriate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu-max.c   | 5 ++---
 target/arm/cpu64.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4026f67579..9c9196475b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,7 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 089f514bd8..d7f2500353 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -16,9 +16,8 @@
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
-void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only)
 {
-    ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
     const bool aarch64_enabled = !aa32_only;
 
@@ -205,7 +204,7 @@ static void cpu_max_initfn(Object *obj)
 
     assert(tcg_enabled() || qtest_enabled());
 
-    aarch64_aa32_a57_init(obj, !aarch64_enabled);
+    aarch64_aa32_a57_init(cpu, !aarch64_enabled);
 
     if (!aarch64_enabled) {
         aa32_max_features(cpu);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2816735577..e3ee0253a0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -688,7 +688,7 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
-    aarch64_aa32_a57_init(obj, false);
+    aarch64_aa32_a57_init(ARM_CPU(obj), false);
 }
 
 static void aarch64_a53_initfn(Object *obj)
-- 
2.43.0


