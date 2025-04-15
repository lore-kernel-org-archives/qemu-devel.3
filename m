Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04116C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGx-0002Rd-E3; Tue, 15 Apr 2025 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9N-0005eM-Mp
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:56 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8R-00064w-VG
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3fea67e64caso3547979b6e.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745980; x=1745350780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6k79lv7zSVWIYNlpIo8u+i+Gnj8j2MqYEzyJZ61dgkc=;
 b=nKXwkuY70pniA9tFEtBncWrRJCK98ijDyFiW//3PocDK8anBcec0ust01B98IzBfRB
 29wHtEqICsm2WEl5NwnK5+JCPlUXI4Ck5+nFMElPxjT9bETIhjrC52NXRMPhgb4jHX8E
 WY4VmjJyDeKg6pd/vBPcrwn9mGt0d6+3iECn5mSIKyL9IZ0Wi5VhkReB1dzyjWCkHdRg
 Xnb3m0V8ocvIXXP6MqEgBPW29cBZrbAcMwuyuEFb+FWinqPha1sQDaHH0EFFk0WPWAbs
 /LKL7pti+S36C4heBBdQYbYCLNM0KojDrxysAJ49yN6yyQwmNAzd2kpr8KG5IZ0gjUek
 xzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745980; x=1745350780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6k79lv7zSVWIYNlpIo8u+i+Gnj8j2MqYEzyJZ61dgkc=;
 b=BkvJ3mDg8eQk8EpQm5O5hLBTpL8l4jJZWL20/te1GruXV57/LaYTQbPtB0xR8m00e7
 mFuDE8+cj2XCvurTV/JeJNEzPOmhfOBpZt3RfHYXGBENk0RgGRjEc435T1WJp7p7NwNV
 uLiOJlwVV3f5pwMOTa55q6l5EzMXV8Pun5GqrTlylrzyeLi+VPgLYM8c0Y2rSmz7Aptc
 tr+OyLKPO7MhySifb8rrvu3aauhurf2XHPkMKR8lCs+WRZns5RT0klsnIHrTHjsryY8E
 u+VmDO8tbOIf6sKlGhm5MuRTUeBzEIkFMUHd0jvPz6+bAKdXAARb9bEkxjzlXVXZMZA+
 DQSw==
X-Gm-Message-State: AOJu0YwHGdPQfnusNVFxCXrA4btO8+dbUlArbpyC+XpxzBp5uxBxNXrv
 +PpS3LyrzKmcJW4k58zxP3MQcEllvte2FefuYiBzNcnHggi5uX9BtDsYvuci0nIjSbvexRcXi61
 n
X-Gm-Gg: ASbGncvtXpLia1n3HxBpj1d2sMLS0NLyqh4VxKLX7BzYkAoYYGrabIamlv9qMgS306D
 IpKBAQ3p9sCAinTfsrT3wVMYFjTUs8XFXifDs3ND/09Zj8P8PwnHKqxGPcwLn8pHUvOrpmo80oY
 s1NzLKeZfouQ12gKvUNPxHOtX5OKungbtUALs1Anku7LyO3Y/QEdYnDPoflZ1egpXMZv4XbmlX9
 jgh7Cdn4WvjAQDxyI6oqOhytyc0vhhVk4oxeVVrK8zrffDWtDOcAwGMoCwAHKHyt9JTCMExaVvs
 dQZAauZ9yPlTdIQtxmfrUSLtX7tcKxGjfgKluSQaSM5EOgilbqC6MGS8W8tmE3Uw8QYiQixasPo
 =
X-Google-Smtp-Source: AGHT+IGQkxp0WC1mT6seJenLKA9aKFB9K12cLflz+k6AZYgz8DLeNnBxkXtmVkCKyv68l2J7brTZPw==
X-Received: by 2002:a17:903:228e:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22c31aacac8mr5395435ad.44.1744745572159; 
 Tue, 15 Apr 2025 12:32:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 114/163] tcg: Add TCGOutOp structures for add/sub carry
 opcodes
