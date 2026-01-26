Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FDEC88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGt4-0004mB-HT; Mon, 26 Jan 2026 02:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeT-0002lh-B6
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeO-00047K-QW
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:44 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so3369335b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411079; x=1770015879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdihhC1LP2ZtiZICPjP+OqK+hRFdFoU/q+if4s9CxEk=;
 b=BSjsUWW2PjPwkJHFRywhnMW0FAbF9bBLjgagLkTRv8qPOTgdw33l6wjHyN0IQ83VRi
 356zl0I2Pdyx4m5wcSPkCscMZ+Mi4L6RL9ROMzkig4ApeSJLMOScOQgVm7IEBgiFdT4p
 Tgg/6RuvSuQsbSBlgeCHSYDlemXV+JHPq6Tgu7d6MGvs9TQ7ryKiDULkL4goxGXcDUOj
 ag7ReU6cuAMXFcAXsmBPD9UkJHlcagVXADmuOdwi3EgzlF3s9rotLPHPGOoT6mPJzkUU
 m9wQUNuoH+h4wxdvtN4CKkEdgsB0z8z0+8hCEMh7NcYtBAsU5kUEk7gY25jNBSS3C4hw
 J64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411079; x=1770015879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TdihhC1LP2ZtiZICPjP+OqK+hRFdFoU/q+if4s9CxEk=;
 b=sEkMZjUafYPw5fgjgSbzWorByRPgSoGRK9tOPeW7DM3mUUnG4ZdpEwFICZbr5jbiFn
 c5KjEu9DquPSNhsqPN9YQG9qxEJYn2KIdSAK4rZzX24Kgr7AbZljmYJZwGDkqWiLKnsW
 FHGsWmBOgjMgyR+F5HkgFJc0DZCGRpRR+U8aR/H9fjKiwrAbgMF5okn65HDu1PvSkG+f
 0GoSNm23wkvSvL1QqYNqo/E06NG7f7+2hxJX+c6Lv78zLVdRrkwnJTPkpRfW3svMWQ6W
 FUYVoXNUoEOvPOjHaCMQIASekLm1Bc+dWTqHsNjmNIpFMjzOEyQzsc04+QBKcAlVY9r6
 csfQ==
X-Gm-Message-State: AOJu0YxufrHHcREZblnipF6e8wSsIPsdxDEuyVBZZ8PzBlEfTPfZlqyw
 BxIQMB47GKthQcgMq6MKDeAyNOiRLqV+rAJDg96tB7JJb5PJw50wGZqeEee35g6/
X-Gm-Gg: AZuq6aI+rNQBZbb0WhA60J/iLFAQIGfrfUSUKaCUYhdxKQ9QxKdui3HrC/W93N8JBvD
 n9GlAN2HmHI+MiIRDjyphEhYeWI5zrfsGaCuKnfjEfmy6DtVsmG2D+dj7I0KDCEGlTuWdOcBx85
 5f/gfADj9KUUmeas8513U/qtTCtZhBWWtpFBzNj9jW+KQ1lRivXhcr/HrJC2b5DPGO45D0yb7jk
 S0fOhzZJJM1xzz/3fGgc3Tp7l8UGlRy/lPz5B7x1YEzkc3cf7axjANTCIqHc8DlB4YqKzfczSb6
 1J1VL+5+ypNgAUmstbkw3dcCH5nfuET4PWZb3W0UpSppuBugGkcRKvVYPRDjr4yfvgqZrghz0q2
 KSrD7G5vJdMnQ+cG9nQyVIJ1JhtoK5CYAoz4vYatZil2lKKHE+rlnmEUHe9aC6mdqp+x6VgARFh
 pH+iGYWqcWO5n/JyEzV3JEnOo8kf774WuhevKHKR4xAw==
X-Received: by 2002:a05:6a00:bd83:b0:81e:b2ba:5b36 with SMTP id
 d2e1a72fcca58-823412d84b3mr3225922b3a.63.1769411079018; 
 Sun, 25 Jan 2026 23:04:39 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:38 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 07/33] tcg/wasm64: Add shl/shr/sar instructions
Date: Mon, 26 Jan 2026 07:03:20 +0000
Message-ID: <5d4b7281f9d786559357c267946a00a5b3ef87f0.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit implements the shl, shr and sar operations using Wasm
instructions. Since the Wasm backend uses 64bit variables, right shifts on
32bit values extract the lower 32bit of the operand before shifting. TCI
instructions are also generated in the same way as the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                | 31 +++++++++++++
 tcg/wasm64/tcg-target.c.inc | 93 +++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index ba8a89d920..b63b88e011 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -28,6 +28,15 @@ static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
     *r2 = extract32(insn, 16, 4);
 }
 
+static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                          uint8_t *i2, uint8_t *i3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = extract32(insn, 16, 6);
+    *i3 = extract32(insn, 22, 6);
+}
+
 static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
 {
     const uint32_t *tb_ptr = v_tb_ptr;
@@ -42,6 +51,7 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         uint32_t insn;
         TCGOpcode opc;
         TCGReg r0, r1, r2;
+        uint8_t pos, len;
 
         insn = *tb_ptr++;
         opc = extract32(insn, 0, 8);
@@ -71,6 +81,27 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
+        case INDEX_op_extract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = extract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_sextract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = sextract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_shl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_shr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_sar:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index d5cf324e7b..3a2a707619 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -140,12 +140,21 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_SHR_S = 0x75,
+    OPC_I32_SHR_U = 0x76,
+
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
+    OPC_I64_SHL = 0x86,
+    OPC_I64_SHR_S = 0x87,
+    OPC_I64_SHR_U = 0x88,
+
+    OPC_I32_WRAP_I64 = 0xa7,
+    OPC_I64_EXTEND_I32_U = 0xad,
 } WasmInsn;
 
 #define BUF_SIZE 1024
@@ -219,6 +228,27 @@ static void tcg_wasm_out_o1_i2(
     tcg_wasm_out_op(s, opc);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
+static void tcg_wasm_out_o1_i2_type(
+    TCGContext *s, TCGType type, WasmInsn opc32, WasmInsn opc64,
+    TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, opc32);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_o1_i2(s, opc64, ret, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
@@ -232,6 +262,21 @@ static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                            TCGReg r1, uint8_t b2, uint8_t b3)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(b2 == extract32(b2, 0, 6));
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 6, b2);
+    insn = deposit32(insn, 22, 6, b3);
+    tcg_out32(s, insn);
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -304,6 +349,54 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SHL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shl,
+};
+
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGReg orig_a1 = a1;
+    if (type < TCG_TYPE_REG) {
+        tcg_out_op_rrbb(s, INDEX_op_extract, TCG_REG_TMP, a1, 0, 32);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_U, OPC_I64_SHR_U,
+                            a0, orig_a1, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shr,
+};
+
+static void tgen_sar(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGReg orig_a1 = a1;
+    if (type < TCG_TYPE_REG) {
+        tcg_out_op_rrbb(s, INDEX_op_sextract, TCG_REG_TMP, a1, 0, 32);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_S, OPC_I64_SHR_S,
+                            a0, orig_a1, a2);
+}
+
+static const TCGOutOpBinary outop_sar = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sar,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


