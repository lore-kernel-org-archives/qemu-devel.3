Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E53EC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8M0-0000NU-ML; Thu, 25 Jul 2024 19:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lw-0008TP-3D; Thu, 25 Jul 2024 19:58:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lu-0001ak-7T; Thu, 25 Jul 2024 19:58:31 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d28023accso389246b3a.0; 
 Thu, 25 Jul 2024 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951908; x=1722556708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P8R3fqODxePYjxBt5uhS8uYJOHjVRCunlLk6iJkAy0=;
 b=M1QdHdjyRSxFWcc+S/Ti1qd4fjQYOAky/ZglolTBPqpAG9u1ILc1BIfKu1ooSAkihi
 UzJ+JTqZp5in/DhtPy4r4pku6YcLHW0Z8RjUjV7nHFExCjK06cKlQdgMVo6nCLh7XFyC
 WhwhV7pSqa75oWStx/ZVdSzXztvtI+/F9j0nbcLgfYrN0HNpbWxIKXsGprvv631Q/4tr
 6eh3cVF3U7vxbhB2jDfACKfPJF0CyM445aL9sf/kEFSdglo13NAhVmXCI+K00JgrQ0s5
 yo1S9+3JqKe8HqyOVCgz00zqvrRVtlF/rzAFggaGA99kYf6OlhKK/N5MkNIfi7D7mS6f
 lSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951908; x=1722556708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5P8R3fqODxePYjxBt5uhS8uYJOHjVRCunlLk6iJkAy0=;
 b=L+NFEKLh/MOnQ0ssIYQilDXXICT9sSp1Rec8xRpNHxoxExf3KZP9enP8UV5q3Q1PFI
 bMHiaKg5Kvjm0bLBfoXekNvdBoE61YFJSrbLMjyUbGO3YOb7otZnTPxHrCSOC6iJkH8J
 bLxTCzmsuPYXbdOGiHJmfcKL/+8QL4Xcdwwyh/VOkNfCMCFncmNPOr5nkf5UqPmLxvbI
 ZaD7QuyKhM+4c3yk+r+T6PNhdXfKRKQiOws0BKEyGBpU/ivDAHVmRHjpt7AHsQ28hjYP
 +yJpzYsUGG7sNq8nQgYqv/GweFmyO34eI8hiqAvzk51cI3SDYMeSULNZw5UXE+NAvMh7
 u3Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWN7TS21Zi678TfmzENOibtB70HFjiRQQn5DZafxnjgv8Q9knYkiCQUWrjL8vV230BrJFGmHvk+qYo+lyiO80qyQ9s
X-Gm-Message-State: AOJu0YyiS+qusLr8rL+2igOCETeWOFDBltu3hph4YziGJgHOmQgHZTRb
 Op8ZGgkZm3ZRcs+8N1AH9mSFkMYILVxlXl7kp2YTFN38Sy7a/Q2+SjgpQA==
X-Google-Smtp-Source: AGHT+IG1XCMU1Zb7a9S1N8JaIKScO7jwvpCTO3jsUReoRckudW9qMwnuPzG8/CMwkT1OLqXafmADLA==
X-Received: by 2002:a05:6a21:9992:b0:1c1:f6f1:de05 with SMTP id
 adf61e73a8af0-1c47b17b015mr4055276637.6.1721951908152; 
 Thu, 25 Jul 2024 16:58:28 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 68/96] target/ppc/mmu_common.c: Remove single use local variable
Date: Fri, 26 Jul 2024 09:53:41 +1000
Message-ID: <20240725235410.451624-69-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

The ptev variable in ppc6xx_tlb_pte_check() is used only once and just
obfuscates an otherwise clear value. Get rid of it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 371ec24485..16578f7fa5 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,13 +98,12 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int h,
                                 MMUAccessType access_type)
 {
-    int ret, pteh, ptev, pp;
+    int ret, pteh, pp;
 
     ret = -1;
     /* Check validity and table match */
-    ptev = pte_is_valid(pte0);
     pteh = (pte0 >> 6) & 1;
-    if (ptev && h == pteh) {
+    if (pte_is_valid(pte0) && h == pteh) {
         /* Check vsid & api */
         pp = pte1 & 0x00000003;
         if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-- 
2.45.2


