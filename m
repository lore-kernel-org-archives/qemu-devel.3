Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C9C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQj-0006ma-QF; Wed, 16 Sep 2026 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQf-0006QW-TL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:02 -0400
Received: from mail-oo2-x1f.google.com ([2607:f8b0:4864:31::1f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQd-0001zM-Te
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:01 -0400
Received: by mail-oo2-x1f.google.com with SMTP id
 006d021491bc7-6bc475ffcbfso402840eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564318; x=1790169118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d7LkeCdJ30dhmzl6U0yMsnXpSoHJk3RNAaUaAekwdu0=;
 b=LKaGAhv461cuxbW46iL5NjSEQml98tMYVPd6My49fhGmz3adPN+9qMikz2NKsvY0Qm
 0rNm1H20XLBAf2gfDznzzXwOHflpGafbite1mpi+VUkxKrQ4qnPBbhtZw+q/w29fbew5
 6eHersZsJCpnv0VhCqsIWKWQww7hTIftM4ov0m6kHd3gId+bmXLUllpw3nRR+eyu28I9
 XUnpBlUaI2IXjYdVYJtobHnI7IAzyVQkgcIaRznUhQtXAxxEFGvXIgQ1VZvqBC3dbh/4
 MBrO9PehxyVVf9Is6jxrOYj9ssOAI/E+7pKGFHZH4H134SfWic0YGaJpDD+rhjWiKDxj
 6Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564318; x=1790169118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d7LkeCdJ30dhmzl6U0yMsnXpSoHJk3RNAaUaAekwdu0=;
 b=MkmPcVu051oiGDVZJhpEw1YiHUuKQGq0ogZIK56jcZNl2Hi3DI6k5zJ+tohfb3I1j5
 CSQfwD4Pkdh2dPzNIhDPZGXEk/xXgLaNPBqAy/b6x/YWdJaWUjHSVWR5/oAmlSLLay+q
 3fPFLGKNnOOpg3jYcQKN2wAIZ1S+qjn0DelzzQMvKyQLABfjPzAYCauBjKBoM+BKovnv
 AI/ehg2mnFLXF7TvjtXGTJr5ML2jSRLZJ7rAjSbL1cCdsqTW3kD+haJ+bMUic3ir1Gsi
 v0860AB9XTZKtbz9FFuudcGgE0ykRkwJQ+/2SCQIU9pGwe7py9WX7oX92BrPwIi7TyNb
 wFtw==
X-Gm-Message-State: AFuF++lgYlVj9KbQCT7dNb/1UH0kLv8qQhyALObH/xQqCvzTMyEZG95C
 R6b62zStH+faKRX4jb5/nTu7WM4f9MvmEEgRs7M+jK5+yjg8+Yz0xgv9cHezTYYcfQqmTLSXO9b
 q3bX+bnI=
X-Gm-Gg: AYBFou0oTUxkna6Wu1eY/Iaf3aT8SrL47tE6+XFeOAiKF12FKdUl5NkdbSeem2fgz/L
 5oTKhbJcgEH6hS/w5SAppIxNsr22qlhLGCfXLi/nlSkCXjtwM4UGOJ7OXKzzNad2AQsJ5G9axSH
 DykBvz0GlBO1l2z1ki5gNvDcK7JdkPDUzyb4vEurLMxzc2T6UitOzbp+vF7uc/pAvG2nK5uHeFJ
 NOClNtq4H0M6eInqLLgfi1v0xjzMGWNpGlOuxvrDfYmBH+oTfKgorjl7qXi0m5KeO+KeO8CM49w
 0NRF3urELj7Hyru1mUawCj+dfMXSdRVuJ4KWQlWGx5q5kDnQvWFwdAyB5eOtnh9yxqicnjWWtqu
 UoyMN6Ku/QVuRSNY1vA5b3yIYQeTHJotln6tgrX1Xto7o8FSTBDuBjEnE/jy8JU70EkN4s7Ayxz
 QKNptXboIFnrOX8SwMeuCqvJqV13t/SqcE8a5xImOPwjk0LJwqGsZM01UDTBin+GU/rNielGfEv
 XtNZ+s=
X-Received: by 2002:a05:6820:2213:b0:6c7:7668:a290 with SMTP id
 006d021491bc7-6c7d15cb485mr2486412eaf.2.1789564318197; 
 Wed, 16 Sep 2026 06:11:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.11.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 82/92] tcg: Generic expansion of tcg_gen_sub2_*
Date: Wed, 16 Sep 2026 03:03:57 -1000
Message-ID: <20260916130409.3382710-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::1f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x1f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 67 ++++++++++++------------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d6e185580c5..1e5282af98d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -158,8 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f42aeb7d8f5..5a472a910c6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,6 +62,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6d8f14038a0..a38a4a3aeae 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1228,6 +1228,28 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
+static void gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_sub(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        gen_sub(type, rh, ah, bh);
+        gen_sub(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1289,28 +1311,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1818,29 +1818,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


