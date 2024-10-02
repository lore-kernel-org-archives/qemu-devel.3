Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E951BCF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIY-0000kr-8a; Wed, 02 Oct 2024 01:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIG-00006B-7I
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:53:02 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIA-0004x9-1K
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b8be13cb1so30709255ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848363; x=1728453163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XRYje7ijyuUJ+98lOYY8WVbGTtgCK8DuFfS8NUC/M0=;
 b=HpN1rBgCukfBb6EOwDDTsQvgBuszuK4s4yTVd+7aTxBoYCtHEzoPhhWrMK5+FDp3FV
 tM/Fr4bkye+8xKj1S5DEaE4QkJW7nbGSGMsZwwStTH6T7qkIEvrJjjmiCw5w2rjpxwk4
 E+RrwMGWtKXuAqW2aCZh1gHeXAncs46IS14p6d+r4u2AfM3ERWaMpjg16CxsxCvkUPr4
 QSmJK5Poy8/vuu5MxSVgF+c5WEvPijuj6iFsDPZqgSj6Qoo3iJ5gUlJpHQunEoQpQGTV
 IfHRjwVrac+oHesuY6qRZIS1Hus3t83FJs675baIBUGRtCOqMpyX/SiBzGBSX9CyV1Dh
 Wc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848363; x=1728453163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XRYje7ijyuUJ+98lOYY8WVbGTtgCK8DuFfS8NUC/M0=;
 b=Ed+5OmlyNBBPEWr7DFVzn52hSQuNhCVUgAa2xZu25CzzUsB5e4aWegT4rkOKOu+pa5
 +cJOXgCEzEc8YzYAtpUmz+u2ENYODx22cuxq+cNI/L2gXm+417G++ouL+zhXS+rVDFfV
 FMhz49Za0vHbVdSoAKOAFzvS24ZgbsjuLAEODzlepEJiLRWB4T31GoiN5GQs5kA1G26P
 RECMhTsg9JV8BncnhpIwjWwhCPJ+Ja7MPhp50sAaeCGvVMwTjdOZdUmhoFZgHRXW2C1N
 H+24Po1TWLOL6/VUEFFHWTk/wDRV/ZaHrFCrekSfBlCjIpZa1USMojm/mNeyJwbw4uP2
 u3mQ==
X-Gm-Message-State: AOJu0YyFeXdFHp1WUN3OdBhoko+UHfZ09NayUZwbR/3x+Ei1u6lnTEtB
 bbAUQ2xYbkiDEo/JwsZHAg1NxmvpIImaovQYR94kBMV3hQvmHftEHPT1lLSM
X-Google-Smtp-Source: AGHT+IFa44sroq1NrONgPn23kxomE7KXVS7z7NysLqh17jUxB3FwDiN6ukP5C4oJ3DCVUP7LED2HSA==
X-Received: by 2002:a17:902:e843:b0:1fb:57e7:5bb4 with SMTP id
 d9443c01a7336-20bc5a6a462mr29496785ad.37.1727848362614; 
 Tue, 01 Oct 2024 22:52:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 33/35] bsd-user: Implement 'get_mcontext' for RISC-V
Date: Wed,  2 Oct 2024 15:50:46 +1000
Message-ID: <20241002055048.556083-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Added the 'get_mcontext' function to extract and populate
the RISC-V machine context from the CPU state.
This function is used to gather the current state of the
general-purpose registers and store it in a 'target_mcontext_'
structure.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-16-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/signal.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
index 2597fec2fd..072ad821d2 100644
--- a/bsd-user/riscv/signal.c
+++ b/bsd-user/riscv/signal.c
@@ -61,3 +61,56 @@ abi_long setup_sigframe_arch(CPURISCVState *env, abi_ulong frame_addr,
     get_mcontext(env, mcp, flags);
     return 0;
 }
+
+/*
+ * Compare with get_mcontext() in riscv/riscv/machdep.c
+ * Assumes that the memory is locked if mcp points to user memory.
+ */
+abi_long get_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
+        int flags)
+{
+
+    mcp->mc_gpregs.gp_t[0] = tswap64(regs->gpr[5]);
+    mcp->mc_gpregs.gp_t[1] = tswap64(regs->gpr[6]);
+    mcp->mc_gpregs.gp_t[2] = tswap64(regs->gpr[7]);
+    mcp->mc_gpregs.gp_t[3] = tswap64(regs->gpr[28]);
+    mcp->mc_gpregs.gp_t[4] = tswap64(regs->gpr[29]);
+    mcp->mc_gpregs.gp_t[5] = tswap64(regs->gpr[30]);
+    mcp->mc_gpregs.gp_t[6] = tswap64(regs->gpr[31]);
+
+    mcp->mc_gpregs.gp_s[0] = tswap64(regs->gpr[8]);
+    mcp->mc_gpregs.gp_s[1] = tswap64(regs->gpr[9]);
+    mcp->mc_gpregs.gp_s[2] = tswap64(regs->gpr[18]);
+    mcp->mc_gpregs.gp_s[3] = tswap64(regs->gpr[19]);
+    mcp->mc_gpregs.gp_s[4] = tswap64(regs->gpr[20]);
+    mcp->mc_gpregs.gp_s[5] = tswap64(regs->gpr[21]);
+    mcp->mc_gpregs.gp_s[6] = tswap64(regs->gpr[22]);
+    mcp->mc_gpregs.gp_s[7] = tswap64(regs->gpr[23]);
+    mcp->mc_gpregs.gp_s[8] = tswap64(regs->gpr[24]);
+    mcp->mc_gpregs.gp_s[9] = tswap64(regs->gpr[25]);
+    mcp->mc_gpregs.gp_s[10] = tswap64(regs->gpr[26]);
+    mcp->mc_gpregs.gp_s[11] = tswap64(regs->gpr[27]);
+
+    mcp->mc_gpregs.gp_a[0] = tswap64(regs->gpr[10]);
+    mcp->mc_gpregs.gp_a[1] = tswap64(regs->gpr[11]);
+    mcp->mc_gpregs.gp_a[2] = tswap64(regs->gpr[12]);
+    mcp->mc_gpregs.gp_a[3] = tswap64(regs->gpr[13]);
+    mcp->mc_gpregs.gp_a[4] = tswap64(regs->gpr[14]);
+    mcp->mc_gpregs.gp_a[5] = tswap64(regs->gpr[15]);
+    mcp->mc_gpregs.gp_a[6] = tswap64(regs->gpr[16]);
+    mcp->mc_gpregs.gp_a[7] = tswap64(regs->gpr[17]);
+
+    if (flags & TARGET_MC_GET_CLEAR_RET) {
+        mcp->mc_gpregs.gp_a[0] = 0; /* a0 */
+        mcp->mc_gpregs.gp_a[1] = 0; /* a1 */
+        mcp->mc_gpregs.gp_t[0] = 0; /* clear syscall error */
+    }
+
+    mcp->mc_gpregs.gp_ra = tswap64(regs->gpr[1]);
+    mcp->mc_gpregs.gp_sp = tswap64(regs->gpr[2]);
+    mcp->mc_gpregs.gp_gp = tswap64(regs->gpr[3]);
+    mcp->mc_gpregs.gp_tp = tswap64(regs->gpr[4]);
+    mcp->mc_gpregs.gp_sepc = tswap64(regs->pc);
+
+    return 0;
+}
-- 
2.46.2


