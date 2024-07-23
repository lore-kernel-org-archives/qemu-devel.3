Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F80C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIwz-00041o-NL; Tue, 23 Jul 2024 13:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWIwv-0003za-V5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:05:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWIwu-0006g6-1e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:05:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so41493235e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721754314; x=1722359114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dLstUHoBmhATlk+DJXSCk2dPpJ6Fwcn+oMf1a9w3C4k=;
 b=Z2IqpQqu0jZksrpct9RxQ1VZEo5HMdVAryLBnjYPJV5IX2j/z0IdpzGk17fhsogxZV
 K0tm1yJt7Erjq4/tN86zxsbFzTo3YnjmtNH9X8qI28+1paaD1UXHnSSTwpo3U13mdxO9
 bnkMRtTg1hyuU/nZpbx7HBeh7tKaPx5x/sNwzFrL0o1Yk/0uqeysnMj8xKnDFCngKf+o
 rtAgPG/4VHaU5W+13CC54BsoWXpwElOwtNHnyUTMBq0gCmkyt5vy3FSv7sx7iALNMNu9
 iUL+BiB40FQG1MGqJe/+16HHPUXP0RLDcvwg/5IheiY3oDrqiy58yn//raJShgYKmjmC
 w4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721754314; x=1722359114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLstUHoBmhATlk+DJXSCk2dPpJ6Fwcn+oMf1a9w3C4k=;
 b=kpyu40YQywzNzo5VVtFMIaGTkPZQU3fCufiLVsH+1VxQF7uiPU0Ke+gYBTyw15Mhfq
 XTBGFL+Us5Z/ATSZ2jNIvXOnsRhus4I13KAcu06JQczi/SA4iKvg1pCU0/S95AWHn8ob
 j6cgmt/Abzc9urm48cyBhJjPpLKeRgvd8xBy89Us2+43lfdjK4/rrEt8mWsOZqCY9XeV
 CGjzVZaU+5lgqC6OEzEU/3YrUpaS2jCi0GQjJO1xQO2pn0gmq4HxLWbBAqr7pcQ4LqpM
 lJ2WswKDHpf9Hx9Z4+LUv+HXRrrMC4jZdE7+GE1/sdfdh7Cajl/+WfyjwC68BqVHabOH
 nc/Q==
X-Gm-Message-State: AOJu0YwJPLuZUU5TWBvBRAU5Y19LNsc8mF337AYojoJgAloRmG0VmNmi
 GSMsHx4TU75aLefPM2Awq8Uh9nm8UXmkUDET9LDT1nh1NJ2u43BKFvJ7X/YDhpN1FlZZnFJ/ZeP
 8
X-Google-Smtp-Source: AGHT+IHsiQYtbDivcM3TyrgxcYp9Oz5pUuTupGssLHG3Y6kZtixuYZ0hapI3TeSQsV97eTrY+yB9Cg==
X-Received: by 2002:a05:600c:4ecb:b0:426:5216:3254 with SMTP id
 5b1f17b1804b1-427dc5799a5mr92147555e9.32.1721754314324; 
 Tue, 23 Jul 2024 10:05:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94c30sm211779575e9.47.2024.07.23.10.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 10:05:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/physmem: Where we assume we have a RAM MR, assert it
Date: Tue, 23 Jul 2024 18:05:13 +0100
Message-Id: <20240723170513.1676453-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In the functions invalidate_and_set_dirty() and
cpu_physical_memory_snapshot_and_clear_dirty(), we assume that we
are dealing with RAM memory regions. In this case we know that
memory_region_get_ram_addr() will succeed. Assert this before we
use the returned ram_addr_t in arithmetic.

This makes Coverity happier about these functions: it otherwise
complains that we might have an arithmetic overflow that stems
from the possible -1 return from memory_region_get_ram_addr().

Resolves: Coverity CID 1547629, 1547715

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/physmem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 9a3b3a76360..87554d68ea4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -894,13 +894,19 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
-    ram_addr_t start = memory_region_get_ram_addr(mr) + offset;
+    ram_addr_t start, first, last;
     unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
-    ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
-    ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
     DirtyBitmapSnapshot *snap;
     unsigned long page, end, dest;
 
+    start = memory_region_get_ram_addr(mr);
+    /* We know we're only called for RAM MemoryRegions */
+    assert(start != RAM_ADDR_INVALID);
+    start += offset;
+
+    first = QEMU_ALIGN_DOWN(start, align);
+    last  = QEMU_ALIGN_UP(start + length, align);
+
     snap = g_malloc0(sizeof(*snap) +
                      ((last - first) >> (TARGET_PAGE_BITS + 3)));
     snap->start = first;
@@ -2630,7 +2636,11 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
                                      hwaddr length)
 {
     uint8_t dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-    addr += memory_region_get_ram_addr(mr);
+    ram_addr_t ramaddr = memory_region_get_ram_addr(mr);
+
+    /* We know we're only called for RAM MemoryRegions */
+    assert(ramaddr != RAM_ADDR_INVALID);
+    addr += ramaddr;
 
     /* No early return if dirty_log_mask is or becomes 0, because
      * cpu_physical_memory_set_dirty_range will still call
-- 
2.34.1


