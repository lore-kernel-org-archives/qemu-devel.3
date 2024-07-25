Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284CCC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lx-00009n-L5; Thu, 25 Jul 2024 19:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ln-0007kg-NF; Thu, 25 Jul 2024 19:58:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ll-0001YH-On; Thu, 25 Jul 2024 19:58:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70eb73a9f14so306424b3a.2; 
 Thu, 25 Jul 2024 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951899; x=1722556699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5pAHExfEf9G2MdH8lvD1c53/R5blDBRSP3uAt4ftNQ=;
 b=XHD9YDQy/Gbevg+w2Q9H6tNAXOWOkY062cNOW3nUWDvOX30NeXD/pKne7Vjxx6ftsg
 hDyqh7ILGu2GUprvfO3rQJ0sgUiElRu97bZjnbTvQNrw8QMT8GsVbOveg3uNvFvgF7UA
 AHaBUQpd1xcBTit1CrJP4+OxG+f3HnjfKKI7aCZhzMFPlB+N0g6asIeFSsmdMB0zOJpB
 OrT253N9vVD7n636HgwVlLZWbpA70Mb3BrihrC0LNltSHt0pwojHhUcvWnJD1jFDknPd
 /bOePUzue6Ad4ki4CY/WuASnWG736+U1cUQu/BVCa9q5NnU/0Ex68TJt/QTLCzPnGZr1
 t7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951899; x=1722556699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5pAHExfEf9G2MdH8lvD1c53/R5blDBRSP3uAt4ftNQ=;
 b=IHXo1blmW+yEaMoXF9E7yWcPtb0jtzBbvZRGDy69Apn9/yFBAnvstrkzrOGxqBg/Il
 8PhGSKT6V/NzJkmCN1A9TQKu+0wgSBJl0gTrZy1ki8/TmHN/8I0AVvDaALB5bSUjqqZ+
 AmAaNgOfvneU6mlaP6re6MxL1kmPpo6Khw569ogHOZtPVRhPjadisCfT1OyBZm0EunDp
 /WEqQ5LZH0o4QRUks55D4ur4u/lnN7i0z0F+LHl9qtgUMXbgC4U5eoW/1YlDna8GnpP1
 VSrLnnKt4cWp9mRzEndSUAMkJ1/0c37zi5KXPLkjAa6qfPl5Go+t/BAM1pEFoHV6QdwR
 v2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeOqbb+B5Pn6yMpDEpo3WUfejnkQyiM3WVkszx0K9b4E3oy+9DbbTS2mrZgVyXvenNOOTeybqOVNImPSVmiQSAu5XD
X-Gm-Message-State: AOJu0YwCG0p1HZz//fGnaFvMsCRHkilS9xjjuxxJHwxPmq30GoxkpVV2
 7dLnyiM5tMrraOCYqep8VRLc1WI/fWMe+blzq2sddQynd3mnMj9LgUGOFw==
X-Google-Smtp-Source: AGHT+IG4MU9KVaJrrVonSK4Ibx1MRQq1C1U9VulfgSHhue20ik+bZFxpdaEuhBPcCcd/z2YBXdHQMw==
X-Received: by 2002:a05:6a20:7292:b0:1c4:7929:a593 with SMTP id
 adf61e73a8af0-1c47b1d198fmr4580263637.23.1721951898943; 
 Thu, 25 Jul 2024 16:58:18 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 65/96] target/ppc: Reorganise and rename ppc_hash32_pp_prot()
Date: Fri, 26 Jul 2024 09:53:38 +1000
Message-ID: <20240725235410.451624-66-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
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

Reorganise ppc_hash32_pp_prot() swapping the if legs so it does not
test for negative first and clean up to make it shorter. Also rename
it to ppc_hash32_prot().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c |  2 +-
 target/ppc/mmu-hash32.h | 35 +++++++++++++----------------------
 target/ppc/mmu_common.c |  2 +-
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index d5f2057eb1..8a446c8a7d 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -45,7 +45,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
     key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
     pp = pte.pte1 & HPTE32_R_PP;
 
-    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
+    return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
 }
 
 static target_ulong hash32_bat_size(int mmu_idx,
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index f0ce6951b4..bc4eedbecc 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -102,49 +102,40 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
-static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
+static inline int ppc_hash32_prot(bool key, int pp, bool nx)
 {
     int prot;
 
-    if (key == 0) {
+    if (key) {
         switch (pp) {
         case 0x0:
-        case 0x1:
-        case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
+            prot = 0;
             break;
-
+        case 0x1:
         case 0x3:
             prot = PAGE_READ;
             break;
-
+        case 0x2:
+            prot = PAGE_READ | PAGE_WRITE;
+            break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     } else {
         switch (pp) {
         case 0x0:
-            prot = 0;
-            break;
-
         case 0x1:
-        case 0x3:
-            prot = PAGE_READ;
-            break;
-
         case 0x2:
             prot = PAGE_READ | PAGE_WRITE;
             break;
-
+        case 0x3:
+            prot = PAGE_READ;
+            break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     }
-    if (nx == 0) {
-        prot |= PAGE_EXEC;
-    }
-
-    return prot;
+    return nx ? prot : prot | PAGE_EXEC;
 }
 
 typedef struct {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index e2542694f0..08c5b61f76 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -120,7 +120,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             }
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
+            ctx->prot = ppc_hash32_prot(ctx->key, pp, ctx->nx);
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-- 
2.45.2


