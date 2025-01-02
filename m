Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5066FE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbD-0006xR-F9; Thu, 02 Jan 2025 13:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb8-0006wS-0x
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb4-00057N-CA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:04 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163dc5155fso155958515ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841220; x=1736446020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TGefZRqWRrM1GhvaWq1tk8dwyk/n1lzSkP8LF9YWj2Q=;
 b=LgO3Z6yqJe89thJjCSHTpAbg/neSI7Qk0rtW20xrTgmI/EU3YYhSjYAz1nFiYghulI
 QFO3bitNFQP0tRHdu/d7pQ6mm2DjMOQCvL3cjrSdBhLNZhwa/7VlEnOeF3Jt0wLc6Q87
 xYFJ+49oTV0Lh2eNut4yjVX3NMD03amKIL1M3KVnxbn4JF8g24prf44B5qHqyn6O4UQe
 saHY0cEfNEV0OlTKDJSZs/wJPrFkHu+jh7P8+Xgt0Wfl2A7gk1gS1JXxn1nN+dFPHDId
 wqXLTKf+l+T+9GPDbzYAaky+N3FXyX04k3K+u49BJTRELsvMCDuspEGiASLZ1u6pSV1+
 wcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841220; x=1736446020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGefZRqWRrM1GhvaWq1tk8dwyk/n1lzSkP8LF9YWj2Q=;
 b=eZzbPJkRUwApP/S/dyzCPqeQaZEpautNHz7TzdE7GoqfBh2q22CJneyRf1iacVu95V
 jrMyv0rMXlq3JDWN+X4l/3dXE5hIu6rJL6WZlwFLBSKrNf4XICEhQ0ZRklUmGJg5iT9Z
 KvROjNu9x7P3vAP0dymvWvyVXjrQ9wUB3f2UefpRJHBgduWMHECQAPuQ5URPjDb2YZZv
 gDMbSSFblG8D4cAbU9+odDgz/gkwJXBSEjo3M45NVpusZdQZe9acIbBp/+o1LwG88pve
 HS3Qwz4uxdjjDKPuYP2K98KLzgYxZA+oHDjADlZOoTqiYHx2f3+QMBWNKCrFNseHHhUM
 EOYA==
X-Gm-Message-State: AOJu0YwXYQ9mRmLWKmbPOsUL/WuRsc/PKXYL6BkmFsJcYmAiAdPLg+Vj
 1r6pDxQTDNOM1Tq5Gn/IfZIcCXJtZsKUp/YT2tMSOnxS5rasuZOpP4HQwwqylVcV+H2kK2zukk/
 g
X-Gm-Gg: ASbGncuFqCoWBEwGebFNwZEEI16Yepg9wAeoWtVm7LEsGXeGv094QYhF/Y0mWnFjTTV
 ePEapDUoBOJlGqjnVHRRv6Bkc95R1SE0v4ekuT4kiGhBo5k12rdI6QoYWA0bgoxwIzUVP9cS1vW
 +dlf5N9CtzAHvAPyKr2/yAs+4tn55au1Z3kJOX9r09aJTPqXVHROU1yxuaNQ0ImygtvKjm11et3
 z9/wOa6WUCRf/3vKoPLuOBphFVeiY6uKBJl/fabuORC8YcTKUMHpb4srL0jTw==
X-Google-Smtp-Source: AGHT+IH5f6VFHng8M8OougfG3e/HJQIcW7AGLzAXiBuRunaQgXTFDxQRs+RsHovH8GyiH3PcYcsS1g==
X-Received: by 2002:a05:6a20:7f8b:b0:1e1:9de5:4543 with SMTP id
 adf61e73a8af0-1e5e047021amr79921844637.14.1735841219838; 
 Thu, 02 Jan 2025 10:06:59 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/73] tcg: Remove TCGOP_VECL
