Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24603CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYh-0002bq-Q4; Thu, 14 Aug 2025 08:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYQ-00025n-EG
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:39 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYM-0004Ni-PK
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:37 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b47173a7e50so688804a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176369; x=1755781169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdo4eXfghXIxBtW7gGLE9m9wdInFFP/OSUyrEzGuH10=;
 b=njMNS517BsMxeezFBT0knnO+Bp7Vns0lsSAhUiVjKsradGXKcUjQWZtx38R7oO4yz8
 Ccg1xt/Tq2XFRALFMN/YkiDmFV3OKON66M5VtV5fW2db8Z/qdf4tj5wSqUC5KUzFQv7E
 RuleMARGkLV4SzPO+7F2r6O4hAT/HhdcU56z+u28GkIWZfxqdR+OJ4BhV1Jxs2X1N+Mu
 PhyTlUb4QeULciODpPmFGvGdd+48/6VoICiYfi04Un3QaBLWZFElxr2tKYiD5lk4wvAv
 pSqbWqfD3xaWIUaxcHedz5KzXSkotGR6qRdVJ1RajuwJNmPLJo+mpydEGCspPYpIYwNp
 6QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176369; x=1755781169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdo4eXfghXIxBtW7gGLE9m9wdInFFP/OSUyrEzGuH10=;
 b=IobWvTJWYbXSaA/WNoqKSObd5O+vf2qucPJVLanvF14hGZYBhhMfZKlAE8ckM4OoBJ
 Jn7icdJnF9TfYHCI2fHXUubzFhvcZ9VZ4olZPDGzV7a2hGrKaaL183deAZ5kPGRBM/8g
 diadFhbIfMji9Ldl1nfz+BdT03qqoaE8cJnilzQjhXZPzqoDjdQJXuVAzhFt6LNmUSOn
 oXqVe8Piw/ep6sKNZqtSIfkKgO+vVw0bnpC4eVSV0f2KVw7AQCIULy+OMnM9kEsjqi/t
 4aaRjz3VIUzoj1LkEDxkC8kYT4vcgOLr6gu7sMwiLDjMudlC9KSojL4lhY13IArKmGre
 xlOQ==
X-Gm-Message-State: AOJu0Yznnsap4hYlPgeDaG4svjHoETCKs4sHo5Kw8CdGqDx2wqR66i0N
 N1xQD7/x92qu3KTxrqEHEmsp6e8fgmTKfnVPSFjPepf7tofzRPxde9nRjKqJlX0Jhk41QRXCb5p
 dOlmkqQs=
X-Gm-Gg: ASbGncuwPc4SHSoyeu20b1sFl9TOyHwPlWJ7JZn9rV0MY0LBZ5/q1t0ivJ4S1aWQGPQ
 n/UdMui25YbmrkeZ/PUw0PYcvX/KebPfyjNSsEBx8sXzuPRi+kUM/EFJ7+Q4OuIe8W1cZtAy3tp
 3ZLZEak3kQgxko/w0UrQ2QIh/Uhta+p5X/Lf1xlEqp3rrgtxjibNQTM1ZQEuBHC6H9e8VFGpv1l
 9owhvWAEz477LZQGwZ8mKTaBTiAH0qMN/IFGcwdVlcQMo0AVOxSTZtSrXx7u4xrTK+u0mNcVsKS
 jDpBzRqQohCIcG+7o8DvIA3jlA72L19nhvo7DHARx25kClD2Ij4mIoiLKgDc79t38bGfrgF53Z/
 M+aoJv/uYYMVnpQZ3WAtKgE5mRprVFc9XXxxbKpybt7A2QcbZ2DbZN5ZcFA==
X-Google-Smtp-Source: AGHT+IEvxep0ddBysjSncdLsBtT9oAN/OtvciwliqINkZ20j0iir6ZhDTscjlsIwpA1fZq9BZHpihA==
X-Received: by 2002:a17:903:380e:b0:235:ec11:f0ee with SMTP id
 d9443c01a7336-244584db9damr34586375ad.14.1755176369489; 
 Thu, 14 Aug 2025 05:59:29 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 27/85] include/hw/core/cpu: Introduce cpu_tlb_fast
Date: Thu, 14 Aug 2025 22:56:54 +1000
Message-ID: <20250814125752.164107-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Encapsulate access to cpu->neg.tlb.f[] in a function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h        |  7 +++++++
 accel/tcg/cputlb.c           | 16 ++++++++--------
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1153cadb70..bd835b07d5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -593,6 +593,13 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
     return (CPUArchState *)(cpu + 1);
 }
 
+#ifdef CONFIG_TCG
+static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
+{
+    return &cpu->neg.tlb.f[mmu_idx];
+}
+#endif
+
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus_queue;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d324f33339..2a6aa01c57 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -129,7 +129,7 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
 static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
                                   vaddr addr)
 {
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
+    uintptr_t size_mask = cpu_tlb_fast(cpu, mmu_idx)->mask >> CPU_TLB_ENTRY_BITS;
 
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
@@ -138,7 +138,7 @@ static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
 static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
 {
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+    return &cpu_tlb_fast(cpu, mmu_idx)->table[tlb_index(cpu, mmu_idx, addr)];
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
@@ -292,7 +292,7 @@ static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
                                         int64_t now)
 {
     CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
-    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+    CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
 
     tlb_mmu_resize_locked(desc, fast, now);
     tlb_mmu_flush_locked(desc, fast);
@@ -331,7 +331,7 @@ void tlb_init(CPUState *cpu)
     cpu->neg.tlb.c.dirty = 0;
 
     for (i = 0; i < NB_MMU_MODES; i++) {
-        tlb_mmu_init(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i], now);
+        tlb_mmu_init(&cpu->neg.tlb.d[i], cpu_tlb_fast(cpu, i), now);
     }
 }
 
@@ -342,7 +342,7 @@ void tlb_destroy(CPUState *cpu)
     qemu_spin_destroy(&cpu->neg.tlb.c.lock);
     for (i = 0; i < NB_MMU_MODES; i++) {
         CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
-        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
+        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, i);
 
         g_free(fast->table);
         g_free(desc->fulltlb);
@@ -667,7 +667,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
                                    unsigned bits)
 {
     CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
-    CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
+    CPUTLBDescFast *f = cpu_tlb_fast(cpu, midx);
     vaddr mask = MAKE_64BIT_MASK(0, bits);
 
     /*
@@ -923,7 +923,7 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
-        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
         unsigned int n = tlb_n_entries(fast);
         unsigned int i;
 
@@ -1316,7 +1316,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
-            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
+            CPUTLBEntry tmptlb, *tlb = &cpu_tlb_fast(cpu, mmu_idx)->table[index];
 
             qemu_spin_lock(&cpu->neg.tlb.c.lock);
             copy_tlb_helper_locked(&tmptlb, tlb);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 3b088b7bd9..caf79c742d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1668,7 +1668,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr_reg;
 
-        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+        /* Load CPUTLBDescFast.{mask,table} into {tmp0,tmp1}. */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
         tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 836894b16a..4069508272 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1420,7 +1420,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr;
 
-        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
+        /* Load CPUTLBDescFast.{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
         tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.43.0


