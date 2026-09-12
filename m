Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FCEC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L8J-0006k2-1d; Sat, 12 Sep 2026 06:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8F-0006jg-PF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:51 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8D-0000bC-P5
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:51 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso799753a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209527; x=1789814327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yYg+qLBEmbn6CTj46bhZ7/XiOyxk2LV37CXOnJkl9CY=;
 b=vQAHtwaKtAuSow9QyfgTbMgYzuVwXlDhXXybAVb9nMKSdLOUnfMYmo/0jijYnp212G
 FM2TbL6ue+vTOyyUpqJewSlD7cnV93Tibgwbxm42h2hiJxMS6kINhiP0qheoPzsvzrQm
 k75zD5RFs/yKBQyuWTm9Z+C8bf/ZXafsFFbZMAQVD38DeW4I8RWCUaVi7rLSGkGgrjas
 DIC71q0XmO9wkHiTxzaBAE3JPEVUt3jBk10GW6TsM2KVMWHTA+bRtZ6dAghWcEk2TvEV
 Z4EQwLgOsMIKTgKzde5KgjBUHhXlFnBV8Fo5oG1QRnOa/ifoQ6kHsyXOUUe7sY2od1cq
 uItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209527; x=1789814327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yYg+qLBEmbn6CTj46bhZ7/XiOyxk2LV37CXOnJkl9CY=;
 b=dmRQKDbzyZ5SbGk0BSAUxn9Twq9xfK64LLn+lTJvpWVAt1swkBlC+FdwRfcX0734Bu
 vV+r4WgwNCP26iNPnE6P64vgKEBJrD3xyzJEamwl0FKXSwlKrZ4qXvsLSA7sxuopuNYT
 8M5JUlfqX6L0JUivM88nb1uk2uVfQUW5Cs1IEbwoCrfjMiF3Pq7Fu6IxrwdYtyxYLnKs
 wtA98mzbPov518QhEyMtcV1/60wJJ/gpyaI7f8ujfiCRSZDXdeXr1oYR+6FE7qmpfP7W
 jwUmMcmDutdCwyohL5qNoYQGarc1eDorgHXt9cfbFYO6IdMyHv0yA8k3t/zmwLc9N5+2
 EMkw==
X-Gm-Message-State: AFuF++k1FXsKduUJeXyK8h/fu1jTJxhRBiCP5DHH1Ijk0O+t91RXC+rS
 xNzPBW5HD/wPUL1ERy+R/mD+T8gUtTmdNNecDQfqC20O2mZVyjG3O+ifF56tRAiAuSJqBqrRhay
 JxNtZF3I=
X-Gm-Gg: AYBFou1O6K8yuLpg8UnJd8U2dz3qW5MqQn4y0fb4QkEAzhg5F2fQ+X9jGAfkKX+rJ05
 ZYML5+lkm9xTKGprd3MNSllwxyd1iT53wr8xxBi+AsPCllVAd18MxxKTBh6xo39ckjTs/oBUEMV
 rw7fheI9QdDbtMIAAv+VxFTUfAQhBnxMospcU7MZqI1T6Mt+OAnNWAw3F6ElpyMKSQsdddqoymA
 f16F5mtbvEq7IY6uweAmSHXNRNcRlHXD6ZyQRxUxu/BFfjZIPwM8CNBy7n6ktWp1mMgtMAC5UOe
 cMhHU63ELaFYSCk6ElSkBF1ByaHMRRvbMyQbj6aIv3MwzdJb9D6r5fcffjvwzhLhlLiZp5xkiS2
 d7vxy/63qjKCNrMhb8BIekzSvnYhzyuGptncwSzpkXcTCbc0rBLuK53H1WxKgfYlY4hp+p4WTES
 8ChN9SYKLU9cciG+HpbH3AgBnYmdcgLiukU4XVO7p5Wpwsz3Je5xv2cSGArpKSmbCinm1BV4baS
 ER/khQl
X-Received: by 2002:a05:6a20:a128:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3daed19f362mr15338055637.9.1789209527444; 
 Sat, 12 Sep 2026 03:38:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9b359sm12702231eec.14.2026.09.12.03.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 80/82] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Sat, 12 Sep 2026 00:31:24 -1000
Message-ID: <20260912103126.598030-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  6 ++-
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 96 ++++++++++++++++++++---------------
 3 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96fb4d5a47c..f8d65cc98ef 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -101,6 +101,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RRR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c);
 
+#define DEF_RRRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, TCGV d);
+
 #define DEF_RRRRR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, TCGV d, TCGV e);
 
@@ -148,6 +151,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRR
 #undef DEF_RRRRR
 #undef DEF_RRRRRR
 #undef DEF_RI
@@ -164,7 +168,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
@@ -190,7 +193,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 337733b71a6..24a7f5592ed 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -60,6 +60,7 @@ DEF_RRR(umax)
 DEF_RRR(umin)
 DEF_RRR(ussub)
 DEF_RRR(xor)
+DEF_RRRR(mulu2)
 DEF_RRRRR(addcio)
 DEF_RRRRRR(add2)
 DEF_RRRRRR(sub2)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ca4440746cb..a12147367ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,13 @@ static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
                        temp_arg(t2), a3, a4);
 }
 
+static TCGOp *gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                          TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3));
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -293,6 +300,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RRR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_RRRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
+                                TCGTemp *, TCGTemp *);
+
 #define DEF_RRRRR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, \
                                 TCGTemp *, TCGTemp *, TCGTemp *);
@@ -343,6 +354,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRR
 #undef DEF_RRRRR
 #undef DEF_RRRRRR
 #undef DEF_RI
@@ -854,6 +866,44 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_extu_i32_i64(t0, src1);
+        gen_extu_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    } else {
+        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+
+        tcg_temp_free_internal(t);
+    }
+}
+
 static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1280,6 +1330,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c)     \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c)); }
 
+#define DEF_RRRR(NAME)                                                  \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c, TCGV d) \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), TTMP(c), TTMP(d)); }
+
 #define DEF_RRRRR(NAME)                                                 \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TCGV c,     \
                                             TCGV d, TCGV e)             \
@@ -1345,6 +1399,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
+#undef DEF_RRRR
 #undef DEF_RRRRR
 #undef DEF_RRRRRR
 #undef DEF_RI
@@ -1382,28 +1437,6 @@ void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1889,25 +1922,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


