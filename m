Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA2AC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lz-0000Hx-8v; Thu, 25 Jul 2024 19:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ls-0008G4-VZ; Thu, 25 Jul 2024 19:58:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lr-0001aF-7f; Thu, 25 Jul 2024 19:58:28 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cf11b91813so306556a91.1; 
 Thu, 25 Jul 2024 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951905; x=1722556705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6zvGAoW0vde6H+RvRc6h6WM8Kmo8nwQI5EQDygJJEc=;
 b=lc+5TEQqxhows0geIDJVdeqRdbzSTMbisyrtSoaRqbbbAQVaQS8Mywhhi+fLHacraF
 rijxxx3QxVHzmo0I+8c4K9Q6G3CCM/NQdhiAQlQMyJ8ltCqh3xys6n8jyI4+4KDPp4px
 Yh+kaKX59FuE4oYV2oo5LBF1nRSdj4c2v+Ds5eu5ww5SSrf/kqXEODn+SCaGf7tn33xa
 AfnPfAXXSwJxRfIw1o7eSPQb9fUNCz8uSSa9O3VdCan2foqEkBRMtNwwUZkUClndHfLh
 px3QSt5aOtV1VY6LJMBEw0nrmgDCug0Eiy8PhN8u48NXDN/LW70DwaR9+OpButnPEBtw
 uBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951905; x=1722556705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6zvGAoW0vde6H+RvRc6h6WM8Kmo8nwQI5EQDygJJEc=;
 b=pbbNDzllHVBMVdqMSkuncOKgmxfAMUUrt5ZV05jqDpkfJOhGpzH28fp4HXIg25WUCZ
 MjvMdbNvCwlWHha48ZfTMn/iUtH46Bo3X2dJ6rntwFfDvrD/TmXLCbHpqNFXIAebrMaO
 C5elzB81ZgUi10HMBn5iMoQXg7dnwCE0rYt3k1fJysh3dzqwIi1GMq8Goo8kZKmnRplj
 mVkHvkZ7gGVJUMjBaq5q9023eOFZcedKZ1Mdj9jZWhJOw8+444GTP8rHLcGyySJMaXpI
 Z5U5ZvWQ0n6WRW8R7MEzaZWCeRB72Orpwe5Rz0kWA277ljGNOGiAr6e3AKdxatWPS0VA
 WUvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqFwsNmhrLTBxrr7D4JJJv9rMa/0RUKv5EdDUMNU8QVFIuIHfCTWoTS+c5lZ7e3TTcPYkyed8SgQRAhVhg0fY+f5d0
X-Gm-Message-State: AOJu0YyAfPDER6enfI5q7HwP4aiOQYKoJhRClF3wf0JKj78R/OQEWR3i
 utgPsL+sMQalgDliltwH5PoQ1cpAVetsEOIUqXElFLxOFb7LOip6OCUXfA==
X-Google-Smtp-Source: AGHT+IFPvcZ427Sv0qS3Fs3c9dGY+wZ5yQleQ3wjjdpPAyzL3063F72X7bnWy9sUFayHSaxla9n91A==
X-Received: by 2002:a17:90b:390f:b0:2c9:999d:a22d with SMTP id
 98e67ed59e1d1-2cf238ebb99mr4789561a91.30.1721951905109; 
 Thu, 25 Jul 2024 16:58:25 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 67/96] target/ppc/mmu_common.c: Remove single use local variable
Date: Fri, 26 Jul 2024 09:53:40 +1000
Message-ID: <20240725235410.451624-68-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

The ptem variable in ppc6xx_tlb_pte_check() is used only once,
simplify by removing it as the value is already clear itself without
adding a local name for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2618cdec6a..371ec24485 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,7 +98,6 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int h,
                                 MMUAccessType access_type)
 {
-    target_ulong ptem;
     int ret, pteh, ptev, pp;
 
     ret = -1;
@@ -107,9 +106,8 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     pteh = (pte0 >> 6) & 1;
     if (ptev && h == pteh) {
         /* Check vsid & api */
-        ptem = pte0 & PTE_PTEM_MASK;
         pp = pte1 & 0x00000003;
-        if (ptem == ctx->ptem) {
+        if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
             if (ctx->raddr != (hwaddr)-1ULL) {
                 /* all matches should have equal RPN, WIMG & PP */
                 if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-- 
2.45.2


