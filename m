Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9175C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbB-0001IN-7g; Thu, 23 May 2024 19:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHad-0006yz-26; Thu, 23 May 2024 19:11:15 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaa-0006IN-Bk; Thu, 23 May 2024 19:11:14 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-36dd56cf5f5so22419935ab.3; 
 Thu, 23 May 2024 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505870; x=1717110670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfWSPhuOjJhkvsLDqYZmW5geyHoP88c+PYL6wv+48vI=;
 b=cZsjh1nX/iO7fMeEj1IFKbuUM+vHS4gZikRXc3YeXDfWPr4v5SAms49Kwr4soWBt1j
 iQg3QpA1PlTX6bjB1WRMKU1P0dzyjMEJKXcoOh4690A7xxNwoh+JlzsAqHRdNKdXwkK6
 jYvrJsJT6YbZaeLsRcG4xvhsA7MHV0TTC02w0iC3aI3adrBmyDQUgEjkvYVeOivFGwPN
 8b2HXOaqN4BNhen1FNyJwwyr+B43oh22LEjlk1DSELNb40y0m+IGohw3iiJUNbZDrRWB
 C1WsCkOEJhWEB9EgCZd7npkdv/PbgiiUAHv1FK1BhL42h2c1HlhLupCMnC2AWNv1XnFZ
 HEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505870; x=1717110670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfWSPhuOjJhkvsLDqYZmW5geyHoP88c+PYL6wv+48vI=;
 b=uakZYtEVVDeOgVW1vQFtPABqFnBzuK0YBJ1Bf8WVDsyNQcg3WonXBGIfbRabQ4Qj2W
 mo4yMIE7z8nZsvxxm0n94Y+ipPPxmojLh1BzEK15gq1GszihF29ZOmPuxEMZx2P+E3Qt
 7FqfONTsSyw869mFJERcpL3ukXnXCNnWlmfcmsDBriRocTUZZevm1StfhhHYiWcpiWg/
 Aj+Nbgw4pji+t2dQH24FoNoWT+Fv8KY6YzGnKrs20jDGksYm8A9YlMLlz2TmW4hJMnI+
 k5iwSw5Q6thtJr+O4MgqbMMKL6hSrPvphhx3fISBVUEAEKgnin/V4y5G+3cD2UEStYvC
 ZhtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj0hcMBZdDyGrW+WPN3mrcximhve5dCodrQCdMxYEHm2UH3V61UVX4wdkGfUUCMMY+b5N7+M9ZDq+DDZAREWl6krFJ
X-Gm-Message-State: AOJu0YwONuqPf1Y4ELki0daGwWiel0Fq2KxMZR2o27ujGXBCy/3Bc4hU
 m99Dm3xMifCEBISsYGhSzYJxq1GbX7tr/V/+7kJMwmNWNbfkvHP4HsX9fw==
X-Google-Smtp-Source: AGHT+IFd4G+Guh2bDb0S0GibyU596gtY0QIN9AjS38DzRcXXAiCv9wM8IU/a8qQnyIgav0i2X3F7wg==
X-Received: by 2002:a05:6e02:1a4f:b0:371:bacd:797 with SMTP id
 e9e14a558f8ab-3737b2df627mr6852575ab.15.1716505870085; 
 Thu, 23 May 2024 16:11:10 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 63/72] target/ppc/mmu_common.c: Split off 40x cases from
 ppc_jumbo_xlate()
Date: Fri, 24 May 2024 09:07:36 +1000
Message-ID: <20240523230747.45703-64-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12a.google.com
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

