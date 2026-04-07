Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E407BFB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wBB-0007mp-Fk; Mon, 06 Apr 2026 22:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-0007aL-LR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAj-000703-Bp
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso22686035ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528887; x=1776133687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BorICyKUEcit0epVpTcgcaMx1qooML0TzworVFbtz8w=;
 b=kI8Dg5WoeqqYdjnEsL6VuOuYot7nLDQH80jlwjI1ZohohivRDbdKboA6B6DQIiuQ5z
 Aj8TFYml5MwR2U2v8chnXtKr15SKq86jVxU1VdZl7GsFnE2qBUZVQVyYaU6EdZmgnGn+
 1sIcTHRwTf8Xm6b4T6Q7UjcurqRd87eXBGlwcDq+F5+MxWiE2hgH65tHXlPDQfqfxm8l
 15Q4n+UyrY8J9dWqEQWjQ3HhcU1M9pcmLYEK8JSgV9xNAm4FPwOt4nyQ/hWI2jwYPBhr
 wCIYxmVsPsnOdekUpsfNR+PHlgzkQvp2JRAMJwCoEOhIvIfHRJj9qZ8Gagb3Zr0682Qk
 HxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528887; x=1776133687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BorICyKUEcit0epVpTcgcaMx1qooML0TzworVFbtz8w=;
 b=NhYDck4N/+TkL90Ik0bCgwvbS6i1lV2Mne5i97b62SFjfeXuGL5LP3t8s9LlRY9CKo
 PqBETasxgajrP3A/0ApTq2IEW99jDd7jmAooOwLlBnziUfNO7qgnBZXOVIQcPRriozKL
 z/y88U75QxnYd2vpO0VVYHFI1WONWDGs9yjm7n0fqbgA5PAHG1zro1EOv4QxFZfCpoFQ
 qTxY2xzS+pMdfsQTpgiHXOXItQbIvwhTrSLIE7HykvqXbSQwM6hyfI25aYcq1lQTiN7Y
 4xboiYcpSOXAB7jQJIRFnZs8iGhUEmK+/uyvrkLCEJjVl9rYhj3Bp8AGNN2vacB8xF6U
 +x0Q==
X-Gm-Message-State: AOJu0Yw/kffQnR+5oBRahNHdcTissjJl/9qT8WlgY+y1UNL2sBFA/fHp
 881B58ePr0uqOOeiAUBfYraVojw7pVFPgGaAdCqXgufCWmUSIM214R2ODA9fGcEc+3EBvPbweZz
 hXH7XtQ0TSA==
X-Gm-Gg: AeBDieselNkCpUTljW+Z5IEXwkpobSiPOSkARBr5117oDd4jSw0BVTsHgyBlv81KbQE
 4hkhRSqtFftUcrz4nVkvqIPzzcpdRCANBi9ysxuxrX/DYClefpQffLdDfX9ZXIkDbJrcW7BzJzR
 HTnI/CeVJNt4X4ZaYPtHrSnIf7a2dMV4UeqtSSPMIXj6lnAWAOZHm0ODX6keNZafU18Knu3jN6g
 0f4WI5p7EGOo0kQcbtpGc6eKiSwn4Md3GafFUkFij0x/MIKs6gMkFnk0eZbZBGVO66QowmFrpES
 RJs6t7O6xY7Bx7KDTBcZsvwXSPOQ56BCwKOEQxkXpmsyNPcfEXuO/RSEC7X206pxnkFSXK/SKi5
 E+K5FgVbwfzSHEpGPqX0ekpW0pMb/mKIiB5NAF0p2+1ayMDX4nr5JxUhzdNaNiJlRKLc08kaWMU
 l1YK1ydfYfpabt59znws79gh5lysh4XcbHBcMnCF7E0xaifk2lq8AXoje7oNFGQlz/yPIVwm1ix
 Ukk
X-Received: by 2002:a17:902:ce0b:b0:2b0:c060:aab8 with SMTP id
 d9443c01a7336-2b277d9b788mr161050855ad.9.1775528887410; 
 Mon, 06 Apr 2026 19:28:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 13/20] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
Date: Mon,  6 Apr 2026 19:27:41 -0700
Message-ID: <20260407022748.57629-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

This allows to get rid of TARGET_AARCH64, and helps with next patch
which will define at runtime tcg address type, by adding a second entry
point in a different source file.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h         |  2 ++
 target/arm/tcg/stubs32.c       |  7 +++++++
 target/arm/tcg/translate-a64.c |  8 ++++++++
 target/arm/tcg/translate.c     | 18 ++++++++----------
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ec27508473..2850edcb198 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -381,6 +381,8 @@ void arm_init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
+void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc);
 void arm_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index c5a0bc61f47..3945dc49e5e 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -3,6 +3,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "target/arm/internals.h"
 #include "target/arm/tcg/translate.h"
 
 
@@ -15,3 +16,9 @@ void a64_translate_init(void)
 {
     /* Don't initialize for 32 bits. Call site will be fixed later. */
 }
+
+void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35ad7530c4b..c5af26e2b7e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10949,3 +10949,11 @@ const TranslatorOps aarch64_translator_ops = {
     .translate_insn     = aarch64_tr_translate_insn,
     .tb_stop            = aarch64_tr_tb_stop,
 };
+
+void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
+{
+     DisasContext dc = {};
+     translator_loop(cpu, tb, max_insns, pc, host_pc,
+                     &aarch64_translator_ops, &dc.base);
+}
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 204f9657993..0597c9d4bed 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6878,18 +6878,16 @@ static const TranslatorOps thumb_translator_ops = {
 void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc)
 {
-    DisasContext dc = { };
-    const TranslatorOps *ops = &arm_translator_ops;
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
 
-    if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
-        ops = &thumb_translator_ops;
-    }
-#ifdef TARGET_AARCH64
     if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
-        ops = &aarch64_translator_ops;
+        aarch64_translate_code(cpu, tb, max_insns, pc, host_pc);
+    } else {
+        DisasContext dc = { };
+        translator_loop(cpu, tb, max_insns, pc, host_pc,
+                        (EX_TBFLAG_AM32(tb_flags, THUMB)
+                        ? &thumb_translator_ops
+                        : &arm_translator_ops),
+                        &dc.base);
     }
-#endif
-
-    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base);
 }
-- 
2.47.3


