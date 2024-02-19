Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8ACC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5y-0000mC-9l; Mon, 19 Feb 2024 03:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5j-0000Nj-VY; Mon, 19 Feb 2024 03:33:39 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5h-0002ms-JH; Mon, 19 Feb 2024 03:33:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d72f71f222so19815525ad.1; 
 Mon, 19 Feb 2024 00:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331610; x=1708936410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riaL4bBi2Km9JTxExie0v3jTFoU1wbNnTnAEl0s+MTk=;
 b=ka5YJabNvGpOpKLIkBddrsy5SWF39iBBm8omy3v9ehya+V3OS2W+5CjtdgoDodVfOw
 fue/8hxa8GKqxJIzEn6yLC5EUS08XOmmZejyZqJ1iJBJF3bsHYlfU3u6DI69U16UgxSc
 xtqGGCoLig9u8wAL6u3g00/ipCALW/P9c6PBVfWi/9CyzIqlWUtJosSuPWIyjYN8CRmp
 Vpwg4oI2IG6vqGUsEKL7TKU/0DyPGUAItKUTkfqA5MEBJSrDVYjZdCexc/07mMmXw246
 v4k5P27rTJkkbTYVqPZqtkIl+x28oIOWGrh1K3CxFJ67rhP8iQLZ7Nti2ihrX3ZyGSDV
 EROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331610; x=1708936410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riaL4bBi2Km9JTxExie0v3jTFoU1wbNnTnAEl0s+MTk=;
 b=RppHdDJbrp0EY72uO1daLJ150X5q4r6NghdIYV2+Dtj3VmCLg0ImHzmFECveCXZzwb
 sHPlQJeug1pVoPLIpX5te0CJNXew/tbLna3cU8H2m704zkvQ4e3korWSgK9h4Q1cT5ax
 21+Jtk0s/Bve4mchdBg/A9YIATL+4zCiNKzY++B3HkgVD87RCZxmFMCujuheHfzYpyM5
 Sp9mcCR8/z++ijsHmcD9Rx8vqZEmXfGuWjq9jNuT/gyOvGqM3vdB7WtyI8pzAbc7rhEA
 m46ctgJ4VGV7Yd0OZ9SN/b7mn+O7SZdA/i9x4TYuNfnfPmgDKhsWdYPVuX6/I0hKrDra
 YG2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuhjywYWSv7idbEEQWHXEBNY8pKov/PGZRvIaQ7+Ib84MFezyZXMIDfdDO93Rx1fhv8AMhodV0UPTAE1MRW5y+XTpe
X-Gm-Message-State: AOJu0Yz2ids59xGpgIRn+B1xKhQow5Rv6ppcJJtMVsKUR+vZb29L+BM4
 /1ca1jV+CVCYjGseqnbyaIsD/PCoHI1fLQZpFATNC+DZS89JDT4zvd1fAMH0
X-Google-Smtp-Source: AGHT+IGfQjlu5HNJGLeXh6Yof+ebb96zo8nAT0s00QDpEhvCzMLYl+dhXeRGRYjFY848cyguETpvRQ==
X-Received: by 2002:a17:902:8c96:b0:1d9:df95:89dd with SMTP id
 t22-20020a1709028c9600b001d9df9589ddmr9552447plo.47.1708331610403; 
 Mon, 19 Feb 2024 00:33:30 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 48/49] target/ppc: 440 optimise tlbwe TLB flushing
Date: Mon, 19 Feb 2024 18:29:37 +1000
Message-ID: <20240219082938.238302-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Have 440 tlbwe flush only the range corresponding to the addresses
covered by the software TLB entry being modified rather than the
entire TLB. This matches what 4xx does.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 923779d052..ba965f1779 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -864,7 +864,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
 
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        tlb_flush(env_cpu(env));
+        ppcemb_tlb_flush(env_cpu(env), tlb);
     }
 
     switch (word) {
-- 
2.42.0


