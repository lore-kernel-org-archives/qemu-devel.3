Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFFAC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5j-0004C4-10; Sat, 12 Sep 2026 06:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5J-0002CA-08
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:49 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5F-0008Vn-RF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:48 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so358888a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209344; x=1789814144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NaWj55VnqqirT0yKVomCVojAAQ1p55Kfckt7u5blQTk=;
 b=Xn69txnvcV9SRVtqEPOzHR4w1Set8Uzmr6NT492nGdfR4OXSVfAYkUXq+9L7IIFc+4
 985EkpPNyGocan4gwvD98TO6L9ZFqk/znU3Q5qB3ggjWfahstAeuJAf94xS5TIxjMw8R
 mDu/UsXpM23Hn9orWQFmpAi8p3dDVYa3dqs1e0/CABCiAA0U2KuMtcFQG2YheSHlwLki
 WjVwoCgEC+M5oFMhtx/R85Med6di4St0vtIASKiHSlaf7vQ8Cl8DZvM/E+U5NE4QaG3i
 wcvYWSNTvC3FxNENGxDLHE0IAC0TdSfZG6v2TH9gDIA9zqo0W0Hi+cBzAUzjLnRpJtwl
 EHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209344; x=1789814144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NaWj55VnqqirT0yKVomCVojAAQ1p55Kfckt7u5blQTk=;
 b=O4Y8eEvcn8H8k7X9eJQh12RTR03i9vefdWNH6PTBJs7yxwlMXQ45t0TWrQMhS84LH8
 zYQvK7vU7/2eWpf5aHjiflAzFuYKD3RFHpr7sNxo0QQjA0KzObvCRwBeLhOQ3a4iK/hl
 at87Ym/kQS9vYcQYCRT4tJUkuuRWBwl9gcORqDyNQr6/eqjy1RKkIciQh0hQJqY4eD7h
 UWUyUXkPJeZENmqSMQKJ1M18iaG7wDi2DvedPSDLOJCxohQ2Hma/8/RGTwlq2FKXJqFL
 DnaNuQqUc108N7ySfrwoYT7ZJLG9gFpFagdER1oINJqGHVd3b3zGrA6uK80IKw8h99wc
 xZSA==
X-Gm-Message-State: AFuF++m872u3M+FjZiqfIM+ZI6lWbQdm2b76PdtPbVFjT3IfIMg9gWul
 uULl1CDRxhwXjXGbHQGDwbWejAVi6FnWjA9TomVMp5sNx3qUqXWaTpNdO6JeiJNahFRx8Y0bvcp
 lgSYZU4A=
X-Gm-Gg: AYBFou1ddTGewurL33ATJu0gmV39/2PixdTj4/5wHYxlegV+njaWh/j/NR7y3c93kP1
 q2wmomr2UVjNM9ntxVl8stXnaWd2wQPuTUVCEPcDHJVWDR1g0XxLM8CFSO2DD4B69uguvHY+P27
 Nw6qOUdRjcElp/LYTZe/yPBksG/s2KYlsOOZUNX80NFe/d74Skb7NGI1DOI5lLpEhsL9ggJC+cJ
 NtSkitlLX59UJZEpoXHwVG1shA5P1BfKbIyTEBME6elm7B547FGkFWdVynYWM1C4XszkMAKkczR
 whiSvKB0wUd61bkH5Cvj7gLBh5WuDS+jjCq1wpDRC0rQFihkbcnC37IQ2/eNEzte2YPpyMIPh/H
 UVcPB2eglIGXraX8YmjQctZ0bcu9aYQWJXuHeNPnIdtB6n9SE/ijHsR1VCgvR4dmLAfSIsAk12b
 Cb7g+HSBGlcyO2Z8h9t5jbEaQh3H4DPOLRXnzFA09NOBmO1UMUs6D+3hJkxDBPLnljuedNKtXpl
 QDFMhI=
X-Received: by 2002:a17:90b:580f:b0:39d:b769:3067 with SMTP id
 98e67ed59e1d1-39dbbc723bamr3890600a91.0.1789209344233; 
 Sat, 12 Sep 2026 03:35:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 78/82] tcg: Generic expansion of tcg_gen_add2_*
Date: Sat, 12 Sep 2026 00:31:22 -1000
Message-ID: <20260912103126.598030-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  9 ++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 78 +++++++++++++++--------------------
 3 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7f67b8972d1..67d32fc9f2e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -104,6 +104,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RRRRR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, TCGV d, TCGV e);
 
+#define DEF_RRRRRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, \
+                                        TCGV d, TCGV e, TCGV f);
+
 #define DEF_RI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b);
 
@@ -145,6 +149,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RRRRR
+#undef DEF_RRRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -159,8 +164,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,8 +191,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index e4f694e5514..dc567a27ffe 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -61,6 +61,7 @@ DEF_RRR(umin)
 DEF_RRR(ussub)
 DEF_RRR(xor)
 DEF_RRRRR(addcio)
+DEF_RRRRRR(add2)
 DEF_RRRU(extract2)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34532f8179c..164b8bb26b6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -297,6 +297,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
                                 TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_RRRRRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *, \
+                                TCGTemp *, TCGTemp *, TCGTemp *);
+
 #define DEF_RI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t);
 
@@ -340,6 +344,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RRRRR
+#undef DEF_RRRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -393,6 +398,28 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_add(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        gen_add(type, rh, ah, bh);
+        gen_add(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                        TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1236,6 +1263,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                             TCGV d, TCGV e)             \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), TTMP(d), TTMP(e)); }
 
+#define DEF_RRRRRR(NAME)                                                \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
+                                            TCGV d, TCGV e, TCGV f)     \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), TTMP(d), TTMP(e), TTMP(f)); }
+
 #define DEF_RI(NAME)                                                    \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b)             \
     { gen_##NAME(TYPE, TTMP(a), b); }
@@ -1292,6 +1324,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RRRRR
+#undef DEF_RRRRRR
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
@@ -1327,28 +1360,6 @@ void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1836,29 +1847,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
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


