Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0DAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbd-0002qt-Jo; Thu, 23 May 2024 19:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHat-0007WB-9L; Thu, 23 May 2024 19:11:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaq-0006LN-EV; Thu, 23 May 2024 19:11:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f449ed4b89so1659235ad.0; 
 Thu, 23 May 2024 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505886; x=1717110686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08TbmnttJvCBv7zA0rr0Giq11RqrNeScp4MIXBnQF2Y=;
 b=fBOVe0lrzO39BUibEBFJ4leD/vAGOFweh0FBEWaRjcwNbIiiLzawShHMqHKxADJsVj
 i0dopo6KSk8d25n27DfhoSnlAJK4LlStwRDC6cdHYMZ7q4MsUfw+ftyqtd7w1Y73EXH5
 mjhDemaAV0kOi6V0zkXNzHtyy+0P9a47l4E/kLB5eTPridTVKen9I/vRhiZgaklHYEOc
 wxiMKFNeS9xxFxSpoqDSJkLqQ82b9kvdLcQDrCzS1+pSB/tEqzN80RAgv8E0SecY90vD
 pMTu4/b6xIQnZhxSAsFHGRRhunYCqjFOnwafqVZx/lE7PpJOXbsKTqazDzlUXQaJSkYP
 hIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505886; x=1717110686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08TbmnttJvCBv7zA0rr0Giq11RqrNeScp4MIXBnQF2Y=;
 b=Yyo9me+AymHcGx3HqtLOnolLUrQ373+gOrBrS3cVMEshxpPASqzDLLWpgSLOvTEuhc
 jbPYgsY6EDsMcRrI66RK6Qc2dr2wE5ad9ixyCBDAol+omXBhqb1ZM0zxfo96fYwmCEwR
 pqD/TpmXJ/A7iOaOGerJ6xsJQROQKw2bQWnGCAILywMch5yfSaIT2V/0ZQr6kSavcXtM
 uqxijl1Ggsn+zZegQefwoO8zs0bI4zaz4225ReLrB3KtPxr0bN4mmtQxkK0GcxJ/NL73
 bdQklxf3UhSr9heZ9erewy86vfyf0d/FTxqWFvO1NdAPFTDISfUYQP3tIEp3DJxGaJNe
 aiJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcE1b8lnbbaSaE0pyo3Zb2qu1RR0SQhHacg1Qz8uW7TsnaVb6otVm/PGkQY1ZWTJyxk5vupFHXsG9Xuc6TCkMZnXFZ
X-Gm-Message-State: AOJu0YwYhckWfpb9M/ucsk2wsLK5RxIGTrtrAqU3xnTaGJn8c806NXjS
 gesGzSI6vWPCEyqdVmbB/G9EMxaKtn5BNJsGZWMGzPEJQpHH9Orkgtjc8g==
X-Google-Smtp-Source: AGHT+IEYNTIqrnsLJk2vJEoaKDZ0mfD+ftpvsTWuWxQtaQG8ytUk6aLJSm/kLg31+zNys0/WSjyb5w==
X-Received: by 2002:a17:902:db07:b0:1f1:8fd9:b99d with SMTP id
 d9443c01a7336-1f339f51959mr49079035ad.23.1716505886007; 
 Thu, 23 May 2024 16:11:26 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 68/72] target/ppc/mmu-hash32.c: Drop a local variable
Date: Fri, 24 May 2024 09:07:41 +1000
Message-ID: <20240523230747.45703-69-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

In ppc_hash32_xlate() the value of need_prop is checked in two places
but precalculating it does not help because when we reach the first
check we always return and not reach the second place so the value
will only be used once. We can drop the local variable and calculate
it when needed, which makes these checks using it similar to other
places with such checks.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index da6e8b293c..3abaf16e78 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -386,7 +386,6 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     hwaddr pte_offset;
     ppc_hash_pte32_t pte;
     int prot;
-    int need_prot;
     hwaddr raddr;
 
     /* There are no hash32 large pages. */
@@ -400,13 +399,11 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
         return true;
     }
 
-    need_prot = prot_for_access_type(access_type);
-
     /* 2. Check Block Address Translation entries (BATs) */
     if (env->nb_BATs != 0) {
         raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
         if (raddr != -1) {
-            if (need_prot & ~*protp) {
+            if (prot_for_access_type(access_type) & ~*protp) {
                 if (guest_visible) {
                     if (access_type == MMU_INST_FETCH) {
                         cs->exception_index = POWERPC_EXCP_ISI;
@@ -474,7 +471,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
 
-    if (need_prot & ~prot) {
+    if (prot_for_access_type(access_type) & ~prot) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (guest_visible) {
-- 
2.43.0


