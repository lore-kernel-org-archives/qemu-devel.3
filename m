Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A8C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MR-0001vo-Ke; Thu, 25 Jul 2024 19:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MK-0001Up-4G; Thu, 25 Jul 2024 19:58:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MI-0001fB-E3; Thu, 25 Jul 2024 19:58:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso251070b3a.0; 
 Thu, 25 Jul 2024 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951932; x=1722556732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a86BV8Vhyccbytvo6ivXRmOcEb6Qh7JvvrYLZhS+bgc=;
 b=PkAcZ21w3c7coAom73mZiphNOwsnpWyfNLy1kNgV5ilW5HPVpq7/m5+2Qu+b61d7uI
 Mq225yvpKPMlehDV/coRh8IE7vGjnWkkdbn7WaYtOr7FyD8KRQdaB7PjeOgMsONMcFtF
 PFQ1Y5qtf85DVbiG5v+BiXsAx3Y/bzYqvX1gulcrEVNaL28cMm9hYVbCJTXyYdRNZTRN
 jArKXB+UvBkG1rU6PpCxiykqk3LtZgYqQhIeJWo+I4l5kbYkjoxwmufmcCCn/UnLiA5x
 hSfMVDe38rPzC990ZxGJfFX1oDqyyL7qkJnexRym4eQ/LVqox819WSsTBZQmIVnWNHTM
 rJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951932; x=1722556732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a86BV8Vhyccbytvo6ivXRmOcEb6Qh7JvvrYLZhS+bgc=;
 b=oCXU4qbYJw+zFYYe3BLGL7IlqzuHAhdlyxnLJYsRTQx9sjJ4uU9N/YqWHjnpdt9Wll
 WXtFVRD6SJTH3OTO2d9bGW7+6OkAUTd1cz7bVgJZadUlwPdlmxI4GnkC/XUN/KvdzYrz
 aXUSGCgAH4ZCD4mO1fRN9JHP/w32lN4rOcKGyVo6JpK4d5/+tiCzH/J5MhXYLsZudsqJ
 wFpPWeodAt+6qUtWVW27//ouNmHE85xHTiDZ76aDSuSMSEk19v7ys/d81tkn7Brx0wIH
 NnLFHUD0Tt10XL08Gip8dBPNYIM00wX5k/rhGklz6JfXBVPoCrOmDZw6a9RU+gnQgSjk
 /ApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1SO7luKHNBdaidid9La0sLc8S96rWPfWG4b2vzkGBZenisMr7YYbRxAvKDIrfDfv79Efy9FxApK2l5UJOtIiirc9P
X-Gm-Message-State: AOJu0YzcgiY0xV1x1kZzceZu0q1M02E0Qrsu4Bdhwds1861Tb78SMK55
 AkS3gTV+vIODxMz7Uo7npF4sRCC6CQGYtgArdjoJ7bp2/Td9ziTQLWjvCA==
X-Google-Smtp-Source: AGHT+IEQ4jM0jOcg2+jjRY7JgLkrwYcE3shVhe4/OZ84XQkrrYppcue1iINPtODkc+jvVY+Yybd0Dg==
X-Received: by 2002:a17:90b:4c42:b0:2c7:c5f5:1c72 with SMTP id
 98e67ed59e1d1-2cdb93ceccdmr11132219a91.13.1721951932475; 
 Thu, 25 Jul 2024 16:58:52 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 76/96] target/ppc/mmu_common.c: Remove nx field from mmu_ctx_t
Date: Fri, 26 Jul 2024 09:53:49 +1000
Message-ID: <20240725235410.451624-77-npiggin@gmail.com>
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

Pass it as a parameter instead. Also use named constants instead of
hex values when extracting bits from SR.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index c4902b7632..9f402a979d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -43,7 +43,6 @@ typedef struct {
     int prot;          /* Protection bits          */
     target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
-    int nx;            /* Non-execute area         */
 } mmu_ctx_t;
 
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
@@ -94,7 +93,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int pteh,
-                                MMUAccessType access_type)
+                                MMUAccessType access_type, bool nx)
 {
     /* Check validity and table match */
     if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
@@ -109,7 +108,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     }
     /* Keep the matching PTE information */
     ctx->raddr = pte1;
-    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
+    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
     if (check_prot_access_type(ctx->prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
         return 0;
@@ -121,8 +120,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
 
 /* Software driven TLB helpers */
 
-static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
-                            target_ulong eaddr, MMUAccessType access_type)
+static int ppc6xx_tlb_check(CPUPPCState *env,
+                            mmu_ctx_t *ctx, target_ulong eaddr,
+                            MMUAccessType access_type, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -150,7 +150,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                       access_type == MMU_DATA_STORE ? 'S' : 'L',
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
-                                     0, access_type)) {
+                                     0, access_type, nx)) {
         case -2:
             /* Access violation */
             ret = -2;
@@ -322,7 +322,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
-    bool pr;
+    bool pr, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -336,8 +336,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ctx->key = (((sr & 0x20000000) && pr) ||
                 ((sr & 0x40000000) && !pr)) ? 1 : 0;
     ds = sr & 0x80000000 ? 1 : 0;
-    ctx->nx = sr & 0x10000000 ? 1 : 0;
-    vsid = sr & 0x00FFFFFF;
+    nx = sr & SR32_NX;
+    vsid = sr & SR32_VSID;
     target_page_bits = TARGET_PAGE_BITS;
     qemu_log_mask(CPU_LOG_MMU,
                   "Check segment v=" TARGET_FMT_lx " %d " TARGET_FMT_lx
@@ -352,10 +352,10 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
-                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
+                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
-        if (type == ACCESS_CODE && ctx->nx) {
+        if (type == ACCESS_CODE && nx) {
             qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
             return -3;
         }
@@ -368,7 +368,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.45.2


