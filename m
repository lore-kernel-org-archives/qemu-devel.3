Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318AC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwK-0008Bd-B3; Wed, 28 May 2025 04:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvh-0007vj-P1
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvf-0005Ev-TM
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so49804165e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420065; x=1749024865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMIpWcZTPgWgvLSAk3E+1RCgQesYjH9TPdAax6aWXxk=;
 b=rnJ9WADOM5QaQW2OaJBWnz23AQBcwcBrnDtly5gV48vz0zAbsikaV7zRdy6UKaHTBT
 87X2hn49GNcNJHBdke/MdIasZgELm2S97C+CRh3Ix8DI56PgBfhXsCBpFbciuQUGq/ze
 rXmQ4VxMqGVuA7sKhGSlzvIx9kKlsqHYyn3/bI6gpmeoXvQ2AQno7p43lWEtIRmw/xIm
 MiSZg5rH4Y/XTWaIRWY5hQWA0kOQ4o0HlhhdpFz5wcF5LfSUbweticYK6o7E/ylKi0hU
 yFaAfqTuAuPBTzLXZtMsX6pGvldA7uC+AV5galEOAeCoPH56ltVJzienOyNKbgfYky39
 1ebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420065; x=1749024865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMIpWcZTPgWgvLSAk3E+1RCgQesYjH9TPdAax6aWXxk=;
 b=gYLhYh0kE0aQyKKVpToiHxVa74gA2oCU3VueOxUgf77f8Q/aX+/Brtaaj87pOwPANs
 AXAFUOcmFfg1dqRmeOAjXjzENt7T3rEZuVfCtAkpBj0JhQMuiJzCef4Sgf7JBzvF6EWG
 6MNR1gKeUrpwr03aWVNs/Evx4yzy11eIiCOvRm040VsMdJyS2Dw7rTRUYTIromhb6pBY
 BXhz5qobW4mI87RFFNco+skaCHCax21yPoBVGPv9wc2PvJLVdQq/UhHoCuO2A+jb0TCL
 V3cptuIgabxvPBif1wqUfQaBKtKKpIF+JLAIUxUDUGPRjDstY9TlhYLOWhp/qAaNtaQr
 2RRw==
X-Gm-Message-State: AOJu0Yz3Qoul51VOSxr4ayHqOoJfm2wFWPb62diq3iV7+JmmD5fy5/58
 5mek1Lt0HGYzsGgrqS5dk5wOQKRevN0WbQwDLDPCv94f8RjZ+gDF+RHStzuEFXSPDWfN+m+Q8M7
 V25xfIZ39KA==
X-Gm-Gg: ASbGncsj+l0wjpTKgJyeL/zS2Ma47nG59d+AhCd5ZULMQ62Vce33tzQh1F1fNwl/rCc
 zo3OeClF/gH79Gd77mgDlM0TG14kqYUmj9W9C2mmBI0eja67vy2v3gzmBt3G/GDnhYRmNYXN8A3
 9Y3xN/z1WYoI4j1zWMREGAdzeSZZXlqIZzJl3gVMzN7NsHhdumZ2DaWYu4JM4Lropxg8G2tCDa7
 oXOmxW9YogSzVooktHyHqnXGcOQdzo8h4qT0M95SrG30n8a4I7nTig1cYmRpbBH4lzGB7OzOgGp
 Ookg5Eje1tTsbH/DYGfTmV8DQUCDh9bi5iTTIWMXQM1tvW7Pc/vuk978
X-Google-Smtp-Source: AGHT+IFHXKmcxmn+3mvlUNwZqsXwOCBrMzNCU7dpupYnK+wGUEHf6uroLQHULQcV/fV80Qg0tYZzng==
X-Received: by 2002:a05:600c:6297:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-44c91ad6b51mr164802105e9.4.1748420065213; 
 Wed, 28 May 2025 01:14:25 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 09/28] target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
Date: Wed, 28 May 2025 09:13:51 +0100
Message-ID: <20250528081410.157251-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use an explicit 64-bit type for extended addresses.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b1fc9e5624..dc597b36e6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -660,23 +660,23 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 }
 
 #ifndef CONFIG_USER_ONLY
-static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
+static TCGv_i64 compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
     int addr_size = dc->cfg->addr_size;
-    TCGv ret = tcg_temp_new();
+    TCGv_i64 ret = tcg_temp_new_i64();
 
     if (addr_size == 32 || ra == 0) {
         if (rb) {
-            tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+            tcg_gen_extu_i32_i64(ret, cpu_R[rb]);
         } else {
-            tcg_gen_movi_tl(ret, 0);
+            return tcg_constant_i64(0);
         }
     } else {
         if (rb) {
             tcg_gen_concat_i32_i64(ret, cpu_R[rb], cpu_R[ra]);
         } else {
-            tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
-            tcg_gen_shli_tl(ret, ret, 32);
+            tcg_gen_extu_i32_i64(ret, cpu_R[ra]);
+            tcg_gen_shli_i64(ret, ret, 32);
         }
         if (addr_size < 64) {
             /* Mask off out of range bits.  */
@@ -781,7 +781,7 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -813,7 +813,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
     (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
@@ -847,7 +847,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
     (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
@@ -941,7 +941,7 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
@@ -973,7 +973,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
     (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
@@ -1007,7 +1007,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
     (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
-- 
2.43.0


