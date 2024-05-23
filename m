Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA18EC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb8-0000wL-Kk; Thu, 23 May 2024 19:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaV-0006Wk-1s; Thu, 23 May 2024 19:11:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaT-0006H3-9z; Thu, 23 May 2024 19:11:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so292176b3a.1; 
 Thu, 23 May 2024 16:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505863; x=1717110663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOatW7IaCqqTgrGWM91a7KrO89P7sTCCoM/uAB8TuFA=;
 b=PSz+51tWle16d7M4fUUglLauV1UOsgbVo0gi7p6juxBDwS5TJsUlZXZI0GJ2Sl3dC2
 MGxq8YkE6PfOy80SCrnGg6xk4PnyWSXx9/G34stZRgAXDF5O2W7KkeEd/79EOgJrOI8H
 4VpdhRN0b9FzEf8DER+8D4+31NsIGmr0dWxg2cCirusNbjAvm7CX+NhfqzRh/CYYEZi/
 2KtS/iSBc81x1xs6Js5w8U2+X4D6P/CrdLhaMr/8FrFlFuoY4buajjqxNKUaKpo0BY/N
 0avJ7mC4ZNfUyR6GDeVKITvlZ3ixwbJhoKYbde4EgHSUB5qwzyjHEmgHSn7gpzX/T/jK
 Pzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505863; x=1717110663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOatW7IaCqqTgrGWM91a7KrO89P7sTCCoM/uAB8TuFA=;
 b=GjthHW6jZbWDUykBBIWvb2ubRxFEHAA4tHbcx9uk7ueIllR0pl8M0H4K1lg9LUTLuN
 bPxC+ZUJRmCI/In9aDTfTfEMkoBFBgwVcywkiSUwLvO2aRjAp9cHYoGlzJpgMVMlyMxK
 UnP0BgSp1iEI5u+Eh7TGnW9ouYDkyUuOufmAc/jVPbFzSyGA5BYYn1R0q5r3lThDbrpP
 qwEigOA7DJaActd4BcMjJStnsXzOMZbAFynSpRWCyNagGJE24nNTVco+2gmvEc2KhB4B
 NvlNEIKz3XGchh4Hivsj7B9t01Hc28ptU+db8fXqQTZrypzGkWfyX8JD57AG7DoaFTQE
 euvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+6vGono6sW9tnUxBcjikG9kUSVi0f8NzkMNFZRogIZ7cSOsj4UT/DtdQudoTWg05YM6tfh12hto8az9nxQD78NM4u
X-Gm-Message-State: AOJu0YwNMcJPUm26x3OkcElIp9DcsBUpI/qaausMewQYZB/Cc2+do6Kz
 9s9xHa2rKqc2MxRMPr7302zM++ICS15TkFrIRN5ekPW61cnn6crs/MmSUg==
X-Google-Smtp-Source: AGHT+IEIWlBTGJNJm1YAKPHEB95s7qNwLPvYbFxd/sl9kKShkDH8WeDnOUXFUYDPzVGdKmbX+VKmkA==
X-Received: by 2002:a05:6a21:3417:b0:1af:d1f0:b350 with SMTP id
 adf61e73a8af0-1b212dc14d2mr828882637.22.1716505863302; 
 Thu, 23 May 2024 16:11:03 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 61/72] target/ppc/mmu_common.c: Simplify ppc_booke_xlate() part
 2
Date: Fri, 24 May 2024 09:07:34 +1000
Message-ID: <20240523230747.45703-62-npiggin@gmail.com>
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

Merge the code fetch and data access cases in a common switch.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 52 ++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 611092966b..8599106f75 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1221,45 +1221,33 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
 
     log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
     env->error_code = 0;
-    if (ret == -1) {
+    switch (ret) {
+    case -1:
+        /* No matches in page tables or TLB */
         if (env->mmu_model == POWERPC_MMU_BOOKE206) {
             booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
         }
-    }
-    if (access_type == MMU_INST_FETCH) {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_ITLB;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            break;
-        case -3:
-            /* No execute protection violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            env->spr[SPR_BOOKE_ESR] = 0;
-            break;
-        }
-    } else {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_DTLB;
-            env->spr[SPR_BOOKE_DEAR] = eaddr;
-            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_DSI;
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
+        env->spr[SPR_BOOKE_DEAR] = eaddr;
+        env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+        break;
+    case -2:
+        /* Access rights violation */
+        cs->exception_index = (access_type == MMU_INST_FETCH) ?
+                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
+        if (access_type != MMU_INST_FETCH) {
             env->spr[SPR_BOOKE_DEAR] = eaddr;
             env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-            break;
         }
+        break;
+    case -3:
+        /* No execute protection violation */
+        cs->exception_index = POWERPC_EXCP_ISI;
+        env->spr[SPR_BOOKE_ESR] = 0;
+        break;
     }
+
     return false;
 }
 
-- 
2.43.0


