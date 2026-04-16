Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1914F8D77A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTuI-0003Hl-Mu; Thu, 16 Apr 2026 17:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTtq-00032m-39
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTto-0002Ay-64
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488d2079582so79588685e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373518; x=1776978318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbhPEwEniRNXF7YsagHJPcd02n2cHBagQEUfQphYiWw=;
 b=czbAiUMHwptZJcKwYr+nVWvIgrFNKt0GbCaxI+ixqoceL7sf6jeg3YRmxRlCVqiAiP
 wZDb3wuRscmhvPaQ0A14GbzxPqBIDfB2hmNf+y3KkXc9J5QsFmhD+X6h81ukdBe8qnpx
 MuNNMxLQ4RIMTHlRZW70x18qyl9B0gCvQ/rNo0h1tNTUAITT67zoHz6izxOG1iAl3G/r
 I5ua6+Khsj7GCZD/j36ttF9f8ZU8W+NKyPG+HIk8wq6wYyMJq28A7h8ARePiJ1gv9G8Y
 hkxWXB/aN+lfBKpWbmlV2QS3C9PQjRz9cLCYLTgp3RGJeZvQtfUIYwNVU44K+Zj1edck
 Ntsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373518; x=1776978318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbhPEwEniRNXF7YsagHJPcd02n2cHBagQEUfQphYiWw=;
 b=Byo8qaM96RSw3WfEv+cWcHjK2VNVIUjiRAQg3GtPTsk66rBIVKH0D6/sYAd1b7zwvZ
 l70s0Q+hZgkIkxfijvZhITNqN1P66ObAzSJOUD025HuzIDkGoBTrfKg+boyl8CQcUBWF
 X8rm3a+Fkxp5tq/jcysUDnXiLc7p+YsdwzEplykd+SPabr699BGFNGDep/d0zqRJoCAw
 vtW4URO3dkiNdienwltbOoTvWLiRrbQ8Hgq4Dw3X7TEdM5ljDwcSl1jMebPk8Lwydb6C
 EimHuDUKpMrIGQ4K4Vxwi6z+vChSf3IKEcYB9cUpa8OHe/wwIuYU73ijPMN+AybZ7bMG
 ol6g==
X-Gm-Message-State: AOJu0YzVzU8RjD0xdgkdGOMtMcXJSK0wu9BaVHonDAOg39hA/0vxwpjA
 1jw+WN37K9J0RY9fJcc0iuyHQs8wy0iPdiN9KRMxyolaj274E77JtGdi8QPR2UlHpDlERmphOb/
 6TffGGsw=
X-Gm-Gg: AeBDiets9ymZRuK/++lSBcoOVi26NOolVBwmfjggPPKQxT5Wd2RyD7f5iVaDKareW7E
 VNXFpfY9ZW8T8ohP7VD1cahF4MDJfeL5+nF+IBNS+ca3cfWcrEtO10ZoRJhcQOmdwLtD4LFXxtp
 53QtQibaB12H7Qnbincu5paDLgTIr/XaD/jLsr7ILYUBXuCX8hyce1ZvcVX8DOtufXzldI8frOh
 uOyYFMCSihjUv89ub9BexQ1pSbcdRplO24n4fN3EECjxwcRzST8N28Z5sRtOdev7G/QmrMdsOUF
 II3oudGzkv8rIwKlIupEBrbAP4+DkZAlWlpGW7uX5THzmS+iECMLzbiULdHi/Dby9iJkSCx37hO
 TGkxN7pu2BtUxkb8plZv42+npBQazWRWyW3euSDrsM2UhXMAoDQ9n3Aqam/4jpXuCiDL8noWN0X
 dCxSw6dg8YAeDNlp446xiObNezWz2sTIfAaQ818HRrswPqtOnhfQba8tgghea+72MaeTSOxDQ1N
 haFRSBpefQ=
X-Received: by 2002:a05:600c:8485:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-488fb78e02fmr2370345e9.27.1776373517615; 
 Thu, 16 Apr 2026 14:05:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5827145sm82763355e9.13.2026.04.16.14.05.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 14:05:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/4] target/mips: Pass MemOpIdx argument to Load/Store
 Multiple helpers
Date: Thu, 16 Apr 2026 23:05:05 +0200
Message-ID: <20260416210508.30686-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416210508.30686-1-philmd@linaro.org>
References: <20260416210508.30686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 target/mips/tcg/ldst_helper.c             | 16 ++++++++++++----
 target/mips/tcg/micromips_translate.c.inc | 16 ++++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 4ebf72d610e..7be2cad89d6 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -224,8 +224,10 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
 
 void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -246,8 +248,10 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -268,8 +272,10 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 
 #if defined(TARGET_MIPS64)
 void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -290,8 +296,10 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
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


