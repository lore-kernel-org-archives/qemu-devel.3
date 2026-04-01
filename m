Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F5B10F6FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7wpi-000340-5D; Wed, 01 Apr 2026 10:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wor-0002q3-91
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wom-0000je-Ht
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488895ad947so3311605e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054714; x=1775659514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgOwgAiAG7tpg0g7lVw/3Db4kPl2tRIKEA+Xx9JPdeA=;
 b=Xi91Q6jWWUB2E3QAWYf2HGrZs5jJU98/7SDCyZ/zZy8OZhKjBIst3UajtYx+WT0uwu
 74Pfvobgvse0hlgTeUPqdK5cc2Iogfg7o4XdMPH69wpdpfdkUdFApVhWprA0/9fSZnoS
 B9x4PoBdRyl69yfnGRo+SO4F2OQg8i1pcL263QxsS78X1M+Tl34bNEsNOt+3JtHC1/B3
 qehIm/YLz+0eMihOZzsgqF8i8xvGtjKHIQ3U3R6GYuamHxsz8oKYOZOyYDVJdSQiO9uJ
 eQfoVrK84N8p31u10IhzUD0YP4m5UZSiIDxuqtMYyMlnFDO5mI+Rm8UbBEU5k9KqWfsq
 EqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054714; x=1775659514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IgOwgAiAG7tpg0g7lVw/3Db4kPl2tRIKEA+Xx9JPdeA=;
 b=k+07WNsyXf78fn4MsC1EWqWst3NXSk1cX1nNrWukh+oeRnuuMcfDf5iLSUoz9nzL1U
 OwMgW/RS98ORCenYX1gRwkF4WjPEb0H8uSpMI/XgP1Z5CHGGhaQ6PQIQozii1X1rdd2o
 rY9CTVCzQf7wddFsF5d5vYenM5zXRwb9QAM0hq8QyGHwUehr4ukTU4n35irftl5ITVvh
 uqs/GKSQkgeUkiC87g71+YNHj3aTsCWMI5D42yjWnsIbSpvnMPNlf5cav3lsmexdxP+a
 vkur6wVZlAHQ7dR/Zcfr4Z1YmmnnAc9FaYJ0Ku+gHAiqOn2+CA55q52ucICd1cP+/3JB
 dHNA==
X-Gm-Message-State: AOJu0YzSByBiOxMV3i2VjmKSNA4Cphval0DCFYN3DoXMW9Be3GiNJl+b
 m9B2ZuXaBgFMdDkiQCyBcEFGvIg4NwzRBF9cMmxk/esoKEyLbKAFzQUAoc3K6+u0BjdGShRH7Zt
 Th3JhrnQ=
X-Gm-Gg: ATEYQzw6gEH5LeC1MB1Zon4LYM0N6HzZ5dGUgea1Y24btYTqABOskoNbbBCZN0avoFw
 9JwIqGHtjrIuYSOm4tLn5nwqrW2lZx09VQoIq4ikYrzjc+MNjdiYh54jmT5ynS6W9SNHCz58L9s
 406I0yopx/ABnB4P92zqnv1TwkRmrykWxPOHHlP2rL63owFUPAesFygnaFauROzyS3Nocxroeg/
 gIF02qCE9sa7d2xNRGAYP7d6TJjIL4lSXv8YrHPve34vwg6jWRStBwm9aOgTzcuDEMpJCnY5IHb
 z4vTeh3yUWVV9KhCpp48is6+r0G4VqtGKRLyF8MzbF0O7BP5P5uTYoQbyDreh0Iw7BWnX64ZNms
 6M9fHoOXaV0OBrWi8wJgBN35XPQxCSzD6ky9Yr04YQkZnhs5Z0u2zlPVye69GrmtHgs51GGmdS0
 SU7w1qHomn2UupT+PcJgMQZ17JiRRcXlJrnYOkHy8H/luPBSkv2EC/eCS2p4ISD3jp9uHTiGxw
X-Received: by 2002:a05:600c:34d0:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-4888355e6d5mr73087245e9.2.1775054712440; 
 Wed, 01 Apr 2026 07:45:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a62616dsm4822575e9.3.2026.04.01.07.45.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 07:45:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH-for-11.1 1/2] target/mips: Expand TCGv type as 32-bit for
 XBurst MXU
Date: Wed,  1 Apr 2026 16:45:01 +0200
Message-ID: <20260401144503.80510-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401144503.80510-1-philmd@linaro.org>
References: <20260401144503.80510-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The MXU extension is only built as 32-bit, so TCGv expands
to TCGv_i32. Use the latter which is more explicit.

In gen_mxu_s32madd_sub() directly expand:

 - tcg_gen_ext[u]_tl_i64 -> tcg_gen_ext[u]_i32_i64
 - tcg_gen_concat_tl_i64 -> tcg_gen_concat_i32_i64

the rest being mechanical changes.

Cc: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 1954 +++++++++++++++----------------
 1 file changed, 977 insertions(+), 977 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 35ebb0397da..7961b073144 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -606,8 +606,8 @@ enum {
 #define MXU_OPTN3_PTN7  7
 
 /* MXU registers */
-static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
-static TCGv mxu_CR;
+static TCGv_i32 mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+static TCGv_i32 mxu_CR;
 
 static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
     "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
@@ -628,42 +628,42 @@ void mxu_translate_init(void)
 }
 
 /* MXU General purpose registers moves. */
-static inline void gen_load_mxu_gpr(TCGv t, unsigned int reg)
+static inline void gen_load_mxu_gpr(TCGv_i32 t, unsigned int reg)
 {
     if (reg == 0) {
-        tcg_gen_movi_tl(t, 0);
+        tcg_gen_movi_i32(t, 0);
     } else if (reg <= 15) {
-        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
+        tcg_gen_mov_i32(t, mxu_gpr[reg - 1]);
     }
 }
 
-static inline void gen_store_mxu_gpr(TCGv t, unsigned int reg)
+static inline void gen_store_mxu_gpr(TCGv_i32 t, unsigned int reg)
 {
     if (reg > 0 && reg <= 15) {
-        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
+        tcg_gen_mov_i32(mxu_gpr[reg - 1], t);
     }
 }
 
-static inline void gen_extract_mxu_gpr(TCGv t, unsigned int reg,
+static inline void gen_extract_mxu_gpr(TCGv_i32 t, unsigned int reg,
                                        unsigned int ofs, unsigned int len)
 {
     if (reg == 0) {
-        tcg_gen_movi_tl(t, 0);
+        tcg_gen_movi_i32(t, 0);
     } else if (reg <= 15) {
-        tcg_gen_extract_tl(t, mxu_gpr[reg - 1], ofs, len);
+        tcg_gen_extract_i32(t, mxu_gpr[reg - 1], ofs, len);
     }
 }
 
 /* MXU control register moves. */
-static inline void gen_load_mxu_cr(TCGv t)
+static inline void gen_load_mxu_cr(TCGv_i32 t)
 {
-    tcg_gen_mov_tl(t, mxu_CR);
+    tcg_gen_mov_i32(t, mxu_CR);
 }
 
-static inline void gen_store_mxu_cr(TCGv t)
+static inline void gen_store_mxu_cr(TCGv_i32 t)
 {
     /* TODO: Add handling of RW rules for MXU_CR. */
-    tcg_gen_mov_tl(mxu_CR, t);
+    tcg_gen_mov_i32(mxu_CR, t);
 }
 
 /*
@@ -671,10 +671,10 @@ static inline void gen_store_mxu_cr(TCGv t)
  */
 static void gen_mxu_s32i2m(DisasContext *ctx)
 {
-    TCGv t0;
+    TCGv_i32 t0;
     uint32_t XRa, Rb;
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 5);
     Rb = extract32(ctx->opcode, 16, 5);
@@ -692,10 +692,10 @@ static void gen_mxu_s32i2m(DisasContext *ctx)
  */
 static void gen_mxu_s32m2i(DisasContext *ctx)
 {
-    TCGv t0;
+    TCGv_i32 t0;
     uint32_t XRa, Rb;
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 5);
     Rb = extract32(ctx->opcode, 16, 5);
@@ -717,11 +717,11 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
  */
 static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, s8, optn3;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     s8 = extract32(ctx->opcode, 10, 8);
@@ -729,7 +729,7 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
     Rb = extract32(ctx->opcode, 21, 5);
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    tcg_gen_addi_i32(t0, t0, (int8_t)s8);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
     }
@@ -737,52 +737,52 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
     switch (optn3) {
     /* XRa[7:0] = tmp8 */
     case MXU_OPTN3_PTN0:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
+        tcg_gen_deposit_i32(t0, t0, t1, 0, 8);
         break;
     /* XRa[15:8] = tmp8 */
     case MXU_OPTN3_PTN1:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
+        tcg_gen_deposit_i32(t0, t0, t1, 8, 8);
         break;
     /* XRa[23:16] = tmp8 */
     case MXU_OPTN3_PTN2:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
+        tcg_gen_deposit_i32(t0, t0, t1, 16, 8);
         break;
     /* XRa[31:24] = tmp8 */
     case MXU_OPTN3_PTN3:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
+        tcg_gen_deposit_i32(t0, t0, t1, 24, 8);
         break;
     /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
     case MXU_OPTN3_PTN4:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
-        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
         break;
     /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
     case MXU_OPTN3_PTN5:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
-        tcg_gen_shli_tl(t1, t1, 8);
-        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_shli_i32(t1, t1, 8);
+        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
         break;
     /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
     case MXU_OPTN3_PTN6:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
-        tcg_gen_mov_tl(t0, t1);
-        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
-        tcg_gen_shli_tl(t1, t1, 16);
-        tcg_gen_or_tl(t0, t0, t1);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_SB);
+        tcg_gen_mov_i32(t0, t1);
+        tcg_gen_andi_i32(t0, t0, 0xFF00FFFF);
+        tcg_gen_shli_i32(t1, t1, 16);
+        tcg_gen_or_i32(t0, t0, t1);
         break;
     /* XRa = {tmp8, tmp8, tmp8, tmp8} */
     case MXU_OPTN3_PTN7:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
-        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
-        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_i32(t1, t1, t1, 8, 8);
+        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
         break;
     }
 
@@ -797,11 +797,11 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
  */
 static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, s8, optn3;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     s8 = extract32(ctx->opcode, 10, 8);
@@ -814,7 +814,7 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
     }
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    tcg_gen_addi_i32(t0, t0, (int8_t)s8);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
     }
@@ -823,23 +823,23 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
     switch (optn3) {
     /* XRa[7:0] => tmp8 */
     case MXU_OPTN3_PTN0:
-        tcg_gen_extract_tl(t1, t1, 0, 8);
+        tcg_gen_extract_i32(t1, t1, 0, 8);
         break;
     /* XRa[15:8] => tmp8 */
     case MXU_OPTN3_PTN1:
-        tcg_gen_extract_tl(t1, t1, 8, 8);
+        tcg_gen_extract_i32(t1, t1, 8, 8);
         break;
     /* XRa[23:16] => tmp8 */
     case MXU_OPTN3_PTN2:
-        tcg_gen_extract_tl(t1, t1, 16, 8);
+        tcg_gen_extract_i32(t1, t1, 16, 8);
         break;
     /* XRa[31:24] => tmp8 */
     case MXU_OPTN3_PTN3:
-        tcg_gen_extract_tl(t1, t1, 24, 8);
+        tcg_gen_extract_i32(t1, t1, 24, 8);
         break;
     }
 
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UB);
+    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx, MO_UB);
 }
 
 /*
@@ -850,12 +850,12 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
  */
 static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, optn2;
     int32_t s10;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa   = extract32(ctx->opcode,   6, 4);
     s10   = sextract32(ctx->opcode, 10, 9) * 2;
@@ -863,7 +863,7 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
     Rb    = extract32(ctx->opcode,  21, 5);
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_addi_tl(t0, t0, s10);
+    tcg_gen_addi_i32(t0, t0, s10);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
     }
@@ -871,25 +871,25 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
     switch (optn2) {
     /* XRa[15:0] = tmp16 */
     case MXU_OPTN2_PTN0:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 0, 16);
+        tcg_gen_deposit_i32(t0, t0, t1, 0, 16);
         break;
     /* XRa[31:16] = tmp16 */
     case MXU_OPTN2_PTN1:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
         gen_load_mxu_gpr(t0, XRa);
-        tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
+        tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
         break;
     /* XRa = sign_extend(tmp16) */
     case MXU_OPTN2_PTN2:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SW);
+        tcg_gen_qemu_ld_i32(t0, t0, ctx->mem_idx, MO_SW);
         break;
     /* XRa = {tmp16, tmp16} */
     case MXU_OPTN2_PTN3:
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UW);
-        tcg_gen_deposit_tl(t0, t1, t1,  0, 16);
-        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, MO_UW);
+        tcg_gen_deposit_i32(t0, t1, t1,  0, 16);
+        tcg_gen_deposit_i32(t0, t1, t1, 16, 16);
         break;
     }
 
@@ -904,12 +904,12 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
  */
 static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, optn2;
     int32_t s10;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     s10 = sextract32(ctx->opcode, 10, 9) * 2;
@@ -922,7 +922,7 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
     }
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_addi_tl(t0, t0, s10);
+    tcg_gen_addi_i32(t0, t0, s10);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
     }
@@ -931,15 +931,15 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
     switch (optn2) {
     /* XRa[15:0] => tmp16 */
     case MXU_OPTN2_PTN0:
-        tcg_gen_extract_tl(t1, t1, 0, 16);
+        tcg_gen_extract_i32(t1, t1, 0, 16);
         break;
     /* XRa[31:16] => tmp16 */
     case MXU_OPTN2_PTN1:
-        tcg_gen_extract_tl(t1, t1, 16, 16);
+        tcg_gen_extract_i32(t1, t1, 16, 16);
         break;
     }
 
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_UW);
+    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx, MO_UW);
 }
 
 /*
@@ -953,11 +953,11 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
  */
 static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, XRd, rs, rt;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode,  6, 4);
     XRd = extract32(ctx->opcode, 10, 4);
@@ -965,20 +965,20 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
     rt  = extract32(ctx->opcode, 21, 5);
 
     if (unlikely(rs == 0 || rt == 0)) {
-        tcg_gen_movi_tl(t0, 0);
-        tcg_gen_movi_tl(t1, 0);
+        tcg_gen_movi_i32(t0, 0);
+        tcg_gen_movi_i32(t1, 0);
     } else {
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
 
         if (mulu) {
-            tcg_gen_mulu2_tl(t0, t1, t0, t1);
+            tcg_gen_mulu2_i32(t0, t1, t0, t1);
         } else {
-            tcg_gen_muls2_tl(t0, t1, t0, t1);
+            tcg_gen_muls2_i32(t0, t1, t0, t1);
         }
     }
-    tcg_gen_mov_tl(cpu_HI[0], t1);
-    tcg_gen_mov_tl(cpu_LO[0], t0);
+    tcg_gen_mov_i32(cpu_HI[0], t1);
+    tcg_gen_mov_i32(cpu_LO[0], t0);
     gen_store_mxu_gpr(t1, XRa);
     gen_store_mxu_gpr(t0, XRd);
 }
