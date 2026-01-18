Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1DCA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatw-0003eg-VF; Sun, 18 Jan 2026 17:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatT-0002I8-La
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatP-0000oW-VY
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a081c163b0so19914595ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773907; x=1769378707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9G7CRzjGckeYSeIr9MRvFLtIOKXPKdQ7GnAe48PSp8=;
 b=XA2mRoBzAjbShPR/+5Leae0ZZlN7SVDHJ5Vaah/qWZpAU+rjgeBJ60wCLbluFPJKq5
 xyQyIVzzMSMHhF6jX84pfax9LgA3dttOFaFKqACzwv3QPuGERGlUol1gyx1MkVb62g1+
 emWIkfv9cm2/hjiDCQH7s0Lb+uQTpWubWsSny5mI2L/1nYi256i/Veugv2MBKbpbO8Io
 3q8aBrh+P5jukbhYPqNX6pR9EiCnhvBZVjRgevUH+ZvdbXuoLF+VaPZpyK131Dl/rAps
 jYQR8miDX86uLaE6SIUVN7brjFcPEuepazrAG20D22BkBVBXzEFotLU3d0XPlZ+I6sn1
 Rd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773907; x=1769378707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C9G7CRzjGckeYSeIr9MRvFLtIOKXPKdQ7GnAe48PSp8=;
 b=IcFXCzgudWGJZmVqLGzLm99qNJp5YcsEik+wd6ZtiPJ03aNaeqkjpuVWbJ+UxNdJ1W
 /3UuVjhYPCmZ7JcaMx91rLOZlDxJneIrgA99LA4+KPK7k88b/SPNza/emW93ByMgK1IT
 KpTN2RMLE4hIs2vp8o+aN5nzgvLbgOfYaic0HW+3WnhnPJuzyLPGUmiCnHHFokiZkTqi
 QAQIloVEui3ApCGswlK9c4rgI0MhYs3e/QNGcHX8lahB4b2byqoN/VzikMdl1KRMv/kk
 e66nE5BcUvqnEc3VNA2essWFvIV/JBXkpfPXdclzmexwHbJLrMqeghYvZJKNZW7C7bKc
 Cknw==
X-Gm-Message-State: AOJu0Yy1CNrOFxFbjzuwoYlkalSzm/Ml/7ASNGyt1L3j9DCMR+bQMsLV
 Y5BjW1djAHN6WKhHT9RfKbMQqZH78qyvX21tmzfPpH7i5CJiY6kNNzaZEx9O+WGVcFAVT3Lh0ze
 zsVooyQoYPQ==
X-Gm-Gg: AY/fxX7Rq6nEYTmeujBaPVxXD5/KZdFZgGSFFaJvI4MVcGRLj9lGddyH1gDlnfRnww/
 nNxJzdxf6Sl1/ULgHGCgLIjYhkpcZE0rtT7mSDp4MKjYecvEFIJdoMFs/GGBiZDMCNhIdvEOUr2
 9fH/s49T6ZF2lRQ5DmPSTF/x8g59roqNmx50yu3JSZXE4O52iZ999etiQ9FzmW3DUlAku/mtV3w
 i6jY8PUmVfAgH8t2dCah5OPuo7qYBIYtLSbBwK27sVMZDbXD+Maa5cINNTlnJ5kaMpTGrpsVdc0
 yeCQdaZt0K091nQzqLnjJ2YWw81ksTfs7uJJa1cwbB+MyTdZLajaYuUD+f9++O+s0tHAiWmFVah
 m2QNhcUZ21+kAjgLt3sfIvnVdHUDeVLynUcEAPreu0i/RSkzTuRgsnxO4GWO6YKLnv44G1kVcFb
 a2z8R+Sa1ndd2hvXHh0g==
X-Received: by 2002:a17:902:db07:b0:2a0:d074:e9f4 with SMTP id
 d9443c01a7336-2a71780bf89mr102598285ad.59.1768773906538; 
 Sun, 18 Jan 2026 14:05:06 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 19/54] tcg: Make TCG_TARGET_REG_BITS common
Date: Mon, 19 Jan 2026 09:03:39 +1100
Message-ID: <20260118220414.8177-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since we only support 64-bit hosts, there's no real need
to parameterize TCG_TARGET_REG_BITS.  It seems worth holding
on to the identifier though, for documentation purposes.

