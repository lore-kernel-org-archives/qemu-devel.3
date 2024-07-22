Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C182C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qN-0006UV-Mg; Mon, 22 Jul 2024 17:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0pz-00054K-VU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:56 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0px-0004KR-Q3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:55 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-396db51d140so20196025ab.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684690; x=1722289490;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=Q7p7BXAe99KQR4PifoFNy572eoP/uNChEYLfdhfjT9M8iPyW08+kt/i5jZOJLAKVsk
 p1aAuQP9bQB6ZGWqU27oUySryDP9tzU3gXtYCU031kBzqeHfc0NVaN2MIuj4AnAtZqQh
 IaWqs5LG9FiPX1aQbumFIjN0ZbCpZ+3YtQe0oKk7sExyPT/arnBD7Qoy3BXgUuIanwq9
 9NIlpKKclnlio3oqKy6v6pEAyo+bsTK9VbsPhJi0v+PayMHVY2/A7eoKGLoyObxp2arM
 Fj4c6iBByDqGvzz5CJ6QnlfwanDZyDt/icF/fD1EBq1ezO/tnaG2muIu4Y4gCl8Q/b+3
 Uabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684690; x=1722289490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htzmk2/K+pRyHcINVlqMN9Cf2KcnbziuOXxz3Bx5eFI=;
 b=g4Q+HB7UD3+hIyKykDTvgN/JBg/qD1x6YdZ5Y/FoCtZEH/ab1fp8VL0LlOyeXvQqJm
 FHR+FVe4YvgK92guuMQrkDCqjRNQlCIS7VGQ94e2Xgc3IGemv9rC3zksWHvwH4dPA3pZ
 wb0/lqiubQEAGjwHCN8RhLG+Nks+y7A0zp7KKGyxknxmrruiRjRMrpAQRwB0HfKjjNjz
 aIvI6o9AvXWPTAiXtlaaxX1/mqwoEio49/1n7GA4prYXV8eztxeMvh0yqeTorpdnifml
 t17FF/jd3AO8A8VXetLwvsomFWkzLfuWMg+f8g82GP5+/RMl9t8fJMJB+1/XCG892ine
 sVRQ==
X-Gm-Message-State: AOJu0YzC/8ktLB387cDJ0uWajIDQJrCoZTzItDLRkhQgj0y3+vd2dYG/
 GjOLzqczBcStTcPfItLLf80liV4li3cIPpw4THI6GQ4KrJBd9+92se3M8DnPzbEWkC7f3YNT2th
 q3aI=
X-Google-Smtp-Source: AGHT+IExN1016SDsl3c0PDoDU6AihToztpkSgd5my0DyuLi0BgU3j+f5i53o6mDuTu8nD7qVKnOxCw==
X-Received: by 2002:a05:6e02:1a8c:b0:383:6af0:eb08 with SMTP id
 e9e14a558f8ab-398e420f849mr117635995ab.1.1721684690581; 
 Mon, 22 Jul 2024 14:44:50 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/14] bsd-user:Add set_mcontext function for ARM AArch64
Date: Mon, 22 Jul 2024 15:43:06 -0600
Message-ID: <20240722214313.89503-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x135.google.com
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


