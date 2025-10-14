Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADFCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ikb-00019d-TA; Tue, 14 Oct 2025 13:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikY-00018B-Ab
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:50 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikV-0008CS-Ei
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso5060787b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760462625; x=1761067425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hB3ew05sFTjrc2BAHZj/TJ6nak9Kqkcz//MuGkF6rNE=;
 b=VPgxl80ubhvgSwAcMy0yqRAX9MPXiqN978QzeSz61/vUB9rcaWY62UTGB3LQv2RYfZ
 zVUEn0QMal7t/xgOQWuIaJ8s283dKEcixc9OJDXEgozKVRktstZbgux17vKb7nLrkzsE
 AaVtTX0+lPLitnLts6BnN3Nx8/KUZUl1UOUtrAS66eYfxcJCl//tVRL5KGZQROXRKtGD
 NtzNnX2kuwcaq9cSqVLkFjkFsXIKlXXFnNRF08q37Yx3Cxd5THnwRYQan9QlrjVFCQJI
 zs+GUlajrsf/88HfNeJXQX99VQOl08CR4GkL9b+J0O+u9hNwP1tGfxVpIKcwM9EPVANJ
 1uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760462625; x=1761067425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hB3ew05sFTjrc2BAHZj/TJ6nak9Kqkcz//MuGkF6rNE=;
 b=ARS15EHOjQPwyfFVucLMhGEWTtEk6aI01IMQUi/iS9gljr7rgI1VYhenmfRNCECkOQ
 u3NxiWH5BMSx2+xSXDdkW293VE7cvS0x5du/0OO1d+E6xB9CraXgxr2/Fwuq+2TBThkk
 SI/l32VlfLlA57FcOJMdGzfI0lBkrehIeOq/pHsd12+LOblozjS6UmhdSCMx7BZq3e2z
 rJ85KHffNKpDPLXOne4E82br86GhxC09kXko07rCkwwIt5A8S94ojwQ7lNv95gugQgFF
 udkVw+GzkLszcEsgeCmQaQUkgiDJtqnHssEGjEreKJLMI8KXgHSka1OkWc6pQUTDrSZV
 3zJg==
X-Gm-Message-State: AOJu0YzzfzNk3PCUcNQeouUyB99RbMRfI4Ls+MXvgvxLHkNDuvurpvJj
 pFtCbTyoGQJpC3eAC5dwI7OenHFKwB319QjfR9g7L3nRVWF14MiAccfTa1q0gRxx3QCM0W/7kcP
 liIOAxsc=
X-Gm-Gg: ASbGncu4ecqAu4k3o6dex9eH+TGw6VXDaaw9z9SSDYbo83Ps2L+w7oso0ckG/fyCbdu
 09VJPJoW8SFtec1nV3aUHA3AfVDawqxmfmrhGp3w3gBNOLPvMPrPafihQxWHLEOD4lCZnMJ4VP6
 4ikRHa1YqnZKdMjE72F8MyD3CDVFWRboCRjztWM3wsluk/n1fGEd2+T5fLUG9Q6HS1mVdir9RoS
 h+Dfw8LX0O818G0idz8BG+53T8hlf/fGiv9bKhTgH/BvFgzIGYnjHB4sDXd9Xt0o4e91YO4Z8aO
 wl36JkF6ohKZni/YAXOySNzIAbrm4ldcjDSAgqGdFtRofWAqbTXw6XkCRvx50xwnAWVuDaBOlIG
 dWbe0ZtAyrLuXzSh1jNcXzXC4xcEvemqBgmSJPcO0o+PS5CSyZi6so+mj5uwLwg==
X-Google-Smtp-Source: AGHT+IFNkh8sAq9fKTei6ASjBB++QBue3bSYFDQBF9q0a9sCpvs2kDpJtIh/oeIhndzwCemV8vTaEQ==
X-Received: by 2002:a05:6a00:13a8:b0:77d:b0cf:ca14 with SMTP id
 d2e1a72fcca58-79387a28134mr27668039b3a.22.1760462624919; 
 Tue, 14 Oct 2025 10:23:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb116basm15741913b3a.30.2025.10.14.10.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:23:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] accel/tcg: Hoist first page lookup above pointer_wrap
Date: Tue, 14 Oct 2025 10:23:41 -0700
Message-ID: <20251014172341.243858-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014172341.243858-1-richard.henderson@linaro.org>
References: <20251014172341.243858-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

For strict alignment targets we registered cpu_pointer_wrap_notreached,
but generic code used it before recognizing the alignment exception.
Hoist the first page lookup, so that the alignment exception happens first.

Cc: qemu-stable@nongnu.org
Buglink: https://bugs.debian.org/1112285
Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3010dd4f5d..631f1fe135 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1742,6 +1742,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     bool crosspage;
+    vaddr last;
     int flags;
 
     l->memop = get_memop(oi);
@@ -1751,13 +1752,15 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     l->page[0].addr = addr;
     l->page[0].size = memop_size(l->memop);
-    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
+    l->page[1].addr = 0;
     l->page[1].size = 0;
-    crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
+    /* Lookup and recognize exceptions from the first page. */
+    mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+
+    last = addr + l->page[0].size - 1;
+    crosspage = (addr ^ last) & TARGET_PAGE_MASK;
     if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
-
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
             mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
@@ -1767,18 +1770,18 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         }
     } else {
         /* Finish compute of page crossing. */
-        int size0 = l->page[1].addr - addr;
+        vaddr addr1 = last & TARGET_PAGE_MASK;
+        int size0 = addr1 - addr;
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
-
         l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
-                                                         l->page[1].addr, addr);
+                                                         addr1, addr);
 
         /*
-         * Lookup both pages, recognizing exceptions from either.  If the
-         * second lookup potentially resized, refresh first CPUTLBEntryFull.
+         * Lookup and recognize exceptions from the second page.
+         * If the lookup potentially resized the table, refresh the
+         * first CPUTLBEntryFull pointer.
          */
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
         if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
-- 
2.43.0


