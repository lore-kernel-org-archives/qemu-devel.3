Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b4+nmSzn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLag6-0001t1-6o; Tue, 27 Oct 2026 02:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafr-0001qY-La
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafp-00089M-R8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:43 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ae486f8a27so85881a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082520; x=1793687320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z99+EbYL9ircoMk8I7rwOLWNLgY4UG5VcoYe5h5n/Hg=;
 b=b4+nmSzn3QHi1aJowezUHzqtzXWRGkIiZXNkfCU1wa+XPqTYnWd1CuHkINhqMxYJax
 8Y6YPFtyoA9baV1N8HTRSVRrsq3noyVShboVmZGrCQdm9tDtDxsGzu8F2O/U/oEs5lOK
 G7m51iFuMiA4GQaAbxLRK4eyzqKhDSQAAjvNshXYrZwcIaIkVc8MgWm73wqfZAIcOS7M
 d1zezY+OF7Lj3ToPZOu0jnKfghnnqMHJ8oIMR0m0noSRptV9eZpRN76NQCBlB3i/FLiu
 KjbsWyY2Vjo2tXFWF9IsZgcujANx02hZRoE6wM1THuKsWlnRwWkzxSmFJzLyQPULNXpe
 azJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082520; x=1793687320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z99+EbYL9ircoMk8I7rwOLWNLgY4UG5VcoYe5h5n/Hg=;
 b=Yag7ZZdeDmH9vnMrwqpkYJTD0x6GFZCotlGU3Zl99k9ENK0tJsxohaT6geI73ej1eK
 s1U3hCs2cyBbpMqBSc9pjdVeyS+eGra3a0MUJsrJ4fOb6MGLk6oaKPqLFsBIO00yNKgs
 NVqPtRTQSjbmbNG6molH/SIK4e/R5RVT1f6MRUz5LXFGC21SIc6bwf1DxqzRRNG9GxPm
 7n/MIZrbTCzSIFTvNVokok08dPqV+237QkONq4YD4NsMQ2DZmo6vez0tg/Bbz3Gj3GDO
 eVyXiMksUGJVK43AZ7yCKYH+y9yJs2IEfzQDdCpwJFm+62x05NaHcYYNkwWpb8B3y+C2
 xbhQ==
X-Gm-Message-State: AFq9FYJCNnzv9otv49+04GdP+cyyzoBaS7eM/1lnOGLvHW18HRKTqEeL
 kvo9Zz7lOHMbIRvx1jnbMkTATzGRbPfQTHG8C6X2uy1QhzHD2owYly4Xbd026w==
X-Gm-Gg: AYBFou1Ybc9RKpls8gXYOATGzR2Lu93+/PFUJY7BrNUe7Kjg4iep922Zh5xqA/1OQ2g
 vGwnn/TJLiRUVbv5CTyhAIA4NCFJHT9CNtFxGK0zaRiJAB2QPREa6QySBwL7/ODdjso5qt0fpg1
 0B9wvee4t85kuKKTQjhBaeb+GRz8Gxe7ybG7qikWpR0uA4XSAY+utt3wkO9RdR8poSXZganuvcH
 Cq4rIgXv/YKopGWivkg1opKPe6ETNs8E2BPWvWnXODfJHXPY3fJEYQeuDp6yVDRif/1P45HqkOm
 FPTIRnHuF907+lkronQeAEyQGBRHS7nexHRGfzepXp1vby3FkNPAIhiTd7WsxAifMZe/KyDjWCS
 1mbARRJqEbthlgwGfrfLo4OiuNxSu1lozYg5h0e1BicA+C/uIT/XRVQ5TFkaL2oW08UxzSFs8e8
 WrZ+QNz4mmWVWGkAfrfkuwL3Qz2vuLSrHTupESX76nlhc+x0D9je32pcmTSJRpYpX6ddT6TXeXP
 NNYARHHdR1riZHFm0q7D9CF8TTNbCUl7KBRwK6Dh1Iri3YZx0azWkn2jJz8jieKMiWXs33jlxcH
 qsPgee8DGdLrJcmXf8g2wj/4okddIuFD/HJW+WsSqJxSjAECE8FpZybFIvUAvJlPofTL
X-Received: by 2002:a17:90b:1fce:b0:39e:59a0:46b5 with SMTP id
 98e67ed59e1d1-3adeae70a21mr8258368a91.24.1793082520303; 
 Mon, 26 Oct 2026 23:28:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/29] target/riscv: mask vsepc according to IALIGN
Date: Tue, 27 Oct 2026 16:27:43 +1000
Message-ID: <20261027062808.1995205-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zephyr Li <fritchleybohrer@gmail.com>

vsepc is the VS-mode counterpart of sepc and is a WARL register, but
unlike mepc and sepc its accessors do not mask the low address bits
according to IALIGN.  As a result, values with invalid low bits can be
observed through vsepc.

Apply get_xepc_mask() to both vsepc reads and writes, matching the
existing mepc/sepc handling.

Add a TCG regression test covering both IALIGN=16 and IALIGN=32.

Fixes: 8747c9eeb2aa ("target/riscv: Add Hypervisor virtual CSRs accesses")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4420
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260915024945.32329-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c                 |  4 +-
 tests/tcg/riscv64/system/meson.build   | 11 ++++++
 tests/tcg/riscv64/test-vsepc-masking.S | 54 ++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vsepc-masking.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 063590f56a79..e6d25e5c4e74 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5484,14 +5484,14 @@ static RISCVException write_vsscratch(CPURISCVState *env, int csrno,
 static RISCVException read_vsepc(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->vsepc;
+    *val = env->vsepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vsepc(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
-    env->vsepc = val;
+    env->vsepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 99ba9913ac4d..3c8b018d9e98 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -26,6 +26,17 @@ tests += {
   'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
   'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
+  'test-vsepc-masking.S': setup + {
+    'test_name': 'test-vsepc-masking-c',
+    'qemu_args': ['-cpu', 'rv64,h=true,c=true', qemu_args],
+  },
+}
+
+tests += {
+  'test-vsepc-masking.S': {
+    'test_name': 'test-vsepc-masking-no-c',
+    'qemu_args': ['-cpu', 'rv64,h=true,c=false,zca=false', qemu_args],
+  },
 }
 
 tests += {
diff --git a/tests/tcg/riscv64/test-vsepc-masking.S b/tests/tcg/riscv64/test-vsepc-masking.S
new file mode 100644
index 000000000000..394a7f361c44
--- /dev/null
+++ b/tests/tcg/riscv64/test-vsepc-masking.S
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define MISA_C          (1 << 2)
+
+	.option	norvc
+	.text
+	.global	_start
+_start:
+	csrr	s0, misa
+	andi	s0, s0, MISA_C
+
+	lla	s1, test_addr
+	ori	t0, s1, 3
+	csrw	vsepc, t0
+	csrr	t1, vsepc
+
+	beqz	s0, ialign32
+	addi	t2, s1, 2	/* IALIGN=16: bit 0 reads as zero. */
+	j	check
+
+ialign32:
+	/* IALIGN=32: bits [1:0] read as zero. */
+	mv	t2, s1
+
+check:
+	li	a0, 2
+	bne	t1, t2, _exit
+
+	li	a0, 0
+	j	_exit
+
+	.balign	4
+test_addr:
+	nop
+
+/* Exit code in a0. */
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
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
2.55.0


