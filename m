Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C875C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPw-0008Ci-GE; Tue, 22 Apr 2025 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOx-0005AK-Cy
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOv-00073w-GL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so60089515ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350524; x=1745955324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggbOR76BAcyXgvavB4mZvfqZnt/5CtPguoo3NLh6PJU=;
 b=u8hmPKYT7fvzpSHlZTbaVudiOODJC42ahyABcxxpK0rq/oI5nlqopFAaHbofMNoYlb
 LRhZr0jtRd5y9LF6/bTP8ioGxNneB3NXwV3VedpHUufATYHGqz4WLSOU14vV0sKzlcUl
 oAliFNz2tG93Cqz4l2+Z6oQQZ7Z0w8yO6Yvd1BZqfrf5e/mt/omrR+Pj1m7bmZlF2TEb
 bXgWyPp8zai08POShSZuFHWqQ4MyJiDX6I4lykslSou+keGkAKcEOHAqKEK/RxTzijUH
 hpGJABdiLNVJx5obEnnZSV5WLDe84cawha+uXF7b6x/ula3PnKQh4Dci2JWOMiIZ15Dm
 7ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350524; x=1745955324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggbOR76BAcyXgvavB4mZvfqZnt/5CtPguoo3NLh6PJU=;
 b=MFP39QIocS3r8jLPtrPTy5OUM83jhAm0f3QAeQjLIQA/Fwo44wBdvtJQWKVinskG0K
 LGiMI3twC+rk9RuZ2NvBt4nhH3PgC1q9qXU8p8M2UN48/bPzBGwGvec9j1Q9XWZJKEBR
 UNM7GQllT3xbRFdN3XVo2g4sMA0bfhcwALzrMOKmnb3MZ2PXwLd0MjcoEzJPzAcEnZCW
 FILX4o3GkjDTY2zBKxQudk+Xg3C7GcwIxdYT0mByQW8lUX825443Eq+9sXO5vOKHuwU7
 AvxQyHrjmI0nSPk08u2IgaqzQToCoKApZUBQ0qgb6Iz9kZocR3RklqWEXf9/dixaw4ze
 62dw==
X-Gm-Message-State: AOJu0YzV55uAzZB6XAA8qtEBLpDoqm1Cb0MBxSwfzRQ9J8X+q2sONAxC
 OsfELt/rOImbFsF2+Y9yd8Ungh5M+UxRFHICU8hiOuwelr6tTod/mOHojPNUvvndZL224+4yhga
 f
X-Gm-Gg: ASbGncs6l6gW0P1+a7TnclUbAJ81y/XVBX19hYzSh3g3bpFAsJk5a73lE9Au7JC5Qlg
 7NgLZDk/Rv51+As94PaBbK1wquqcrHuTF1+i7zs59TFH2LpZiS6y+Rv9dTNyjdAA/8d27d7BkUV
 D8r8JmAbuHHK1zpgXULrBjHXgN2TGRk3gBv2c8xfRnjOICGoXVpPy9A2edsAdPQviWz46VDOCU+
 WSr7o609ae/NzPIHo0iQ/wo/iHZQor5RHIpzhm6Zo5LRv/rh99ozJew6e1vtaGsUGLCU8OYbuxW
 j8hY1TkOpHCGPWepuQPdcvs4myMl9PQy3/xhZH8OgGnApL5zKINY+8vinWAbDI9XQe5LZTr2OcY
 =
X-Google-Smtp-Source: AGHT+IHQ5G/Uz3gsObG6PveHqWI147CwQFLiTqGfqBTYuOHqLAAHEQ4et/oHp3TnjcFHck56UV4HUw==
X-Received: by 2002:a17:903:40cc:b0:223:39ae:a98 with SMTP id
 d9443c01a7336-22c53581510mr278314625ad.22.1745350524180; 
 Tue, 22 Apr 2025 12:35:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 097/147] accel/tcg: Split out tlb-bounds.h
Date: Tue, 22 Apr 2025 12:27:26 -0700
Message-ID: <20250422192819.302784-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The CPU_TLB_DYN_{MIN,MAX}_BITS definitions are not required
outside of cputlb.c and translate-all.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h   | 27 ---------------------------
 accel/tcg/tlb-bounds.h    | 32 ++++++++++++++++++++++++++++++++
 accel/tcg/cputlb.c        |  1 +
 accel/tcg/translate-all.c |  1 +
 4 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 accel/tcg/tlb-bounds.h

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index f9a06bcbab..08538e2896 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -22,33 +22,6 @@
  */
 #define GETPC_ADJ   2
 
-#ifdef CONFIG_SOFTMMU
-
-#define CPU_TLB_DYN_MIN_BITS 6
-#define CPU_TLB_DYN_DEFAULT_BITS 8
-
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
-#endif /* CONFIG_SOFTMMU */
-
 void tb_lock_page0(tb_page_addr_t);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/accel/tcg/tlb-bounds.h b/accel/tcg/tlb-bounds.h
new file mode 100644
index 0000000000..efd34d4793
--- /dev/null
+++ b/accel/tcg/tlb-bounds.h
@@ -0,0 +1,32 @@
+/*
+ * softmmu size bounds
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_TLB_BOUNDS_H
+#define ACCEL_TCG_TLB_BOUNDS_H
+
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  ifdef TARGET_PAGE_BITS_VARY
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  else
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  endif
+# endif
+
+#endif /* ACCEL_TCG_TLB_BOUNDS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 28c47d4872..a717f357d5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "tb-hash.h"
 #include "tb-internal.h"
+#include "tlb-bounds.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb161ae61a..87fb6c51d3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -47,6 +47,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "tb-internal.h"
+#include "tlb-bounds.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
 #include "qemu/bitmap.h"
-- 
2.43.0


