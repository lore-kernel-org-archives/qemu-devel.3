Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64028E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm3K-0005rs-Iq; Fri, 06 Sep 2024 23:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzt-00045K-2P
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:31 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzm-00055z-9V
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso2345308a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679216; x=1726284016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=cyHApW9WXvxnTgEMYzhO45SyY0PjsYAR5Ud8bLhRLonROqy3nEMzM5zHgs3Jsb/+RW
 uf9oU93LUO5Jlr1irK7xccf+obLCUqqGDg5oCXsCBzrrv+zgVuZchcSbXqffl4dYYUQw
 YfK+HRDHj349ymA54rTLgVTWz6JDmLQdiuASmiNuO2j6tQGsv/Y/r1grhGAEP3rZIObp
 ybK1nJ2JbmoSupTQqDTg4QKqvHg3xZiXbHUOprhNv4FAqt2IKab2LxZz0Fg4eRe0DdNA
 Kb0gEEpqWJui7Pu7HRQz7PxfiOi6PyVp3bGzgFAIbe1lE9uihHR2+d6EOWBrbkXqEXMD
 YTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679216; x=1726284016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy74LlRTmtwc1XLq4kdnjaS7OlYM0YhDmnWN/nXgpX8=;
 b=XNeq0bNWOZwYq91xYUymz8yLIspjYLYY1LLfwdYGkdydlIzjRI92sjObwGQdxdNVcJ
 YBnr6ZegMMqIjn8vk4KuoU8uNKHzl+hSniksxsknwetqu19FaM/tP5K4qikRa/ewXQiQ
 Stfk7eu1JKsZZPDdkRkuRrZy2F0Db2mJQkMMLFKTLjOxqaNk4/nsTPPSe7w7Y7w9uOGl
 XYjbFnzXjDWR+ItJ/WKsd8GtCoXh05f2+4om7JqG3+Gdoq9hoUghv513u0b+esHwVo8e
 ZdLzGrwq7NbX450GNMOhKiuf5ojKVk3xh2AHHCZWAJLJjM6nmaFAK0ERXls88OtNeJf1
 Oavw==
X-Gm-Message-State: AOJu0YwCWG79YU/Ju81z3zGDiRzLwLK6JHJwAN0qyHhCNdYfGkzWrOYD
 PnY2zdBEOD6xTQh4SLjN0AhMmt3LNNVFzRe3DNtMmUMxqj9/mtbON+JsOw==
X-Google-Smtp-Source: AGHT+IGtkE+zlj86r0vToS4skCXEto0qt/uIG/uMrwycEPfLWJp7r6Yo28qsQLdKFX9Zcs2ZFwfBkw==
X-Received: by 2002:a17:902:f606:b0:205:76f3:fc2c with SMTP id
 d9443c01a7336-206f05157bamr69164895ad.16.1725679216575; 
 Fri, 06 Sep 2024 20:20:16 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:16 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 15/17] bsd-user: Implement 'get_mcontext' for RISC-V
Date: Sat,  7 Sep 2024 13:19:25 +1000
Message-Id: <20240907031927.1908-16-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x532.google.com
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


