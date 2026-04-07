Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B3AFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaV-0004EN-7B; Tue, 07 Apr 2026 15:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaR-00047x-44
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaO-0007NL-Is
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:46 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35d9749c26dso3994249a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591982; x=1776196782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Smdg2r8Qlu4cp1beF5JjyoiN3F9rXYpZ3sMjVwx1frY=;
 b=zO6s3FCzU8D2l4IZJd8VuZcViiU6acNYjBfEM7CIjiyn36bbZZBPQeon49NnBeGceW
 TyvuEbkuSwyrZ9ivqRz8nHMu+/vy7n8ojmw8A/xNpnjyziBBAUbWWt9E8KjhJ5LHbfLF
 dM6S4S/AZ986zM0yhDxdzkkyUjyMNKAAPZDWVq5IA5pLZvq+3z7HNu/dmWQrTI6XRcA0
 E0FXUh5ECwZww3C16EMrJ+qsSeDg4xEnojgT31QXQegF+3DbqR23EBxUsM0dwMZGY0Ad
 6DH8FO7ahdf08tVEPJjVj9ivc+BhIHnssQ4bN8uAOUOWtzmx8MbiuLu0HOWuOtYYhy30
 yEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591982; x=1776196782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Smdg2r8Qlu4cp1beF5JjyoiN3F9rXYpZ3sMjVwx1frY=;
 b=JI3uUQ52KIOJLvVIOct7D5Vfw6vET7xWYXy9f5gxT97bG82YKq9vYtfSBURptsakut
 tERkITnchWZK1jt/vL5aZ3TjHa5da99Ul71Gw52ggkkSZaJMlciZ4ji1Sdor6lweksrY
 u1B7btIk3R/cvli5C2MLMpUZzT9PhCWZOdGJy7ngIt6ppYe/iF0agUjznbYsUl43q9fx
 iuEBqKLjnI6FVrvIg1DAIZTwTTAIPnEg2YyvvzW/ZVGRCOYl0ttMHQFBFkKXXJ5CEoCu
 23vEtn26lHVLoQPYyv8EO2kuuj0bnolyrSUpyNn9hvDyGj3XNlJuno8AOCAXhVfRIU+b
 658A==
X-Gm-Message-State: AOJu0YxP7jPfmRTCf/KU0OTdTa2ww8naEfRjpCNmIjazr+2OWopyoJ09
 wR5uzAkzAFpsSQJVm9ksaMJMfO9K+mFiCNLEQ5mxxxYz78PsRWisNaAqBYKJtRsLLpVMHdEFeBH
 NBzPfy0w=
X-Gm-Gg: AeBDietTzb9QcAy9fkvAPHW/zybQV2XinN06zndKqrvqNPHHB3G7wFl0wrBu3uQ41am
 raTdV7R5FaV9eTWp4DeMmYNQl2llqCCzgzYDGkEuZH3jQ6n30LhFBLYJXbPqW1zwFnVfpn1MTQ9
 mgQIV0/DEZwXClYq+FKyLwnZ/i6y8boE7mwq5sVCNB3ELtT1IvxMoMfGVqMoqdvBMmLxMq3dy7d
 LQidOMdzVeuIoJekkROxEXbTm934qFhkV1hKKqL5upIizne9w4PR8I+l+Nhp6IbSCrg/WZl4vuR
 AQvnGTfLDS6R9k2Zmlg9GXjUyJ22Ti6ZjT6YjLIVBOcLAseP0qVOK4DF4tnvA/N6rRgJIyt1aQh
 w4yw3snPSvQXGbUwuuvOB4eQDxwpP/wzmKBDm/YgZgnzGt4fUYRQrQgsS1xZYC602xbjuMgyNfv
 ABmfSj52+zz4aPburhKSQSFXlFpwmhFDwvbGMMp/h5YbBxjr9V/Ip7+g9uvl+zhl3cSQNqCJVFL
 cI7
X-Received: by 2002:a17:90b:3d8a:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-35de68ebaf3mr19639216a91.18.1775591982470; 
 Tue, 07 Apr 2026 12:59:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 13/21] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
Date: Tue,  7 Apr 2026 12:59:14 -0700
Message-ID: <20260407195922.196410-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/tcg/translate-a64.c |  9 +++++++++
 target/arm/tcg/translate.c     | 19 +++++++++----------
 4 files changed, 27 insertions(+), 10 deletions(-)

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
index 35ad7530c4b..7533a4d01b6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#include "exec/translator.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
@@ -10949,3 +10950,11 @@ const TranslatorOps aarch64_translator_ops = {
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
index 204f9657993..9ab926b118e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,7 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/target_page.h"
+#include "exec/translator.h"
 #include "helper.h"
 #include "helper-mve.h"
 
@@ -6878,18 +6879,16 @@ static const TranslatorOps thumb_translator_ops = {
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


