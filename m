Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED51C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5W-0008K4-Oc; Mon, 19 Feb 2024 03:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5U-00081b-TI; Mon, 19 Feb 2024 03:33:20 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5T-0002kA-2r; Mon, 19 Feb 2024 03:33:20 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso3892184a12.3; 
 Mon, 19 Feb 2024 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331597; x=1708936397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFqipXJsXEnafgLcmtHeug1c4B0ygbUJpknek1Zmhr0=;
 b=ZzyXGX8yVWnPlD68AphIBB8RHwaPDjyIpPti5R3QsmmEk32orxl3BGKvCNUUFsdzuM
 GMSw9b2JYeMRpFERIReeK37c7HHFfwYwRGl3gp7Cn8vh5g1cjrtvggPoSjOSkf0v+S/y
 gBdRi+zwpnoLbwzbsdIp609SNbbXWv3U7V/+8fTh47op07I0fZ5yd8hjyYE90OmNGKv3
 KJUslHDXvstOEiKzLdmQi+bcnjLTwFqLQgK+c+P/zQ6ZJXne054Dv4HBi8uZXyRI8VcJ
 6mvfcJST5dzvHmcPZgdNTaKxoWzcIrRu9r1rrv/nY5130wAvYTf7EuEj162BzsApB0Vo
 pISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331597; x=1708936397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFqipXJsXEnafgLcmtHeug1c4B0ygbUJpknek1Zmhr0=;
 b=qvG0rnCGzE5lEKVucfAZ/yosqxfoJCzyGgUjedArYofMAg8SKfJSkO1FTF81w9vbdu
 2fhWQhYGTt5JexZEL9+66Jrtb/4uW2SA6S2xN8NxUWMcKxHseV56JowBa2NVXDMfe1W1
 IB99LA0gEoy2t5yvPYP8GtkVoJ7Vg6yKKbyqtCqdBrD1QX1NdIM0mejH/ojxIbGE28zR
 JcS36u9jigo+ecTh9PrLQBiASEuKmBhtkwgtdSLcMuiDMRe2VIGBeidZkYYPoyjktcy5
 IJX8PanwP51qYnqkrQBVvDOIJVdrC6fhcsMDAd3zhiwRwUEsYS5AKRQBu0vdenvzc4j+
 rhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU91SjUCzzHXBx/LyF9vwhAChIh6/F/OUV7Hoo2er/tEAvuNX83Xw8KSv+EvcvwRfIEjgM0nko9pP88qIDUD17IBkqN
X-Gm-Message-State: AOJu0YzOAYjJB6cUh7JbbPB4PmCFqAvQdBeEezyT+2hy6ejXzbWFrzoz
 m4lafPWFdJ6nARhgJI+bLbMK7uqt8wdjjyYJOM0Gm0th5Jdc1P7yL4goTgAZ
X-Google-Smtp-Source: AGHT+IEDbBsqE7Vx0nKcUkV8hCRbWoPEMhXofiXesUOHxwZOzjDlRXqg1VEAB3yWYe0oVoypoucOqg==
X-Received: by 2002:a05:6a21:626:b0:19e:ac67:13a9 with SMTP id
 ll38-20020a056a21062600b0019eac6713a9mr9173557pzb.19.1708331596978; 
 Mon, 19 Feb 2024 00:33:16 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 45/49] target/ppc: Factor out 4xx ppcemb_tlb_t flushing
Date: Mon, 19 Feb 2024 18:29:34 +1000
Message-ID: <20240219082938.238302-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

Flushing the TCG TLB pages that cache a software TLB is a common
operation, factor it into its own function.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c140f3c96d..949ae87f4f 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -749,12 +749,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
     return ret;
 }
 
+static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
+{
+    target_ulong ea;
+
+    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
+        tlb_flush_page(cs, ea);
+    }
+}
+
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
-    target_ulong page, end;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %d val " TARGET_FMT_lx "\n",
                   __func__, (int)entry,
@@ -763,13 +771,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
     tlb->size = booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
                                        & PPC4XX_TLBHI_SIZE_MASK);
@@ -805,13 +810,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
     /* Invalidate new TLB (if valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
 }
 
-- 
2.42.0


