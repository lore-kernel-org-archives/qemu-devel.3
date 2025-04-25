Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C00C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REH-0002kz-JN; Fri, 25 Apr 2025 18:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBB-0004Ms-Mp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB7-0001vC-4o
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso3838038b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618747; x=1746223547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pz1cy7aHvwwzzh/teMk0HceOOxHY+iI2D2LYcVwkzTw=;
 b=qBvnlYmwvKxPfNRE+KMva7pzlhR4lajlUHMk/qj6SpFeSjSxOkp8BFIRTi57CrtSG4
 C3BQHpf+BDuSOiTE2ZIib4ccGdJnWESQQdHUCjutRpsV075bS4l2fUnbnhwVjCUAwzD8
 e8ucFo/IbeoXBOeFQu/dhOmun/fDXAL/VHGE0/KESoAxmkj2stjqqavcg/wlHayRxVwl
 Xn2S3PiNy3lfp6/ihPdxJk1rFz97JLosqPkjtaBRqV2r7aV7oUizAf6bH8FgMSZJqkSx
 zc/MXScuqxTIb1oE1esyKopUo3l+itb5AMyrSt0mZ9tyGVWMSUsyHyTe3BS2MlaK5Wj1
 jk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618747; x=1746223547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pz1cy7aHvwwzzh/teMk0HceOOxHY+iI2D2LYcVwkzTw=;
 b=bHCdtP5esRkvEWBPr406q1byjRhd3h0EocwWRxOzVe7YiuxWGE/ZV9PqWLoJ3lO3nY
 ha13SKSjDmEIlupa7HQHlKz5bDVUJFtnT+7Lut6k6GLj89wdmhTgVOEd3EjErfn/F12G
 BWwPKcCBIWx968HzOewyPm3TZw1sdy2dwR0Ki2Wn8wdVyqLZhUl0klcOYMJbo7rIwIBi
 08b8rcrU2sz7EGh9EYRGt4XQGvbBH101z3ogSNjbTRaMgRV+SU+jUmgSb4j2FPffjXLt
 qiWU7xV7JRweNCMPa4hPuvNxmM6EkbeOO4MswxZD+Zgx77eJg6YZa4BnilWknddsm4xj
 1nyw==
X-Gm-Message-State: AOJu0YxWNiBhLxz/ai2ycT5YbzNdb/dS0rJ6OJd/qF1Ck7R7ElipMw03
 Q+4TH6o1ejiYKkzBDFhmfetNYwDMANKjuGkpDmGEoWjU2jOBwZtoYJgwTwQmyp4ypJeqEGiCvCd
 9
X-Gm-Gg: ASbGnctUX5fTvwJDCaaXeZwkj2S3HI6RlYGomxEGtPVzxEoAEmj83lOET1YYL1geSm1
 uwhn3yZdZdiD6URVPLtgI0JxF0MeL9/LJTNZTWqYYoGtEweR9C2Bv0hjU81pGu5fbL1pin+vtF0
 no6GXMNHTXLmZ8UiAGs3E2s+QlfRkemYwwGv8KPI8P+IfKDhUe7ER4RtW90HKZXa8I/LE+Q+ePD
 y6bn3G7EpHXYEm2/TS47kZB9D+QYNvQHw4o2HvASEV0qB4Ixsz0Y30NTHjD0Dg0IvHs5rY+7Qpl
 3tzz0dKV1N3eRyOb+Jw1pRp5MONTf29evEZUJiXbDev4qlvrp1IVhvpDXD2Zd65zk/qhJKQktGQ
 =
X-Google-Smtp-Source: AGHT+IHOPiX73X8LB2FzwXR42PK+XwaaFXnuiNzB8weaVOdtuP8N/oWyHvCrlc0AHCEOu9oLfNjnJg==
X-Received: by 2002:a05:6a21:6d93:b0:1f5:6b36:f56c with SMTP id
 adf61e73a8af0-2046a6f3450mr1070732637.39.1745618746990; 
 Fri, 25 Apr 2025 15:05:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 152/159] tcg: Convert st to TCGOutOpStore
