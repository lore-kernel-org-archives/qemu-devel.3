Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5435C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8M1-0000R5-Rz; Thu, 25 Jul 2024 19:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lz-0000JO-7S; Thu, 25 Jul 2024 19:58:35 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lx-0001bV-Ej; Thu, 25 Jul 2024 19:58:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a0c6ab3354so359615a12.0; 
 Thu, 25 Jul 2024 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951911; x=1722556711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/n/7DC2LKs+F5tkq6shY2w81FHa/0XUlyrdZo4NpF2c=;
 b=ebxepJPySfSCCMLo4wCN2nYNEbsYeuMfEMji7WEKp/HowJTconvRsPXbgll0GKnLPj
 NznHYlzuTqTVI5QaGzjX4noY/C8Apl5JZd6ueI1DfFJKvPJw3SuoAyRhRNGJueHZCN5j
 zJD1kozarQAsMuy68HGoAZzCupwS0W0VYcl1kumCB5rRVjYy4FccqU0rglzplHK2P6pb
 Z+kfQuXFzkdOUkI2M2PisEl92KXiUDiZ/mPPGzf5L5qHoz6VY22qd5JNB4iN3uPxD7IN
 Qnaj9vGng/FGPSRduf6jNL6GMuga87zk8aVMQRmDDZYAA3sY0hCP10BGg9NoGip1gP/l
 pxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951911; x=1722556711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/n/7DC2LKs+F5tkq6shY2w81FHa/0XUlyrdZo4NpF2c=;
 b=oKMCE8dWJ67EM5Q6k/49UryEatOgBzOlrgEeFXVHyincHPgD5Z2OxakdZVHSMl2OMo
 +NuOSosS/7OX5oYZQELPL6ML1AIQYnILffPakgZLd5lvatQSEZrI0bwP7bkDxhZD9yF5
 8Lm4eNPBEvP1IsK2vG/Z0Cqszljhg0QxncrAT9f5M8X6vC68Ov8/CxT6xD2PDFPhA4PC
 TPvdNq4dsSm+eKXsUpfr67pYbjbeGKbxT57CFuLYyhNlHZNaKF5iPnAtKIe1Zed8yU23
 d/8xHc0ETFM9YTsKMa+nZ74EL0H/xrEra0pbTXNJ6VQUSX3i0ocKGWJ706dv6FI7pkOg
 9WiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj4drKqi80qcxvh1pB07d0DfF9kA86Lymh/GSRqZvOVb1UrC4ruCYmi1MFBeoYX33HkUxRPqa9ERQ8QdAUaYbbyreA
X-Gm-Message-State: AOJu0YwEsSh4yAA73+f5fDaRgv18v8Gq5dgXAcp2+KqsnZ9vn79GepBJ
 NBeDabqF+KtvAUhERqBgbDh03H/ZSlNX54bBzt0d5edCJr0UY2dGS1KoMw==
X-Google-Smtp-Source: AGHT+IFEJqbkZ1wOx0NGerjTcpZuVUnfdbJmKX27jhWP+fYeiOuC5jIkyzwgYghnwX1M/5RlCsPPbA==
X-Received: by 2002:a17:90a:9308:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2cf2e9dc505mr4171466a91.17.1721951911251; 
 Thu, 25 Jul 2024 16:58:31 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 69/96] target/ppc/mmu_common.c: Remove another single use local
 variable
Date: Fri, 26 Jul 2024 09:53:42 +1000
Message-ID: <20240725235410.451624-70-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

In ppc6xx_tlb_pte_check() the pteh variable is used only once to
compare to the h parameter of the function. Inline its value and use
pteh name for the function parameter which is more descriptive.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 16578f7fa5..b21f52290f 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -95,15 +95,14 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 }
 
 static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
-                                target_ulong pte1, int h,
+                                target_ulong pte1, int pteh,
                                 MMUAccessType access_type)
 {
-    int ret, pteh, pp;
+    int ret, pp;
 
     ret = -1;
     /* Check validity and table match */
-    pteh = (pte0 >> 6) & 1;
-    if (pte_is_valid(pte0) && h == pteh) {
+    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
         /* Check vsid & api */
         pp = pte1 & 0x00000003;
         if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-- 
2.45.2


