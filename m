Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA8C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFx8-0002v7-Sy; Fri, 28 Mar 2025 16:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx1-0002ta-8r
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:12 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwz-0007om-7c
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3f6a92f2328so1343243b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192308; x=1743797108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Musv96uqDqGBH3VebH5aXYMcN88bZT/SnScT9B79DM=;
 b=Z3c1EtrysxkK8kGjNuI6g2+Ip5MUMZAVEv9sM0WhLHqixvk7C7afL2mPS8FwUDJz+S
 V1Tw5WzPrMNDwkdPWlY5u0DF3fxbuemaQ+AUd7PBohccGqAV+7ZTyCwve5PQCLjtpB36
 t/h9udWLRSQTs3AbgGEkHGTgjYU3xv/pBdtBGnOTi0h9//zEejXa+A5QBwR/WNsz7t6T
 PmsuC5wFJwJ0BcO811TpDwb4oMrhHBrRzAyvLt1KpmXDR9jJJxIDDqy7aZ644QLBol58
 lL8y+U1fCPjAcXFM5agLkzW+kC4A2fJKsvQFmRVTyvoCoLCB3R2mV4vcUcyIdrVmASM7
 WLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192308; x=1743797108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Musv96uqDqGBH3VebH5aXYMcN88bZT/SnScT9B79DM=;
 b=DftZ9X3d95ZRQp6jZl5f++rg+m18fnyqSbpinBqSHE1zqeJAJwTuRGzogdqFeDE6EY
 6Wj0WG5TTVp0rGc1uUJbsoOQ6qVDT5hgRl9e+Dz5Yd4bsHT8GaJcUALDt0NkOPQyy9VE
 0EqEZb8pmT8eipz2TmPKvjF+jh+RoZMUeI4rz4f/582B/6b/Cx2DAs/j+nG/+ZV/E6+7
 f5fafjcDSFh1OmkhnMcoOwVt840GdsMOBJ9oMHfiqv/mZQmC23NPuPMHOFFou3qgrlIV
 KbkO7T9rsaO4WZr3M7DZt6YBwsiKj30lDIq3U1xf0V4HZv2EF5mVGlzyAcf9akpkCu2n
 erDg==
X-Gm-Message-State: AOJu0YxHq/BXD5/EFkTU+t6gkCOy2nOaI/sXxO5B4pOPRSYb8YkTpsTz
 uhU02at2iSAdr8ga6IV3kg1r5vIXxYyWQVC/mOlWsSV4+zvH/MVxrmqC9Y8BrO6QehTOGxGxRM1
 K
X-Gm-Gg: ASbGncu90CKJH5lIFhwOyI8sHwPQA+aTK0s/JytMO+axJSvi6tfHfCGVK6fjPtHAd63
 lRAGXxr/ly6ug+GnTGyfU5iPjeiaeVRME6TQn/wMkNYqiNeMgTAREB27VrkBSGH4qCalC6SAAln
 gxCMAJeugg+P6P+7jARvVZXzTIVQukisLkBWIxS+BAmAB2Advh8chrwj5B/OUC4dOc8/UwkaCj+
 lNqhP15IT7RSalmKAkHHi53eq/qBkhhNEAwYECarv7QYzjoVworAg8rYc3vCKHE6S6BSp3D9DSy
 WOnCQ1vEwi2ZCr4rHOJuAOrohff8FbK8gOoobUbwQw8pumZQHkxGx+rApLx/W1g+es6BVelDbqL
 /gKxQwfAwf/4=
X-Google-Smtp-Source: AGHT+IH54HqArmbarM9uoxXC1Y6I8bgouOcwvzNXNd9c1G+dMUBRy/g4Bkb5af/T+ZUxBg5EWhs9LQ==
X-Received: by 2002:a05:6808:2388:b0:3f7:5223:84c7 with SMTP id
 5614622812f47-3ff0ed043ffmr496221b6e.19.1743192307794; 
 Fri, 28 Mar 2025 13:05:07 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 7/9] include/exec: Redefine tlb-flags with absolute values
Date: Fri, 28 Mar 2025 15:04:57 -0500
Message-ID: <20250328200459.483089-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Don't base the values on TARGET_PAGE_BITS_MIN, but do verify
that TLB_FLAGS_MASK does not overlap minimum page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 68 +++++++++++++++++++---------------------
 accel/tcg/cputlb.c       |  2 ++
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 54a6bae768..357e79095c 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -19,54 +19,29 @@
 #ifndef TLB_FLAGS_H
 #define TLB_FLAGS_H
 
-#include "exec/cpu-defs.h"
+/*
+ * Flags returned for lookup of a TLB virtual address.
+ */
 
 #ifdef CONFIG_USER_ONLY
 
 /*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
+ * Allow some level of source compatibility with softmmu.
+ * Invalid is set when the page does not have requested permissions.
+ * MMIO is set when we want the target helper to use the functional
+ * interface for load/store so that plugins see the access.
  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
-#define TLB_WATCHPOINT      0
+#define TLB_INVALID_MASK     (1 << 0)
+#define TLB_MMIO             (1 << 1)
+#define TLB_WATCHPOINT       0
 
 #else
 
-/*
- * Flags stored in the low bits of the TLB virtual address.
- * These are defined so that fast path ram access is all zeros.
- * The flags all must be between TARGET_PAGE_BITS and
- * maximum address alignment bit.
- *
- * Use TARGET_PAGE_BITS_MIN so that these bits are constant
- * when TARGET_PAGE_BITS_VARY is in effect.
- *
- * The count, if not the placement of these bits is known
- * to tcg/tcg-op-ldst.c, check_max_alignment().
- */
-/* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-/*
- * Set if TLB entry references a clean RAM page.  The iotlb entry will
- * contain the page physical address.
- */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
-
-/*
- * Use this mask to check interception with an alignment mask
- * in a TCG backend.
- */
-#define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
-
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
  * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
  */
+
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP            (1 << 0)
 /* Set if TLB entry contains a watchpoint.  */
@@ -82,6 +57,27 @@
     (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
      TLB_DISCARD_WRITE | TLB_MMIO)
 
+/*
+ * Flags stored in CPUTLBEntry.addr_idx[x].
+ * These must be above the largest alignment (64 bytes),
+ * and below the smallest page size (1024 bytes).
+ * This leaves bits [9:6] available for use.
+ */
+
+/* Zero if TLB entry is valid.  */
+#define TLB_INVALID_MASK     (1 << 6)
+/* Set if TLB entry references a clean RAM page.  */
+#define TLB_NOTDIRTY         (1 << 7)
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW       (1 << 8)
+
+/*
+ * Use this mask to check interception with an alignment mask
+ * in a TCG backend.
+ */
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
+
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a717f357d5..39314e86f3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -49,6 +49,8 @@
 #endif
 #include "tcg/tcg-ldst.h"
 
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
+
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
 /* #define DEBUG_TLB_LOG */
-- 
2.43.0


