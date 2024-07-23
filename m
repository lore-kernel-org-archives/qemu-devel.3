Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C61C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxZ-00036C-Eb; Tue, 23 Jul 2024 14:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwv-0001Ho-FI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:25 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwp-0001Cs-NC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so23538045ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758144; x=1722362944;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=o2U4dMg1+GveMy9MhEdt78KLhkPo/a4tguwZT2ZH2yF1mJnpiIvCoo8M676Ws0PEGe
 qfWkm00XjyNOoVnSL25XjqpLNvwz4V7VZzL4ME7zOBq+9pKCfysrhVPAmz+2GtZjAD7F
 OYH9xjp5mPNYpDosRVDiPMTe+q+a1v3YGMIV8WDsVmlx+3854ATi4liS7U5PT8tUvEOp
 I5SbUVJ+YDX9tSAROPe0xpy5zHfzy/SKxUohOeu/WjRGJE9aDCk+ArPMetrR9zuGUGPd
 kUG2uLY5tYdvMEK0pHXBUQ0wrpecrdjTbWenLbK++6Uy8k3W/PW5ZQ5q2O5w3xAqdPzb
 zVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758144; x=1722362944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=uf8wqLEIJIZJIaEwNykM1KzAGS0yKwCQ8RhQ+gIiLf/bZyS+0fq3tMJU7UMRwLL7PO
 fZUGLLCkZ6rszlPRccZXQq3xofU3NshTv83tGOX0w4P6kLsgVAWbIbiMnRw7paiRknjt
 HUp4tDc3ZMJ30WwXeAmsZkpwwF0OyiNLcCt/yUFZUvXkzLDn/QSXDamt2nQHbwS0rHyS
 +w520mYW6kGQhfwfKYO0LOkSPUmviTcPA0I6iuNOxfkoKNRdl7sWZ6U5N5GthRVKSK/W
 T4Db93KaGqGVVvgEIXONzm1PIpEiOh/lQS1EICPsUya8Fm5KdWkURnVS5XHo3o0qlQIc
 oBHA==
X-Gm-Message-State: AOJu0YytgXDnsZa+3EBFK2e8AX4FAawqM3S1AQVe3CsG/Zixc3pJ3hJx
 u29s2UJuPWQk4jImD2M+u8jpO59C2ZWuYp/3Ifj4io4jFkn9R/TWmQGqmp04YiI97RCzs9K3zBC
 A0Kc=
X-Google-Smtp-Source: AGHT+IE5XUB9i4eIXYNDVS0qvWcmdwoDTpT6VVhIWa81qGwd8+A+8hnysZMLVGGzR40Ontl/qzc/bw==
X-Received: by 2002:a92:c56c:0:b0:39a:16c0:4bef with SMTP id
 e9e14a558f8ab-39a16c04e68mr9278115ab.23.1721758144376; 
 Tue, 23 Jul 2024 11:09:04 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/14] bsd-user:Add set_mcontext function for ARM AArch64
Date: Tue, 23 Jul 2024 12:07:18 -0600
Message-ID: <20240723180725.99114-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
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


