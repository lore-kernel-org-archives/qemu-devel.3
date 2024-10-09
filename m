Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515E5CEDDA7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJJ-0001Nc-CR; Wed, 09 Oct 2024 11:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJH-0001La-NE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJG-0007x4-2d
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71dea49e808so4428432b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486544; x=1729091344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DYfuoBzid/U1ZJhrVaORza7JwLn2M4M2h5sPBcvVQ5Q=;
 b=MnMLmH4PKyp4aNGdTTRhPf9H1AUlSITQQI+qwwbgQViu160uufnf9wZQPdOSp9s/9z
 aIUsG7/aS/Nc07whLauXZ3dpY+EfYHuAjO8NGdV86RZNcn4qmJSLSACQNB/ytwdMvq5S
 eoL49CFgDn3sKNB5pKnE0lGSYwckreZpIxAAOS0xt0UT8Wm9M2AjjMj7x4BzNAYWoCjA
 h7r2C/E8kEeAZrfynbrEq4DwbxpsjbhxaBdr9dwlmxp1HQ62k6AaydkPgHu2NZ9MqWon
 LWCnVamcNsA0ZYkGkgT0cjnzDGGhAGp5yndwhJ+DeSRy+/XZMjDJz5V0f57mRoKe20FY
 LPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486544; x=1729091344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYfuoBzid/U1ZJhrVaORza7JwLn2M4M2h5sPBcvVQ5Q=;
 b=C69ycnIApu+vscYrxHXcf2i7ya+XHfjzW2tH86oMV6OZD+vWL+WRpyiTtuIAASu1zM
 voT16/l5zOfJLQFsW/9pvrvQvP01xM+WJAbnPO9iLQIjcmC4uXJTChck1WexczR60L20
 579U+FLBeDs2+EXWZetELQfHR/Oq63SV5ZyaRCXSuM1/xvcmfWsGq99corEX9eHy8DDX
 WqvNx3bm8cRyuPMJz8H9OYPI9/KWO+hw+sb719OZ/j1JQTmVzHFpjdThGbNBzfOX/7Dz
 fxZGdIk+w9SzwS9G5T9PdPWf/g9my5Cvu5lshFVQygAmGfrhdSrGsjRnI92ER1DyHILQ
 rlDA==
X-Gm-Message-State: AOJu0Yxi0a4xl7I9EjWAj35wAjJp0PIbDfgCJJXAQfdHNRRB1uI9D2rz
 aW1957PF7VWkaaLFslgrY4+1d1sN97Ry1nT4UHiNcJ9B56AAUD1VJK4b3E6IWkl75l5WUQWP1NH
 p
X-Google-Smtp-Source: AGHT+IEJLGpA39Vv+ilmNwxnUt3wkUQQWTQpabEuIbV19gB1Qm2wNwpL6xTFVKy73Tjo3n0sV+W6Bg==
X-Received: by 2002:a05:6a00:1307:b0:71e:1201:636a with SMTP id
 d2e1a72fcca58-71e1db6ecd6mr4760730b3a.1.1728486544248; 
 Wed, 09 Oct 2024 08:09:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/23] accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
Date: Wed,  9 Oct 2024 08:08:40 -0700
Message-ID: <20241009150855.804605-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Add the data structures for tracking softmmu pages via
a balanced interval tree.  So far, only initialize and
destroy the data structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  3 +++
 accel/tcg/cputlb.c    | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d21a24c82f..b567abe3e2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -34,6 +34,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/interval-tree.h"
 #include "qom/object.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
@@ -287,6 +288,8 @@ typedef struct CPUTLBDesc {
     CPUTLBEntry vtable[CPU_VTLB_SIZE];
     CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
     CPUTLBEntryFull *fulltlb;
+    /* All active tlb entries for this address space. */
+    IntervalTreeRoot iroot;
 } CPUTLBDesc;
 
 /*
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8affa25db3..435c2dc132 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,6 +89,13 @@ QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+/* Extra data required to manage CPUTLBEntryFull within an interval tree. */
+typedef struct CPUTLBEntryTree {
+    IntervalTreeNode itree;
+    CPUTLBEntry copy;
+    CPUTLBEntryFull full;
+} CPUTLBEntryTree;
+
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
     return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
@@ -305,6 +312,7 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     desc->large_page_mask = -1;
     desc->vindex = 0;
     memset(desc->vtable, -1, sizeof(desc->vtable));
+    interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
 }
 
 static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
@@ -326,6 +334,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
     fast->table = g_new(CPUTLBEntry, n_entries);
     desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
+    memset(&desc->iroot, 0, sizeof(desc->iroot));
     tlb_mmu_flush_locked(desc, fast);
 }
 
@@ -365,6 +374,8 @@ void tlb_destroy(CPUState *cpu)
 
         g_free(fast->table);
         g_free(desc->fulltlb);
+        interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
+                                 offsetof(CPUTLBEntryTree, itree));
     }
 }
 
-- 
2.43.0


