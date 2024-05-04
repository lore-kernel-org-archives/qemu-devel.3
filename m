Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D00C10F1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HUC-000257-5x; Sat, 04 May 2024 11:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HUA-00023s-4m
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU8-0006F9-GP
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ed96772f92so2966305ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837175; x=1715441975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVVPRKrlT2Orc69ECKDjPxn2WVFASwuWViHwTTTKVCk=;
 b=nEFYmN6suGlspSM4JCvNYyhkb3fNpxI5zTZ/jYa5reAahd54c/PCWlfqSI0qXEH6Te
 TZP18y2rd/W3hNol1UOXeCK6FU06DRjCeuljpTqHf2ms7NFjdmXOp1Dg3P19+LxPTCVJ
 uE7TiNJNHqhfoPIFJJGl6ntyGD008mQXKRIBmJfIU+Xd9wlY+9E9hNvGSFtTm0ZWm0eN
 BJ3mc//eAx2fXwgGDhH/OwXkhREbK3yim4k3UPPfkyaMC1Jry2x+W36s2UuC2TwhVI+v
 QjEV0Xwh3MaFe/53tLRLYiYQGFBMZc9PYx9PAFm275ZTg2Qr1dQpzzFhVBymxvkRIoO3
 AFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837175; x=1715441975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVVPRKrlT2Orc69ECKDjPxn2WVFASwuWViHwTTTKVCk=;
 b=afgRejoqQSPeeBsoh6L0tX5tsgMppJGvyeQDljltzomKlVazfZw6Ce4VxIJ1pMw74o
 3QZw6DQUGjMvgUFo/oavPvv7bcLyBU359jhuekWRwRC4sRHQpDALyhywXn8Ar/MPcytw
 zKGu20CffUf//+JbeQLvNO9HbLtRAsIXRPkudWwkLWDj5/2aYTAL03z+NbEzCp81hVjL
 8vHwRAqvXHOaE2anG0O9Ig3GpGbIxuiuG8+pajYptP6YGMfhTcwnOU4R4srPg91ukefA
 Q38VLe08swqTS4Yo7FNZ3XCv1cD5SfelzWKEUn0sy6Wc0Uce2XC9lwQpJStXgI9WiHQo
 OnkA==
X-Gm-Message-State: AOJu0YyLiIJqA+kQZrcxKW9kokpM6wB48AsrYrgjn8e/V8BJJt2TPCEV
 JkYYhJIDJq3bMs4UwmE58+j3/90TrzE/AFcQkm+yR4OGwOiYCW6NqmEHYZtXUkqrXj9O/trfv3W
 v
X-Google-Smtp-Source: AGHT+IHcBwjE99xqxnJtkEZC3Z61nv3umAeO4o6zrnJByalth0j3JygsO+lpuAXzMn5MmOo1+w3L8A==
X-Received: by 2002:a17:903:228e:b0:1eb:51a4:3685 with SMTP id
 b14-20020a170903228e00b001eb51a43685mr6776336plh.52.1714837174794; 
 Sat, 04 May 2024 08:39:34 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/9] target/alpha: Split out gen_goto_tb
Date: Sat,  4 May 2024 08:39:24 -0700
Message-Id: <20240504153926.357845-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 5/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-8-philmd@linaro.org>
---
 target/alpha/translate.c | 53 ++++++++++++----------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index b7b94cc378..c1a55e5153 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -425,15 +425,22 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
     return DISAS_NEXT;
 }
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
+static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
-    return translator_use_goto_tb(&ctx->base, dest);
+    uint64_t dest = ctx->base.pc_next + disp;
+
+    if (translator_use_goto_tb(&ctx->base, dest)) {
+        tcg_gen_goto_tb(idx);
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_exit_tb(ctx->base.tb, idx);
+    } else {
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_lookup_and_goto_ptr();
+    }
 }
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
-
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
     }
@@ -442,43 +449,19 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
     if (disp == 0) {
         return DISAS_NEXT;
     }
-
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-    } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
-    }
-
+    gen_goto_tb(ctx, 0, disp);
     return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
     tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
-    if (use_goto_tb(ctx, ctx->base.pc_next)) {
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-    } else {
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
-    }
+    gen_goto_tb(ctx, 0, 0);
     gen_set_label(lab_true);
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_goto_tb(1);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 1);
-    } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
-    }
+    gen_goto_tb(ctx, 1, disp);
 
     return DISAS_NORETURN;
 }
@@ -2922,12 +2905,8 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        if (use_goto_tb(ctx, ctx->base.pc_next)) {
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-            tcg_gen_exit_tb(ctx->base.tb, 0);
-        }
-        /* FALLTHRU */
+        gen_goto_tb(ctx, 0, 0);
+        break;
     case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
-- 
2.34.1


