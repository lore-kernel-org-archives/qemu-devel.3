Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1442EF99C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxtA-0007Dc-Ke; Fri, 13 Feb 2026 13:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxt7-0007D4-A3
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxt5-00062c-5w
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so11232315e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007249; x=1771612049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRcTQI36rdFbgS0RaM9tbsJGf2KLXWBx5voTCVv7K6s=;
 b=fN6uYqHEXLWsguuplbm1YwYr7jiM6mnZWo1zzey4WS3E84oM3dxICbUvUnuGTDslxD
 MceZfDlKWm1fffyYcLl9WfapRw2aXi57bhzlRy72oXSWu/UV3MCLs6dS19Qs425D/xl3
 mAzCqY1SVZHSEAmn6pVXtc2jUBuGxAc/2Hc+Jj0ccV3ZLCheN1XmyOQGB3kkMY/Zy+uk
 ZQfXL7Wc2HHebRhgRRY6oZtXzFl5T3VBluvMyhHj9hIA94tQxP5L/3zT29ntSQcaoIke
 7fAKdnDrLAeqQWHzjFptTfQyRZsO2Maz5Gihci/O6XBkopGbFDQxLT9UnwR1sOrvGjuV
 vQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007249; x=1771612049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRcTQI36rdFbgS0RaM9tbsJGf2KLXWBx5voTCVv7K6s=;
 b=Y16XzmdOjszNm4kJUlQNErEzvOnFDgRvgajPV+IhQ78kJeAPeBkdQKXnsgCKDbPp5C
 Z6LK0FsEilxRM3VCUL9QY8ATZ6c/By1QQKqHFPCfmK4D7C/SJMyrSVGXU5ql9SD2BChO
 kXfrV+vNEpH/Gltm+CMtsqsq83gtgk9wNFdp6FUojH78zurNocRFoZpcR1Ego5uwl2nN
 agDzrUS7M21eyENYQz+3QKah8hERw1Qin/Y+3pm6ey/Vd/ZE10C7+lDGBxCrEMeV23K4
 B79FUXvz3kHCk6S4H8TN4zwE+8D/dDKr7xHElJWVm2riKNXiqIT9vpNk8myIdS0bAK7S
 LZoA==
X-Gm-Message-State: AOJu0YzRLVts8p+dm0MEyXF5EEZuQS2G5RlMpRxnW19OYGZht31RXazt
 qJGh3X/gjC4BpJK/o/WVsouGhmAwnZD8/coYB5owknf3VaVYMk9JOY2Xcy0X+sFKqQT4uRT/9B8
 svb6I01s=
X-Gm-Gg: AZuq6aKOJtcO3KQG1K5OTWy3Plwf35oUmTp1mLUk5clllLKVO/hQFrLoAH9tgvW/8r5
 hMfI8DpUGtUQjDlYkQiRo2721a5Od4BehfWkeZWf+3vjxkFZPg48CeRdzCS2CTcuzQaVj+vFZYI
 I+vQs4xj8QtwVjE/o9OO6bLF8/vlWJXcNb0pbeH8Swa5f6MyNzrekCOusmfvXGqobB90DgDNsu6
 ITh10QB8nBfPPHsQlMF2MatXX9Uhr6dU8EmduXG0TuPQ8ClIC1coljd8zD8aogpVqoNpTxLQKBm
 apaUzYSvxnhLrtq8YBezWpkUmiasMVL+RyWHauj9p/JL0kr14jUOqfdmWGrA9eKOyidzKhqZ6cq
 Loqefcpx9UbHjJ9jue2kc1FjxO/Kf7cwTKYHg2b7qZnLtb/3Y+ovwzq+zNdDi+V6rJ2Ae9fQfYk
 d+RpNTKHaai0FZnEA48IP8K6feQiB4Z4arZXbCaeASCGVAaXtGNcWjueNgbI0vVqHoPH3wbHyi
X-Received: by 2002:a05:6000:1a8f:b0:435:a9c9:159 with SMTP id
 ffacd0b85a97d-437978d11d0mr4962786f8f.18.1771007249114; 
 Fri, 13 Feb 2026 10:27:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm7698227f8f.23.2026.02.13.10.27.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] page-vary: Expose TARGET_PAGE_BITS_MIN definition
Date: Fri, 13 Feb 2026 19:27:10 +0100
Message-ID: <20260213182713.44924-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
References: <20260213182713.44924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

We'll use TARGET_PAGE_BITS_MIN in page-vary-common.c,
so expose it via "exec/page-vary.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/page-vary.h | 14 ++++++++++++++
 page-vary-target.c       | 15 ---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 101c25911c1..3c77689ca52 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -20,6 +20,20 @@
 #ifndef EXEC_PAGE_VARY_H
 #define EXEC_PAGE_VARY_H
 
+/*
+ * For system mode, the minimum comes from the number of bits
+ * required for maximum alignment (6) and the number of bits
+ * required for TLB_FLAGS_MASK (3).
+ *
+ * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
+ * page size to match the host page size.  Mostly, this reduces the
+ * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
+ * There is no true minimum required by the implementation, but keep the
+ * same minimum as for system mode for sanity.
+ * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
+ */
+#define TARGET_PAGE_BITS_MIN 9
+
 typedef struct {
     bool decided;
     int bits;
diff --git a/page-vary-target.c b/page-vary-target.c
index 49a32b4fe51..ab92da4539d 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,21 +23,6 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
-
-/*
- * For system mode, the minimum comes from the number of bits
- * required for maximum alignment (6) and the number of bits
- * required for TLB_FLAGS_MASK (3).
- *
- * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
- * page size to match the host page size.  Mostly, this reduces the
- * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
- * There is no true minimum required by the implementation, but keep the
- * same minimum as for system mode for sanity.
- * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
- */
-#define TARGET_PAGE_BITS_MIN 9
-
 #ifndef TARGET_PAGE_BITS_VARY
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
-- 
2.52.0


