Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95461606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hzOohJnN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6a7-0006QP-II; Wed, 28 Oct 2026 12:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a5-0006PN-Dj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:53 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a2-0007VC-NB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:53 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6dd4f3f696aso690420eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205169; x=1793809969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mwxXAe8gLx4Kv98pFPow54XcNdRbMEjAe+UH66vUv1c=;
 b=hzOohJnN0iTNxYB8GFjRWBEq+mQxHYXv86+r++DkyHu6RK5ff8DYZLhpO7dJ/1cYg+
 8XCfvyEAdsuWGhcqJrfz4cZEBbs7LW0DCRLhWf+/q1+RhPKWy7+ma+9Gbut1g1+xUizP
 EHHECuHsUeH0Bs9UnX8HDEfsp5EXA2Mp7pRevvqk9XRp0HI3QXxh68BYx7IqaVmnkzZs
 ZFrQozRxD0JaX195VEEsw23jJMlfyIEqN2v+sdnmrrSrAzOKZQP8hF3e8vEzcozlKU/g
 g4bOm4tThMws/85eALIiyqOItpphky6qMfckl7MKAKWT9BYhvWzAHUTGObbi4/FtI9bR
 nZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205169; x=1793809969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mwxXAe8gLx4Kv98pFPow54XcNdRbMEjAe+UH66vUv1c=;
 b=ix7669OauwMN++AXoXs+5y/4/oqwk55gwfVdcEGruUYbozXnC0TXF3F7VSaxuKLBRZ
 o09e9FJcpoP9YaUw9EDE7kJwFHA8s4BNWplyAeb7M+uRwgjBR9Onw6io/wr5oQEyaRkE
 lN1TQ+M/wGT9hO2vQgfg284NRSX2q+TeQn7i69HPO43xZhf0aKTS93lDuCfLMzTYf5fM
 iR4Kg50dj8hmesSV0WkKP03eoylYG6vtD7Mx/thoCKscQRs+iBTPDKuRTMjlYgZJ4eqR
 lSp/WoE4AexFOhDasL6+zp6C7fqCqUEL2KwN0mCDqNIkNsGHYPfJtjKi8jUuCC71WVXU
 EvWw==
X-Gm-Message-State: AFq9FYIFIjrRhpOnfMN8e7DsNPLKgpuwBTVfFVam8Ae80Xpg41+a/Whg
 /meDpD0RV4AySLMN4C9h/kSkOiRbAWlrhEtiecBstKoOIMRwPc2rwbbet5oLIj0cJSqk7R5JLyI
 qkJT2
X-Gm-Gg: AYBFou0/21XCXPdYEfvOtKYszMmUlOhFqm9mLu52QnUCwxXuo30GjtnzA0eOrgz83Gt
 Bvwy2sR+t8/ESoq9RVWZ2IpM5uGyxaGrvW4cJ9Wu1/VreEJkdrCM+PGbkxf+CUNV4sWfvtgh/mZ
 /K6N1toCegonVJR1Ri37qlWkLPYgCsN5lN+wFKUNSspvqkjpnhQ3PlSbW4uZnmoUimreUb4bTCq
 rsPYgqABrpWKFJahU2tLg0n9e8e4MdKMDaMLiSDYjyu4FKaHuVRS3+W6Lw8fegh8tTqE0j+ki9S
 3rFxApyR4HKKYgUJr3Zwdp9fVClc5pXpGwpx6Iz3YD0wIRJI4UVLDzH9zqsdcGJ/Z0z1B3rdi6X
 WgRNmgCDeqktPB4BfWPQ/WuaDodMqWzn/HrJGY/gvZkru6pHfLL3Sm089zypAUEzMXsCzwFWQa4
 Ltm6RyMoh/DVYnPbjb5xGbF8LF3LlVvaAgUeJ2mMCGI+60mn7tkCWFkIXrLt0iLzlstoQjme2ju
 sjqOb9TGsqchkLuthXa6KpzlOMYEvJIWIR9HxfwiZXyEIJyL86RJ+h4txXatTGty8YFvVeMsUNh
 zZEW2Z1mJy+l6zAKs3dzckygmJh6kLrc7Q==
X-Received: by 2002:a05:6820:83d7:20b0:6be:139:c032 with SMTP id
 006d021491bc7-713ee85cb96mr1197451eaf.18.1793205168995; 
 Wed, 28 Oct 2026 09:32:48 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 01/16] tcg: Add INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:30 -0500
Message-ID: <20261028163245.1031673-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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


