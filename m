Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F45C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TI-00065a-FL; Fri, 16 Aug 2024 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TA-0005Le-9P
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sw-0007NC-Hh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:30 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so1523589a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828216; x=1724433016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=XUwe0/e3mWEB/5or7pcJMJuVVlS2WFvc9P0pYyXjIybvwnZ60VylD/t4cU6kg+KYY/
 IMNhLiDnowQJqD45T7HkYBu7nIFKWa7BkehnNgd+q9fz3SqmryrnlmFVOC1Smte/E6Yb
 j6rzLUV+nTY8lEOmLxNKAkq5JmkUPz9sjdcPn7sGAzwcRSkdL4a/LZVf5WlRAq7RjHDP
 zcksIj/A7J+Gnbtzgr2EAiPlAiz4YDo0BNG6Dwu5FBBC35q7GMQx68txZ9uYclUK+rBC
 hdVkLHM66h5/i2NESMXXUoeLjXoxjn6ygjwVAkcDA94e2dm7zRzsLtxVTGu5lwbB17zO
 8p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828216; x=1724433016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=UuA9Zr0W5xcIEh/1ziV4tTEV3t1lJIYSsQbENgITr95l86+SeDlHCKLMpFxQ4Czz/o
 8x8Mllq7OfUI8A/yKRbL2q2JTH5H35vrP0mp4nz4/hkAej8Qx/gmDj63/HVEKYVENt0i
 Gzl7kPsX8aNoxiNXJ8TAE3YZQjriwvweFfdxoiX3rppTvfhxwarP1VIeDnepnx6YnBDG
 ozG4WIiltCeSsywdv3/RhQWKlvL9hcVhMqQkoYrg6Y8MBKrYgJXzAHzr8K+RKMO/VV81
 3NjhaCTTLopht0q1vzmaxwTIkDkeSPJJ1E+1pbKOL+EO86dOFC/+JZ1my21ymjLdbpVx
 /8Zw==
X-Gm-Message-State: AOJu0Yxj642ZAsr8/vtFN3YPUcmCelSSPBzmCgTYr8ATcN0eufcChnRt
 Jepd8Cz5C0x+uaqM5A185nJHgujN+2U4CZROtZ7xW++3rEjG0wY0Tx08uxWQR2I=
X-Google-Smtp-Source: AGHT+IG7DLCzkBqmtaasx864Q++FJ+rbCuav7V8150xy/9F79fFYfxpEBvITGdwhvhzuE75ywS4iZA==
X-Received: by 2002:a17:90a:68c7:b0:2c9:6753:6192 with SMTP id
 98e67ed59e1d1-2d3e457a19bmr4856599a91.12.1723828215476; 
 Fri, 16 Aug 2024 10:10:15 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:15 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/17] bsd-user: Define RISC-V register structures and
 register copying
Date: Sat, 17 Aug 2024 03:09:38 +1000
Message-Id: <20240816170949.238511-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


