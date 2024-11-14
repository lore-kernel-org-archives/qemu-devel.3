Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116ABD637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOSK-0001f8-6C; Wed, 13 Nov 2024 20:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSH-0001a6-Fu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSD-0002Um-Us
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:29 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so58246f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546924; x=1732151724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUDaBZRCGe5XV9UkQASFR3nCzZYDHP53JFnYTigMJ4o=;
 b=NYXwQxItPqJDdAsaYRcfhW55oxaVXkg/vhnwk5Vfy3WnClpXzH9wHtMlaICT+mKDxt
 SnorxN6UWtwMbpxCI0T8tSfRZS2SihVqysXma6Sng/RcO+u7p3r78LnxnsMkFlXVU3rH
 y7yEK85/q/qMGiRR83GvKI0JKEgAjei8YzeQ9z075OLWTljc1VPP3LLao6dFYphkQlKH
 cBC/7Ug8oNSiWSJ5lucVBUwSrF1hwm7O1P8wnIX9JAVvGRFexLTlMbPcWaHI8avD5AES
 tDhNonB94W7KS1CoynhfpoIZOs9ITmEEUzQ49fbq3e+DaS8FEgUgoLj/pmdcxnBXn0XZ
 1FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546924; x=1732151724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUDaBZRCGe5XV9UkQASFR3nCzZYDHP53JFnYTigMJ4o=;
 b=pS7KTGYlxcEmqM9FEtuIAeOKmIXNIeG7B/4VtalmfRoTgoTrvzHpbrcsYSIb+WkqZL
 iUWShkQkec2pBgGCOcCz/qJA7XyUeDXKtax8Q1XbUQQS7gevpNrm3xo7jPOL4rsi7SK0
 /hwlhEuxeQ+cTMKmzb4OZ+cXOquB57X/2mhBmZNnTDm2HEBy5Ysiz7VJZzFJQ3GGHrEp
 SmHsioMIhrgYjuLDqkEMc3ZKO1/ncj3pIPQHFsgk/EHx3rIGY8ogmVVV7rAC1vzxHIRw
 ZNRGy0hUSBAnI1+XMXEFAaTpetiu9BL+w4hQ/3FBlL8FJ7uXr+vETdNyBHeQVh33J64a
 /PIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVEZmvljQcsloyhLFVL6YS8hXXHZ8bS9kvpPx9fl7Nv7gXagyNe9N1eCSi4V4TIb1LCluuVLGNfxjG@nongnu.org
X-Gm-Message-State: AOJu0YzRtPPRudVG1uMYrRqiYqzZ/xbX0H9LRr9BX50lBxJmDNOR7HHr
 kfPsSZNxdqWueLB9PRA8E0rF2NBHDYHaFfgL+IxFLHRW+oNDO/Yu394qottJX3M=
X-Google-Smtp-Source: AGHT+IHsnUDtCJjwswsvou+rSW6UUntSAN1M9ewjVg4bTB1KhLSGIABGdWRRaamvym5hsGHe6A5/Vw==
X-Received: by 2002:a5d:6c64:0:b0:37d:528d:b8ad with SMTP id
 ffacd0b85a97d-381f1865423mr20754685f8f.6.1731546924040; 
 Wed, 13 Nov 2024 17:15:24 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d95sm19924032f8f.44.2024.11.13.17.15.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/24] exec: Declare tlb_set_page_with_attrs() in
 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:01 +0100
Message-ID: <20241114011310.3615-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h                | 28 ++++++++++++++++++++++++++++
 include/exec/exec-all.h              | 25 -------------------------
 target/i386/tcg/sysemu/excp_helper.c |  2 +-
 target/microblaze/helper.c           |  2 +-
 4 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index f6205d5306..ae4798a017 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,8 @@
 #define CPUTLB_H
 
 #include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -80,4 +82,30 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
                        CPUTLBEntryFull *full);
 
+/**
+ * tlb_set_page_with_attrs:
+ * @cpu: CPU to add this TLB entry for
+ * @addr: virtual address of page to add entry for
+ * @paddr: physical address of the page
+ * @attrs: memory transaction attributes
+ * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
+ * @mmu_idx: MMU index to insert TLB entry for
+ * @size: size of the page in bytes
+ *
+ * Add an entry to this CPU's TLB (a mapping from virtual address
+ * @addr to physical address @paddr) with the specified memory
+ * transaction attributes. This is generally called by the target CPU
+ * specific code after it has been called through the tlb_fill()
+ * entry point and performed a successful page table walk to find
+ * the physical address and attributes for the virtual address
+ * which provoked the TLB miss.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
+                             hwaddr paddr, MemTxAttrs attrs,
+                             int prot, int mmu_idx, vaddr size);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 79649537b0..2b314d658b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -174,31 +174,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @addr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @addr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
 /* tlb_set_page:
  *
  * This function is equivalent to calling tlb_set_page_with_attrs()
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index da187c8792..cda0152b80 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5d3259ce31..27fc929bee 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
-- 
2.45.2


