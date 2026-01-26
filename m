Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222C2C88E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtA-00050X-9A; Mon, 26 Jan 2026 02:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfW-0002yQ-9r
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:58 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGf3-0004LX-Fo
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:36 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so4125007b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411115; x=1770015915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6xRwxR8Gqwk8zRsC9Xk72G+qx04EZA2MfdW30gzxV0=;
 b=dfTWM1H/7EQlH/QY+f0McceOkKA2Lwh2TByf7slCwt0Wjj+4hg05CeRbnPwQBrGIeP
 miN/lrOQl+C9mw8xTqPoU8XisVfOvY1STzT6VhUGrXw1A8J2BduD0Qp8aXi+WxM/xPd9
 TxSgKq2tiRNpWL0oVTrjQ77DL5iTes1K181huQEOqCDZ4x0jAACUOx49uI/AWBQ4OJ47
 27fpvIUYHCh7fEk+bQhNHipeeHFMwfGV/dA+dtTUTukSxmkf69u+DX/ELj/j74vZSEdG
 qW7YbKxamwBfJF26B8izU0+/ldslHMLlS4ZcPoo5W1HThLYqMl7ci6Ez6YRT1aMwcndJ
 7z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411115; x=1770015915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6xRwxR8Gqwk8zRsC9Xk72G+qx04EZA2MfdW30gzxV0=;
 b=Wa3iJFuExW95c9FfxTYkFMJjZeQ4frJAdGxSAyvc7h3O4zg6huEkbtBMHAZPda2Kmf
 AYzGzqGRmfqo12C8iRZD0Ov4oYbRsNJPaHND7ZMFqfzXMNZporTJ+AJErRGPPv0gYyt6
 0POsiZ6zAqZ6PFwaW75xYFCSIWEIuNsyFCsItJHIKzW2x9vDAOtomZ3k2TV2MUEA79O4
 LVc/QN61DeClGX0BBxsPWDCOZpi2Y3qSCMFqbG08axxU+9KyFx06fsmS1MmbPsLT8Tnt
 VpNZmTJEKPByMQwPwcXS+Gd44/rmB08+2897bTuyqblBhmCvKzQTBjlApZ53Uk8GbEky
 i7KA==
X-Gm-Message-State: AOJu0Yz5HLMh4Mm/nFNAeVS4kxWub4lpICYVdwGrWFG0So57JcRyRoDw
 e3pySHdkeLbydWVZNz4o0DnL+uagWCGW8ulus20Gjkdmk99uKdhQYpANajScxa5F
X-Gm-Gg: AZuq6aK6cqtonozOcpgueqWsZqop32TsCahe9oPZkdpN/2EFhk9FvBxCqc8W6pm9RK/
 +VogXRdXtOZPmj19LSZQwl0t/SQxy7pZ9kv4rLPZz/A4s73/sX992iJo1bAo9SRmyrUFTOhl3uo
 Ygcn6vR1Wp/Lx2nVHj9gvVdtIAVspYvvILLpKKZ3/Yci+P6vlcdvk5dRoaN8uNWRKCfxnKp6ojt
 6yhpFbWyuXgdPFH3uXOxmPLi0mSV5rq53vcPVKA4kaNur0X7wxGNkx8R1KTufsEZho3zY7/hSGY
 Qq+LByPjxAJj48Dsm5u2kqxLZ8MdAYfv+DhegffOwy8F1bd8eMd7fNQVrGlbyWz5nR526OyUyr0
 4ExMj6kbqwcsHIL4v+Xp80UVZ0FcacoupWTgkTznGmQ9haxV0tf9ohqyYDAqip8hJ9zGo+vSAmk
 dcPWKP20EqeEVIClAi3ctI+MwVxSKCkHxeoCQmuT84AA==
X-Received: by 2002:a05:6a00:13a3:b0:823:aa5:23f1 with SMTP id
 d2e1a72fcca58-823412cfa25mr3559175b3a.57.1769411114933; 
 Sun, 25 Jan 2026 23:05:14 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:14 -0800 (PST)
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
Subject: [PATCH v4 15/33] tcg/wasm64: Add rot/clz/ctz instructions
Date: Mon, 26 Jan 2026 07:03:28 +0000
Message-ID: <8ae7e6301ed4100b0ac334a1c312dc0fbba23d2e.1769407033.git.ktokunaga.mail@gmail.com>
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

