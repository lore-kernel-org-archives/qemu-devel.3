Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E9C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8ts-00061Q-NA; Fri, 14 Mar 2025 13:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tE-0005ed-5z
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:10 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t6-0008HG-HA
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so62105905ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973519; x=1742578319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZK4IDfbpcoj/UHXYNBc9hj61CH/qnmJNHrSERoWz24=;
 b=k285P5i9vOuCu9IxPnh7OBLSosROs8en99zv6zczWSCR9fI16nQSB1ZKJhuimUck6P
 QMT8a2nOci676V8rchwL97ywt4v5jj/U/zANyulfkxL33nnwRCSXBlSFli+5kOwMa5Sw
 Jct6qfL/2y3S415Be2+Ptd8kNpxao1GpH6lpRGGf/j+hkFmDGd8WtWCV3b1CJ4OIMoer
 tK+y6vtrSwy2LRnFEm5fnT4TW9BGr8FZz0+bocPDzY7Mb8MEmkkYcNsoa5B74dEEnOhm
 1qH2c7ySCW4/BpS26uCJjZGCuHPfa8E+1aLs/ccFn4lUgLJloJJRCoUSFN5uUYFcOC5h
 mfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973519; x=1742578319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZK4IDfbpcoj/UHXYNBc9hj61CH/qnmJNHrSERoWz24=;
 b=SbYIyHJczAtdWV+zbe0jgoi9xlg/tnI6TW4VqgerRP7oQtghyByvnuJxCXgdHVjGLA
 gNdVtWG+kqBqHcpGG0a6EhFXxdtdzX8qHlrx102iEVgN8Fkd/AUwgwVuBiMsflN46av1
 EZEaAFOq9KQLa4tWiowmAraqi7Bk/xIccHEl32x47q2Av0TCtag4uzj1zFK+fkEbQAZw
 w+p/Aie/i1AILQOpA31KHKMJbfHtMqcowkU2gXUwMaFHKr7eDJfqHwKf2vRqWyW8ex1M
 xBxJPla2u0IoJ7NfqtaTC40Phou2o1zfO34rF39VL9p/bHrMjEaTrNJJ5erufdAw7yAM
 taZA==
X-Gm-Message-State: AOJu0Yw1se82XyrCAvC2eyR94H/jLN0n9PNmeQoP/0E6kXRtdPZZkUgU
 n1xS1E4N8rFg6tuPO6ZfaReAVWSvJ5YKVJVWshIDU+0v7R3vHBz3AVhPkVvyXqQnNt9ZeQYtilt
 vQtY=
X-Gm-Gg: ASbGnctoAY5PoC2QLK/kUwdan7L3DlIX2lC5DRSypi1CsUqg8YC7S8UJ9cxD6Csym2U
 HCBdSRI0ruIIwjfhTr+ODi5tT989WuImoufzFzeMH8nYSFWIgsh6hGthRsVTGbJq25xH3c5d1Oq
 WNoOUcQ1ZCs09qrdvHmzt+98JgIjjG6stpgdT/aiWVEQzJBLiElY/aRSKL26q4vmlpELQHVtmRB
 +DaNN8rrJz+R6PVvOuudfkV/GaHDd/3qPj412xq0PTp4rIWcY0jZLmsUgB0wdiiDxdHAu+t6THa
 UbE8gU/k/Q4fhlJQVv24IqWGLL8kA1LkgBNvCZkqfOJn
X-Google-Smtp-Source: AGHT+IFO+PDwMeyLa4EGhItdNdod3PivHdGg2tuOsQqj5N7me/+24tmsBkj8Jw+BltKmizpirWlssg==
X-Received: by 2002:a05:6a00:b4e:b0:736:533b:f6fa with SMTP id
 d2e1a72fcca58-737223bf5e7mr3790179b3a.13.1741973518933; 
 Fri, 14 Mar 2025 10:31:58 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PATCH v5 12/17] hw/xen: add stubs for various functions
Date: Fri, 14 Mar 2025 10:31:34 -0700
Message-Id: <20250314173139.2122904-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Those symbols are used by system/physmem.c, and are called only if
xen_enabled() (which happens only if CONFIG_XEN is set and xen is
available).

So we can crash the stubs in case those are called, as they are linked
only when CONFIG_XEN is not set.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/xen/xen_stubs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/meson.build |  3 +++
 2 files changed, 54 insertions(+)
 create mode 100644 hw/xen/xen_stubs.c

diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
new file mode 100644
index 00000000000..5e565df3929
--- /dev/null
+++ b/hw/xen/xen_stubs.c
@@ -0,0 +1,51 @@
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


