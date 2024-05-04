Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28753C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HUC-00024q-0P; Sat, 04 May 2024 11:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HUA-000249-Nk
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU8-0006FI-Tz
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:38 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so319570a12.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837175; x=1715441975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dNPNLs1khRCpqkW7qQSkGpf2gCcH5jGPYIjxIk0MdY=;
 b=Dtl7I85o02IsilE/RAvQycghH3veu4YufVfJT+ozjzsmkH/RZdFCz6zTkMV4NZpeme
 ERsGso6XoTNf/G8GfWpv9nQtRLyT0TFVPtbjAg4pLlIo2spWKPaVPAh+X+6o/6gTokHB
 5LZdtfDmH4/T+a9ipliyJUWHUBokQqbUF9zXDme1cxC3KUREFKJIjyFoSPadZM8HxNYK
 Sdl4OhlmbTYDx2p6HWzT9l5TPjNL4wLFHf98rToNMhFmEg637LnYYfRPbLq7iamD9o51
 mAhP7c4B1E8IGH/YUEg5/1/sOpUZiZv4VbjtbEyD11ze3azYJyh/rhLGuQ2wMhDz4FZP
 CRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837175; x=1715441975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dNPNLs1khRCpqkW7qQSkGpf2gCcH5jGPYIjxIk0MdY=;
 b=itz0WwvV944T5SyWhQyvYwhJDaV717Q7hLNE+m+v9ZlsfVOcCrSrskbe3aqo+iUn3l
 UF7BKWyAGgqd/Ubow376QCX43yu2ye0S6dNqsvRptopMHNFJPE1vAhC+iehIhEVT5y/T
 WoocvN84hdUmitpG/o2EQUyrL1YTOIqB6eN43QUHTU4gHg841s8iQEtIwWTj9NsWQbBW
 eYvjJJu6uymk8VIuZeQnRQpVEuadD39dH4lWeORYPH46px8nhOnURj7X1RFCeM3HRynj
 OGORFRU8EGZnwmQwc37tYFBAzTs7Z7oLFHO7kip4MHJEaMhibIhnPmuqqSYwzkT/gELG
 ukPQ==
X-Gm-Message-State: AOJu0Yw6ZGm0eX8kt9i7kM5yJG5ZnXX1QOyM2MJkyxtg11Y58WuRXfkY
 QwrcY/OMGv7Ins5nXSuJTh4SN9SEzo1xlfLFKG+NdL9JPP1IMQkKdPyI6bduxGUPCIe5Z/W39DV
 U
X-Google-Smtp-Source: AGHT+IEHw0hbEAKWoogkQE60piDeGiF5T43pZJzRuqGBme4nV/1yLqyy6Rbhadbwyw4s8wwoadVNPg==
X-Received: by 2002:a17:902:ea0e:b0:1e5:3d8a:75fd with SMTP id
 s14-20020a170902ea0e00b001e53d8a75fdmr6739272plg.69.1714837175579; 
 Sat, 04 May 2024 08:39:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] target/alpha: Split out gen_pc_disp
Date: Sat,  4 May 2024 08:39:25 -0700
Message-Id: <20240504153926.357845-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Prepare for pcrel by not modifying cpu_pc before use,
in the case of JSR.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-9-philmd@linaro.org>
---
 target/alpha/translate.c | 41 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c1a55e5153..86402d96d5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -252,6 +252,11 @@ static void st_flag_byte(TCGv val, unsigned shift)
     tcg_gen_st8_i64(val, tcg_env, get_flag_ofs(shift));
 }
 
+static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
+{
+    tcg_gen_movi_i64(dest, ctx->base.pc_next + disp);
+}
+
 static void gen_excp_1(int exception, int error_code)
 {
     TCGv_i32 tmp1, tmp2;
@@ -263,7 +268,7 @@ static void gen_excp_1(int exception, int error_code)
 
 static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
 {
-    tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+    gen_pc_disp(ctx, cpu_pc, 0);
     gen_excp_1(exception, error_code);
     return DISAS_NORETURN;
 }
@@ -427,14 +432,12 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
 
 static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
-
-    if (translator_use_goto_tb(&ctx->base, dest)) {
+    if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
         tcg_gen_goto_tb(idx);
-        tcg_gen_movi_i64(cpu_pc, dest);
+        gen_pc_disp(ctx, cpu_pc, disp);
         tcg_gen_exit_tb(ctx->base.tb, idx);
     } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
+        gen_pc_disp(ctx, cpu_pc, disp);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -442,7 +445,7 @@ static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
     if (ra != 31) {
-        tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
+        gen_pc_disp(ctx, ctx->ir[ra], 0);
     }
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
@@ -1091,7 +1094,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             }
 
             /* Allow interrupts to be recognized right away.  */
-            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+            gen_pc_disp(ctx, cpu_pc, 0);
             return DISAS_PC_UPDATED_NOCHAIN;
 
         case 0x36:
@@ -1138,19 +1141,17 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #else
     {
         TCGv tmp = tcg_temp_new();
-        uint64_t exc_addr = ctx->base.pc_next;
-        uint64_t entry = ctx->palbr;
+        uint64_t entry;
 
+        gen_pc_disp(ctx, tmp, 0);
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
-            exc_addr |= 1;
+            tcg_gen_ori_i64(tmp, tmp, 1);
         } else {
-            tcg_gen_movi_i64(tmp, 1);
-            st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
+            st_flag_byte(tcg_constant_i64(1), ENV_FLAG_PAL_SHIFT);
         }
-
-        tcg_gen_movi_i64(tmp, exc_addr);
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
+        entry = ctx->palbr;
         entry += (palcode & 0x80
                   ? 0x2000 + (palcode - 0x80) * 64
                   : 0x1000 + palcode * 64);
@@ -2344,9 +2345,13 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         /* JMP, JSR, RET, JSR_COROUTINE.  These only differ by the branch
            prediction stack action, which of course we don't implement.  */
         vb = load_gpr(ctx, rb);
-        tcg_gen_andi_i64(cpu_pc, vb, ~3);
         if (ra != 31) {
-            tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
+            tmp = tcg_temp_new();
+            tcg_gen_andi_i64(tmp, vb, ~3);
+            gen_pc_disp(ctx, ctx->ir[ra], 0);
+            tcg_gen_mov_i64(cpu_pc, tmp);
+        } else {
+            tcg_gen_andi_i64(cpu_pc, vb, ~3);
         }
         ret = DISAS_PC_UPDATED;
         break;
@@ -2908,7 +2913,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_goto_tb(ctx, 0, 0);
         break;
     case DISAS_PC_STALE:
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+        gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         tcg_gen_lookup_and_goto_ptr();
-- 
2.34.1


