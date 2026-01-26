Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E99AC88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtC-00055H-9k; Mon, 26 Jan 2026 02:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfl-000345-Kk
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:17 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGff-0004P5-Fy
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:03 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f39438187so2092660b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411133; x=1770015933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW6mvMBqHTOULgwoPd4qVUL2Z6DbdIb81ntiy7HNrDs=;
 b=BjVj6Qdv5Tfe6C/QUBWSvKjE9gl4GsQ7xpp06qaqetjiJfsmaNYMeW+KSI1ifz0URz
 WWHN7RIZQQALmg86WJ5uM7HCEhuFmGGQV649jWPIJ4L++hUSeGaf7hPR2hKhWZ3n2jHZ
 zDE2Wip8EIOAOlWCKpgb81lHihmmhAXe3QYdiZOP19rdoa8gcFMgxoqLitwfOLrhXvWM
 wNQ34ms+hfg5Sx6GQuXLPZDMTlgCWZU0TPx5yExm80lAa8sBMJTBtVvSirKTn5OaGFZd
 UG/lJKOboLGHrt3yVMyoC11qfN79kvXQ/L/imoxfj5e2qmRZ7Pcu1kyFtbmHRFJP6qCE
 WMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411133; x=1770015933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dW6mvMBqHTOULgwoPd4qVUL2Z6DbdIb81ntiy7HNrDs=;
 b=A0vFsExhc6wCxWPvRYaIHVfj0+1HxHtsX+9oY5P4cVxCR0qpv7QWqD1EKLE0+GX/uL
 YoiziihUld0BHd5q9l0BUJHM/6XPKz0/Lp78nrEci/NOF2YLTXO6HBB0DgdigUYyZU4u
 KkPodBBVkXEVbING97wqGSeExitwkXNAZ7VaLCydiQiP46Wyf5TjkfH1td85RvxczNKo
 FXak57XZhqfz6mIWqEb8jnzHdlqTBjGCq/EFyS7pL7jxbrpAsbH8l+D6TgwNOAPG+X0S
 B9YaR7emyh/O7HnbF0VbrNeI3pADpTZvyduqBUJcFv3In710NcULNy5BigOAABQXTCtV
 f3OA==
X-Gm-Message-State: AOJu0YzKySkax71Ytl2gVL+BkT3ft0MN7DFdx9yIbPOYNnFR6PlBFdel
 xSKYcqpE70utdunSZUyRPXT1ZDOo4lNa9IuW0ocPPurshGNYuvLtKlTERhmW8t+n
X-Gm-Gg: AZuq6aLwAJrYMcfs8yD+Nh79uMqeQU3xNdh+STMAdOTFXHccYTovaJ0/asNqQp1MsKZ
 kQaPFgHdKJig24C3KGMzBFhLqFKj+dTRA63zrkyQbqGybRkmzTSyvTkfW/IpA+XIs+vFpZzzN3c
 GIPRwFNTE+EF0D19KVx9I01uI9trCK9Iop8RfZtyLBAu22og3FD4O4kDg/9QnyLrOy1xdT6mxBl
 yNwIg2tBEjJtYgTTO7ScDu23cZAhLNdnpU3jQ0OOp1tEcqotka2rrtQWWOjuWvjQnAtYiK+naAT
 Z9aNZ4pkLHMT917bQr/FKkvFWri4XEAC7shaez20Rt61LHVTGSLMbA2AXyQ1v4bLRkqEKs/8zmF
 FcxChOHCC7NVSuf54pwlV0fJfs+G8EfQPiRS/HoZ8pkxtShDPnawrsCKI1dWPlqjBx7PrhEJC6Z
 yvFhCu91+GpNt+Tc17k4gDckR1DQ+206+gxZy/kUZJkQ==
