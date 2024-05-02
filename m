Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE9AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFK-0008TI-Ms; Thu, 02 May 2024 01:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFA-0008NT-4C
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:33 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF1-0002bO-Gj
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:30 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5af23552172so4531678eaf.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628661; x=1715233461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADqNlAkDm96SQVHhIMZpqIxZeOqZ/sxONedvIjC0scE=;
 b=hrS1yJ9h4CDdp3kWKbkwFo9hfKvHVz2DLBTEWTrNUO7PbRFmmV14Hj7VkIox4We0/G
 MGgbawWMdZ7dbb65xpoxwHqC04Cu/8lQ6k2OzzvychUvl1O/wIs2LJOuVYlKNexoa/R7
 J5UE5CxGmjXUvhhF21rtJNdwtrtEBIyzPFRk5MYHoGqg1dIEgi9Aqq/ezyqG3oO9FrJ1
 GiJCgnj1exTqR1HzmCA1J9nGqtva/LW1AsIfcCKCTGAAH1H0BJYZBnTNmGbMHrYMXPdQ
 fHJCmjEJ+7OPf9jj31nVGv+nkR5nvAafxfdn+kiTNxNquf8lwOGxfxF7unZ4ij96FzMl
 JyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628661; x=1715233461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADqNlAkDm96SQVHhIMZpqIxZeOqZ/sxONedvIjC0scE=;
 b=lAa/s6xr8zTyIXbh+YShFjBhtSmoSqVCIkP30B0qtDQw+RWqRd+cuJWGpmqhZiqmrZ
 RB2a5Xxnbmw8qG+wdZ1bulaVMQJn73ShpGjBxmfas+jCBZ7bWuiyU0AxeynGoHA2o6LP
 uBiZr+ghcIN7l/ktiv6E2A6zsT2Z9SF/zw/5t7t4OSx4PIBKHzzUGg7tc8TM5yNf8Ith
 BAUUaGQrnprFfoJWUAmyu+9xPIRq58o0s8Z45r9+8SwKck2oAIFjjil1LNxJeeW+Xf6X
 KYSPOnIi1L9A4qx03aCedB8lM5nS5gPabSBRwEZy5M4n/RtDQdnDFx0NCWzM396TJfqI
 71Bw==
X-Gm-Message-State: AOJu0YwMdN9dDdg/NYfKBkyAPNuCmwux3fpXHo/j4WxjhcOq+DiEknt/
 Mdh4Pn2YFQ0PBoYTmuD+hJhQaeI9/lW2UtVGdzjBxLlZyYWoMVCxWOMMPuY8VnJQyl+qNPaw8Fn
 7
X-Google-Smtp-Source: AGHT+IHUY1OOIPERORejxuxUKhRMKGRdyno2lzbvKMWu8fD+Gl995g2vJFaqgbmsh4V0EnPFkHHnuA==
X-Received: by 2002:a05:6358:d3a7:b0:17e:53f9:6985 with SMTP id
 mp39-20020a056358d3a700b0017e53f96985mr1586564rwb.14.1714628660924; 
 Wed, 01 May 2024 22:44:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 01/14] target/s390x: Do not use unwind for per_check_exception
Date: Wed,  1 May 2024 22:44:04 -0700
Message-Id: <20240502054417.234340-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Using exception unwind via tcg_s390_program_interrupt,
we discard the current value of psw.addr, which discards
the result of a branch.

Pass in the address of the next instruction, which may
not be sequential.  Pass in ilen, which we would have
gotten from unwind and is passed to the exception handler.
Sync cc_op before the call, which we would have gotten
from unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h          |  2 +-
 target/s390x/tcg/excp_helper.c |  2 +-
 target/s390x/tcg/misc_helper.c | 23 ++++++++++++++++++++---
 target/s390x/tcg/translate.c   | 13 +++++++------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index cc1c20e9e3..96ab71e877 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -359,7 +359,7 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
-DEF_HELPER_1(per_check_exception, void, env)
+DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index f1c33f7967..4c0b692c9e 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -209,7 +209,7 @@ static void do_program_interrupt(CPUS390XState *env)
 
     switch (env->int_pgm_code) {
     case PGM_PER:
-        advance = !(env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION);
+        /* advance already handled */
         break;
     case PGM_ASCE_TYPE:
     case PGM_REG_FIRST_TRANS:
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 8764846ce8..8c27998ab9 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "qemu/host-utils.h"
@@ -590,10 +591,26 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-void HELPER(per_check_exception)(CPUS390XState *env)
+G_NORETURN static void per_raise_exception(CPUS390XState *env)
 {
-    if (env->per_perc_atmid) {
-        tcg_s390_program_interrupt(env, PGM_PER, GETPC());
+    trigger_pgm_exception(env, PGM_PER);
+    cpu_loop_exit(env_cpu(env));
+}
+
+G_NORETURN static void per_raise_exception_log(CPUS390XState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "PER interrupt after %#" PRIx64 "\n",
+                  env->per_address);
+    per_raise_exception(env);
+}
+
+void HELPER(per_check_exception)(CPUS390XState *env, uint64_t next_pc,
+                                 uint32_t ilen)
+{
+    if (unlikely(env->per_perc_atmid)) {
+        env->psw.addr = next_pc;
+        env->int_pgm_ilen = ilen;
+        per_raise_exception_log(env);
     }
 }
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 90a74ee795..2319dcf259 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6426,13 +6426,14 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER) {
-        /* An exception might be triggered, save PSW if not already done.  */
-        if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-        }
+        TCGv_i64 next_pc = psw_addr;
 
-        /* Call the helper to check for a possible PER exception.  */
-        gen_helper_per_check_exception(tcg_env);
+        if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
+            next_pc = tcg_constant_i64(s->pc_tmp);
+        }
+        update_cc_op(s);
+        gen_helper_per_check_exception(tcg_env, next_pc,
+                                       tcg_constant_i32(s->ilen));
     }
 #endif
 
-- 
2.34.1