Introduce ppc_40x_xlate() to split off 40x handlning leaving only 6xx
in ppc_jumbo_xlate() now.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 150 +++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 57 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ab912da821..ddb014e0aa 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1258,6 +1258,74 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
+static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                          MMUAccessType access_type,
+                          hwaddr *raddrp, int *psizep, int *protp,
+                          int mmu_idx, bool guest_visible)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    int ret;
+
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+        return true;
+    }
+
+    ret = mmu40x_get_physical_address(env, raddrp, protp, eaddr, access_type);
+    if (ret == 0) {
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (!guest_visible) {
+        return false;
+    }
+
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    if (access_type == MMU_INST_FETCH) {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            env->spr[SPR_40x_ESR] = 0x00000000;
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            env->error_code = 0x08000000;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            cs->exception_index = POWERPC_EXCP_DTLB;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_40x_ESR] = 0x00800000;
+            } else {
+                env->spr[SPR_40x_ESR] = 0x00000000;
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            env->error_code = 0;
+            env->spr[SPR_40x_DEAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_40x_ESR] |= 0x00800000;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return false;
+}
+
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
@@ -1301,23 +1369,11 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_SOFT_6xx:
-                cs->exception_index = POWERPC_EXCP_IFTLB;
-                env->error_code = 1 << 18;
-                env->spr[SPR_IMISS] = eaddr;
-                env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
-                goto tlb_miss;
-            case POWERPC_MMU_SOFT_4xx:
-                cs->exception_index = POWERPC_EXCP_ITLB;
-                env->error_code = 0;
-                env->spr[SPR_40x_DEAR] = eaddr;
-                env->spr[SPR_40x_ESR] = 0x00000000;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            break;
+            cs->exception_index = POWERPC_EXCP_IFTLB;
+            env->error_code = 1 << 18;
+            env->spr[SPR_IMISS] = eaddr;
+            env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+            goto tlb_miss;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_ISI;
@@ -1339,54 +1395,31 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_SOFT_6xx:
-                if (access_type == MMU_DATA_STORE) {
-                    cs->exception_index = POWERPC_EXCP_DSTLB;
-                    env->error_code = 1 << 16;
-                } else {
-                    cs->exception_index = POWERPC_EXCP_DLTLB;
-                    env->error_code = 0;
-                }
-                env->spr[SPR_DMISS] = eaddr;
-                env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
-            tlb_miss:
-                env->error_code |= ctx.key << 19;
-                env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                  get_pteg_offset32(cpu, ctx.hash[0]);
-                env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                  get_pteg_offset32(cpu, ctx.hash[1]);
-                break;
-            case POWERPC_MMU_SOFT_4xx:
-                cs->exception_index = POWERPC_EXCP_DTLB;
+            if (access_type == MMU_DATA_STORE) {
+                cs->exception_index = POWERPC_EXCP_DSTLB;
+                env->error_code = 1 << 16;
+            } else {
+                cs->exception_index = POWERPC_EXCP_DLTLB;
                 env->error_code = 0;
-                env->spr[SPR_40x_DEAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_40x_ESR] = 0x00800000;
-                } else {
-                    env->spr[SPR_40x_ESR] = 0x00000000;
-                }
-                break;
-            default:
-                g_assert_not_reached();
             }
+            env->spr[SPR_DMISS] = eaddr;
+            env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+tlb_miss:
+            env->error_code |= ctx.key << 19;
+            env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
+                                  get_pteg_offset32(cpu, ctx.hash[0]);
+            env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
+                                  get_pteg_offset32(cpu, ctx.hash[1]);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_DSI;
             env->error_code = 0;
-            if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
-                env->spr[SPR_40x_DEAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_40x_ESR] |= 0x00800000;
-                }
+            env->spr[SPR_DAR] = eaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_DSISR] = 0x0A000000;
             } else {
-                env->spr[SPR_DAR] = eaddr;
-                if (access_type == MMU_DATA_STORE) {
-                    env->spr[SPR_DSISR] = 0x0A000000;
-                } else {
-                    env->spr[SPR_DSISR] = 0x08000000;
-                }
+                env->spr[SPR_DSISR] = 0x08000000;
             }
             break;
         case -4:
@@ -1462,6 +1495,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_BOOKE206:
         return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_SOFT_4xx:
+        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
+                             psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
         return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
                                    protp);
-- 
2.43.0


