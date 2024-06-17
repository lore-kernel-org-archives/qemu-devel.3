Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1198EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZ1-0004hm-U4; Mon, 17 Jun 2024 14:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYr-0004P2-8k
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYp-0004y8-DW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-705b9a89e08so4054919b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650714; x=1719255514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzc68h1Ua4UnQlWlrtm3BT2YNpP7DWO6KFC5L451s7M=;
 b=PnZiXsaa/+IHj+XfhJRuqgmIec7M7y2ZdLeITcRM2gmHvfHY/Dx6Bp6Wxjl+IKVaR6
 EQTPNA/l18p+eUNItLDXlAOFNjHB7PN00KfwBZapQo0jyl1wW4wbJE66B7riGUaKR6cG
 lF2+duerN6/3QJt8uo2S/15qriOhd+SPXb+8XO/GYOGvRc+Fkd2Mio9Is+/Zm8M6MOz1
 z6M0M4x3qDzhsVWujxkPxc8YseG83X9CcnTbUth74P/tI69WrtIQO3SmTKq9FvTb3Rzd
 0dDioxVH9/WbbgA4Q89KkNT5S151Aep5rfvNs2kWaoYRbCdn/cUieX3xF8lozaF8+Ql2
 YcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650714; x=1719255514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzc68h1Ua4UnQlWlrtm3BT2YNpP7DWO6KFC5L451s7M=;
 b=u2NGdPSYfJqRQwh8HlZaAMxKnGgCeVTlbWLU4OimrgBCKRbDYr4ZYvhKoxEGl4fXwD
 oGZsK2Dt4i/9TCufJ6M/r4AzqBVHuHR25b5AMwfwSNx9Uk5HhdTPcJ8BGhBlqj/MDQY4
 5jhz1VLZl+yDXpBKysrN9kDKiW9zPVgf4b/cKYwy+SnrLk+Qwqm2tqIBRIdY0SjFkNky
 BvC+NkSjWXYiyOdQpPo9/VFvX8Nfz0gD98hy/h07KaxtaNJiUzXBP1lWyK9lSZ5u4I5U
 06/UhT7yaxAB/TNWuV5YxXQ6YcEkTolnj2CT92QiJ4b5qPGbXQ/f13URzEm0nXkYgJjX
 iqCw==
X-Gm-Message-State: AOJu0YyMJX4K1DObhk2Sql8YZkq8xLypwx6CyEWg+WZ0YSCiLgwD8UVj
 lBGgK3MGoB15GSXOvCrfI+qoC2WWA7aH5laM2JGY4QrMnR5tZN26sD+KtNJfcSc=
X-Google-Smtp-Source: AGHT+IEm89zSSI9qpDrXwyBv1Iz+uCiI0Hu/9U2j9Lihg9g4w0hn8lPi/9e5C8qTwtApRtsaWODDeQ==
X-Received: by 2002:a05:6a00:38cc:b0:705:f5c0:8ba2 with SMTP id
 d2e1a72fcca58-705f5c08bf9mr5667571b3a.2.1718650713675; 
 Mon, 17 Jun 2024 11:58:33 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:33 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 06/23] Add Aarch64 register handling
Date: Tue, 18 Jun 2024 00:27:47 +0530
Message-Id: <20240617185804.25075-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42c.google.com
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

Header file for managing CPU register states in
FreeBSD user mode

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_reg.h | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_reg.h

diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
new file mode 100644
index 0000000000..5c7154f0c1
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_reg.h
@@ -0,0 +1,56 @@
+/*
+ *  FreeBSD arm64 register structures
+ *
+ *  Copyright (c) 2015 Stacey Son
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_REG_H
+#define TARGET_ARCH_REG_H
+
+/* See sys/arm64/include/reg.h */
+typedef struct target_reg {
+    uint64_t        x[30];
+    uint64_t        lr;
+    uint64_t        sp;
+    uint64_t        elr;
+    uint64_t        spsr;
+} target_reg_t;
+
+typedef struct target_fpreg {
+    __uint128_t     fp_q[32];
+    uint32_t        fp_sr;
+    uint32_t        fp_cr;
+} target_fpreg_t;
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+static inline void target_copy_regs(target_reg_t *regs, CPUARMState *env)
+{
+    int i;
+
+    for (i = 0; i < 30; i++) {
+        regs->x[i] = tswapreg(env->xregs[i]);
+    }
+    regs->lr = tswapreg(env->xregs[30]);
+    regs->sp = tswapreg(env->xregs[31]);
+    regs->elr = tswapreg(env->pc);
+    regs->spsr = tswapreg(pstate_read(env));
+}
+
+#undef tswapreg
+
+#endif /* TARGET_ARCH_REG_H */
-- 
2.34.1


