Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ADFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qY-0007H7-Sa; Mon, 22 Jul 2024 17:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0py-00052n-1t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:55 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0pt-0004JY-Lb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:53 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-808a8c90f5bso187017239f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684688; x=1722289488;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=KiujD1ooZD027gZetN1OzZnkXhKtxtr5sUZZDYK+tq3F/J5lTvzwMbBs9rd7+XMcBY
 ZY/xDJS6hsA3XHC4NXZL4Ul8y8L8azF6LwnVRWn/I40AqZ/wiw0IyCarfDP1rXu4dH34
 y7uNOOtKFMAAe5/jWzGJ0bIrLAZOi4zKPkEk4EfCr+vQZwGukXbh8hUu/JiiaqjSLzfE
 0HdrkXpIqcnuA6Vc7AvPmu0W03EUObygsjlvOkTyczzIwGsOjwHroJCQnrSznM3v4IJQ
 rENiJkii5jBMqQFSMTVdHKOPtnmgBu4pKEOM/Hwhx+aqDZdWIB6fEi9uOke/7fUaFjQB
 C+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684688; x=1722289488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=FY1xR2OYjgC92dwNxRaTTQW1KbQeuOc324A9XL+DozaoS9ceNeQ3EHu1/hqbRW4zMc
 QavVAx2shV+ypaetJbJcr5hcxt+ije+pIeooQpp/5OWkWV8dhcsWiXoMapyD/eiYbKna
 s+wOlrJ9LS4qfncePsa2IEXKNHtr0a4RbEqxMIs9/HO7dJ27mDYXyiNJCjDU+vIU1vjW
 wy6g5kz7AJxn7LHj0inw/sEkNRC4VxijOLIdez0wyLlYWsMoxYYK7YG2QzCAO0CPuOEI
 ar9b0X3zb903W+X6knRA4B2bttCvyyi9Vmbu0IzO6dtqzdD24pgcRKnsAxyZnMT8P6X0
 AoRA==
X-Gm-Message-State: AOJu0Yy7lo0yQzCvGmiFEaGZvqhsDPrRtlxA/0qiqL+g9HAjpJFxAVqC
 PKbvLwI8Eg3m3XVpclTMjAlX4V1BInL5prJmJaJ3x5v+ZL9/w4aIHUhrjqSDUCXw/SrvhYr/sv4
 kdIs=
X-Google-Smtp-Source: AGHT+IGcRMGjtNEgsWxBLsdkW6NYzKwCKPI1HCCAaJovVoKMfl9zfqSbr7hJY0JUJqfBcPiHwl3XBw==
X-Received: by 2002:a05:6602:2d93:b0:803:85ba:3cf9 with SMTP id
 ca18e2360f4ac-81b33a0ca27mr1026733139f.10.1721684688327; 
 Mon, 22 Jul 2024 14:44:48 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/14] bsd-user:Add get_mcontext function for ARM AArch64
Date: Mon, 22 Jul 2024 15:43:04 -0600
Message-ID: <20240722214313.89503-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-6-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 98861f9ab3b..ab3bf8558ab 100644
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
2.45.1


