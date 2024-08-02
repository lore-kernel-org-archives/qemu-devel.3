Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E83C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkq-0001GA-HE; Fri, 02 Aug 2024 04:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnko-000122-I3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:14 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkl-0006i6-Mv
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:14 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-68aa9c894c7so2538267b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587709; x=1723192509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CPFezZ+3JBewhbWuELhuuqGJLgvyqacF3/NeINriXU=;
 b=AivtNNOIRxgiTqpIngxDAbNbg9Dy0q5nmiqCXJMgHXkFSG8aX4h0Oj2gXfIQRc28nw
 ucCF2ojsKSujW3OLTDajkzdXBPvsFvp0V3fZY/EnxfsDv+OK8Vj8zQVlefRqFsgANOff
 dBCZFt4nEL1IVmnkMnVaHPVP9Ewl5w3a+cG5/esIm2vEfZshH9xFFgD18Wfz2QFu9E2W
 zskqFj6o2vnNL1/93RJW+LucgN0OE0vN16387ySHpv6e+lgwBGtTyVBGZlNxPsga0UXT
 ZWT9/J/B6uBViWRbgzo1kDFu7VDoLRZGB4xDSJOukqSIJHNaoDSg6s/tBq25OApuG/gW
 OXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587709; x=1723192509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CPFezZ+3JBewhbWuELhuuqGJLgvyqacF3/NeINriXU=;
 b=dYgjdG60+OpMbJpmyLNFxLZE32uMsWQcSemQZATLR2FWlm/DiJPjNqkqn/2g9MRF6v
 N9crMM8sAjDXzvWjZFs1N/DlE8C+5qpDRR6Uf8i4uzIKsuQtL20FgDakVUdRUVLG4B9p
 Ckcw9MBKxC0vJHpTOwUsaKdGKE2Sux071CiF8CtKxYJ8ooOFMGLbjYoRadZRj/sQp4vi
 UgfHThZdBwm57wB9bmvVefVhwx2h2CoaXTyiLEjCp1Ixfkyz9deZUgQPBJs4RC/xZY1y
 inyvOaXwMKf5/+BnflpFLkn38ohqNRe1ntily5FV0N2/tr1HBlYcqAaePUjgDW+wu11i
 GV9g==
X-Gm-Message-State: AOJu0Ywu7dvNxBTxycHgO95DU/q9NcrZRIsbDGxOFzU3hwWfLoLbGVQN
 +yK0rK1Urn4SJYIFqyCSRmyO9WzexTb/+I9lZAf2XbyHNzVHxiXzIGPWXLMbqto=
X-Google-Smtp-Source: AGHT+IEnfSUuPxzKSy+V4uqZDRADoDY0ZQnNeMNvnr/DxIuvm3EhVE2/3AodeYPcVT8o6TgdLTl2kw==
X-Received: by 2002:a0d:c306:0:b0:664:7b3d:a53f with SMTP id
 00721157ae682-68964591506mr24985477b3.45.1722587709186; 
 Fri, 02 Aug 2024 01:35:09 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:08 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 14/18] bsd-user: Define RISC-V signal handling structures and
 constants
Date: Fri,  2 Aug 2024 18:34:19 +1000
Message-Id: <20240802083423.142365-15-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=itachis6234@gmail.com; helo=mail-yw1-x112f.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Added definitions for RISC-V signal handling, including structures
and constants for managing signal frames and context

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
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


