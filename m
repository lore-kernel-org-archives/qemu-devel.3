Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFke-000879-Pn; Fri, 28 Jun 2024 13:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFkX-00086O-U1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:51:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFkS-0005Qg-VK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:51:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso694051b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719597058; x=1720201858;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Scj9q1v0Nm4rT0rqRAAgkJUU1hV8RtxAnMVPq0A+JNk=;
 b=a2XKdknDT/uxKR7s86kHmtd/Y/KfbjH89bLN8qRt+Abi64LxFLcM3K5Z8bY+SC3/Zq
 EfdEr0fG3QRlKnp36uxjnlKVEul8+0bMJETiCcNzFk990b1uUGxWgPBMe60BnSWIXGnm
 fxufvJDEPXUGN2ESZS4RPdI3UTapyw3ubxkD5Ka5b/bYVqJHHo5DjBrZJdY/PAiNFRDh
 1PrUcO8Btug4xQdG+K/Ni6NkXt3yGDgojoALHIa4oxDgdfP0KaJYzXdO8zQMJuCz4+2H
 D7Xx1VNEOjOgICFiD4zvMxx/CcvF5lsrFOkBmrDosVg9LMSoEsvpEoef+77YFKm+CyOG
 nBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597058; x=1720201858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Scj9q1v0Nm4rT0rqRAAgkJUU1hV8RtxAnMVPq0A+JNk=;
 b=a4xN5wndcQZ4uvyxb0T1DPuUZ6uvTWIbCwEunFVUGH7XxhxD/j1won7X7ice+OmuWu
 rq3pZ5OQGa1TRn+v6wivEX3ZI7EJDMk/Q5JVToGWFdm+Uf3LzxnWshBST6nxebqnL7HA
 Sk1JxepCaBZs2e28wAxJIqTNq54Y9/hC2mcJC3BpEYYRwOY4mXvpZrxOtQQqeo4FRtXx
 DgJjIeW38hWdj5R3q4slFF3DXHsHDyHBwpx9bqRW4zr4YugowtlSpwFkRuwx43j7xt1o
 2scT13kuxJFCOUXc/ekf+oq45RafjL4i1KNWwGKZfuPWB0xT0g8XkaeIzzNsEBaTuxNz
 qkbg==
X-Gm-Message-State: AOJu0YztonLZG+EVMn74FoqLC0F2KDBidmHB0Ha8IWr7RoSL0XwGJd9l
 NU94IEi9gKh76a43WKJaQR+rP4q9PkaZ4CkVo0mTKuV7fjNAVDPBkom/LyKL24BPxZ/z/Oe49NI
 o
X-Google-Smtp-Source: AGHT+IFdZgcERIByTRi5/hXliCMj9hDyEhglsmE8+E8UdYKDQ7bdn1sqdsf+UAyhSNvjoTZFnFsGaQ==
X-Received: by 2002:a05:6a00:b50:b0:706:8a67:c3a0 with SMTP id
 d2e1a72fcca58-7068a67c5fcmr19213082b3a.5.1719597058267; 
 Fri, 28 Jun 2024 10:50:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6c9e0ee3sm1541952a12.60.2024.06.28.10.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:50:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/3] target/riscv: zimop and zcmop extension for riscv
Date: Fri, 28 Jun 2024 10:50:30 -0700
Message-Id: <20240628175030.595936-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

`zimop` stands for `may be operations`. `zcmop` stands for compressed
`may be operations`. For some RISC-V CPU extension, once compiled into
the binary are part of generated code which can't be gated behind a probe
of whether an instruction set is supported or not. One such example is
`zicfiss` [1] extension where `shadow stack push` and `shadow stack pop
and check` will be part of every function body. Thus binaries compiled
with such extensions need to run in following scenarios

    - On machines where extension is present and enabled
    - On machines where extension is present and disabled
    - On machines where extension is not present/implemented.

`zimop` (for 32bit instructions) and `zcmop` (for compressed) were devised
and defined [2] to support such future (like zicfiss) CPU extensions
where zimops and zcmops provide a base non-faulting behavior for
codepoints that may claimed by future ISA extensions. Minimally, any
CPU implementation wanting to have binary compatibility with such
binaries only has to implement `zimop and zcmop`. Furthermore, this
allows per-task optin for software where user has the option to enable
the feature on per-task basis.

`zimop` are defined to write zero to `rd`. `zcmop` are defined to *not* write
to any register.

