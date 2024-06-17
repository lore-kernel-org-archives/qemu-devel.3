Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B29C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZL-0006sS-IS; Mon, 17 Jun 2024 14:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZJ-0006lx-UP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:05 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZI-00052f-9b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:05 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b9778bb7c8so2381222eaf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650742; x=1719255542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1ZNdfkD296PLmViWh+uFcrYLRqsmpQNhISj3YpSETo=;
 b=FlxBEp5uYZi5wTWtUXvmY6o7v4IyY0MIsmnr4UtH5P5z/ZPRQCkEL+CzUODrE0je5W
 4COD7VX955a/c6NCqoiIkLXWXWkFeLTsFXpfVguW4Kj18RIDwZEgi7SxcBB4uy2+ZAgc
 7BNnWIkO9cs4p7zRUYp7AkPoJvrSDL8OAXB14qqIl00Xob6jW1AmhYah0ghEDp5q5h0i
 KEmFflVD6QlAjDWAQXEGqRZxP6OBKyHkZecnq16PzahMg8EGeInUn2X5CLEnvF2bBqQQ
 4nAZu3oFKyR+SpP5agNLvPKVnPwd6zWUNBCuzlicy1hEjx2G+R3xK0Ck44sENv1xTz4X
 R9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650742; x=1719255542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1ZNdfkD296PLmViWh+uFcrYLRqsmpQNhISj3YpSETo=;
 b=SH9DsDUviFJya/tlOrZ7/x2h/0Ns/dBigLotxHVEjA7rBNMD2zOpH1yt0lDodK3bde
 VMpoDT8v3AK1aKXjSjs+oGaJ3UHVKYZlFMaRrR2nYZ0X4vchPwaMwJzLdXP6Qe2a8olK
 ov3GtnoChaELLHRri1lNz1rdQw2b8qNO5Gbbwu08+SrR1G0zBSCFUIN4LGbH1/LRcdeh
 P54qdH61Y8yZ4b3hBlXM+3WlxQgMvSN6WKtZ56beE1yQI+eiZ86SZwkVjC/Y64ct04Vk
 TbU4OJ5HY9D8I+recGfGT8yO8mP2GaqyGFjSm67gpQL/58ugutTWjTPrZ21chgEPAo2K
 lGEg==
X-Gm-Message-State: AOJu0YxIIIjN96hkkub3ZJ5zk2VelTP4StGNwMVfI2NTdMX9yS0H/8RN
 mYC4Jh7dxffSUVoZ8LJ6J0OEH8B57wpLWAKR3JgDxmREdM9ySH7bBU+wzE3fEhA=
X-Google-Smtp-Source: AGHT+IFxH+j1o7/vxpe2HMoUYXx9INhS7yfHpU4MAT7kZbvuEvwWRDfq6OJzEFdH1ZkcPyT8erK01A==
X-Received: by 2002:a05:6871:58d:b0:254:b74e:d654 with SMTP id
 586e51a60fabf-2584290fc96mr11589378fac.22.1718650742565; 
 Mon, 17 Jun 2024 11:59:02 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:59:02 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH 20/23] Add get_mcontext function for ARM AArch64 in bsd-user
Date: Tue, 18 Jun 2024 00:28:01 +0530
Message-Id: <20240617185804.25075-21-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc32.google.com
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

From: Stacey Son <sson@FreeBSD.org>

function to retrieve machine context,it populates the provided
target_mcontext_t structure with information from the CPUARMState
registers

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


