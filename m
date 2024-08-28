Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0619C5479A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMx-0003s2-CI; Wed, 28 Aug 2024 05:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMv-0003jB-2J
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMt-0001qi-Fa
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-714262f1bb4so4804798b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838814; x=1725443614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=ghpbtg+egFMkAtoh6Slu7QR2fXV6vyQcvG7Xq6eYlDwisExVMKcn9w/o+24GByIvxn
 ZtEbLlU8YqRjSR82AXK72gmw6UB7NjFDrNGDXn4rQAdm3vZoJLqB2gVGxwnQ1uCEzhvi
 kNaFCIbzq+hrXXVTo8KErxWHlgdjLKYlhDhLiB3MGJlA2rONHK0W0psp8TyyKvi56omU
 9jUaSR3rNR0tcuKQiFhozz8XC/TktaRh4nZUbGfA/0CnEUZDbqEqKduPW0/THy6QVPBH
 LrkGrhKOMPxqxV223K0cpKuHHE8obikkOlO1VnzfFyqwDTUN4I6l4nIQqpA3MWwQqAl0
 K6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838814; x=1725443614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=qoqm/9AWproTBDnehjKSHHcMqAL32zSZaYWSaONfDP0rPd3/jHpUxNyXfy+XTxZK7f
 jlYSD34wWAo58XlFufIthP0AgXloWEZZ44rIBMH2LReGZoZjpFOLTAxPNneQJyHFBHZW
 UY6Oj8HSTCo7DihLzLopiPiRHiPgPHEWefcTTJMSksaeeQXDHsJbraCUIrb2R4KiSPak
 HUrUc/G/lcvXlm56YT5zL0GvFpr8S+j9y6eBAC0qX7FD0Zg/Yv+naXJby1PoDbn1rw3e
 xV3YdOAGxdBGwnA6Kdy+iYGqftgYJexWsi//j57pOEk8x88EeQKUFn0BGrd8zUEN9YX8
 cl7w==
X-Gm-Message-State: AOJu0Ywnp01tHw3rc5qf5P9iyxGMGZYvlyUihZIVoZkQ4O313udyY8cu
 chVPqVvL55hSfUotTQw9QHIix9zElVJCWgR6tvrRcZTjh1eZFyHC0rDHTg==
X-Google-Smtp-Source: AGHT+IFRCPZSwDfAN08AzcETmd8mcfCLQ3Fl93n0/EgbXbSaiKcpMZpSOCLs2ztQJFztONmSD233MA==
X-Received: by 2002:a05:6a00:91db:b0:70d:311b:8569 with SMTP id
 d2e1a72fcca58-71445ed4f93mr14654698b3a.26.1724838813694; 
 Wed, 28 Aug 2024 02:53:33 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:33 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 15/17] bsd-user: Implement 'get_mcontext' for RISC-V
Date: Wed, 28 Aug 2024 19:52:41 +1000
Message-Id: <20240828095243.90491-16-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.34.1


