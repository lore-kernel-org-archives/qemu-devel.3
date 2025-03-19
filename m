Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBDCC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPc-0000Ab-Bu; Wed, 19 Mar 2025 04:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOf-0007zn-BD
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOb-0004Oo-7u
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22622ddcc35so14259225ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371403; x=1742976203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woS5shbhb+81BaLCop8v0D00aFw49LjawXYA3y+JHPY=;
 b=UqkoN2B2qv35BCr25S1VDkmGA0OJO89y6PeixV840amIWQt7EsRMMSGR/+dLhSBQPi
 ko3G/WQW/mmqLKuhMg+KC/VWnWQdXXGoQxzekGdVsN0f22kDk78w1HoIb+t6I3r8hf0f
 r77/Fckux1oVAzoSfbgw5z28haZFMMhRJ15g3ysYzeIQw0AO20VJN09rORtaS8VGkw+b
 2Hp0Ue14t8z7Z2eXsEZUCREpsg1Q6wjzg5Z+Redj0hH0HNBxSshf7mJ2eNTsFDyhL/h5
 E09JUa6C6g/GPl29bDnHPfrMC5/Aq+d0Q9XXIZcb4X4jw0siNQt7wjevArsjTgFdbH3s
 KbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371403; x=1742976203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woS5shbhb+81BaLCop8v0D00aFw49LjawXYA3y+JHPY=;
 b=anC5PARaEROOsw9enHGiCSV1osp02CsIebMMyyppyaXa7EG1hlYpmaY59BDfICrd6l
 UguYY2WgRM9xUVHRDqWsubNOQJmfsQ+xCHcIGVlfkhhpzlTa7nkyb7WhwV7/4zYekyI8
 YZJGxki/gGEYqR0eoFWF1P+JsqQQ77LS3OxDPYLzC8h6cloMJT7ariCs2bcvOSCSX5wH
 xw4D0os7zisnBuZWq/Ka4oGleODII+maPKxmihQSZ9Cr3rwCvCujK46ouCiyPXzqtPxD
 cdAKxbzLicceC3VVFCxJJivb+7vRuAYVFeA9dkSMsMrZH/m+yxg0NPPkiU1dDR05f8MO
 tLqA==
X-Gm-Message-State: AOJu0YzAyyBYnavSrJr7hS7yrzGf9PYH+bxUPNAjFJn335wXnvwhZXal
 E7E+lnIYg/8ko62a2yOO8+0Q2/43xjLiih8UjdRmh3mGLzkCQf03jqeSHw==
X-Gm-Gg: ASbGncuif2vgrVLLjP0s0RbIbyAJD5H8O6ymWPLo1TG1dIPa5UZKTz48Wo03hP2wotY
 hFF5QlFwn99abhmeqqyHkfWaZ09wM1MN4Dc/mgvWsaaMRf7Uc7OAKq9IOwgQvyHkAZE3YxzAY67
 VcFLLbOD055N7Hvs8J2JM9ssAHxi7sasWcp9/XClWrSR+Yw90HorcUYnMUqFBcZqlxREnkj9YVS
 77SdYw5nZysPmqev3mx04PTUH9Oki6Ls3cg0s/bpFB4y4U7EdEGdrNlxGwjnV0mb0p/3LVugcC4
 M0o3SPj+Pn3Qc7LJPOHXr8n+rfRRLFlcFbgEn8GT0VoU4STJjsCThcnFY+u7qJQ9CXgm+FQqHFt
 Uyo+x/OFJfkCgCNtPG2+XCCjRqKa2LG3ERf8g1KFhc6W5VRdc
X-Google-Smtp-Source: AGHT+IFWrlOzBsrKezCIgsKRr5rtUp42EBhYULlSvO1ntd0HyC8w8Xkasi7WEwqlog5NQrRZfnoKoA==
X-Received: by 2002:a17:902:da8c:b0:224:1074:63a0 with SMTP id
 d9443c01a7336-22649a80c34mr24066465ad.34.1742371403166; 
 Wed, 19 Mar 2025 01:03:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/10] optimize the memory probing for vector fault-only-first
 loads.
Date: Wed, 19 Mar 2025 18:03:00 +1000
Message-ID: <20250319080308.609520-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Paolo Savini <paolo.savini@embecosm.com>

