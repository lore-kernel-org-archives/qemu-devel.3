Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF5C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nk-0001lu-5M; Thu, 17 Sep 2026 00:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nD-0001Cv-S5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nB-0007Cd-Sn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:15 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so223801a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619532; x=1790224332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+x4xrktbqqWpbRQSUlRvKiXAMDa/dHb1ft0eXd9qX+M=;
 b=ooJkWqotDdwXdCJuy2oexylC68HJSO+b5z03Qjg8vFCOmxF9DcvgvaSG6puQ6FcOI3
 PyMEGcv8sK1Z7IrZiuJcYg2vol/fMI1tc6S3dUYmTAZ4bU9CPb+8UdydDJ1Y0YkIKIVF
 WT77GUix5fpoG16CsKN055+XOO/tOfdJoGcJ67bbKf+011mSIV/N4KrIE4CnUvJeBUdf
 Uc8YUCsgpDn+/5fRP/YXjEI3IW/JMLeh12xNoevAd20FC374PftRaJIO+P1qWHNWRpW4
 TnfwMfpe0BuDcVT5vFMMh1h/cZ+MAnWkAOBUM7xDGoJ7hhugVgMt6G3KaGeLjN8zRydO
 17fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619532; x=1790224332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+x4xrktbqqWpbRQSUlRvKiXAMDa/dHb1ft0eXd9qX+M=;
 b=2VzlCGZ0QPEKAb4d46dsJaEXxQzEh4vh6bepr5sQ/vqUmtU1N/Qo0td4m4n/yqwpDB
 FanJIfomPqNwLm0+4x4KK360KjlfEjX/GQFKfoKCFpHRwvqoOxBRKTT8MPma2XqVuHMZ
 lYTiZF94qcNWuovdP/hSHQF2I4SWHtZinSc/3yfgvgRAdveXPx6Eigo4SglGViegf0gO
 9FYp9u0WW1gFAKFU265EFhW0Gg1IO3W+84AXSC+rlrHdSesYi58lKm47D/Yse9EGskCo
 m2paEoEJn6z8oqkzOjNVUVjQZOTXpWnu0qU9meA1yyYwZCm6jUFxQKNnTbAX+pw1nTBz
 j1Dw==
X-Gm-Message-State: AFuF++nz8Is59OtgmVmjv7QUkfpcfxLTiXKThkl8jQzudB/gIlBROFaZ
 wYLK110OL2QDYgxWkGQToPJYs2NN/8+GE52aGeMIBpBHJKA23OoWiX5XS1QFpm0dE7m05U0sFao
 flUJvl3U=
X-Gm-Gg: AYBFou2GnlJ7yd1iz25k06pPdQvBUHFuKgDEckdB15Z7W+OUTX+YeythFjqehSWxge1
 hjuFvVLeN3pv5i9M9B/v7wRWo5SETkDT1ceY1h1oyCZYw7e8Sg3wzrEX7IIKG9RPZBiZ/rODbHp
 qAnWRHzBkf4X87hCULnqLuJZCfrgAsob/Th41VRNOh3KvCO4KzJ7NhubrZPBecVbpo52wFBcGTy
 Nq3nbrp92kcX5P6Tl8SfrDtPwZToznPE2KJw5Z2fVLVO2jvlnZnYWhgMzUvAzAPFOsVLJ15RMzc
 Mno9ipf+yGjWC9MvRdTmanc6V63jkcX1BoLT80vg5qL1hlAYs1lPWiihITuzg6QfRy3A9J0N9sm
 HatW4R9/4mkzfQEBLobyk70mAV9xXyp1/07ezZB4RClCcXE+LUJC45Bi2RXERCDCk94WWsh+UvS
 DXmThyNnEflR5PFKVgHm1zOgv2PToMPAltRPhiB2vL+1mtUFwCwGTW7vv9e3EvLY9BsfXyidF5r
 /FIoYk=
X-Received: by 2002:a17:90b:1c8b:b0:39e:4154:130a with SMTP id
 98e67ed59e1d1-39e4154157bmr613622a91.10.1789619532386; 
 Wed, 16 Sep 2026 21:32:12 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 043/101] tcg: Generic expansion of tcg_gen_brcond_*
Date: Wed, 16 Sep 2026 18:27:25 -1000
Message-ID: <20260917042823.542588-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  5 ++--
 include/tcg/tcg.h            |  1 +
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 46 +++++++++++++++++++-----------------
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a5b9e0da647..31d35780739 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -120,6 +122,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /* 32 bit ops */
 
@@ -143,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +218,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 27ea86ce02a..55a2313b38c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -97,6 +97,7 @@ struct TCGLabelUse {
 };
 
 typedef struct TCGLabel TCGLabel;
+typedef struct TCGLabel *TCGLabelPtr;
 struct TCGLabel {
     bool present;
     bool has_value;
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e17caafd890..d2bbf9ba017 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
+DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8b98a0b1c12..34e85f91095 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -326,6 +326,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -338,6 +340,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /*
  * Templated operations.
@@ -355,10 +358,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c)               \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
 
+#define DEF4(NAME, T1, T2, T3, T4)                                      \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d)         \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),                  \
+                 glue(C_,T3)(c), glue(C_,T4)(d)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_TCGCond
+#define C_TCGLabelPtr
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -386,6 +396,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_TCGCond
+#undef C_TCGLabelPtr
 
 #undef DEF1
 #undef DEF2
@@ -452,6 +464,18 @@ static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
+                       TCGTemp *src2, TCGLabel *l)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_br(l);
+    } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op = gen_op_ttii(INDEX_op_brcond, type,
+                                src1, src2, cond, label_arg(l));
+        add_as_label_use(l, op);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -711,17 +735,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
-                                      arg1, arg2, cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1521,17 +1534,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                      label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
     tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-- 
2.53.0


