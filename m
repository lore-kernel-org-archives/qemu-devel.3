Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E13FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCa-0008Bh-Ir; Wed, 25 Feb 2026 18:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCV-0008Ap-3M
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCT-0004O9-AM
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43991064db8so234796f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061707; x=1772666507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y3Jc9cBiP93i40JuMbC0QlECSRh9zM7TqGGi/psNBgc=;
 b=VkIIo4TdkjDgPjNqATWHBxBTfwefb9xj4jeauYGyqAZrIhgRITtwHYJPxCv9OONhSH
 FuE+Cql7NALj6ezvfkDQiRYJzQWRPMprSSc02lxCV9gliR2cR7tQcml999hsX9yilsJt
 FPEStUBs6RPSKNUrY3Io07l3Dpq8dGJEzBEbkXSbwzml43Rj7nAiWg35dhJpWzfThqFC
 UoH6A34DmGT90IfB0GBYw694xl302xQrAe0ApwmBiSCDc0rz5979QBNA6+4TMQGRGoJo
 Cwrf7Q9UsyuAU5nbbmrBXFai0W4/LGMf0y0bWlhgaM3XE2XKsPEHNodS2WA9ICn8Vd82
 qCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061707; x=1772666507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y3Jc9cBiP93i40JuMbC0QlECSRh9zM7TqGGi/psNBgc=;
 b=wfILAobBEJgfT0xbMi2C6ZDocF7vZl78WDUAhZqMnVzQQbBTLMEGY95FTwKjM0gML/
 fu3uYv+dOAS6u4yqFkQpNfdoiJLhPCAtd1TSs0DZu2ZtDRqcpI325C/zFX/1Z1fciqVU
 WIHwPu1iCedXApzCTk0rTaZNbneZkDP3C7DSI48S59OYEnNO/QXOgVb1vQu2XNP4opJI
 eQyCwOcta8yEU2UEIrR5OSo97xsWhPjv7CyJH5T4H4cyJ8+GDYAu0GwYac7E0XW2BzCg
 VqVrEV6h0rumCGFuMXLv0HP/PdCqduRMgN1W9psyRLon6ocxDwcuuAQXg6YyXILWSknG
 dFZg==
X-Gm-Message-State: AOJu0YxLy2z32C4AyEDh6AN5uvFDSRKoNQIfL8iMxYcz8Ol6yaaN47Hk
 2UI4Nc6RpFKWqBBAXBKzpcooe6WoAq+5uu5X0QQw6Z+D5LLQcd2onEpBLWniXu/gySafAOxzziR
 mbO8JXqE=
X-Gm-Gg: ATEYQzyPpTc0B43T4UIxiD6PrTuPdTgyg7+sjVlJxn3LMQYzq9d+aNIn+GvH99qPmES
 8xwA09ETOulzDdzXSNfMd46SUS2UCFugvxW1TysRSwCJOU6o6AijLkxU4K+pDPoud7oF7afBr4c
 /xa9X0GPJE10FxCjcRE/WGxo4yKsuCKiodknssYqFBLHbjsv/iqIig8lSeXkKRfV8LUAwp1YBiu
 fZN9A/80Fu0Slt6puO4x7tJ5cEe9Ukku634s4zFm8JThKr1v7zvoPV4Ho4mMbImVkp7v05HXGMV
 7xAzfvLKEcvHXSbCFj0WUM4UX0DcAL624ftaqIWyUGXi9k+NGcq+XuqIg8DNp7rtfXYzzOIjdl5
 jzlY5fO+iCzhNwqya96VkQ2aL3FxwSj7zOptImz69PHTUblmNWYcusHtThhi0n1bQdBcW6WqLCN
 8l882p0+b8Tee7C4tFCThN+WnS/SqVNOtSyO0k100z/6ARhTykwMoP8u0Q5uZEMJo923ZVmiMy
X-Received: by 2002:a05:600c:8b02:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-483a95a86eamr310064855e9.5.1772061707528; 
 Wed, 25 Feb 2026 15:21:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm98680445e9.7.2026.02.25.15.21.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/70] target-info: Move TARGET_PAGE_BITS sanity check
Date: Thu, 26 Feb 2026 00:14:07 +0100
Message-ID: <20260225231411.96482-68-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the check from page-vary-target.c to target-info-stub.c,
in the process of removing page-vary-target.c entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260217095106.598486-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 page-vary-target.c | 4 ----
 target-info-stub.c | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/page-vary-target.c b/page-vary-target.c
index ab92da4539d..7c0565dd8dc 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,10 +23,6 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
-#ifndef TARGET_PAGE_BITS_VARY
-QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
-#endif
-
 #ifndef CONFIG_USER_ONLY
 #include "exec/tlb-flags.h"
 
diff --git a/target-info-stub.c b/target-info-stub.c
index 896f16e582b..f5896a72621 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -11,11 +11,17 @@
 #include "qemu/target-info-impl.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
+#include "exec/page-vary.h"
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
+/* Validate target page size, if invariant. */
+#ifndef TARGET_PAGE_BITS_VARY
+QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
+#endif
+
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
-- 
2.52.0


