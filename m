Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB119C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZN-000754-DM; Mon, 17 Jun 2024 14:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZL-0006se-IS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZK-00052t-0C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso3154840b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650744; x=1719255544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RS52m5Rtxu4YyXgEJCG8PR37BWo6RzXvr9iG3e006XM=;
 b=R+LxjGRJO+FCfK44DNy8MDOvef7BoG9TPopd4fZzDzdYNKWtmxK8yVsF5OiwvaLwCX
 hMsYhQadgsfRtwsGXyzloHT1G3B8jJsaeg4JEetTEeof3bXtmMkbnSUib9jje7caG72h
 2ZwZuEERHK6+38SoZeT08IhA/NARYtRNpNba/lDxWv7HA28lOqUMngtWvQjpbR06ytnj
 VsrVidBtF83VkxLV93ZC40y9fvBcHjegkcCFRhVT8XwtxgwzCiKn9hJfqoJdGGfSzwzZ
 Du4T3CXi0mNQkPdDPslMMOOJz3ATiQcPwA/rSgs6VJScADKA+C0p8T6JcRrCyX9yr3TF
 zSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650744; x=1719255544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RS52m5Rtxu4YyXgEJCG8PR37BWo6RzXvr9iG3e006XM=;
 b=qeTg3Tth8T8+7MIlrtjFAMjEcCA5DPcDzlaXGwTzlHd4jRcvtcGq8wgAhJEY+hEgg0
 pzArk7TiaYle8bBHNLh17gOMyeNZFj5oSFMdU7CfF5yvZ3Ooyexhi8tDnRMcZaDAqney
 lYhi10IiDeEErsFgTIsN0ueCpS5P0dKX9K9/rNHtEC733vhDqF/Q25TyCbqGSwb1Ub0n
 Pc1O1JkJIenRnH/WjYl8anIETL55gKmc6pqAUWI3exmgsCa16/C6ncMaucjhuxpTZ/A2
 X7+J+eIoLsTdRpSq1KD6vamtoSzoEFGMiv0XCiY1GxfEX1Ni1RcoE+RCW2UKc1yZVfJs
 8yGQ==
X-Gm-Message-State: AOJu0YzC9JINBb3E53nSUljnNihjnZrtlI2ECCSI2SlvDyTbADfEwT/J
 OrHgv3b6qAl9RhHJ+miy1rHLFsKUi5c3SQy0MY9As1vATdM/usVwSuGSat9svho=
X-Google-Smtp-Source: AGHT+IFxIq0b/W3Kcd5CLPPgBeZea3DOF76vTJei6zxr/pk+elRk8k5TyyDtiiYYjMhkPj4K9/EmeA==
X-Received: by 2002:a05:6a21:4603:b0:1b5:d172:91e8 with SMTP id
 adf61e73a8af0-1bae800c427mr10780039637.49.1718650744396; 
 Mon, 17 Jun 2024 11:59:04 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:59:04 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 21/23] Add setup_sigframe_arch function for ARM AArch64 in
 bsd-user
Date: Tue, 18 Jun 2024 00:28:02 +0530
Message-Id: <20240617185804.25075-22-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Warner Losh <imp@bsdimp.com>

The function utilizes the `get_mcontext` function to retrieve the machine
context for the current CPUARMState

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/signal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index ab3bf8558a..43c886e603 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -81,3 +81,17 @@ abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
 
     return err;
 }
+
+/*
+ * Compare to arm64/arm64/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
+
-- 
2.34.1