Move one tcg/*/tcg-target-reg-bits.h to tcg/target-reg-bits.h
and remove the others.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h                     |  2 +-
 .../tcg/target-reg-bits.h                     |  8 +++----
 include/tcg/tcg.h                             |  2 +-
 tcg/aarch64/tcg-target-reg-bits.h             | 12 -----------
 tcg/loongarch64/tcg-target-reg-bits.h         | 21 -------------------
 tcg/mips64/tcg-target-reg-bits.h              | 16 --------------
 tcg/riscv64/tcg-target-reg-bits.h             | 19 -----------------
 tcg/s390x/tcg-target-reg-bits.h               | 17 ---------------
 tcg/sparc64/tcg-target-reg-bits.h             | 12 -----------
 tcg/tci/tcg-target-reg-bits.h                 | 18 ----------------
 tcg/x86_64/tcg-target-reg-bits.h              | 16 --------------
 11 files changed, 6 insertions(+), 137 deletions(-)
 rename tcg/ppc64/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
 delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/mips64/tcg-target-reg-bits.h
 delete mode 100644 tcg/riscv64/tcg-target-reg-bits.h
 delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
 delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 delete mode 100644 tcg/tci/tcg-target-reg-bits.h
 delete mode 100644 tcg/x86_64/tcg-target-reg-bits.h

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 49a27e4eae..d5bda83a2e 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -24,7 +24,7 @@
 #include <ffi.h>
 #pragma GCC diagnostic pop
 #endif
-#include "tcg-target-reg-bits.h"
+#include "tcg/target-reg-bits.h"
 
 #define MAX_CALL_IARGS  7
 
diff --git a/tcg/ppc64/tcg-target-reg-bits.h b/include/tcg/target-reg-bits.h
similarity index 71%
rename from tcg/ppc64/tcg-target-reg-bits.h
rename to include/tcg/target-reg-bits.h
index 3a15d7bee4..8f4ad3ed99 100644
--- a/tcg/ppc64/tcg-target-reg-bits.h
+++ b/include/tcg/target-reg-bits.h
@@ -7,10 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#ifndef _ARCH_PPC64
-# error Expecting 64-bit host architecture
-#endif
-
+/*
+ * We only support 64-bit hosts now.
+ * Retain the identifier for documentation.
+ */
 #define TCG_TARGET_REG_BITS  64
 
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6d9aa50d4..067150c542 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -31,7 +31,7 @@
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg/tcg-mo.h"
-#include "tcg-target-reg-bits.h"
+#include "tcg/target-reg-bits.h"
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
 #include "tcg/insn-start-words.h"
diff --git a/tcg/aarch64/tcg-target-reg-bits.h b/tcg/aarch64/tcg-target-reg-bits.h
deleted file mode 100644
index 3b57a1aafb..0000000000
--- a/tcg/aarch64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Define target-specific register size
- * Copyright (c) 2023 Linaro
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#define TCG_TARGET_REG_BITS  64
-
-#endif
diff --git a/tcg/loongarch64/tcg-target-reg-bits.h b/tcg/loongarch64/tcg-target-reg-bits.h
deleted file mode 100644
index 51373ad70a..0000000000
--- a/tcg/loongarch64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/*
- * Loongson removed the (incomplete) 32-bit support from kernel and toolchain
- * for the initial upstreaming of this architecture, so don't bother and just
- * support the LP64* ABI for now.
- */
-#if defined(__loongarch64)
-# define TCG_TARGET_REG_BITS 64
-#else
-# error unsupported LoongArch register size
-#endif
-
-#endif
diff --git a/tcg/mips64/tcg-target-reg-bits.h b/tcg/mips64/tcg-target-reg-bits.h
deleted file mode 100644
index ee346a3f25..0000000000
--- a/tcg/mips64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#if !defined(_MIPS_SIM) || _MIPS_SIM != _ABI64
-# error "Unknown ABI"
-#endif
-
-#define TCG_TARGET_REG_BITS 64
-
-#endif
diff --git a/tcg/riscv64/tcg-target-reg-bits.h b/tcg/riscv64/tcg-target-reg-bits.h
deleted file mode 100644
index 761ca0d774..0000000000
--- a/tcg/riscv64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2018 SiFive, Inc
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/*
- * We don't support oversize guests.
- * Since we will only build tcg once, this in turn requires a 64-bit host.
- */
-#if __riscv_xlen != 64
-#error "unsupported code generation mode"
-#endif
-#define TCG_TARGET_REG_BITS 64
-
-#endif
diff --git a/tcg/s390x/tcg-target-reg-bits.h b/tcg/s390x/tcg-target-reg-bits.h
deleted file mode 100644
index b01414e09d..0000000000
--- a/tcg/s390x/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2009 Ulrich Hecht <uli@suse.de>
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-/* We only support generating code for 64-bit mode.  */
-#if UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error "unsupported code generation mode"
-#endif
-
-#endif
diff --git a/tcg/sparc64/tcg-target-reg-bits.h b/tcg/sparc64/tcg-target-reg-bits.h
deleted file mode 100644
index 34a6711013..0000000000
--- a/tcg/sparc64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2023 Linaro
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#define TCG_TARGET_REG_BITS  64
-
-#endif
diff --git a/tcg/tci/tcg-target-reg-bits.h b/tcg/tci/tcg-target-reg-bits.h
deleted file mode 100644
index dcb1a203f8..0000000000
--- a/tcg/tci/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2009, 2011 Stefan Weil
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#if UINTPTR_MAX == UINT32_MAX
-# define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error Unknown pointer size for tci target
-#endif
-
-#endif
diff --git a/tcg/x86_64/tcg-target-reg-bits.h b/tcg/x86_64/tcg-target-reg-bits.h
deleted file mode 100644
index fc3377e829..0000000000
--- a/tcg/x86_64/tcg-target-reg-bits.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define target-specific register size
- * Copyright (c) 2008 Fabrice Bellard
- */
-
-#ifndef TCG_TARGET_REG_BITS_H
-#define TCG_TARGET_REG_BITS_H
-
-#ifdef __x86_64__
-# define TCG_TARGET_REG_BITS  64
-#else
-# error
-#endif
-
-#endif
-- 
2.43.0


