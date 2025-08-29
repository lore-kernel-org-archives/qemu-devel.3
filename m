Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2137CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjE-0006JF-EO; Sat, 30 Aug 2025 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7aw-0004GH-TT
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7av-0003XX-1b
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-249036375a1so12721175ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506555; x=1757111355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+3RJP5x9tU8ncpZPQyYYeZqq72wzhFyUN/VD6LAv/I=;
 b=odsO8lIG0nWpn+1MgQfxjtN2I0Av9zQAaWYr9NZpZNJiMFUvxEyC0sXDkMxXAzV13B
 qTBdwfiF0YmImM2gZ62hxpLI2AkqyhSUK/eAJgP37IQ3bFZ+gYpgER8lmhBp541gcPAC
 fWY8rrtmOvTl7auZZRRzfz7dXJWjS6JuR0tmrvjLGNbFKQrQ1TqdtygdKHDTSSnJeHkb
 a0lnVdcdP5rJdTy8km6LODM5F6NG7ETTCYCnwSXwVy6s3xmGzgwqly2koepTolQzgHRv
 4tE5kwzh2t04RlKZIcBsgrehWZeDgePYTw2XC1PncWtPX7NU558/iZdD3ywO15smeyXQ
 laaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506555; x=1757111355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+3RJP5x9tU8ncpZPQyYYeZqq72wzhFyUN/VD6LAv/I=;
 b=M05SopPDPsMdyzPpgWCDO4Nc3ROATXeATpo1/uuDc4VGNtCcdhanju0oLFWngNFOA+
 MWmkfMj8T5cQKgUV+GjK4SOJZxWyOYFkUc+mIHXzwzf3CKDTrUv5NBhXPzLcOftoGrEF
 JTIr+Ntg6aKpP9XBUGINpOBGKbDAlhoMmhHTbMnD+bQwuCp9lsXKVuGht+XqlYnmWA5M
 sIotoMPXI+LM0atMLYCxCpFebLwnpJPE7m1F15cG+8gClcjeQGjekbItxLyWu2GQFGlY
 VEqDv3DTxaUaF6BUtGksw5rHCfG38evx+yh/TOU5a6YaQxHa5f2bscPOmVGhGN5Oj45K
 Ee9Q==
X-Gm-Message-State: AOJu0Yxat+nzalbswb8Uq+w+9e7oUI09QftwBNnyY/Ro+pal1eCMRCCH
 o9krLfLrdWACM59fuKVNYKxYsmrW1/uWlmFiHrkgWC1gZ/CTEkluYL1AsxVqUNhNXmChDEhvTGf
 KcxFheqc=
X-Gm-Gg: ASbGncvqRrKf3xHsPb+WgJsni7aS8JIffcWTXRkKtGx4i+brDLRgJ+15W58Rz6fsFxz
 vJiuELNPxruYrt7W7Tbw5ZRDKPpmJ9MHX7S+5PY3mOWHfnIFWKZ9HDCx0vjVDdug95vgqt0u3LM
 o4w9NaL4R+UB9lbyfE+LJij9k4K+RX2IEy2Qn8S+eMPt8loTMk4Mr5cT9y+lCWLvINvXC4uzjQb
 rXAahafxtdFbSL+KkLga0A0AQ7yrHB4uwVZHq50a+kWJDq19H3AjE9HdwLluUuC+AFTx6hjAYCM
 RN02kYZSho7Tj6wVfIrpXHVjqdgmwtj7b3FQnJyk3y7CIroE4lwehg7/LRft6f/pGSQPNHzVdlS
 beeoxoxOlv9Lsq4PpYeV0lwF1JAQPvBhqZx32K37XFmXXgsH7O/6Znnx9FupN58INv4eI3jo2Hl
 wTwFvDtefn
X-Google-Smtp-Source: AGHT+IHnjkNG9qt5wJsnT0QLChkzMgJgJveOKVma1uWzbaIb7ST5IP9yKEaEtSMsw4l8C0lSqX+sBw==
X-Received: by 2002:a17:903:3c45:b0:248:f762:865b with SMTP id
 d9443c01a7336-24944b196e1mr2620265ad.28.1756506554857; 
 Fri, 29 Aug 2025 15:29:14 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 41/91] linux-user/arm: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:37 +1000
Message-ID: <20250829222427.289668-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move the target_pt_regs structure from target_syscall.h.
Replace the array with proper structure fields.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_ptrace.h  | 16 ++++++++++++++++
 linux-user/arm/target_syscall.h |  8 --------
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 linux-user/arm/target_ptrace.h

diff --git a/linux-user/arm/target_ptrace.h b/linux-user/arm/target_ptrace.h
new file mode 100644
index 0000000000..1610b8e03c
--- /dev/null
+++ b/linux-user/arm/target_ptrace.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef ARM_TARGET_PTRACE_H
+#define ARM_TARGET_PTRACE_H
+
+/*
+ * See arch/arm/include/uapi/asm/ptrace.h.
+ * Instead of an array and ARM_xx defines, use proper fields.
+ */
+struct target_pt_regs {
+    abi_ulong regs[16];
+    abi_ulong cpsr;
+    abi_ulong orig_r0;
+};
+
+#endif /* ARM_TARGET_PTRACE_H */
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 412ad434cf..8c4ddba717 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -1,14 +1,6 @@
 #ifndef ARM_TARGET_SYSCALL_H
 #define ARM_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-/* uregs[0..15] are r0 to r15; uregs[16] is CPSR; uregs[17] is ORIG_r0 */
-struct target_pt_regs {
-    abi_long uregs[18];
-};
-
 #define ARM_SYSCALL_BASE	0x900000
 #define ARM_THUMB_SYSCALL	0
 
-- 
2.43.0


