Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66FFC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lR-0003fb-H5; Tue, 11 Mar 2025 15:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kE-00011k-Pi
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kA-00008V-4f
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso3135395ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723104; x=1742327904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=sE3Sv2PmuDHH2NJUPQHB+DnObIB0L7z5fqcP4ko5dAS+3AvSH/mHBm0gWKOOmHz5VW
 cHQlTLbQMpq2zSSQS1ZOiKerjFllkI7a0zncwAmdTnL57U689B8E679W7I6Yt0//Wbfl
 yMyWG6Je0tzMCFIVIFffPEvuoL/tjla0QGmn8/mR/IOldQlBKHjzMLONc0T6IPwjkt1V
 0s8+ldtdA9kFpDIuJVWduBPrhcLbBN+5/WlTzwIc+dOHmcy3CNdce3mUp9ftkOFPNjXP
 EaNZjuizq+SQ59lqNU2dNP/Ej7rde5F12xIm8ApB02QUcqXDFiTONYNUJL48SW7jr5Id
 ja7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723104; x=1742327904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=MMZdZr02QvAZ4wkITA1+/Iz2JKm8OUocvRAOSY6vAg7wA76YOEci6S/lLvcLdWuX+q
 /+REnBi6TBq4mC4F89P6acd7nVDkb7PNeWjpy1tod9Lpc33MGvDNIz7YSlBPgypqRuL+
 JI5dNr9SCL1Cd5npZhvVn1KTGKy6Uyc9a8IbYZkAAcW89+VTAZCiyBMnh5fw8vlHnAge
 +RNWZ0woFlk2kaJI7aHUQeAWwK+KQ2zNknvr5Ewubsq6Z9UPMdD5HmMW/zGosG/6Ni0v
 kYPgXM/H/owHqbwrPeap4BYAn4UVtezaw8yGJIWLqexkPDeIwU8GkyCCquMORdQm37En
 P9Ig==
X-Gm-Message-State: AOJu0Yydh5CgaLeBfTiVjew+vh9fRTnxyoq96TkNw7vVIB7ZKrNEJLO3
 iQAjO9CCp9ryZ2Qe4SWSyjvAEt+wTYyiOEY+GEk2XhDHHnk6b9gMia0enIiqduVfhbnCGtC+nl8
 tntI=
X-Gm-Gg: ASbGncsOWLPydQ0aaR0s8/9ViwV8t3rzBoo/jtbJRu2xeG5/7F3sNYUIYkkPCHK/mkQ
 ZfXDibQtm2wS0prxGkvKyunwn5lEpZlqkX3L3ZpSlpHsYuygmjrvoYbBhdcwUX8HpS+RJyY5fAJ
 NK845Xn37cyFyCU4mvTdjLckLTX5enkzDrlgbFdXb914c87LrOFGsliZ4/T+GT1kvcIROWC8tfP
 wmRaP2znmXNspRx3fP1auY1GH1K0TfBKMehIzb5VA8rfZTHVy4mTP6kSBnz8wFq0JeO1qsKBOGf
 fkhCoHmnFtTUWDqlkPRKUf36P71VzYK05lhmxNILVC4H
X-Google-Smtp-Source: AGHT+IEToni6mHy+/TOd0EQfFDFUNLQyZb+aNmkKXcJNYvCuHB4nuxbuNFqkwEKNu7S4yPPDELKJzQ==
X-Received: by 2002:a17:902:eccd:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-22593dc5076mr68139055ad.16.1741723104414; 
 Tue, 11 Mar 2025 12:58:24 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/17] hw/xen: add stubs for various functions
Date: Tue, 11 Mar 2025 12:57:58 -0700
Message-Id: <20250311195803.4115788-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Those functions are used by system/physmem.c, and are called only if
xen is enabled (which happens only if CONFIG_XEN is not set).

So we can crash in case those are called.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/xen/xen_stubs.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/meson.build |  3 +++
 2 files changed, 59 insertions(+)
 create mode 100644 hw/xen/xen_stubs.c

diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
new file mode 100644
index 00000000000..19cee84bbb4
--- /dev/null
+++ b/hw/xen/xen_stubs.c
@@ -0,0 +1,56 @@
+/*
+ * Various stubs for xen functions
+ *
+ * Those functions are used only if xen_enabled(). This file is linked only if
+ * CONFIG_XEN is not set, so they should never be called.
+ *
+ * Copyright (c) 2025 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/xen.h"
+#include "system/xen-mapcache.h"
+
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    g_assert_not_reached();
+}
+
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    g_assert_not_reached();
+}
+
+void xen_invalidate_map_cache_entry(uint8_t *buffer)
+{
+    g_assert_not_reached();
+}
+
+void xen_invalidate_map_cache(void)
+{
+    g_assert_not_reached();
+}
+
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    g_assert_not_reached();
+}
+
+uint8_t *xen_map_cache(MemoryRegion *mr,
+                       hwaddr phys_addr,
+                       hwaddr size,
+                       ram_addr_t ram_addr_offset,
+                       uint8_t lock,
+                       bool dma,
+                       bool is_write)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index 4a486e36738..a1850e76988 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -9,6 +9,9 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
 
 system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-operations.c',
+),
+if_false: files(
+  'xen_stubs.c',
 ))
 
 xen_specific_ss = ss.source_set()
-- 
2.39.5


