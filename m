Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F17F436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkWI-0006Jk-BW; Fri, 17 Apr 2026 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkWF-0006GP-Mj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:50:07 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkWD-0007Wy-G0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:50:07 -0400
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56e91f17a99so510933e0c.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776437404; x=1777042204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3BlBc3lz7D9zmiWzkR8i/iKkBIK3+ol238PEeTSaSg=;
 b=cFpdaeNWS82hrNcojhLjSILdZxntKBiYylHJFM/KV+qj1O1B88ejdOfLBTSOzu2aoA
 GovVhrNLCZ1Rqg6ZzuBGnnJo+gpJ4LyeCuHCUFjMaz/XlsC9wIzjhOsj6fLSWGLe7Hcy
 UIxgbec8AS710gnj6JjojYOrLyIvPm0bR7fu78B3B3eoju87T4CrMmhYApCf0GpuW5Yu
 AahZhBtjiWakOT3Va0Vsrr4gr191yYl8HbAMW2VGuk5fkmQ4VfR3p1jLcg25P/IdrbXZ
 8nDscaocwIu3ZZa5XY4v0gQX2ULicqI8Qq8Q8PVundFKkFb/UWdEIRVwXSZrWnBHXZY/
 +FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776437404; x=1777042204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3BlBc3lz7D9zmiWzkR8i/iKkBIK3+ol238PEeTSaSg=;
 b=b7xV6RMKwcx5ZPCf1272y2P+O+TcPWsBisYY7oUPW4685SAVtPVz/Z5StOaIxA10Me
 ZM9lGDXFB11WXVTg9FVmjIjdCKYKdqOr7CCFBlYYP3+QxHpsUlnwBsbFKJKwIqg7zj4A
 r9hzxNF5brFY00ZStgCLjNL6yCd82WV7urVg5D50GGO2iuar7tASi4q80uhYtj8AR5IA
 o67QAPa87AskfbokMzxsWddfgjyT1ah/1LbPo/4foaDXzHSEZZG5RY5uTIpuGVSiQzt0
 vDwWd7ovbRelFKp8fKume1AVMyYNTaYfCqO0l9+FXcP54x4xNkGUXoRHfa9sDkMfz6YS
 6HOg==
X-Gm-Message-State: AOJu0Ywpf3/W7+iiOkl5aUvocOuk46FBrffb+cpKKbbVjyy4/5pDpoNc
 o7Kzsjh6aPzc7wtOk2V1CoR1zQOcOV68oLOPdtN7gh/xRJkuZFDkgOuG
X-Gm-Gg: AeBDiesGa8rOF9kB/Lf9jQIbSbhi8qS5ggMkEkXe6GBML/EA8hS6avVJPqoonCkvLxJ
 mtF1PUnnUN1QbHrZMFXZGfT/vBb1+0qU7dFQ/38q8ody8OGr0rX33J7SUbuG/O8gdJLTZKm29gD
 E8NeFAIwUVe2HJIkPP/E8yhP+P87pb3uJiJhJNMhDCLAjrUG3k9gKS2fx8Zc/HWTtQeBbiMMLM2
 MUef18siLbytVvPEiv3pBQyGh5JpWy6TiUA3Lt1ZQtF82iRks6V0bpa4BGQ2nd8tRsWzXJEcjMC
 CO2Xwynv3Pa8xZQ2bxSz7HRgoBhBeCpYn2H0+pyuENlTbnRyF0MSrzdNIgRzZILzGxkQorOLNuD
 HI2UMCDIUDRdp/SiDWlbL0zEnkIB5hIRCjRChEWngGxgS+O8tJW66HDf8GkENo3tZPVkXqotRuu
 G21RyRf1+nucuYDQL6g8zQQJMGTXag0vuKdvusTyaxO0NYSdcd9VFityMoUXEXHD4IbYSwq6UoZ
 Qoroh2lnwDu8w9pyw==
X-Received: by 2002:a05:6122:3704:b0:56f:a329:6859 with SMTP id
 71dfb90a1353d-56fa58a562cmr1849335e0c.7.1776437404250; 
 Fri, 17 Apr 2026 07:50:04 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa92f21bbsm954365e0c.11.2026.04.17.07.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 07:50:03 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v10 2/2] tests/tcg/riscv64: Add test for vlsseg8e32 instruction
Date: Fri, 17 Apr 2026 22:49:32 +0800
Message-ID: <fc0e1cb69ab0540a8e31a5f85522437e784c952e.1776437127.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776437127.git.chao.liu.zevorn@gmail.com>
References: <cover.1776437127.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa44.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This case, it copied 64 bytes from a0 to a1 with vlsseg8e32.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Eric Biggers <ebiggers@kernel.org>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 ++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..05c8f851e0 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -7,7 +7,7 @@ VPATH += $(TEST_SRC)
 
 LINK_SCRIPT = $(TEST_SRC)/semihost.ld
 LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
+CFLAGS += -march=rv64gcv -mabi=lp64d -g -Og
 
 %.o: %.S
 	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
@@ -41,5 +41,10 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-vlsseg8e32
+run-vlsseg8e32: QEMU_OPTS := -cpu rv64,v=true $(QEMU_OPTS)
+run-vlsseg8e32: test-vlsseg8e32
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vlsseg8e32.S b/tests/tcg/riscv64/test-vlsseg8e32.S
new file mode 100644
index 0000000000..bbc79d5e8d
--- /dev/null
+++ b/tests/tcg/riscv64/test-vlsseg8e32.S
@@ -0,0 +1,107 @@
+#
+# QEMU RISC-V Vector Strided Load Instruction testcase
+#
+# Copyright (c) 2025 Chao Liu chao.liu@yeah.net
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+	.option	norvc
+
+	.section .data
+	.align 4
+source_data:
+	.asciz "Test the vssseg8e32 insn by copy 64b and verifying correctness."
+	.equ source_len, 64
+
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+enable_rvv:
+
+	li	x15, 0x800000000024112d
+	csrw	0x301, x15
+	li	x1, 0x2200
+	csrr	x2, mstatus
+	or	x2, x2, x1
+	csrw	mstatus, x2
+
+rvv_test_func:
+	la	a0, source_data
+	li	a1, 0x80020000
+	vsetivli	zero, 1, e32, m1, ta, ma
+	li	t0, 64
+
+	vlsseg8e32.v	v0, (a0), t0
+	addi	a0, a0, 32
+	vlsseg8e32.v	v8, (a0), t0
+
+	vssseg8e32.v	v0, (a1), t0
+	addi	a1, a1, 32
+	vssseg8e32.v	v8, (a1), t0
+
+compare_start:
+	la	a0, source_data
+	li	a1, 0x80020000
+	li	t0, 0
+	li	t1, source_len
+
+compare_loop:
+	# when t0 >= len, compare end
+	bge	 t0, t1, compare_done
+
+	lb	t2, 0(a0)
+	lb	t3, 0(a1)
+	bne	t2, t3, compare_fail
+
+	addi	a0, a0, 1
+	addi	a1, a1, 1
+	addi	t0, t0, 1
+	j	compare_loop
+
+compare_done:
+	# compare ok, return 0
+	li	a0, 0
+	j	_exit
+
+compare_fail:
+	# compare failed, return 2
+	li	a0, 2
+	j	_exit
+
+trap:
+	# When an instruction traps, compare it to the insn in memory.
+	csrr	t0, mepc
+	csrr	t1, mtval
+	lwu	t2, 0(t0)
+	bne	t1, t2, fail
+
+	# Skip the insn and continue.
+	addi	t0, t0, 4
+	csrw	mepc, t0
+	mret
+
+fail:
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.53.0


