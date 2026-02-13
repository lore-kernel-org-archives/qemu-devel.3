Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA77BEF99C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxtF-0007EZ-2a; Fri, 13 Feb 2026 13:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtD-0007ED-Fs
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:39 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtC-000639-2L
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1323653f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007256; x=1771612056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yI+Mv4GQHxCw9O8vk7u+Ssd80Cd3/VBhYa0FvH/zNGU=;
 b=DkVWbNoR2qdjQktYZ3+uNLZEES0fSgDldV0n1oyyGm6yi8Y+zgFghVCm6xe8u4P7pd
 h0EahOe0W6t3sMjgsc42LjadCFQpjdhZud3K05pm8XpIoXJ0JxENln7l3VnxVVO6quvg
 Foy8O+KvhhpPymGyIUq7pZdtPSZjBF/lrnbxcaWgh/XvRtyI9OZu+odHiPlSTd2jnJu2
 1WgtAMMK8ZOx9zBT/cEvi3RhoBXtE1FhOavIqliGWUIh90aeUU4n7xJeixPuklwUe6Ou
 NUS8I6VpgvdGR0HJssOoog7icu7+ic++4NTQwcyOYXswTgfQ9gGUoFDqGIIxURgdAW/A
 Z7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007256; x=1771612056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yI+Mv4GQHxCw9O8vk7u+Ssd80Cd3/VBhYa0FvH/zNGU=;
 b=Z3qcX4ThauLhDf1rlX+xmcm5M2tsQ4f5zxd1i4CwyKhGhc5ieeH+DTs2dxJHo9RAK6
 ZFW94iTVV9FsQYOoFCYlA9S8Kjqq2YGQ8zz9HIZQ8nrWj+GiX6nCFSeA+d3gBp7AZtQV
 ZjOMMNEjc+40rR/bFnasUmQUCV8OI2k3Ev7yJMq+Fpeu+1vWEZtusHoV2z0w2mwoBIwc
 kW3ULGYXcW2wagd5ztUtgZRcLBgwC3LJB6GCXxmwju+LallKJ8ecNV56ZpCce+g/I51I
 e0DjWWxKmnHdf89i6R4G0W+KUr5gCzW1lkNYjhunvZT9tUTcapPtfCdt5S1EI/KfsloE
 3BlA==
X-Gm-Message-State: AOJu0YwNS7KLe1vXYC5ebYwdWCLZKFxQ/mBdBcoTr7o4PA6qKnd7dDaV
 zc0pBkDhH+CHD6u/8EdPBFNmwFoF0Sj2w6gUKIbWuWQoiVrfi71KE5RuB/8RKo0B/daujwJZHYf
 4laltVzc=
X-Gm-Gg: AZuq6aKSTLsKUnG4OXxlLs+rLKzxNZknIVpCgvd9RLpFq6ROZXFzRJqYrft4OlP8akf
 Mn9TY0P59/OaVuTUSO13s9TJBYcVurkqjhLmAEmhRYJEuuya5XFp9XZTcNx4BxxxtyWcpdJCRw+
 jkQ7qLpwaOpdlT4NPYnI1QzRtDrPmywpm95J/j8uG01NT5xM4DLuTSq1AR++4ywVXDRxVYu7d+G
 2Sy1hBAXywmqpF2+EYZ/dPhRHId+OMd8pxBpZbvYDaYobV/vGt94QZQflULjDx5WpSY5IxGko3M
 gL3Hl4NVpr2Pn37UntPKwGXz0uz2wQ0PIPdhkhtw10rNeEKI5cCbqgcHd60ro+t+T+vPxJBPzQ0
 VcqQwMyoxIftZ0+M2YffHw9JNqLNBEmBEhdbPql1Au6vXsiB2edWlEh3O9VXS8mcmJ9C+vZvF8X
 rfeNN3/goHDguURX08ZDFJitcOgkoQPQDgyfBhBmF7B4bkt+iRKGd2yTqxm8lmp871tdaDIaJG
X-Received: by 2002:a05:6000:2406:b0:435:b776:304c with SMTP id
 ffacd0b85a97d-4379db9349dmr763757f8f.30.1771007255943; 
 Fri, 13 Feb 2026 10:27:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abcda5sm8359465f8f.19.2026.02.13.10.27.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] page-vary: Use target_page_bits_vary in
 set_preferred_target_page_bits
Date: Fri, 13 Feb 2026 19:27:11 +0100
Message-ID: <20260213182713.44924-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
References: <20260213182713.44924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Rather checking whether the target uses variable page sizes
at runtime calling target_page_bits_vary().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 page-vary-target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/page-vary-target.c b/page-vary-target.c
index ab92da4539d..5fb79eb5752 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -20,6 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
@@ -46,11 +47,10 @@ int migration_legacy_page_bits(void)
 bool set_preferred_target_page_bits(int bits)
 {
     assert(bits >= TARGET_PAGE_BITS_MIN);
-#ifdef TARGET_PAGE_BITS_VARY
-    return set_preferred_target_page_bits_common(bits);
-#else
+    if (target_page_bits_vary()) {
+        return set_preferred_target_page_bits_common(bits);
+    }
     return true;
-#endif
 }
 
 void finalize_target_page_bits(void)
-- 
2.52.0


