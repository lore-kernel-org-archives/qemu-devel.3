Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C959CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8N6-0005Zv-Fh; Thu, 25 Jul 2024 19:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ms-000422-R8; Thu, 25 Jul 2024 19:59:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mr-0001lO-0V; Thu, 25 Jul 2024 19:59:30 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7a103ac7be3so307706a12.3; 
 Thu, 25 Jul 2024 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951967; x=1722556767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnH5h8uNaL1eOAmJuCUwBb3iL6jnZdT02PMg2QjED74=;
 b=cas9rT/xeWCIGQXpjpOLu9cFXc1kDPTMgN7BMtZMFAsobEveceg6cC4w0S6yhOKE/P
 JXT8iXlBZn7cO47ZaDTIYgcG89Js8rL/Qa1cVjxmkduFWGHld7v9mmF9NWuet3ZWod/i
 tSsHj8DOU6cBwKKXzXv4+hET3D7taAoMCi0xUEabwajpuikkXsMj9tYuR4m5H63sUXiX
 Mr7CtHt3BQMiKYaKOMLM1ImBWdtf3THrMHsUAh7EOCaXyhOr2BR+Jt2L+XXTSLskKVN1
 m+Ru6E2/q/KJGxq/gVqQtBtsyvIWceRntY7Fj68cR8FQLjzd01L95Ow0usg+gixsYXhM
 V4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951967; x=1722556767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnH5h8uNaL1eOAmJuCUwBb3iL6jnZdT02PMg2QjED74=;
 b=jwKeqAXFkYXDAy+oiMQx4pA1lwN4KbU7KyZnZn8m0/I6PXi9Y4cTuW7Rd284AE/JRL
 on11eUMKE2zGxq4g/fPahEOKWU7rkN3mxZbOENSFZgEMe/xuDyUFuLzOEMbzOwBiQbIb
 gi38dbb8OMLRLmneV8mAU3Cerlh+nTaKb6W0KXpXTKPxm41/62JaQXWiM7jXRInMNs14
 m/ubBsS/YZp2ItxhiMOAlBQNvYRJ7xQbL2d1pACKY9GewTlSoqNeYGzrygBs1vLzlgVn
 S04vD6ZoDJdJF98XV3DAcA3L9e1XcnEaEac8JumO/8q7DDXhezQAJ6pejpXgxQRgB1eL
 d38A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHPF7CcdYOMdRu12x5T0LbR+fh3sJBNA/NuluNlup7EXlUoD43/xxTLntMaQz1Ymr6S4N0q6u+d6zhEtiPINSQX6L
X-Gm-Message-State: AOJu0YyglmvWjX3ojXIIkz7eyOvW50AjArkNmvJAsY4uN4SvaIoYpUUS
 rbUyEL7n1GsSMzQoIG4dtJmz8GRjQMLDVl7vk2bQdBHZLNmvC1rJXXrLYg==
X-Google-Smtp-Source: AGHT+IFewWWqqsCskx9Qai0RNNhD3jKtWuYIMYxuxf9ln7+IHjTtaejFkOn7AXl6UZe2eKRRdCRqwQ==
X-Received: by 2002:a17:90b:4c50:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2cf2e9ab13dmr3993023a91.8.1721951966685; 
 Thu, 25 Jul 2024 16:59:26 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 87/96] target/ppc/mmu_common.c: Rename function parameter
Date: Fri, 26 Jul 2024 09:54:00 +1000
Message-ID: <20240725235410.451624-88-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

Rename parameter of get_bat_6xx_tlb() from virtual to eaddr to match
other functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ede409eb99..110936ca83 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -221,7 +221,7 @@ static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
 }
 
 static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                           target_ulong virtual, MMUAccessType access_type)
+                           target_ulong eaddr, MMUAccessType access_type)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
@@ -230,7 +230,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     bool ifetch = access_type == MMU_INST_FETCH;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
-                  ifetch ? 'I' : 'D', virtual);
+                  ifetch ? 'I' : 'D', eaddr);
     if (ifetch) {
         BATlt = env->IBAT[1];
         BATut = env->IBAT[0];
@@ -246,15 +246,15 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
-                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
-        if ((virtual & 0xF0000000) == BEPIu &&
-            ((virtual & 0x0FFE0000) & ~bl) == BEPIl) {
+                      ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
+        if ((eaddr & 0xF0000000) == BEPIu &&
+            ((eaddr & 0x0FFE0000) & ~bl) == BEPIl) {
             /* BAT matches */
             if (valid != 0) {
                 /* Get physical address */
                 ctx->raddr = (*BATl & 0xF0000000) |
-                    ((virtual & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
-                    (virtual & 0x0001F000);
+                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
+                    (eaddr & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
                 if (check_prot_access_type(ctx->prot, access_type)) {
@@ -273,7 +273,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (ret < 0) {
         if (qemu_log_enabled()) {
             qemu_log_mask(CPU_LOG_MMU, "no BAT match for "
-                          TARGET_FMT_lx ":\n", virtual);
+                          TARGET_FMT_lx ":\n", eaddr);
             for (i = 0; i < 4; i++) {
                 BATu = &BATut[i];
                 BATl = &BATlt[i];
@@ -284,7 +284,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
                               " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
                               "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
                               TARGET_FMT_lx "\n", __func__, ifetch ? 'I' : 'D',
-                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl);
+                              i, eaddr, *BATu, *BATl, BEPIu, BEPIl, bl);
             }
         }
     }
-- 
2.45.2


