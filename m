Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE1FC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbj-0003TB-BS; Thu, 23 May 2024 19:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHb5-0000Wx-Sj; Thu, 23 May 2024 19:11:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHb3-0006R2-VF; Thu, 23 May 2024 19:11:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso294942b3a.1; 
 Thu, 23 May 2024 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505899; x=1717110699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuLmmK0ZiA7UO80ik8S5jqOuyqVZgLfQb9PxXw9R3PU=;
 b=hRSo4Q9az8IQWPHKC4DRsbi8VFxUVPxu4Fszc2r4Abjd4ZR+4GXXcdX5HCwifG5W4t
 JCfU2D/qBQs7lLVu42yUMH1rVORH2yDl0Gxkq6hh5wA/TPUFun3uDjNTPkDLZLNK78Tq
 IQqFwibUhNU8nUkrA6et9uRnWZfM55hHb4Q5+BaeFq4Yhd/yqIdl+VNi8IjTufB3P9QQ
 CDR/sxe0s9JwKXAgMXlx3Pl1nmS9vQEAPOlJtcNxij2xMuir3ENkrdG5/fUClgEMeU49
 o1UERbMgqVjLw6wH/A0cE+8ubC+DwUJMmRHsYQEC4BVUwYEIIryJBB/TVr8yl3wHKz6f
 10ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505899; x=1717110699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuLmmK0ZiA7UO80ik8S5jqOuyqVZgLfQb9PxXw9R3PU=;
 b=jUSb9fV4UHi9294xr1L8O6sVzRgh3lOPxbiB8R8IHVg0Ewx19M049BuG3R7vzkvC+L
 CJTkJIMrF8V1y6NyHsf5iC7FeyKhAEx3nPFZx6riyAqtjjxTmIwofq5uGurPVG6gBMKn
 fsB3msLncSvSgyiTjPUg/MCxM7/uPqzT7/v6k0WQoKYY+XkgGYIwKbYAIWW/ZbldlWAi
 jcD/pQTYLHObPpeRh+q/wdL0dDpcOYHr2HcMLw864PuQqDqPFFJ1EoDToSvh0uFPeOpG
 q15OnjJS6TfNZ9JyhMBEu27c0NZqV8TbJ94NHQJLsKqb3N0oTColVq89SDNyZ7HzNIQK
 a+1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFumY+YbLavUWXzWtUMb2N78o64Atw63VqQU9jcn5Y3nqbDfpXk6k2w4Gj5HUkCIOeABxPKE76DatpVO8gOKZcYfOB
X-Gm-Message-State: AOJu0YwGa+e+VTGrLlnB1Bc3Yf8mTpmJpGwb18RgPdQ8kT101LF7rFI/
 ujJYZ4u2icJBRCq96ULdllD5h3q/jVuo3sNtk2L1DoEU+V8ZJWnXA180gg==
X-Google-Smtp-Source: AGHT+IF/tOqlJYqc5SUBVJjFLJJbwAPodyw2on0eyUbvbqCFKwUMg200md2+uXCtmHvvutbEhadJ0A==
X-Received: by 2002:a05:6a21:920b:b0:1b1:ebf2:d767 with SMTP id
 adf61e73a8af0-1b212df0c74mr1165922637.43.1716505899361; 
 Thu, 23 May 2024 16:11:39 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 72/72] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
Date: Fri, 24 May 2024 09:07:45 +1000
Message-ID: <20240523230747.45703-73-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
pp_check() in mmu_common.c, merge these to remove duplicated code.
Define the common function as static lnline otherwise exporting the
function from mmu-hash32.c would stop the compiler inlining it which
results in slightly lower performance.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
[np: move ppc_hash32_pp_prot inline without changing it]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 45 -----------------------------------------
 target/ppc/mmu-hash32.h | 45 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu_common.c | 44 ++--------------------------------------
 3 files changed, 47 insertions(+), 87 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 1e8f1df0f0..d5f2057eb1 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -37,51 +37,6 @@
 #  define LOG_BATS(...) do { } while (0)
 #endif
 
-static int ppc_hash32_pp_prot(int key, int pp, int nx)
-{
-    int prot;
-
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        default:
-            abort();
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            prot = 0;
-            break;
-
-        case 0x1:
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
-            break;
-
-        default:
-            abort();
-        }
-    }
-    if (nx == 0) {
-        prot |= PAGE_EXEC;
-    }
-
-    return prot;
-}
-
 static int ppc_hash32_pte_prot(int mmu_idx,
                                target_ulong sr, ppc_hash_pte32_t pte)
 {
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 7119a63d97..f0ce6951b4 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -102,6 +102,51 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
+static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
+{
+    int prot;
+
+    if (key == 0) {
+        switch (pp) {
+        case 0x0:
+        case 0x1:
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+
+        default:
+            abort();
+        }
+    } else {
+        switch (pp) {
+        case 0x0:
+            prot = 0;
+            break;
+
+        case 0x1:
+        case 0x3:
+            prot = PAGE_READ;
+            break;
+
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
+
+        default:
+            abort();
+        }
+    }
+    if (nx == 0) {
+        prot |= PAGE_EXEC;
+    }
+
+    return prot;
+}
+
 typedef struct {
     uint32_t pte0, pte1;
 } ppc_hash_pte32_t;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2c75e53250..e2542694f0 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -77,44 +77,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 /*****************************************************************************/
 /* PowerPC MMU emulation */
 
-static int pp_check(int key, int pp, int nx)
-{
-    int access;
-
-    /* Compute access rights */
-    access = 0;
-    if (key == 0) {
-        switch (pp) {
-        case 0x0:
-        case 0x1:
-        case 0x2:
-            access |= PAGE_WRITE;
-            /* fall through */
-        case 0x3:
-            access |= PAGE_READ;
-            break;
-        }
-    } else {
-        switch (pp) {
-        case 0x0:
-            access = 0;
-            break;
-        case 0x1:
-        case 0x3:
-            access = PAGE_READ;
-            break;
-        case 0x2:
-            access = PAGE_READ | PAGE_WRITE;
-            break;
-        }
-    }
-    if (nx == 0) {
-        access |= PAGE_EXEC;
-    }
-
-    return access;
-}
-
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code)
 {
@@ -137,7 +99,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     target_ulong ptem, mmask;
-    int access, ret, pteh, ptev, pp;
+    int ret, pteh, ptev, pp;
 
     ret = -1;
     /* Check validity and table match */
@@ -156,11 +118,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                     return -3;
                 }
             }
-            /* Compute access rights */
-            access = pp_check(ctx->key, pp, ctx->nx);
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = access;
+            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-- 
2.43.0


