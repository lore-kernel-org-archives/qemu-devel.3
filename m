Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929E7C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MJV-0006g6-1F; Fri, 10 May 2024 05:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MJI-0006fS-Ej
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:13:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MJD-0008MM-Nj
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:12:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41b2119da94so11824925e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715332373; x=1715937173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YqSxbDZF0XfZdmTBbKAQsuSowkJqen2aaRxH/t+J4jE=;
 b=O1ftfOzH5hdvxjGE0ZJ7/dFoYDmiiohepZJk3/PDzJQU9uXtHy6npiSevMo3vYHApK
 tS9Es3yqUObFX/p0utulJ7EqvYcpsRsi7WpkKCeEfJr6BDzRzN3Skb0j2ZSF6kj6MBpM
 p4SqclZSIx9WE1MMj5GVkjf9UMK/jU31Rhu9rQmEMMBBB47v6NuyffYNqn1bRQzAPV0X
 gSfxBx5b9KaPZ+OM39pSDLNiM7eKWOQEcjA4EZHwrYdHzBtyNPYhGBPdt2iGmLcIZrrD
 UDzg+LkApg3+5+2nrbqi3BVkTRgKY96VtACR7ThPMDDeGlQ0GvFL/CkHc0JCf5HhR2IB
 ARJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332373; x=1715937173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqSxbDZF0XfZdmTBbKAQsuSowkJqen2aaRxH/t+J4jE=;
 b=ImG22XbO7ZmRJo6Nw/lZhHcBeC6Tfcod13R49ocR/Bx+skiP+nri1NS7CPRkn5YrXd
 LVA9eA8DiQmf5a7KQ7Jx1trHbZFgL56MAFDDmLI08J5CTecS/JLO0qkJEMBw/PT84Rjl
 HcfWr1Y48VSd9S4xY52Qmaq3LXTH6UjCPwcBH5QJwk6R+0W2eax0msXKoxGur7PGoI0+
 k5v9cUxU+RXQct0I5z6UtvHNhoCrRWlO9PQ3JMUzR2+2l1FgYblHyXXBiuFjYJbmOY7e
 10hen6KWKXQcowy2FBmSmRBM90zhkFurKRON39UI4YNyHuYzZrGzOyqL8mRQxqswuS56
 GCbQ==
X-Gm-Message-State: AOJu0YwJJQKORlzy5MBGSxKy17HCi0Ev6ilKFvNtrxvUVPZkRm4cn58P
 NYufe+CgHbVrZy8TSB6076ixfpBrgJSiSi6LdqMAm+EDPhxoPWdtBEP4LRT4L7wh8Ruo3D6K4Nt
 wt04=
X-Google-Smtp-Source: AGHT+IHygWlu3kaamvv5jetXeHfYV+GINSdRX7DJWUimUxZYMMl22t3yxXSkZTW5sZuSomtHq/d4Mg==
X-Received: by 2002:a05:600c:3548:b0:41b:4de0:7bff with SMTP id
 5b1f17b1804b1-41fead6d187mr14302765e9.35.1715332372912; 
 Fri, 10 May 2024 02:12:52 -0700 (PDT)
Received: from stoup.. (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce9426sm55844835e9.25.2024.05.10.02.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 02:12:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	git@xen0n.name,
	qemu-stable@nongnu.org
Subject: [PATCH] tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
Date: Fri, 10 May 2024 11:12:51 +0200
Message-Id: <20240510091251.7975-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TCG register spill/fill uses tcg_out_ld/st with all types,
not necessarily going through INDEX_op_{ld,st}_vec.

Cc: qemu-stable@nongnu.org
Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2336
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 103 ++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 23 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69c5b8ac4f..06ca1ab11c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -808,18 +808,88 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
     }
 }
 
-static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
-                       TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, intptr_t offset)
 {
-    bool is_32bit = type == TCG_TYPE_I32;
-    tcg_out_ldst(s, is_32bit ? OPC_LD_W : OPC_LD_D, arg, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (dest < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
+        } else {
+            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (dest < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
+        } else {
+            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
+        }
+        break;
+    case TCG_TYPE_V128:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_vld(s, dest, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
-static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                       TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
+                       TCGReg base, intptr_t offset)
 {
-    bool is_32bit = type == TCG_TYPE_I32;
-    tcg_out_ldst(s, is_32bit ? OPC_ST_W : OPC_ST_D, arg, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (src < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_ST_W, src, base, offset);
+        } else {
+            /* TODO: Could use fst_s, fstx_s */
+            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
+                if (-0x800 <= offset && offset <= 0x7ff) {
+                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
+                } else {
+                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
+                }
+                base = TCG_REG_TMP0;
+                offset = 0;
+            }
+            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (src < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_ST_D, src, base, offset);
+        } else {
+            /* TODO: Could use fst_d, fstx_d */
+            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
+                if (-0x800 <= offset && offset <= 0x7ff) {
+                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
+                } else {
+                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
+                }
+                base = TCG_REG_TMP0;
+                offset = 0;
+            }
+            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
+        }
+        break;
+    case TCG_TYPE_V128:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_vst(s, src, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -1740,7 +1810,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2, a3;
-    TCGReg temp = TCG_REG_TMP0;
     TCGReg temp_vec = TCG_VEC_TMP0;
 
     static const LoongArchInsn cmp_vec_insn[16][4] = {
@@ -1820,22 +1889,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_st_vec:
-        /* Try to fit vst imm */
-        if (-0x800 <= a2 && a2 <= 0x7ff) {
-            tcg_out_opc_vst(s, a0, a1, a2);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
-            tcg_out_opc_vstx(s, a0, a1, temp);
-        }
+        tcg_out_st(s, type, a0, a1, a2);
         break;
     case INDEX_op_ld_vec:
-        /* Try to fit vld imm */
-        if (-0x800 <= a2 && a2 <= 0x7ff) {
-            tcg_out_opc_vld(s, a0, a1, a2);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
-            tcg_out_opc_vldx(s, a0, a1, temp);
-        }
+        tcg_out_ld(s, type, a0, a1, a2);
         break;
     case INDEX_op_and_vec:
         tcg_out_opc_vand_v(s, a0, a1, a2);
-- 
2.34.1


