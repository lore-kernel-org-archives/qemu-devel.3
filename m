Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E957CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcnO-0004M8-GW; Wed, 06 May 2026 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnM-0004E9-EJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnK-0000U5-DI
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0046078so57226315e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076008; x=1778680808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AProBNNYKZYY1mqtdA3F7DQEDgEilBHZyhUb2mUtV+I=;
 b=RJEc8n572VY1mZXuqUOL9qcVw760QHPqFcYj2d4RL8jIrdsIUmT8Of8QsaJuWW1o99
 XtWgX51Xq5M6Wmr32oTNMRtYR0hrg+1Rs2oZfLjjqYPnGMWJB+KGnLWlw6s5m9XWxa0k
 9tgTaCLDk0AYLR1qGMMf2O3I6gp7JYmufnVo06u4XjL0mFdySCGZGupcGmuiyKIQjvCh
 wjjtWHjXMwNtLPPA8Z1xlPSv47vd9VDFuQEFvn1arHVkv8rHQ6MWI9DdeASBjozUPDAG
 QHYsHrkIdvbvd0ve3Cm/IEwM9Z2WmzWzPtgDDjr6TE39qUMiFrE1IOQy2GxYSpiHdBex
 xOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076008; x=1778680808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AProBNNYKZYY1mqtdA3F7DQEDgEilBHZyhUb2mUtV+I=;
 b=GbQ49voTJozWuDV5BvxMoxefI+y7SfCoz8qx4hVdG1/KIIbGs5kvp5tn2p2K7GTYTF
 pqIlFXL4HlxHTRurl/u4qHmfok/7HHRIYIP7YXgCSXwKdaE9cZMi0aP8Zh+rqUizfGx2
 spI/aL63L7pEPL0hHC7QEGaoRYAhpOGA5lNqYvxSzPlKoooUcL3QOiasP5X0Y+MM5ZAR
 2sv2XRv8YtM7xBRSQC5kVzjHz0qtez4hLj9rITWw3QfIe3fNQaxmDqqd9XQftA2whfdB
 CrwkW0KwaSUbPSrjW8a4CSv7UeFUEj2Xv2zJYSxv1Uw41RcPsbathaTXmWDHggkxMQAn
 ALiA==
X-Gm-Message-State: AOJu0Yzoy2xVTTx5207qQGwJ0SF9mi9G+S1FS+JPUc19u3bOIuBrDlrn
 fMyETP0HAxG76JKmsFeTK4HGqZXWV2FwC784jqXMgnH27IslWwYHnzfMaSzTTLrX3I+4Ra+/zce
 9z7GhFqE=
X-Gm-Gg: AeBDievM2KFpvZJc7ZAm75Amxc6AjUvzo2kAomP8Q7FN3mK7XQBqo4UgpxNCTQ8kIxU
 cuC1Fu/wiU4lXtrCNngtDidNkhOoyRuKt9Drmb+Guu2rMh9mnvEAbcJLrlO0W+dzYSOGKu9Qf22
 b6XOIczlrGmvMOpt84MZV/59uBWkz0gyj++JOffZ2USQuHIgNiexYOry0SY2o5fI3Jitt2Ne20S
 Rbw/Cp6TSJjnXzfjIRgdHwBpUB2rbKu3lP9olI+ZGS4PIUziJoQvf0V+Eq3NMeROPE1ergsyZwZ
 W3eaOsWl3ADmk78MpO4MV2n/L6zF/y/Gg1zwGEUKb/lpf7Q6Iz+onYEzcfVRb6PljljbV+2HSbl
 hM/c5DTdfcCM6zREvJTaFDPlBPU2vzqvYNUvmKEB1X45+7s7GqgwgSDuDFFBT0VbhAWZbJyu7IO
 mW+WaslshqJYPgDuFV1WOZDaf0GP1eMy3PYZtuwytAC5nn4dIzo1SbMDx9BddmsqH5S80Itk0fq
 kLtJZqrSJ8=
X-Received: by 2002:a05:600c:3e8d:b0:48a:6268:18a9 with SMTP id
 5b1f17b1804b1-48e51f32797mr65250505e9.13.1778076007588; 
 Wed, 06 May 2026 07:00:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538c4ae1sm47165655e9.12.2026.05.06.07.00.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 037/110] target/mips: Pass MemOpIdx argument to Load/Store
 Multiple helpers
Date: Wed,  6 May 2026 15:54:09 +0200
Message-ID: <20260506135524.20617-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of using the MemOp content in the next commit,
pass it as MemOpIdx. Include the access size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417035734.32334-2-philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c             | 16 ++++++++++++----
 target/mips/tcg/micromips_translate.c.inc | 16 ++++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 10319bf03a6..ffe1895706a 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -212,8 +212,10 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
 
 void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -234,8 +236,10 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -256,8 +260,10 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 
 #if defined(TARGET_MIPS64)
 void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -278,8 +284,10 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 8fda7c8a214..4dca11b84b4 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -693,7 +693,8 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
                               int base, int16_t offset)
 {
     TCGv t0, t1;
-    TCGv_i32 t2;
+    MemOp mop = MO_UNALN;
+    MemOpIdx oi;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         gen_reserved_instruction(ctx);
@@ -705,22 +706,25 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
     gen_base_offset_addr(ctx, t0, base, offset);
 
     t1 = tcg_constant_tl(reglist);
-    t2 = tcg_constant_i32(ctx->mem_idx);
 
     save_cpu_state(ctx, 1);
     switch (opc) {
     case LWM32:
-        gen_helper_lwm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UL, ctx->mem_idx);
+        gen_helper_lwm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
     case SWM32:
-        gen_helper_swm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UL, ctx->mem_idx);
+        gen_helper_swm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
 #ifdef TARGET_MIPS64
     case LDM:
-        gen_helper_ldm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UQ, ctx->mem_idx);
+        gen_helper_ldm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
     case SDM:
-        gen_helper_sdm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UQ, ctx->mem_idx);
+        gen_helper_sdm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
 #endif
     }
-- 
2.53.0


