Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B64DC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEwd-0001aj-7d; Wed, 30 Jul 2025 18:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvT-0007xS-RD
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:32 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvQ-0002IJ-Qx
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:31 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b3f741a77f7so237944a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913127; x=1754517927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWqG/ZCcf+A9z9lr74PPjPnFPBKLGhXlaBBrGS/ZEnE=;
 b=LzUTpOhr25saEJDQXAt2IExKwS+fn8FbEm7XbQ4l+3xx2pEN7ZT2LHVarzf5oT7JI0
 cELEwT3uQjp07ZK/A40/eUji0KXnUiHtXOZHJYQN80hnvCyZm7w9g+SJTEFzs33WNenb
 Sc711owlrfFGa93IBOOGSPI/26XNRp6aCKvIzMCGsZ5yp200qbBeYcQm+C6CQNYhDyv5
 I3FnkTQwohGufs+qQ79cB5bJLEfgh5gZHKpOJ1N4xqwVRHdsfHhsQnfz1rmo9QxdIH1V
 JkhsFEghXZfllMpUN9MxWi2yVmGolsF0gmhP4nKlBIdXts6cCOBmAc4/f4d6dKVaAmJs
 QKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913127; x=1754517927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWqG/ZCcf+A9z9lr74PPjPnFPBKLGhXlaBBrGS/ZEnE=;
 b=MspDOi6OK9e21y37gp/Jc2ZZhOi1qG2amA5OBld94BEXifTKRkmv9ltrebsgI+Uyk1
 L4Pl3RTOLh0cl9owdWmVxUtTL6ZNcSB5kE7mi6/jCMKHEfwdrjWHJwyt/9QgcjJT6AUW
 jmYtPz1dqZzu8wzmvwT4TfbWW6cD/X2DBa3bnBc+CXdbKfBWS6QWXLyt0lPZbX9XVPC3
 Rjg/H74IPOQ7pVhK8KorGEXT6AXrn7hGXdaYuz1gUPEXdEmQK9bJUzEFJaVJU+UoNYzY
 p1NsuOGjHMY6a2Y+k09/YHbaOq0iaHG+Dl8HsOZh2/audDF7ooPf8mkyc1PrHQisBQ/m
 lnvw==
X-Gm-Message-State: AOJu0Yydxb+foj61Jj9u4ztOQIbjkerONRmoM/x5wJl9Q0QfV166nZQ8
 gduIn56npK6EjUT9yZRR6Mw8KK8q7XVlRBwRzrvkEhq5Q/rIjwILUhUw+NBDqU9EOSvpXEpVR3C
 t5/WA
X-Gm-Gg: ASbGncuc5tdMvN5kOu1RexidnZMgsDDZvKx7kD6ltOlOnF3nnj0+Vc3hZGKfQ/X20YI
 imydxrjvzq/6BFDcJTUDWwcUrhokB2Az8BqWnPw46HzGseXkC17FOY8hDanX4rN0OrwvnxYjeSG
 bF7VHC4h/02XU80chCXur+b8wJJNv1SbeezFPSY3jaYe4/hBOJoDxZ2JHNODgattU7PpX4u+x4n
 mRG0pqK6Wq71I9l/HP991IPLOQ7ETOY2uoargCCkXj5a+bYkDn40lLJdDEPjlYBF0NEYrByl/bV
 kjS5N4u+WxZ/qPs3GIcghuqQ0ApvK9lahBJoJFvCeMeZxyQfoXh1OvCURWW9G1wF3qSD6Mpex7i
 j7KZzEOraO/2xd1GAWj1wiA==
X-Google-Smtp-Source: AGHT+IHFCbOYutiwPbJ/qhYuPA4tEA/EauJphSu2WmJPD+wVIvjyHTGTUXlu2WtN9DGyOUGnW3sWQw==
X-Received: by 2002:a17:903:32cb:b0:234:c549:da0e with SMTP id
 d9443c01a7336-24096b587cemr84370605ad.47.1753913127176; 
 Wed, 30 Jul 2025 15:05:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241afb7037asm1266325ad.0.2025.07.30.15.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:05:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/3] include/exec/target_page.h: move page-target.c to
 header
Date: Wed, 30 Jul 2025 15:05:18 -0700
Message-ID: <20250730220519.1140447-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                |  2 +-
 include/exec/target_page.h | 11 ++++++++++-
 page-target.c              | 21 ---------------------
 3 files changed, 11 insertions(+), 23 deletions(-)
 delete mode 100644 page-target.c

diff --git a/meson.build b/meson.build
index 218a9ad203e..f94209bb301 100644
--- a/meson.build
+++ b/meson.build
@@ -3897,7 +3897,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-target.c', 'page-vary-target.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 specific_ss.add(files('target-info-stub.c'))
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index ca0ebbc8bbd..813591c9b51 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -62,6 +62,15 @@ static inline int qemu_target_page_bits(void)
     return TARGET_PAGE_BITS;
 }
 
-size_t qemu_target_pages_to_MiB(size_t pages);
+/* Convert target pages to MiB (2**20). */
+static inline size_t qemu_target_pages_to_MiB(size_t pages)
+{
+    int page_bits = TARGET_PAGE_BITS;
+
+    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
+    g_assert(page_bits < 20);
+
+    return pages >> (20 - page_bits);
+}
 
 #endif
diff --git a/page-target.c b/page-target.c
deleted file mode 100644
index 8fcd5443b52..00000000000
--- a/page-target.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * QEMU page values getters (target independent)
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * SPDX-License-Identifier: LGPL-2.1-or-later
- */
-
-#include "qemu/osdep.h"
-#include "exec/target_page.h"
-
-/* Convert target pages to MiB (2**20). */
-size_t qemu_target_pages_to_MiB(size_t pages)
-{
-    int page_bits = TARGET_PAGE_BITS;
-
-    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
-    g_assert(page_bits < 20);
-
-    return pages >> (20 - page_bits);
-}
-- 
2.47.2


