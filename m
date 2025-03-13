Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09B1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshql-0006nI-PY; Thu, 13 Mar 2025 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tshqj-0006jE-S8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:39:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tshqZ-0002zg-Lq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:39:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso8231025e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741869570; x=1742474370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbRR7H53hotLFHHWC9P26n2OfTWPsqKY3P8IXBsMAgw=;
 b=fmxa26Wp1wUOb/lCMEHMGdxFmm9F9gL/gfdrP8e+fux4igAOQ9q6seKx5oyPat8hQ0
 KHThbgHlaoMrjuOJv0qP7kW0xkRF6C+D1g81bL+h8NzZi0/J96nE5Rd+u7j13MHYXgd1
 qjWBfByECGA8BFiqa/Z0+WtwdYunpyB2yUMOJkPrXy1qsNrF+HePhHKxNhGFE8pyH+iF
 NPJ+oYYEjl70nmS9uFxjyKpNv8VBFhhi69rBumT3hm18Wd5jMl2WQreFVWIsMU50Gt3R
 ALeZTU3bB6ZpI/VPBy3MUZd8RprQlvWtKhzxXW6781gkwdfzo6E/tZ6tFf/BXFeQkYOJ
 J+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869570; x=1742474370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbRR7H53hotLFHHWC9P26n2OfTWPsqKY3P8IXBsMAgw=;
 b=CVs0BgwHEXSkM7/suB8EK+Y9OxUc8diLjfSCwbMCOW5BK6IzV1AxfJORaQ32dalq2L
 BrSdVzcCpbOpB9rjdnS1lFxWbHGduPa546fEnCTkvaPNwP6CnS/FlG9xFE5sMVDvySeW
 /rZFi0M8yg+OIogb9WPtwX6PkEKLEXneBz8Vvge/yyU54V0LWzpS79zZ7uKZBeftKQEn
 SUP6tieYQ8uvBJdWlt/tcbMBEhtkcmtfJn+nfd4OVMr09gareW8RudV9dPnEUUx2sPtq
 lxcpH/H6jl5id31nuX7vLVemKvt6p4HRebnrD9Ud70iSrXU+BaCwwLS/1xhhdGUe4tTs
 pI5A==
X-Gm-Message-State: AOJu0YzL4Poz9gTuwW26wNJUEN7YgK2P+Uh8h8wr9893HsqzeKp/kPJf
 TiQWWPyRLJAGaiz/CX++uyiNLMie03drTq8AA0kTw38NkzlZZiy8Tl+7ywZiI1db3g/3S3xA50+
 lhw/NTg==
X-Gm-Gg: ASbGncs4ni7Li5zKM4g7NhXW/oxxW3T7rZ5U88XB7BykAL3Soka6YE8P2HO2Cm7vbD+
 0UCITV0qOblNGnNCeBSapnRVmXyEjx8C5qp4ap13AX3yv5iuO/VSCdpyOdXiyO/24Zz/v7Ffshl
 CVSuvuH8ubpPNzKYwiXSLzVztfnlXbSLV5ndpX3AU2nT1zfhY18cDhxDUkhHPszquezHDqPhpRz
 rHR/Gmp8DVn55oRT83k9Xrt9rCb5I4u9OiQ/rFdtRAZy3d/SQsRiZri2Ukfq8S5OSNWa1azR3LV
 NHT4wjLSjvW0OdpIgVILO1ubYw4XUMxyi8KXKN7/jKnyfO4a2ZO9QKfDXSzCsgpj7WBDdApn2NJ
 5xQ2E5qaMuw==
X-Google-Smtp-Source: AGHT+IGkaBbwPII0Kz10ecShYMfeuFg82sEg9Q09ObOIIeFq2bJTOtfrqM0SdzjwB0fWPw9U9y/2+Q==
X-Received: by 2002:a05:600c:46d3:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43c602223f0mr258041045e9.30.1741869570338; 
 Thu, 13 Mar 2025 05:39:30 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5ccasm52092665e9.26.2025.03.13.05.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 05:39:30 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [PATCH 1/1 v2] [RISC-V/RVV] Expand the probe_pages helper function to
 handle probe flags.