@@ -993,13 +993,13 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
 static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
                            bool packed_result)
 {
-    TCGv t0, t1, t2, t3;
+    TCGv_i32 t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1014,64 +1014,64 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
      */
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1, 0, 16);
-    tcg_gen_sextract_tl(t1, t1, 16, 16);
+    tcg_gen_sextract_i32(t0, t1, 0, 16);
+    tcg_gen_sextract_i32(t1, t1, 16, 16);
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3, 0, 16);
-    tcg_gen_sextract_tl(t3, t3, 16, 16);
+    tcg_gen_sextract_i32(t2, t3, 0, 16);
+    tcg_gen_sextract_i32(t3, t3, 16, 16);
 
     switch (optn2) {
     case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     }
     if (fractional) {
         TCGLabel *l_done = gen_new_label();
-        TCGv rounding = tcg_temp_new();
+        TCGv_i32 rounding = tcg_temp_new_i32();
 
-        tcg_gen_shli_tl(t3, t3, 1);
-        tcg_gen_shli_tl(t2, t2, 1);
-        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
+        tcg_gen_shli_i32(t3, t3, 1);
+        tcg_gen_shli_i32(t2, t2, 1);
+        tcg_gen_andi_i32(rounding, mxu_CR, 0x2);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, rounding, 0, l_done);
         if (packed_result) {
             TCGLabel *l_apply_bias_l = gen_new_label();
             TCGLabel *l_apply_bias_r = gen_new_label();
             TCGLabel *l_half_done = gen_new_label();
-            TCGv bias = tcg_temp_new();
+            TCGv_i32 bias = tcg_temp_new_i32();
 
             /*
              * D16MULF supports unbiased rounding aka "bankers rounding",
              * "round to even", "convergent rounding"
              */
-            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
-            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
-            tcg_gen_andi_tl(t0, t3, 0x1ffff);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
+            tcg_gen_andi_i32(bias, mxu_CR, 0x4);
+            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_l);
+            tcg_gen_andi_i32(t0, t3, 0x1ffff);
+            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_half_done);
             gen_set_label(l_apply_bias_l);
-            tcg_gen_addi_tl(t3, t3, 0x8000);
+            tcg_gen_addi_i32(t3, t3, 0x8000);
             gen_set_label(l_half_done);
-            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
-            tcg_gen_andi_tl(t0, t2, 0x1ffff);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
+            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_r);
+            tcg_gen_andi_i32(t0, t2, 0x1ffff);
+            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_done);
             gen_set_label(l_apply_bias_r);
-            tcg_gen_addi_tl(t2, t2, 0x8000);
+            tcg_gen_addi_i32(t2, t2, 0x8000);
         } else {
             /* D16MULE doesn't support unbiased rounding */
-            tcg_gen_addi_tl(t3, t3, 0x8000);
-            tcg_gen_addi_tl(t2, t2, 0x8000);
+            tcg_gen_addi_i32(t3, t3, 0x8000);
+            tcg_gen_addi_i32(t2, t2, 0x8000);
         }
         gen_set_label(l_done);
     }
@@ -1079,9 +1079,9 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
         gen_store_mxu_gpr(t3, XRa);
         gen_store_mxu_gpr(t2, XRd);
     } else {
-        tcg_gen_andi_tl(t3, t3, 0xffff0000);
-        tcg_gen_shri_tl(t2, t2, 16);
-        tcg_gen_or_tl(t3, t3, t2);
+        tcg_gen_andi_i32(t3, t3, 0xffff0000);
+        tcg_gen_shri_i32(t2, t2, 16);
+        tcg_gen_or_i32(t3, t3, t2);
         gen_store_mxu_gpr(t3, XRa);
     }
 }
@@ -1097,13 +1097,13 @@ static void gen_mxu_d16mul(DisasContext *ctx, bool fractional,
 static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
                            bool packed_result)
 {
-    TCGv t0, t1, t2, t3;
+    TCGv_i32 t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1113,90 +1113,90 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
     aptn2 = extract32(ctx->opcode, 24, 2);
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1, 0, 16);
-    tcg_gen_sextract_tl(t1, t1, 16, 16);
+    tcg_gen_sextract_i32(t0, t1, 0, 16);
+    tcg_gen_sextract_i32(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3, 0, 16);
-    tcg_gen_sextract_tl(t3, t3, 16, 16);
+    tcg_gen_sextract_i32(t2, t3, 0, 16);
+    tcg_gen_sextract_i32(t3, t3, 16, 16);
 
     switch (optn2) {
     case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     }
 
     if (fractional) {
-        tcg_gen_shli_tl(t3, t3, 1);
-        tcg_gen_shli_tl(t2, t2, 1);
+        tcg_gen_shli_i32(t3, t3, 1);
+        tcg_gen_shli_i32(t2, t2, 1);
     }
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t1, XRd);
 
     switch (aptn2) {
     case MXU_APTN2_AA:
-        tcg_gen_add_tl(t3, t0, t3);
-        tcg_gen_add_tl(t2, t1, t2);
+        tcg_gen_add_i32(t3, t0, t3);
+        tcg_gen_add_i32(t2, t1, t2);
         break;
     case MXU_APTN2_AS:
-        tcg_gen_add_tl(t3, t0, t3);
-        tcg_gen_sub_tl(t2, t1, t2);
+        tcg_gen_add_i32(t3, t0, t3);
+        tcg_gen_sub_i32(t2, t1, t2);
         break;
     case MXU_APTN2_SA:
-        tcg_gen_sub_tl(t3, t0, t3);
-        tcg_gen_add_tl(t2, t1, t2);
+        tcg_gen_sub_i32(t3, t0, t3);
+        tcg_gen_add_i32(t2, t1, t2);
         break;
     case MXU_APTN2_SS:
-        tcg_gen_sub_tl(t3, t0, t3);
-        tcg_gen_sub_tl(t2, t1, t2);
+        tcg_gen_sub_i32(t3, t0, t3);
+        tcg_gen_sub_i32(t2, t1, t2);
         break;
     }
 
     if (fractional) {
         TCGLabel *l_done = gen_new_label();
-        TCGv rounding = tcg_temp_new();
+        TCGv_i32 rounding = tcg_temp_new_i32();
 
-        tcg_gen_andi_tl(rounding, mxu_CR, 0x2);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, rounding, 0, l_done);
+        tcg_gen_andi_i32(rounding, mxu_CR, 0x2);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, rounding, 0, l_done);
         if (packed_result) {
             TCGLabel *l_apply_bias_l = gen_new_label();
             TCGLabel *l_apply_bias_r = gen_new_label();
             TCGLabel *l_half_done = gen_new_label();
-            TCGv bias = tcg_temp_new();
+            TCGv_i32 bias = tcg_temp_new_i32();
 
             /*
              * D16MACF supports unbiased rounding aka "bankers rounding",
              * "round to even", "convergent rounding"
              */
-            tcg_gen_andi_tl(bias, mxu_CR, 0x4);
-            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_l);
-            tcg_gen_andi_tl(t0, t3, 0x1ffff);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_half_done);
+            tcg_gen_andi_i32(bias, mxu_CR, 0x4);
+            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_l);
+            tcg_gen_andi_i32(t0, t3, 0x1ffff);
+            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_half_done);
             gen_set_label(l_apply_bias_l);
-            tcg_gen_addi_tl(t3, t3, 0x8000);
+            tcg_gen_addi_i32(t3, t3, 0x8000);
             gen_set_label(l_half_done);
-            tcg_gen_brcondi_tl(TCG_COND_NE, bias, 0, l_apply_bias_r);
-            tcg_gen_andi_tl(t0, t2, 0x1ffff);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0x8000, l_done);
+            tcg_gen_brcondi_i32(TCG_COND_NE, bias, 0, l_apply_bias_r);
+            tcg_gen_andi_i32(t0, t2, 0x1ffff);
+            tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0x8000, l_done);
             gen_set_label(l_apply_bias_r);
-            tcg_gen_addi_tl(t2, t2, 0x8000);
+            tcg_gen_addi_i32(t2, t2, 0x8000);
         } else {
             /* D16MACE doesn't support unbiased rounding */
-            tcg_gen_addi_tl(t3, t3, 0x8000);
-            tcg_gen_addi_tl(t2, t2, 0x8000);
+            tcg_gen_addi_i32(t3, t3, 0x8000);
+            tcg_gen_addi_i32(t2, t2, 0x8000);
         }
         gen_set_label(l_done);
     }
@@ -1205,9 +1205,9 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
         gen_store_mxu_gpr(t3, XRa);
         gen_store_mxu_gpr(t2, XRd);
     } else {
-        tcg_gen_andi_tl(t3, t3, 0xffff0000);
-        tcg_gen_shri_tl(t2, t2, 16);
-        tcg_gen_or_tl(t3, t3, t2);
+        tcg_gen_andi_i32(t3, t3, 0xffff0000);
+        tcg_gen_shri_i32(t2, t2, 16);
+        tcg_gen_or_i32(t3, t3, t2);
         gen_store_mxu_gpr(t3, XRa);
     }
 }
@@ -1218,13 +1218,13 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
  */
 static void gen_mxu_d16madl(DisasContext *ctx)
 {
-    TCGv t0, t1, t2, t3;
+    TCGv_i32 t0, t1, t2, t3;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1234,60 +1234,60 @@ static void gen_mxu_d16madl(DisasContext *ctx)
     aptn2 = extract32(ctx->opcode, 24, 2);
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_sextract_tl(t0, t1,  0, 16);
-    tcg_gen_sextract_tl(t1, t1, 16, 16);
+    tcg_gen_sextract_i32(t0, t1,  0, 16);
+    tcg_gen_sextract_i32(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_sextract_tl(t2, t3,  0, 16);
-    tcg_gen_sextract_tl(t3, t3, 16, 16);
+    tcg_gen_sextract_i32(t2, t3,  0, 16);
+    tcg_gen_sextract_i32(t3, t3, 16, 16);
 
     switch (optn2) {
     case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t0, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t0, t2);
         break;
     case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t1, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t1, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
-        tcg_gen_mul_tl(t3, t0, t3);
-        tcg_gen_mul_tl(t2, t1, t2);
+        tcg_gen_mul_i32(t3, t0, t3);
+        tcg_gen_mul_i32(t2, t1, t2);
         break;
     }
-    tcg_gen_extract_tl(t2, t2, 0, 16);
-    tcg_gen_extract_tl(t3, t3, 0, 16);
+    tcg_gen_extract_i32(t2, t2, 0, 16);
+    tcg_gen_extract_i32(t3, t3, 0, 16);
 
     gen_load_mxu_gpr(t1, XRa);
-    tcg_gen_extract_tl(t0, t1,  0, 16);
-    tcg_gen_extract_tl(t1, t1, 16, 16);
+    tcg_gen_extract_i32(t0, t1,  0, 16);
+    tcg_gen_extract_i32(t1, t1, 16, 16);
 
     switch (aptn2) {
     case MXU_APTN2_AA:
-        tcg_gen_add_tl(t3, t1, t3);
-        tcg_gen_add_tl(t2, t0, t2);
+        tcg_gen_add_i32(t3, t1, t3);
+        tcg_gen_add_i32(t2, t0, t2);
         break;
     case MXU_APTN2_AS:
-        tcg_gen_add_tl(t3, t1, t3);
-        tcg_gen_sub_tl(t2, t0, t2);
+        tcg_gen_add_i32(t3, t1, t3);
+        tcg_gen_sub_i32(t2, t0, t2);
         break;
     case MXU_APTN2_SA:
-        tcg_gen_sub_tl(t3, t1, t3);
-        tcg_gen_add_tl(t2, t0, t2);
+        tcg_gen_sub_i32(t3, t1, t3);
+        tcg_gen_add_i32(t2, t0, t2);
         break;
     case MXU_APTN2_SS:
-        tcg_gen_sub_tl(t3, t1, t3);
-        tcg_gen_sub_tl(t2, t0, t2);
+        tcg_gen_sub_i32(t3, t1, t3);
+        tcg_gen_sub_i32(t2, t0, t2);
         break;
     }
 
-    tcg_gen_andi_tl(t2, t2, 0xffff);
-    tcg_gen_shli_tl(t3, t3, 16);
-    tcg_gen_or_tl(mxu_gpr[XRd - 1], t3, t2);
+    tcg_gen_andi_i32(t2, t2, 0xffff);
+    tcg_gen_shli_i32(t3, t3, 16);
+    tcg_gen_or_i32(mxu_gpr[XRd - 1], t3, t2);
 }
 
 /*
@@ -1296,11 +1296,11 @@ static void gen_mxu_d16madl(DisasContext *ctx)
  */
 static void gen_mxu_s16mad(DisasContext *ctx)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn1, pad;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1319,32 +1319,32 @@ static void gen_mxu_s16mad(DisasContext *ctx)
 
     switch (optn2) {
     case MXU_OPTN2_WW: /* XRB.H*XRC.H */
-        tcg_gen_sextract_tl(t0, t0, 16, 16);
-        tcg_gen_sextract_tl(t1, t1, 16, 16);
+        tcg_gen_sextract_i32(t0, t0, 16, 16);
+        tcg_gen_sextract_i32(t1, t1, 16, 16);
         break;
     case MXU_OPTN2_LW: /* XRB.L*XRC.L */
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
-        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        tcg_gen_sextract_i32(t0, t0,  0, 16);
+        tcg_gen_sextract_i32(t1, t1,  0, 16);
         break;
     case MXU_OPTN2_HW: /* XRB.H*XRC.L */
-        tcg_gen_sextract_tl(t0, t0, 16, 16);
-        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        tcg_gen_sextract_i32(t0, t0, 16, 16);
+        tcg_gen_sextract_i32(t1, t1,  0, 16);
         break;
     case MXU_OPTN2_XW: /* XRB.L*XRC.H */
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
-        tcg_gen_sextract_tl(t1, t1, 16, 16);
+        tcg_gen_sextract_i32(t0, t0,  0, 16);
+        tcg_gen_sextract_i32(t1, t1, 16, 16);
         break;
     }
-    tcg_gen_mul_tl(t0, t0, t1);
+    tcg_gen_mul_i32(t0, t0, t1);
 
     gen_load_mxu_gpr(t1, XRa);
 
     switch (aptn1) {
     case MXU_APTN1_A:
-        tcg_gen_add_tl(t1, t1, t0);
+        tcg_gen_add_i32(t1, t1, t0);
         break;
     case MXU_APTN1_S:
-        tcg_gen_sub_tl(t1, t1, t0);
+        tcg_gen_sub_i32(t1, t1, t0);
         break;
     }
 
