Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B31C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZK-0006kd-3G; Mon, 17 Jun 2024 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ0-0004uJ-BQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYy-00050g-3Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so4189589b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650722; x=1719255522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYrmA0vk2Zd3/clu1etzd70moyuztxZzOi8TsOsOvYU=;
 b=lrU7Hiph/155Gua7+3tiEt/GajwCI8xVvGvA5SFhhBHMdKFrGxRVt9Hw7E9Xd1uekC
 +wk0DBu0434YzJ0rXgyWdP8iNmAN3BsgainXiH6fw/ISuiWoSepDdy6zRnZabLisBsDv
 Oc97bOl+wzfsHoum31KsdpRl9+IK2Gx86B0WgppNfWhLw6g4HALORamtDkxK3orQ3FpN
 q+MV5I7RyAujt8qXjhGk9/pY4e1Vj1CIQ2fcgYsETYifvjM+1zBtS3PiA7BRVUDxKcQl
 O+y78dUxj8vW+g9vw/tWoIwduAAuSOqYHBE+P3cWcYS13DC1YiIO7m6nEuw+mu0OpUpe
 4wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650722; x=1719255522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYrmA0vk2Zd3/clu1etzd70moyuztxZzOi8TsOsOvYU=;
 b=ML2ZrbiAFQNIcAAar5eJhjd/LR0tdK2UsgVrxQ8AboqP2HEUDidvXtjOgTWX+beX0z
 q6ip77x7l4PT87xaUi6QiDxZSxe2t+F9bmhvb8KSR/TXoN7Lzbgng9iEChEjhSBi2mCN
 XxHPC9PQGo9IyWWDI43ImLm+RxNFb5o3adEg21o4sHzNRt9Owny8xQfDnaO9/YSSK09A
 1VUJm0f5DQhi6C+NB5GJXftDeO+jfP2vOnelVmL8OuRCxUfovvBT9EsVmYrHDd1dff7A
 DBMAxDXwd6kg8eWZP42i3+Ryliflbs7Cl+QnYFZDIbu1rj7UDEv/qMNa9sv2Lm4ICFE6
 1t9w==
X-Gm-Message-State: AOJu0YzUp+8Gfe8wSwH0SyN4IzfizYIM+5z7Jg7ezflSJ3IskVc/kc8o
 D2QMLwcrthd4/nSXnNyFESMJjBCEdM4rGug6ITe29kg6DSA9AlilE6RWcn4UjkQ=
X-Google-Smtp-Source: AGHT+IE3+z5PYLzh3MyGQGqM79KRSmOhWdAle+kbNEKnvUZlFLZtUszy56tS/DkoRgoAJ3+chVQvaA==
X-Received: by 2002:a05:6a20:7489:b0:1b8:622a:cf8f with SMTP id
 adf61e73a8af0-1bae82c1a36mr11850309637.57.1718650722335; 
 Mon, 17 Jun 2024 11:58:42 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:42 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 10/23] Add thread initialization for BSD-USER
Date: Tue, 18 Jun 2024 00:27:51 +0530
Message-Id: <20240617185804.25075-11-itachis@FreeBSD.org>
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

From: Stacey Son <sson@FreeBSD.org>

Initializes thread's register state

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 bsd-user/aarch64/target_arch_thread.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
index d2f2dea7ce..bfc9050cb1 100644
--- a/bsd-user/aarch64/target_arch_thread.h
+++ b/bsd-user/aarch64/target_arch_thread.h
@@ -42,4 +42,20 @@ static inline void target_thread_set_upcall(CPUARMState *regs, abi_ulong entry,
     pstate_write(regs, PSTATE_MODE_EL0t);
 }
 
+static inline void target_thread_init(struct target_pt_regs *regs,
+        struct image_info *infop)
+{
+    abi_long stack = infop->start_stack;
+
+    /*
+     * Make sure the stack is properly aligned.
+     * arm64/include/param.h (STACKLIGN() macro)
+     */
+
+    memset(regs, 0, sizeof(*regs));
+    regs->regs[0] = infop->start_stack;
+    regs->pc = infop->entry;
+    regs->sp = stack & ~(16 - 1);
+}
+
 #endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