X-Received: by 2002:a05:6a00:4fd0:b0:81f:473e:e8d7 with SMTP id
 d2e1a72fcca58-823412b8781mr3011072b3a.54.1769411132825; 
 Sun, 25 Jan 2026 23:05:32 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:32 -0800 (PST)
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
Subject: [PATCH v4 19/33] tcg/wasm64: Add qemu_ld/qemu_st instructions
Date: Mon, 26 Jan 2026 07:03:32 +0000
Message-ID: <b8befeb44428fb1095845fc4f5a164f15643d046.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds qemu_ld and qemu_st by calling the helper functions
corresponding to MemOp.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/tcg-op-ldst.c               |   2 +-
 tcg/wasm64.c                    |  82 +++++++++++++++++
 tcg/wasm64/tcg-target-has.h     |   1 +
 tcg/wasm64/tcg-target-opc.h.inc |   2 +
 tcg/wasm64/tcg-target.c.inc     | 155 ++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 354d9968f9..05c145f353 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -125,7 +125,7 @@ static void tcg_gen_req_mo(TCGBar type)
 
 static TCGTemp *tci_extend_addr(TCGTemp *addr)
 {
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
     /*
      * 64-bit interpreter requires 64-bit addresses.
      * Compare to the extension performed by tcg_out_{ld,st}_helper_args
diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 9fb29131cb..bb2651c4dc 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -63,6 +63,14 @@ static void tci_args_ri(uint32_t insn, TCGReg *r0, tcg_target_ulong *i1)
     *i1 = sextract32(insn, 12, 20);
 }
 
+static void tci_args_rrm(uint32_t insn, TCGReg *r0,
+                         TCGReg *r1, MemOpIdx *m2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *m2 = extract32(insn, 16, 16);
+}
+
 static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
 {
     *r0 = extract32(insn, 8, 4);
@@ -190,6 +198,56 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     return result;
 }
 
+static uint64_t tci_qemu_ld(CPUArchState *env, uint64_t taddr,
+                            MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu(env, taddr, oi, ra);
+    case MO_SB:
+        return helper_ldsb_mmu(env, taddr, oi, ra);
+    case MO_UW:
+        return helper_lduw_mmu(env, taddr, oi, ra);
+    case MO_SW:
+        return helper_ldsw_mmu(env, taddr, oi, ra);
+    case MO_UL:
+        return helper_ldul_mmu(env, taddr, oi, ra);
+    case MO_SL:
+        return helper_ldsl_mmu(env, taddr, oi, ra);
+    case MO_UQ:
+        return helper_ldq_mmu(env, taddr, oi, ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
+                        MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SIZE) {
+    case MO_UB:
+        helper_stb_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UW:
+        helper_stw_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UL:
+        helper_stl_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UQ:
+        helper_stq_mmu(env, taddr, val, oi, ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
 {
     const uint32_t *tb_ptr = v_tb_ptr;
@@ -208,6 +266,8 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         uint8_t pos, len;
         TCGCond condition;
         uint32_t tmp32;
+        uint64_t taddr;
+        MemOpIdx oi;
         int32_t ofs;
         void *ptr;
 
@@ -492,6 +552,28 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             }
             tb_ptr = ptr;
             break;
+        case INDEX_op_qemu_ld:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
+        case INDEX_op_tci_qemu_ld_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
+        case INDEX_op_qemu_st:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
+        case INDEX_op_tci_qemu_st_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target-has.h b/tcg/wasm64/tcg-target-has.h
index a29ceb2ea5..8fe9b45403 100644
--- a/tcg/wasm64/tcg-target-has.h
+++ b/tcg/wasm64/tcg-target-has.h
@@ -4,6 +4,7 @@
 
 #define TCG_TARGET_HAS_tst 0
 #define TCG_TARGET_HAS_extr_i64_i32 0
+#define TCG_TARGET_HAS_qemu_ldst_i128 0
 
 #define TCG_TARGET_extract_valid(type, ofs, len) 0
 #define TCG_TARGET_sextract_valid(type, ofs, len) \
diff --git a/tcg/wasm64/tcg-target-opc.h.inc b/tcg/wasm64/tcg-target-opc.h.inc
index 092a5086ec..dcafaad93f 100644
--- a/tcg/wasm64/tcg-target-opc.h.inc
+++ b/tcg/wasm64/tcg-target-opc.h.inc
@@ -16,3 +16,5 @@ DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_ld_rrr, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_st_rrr, 0, 3, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 765ab72941..0f51310700 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -985,6 +985,99 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     gen_call(s, info, func_idx);
 }
 
+static void *qemu_ld_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu;
+    case MO_SB:
+        return helper_ldsb_mmu;
+    case MO_UW:
+        return helper_lduw_mmu;
+    case MO_SW:
+        return helper_ldsw_mmu;
+    case MO_UL:
+        return helper_ldul_mmu;
+    case MO_SL:
+        return helper_ldsl_mmu;
+    case MO_UQ:
+        return helper_ldq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+
+    helper_idx = (intptr_t)qemu_ld_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(data_reg));
+}
+
+static void *qemu_st_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        return helper_stb_mmu;
+    case MO_16:
+        return helper_stw_mmu;
+    case MO_32:
+        return helper_stl_mmu;
+    case MO_64:
+        return helper_stq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+    MemOp mop = get_memop(oi);
+
+    helper_idx = (intptr_t)qemu_st_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        break;
+    default:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        break;
+    }
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+}
+
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1054,6 +1147,19 @@ static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGArg m2)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(m2 == extract32(m2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, m2);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
 {
@@ -1786,6 +1892,55 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
     tcg_wasm_out_call(s, (intptr_t)func, info);
 }
 
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_ld_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    }
+    tcg_wasm_out_qemu_ld(s, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_st_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    }
+    tcg_wasm_out_qemu_st(s, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


