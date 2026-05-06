Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEE7CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsZ-0004RN-HY; Wed, 06 May 2026 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrz-0002SE-Vf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrx-0001LA-Du
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4074122f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076293; x=1778681093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5H6M3QI6haiUuGnj8K05NXZuhEnZFAU6DI7IQxSyklk=;
 b=ffxGRaCvEADj9fqGWKD1XvTx0WUHmrMactBg+pXSnKc0t5nhZN4PWTxZTZPOqQ9ty1
 Z4SKaPrWcegZcl9qpNRInTusmTJsvFyjWYTyh/5FbLa43lLPLCxDGJ7lwTOIu/CVnJZ8
 501XUqNtRz7AU36wjjlQS/ZMHdycvDBjH/ZH5jxnebLmuzVUrtjLRv7g6THFovCfQ+sQ
 qDhV/RWFpxl7oYiQYfoEwlRjel+LdSzl4XmdhQiciowJ+hihafw1zF/Inj88nx+CjWnm
 DCV1sCre+SGhbBjQ2pKeyxmdkZ3E266HV/G/VjFn/bgSJT2l7rK2hmLwxc3tpndTZxAE
 vrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076293; x=1778681093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5H6M3QI6haiUuGnj8K05NXZuhEnZFAU6DI7IQxSyklk=;
 b=QKBedteCygfX5x7k+DXL01cYXwYorslEziTevkwYK89HhPNWKBR7uDOyx0RBHTyZKi
 Xkq3nvT1Y449309JJgf2/jxeTRZMr4Z18HmEuDg9ZpTfANmuK1CeBaNG1jOuJ545tfMv
 23BHFPXFcmCkz/nkQjVz5YMDWaSg3JUf5IY9ktcK3r8vlNnl1o4TwlTahV6sjv0xrHDR
 Aim0LFKTbtlJ//ZhjGHYCi/zPnUHlR9Hkb5bHlkoUcPj+eBk3wULvCYXG37VtOZaIyOz
 GmarSwO4RrQNILDMOq8u8dd6PS+UuNfRZ/7ghD4M+mFv3oIlT+t5qd+NKBb5zg7MfJ6c
 eUAw==
X-Gm-Message-State: AOJu0YyL/jVSRg5ng0Hu6Gm6IptGE9tKdy1g4f80SyEsr5NcdUqn0/UM
 7KvyM9EkW65w9aci6Pn3gPUN2K0/GuUktTmiwfIcZtHMzKZZzUOjpT3twfkEUuazO8J54UZ6oJn
 CJwDgYOI=
X-Gm-Gg: AeBDieuwKgBtHC+CkZccz5rs4bdWczJ5af4xp7a4UNrBTHTO3TY23yKj1HZgOv/Wr6k
 xWrY4DMmZzsonM4JB00J4+eHLJzQL5aHVErhCj4wis7W5Up3gX4nD3S2sS/Wn6sVeq5Mb/bqGKk
 3qqQn63Lhhud6B1Ql/TLFpnjrubTHod5Yl9PZeE1LJJo5flC5CJPpqjlai0r3iZVccoANyeBWBw
 GBBC1JqZURq/40G53Bo0mg6/E4Sp6t3YVpzRiva5z2gkFz4XR2M9q8ou65x/j9K42wdX++s1OWy
 jo5J/AGGEc8x10kcfhouUV72/CiBtz4j/cak7yTVfcEr5yoRXpa0HqB9PEzstP8yMlv8KVpAFgR
 kkrWm3Kv2lwDdTH1Xhceo3l2Jhxl/Py8WcNWbJcJkqrgGDdDshxFyb1uWV1r5Cy422/EyT+/mEP
 t2/Uk5BNtShp67rACvfZ+PYbnoc6RwjaIw6sDAbCn5D9b2lVYMz36Q7N7KTghhJx5FsVacgfKzg
 6M8RWtHwRQmlDFvvgPHNg==
X-Received: by 2002:a05:6000:4010:b0:441:1fa5:457c with SMTP id
 ffacd0b85a97d-4515a6c2a13mr6227876f8f.5.1778076293288; 
 Wed, 06 May 2026 07:04:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a488d8sm12620606f8f.12.2026.05.06.07.04.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 072/110] target/mips: Expand TCGv type for 64-bit extensions
Date: Wed,  6 May 2026 15:54:44 +0200
Message-ID: <20260506135524.20617-73-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

These TX79, Octeon and Loongarch extensions are only built
as 64-bit, so TCGv expands to TCGv_i64. Use the latter which
is more explicit. Mechanical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260401144503.80510-3-philmd@linaro.org>
---
 target/mips/tcg/lcsr_translate.c   | 16 +++---
 target/mips/tcg/loong_translate.c  | 92 +++++++++++++++---------------
 target/mips/tcg/octeon_translate.c | 60 +++++++++----------
 target/mips/tcg/tx79_translate.c   | 14 ++---
 4 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
