Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15DBC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnte-0003PA-VL; Sun, 16 Feb 2025 18:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntD-0002Pz-Kl
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:33 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntA-000622-M4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:31 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220f4dd756eso39371695ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747847; x=1740352647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z6gT+Msb8QzrAEqXW/si7EOpJrx/6qz0s4Hcfc6ydDY=;
 b=Q71cYpiJWSeopH4AFv8ee5kQE5f1D5Bc0HbkDnrBVi/q8hpzxw7oPv3EB8Ua623etf
 wNxMxTDPxPOyGRq5EWSXBkSb4t+FMFtFpk+F4Jr0UImxyMxJydtOzFSlmP+TkiCVPgpZ
 6NufOculr6g3Jr/NCHwn1gvWmYMSf9hABhroXoYseeTGkQlMAWOsGtujpyei4qVV1SKf
 QpPhcwLFnJ0WZSjEJiWpyTVdzou0M8P2QVIVQbSF0D//BKDLZw81ozXAs842UUgBJ4ye
 U6gNqVKey7uDVdoLYB3u/nsSnhLBVgCTqSXY9JjIWn043kM8In986kJn25OgcIaOnrmI
 2e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747847; x=1740352647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6gT+Msb8QzrAEqXW/si7EOpJrx/6qz0s4Hcfc6ydDY=;
 b=vRcyPXUhY4UShmuyd5+yZ/1umcjsMtVynt6QzQNaCURS3oTiN5Wxrz+jhUXAGsRuvx
 6YQtJz03GvP712CTJemWASP0oRA88gvYQWttg40ozyDQDxKKacN3BAu6kzAp9KiJb17S
 PYFxo7mKrmDo/fIotrZGJaedVnnNe7utscOyILxHNUyD5T02qE5vMlMgAVjtqM1301zZ
 BB3WhhwAeB6XpBaX1v/7bX0b2bXRTufbsDYwt1ak5LY+kcsPj3KxlI/h3PuvJlWu94iY
 nmpx3VHQupR6uPSs/YIujc+IKsfGnxYpWZckx05rq8bK0On9XYvjvZX+xYjE+MHcHJKM
 x8TA==
X-Gm-Message-State: AOJu0YwenZnEtswu+0FZ4gBesYjLl0yhqzr2B9/voaQaVdwn3AC8kjqP
 fGJf501+vGwhHg/P+UiqCqO3RNPDjLqPEz8EGjQ4hWd9BMtNp4uWPruIYvhS6HyyV3Vx2hDu2xN
 m
X-Gm-Gg: ASbGncvHqQwjejIlWMJI2+v2cYGI65bvUznADrJq7W47bwhYCS0Tx8IWXU0R0bQgJqw
 DSeoAy1CMK7HH2us5H3lhL1iC/kJWIfiXkF51PPK123Ai1Hdh7l9NEnqaRFqQ2ue2gucy574iO8
 FdbbM6fbh6aI+zCZCOR0irgsPvJe1LcViljrWvkLFT7jzJfP2eLhxhSeAeJgIqaLrgCeD8SsuOO
 cCj7ZAocMGGKpfrhDxMX+nhjG4YVDFvqD+9insnfRx6djuA5R0vrbkGP2cJZd743mqNiG0+faY9
 EqdDCwmMEP43jgnPb+PzPseryTywhf2S3QU2Johe+JCj2DU=
X-Google-Smtp-Source: AGHT+IHbigd4L9RYoSCfjXoHgDamkO5DxHC8bxNwZp1xQDl/eBT1G61h3tzkWchxAELypvTuabrA4g==
X-Received: by 2002:a17:902:f706:b0:21f:71a8:f669 with SMTP id
 d9443c01a7336-221040be573mr130540215ad.38.1739747846736; 
 Sun, 16 Feb 2025 15:17:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 096/162] tcg: Convert ext_i32_i64 to TCGOutOpUnary
Date: Sun, 16 Feb 2025 15:09:05 -0800
Message-ID: <20250216231012.2808572-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 22 +++++++++++++++++++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  2 --
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         |  2 --
 10 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c687e7ccd9..a0ee11d5fa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1068,6 +1068,23 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+#if TCG_TARGET_REG_BITS == 64
+/*
+ * We require these functions for slow-path function calls.
+ * Adapt them generically for opcode output.
+ */
+
+static void tgen_exts_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_exts_i32_i64(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_exts_i32_i64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_exts_i32_i64,
+};
+#endif
+
 /*
  * Register V as the TCGOutOp for O.
  * This verifies that V is of type T, otherwise give a nice compiler error.
@@ -1122,6 +1139,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
+    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
 #endif
 };
 
@@ -5406,9 +5424,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_ext_i32_i64:
-        tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_extu_i32_i64:
         tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
         break;
@@ -5466,6 +5481,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_bswap64:
+    case INDEX_op_ext_i32_i64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 00400f6ea7..68f7a1cec2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3177,7 +3176,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3459a510ea..7bf677fdc3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4001,7 +4000,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c88db7a0e2..e2dbd08e12 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2462,7 +2461,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e041ce2752..00d5bf6d43 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2370,7 +2370,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2397,7 +2396,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3d1ffa9130..fea767573c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4270,7 +4269,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dc2b487844..e5fe15c338 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2877,7 +2876,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_ext_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ab178bebc8..5c5a38c2c8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3471,7 +3470,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0f2bec21e9..e93ef8e7f2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
@@ -1909,7 +1908,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9ba108ef8d..ecff90404f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
@@ -1109,7 +1108,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
-- 
2.43.0


