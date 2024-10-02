Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165FBCF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIS-0000LF-CZ; Wed, 02 Oct 2024 01:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIB-0008Rn-NR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIA-0004xJ-1D
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20aff65aa37so50374175ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848366; x=1728453166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cg5V26fxSf+8PSayT4uCJqnh/iL9F8w1aRyk79raAGM=;
 b=MGIWNaKNaYabzuMzhL8oA8j0oR5yOgcjHcYbgpXL7VB+D8Btv7dEAQHYn1RyOPOtvI
 H6+Wt9LsbaqRzeqW7ihkBo4MturzeG9BO8QLQMfV3365BKUEud7UdIa6+gaOd1A5OgqK
 aC0qLNDUX3Pyd57k4Ahf0yALVt+3y8TPSljizO7JOwkpHi7hK6NhXEemOr9MSY2y2bGU
 wgJCjYx6Cd2m5+Z2GkrgzbWBL3+vxJxvaXuMxuMeISAOawYzkgJ4hADRAfgBS4/BfXk5
 /bxxIAlYwMzIyAtxB6Oun/9CbNahPyK3fAu0oUjkH9VocyjI/oqt57tGe9zYqQWiGTJp
 4//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848366; x=1728453166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cg5V26fxSf+8PSayT4uCJqnh/iL9F8w1aRyk79raAGM=;
 b=ZsBu73yzkx9Odgn7ur1IKuXxHHXWi2LmNuxjJBzw+jYZWzOj/kTn6+Suxr43qcDoJh
 otlRJaVoxClTCqD9h7hpXhEF5Vtl8Axl/s+8igzxnu0FshFA8m3lZaDBJMzUolZu2AvX
 uyV9JpDHss79aJBhFI54oKplQJthPuUASwVbKpu/y1VHcjcy8pK5sz6gx9FEu2DLVcYY
 vI/ZYYAtITcP5g0oIwUmAyCL/jyOAzjSV7p2YFEAfhUJHRG9gQkzLaWcNk0Do95kxUau
 goRo9hhEoUIYos4D5O8FIny8kZkbxzOTfX0kx4uvzl8nyGp8vIeXOh8FLmdPDMvQ9b0o
 5Yhw==
X-Gm-Message-State: AOJu0YxzKvJp9zzg2lmoXCMcGn9fd3lerNNN6SMYn02OOL7HzlrDwBok
 6bBry9JXDUoV19qbQm/xj8RQvbnFLA1VQr1qqa547sZKRdN1oRSgobA/XvHt
X-Google-Smtp-Source: AGHT+IH2h8g6hLQOHGgDnULtaNyA1TBG3Pv69lJkRtlFxkLp/rPGwfRFTxnGdXmwoLPAeVKbjCloSg==
X-Received: by 2002:a17:903:32c9:b0:20b:aebb:e17c with SMTP id
 d9443c01a7336-20bc5a52cc6mr28896835ad.36.1727848366152; 
 Tue, 01 Oct 2024 22:52:46 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 34/35] bsd-user: Implement set_mcontext and
 get_ucontext_sigreturn for RISCV
Date: Wed,  2 Oct 2024 15:50:47 +1000
Message-ID: <20241002055048.556083-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

Added implementations for 'set_mcontext' and 'get_ucontext_sigreturn'
functions for RISC-V architecture,
Both functions ensure that the CPU state and user context are properly
managed.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-17-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/signal.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
index 072ad821d2..10c940cd49 100644
--- a/bsd-user/riscv/signal.c
+++ b/bsd-user/riscv/signal.c
@@ -114,3 +114,57 @@ abi_long get_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
 
     return 0;
 }
+
+/* Compare with set_mcontext() in riscv/riscv/exec_machdep.c */
+abi_long set_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
+        int srflag)
+{
+
+    regs->gpr[5] = tswap64(mcp->mc_gpregs.gp_t[0]);
+    regs->gpr[6] = tswap64(mcp->mc_gpregs.gp_t[1]);
+    regs->gpr[7] = tswap64(mcp->mc_gpregs.gp_t[2]);
+    regs->gpr[28] = tswap64(mcp->mc_gpregs.gp_t[3]);
+    regs->gpr[29] = tswap64(mcp->mc_gpregs.gp_t[4]);
+    regs->gpr[30] = tswap64(mcp->mc_gpregs.gp_t[5]);
+    regs->gpr[31] = tswap64(mcp->mc_gpregs.gp_t[6]);
+
+    regs->gpr[8] = tswap64(mcp->mc_gpregs.gp_s[0]);
+    regs->gpr[9] = tswap64(mcp->mc_gpregs.gp_s[1]);
+    regs->gpr[18] = tswap64(mcp->mc_gpregs.gp_s[2]);
+    regs->gpr[19] = tswap64(mcp->mc_gpregs.gp_s[3]);
+    regs->gpr[20] = tswap64(mcp->mc_gpregs.gp_s[4]);
+    regs->gpr[21] = tswap64(mcp->mc_gpregs.gp_s[5]);
+    regs->gpr[22] = tswap64(mcp->mc_gpregs.gp_s[6]);
+    regs->gpr[23] = tswap64(mcp->mc_gpregs.gp_s[7]);
+    regs->gpr[24] = tswap64(mcp->mc_gpregs.gp_s[8]);
+    regs->gpr[25] = tswap64(mcp->mc_gpregs.gp_s[9]);
+    regs->gpr[26] = tswap64(mcp->mc_gpregs.gp_s[10]);
+    regs->gpr[27] = tswap64(mcp->mc_gpregs.gp_s[11]);
+
+    regs->gpr[10] = tswap64(mcp->mc_gpregs.gp_a[0]);
+    regs->gpr[11] = tswap64(mcp->mc_gpregs.gp_a[1]);
+    regs->gpr[12] = tswap64(mcp->mc_gpregs.gp_a[2]);
+    regs->gpr[13] = tswap64(mcp->mc_gpregs.gp_a[3]);
+    regs->gpr[14] = tswap64(mcp->mc_gpregs.gp_a[4]);
+    regs->gpr[15] = tswap64(mcp->mc_gpregs.gp_a[5]);
+    regs->gpr[16] = tswap64(mcp->mc_gpregs.gp_a[6]);
+    regs->gpr[17] = tswap64(mcp->mc_gpregs.gp_a[7]);
+
+
+    regs->gpr[1] = tswap64(mcp->mc_gpregs.gp_ra);
+    regs->gpr[2] = tswap64(mcp->mc_gpregs.gp_sp);
+    regs->gpr[3] = tswap64(mcp->mc_gpregs.gp_gp);
+    regs->gpr[4] = tswap64(mcp->mc_gpregs.gp_tp);
+    regs->pc = tswap64(mcp->mc_gpregs.gp_sepc);
+
+    return 0;
+}
+
+/* Compare with sys_sigreturn() in riscv/riscv/machdep.c */
+abi_long get_ucontext_sigreturn(CPURISCVState *regs,
+                        abi_ulong target_sf, abi_ulong *target_uc)
+{
+
+    *target_uc = target_sf;
+    return 0;
+}
-- 
2.46.2