Date: Thu, 13 Mar 2025 12:39:26 +0000
Message-ID: <20250313123926.374878-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313123926.374878-1-paolo.savini@embecosm.com>
References: <20250313123926.374878-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32a.google.com
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

This commit expands the probe_pages helper function in
target/riscv/vector_helper.c to handle also the cases in which we need access to
the flags raised while probing the memory and the host address.
This is done in order to provide a unified interface to probe_access and
probe_access_flags.
The new version of probe_pages can now act as a regular call to probe_access as
before and as a call to probe_access_flags. In the latter case the user need to
pass pointers to flags and host address and a boolean value for nonfault.
The flags and host address will be set and made available as for a direct call
to probe_access_flags.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 57 +++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 67b3bafebb..4bd511a03d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -114,25 +114,42 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
  * It will trigger an exception if there is no mapping in TLB
  * and page table walk can't fill the TLB entry. Then the guest
  * software can return here after process the exception or never return.
+ *
+ * This function can also be used when direct access to probe_access_flags is
+ * needed in order to access the flags. If a pointer to a flags operand is
+ * provided the function will call probe_access_flags instead, use nonfault
+ * and update host and flags.
  */
-static void probe_pages(CPURISCVState *env, target_ulong addr,
-                        target_ulong len, uintptr_t ra,
-                        MMUAccessType access_type)
+static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
+                        uintptr_t ra, MMUAccessType access_type, int mmu_index,
+                        void **host, int *flags, bool nonfault)
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
-    int mmu_index = riscv_env_mmu_index(env, false);
 
-    probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                 mmu_index, ra);
+    if (flags != NULL) {
+        *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                    access_type, mmu_index, nonfault, host, ra);
+    } else {
+        probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                     mmu_index, ra);
+    }
+
     if (len > curlen) {
         addr += curlen;
         curlen = len - curlen;
-        probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     mmu_index, ra);
+        if (flags != NULL) {
+            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                        access_type, mmu_index, nonfault,
+                                        host, ra);
+        } else {
+            probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                         mmu_index, ra);
+        }
     }
 }
 
+
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -332,8 +349,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
-                               mmu_index, true, &host, ra);
+    probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
+                true);
 
     if (flags == 0) {
         if (nf == 1) {
@@ -632,7 +649,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t vma = vext_vma(desc);
     target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags;
+    int flags, probe_flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -646,15 +663,15 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), elems * msize,
-                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
+                &flags, true);
 
     /* If we are crossing a page check also the second page. */
     if (env->vl > elems) {
         addr_probe = addr + (elems << log2_esz);
-        flags |= probe_access_flags(env, adjust_addr(env, addr_probe),
-                                    elems * msize, MMU_DATA_LOAD, mmu_index,
-                                    true, &host, ra);
+        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
+                    mmu_index, &host, &probe_flags, true);
+        flags |= probe_flags;
     }
 
     if (flags & ~TLB_WATCHPOINT) {
@@ -666,16 +683,16 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
             addr_i = adjust_addr(env, base + i * (nf << log2_esz));
             if (i == 0) {
                 /* Allow fault on first element. */
-                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD);
+                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD,
+                            mmu_index, &host, NULL, false);
             } else {
                 remain = nf << log2_esz;
                 while (remain > 0) {
                     offset = -(addr_i | TARGET_PAGE_MASK);
 
                     /* Probe nonfault on subsequent elements. */
-                    flags = probe_access_flags(env, addr_i, offset,
-                                               MMU_DATA_LOAD, mmu_index, true,
-                                               &host, 0);
+                    probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
+                                mmu_index, &host, &flags, true);
 
                     /*
                      * Stop if invalid (unmapped) or mmio (transaction may
-- 
2.34.1


