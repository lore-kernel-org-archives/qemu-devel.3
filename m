Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77ABD637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOSE-0001PT-Hv; Wed, 13 Nov 2024 20:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSA-00019G-EJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOS7-0002QH-V8
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so1004725e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546917; x=1732151717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijxub0J6LSuaPkun5QktYbNZDFSQDSukz+hms+c1Ih0=;
 b=j8Wy1IKpWhbSGsE+4uzRK5uSblCZD17L68agSr7tqfki3RzMgzQ/9LlyDdsbViyXxI
 foFXN5L3kI1hfN50MEHH1uuJxXBDvdmmH954OyqQmiwaRQwzUFwLJz3Rq5bGpdv9k0dD
 2axyG+I38ZHsONIuxVH9GxpdN7t7BrlA0I5IsnfioEGInOsmraycuIXymuB94pZF25lJ
 NacY8T4RUxJhpzZHwcbXVZ7uj8WjgeJEC4Q5I9qXZLEeYAaB5sv43S2wFR+zcQOw2xz2
 eqd8/hhOk9ClRbzym+RHICjkl4J38EpVEV5ymfqRCkNyJfjDAIjGl8IiJR+dhMG8n6gU
 /cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546917; x=1732151717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijxub0J6LSuaPkun5QktYbNZDFSQDSukz+hms+c1Ih0=;
 b=CNj8NcCWdpon48/F81VNX2izHMIedilcPQt1QoMp3KE4XDQeRGxUy+qE+UxEu9O7W5
 WKQ3WfxxWRz75nEn3aRIqyfxXnShvz5KzDeydDXab7mxYRlaKJQT5t2Ade9dZhfjXeCc
 4WWYN7mSE9wRJVd6XL6LtVFgWDLL24jbrzfv9nnPfpcn8kpvt2Vr5aGslu5cIEg2lCu1
 rFc5tWntkMSdT2YMry8dHz0qg6aeM12lGYs2aNTaH0RWbGKtBJzL8oa/TMSogRZIf0IT
 Q4VKshtE6pn6KlGqfO40HRoqgXJFKed1jGYzJ5g7kkHxsmql8fKicYOyZr5boAHGEx31
 E51Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi4MfvjkGj+onKH5x1/B00hv7i926qpvgkOEElTH/H2PPoATAI3yx9QjykTQm63OI/tzbqnXfjiCxT@nongnu.org
X-Gm-Message-State: AOJu0YxHf41LZrxwIh1lG+nATMdN1MXT4c7oQFnvcKz/seWYnK72LZYl
 gQcghOpkQMYOXvfig/GeGXQSjo57tuJsHiLbvGaxTYvFhbfe+DBrABhySZ/i1vHka8imOH/OBQq
 J
X-Google-Smtp-Source: AGHT+IFREe/JrPjo0y0t9M2Yxcx4JMxB17tQX6TF3pVR/3qVRL4KfJoVIRyzbtQL0IXAATDBdsI/jg==
X-Received: by 2002:a5d:6d83:0:b0:37d:49a1:40c7 with SMTP id
 ffacd0b85a97d-381f1872717mr19221825f8f.28.1731546916093; 
 Wed, 13 Nov 2024 17:15:16 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97c6b6sm19475690f8f.24.2024.11.13.17.15.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:14 -0800 (PST)
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
Subject: [PATCH 15/24] exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:00 +0100
Message-ID: <20241114011310.3615-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 include/exec/cputlb.h     | 23 +++++++++++++++++++++++
 include/exec/exec-all.h   | 22 ----------------------
 target/sparc/mmu_helper.c |  2 +-
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 5386e53806..f6205d5306 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,7 @@
 #define CPUTLB_H
 
 #include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 
@@ -57,4 +58,26 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
 #endif
 
+/**
+ * tlb_set_page_full:
+ * @cpu: CPU context
+ * @mmu_idx: mmu index of the tlb to modify
+ * @addr: virtual address of the entry to add
+ * @full: the details of the tlb entry
+ *
+ * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
+ * @full must be filled, except for xlat_section, and constitute
+ * the complete description of the translated page.
+ *
+ * This is generally called by the target tlb_fill function after
+ * having performed a successful page table walk to find the physical
+ * address and attributes for the translation.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
+                       CPUTLBEntryFull *full);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d792203773..79649537b0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -174,28 +174,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/**
- * tlb_set_page_full:
- * @cpu: CPU context
- * @mmu_idx: mmu index of the tlb to modify
- * @addr: virtual address of the entry to add
- * @full: the details of the tlb entry
- *
- * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
- *
- * This is generally called by the target tlb_fill function after
- * having performed a successful page table walk to find the physical
- * address and attributes for the translation.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
-                       CPUTLBEntryFull *full);
-
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 9ff06026b8..7548d01777 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
-- 
2.45.2