index 352b0f43282..128c17a9181 100644
--- a/target/mips/tcg/lcsr_translate.c
+++ b/target/mips/tcg/lcsr_translate.c
@@ -18,8 +18,8 @@
 
 static bool trans_CPUCFG(DisasContext *ctx, arg_CPUCFG *a)
 {
-    TCGv dest = tcg_temp_new();
-    TCGv src1 = tcg_temp_new();
+    TCGv_i64 dest = tcg_temp_new_i64();
+    TCGv_i64 src1 = tcg_temp_new_i64();
 
     gen_load_gpr(src1, a->rs);
     gen_helper_lcsr_cpucfg(dest, tcg_env, src1);
@@ -30,10 +30,10 @@ static bool trans_CPUCFG(DisasContext *ctx, arg_CPUCFG *a)
 
 #ifndef CONFIG_USER_ONLY
 static bool gen_rdcsr(DisasContext *ctx, arg_r *a,
-                        void (*func)(TCGv, TCGv_ptr, TCGv))
+                        void (*func)(TCGv_i64, TCGv_ptr, TCGv_i64))
 {
-    TCGv dest = tcg_temp_new();
-    TCGv src1 = tcg_temp_new();
+    TCGv_i64 dest = tcg_temp_new_i64();
+    TCGv_i64 src1 = tcg_temp_new_i64();
 
     check_cp0_enabled(ctx);
     gen_load_gpr(src1, a->rs);
@@ -44,10 +44,10 @@ static bool gen_rdcsr(DisasContext *ctx, arg_r *a,
 }
 
 static bool gen_wrcsr(DisasContext *ctx, arg_r *a,
-                        void (*func)(TCGv_ptr, TCGv, TCGv))
+                        void (*func)(TCGv_ptr, TCGv_i64, TCGv_i64))
 {
-    TCGv val = tcg_temp_new();
-    TCGv addr = tcg_temp_new();
+    TCGv_i64 val = tcg_temp_new_i64();
+    TCGv_i64 addr = tcg_temp_new_i64();
 
     check_cp0_enabled(ctx);
     gen_load_gpr(addr, a->rs);
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 7d74cc34f8a..797e3b5f721 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -28,7 +28,7 @@
 static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
                            bool is_double)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
     TCGLabel *l1, *l2, *l3;
 
     if (rd == 0) {
@@ -36,8 +36,8 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     l1 = gen_new_label();
     l2 = gen_new_label();
     l3 = gen_new_label();
@@ -46,23 +46,23 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     gen_load_gpr(t1, rt);
 
     if (!is_double) {
-        tcg_gen_ext32s_tl(t0, t0);
-        tcg_gen_ext32s_tl(t1, t1);
+        tcg_gen_ext32s_i64(t0, t0);
+        tcg_gen_ext32s_i64(t1, t1);
     }
-    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_i64(cpu_gpr[rd], 0);
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
-    tcg_gen_mov_tl(cpu_gpr[rd], t0);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t1, -1LL, l2);
+    tcg_gen_mov_i64(cpu_gpr[rd], t0);
 
     tcg_gen_br(l3);
     gen_set_label(l2);
-    tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_div_i64(cpu_gpr[rd], t0, t1);
     if (!is_double) {
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+        tcg_gen_ext32s_i64(cpu_gpr[rd], cpu_gpr[rd]);
     }
     gen_set_label(l3);
 
@@ -82,7 +82,7 @@ static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
 static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
                             bool is_double)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
     TCGLabel *l1, *l2;
 
     if (rd == 0) {
@@ -90,8 +90,8 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     l1 = gen_new_label();
     l2 = gen_new_label();
 
@@ -99,17 +99,17 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
     gen_load_gpr(t1, rt);
 
     if (!is_double) {
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
+        tcg_gen_ext32u_i64(t0, t0);
+        tcg_gen_ext32u_i64(t1, t1);
     }
-    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_i64(cpu_gpr[rd], 0);
 
     tcg_gen_br(l2);
     gen_set_label(l1);
-    tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_divu_i64(cpu_gpr[rd], t0, t1);
     if (!is_double) {
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+        tcg_gen_ext32s_i64(cpu_gpr[rd], cpu_gpr[rd]);
     }
     gen_set_label(l2);
 
@@ -129,7 +129,7 @@ static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
 static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
                            bool is_double)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
     TCGLabel *l1, *l2, *l3;
 
     if (rd == 0) {
@@ -137,8 +137,8 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     l1 = gen_new_label();
     l2 = gen_new_label();
     l3 = gen_new_label();
@@ -147,19 +147,19 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
     gen_load_gpr(t1, rt);
 
     if (!is_double) {
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
+        tcg_gen_ext32u_i64(t0, t0);
+        tcg_gen_ext32u_i64(t1, t1);
     }
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, t1, 0, l1);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t1, -1LL, l2);
     gen_set_label(l1);
-    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_movi_i64(cpu_gpr[rd], 0);
     tcg_gen_br(l3);
     gen_set_label(l2);
-    tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_rem_i64(cpu_gpr[rd], t0, t1);
     if (!is_double) {
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+        tcg_gen_ext32s_i64(cpu_gpr[rd], cpu_gpr[rd]);
     }
     gen_set_label(l3);
 
