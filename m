Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F8C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVG-00006F-5b; Fri, 26 Apr 2024 15:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVD-0008Pw-Ih
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:59 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVA-00047T-DA
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5176f217b7bso4410692e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160694; x=1714765494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9yWcGZAI9YJhaaCrPIJ5UzojqcAhJ+99W/2NEpvWPY=;
 b=XM+o+9A7QoMGYO40D2WHigONbruErFFVZnReSPbCXhvTq2HwoWTBYIcF1XsJdItm63
 OadKUZHyZEC8PBDRrtzh7ktB1mzhS4RDD/F5/MNvcp3vovpDgsjn9sGFbX2GXeoKM6fS
 y61uVykqw5y53dWFcnQgPwbZkmkZand+yyjpcFECxLzGzEPhBtsNdx/kKOvFhJwrBpq0
 sSFHY7gCSp0Kf2PG/ixBdW47103EubK/wOf+8nFFTRB0imtyInRiraGpF0NzKlcWvY3H
 1r5wgEPHbRuhozIG6QN+iS6Yubkx97Thk+sCT9da5PsW75WmIRqBsHdxhNpNiUhsp5Xd
 6tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160694; x=1714765494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9yWcGZAI9YJhaaCrPIJ5UzojqcAhJ+99W/2NEpvWPY=;
 b=dbC+m9MQKkNOU8H8I9Z28HtWEzCkGPAvOfxm7d/lrkQvtVlOidAv9u+u/wHUnGOVbS
 IR2Atqe6Xh0hqniPjPScMXS3nNJHMsfaPmQD8rYHodRhp1TIspIXpj+VddBTl+Y5jXo7
 1v9WkFmO2sfyD82gXw+R/ZcUrEhkiZiGlKuYz5vpuSsB/8GiXkgMsRqidUpKpbMOJt03
 1MlqFDgbtNzPeQdBN3z5SZM0mNpVW+JxND6HVu1qe/PffHcBTThQnKZ3nncnAd0YG5Wu
 TbuEm7/rjyAQnIhAJGyX3P6m704NKbirpeGXB81qd5VlsanDkWROaZsaaS2tivinNcSu
 6bNg==
X-Gm-Message-State: AOJu0Yz+DXdewB200u8B+qADAyLIzl/hKCnKcW2sO3Y6WmMaL8m6tHS/
 u7VZq1OnV0xsmmcLjtyljOhMIToKjGN3+XLMPeb/A3J46K5HvnelyUX1aGD5njmKomoYTybwvrH
 xaGo=
X-Google-Smtp-Source: AGHT+IEkPQs9duixVRBukgTwLqANKQo2EbNAR1DifxNFZ52yn88GjQTiys7n4Fdp+0p0CWUFSOf+EA==
X-Received: by 2002:a05:6512:ba7:b0:51a:fc86:fc6d with SMTP id
 b39-20020a0565120ba700b0051afc86fc6dmr3811665lfv.22.1714160692338; 
 Fri, 26 Apr 2024 12:44:52 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 jw17-20020a170906e95100b00a58df78ab27sm188914ejb.166.2024.04.26.12.44.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:44:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 29/38] exec: Declare abi_ptr type in its own 'abi_ptr.h' header
Date: Fri, 26 Apr 2024 21:41:49 +0200
Message-ID: <20240426194200.43723-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The abi_ptr type is declared in "exec/cpu_ldst.h" with all
the load/store helpers. Some source files requiring abi_ptr
type don't need the load/store helpers. In order to simplify,
create a new "exec/abi_ptr.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231212123401.37493-21-philmd@linaro.org>
---
 include/exec/abi_ptr.h    | 33 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h   | 17 +++--------------
 include/exec/exec-all.h   |  1 +
 include/exec/translator.h |  5 ++++-
 4 files changed, 41 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/abi_ptr.h

diff --git a/include/exec/abi_ptr.h b/include/exec/abi_ptr.h
new file mode 100644
index 0000000000..2aedcceb0c
--- /dev/null
+++ b/include/exec/abi_ptr.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU abi_ptr type definitions
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef EXEC_ABI_PTR_H
+#define EXEC_ABI_PTR_H
+
+#include "cpu-param.h"
+
+#if defined(CONFIG_USER_ONLY)
+/*
+ * sparc32plus has 64bit long but 32bit space address
+ * this can make bad result with g2h() and h2g()
+ */
+#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
+typedef uint32_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%x"
+#else
+typedef uint64_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%"PRIx64
+#endif
+
+#else /* !CONFIG_USER_ONLY */
+
+#include "exec/target_long.h"
+
+typedef target_ulong abi_ptr;
+#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 82690d3947..64e0319996 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -63,20 +63,11 @@
 #define CPU_LDST_H
 
 #include "exec/memopidx.h"
+#include "exec/abi_ptr.h"
 #include "qemu/int128.h"
 #include "cpu.h"
 
 #if defined(CONFIG_USER_ONLY)
-/* sparc32plus has 64bit long but 32bit space address
- * this can make bad result with g2h() and h2g()
- */
-#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
-typedef uint32_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%x"
-#else
-typedef uint64_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%"PRIx64
-#endif
 
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
@@ -120,10 +111,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     assert(h2g_valid(x)); \
     h2g_nocheck(x); \
 })
-#else
-typedef vaddr abi_ptr;
-#define TARGET_ABI_FMT_ptr VADDR_PRIx
-#endif
+
+#endif /* CONFIG_USER_ONLY */
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
 int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 9599e16a09..530d442112 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
+#include "exec/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 2c4fb818e7..6cd937ac5c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "exec/abi_ptr.h"
+#include "cpu.h"
 
 /**
  * gen_intermediate_code
-- 
2.41.0


