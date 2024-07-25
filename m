Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1E8C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ml-00032g-DE; Thu, 25 Jul 2024 19:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mc-0002g1-TS; Thu, 25 Jul 2024 19:59:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mb-0001hu-5A; Thu, 25 Jul 2024 19:59:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so315400a91.0; 
 Thu, 25 Jul 2024 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951951; x=1722556751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93c6+H2hrcICDkkxEDbmglLCCDcvdLoQiaSIH3qqU+w=;
 b=XpYjlLTc5xQm4aActKDWJI48OxhBkBPUfN8lFHYjm2vRvYLfmfHfOOs7Pu2+TKh6rR
 s97/QT1/YKfynI8N+jkilTehz5CysULS+/2F9jmZL5OtiDDjCW0IYdzcRnyylcNio1ke
 aOmLkttWc/cF2m8itLQEnN8EG5hNZYMXKpV09hyV+SRBaUDu8CkA2tL/BhhzbknfRpFf
 MW6gyJFsS6cPdBHe3ieUGaYgHQEhcOFU1WzLUQpFj9fiHPJgHmMzLPhSKHyICp/xoBg/
 ttzfEEqQyAbGbd14WRoc9RWFBZ4zXxu1zJHXrOq1W9qaXKYLoaQUeh/y/jzAC6QHsCtn
 JAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951951; x=1722556751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93c6+H2hrcICDkkxEDbmglLCCDcvdLoQiaSIH3qqU+w=;
 b=DeAIKnB72Qg6+2G8MmPWyYrmr9tKNDmgg5DPIrDO6E+ezZEE/qmLDv83hiMophjJ3G
 PxngF3gkhxcExD9O8KMCDTm9g3EdKq5yLLQ0E/MQv9FLtYTsB+M3dGSO5FIOwbjnwrrk
 jaKYflFZXInpjQZQM9gVcplX+zE5NLH4Uav8IcktMGCeUPLhLiBQkZQe92em1t2VfuY8
 rnPRoM92x22krGD/1uEDzwAm7DjgqOsTHmGWREyTWmc3Bq5PC+gq1TExLYjDTcUstbH1
 IbMaSfIHRB/1C8wUVdpyzqQ28xOT7kea1KyQ5wyxnjeHdemDJpiFPs00E+Vm5mNxdTFZ
 9G1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy3c26aKxQunPSg8RAXMi0PpPPTJrZzuZ20oLyK8SPYJbKvuUyUJCUJgdOy3LuXgh++60UtXMm3lHWcSQ5+tTmA5/9
X-Gm-Message-State: AOJu0YwHYqC5rP+/dM3v8RlXXiJM801D3Tmpd3WQtem0+ghBs8yy6xs7
 cLJPHppr+w+vJ2D+gNIflQMeD/BxksB+73B5UMzJoQQLgZiWUlamYt0Nfw==
X-Google-Smtp-Source: AGHT+IEslX8eI463/2mps+z95v6KA5136VtPqHa6xEqowTzdPKL6lx1MDV8vwHYpZSAkQQ+SQLMtUw==
X-Received: by 2002:a17:90b:4a52:b0:2c9:755f:d4ae with SMTP id
 98e67ed59e1d1-2cf237871dcmr5182377a91.8.1721951951159; 
 Thu, 25 Jul 2024 16:59:11 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 82/96] target/ppc: Add function to get protection key for
 hash32 MMU
Date: Fri, 26 Jul 2024 09:53:55 +1000
Message-ID: <20240725235410.451624-83-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

Add a function to get key bit from SR and use it instead of open coded
version.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 9 ++++++---
 target/ppc/mmu-hash32.h | 5 +++++
 target/ppc/mmu_common.c | 3 +--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8a446c8a7d..93559447ff 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -42,7 +42,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
 {
     unsigned pp, key;
 
-    key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
+    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
     pp = pte.pte1 & HPTE32_R_PP;
 
     return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
@@ -145,7 +145,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    int key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
 
     qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
 
@@ -206,7 +205,11 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
         cpu_abort(cs, "ERROR: insn should not need address translation\n");
     }
 
-    *prot = key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
+    if (ppc_hash32_key(mmuidx_pr(mmu_idx), sr)) {
+        *prot = PAGE_READ | PAGE_WRITE;
+    } else {
+        *prot = PAGE_READ;
+    }
     if (check_prot_access_type(*prot, access_type)) {
         *raddr = eaddr;
         return true;
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index bc4eedbecc..5902cf8333 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -102,6 +102,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
+static inline bool ppc_hash32_key(bool pr, target_ulong sr)
+{
+    return pr ? (sr & SR32_KP) : (sr & SR32_KS);
+}
+
 static inline int ppc_hash32_prot(bool key, int pp, bool nx)
 {
     int prot;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 339df377e8..1ed2f45ac7 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -310,8 +310,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
 
     sr = env->sr[eaddr >> 28];
-    ctx->key = (((sr & 0x20000000) && pr) ||
-                ((sr & 0x40000000) && !pr)) ? 1 : 0;
+    ctx->key = ppc_hash32_key(pr, sr);
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
-- 
2.45.2