Date: Fri, 25 Apr 2025 14:54:46 -0700
Message-ID: <20250425215454.886111-153-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  37 ++++++++++
 tcg/aarch64/tcg-target.c.inc     |  52 +++++++-------
 tcg/arm/tcg-target.c.inc         |  72 +++++++++----------
 tcg/i386/tcg-target.c.inc        | 114 ++++++++++++++-----------------
 tcg/loongarch64/tcg-target.c.inc |  50 +++++++-------
 tcg/mips/tcg-target.c.inc        |  55 ++++++++-------
 tcg/ppc/tcg-target.c.inc         |  52 +++++++-------
 tcg/riscv/tcg-target.c.inc       |  52 +++++++-------
 tcg/s390x/tcg-target.c.inc       |  60 ++++++++--------
 tcg/sparc64/tcg-target.c.inc     |  53 +++++++-------
 tcg/tci/tcg-target.c.inc         |  56 ++++++++-------
 11 files changed, 341 insertions(+), 312 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a9d62d9e17..28791c6567 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1090,6 +1090,14 @@ typedef struct TCGOutOpSetcond2 {
                 TCGArg bl, bool const_bl, TCGArg bh, bool const_bh);
 } TCGOutOpSetcond2;
 
+typedef struct TCGOutOpStore {
+    TCGOutOp base;
+    void (*out_r)(TCGContext *s, TCGType type, TCGReg data,
+                  TCGReg base, intptr_t offset);
+    void (*out_i)(TCGContext *s, TCGType type, tcg_target_long data,
+                  TCGReg base, intptr_t offset);
+} TCGOutOpStore;
+
 typedef struct TCGOutOpSubtract {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1211,6 +1219,12 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
+    OUTOP(INDEX_op_st_i32, TCGOutOpStore, outop_st),
+    OUTOP(INDEX_op_st_i64, TCGOutOpStore, outop_st),
+    OUTOP(INDEX_op_st8_i32, TCGOutOpStore, outop_st8),
+    OUTOP(INDEX_op_st8_i64, TCGOutOpStore, outop_st8),
+    OUTOP(INDEX_op_st16_i32, TCGOutOpStore, outop_st16),
+    OUTOP(INDEX_op_st16_i64, TCGOutOpStore, outop_st16),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
     OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
@@ -1232,6 +1246,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_st32_i64, TCGOutOpStore, outop_st),
 #endif
 };
 
