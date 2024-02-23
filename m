Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuT-0004rc-2S; Fri, 23 Feb 2024 10:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkc-0007pk-Kx; Fri, 23 Feb 2024 10:46:15 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXka-0006kg-L2; Fri, 23 Feb 2024 10:46:14 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso8070235ad.3; 
 Fri, 23 Feb 2024 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703171; x=1709307971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A2Aje2N0w6l4FxwC4XiZoj+oYgoAy7mHRX7fG8IQzM=;
 b=mDT6zJvOrHIAUU19S6cOLu/9RC7fNB2hWJhu6C/ilxrpMarlRsH7BUcVQWdmCswvrl
 /Ke+UEiWqf4t3YgRus83H4LuR2gmmNHtvBs8oNLEZ/Sj9ug154ZTKnliKusz3GC5KJO5
 LtaVRzZ6/PaFYQ7ZYGiS9hIipXV4R1GA05tQ7L1abyT/IiWxoGIVnsxyD7pBuD2Nm1X8
 OG2LsTx2X+OusCtG12lseD+chGgJIxQ31EYiCib2od6qYK5wlKT5F9vSWVIBTSnUaMRU
 vNgtvapbYVwU3wJaNjvaKst+t6m91k/xqJEbkafE2RdbjHlZWFJXhxy3uoj01cGvBioy
 sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703171; x=1709307971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2A2Aje2N0w6l4FxwC4XiZoj+oYgoAy7mHRX7fG8IQzM=;
 b=ueAmpxxeVoP8IeFywBQGYD1e6mJBqIOm2HGWFSY9/h3ENbpCvegwxAU91p7SCY8Hgg
 3TmyMxnQMp1L32ux9JTR3mjyeOgKuWuONMoOG4wvTWzjTpA1Fzk1jKCDxGN9DImbJJwR
 dJKCeT5zKAXKJgBZ/PJASY0ZSeBoD7bohn/4ZrWrvkHSSjP5q3SI87yFlWtSHi7iGiIh
 AMB3WyPW3cuwbbOZUqXXm/KwFSH85Qpj8QprEIVqervhVUoK35XW2EI8NSG2XhmicAiG
 nSh2M5JBfR2s46MWEnf9r+30xVqv8UuV0C5SH1sb5ZnFTtauyOZnUzxSqC2p2za/H2nR
 ddQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgGdkoCpCioAz/TBJUvjSRxcbP7pm4PI6WlxQgbNv8K2NSlRcAS1pKjmk128WEXZYDyDhDYoQQ2r85btxNNsVNF9bu
X-Gm-Message-State: AOJu0YzZUmCFBnYQvRF3C/G+yU+B9IYSjEDGN2U0sUwqxaZr/ZIHSKxF
 dUukPImPcn5kBK3exzhYLW/ZwuCb6+in9zwHiAVmG1KByEk/14p5G0FF4fP6
X-Google-Smtp-Source: AGHT+IHUiRZ7fufWhNJIHJxLIGYECaRCy1nmRVkFKmXxevodNMRsUMVtVHND7j3BmHNVgoyi3aQaxw==
X-Received: by 2002:a17:903:8c7:b0:1dc:7362:7365 with SMTP id
 lk7-20020a17090308c700b001dc73627365mr218768plb.4.1708703170932; 
 Fri, 23 Feb 2024 07:46:10 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:46:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 47/47] target/ppc: optimise ppcemb_tlb_t flushing
Date: Sat, 24 Feb 2024 01:42:06 +1000
Message-ID: <20240223154211.1001692-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Filter TLB flushing by PID and mmuidx.

Zoltan reports that, together with the previous TLB flush changes,
performance of a sam460ex machine running 'lame' to convert a wav to
mp3 is improved nearly 10%:

                  CPU time    TLB partial flushes  TLB elided flushes
Before            37s         508238               7680722
After             34s             73                  1143

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 43 +++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ba965f1779..c071b4d5e2 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -751,11 +751,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
 
 static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
 {
-    target_ulong ea;
+    unsigned mmu_idx = 0;
 
-    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
-        tlb_flush_page(cs, ea);
+    if (tlb->prot & 0xf) {
+        mmu_idx |= 0x1;
     }
+    if ((tlb->prot >> 4) & 0xf) {
+        mmu_idx |= 0x2;
+    }
+    if (tlb->attr & 1) {
+        mmu_idx <<= 2;
+    }
+
+    tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->size, mmu_idx,
+                              TARGET_LONG_BITS);
 }
 
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
@@ -770,7 +779,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
@@ -821,7 +830,7 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
@@ -851,6 +860,25 @@ target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
     return ppcemb_tlb_search(env, address, env->spr[SPR_40x_PID]);
 }
 
+static bool mmubooke_pid_match(CPUPPCState *env, ppcemb_tlb_t *tlb)
+{
+    if (tlb->PID == env->spr[SPR_BOOKE_PID]) {
+        return true;
+    }
+    if (!env->nb_pids) {
+        return false;
+    }
+
+    if (env->spr[SPR_BOOKE_PID1] && tlb->PID == env->spr[SPR_BOOKE_PID1]) {
+        return true;
+    }
+    if (env->spr[SPR_BOOKE_PID2] && tlb->PID == env->spr[SPR_BOOKE_PID2]) {
+        return true;
+    }
+
+    return false;
+}
+
 /* PowerPC 440 TLB management */
 void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
@@ -863,7 +891,10 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
     tlb = &env->tlb.tlbe[entry];
 
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && mmubooke_pid_match(env, tlb)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
+                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
         ppcemb_tlb_flush(env_cpu(env), tlb);
     }
 
-- 
2.42.0