Date: Thu,  2 Jan 2025 10:05:45 -0800
Message-ID: <20250102180654.1420056-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This is now redundant with TCGOp.type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      |  1 -
 tcg/optimize.c         |  4 ++--
 tcg/tcg-op-vec.c       |  4 ----
 tcg/tcg.c              | 11 ++++++-----
 docs/devel/tcg-ops.rst | 14 +++++++-------
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 901d89bbfe..467de19f58 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -440,7 +440,6 @@ struct TCGOp {
 #define TCGOP_CALLI(X)    (X)->param1
 #define TCGOP_CALLO(X)    (X)->param2
 
-#define TCGOP_VECL(X)     (X)->param1
 #define TCGOP_VECE(X)     (X)->param2
 
 static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5298597b80..a9d552dd6c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -370,7 +370,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
-        /* TCGOP_VECL and TCGOP_VECE remain unchanged.  */
+        /* op->type and TCGOP_VECE remain unchanged.  */
         new_op = INDEX_op_mov_vec;
         break;
     default:
@@ -2869,7 +2869,7 @@ void tcg_optimize(TCGContext *s)
 
         /* Pre-compute the type of the operation. */
         if (def->flags & TCG_OPF_VECTOR) {
-            ctx.type = TCG_TYPE_V64 + TCGOP_VECL(op);
+            ctx.type = op->type;
         } else if (def->flags & TCG_OPF_64BIT) {
             ctx.type = TCG_TYPE_I64;
         } else {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6ade58da54..7f2297f748 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -143,7 +143,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
 void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
 {
     TCGOp *op = tcg_emit_op(opc, type, 2);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -153,7 +152,6 @@ void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b)
 {
     TCGOp *op = tcg_emit_op(opc, type, 3);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -164,7 +162,6 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b, TCGArg c)
 {
     TCGOp *op = tcg_emit_op(opc, type, 4);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -176,7 +173,6 @@ void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, type, 6);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 717c313b33..8c76b876b5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2632,7 +2632,8 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             nb_cargs = def->nb_cargs;
 
             if (def->flags & TCG_OPF_VECTOR) {
-                col += ne_fprintf(f, "v%d,e%d,", 64 << TCGOP_VECL(op),
+                col += ne_fprintf(f, "v%d,e%d,",
+                                  8 * tcg_type_size(op->type),
                                   8 << TCGOP_VECE(op));
             }
 
@@ -4729,7 +4730,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 
     itype = its->type;
     vece = TCGOP_VECE(op);
-    vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+    vtype = op->type;
 
     if (its->val_type == TEMP_VAL_CONST) {
         /* Propagate constant via movi -> dupi.  */
@@ -5196,8 +5197,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
     default:
         if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, TCGOP_VECL(op), TCGOP_VECE(op),
-                           new_args, const_args);
+            tcg_out_vec_op(s, op->opc, op->type - TCG_TYPE_V64,
+                           TCGOP_VECE(op), new_args, const_args);
         } else {
             tcg_out_op(s, op->opc, new_args, const_args);
         }
@@ -5223,7 +5224,7 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
     TCGTemp *ots, *itsl, *itsh;
-    TCGType vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+    TCGType vtype = op->type;
 
     /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
     tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index d46b625e0e..0929abdaca 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -712,10 +712,10 @@ QEMU specific operations
 Host vector operations
 ----------------------
 
-All of the vector ops have two parameters, ``TCGOP_VECL`` & ``TCGOP_VECE``.
+All of the vector ops have two parameters, ``vec_type`` & ``TCGOP_VECE``.
 The former specifies the length of the vector in log2 64-bit units; the
 latter specifies the length of the element (if applicable) in log2 8-bit units.
-E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
+E.g. TCG_TYPE_V128, and VECE = 2 -> 1 << 2 -> i32.
 
 .. list-table::
 
@@ -729,7 +729,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
    * - dup_vec *v0*, *r1*
 
-     - | Duplicate the low N bits of *r1* into VECL/VECE copies across *v0*.
+     - | Duplicate the low N bits of *r1* into vec_type/VECE copies across *v0*.
 
    * - dupi_vec *v0*, *c*
 
@@ -738,8 +738,8 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
    * - dup2_vec *v0*, *r1*, *r2*
 
-     - | Duplicate *r2*:*r1* into VECL/64 copies across *v0*. This opcode is
-         only present for 32-bit hosts.
+     - | Duplicate *r2*:*r1* into vec_type/64 copies across *v0*.
+         This opcode is only present for 32-bit hosts.
 
    * - add_vec *v0*, *v1*, *v2*
 
@@ -810,7 +810,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
        .. code-block:: c
 
-          for (i = 0; i < VECL/VECE; ++i) {
+          for (i = 0; i < vec_type/VECE; ++i) {
               v0[i] = v1[i] << s2;
           }
 
@@ -832,7 +832,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
        .. code-block:: c
 
-          for (i = 0; i < VECL/VECE; ++i) {
+          for (i = 0; i < vec_type/VECE; ++i) {
               v0[i] = v1[i] << v2[i];
           }
 
-- 
2.43.0


