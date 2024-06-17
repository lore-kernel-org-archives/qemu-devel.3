Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2925C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZI-0006OR-1v; Mon, 17 Jun 2024 14:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZF-00066G-Vv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZE-00052I-2p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-705c424ebbbso4397898b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650738; x=1719255538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9i4EEFGzjqehEnuQgpeD/IRBLzE2eNmHoKEYKqac6c=;
 b=cC7AVQI9BY89JyQruEmw0ngEt3KPq9Ax5t0zUlyeqsW8jLotXzxmRK/DuvYeP6czA7
 zmarIjQFBvginAjI2pt8Iv8bx9TghY2iG7iHJL+M2C5IM0wNjVhB6q9D4ychiBa6Pn0k
 /QDRKuu2WQm6P8TWokko9/kZHWaVLdiHDQI+akETEofbxO0VMP98v+om3A6QtvpbgVtZ
 xCHFiyVVIpYh9Fxr6jMkA3HGi/ByA2Ugr0OhAxnVWbFTyKocWh9KRR/4Euhfm3TDCKPe
 WleuRJLR+S+hrl2g3vHlaATy0JAGJupKRUeNvS6lt56Af0CuorIj0E5t++bakWmUfbsF
 v73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650738; x=1719255538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9i4EEFGzjqehEnuQgpeD/IRBLzE2eNmHoKEYKqac6c=;
 b=Af53MIcxSYt4jLE6e8V+EdVwEaUOpbaJnvn80HyeXwBSoPU7Uou58K4qJ8C9wRjVxv
 YbBr1yy8bQodZstS8pe6V1/aoZHsfUBUuohDMGp22IBvSX2IwwM5buoUWqrXIeZZooBg
 j9GIhqNqaGyLGTK7Ba4mfxZsQZszXIa6wCSJO4RBbf3qe5trsEDzqcc/3eNSakV7pdxl
 Nf+eQCM5/Q+G4xvFM+jfSvWMzTu/FEF54+0znGQwYw1O4iAp5ENec0DUHZDW0yVZp79p
 4TGaI4IWuKK91xNEkAGlXw/8GqTHgniTvQ0aLy0ciW4peOBQS7KmZ1LCIyudr8U/4HbQ
 E9bQ==
X-Gm-Message-State: AOJu0Yz2ptA4t9cn2KlAe+C9FNTtMqdOLkAvT4CvPxbBgK8X36zAUycu
 kYc+YLmJi7CeU/dfNVIdtsmdtJh13s2ToG4Ut9LK+N9WShgnbHMfmsW6q9z8SU0=
X-Google-Smtp-Source: AGHT+IEHwtnhPtyCvr43fEjeDcaZ2ZaNSt2DkRJejf5UjglIp3v8tI0FRHPusVUEZmDp2CoFiEAQ8A==
X-Received: by 2002:aa7:8c0f:0:b0:705:b0aa:a6bf with SMTP id
 d2e1a72fcca58-705d710501bmr13230699b3a.2.1718650738239; 
 Mon, 17 Jun 2024 11:58:58 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:58 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 18/23] Add ARM AArch64 specific signal definitions for bsd-user
Date: Tue, 18 Jun 2024 00:27:59 +0530
Message-Id: <20240617185804.25075-19-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42f.google.com
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

Defined register indices and sizes,introduced structures to represent
general purpose registers, floating point registers, and machine context

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/target_arch_signal.h | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_signal.h

diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
new file mode 100644
index 0000000000..df17173316
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -0,0 +1,80 @@
+/*
+ * ARM AArch64 specific signal definitions for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_SIGNAL_H
+#define TARGET_ARCH_SIGNAL_H
+
+#include "cpu.h"
+
+#define TARGET_REG_X0   0
+#define TARGET_REG_X30  30
+#define TARGET_REG_X31  31
+#define TARGET_REG_LR   TARGET_REG_X30
+#define TARGET_REG_SP   TARGET_REG_X31
+
+#define TARGET_INSN_SIZE    4       /* arm64 instruction size */
+
+/* Size of the signal trampolin code. See _sigtramp(). */
+#define TARGET_SZSIGCODE    ((abi_ulong)(9 * TARGET_INSN_SIZE))
+
+/* compare to sys/arm64/include/_limits.h */
+#define TARGET_MINSIGSTKSZ  (1024 * 4)                  /* min sig stack size */
+#define TARGET_SIGSTKSZ     (TARGET_MINSIGSTKSZ + 32768)  /* recommended size */
+
+/* struct __mcontext in sys/arm64/include/ucontext.h */
+
+struct target_gpregs {
+    uint64_t    gp_x[30];
+    uint64_t    gp_lr;
+    uint64_t    gp_sp;
+    uint64_t    gp_elr;
+    uint32_t    gp_spsr;
+    uint32_t    gp_pad;
+};
+
+struct target_fpregs {
+    __uint128_t fp_q[32];
+    uint32_t    fp_sr;
+    uint32_t    fp_cr;
+    uint32_t    fp_flags;
+    uint32_t    fp_pad;
+};
+
+struct target__mcontext {
+    struct target_gpregs mc_gpregs;
+    struct target_fpregs mc_fpregs;
+    uint32_t    mc_flags;
+#define TARGET_MC_FP_VALID  0x1
+    uint32_t    mc_pad;
+    uint64_t    mc_spare[8];
+};
+
+typedef struct target__mcontext target_mcontext_t;
+
+#define TARGET_MCONTEXT_SIZE 880
+#define TARGET_UCONTEXT_SIZE 960
+
+#include "target_os_ucontext.h"
+
+struct target_sigframe {
+    target_siginfo_t    sf_si;  /* saved siginfo */
+    target_ucontext_t   sf_uc;  /* saved ucontext */
+};
+
+#endif /* TARGET_ARCH_SIGNAL_H */
-- 
2.34.1


