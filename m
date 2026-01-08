Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F345BD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibs-0005LU-OF; Thu, 08 Jan 2026 00:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibq-0005KZ-7l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:58 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibo-0005Ny-9B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:57 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso1165366a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850255; x=1768455055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dhACpDk9o6KEnsF8TAiInCR2PjerLRJOGnsSv7vL7Qg=;
 b=J/nl6qP7Cihg+tPR9e7gBonq8fMQuoevOzKsZXkgKpZxZikYvmpVJ04ljzGjjTJppi
 +PW6p7LpBLMr87xvnrBafGrwWisHAaIdREYJPjqWaXF1kyq5xWrvYPYz+0qqdETgJ/Xp
 yr7mejaVCNybp7XGe5q+OTZ68+nmkcljiy4KBnH1gNcf6p1qLcHUQ8uwyRvAU2h5bhl+
 mb5AgVCAvyFIrUsolK5fcZLMbzKIKCGQIBrp/7A9/8BiIR7Eba8olLeuopTZhzcSquei
 h8O0dt6zbDAi7dc0UceiC6k9l/+yGxWqnaFpAbjse+0HEXDs6MNl6pp6sHbJbQu3K9Xo
 XyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850255; x=1768455055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dhACpDk9o6KEnsF8TAiInCR2PjerLRJOGnsSv7vL7Qg=;
 b=xTgkDWZAxlvGcFPMqiTSsTMeuU0HdhpUS85KzTnLMMSIodSxOIeC647wOUlM6G/X/Y
 j4xzh3+CdnrD/zlxR2Peua6/8eS8+QChrgF0liVQDg4lFbMyWFv9Ind7Az+ViZspucuf
 y2yTXnBcHhNVSe5WC+ZgH+REBCqngEj4Tp19NtGVBYCcvOMaAzLBatL6z8869tfxJiGo
 dTQvmNQpb1ZOXsGtpc7HhUir71mdWVJDp4UwRF8qA1aRPFRc/NCzJheyzIWUGGb9X3gF
 8VmFEJS2rXPjsSFO6Qzq0daSqXkJFTQ+117YoA/eMeRrpjZaE48W+ryFESZW2AJvVjDZ
 Cx0g==
X-Gm-Message-State: AOJu0YzhG9Se1XnlfQDOaJnCzaUGr5U18dLpG/8zXChqOHp+hJuTdSqg
 OE+4cI3I0jdQpUU0ihjzDrj4usigGaDfD4hR5xi5D9S8yUb/OY6FcBAJKKjWh03AdDAlPMw8CoE
 JaFTiCGo=
X-Gm-Gg: AY/fxX6CfnArq06qNos/BEiLxh7WQ3GLETDG+vKpjAXhQ2PsVSKshKSo/FZUqILfg5b
 vJrXET/86/x5OBaP3XYAAXvcQmtjjpOFkjsEJHPhLbf4npMf2kAxmfwvHcmY1m9OczcJ4dcX6mX
 3fo0abgvRQdpDpJx1vcSAZ4x6sRkdXBFm+DcDHCN2N+FZQXBCjNKopSXwiLjq1x5NjNy0c1Grsm
 G6Mycy66NUNOKEO/+L6pQbjQXazGAwHeCRcDVQmfvqVmbn8x0RmORxLwEyjWE9zeHv48jP/sCXs
 o8LJSFUBnK2SG+fW5bZfqUfVjoEr5CEBGr+IJmqRK22VKFNRcz2IIzSLDPydbRiHiW2IYAHv11r
 6FiMBGZTdtt7OEsNH3FhM3xFHSPmLpaqZxdKTmnptDcNjn0fCcg82r34dY+YTEI1mWQDsdfMJEY
 oGoqNr+IUChIRDJaqltA==
X-Google-Smtp-Source: AGHT+IHgD/gH7k0JBp8GxXsIwkFe0XY0fxBFODBu/2gcmiGifQ0a/GsUXkpXRfWdjl78oLYObQrwHQ==
X-Received: by 2002:a05:6a20:7d9a:b0:34f:68e9:da94 with SMTP id
 adf61e73a8af0-3898f897402mr4549909637.30.1767850254716; 
 Wed, 07 Jan 2026 21:30:54 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/50] tcg: Make TCG_TARGET_REG_BITS common
Date: Thu,  8 Jan 2026 16:29:44 +1100
Message-ID: <20260108053018.626690-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Since we only support 64-bit hosts, there's no real need
to parameterize TCG_TARGET_REG_BITS.  It seems worth holding
on to the identifier though, for documentation purposes.

Move one tcg/*/tcg-target-reg-bits.h to tcg/target-reg-bits.h
and remove the others.

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


