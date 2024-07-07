Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7AEC3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIe-0000my-0y; Sun, 07 Jul 2024 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXId-0000mm-8b
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIb-00059a-Pg
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so22586825ad.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379508; x=1720984308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QeYYhSPAIOJyKkxryN3Nk246i89++ucyqIxnORISd4=;
 b=OdjFWn5wM4rSaCxbrSNGokrwhJ0IX5Bz2jwNH4VRMb7LDxHeLPMFiIsaAUstQyxHex
 EELjCMdgREHiJghrs1qrY5SVxNQ+aOLrX8j6YTj7ZT1cRz3/2W+hNhkR7RzAtzMPav4b
 dsMvrjmUZpsQ6fZpvU+wY7lfW4gcK4Wt1zmXx8YqcCLqF7OEvpfu1RwbUtQoCvQ5c1HG
 klcMeDttzXHwDWL1f+b5Xey8hZxckhyCgYketYr608Rbi2C+uYYIN0M+0QOZyI6crfdl
 3SSSzgnmG1xptrkuu6Dqa1mJb9wceyBPQjnvuMxhdNqwyPmG7aVpP4aU/eKGDUz8cYyH
 /9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379508; x=1720984308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QeYYhSPAIOJyKkxryN3Nk246i89++ucyqIxnORISd4=;
 b=sOAAL3tF/JoPDYXfUthRX3fi9G7jRCvbQiPW0nCE1VzPGXFQGr1m0bNXGcdstaW6JD
 DP0ry+W4g6ngGft1NNMc9PFvwV4FhmZr19qvINkV3LQf61mYADH+7rGYJcp3wG9RynMD
 Q5nGCHj8IcE7/DJdnO5heH+GSsy9A95RuM9/8hpU4aHouLECANggfH3AZxG4nYupm54T
 S5KFuHRYvrOc3jVps2o5Ssju2KOcO6koXQWunIs8f8mUAZIjHeAk72jh5Y/jUmu2XjEE
 HX9WLG//X+V5aahdt15aN6KIZMYoFVMPvM2ViWeQMKOY84caYogoOdEV05Jnmz8SUMG5
 52Sw==
X-Gm-Message-State: AOJu0Yx9RbuZYjMNXYfwMy6+ki/zlLW2uLazzxlGyVBzgjzS6P0IVNKm
 sPsQ4Wk+2u/AiIf4uAECF74Aa+0mRYOR3Gtz2rTAuiEpgAnqob5jVFNv0Pt9
X-Google-Smtp-Source: AGHT+IEOpgOprySwIe49Tz7iuItn+AUFtDpWnuVdEhm6ZbquG9KwJuDeIej/9Edzbwcron4XC3eGCw==
X-Received: by 2002:a17:903:120b:b0:1f6:ed74:b4e3 with SMTP id
 d9443c01a7336-1fb33e0511amr115189115ad.3.1720379508057; 
 Sun, 07 Jul 2024 12:11:48 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:47 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v2 5/8] bsd-user:Add get_mcontext function for ARM AArch64
Date: Mon,  8 Jul 2024 00:41:25 +0530
Message-Id: <20240707191128.10509-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
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

From: Stacey Son <sson@FreeBSD.org>

function to retrieve machine context,it populates the provided
target_mcontext_t structure with information from the CPUARMState
registers.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/aarch64/signal.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 98861f9ab3..ab3bf8558a 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -51,3 +51,33 @@ abi_long set_sigtramp_args(CPUARMState *regs, int sig,
 
     return 0;
 }
+
+/*
+ * Compare to get_mcontext() in arm64/arm64/machdep.c
+ * Assumes that the memory is locked if mcp points to user memory.
+ */
+abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
+{
+    int err = 0, i;
+    uint64_t *gr = mcp->mc_gpregs.gp_x;
+
+    mcp->mc_gpregs.gp_spsr = pstate_read(regs);
+    if (flags & TARGET_MC_GET_CLEAR_RET) {
+        gr[0] = 0UL;
+        mcp->mc_gpregs.gp_spsr &= ~CPSR_C;
+    } else {
+        gr[0] = tswap64(regs->xregs[0]);
+    }
+
+    for (i = 1; i < 30; i++) {
+        gr[i] = tswap64(regs->xregs[i]);
+    }
+
+    mcp->mc_gpregs.gp_sp = tswap64(regs->xregs[TARGET_REG_SP]);
+    mcp->mc_gpregs.gp_lr = tswap64(regs->xregs[TARGET_REG_LR]);
+    mcp->mc_gpregs.gp_elr = tswap64(regs->pc);
+
+    /* XXX FP? */
+
+    return err;
+}
-- 
2.34.1