@@ -1361,17 +1361,17 @@ static void gen_mxu_s16mad(DisasContext *ctx)
  */
 static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
 {
-    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    TCGv_i32 t0, t1, t2, t3, t4, t5, t6, t7;
     uint32_t XRa, XRb, XRc, XRd, aptn2;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
-    t4 = tcg_temp_new();
-    t5 = tcg_temp_new();
-    t6 = tcg_temp_new();
-    t7 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
+    t4 = tcg_temp_new_i32();
+    t5 = tcg_temp_new_i32();
+    t6 = tcg_temp_new_i32();
+    t7 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1384,53 +1384,53 @@ static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
 
     if (su) {
         /* Q8MULSU / Q8MACSU */
-        tcg_gen_sextract_tl(t0, t3,  0, 8);
-        tcg_gen_sextract_tl(t1, t3,  8, 8);
-        tcg_gen_sextract_tl(t2, t3, 16, 8);
-        tcg_gen_sextract_tl(t3, t3, 24, 8);
+        tcg_gen_sextract_i32(t0, t3,  0, 8);
+        tcg_gen_sextract_i32(t1, t3,  8, 8);
+        tcg_gen_sextract_i32(t2, t3, 16, 8);
+        tcg_gen_sextract_i32(t3, t3, 24, 8);
     } else {
         /* Q8MUL / Q8MAC */
-        tcg_gen_extract_tl(t0, t3,  0, 8);
-        tcg_gen_extract_tl(t1, t3,  8, 8);
-        tcg_gen_extract_tl(t2, t3, 16, 8);
-        tcg_gen_extract_tl(t3, t3, 24, 8);
+        tcg_gen_extract_i32(t0, t3,  0, 8);
+        tcg_gen_extract_i32(t1, t3,  8, 8);
+        tcg_gen_extract_i32(t2, t3, 16, 8);
+        tcg_gen_extract_i32(t3, t3, 24, 8);
     }
 
-    tcg_gen_extract_tl(t4, t7,  0, 8);
-    tcg_gen_extract_tl(t5, t7,  8, 8);
-    tcg_gen_extract_tl(t6, t7, 16, 8);
-    tcg_gen_extract_tl(t7, t7, 24, 8);
+    tcg_gen_extract_i32(t4, t7,  0, 8);
+    tcg_gen_extract_i32(t5, t7,  8, 8);
+    tcg_gen_extract_i32(t6, t7, 16, 8);
+    tcg_gen_extract_i32(t7, t7, 24, 8);
 
-    tcg_gen_mul_tl(t0, t0, t4);
-    tcg_gen_mul_tl(t1, t1, t5);
-    tcg_gen_mul_tl(t2, t2, t6);
-    tcg_gen_mul_tl(t3, t3, t7);
+    tcg_gen_mul_i32(t0, t0, t4);
+    tcg_gen_mul_i32(t1, t1, t5);
+    tcg_gen_mul_i32(t2, t2, t6);
+    tcg_gen_mul_i32(t3, t3, t7);
 
     if (mac) {
         gen_load_mxu_gpr(t4, XRd);
         gen_load_mxu_gpr(t5, XRa);
-        tcg_gen_extract_tl(t6, t4,  0, 16);
-        tcg_gen_extract_tl(t7, t4, 16, 16);
+        tcg_gen_extract_i32(t6, t4,  0, 16);
+        tcg_gen_extract_i32(t7, t4, 16, 16);
         if (aptn2 & 1) {
-            tcg_gen_sub_tl(t0, t6, t0);
-            tcg_gen_sub_tl(t1, t7, t1);
+            tcg_gen_sub_i32(t0, t6, t0);
+            tcg_gen_sub_i32(t1, t7, t1);
         } else {
-            tcg_gen_add_tl(t0, t6, t0);
-            tcg_gen_add_tl(t1, t7, t1);
+            tcg_gen_add_i32(t0, t6, t0);
+            tcg_gen_add_i32(t1, t7, t1);
         }
-        tcg_gen_extract_tl(t6, t5,  0, 16);
-        tcg_gen_extract_tl(t7, t5, 16, 16);
+        tcg_gen_extract_i32(t6, t5,  0, 16);
+        tcg_gen_extract_i32(t7, t5, 16, 16);
         if (aptn2 & 2) {
-            tcg_gen_sub_tl(t2, t6, t2);
-            tcg_gen_sub_tl(t3, t7, t3);
+            tcg_gen_sub_i32(t2, t6, t2);
+            tcg_gen_sub_i32(t3, t7, t3);
         } else {
-            tcg_gen_add_tl(t2, t6, t2);
-            tcg_gen_add_tl(t3, t7, t3);
+            tcg_gen_add_i32(t2, t6, t2);
+            tcg_gen_add_i32(t3, t7, t3);
         }
     }
 
-    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
-    tcg_gen_deposit_tl(t1, t2, t3, 16, 16);
+    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_i32(t1, t2, t3, 16, 16);
 
     gen_store_mxu_gpr(t0, XRd);
     gen_store_mxu_gpr(t1, XRa);
@@ -1443,17 +1443,17 @@ static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
  */
 static void gen_mxu_q8madl(DisasContext *ctx)
 {
-    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    TCGv_i32 t0, t1, t2, t3, t4, t5, t6, t7;
     uint32_t XRa, XRb, XRc, XRd, aptn2;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
-    t4 = tcg_temp_new();
-    t5 = tcg_temp_new();
-    t6 = tcg_temp_new();
-    t7 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
+    t4 = tcg_temp_new_i32();
+    t5 = tcg_temp_new_i32();
+    t6 = tcg_temp_new_i32();
+    t7 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
@@ -1464,45 +1464,45 @@ static void gen_mxu_q8madl(DisasContext *ctx)
     gen_load_mxu_gpr(t3, XRb);
     gen_load_mxu_gpr(t7, XRc);
 
-    tcg_gen_extract_tl(t0, t3,  0, 8);
-    tcg_gen_extract_tl(t1, t3,  8, 8);
-    tcg_gen_extract_tl(t2, t3, 16, 8);
-    tcg_gen_extract_tl(t3, t3, 24, 8);
+    tcg_gen_extract_i32(t0, t3,  0, 8);
+    tcg_gen_extract_i32(t1, t3,  8, 8);
+    tcg_gen_extract_i32(t2, t3, 16, 8);
+    tcg_gen_extract_i32(t3, t3, 24, 8);
 
-    tcg_gen_extract_tl(t4, t7,  0, 8);
-    tcg_gen_extract_tl(t5, t7,  8, 8);
-    tcg_gen_extract_tl(t6, t7, 16, 8);
-    tcg_gen_extract_tl(t7, t7, 24, 8);
+    tcg_gen_extract_i32(t4, t7,  0, 8);
+    tcg_gen_extract_i32(t5, t7,  8, 8);
+    tcg_gen_extract_i32(t6, t7, 16, 8);
+    tcg_gen_extract_i32(t7, t7, 24, 8);
 
-    tcg_gen_mul_tl(t0, t0, t4);
-    tcg_gen_mul_tl(t1, t1, t5);
-    tcg_gen_mul_tl(t2, t2, t6);
-    tcg_gen_mul_tl(t3, t3, t7);
+    tcg_gen_mul_i32(t0, t0, t4);
+    tcg_gen_mul_i32(t1, t1, t5);
+    tcg_gen_mul_i32(t2, t2, t6);
+    tcg_gen_mul_i32(t3, t3, t7);
 
     gen_load_mxu_gpr(t4, XRa);
-    tcg_gen_extract_tl(t6, t4, 0, 8);
-    tcg_gen_extract_tl(t7, t4, 8, 8);
+    tcg_gen_extract_i32(t6, t4, 0, 8);
+    tcg_gen_extract_i32(t7, t4, 8, 8);
     if (aptn2 & 1) {
-        tcg_gen_sub_tl(t0, t6, t0);
-        tcg_gen_sub_tl(t1, t7, t1);
+        tcg_gen_sub_i32(t0, t6, t0);
+        tcg_gen_sub_i32(t1, t7, t1);
     } else {
-        tcg_gen_add_tl(t0, t6, t0);
-        tcg_gen_add_tl(t1, t7, t1);
+        tcg_gen_add_i32(t0, t6, t0);
+        tcg_gen_add_i32(t1, t7, t1);
     }
-    tcg_gen_extract_tl(t6, t4, 16, 8);
-    tcg_gen_extract_tl(t7, t4, 24, 8);
+    tcg_gen_extract_i32(t6, t4, 16, 8);
+    tcg_gen_extract_i32(t7, t4, 24, 8);
     if (aptn2 & 2) {
-        tcg_gen_sub_tl(t2, t6, t2);
-        tcg_gen_sub_tl(t3, t7, t3);
+        tcg_gen_sub_i32(t2, t6, t2);
+        tcg_gen_sub_i32(t3, t7, t3);
     } else {
-        tcg_gen_add_tl(t2, t6, t2);
-        tcg_gen_add_tl(t3, t7, t3);
+        tcg_gen_add_i32(t2, t6, t2);
+        tcg_gen_add_i32(t3, t7, t3);
     }
 
-    tcg_gen_andi_tl(t5, t0, 0xff);
-    tcg_gen_deposit_tl(t5, t5, t1,  8, 8);
-    tcg_gen_deposit_tl(t5, t5, t2, 16, 8);
-    tcg_gen_deposit_tl(t5, t5, t3, 24, 8);
+    tcg_gen_andi_i32(t5, t0, 0xff);
+    tcg_gen_deposit_i32(t5, t5, t1,  8, 8);
+    tcg_gen_deposit_i32(t5, t5, t2, 16, 8);
+    tcg_gen_deposit_i32(t5, t5, t3, 24, 8);
 
     gen_store_mxu_gpr(t5, XRd);
 }
@@ -1518,21 +1518,21 @@ static void gen_mxu_q8madl(DisasContext *ctx)
  */
 static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, s12;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     s12 = sextract32(ctx->opcode, 10, 10);
     Rb = extract32(ctx->opcode, 21, 5);
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_movi_tl(t1, s12 * 4);
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_movi_i32(t1, s12 * 4);
+    tcg_gen_add_i32(t0, t0, t1);
 
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
+    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
@@ -1553,22 +1553,22 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
  */
 static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, s12;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     s12 = sextract32(ctx->opcode, 10, 10);
     Rb = extract32(ctx->opcode, 21, 5);
 
     gen_load_gpr(t0, Rb);
-    tcg_gen_movi_tl(t1, s12 * 4);
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_movi_i32(t1, s12 * 4);
+    tcg_gen_add_i32(t0, t0, t1);
 
     gen_load_mxu_gpr(t1, XRa);
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
 
@@ -1589,11 +1589,11 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
 static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
                              bool postinc, uint32_t strd2)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, Rc;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     Rc = extract32(ctx->opcode, 16, 5);
@@ -1601,10 +1601,10 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_tl(t1, t1, strd2);
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_shli_i32(t1, t1, strd2);
+    tcg_gen_add_i32(t0, t0, t1);
 
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
+    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
@@ -1627,11 +1627,11 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
  */
 static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t Ra, Rb, Rc;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     Ra = extract32(ctx->opcode, 11, 5);
     Rc = extract32(ctx->opcode, 16, 5);
@@ -1639,10 +1639,10 @@ static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_tl(t1, t1, strd2);
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_shli_i32(t1, t1, strd2);
+    tcg_gen_add_i32(t0, t0, t1);
 
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
+    tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
     gen_store_gpr(t1, Ra);
 }
 
@@ -1658,11 +1658,11 @@ static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
 static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
                              bool postinc, uint32_t strd2)
 {
-    TCGv t0, t1;
+    TCGv_i32 t0, t1;
     uint32_t XRa, Rb, Rc;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
 
     XRa = extract32(ctx->opcode, 6, 4);
     Rc = extract32(ctx->opcode, 16, 5);
@@ -1670,11 +1670,11 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_tl(t1, t1, strd2);
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_shli_i32(t1, t1, strd2);
+    tcg_gen_add_i32(t0, t0, t1);
 
     gen_load_mxu_gpr(t1, XRa);
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+    tcg_gen_qemu_st_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
 
@@ -1859,23 +1859,23 @@ static void gen_mxu_d32sxx(DisasContext *ctx, bool right, bool arithmetic)
     XRd  = extract32(ctx->opcode, 18, 4);
     sft4 = extract32(ctx->opcode, 22, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t0, XRb);
     gen_load_mxu_gpr(t1, XRc);
 
     if (right) {
         if (arithmetic) {
-            tcg_gen_sari_tl(t0, t0, sft4);
-            tcg_gen_sari_tl(t1, t1, sft4);
+            tcg_gen_sari_i32(t0, t0, sft4);
+            tcg_gen_sari_i32(t1, t1, sft4);
         } else {
-            tcg_gen_shri_tl(t0, t0, sft4);
-            tcg_gen_shri_tl(t1, t1, sft4);
+            tcg_gen_shri_i32(t0, t0, sft4);
+            tcg_gen_shri_i32(t1, t1, sft4);
         }
     } else {
-        tcg_gen_shli_tl(t0, t0, sft4);
-        tcg_gen_shli_tl(t1, t1, sft4);
+        tcg_gen_shli_i32(t0, t0, sft4);
+        tcg_gen_shli_i32(t1, t1, sft4);
     }
     gen_store_mxu_gpr(t0, XRa);
     gen_store_mxu_gpr(t1, XRd);
@@ -1900,26 +1900,26 @@ static void gen_mxu_d32sxxv(DisasContext *ctx, bool right, bool arithmetic)
     XRd = extract32(ctx->opcode, 14, 4);
     rs  = extract32(ctx->opcode, 21, 5);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t1, XRd);
     gen_load_gpr(t2, rs);
-    tcg_gen_andi_tl(t2, t2, 0x0f);
+    tcg_gen_andi_i32(t2, t2, 0x0f);
 
     if (right) {
         if (arithmetic) {
-            tcg_gen_sar_tl(t0, t0, t2);
-            tcg_gen_sar_tl(t1, t1, t2);
+            tcg_gen_sar_i32(t0, t0, t2);
+            tcg_gen_sar_i32(t1, t1, t2);
         } else {
-            tcg_gen_shr_tl(t0, t0, t2);
-            tcg_gen_shr_tl(t1, t1, t2);
+            tcg_gen_shr_i32(t0, t0, t2);
+            tcg_gen_shr_i32(t1, t1, t2);
         }
     } else {
-        tcg_gen_shl_tl(t0, t0, t2);
-        tcg_gen_shl_tl(t1, t1, t2);
+        tcg_gen_shl_i32(t0, t0, t2);
+        tcg_gen_shl_i32(t1, t1, t2);
     }
     gen_store_mxu_gpr(t0, XRa);
     gen_store_mxu_gpr(t1, XRd);
@@ -1946,23 +1946,23 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
     if (unlikely(XRa == 0)) {
         /* destination is zero register -> do nothing */
     } else {
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
 
         if (!sarw) {
             /* Make SFT4 from rb field */
-            tcg_gen_movi_tl(t2, rb >> 1);
+            tcg_gen_movi_i32(t2, rb >> 1);
         } else {
             gen_load_gpr(t2, rb);
-            tcg_gen_andi_tl(t2, t2, 0x0f);
+            tcg_gen_andi_i32(t2, t2, 0x0f);
         }
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
-        tcg_gen_sar_tl(t0, t0, t2);
-        tcg_gen_sar_tl(t1, t1, t2);
-        tcg_gen_extract_tl(t2, t1, 0, 16);
-        tcg_gen_deposit_tl(t2, t2, t0, 16, 16);
+        tcg_gen_sar_i32(t0, t0, t2);
+        tcg_gen_sar_i32(t1, t1, t2);
+        tcg_gen_extract_i32(t2, t1, 0, 16);
+        tcg_gen_deposit_i32(t2, t2, t0, 16, 16);
         gen_store_mxu_gpr(t2, XRa);
     }
 }
