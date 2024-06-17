Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B19C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYm-00049T-NW; Mon, 17 Jun 2024 14:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYk-00044p-Jy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYj-0004wY-3A
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-705c739b878so3731708b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650707; x=1719255507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmiGU0XGOgkNkeKrlW4wG8IDU2PioKKg7Y5d+i/ULYE=;
 b=jTxHPqyQQkEFVako2s8NLJbsDmO0eX6kJgKcKVJ7WR40DguifIJ1aFPQ0Fbqh514Xz
 Q1exrHYZWb0ZOgs8XGFRG5dpz4bWXpiVfvh7RH81A6SwpV1x4LzMLL/17TApRq6zXKzz
 9sEAKNbRrNjXmVhIn1D2A3MUksmqTd5Nh7ndzUu9VwMw/K8gVWj47yqKd/KjNy+bbJoJ
 g2STylLymFR9iddLtB50jEIKWXqIz+Y4YeE01m/0FN+welvkG+2cmiYo33kIiAhyWpZH
 AXJCiXBLvdCpeaD//4Qxw4frODyVwAu9bQ/YsjkRnbNyZ2tue7Y8Boj2J7VQHh5nTKEf
 7gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650707; x=1719255507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmiGU0XGOgkNkeKrlW4wG8IDU2PioKKg7Y5d+i/ULYE=;
 b=nA/572UE2sFb5lkdZxqFV1TVYtcVW9G+7nV/FrLiGN1Qo/MTvoOBUXqXKwJAHZVc9K
 XPcTwGMrHULte/i4Y9wwga5nF+7ignJ7ToOw9rA2HVh7LxFU7TiIjs+bhp2J4MZOHOsG
 Pvi+FA8Ddod/EI985/vg4Ki1Ttwv5cK/grZ+Fb+9rZDWdQNgW4R3EHCo0rcW+nRBqrPg
 nk7i1cFWiLV+ZhsSQXUWYHdGnncs2V63x1AYmezPB5bU+y8MMpSZ4DMd8y+u4SZq+Ixh
 poG/UMMee8HaVptrz63AGA3Owv0q98iMKZAM/ddzrfNJoHi/XGMYUp9VABQVjZ7EPR0f
 OHCw==
X-Gm-Message-State: AOJu0YxKKhmiHbdJSancrzoU9Insv027DNYbWub64JWWr1v4nCwPKBFK
 D5y0l2e+7lE3FpTeWCMGOL7lW1AWqH2bWsOyRLmYc73WFGTNv+qqAlnsFfqbU1I=
X-Google-Smtp-Source: AGHT+IFK2TgqUuHnvf3PHdJbDqbq54NEpzQq5HOcHRcDHcrV1+l1KI4ggxTOxN8svyLso7qjSTt+9A==
X-Received: by 2002:a05:6a20:a924:b0:1ba:ee32:e7f0 with SMTP id
 adf61e73a8af0-1bcaafaf6dfmr694283637.4.1718650707243; 
 Mon, 17 Jun 2024 11:58:27 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:26 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 03/23] Added function to clone CPU state
Date: Tue, 18 Jun 2024 00:27:44 +0530
Message-Id: <20240617185804.25075-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x434.google.com
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

Function can copy cpu state to create new thread

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 1962d2c99b..4e950305d3 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -171,4 +171,21 @@ static inline void target_cpu_loop(CPUARMState *env)
     } /* for (;;) */
 }
 
+
+/* See arm64/arm64/vm_machdep.c cpu_fork() */
+static inline void target_cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->xregs[31] = newsp;
+    }
+    env->regs[0] = 0;
+    env->regs[1] = 0;
+    pstate_write(env, 0);
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


