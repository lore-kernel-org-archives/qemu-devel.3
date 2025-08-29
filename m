Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D32CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkx-0003i7-4Y; Sat, 30 Aug 2025 11:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xv-0003Na-SY
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xt-000369-Oi
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1239015b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506367; x=1757111167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeyuONIhn7M8m2f6ZvIYRj5UQSQ10lMaLgBMOA9lrAQ=;
 b=KfXWy/Fm63w12nVyFiO/slR4AWu/Rig9AwK1e1TAFLqJmLF75EMN6eTxuY30SSW/M2
 SN3vgQAz1pkvZhPLuQtOIXOYXK0l9cIsgqInZQ+2eVCRaDxbFNvzDPN8vQYMu7OtGIJY
 Q/Hz5/oPtrnyJiCEfm8YhPKEysjglKZZ9EGN4sJKDN6vn0WsLUfMrLcF+/0VDFB45ayt
 jXmlgL6hDkHBeIO1WUb1BQYA/peMa3+F6HfzAQqu3RpaMnftPDISmZFtafCOeJossNIu
 t180Yda3JbCN/lWic62Trhi87bS0A8xHtzazB+yydQpXEgQhA0WjG5yzP75HeslJl6rz
 bHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506367; x=1757111167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeyuONIhn7M8m2f6ZvIYRj5UQSQ10lMaLgBMOA9lrAQ=;
 b=bqgUF1YcX7i1IRL5AGD53ij+97O9zOqv6/udyNCHHRrU/gzRsSouw0hBjGBZh1hGkj
 aV92IFN4Oe0BeDTh288Y0ByP8Ju6A8Wr9OFlYuJeGzfph0xqn2T20L7ROW2b/Z+Tr1iE
 sXqDt7TUc2Syt49BWfeDEs3kXONuecmaYVSuyzTi2QAAft++vIOGLKaJ71k0cM4T3P3I
 ooRE7cp337aHczK1HL9AClY/O8hiLn/APybNUatwftjrmq1KR+ABIjJ8fvwir7U815Z+
 CwIEhTC/qUavrQIrilsNTO8EfxHfN23LaxwwgisabYby7p2R8zz6HbXrEbal1A+gu4pt
 MbeQ==
X-Gm-Message-State: AOJu0YwhtkS0ceC2NXGG+Mrt5Xazz4RMzKqyYfvtHHKZS5FRTFsh2sqb
 L1PDSxWQkbpACvkAXHEamMxzxQXc0ttRup1PzcrIvQkh/ByY5xGqbySP2MTg4FTRLTE8bxPGzQd
 eHaBsXkc=
X-Gm-Gg: ASbGncsbr/2GZ+CKWE6S7PGMkyIgcuWFtBT/KcQvM1oNJdatVumIWwm2QOk+Z3CCejK
 hcMdEXSWTfNMlgYTuGHqfQGHDgjxSlnMYvuVPsqB4QkZn5h7pSv/XPRFLG+sLheIZAcbXLLXG/p
 +ZJ8YEMzg6TtgOYLm8hb9PtHFspki9mAUjE9qNAMkIY8KK0sSGsSfBPlilPekXkT/ThRZKO+oxh
 HpPM7fQRYLZwGhMh/mHgnryNqB0RRDuqLoXw4bjFKKXh2K0s9sWijiHoDw61baIWlU54A6XuzdS
 P7wbSRZchT6uLr/SCeI7vG4S5NvXjOnbwyDmJIInI0HYMqS7EMYuyRcbeusmtwINjBtich2qw0I
 PSPxGtOpiPwJfVsFTiCH3Cm0GxG6Abvod2cc3DG11IeBslqo6wkYVnq0M2oue
X-Google-Smtp-Source: AGHT+IFDccpDkN0i3dfJVEAzM3vxk3oC/yNuHoZorujCn2LTVTMReAddkuNEhLofihMoiepXIRj2TQ==
X-Received: by 2002:a05:6a00:460e:b0:772:fc2:be71 with SMTP id
 d2e1a72fcca58-7723e338532mr275928b3a.20.1756506366734; 
 Fri, 29 Aug 2025 15:26:06 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 39/91] linux-user/aarch64: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:35 +1000
Message-ID: <20250829222427.289668-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Move the target_pt_regs structure from target_syscall.h, and
rename to target_user_pt_regs, to match what's in ptrace.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_ptrace.h  | 14 ++++++++++++++
 linux-user/aarch64/target_syscall.h |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 linux-user/aarch64/target_ptrace.h

diff --git a/linux-user/aarch64/target_ptrace.h b/linux-user/aarch64/target_ptrace.h
new file mode 100644
index 0000000000..10681338ba
--- /dev/null
+++ b/linux-user/aarch64/target_ptrace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef AARCH64_TARGET_PTRACE_H
+#define AARCH64_TARGET_PTRACE_H
+
+/* See arch/arm64/include/uapi/asm/ptrace.h. */
+struct target_user_pt_regs {
+    uint64_t regs[31];
+    uint64_t sp;
+    uint64_t pc;
+    uint64_t pstate;
+};
+
+#endif /* AARCH64_TARGET_PTRACE_H */
diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index c055133725..bd05f6c7fe 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,13 +1,6 @@
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    uint64_t        regs[31];
-    uint64_t        sp;
-    uint64_t        pc;
-    uint64_t        pstate;
-};
-
 #if TARGET_BIG_ENDIAN
 #define UNAME_MACHINE "aarch64_be"
 #else
-- 
2.43.0


