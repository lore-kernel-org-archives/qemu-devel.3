Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C5CF3197
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIA-0008JJ-E1; Wed, 02 Oct 2024 01:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHn-0007vq-V8
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHm-0004wc-9g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b7463dd89so35784825ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848349; x=1728453149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8/eqSFR6IGIJa8Y4u4kxgSIB5m8G9YNXabKD73+56A=;
 b=Wd9jsWld4B77rbCXpJNEnm2QMphF9RyFVPSOy238COmPY3prA9tY1l9x5hHSiFZ5Q2
 D68VidYIFhF/8zIrq51Eo+glX16P1dWSVBxmDEKfPLVDN7nXGzvGqLWzwPWuZybPYuPr
 RczbhVxJvfaRnzyGFZNKEJWfbJuJPc5nVg2HGv1kH4DIqY9VN7yfYGKO69F4mzQmB0yM
 SplvGSR9+RldOyMrer596bzgVPTKHwc9ZiR4zKyt/qpUy9Ep3NdjrnaxE8dO5MhOppq5
 Hf0l3zWHptGz+1J7wwIJk+Y8oR0y0swmJSB4C5KIlrAlR+knIs03gnfqLIf2qpIpoC+s
 rubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848349; x=1728453149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8/eqSFR6IGIJa8Y4u4kxgSIB5m8G9YNXabKD73+56A=;
 b=kzJ8ia9kJZDSMdmsvpVLf5znprdwYXgMATu3KNsJ/SzZRoCvJALjOpNeO7sakfrlni
 2cZR04cQmaf6nh73+ZtVCcEXXVPnX++K+AGZwexa5hbhtuCoqwEAcOZ23Ycn1BuGPzJV
 NJuRwMwqn9HuSElNCVATn75dMCIchDnnZU6TkUSoZDyHdiecFXCL0XRtfmQOOybrV4MV
 fH1CejapZPn3nfXGD8MRh7wP62zVbJ4cITtC4f1XEj/VYzJO0G/n+FZTForNtxIGlT6T
 juEmdAux8wtmizPFpGhzQzaUXAQNdNwCWowsX7kmuVyJj4ObPpMOUGJ4gyl4iVo4+VNx
 KwPQ==
X-Gm-Message-State: AOJu0YzXh3VfXNhd1/4j1leXvVsqZKM9V2DCzfJOitlsBEBADv77NyCT
 7hs2R+PE0qtQT02JXmG45A51WkAfaSOcQZ5LuYEkji1Hk/sIJ4mz6Awca8hA
X-Google-Smtp-Source: AGHT+IHzLWA8j57eGydM2z8SPJu/6NBLZC050+Oq0h69SIh2ksLA6Lxzrf74UsGn+Z4MTehdxeMepQ==
X-Received: by 2002:a17:902:e88f:b0:20b:4f95:9335 with SMTP id
 d9443c01a7336-20bc5a6a4a1mr28762505ad.43.1727848348780; 
 Tue, 01 Oct 2024 22:52:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 29/35] bsd-user: Define RISC-V system call structures and
 constants
Date: Wed,  2 Oct 2024 15:50:42 +1000
Message-ID: <20241002055048.556083-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-12-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_syscall.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/riscv/target_syscall.h

diff --git a/bsd-user/riscv/target_syscall.h b/bsd-user/riscv/target_syscall.h
new file mode 100644
index 0000000000..e7e5231309
--- /dev/null
+++ b/bsd-user/riscv/target_syscall.h
@@ -0,0 +1,38 @@
+/*
+ *  RISC-V system call definitions
+ *
+ *  Copyright (c) Mark Corbin
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
+#ifndef BSD_USER_RISCV_TARGET_SYSCALL_H
+#define BSD_USER_RISCV_TARGET_SYSCALL_H
+
+/*
+ * struct target_pt_regs defines the way the registers are stored on the stack
+ * during a system call.
+ */
+
+struct target_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong sepc;
+};
+
+#define UNAME_MACHINE "riscv64"
+
+#define TARGET_HW_MACHINE       "riscv"
+#define TARGET_HW_MACHINE_ARCH  UNAME_MACHINE
+
+#endif /* BSD_USER_RISCV_TARGET_SYSCALL_H */
-- 
2.46.2


