Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F06AC5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFe-0001SV-R5; Wed, 19 Aug 2026 01:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3O8SEagcKCjIXOQYmZWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jackyli.bounces.google.com>)
 id 1wwQfx-0005zK-Ih
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:51 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3O8SEagcKCjIXOQYmZWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jackyli.bounces.google.com>)
 id 1wwQfv-0007Ks-LP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:49 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-84857446424so588677b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085883; x=1787690683; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=08nTZ8BlEZVF2fG/KvaQ5nP1tNkYkFgXiPifhkCCDBg=;
 b=p8HtCjK0+NcoDqzXHjps1fUQ/Z1vdcglmVYW6RaMwjuu69G6LBDFmJX6yCQXDgnRhu
 EIJ99kxR/54kGeNGQky0V0po2ibfo8ORcpfHLgfh89g2/BS8NvXekgS+ETELTZsxSnGG
 3KiPqL5HTfO+fgPAUc7Tj69GDOoLm+/2KlZfU5f6RFKrm6pPqhrserEQZgKLV9dc31Ub
 XpQCrYN28T5lec8J76adjcIyueDcgUkfwjFKHazK2X1EbPqjqLVljxl8ukSEl4TsAqG0
 UzLBoF6UxATQXSZcRxgJTEgV6Go8czQiH7fYVdVbjSF6yMal5JobN4a9yHIzSCyZbfta
 0Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085883; x=1787690683;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=08nTZ8BlEZVF2fG/KvaQ5nP1tNkYkFgXiPifhkCCDBg=;
 b=fiQ/o7FSyVMgjKncHGD0lBK91/IW1cpAaP08ocQBWiQexTdjjpXNOv96Drazjl+NZv
 yc9faD+OWtGr2/ITJYLeaA0qJqTyyD9ej2IlRdELBvJlan0xnoKEa4bRsNHRL579+2bS
 7S1TV6iZc28jkNWyRlmHfbbwQB3nkjU/XJv2VBUmtJ3as39ph2tAuXk8dFZavg+Yexl5
 I+F7cnqc8NgtM0zkATlO0xgDuYUnQS2mE+HAAFA0jhUcOE3xLkb9WTpurJ6KPCtK1Liy
 VDdDl978CSdsJi+w55UgB+iRFbPalhhVvxjEXwcOubr6tXTCxfZLA/Foc6BgHxFLUYBF
 pgRw==
X-Gm-Message-State: AOJu0Yx0Np5++IjXJAAqrqLCNjILKaiKBqUq3kN0YwNMUI6xUCG2mnlJ
 tZr5shLIXjvYwV67go7+wlvFGOasEki7YXVQYBp8QZ9c/uWkYEodVrBi1DGhIMUlnifD1eW6o3/
 P/QWTN7BSr5BRVUvRy7L26msZ9mM1b4c7eCeCaYqWKMcSeuu4IydILK+PLczdMQB4QAHLCRRJQQ
 kPG4NRLgmZrL/UFXW1KuGrOqg7xvjy8Hh1m+m1DEU=
X-Received: from pfnv20.prod.google.com ([2002:aa7:8514:0:b0:84b:57b7:60c5])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4094:b0:848:4859:a45
 with SMTP id d2e1a72fcca58-851cd954427mr1821986b3a.2.1787085883244; Tue, 18
 Aug 2026 13:44:43 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:15 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-1-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 1/6] x86: Introduce basic PKRU hardware wrappers
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3O8SEagcKCjIXOQYmZWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jackyli.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:07 -0400
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

Introduce basic hardware instruction wrappers and helper functions for
interacting with x86 Protection Keys for Userspace (PKRU / MPK) in QEMU.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 MAINTAINERS |  1 +
 util/pkey.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..5a31c45963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -156,6 +156,7 @@ F: target/i386/meson.build
 F: tools/i386/
 F: tests/functional/i386/
 F: tests/functional/x86_64/
+F: util/pkey.c
 
 X86 VM file descriptor change on reset test
 M: Ani Sinha <anisinha@redhat.com>
diff --git a/util/pkey.c b/util/pkey.c
new file mode 100644
index 0000000000..4f14a72151
--- /dev/null
+++ b/util/pkey.c
@@ -0,0 +1,96 @@
+/*
+ * QEMU guest memory protection key helpers
+ *
+ * Copyright (c) 2026 Google LLC
+ *
+ * Author:
+ *  Jacky Li <jackyli@google.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/cpu-common.h"
+#include "qemu/error-report.h"
+
+#if defined(HOST_X86_64) && defined(CONFIG_LINUX)
+#include <asm/unistd.h>
+#include <cpuid.h>
+#include <immintrin.h>
+#include <linux/kvm.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+
+#include "qemu/atomic.h"
+
+#ifndef PR_SET_SPECULATION_CTRL
+#define PR_SET_SPECULATION_CTRL 53
+#endif
+#ifndef PR_SPEC_INDIRECT_BRANCH
+#define PR_SPEC_INDIRECT_BRANCH 1
+#endif
+#ifndef PR_SPEC_DISABLE
+#define PR_SPEC_DISABLE (1UL << 2)
+#endif
+
+#ifndef PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS 0x1
+#endif
+
+/* Each protection key occupies exactly 2 bits in the PKRU register. */
+#define BITS_PER_KEY 2
+/* The mask used to extract/write the 2-bit permission flags. */
+#define KEY_MASK 3U
+/* Max protection keys supported on x86_64 */
+#define KEY_COUNT 16
+
+static inline __attribute__((target("pku"), always_inline))
+uint32_t rdpkru(void)
+{
+    return _rdpkru_u32();
+}
+
+static inline __attribute__((target("pku"), always_inline)) void wrpkru(
+        uint32_t pkru)
+{
+    _wrpkru(pkru);
+}
+
+static inline __attribute__((target("pku"), always_inline)) int inline_pkey_get(
+        int pkey)
+{
+    uint32_t pkru = rdpkru();
+    return (pkru >> (pkey * BITS_PER_KEY)) & KEY_MASK;
+}
+
+static inline __attribute__((target("pku"), always_inline)) void
+inline_pkey_set(int pkey, unsigned int access_rights)
+{
+    uint32_t pkru = rdpkru();
+    pkru &= ~(KEY_MASK << (pkey * BITS_PER_KEY));
+    pkru |= ((access_rights & KEY_MASK) << (pkey * BITS_PER_KEY));
+    wrpkru(pkru);
+}
+
+static inline __attribute__((always_inline)) intptr_t local_syscall3(
+        intptr_t num, intptr_t arg1, intptr_t arg2, intptr_t arg3)
+{
+    intptr_t ret = num;
+    asm volatile("syscall\n"
+               : "+a"(ret)
+               : "D"(arg1), "S"(arg2), "d"(arg3)
+               : "rcx", "r11", "memory");
+    return ret;
+}
+
+#else
+/* Dummy implementations for all other configurations (non-x86_64 Linux, */
+/* Windows, macOS, etc.) */
+#if defined(CONFIG_LINUX)
+#include <linux/kvm.h>
+#include <sys/ioctl.h>
+#endif
+#endif

-- 
2.55.0.737.g08866a6d13-goog