@@ -5779,6 +5794,28 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_st32_i64:
+        /* Use tcg_op_st w/ I32. */
+        type = TCG_TYPE_I32;
+        /* fall through */
+    case INDEX_op_st_i32:
+    case INDEX_op_st_i64:
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+        {
+            const TCGOutOpStore *out =
+                container_of(all_outop[op->opc], TCGOutOpStore, base);
+
+            if (const_args[0]) {
+                out->out_i(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_r(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
+
     case INDEX_op_brcond:
         {
             const TCGOutOpBrcond *out = &outop_brcond;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 903a95ad7e..efdc315a0d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2838,6 +2838,33 @@ static const TCGOutOpLoad outop_ld32s = {
     .out = tgen_ld32s,
 };
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_STRB, data, base, offset, 0);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st8_r,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, I3312_STRH, data, base, offset, 0);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st16_r,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tcg_out_st,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2848,22 +2875,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, I3312_STRB, a0, a1, a2, 0);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, I3312_STRH, a0, a1, a2, 1);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, I3312_STRW, a0, a1, a2, 2);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
-        break;
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, ext);
@@ -3331,15 +3342,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(rz, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 2079dd3bdc..5b34f61ca1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1084,26 +1084,6 @@ static void tcg_out_st32(TCGContext *s, ARMCond cond,
         tcg_out_st32_12(s, cond, rd, rn, offset);
 }
 
-static void tcg_out_st16(TCGContext *s, ARMCond cond,
-                         TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xff || offset < -0xff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_st16_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_st16_8(s, cond, rd, rn, offset);
-}
-
-static void tcg_out_st8(TCGContext *s, ARMCond cond,
-                        TCGReg rd, TCGReg rn, int32_t offset)
-{
-    if (offset > 0xfff || offset < -0xfff) {
-        tcg_out_movi32(s, cond, TCG_REG_TMP, offset);
-        tcg_out_st8_r(s, cond, rd, rn, TCG_REG_TMP);
-    } else
-        tcg_out_st8_12(s, cond, rd, rn, offset);
-}
-
 /*
  * The _goto case is normally between TBs within the same code buffer, and
  * with the code buffer limited to 16MB we wouldn't need the long case.
@@ -2548,21 +2528,48 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg rd,
+                     TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xfff || offset < -0xfff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_st8_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_st8_12(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg rd,
+                      TCGReg rn, ptrdiff_t offset)
+{
+    if (offset > 0xff || offset < -0xff) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, offset);
+        tcg_out_st16_r(s, COND_AL, rd, rn, TCG_REG_TMP);
+    } else {
+        tcg_out_st16_8(s, COND_AL, rd, rn, offset);
+    }
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_st8_i32:
-        tcg_out_st8(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st16_i32:
-        tcg_out_st16(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st_i32:
-        tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2589,11 +2596,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-        return C_O0_I2(r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, q);
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d16ddcb940..52285bcd54 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3489,55 +3489,69 @@ static const TCGOutOpLoad outop_ld32s = {
 };
 #endif
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R, data, base, offset);
+}
+
+static void tgen_st8_i(TCGContext *s, TCGType type, tcg_target_long data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, base, offset);
+    tcg_out8(s, data);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(qi, r),
+    .out_r = tgen_st8_r,
+    .out_i = tgen_st8_i,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16, data, base, offset);
+}
+
+static void tgen_st16_i(TCGContext *s, TCGType type, tcg_target_long data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16, 0, base, offset);
+    tcg_out16(s, data);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(ri, r),
+    .out_r = tgen_st16_r,
+    .out_i = tgen_st16_i,
+};
+
+static void tgen_st_i(TCGContext *s, TCGType type, tcg_target_long data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    bool ok = tcg_out_sti(s, type, data, base, offset);
+    tcg_debug_assert(ok);
+}
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(re, r),
+    .out_r = tcg_out_st,
+    .out_i = tgen_st_i,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
 
-#if TCG_TARGET_REG_BITS == 64
-# define OP_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i64): \
-        case glue(glue(INDEX_op_, x), _i32)
-#else
-# define OP_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i32)
-#endif
-
     /* Hoist the loads of the most common arguments.  */
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
 
     switch (opc) {
-    OP_32_64(st8):
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, a1, a2);
-            tcg_out8(s, a0);
-        } else {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R, a0, a1, a2);
-        }
-        break;
-    OP_32_64(st16):
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16, 0, a1, a2);
-            tcg_out16(s, a0);
-        } else {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16, a0, a1, a2);
-        }
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_st32_i64:
-#endif
-    case INDEX_op_st_i32:
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz, 0, a1, a2);
-            tcg_out32(s, a0);
-        } else {
-            tcg_out_st(s, TCG_TYPE_I32, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
@@ -3569,25 +3583,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_st_i64:
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW, 0, a1, a2);
-            tcg_out32(s, a0);
-        } else {
-            tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
-        }
-        break;
-#endif
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
     default:
         g_assert_not_reached();
     }
-
-#undef OP_32_64
 }
 
 static int const umin_insn[4] = {
@@ -4135,19 +4136,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        return C_O0_I2(qi, r);
-
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        return C_O0_I2(ri, r);
-
-    case INDEX_op_st_i64:
-        return C_O0_I2(re, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 66555b8982..73a1196d8b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1983,6 +1983,33 @@ static const TCGOutOpLoad outop_ld32s = {
     .out = tgen_ld32s,
 };
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_ST_B, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st8_r,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_ST_H, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st16_r,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tcg_out_st,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1993,22 +2020,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, OPC_ST_B, a0, a1, a2);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, OPC_ST_H, a0, a1, a2);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, OPC_ST_W, a0, a1, a2);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_ldst(s, OPC_ST_D, a0, a1, a2);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2530,13 +2541,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 21ed11b78d..5e41729d88 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2342,12 +2342,38 @@ static const TCGOutOpLoad outop_ld32s = {
 };
 #endif
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_SB, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st8_r,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_SH, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st16_r,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    MIPSInsn i1;
     TCGArg a0, a1, a2;
 
     a0 = args[0];
