Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA83E7719B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bE-0002l7-KI; Tue, 07 Jan 2025 03:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aV-0000Qs-Qw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:23 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aN-0003NV-4o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216281bc30fso1719665ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237108; x=1736841908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9a80YL4E9gvAHs0oLsPLUBevNHIdEyogsQJy6GNuq/k=;
 b=YeJ4B/JAUFIiIHK5Khi+Msm1IwX129jUZooyHjAS+7KT8Yto4hqAHWhSqheo50zVBE
 zoB/G+76j8ryTmWnIiLfR8vHtVHf6AaOlClgwCDM/S55yvWgp7Kqf3RdiaTdeX2cWAnH
 q6v/QHVkTWxMikk1ssxxX+0UfrIG2mqk06vl2MylumkBtuqVTVv4vEJrDzD8IBIeQ0an
 eFXiDqMvuj9Vsc4siTqaplxlnrKylQkR64bfdiOnU6Hl4XpTe4ZrLImztkLYpJv9VsC+
 b5EXJ7u8//y33fSTc5bOfaB/Qq2XJNYlggDpXXDXQkTt8oAWvuHro1Ao1Wf8PdE+S6YS
 d3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237108; x=1736841908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9a80YL4E9gvAHs0oLsPLUBevNHIdEyogsQJy6GNuq/k=;
 b=SUNMFo9MmhyegsyhmttWbEXQ4Slhd4KMun4er47xxKhnHVmdY2ZuUUmUrkMyzv6ai2
 g48q/kkiZsXB9gHBBcaBkQtza3F69CupLE9P9kBVeUHq5SrrS+wGK0ZgL5ng/9CqNC3P
 1dN46myMHB/fMqMYbFVTLLIPFrv2DH4U9UI5EPDbOrgnRSMWHY4d/b7s4NRDWtqxIlJj
 zv+J7i5IrMJwp9TC3KSpPaueuiUPFvJNhhtPOmA+yj8/z2eFEFs008c7Tj5l5R9zm95z
 00w1eE4pJTJkIv+PmOnWDUmHGngXD46YSZHXVHDJi4kBHKA0jSTaJATYXWBVq/CKtVYr
 qxDA==
X-Gm-Message-State: AOJu0Yyfbh0MbpeRPOpeo/4GrGa9UX6VzxK+kL/OSVdUeusw75L/c6bW
 v2zeBkB7roiCmZ7GlTM2j/2wuvr55cGDGfKf9Wd828dkja7/xZuRzLw5YfQQEFQM7wcCnFn8kSV
 i
X-Gm-Gg: ASbGnctfeBkcxS9wZ8gccLbf7famn8iONNdnNXN7Oq17epZeCxqnXZKWB3nqTTZ+A1K
 yTfBPqidUptLZ7UpFIr6uu07W0yOd3E8xyudVCvicCG1zVzWw/hALaXgB2O4+emf15UL1Fqp78T
 qmpKdwPyplf9ZfsCKxE8/MClt4F7q5adSaeDCPW7Lv91+BREVNQL/HAJYxERPqC8S213OztQ1l/
 q4txGLRUYt5Wxo3WfUeESZnB2FGy2wonVhiyzYj5icqkQQlreTrpLJThPAG8LC9Vv9D7J2zeCq9
 aFh5YHxBNipdk3JQIA==
X-Google-Smtp-Source: AGHT+IHCyP5CUMXdugcA6Tp8gIDEqjk1CKbCQkguUpTrgSVjW0owEV2yGGts2zCCLPG7ytVdfWrx+w==
X-Received: by 2002:a05:6300:6f95:b0:1e1:e2d9:7f3b with SMTP id
 adf61e73a8af0-1e5e080cb6bmr73168945637.38.1736237108353; 
 Tue, 07 Jan 2025 00:05:08 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 50/81] tcg: Add all_outop[]
Date: Tue,  7 Jan 2025 00:00:41 -0800
Message-ID: <20250107080112.1175095-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Add infrastructure for more consolidated output of opcodes.
The base structure allows for constraints to be either static
or dynamic, and for the existence of those constraints to
replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1736cf664b..7effb17b32 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -862,6 +862,8 @@ static int tcg_out_pool_finalize(TCGContext *s)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
+    C_NotReached = -3,
+    C_Dynamic = -2,
     C_NotImplemented = -1,
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
@@ -955,6 +957,11 @@ static const TCGConstraintSet constraint_sets[] = {
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
+typedef struct TCGOutOp {
+    TCGConstraintSetIndex static_constraint;
+    TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
+} TCGOutOp;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -964,6 +971,14 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+static const TCGOutOp outop_notreached = {
+    .static_constraint = C_NotReached,
+};
+
+static const TCGOutOp * const all_outop[NB_OPS] = {
+    [0 ... NB_OPS - 1] = &outop_notreached,
+};
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -2410,8 +2425,32 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return has_type && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
-        tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
+        if (op < INDEX_op_last_generic) {
+            const TCGOutOp *outop;
+            TCGConstraintSetIndex con_set;
+
+            if (!has_type) {
+                return false;
+            }
+
+            outop = all_outop[op];
+            tcg_debug_assert(outop != NULL);
+
+            con_set = outop->static_constraint;
+            if (con_set == C_Dynamic) {
+                con_set = outop->dynamic_constraint(type, flags);
+            }
+            if (con_set >= 0) {
+                return true;
+            }
+            tcg_debug_assert(con_set == C_NotImplemented);
+            return false;
+        }
+        tcg_debug_assert(op < NB_OPS);
         return true;
+
+    case INDEX_op_last_generic:
+        g_assert_not_reached();
     }
 }
 
@@ -3331,18 +3370,25 @@ static void process_constraint_sets(TCGContext *s)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGOpcode opc = op->opc;
+    TCGType type = TCGOP_TYPE(op);
+    unsigned flags = TCGOP_FLAGS(op);
+    const TCGOpDef *def = &tcg_op_defs[opc];
+    const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
 
-#ifdef CONFIG_DEBUG_TCG
-    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
-#endif
-
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
     }
 
-    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+    if (outop) {
+        con_set = outop->static_constraint;
+        if (con_set == C_Dynamic) {
+            con_set = outop->dynamic_constraint(type, flags);
+        }
+    } else {
+        con_set = tcg_target_op_def(opc, type, flags);
+    }
     tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
 
     /* The constraint arguments must match TCGOpcode arguments. */
-- 
2.43.0