@@ -179,7 +179,7 @@ static bool trans_DMOD_G(DisasContext *s, arg_muldiv *a)
 static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
                             bool is_double)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
     TCGLabel *l1, *l2;
 
     if (rd == 0) {
@@ -187,8 +187,8 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     l1 = gen_new_label();
     l2 = gen_new_label();
 
@@ -196,16 +196,16 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
     gen_load_gpr(t1, rt);
 
     if (!is_double) {
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
+        tcg_gen_ext32u_i64(t0, t0);
+        tcg_gen_ext32u_i64(t1, t1);
     }
-    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_brcondi_i64(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_i64(cpu_gpr[rd], 0);
     tcg_gen_br(l2);
     gen_set_label(l1);
-    tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_remu_i64(cpu_gpr[rd], t0, t1);
     if (!is_double) {
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+        tcg_gen_ext32s_i64(cpu_gpr[rd], cpu_gpr[rd]);
     }
     gen_set_label(l2);
 
@@ -225,22 +225,22 @@ static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
 static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
                             bool is_double)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
 
-    tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_mul_i64(cpu_gpr[rd], t0, t1);
     if (!is_double) {
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+        tcg_gen_ext32s_i64(cpu_gpr[rd], cpu_gpr[rd]);
     }
 
     return true;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b2eca29e06c..e1f52d444aa 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -15,7 +15,7 @@
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
-    TCGv p;
+    TCGv_i64 p;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x%" VADDR_PRIx "\n",
@@ -25,14 +25,14 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
     }
 
     /* Load needed operands */
-    TCGv t0 = tcg_temp_new();
+    TCGv_i64 t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
 
-    p = tcg_constant_tl(1ULL << a->p);
+    p = tcg_constant_i64(1ULL << a->p);
     if (a->set) {
-        tcg_gen_and_tl(bcond, p, t0);
+        tcg_gen_and_i64(bcond, p, t0);
     } else {
-        tcg_gen_andc_tl(bcond, p, t0);
+        tcg_gen_andc_i64(bcond, p, t0);
     }
 
     ctx->hflags |= MIPS_HFLAG_BC;
@@ -43,34 +43,34 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 
 static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_add_tl(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t1);
     tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
     return true;
 }
 
 static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
@@ -80,97 +80,97 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 
 static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
-    tcg_gen_sextract_tl(t0, t0, a->p, a->lenm1 + 1);
+    tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
 }
 
 static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
-    tcg_gen_deposit_z_tl(t0, t0, a->p, a->lenm1 + 1);
+    tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
 }
 
 static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {
         tcg_gen_andi_i64(t0, t0, 0xffffffff);
     }
-    tcg_gen_ctpop_tl(t0, t0);
+    tcg_gen_ctpop_i64(t0, t0);
     gen_store_gpr(t0, a->rd);
     return true;
 }
 
 static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     if (a->ne) {
-        tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
+        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
     } else {
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
+        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
     }
     return true;
 }
 
 static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
 
     /* Sign-extend to 64 bit value */
     target_ulong imm = a->imm;
     if (a->ne) {
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
+        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
     } else {
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
+        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
     }
     return true;
 }
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index ae3f5e19c43..e071c867631 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -241,8 +241,8 @@ static bool trans_parallel_compare(DisasContext *ctx, arg_r *a,
         return true;
     }
 
-    c0 = tcg_constant_tl(0);
-    c1 = tcg_constant_tl(0xffffffff);
+    c0 = tcg_constant_i64(0);
+    c1 = tcg_constant_i64(0xffffffff);
     ax = tcg_temp_new_i64();
     bx = tcg_temp_new_i64();
     t0 = tcg_temp_new_i64();
@@ -322,7 +322,7 @@ static bool trans_PCEQW(DisasContext *ctx, arg_r *a)
 static bool trans_LQ(DisasContext *ctx, arg_i *a)
 {
     TCGv_i64 t0;
-    TCGv addr;
+    TCGv_i64 addr;
 
     if (a->rt == 0) {
         /* nop */
@@ -330,14 +330,14 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
     }
 
     t0 = tcg_temp_new_i64();
-    addr = tcg_temp_new();
+    addr = tcg_temp_new_i64();
 
     gen_base_offset_addr(ctx, addr, a->base, a->offset);
     /*
      * Clear least-significant four bits of the effective
      * address, effectively creating an aligned address.
      */
-    tcg_gen_andi_tl(addr, addr, ~0xf);
+    tcg_gen_andi_i64(addr, addr, ~0xf);
 
     /* Lower half */
     tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
@@ -353,14 +353,14 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
 static bool trans_SQ(DisasContext *ctx, arg_i *a)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv addr = tcg_temp_new();
+    TCGv_i64 addr = tcg_temp_new_i64();
 
     gen_base_offset_addr(ctx, addr, a->base, a->offset);
     /*
      * Clear least-significant four bits of the effective
      * address, effectively creating an aligned address.
      */
-    tcg_gen_andi_tl(addr, addr, ~0xf);
+    tcg_gen_andi_i64(addr, addr, ~0xf);
 
     /* Lower half */
     gen_load_gpr(t0, a->rt);
-- 
2.53.0


