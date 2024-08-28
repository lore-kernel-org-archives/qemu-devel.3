Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C371FC54E62
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMs-0003Zq-QJ; Wed, 28 Aug 2024 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMr-0003UP-C4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMo-0001qQ-Jz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7142a93ea9cso4676513b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838809; x=1725443609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voYN43OZ7lwbwneNl7z2eHNOhROV9NjNWmAvKPq1wXw=;
 b=VlE6cYJFOQhmp7SoDVN9agSH5p1RAqep/XY42v06kPhoGA4UZthopBK3+7ve+Fm0Ml
 blWoDD0PZRsVX6CaGEQBkt5teNfFh01wAoy4XFi73lwI1/W+2JSBpJ7hvjUd8RvH1JE0
 yp2KYIbsVlbvGD9aOVpP980Au9liN1LcfO3/ibnt9VADkutfTSTgaAOu3Ag7HNBKZM0h
 F2vxUSiq9ilaEFXkk6xHagMC7W9oZKEraiZFOGVbeS2cGEFBh5xdH2cRvHFJ90FBjsm/
 oYPZ8P0rYeVN+GOjWQAHYOLLlT1DCvwoolWipN72sA7ZkbssuZ1E126uGvhW5yLJr9wG
 Ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838809; x=1725443609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voYN43OZ7lwbwneNl7z2eHNOhROV9NjNWmAvKPq1wXw=;
 b=Nhaoywfh6+HRER+XUji6m5SS4MtSmARbkepqJjmHQhwwrvlTa9wOStio4n4ENzX7xM
 qjKk2XnhU1o7C8pUNP/G92f9hixPya1XAscgwCN1GM/8MyCXdiHjcrsi3jv0ncUG43rf
 CFW9RuoSLn+W7CiLUBC6ZCGhkmpgSGz7Q37/42hZaGDrjHzHedm9WVaLEecG6Fp6IY7P
 dzpJgSBXUUzLTjzpGogyVCC5SfczHv9XEkYTKdQXIAm3U1diE/kBM21pIv4hGmoJl31A
 QfWd5PmRHLz/VAUhSD9C5LkvlwF6Q5E6V/FGxotDjySEADjvibivTRuCgYKg3bsJ5xKG
 7G8g==
X-Gm-Message-State: AOJu0Yy+ZzPIxZvs/D+m2cyzYQqeXCpHiz0Q7wm3bsTeqCnXV1IMn7Pk
 2vh/HSPruiVZgUAbU4u4Yn6JHDEmzdpZ5X9PQlj3c7IM5J+kjKZb4oyJu1VE
X-Google-Smtp-Source: AGHT+IF4aqeaZBaKfaGCEPmVNhVUX0bEs4Yb6HLzPOVUBGbAGWe1I4ZiPMSFic1OdwvvAo8s4RDEXw==
X-Received: by 2002:a05:6a21:1507:b0:1c4:8da5:c665 with SMTP id
 adf61e73a8af0-1cc89d29c87mr16704229637.11.1724838808730; 
 Wed, 28 Aug 2024 02:53:28 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:28 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 13/17] bsd-user: Define RISC-V signal handling structures
 and constants
Date: Wed, 28 Aug 2024 19:52:39 +1000
Message-Id: <20240828095243.90491-14-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x431.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added definitions for RISC-V signal handling, including structures
and constants for managing signal frames and context

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_signal.h | 75 +++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_signal.h

diff --git a/bsd-user/riscv/target_arch_signal.h b/bsd-user/riscv/target_arch_signal.h
new file mode 100644
index 0000000000..1a634b865b
--- /dev/null
+++ b/bsd-user/riscv/target_arch_signal.h
@@ -0,0 +1,75 @@
+/*
+ *  RISC-V signal definitions
+ *
+ *  Copyright (c) 2019 Mark Corbin
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
+#ifndef TARGET_ARCH_SIGNAL_H
+#define TARGET_ARCH_SIGNAL_H
+
+#include "cpu.h"
+
+
+#define TARGET_INSN_SIZE     4  /* riscv instruction size */
+
+/* Size of the signal trampoline code placed on the stack. */
+#define TARGET_SZSIGCODE    ((abi_ulong)(7 * TARGET_INSN_SIZE))
+
+/* Compare with riscv/include/_limits.h */
+#define TARGET_MINSIGSTKSZ  (1024 * 4)
+#define TARGET_SIGSTKSZ     (TARGET_MINSIGSTKSZ + 32768)
+
+struct target_gpregs {
+    uint64_t    gp_ra;
+    uint64_t    gp_sp;
+    uint64_t    gp_gp;
+    uint64_t    gp_tp;
+    uint64_t    gp_t[7];
+    uint64_t    gp_s[12];
+    uint64_t    gp_a[8];
+    uint64_t    gp_sepc;
+    uint64_t    gp_sstatus;
+};
+
+struct target_fpregs {
+    uint64_t        fp_x[32][2];
+    uint64_t        fp_fcsr;
+    uint32_t        fp_flags;
+    uint32_t        pad;
+};
+
+typedef struct target_mcontext {
+    struct target_gpregs   mc_gpregs;
+    struct target_fpregs   mc_fpregs;
+    uint32_t               mc_flags;
+#define TARGET_MC_FP_VALID 0x01
+    uint32_t               mc_pad;
+    uint64_t               mc_spare[8];
+} target_mcontext_t;
+
+#define TARGET_MCONTEXT_SIZE 864
+#define TARGET_UCONTEXT_SIZE 936
+
+#include "target_os_ucontext.h"
+
+struct target_sigframe {
+    target_ucontext_t   sf_uc; /* = *sf_uncontext */
+    target_siginfo_t    sf_si; /* = *sf_siginfo (SA_SIGINFO case)*/
+};
+
+#define TARGET_SIGSTACK_ALIGN 16
+
+#endif /* TARGET_ARCH_SIGNAL_H */
-- 
2.34.1


