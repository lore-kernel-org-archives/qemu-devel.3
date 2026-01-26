Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65539C88E57
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGm5-0005Em-Qb; Mon, 26 Jan 2026 02:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeL-0002kc-HH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeG-00045g-2I
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:35 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so1963684b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411070; x=1770015870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Q81oLzyNhe0nfh2SJ9vu+lqMg2lFcteDby5lmMtWCY=;
 b=ECYVc8u2YcTdJ2/BzbnD20zS+w2+hMEgmxfPp46He1oDyq69TFw3uchxj2KfSn41cc
 6YORlGO1ln7Xen6PTMu0f2TNHKo1u8XDyCCox6vdE3dcAhN2W/BTSPAEetRZhDZL62pT
 IGfIoY4ZstT2BeboSe541yGmQ3aa9v9Xppxi4ox2sVyppjbzk13irLWXvdolXqmPeqdd
 AWt4RtJLtFuSYAt69DR7iIjB2eec09CwmF9/LySLbJDZgXXRsld3B+hoId3p8GhqOQkI
 WmrEVwNO+zUKayGXSVNimoWFl4Yr+8CKgamfZsxv8S4m9wDIngVbbgHnLMEgxNj+E6Za
 lIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411070; x=1770015870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Q81oLzyNhe0nfh2SJ9vu+lqMg2lFcteDby5lmMtWCY=;
 b=JpDSnpInXFlEU+E7VWljOGiaMiZUsJCxnGAVcMCnLVP12BlT6A6onKdp9OTpvKpnhV
 5PqeFaWp5ULayltmi+ju2LMeNURRqtcXBV8V5sdm+joWhDFNy9lbvjHXCzutievwBhai
 VOP1L2Fw4FLXvse1L7PBgj0L64sifLtWXjn1/mqfa33LI9HlihWNgzj4ZfsI+z1ktmdI
 4TpCe5GZre1tpcAkMh8O5AF2qvdUWniL5vlfI486HE66rG/yBuhQoBULn7Vi1K5KxMY+
 CsR/RVo5MZnciiov/sQa5Z4Z3PfY2vw3VltYUu73qOerJ6SI4Qkp1Sa38GZ3AAQLEmgM
 RLLQ==
X-Gm-Message-State: AOJu0Yzm9GEm5ySpEh6Xd9BytIF7zhzvw9VFYIFMyDxSluLBMt7wYGJX
 mILkIjoyBrUXat4GQrRKQOhoMvi87xe8oGhC7Jn69LK1erNqbCuJikZB3NINmiPP
X-Gm-Gg: AZuq6aLKzoR6JuF2xttnT0iDrW4JfX4IWkpoYp3esaneHiVe/HW6jWb/jUUtYAxrtcM
 af3mV2Pckg616NAxoDRcZCUJtkl1N+iMCIvXo2N0ZaNmrIsQt7GmcGirbCglyeKsarigv89/w1Z
 R/QV3Fq1BD9RpTGH/tj1uoqWGU/aDImfJc17qYStrh1g8STm6zBoAYS2VJXVILcBP7kvWgCmieM
 bMQS8yx518KITc4ny90K0TAn1e4rzfHNpO/At1FF7dreXlvWzcxA+a47bUpaLvj6CndS3C10dfR
 H6MS22omWq7DsYsE6+7uM77ky5nK7CMsFLWqCc0XiKQ4/sC034As8mmulbkaZxGTlhjY6wY1ifY
 ZJYQUTgoRSPc5AYpsq3wM4LwC2PDMczULQenuN8aKd5P0othNuwHLPzUewVe/aSnsrOBGaIr5sa
 0BpPLF0R8Hpyjr8//ZbJsWk817mUWaN/utmOk7swXfkfcsqTVhkwRF
X-Received: by 2002:a05:6a00:bd85:b0:81f:8387:53a8 with SMTP id
 d2e1a72fcca58-82341286955mr3639624b3a.34.1769411070157; 
 Sun, 25 Jan 2026 23:04:30 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:29 -0800 (PST)
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
Subject: [PATCH v4 05/33] tcg/wasm64: Add and/or/xor instructions
Date: Mon, 26 Jan 2026 07:03:18 +0000
Message-ID: <98489736a6ad338cda86ed9fe31af5cba239fa0c.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x432.google.com
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

This commit adds support for generateing the and, or and xor operations. The
generated Wasm codes will be instantiated and executed in the browser.

Browsers tipycally limit the number of active Wasm instances and the
instantiating Wasm modules introduces overhead. As a result, instantiating
TBs that are rarely called is undesirable. To address this, the Wasm backend
relies on the a forked subset of the TCI interpreter (tcg_qemu_tb_exec_tci
function in tcg/wasm64.c) for executing such TBs.

The Wasm backend emits both Wasm and TCI instructions. TCI instructions are
emitted to s->code_ptr, while the corresponding Wasm instructions are
generated into a separate buffer allocated via tcg_malloc(). This buffer
intends to be merged into the TB before tcg_gen_code returns.

In the Wasm code, each TCG variable is mapped to a 64bit Wasm
variable. Execution works by first pushing the operands into the Wasm's
stack using get instructions. The result is left on the stack and this can
be assigned to a variable by popping it using a set instruction. The Wasm
binary format is documented at [1].

Additionally, since the Wasm instuction's index operand must be
LEB128-encoded, this commit introduces an encoder function implemented
following [2].

