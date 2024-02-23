Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BF8C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY15-0005tJ-SA; Fri, 23 Feb 2024 11:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkS-0007cs-QF; Fri, 23 Feb 2024 10:46:04 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkP-0006jS-Q4; Fri, 23 Feb 2024 10:46:04 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so7537935ad.3; 
 Fri, 23 Feb 2024 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703160; x=1709307960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrRZ61wOnwt9hhs6OE9xukgw6eXlMPtoB/Awq7rJA7I=;
 b=FgQby1VBsXjsK4OGmmXFkgVOBo4CNZmIiiFxFNH1V//gmlGHsCg6odT+f354n5phua
 iDrQCg+2iw3DFdrsbhrpGGuV4xPGGEe0WxTO8wlxk3Bt5HZsIFpsfaSSPK6Gf+04bVSx
 2NB5VtSq1WzTVZyZBar6pBSC3N4jXE900pS7fidNT/nlBdiqPWm9G+VDRzYLdHn0j4It
 GuTDD7SxH7qd2jz+rceNJOv5oUTowRR5sUJHwD1y9HgwU0A0cNyaAqZm6PLN00CymEld
 shNQ92QoqFeDIsdgalSf6bZkLXB2GlVORpjQpNKngCU5Y5WPxxsdKthbhAkv6X61Z6mC
 cgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703160; x=1709307960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrRZ61wOnwt9hhs6OE9xukgw6eXlMPtoB/Awq7rJA7I=;
 b=FCe6bnLS0Ijca1MpoEa1tWKJQCsnj4VYYF/p0os77dt48FNVeMwWPBqK8XhDsZcQHj
 Khn3ClCNav5Yf5PEABX3FrJc9n4yzHQiJiO3w8F9A0aF5j5rM2cQmjtlGClWvCqMq2CA
 5p9iCimUkYIdh/Ycjuf5bWaiu+RC2PPLGdMlbW4wu0ZAmGOZhvK2fRPoDFYs2Sew591Z
 ub9qTXjKXPRPuCoZmUJ/78SfVBT0FmhecmZRXZifNIEUTueGP5aNFfkfIJd8G4y8RWBz
 D9sxIIgtn8+98sMP9MPetmFTBMJ+xTLTb0E+znnqlvlhGcO5ZNviYAC4Qctzco0I/UXi
 X4EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzqWIQMcUehJk9VVw6fY8AJDazpNdonTwnMA8V8NbpZCkVXkLJyuGkVlBACpXdEeuwoa/+kOrKWuqHxsRkaK59DJA1
X-Gm-Message-State: AOJu0YwvajHLq0tSxpmvtAH9Nvx4CVTS6KWp+UiWXaNbIqLlDsiSqSER
 5gTjesEo/nY4ZY1Oux8ujMPXn7eGg5M+qDxdZZjR93eovOXRxQ3wtdUc3TdE
X-Google-Smtp-Source: AGHT+IHPcWpjyPTIXwNnFjNfT0SP2LpoI3MCpdOaKIA51f4GuPcVeG8uPAU+2cgxnK9XqQQVftvKtg==
X-Received: by 2002:a17:902:9a4c:b0:1db:d184:c458 with SMTP id
 x12-20020a1709029a4c00b001dbd184c458mr142829plv.44.1708703159732; 
 Fri, 23 Feb 2024 07:45:59 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 44/47] target/ppc: 4xx don't flush TLB for a newly written
 software TLB entry
Date: Sat, 24 Feb 2024 01:42:03 +1000
Message-ID: <20240223154211.1001692-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

BookE software TLB is implemented by flushing old translations from the
relevant TCG TLB whenever software TLB entries change. This means a new
software TLB entry should not have any corresponding cached TCG TLB
translations, so there is nothing to flush. The exception is multiple
software TLBs that cover the same address and address space, but that is
a programming error and results in undefined behaviour, and flushing
does not give an obviously better outcome in that case either.

Remove the unnecessary flush of a newly written software TLB entry.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 949ae87f4f..68632bf54e 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -808,13 +808,6 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_WRITE ? 'w' : '-',
                   tlb->prot & PAGE_EXEC ? 'x' : '-',
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
-    /* Invalidate new TLB (if valid) */
-    if (tlb->prot & PAGE_VALID) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
-                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
-        ppcemb_tlb_flush(cs, tlb);
-    }
 }
 
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
-- 
2.42.0


