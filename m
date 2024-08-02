Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C1BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnko-0000un-0Y; Fri, 02 Aug 2024 04:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkl-0000jU-Dz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:11 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkj-0006h3-0A
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d199fb3dfso6653947b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587707; x=1723192507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn2m1zPQU5uZwrc+vr+y8yHWMvWTtYhQaIESa/eMd7c=;
 b=V61L/z1l+62i/6Jr+uTgo+9f4dkLkqk+ozHH6qkCR4IJxaYYbijveYE8RwOoPEPrg0
 Szq51IYUhJCQvZtssITowOHNEY0hhFp38UZeRe7ClmvLQ4NbC9XRx6qnsnji59bv6R3E
 CP2a+GnGh+tw3poL/+G0/tKtJplWHVuPtN/nMrF7IVVFdrTjW919/6bWjdF6vITgN0/d
 322x33ld+Yq2L677T4r07f2PPvPBEdvzoPcJIs6uQanQKDqWK/vZlPNsQCypYnHKTBz+
 fCM+NIaIyk1YkkVXU+KBUsvjlxSaQBZRnxMNpSfvSIV2T0sulUmChPciOq8V9dUbIlc+
 PmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587707; x=1723192507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn2m1zPQU5uZwrc+vr+y8yHWMvWTtYhQaIESa/eMd7c=;
 b=kAfXk2FEY6VyjaTeqKsiKdgx0Z51ltcUVVmOyzunkjfkpXgfMUrFO1oNYu1gzrJ0ve
 Pzeqh3jxILayRJQaEbBote5YiNveOuybXBBS5XT3oG13u3GwEIbWjxUF36pGUwtBKAS7
 viPaGPR1F0B4udF06HRCVARPRj8KpYgonC1xdBGvGYPQRnoKipUdE33a+iqZ7cE3Nfqb
 8Ip8R+a2TGbvZtm0PLf9vQnMSmLduxvB/znLzfCqU7S4Vqs7nVJdoXeDyrWrXH0xgQWU
 wXh0CB4MkvDqIXU7hsaGHHzMHYQooASjoZlIwt9mRsBzG6GFuJaxR8GkuXQx7d/nG3rk
 vPrw==
X-Gm-Message-State: AOJu0YzGgZspb+v9qLsoAxly5fTu7Om4rubIJw/w2YUYSAYUNL8yIufp
 IM3XNmoNZ0auh3EG4FKZZ713vNV4vxHX1bxw9bubW2eNh3Q/Zv9sRCAQ+xXmPs4=
X-Google-Smtp-Source: AGHT+IEbT01iEVBXVWAh2k+szBZd46e9KsRqjppb1I59ZG2vlwGeXkBaPIr5mxM0V57fiMobIwPGbQ==
X-Received: by 2002:aa7:8884:0:b0:705:be21:f2be with SMTP id
 d2e1a72fcca58-7106cfd2649mr3582341b3a.18.1722587706823; 
 Fri, 02 Aug 2024 01:35:06 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:06 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 13/18] bsd-user: Add generic RISC-V64 target definitions
Date: Fri,  2 Aug 2024 18:34:18 +1000
Message-Id: <20240802083423.142365-14-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x431.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added a generic definition for RISC-V64 target-specific details.
Implemented the 'regpairs_aligned' function,which returns 'false'
to indicate that register pairs are not aligned in the RISC-V64 ABI.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/riscv/target.h

diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
new file mode 100644
index 0000000000..036ddd185e
--- /dev/null
+++ b/bsd-user/riscv/target.h
@@ -0,0 +1,20 @@
+/*
+ * Riscv64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * riscv64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.34.1