@@ -1988,46 +1988,46 @@ static void gen_mxu_q16sxx(DisasContext *ctx, bool right, bool arithmetic)
     XRd  = extract32(ctx->opcode, 18, 4);
     sft4 = extract32(ctx->opcode, 22, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t0, XRb);
     gen_load_mxu_gpr(t2, XRc);
 
     if (arithmetic) {
-        tcg_gen_sextract_tl(t1, t0, 16, 16);
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
-        tcg_gen_sextract_tl(t3, t2, 16, 16);
-        tcg_gen_sextract_tl(t2, t2,  0, 16);
+        tcg_gen_sextract_i32(t1, t0, 16, 16);
+        tcg_gen_sextract_i32(t0, t0,  0, 16);
+        tcg_gen_sextract_i32(t3, t2, 16, 16);
+        tcg_gen_sextract_i32(t2, t2,  0, 16);
     } else {
-        tcg_gen_extract_tl(t1, t0, 16, 16);
-        tcg_gen_extract_tl(t0, t0,  0, 16);
-        tcg_gen_extract_tl(t3, t2, 16, 16);
-        tcg_gen_extract_tl(t2, t2,  0, 16);
+        tcg_gen_extract_i32(t1, t0, 16, 16);
+        tcg_gen_extract_i32(t0, t0,  0, 16);
+        tcg_gen_extract_i32(t3, t2, 16, 16);
+        tcg_gen_extract_i32(t2, t2,  0, 16);
     }
 
     if (right) {
         if (arithmetic) {
-            tcg_gen_sari_tl(t0, t0, sft4);
-            tcg_gen_sari_tl(t1, t1, sft4);
-            tcg_gen_sari_tl(t2, t2, sft4);
-            tcg_gen_sari_tl(t3, t3, sft4);
+            tcg_gen_sari_i32(t0, t0, sft4);
+            tcg_gen_sari_i32(t1, t1, sft4);
+            tcg_gen_sari_i32(t2, t2, sft4);
+            tcg_gen_sari_i32(t3, t3, sft4);
         } else {
-            tcg_gen_shri_tl(t0, t0, sft4);
-            tcg_gen_shri_tl(t1, t1, sft4);
-            tcg_gen_shri_tl(t2, t2, sft4);
-            tcg_gen_shri_tl(t3, t3, sft4);
+            tcg_gen_shri_i32(t0, t0, sft4);
+            tcg_gen_shri_i32(t1, t1, sft4);
+            tcg_gen_shri_i32(t2, t2, sft4);
+            tcg_gen_shri_i32(t3, t3, sft4);
         }
     } else {
-        tcg_gen_shli_tl(t0, t0, sft4);
-        tcg_gen_shli_tl(t1, t1, sft4);
-        tcg_gen_shli_tl(t2, t2, sft4);
-        tcg_gen_shli_tl(t3, t3, sft4);
+        tcg_gen_shli_i32(t0, t0, sft4);
+        tcg_gen_shli_i32(t1, t1, sft4);
+        tcg_gen_shli_i32(t2, t2, sft4);
+        tcg_gen_shli_i32(t3, t3, sft4);
     }
-    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
-    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
 
     gen_store_mxu_gpr(t0, XRa);
     gen_store_mxu_gpr(t2, XRd);
@@ -2052,50 +2052,50 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
     XRd = extract32(ctx->opcode, 14, 4);
     rs  = extract32(ctx->opcode, 21, 5);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t5 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t5 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t2, XRd);
     gen_load_gpr(t5, rs);
-    tcg_gen_andi_tl(t5, t5, 0x0f);
+    tcg_gen_andi_i32(t5, t5, 0x0f);
 
 
     if (arithmetic) {
-        tcg_gen_sextract_tl(t1, t0, 16, 16);
-        tcg_gen_sextract_tl(t0, t0,  0, 16);
-        tcg_gen_sextract_tl(t3, t2, 16, 16);
-        tcg_gen_sextract_tl(t2, t2,  0, 16);
+        tcg_gen_sextract_i32(t1, t0, 16, 16);
+        tcg_gen_sextract_i32(t0, t0,  0, 16);
+        tcg_gen_sextract_i32(t3, t2, 16, 16);
+        tcg_gen_sextract_i32(t2, t2,  0, 16);
     } else {
-        tcg_gen_extract_tl(t1, t0, 16, 16);
-        tcg_gen_extract_tl(t0, t0,  0, 16);
-        tcg_gen_extract_tl(t3, t2, 16, 16);
-        tcg_gen_extract_tl(t2, t2,  0, 16);
+        tcg_gen_extract_i32(t1, t0, 16, 16);
+        tcg_gen_extract_i32(t0, t0,  0, 16);
+        tcg_gen_extract_i32(t3, t2, 16, 16);
+        tcg_gen_extract_i32(t2, t2,  0, 16);
     }
 
     if (right) {
         if (arithmetic) {
-            tcg_gen_sar_tl(t0, t0, t5);
-            tcg_gen_sar_tl(t1, t1, t5);
-            tcg_gen_sar_tl(t2, t2, t5);
-            tcg_gen_sar_tl(t3, t3, t5);
+            tcg_gen_sar_i32(t0, t0, t5);
+            tcg_gen_sar_i32(t1, t1, t5);
+            tcg_gen_sar_i32(t2, t2, t5);
+            tcg_gen_sar_i32(t3, t3, t5);
         } else {
-            tcg_gen_shr_tl(t0, t0, t5);
-            tcg_gen_shr_tl(t1, t1, t5);
-            tcg_gen_shr_tl(t2, t2, t5);
-            tcg_gen_shr_tl(t3, t3, t5);
+            tcg_gen_shr_i32(t0, t0, t5);
+            tcg_gen_shr_i32(t1, t1, t5);
+            tcg_gen_shr_i32(t2, t2, t5);
+            tcg_gen_shr_i32(t3, t3, t5);
         }
     } else {
-        tcg_gen_shl_tl(t0, t0, t5);
-        tcg_gen_shl_tl(t1, t1, t5);
-        tcg_gen_shl_tl(t2, t2, t5);
-        tcg_gen_shl_tl(t3, t3, t5);
+        tcg_gen_shl_i32(t0, t0, t5);
+        tcg_gen_shl_i32(t1, t1, t5);
+        tcg_gen_shl_i32(t2, t2, t5);
+        tcg_gen_shl_i32(t3, t3, t5);
     }
-    tcg_gen_deposit_tl(t0, t0, t1, 16, 16);
-    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+    tcg_gen_deposit_i32(t0, t0, t1, 16, 16);
+    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
 
     gen_store_mxu_gpr(t0, XRa);
     gen_store_mxu_gpr(t2, XRd);
@@ -2195,9 +2195,9 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         /* exactly one operand is zero register - find which one is not...*/
         uint32_t XRx = XRb ? XRb : XRc;
         /* ...and do half-word-wise max/min with one operand 0 */
-        TCGv_i32 t0 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
         TCGv_i32 t1 = tcg_constant_i32(0);
-        TCGv_i32 t2 = tcg_temp_new();
+        TCGv_i32 t2 = tcg_temp_new_i32();
 
         /* the left half-word first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0xFFFF0000);
@@ -2226,9 +2226,9 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new();
-        TCGv_i32 t1 = tcg_temp_new();
-        TCGv_i32 t2 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
 
         /* the left half-word first */
         tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0xFFFF0000);
@@ -2288,9 +2288,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
         /* exactly one operand is zero register - make it be the first...*/
         uint32_t XRx = XRb ? XRb : XRc;
         /* ...and do byte-wise max/min with one operand 0 */
-        TCGv_i32 t0 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
         TCGv_i32 t1 = tcg_constant_i32(0);
-        TCGv_i32 t2 = tcg_temp_new();
+        TCGv_i32 t2 = tcg_temp_new_i32();
         int32_t i;
 
         /* the leftmost byte (byte 3) first */
@@ -2324,9 +2324,9 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
         tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new();
-        TCGv_i32 t1 = tcg_temp_new();
-        TCGv_i32 t2 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
         int32_t i;
 
         /* the leftmost bytes (bytes 3) first */
@@ -2387,32 +2387,32 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
-        tcg_gen_movi_tl(t2, 0);
+        tcg_gen_movi_i32(t2, 0);
 
         for (int i = 0; i < 4; i++) {
             if (sltu) {
-                tcg_gen_extract_tl(t0, t3, 8 * i, 8);
-                tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+                tcg_gen_extract_i32(t0, t3, 8 * i, 8);
+                tcg_gen_extract_i32(t1, t4, 8 * i, 8);
             } else {
-                tcg_gen_sextract_tl(t0, t3, 8 * i, 8);
-                tcg_gen_sextract_tl(t1, t4, 8 * i, 8);
+                tcg_gen_sextract_i32(t0, t3, 8 * i, 8);
+                tcg_gen_sextract_i32(t1, t4, 8 * i, 8);
             }
-            tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
-            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+            tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
+            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
         }
         gen_store_mxu_gpr(t2, XRa);
     }
@@ -2438,18 +2438,18 @@ static void gen_mxu_S32SLT(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
-        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
+        tcg_gen_setcond_i32(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
     }
 }
 
@@ -2474,28 +2474,28 @@ static void gen_mxu_D16SLT(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
-        tcg_gen_sextract_tl(t0, t3, 16, 16);
-        tcg_gen_sextract_tl(t1, t4, 16, 16);
-        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
-        tcg_gen_shli_tl(t2, t0, 16);
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
-        tcg_gen_sextract_tl(t1, t4,  0, 16);
-        tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
-        tcg_gen_or_tl(mxu_gpr[XRa - 1], t2, t0);
+        tcg_gen_sextract_i32(t0, t3, 16, 16);
+        tcg_gen_sextract_i32(t1, t4, 16, 16);
+        tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_shli_i32(t2, t0, 16);
+        tcg_gen_sextract_i32(t0, t3,  0, 16);
+        tcg_gen_sextract_i32(t1, t4,  0, 16);
+        tcg_gen_setcond_i32(TCG_COND_LT, t0, t0, t1);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t2, t0);
     }
 }
 
@@ -2525,36 +2525,36 @@ static void gen_mxu_d16avg(DisasContext *ctx, bool round45)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same registers -> just set destination to same */
-        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
-        tcg_gen_sextract_tl(t0, t3, 16, 16);
-        tcg_gen_sextract_tl(t1, t4, 16, 16);
-        tcg_gen_add_tl(t0, t0, t1);
+        tcg_gen_sextract_i32(t0, t3, 16, 16);
+        tcg_gen_sextract_i32(t1, t4, 16, 16);
+        tcg_gen_add_i32(t0, t0, t1);
         if (round45) {
-            tcg_gen_addi_tl(t0, t0, 1);
+            tcg_gen_addi_i32(t0, t0, 1);
         }
-        tcg_gen_shli_tl(t2, t0, 15);
-        tcg_gen_andi_tl(t2, t2, 0xffff0000);
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
-        tcg_gen_sextract_tl(t1, t4,  0, 16);
-        tcg_gen_add_tl(t0, t0, t1);
+        tcg_gen_shli_i32(t2, t0, 15);
+        tcg_gen_andi_i32(t2, t2, 0xffff0000);
+        tcg_gen_sextract_i32(t0, t3,  0, 16);
+        tcg_gen_sextract_i32(t1, t4,  0, 16);
+        tcg_gen_add_i32(t0, t0, t1);
         if (round45) {
-            tcg_gen_addi_tl(t0, t0, 1);
+            tcg_gen_addi_i32(t0, t0, 1);
         }
-        tcg_gen_shri_tl(t0, t0, 1);
-        tcg_gen_deposit_tl(t2, t2, t0, 0, 16);
+        tcg_gen_shri_i32(t0, t0, 1);
+        tcg_gen_deposit_i32(t2, t2, t0, 0, 16);
         gen_store_mxu_gpr(t2, XRa);
     }
 }
@@ -2585,31 +2585,31 @@ static void gen_mxu_q8avg(DisasContext *ctx, bool round45)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRb == XRc)) {
         /* both operands same registers -> just set destination to same */
-        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
-        tcg_gen_movi_tl(t2, 0);
+        tcg_gen_movi_i32(t2, 0);
 
         for (int i = 0; i < 4; i++) {
-            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
-            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
-            tcg_gen_add_tl(t0, t0, t1);
+            tcg_gen_extract_i32(t0, t3, 8 * i, 8);
+            tcg_gen_extract_i32(t1, t4, 8 * i, 8);
+            tcg_gen_add_i32(t0, t0, t1);
             if (round45) {
-                tcg_gen_addi_tl(t0, t0, 1);
+                tcg_gen_addi_i32(t0, t0, 1);
             }
-            tcg_gen_shri_tl(t0, t0, 1);
-            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+            tcg_gen_shri_i32(t0, t0, 1);
+            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
         }
         gen_store_mxu_gpr(t2, XRa);
     }
@@ -2636,10 +2636,10 @@ static void gen_mxu_q8movzn(DisasContext *ctx, TCGCond cond)
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
     TCGLabel *l_quarterdone = gen_new_label();
     TCGLabel *l_halfdone = gen_new_label();
     TCGLabel *l_quarterrest = gen_new_label();
@@ -2649,28 +2649,28 @@ static void gen_mxu_q8movzn(DisasContext *ctx, TCGCond cond)
     gen_load_mxu_gpr(t1, XRb);
     gen_load_mxu_gpr(t2, XRa);
 
-    tcg_gen_extract_tl(t3, t1, 24, 8);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterdone);
-    tcg_gen_extract_tl(t3, t0, 24, 8);
-    tcg_gen_deposit_tl(t2, t2, t3, 24, 8);
+    tcg_gen_extract_i32(t3, t1, 24, 8);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_quarterdone);
+    tcg_gen_extract_i32(t3, t0, 24, 8);
+    tcg_gen_deposit_i32(t2, t2, t3, 24, 8);
 
     gen_set_label(l_quarterdone);
-    tcg_gen_extract_tl(t3, t1, 16, 8);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
-    tcg_gen_extract_tl(t3, t0, 16, 8);
-    tcg_gen_deposit_tl(t2, t2, t3, 16, 8);
+    tcg_gen_extract_i32(t3, t1, 16, 8);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_halfdone);
+    tcg_gen_extract_i32(t3, t0, 16, 8);
+    tcg_gen_deposit_i32(t2, t2, t3, 16, 8);
 
     gen_set_label(l_halfdone);
-    tcg_gen_extract_tl(t3, t1, 8, 8);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_quarterrest);
-    tcg_gen_extract_tl(t3, t0, 8, 8);
-    tcg_gen_deposit_tl(t2, t2, t3, 8, 8);
+    tcg_gen_extract_i32(t3, t1, 8, 8);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_quarterrest);
+    tcg_gen_extract_i32(t3, t0, 8, 8);
+    tcg_gen_deposit_i32(t2, t2, t3, 8, 8);
 
     gen_set_label(l_quarterrest);
-    tcg_gen_extract_tl(t3, t1, 0, 8);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
-    tcg_gen_extract_tl(t3, t0, 0, 8);
-    tcg_gen_deposit_tl(t2, t2, t3, 0, 8);
+    tcg_gen_extract_i32(t3, t1, 0, 8);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_done);
+    tcg_gen_extract_i32(t3, t0, 0, 8);
+    tcg_gen_deposit_i32(t2, t2, t3, 0, 8);
 
     gen_set_label(l_done);
     gen_store_mxu_gpr(t2, XRa);
@@ -2697,10 +2697,10 @@ static void gen_mxu_d16movzn(DisasContext *ctx, TCGCond cond)
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
     TCGLabel *l_halfdone = gen_new_label();
     TCGLabel *l_done = gen_new_label();
 
@@ -2708,16 +2708,16 @@ static void gen_mxu_d16movzn(DisasContext *ctx, TCGCond cond)
     gen_load_mxu_gpr(t1, XRb);
     gen_load_mxu_gpr(t2, XRa);
 
-    tcg_gen_extract_tl(t3, t1, 16, 16);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_halfdone);
-    tcg_gen_extract_tl(t3, t0, 16, 16);
-    tcg_gen_deposit_tl(t2, t2, t3, 16, 16);
+    tcg_gen_extract_i32(t3, t1, 16, 16);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_halfdone);
+    tcg_gen_extract_i32(t3, t0, 16, 16);
+    tcg_gen_deposit_i32(t2, t2, t3, 16, 16);
 
     gen_set_label(l_halfdone);
-    tcg_gen_extract_tl(t3, t1, 0, 16);
-    tcg_gen_brcondi_tl(cond, t3, 0, l_done);
-    tcg_gen_extract_tl(t3, t0, 0, 16);
-    tcg_gen_deposit_tl(t2, t2, t3, 0, 16);
+    tcg_gen_extract_i32(t3, t1, 0, 16);
+    tcg_gen_brcondi_i32(cond, t3, 0, l_done);
+    tcg_gen_extract_i32(t3, t0, 0, 16);
+    tcg_gen_deposit_i32(t2, t2, t3, 0, 16);
 
     gen_set_label(l_done);
     gen_store_mxu_gpr(t2, XRa);
