Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8A9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmH-0005Tq-6t; Sun, 16 Feb 2025 18:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmF-0005TV-N5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:19 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmC-0005Br-9P
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:18 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0b9so1517147a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747414; x=1740352214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b0p2g4sOl26LPe67Sxq813mAyPE6hn7JbCwtsVy2quc=;
 b=lcc51JGUTJOvWqa3GxGVxWoBMb9+Mr3JDuV0qfFY4TKIwwl4Q1iXghAI/3xdLKOc4i
 2Bqh6dKBFlz34J67hkpVwWSQmPzlmTpMP1mxI1sXUMVbRfeFaTqRNiF/UnIDkWqBRHM5
 c0XCqFlhTDxvPc/pRusADBWZ5oYw5flObk8RoLvgi6ydRT8LrK0XFufXIQJ2mHFV6X14
 /ttNNY+5WgpUy6fYanjvuT5XgUq8KPUmSTmNaPx2lySIMvHFZbzTqYveITUFUrVyVz5v
 GI58+f5lJXNrYQ3MTWAxtRkxUX4YncNztTkWGk/wt7OcZQSDsVYrVIOh/P6xkckd6+0a
 6A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747414; x=1740352214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0p2g4sOl26LPe67Sxq813mAyPE6hn7JbCwtsVy2quc=;
 b=g3dQxjUA9m7kfznhX39p6rZfD04xMWO4YTRfgONq583N4bwJEG0rNBv/42SpbuUZIV
 IMVgmjnQQSx2IaeFL6jYkkRHc+WkDSr7wqJy0JuDh8UXfYIbUHpy+0JQxEGOYRPfWfKd
 3+t3bCt/j5rLL9vi8/K0IPWRhLSk6TGzSxXkazMuKyewyTAg/yS8ewHg7Y+sAyA5a1o0
 4nONfb+zaXjr5eYWuXSppyMF7TY2z7vGHYcZPZReTHfyVi0S8VtrQGkBBBVeMUgITRGo
 pViLQrQcnzoazQgWOIxVcAEB/N5XeqGhOM1ZaWLjvohs0RiVeUBAyXtKHUesrrIF6q3K
 2DNg==
X-Gm-Message-State: AOJu0YzS/v7kr94s7zAmzFX8IGze1+OPBat8UYs3RZX2aQOA3Y0HI5zs
 QliL8dkqdT47uEFefmTu33tq0ODUvYHuY8s6ThQpIjPZtFWbYklWEjcH4wjMlXL8nIYI0Tnpjbo
 0
X-Gm-Gg: ASbGnctKmEFjMUa+F1I3BogJm21Wqk7knxfqQGQS1u/dBEhUl+dHtw+HyQ6ihAEc20B
 MTfHXMzE4dTU6pnsYTDwBIa9dF3VccWYZ4n2ybAiPERAdY97Dw2sCPgA2oivAYeA0CWhZnWp1Cb
 i/cDGOzMUonfmNueqrgGqfcqHHD7AbABY7Q0aoS6bIg1uuQiKKctJeafYhj4uVb3Tf50UkSPAT5
 KkGwFoeFmyBhO+zbxlo6SgFR/NftZ7V8FinRJHCoGPXz35bDFhIWQuC3tLB2Og7OdXAzJ5TcHiO
 cTmAA+n4aocV+m3Hf/rXkOH2zAm6nbGMOk7/b+LTIAPUYas=
X-Google-Smtp-Source: AGHT+IGil22Ru8l9FJ89HRgwgFL9YeYJQZ/y4ygQ62YhSFH1C5D5A130HUEZZIM2Sji8ubrTa0CBvw==
X-Received: by 2002:a17:90b:3842:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2fc40d13ea8mr12254712a91.4.1739747414410; 
 Sun, 16 Feb 2025 15:10:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 001/162] tcg: Add all_outop[]
Date: Sun, 16 Feb 2025 15:07:30 -0800
Message-ID: <20250216231012.2808572-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 tcg/tcg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8950df2ad..96c29536b6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -861,6 +861,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
+    C_Dynamic = -2,
     C_NotImplemented = -1,
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
@@ -954,6 +955,29 @@ static const TCGConstraintSet constraint_sets[] = {
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
+/*
+ * TCGOutOp is the base class for a set of structures that describe how
+ * to generate code for a given TCGOpcode.
+ *
+ * @static_constraint:
+ *   C_NotImplemented: The TCGOpcode is not supported by the backend.
+ *   C_Dynamic:        Use @dynamic_constraint to select a constraint set
+ *                     based on any of @type, @flags, or host isa.
+ *   Otherwise:        The register allocation constrains for the TCGOpcode.
+ *
+ * Subclasses of TCGOutOp will define a set of output routines that may
+ * be used.  Such routines will often be selected by the set of registers
+ * and constants that come out of register allocation.  The set of
+ * routines that are provided will guide the set of constraints that are
+ * legal.  In particular, assume that tcg_optimize() has done its job in
+ * swapping commutative operands and folding operations for which all
+ * operands are constant.
+ */
+typedef struct TCGOutOp {
+    TCGConstraintSetIndex static_constraint;
+    TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
+} TCGOutOp;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -963,6 +987,10 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+/* Register allocation descriptions for every TCGOpcode. */
+static const TCGOutOp * const all_outop[NB_OPS] = {
+};
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -2416,8 +2444,32 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
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
 
@@ -3335,19 +3387,27 @@ static void process_constraint_sets(void)
 
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
-    tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
+    if (outop) {
+        con_set = outop->static_constraint;
+        if (con_set == C_Dynamic) {
+            con_set = outop->dynamic_constraint(type, flags);
+        }
+    } else {
+        con_set = tcg_target_op_def(opc, type, flags);
+    }
+    tcg_debug_assert(con_set >= 0);
+    tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
 
     /* The constraint arguments must match TCGOpcode arguments. */
     tcg_debug_assert(constraint_sets[con_set].nb_oargs == def->nb_oargs);
-- 
2.43.0