Date: Tue, 15 Apr 2025 12:24:25 -0700
Message-ID: <20250415192515.232910-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 tcg/tcg.c                        | 61 +++++++++++++++++++++++++++-----
 tcg/aarch64/tcg-target.c.inc     | 34 ++++++++++++++++++
 tcg/arm/tcg-target.c.inc         | 34 ++++++++++++++++++
 tcg/i386/tcg-target.c.inc        | 34 ++++++++++++++++++
 tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++
 tcg/mips/tcg-target.c.inc        | 34 ++++++++++++++++++
 tcg/ppc/tcg-target.c.inc         | 34 ++++++++++++++++++
 tcg/riscv/tcg-target.c.inc       | 34 ++++++++++++++++++
 tcg/s390x/tcg-target.c.inc       | 34 ++++++++++++++++++
 tcg/sparc64/tcg-target.c.inc     | 34 ++++++++++++++++++
 tcg/tci/tcg-target.c.inc         | 34 ++++++++++++++++++
 11 files changed, 393 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c6a49f5648..1db9796964 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -133,6 +133,8 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
+static void tcg_out_set_carry(TCGContext *s);
+static void tcg_out_set_borrow(TCGContext *s);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
@@ -978,6 +980,18 @@ typedef struct TCGOutOp {
     TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
 } TCGOutOp;
 
+typedef struct TCGOutOpAddSubCarry {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rri)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, tcg_target_long a2);
+    void (*out_rir)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, TCGReg a2);
+    void (*out_rii)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, tcg_target_long a2);
+} TCGOutOpAddSubCarry;
+
 typedef struct TCGOutOpBinary {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1131,6 +1145,11 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_addci, TCGOutOpAddSubCarry, outop_addci),
+    OUTOP(INDEX_op_addcio, TCGOutOpBinary, outop_addcio),
+    OUTOP(INDEX_op_addco, TCGOutOpBinary, outop_addco),
+    /* addc1o is implemented with set_carry + addcio */
+    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
@@ -1170,6 +1189,11 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
+    OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
+    OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
+    /* subb1o is implemented with set_borrow + subbio */
+    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
 #if TCG_TARGET_REG_BITS == 32
@@ -5564,7 +5588,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
+    case INDEX_op_addc1o:
+        tcg_out_set_carry(s);
+        /* fall through */
     case INDEX_op_add:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
@@ -5603,8 +5632,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_sub:
         {
-            const TCGOutOpSubtract *out =
-                container_of(all_outop[op->opc], TCGOutOpSubtract, base);
+            const TCGOutOpSubtract *out = &outop_sub;
 
             /*
              * Constants should never appear in the second source operand.
@@ -5619,15 +5647,32 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_addco:
-    case INDEX_op_subbo:
+    case INDEX_op_subb1o:
+        tcg_out_set_borrow(s);
+        /* fall through */
     case INDEX_op_addci:
     case INDEX_op_subbi:
-    case INDEX_op_addcio:
     case INDEX_op_subbio:
-    case INDEX_op_addc1o:
-    case INDEX_op_subb1o:
-        g_assert_not_reached();
+    case INDEX_op_subbo:
+        {
+            const TCGOutOpAddSubCarry *out =
+                container_of(all_outop[op->opc], TCGOutOpAddSubCarry, base);
+
+            if (const_args[2]) {
+                if (const_args[1]) {
+                    out->out_rii(s, type, new_args[0],
+                                 new_args[1], new_args[2]);
+                } else {
+                    out->out_rri(s, type, new_args[0],
+                                 new_args[1], new_args[2]);
+                }
+            } else if (const_args[1]) {
+                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
 
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bece494c55..87f8c98ed7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2078,6 +2078,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2421,6 +2438,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f366424af5..aa0397520d 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1826,6 +1826,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2135,6 +2152,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2b2ad9ca95..04e31cae12 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2629,6 +2629,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3054,6 +3071,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 735dcc117a..937f19fe6b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1326,6 +1326,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tcg_out_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1715,6 +1732,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e69781b871..0c268cef42 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1593,6 +1593,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2044,6 +2061,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a964239aab..5b04655f3b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2863,6 +2863,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3267,6 +3284,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dce46dcba6..707ebb8f6d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1947,6 +1947,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2333,6 +2350,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ff06834e6e..a30afb455e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2248,6 +2248,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2766,6 +2783,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 4c7d916302..12f0dbd23d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1381,6 +1381,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1717,6 +1734,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9a5ca9c778..bba96d7a19 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -573,6 +573,23 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -893,6 +910,23 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


