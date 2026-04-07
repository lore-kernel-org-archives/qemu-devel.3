Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EA110F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcC-0005LU-Ag; Wed, 08 Apr 2026 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYA4-0000lD-4A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoZ-0000py-A6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b258576d8cso35167445ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600549; x=1776205349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMozfKLpPr+o2x65kY+FaUHoEdApriGrkE0DK1FGUcI=;
 b=IVSIyItd3BO0Ba+TQORYM+wUeukx7eYzPo6VTSiSbc/xF3vVA5pLQlKgg4TDiJgxdF
 wrm2JWy3uUErpPXegEdBBjCL/PlBc8xCLn7cys9ShusVb1kffUP9ssq4rbrIozlQii7N
 BbgrGI6Rj/UB0lFF/c3bqnrJSGYDd4/gtGHDgc/V5N/vxjnhWNxsM6btNQJc2N8GVGK6
 Es2Lj0l6cUekdGi0kB/qc+xvhMbJ7ijmAo1ox2EFDxdLH1sQ4tMCmPjI8mqXbxqtezyg
 vP1W9Uoc580pqHaP3o8DFca8a9DHudfHnJjbVM8xWZpLTyDSQGICs4v95xzA6EB/Tc+m
 My9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600549; x=1776205349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMozfKLpPr+o2x65kY+FaUHoEdApriGrkE0DK1FGUcI=;
 b=P883wAudQmV83t3J9p/5R01SEN4Kb3BPh5xDjGoqfs6ClOCY6pqVC9aYLsRxZNiPGX
 Mn87FJQ6SGf8se+Ie7Bpef81X3n85PyI8TWkSQnGk4SAswxQl7Fo5NVH14equZhZR/v2
 2EdTgjw/6DPFZY0xEGkrm3DujhTI23BXn6YfY8YmqBgfzhm9ckCw5/CA8EjhMyZpokLM
 G2e32GKcgFSUXlnXKHJ3pANVZXQjeH8iRdmgQeiStrIVAmgGQF+m1jp5xkpgxOqSH6xq
 6S0REQN+6GJw6Xd5YdYeGEdqp8iuVGdnNSGcXqJPoVb7GDfT+p3u/ad7299DKm45fbDa
 UOOg==
X-Gm-Message-State: AOJu0Yw4ibJrhsXujJRKVQaecg+A5G3WEiEyW32LSAO2UwWx4w385uhM
 2abl4VAnpcR2Z4OJwahGHqNoJyAO+/kvQKCybcHE2cI52Mtfyg7Ea/yLYHvJtahj3k1WU7wttuZ
 mv5R8rFc=
X-Gm-Gg: AeBDietmYSvLXhniKllEis+RXy43aw5T6EvATLzr7fiEcjR8cn5qWPcEeu6dHnX+D2o
 QFvX8YgPRSjfnT71OlW4aE7h4QZclPB/YXJPME+1oc/ETscZ3HTZv6ILsscnVANqW/Hz/VFlfJT
 9Zgn6A4g+D0C69BEw1qpIhTFtjKIVwFyHqNLO+He7v0KGxIqhbR3DF2rdzzH+5uS6f8m+L0zWDL
 gQMySOBcn0I+5AN7UgJzR/8/d8UB5EbdsFbIxRH8ZfLP2DHpbhal522zLLN+h6kZpq8m3da8utN
 ksSwXKvevqt5BnJHidzLTyS1lWW6g1upqjW7lFonOAWfUM9bMQL0dsPIX8xAdOdiMjDHOl0K17B
 gvAuvMkV/W8tH5eJ5d06Y8C1msLuMpQp3rlXmfzpwd947Gq3sJ/s/Cb1k/kMUGmMnQq+VQvlX1S
 Ve7GLW3ffLL6YEuGpJK30Ax3GijC0nXU2iY0yamzP5BsXk7v9dF8YD9issBngNfuH2izeikOP5b
 yGW
X-Received: by 2002:a17:903:3b8f:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b28181f77amr196965195ad.15.1775600549042; 
 Tue, 07 Apr 2026 15:22:29 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 13/21] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
Date: Tue,  7 Apr 2026 15:22:00 -0700
Message-ID: <20260407222208.271838-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


