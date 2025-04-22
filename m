Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5884DC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPe-0006t2-Iv; Tue, 22 Apr 2025 15:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLk-0000mB-B1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLg-0006eK-8l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224019ad9edso79385985ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350323; x=1745955123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7VCm6mlHRL+Ejn4ewBmyxmL8FXzxR8z3K0tghqh0r4s=;
 b=NGPlTD7hrYGOuG4Allx3iBhaoCJDTKDzTE3Tojee9v3iqigxw34G1IdbBhNnPnmszz
 mT3QwkGHNiK4v3QNR5lGunHkr5u5bQaq+nBA8uXOY2IZFWeNg5pxXkquLsiVKObR5Ict
 2SolhP1kfzsEvpryNNTF4caPqrU4Mb0LxJ95TmvXQxFUxgdJ5olqmfOtMyD7l/brsNXB
 0qOyikPaAoL2VMQX+gpDG47d7tk1yEFWJVNcHuusx2yxUIAh38s5BNr6LzQ2vfNq8JY3
 WEJ1dQvZTbsIq3g7QsC9UUUhHgVb3Pn8iqe58vEwhI/mRK8Q6iKugAHzPzY8CF8tmKmg
 sWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350323; x=1745955123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VCm6mlHRL+Ejn4ewBmyxmL8FXzxR8z3K0tghqh0r4s=;
 b=ksoIibSlhfWM9a1QvlTL/qwAcFDcQHR3QgEEcUfCnXkFn3Nro7xlEMmjVnuXFmEEHF
 pxn3ckZ/V+62ikTW97R5UJL5j3tTmeUhRSs451v1RjZg7nJ6JFH1lh3noNFQwHpomnqW
 cbAKNI/r5k0DcIMjhD+O6D0eZkUKdhMDGK4RW5+RehrzhwZ45NXYEOzIn0VzqrvBzSLz
 PsQHg5AmHPvSBttuNMrJnqMMI51JHtCWE7qwyilXnYZ5yeIUtPJuBAnMuATHCjSekPJh
 /4MwbAUwIu3Lu5qqCk6TVwaQ861xgFY+3P6V4RjrD0Y8lCir9fuWbk8fQ4CyyBkZ9Oot
 hBsQ==
X-Gm-Message-State: AOJu0YwEMftQckHcKjDl0j+By5NjO+jI6ycnseF8333nHYEC8jekPtH8
 LGoKMypWftF9rpER0kMEe59Ll+Lp1OlwDu+GWa7sV2ZPJ4EpvcXG6IGTwipbEVa/zyAj4OGAmfK
 0
X-Gm-Gg: ASbGncuJOADx/STXgC/eFrHNkAZ+K842QORbFPLmd/LJhOpZT2Z2XTv7jKDmRbCKjsa
 9B7eqUt09VL5+cBsFo5udWpgkadkLjHuPkIu1FlrvvZqv9fWkZ1MtQ41MbUuJV/EQ2lwDqd8rNL
 s2K1hqjeK518bfaoHtsApGjjjiCzygfNDruaiMo3xK7xsEjYJ3bsry+o2JXKOpuIcNYxiO6XlEu
 c6HwPbFFGQchlQ1Sh87wtD/j2cNB6rBJNwcZF2jsx7YWLYjAGH8dTKptbz8Za/6hU6uHiKfkkyO
 OW6JyLI6zL6xTORyjZtpO3XPt+8RyTeqZKTIttbVmwadZhwDw/bCec8AEzNf0hOrEXTE/A2i6lU
 =
X-Google-Smtp-Source: AGHT+IGItKZjDl+HJUif+XBUeE3HHp6dQITkPixJIERk2XYFs7tYuznvoKa0CE9SaioY7sI755yrrQ==
X-Received: by 2002:a17:903:166f:b0:223:397f:46be with SMTP id
 d9443c01a7336-22c536423f9mr234234805ad.47.1745350322832; 
 Tue, 22 Apr 2025 12:32:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 064/147] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
Date: Tue, 22 Apr 2025 12:26:53 -0700
Message-ID: <20250422192819.302784-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

While we're renaming things, don't modify addr; save it for
reuse in the qatomic_set.  Compute the host address into a
new local variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 10090067f7..5df98d93d0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -882,18 +882,16 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
  *
  * Called with tlb_c.lock held.
  */
-static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
+static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent,
                                          uintptr_t start, uintptr_t length)
 {
-    uintptr_t addr = tlb_entry->addr_write;
+    const uintptr_t addr = ent->addr_write;
 
     if ((addr & (TLB_INVALID_MASK | TLB_MMIO |
                  TLB_DISCARD_WRITE | TLB_NOTDIRTY)) == 0) {
-        addr &= TARGET_PAGE_MASK;
-        addr += tlb_entry->addend;
-        if ((addr - start) < length) {
-            qatomic_set(&tlb_entry->addr_write,
-                        tlb_entry->addr_write | TLB_NOTDIRTY);
+        uintptr_t host = (addr & TARGET_PAGE_MASK) + ent->addend;
+        if ((host - start) < length) {
+            qatomic_set(&ent->addr_write, addr | TLB_NOTDIRTY);
         }
     }
 }
@@ -918,16 +916,18 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+        unsigned int n = tlb_n_entries(fast);
         unsigned int i;
-        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
 
         for (i = 0; i < n; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
+            tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
                                          start, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
+            tlb_reset_dirty_range_locked(&desc->vfulltlb[i], &desc->vtable[i],
                                          start, length);
         }
     }
-- 
2.43.0


