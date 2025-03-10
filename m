Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A620C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVES-00036N-S2; Mon, 10 Mar 2025 00:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEL-0002qO-Sv
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEJ-0008GV-9V
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so30008625ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582745; x=1742187545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mz3bAPQKR6fBbshrwXBmzVU3oJFomZ1j01ZC38m+4VY=;
 b=TLlehUDwGr3Ojy/jycr09XR9AGfp44aChpgfM5jJV7kaXsAnSr+JA5kc4a3EqTKgpM
 JtxCX0tVzaWove2jYvdSkdAn9S8DRdO6zp6WHBlwT6FNJBdQYnitgqWkQC5ZZW+5dnai
 XaUkP9u/wkqot5dliz9Al9J4xvegDm3RNQsMDfVuuLPODSJXcR6PtgYxajmw1xy/3E/A
 uzQRBfems31WGv2A7S3iZ/OVUuV+G6g6o2N7kv29HkTAt/FKyasWn+Il+/q5UfA44RhV
 iERRe/ukaJ9BeHhn47IuEvrTlO9c2QLYcQGqKVRm4O9ajzHD4FFS7q4LHh1w9NRDo0X/
 jxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582745; x=1742187545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mz3bAPQKR6fBbshrwXBmzVU3oJFomZ1j01ZC38m+4VY=;
 b=tIhSRKpZetgZWLF/ojChPnfd1NVU5xugEjIdfY0CAAlOLH5mHQzkZpmfKG4HpZx2yw
 0ciHAjjKmIW0oBo76o5fenx5JlkknXz3ZTXo2k5pZFXl0E1DfocKo6BAWzEv/9arEhfP
 /TFpfgBdXQVX31yoH6vB6opt7erDdEwItPVJZFxlEzo+qnvvQR4tUamqkGxG1ZX3dH70
 tU3i5fSwEN0K41uVuC9RJAx/gVsHnuFeVS8DGdxQ/D0yetRaBMZT+pcFMS4q/mX2DiBL
 cGhRNwCI97nOSATgXbhgVynzbe84ou2BmHlH6mm6xeMLY15EuL8OUDmB4ctUgOW0EZUP
 voIw==
X-Gm-Message-State: AOJu0YzZwP0TabvLcI3zkGmYxuESt7TLSYQBZ/333JpWGeDG8GlYqPmS
 oFur2pa6OB3sWKa68Z9ZA8NimwPQhwVBJ3aZOR36Y9inDDNPBzeWsUVX44DWK2h5yy8ugVI1POG
 GGUQ=
X-Gm-Gg: ASbGncv4bzj9ggTOoRTZo1zTO54hFwHlYD1zSVu2UU7sQgU31+wHNeW53PWpVq9xr27
 MADBtbi+MULaZgfd449v2Ms1K+/yD6PPm/44SJ9TuIwU3Lsx7gR5kla4h6WnaKWdeTBjco8npWF
 bQ1XfaZ36ZQWkHsMh8K7QPSRqbGnWOQNF89EXkeiOurQFrSh/0V54tTMsLBPEuWWELZG++jNRjB
 mpLZD8nelENaGsknHDvF52ln8HIHrevTmC39R6WJp4BjaLjm8LNzywwH69f/Oi2O3XLkumL8jgQ
 zWpGw4Qz18jQOL1fKHhrl0QuxBSWnsPlVJ8uBHkSJC6CDqpJlNQDvak=
X-Google-Smtp-Source: AGHT+IF05iTMc8yin7+8YVYQSgdEUPUj/50hW5+Z0DK0JGoSuS9iEibUeyOyOMAIIkH5mDIAK7kv9A==
X-Received: by 2002:a05:6a00:2e17:b0:736:3954:d78c with SMTP id
 d2e1a72fcca58-736aaa1ce42mr17690072b3a.6.1741582745578; 
 Sun, 09 Mar 2025 21:59:05 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 13/16] hw/xen: add stubs for various functions
Date: Sun,  9 Mar 2025 21:58:39 -0700
Message-Id: <20250310045842.2650784-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
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


