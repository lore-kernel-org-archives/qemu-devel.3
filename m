Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2187EC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZP-0007MA-Bc; Mon, 17 Jun 2024 14:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZN-00076O-Io
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZL-00053B-Vn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so3601428b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650746; x=1719255546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0dzrd+ciGxDD70aSvLklNlGUxbQ7sp9bKeESCi0z6s=;
 b=ZgLXrQHe+kBKAnv0yVYDf8+3M4VcxEakv+QB0BXfBXK9n0E0+eaz4LFP03lFqx69q2
 BdGBRlQQkUzeKE1YIsHQAtbGANgoiMH2/uoOSwY/lzjTj9y9H9DP6OOQFgoQmc275CzZ
 ohI2CDnHDrYEMrKNLLAUmBTaeP4Fky45a5m9ro9+6r5kY6SbJrYg/Imai2X1LPmnZXmD
 Nn+WLz/tqMzDxj/LdUE8ACyZuQNeSLgj5BjDmz009JKB9ZmbTpfvKVjPI4Ui2PG6deH/
 LAVxKGPXg0KdrPPmV/U2OG0KL7ueszxYimffZBI5ugpl8popAMtrd11ZEPK7s/kLUsKg
 ol5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650746; x=1719255546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0dzrd+ciGxDD70aSvLklNlGUxbQ7sp9bKeESCi0z6s=;
 b=eA6l3suF6gv4Na3CNjbaUzBHi5yMIRWBJsA+PiHW+X2QKQdwZibRxd4LRzULqU0D+/
 9TrILj3ShckbQ4qzgrfgIWGnPsEZ0cHnegt7MRYmPIN13pIJs2KGC3d2xrXED9VEtCa6
 8t1NuLGN0HepOsP23hv+AABDmdGpaKbWgNdISsHubPEI4EhTGGFxryYmHkVM3l0NG90x
 J3AbifoLH50Os4pIJNtgyA9JwRJZ2uAd70YjybY9dqhStlmgIyfQrgcbLKtrpwUPzM0E
 odvZzjyAuaDDxvZyzcmU81rig2nF3Sm1fLu9K0MptFWeD+KxvxYtQCr8KFZE9AT4n7DV
 vc0g==
X-Gm-Message-State: AOJu0YxBqpO5ZNMreRoqxNRoUanvMqJ3oMVUBpHFcydKn3+828nOaAHs
 Df6Xxf1iR6UJ+wsJJQzhl21QIbHcjvgbd8uljesJdH8V6YeNVUirs+VrpifmGyc=
X-Google-Smtp-Source: AGHT+IHbZvh05bXQRENKWWwIc+1eTP/T+hYJlk6yj29WGdDosCvzL6U+y0BZ64OOeQz0Eh9BLag8oQ==
X-Received: by 2002:a05:6a20:4327:b0:1b7:406c:1081 with SMTP id
 adf61e73a8af0-1bae7e293e1mr10756463637.7.1718650746452; 
 Mon, 17 Jun 2024 11:59:06 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:59:06 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 22/23] Add set_mcontext function for ARM AArch64 in bsd-user
Date: Tue, 18 Jun 2024 00:28:03 +0530
Message-Id: <20240617185804.25075-23-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x433.google.com
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

The function copies register values from the provided target_mcontext_t
structure to the CPUARMState registers

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


