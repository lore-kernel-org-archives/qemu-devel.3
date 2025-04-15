Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC0C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luQ-0008Oo-IH; Tue, 15 Apr 2025 15:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luM-0008MC-VL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luK-0007uy-Hg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso6703734b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745117; x=1745349917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yI5KeM52d/j0eKECLiPnoO5wPQPoDN1csZucj8po+3M=;
 b=Wolub87Y0qiqofKCOOhzdcXchuvSM3/t0Ce9gO8/2xMxqXR3WJR3t7DNOrTQjfbYB2
 xqqz/yUPeX+VY6Pud8mcJ6RW1HNJWQqzjDZAWhu3l7WIZMAaB3D4EYwtama8zzosn800
 wlN/vpgLVkcg7x4+TPv4ec66lbz1P+rTuQ210fEbsEnbKRy06+3V+yz+/MASy4ReYnL/
 MU8nbBaIZbfljypxoI+ODJfxVU21k7yuwZf33V9d2+ij98LU4wTbzgpMfKpAigjjTgJv
 bavWKt3pSN/2pG6gEUkuZutlkQ4KpGOvkSBTRtSd0vfqv5/QzZRr2iO087+pg0pJ/97j
 picw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745117; x=1745349917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yI5KeM52d/j0eKECLiPnoO5wPQPoDN1csZucj8po+3M=;
 b=MlaVliEcRW2f+BLCCTCc5ytnZP/bpkZjM3eVdE1RcqWO12PX2jXsWP/Z8xevewnEeu
 imdQ6GXLKtOE64FWtozZopklZYERW+NP+yp0tIipvfx4H0VDCV1x9DVbSIBNtJmQ6ea4
 eHibzxRBthpyRRWxaZRn08SJP+S01/KTlF9EM3IIKwU/UsOTUh3GTZlfYr3WcUJviizo
 Brragaz6z49ueL4olTbu49rSUygbaXD/SfosYhS4SpQL4AcE0dB9fUkRnoRFsgL+3L40
 irrBb/NlNEapld9Q2MGhlnAegFvqb4TsKJN/YXhC+kLrHrIMMBgx3yVArB2GtsqVPIru
 FVTw==
X-Gm-Message-State: AOJu0YygCctcnJQ1+8LC3TkmfFT11noiwi0Yu0/Z256OrIflqlnNhqSS
 OowCOblsb3f4KWi2H6hrUzBTWijtUUOwHhwVE8et6JoBr1d5avuLKlsyxlcCTovqGqsc8jiGVS9
 j
X-Gm-Gg: ASbGncujHToMUbRpnQ11KU6smaivPwqG3v1qyCWqi7kQ37nTRQ7d8AHIhmGT71tqcXO
 Xy6Kz6mHUUSWiLnTp35guKamMdBi1g6bBvEHTwwKqV8tkit+RT6Gbq5NDne5GM3nxWier7PlI/Y
 rkJA63y3GR3+CCWwzSv2ZWTBAht0sDa18F7QqgdLv7VajqCeIAVXU40wiZ7b0upF5d2wnB7DiBD
 1UJSnAm04F2naaci1lIWqF587nMGnAkPLRrdv1TqOU6f0cmLP4F4l539wpdQwcMV47NPGO1KQaa
 mtTkZPdfq5uFYj37/ngCcmVY443mzTKnJ/k6hVREf6TpOmaucuJLXWu6EqhzlPNHMFoF4mFlP2e
 d9zq/j6CR5w==
X-Google-Smtp-Source: AGHT+IEA8r6LaE7GBJSBVF85VtXIVGEKWkdhCuNIhj5+WGDFrXVdZxTuaLcN5MA5j/v+G8G1WK4NRA==
X-Received: by 2002:a05:6a00:398d:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-73c1f8c3d99mr929890b3a.4.1744745117303; 
 Tue, 15 Apr 2025 12:25:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 001/163] tcg: Add all_outop[]
Date: Tue, 15 Apr 2025 12:22:32 -0700
Message-ID: <20250415192515.232910-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..ae98ca325e 100644
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


