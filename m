Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F26C5479A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMy-0003xN-N3; Wed, 28 Aug 2024 05:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMx-0003r4-3e
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:39 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMv-0001qr-JU
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:38 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5da686531d3so5092679eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838816; x=1725443616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FVE9uwE5SGNsSu9ob6L64WLDml4rbiZ/hyx7tyV/IQ=;
 b=IKBsic42fRyfnnfVFwpJCQiyT3Cgizw8TBWnEEKl0TJ+xB0UBGEgv9x3RU/r+Zsovq
 pNOSDv8fjGW6piCXMuZYYt7r0pczQjIW3Q5Z/esbrOSFdv48QxxLmytn6IIcxIGyZJPE
 gfuLeQkUiD1L9KZ2q5ZASNwVi6VwDMLiy3weDWvSHy3wM4FUhR+LqgQ2HABGjTxn/i6e
 AgDgnQ30Ob+Vod55CCOFIhqaw2Em8frQK47HFD96mCtwgLjHf1xwNGOnbAOccDSKo3Wj
 O/HqPBjstQ4NMMC2+wmlfvLn3O0q4oAQW3FdDBszKjbHs4kaZAhe1v9lBEOHDWVT8LQM
 ielw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838816; x=1725443616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FVE9uwE5SGNsSu9ob6L64WLDml4rbiZ/hyx7tyV/IQ=;
 b=GpCUNlW2lIbmaLmZk0QWKB12wa856rNOe+jVeB/Y+akU+sWrs774PMKYucmdK9lYhD
 IsonIYvcZjler6h842gJ209P+M9uve60KHfRh6ja6n2pWAGkNBdmw5DYqDKbfnOH+I74
 nXeRB4w2oYe/vkqr5PWEYWmFxQ5MnAN5IGjh2yvtlubTpvEfDaQsD1MRuVmvjsMjGp4W
 TFkE8AY6WaSniTx1FzDBI4X3PvpGe0NdV//02GEzN6cMoLReZKzqVWXKnXu6qEBiEoGF
 Va0CnUIGXI4T+/23ssoVY6bGRI4JK75omKDRwBp9/6wtlJHqfrUkL5UqzmtlX2D3WJ8M
 Kp8w==
X-Gm-Message-State: AOJu0YxzvtMhIycE4ur0qbBxepHdX2hxHxCOj0zlPCLSHs6DS13mIw3d
 o9fkkZAUJIV+U1sPB8vsV3W8pl/5O9CBTkJ4Z3d4omv/676yJd0j+HEmCg==
X-Google-Smtp-Source: AGHT+IHR+mVWu+8f4uV9yDbglWqT0a7Hw5K/+g4Rp9SbCBYcuNeahjokD+i/+bfrKiTDqXgVcxAr9Q==
X-Received: by 2002:a05:6358:d39b:b0:1b5:e9d4:66f4 with SMTP id
 e5c5f4694b2df-1b5e9d467eemr733723255d.9.1724838816173; 
 Wed, 28 Aug 2024 02:53:36 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:35 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 16/17] bsd-user: Implement set_mcontext and
 get_ucontext_sigreturn for RISCV
Date: Wed, 28 Aug 2024 19:52:42 +1000
Message-Id: <20240828095243.90491-17-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc2a.google.com
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

Added implementations for 'set_mcontext' and 'get_ucontext_sigreturn'
functions for RISC-V architecture,
Both functions ensure that the CPU state and user context are properly
managed.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


