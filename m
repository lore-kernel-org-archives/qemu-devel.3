Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24637C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkt-0001cO-IF; Fri, 02 Aug 2024 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkr-0001LO-7Z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:17 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkp-0006jS-Gi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:16 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-26119999171so5423885fac.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587714; x=1723192514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub55mYjo8eKJZWzZaO7/xrNx8gK4oU8jbRvbKSQQd5Y=;
 b=MFG1soC4yxYMrX5w9nbp8SR/9YQR2+Xxq+LB6IWZtGA34US9UAvVdYHy1jaKtA//Ec
 XYJ/6sSQchs8Ts+87P7K7a32wtrUn17liJvVTUd2s1pYthZwJx3AYpvVG2Dsm//8Q77J
 m/vHUCsg+JfT9sso5+0w3CVgp3+IezZxdQEUCVSNlLiURJue8T5WdMbaF/ezv8a3pHhd
 a7WdPAGTeuHxgE6OTCSyv/IIMbMgvMbQsTwDJm1LZ7q1PXmyLI2Cg96oD2fTxDGpuGXc
 5EGdlnJKiRpat/TR/gQtdnDnYrWye9MxQtjLongS8UgMh+NQNtC/EOZPWIZaPgghWHTi
 /ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587714; x=1723192514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub55mYjo8eKJZWzZaO7/xrNx8gK4oU8jbRvbKSQQd5Y=;
 b=fz10RtFq65RF4ydw+FyPf9zLryRDhYt4SQC0M7vDy95jyeHgD/ZyTC9I6bmwaBJLhj
 DMgfet98n3ndj4+R3PFeBM+wKQzqTt5qoPEU2YsIykM8ts4t7p5+584pklnDp/36FjDR
 TNls+5UBIvkl10QkEvOBgRiLajX2nCuW6ZYWu66DPeca/1XfEdv1UBX0kTa5RyUAmLkF
 0BXtyoLAdL8CiH2vK5cjrc3P3Bsf62VHlaLmEQOPsvCOxhctsiL/+t91HbGJM0d8t7Q0
 GW/0TMNjp44iUrJs7sS0oFlfWqxNedTtD0iVVYil8FGNAyux4RqwZawsgvbcL+HYL5jr
 YgOQ==
X-Gm-Message-State: AOJu0YyQKsBtpEqBLUamZAAYv+/eifZGwECRvySVmo0GLrAGjwGpHVNZ
 g32H703Qwb8ki9SZRp514B4iu0zuib35k7e+2w347VWBIls1BJuQgxLjHIiWvt4=
X-Google-Smtp-Source: AGHT+IFzsCKjI+rRpax3TY45SOh3hzfHbWHpkgts8Iv7hNVWKfDC5QVqwxGqAmlEB9B91Dkvig3ogA==
X-Received: by 2002:a05:6870:9122:b0:260:fda4:365a with SMTP id
 586e51a60fabf-26891ed43f5mr3346061fac.33.1722587714005; 
 Fri, 02 Aug 2024 01:35:14 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:13 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 16/18] bsd-user: Implement 'get_mcontext' for RISC-V
Date: Fri,  2 Aug 2024 18:34:21 +1000
Message-Id: <20240802083423.142365-17-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=itachis6234@gmail.com; helo=mail-oa1-x36.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Added the 'get_mcontext' function to extract and populate
the RISC-V machine context from the CPU state.
This function is used to gather the current state of the
general-purpose registers and store it in a 'target_mcontext_'
structure.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/riscv/signal.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
index 005eb53cab..be6aa8efc2 100644
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
2.34.1


