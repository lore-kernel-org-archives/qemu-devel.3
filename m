Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10114C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVLI-0004gD-Gy; Fri, 21 Feb 2025 10:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tlVLE-0004f1-Nm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:53:28 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tlVLC-0004FK-77
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:53:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f325ddbc2so1601110f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1740153205; x=1740758005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWZPE0CJ4XoKWyVumQRHQmTFwkDW08j4VNm/xt4Y6eo=;
 b=Ls+5B9QKEEmitbeMUH1e+PdMoyNmeY9sPPUI7vKBkLKi8m4dyHHKjBggY57z+t7Nou
 p27T8gg11HyfbGB9d/GYtUYXLnPS6nCaG7fFHl4pveyaJ8U17nNpk4d09Um8UoeL7wnT
 avI+SNjnC/92amhQMAUsW3ulMris4h5hQyDBq8lJHI5PzH06QQeyxeRmVxOqahTLKwzo
 0KjoJJ97YegsuXzRr3AEzGF1lMFbLCTLqYPxCVckUAX60i8NR0oRWO3WsHke6PHmjyMA
 TNsIx0Vf/KbyIQo7Wx18ziJec+vAsT/UXPmg1+KEhWBmgdsAY0sEHjoyevidqcYkgfuU
 jz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740153205; x=1740758005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWZPE0CJ4XoKWyVumQRHQmTFwkDW08j4VNm/xt4Y6eo=;
 b=gvoxfRIy+9Mho9gTVyrSVXXib0nAGL7SlAqrPeXauKLrrBOt4OcGB1LUPxsSX9NLc7
 M468/s4+ChyqSI2y0oArIb1dpma2qFeYmDz+SVRrR+/SMhyARS2BdipXuRN7JDt1Rwyn
 zMAvP1RD7DbJBRzu9rjnHasjoUS2pZm/NjDKDrx4vp3+2np+MQhK70dolCqs5Ln/HXX1
 Sx3Bo/OVe+hgzqFU34zdgUzQPafuLxvYYV2EnHO5jwGtZixAb22eWSF2JVL8waM3V03G
 Gea38ZFWpekp8gujfjNFvaHtnAeDZvq1P3kw/Xm7Jai9nuNXtc3i6fG3b6tjLa9nHwOD
 5nlw==
X-Gm-Message-State: AOJu0YyujJU9v7xgtS25oKzBgNVSnOZhimAfaOYMQ3Cfsdgv03udFSL+
 /O+Y/H6ymNlDobkN3friVz6US9bekNApKncN8hcvkShClXVTRxWHm3jirP1RU5Xh4ZzoL1w0rWO
 Ur+YHcQ==
X-Gm-Gg: ASbGncugY4cYL5MadV11HTBhMKlC7aEWunBneAROqp++q1RQ+XvAbygc7djCSnI3TrT
 VXuLkupFltb9DDre9uiJoycngG2yZSML1/61YevGnm5q8kx2x71llR+mNqj01tjWnYAZyTOnRQd
 M0fevmqTvi0NJAxM98zuwflm2dJ52ITsxhw+S+z1rhqW3jiz7uBUbDBBvT1N/sNrsbXxUVRSTpc
 U5NZ/UJAzGNVfmz6c5qbu3kxrD2w8CDMU+3ZQbjvsh5P8NWPMoAbB1DxB5tY0VQ/JRA8I5LlftW
 PxvS0oJUgS7ePJQZNnJ9cQ6caZmmjtGh564EjoyNnocs
X-Google-Smtp-Source: AGHT+IFC2gokp/ZX300Zs3ofEKFZTcxlW797ZK4oeltyUDnCXTxtMwJJ/rSj3vHyngcRvsULtyYhgQ==
X-Received: by 2002:a5d:64c4:0:b0:38f:6697:af91 with SMTP id
 ffacd0b85a97d-38f70825fe0mr3147442f8f.39.1740153204743; 
 Fri, 21 Feb 2025 07:53:24 -0800 (PST)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:1f03:a9f0:23a0:9bda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa1esm23510035f8f.100.2025.02.21.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:53:24 -0800 (PST)
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
Subject: [PATCH 1/1 V2] [RISC-V/RVV] optimize the memory probing for vector
 fault-only-first loads.
Date: Fri, 21 Feb 2025 15:53:20 +0000
Message-ID: <20250221155320.59159-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221155320.59159-1-paolo.savini@embecosm.com>
References: <20250221155320.59159-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x42a.google.com
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
---
 target/riscv/vector_helper.c | 103 ++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5386e3b97c..772cff8fbe 100644
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
2.34.1


