Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19917C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIgm-00015J-Do; Mon, 14 Jul 2025 08:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubHzH-00042a-3L
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:08:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubHz5-0004f3-VF
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:08:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234f17910d8so42573945ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752494913; x=1753099713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Wl8gfbM6N7ds9hzF8aCIKvoOCjkpEJPMwCp3ZCChH0=;
 b=PlZ8hMa6mmpRVL7M63PuOCbK1hPrrBU7+Zd7P9YQJviIvx4f+ZLfjvY0UCAvLACEPA
 flvCi9sOMtyuhpHuDHG0P+WblZjxnrMmkHcnzp+332AKw78FRm96ZwdtzAvK5gc+x4L+
 GZsWBMU0bDTbsVSOrkrUy8ZFUEvLv8T8d/y+iOYoEBIob2ZvdSgHwNroiIiMzTYCypwZ
 6SG91fD61Gk9Ii9iYgY96153TDNUhphu2dMW1ITLTQ+nJN/Vq7KInLusX6F6FgCzRDfd
 G0nzQrh1UDY/SE9yhdOLnloAn8OHnwl4WO13BgZiGhOmkBqlzmMbh4OQgKptqQ0RE0Lg
 Q6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494913; x=1753099713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Wl8gfbM6N7ds9hzF8aCIKvoOCjkpEJPMwCp3ZCChH0=;
 b=dfshsmbIIUORjteVe2zNn/E8cK8CGSXD4KPbZ0QdcVPItyA6M9oO3BldwjIq6zZ8g0
 +nZnmTAV4RhSzolrKcdHb9Q8M1Msqo0C9f0P+lIhZlZz+IOM7kQmJQyDAVHE/f4byLyx
 k+7HUvs8o1eZE0cEmrzMR7M2whQM6sQ1s4crXVvY2OdY1cXUFhGWn/nXyntKZEP3ALA9
 6jPrkJpFJ1aJOwHB3zkc4ZMkOZP2dMmEglGxt89+T5wMIp9hWNlAEGyZrljViaLPGRpP
 fcUhlReIvWM9fErb64roqW1AN93Q+KPefxoaCVsBq/I0S9YBA4d+/sfxvaJLtN4t+AZi
 LFzg==
X-Gm-Message-State: AOJu0YxbNv+yi64OKQnDXZn03bHpyQmRDFXciWyJgqdPHsLwllJEvBM4
 cQB9LN7f0EiEKQKyAjyeHv0UQv2zJ44TcB5f74cfVYjvkV6bBJe/SqBKJ1rJ4JB5gE/ikZfFvte
 t/veS
X-Gm-Gg: ASbGnctu+n+g4LF8eJUCzforWLcrHXX7JaynfHT8rLZ5DxsMOx22XUltUY7mmvCvVGf
 xUtWvhVhAfWuN7h78HrF7twl0jBXXlBIlKBC1PXn9THaJ/wFjQUHt7QPgJZrBUbFuh06HZr1g7/
 2AcGpDecfq0d2k76+pwinBTBiyx5RW4vhNVPe8dqqRya7657W482mXBnH8tSv5cN7eXUeR7sCX+
 OVNXa0WY7bNQyTx/BgsMNiYKO3comnYDQvsf0tn5JI7AS55xu2aaxrw7Okewn0QfLSf8uzlMAYl
 cyO9PDlXZxdMNxKHfYZDI2a47bhFdhxq9vSrCTpFGzHt4SKoVAO6A5XuqMUOXgMIdrUU44c4+LD
 M7RoBhl2Qpqt2m77lP/BX1YwHVxEgI+eXFA==
X-Google-Smtp-Source: AGHT+IG/TxzQUdv6+hH7SEM7Ia/rglKxTAoNk1dGmkOBWhEgVwTamASoXIAGAn2GYgNhYIIy8N8RJw==
X-Received: by 2002:a17:903:11c9:b0:235:2e0:aa9 with SMTP id
 d9443c01a7336-23dede456d7mr195630975ad.14.1752494912721; 
 Mon, 14 Jul 2025 05:08:32 -0700 (PDT)
Received: from grind ([177.170.118.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4286b4asm97720765ad.46.2025.07.14.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:08:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv: set mtval = 0 for illegal_inst if no opcode
 avail
Date: Mon, 14 Jul 2025 09:08:22 -0300
Message-ID: <20250714120822.1243870-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

There is no guarantee that we'll able to get a proper opcode to put into
mtval for illegal inst exceptions, as demonstrated in [1].

The 'proper opcode' would be retrieved via unwinding the CPU state (via
cpu_restore_state(), down to riscv_restore_state_to_opc()) after
riscv_raise_exception(). There are cases where that doesn't happen:
we'll see a failure in cpu_restore_state(), where in_code_gen_buffer()
will return 'false' even for a 'host_pc' that is retrieved via GETPC()
and not in an instruction fetch context.

Hopefully we don't have to always provide mtval in these cases. The
RISC-V priv ISA says that mtval for illegal_inst exceptions are
optional, and the faulting instruction address will be reported in
env->mepc.

The ISA also says that we can set mtval to ILEN/MXLEN bits of the
faulting insn address, and we could do that when we're not able to fetch
the opcode. But that would add inconsistency in how we behave since
mtval would have either the opcode or the insn addr, and no easy way of
knowing which one we have, and software would need to check it with mepc
regardless. Zeroing mtval when we don't have the opcode is clearer.

And yes, zeroing mtval due to an unwind failure isn't ideal either, but
it's less worse than reporting a wrong mtval. Until we figure out a way
to fix the unwinding in this case, let's clear mtval and let software
know that it must find the faulting opcode via other means.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3020

Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c |  5 +++++
 target/riscv/op_helper.c  | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..1cd1849a1d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2243,6 +2243,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             break;
         case RISCV_EXCP_ILLEGAL_INST:
         case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
+            /*
+             * Note: we'll set tval = 0 for illegal_inst cases
+             * where we failed to unwind and to get the proper
+             * opcode. See riscv_raise_exception() for more info.
+             */
             tval = env->bins;
             break;
         case RISCV_EXCP_BREAKPOINT:
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 15460bf84b..930981a076 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -40,6 +40,27 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                           env->pc);
 
     cs->exception_index = exception;
+
+    /*
+     * There is no guarantee that we'll be able to unwind
+     * and set env->bins (the opcode for the current PC)
+     * properly via the cpu_restore_state() path. The RISC-V
+     * priv ISA says that:
+     *
+     * "The mtval register can optionally also be used to return
+     * the faulting instruction bits on an illegal-instruction
+     * exception (mepc points to the faulting instruction in
+     * memory)."
+     *
+     * It's not ideal to set mtval != 0 in some cases and zero
+     * in others due to unwind failures, but it's way better
+     * than to set mtval to a bogus env->bins opcode from
+     * the last successful unwinding.
+     */
+    if (cs->exception_index == RISCV_EXCP_ILLEGAL_INST) {
+        env->bins = 0;
+    }
+
     cpu_loop_exit_restore(cs, pc);
 }
 
-- 
2.50.1