@@ -2744,14 +2744,14 @@ static void gen_mxu_s32movzn(DisasContext *ctx, TCGCond cond)
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
     TCGLabel *l_done = gen_new_label();
 
     gen_load_mxu_gpr(t0, XRc);
     gen_load_mxu_gpr(t1, XRb);
 
-    tcg_gen_brcondi_tl(cond, t1, 0, l_done);
+    tcg_gen_brcondi_i32(cond, t1, 0, l_done);
     gen_store_mxu_gpr(t0, XRa);
     gen_set_label(l_done);
 }
@@ -2784,18 +2784,18 @@ static void gen_mxu_S32CPS(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely(XRb == 0)) {
         /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRc == 0)) {
         /* condition always false -> just move XRb to XRa */
-        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
         TCGLabel *l_not_less = gen_new_label();
         TCGLabel *l_done = gen_new_label();
 
-        tcg_gen_brcondi_tl(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
-        tcg_gen_neg_tl(t0, mxu_gpr[XRb - 1]);
+        tcg_gen_brcondi_i32(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
+        tcg_gen_neg_i32(t0, mxu_gpr[XRb - 1]);
         tcg_gen_br(l_done);
         gen_set_label(l_not_less);
         gen_load_mxu_gpr(t0, XRb);
@@ -2824,37 +2824,37 @@ static void gen_mxu_D16CPS(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely(XRb == 0)) {
         /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else if (unlikely(XRc == 0)) {
         /* condition always false -> just move XRb to XRa */
-        tcg_gen_mov_tl(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
         TCGLabel *l_done_hi = gen_new_label();
         TCGLabel *l_not_less_lo = gen_new_label();
         TCGLabel *l_done_lo = gen_new_label();
 
-        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1], 16, 16);
-        tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 16, 16);
-        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_done_hi);
-        tcg_gen_subfi_tl(t1, 0, t1);
+        tcg_gen_sextract_i32(t0, mxu_gpr[XRc - 1], 16, 16);
+        tcg_gen_sextract_i32(t1, mxu_gpr[XRb - 1], 16, 16);
+        tcg_gen_brcondi_i32(TCG_COND_GE, t0, 0, l_done_hi);
+        tcg_gen_subfi_i32(t1, 0, t1);
 
         gen_set_label(l_done_hi);
         tcg_gen_shli_i32(t1, t1, 16);
 
-        tcg_gen_sextract_tl(t0, mxu_gpr[XRc - 1],  0, 16);
-        tcg_gen_brcondi_tl(TCG_COND_GE, t0, 0, l_not_less_lo);
-        tcg_gen_sextract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
-        tcg_gen_subfi_tl(t0, 0, t0);
+        tcg_gen_sextract_i32(t0, mxu_gpr[XRc - 1],  0, 16);
+        tcg_gen_brcondi_i32(TCG_COND_GE, t0, 0, l_not_less_lo);
+        tcg_gen_sextract_i32(t0, mxu_gpr[XRb - 1],  0, 16);
+        tcg_gen_subfi_i32(t0, 0, t0);
         tcg_gen_br(l_done_lo);
 
         gen_set_label(l_not_less_lo);
-        tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 16);
+        tcg_gen_extract_i32(t0, mxu_gpr[XRb - 1],  0, 16);
 
         gen_set_label(l_done_lo);
-        tcg_gen_deposit_tl(mxu_gpr[XRa - 1], t1, t0, 0, 16);
+        tcg_gen_deposit_i32(mxu_gpr[XRa - 1], t1, t0, 0, 16);
     }
 }
 
@@ -2880,27 +2880,27 @@ static void gen_mxu_Q8ABD(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
-        tcg_gen_movi_tl(t2, 0);
+        tcg_gen_movi_i32(t2, 0);
 
         for (int i = 0; i < 4; i++) {
-            tcg_gen_extract_tl(t0, t3, 8 * i, 8);
-            tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+            tcg_gen_extract_i32(t0, t3, 8 * i, 8);
+            tcg_gen_extract_i32(t1, t4, 8 * i, 8);
 
-            tcg_gen_sub_tl(t0, t0, t1);
-            tcg_gen_abs_tl(t0, t0);
+            tcg_gen_sub_i32(t0, t0, t1);
+            tcg_gen_abs_i32(t0, t0);
 
-            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+            tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
         }
         gen_store_mxu_gpr(t2, XRa);
     }
@@ -2930,41 +2930,41 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
         tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t3, XRb);
         gen_load_mxu_gpr(t4, XRc);
 
         for (int i = 0; i < 4; i++) {
-            tcg_gen_andi_tl(t0, t3, 0xff);
-            tcg_gen_andi_tl(t1, t4, 0xff);
+            tcg_gen_andi_i32(t0, t3, 0xff);
+            tcg_gen_andi_i32(t1, t4, 0xff);
 
             if (i < 2) {
                 if (aptn2 & 0x01) {
-                    tcg_gen_sub_tl(t0, t0, t1);
+                    tcg_gen_sub_i32(t0, t0, t1);
                 } else {
-                    tcg_gen_add_tl(t0, t0, t1);
+                    tcg_gen_add_i32(t0, t0, t1);
                 }
             } else {
                 if (aptn2 & 0x02) {
-                    tcg_gen_sub_tl(t0, t0, t1);
+                    tcg_gen_sub_i32(t0, t0, t1);
                 } else {
-                    tcg_gen_add_tl(t0, t0, t1);
+                    tcg_gen_add_i32(t0, t0, t1);
                 }
             }
             if (i < 3) {
-                tcg_gen_shri_tl(t3, t3, 8);
-                tcg_gen_shri_tl(t4, t4, 8);
+                tcg_gen_shri_i32(t3, t3, 8);
+                tcg_gen_shri_i32(t4, t4, 8);
             }
             if (i > 0) {
-                tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+                tcg_gen_deposit_i32(t2, t2, t0, 8 * i, 8);
             } else {
-                tcg_gen_andi_tl(t0, t0, 0xff);
-                tcg_gen_mov_tl(t2, t0);
+                tcg_gen_andi_i32(t0, t0, 0xff);
+                tcg_gen_mov_i32(t2, t0);
             }
         }
         gen_store_mxu_gpr(t2, XRa);
@@ -2999,19 +2999,19 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
     if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
         if (XRa != 0) {
-            tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+            tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
         }
         if (XRd != 0) {
-            tcg_gen_movi_tl(mxu_gpr[XRd - 1], 0);
+            tcg_gen_movi_i32(mxu_gpr[XRd - 1], 0);
         }
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
-        TCGv t5 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
+        TCGv_i32 t5 = tcg_temp_new_i32();
 
         if (XRa != 0) {
             gen_extract_mxu_gpr(t0, XRb, 16, 8);
@@ -3019,22 +3019,22 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
             gen_extract_mxu_gpr(t2, XRb, 24, 8);
             gen_extract_mxu_gpr(t3, XRc, 24, 8);
             if (aptn2 & 2) {
-                tcg_gen_sub_tl(t0, t0, t1);
-                tcg_gen_sub_tl(t2, t2, t3);
+                tcg_gen_sub_i32(t0, t0, t1);
+                tcg_gen_sub_i32(t2, t2, t3);
             } else {
-                tcg_gen_add_tl(t0, t0, t1);
-                tcg_gen_add_tl(t2, t2, t3);
+                tcg_gen_add_i32(t0, t0, t1);
+                tcg_gen_add_i32(t2, t2, t3);
             }
             if (accumulate) {
                 gen_load_mxu_gpr(t5, XRa);
-                tcg_gen_extract_tl(t1, t5,  0, 16);
-                tcg_gen_extract_tl(t3, t5, 16, 16);
-                tcg_gen_add_tl(t0, t0, t1);
-                tcg_gen_add_tl(t2, t2, t3);
+                tcg_gen_extract_i32(t1, t5,  0, 16);
+                tcg_gen_extract_i32(t3, t5, 16, 16);
+                tcg_gen_add_i32(t0, t0, t1);
+                tcg_gen_add_i32(t2, t2, t3);
             }
-            tcg_gen_shli_tl(t2, t2, 16);
-            tcg_gen_extract_tl(t0, t0, 0, 16);
-            tcg_gen_or_tl(t4, t2, t0);
+            tcg_gen_shli_i32(t2, t2, 16);
+            tcg_gen_extract_i32(t0, t0, 0, 16);
+            tcg_gen_or_i32(t4, t2, t0);
         }
         if (XRd != 0) {
             gen_extract_mxu_gpr(t0, XRb, 0, 8);
@@ -3042,22 +3042,22 @@ static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
             gen_extract_mxu_gpr(t2, XRb, 8, 8);
             gen_extract_mxu_gpr(t3, XRc, 8, 8);
             if (aptn2 & 1) {
-                tcg_gen_sub_tl(t0, t0, t1);
-                tcg_gen_sub_tl(t2, t2, t3);
+                tcg_gen_sub_i32(t0, t0, t1);
+                tcg_gen_sub_i32(t2, t2, t3);
             } else {
-                tcg_gen_add_tl(t0, t0, t1);
-                tcg_gen_add_tl(t2, t2, t3);
+                tcg_gen_add_i32(t0, t0, t1);
+                tcg_gen_add_i32(t2, t2, t3);
             }
             if (accumulate) {
                 gen_load_mxu_gpr(t5, XRd);
-                tcg_gen_extract_tl(t1, t5,  0, 16);
-                tcg_gen_extract_tl(t3, t5, 16, 16);
-                tcg_gen_add_tl(t0, t0, t1);
-                tcg_gen_add_tl(t2, t2, t3);
+                tcg_gen_extract_i32(t1, t5,  0, 16);
+                tcg_gen_extract_i32(t3, t5, 16, 16);
+                tcg_gen_add_i32(t0, t0, t1);
+                tcg_gen_add_i32(t2, t2, t3);
             }
-            tcg_gen_shli_tl(t2, t2, 16);
-            tcg_gen_extract_tl(t0, t0, 0, 16);
-            tcg_gen_or_tl(t5, t2, t0);
+            tcg_gen_shli_i32(t2, t2, 16);
+            tcg_gen_extract_i32(t0, t0, 0, 16);
+            tcg_gen_or_i32(t5, t2, t0);
         }
 
         gen_store_mxu_gpr(t4, XRa);
@@ -3090,46 +3090,46 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
-        TCGv t4 = tcg_temp_new();
-        TCGv t5 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
+        TCGv_i32 t4 = tcg_temp_new_i32();
+        TCGv_i32 t5 = tcg_temp_new_i32();
 
         if (XRb != 0) {
-            tcg_gen_extract_tl(t0, mxu_gpr[XRb - 1],  0, 8);
-            tcg_gen_extract_tl(t1, mxu_gpr[XRb - 1],  8, 8);
-            tcg_gen_extract_tl(t2, mxu_gpr[XRb - 1], 16, 8);
-            tcg_gen_extract_tl(t3, mxu_gpr[XRb - 1], 24, 8);
-            tcg_gen_add_tl(t4, t0, t1);
-            tcg_gen_add_tl(t4, t4, t2);
-            tcg_gen_add_tl(t4, t4, t3);
+            tcg_gen_extract_i32(t0, mxu_gpr[XRb - 1],  0, 8);
+            tcg_gen_extract_i32(t1, mxu_gpr[XRb - 1],  8, 8);
+            tcg_gen_extract_i32(t2, mxu_gpr[XRb - 1], 16, 8);
+            tcg_gen_extract_i32(t3, mxu_gpr[XRb - 1], 24, 8);
+            tcg_gen_add_i32(t4, t0, t1);
+            tcg_gen_add_i32(t4, t4, t2);
+            tcg_gen_add_i32(t4, t4, t3);
         } else {
-            tcg_gen_mov_tl(t4, 0);
+            tcg_gen_mov_i32(t4, 0);
         }
         if (XRc != 0) {
-            tcg_gen_extract_tl(t0, mxu_gpr[XRc - 1],  0, 8);
-            tcg_gen_extract_tl(t1, mxu_gpr[XRc - 1],  8, 8);
-            tcg_gen_extract_tl(t2, mxu_gpr[XRc - 1], 16, 8);
-            tcg_gen_extract_tl(t3, mxu_gpr[XRc - 1], 24, 8);
-            tcg_gen_add_tl(t5, t0, t1);
-            tcg_gen_add_tl(t5, t5, t2);
-            tcg_gen_add_tl(t5, t5, t3);
+            tcg_gen_extract_i32(t0, mxu_gpr[XRc - 1],  0, 8);
+            tcg_gen_extract_i32(t1, mxu_gpr[XRc - 1],  8, 8);
+            tcg_gen_extract_i32(t2, mxu_gpr[XRc - 1], 16, 8);
+            tcg_gen_extract_i32(t3, mxu_gpr[XRc - 1], 24, 8);
+            tcg_gen_add_i32(t5, t0, t1);
+            tcg_gen_add_i32(t5, t5, t2);
+            tcg_gen_add_i32(t5, t5, t3);
         } else {
-            tcg_gen_mov_tl(t5, 0);
+            tcg_gen_mov_i32(t5, 0);
         }
 
         if (sumc) {
-            tcg_gen_addi_tl(t4, t4, 2);
-            tcg_gen_addi_tl(t5, t5, 2);
+            tcg_gen_addi_i32(t4, t4, 2);
+            tcg_gen_addi_i32(t5, t5, 2);
         }
-        tcg_gen_shli_tl(t4, t4, 16);
+        tcg_gen_shli_i32(t4, t4, 16);
 
-        tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t4, t5);
     }
 }
 
