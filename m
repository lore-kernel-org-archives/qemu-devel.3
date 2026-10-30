Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l1NtMFR0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTS-0003il-Jp; Fri, 30 Oct 2026 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSr-0002jJ-Lw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0005VG-7X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:08 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8470d7d430fso284889a34.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366160; x=1793970960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mwxXAe8gLx4Kv98pFPow54XcNdRbMEjAe+UH66vUv1c=;
 b=l1NtMFR0nxiRwtZz300q+AxL7WDip5ipmBCPyL36J8//5Q/KETSAj1br6GsVmaz/qn
 Vr55o7dtgvGsv4YN+nZrhwh4AsPDlktURMAzbh7AkgoFni1fLMyy0/eVQuj57LLWlBpX
 bTGZguk9YHZiYLyStvKgPdGLYzIR2E2Z7+92rBgZC3rvR0HtQc33IAC7VbsCxE7UPRGZ
 bUGvyWRPTljXpKU6aRvbs/GUmaiQe2N4HdujTRSVj4QrLZZ9e/LPONQ9Hj00OtoiP08n
 ICquXsqcj8r0O+J941oLVU0JK/e6gVOhKOkJmrHvVaa60wFHaE1WmQAbH/rrSLMiF0ui
 Gy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366160; x=1793970960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mwxXAe8gLx4Kv98pFPow54XcNdRbMEjAe+UH66vUv1c=;
 b=l428dOtWEpQ9YfgY8wxF4ynh3CnkLMMPa7o1UNW7BjycCV/wI7XwKH8PQkcKRzREXe
 cIJn3DrVsGoMsR8ah2rGHQOS6B45E+T4uV0OtuFj3zydEpAEEpx3ipDtJtHxLW2+i39j
 kAsymvk0kUllY57xmTXx6oTJD8v5B00YKNZVagIAipYNjW3eNTbhYPr02G7cjwJO/aM5
 kBQfnypaQNA8x0sDUSLzSDUbE9x7QRuNNIzQc1Ze9yCVL+I1Oah9QdSJ8CUNtKWivESn
 4iIlAWHbEacii717J0pcZ2THPnXkHb72IrppAi/XRG6TXoCFRkOuoRNkr6AyTu4KxbQ1
 3T3w==
X-Gm-Message-State: AFq9FYK8lTupYZXLpprEcVcLHiuTkVSE2ind+qZj2ZoSYxRBpB+oz1qp
 LaXMmpKt1WFuiU3qfsXigSiz7X5jKCHFgQlv5UnLsTIWA++TWpFjJ0v/CO9JWB/yiWkDOtz82PI
 19u5X
X-Gm-Gg: AYBFou24h2gMvGsnNKyYXXEI39KNqFBGkGkRNiKn6ntCwrRE2ElBm8W2zYKd9bQ0xXu
 G39+4jms5j+O8FwVr5q2LWWXECF/Sa3HhU1eN5H5as+1I8mMsjrNb5jFO+EfupUQ1NxN5bLaakw
 evjvCSIXGqT3OIFNMg3s6rONp9L9olC/sJ98Hzyf6zGXqxa6Rg4YKIu6lWOQYl+IZjJfW0hxNt4
 xkVVzysvwl20cZN+YY99zAJ3mkgAsgQ6rAQeU62fvb2ckHqhad++XTEnY3rumxdamU716d54yrX
 NmbQGOxldBEesvYG1oJbMTgsWzlsha/2IMSEpGTWMGZ8YzTYUsdcNCZVgfcrgtwflaO4eXn1Jq7
 bFrqEf2jWeOxmTDb+605WwbftwZnO8XEBDxlPmccfoI+zuDeRGNw8KKI7uMsIyZMInk2ZnXR+wH
 EmEcs+ZwhD54r3d0IJpDk+H+hO+w8EAO0I51QTffezcUQQJ0K74H3UKj7jqjuQr2b8NB50rheaR
 duGUg39ixyUWY+tgrObLc/JGFwRMJ+Xqv3dUVn9yu+BH2xTf9LFiAQbmvGAJIjZ/vVGHFPjUYru
 5/VEAxas1tYc7cSAvO+2S4UweT0FeA==
X-Received: by 2002:a05:6808:6415:b0:564:b24:af6a with SMTP id
 5614622812f47-5640dde8044mr1499495b6e.38.1793366159995; 
 Fri, 30 Oct 2026 06:15:59 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:15:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/19] tcg: Add INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:39 -0500
