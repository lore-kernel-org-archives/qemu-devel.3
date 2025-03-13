Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C85C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslcH-0005Ef-He; Thu, 13 Mar 2025 12:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslal-0003SB-0H
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslag-0005hQ-PT
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:30 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22334203781so44356645ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883965; x=1742488765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=sDXO1nePBqK0vwW5sYs5U6wDCVMt6g9o1VFYqCFjKZbV4xvCH2/7Mak5EDmmevsgS1
 YGXQJI67Tw/BjaP2rdI+hFCU/BtMD7coA7HmbVE/bC22W4SXE6RhdtFxBK01mxRuX2+k
 zxTGJIbQ/rEShRt/AjpercM86M3b+8PHnlrT8bEA8rCRDoNYg2e/HOgMe7j2sARTcDGe
 J5hHZt6TyncA6Yq2qnRH3jxGPBEr9SgFrsS4V/KT29i0sS4wnGFNeIfx1GOkln7f+3qR
 B07cDPfU8dBg74rXxaXgOfqWrRpMU7iI447cDHAZGfMhHG48/Sd31N44PjiueeYN6kfx
 MVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883965; x=1742488765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=Or7d+So2AlYT7iPFeg/GuVUf8ZCGELXokeBegEZrK0otydGNMVOFFt/dYE3A7cFuwY
 r9cf7igJ7eUMp00TUmY/Pui3AmLNIciXe/sdVssASiTBhRRLwlCb3Y6jbngvw9aPxwlP
 +tYeeneqXxr+NBU/W1XvR/HGFYzmFma/2g2mM9HnQkLj9UigQzDOZj7srA0Bryx4neOm
 btORzyDLyMJN4nyspVJWJ0HAidmSgL1aK2rk4Dg2NjeErZweULrzuoA1Ztj3VE/WWYIW
 AiO2FRhFVwZEILUgUDkAH1DS+4jNuVLVnBmYwRGKUXlxywpWdnl/jRuY2CamK3UnvA16
 WPJw==
X-Gm-Message-State: AOJu0YzFk+rJ47IeE47UDhCYvCvmLWr1g+37IN6/B6XtAnhY1+4Cw1+O
 DH6sGdBToa1qwH9vc8wd7WT+pgK1HqwAaMW/v3nVIkTPpx5AAf7I5Iii3XChmi9gs0te5yL/9pj
 WIm0=
X-Gm-Gg: ASbGnctouac1LXR0V99Qp3mpenTONEipzHFPKrLPa+ADIw5yNCK7X0bLi6WsVD6Hojw
 ewGz4BA4nsa4LjFmFHE8yu6elhRww+if1wZr4GrLuDqDhcVxDnUjY8+OiovJkq5c1+ruSYHNuAQ
 eUXhfrgCEUgSJYAQUDDBTTNrYCtfp3Y8EP2lbEZZXbr3JhOEzxEgYkGyxTGYRyPPhsqqXxKTDRj
 pp/+pIe8oSomP04iulk8eRZayOsXf30yfAMq7ovqpVrvIN1DsISRwXNuQYpIh6VjpUoo+J0xdr2
 bFpIcYWbKp250esjYBXiFec+3I79yuWPe/WHNDPrasmE
X-Google-Smtp-Source: AGHT+IFiKP7Cv0cYdqEMV+MhGWK6VMcS4hFI6ysthSkCfjorg7zJkJOo9IS+PhkZP2SVMZhjn6kprA==
X-Received: by 2002:a17:90b:3502:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30135f4d091mr4406058a91.12.1741883965232; 
 Thu, 13 Mar 2025 09:39:25 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 12/17] hw/xen: add stubs for various functions
Date: Thu, 13 Mar 2025 09:38:58 -0700
Message-Id: <20250313163903.1738581-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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


