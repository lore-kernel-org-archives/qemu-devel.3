Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C476C3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIh-0000oB-Kz; Sun, 07 Jul 2024 15:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIg-0000o2-LO
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIf-00059z-73
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:54 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d92bbadfd6so461083b6e.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379512; x=1720984312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5fjvNTx+vSPFZHp2emZLnu0OQ08Pqx5zQgJemqgRQ0=;
 b=F1uLfl/SSpcI8IonT5DHLDho7DF9AUzy9NPsDkbwYDEQZGpfC0V36N39cDbBs8+n5l
 SC08vSt1b/xKgvxuhcHWZi/vKwRkiqS166+Cgf3w6ySkB9sc3a4meTW/JdYLDN/LfJvm
 FbelrbwzuO9xs1XXnDKhDgCTnpmS9Y9BJ+2XXvAme2NL+L9V8u16lvh2pzpmuCRW5koB
 P3291G5bjGdFxa0oEM33/NUCpnxxuTk2Lw5kCkTrpLEjd9BL0+wLbZKyW4hxDIA5Qici
 Geh8Wh8TzRBynwKR8TFme/BDMFkco9hbMGIIo9o8EKt60CeU2IWxqJlmhwpFiZTM/kB8
 kijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379512; x=1720984312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5fjvNTx+vSPFZHp2emZLnu0OQ08Pqx5zQgJemqgRQ0=;
 b=adSPosAld9S+trO6RCLimZ1jqI8svINnersGV0otz+q+tTO7GdwZn4IWGqkdyzU0fk
 2cZtA7qt6czF9MH1cAuOArhgvnygrHwmEtQ+DdVgiacKujzq1J+ua02NJeBCykZYWmTx
 9NRpzZYmbkC/MctXi/qCOhsVKQ/Dz/LzEXJnyltVh8c3/mW3uvu8ma87pBvkxUe9sPSt
 Q9a7PVzkPQ98WOGVY95YAgFaFUOjrMvFSlPLRbs/eShcFgZMLObOo/fE4SLujwfHPwO6
 ZUAmvxU00wDWnn2uSw+vHpBBPjCWP565nnYucsFVAk6DsoXy6gGzYvk8Wk4DAgsLzng6
 SbAA==
X-Gm-Message-State: AOJu0Yyroa7UwBU+PtoZ3m1ShA+DeUZ1Ph1vhsrV0UvH84Su2OorLlMR
 3AN3i+LuZEMOyhoTqukw39oa/ym4xWR6QjAHntJe6giNVLdmhLd/P5D41O36
X-Google-Smtp-Source: AGHT+IEXSu2N8jPpnw7zLKIx57cf0AKYgpXqa7y3MKyXHXh5o3Kh+W3KlgofBf/eahjKbvDm5mBGHg==
X-Received: by 2002:a05:6808:1705:b0:3d6:2fc8:2553 with SMTP id
 5614622812f47-3d914eabe84mr11526335b6e.52.1720379511656; 
 Sun, 07 Jul 2024 12:11:51 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:51 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v2 7/8] bsd-user:Add set_mcontext function for ARM AArch64
Date: Mon,  8 Jul 2024 00:41:27 +0530
Message-Id: <20240707191128.10509-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=itachis6234@gmail.com; helo=mail-oi1-x233.google.com
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

The function copies register values from the provided target_mcontext_t
structure to the CPUARMState registers.
Note:FP is unfinished upstream but will be a separate commit coming soon.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 43c886e603..13faac8ce6 100644
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
2.34.1


