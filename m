Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F7CC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38u-0004jH-0m; Sat, 08 Mar 2025 17:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38S-0004YZ-1w
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:12 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Q-0005LT-8B
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:11 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22401f4d35aso55290105ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474748; x=1742079548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzyDViup58ROLXi9a5eLqmvAZgtt4FP4fwTvGjoaRo8=;
 b=EVJKeDS1Ww74kLYbEQRT3RNzv5P6Xn7T+YCqYh1MWvrfsG9nAv0qwX11PU+E9Xqu2s
 gYPikMjIEn6eQFFLRH4MqBI1FltOiLOq7nNw5Vlcu0HPhIubcIXYCYwxGvyseUskjv2J
 3f6R88vhXliH7UryHVZMKlsICzaV+1AKZ62PJ/k8mPgVH6cmeSGIqNS5Fs0PcEe9S3hi
 k6kNo1XDLxzn2ZNBBQnwGTPDQ311u4IFb+MgACEKTTp8y2aMUv7SPenbW2Gw4y36taAh
 dlFvQHM3kayBm4NfXB58IxoWyzmP1kr7oh6L8bQaF3Ued71lJxAzOuymODEvwmo0RVFk
 qdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474748; x=1742079548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzyDViup58ROLXi9a5eLqmvAZgtt4FP4fwTvGjoaRo8=;
 b=CPpYZnIeJ0xZTiUWLLIHaryR+2Hmd60TZkr7mUI+mnTySJALOxaBBHY+j3DKbBM3xX
 hVPZAxdrN7wWuijCsPvuKgK2fxwJNqCUMy3HPtQKayn30vzsf7jDfWq4Y+Q1GGnS/mcS
 asP4V+/iM8eJwYQFRW9Mwjw1wzMzU5Q7Q0Bw0SoaJDZ9XyYgakx6RuSSV3WckPqAOdW5
 k5+u6l5nDt8+QgOHXkr19s5YRgmBw+CdXy2tJR9mriyrGVeS9/hhvkf58MslQGwn3qSl
 fWwYKxsUflMjc5WsyFEybRi86wxTpx8tUxuzZJjtoarVzKeETN/6WaDN8vpFRcBnAhvK
 vAvA==
X-Gm-Message-State: AOJu0Yy+1El+UdHW5sKfi30clxpo1/lCnOeNFHcFkO/8cV//1LNYBFBN
 Uix1O6kcm5DRLaCgpw8ZT0qbn2Cjad7M/4JokELKArSHU2vCEOUOOTjDtpF4qiA5T2UTpaT1Q14
 H
X-Gm-Gg: ASbGncv75FGLEOtoZWj7vYsKZxAaM7gdvjcF9RcXc7RE2oz6IcKujoLSpMc6A6BJCPN
 DSDV8Jgxeos+xJhFq+2aAs/TXbuox/3vf9uTF3Y1dkhEB7h9NVUQe9VochS3ohyCzz53LTujzHf
 /kovAbNTeNloYK3T0LOspFe3Z/SkoFWGgYZfKA9rsCiE6zs6XpguG9Y1mrrSWHPErdUqOf8ciSt
 tH5k0e0O0N3pDy9aakJzVIL8bV11P8CAQ/4tThbUWRPMo0AXWIIebJYfcCuhKfSyDnEXK7rWYOC
 e/15+j0rRSvs3QlxDEZJKu2+YaV0jhjtY6aD3LH2Mod6FY4ospC+4rlce3csyq40s+gsFsid9B9
 c
X-Google-Smtp-Source: AGHT+IFyJnA1+vdfNfUgsMYdAyxkp/4Lc0qas+OrnJ+irFS+FWN6ufmm4ukreIYxEuOECAoPLeNtgg==
X-Received: by 2002:a17:903:2445:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22428bd446dmr121049425ad.51.1741474748455; 
 Sat, 08 Mar 2025 14:59:08 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/23] exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:46 -0800
Message-ID: <20250308225902.1208237-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-16-philmd@linaro.org>
---
 include/exec/cputlb.h     | 23 +++++++++++++++++++++++
 include/exec/exec-all.h   | 22 ----------------------
 target/sparc/mmu_helper.c |  2 +-
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6cac7d530f..733ef012d1 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,7 @@
 #define CPUTLB_H
 
 #include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 
 #ifdef CONFIG_TCG
 
@@ -39,4 +40,26 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
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
index f24256fb5e..f43c67366b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -156,28 +156,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
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
2.43.0


