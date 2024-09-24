Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DA1CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtn-00089z-1L; Tue, 24 Sep 2024 18:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtV-00068B-6a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtS-0001zi-Lv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so222722b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216425; x=1727821225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvZHALT/Y07lad0lf7s/hV7uoEQ9M7X3TPQENnIjQhg=;
 b=Bg4d7ebhYiQ9+dEuwGYa9l4c5p024Zv/J+blWzqJOj5zCW+b1IdtVNwmiAjvEz/ISl
 dNgA94fkQVAUeXOWS4M7OJkffEVtrlENvEFS9LcRf5fkBv/BPGCTYKUlMG1YPYuoa2BP
 YnUb6oyY8Kqbup0h6fDRDWEOhe2P4RAB3NCrycGIwqZMscZwBhq7wK6p3w4+5TzYxthZ
 h0bUMHV4QcgAVaJdvxEJOlxDLwWTUweAbtNQKZJ/MqbzjzgdfSoGDb/6xNvTZ/YKL8vs
 ppccVCv+ufo8fZJtVokBcX2P8GPBbbADCnK/nGVI8JCXkZRKdMINJUR8C3pc/mnRVyA7
 TiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216425; x=1727821225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvZHALT/Y07lad0lf7s/hV7uoEQ9M7X3TPQENnIjQhg=;
 b=NgQL2fvPh1P6sLaZSwXpwGqZD3IPir0cLv6MG3CPs1hF1MXPAG5uscKGo1+qv6cvcf
 1StxIp6wxQtyeHYQtiiwzyUcFJUjiR/wIFPT8OnB/em6yoskP+W1mo2xosgDbQZFdw2I
 8WQwQD3QhfEcq/lZnY5uT2ZEkJV/4c36hHAbGIuoWjyoyv2g+psXrnLNbXnKL1U24CJQ
 Q9Af9ZCGPqe5zHyLp3bpt/q8L+zfBkgIYFpPpXyV3qjGjY2YCTcYZxkANDlG/TR/zu4x
 0z/5+pq8nQgtnjlV3MHmVfugoKjLuCM8Wpo66zpU6gjPr8/UdHMwOGE/5gOz/LQ0iRR/
 uaRA==
X-Gm-Message-State: AOJu0YwQWm1NEoz5Qz9tsVFopeFNI34Dl0Byj+DtrHQ+X10HDOzL7MOg
 sDsMGuwOAFxwYvIwOgmDSO8nO/c2T52mMDmPiN81oGKggsNbGAffO6mrEw==
X-Google-Smtp-Source: AGHT+IE/b3ssdjOY/EOJFkAhoTF4XvlGqs1Kg0LAQAr9QEWj1SPNN6Uj9IMBDZtir+bTGiyTq/gXTQ==
X-Received: by 2002:a05:6a20:c909:b0:1cf:38cf:dfb6 with SMTP id
 adf61e73a8af0-1d4c6ecece2mr893680637.20.1727216425038; 
 Tue, 24 Sep 2024 15:20:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 43/47] bsd-user: Define RISC-V signal handling structures
 and constants
Date: Wed, 25 Sep 2024 08:17:44 +1000
Message-ID: <20240924221751.2688389-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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
Message-ID: <20240916155119.14610-14-itachis@FreeBSD.org>
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
2.46.1


