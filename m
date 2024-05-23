Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C346CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHaN-0005tq-9u; Thu, 23 May 2024 19:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaA-0005Wu-9l; Thu, 23 May 2024 19:10:47 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHa7-0006Ez-28; Thu, 23 May 2024 19:10:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2bd816ecaf5so2394095a91.2; 
 Thu, 23 May 2024 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505840; x=1717110640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zp4mz0WwPCrb5EbeMB+62K9gzVJyjO+llF11kQYztws=;
 b=HAqvtpw0MNpDf3nrmWadLHNCfk3fR+mHdWznN1gASePI+NT/k2H3dX0G9E0nkgQOVt
 v71si3AcyYoOR6Rpy+4coSQ9KjrhQPEutJ/+di4BuQryZbAAj2/DjxxN+XK32joNXsYZ
 y3UMCdik70KnxE2TM82+adNsISwDjbwWtLCrruOqTE6uQ1eZmo2eBvXH5ZEsZb8pmK5N
 h73MORSXu8SY4osz82zbDs3xR91BMy83ZpIhoJINFcNSuO9CiMBjhPH5KBDSRgPL7mgq
 L0fbfpde3FCWtNWWamQBi775Dwx6iPCBEMBKpITm1LHxHgkPypDokCP+4IIP/w3n7Wd0
 JG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505840; x=1717110640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zp4mz0WwPCrb5EbeMB+62K9gzVJyjO+llF11kQYztws=;
 b=Mneff9YpxEN1X93J7SnWST/rCVis2OFrgKcxMrv9+0cd93sVvNwd8P4mgEYjkwcNRO
 3G2kSIugUHc++pQyMa3NBhALTKAR5zSMd7hgc50lgmJX9mbnS7c4hBMl8IWMhQ/kM2FT
 bIQadIrcjZxYHoW8YUrG1ftTdmNzEuw2UyWumkH+TmYAl0xWmLu1DDvRiEEmv1NQQwMa
 F0FjASSNgRyIKWVCOMlu+TrH2aHBe6gW7rn8O/p3gdydbj0/GG7O4MCs5EQmHf1zaVri
 1dv56u9eMyMQGCb30aev921wzEbiK/WO4KDyi0FfFjdi0OBoxlrVYTwy22m9/o8yWPPB
 XOAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBHa/ABLJI7npOzuXhY3h+5rOTkh1nQ1qwi5Xn/3Ush6tD1yZiQUXdg6g4KaRmF96V713e2XdlykObJ/FDjL8Yxv+V
X-Gm-Message-State: AOJu0YyDP+K8t3BNByxd6yFcIja2DSGFLK6pvnDQ8k9ARCefsCQ7zYVq
 wy+DxaD9pkQR2kc+SPdOnLyq2+cnJUx+iskhkWXVHd0pVElZRxsFDid3bw==
X-Google-Smtp-Source: AGHT+IEBv2s+YlxzCUT8BtlD4XthOdeviqJZZIi0KONeKYGIA2cRGrsBojsW+HN9K0YMjdbSRkHkiw==
X-Received: by 2002:a17:90a:ea0e:b0:2b3:9ce8:1239 with SMTP id
 98e67ed59e1d1-2bf5e173c8emr626987a91.6.1716505840011; 
 Thu, 23 May 2024 16:10:40 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 53/72] target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
Date: Fri, 24 May 2024 09:07:26 +1000
Message-ID: <20240523230747.45703-54-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

Instead of putting a large block of code in an if, invert the
condition and return early to be able to deindent the code block.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 319 ++++++++++++++++++++--------------------
 1 file changed, 159 insertions(+), 160 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 124148b3da..f40481b4b1 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1264,187 +1264,186 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         *protp = ctx.prot;
         *psizep = TARGET_PAGE_BITS;
         return true;
+    } else if (!guest_visible) {
+        return false;
     }
 
