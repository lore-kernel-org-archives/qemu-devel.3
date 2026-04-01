Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1069A10F6FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7wpU-0002tb-NX; Wed, 01 Apr 2026 10:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wou-0002qK-6Y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wor-0000k9-N5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so58895965e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054720; x=1775659520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5g35LwpSw27zQ9aG66d1cvT6EAToOFVdNkIG3aDLtDk=;
 b=ZRQfdpgJLXlKvxXhgC3gZNXrqq94NN3yNTSZtJn23ipOUZgx65ZzlH0BQ5RNI4wyqD
 ODci7IxV45o1rgXWYBbakNPA4LQ8I0F4cPms+yHD28OtaFdrb4tr8MudtuEeN8kwWP6F
 o9MddUISyP9es4sJut5Tqgiq8vFwuR0rh2k/KAeXgMv8M8/ZO+JSqTlSfsN2TG5k8SYB
 Kejd5jwFvztgYYUmuaYD2v93wiFp6isvf995vaEwIXEMOnmkefIcimQiW8hML5JYrsSi
 yeDFqLvHqCjFvlh2mlkWgHTd2wvxX9Hh/Cm8t66wPMDNLhXpKdUEjZbvXdM/O5Fdc7ho
 plhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054720; x=1775659520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5g35LwpSw27zQ9aG66d1cvT6EAToOFVdNkIG3aDLtDk=;
 b=gF6Pa3h9suMMbYsFLir6CPMysPvN+x2RGdPg9K3StDrp4CRWVNikPfocljGrwPgacI
 gNTH+ArNVf3sbzEVyPyjnMQz/ZdK39hevSurbagiR+BoEWGQToMlNflDuaOX0hXFKV3U
 5mjby5YWn5GyVvkqfCl5OGPFd2lZopQis5W9vIKx1j0ur4jR6GlFIt4zgvvOvsDU066a
 HXSSWD+uXvmeC/hiyMAHfB4U6y+iBuzzoYKkeq6G8fENKnPckgXh/ufkw3gDw/fyL7ao
 ku418YJDUuWIA+txJuRzdm/9MNF8VmmzDwBUv6cn85Itz3UnUUwQwgfhlkJV5np5/YcI
 oCtg==
X-Gm-Message-State: AOJu0YyvHrn2X8PmGw+0rlv6aNDTgXdTNWV5F3FPm2VYeAMI1dd3QO44
 bhX+ugsidFRcSrEEIXG4TEcv0PgnPUslCJMBWAXMWFPVbXMZ6/Cq4tSBNfYX3lG2V0pqO487nbM
 YaDo+xoo=
X-Gm-Gg: ATEYQzxFq7eF7vu0P+9fKIfFDP96Ala5WMlN5FyR9uVVhfG6ratnVomvUgCsNF7EE1h
 mqFBzPc9WFmBrGJ5NN+5jqYkF5aX8kYXaxgdnfzONbZ8oEaN6NIU5L9VpqtQo7BOe3Lx0hVMX2H
 j2lWurVbDOgJ8IJbegPqAz8yAr0Nc2nd/RqL1DKaQJAtZocZ+ZL4vNdu0vRABc934ucS+mRC2rL
 lQawVF5Mb1PYtrGwntYTfHUPiYhFWg/te9Mf2X3sDoj/O7C0lmm4UBgW1wLDEKqtnNZ1tOHK+i1
 gJ2g9yDcGieeuJ2QeX7LKGlaMxhgVC/uWXqsGRasXWS5onff1LCyUVA5VzW3p8q9e3qm4IOwpTh
 XpT0i5EGX2SO8+mETZLPiDq/3Y45ci2Z69l2p9bPoWe3vm9egcscmGegTr8etXrv2Ak4f2uuEaH
 jwDJ6tPvgQ/meYL3JNVsE47pOwhBdS92z2vqJZKAWi03TJAee3e2gW1Nhleaj1QKTn80AVpsNa
X-Received: by 2002:a05:600c:a0d:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48883591733mr69316145e9.14.1775054719368; 
 Wed, 01 Apr 2026 07:45:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm3814585e9.13.2026.04.01.07.45.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 07:45:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-11.1 2/2] target/mips: Expand TCGv type for 64-bit
 extensions
Date: Wed,  1 Apr 2026 16:45:02 +0200
Message-ID: <20260401144503.80510-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401144503.80510-1-philmd@linaro.org>
References: <20260401144503.80510-1-philmd@linaro.org>
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

These TX79, Octeon and Loongarch extensions are only built
as 64-bit, so TCGv expands to TCGv_i64. Use the latter which
is more explicit. Mechanical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


