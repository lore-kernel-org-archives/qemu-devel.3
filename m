Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049FAC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOwB-0000fO-UG; Fri, 25 Jul 2025 16:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrP-0005sM-9k
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrN-0000pa-Cy
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2500443b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474660; x=1754079460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FD4Gd1pna1IUWe5RbcA+2/xdxsAuojInLMOC0axkExY=;
 b=UJoHjZPAvCnPiq+K/5hAc3Nmqct8XI9Cygcl8nVEY9BjQjw1I7OhSfKkGXc1vp+x7u
 h1uFORQMLjtDvzUt7bxJeDXmulQVmVOtFXnHAV8tC/3qw63fGgmD2lxh2sqhl3uFJUz9
 krNgtCKAawRCZBG1IzgQRDB0P7iZjz8SkFR7hwjXF3CpK4rwYFUoVCMkNFWKaTW9YqTR
 x1PjjygENat2QXAJ8pTWaNzRROrJQ24WYhzg33MjnVqlKqlqNJKHk7DRCRWnTiAKiUnu
 Oia24I+0gSalhZ/L6tQoj076UyHPIXXnEd55AFLAhNe/mR6I3DJyT3WB8fqWWsHEbm8S
 4eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474660; x=1754079460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD4Gd1pna1IUWe5RbcA+2/xdxsAuojInLMOC0axkExY=;
 b=VGETf0aao3AKYZI4F8G6iJhzZbTEy4PiSE/MyhSy2Opk4t+KG52Q0yS736RgnQSuaD
 PoST/L2o3MAT/OfBwgEqtNMLj8kCWw49ip4zZB2A/tbnGm084snO7zo0wfmvJrclcYWz
 p02jR8Df/6MS622Xwoa69O5IgkS4nh2L3aNvtJkRmXPEi/H6euIkkYVOIqcUpn6+ILLc
 kxlU3Tywie2mrjJM6Uj/CruEILxRBy3SpeDcFnvaUULwFcZZb76rwWwHTlh8fJJBE3X6
 UPsXVvY2+LEv7dfJU9AbTUNYUOW+8OTB/610pf2NU/K8WQw1WOQYosDt0RXLRsg+ZMUD
 HoUw==
X-Gm-Message-State: AOJu0YybjPrQQMYfnKYDHQSeVCkNEYNzZYpaBClfNZ5liVjcrzBqCNQd
 oDVOlUWdRAPDT4u9np/P6oJkxJHVU9mVo/Mr3i3wViK+UdeJ/VFQi3nveNQ5Y7q8v/ONfTv5sQ4
 PUto1
X-Gm-Gg: ASbGncuc+WVYbH56rOPCFnAoi2dZRQNOo/nco8H7dd3HGUl8C+a2nCMBYnT8yceloep
 2m6EANAf8ziAY5fvNXH85swkpbQzd99LC0F/7LRRqYWVpE1dsF9txI+vLp0bUttPAGfDy+Jbzww
 cN7yvOR9sjyLOywSVUjB0/9Io1bIUXeNHDM9lQM+ggoMjpv6YVQgQ7plqk+Fgv4j8xDo1aJLEZ0
 xuyC7Z0Nxh6lxFPXcLE3hCISp39F42BPq0j+vs4LgqQfM9JvW2wUQmJ2xNh896lc4IFP/pJKG/g
 cLVJOyMlrLOZvpROsLehIsif4nYh3OUvxiJ4H68UKVw8GZGftS1a8r8ogYjZH37jIG1V005Qsqd
 anyAYCEupG1ZlAgjislAGGA==
X-Google-Smtp-Source: AGHT+IGfOxZILnpU+tCZ2Rr1XNUJ9qeEDY/fUHRVSEZNZESPsVM38cQ+swdd6igJzV9d9X1jJ/A32g==
X-Received: by 2002:a05:6a00:a884:b0:746:2217:5863 with SMTP id
 d2e1a72fcca58-761ef312a8cmr9432005b3a.6.1753474659867; 
 Fri, 25 Jul 2025 13:17:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408c023absm383611b3a.38.2025.07.25.13.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:17:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/3] migration/vfio: compile only once
Date: Fri, 25 Jul 2025 13:17:29 -0700
Message-ID: <20250725201729.17100-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/vfio-stub.c | 16 ++++++++++++++++
 migration/vfio.c      | 14 --------------
 migration/meson.build |  6 +++---
 3 files changed, 19 insertions(+), 17 deletions(-)
 create mode 100644 migration/vfio-stub.c

diff --git a/migration/vfio-stub.c b/migration/vfio-stub.c
new file mode 100644
index 00000000000..f59ebe075dc
--- /dev/null
+++ b/migration/vfio-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU live migration - stubs for VFIO
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration.h"
+
+void migration_populate_vfio_info(MigrationInfo *info)
+{
+}
+
+void migration_reset_vfio_bytes_transferred(void)
+{
+}
diff --git a/migration/vfio.c b/migration/vfio.c
index 0b64e49ef06..af6ae2c1e19 100644
--- a/migration/vfio.c
+++ b/migration/vfio.c
@@ -8,13 +8,8 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-types-migration.h"
 #include "migration.h"
-#include CONFIG_DEVICES
-
-#ifdef CONFIG_VFIO
 #include "hw/vfio/vfio-migration.h"
-#endif
 
-#ifdef CONFIG_VFIO
 void migration_populate_vfio_info(MigrationInfo *info)
 {
     if (vfio_migration_active()) {
@@ -27,12 +22,3 @@ void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_migration_reset_bytes_transferred();
 }
-#else
-void migration_populate_vfio_info(MigrationInfo *info)
-{
-}
-
-void migration_reset_vfio_bytes_transferred(void)
-{
-}
-#endif
diff --git a/migration/meson.build b/migration/meson.build
index 45e9445f97d..0f71544a825 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -49,6 +49,6 @@ system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('vfio.c'))
+system_ss.add(when: 'CONFIG_VFIO',
+              if_true: files('vfio.c'),
+              if_false: files('vfio-stub.c'))
-- 
2.47.2