-    if (guest_visible) {
-        log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
-        if (type == ACCESS_CODE) {
-            switch (ret) {
-            case -1:
-                /* No matches in page tables or TLB */
-                switch (env->mmu_model) {
-                case POWERPC_MMU_SOFT_6xx:
-                    cs->exception_index = POWERPC_EXCP_IFTLB;
-                    env->error_code = 1 << 18;
-                    env->spr[SPR_IMISS] = eaddr;
-                    env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
-                    goto tlb_miss;
-                case POWERPC_MMU_SOFT_4xx:
-                    cs->exception_index = POWERPC_EXCP_ITLB;
-                    env->error_code = 0;
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    env->spr[SPR_40x_ESR] = 0x00000000;
-                    break;
-                case POWERPC_MMU_BOOKE206:
-                    booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
-                    /* fall through */
-                case POWERPC_MMU_BOOKE:
-                    cs->exception_index = POWERPC_EXCP_ITLB;
-                    env->error_code = 0;
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
-                    break;
-                case POWERPC_MMU_REAL:
-                    cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
-                default:
-                    cpu_abort(cs, "Unknown or invalid MMU model\n");
-                }
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    if (type == ACCESS_CODE) {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_SOFT_6xx:
+                cs->exception_index = POWERPC_EXCP_IFTLB;
+                env->error_code = 1 << 18;
+                env->spr[SPR_IMISS] = eaddr;
+                env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+                goto tlb_miss;
+            case POWERPC_MMU_SOFT_4xx:
+                cs->exception_index = POWERPC_EXCP_ITLB;
+                env->error_code = 0;
+                env->spr[SPR_40x_DEAR] = eaddr;
+                env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case -2:
-                /* Access rights violation */
-                cs->exception_index = POWERPC_EXCP_ISI;
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->error_code = 0;
-                } else {
-                    env->error_code = 0x08000000;
-                }
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_ITLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
                 break;
-            case -3:
-                /* No execute protection violation */
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->spr[SPR_BOOKE_ESR] = 0x00000000;
-                    env->error_code = 0;
+            case POWERPC_MMU_REAL:
+                cpu_abort(cs, "PowerPC in real mode should never raise "
+                              "any MMU exceptions\n");
+            default:
+                cpu_abort(cs, "Unknown or invalid MMU model\n");
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x08000000;
+            }
+            break;
+        case -3:
+            /* No execute protection violation */
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->spr[SPR_BOOKE_ESR] = 0x00000000;
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x10000000;
+            }
+            cs->exception_index = POWERPC_EXCP_ISI;
+            break;
+        case -4:
+            /* Direct store exception */
+            /* No code fetch is allowed in direct-store areas */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->error_code = 0;
+            } else {
+                env->error_code = 0x10000000;
+            }
+            break;
+        }
+    } else {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_SOFT_6xx:
+                if (access_type == MMU_DATA_STORE) {
+                    cs->exception_index = POWERPC_EXCP_DSTLB;
+                    env->error_code = 1 << 16;
                 } else {
-                    env->error_code = 0x10000000;
+                    cs->exception_index = POWERPC_EXCP_DLTLB;
+                    env->error_code = 0;
                 }
-                cs->exception_index = POWERPC_EXCP_ISI;
+                env->spr[SPR_DMISS] = eaddr;
+                env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+            tlb_miss:
+                env->error_code |= ctx.key << 19;
+                env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
+                  get_pteg_offset32(cpu, ctx.hash[0]);
+                env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
+                  get_pteg_offset32(cpu, ctx.hash[1]);
                 break;
-            case -4:
-                /* Direct store exception */
-                /* No code fetch is allowed in direct-store areas */
-                cs->exception_index = POWERPC_EXCP_ISI;
-                if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                    (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->error_code = 0;
+            case POWERPC_MMU_SOFT_4xx:
+                cs->exception_index = POWERPC_EXCP_DTLB;
+                env->error_code = 0;
+                env->spr[SPR_40x_DEAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_40x_ESR] = 0x00800000;
                 } else {
-                    env->error_code = 0x10000000;
+                    env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            }
-        } else {
-            switch (ret) {
-            case -1:
-                /* No matches in page tables or TLB */
-                switch (env->mmu_model) {
-                case POWERPC_MMU_SOFT_6xx:
-                    if (access_type == MMU_DATA_STORE) {
-                        cs->exception_index = POWERPC_EXCP_DSTLB;
-                        env->error_code = 1 << 16;
-                    } else {
-                        cs->exception_index = POWERPC_EXCP_DLTLB;
-                        env->error_code = 0;
-                    }
-                    env->spr[SPR_DMISS] = eaddr;
-                    env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
-                tlb_miss:
-                    env->error_code |= ctx.key << 19;
-                    env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                        get_pteg_offset32(cpu, ctx.hash[0]);
-                    env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                        get_pteg_offset32(cpu, ctx.hash[1]);
-                    break;
-                case POWERPC_MMU_SOFT_4xx:
-                    cs->exception_index = POWERPC_EXCP_DTLB;
-                    env->error_code = 0;
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_40x_ESR] = 0x00800000;
-                    } else {
-                        env->spr[SPR_40x_ESR] = 0x00000000;
-                    }
-                    break;
-                case POWERPC_MMU_BOOKE206:
-                    booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                    /* fall through */
-                case POWERPC_MMU_BOOKE:
-                    cs->exception_index = POWERPC_EXCP_DTLB;
-                    env->error_code = 0;
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                    break;
-                case POWERPC_MMU_REAL:
-                    cpu_abort(cs, "PowerPC in real mode should never raise "
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_DTLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                break;
+            case POWERPC_MMU_REAL:
+                cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
-                default:
-                    cpu_abort(cs, "Unknown or invalid MMU model\n");
+            default:
+                cpu_abort(cs, "Unknown or invalid MMU model\n");
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            env->error_code = 0;
+            if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
+                env->spr[SPR_40x_DEAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_40x_ESR] |= 0x00800000;
+                }
+            } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
+                       (env->mmu_model == POWERPC_MMU_BOOKE206)) {
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+            } else {
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x0A000000;
+                } else {
+                    env->spr[SPR_DSISR] = 0x08000000;
                 }