[1] https://webassembly.github.io/spec/core/binary/index.html
[2] https://en.wikipedia.org/wiki/LEB128

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                 |   1 +
 tcg/wasm64.c                |  66 +++++++++++++++
 tcg/wasm64/tcg-target.c.inc | 160 ++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 tcg/wasm64.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 470b15eeb7..30e468f290 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4111,6 +4111,7 @@ WebAssembly TCG target
 M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: tcg/wasm64/
+F: tcg/wasm64.c
 
 Block drivers
 -------------
diff --git a/tcg/wasm64.c b/tcg/wasm64.c
new file mode 100644
index 0000000000..9f3b1344d6
--- /dev/null
+++ b/tcg/wasm64.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * WebAssembly backend with forked TCI, based on tci.c
+ *
+ * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg.h"
+
+static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+}
+
+static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
+{
+    const uint32_t *tb_ptr = v_tb_ptr;
+    tcg_target_ulong regs[TCG_TARGET_NB_REGS];
+    uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
+                   / sizeof(uint64_t)];
+
+    regs[TCG_AREG0] = (tcg_target_ulong)env;
+    regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
+
+    for (;;) {
+        uint32_t insn;
+        TCGOpcode opc;
+        TCGReg r0, r1, r2;
+
+        insn = *tb_ptr++;
+        opc = extract32(insn, 0, 8);
+
+        switch (opc) {
+        case INDEX_op_and:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & regs[r2];
+            break;
+        case INDEX_op_or:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | regs[r2];
+            break;
+        case INDEX_op_xor:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ^ regs[r2];
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 4bcb594360..a1757b4db7 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -25,6 +25,10 @@
  * THE SOFTWARE.
  */
 
+#include "qemu/queue.h"
+
+typedef uint32_t tcg_insn_unit_tci;
+
 static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R2,
     TCG_REG_R3,
@@ -109,3 +113,159 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
     return false;
 }
+
+/* converts a TCG register to a wasm variable index */
+static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
+    0,  /* TCG_REG_R0 */
+    1,  /* TCG_REG_R1 */
+    2,  /* TCG_REG_R2 */
+    3,  /* TCG_REG_R3 */
+    4,  /* TCG_REG_R4 */
+    5,  /* TCG_REG_R5 */
+    6,  /* TCG_REG_R6 */
+    7,  /* TCG_REG_R7 */
+    8,  /* TCG_REG_R8 */
+    9,  /* TCG_REG_R9 */
+    10, /* TCG_REG_R10 */
+    11, /* TCG_REG_R11 */
+    12, /* TCG_REG_R12 */
+    13, /* TCG_REG_R13 */
+    14, /* TCG_REG_R14 */
+    15, /* TCG_REG_R15 */
+};
+
+#define REG_IDX(r) tcg_target_reg_index[r]
+
+typedef enum {
+    OPC_GLOBAL_GET = 0x23,
+    OPC_GLOBAL_SET = 0x24,
+
+    OPC_I64_AND = 0x83,
+    OPC_I64_OR = 0x84,
+    OPC_I64_XOR = 0x85,
+} WasmInsn;
+
+#define BUF_SIZE 1024
+typedef struct LinkedBufEntry {
+    uint8_t data[BUF_SIZE];
+    uint32_t size;
+    QSIMPLEQ_ENTRY(LinkedBufEntry) entry;
+} LinkedBufEntry;
+
+typedef QSIMPLEQ_HEAD(, LinkedBufEntry) LinkedBuf;
+
+static void linked_buf_out8(LinkedBuf *linked_buf, uint8_t v)
+{
+    LinkedBufEntry *buf = QSIMPLEQ_LAST(linked_buf, LinkedBufEntry, entry);
+    if (!buf || (buf->size == BUF_SIZE)) {
+        LinkedBufEntry *e = tcg_malloc(sizeof(LinkedBufEntry));
+        e->size = 0;
+        QSIMPLEQ_INSERT_TAIL(linked_buf, e, entry);
+        buf = e;
+    }
+    buf->data[buf->size++] = v;
+}
+
+static void linked_buf_out_leb128(LinkedBuf *p, uint64_t v)
+{
+    uint8_t b;
+    do {
+        b = v & 0x7f;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        linked_buf_out8(p, b);
+    } while (v != 0);
+}
+
+/*
+ * wasm code is generataed in the dynamically allocated buffer which
+ * are managed as a linked list.
+ */
+static __thread LinkedBuf sub_buf;
+
+static void init_sub_buf(void)
+{
+    QSIMPLEQ_INIT(&sub_buf);
+}
+static void tcg_wasm_out8(TCGContext *s, uint8_t v)
+{
+    linked_buf_out8(&sub_buf, v);
+}
+static void tcg_wasm_out_leb128(TCGContext *s, uint64_t v)
+{
+    linked_buf_out_leb128(&sub_buf, v);
+}
+
+static void tcg_wasm_out_op(TCGContext *s, WasmInsn opc)
+{
+    tcg_wasm_out8(s, opc);
+}
+static void tcg_wasm_out_op_idx(TCGContext *s, WasmInsn opc, uint32_t idx)
+{
+    tcg_wasm_out8(s, opc);
+    tcg_wasm_out_leb128(s, idx);
+}
+
+static void tcg_wasm_out_o1_i2(
+    TCGContext *s, WasmInsn opc, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op(s, opc);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGReg r2)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    tcg_out32(s, insn);
+}
+
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_AND, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_and,
+};
+
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_OR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_XOR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_xor,
+};
+
+static void tcg_out_tb_start(TCGContext *s)
+{
+    init_sub_buf();
+}
-- 
2.43.0