@@ -3148,74 +3148,74 @@ static void gen_mxu_q16add(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t4 = tcg_temp_new();
-    TCGv t5 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t4 = tcg_temp_new_i32();
+    TCGv_i32 t5 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_extract_tl(t0, t1,  0, 16);
-    tcg_gen_extract_tl(t1, t1, 16, 16);
+    tcg_gen_extract_i32(t0, t1,  0, 16);
+    tcg_gen_extract_i32(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_extract_tl(t2, t3,  0, 16);
-    tcg_gen_extract_tl(t3, t3, 16, 16);
+    tcg_gen_extract_i32(t2, t3,  0, 16);
+    tcg_gen_extract_i32(t3, t3, 16, 16);
 
     switch (optn2) {
     case MXU_OPTN2_WW: /* XRB.H+XRC.H == lop, XRB.L+XRC.L == rop */
-        tcg_gen_mov_tl(t4, t1);
-        tcg_gen_mov_tl(t5, t0);
+        tcg_gen_mov_i32(t4, t1);
+        tcg_gen_mov_i32(t5, t0);
         break;
     case MXU_OPTN2_LW: /* XRB.L+XRC.H == lop, XRB.L+XRC.L == rop */
-        tcg_gen_mov_tl(t4, t0);
-        tcg_gen_mov_tl(t5, t0);
+        tcg_gen_mov_i32(t4, t0);
+        tcg_gen_mov_i32(t5, t0);
         break;
     case MXU_OPTN2_HW: /* XRB.H+XRC.H == lop, XRB.H+XRC.L == rop */
-        tcg_gen_mov_tl(t4, t1);
-        tcg_gen_mov_tl(t5, t1);
+        tcg_gen_mov_i32(t4, t1);
+        tcg_gen_mov_i32(t5, t1);
         break;
     case MXU_OPTN2_XW: /* XRB.L+XRC.H == lop, XRB.H+XRC.L == rop */
-        tcg_gen_mov_tl(t4, t0);
-        tcg_gen_mov_tl(t5, t1);
+        tcg_gen_mov_i32(t4, t0);
+        tcg_gen_mov_i32(t5, t1);
         break;
     }
 
     switch (aptn2) {
     case MXU_APTN2_AA: /* lop +, rop + */
-        tcg_gen_add_tl(t0, t4, t3);
-        tcg_gen_add_tl(t1, t5, t2);
-        tcg_gen_add_tl(t4, t4, t3);
-        tcg_gen_add_tl(t5, t5, t2);
+        tcg_gen_add_i32(t0, t4, t3);
+        tcg_gen_add_i32(t1, t5, t2);
+        tcg_gen_add_i32(t4, t4, t3);
+        tcg_gen_add_i32(t5, t5, t2);
         break;
     case MXU_APTN2_AS: /* lop +, rop + */
-        tcg_gen_sub_tl(t0, t4, t3);
-        tcg_gen_sub_tl(t1, t5, t2);
-        tcg_gen_add_tl(t4, t4, t3);
-        tcg_gen_add_tl(t5, t5, t2);
+        tcg_gen_sub_i32(t0, t4, t3);
+        tcg_gen_sub_i32(t1, t5, t2);
+        tcg_gen_add_i32(t4, t4, t3);
+        tcg_gen_add_i32(t5, t5, t2);
         break;
     case MXU_APTN2_SA: /* lop +, rop + */
-        tcg_gen_add_tl(t0, t4, t3);
-        tcg_gen_add_tl(t1, t5, t2);
-        tcg_gen_sub_tl(t4, t4, t3);
-        tcg_gen_sub_tl(t5, t5, t2);
+        tcg_gen_add_i32(t0, t4, t3);
+        tcg_gen_add_i32(t1, t5, t2);
+        tcg_gen_sub_i32(t4, t4, t3);
+        tcg_gen_sub_i32(t5, t5, t2);
         break;
     case MXU_APTN2_SS: /* lop +, rop + */
-        tcg_gen_sub_tl(t0, t4, t3);
-        tcg_gen_sub_tl(t1, t5, t2);
-        tcg_gen_sub_tl(t4, t4, t3);
-        tcg_gen_sub_tl(t5, t5, t2);
+        tcg_gen_sub_i32(t0, t4, t3);
+        tcg_gen_sub_i32(t1, t5, t2);
+        tcg_gen_sub_i32(t4, t4, t3);
+        tcg_gen_sub_i32(t5, t5, t2);
         break;
     }
 
-    tcg_gen_shli_tl(t0, t0, 16);
-    tcg_gen_extract_tl(t1, t1, 0, 16);
-    tcg_gen_shli_tl(t4, t4, 16);
-    tcg_gen_extract_tl(t5, t5, 0, 16);
+    tcg_gen_shli_i32(t0, t0, 16);
+    tcg_gen_extract_i32(t1, t1, 0, 16);
+    tcg_gen_shli_i32(t4, t4, 16);
+    tcg_gen_extract_i32(t5, t5, 0, 16);
 
-    tcg_gen_or_tl(mxu_gpr[XRa - 1], t4, t5);
-    tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
+    tcg_gen_or_i32(mxu_gpr[XRa - 1], t4, t5);
+    tcg_gen_or_i32(mxu_gpr[XRd - 1], t0, t1);
 }
 
 /*
@@ -3232,66 +3232,66 @@ static void gen_mxu_q16acc(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv s3 = tcg_temp_new();
-    TCGv s2 = tcg_temp_new();
-    TCGv s1 = tcg_temp_new();
-    TCGv s0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 s3 = tcg_temp_new_i32();
+    TCGv_i32 s2 = tcg_temp_new_i32();
+    TCGv_i32 s1 = tcg_temp_new_i32();
+    TCGv_i32 s0 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t1, XRb);
-    tcg_gen_extract_tl(t0, t1,  0, 16);
-    tcg_gen_extract_tl(t1, t1, 16, 16);
+    tcg_gen_extract_i32(t0, t1,  0, 16);
+    tcg_gen_extract_i32(t1, t1, 16, 16);
 
     gen_load_mxu_gpr(t3, XRc);
-    tcg_gen_extract_tl(t2, t3,  0, 16);
-    tcg_gen_extract_tl(t3, t3, 16, 16);
+    tcg_gen_extract_i32(t2, t3,  0, 16);
+    tcg_gen_extract_i32(t3, t3, 16, 16);
 
     switch (aptn2) {
     case MXU_APTN2_AA: /* lop +, rop + */
-        tcg_gen_add_tl(s3, t1, t3);
-        tcg_gen_add_tl(s2, t0, t2);
-        tcg_gen_add_tl(s1, t1, t3);
-        tcg_gen_add_tl(s0, t0, t2);
+        tcg_gen_add_i32(s3, t1, t3);
+        tcg_gen_add_i32(s2, t0, t2);
+        tcg_gen_add_i32(s1, t1, t3);
+        tcg_gen_add_i32(s0, t0, t2);
         break;
     case MXU_APTN2_AS: /* lop +, rop - */
-        tcg_gen_sub_tl(s3, t1, t3);
-        tcg_gen_sub_tl(s2, t0, t2);
-        tcg_gen_add_tl(s1, t1, t3);
-        tcg_gen_add_tl(s0, t0, t2);
+        tcg_gen_sub_i32(s3, t1, t3);
+        tcg_gen_sub_i32(s2, t0, t2);
+        tcg_gen_add_i32(s1, t1, t3);
+        tcg_gen_add_i32(s0, t0, t2);
         break;
     case MXU_APTN2_SA: /* lop -, rop + */
-        tcg_gen_add_tl(s3, t1, t3);
-        tcg_gen_add_tl(s2, t0, t2);
-        tcg_gen_sub_tl(s1, t1, t3);
-        tcg_gen_sub_tl(s0, t0, t2);
+        tcg_gen_add_i32(s3, t1, t3);
+        tcg_gen_add_i32(s2, t0, t2);
+        tcg_gen_sub_i32(s1, t1, t3);
+        tcg_gen_sub_i32(s0, t0, t2);
         break;
     case MXU_APTN2_SS: /* lop -, rop - */
-        tcg_gen_sub_tl(s3, t1, t3);
-        tcg_gen_sub_tl(s2, t0, t2);
-        tcg_gen_sub_tl(s1, t1, t3);
-        tcg_gen_sub_tl(s0, t0, t2);
+        tcg_gen_sub_i32(s3, t1, t3);
+        tcg_gen_sub_i32(s2, t0, t2);
+        tcg_gen_sub_i32(s1, t1, t3);
+        tcg_gen_sub_i32(s0, t0, t2);
         break;
     }
 
     if (XRa != 0) {
-        tcg_gen_add_tl(t0, mxu_gpr[XRa - 1], s0);
-        tcg_gen_extract_tl(t0, t0, 0, 16);
-        tcg_gen_extract_tl(t1, mxu_gpr[XRa - 1], 16, 16);
-        tcg_gen_add_tl(t1, t1, s1);
-        tcg_gen_shli_tl(t1, t1, 16);
-        tcg_gen_or_tl(mxu_gpr[XRa - 1], t1, t0);
+        tcg_gen_add_i32(t0, mxu_gpr[XRa - 1], s0);
+        tcg_gen_extract_i32(t0, t0, 0, 16);
+        tcg_gen_extract_i32(t1, mxu_gpr[XRa - 1], 16, 16);
+        tcg_gen_add_i32(t1, t1, s1);
+        tcg_gen_shli_i32(t1, t1, 16);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t1, t0);
     }
 
     if (XRd != 0) {
-        tcg_gen_add_tl(t0, mxu_gpr[XRd - 1], s2);
-        tcg_gen_extract_tl(t0, t0, 0, 16);
-        tcg_gen_extract_tl(t1, mxu_gpr[XRd - 1], 16, 16);
-        tcg_gen_add_tl(t1, t1, s3);
-        tcg_gen_shli_tl(t1, t1, 16);
-        tcg_gen_or_tl(mxu_gpr[XRd - 1], t1, t0);
+        tcg_gen_add_i32(t0, mxu_gpr[XRd - 1], s2);
+        tcg_gen_extract_i32(t0, t0, 0, 16);
+        tcg_gen_extract_i32(t1, mxu_gpr[XRd - 1], 16, 16);
+        tcg_gen_add_i32(t1, t1, s3);
+        tcg_gen_shli_i32(t1, t1, 16);
+        tcg_gen_or_i32(mxu_gpr[XRd - 1], t1, t0);
     }
 }
 
@@ -3309,58 +3309,58 @@ static void gen_mxu_q16accm(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t2, XRb);
     gen_load_mxu_gpr(t3, XRc);
 
     if (XRa != 0) {
-        TCGv a0 = tcg_temp_new();
-        TCGv a1 = tcg_temp_new();
+        TCGv_i32 a0 = tcg_temp_new_i32();
+        TCGv_i32 a1 = tcg_temp_new_i32();
 
-        tcg_gen_extract_tl(t0, t2,  0, 16);
-        tcg_gen_extract_tl(t1, t2, 16, 16);
+        tcg_gen_extract_i32(t0, t2,  0, 16);
+        tcg_gen_extract_i32(t1, t2, 16, 16);
 
         gen_load_mxu_gpr(a1, XRa);
-        tcg_gen_extract_tl(a0, a1,  0, 16);
-        tcg_gen_extract_tl(a1, a1, 16, 16);
+        tcg_gen_extract_i32(a0, a1,  0, 16);
+        tcg_gen_extract_i32(a1, a1, 16, 16);
 
         if (aptn2 & 2) {
-            tcg_gen_sub_tl(a0, a0, t0);
-            tcg_gen_sub_tl(a1, a1, t1);
+            tcg_gen_sub_i32(a0, a0, t0);
+            tcg_gen_sub_i32(a1, a1, t1);
         } else {
-            tcg_gen_add_tl(a0, a0, t0);
-            tcg_gen_add_tl(a1, a1, t1);
+            tcg_gen_add_i32(a0, a0, t0);
+            tcg_gen_add_i32(a1, a1, t1);
         }
-        tcg_gen_extract_tl(a0, a0, 0, 16);
-        tcg_gen_shli_tl(a1, a1, 16);
-        tcg_gen_or_tl(mxu_gpr[XRa - 1], a1, a0);
+        tcg_gen_extract_i32(a0, a0, 0, 16);
+        tcg_gen_shli_i32(a1, a1, 16);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], a1, a0);
     }
 
     if (XRd != 0) {
-        TCGv a0 = tcg_temp_new();
-        TCGv a1 = tcg_temp_new();
+        TCGv_i32 a0 = tcg_temp_new_i32();
+        TCGv_i32 a1 = tcg_temp_new_i32();
 
-        tcg_gen_extract_tl(t0, t3,  0, 16);
-        tcg_gen_extract_tl(t1, t3, 16, 16);
+        tcg_gen_extract_i32(t0, t3,  0, 16);
+        tcg_gen_extract_i32(t1, t3, 16, 16);
 
         gen_load_mxu_gpr(a1, XRd);
-        tcg_gen_extract_tl(a0, a1,  0, 16);
-        tcg_gen_extract_tl(a1, a1, 16, 16);
+        tcg_gen_extract_i32(a0, a1,  0, 16);
+        tcg_gen_extract_i32(a1, a1, 16, 16);
 
         if (aptn2 & 1) {
-            tcg_gen_sub_tl(a0, a0, t0);
-            tcg_gen_sub_tl(a1, a1, t1);
+            tcg_gen_sub_i32(a0, a0, t0);
+            tcg_gen_sub_i32(a1, a1, t1);
         } else {
-            tcg_gen_add_tl(a0, a0, t0);
-            tcg_gen_add_tl(a1, a1, t1);
+            tcg_gen_add_i32(a0, a0, t0);
+            tcg_gen_add_i32(a1, a1, t1);
         }
-        tcg_gen_extract_tl(a0, a0, 0, 16);
-        tcg_gen_shli_tl(a1, a1, 16);
-        tcg_gen_or_tl(mxu_gpr[XRd - 1], a1, a0);
+        tcg_gen_extract_i32(a0, a0, 0, 16);
+        tcg_gen_shli_i32(a1, a1, 16);
+        tcg_gen_or_i32(mxu_gpr[XRd - 1], a1, a0);
     }
 }
 
@@ -3379,33 +3379,33 @@ static void gen_mxu_d16asum(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t2, XRb);
     gen_load_mxu_gpr(t3, XRc);
 
     if (XRa != 0) {
-        tcg_gen_sextract_tl(t0, t2,  0, 16);
-        tcg_gen_sextract_tl(t1, t2, 16, 16);
-        tcg_gen_add_tl(t0, t0, t1);
+        tcg_gen_sextract_i32(t0, t2,  0, 16);
+        tcg_gen_sextract_i32(t1, t2, 16, 16);
+        tcg_gen_add_i32(t0, t0, t1);
         if (aptn2 & 2) {
-            tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         } else {
-            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+            tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         }
     }
 
     if (XRd != 0) {
-        tcg_gen_sextract_tl(t0, t3,  0, 16);
-        tcg_gen_sextract_tl(t1, t3, 16, 16);
-        tcg_gen_add_tl(t0, t0, t1);
+        tcg_gen_sextract_i32(t0, t3,  0, 16);
+        tcg_gen_sextract_i32(t1, t3, 16, 16);
+        tcg_gen_add_i32(t0, t0, t1);
         if (aptn2 & 1) {
-            tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+            tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
         } else {
-            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+            tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
         }
     }
 }
@@ -3428,10 +3428,10 @@ static void gen_mxu_d32add(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv cr = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 cr = tcg_temp_new_i32();
 
     if (unlikely(addc > 1)) {
         /* opcode incorrect -> do nothing */
@@ -3445,14 +3445,14 @@ static void gen_mxu_d32add(DisasContext *ctx)
             gen_load_mxu_gpr(t1, XRc);
             gen_load_mxu_cr(cr);
             if (XRa != 0) {
-                tcg_gen_extract_tl(t2, cr, 31, 1);
-                tcg_gen_add_tl(t0, t0, t2);
-                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+                tcg_gen_extract_i32(t2, cr, 31, 1);
+                tcg_gen_add_i32(t0, t0, t2);
+                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
             }
             if (XRd != 0) {
-                tcg_gen_extract_tl(t2, cr, 30, 1);
-                tcg_gen_add_tl(t1, t1, t2);
-                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+                tcg_gen_extract_i32(t2, cr, 30, 1);
+                tcg_gen_add_i32(t1, t1, t2);
+                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
             }
         }
     } else if (unlikely(XRa == 0 && XRd == 0)) {
@@ -3460,7 +3460,7 @@ static void gen_mxu_d32add(DisasContext *ctx)
     } else {
         /* common case */
         /* FIXME ??? What if XRa == XRd ??? */
-        TCGv carry = tcg_temp_new();
+        TCGv_i32 carry = tcg_temp_new_i32();
 
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
@@ -3468,27 +3468,27 @@ static void gen_mxu_d32add(DisasContext *ctx)
         if (XRa != 0) {
             if (aptn2 & 2) {
                 tcg_gen_sub_i32(t2, t0, t1);
-                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t1);
             } else {
                 tcg_gen_add_i32(t2, t0, t1);
-                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t2);
             }
-            tcg_gen_andi_tl(cr, cr, 0x7fffffff);
-            tcg_gen_shli_tl(carry, carry, 31);
-            tcg_gen_or_tl(cr, cr, carry);
+            tcg_gen_andi_i32(cr, cr, 0x7fffffff);
+            tcg_gen_shli_i32(carry, carry, 31);
+            tcg_gen_or_i32(cr, cr, carry);
             gen_store_mxu_gpr(t2, XRa);
         }
         if (XRd != 0) {
             if (aptn2 & 1) {
                 tcg_gen_sub_i32(t2, t0, t1);
-                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t1);
+                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t1);
             } else {
                 tcg_gen_add_i32(t2, t0, t1);
-                tcg_gen_setcond_tl(TCG_COND_GTU, carry, t0, t2);
+                tcg_gen_setcond_i32(TCG_COND_GTU, carry, t0, t2);
             }