+            }
+            break;
+        case -4:
+            /* Direct store exception */
+            switch (type) {
+            case ACCESS_FLOAT:
+                /* Floating point load/store */
+                cs->exception_index = POWERPC_EXCP_ALIGN;
+                env->error_code = POWERPC_EXCP_ALIGN_FP;
+                env->spr[SPR_DAR] = eaddr;
                 break;
-            case -2:
-                /* Access rights violation */
+            case ACCESS_RES:
+                /* lwarx, ldarx or stwcx. */
                 cs->exception_index = POWERPC_EXCP_DSI;
                 env->error_code = 0;
-                if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
-                    env->spr[SPR_40x_DEAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_40x_ESR] |= 0x00800000;
-                    }
-                } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                           (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                    env->spr[SPR_BOOKE_DEAR] = eaddr;
-                    env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x06000000;
                 } else {
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x0A000000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x08000000;
-                    }
+                    env->spr[SPR_DSISR] = 0x04000000;
                 }
                 break;
-            case -4:
-                /* Direct store exception */
-                switch (type) {
-                case ACCESS_FLOAT:
-                    /* Floating point load/store */
-                    cs->exception_index = POWERPC_EXCP_ALIGN;
-                    env->error_code = POWERPC_EXCP_ALIGN_FP;
-                    env->spr[SPR_DAR] = eaddr;
-                    break;
-                case ACCESS_RES:
-                    /* lwarx, ldarx or stwcx. */
-                    cs->exception_index = POWERPC_EXCP_DSI;
-                    env->error_code = 0;
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x06000000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x04000000;
-                    }
-                    break;
-                case ACCESS_EXT:
-                    /* eciwx or ecowx */
-                    cs->exception_index = POWERPC_EXCP_DSI;
-                    env->error_code = 0;
-                    env->spr[SPR_DAR] = eaddr;
-                    if (access_type == MMU_DATA_STORE) {
-                        env->spr[SPR_DSISR] = 0x06100000;
-                    } else {
-                        env->spr[SPR_DSISR] = 0x04100000;
-                    }
-                    break;
-                default:
-                    printf("DSI: invalid exception (%d)\n", ret);
-                    cs->exception_index = POWERPC_EXCP_PROGRAM;
-                    env->error_code =
-                        POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
-                    env->spr[SPR_DAR] = eaddr;
-                    break;
+            case ACCESS_EXT:
+                /* eciwx or ecowx */
+                cs->exception_index = POWERPC_EXCP_DSI;
+                env->error_code = 0;
+                env->spr[SPR_DAR] = eaddr;
+                if (access_type == MMU_DATA_STORE) {
+                    env->spr[SPR_DSISR] = 0x06100000;
+                } else {
+                    env->spr[SPR_DSISR] = 0x04100000;
                 }
                 break;
+            default:
+                printf("DSI: invalid exception (%d)\n", ret);
+                cs->exception_index = POWERPC_EXCP_PROGRAM;
+                env->error_code = POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
+                env->spr[SPR_DAR] = eaddr;
+                break;
             }
+            break;
         }
     }
     return false;
-- 
2.43.0


