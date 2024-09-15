Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5C8C3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9J-0007UG-Kc; Sun, 15 Sep 2024 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9I-0007PF-0Y
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9G-0008FI-BX
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2068a7c9286so25487695ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726414008; x=1727018808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voYN43OZ7lwbwneNl7z2eHNOhROV9NjNWmAvKPq1wXw=;
 b=jTFdh+28AmurOPfON21EfbGSYdxGnhC5Tnu7uRgSLQt5X2eDuAxmi3bqgp0l5sES3A
 B14M2XM4w86yr9zBeUdZT7y+xLVvQVULGGoEFCA8XS7jdv8HHQHC/7RCrda6oGTkknJQ
 FiZAkECEWSKlZtglNIYqYyXty6l0X0rHXezTJ+cleYIv0nZ+o4wEcd71pW2fwV2A4opb
 b/1bMF4E/0I+Xaaid7YPZ5fg98RZjuTmYfVG8xY3bdJjMii8Nl0sdWSWaIm8tt1Xrp1r
 9XBrEdtdY2aW9A5/yYDHxqQdJ7qGEH/sA0734bvUsdDY5lLBlk27PfPrSgxKF6E07S3C
 ZA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726414008; x=1727018808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voYN43OZ7lwbwneNl7z2eHNOhROV9NjNWmAvKPq1wXw=;
 b=SGZtleDhDixCXCUmDgYoiKhdIdpRcrUBsILCHi/Dgl7maDNtG1uwPhGrYKWOscMRu9
 sxZxEJucCKaH0B9VLMEqS4iWSnCsE6j8MJl2qTKRm+ez9mMTCNdqSo15s2I9/VrV/wdO
 F4RkD0H3To5Ekev64AQnFgqP36Owu3/Fc+Gc66rJYvOkwAuD4+41RR8bvq2J0J6BliIO
 9e9hSK3529gNsp1HKo8VZ5WvoPgpc5XEf/TLQHfoi46LH9j0jbTjUiWRSR2ZmaQftiqw
 0+If8kTfisQHAmCoV3f5iemL2DJurruUuEEaozGAcf3b9GLPzuAYJk58zVc8ofTyrfAM
 zO8w==
X-Gm-Message-State: AOJu0YzXFO+mOOrZzKTwLNLiR2b4FRW7FXoVM35xeEXPvdgktK4gtlPu
 Q8W2hnAOP+CB9d5ZX0FWse6jzVIIJxuEY2zykvPnOC25jbuZD2uw7dMjhA==
X-Google-Smtp-Source: AGHT+IHaES2ToxkVZTIDmhPlQ0znSXocgXKqcXTt8hKIawIEAcyMNUVJBZxdQJolf5IaLNQjtcTlyQ==
X-Received: by 2002:a17:903:2452:b0:205:5dfe:7d9 with SMTP id
 d9443c01a7336-20781d62a07mr125593715ad.19.1726414008315; 
 Sun, 15 Sep 2024 08:26:48 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:47 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 13/17] bsd-user: Define RISC-V signal handling structures
 and constants
Date: Mon, 16 Sep 2024 01:25:50 +1000
Message-Id: <20240915152554.8394-14-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x634.google.com
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


