Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC440C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk87-0000zO-1U; Wed, 24 Jul 2024 18:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7x-0000NB-6t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:29 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7u-0006Ze-KR
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:28 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-816d9285ebdso12579139f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858785; x=1722463585;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=sVSj2NKdXv9oNWuA0h79Odtj8V87Q2dLB/bFiqUS8o+emkCcC5eagtbBmDS7k8lCMi
 gdI9DmyFZdvB9Jcnp/j4RwAJPfNhjYAM61GpQoMUu/MD39Rzdqm1HMU19VHGHswNtz+4
 llLCP+8ItHnONs4u3WJfH4fVc+pQ79Zlsfco+ViRhCWcB+jqEmyREd5gsV6ZO0+h38q5
 bYUx4qPlOf9Dw1zABj88lTEjEuQ0eZduOs08vY6LX6BtLCVhoOhyNT3KOyFtM/OYgKn/
 kEcmmqanFwDc+epKSJdUY7mws5xNDKYdEw9OEnAIR6rwaCQV+JBkqX3rXRgM+MIWw9OM
 +XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858785; x=1722463585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=Gq9El+s01N9JccrQmm6sElvqUwj3FgBou+fmJjfMVBg+AwZOoWKtSB944QBSb/j/wa
 PJ/YpEE0tA/M/juOzE2sUXoWOSBOXdib2ubttGdLlAsvUlqctzZu8w4vEi5JmefNTKYH
 D9sFeXRkbZhT97BolBeuK7QyiEzZMUX9JG1g/GrY3rp9t+UNMVDXNVY78+KQjE+yzPOK
 1K5O5+gu/Uwx//vXBp+G3kTteiGxWhqIkUIEQH/sZKJRCjJ43dAPCc/djL/D3kD9RQIc
 TAHiJegHhPbUUV3LoHDFSM+cNXsfQSYyQf6IV7td4aKlCiOS2qHLZqbmjJy4gNuWNLtP
 C9QA==
X-Gm-Message-State: AOJu0YyIB6IHc+eNcb/p52AlgmK4jvYiV2/meD0lILY7RochL80AEDf5
 5coixmJO6IN2e2tXjyXkJlbIPwYk1g0csYf1YGqthk4IM7pe562A48Tmq5KhrY1WpLdGyb4JKEw
 B1Hk=
X-Google-Smtp-Source: AGHT+IGXVLCUuNyKTl378VH+uSkWXoBANbwc+cOrruaKelNedYmIRYtOKzn5HOz4jTzWXQDfOAZcNA==
X-Received: by 2002:a05:6602:2c12:b0:806:2e60:d169 with SMTP id
 ca18e2360f4ac-81f7be798d1mr170640639f.17.1721858784861; 
 Wed, 24 Jul 2024 15:06:24 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/15] bsd-user:Add set_mcontext function for ARM AArch64
Date: Wed, 24 Jul 2024 16:04:40 -0600
Message-ID: <20240724220449.10398-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
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

The function copies register values from the provided target_mcontext_t
structure to the CPUARMState registers.
Note:FP is unfinished upstream but will be a separate commit coming soon.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-8-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 43c886e6036..13faac8ce60 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -95,3 +95,25 @@ abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
     return 0;
 }
 
+/*
+ * Compare to set_mcontext() in arm64/arm64/machdep.c
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
+{
+    int err = 0, i;
+    const uint64_t *gr = mcp->mc_gpregs.gp_x;
+
+    for (i = 0; i < 30; i++) {
+        regs->xregs[i] = tswap64(gr[i]);
+    }
+
+    regs->xregs[TARGET_REG_SP] = tswap64(mcp->mc_gpregs.gp_sp);
+    regs->xregs[TARGET_REG_LR] = tswap64(mcp->mc_gpregs.gp_lr);
+    regs->pc = mcp->mc_gpregs.gp_elr;
+    pstate_write(regs, mcp->mc_gpregs.gp_spsr);
+
+    /* XXX FP? */
+
+    return err;
+}
-- 
2.45.1


