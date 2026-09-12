Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5BFC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5X-000318-4F; Sat, 12 Sep 2026 06:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5H-00022s-Tt
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:48 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5E-0008VX-Up
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:47 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91ede8035so4589865ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209343; x=1789814143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FBx7yarZFWiRiwdeUt91Lu25tly+yF456lbhvZaOQUQ=;
 b=brQTCxeGInmrjWuzvOfMExAUXtesH4/3E/6lfh+Q+cn7xNpMNMVr/EoUgTC+Dfo+EU
 Sgk2hoZMiE5g7yWXSkbRUg7AVy6+hSuRhpV8yYBK8QW1aTTLlfHNGLQ0HOdJ0kofORD1
 wxhy0w03y8RKiHH+FgXinm44z6z/WjR7SDCeVPQhT8QLWKKzkUCt082X4sBotnsreg4M
 aEB2O4X7JclC1FTjFD1mG3zIfqFeLMSbrHVF0+VXakQ4aghj15Xi0i7BDEUnsTRtq9Fj
 IdSBsUsKKFSLlqWk381rRrRG+5CQfu/pYR3UEQQkERLDJ5bei+NKoKFM36POnmdsagjd
 ndKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209343; x=1789814143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FBx7yarZFWiRiwdeUt91Lu25tly+yF456lbhvZaOQUQ=;
 b=P3VRrhJgbWa4y35rj4kAKrQ3iHk18rD6RcjUMTsToyG2c+v9JPU2tz+qurFcIJeJEv
 OAGaraVel0ck71JN8pauD48+VGxma112JTL5ty6mYcJ0zBgx9tYb23FcrBX3GHlaHhcF
 kSJoh0FYWAKVFjD8/+Kid6JVH6ilCRqZkhe9Ylen0f/BJo0ODFuTF11KTbsH7VnhGT67
 B9Vn8dlMx7ZLnZQ1qeANju31thV5xwIZm70mWjbcDASywo/s+dRT6MRRqaQkeMNgSVXN
 MAfLjAPKmH2Spy91VvAcdGBU8lFbH7ImO6p6Du2qDUYq3FIyWNr6Z4/onsdXddbXm3o9
 NLvg==
X-Gm-Message-State: AFuF++kQalThzTcZezGa3pZ7SS0IwasSep/BctlB9NkMkO8Mh0o4juK5
 2hsFXD8wpEqyb5B9zQi1VD9BMXW2OM9o0a10WvYjJ5jkzmup0n4cNRg3gkWI5BsTaou7hdIyN3l
 TXc1KQqU=
X-Gm-Gg: AYBFou2i6XGw0xmg15W73M+LrL5xEyN6R/dqwTcT4JVw0FG7l1uJsDJh0TMEsw8P3hq
 AVXO0dNax9syG/oVg5vmlDfXaEGuCqDtgRvuGBnx9lgi2XjC3EazP3YPQGTi935Canc9NMtRxzU
 66gBX0my5mZzM7/s6SXgFiFhuACUF5y3Wez3y8z1GZNrfH/1+IbLE78OgOx0e7qi8TQ9+Vzy2xD
 +h0kR0vgBwlHn2BnhXUICXUgEoobENLmsgyui6AjZ/eKefiUcvMG0XKZre0yvgrxfD8C+h0rTk8
 63aVg1q9j+GLCuK9J7T+fRp7Z+kqOTm4auQiv0xEADrKznddepOBI4rRVcTZ26dzXkIMm05vNM9
 0iFvYCJH5iWNT6/BERg4UNoXmH/4F6ae5EEpFAxcezaqJjN02Af/45yMO2Xcd4rFleKGY9QbCk2
 Hgknk+DpM78q5hDepf9KfP8fowgrU0L+zmXEySX8euD5Q3LWRHqnSYOexptV3ZrL+niNOvQTtM/
 c/cLRg=
X-Received: by 2002:a17:902:f54b:b0:2d8:d4ce:7e3d with SMTP id
 d9443c01a7336-2dd4bd7a4cdmr37028985ad.18.1789209343317; 
 Sat, 12 Sep 2026 03:35:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 77/82] tcg: Generic expansion of tcg_gen_addcio_*
Date: Sat, 12 Sep 2026 00:31:21 -1000
Message-ID: <20260912103126.598030-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h   |  8 +--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 91 ++++++++++++++---------------------
 3 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 489121d478c..7f67b8972d1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -101,6 +101,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RRR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c);
 
+#define DEF_RRRRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, TCGV d, TCGV e);
+
 #define DEF_RI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b);
 
@@ -141,6 +144,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -159,8 +163,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -190,8 +192,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 187cffbdf4d..e4f694e5514 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -60,6 +60,7 @@ DEF_RRR(umax)
 DEF_RRR(umin)
 DEF_RRR(ussub)
 DEF_RRR(xor)
+DEF_RRRRR(addcio)
 DEF_RRRU(extract2)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3fd9d8bb92c..34532f8179c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -293,6 +293,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RRR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_RRRRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
+                                TCGTemp *, TCGTemp *, TCGTemp *);
+
 #define DEF_RI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t);
 
@@ -335,6 +339,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -388,6 +393,32 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                       TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_add(type, t0, a, b);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        gen_add(type, r, t0, ci);
+        gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        gen_or(type, co, t0, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1200,6 +1231,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c)     \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c)); }
 
+#define DEF_RRRRR(NAME)                                                 \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
+                                            TCGV d, TCGV e)             \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), TTMP(d), TTMP(e)); }
+
 #define DEF_RI(NAME)                                                    \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b)             \
     { gen_##NAME(TYPE, TTMP(a), b); }
@@ -1255,6 +1291,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -1312,33 +1349,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        TCGv_i32 mone = tcg_constant_i32(-1);
-
-        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
-        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_add_i32(t0, a, b);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i32(r, t0, ci);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i32(co, t0, t1);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1849,33 +1859,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-        TCGv_i64 discard = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        TCGv_i64 mone = tcg_constant_i64(-1);
-
-        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i64(discard);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_add_i64(t0, a, b);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i64(r, t0, ci);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i64(co, t0, t1);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