@@ -2355,24 +2381,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        i1 = OPC_SB;
-        goto do_ldst;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        i1 = OPC_SH;
-        goto do_ldst;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        i1 = OPC_SW;
-        goto do_ldst;
-    case INDEX_op_st_i64:
-        i1 = OPC_SD;
-    do_ldst:
-        tcg_out_ldst(s, i1, a0, a1, a2);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2407,15 +2415,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(rz, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 275c5a90a5..9cf24831df 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3746,28 +3746,39 @@ static const TCGOutOpLoad outop_ld32s = {
 };
 #endif
 
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
+                     TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, STB, STBX, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem_long(s, STH, STHX, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_mem_long(s, STB, STBX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_mem_long(s, STH, STHX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_mem_long(s, STW, STWX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -4415,15 +4426,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5b987c930f..bcfdb6c545 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2596,6 +2596,33 @@ static const TCGOutOpLoad outop_ld32s = {
     .out = tgen_ld32s,
 };
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_SB, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st8_r,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                        TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, OPC_SH, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st16_r,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2606,22 +2633,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, OPC_SB, a0, a1, a2);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, OPC_SH, a0, a1, a2);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, OPC_SW, a0, a1, a2);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_ldst(s, OPC_SD, a0, a1, a2);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2864,15 +2875,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(rz, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fe7665b21d..e266c19829 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3100,29 +3100,39 @@ static const TCGOutOpLoad outop_ld32s = {
     .out = tgen_ld32s,
 };
 
-# define OP_32_64(x) \
-        case glue(glue(INDEX_op_,x),_i32): \
-        case glue(glue(INDEX_op_,x),_i64)
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
+                     TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, RX_STC, RXY_STCY, data, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_mem(s, RX_STH, RXY_STHY, data, base, TCG_REG_NONE, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    OP_32_64(st8):
-        tcg_out_mem(s, RX_STC, RXY_STCY, args[0], args[1],
-                    TCG_REG_NONE, args[2]);
-        break;
-
-    OP_32_64(st16):
-        tcg_out_mem(s, RX_STH, RXY_STHY, args[0], args[1],
-                    TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_st_i32:
-        tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
         break;
@@ -3142,13 +3152,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_st32_i64:
-        tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
@@ -3597,15 +3600,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(r, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 59a737dde4..a0efeee98c 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2028,6 +2028,33 @@ static const TCGOutOpLoad outop_ld32s = {
     .out = tgen_ld32s,
 };
 
+static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, data, base, offset, STB);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st8_r,
+};
+
+static void tgen_st16_r(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, data, base, offset, STH);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tgen_st16_r,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2041,21 +2068,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-#define OP_32_64(x)                             \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64)
-
-    OP_32_64(st8):
-        tcg_out_ldst(s, a0, a1, a2, STB);
-        break;
-    OP_32_64(st16):
-        tcg_out_ldst(s, a0, a1, a2, STH);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, a0, a1, a2, STW);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2069,10 +2081,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_st_i64:
-        tcg_out_ldst(s, a0, a1, a2, STX);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
@@ -2089,13 +2097,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d549dc90f5..be9270a861 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -40,15 +40,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
-        return C_O0_I2(r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
@@ -487,18 +478,6 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
     tcg_out32(s, insn);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-# define CASE_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i64): \
-        case glue(glue(INDEX_op_, x), _i32):
-# define CASE_64(x) \
-        case glue(glue(INDEX_op_, x), _i64):
-#else
-# define CASE_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i32):
-# define CASE_64(x)
-#endif
-
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
@@ -1191,20 +1170,39 @@ static const TCGOutOpLoad outop_ld32s = {
 };
 #endif
 
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
+                     TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st8_i32, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st16_i32, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    CASE_32_64(st8)
-    CASE_32_64(st16)
-    case INDEX_op_st_i32:
-    CASE_64(st32)
-    CASE_64(st)
-        tcg_out_ldst(s, opc, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
-- 
2.43.0


