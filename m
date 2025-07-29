Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC25C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguZY-0008Lt-Rf; Tue, 29 Jul 2025 20:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJH-0004qP-D4
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJF-0004g7-2j
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so1284554b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833878; x=1754438678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LMG725nib6z5VR/+Q3UcrgvM0cFgPWaum8FcyQV4Vtw=;
 b=WyKsq6L3dRsxCio7V8Rxnjzvb4E6d8pSt8rGSI5rcb3ehzcXqi9Y1ocYdt4wlvtZaN
 PnrSWJ7/aj7rhN58YbFo0spSeSbRf/tXVEe9Z6g0gX6vtcdweMYx3qovxsON11x3k+ZB
 7GZLWFW849bYrrPREXgVtlnhPb2WRo9aTfxD4sC9e+x1tM5BR0uXoIeHom1pCPYF4Eud
 yL3LBFcTxZYeNHsJ1trNn4q3/ihIGg9CvV2SFGhQZWfxbbqMjCjyh0nuudNf+joYF9ot
 gNnlVnRiXFRfRASuxS74L39qRNiaP/mWSUxNYfrkfNCJdmeAti9UvmNdyJ+6sw2h5XyO
 U1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833878; x=1754438678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMG725nib6z5VR/+Q3UcrgvM0cFgPWaum8FcyQV4Vtw=;
 b=dPbKkD0L2rYViKcXAie6EVG56HlLaDwRkZtJbt2u1A0/Xq1PmAed1zGLGiXbosg+AW
 RaPBiRKm4j/YAAsOfWu98jLRPrteWndlMBQs69/3hILf7F0fCx22DJ4+2XsYQZmd4Qxw
 Dleh1Siu4wSuiyQdrw5r39Y7qJpg4wA8hVnuic+bU5BWztilfztW4aKXoQONl41I4gGb
 IqxHiqev0yyXVab7WVwp7yNAk1LFKNrIivX/hrjP87J4eNxM25qZCE9dBRGfssINt2oB
 C6InfLDqYrVKve8nTn891VletgstGLo3JQ7pE2XqAR+n3n5LtH2SzzAYwcxB5sDR3R3N
 K/iw==
X-Gm-Message-State: AOJu0YzVNPbSUM69/neoIXknT0I/a1x9S+14h0Mi5CaxesQQkOVqgHDC
 tLF+szE5L3KvbmVn5pt3FZnDLtZy9sFVjjqYuefTtUitCRpmsFZ7wUFCCt8uxaPMTP57YQtRq0u
 03WQU
X-Gm-Gg: ASbGncvyP5tua0C3/wvNZEP/U4zAkXFiO2aHRk5T5Neh6nGLUZbSfnjT2X8pjau5dE8
 Umn+7vCxcLT8noiwVc4qo0y1WevlxsimFgaXcTghKE6eSZ2V/cyhS5xv05H2afJgSslbCzO/kro
 +mtoxlkc+3d5aFBm73JVZ1ojYv/eJNGPrCJjC2RfwnPTR0RsDi4TdpaQZt1gVlcT7Ro2EdS/UAY
 OPfHrLbb864piPmgZUvEf7Ykzm4dN8timb/en2u6droL9PrFKgjXQgiZpJ+5wmC9d39unWQAQJq
 VUl/z7zXVwDFh6rwi/8cg2cc6vWO0yaMbYWy2cHSIjSkaICuUNf5BKFVr60+uQEkuHOw35aiMQ5
 Haco3iGGmx6xkJekCbH+yMElxkfIpQ5zGw94dJUz5KGuHn+ZHWS1WKJ/p38OSJ6T60SUrsetZL8
 KLKQC1OB4LFgI2RFpbcSNB
X-Google-Smtp-Source: AGHT+IHTfBTfQ8EdScH5kVwG3IRfs8xGzaOJ/hHQK4UZq6gI7mm30paR9BuwT4Y734aUjGfHWtaNwA==
X-Received: by 2002:a05:6a00:2a0f:b0:758:b81:603a with SMTP id
 d2e1a72fcca58-76ab102133dmr1808221b3a.2.1753833878204; 
 Tue, 29 Jul 2025 17:04:38 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/89] linux-user: Move elf parameters to {arm,
 aarch64}/target_elf.h
Date: Tue, 29 Jul 2025 13:59:37 -1000
Message-ID: <20250730000003.599084-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h | 10 ++++++++++
 linux-user/arm/target_elf.h     |  5 +++++
 linux-user/elfload.c            | 29 -----------------------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index d955b3d07f..8f704055ec 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
+#define ELF_ARCH                EM_AARCH64
+#define ELF_CLASS               ELFCLASS64
+#define USE_ELF_CORE_DUMP
+
+#if TARGET_BIG_ENDIAN
+# define VDSO_HEADER            "vdso-be.c.inc"
+#else
+# define VDSO_HEADER            "vdso-le.c.inc"
+#endif
+
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 209076284b..2f8564a484 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,6 +8,11 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
+#define ELF_ARCH                EM_ARM
+#define ELF_CLASS               ELFCLASS32
+#define EXSTACK_DEFAULT         true
+#define USE_ELF_CORE_DUMP
+
 #define HI_COMMPAGE (intptr_t)0xffff0f00u
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d071bca660..dec27496ff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,35 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ARM
-
-#ifndef TARGET_AARCH64
-/* 32 bit ARM definitions */
-
-#define ELF_ARCH        EM_ARM
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#define USE_ELF_CORE_DUMP
-
-#else
-/* 64 bit ARM definitions */
-
-#define ELF_ARCH        EM_AARCH64
-#define ELF_CLASS       ELFCLASS64
-
-#define USE_ELF_CORE_DUMP
-
-#if TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-be.c.inc"
-#else
-# define VDSO_HEADER  "vdso-le.c.inc"
-#endif
-
-#endif /* not TARGET_AARCH64 */
-
-#endif /* TARGET_ARM */
-
 #ifdef TARGET_SPARC
 
 #ifndef TARGET_SPARC64
-- 
2.43.0


