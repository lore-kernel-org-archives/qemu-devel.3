Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE615C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5v-0000X2-KC; Mon, 19 Feb 2024 03:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5d-0000Lv-HO; Mon, 19 Feb 2024 03:33:34 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5c-0002mU-11; Mon, 19 Feb 2024 03:33:29 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d71cb97937so39765055ad.3; 
 Mon, 19 Feb 2024 00:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331606; x=1708936406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m7BhFt0ST6ChSL1LESi22LcAsHCg1BKFvnmGi1yDfU=;
 b=QxAEFqNOkOxMqZbCOU9lWRYnxiNPWBAqOrEmo08rbZGdbqo9cMMYO0ygimxTEggOl1
 DViaZEnNx5H5BBVsPLXdt1qq0dhxtWDxRwiXypNf+677eJdM3DpzZTvFxDv7YgLUXIzy
 YhFWj9eNj5+noqf+cIpWAap2eLieGkPjhIxBeNo3lqOc60PKeq8tekEJve/RmrehIqyZ
 uVC+KB1PAir6q/ATT/KnDqU0WLKvyS2CFiqjo6AAevGMYyaadRb6288fokb3h9Jq7YLh
 OAYDouJ5Xe2iD1C+2ksyK1KXqB7vrJEs/pVZtRfJjaBWW1G74/QL6NKW7BFusWL/yt4K
 5N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331606; x=1708936406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m7BhFt0ST6ChSL1LESi22LcAsHCg1BKFvnmGi1yDfU=;
 b=l2hQgKMILU6aqY2h46Z7WW0Rz7NAfDp9LzgyAJjG6dIfqpmkUaQDtnQaMqLimTQWTJ
 K22ivNx4lp13m4/NM9L4HCjQrIllx24ifYHyYN/JZsex/G+Xva++x2sKHNGzSHzfZEXm
 Fvy2x3vNtYN0C/tDtrX7oZmKv8QEzI7emcuaxJuUGxx5+vns2YZEwHZyaw2Hgrq3FjyG
 j9JV24Y0wCDAUoEWkv3fZjxIjB6ERF72LQM0Nq43pPWC86CXjpGMmnFbns09oNpqkKjR
 cfgmtxF30H3m0/z7AZ89Fn3T10J7wdDvtH/aCC8uxUa+mUy69yGJQZzj68sqPpKwHryh
 kCpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXduvEMi+Zb3xucSXtDbFQNUhPCE3AOrsC7Xb15oLOK9cJlTDbX5SrFxSMwauVmrXvkSdyx2O/WN980nQzr9/2GwYzT
X-Gm-Message-State: AOJu0Yx7bYBV1oTDLWXdbrKtEtUQYtqi1/QJB9UpzBExC616fWTNaVFe
 OJrcM84KblArX0ln4H51LeCfkVzfLi+BPuHjUFhRky6IlHu1qrg+QQTb9moJ
X-Google-Smtp-Source: AGHT+IH2lOBwqUJKJ7knmwBkxpKOuThGZYuTaRNYatvbdcuZVyJH9P51XmdACaHdDJE1OqyuxYv4+g==
X-Received: by 2002:a17:903:2442:b0:1db:fc18:2db9 with SMTP id
 l2-20020a170903244200b001dbfc182db9mr1249715pls.64.1708331606189; 
 Mon, 19 Feb 2024 00:33:26 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 47/49] target/ppc: 4xx optimise tlbwe_lo TLB flushing
Date: Mon, 19 Feb 2024 18:29:36 +1000
Message-ID: <20240219082938.238302-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rather than tlbwe_lo always flushing all TCG TLBs, have it flush just
those corresponding to the old software TLB, and only if it was valid.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 68632bf54e..923779d052 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -813,12 +813,20 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
+    CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %i val " TARGET_FMT_lx "\n",
                   __func__, (int)entry, val);
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
+                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
+    }
     tlb->attr = val & PPC4XX_TLBLO_ATTR_MASK;
     tlb->RPN = val & PPC4XX_TLBLO_RPN_MASK;
     tlb->prot = PAGE_READ;
@@ -836,8 +844,6 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_WRITE ? 'w' : '-',
                   tlb->prot & PAGE_EXEC ? 'x' : '-',
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
-
-    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
 }
 
 target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
-- 
2.42.0


