Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C65BC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9Q-0007sx-8a; Sun, 15 Sep 2024 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9O-0007mq-B4
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9M-0008Ga-Pi
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2053525bd90so20691535ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726414015; x=1727018815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=l8KBLw7gczQDl1hfyBEIlFf0GgGntPZV5aqAYDQ2Yx3t0zWTLuOe+xKXcZrFDg/pFY
 HN/+6xm/ayNLelalJrgk2lIkd5A396Ek6r+bOM2DxvTJcivVnPGNJqWb0dVezwWxzyLp
 pdpjJEt0FdQNyIJGjm8HXddjWWH3oVdHCdQ55QDzkA5v1dKqpzHAS/d8LLTX1F9FQ3Vs
 ShfmyAt8UOM/19FCi0v+saFzBqePHzqEEuc5qMuSY2/3kjbLF6WnMuGpBW32Fu9rUENU
 y58LbrGzAngfVhVaRzWXQH/tGoOdzmX+ljBkMJCaIPI7RPqIF6x+SHKweLD/C7TrvqDC
 LyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726414015; x=1727018815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=DLFuH85oWdbckO2VzJcNmf3v/WY+VUk1pI3yEasErW7/JaCKgcCK4rTOI1IfhGOkqr
 M7O4Jk0Md2imEog/EabRvWulk2tyc9XKugbdHsO5PDnhgvE1F/0gvgdpICCqUMsamRi6
 sXVD/uLvtBUdh4nI4fcmwp2Ki21WdQORzzL81LScUSzUN+ABcH1e0+rulhR1w7krvycs
 yhLLQa8MdETRvB2tzq7poykQjRDLhrDXrFvNMbQmcMYosvzv/uODub0ICuubsEl1mp9x
 D6n0Y0mPUQ1qGnrwc5jwCFm8T7EP8mT6EN84HMbO+VQ0ItaQQUYNgID9p0KODAh4Hj83
 ks6A==
X-Gm-Message-State: AOJu0YyTeZLZmIIxxTUXhHZ37n49+mL1axwavN/baFjebM+uAbLWCUS6
 z8JGICp9tycjDtp1deAkc0/DMvHnNYOkG98p7WfuEmxtB3cNcT98PMx0OA==
X-Google-Smtp-Source: AGHT+IHau58JLY6Ku78VHDiG8lI6bEgv1JT5MyREJC1gNngDW8GMmQs7Qj0Bt5JBSf+soxAw6ti3XQ==
X-Received: by 2002:a17:902:db0f:b0:1fb:7c7f:6458 with SMTP id
 d9443c01a7336-2078243596dmr163949055ad.32.1726414015027; 
 Sun, 15 Sep 2024 08:26:55 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:53 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 15/17] bsd-user: Implement 'get_mcontext' for RISC-V
Date: Mon, 16 Sep 2024 01:25:52 +1000
Message-Id: <20240915152554.8394-16-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x632.google.com
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