Message-ID: <20261030131554.41208-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an opcode for compound address formation.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst           |  4 ++++
 include/tcg/tcg-opc.h            |  1 +
 tcg/aarch64/tcg-target-has.h     |  3 +++
 tcg/loongarch64/tcg-target-has.h |  3 +++
 tcg/ppc64/tcg-target-has.h       |  3 +++
 tcg/riscv64/tcg-target-has.h     |  3 +++
 tcg/s390x/tcg-target-has.h       |  3 +++
 tcg/sparc64/tcg-target-has.h     |  3 +++
 tcg/tci/tcg-target-has.h         |  3 +++
 tcg/x86_64/tcg-target-has.h      |  3 +++
 tcg/tcg.c                        | 22 ++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/ppc64/tcg-target.c.inc       |  3 +++
 tcg/riscv64/tcg-target.c.inc     |  3 +++
 tcg/s390x/tcg-target.c.inc       |  3 +++
 tcg/sparc64/tcg-target.c.inc     |  3 +++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 tcg/x86_64/tcg-target.c.inc      |  4 ++++
 19 files changed, 79 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 88d48a1f99..51fa183e91 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -524,6 +524,10 @@ Misc
 
      - | Reverse the 64 bits of input *t1* with output in *dest*.
 
+   * - lea *dest*, *t1*, *t2*, *sh*, *imm*
+
+     - | *dest* = *t1* + (*t2* << *sh*) + *imm*.
+
 Conditional moves
 -----------------
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f3a81d5d7f..884345afe5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,6 +64,7 @@ DEF(ld16s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32u, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld, 1, 1, 1, TCG_OPF_INT)
+DEF(lea, 1, 2, 2, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 69e83efb69..86672b2eab 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,4 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 32abc6f457..31e6ea9632 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,4 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/ppc64/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
index a3711feeae..d11d82f184 100644
--- a/tcg/ppc64/tcg-target-has.h
+++ b/tcg/ppc64/tcg-target-has.h
@@ -66,4 +66,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index aef10c2d9d..93f8baad09 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,4 +69,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)         0
+#define TCG_TARGET_lea_imm_valid(type, imm)       0
+
 #endif
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 0aeb5ba01a..58e3afe526 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,4 +77,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index b29fd177f6..4182a7c1aa 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,4 +19,7 @@
 
 #define TCG_TARGET_deposit_valid(type, ofs, len) 0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 64742cf0b7..f4f9ddf595 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -17,4 +17,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index d249c1b3e7..6ffae51f92 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,4 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1cd6d41d31..d19c3fb857 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1095,6 +1095,12 @@ typedef struct TCGOutOpSubtract {
                     TCGReg a0, tcg_target_long a1, TCGReg a2);
 } TCGOutOpSubtract;
 
+typedef struct TCGOutOpLea {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                TCGReg a2, unsigned sh, tcg_target_long imm);
+} TCGOutOpLea;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1191,6 +1197,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
+    OUTOP(INDEX_op_lea, TCGOutOpLea, outop_lea),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5796,6 +5803,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_lea:
+        {
+            const TCGOutOpLea *out = &outop_lea;
+            int sh = new_args[3];
+            tcg_target_long imm = new_args[4];
+
+            tcg_debug_assert(!const_args[1]);
+            tcg_debug_assert(!const_args[2]);
+            tcg_debug_assert(TCG_TARGET_lea_sh_valid(type, sh));
+            tcg_debug_assert(TCG_TARGET_lea_imm_valid(type, imm));
+
+            out->out(s, type, new_args[0], new_args[1], new_args[2], sh, imm);
+        }
+        break;
+
     case INDEX_op_goto_ptr:
         tcg_debug_assert(!const_args[0]);
         tcg_out_goto_ptr(s, new_args[0]);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 273462ca61..b601b19c7f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,6 +3081,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69e76807d6..17784d8bbe 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,6 +2098,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index cd1c234367..99f4469f4b 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3633,6 +3633,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 03f32c5819..ec0c8e1af0 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2740,6 +2740,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 4d1a779c47..2fd7012d04 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,6 +3187,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 35cd14a5b6..cb457453ff 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2120,6 +2120,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4cd1c1431c..6942fdbb4e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1220,6 +1220,10 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 /* Test if a constant matches the constraint. */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 590c9c2402..46efee87e6 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3357,6 +3357,10 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
-- 
2.53.0


