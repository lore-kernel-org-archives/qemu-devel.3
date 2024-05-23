Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A0AC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb8-0000x1-SS; Thu, 23 May 2024 19:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaS-0006R5-TY; Thu, 23 May 2024 19:11:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaR-0006Gn-3X; Thu, 23 May 2024 19:11:04 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e85a0a5bso306083b3a.0; 
 Thu, 23 May 2024 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505860; x=1717110660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zj10GwnBLigCFCzZD/qELEhtkACYTZ//+7hgLyk56U=;
 b=gUwrsFuDl0StJQxqNljq6RqGbHOcyb3plhQ0giipMXLtTA3FBDOHIzxWpKyalQWUUg
 c70eqgwow2WuTzxmoDMbRiNS//L4WVKCpsV907HHWTDxKuE38sLXn907I6TDNDW3gm3l
 STw7shAOLpBEGrfPPMAQNkpvJxPFM22LaaOsNS1T0fDPkr7TNy+KyfR4tiuYH60DymT4
 0h3ml5FUpvp+jyvukubuYNhP2AP4NRa9Lt6B1d9EPr0TZORFKWcUANk4/XxwIjPZPNuF
 OKu+LrwOOmvKyo8clFRiZzkw0SiI9os5sdwiQvM7xj67/bPWSHNoO6vfV9v5p7R8r23v
 eV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505860; x=1717110660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zj10GwnBLigCFCzZD/qELEhtkACYTZ//+7hgLyk56U=;
 b=QOIPoi6+doFkRNuFBQJN8Tr20tKYASyG0gIrLWhSz+J6h5gkL/r5y3vTLSDbRYiR/e
 OCUfwV62iFGeFHMLMp7fjL8+7zyDIsJ1k4NzbzQ5oXPYGfmxrRCetklFyxrd41Vfhc0c
 Wdh9d5dIk4R4oeHzH1bskZOX+gDdz6yoeTA0NJ7SnkgtPjqfSGn7tWhqPI9dukKWrNHH
 Eu/t3ysH2lFoaKL2DhsO6165SwKdhRGAyp8Iqkx9VRv9AuXLwv/B3unU7BwTHsvl7tR3
 6xDqhhyToTmp3UdnrUTUdKDuAK6YcJXBpK5NB3td8IWn0/ZhB3XQ+V8Jzj91Dakx3hgY
 cIuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8G+5VLHpduB/iuQmCQpgIweel0DEhi3DF0BDqiJKau0yT6HA6xwDIOEFiQdv6mniMtTa/2/XVZKS+Dxb3sPTd29ke
X-Gm-Message-State: AOJu0Yx9C7hFyK/4CzreEOvBHDbu3iQCR4EzMvyPSLEAs9ner1e70p4b
 TrV1P2p3Pl7patFXK9E4FCt5NEt3WooxceesF48l1M51lAmpwHPgoAtWUQ==
X-Google-Smtp-Source: AGHT+IGBezOBLre4tU9zouvWfAT8CIGe38jigDyWcibo21Q0COfpyVqpQ1XHVtGFlA2AXqDXXo1Uyg==
X-Received: by 2002:a05:6a20:5506:b0:1ad:999b:de47 with SMTP id
 adf61e73a8af0-1b212e5b906mr748782637.51.1716505860542; 
 Thu, 23 May 2024 16:11:00 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 60/72] target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part
 1
Date: Fri, 24 May 2024 09:07:33 +1000
Message-ID: <20240523230747.45703-61-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Move setting error_code that appears in every case out in front and
hoist the common fall through case for BOOKE206 as well which allows
removing the nested switches.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 09a780bb7a..611092966b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1220,58 +1220,41 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    env->error_code = 0;
+    if (ret == -1) {
+        if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+        }
+    }
     if (access_type == MMU_INST_FETCH) {
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_ITLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+            cs->exception_index = POWERPC_EXCP_ITLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_ISI;
-            env->error_code = 0;
             break;
         case -3:
             /* No execute protection violation */
             cs->exception_index = POWERPC_EXCP_ISI;
             env->spr[SPR_BOOKE_ESR] = 0;
-            env->error_code = 0;
             break;
         }
     } else {
         switch (ret) {
         case -1:
             /* No matches in page tables or TLB */
-            switch (env->mmu_model) {
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_DTLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+            cs->exception_index = POWERPC_EXCP_DTLB;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_DSI;
-            env->error_code = 0;
             env->spr[SPR_BOOKE_DEAR] = eaddr;
             env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             break;
-- 
2.43.0