-            tcg_gen_andi_tl(cr, cr, 0xbfffffff);
-            tcg_gen_shli_tl(carry, carry, 30);
-            tcg_gen_or_tl(cr, cr, carry);
+            tcg_gen_andi_i32(cr, cr, 0xbfffffff);
+            tcg_gen_shli_i32(carry, carry, 30);
+            tcg_gen_or_i32(cr, cr, carry);
             gen_store_mxu_gpr(t2, XRd);
         }
         gen_store_mxu_cr(cr);
@@ -3509,9 +3509,9 @@ static void gen_mxu_d32acc(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
 
     if (unlikely(XRa == 0 && XRd == 0)) {
         /* destinations are zero register -> do nothing */
@@ -3521,19 +3521,19 @@ static void gen_mxu_d32acc(DisasContext *ctx)
         gen_load_mxu_gpr(t1, XRc);
         if (XRa != 0) {
             if (aptn2 & 2) {
-                tcg_gen_sub_tl(t2, t0, t1);
+                tcg_gen_sub_i32(t2, t0, t1);
             } else {
-                tcg_gen_add_tl(t2, t0, t1);
+                tcg_gen_add_i32(t2, t0, t1);
             }
-            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+            tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
         }
         if (XRd != 0) {
             if (aptn2 & 1) {
-                tcg_gen_sub_tl(t2, t0, t1);
+                tcg_gen_sub_i32(t2, t0, t1);
             } else {
-                tcg_gen_add_tl(t2, t0, t1);
+                tcg_gen_add_i32(t2, t0, t1);
             }
-            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+            tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
         }
     }
 }
@@ -3552,9 +3552,9 @@ static void gen_mxu_d32accm(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
 
     if (unlikely(XRa == 0 && XRd == 0)) {
         /* destinations are zero register -> do nothing */
@@ -3563,19 +3563,19 @@ static void gen_mxu_d32accm(DisasContext *ctx)
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
         if (XRa != 0) {
-            tcg_gen_add_tl(t2, t0, t1);
+            tcg_gen_add_i32(t2, t0, t1);
             if (aptn2 & 2) {
-                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+                tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
             } else {
-                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
+                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t2);
             }
         }
         if (XRd != 0) {
-            tcg_gen_sub_tl(t2, t0, t1);
+            tcg_gen_sub_i32(t2, t0, t1);
             if (aptn2 & 1) {
-                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+                tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
             } else {
-                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
+                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t2);
             }
         }
     }
@@ -3595,8 +3595,8 @@ static void gen_mxu_d32asum(DisasContext *ctx)
     XRb   = extract32(ctx->opcode, 10, 4);
     XRa   = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
 
     if (unlikely(XRa == 0 && XRd == 0)) {
         /* destinations are zero register -> do nothing */
@@ -3606,16 +3606,16 @@ static void gen_mxu_d32asum(DisasContext *ctx)
         gen_load_mxu_gpr(t1, XRc);
         if (XRa != 0) {
             if (aptn2 & 2) {
-                tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+                tcg_gen_sub_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
             } else {
-                tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+                tcg_gen_add_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
             }
         }
         if (XRd != 0) {
             if (aptn2 & 1) {
-                tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+                tcg_gen_sub_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
             } else {
-                tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
+                tcg_gen_add_i32(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t1);
             }
         }
     }
@@ -3638,13 +3638,13 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  */
 static void gen_mxu_s32extr(DisasContext *ctx)
 {
-    TCGv t0, t1, t2, t3;
+    TCGv_i32 t0, t1, t2, t3;
     uint32_t XRa, XRd, rs, bits5;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
 
     XRa   = extract32(ctx->opcode,  6, 4);
     XRd   = extract32(ctx->opcode, 10, 4);
@@ -3660,23 +3660,23 @@ static void gen_mxu_s32extr(DisasContext *ctx)
         gen_load_mxu_gpr(t0, XRd);
         gen_load_mxu_gpr(t1, XRa);
         gen_load_gpr(t2, rs);
-        tcg_gen_andi_tl(t2, t2, 0x1f);
-        tcg_gen_subfi_tl(t2, 32, t2);
-        tcg_gen_brcondi_tl(TCG_COND_GE, t2, bits5, l_xra_only);
-        tcg_gen_subfi_tl(t2, bits5, t2);
-        tcg_gen_subfi_tl(t3, 32, t2);
-        tcg_gen_shr_tl(t0, t0, t3);
-        tcg_gen_shl_tl(t1, t1, t2);
-        tcg_gen_or_tl(t0, t0, t1);
+        tcg_gen_andi_i32(t2, t2, 0x1f);
+        tcg_gen_subfi_i32(t2, 32, t2);
+        tcg_gen_brcondi_i32(TCG_COND_GE, t2, bits5, l_xra_only);
+        tcg_gen_subfi_i32(t2, bits5, t2);
+        tcg_gen_subfi_i32(t3, 32, t2);
+        tcg_gen_shr_i32(t0, t0, t3);
+        tcg_gen_shl_i32(t1, t1, t2);
+        tcg_gen_or_i32(t0, t0, t1);
         tcg_gen_br(l_done);
         gen_set_label(l_xra_only);
-        tcg_gen_subi_tl(t2, t2, bits5);
-        tcg_gen_shr_tl(t0, t1, t2);
+        tcg_gen_subi_i32(t2, t2, bits5);
+        tcg_gen_shr_i32(t0, t1, t2);
         gen_set_label(l_done);
-        tcg_gen_extract_tl(t0, t0, 0, bits5);
+        tcg_gen_extract_i32(t0, t0, 0, bits5);
     } else {
         /* unspecified behavior but matches tests on real hardware*/
-        tcg_gen_movi_tl(t0, 0);
+        tcg_gen_movi_i32(t0, 0);
     }
     gen_store_mxu_gpr(t0, XRa);
 }
@@ -3688,14 +3688,14 @@ static void gen_mxu_s32extr(DisasContext *ctx)
  */
 static void gen_mxu_s32extrv(DisasContext *ctx)
 {
-    TCGv t0, t1, t2, t3, t4;
+    TCGv_i32 t0, t1, t2, t3, t4;
     uint32_t XRa, XRd, rs, rt;
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    t3 = tcg_temp_new();
-    t4 = tcg_temp_new();
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    t3 = tcg_temp_new_i32();
+    t4 = tcg_temp_new_i32();
     TCGLabel *l_xra_only = gen_new_label();
     TCGLabel *l_done = gen_new_label();
     TCGLabel *l_zero = gen_new_label();
@@ -3711,32 +3711,32 @@ static void gen_mxu_s32extrv(DisasContext *ctx)
     gen_load_mxu_gpr(t1, XRa);
     gen_load_gpr(t2, rs);
     gen_load_gpr(t4, rt);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t4, 0, l_zero);
-    tcg_gen_andi_tl(t2, t2, 0x1f);
-    tcg_gen_subfi_tl(t2, 32, t2);
-    tcg_gen_brcond_tl(TCG_COND_GE, t2, t4, l_xra_only);
-    tcg_gen_sub_tl(t2, t4, t2);
-    tcg_gen_subfi_tl(t3, 32, t2);
-    tcg_gen_shr_tl(t0, t0, t3);
-    tcg_gen_shl_tl(t1, t1, t2);
-    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, t4, 0, l_zero);
+    tcg_gen_andi_i32(t2, t2, 0x1f);
+    tcg_gen_subfi_i32(t2, 32, t2);
+    tcg_gen_brcond_i32(TCG_COND_GE, t2, t4, l_xra_only);
+    tcg_gen_sub_i32(t2, t4, t2);
+    tcg_gen_subfi_i32(t3, 32, t2);
+    tcg_gen_shr_i32(t0, t0, t3);
+    tcg_gen_shl_i32(t1, t1, t2);
+    tcg_gen_or_i32(t0, t0, t1);
     tcg_gen_br(l_extract);
 
     gen_set_label(l_xra_only);
-    tcg_gen_sub_tl(t2, t2, t4);
-    tcg_gen_shr_tl(t0, t1, t2);
+    tcg_gen_sub_i32(t2, t2, t4);
+    tcg_gen_shr_i32(t0, t1, t2);
     tcg_gen_br(l_extract);
 
     /* unspecified behavior but matches tests on real hardware*/
     gen_set_label(l_zero);
-    tcg_gen_movi_tl(t0, 0);
+    tcg_gen_movi_i32(t0, 0);
     tcg_gen_br(l_done);
 
     /* {XRa} = extract({tmp}, 0, rt) */
     gen_set_label(l_extract);
-    tcg_gen_subfi_tl(t4, 32, t4);
-    tcg_gen_shl_tl(t0, t0, t4);
-    tcg_gen_shr_tl(t0, t0, t4);
+    tcg_gen_subfi_i32(t4, 32, t4);
+    tcg_gen_shl_i32(t0, t0, t4);
+    tcg_gen_shr_i32(t0, t0, t4);
 
     gen_set_label(l_done);
     gen_store_mxu_gpr(t0, XRa);
@@ -3762,33 +3762,33 @@ static void gen_mxu_s32lui(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else {
         uint32_t s16;
-        TCGv t0 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
 
         switch (optn3) {
         case 0:
-            tcg_gen_movi_tl(t0, s8);
+            tcg_gen_movi_i32(t0, s8);
             break;
         case 1:
-            tcg_gen_movi_tl(t0, s8 << 8);
+            tcg_gen_movi_i32(t0, s8 << 8);
             break;
         case 2:
-            tcg_gen_movi_tl(t0, s8 << 16);
+            tcg_gen_movi_i32(t0, s8 << 16);
             break;
         case 3:
-            tcg_gen_movi_tl(t0, s8 << 24);
+            tcg_gen_movi_i32(t0, s8 << 24);
             break;
         case 4:
-            tcg_gen_movi_tl(t0, (s8 << 16) | s8);
+            tcg_gen_movi_i32(t0, (s8 << 16) | s8);
             break;
         case 5:
-            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 8));
+            tcg_gen_movi_i32(t0, (s8 << 24) | (s8 << 8));
             break;
         case 6:
             s16 = (uint16_t)(int16_t)(int8_t)s8;
-            tcg_gen_movi_tl(t0, (s16 << 16) | s16);
+            tcg_gen_movi_i32(t0, (s16 << 16) | s16);
             break;
         case 7:
-            tcg_gen_movi_tl(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
+            tcg_gen_movi_i32(t0, (s8 << 24) | (s8 << 16) | (s8 << 8) | s8);
             break;
         }
         gen_store_mxu_gpr(t0, XRa);
@@ -3816,11 +3816,11 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
 
-        tcg_gen_movi_tl(t2, 0);
+        tcg_gen_movi_i32(t2, 0);
         if (XRb != 0) {
             TCGLabel *l_less_hi = gen_new_label();
             TCGLabel *l_less_lo = gen_new_label();
@@ -3829,32 +3829,32 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             TCGLabel *l_greater_lo = gen_new_label();
             TCGLabel *l_done = gen_new_label();
 
-            tcg_gen_sari_tl(t0, mxu_gpr[XRb - 1], 16);
-            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
-            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
+            tcg_gen_sari_i32(t0, mxu_gpr[XRb - 1], 16);
+            tcg_gen_brcondi_i32(TCG_COND_LT, t0, 0, l_less_hi);
+            tcg_gen_brcondi_i32(TCG_COND_GT, t0, 255, l_greater_hi);
             tcg_gen_br(l_lo);
             gen_set_label(l_less_hi);
-            tcg_gen_movi_tl(t0, 0);
+            tcg_gen_movi_i32(t0, 0);
             tcg_gen_br(l_lo);
             gen_set_label(l_greater_hi);
-            tcg_gen_movi_tl(t0, 255);
+            tcg_gen_movi_i32(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
-            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
-            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
+            tcg_gen_shli_i32(t1, mxu_gpr[XRb - 1], 16);
+            tcg_gen_sari_i32(t1, t1, 16);
+            tcg_gen_brcondi_i32(TCG_COND_LT, t1, 0, l_less_lo);
+            tcg_gen_brcondi_i32(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
             gen_set_label(l_less_lo);
-            tcg_gen_movi_tl(t1, 0);
+            tcg_gen_movi_i32(t1, 0);
             tcg_gen_br(l_done);
             gen_set_label(l_greater_lo);
-            tcg_gen_movi_tl(t1, 255);
+            tcg_gen_movi_i32(t1, 255);
 
             gen_set_label(l_done);
-            tcg_gen_shli_tl(t2, t0, 24);
-            tcg_gen_shli_tl(t1, t1, 16);
-            tcg_gen_or_tl(t2, t2, t1);
+            tcg_gen_shli_i32(t2, t0, 24);
+            tcg_gen_shli_i32(t1, t1, 16);
+            tcg_gen_or_i32(t2, t2, t1);
         }
 
         if (XRc != 0) {
@@ -3865,32 +3865,32 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
             TCGLabel *l_greater_lo = gen_new_label();
             TCGLabel *l_done = gen_new_label();
 
-            tcg_gen_sari_tl(t0, mxu_gpr[XRc - 1], 16);
-            tcg_gen_brcondi_tl(TCG_COND_LT, t0, 0, l_less_hi);
-            tcg_gen_brcondi_tl(TCG_COND_GT, t0, 255, l_greater_hi);
+            tcg_gen_sari_i32(t0, mxu_gpr[XRc - 1], 16);
+            tcg_gen_brcondi_i32(TCG_COND_LT, t0, 0, l_less_hi);
+            tcg_gen_brcondi_i32(TCG_COND_GT, t0, 255, l_greater_hi);
             tcg_gen_br(l_lo);
             gen_set_label(l_less_hi);
-            tcg_gen_movi_tl(t0, 0);
+            tcg_gen_movi_i32(t0, 0);
             tcg_gen_br(l_lo);
             gen_set_label(l_greater_hi);
-            tcg_gen_movi_tl(t0, 255);
+            tcg_gen_movi_i32(t0, 255);
 
             gen_set_label(l_lo);
-            tcg_gen_shli_tl(t1, mxu_gpr[XRc - 1], 16);
-            tcg_gen_sari_tl(t1, t1, 16);
-            tcg_gen_brcondi_tl(TCG_COND_LT, t1, 0, l_less_lo);
-            tcg_gen_brcondi_tl(TCG_COND_GT, t1, 255, l_greater_lo);
+            tcg_gen_shli_i32(t1, mxu_gpr[XRc - 1], 16);
+            tcg_gen_sari_i32(t1, t1, 16);
+            tcg_gen_brcondi_i32(TCG_COND_LT, t1, 0, l_less_lo);
+            tcg_gen_brcondi_i32(TCG_COND_GT, t1, 255, l_greater_lo);
             tcg_gen_br(l_done);
             gen_set_label(l_less_lo);
-            tcg_gen_movi_tl(t1, 0);
+            tcg_gen_movi_i32(t1, 0);
             tcg_gen_br(l_done);
             gen_set_label(l_greater_lo);
-            tcg_gen_movi_tl(t1, 255);
+            tcg_gen_movi_i32(t1, 255);
 
             gen_set_label(l_done);
-            tcg_gen_shli_tl(t0, t0, 8);
-            tcg_gen_or_tl(t2, t2, t0);
-            tcg_gen_or_tl(t2, t2, t1);
+            tcg_gen_shli_i32(t0, t0, 8);
+            tcg_gen_or_i32(t2, t2, t0);
+            tcg_gen_or_i32(t2, t2, t1);
         }
         gen_store_mxu_gpr(t2, XRa);
     }
@@ -3910,11 +3910,11 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     XRb  = extract32(ctx->opcode, 10, 4);
     XRa  = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t4 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t4 = tcg_temp_new_i32();
 
     TCGLabel *l_b_hi_lt = gen_new_label();
     TCGLabel *l_b_hi_gt = gen_new_label();
@@ -3930,47 +3930,47 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     gen_load_mxu_gpr(t0, XRb);
     gen_load_mxu_gpr(t1, XRc);
 
-    tcg_gen_sextract_tl(t2, t0, 16, 16);
-    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_hi_lt);
-    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_b_hi_gt);
-    tcg_gen_movi_tl(t3, 0);
+    tcg_gen_sextract_i32(t2, t0, 16, 16);
+    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_b_hi_lt);
+    tcg_gen_brcondi_i32(TCG_COND_GT, t2, 0, l_b_hi_gt);
+    tcg_gen_movi_i32(t3, 0);
     tcg_gen_br(l_b_lo);
     gen_set_label(l_b_hi_lt);
