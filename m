Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F8AEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRn-0002ct-W1; Thu, 12 Sep 2024 01:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socR3-0007Pw-IO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socR1-0003AQ-Mq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2054e22ce3fso6251825ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119122; x=1726723922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00k0Mqx/EpFUnR82ExpzBJkLkNZLP5MDHD2q8XNb0eY=;
 b=PIyG4vwvhQ5+Vl770jNqy5xp56ACpiJLSYvkM4o0MLGXuRex3X31ThQ/B0AA8j0PS1
 qiHOm1feSNQJQW7vCyfV3cmAF5V80QqHRAl3gLlLzoqw7m98Krlvfl4M9Q23UXxeD62e
 cqEYe4DxIHCaw/WdGJkct9unyV/jNMGVa356mMGiD5951VBlgPpvJUXs+WthOtLBFw5D
 fWQ8yR8BYVzzdBBF3fU+bp4UrpGuMc9REETV9ihPtVoZF84JM02vUo+eEuTQXAWdtmiP
 9KnapWoDakx1dzsyWlV9zG3WVpVE2exDCNAyYBcorb/yjDX6kozQLWIYEOTz/Lh9R6jW
 bPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119122; x=1726723922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00k0Mqx/EpFUnR82ExpzBJkLkNZLP5MDHD2q8XNb0eY=;
 b=uDFu8b5AMlo/5PlWhZZy2kFa2QfYp5RI4Y0eFnSfMH01Ovhs1ZJgn7L21FI3bZ/tQk
 rNQPdekwtGavw3hF8cw45gv7YoJ6NBnC4Lmrr9+OKAoxzOHezbJp4fTrasx95Hmm8WkG
 eMjuPGn9tkhMJKbHtkvdVFp1g16mVg/GegdUmjwJbiGVlvKppQWIkHQ94Vl/qR82BEmn
 jDL5hZZQPCKZ8Q9zSDFAX8NSAhKMbGNyGOLwhWYbxWgXhdY71v6KfGYj4IZytGCCOVoJ
 52NvUmoiD/jVu0HNYB0GTQsZ57gzuXgZ1h6irhiVjy3S/RQb3ZnHsD0c/uT4LvWwDHso
 NsZQ==
X-Gm-Message-State: AOJu0Yz3jBbEsz042Fxc2bQyNU61bkQf+7zXQGYn/q2H7Bw7USjhLPY5
 AvNXLq5mpUnMk7NJd3UhxW5ReUoOfmmAdc8MrECvzBkc8wRF8R0iQHzbjA==
X-Google-Smtp-Source: AGHT+IGokXQU+krw4BySG5/0ZY/OlN9RfUUfqek2zBZGxtavXhP2vT/OfN8M9VuIlnIfmnNRx4YXhg==
X-Received: by 2002:a05:6a21:3318:b0:1c8:fdc7:8813 with SMTP id
 adf61e73a8af0-1cf75f2a590mr2135044637.23.1726119122017; 
 Wed, 11 Sep 2024 22:32:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/47] bsd-user: Define RISC-V signal handling structures and
 constants
Date: Thu, 12 Sep 2024 15:29:43 +1000
Message-ID: <20240912052953.2552501-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

Added definitions for RISC-V signal handling, including structures
and constants for managing signal frames and context

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-14-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


