Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD78C3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE19-0007Yk-Cc; Mon, 16 Sep 2024 11:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE17-0007Sh-TO; Mon, 16 Sep 2024 11:51:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE16-0000V6-5J; Mon, 16 Sep 2024 11:51:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-206b9455460so35165325ad.0; 
 Mon, 16 Sep 2024 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501914; x=1727106714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=RzV5qcbVa2nj0Lm5jeqORRCcNSD2iolLYMxy5AydgBeRZqEiRc5vqzpYQiKdDItUL4
 Rmr9FQog3IDM/nWhpAgxjklPZlOzIcDFG+KdEMTSJffMBDO7z7U3XyFrQdNa88MwyxlG
 A1YicGiNdgSzqA/m31Ap3kIPbnfTiZULjSv90kBlEWuv7F8qnx6w/0MZwMgm0gnzi0Yb
 /a0/NZFQeVj1XPteYTpSmkhCZpgbn/hCzbsIkZBcTbN1dSH07kg3bhMzUaJKx+DBrCZ1
 FKHHQF3Q0x/Y5RRLFngBJ2aORAmzwf7Uho/lKqTSUjUAsOdKaVuDC64aURWqyz5Y5QUz
 Qylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501914; x=1727106714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=eVXZW4/s5re+duDQS73bIxea3Ns3tVoOzKW8D20N9rnHtO/iKnLoW0ltAfjRRVwLKy
 Qhv6TJVeTaexM6uldQXfmeRxkaDh9G+PjA7baCoql02Q/tkKFfgp/No8QameUQp9Ui33
 aNvHpHRJBp+T8WJZxS8gg6FS7DapuKwDLw7lSkkguVwsBX4Zs0KTrL9vpajNO5bgPGwh
 VJ1Wr1SdYctGVGkOmeGzHhqClaTL4igeB2DKZ3ZrrgtBnQKXesVBjpH1rwXNXUhwpgEB
 Xdst4MP1+cAbl2rKb7dIkPZ407hX7Kb61BRvkEjy8nN2C0TACrphq5IcpFFnIHadpsvE
 Ki6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5bc63mgrDplwxH20IKpf0E5+UAbiM4Trbu2cKd6nxJawhQScEolvCuoc523QzE7qRWIWEf20zf67q@nongnu.org
X-Gm-Message-State: AOJu0YwcvDmCHM12G2Iw4BTS6RvOU06JqIjdHRnAz1LoI44fksjhYC9h
 3+pkZmS530quZeQgEKY3lzaijORALJdESeNpgBAexdcb1hKVfDao9BvwOw9U
X-Google-Smtp-Source: AGHT+IGQT11ilGOBhstWx/nD8trFw8U4pzR5EQtFrIUQBuRY1SZ7BrwGAy98g0ylOQMotX6Zf8uY0g==
X-Received: by 2002:a17:902:dac4:b0:205:8b84:d5e8 with SMTP id
 d9443c01a7336-2076e5a3ed1mr222790015ad.18.1726501913973; 
 Mon, 16 Sep 2024 08:51:53 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:53 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 06/17] bsd-user: Define RISC-V register structures and
 register copying
Date: Tue, 17 Sep 2024 01:51:08 +1000
Message-Id: <20240916155119.14610-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x631.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added definitions for RISC-V register structures, including
general-purpose registers and floating-point registers, in
'target_arch_reg.h'. Implemented the 'target_copy_regs' function to
copy register values from the CPU state to the target register
structure, ensuring proper endianness handling using 'tswapreg'.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_reg.h | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_reg.h

diff --git a/bsd-user/riscv/target_arch_reg.h b/bsd-user/riscv/target_arch_reg.h
new file mode 100644
index 0000000000..12b1c96b61
--- /dev/null
+++ b/bsd-user/riscv/target_arch_reg.h
@@ -0,0 +1,88 @@
+/*
+ *  RISC-V register structures
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_REG_H
+#define TARGET_ARCH_REG_H
+
+/* Compare with riscv/include/reg.h */
+typedef struct target_reg {
+    uint64_t ra;            /* return address */
+    uint64_t sp;            /* stack pointer */
+    uint64_t gp;            /* global pointer */
+    uint64_t tp;            /* thread pointer */
+    uint64_t t[7];          /* temporaries */
+    uint64_t s[12];         /* saved registers */
+    uint64_t a[8];          /* function arguments */
+    uint64_t sepc;          /* exception program counter */
+    uint64_t sstatus;       /* status register */
+} target_reg_t;
+
+typedef struct target_fpreg {
+    uint64_t        fp_x[32][2];    /* Floating point registers */
+    uint64_t        fp_fcsr;        /* Floating point control reg */
+} target_fpreg_t;
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+/* Compare with struct trapframe in riscv/include/frame.h */
+static inline void target_copy_regs(target_reg_t *regs,
+                                    const CPURISCVState *env)
+{
+
+    regs->ra = tswapreg(env->gpr[1]);
+    regs->sp = tswapreg(env->gpr[2]);
+    regs->gp = tswapreg(env->gpr[3]);
+    regs->tp = tswapreg(env->gpr[4]);
+
+    regs->t[0] = tswapreg(env->gpr[5]);
+    regs->t[1] = tswapreg(env->gpr[6]);
+    regs->t[2] = tswapreg(env->gpr[7]);
+    regs->t[3] = tswapreg(env->gpr[28]);
+    regs->t[4] = tswapreg(env->gpr[29]);
+    regs->t[5] = tswapreg(env->gpr[30]);
+    regs->t[6] = tswapreg(env->gpr[31]);
+
+    regs->s[0] = tswapreg(env->gpr[8]);
+    regs->s[1] = tswapreg(env->gpr[9]);
+    regs->s[2] = tswapreg(env->gpr[18]);
+    regs->s[3] = tswapreg(env->gpr[19]);
+    regs->s[4] = tswapreg(env->gpr[20]);
+    regs->s[5] = tswapreg(env->gpr[21]);
+    regs->s[6] = tswapreg(env->gpr[22]);
+    regs->s[7] = tswapreg(env->gpr[23]);
+    regs->s[8] = tswapreg(env->gpr[24]);
+    regs->s[9] = tswapreg(env->gpr[25]);
+    regs->s[10] = tswapreg(env->gpr[26]);
+    regs->s[11] = tswapreg(env->gpr[27]);
+
+    regs->a[0] = tswapreg(env->gpr[10]);
+    regs->a[1] = tswapreg(env->gpr[11]);
+    regs->a[2] = tswapreg(env->gpr[12]);
+    regs->a[3] = tswapreg(env->gpr[13]);
+    regs->a[4] = tswapreg(env->gpr[14]);
+    regs->a[5] = tswapreg(env->gpr[15]);
+    regs->a[6] = tswapreg(env->gpr[16]);
+    regs->a[7] = tswapreg(env->gpr[17]);
+
+    regs->sepc = tswapreg(env->pc);
+}
+
+#undef tswapreg
+
+#endif /* TARGET_ARCH_REG_H */
-- 
2.34.1


