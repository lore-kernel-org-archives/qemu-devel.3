Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7804AC88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGt6-0004qo-E5; Mon, 26 Jan 2026 02:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGf3-0002tT-Nz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:42 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeu-0004KV-Ps
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso1764004b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411106; x=1770015906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3Pe0nbPZv/rihffMMsnlYdWZcSw9d/3vgrrjLHECqs=;
 b=ljhcINzbtiDwm7u39KEJlMx7qkAefOAy724yUz5z8x7LGHVa1n8CVCvmIKeQYaeiaS
 d2H/CeGRTQtTFu109VTAKRjwshBmC9duuz2/KApYBv04ZMOMmsPtLey1G5UC54q/LVuT
 YN/0L9jplpSOxa8e5IUxQn3WG+JUdZOCqYzn0fMEHsMlkgcFGis9co6SA4tI1kCRG0Zq
 OwyLMDQiEjlFg2gqDjoVcKZB2bvuLQz74qQ4Gdl141NNmoFQf/Z3lpS7zoEcSlNJAUyd
 bRwGApdHXofnwapeoTb2KzZhsPPrbvPhyxsUjHYPofCyjgTvY1gbHQNK+8XbEwaFz/kR
 SYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411106; x=1770015906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3Pe0nbPZv/rihffMMsnlYdWZcSw9d/3vgrrjLHECqs=;
 b=iosGyF0+Ogk6tYGKh7S6Wr9zaQjc+ojM65n20DaKKV9e79lnPxGOZhKiarmIiKnNu2
 nuoZMlYJIuBto1k5VXqLTgDwMdNwb7Fse1c/jhtBwrrrQARXEf4dtPBNc0nqJxFNgj1W
 o/hhB3mNtm++Uy0F50vbDddGNN8lqGbfYZjtj99Tbl8EibHdTYazeVOXL69Gd4p/SFg6
 iUdSP/f4J7xqu0YMNapMdCrWy3tKt+KV/YPUMqgudtdRDivx9DZNCnxJarEqxTR5PVPb
 MPuPzU5lkP5OiUP0MnQrKU4W/XNI8TN9YB8i/G7VkU7WI0b/nMPF50FwoXLKPXPduDCH
 5+YA==
X-Gm-Message-State: AOJu0YxiyomS/4+/2bwUvWqwjLIMLR8pDl53BonRlFYKrDMXRKTqgutI
 i2/Oy/a+vRxLNzyTs5/eTCse8A+38b4MhI6S6NFf0kX8Ce8yDgYil2WmfXi72Ba1
X-Gm-Gg: AZuq6aLpLYrV1Es3SYzYJ/vOPvUymN/ThIfsZBD5sCOyd6BvdFMH5knDdGkBsd3/9Bg
 1DGBfNiS69TzDqFSsFVU7NhxMeh3K679Kwk9MRTiLGLLGU1LERDvG+HeM2727f9U0h7F+5X0pwl
 85MQVLALt8OGwOhhgQjuxYgvuurtiCZ417qXQ36VcPEWw/cKRiDuAbTDxlsOLwNNsITYBfWZHf3
 RRFfKhzTBTI1WIOVlnx7TlZ5GHRm3xR4bmfbn5ahlpM1OAXZ+Kam4rCZfpqrWQZXEJ/CRdgIcSA
 xhJ5DPyM9nDYmBaisBiVhCigXM5Oj5Xjs2UVGRzpafVhjacII2UrDd5IYy9Z9vrvDnAqG0ETPT/
 aVmkhvWpwRREldydSm1NYxf6JtPoQNiRiXTJ7SutIdF5MiJsroL8FwN/UdARoSulvukefxBKRLx
 j7vsRxtyEadlLYlpWydTcs5DYRUTt4dC6JbjsTOGkoTb6Xno9qGXdo
X-Received: by 2002:a05:6a00:94f5:b0:81c:5bca:8104 with SMTP id
 d2e1a72fcca58-8234122e4f1mr2902683b3a.24.1769411105684; 
 Sun, 25 Jan 2026 23:05:05 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:05 -0800 (PST)
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
Subject: [PATCH v4 13/33] tcg/wasm64: Add div/rem instructions
Date: Mon, 26 Jan 2026 07:03:26 +0000
Message-ID: <6d41128fb32942c6f6ee526b078c611cf147960b.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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

The div and rem operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                    | 32 ++++++++++++++++
 tcg/wasm64/tcg-target-opc.h.inc |  4 ++
 tcg/wasm64/tcg-target.c.inc     | 68 +++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 2c8a7b814e..8c8dcb81c7 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -327,6 +327,38 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             ptr = (void *)(regs[r1] + ofs);
             *(uint32_t *)ptr = regs[r0];
             break;
+        case INDEX_op_divs:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
+            break;
+        case INDEX_op_divu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
+            break;
+        case INDEX_op_rems:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
+            break;
+        case INDEX_op_remu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
+            break;
+        case INDEX_op_tci_divs32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_divu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
+            break;
+        case INDEX_op_tci_rems32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_remu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target-opc.h.inc b/tcg/wasm64/tcg-target-opc.h.inc
index 122b45749a..5ed8c67535 100644
--- a/tcg/wasm64/tcg-target-opc.h.inc
+++ b/tcg/wasm64/tcg-target-opc.h.inc
@@ -8,3 +8,7 @@ DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 4131595fce..d4db2528f8 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -181,12 +181,20 @@ typedef enum {
     OPC_I64_GE_U = 0x5a,
 
     OPC_I32_ADD = 0x6a,
+    OPC_I32_DIV_S = 0x6d,
+    OPC_I32_DIV_U = 0x6e,
+    OPC_I32_REM_S = 0x6f,
+    OPC_I32_REM_U = 0x70,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
+    OPC_I64_DIV_S = 0x7f,
+    OPC_I64_DIV_U = 0x80,
+    OPC_I64_REM_S = 0x81,
+    OPC_I64_REM_U = 0x82,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
@@ -1070,6 +1078,66 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .out_rr = tgen_extrh_i64_i32,
 };
 
+static void tgen_divs(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divs32
+                     : INDEX_op_divs);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_S, OPC_I64_DIV_S, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divs = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divs,
+};
+
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divu32
+                     : INDEX_op_divu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_U, OPC_I64_DIV_U, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rems32
+                     : INDEX_op_rems);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_S, OPC_I64_REM_S, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_remu32
+                     : INDEX_op_remu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_U, OPC_I64_REM_U, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