[1] - https://github.com/riscv/riscv-cfi/blob/main/src/cfi_backward.adoc
[2] - https://github.com/riscv/riscv-isa-manual/blob/main/src/zimop.adoc

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..3caf8553d1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zimops, PRIV_VERSION_1_12_0, ext_zimops),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -2273,6 +2274,7 @@ static Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+    DEFINE_PROP_BOOL("zimops", RISCVCPU, cfg.ext_zimops, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..5c42ff8cdf 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -124,6 +124,7 @@ struct RISCVCPUConfig {
     uint32_t mvendorid;
     uint64_t marchid;
     uint64_t mimpid;
+    bool ext_zimops;
 
     /* Named features  */
     bool ext_svade;
-- 
2.34.1


From 4d15b0e0037f444eb75e60b398e19dcf476f07d4 Mon Sep 17 00:00:00 2001
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 28 Jun 2024 00:13:58 -0700
Subject: [PATCH 2/3] target/riscv: zimop instruction encoding and its
 implementation

This patch adds assigned codepoints for decoder for 32bit instructions
and provide implementation for instruction. If extension is present,
then moves 0 to `rd`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn32.decode                 | 15 +++++++
 target/riscv/insn_trans/trans_zimops.c.inc | 50 ++++++++++++++++++++++
 target/riscv/translate.c                   |  3 ++
 3 files changed, 68 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_zimops.c.inc

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..fca3838a9f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -167,6 +167,21 @@ csrrwi   ............     ..... 101 ..... 1110011 @csr
 csrrsi   ............     ..... 110 ..... 1110011 @csr
 csrrci   ............     ..... 111 ..... 1110011 @csr
 
+# zimops (unpriv integer may be operations) instructions with system opcode
+# zimops_r and zimops_rr are two code points assigned to zimops
+# Any new extension that claims zimops encoding should be placed above mop.r
+# and mop.rr
+
+# mop.r
+{
+  zimops_r   1-00--0 111--     ----- 100 ..... 1110011 %rd
+}
+
+# mop.rr
+{
+  zimops_rr  1-00--1 -----     ----- 100 ..... 1110011 %rd
+}
+
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
 ld       ............   ..... 011 ..... 0000011 @i
diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/insn_trans/trans_zimops.c.inc
new file mode 100644
index 0000000000..b5ad7bded8
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zimops.c.inc
@@ -0,0 +1,50 @@
+/*
+ * RISC-V translation routines for the Control-Flow Integrity Extension
+ *
+ * Copyright (c) 2024 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+static bool trans_zimops_r(DisasContext *ctx, arg_zimops_r * a)
+{
+    /* zimops not implemented, raise illegal instruction & return true */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return true;
+    }
+    /*
+     * zimops implemented, simply grab destination and mov zero.
+     * return true
+     */
+    TCGv dest = dest_gpr(ctx, a->rd);
+    dest = tcg_constant_tl(0);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+static bool trans_zimops_rr(DisasContext *ctx, arg_zimops_r * a)
+{
+    /* zimops not implemented, raise illegal instruction & return true */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return true;
+    }
+    /*
+     * zimops implemented, simply grab destination and mov zero.
+     * return true
+     */
+    TCGv dest = dest_gpr(ctx, a->rd);
+    dest = tcg_constant_tl(0);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2c27fd4ce1..b7fd3456c8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1115,6 +1115,9 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
 
+/* Include decoder for zimop */
+#include "insn_trans/trans_zimops.c.inc"
+
 /* The specification allows for longer insns, but not supported by qemu. */
 #define MAX_INSN_LEN  4
 
-- 
2.34.1


From dc5d2c62475ac7a9cf42b9ed1398961505b8b91d Mon Sep 17 00:00:00 2001
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 2 Jan 2024 15:46:13 -0800
Subject: [PATCH 3/3] target/riscv: Introduce `compressed zimop` aka `zcmop`

Analogous to zimop, there are 8 encodings carved out of illegal space
encodings (c.lui xn, 0) in compressed instructions which are defined
to be zcmops short for compressed may be operations.

Unlike zimops (which write 0 to rd), zcmops don't actually write anything
to any register. Their encodings allow future extensions to define them to
read register x[n].

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn16.decode                 |  6 ++++++
 target/riscv/insn_trans/trans_zimops.c.inc | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..d24b54d319 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -32,6 +32,7 @@
 %uimm_cl_w     5:1 10:3 6:1       !function=ex_shift_2
 %imm_cb        12:s1 5:2 2:1 10:2 3:2 !function=ex_shift_1
 %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
+%zcmop_n       8:3
 
 %shlimm_6bit  12:1 2:5               !function=ex_rvc_shiftli
 %shrimm_6bit  12:1 2:5               !function=ex_rvc_shiftri
@@ -66,6 +67,8 @@
 &cmpp      urlist spimm
 &cmjt      index
 
+&cmop      zcmop_n
+
 # Formats 16:
 @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
 @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
@@ -109,6 +112,8 @@
 @cm_mv        ... ...  ... .. ... ..  &r2_s  rs2=%r2s     rs1=%r1s
 @cm_jt        ... ...  ........   ..  &cmjt  %index
 
+@c_mop        ... . .....  ..... ..  &cmop %zcmop_n
+
 # *** RV32/64C Standard Extension (Quadrant 0) ***
 {
   # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
@@ -140,6 +145,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  zcmops          011 0  0...1  00000 01 @c_mop # zcmop carving out of illegal c.lui xn,0 space
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/insn_trans/trans_zimops.c.inc
index b5ad7bded8..99f25bd9ea 100644
--- a/target/riscv/insn_trans/trans_zimops.c.inc
+++ b/target/riscv/insn_trans/trans_zimops.c.inc
@@ -48,3 +48,14 @@ static bool trans_zimops_rr(DisasContext *ctx, arg_zimops_r * a)
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
+
+static bool trans_zcmops(DisasContext *ctx, arg_zcmops * a)
+{
+    /* zimops not implemented, return false */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return false;
+    }
+
+    return true;
+}
-- 
2.34.1


