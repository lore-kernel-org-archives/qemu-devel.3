Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDA7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHa4-00050f-CG; Thu, 23 May 2024 19:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZU-0002Bn-Fi; Thu, 23 May 2024 19:10:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZS-0005s1-PL; Thu, 23 May 2024 19:10:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b5d0c50so1607385ad.2; 
 Thu, 23 May 2024 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505799; x=1717110599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xWtYFgPKmZvzoUo1p/mj26aITEKQ3OxBcn5RDEMeAE=;
 b=nZDJyl4629u5TcOB/FFYp/TOEW+AyrMCUeBzyYLTX8x9n/I4/OotJIwjSpZZ4MPdxs
 UTcFipkab9dWeUBucjNgnH/cD+EGzUKkHbOKDJfzDd2G124iJQoYqSDYkuo6R+mJkZ/B
 w01ZWlbpm0DXbJkExij3VdYbTn1XERcxSBywLTytW8vZ6mgjaFbQfni/Ts7c7yO/dL/A
 ywL22JsHTF0FDK2L/ANFCsBN4fFIp7hS/Z9sEJGCwDKWLRzedwOIJ5qBm0IWEYTi4+WA
 BWKjK+o5DtRUXt9/q6Q2/TWxhtb7AauXgaFHMosp199vZOZESutgPXa1kAek3uCG5DDt
 Xo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505799; x=1717110599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xWtYFgPKmZvzoUo1p/mj26aITEKQ3OxBcn5RDEMeAE=;
 b=J7s7Bqx8loLlXRvmr4WPqVIhy6W+hT4u/+6I5y9ByI9DiQ0hDeXoL3Z3sPt3eZy/pC
 RpzyhBYUmSLNMDm9T9cvdwBWZv3yRVxPAKwYYk75D6Zv+9xjcG7X1ZuCZfRI0I/OJEtg
 7wd1GyvG4Awsg5F5FQmQp4xumgFb1TxSw00IjHhl6lvUix13J82o6hdGp5s6qbscUp5X
 LwJFwGAO4BjsB6WKLJhe3Zuf1JebJ1iX07ZPxKYWAdR4UiJF3uvLOTuDDbVCJpldt42a
 xdmtPhD29iuBb/FFYHqtodRH78WV9MOLnWhlx3hKco2XYqfVKJ+qJZ/xJ/B3UiVMr2Ma
 O94w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3SikWC44O+vHvTmLsYm3SJEp3zL9MyEjmQ9NRy1Df6aEhNSc5ttl0ukTkceabxQoe96PRhJjo4SWvPeKxz6drQmM8
X-Gm-Message-State: AOJu0Yw1eO0XKKhmnqfd6OImUTvEww5XyI2BKxQoDTuf7RquvWXnvMvH
 T/zOgInp/RlZJGqxaTtcM0idk3OxWAcoEED6P8QuPq/hrYAvgUcCCSv22w==
X-Google-Smtp-Source: AGHT+IG4zaS0j4WzWY2a7KG7/BeYTBe0VJ7CMttqmMyNn8+/dHxqXTmHadvpNEpKge2hDiTZwr0mAg==
X-Received: by 2002:a17:902:c60c:b0:1f2:ffcc:8a0b with SMTP id
 d9443c01a7336-1f4487186d1mr6534515ad.24.1716505798718; 
 Thu, 23 May 2024 16:09:58 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 39/72] target/ppc: Remove unused struct 'mmu_ctx_hash32'
Date: Fri, 24 May 2024 09:07:12 +1000
Message-ID: <20240523230747.45703-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

I think it's use was removed by
Commit 5883d8b296 ("mmu-hash*: Don't use full ppc_hash{32,
64}_translate() path for get_phys_page_debug()")

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 6dfedab11d..da6e8b293c 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -37,12 +37,6 @@
 #  define LOG_BATS(...) do { } while (0)
 #endif
 
-struct mmu_ctx_hash32 {
-    hwaddr raddr;      /* Real address              */
-    int prot;                      /* Protection bits           */
-    int key;                       /* Access key                */
-};
-
 static int ppc_hash32_pp_prot(int key, int pp, int nx)
 {
     int prot;
-- 
2.43.0