The rot/clz/ctz operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                    |  34 ++++++++++
 tcg/wasm64/tcg-target-opc.h.inc |   4 ++
 tcg/wasm64/tcg-target.c.inc     | 107 ++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index a5e72d8fe5..2688ded58a 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -363,6 +363,40 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop64(regs[r1]);
             break;
+        case INDEX_op_clz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
+            break;
+        case INDEX_op_ctz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
+            break;
+        case INDEX_op_tci_clz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_tci_ctz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_rotl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_rotr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_tci_rotl32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol32(regs[r1], regs[r2] & 31);
+            break;
+        case INDEX_op_tci_rotr32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror32(regs[r1], regs[r2] & 31);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target-opc.h.inc b/tcg/wasm64/tcg-target-opc.h.inc
index 5ed8c67535..092a5086ec 100644
--- a/tcg/wasm64/tcg-target-opc.h.inc
+++ b/tcg/wasm64/tcg-target-opc.h.inc
@@ -12,3 +12,7 @@ DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 8932330e3a..1d980fb99f 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -158,6 +158,7 @@ typedef enum {
     OPC_I32_CONST = 0x41,
     OPC_I64_CONST = 0x42,
 
+    OPC_I32_EQZ = 0x45,
     OPC_I32_EQ = 0x46,
     OPC_I32_NE = 0x47,
     OPC_I32_LT_S = 0x48,
@@ -169,6 +170,7 @@ typedef enum {
     OPC_I32_GE_S = 0x4e,
     OPC_I32_GE_U = 0x4f,
 
+    OPC_I64_EQZ = 0x50,
     OPC_I64_EQ = 0x51,
     OPC_I64_NE = 0x52,
     OPC_I64_LT_S = 0x53,
@@ -180,6 +182,8 @@ typedef enum {
     OPC_I64_GE_S = 0x59,
     OPC_I64_GE_U = 0x5a,
 
+    OPC_I32_CLZ = 0x67,
+    OPC_I32_CTZ = 0x68,
     OPC_I32_ADD = 0x6a,
     OPC_I32_DIV_S = 0x6d,
     OPC_I32_DIV_U = 0x6e,
@@ -187,7 +191,11 @@ typedef enum {
     OPC_I32_REM_U = 0x70,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
+    OPC_I32_ROTL = 0x77,
+    OPC_I32_ROTR = 0x78,
 
+    OPC_I64_CLZ = 0x79,
+    OPC_I64_CTZ = 0x7a,
     OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
@@ -202,6 +210,8 @@ typedef enum {
     OPC_I64_SHL = 0x86,
     OPC_I64_SHR_S = 0x87,
     OPC_I64_SHR_U = 0x88,
+    OPC_I64_ROTL = 0x89,
+    OPC_I64_ROTR = 0x8a,
 
     OPC_I32_WRAP_I64 = 0xa7,
     OPC_I64_EXTEND_I32_S = 0xac,
@@ -212,6 +222,7 @@ typedef enum {
 
 typedef enum {
     BLOCK_I64 = 0x7e,
+    BLOCK_I32 = 0x7f,
 } WasmBlockType;
 
 #define BUF_SIZE 1024
@@ -563,6 +574,42 @@ static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_cz(
+    TCGContext *s, TCGType type, WasmInsn opc32, WasmInsn opc64,
+    TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_I32_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I32);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, opc32);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I64_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, opc64);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1182,6 +1229,66 @@ static const TCGOutOpUnary outop_ctpop = {
     .out_rr = tgen_ctpop,
 };
 
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotl32
+                     : INDEX_op_rotl);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTL, OPC_I64_ROTL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotl,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotr32
+                     : INDEX_op_rotr);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTR, OPC_I64_ROTR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotr,
+};
+
+static void tgen_clz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_clz32
+                     : INDEX_op_clz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CLZ, OPC_I64_CLZ, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_clz,
+};
+
+static void tgen_ctz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_ctz32
+                     : INDEX_op_ctz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CTZ, OPC_I64_CTZ, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_ctz,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


