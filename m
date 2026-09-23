Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83242C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgk-0008Gl-EV; Wed, 23 Sep 2026 16:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg1-00089C-Gb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:50 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tfx-0004yu-QR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:48 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso811551b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195684; x=1790800484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uBX7tfKeYT6a4zn2/UKWbzFJjN8erPR3i7LwyHHAdJI=;
 b=VAkE5Td028HjNAR/kiXYMqaFLCoYfbzpcDnJipGufnwrTiZT0gf7y4EOamxOd16Oif
 plFeo4mPuKsHpWPQmttkznqrh7eZw51sTeITooI+o+cBtGXt84FVzOn0ja+uD0zVHIZm
 Km2gGjpgZDp5m88zbDHvIcFdmNFhtWRP3e8MGEOduvmyyJZPDff6/EbpNzb6LkcY1b4d
 el2HFgMK+LMbRMVrWaHGUClglkLy5snchVBtXFWv5saLMuvL1Kb07ZXYZRCLPmYacFuD
 Do0IG3w0uf3YbGmqFuWLz84Gap77zvnmrV8r12NuJCTVpxFTxKV+LXUvvXV8tlCppwsA
 F6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195684; x=1790800484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uBX7tfKeYT6a4zn2/UKWbzFJjN8erPR3i7LwyHHAdJI=;
 b=gUbtmGCHA2O7ZlIjf15xFIeOvHMswiErnnJByxYOAzhJp1XP+nWznbznwzVZNEVNba
 DyHvWAPvDwHFJcfYSCUvaTVlTcSiFPmdu6/BQ3eDGT1GD5BfP4MiDfWEWLF9SwGGKSV1
 UkiQW4W+JNaDzkAhlpZkg1wraV93mg4/mec8HmIDI4eLLr2cdX8m1HNKu3Tu0kf+v6ZC
 rQypZKTZnmLJigl1X7nydKwvXE4rE6vQdxJcZNqZOvn2i7tNjo/uwZBQovA7ZQvgaTp8
 mA9amP30ndF5C5WmMCbWnh4OexytzwjmZfef5w7yGMW2iWHgxCN34isub98UCxMLudXD
 Vyag==
X-Gm-Message-State: AFuF++k2DaJCvPBCPsxZncpyyMXHps7K6dLut3iJeR1CvR3SNP0TECm/
 6TkVcH63CGFKIq418ee+xV/i7Rt7QgBri8pcpSfewZAUwi65+6o4iiP9D/kviUa59b/O63hYu7i
 D7D1m
X-Gm-Gg: AYBFou0w5rOPJhGp7fGz8XEaih+9PIIVI0xYDkjnpIL4HWVIkNE+K7UrRYl3hI1ee0a
 ONUBNqt62AUw8hjTC6eW1rlYYro5szYH9Mp+1Ftd0paTnjshnIeviotdVxIbpOQ4XSUdc4P1f1R
 mvJ4ye13+t4EwRX8JT5yAJlTjVHyJZFida/gzedBYj4cPxHxenDXdDB/F1meaBJCj1ygsgJ7g7N
 yirpktMlrPpmvycplGn0hwspYFhQDZCKbB0eMUgTi/PWLlhWwaUwxWT7bCEePHqSexbs74iH6iS
 Mlqc0UFfJgYL26thamvVPVMb9hQDD+y+EMhtEZUhPRBkuND/lkMSOxuLNdGahQ+xvcEB9OYdVMW
 /1WESPv1VEdMznOcpbrcEb6a04vED1vfHCjPCucgXU/XWRgDi+y3UBvRb6BrKmzv/xHG1FWlQaY
 dkbtrd4XW/z8eS446wvJeQh5Xq3tjiDvkM+hCOD471XelU1p+WQa02iY9uqy39wASF30GQF+W9V
 8GB+PZymVmhqG7i8jRDmzAElcOz+w==
X-Received: by 2002:a05:6a00:1c9f:b0:874:708d:b622 with SMTP id
 d2e1a72fcca58-87e9b69d6aamr227836b3a.32.1790195683974; 
 Wed, 23 Sep 2026 13:34:43 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 01/16] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system
 plugins
Date: Wed, 23 Sep 2026 13:34:26 -0700
Message-ID: <20260923203441.31276-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In b79a9b6e5b, we stopped using TLB_MMIO for user-only plugins,
but erroneously thought we were already doing the same for system.
Do that now.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba12..ae5af014960 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1369,7 +1369,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1399,16 +1398,13 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
 
     *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
-
-    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
-        || (access_type != MMU_INST_FETCH && force_mmio)) {
-        *phost = NULL;
-        return TLB_MMIO;
+    if (check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu)) {
+        flags |= TLB_FORCE_SLOW;
     }
 
-    /* Everything else is RAM. */
-    *phost = (void *)((uintptr_t)addr + entry->addend);
+    *phost = (flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED)
+              ? NULL
+              : (void *)((uintptr_t)addr + entry->addend));
     return flags;
 }
 
-- 
2.53.0