Fault-only-first loads in the RISC-V vector extension need to update
the vl with the element index that causes an exception.
In order to ensure this the emulation of this instruction used to probe the
memory covered by the load operation with a loop that iterated over each element
so that when a flag was raised it was possible to set the vl to the
corresponding element index.
This loop was executed every time whether an exception happened or not.

This commit removes the per element memory probing from the main execution path
and adds a broad memory probing first. If this probing raises any flag that is
not a watchpoint flag (that per standard is allowed by this instruction) we
proceed with the per element probing to find the index of the element causing
the exception and set vl to such index.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250221155320.59159-2-paolo.savini@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 103 ++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7773df6a7c..71b823d5d4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -633,47 +633,69 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, offset, remain, page_split, elems;
+    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
+    int flags;
+    void *host;
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    /* probe every access */
-    for (i = env->vstart; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            continue;
-        }
-        addr = adjust_addr(env, base + i * (nf << log2_esz));
-        if (i == 0) {
-            /* Allow fault on first element. */
-            probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
-        } else {
-            remain = nf << log2_esz;
-            while (remain > 0) {
-                void *host;
-                int flags;
-
-                offset = -(addr | TARGET_PAGE_MASK);
-
-                /* Probe nonfault on subsequent elements. */
-                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
-                                           mmu_index, true, &host, 0);
-
-                /*
-                 * Stop if invalid (unmapped) or mmio (transaction may fail).
-                 * Do not stop if watchpoint, as the spec says that
-                 * first-fault should continue to access the same
-                 * elements regardless of any watchpoint.
-                 */
-                if (flags & ~TLB_WATCHPOINT) {
-                    vl = i;
-                    goto ProbeSuccess;
-                }
-                if (remain <= offset) {
-                    break;
+    addr = base + ((env->vstart * nf) << log2_esz);
+    page_split = -(addr | TARGET_PAGE_MASK);
+    /* Get number of elements */
+    elems = page_split / msize;
+    if (unlikely(env->vstart + elems >= env->vl)) {
+        elems = env->vl - env->vstart;
+    }
+
+    /* Check page permission/pmp/watchpoint/etc. */
+    flags = probe_access_flags(env, adjust_addr(env, addr), elems * msize,
+                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+
+    /* If we are crossing a page check also the second page. */
+    if (env->vl > elems) {
+        addr_probe = addr + (elems << log2_esz);
+        flags |= probe_access_flags(env, adjust_addr(env, addr_probe),
+                                    elems * msize, MMU_DATA_LOAD, mmu_index,
+                                    true, &host, ra);
+    }
+
+    if (flags & ~TLB_WATCHPOINT) {
+        /* probe every access */
+        for (i = env->vstart; i < env->vl; i++) {
+            if (!vm && !vext_elem_mask(v0, i)) {
+                continue;
+            }
+            addr_i = adjust_addr(env, base + i * (nf << log2_esz));
+            if (i == 0) {
+                /* Allow fault on first element. */
+                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD);
+            } else {
+                remain = nf << log2_esz;
+                while (remain > 0) {
+                    offset = -(addr_i | TARGET_PAGE_MASK);
+
+                    /* Probe nonfault on subsequent elements. */
+                    flags = probe_access_flags(env, addr_i, offset,
+                                               MMU_DATA_LOAD, mmu_index, true,
+                                               &host, 0);
+
+                    /*
+                     * Stop if invalid (unmapped) or mmio (transaction may
+                     * fail). Do not stop if watchpoint, as the spec says that
+                     * first-fault should continue to access the same
+                     * elements regardless of any watchpoint.
+                     */
+                    if (flags & ~TLB_WATCHPOINT) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+                    if (remain <= offset) {
+                        break;
+                    }
+                    remain -= offset;
+                    addr_i = adjust_addr(env, addr_i + offset);
                 }
-                remain -= offset;
-                addr = adjust_addr(env, addr + offset);
             }
         }
     }
@@ -685,15 +707,6 @@ ProbeSuccess:
 
     if (env->vstart < env->vl) {
         if (vm) {
-            /* Calculate the page range of first page */
-            addr = base + ((env->vstart * nf) << log2_esz);
-            page_split = -(addr | TARGET_PAGE_MASK);
-            /* Get number of elements */
-            elems = page_split / msize;
-            if (unlikely(env->vstart + elems >= env->vl)) {
-                elems = env->vl - env->vstart;
-            }
-
             /* Load/store elements in the first page */
             if (likely(elems)) {
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
-- 
2.48.1