-    tcg_gen_movi_tl(t3, 0xffff0000);
+    tcg_gen_movi_i32(t3, 0xffff0000);
     tcg_gen_br(l_b_lo);
     gen_set_label(l_b_hi_gt);
-    tcg_gen_movi_tl(t3, 0x00010000);
+    tcg_gen_movi_i32(t3, 0x00010000);
 
     gen_set_label(l_b_lo);
-    tcg_gen_sextract_tl(t2, t0, 0, 16);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_c_hi);
-    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_lo_lt);
-    tcg_gen_ori_tl(t3, t3, 0x00000001);
+    tcg_gen_sextract_i32(t2, t0, 0, 16);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_c_hi);
+    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_b_lo_lt);
+    tcg_gen_ori_i32(t3, t3, 0x00000001);
     tcg_gen_br(l_c_hi);
     gen_set_label(l_b_lo_lt);
-    tcg_gen_ori_tl(t3, t3, 0x0000ffff);
+    tcg_gen_ori_i32(t3, t3, 0x0000ffff);
     tcg_gen_br(l_c_hi);
 
     gen_set_label(l_c_hi);
-    tcg_gen_sextract_tl(t2, t1, 16, 16);
-    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_hi_lt);
-    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_c_hi_gt);
-    tcg_gen_movi_tl(t4, 0);
+    tcg_gen_sextract_i32(t2, t1, 16, 16);
+    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_c_hi_lt);
+    tcg_gen_brcondi_i32(TCG_COND_GT, t2, 0, l_c_hi_gt);
+    tcg_gen_movi_i32(t4, 0);
     tcg_gen_br(l_c_lo);
     gen_set_label(l_c_hi_lt);
-    tcg_gen_movi_tl(t4, 0xffff0000);
+    tcg_gen_movi_i32(t4, 0xffff0000);
     tcg_gen_br(l_c_lo);
     gen_set_label(l_c_hi_gt);
-    tcg_gen_movi_tl(t4, 0x00010000);
+    tcg_gen_movi_i32(t4, 0x00010000);
 
     gen_set_label(l_c_lo);
-    tcg_gen_sextract_tl(t2, t1, 0, 16);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_done);
-    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_lo_lt);
-    tcg_gen_ori_tl(t4, t4, 0x00000001);
+    tcg_gen_sextract_i32(t2, t1, 0, 16);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_done);
+    tcg_gen_brcondi_i32(TCG_COND_LT, t2, 0, l_c_lo_lt);
+    tcg_gen_ori_i32(t4, t4, 0x00000001);
     tcg_gen_br(l_done);
     gen_set_label(l_c_lo_lt);
-    tcg_gen_ori_tl(t4, t4, 0x0000ffff);
+    tcg_gen_ori_i32(t4, t4, 0x0000ffff);
 
     gen_set_label(l_done);
     gen_store_mxu_gpr(t3, XRa);
@@ -3991,62 +3991,62 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
     XRa  = extract32(ctx->opcode,  6, 4);
     ptn2 = extract32(ctx->opcode, 24, 2);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t0, XRb);
     gen_load_mxu_gpr(t1, XRc);
 
     switch (ptn2) {
     case 0:
-        tcg_gen_andi_tl(t2, t0, 0xff000000);
-        tcg_gen_andi_tl(t3, t1, 0x000000ff);
-        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
-        tcg_gen_shri_tl(t0, t0,  8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
-        tcg_gen_deposit_tl(t3, t3, t1, 16, 8);
-        tcg_gen_shri_tl(t0, t0,  8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t2, t2, t0,  8, 8);
-        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        tcg_gen_andi_i32(t2, t0, 0xff000000);
+        tcg_gen_andi_i32(t3, t1, 0x000000ff);
+        tcg_gen_deposit_i32(t3, t3, t0,  8, 8);
+        tcg_gen_shri_i32(t0, t0,  8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_i32(t3, t3, t1, 16, 8);
+        tcg_gen_shri_i32(t0, t0,  8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t2, t2, t0,  8, 8);
+        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t2, t2, t1, 16, 8);
         break;
     case 1:
-        tcg_gen_andi_tl(t2, t0, 0xff000000);
-        tcg_gen_andi_tl(t3, t1, 0x000000ff);
-        tcg_gen_deposit_tl(t3, t3, t0, 16, 8);
-        tcg_gen_shri_tl(t0, t0,  8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t2, t2, t0, 16, 8);
-        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
-        tcg_gen_shri_tl(t0, t0,  8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
-        tcg_gen_deposit_tl(t3, t3, t1,  8, 8);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t2, t2, t1,  8, 8);
+        tcg_gen_andi_i32(t2, t0, 0xff000000);
+        tcg_gen_andi_i32(t3, t1, 0x000000ff);
+        tcg_gen_deposit_i32(t3, t3, t0, 16, 8);
+        tcg_gen_shri_i32(t0, t0,  8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t2, t2, t0, 16, 8);
+        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
+        tcg_gen_shri_i32(t0, t0,  8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_i32(t3, t3, t1,  8, 8);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t2, t2, t1,  8, 8);
         break;
     case 2:
-        tcg_gen_andi_tl(t2, t0, 0xff00ff00);
-        tcg_gen_andi_tl(t3, t1, 0x00ff00ff);
-        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
-        tcg_gen_shri_tl(t0, t0, 16);
-        tcg_gen_shri_tl(t1, t1,  8);
-        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
-        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
-        tcg_gen_shri_tl(t1, t1, 16);
-        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        tcg_gen_andi_i32(t2, t0, 0xff00ff00);
+        tcg_gen_andi_i32(t3, t1, 0x00ff00ff);
+        tcg_gen_deposit_i32(t3, t3, t0,  8, 8);
+        tcg_gen_shri_i32(t0, t0, 16);
+        tcg_gen_shri_i32(t1, t1,  8);
+        tcg_gen_deposit_i32(t2, t2, t1,  0, 8);
+        tcg_gen_deposit_i32(t3, t3, t0, 24, 8);
+        tcg_gen_shri_i32(t1, t1, 16);
+        tcg_gen_deposit_i32(t2, t2, t1, 16, 8);
         break;
     case 3:
-        tcg_gen_andi_tl(t2, t0, 0xffff0000);
-        tcg_gen_andi_tl(t3, t1, 0x0000ffff);
-        tcg_gen_shri_tl(t1, t1, 16);
-        tcg_gen_deposit_tl(t2, t2, t1,  0, 16);
-        tcg_gen_deposit_tl(t3, t3, t0, 16, 16);
+        tcg_gen_andi_i32(t2, t0, 0xffff0000);
+        tcg_gen_andi_i32(t3, t1, 0x0000ffff);
+        tcg_gen_shri_i32(t1, t1, 16);
+        tcg_gen_deposit_i32(t2, t2, t1,  0, 16);
+        tcg_gen_deposit_i32(t3, t3, t0, 16, 16);
         break;
     }
 
@@ -4067,30 +4067,30 @@ static void gen_mxu_q8sad(DisasContext *ctx)
     XRb = extract32(ctx->opcode, 10, 4);
     XRa = extract32(ctx->opcode,  6, 4);
 
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t4 = tcg_temp_new();
-    TCGv t5 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t4 = tcg_temp_new_i32();
+    TCGv_i32 t5 = tcg_temp_new_i32();
 
     gen_load_mxu_gpr(t2, XRb);
     gen_load_mxu_gpr(t3, XRc);
     gen_load_mxu_gpr(t5, XRd);
-    tcg_gen_movi_tl(t4, 0);
+    tcg_gen_movi_i32(t4, 0);
 
     for (int i = 0; i < 4; i++) {
-        tcg_gen_andi_tl(t0, t2, 0xff);
-        tcg_gen_andi_tl(t1, t3, 0xff);
-        tcg_gen_sub_tl(t0, t0, t1);
-        tcg_gen_abs_tl(t0, t0);
-        tcg_gen_add_tl(t4, t4, t0);
+        tcg_gen_andi_i32(t0, t2, 0xff);
+        tcg_gen_andi_i32(t1, t3, 0xff);
+        tcg_gen_sub_i32(t0, t0, t1);
+        tcg_gen_abs_i32(t0, t0);
+        tcg_gen_add_i32(t4, t4, t0);
         if (i < 3) {
-            tcg_gen_shri_tl(t2, t2, 8);
-            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_shri_i32(t2, t2, 8);
+            tcg_gen_shri_i32(t3, t3, 8);
         }
     }
-    tcg_gen_add_tl(t5, t5, t4);
+    tcg_gen_add_i32(t5, t5, t4);
     gen_store_mxu_gpr(t4, XRa);
     gen_store_mxu_gpr(t5, XRd);
 }
@@ -4196,8 +4196,8 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
                 /*               XRa                       */
                 /*                                         */
 
-                TCGv_i32 t0 = tcg_temp_new();
-                TCGv_i32 t1 = tcg_temp_new();
+                TCGv_i32 t0 = tcg_temp_new_i32();
+                TCGv_i32 t1 = tcg_temp_new_i32();
 
                 tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x00FFFFFF);
                 tcg_gen_shli_i32(t0, t0, 8);
@@ -4219,8 +4219,8 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
                 /*                   XRa                   */
                 /*                                         */
 
-                TCGv_i32 t0 = tcg_temp_new();
-                TCGv_i32 t1 = tcg_temp_new();
+                TCGv_i32 t0 = tcg_temp_new_i32();
+                TCGv_i32 t1 = tcg_temp_new_i32();
 
                 tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x0000FFFF);
                 tcg_gen_shli_i32(t0, t0, 16);
@@ -4242,8 +4242,8 @@ static void gen_mxu_S32ALNI(DisasContext *ctx)
                 /*                       XRa               */
                 /*                                         */
 
-                TCGv_i32 t0 = tcg_temp_new();
-                TCGv_i32 t1 = tcg_temp_new();
+                TCGv_i32 t0 = tcg_temp_new_i32();
+                TCGv_i32 t1 = tcg_temp_new_i32();
 
                 tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x000000FF);
                 tcg_gen_shli_i32(t0, t0, 24);
@@ -4290,13 +4290,13 @@ static void gen_mxu_S32ALN(DisasContext *ctx)
         /* destination is zero register -> do nothing */
     } else if (unlikely((XRb == 0) && (XRc == 0))) {
         /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGv t3 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+        TCGv_i32 t3 = tcg_temp_new_i32();
         TCGLabel *l_exit = gen_new_label();
         TCGLabel *l_b_only = gen_new_label();
         TCGLabel *l_c_only = gen_new_label();
@@ -4304,20 +4304,20 @@ static void gen_mxu_S32ALN(DisasContext *ctx)
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
         gen_load_gpr(t2, rs);
-        tcg_gen_andi_tl(t2, t2, 0x07);
+        tcg_gen_andi_i32(t2, t2, 0x07);
 
         /* do nothing for undefined cases */
-        tcg_gen_brcondi_tl(TCG_COND_GE, t2, 5, l_exit);
+        tcg_gen_brcondi_i32(TCG_COND_GE, t2, 5, l_exit);
 
-        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_b_only);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 4, l_c_only);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 0, l_b_only);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, t2, 4, l_c_only);
 
-        tcg_gen_shli_tl(t2, t2, 3);
-        tcg_gen_subfi_tl(t3, 32, t2);
+        tcg_gen_shli_i32(t2, t2, 3);
+        tcg_gen_subfi_i32(t3, 32, t2);
 
-        tcg_gen_shl_tl(t0, t0, t2);
-        tcg_gen_shr_tl(t1, t1, t3);
-        tcg_gen_or_tl(mxu_gpr[XRa - 1], t0, t1);
+        tcg_gen_shl_i32(t0, t0, t2);
+        tcg_gen_shr_i32(t1, t1, t3);
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], t0, t1);
         tcg_gen_br(l_exit);
 
         gen_set_label(l_b_only);
@@ -4359,8 +4359,8 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
     } else if (unlikely(XRa == 0 && XRd == 0)) {
         /* do nothing because result just dropped */
     } else {
-        TCGv t0 = tcg_temp_new();
-        TCGv t1 = tcg_temp_new();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
         TCGv_i64 t2 = tcg_temp_new_i64();
         TCGv_i64 t3 = tcg_temp_new_i64();
 
@@ -4368,18 +4368,18 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
         gen_load_gpr(t1, Rc);
 
         if (uns) {
-            tcg_gen_extu_tl_i64(t2, t0);
-            tcg_gen_extu_tl_i64(t3, t1);
+            tcg_gen_extu_i32_i64(t2, t0);
+            tcg_gen_extu_i32_i64(t3, t1);
         } else {
-            tcg_gen_ext_tl_i64(t2, t0);
-            tcg_gen_ext_tl_i64(t3, t1);
+            tcg_gen_ext_i32_i64(t2, t0);
+            tcg_gen_ext_i32_i64(t3, t1);
         }
         tcg_gen_mul_i64(t2, t2, t3);
 
         gen_load_mxu_gpr(t0, XRa);
         gen_load_mxu_gpr(t1, XRd);
 
-        tcg_gen_concat_tl_i64(t3, t1, t0);
+        tcg_gen_concat_i32_i64(t3, t1, t0);
         if (sub) {
             tcg_gen_sub_i64(t3, t3, t2);
         } else {
@@ -4388,8 +4388,8 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
         gen_move_low32(t1, t3);
         gen_move_high32(t0, t3);
 
-        tcg_gen_mov_tl(cpu_HI[0], t0);
-        tcg_gen_mov_tl(cpu_LO[0], t1);
+        tcg_gen_mov_i32(cpu_HI[0], t0);
+        tcg_gen_mov_i32(cpu_LO[0], t1);
 
         gen_store_mxu_gpr(t1, XRd);
         gen_store_mxu_gpr(t0, XRa);
@@ -4936,12 +4936,12 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
     }
 
     {
-        TCGv t_mxu_cr = tcg_temp_new();
+        TCGv_i32 t_mxu_cr = tcg_temp_new_i32();
         TCGLabel *l_exit = gen_new_label();
 
         gen_load_mxu_cr(t_mxu_cr);
-        tcg_gen_andi_tl(t_mxu_cr, t_mxu_cr, MXU_CR_MXU_EN);
-        tcg_gen_brcondi_tl(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
+        tcg_gen_andi_i32(t_mxu_cr, t_mxu_cr, MXU_CR_MXU_EN);
+        tcg_gen_brcondi_i32(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
 
         switch (opcode) {
         case OPC_MXU_S32MADD:
-- 
2.53.0


