Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAC2C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqxo-0005X0-8c; Tue, 11 Mar 2025 00:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvd-0003Qb-5E
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvY-0006WL-30
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so8373666a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666150; x=1742270950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=g1IZNUjnq36g2EP+lzfCwYWVFUAy3fM0/Pvz3UtxxPlutccXo0EadWlw7L9rlno8g0
 4g7O6cYMje+k9dkI3rZZtcyL9h2ugaGC/wuDFGWI3u9fqN5O889nv7gQe3Nl9iOflL6M
 vQsg4uqP/QtGkHcjQKNCQu4glCKMgNdTn7+XTJpCaSgqJy2k9GYSvOGtw83IMBy/kCBd
 hB/zBMY8/UGXFDF+e3V6W7H4w1m+vDsjVuGQNwhSHRzd1kNQJBVm0SZ+amxuW8YVm0gY
 KMAe+PqVrB9olSJ4eiO5kK4+hJw9i3rv3jtGeHsg9xSDWWfi6zkNKa1xW5F9uMUGezVk
 aPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666150; x=1742270950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZcwoIie6BtZ5Bqo8BYW0CKBTK95znA0iA8YHmiy7v4=;
 b=vTOLY1D1wwx51uzTfNtJzi5h9wYyS79KbrlipSvaNxIY/07Fn9INhLsNlXCU3XVIAS
 dOpoG+V6rpif8TYQXlxQIMvV+SENBLJ4B3oAVV3+dH2nIpej76mf2AfKzN3BRAeuZBD3
 D7cVZ7H0wavKeWgU6VDcW+uk2UwwcZ02PIH3rVLrxst5F8FWV5VzATmfPMPGLqZ4t67R
 bbmCzC2LQxKZKKaLTudmWLfAHWj59aGJJDPzHZ+YUoIh836xE8R0sha8kKG029AvBwbs
 qGl05zVNPDP17sRG1GWH6UvafFlonyWMDT43exKlQwdw2I7p0NDdtSaoVQQE/ZBTaXNF
 kjGw==
X-Gm-Message-State: AOJu0YwrlzXehQGV+3iG4PgQ/siWM8ZSZfJ1+VxrvVPXIR8bvLy03GoE
 vOTbkHEAAqTF3S9WSj5Gp4cwDyCkPtRY5Wyal/V0i6NxDN0w/VeaXL0TR9b/sZirBNZgdR7Jiva
 tymE=
X-Gm-Gg: ASbGncvw5fUgZ4t42zJcui7JugB/BGo66zFZI9p5ih0aos/e5ix0ZyQY/I6vHMGIe33
 euOQzA41dyFFCCrgBFHR8K5l2RJv8B1XL6OLMnJuebgXXsslQsrQtoZrztiPaACAJHtnXnfswP+
 pgfHdueJF8l1W0MeiN7+vKg6zWPPMe5VMu3tbRJFR+w5DqXouZ9bRrL6CUDHAuZ1OcuQh5JATi6
 cjvCg5SyO6NcpYi5Rj8wzUk0Y9LVtxoo9DseyZA1E9wZZLDIrXzrs1HNiWC+9A3FbOmwXC66Zgv
 4bISmt6GJf27HEfbUod8ipLOgXs8tD9+ft5/RvptCWaA
X-Google-Smtp-Source: AGHT+IHJmCe2dJrkKZuUg8Hp5UUMBrSHtlgnmpF6Gn789stb7ihIio5wxKC4BVHFee5F9pMJvA7mBw==
X-Received: by 2002:a05:6a21:3941:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-1f544c7fc7fmr33091101637.36.1741666150581; 
 Mon, 10 Mar 2025 21:09:10 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/16] hw/xen: add stubs for various functions
Date: Mon, 10 Mar 2025 21:08:34 -0700
Message-Id: <20250311040838.3937136-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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


