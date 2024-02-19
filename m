Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99501C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5i-0000Ez-7a; Mon, 19 Feb 2024 03:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5Z-0000B5-Bl; Mon, 19 Feb 2024 03:33:25 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5X-0002m8-Rx; Mon, 19 Feb 2024 03:33:25 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e466a679bfso123271b3a.1; 
 Mon, 19 Feb 2024 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331601; x=1708936401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrRZ61wOnwt9hhs6OE9xukgw6eXlMPtoB/Awq7rJA7I=;
 b=ced6m7Z1pNWJLWf50VDaIzNFpjMiy0IyLz3lb6kpXN2BN/gJwWkK4VX+9vpeZo/ktw
 7KjTdIhSwpYvqvQMwTD6Y2eZLRnqnIvOOWOycudgdOzauxgm/t411mpgwXkAlcDHq58S
 mkdMo3wjOhZ40TkIR9Lm9ginkgT6m1krEDD6Y9RKlSQEWyYdLTip+ApLzf2K1WcM65Vr
 m1x25S0uG0cdQbELNiOO5BTpccAUkqSoc/k06wuwyzDRaoL90BpxBDgzh/I2/fYhEbIj
 h5p/XrU/AdZDHrjOg/sYQI0DEBzMvVo4Q7s7WXyluB587yOpbH0xNurKnlfJnwaKn/gg
 rttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331601; x=1708936401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrRZ61wOnwt9hhs6OE9xukgw6eXlMPtoB/Awq7rJA7I=;
 b=gZzG9xZXDGMetQWk1/R71krz7ROxb9ZH7d1eIC+i5VwzpAla+aBL2glGn7A0JkjtSD
 17fUxXFtmd1X1sJ6XmoclJYOlQm01ztE1dhhF6QHU4yXytCMBWfm7+0ntTpkFMtPZeuB
 Wv0H1Ze72XwWnQiQkL60EYCDtGXNSwBnAOXVc9rY11cO4HUFx7hxG4Ood1XyDiSlAXbj
 6MNdlpPrXkVB4QKsGE6feKY93OPSz7IKqmGcHDatTrIFly6udQ/T2eD1BSlPlnJLGT2/
 M5I41BUtE8yt8PJPw5iEYp1vkHYZK9/oh3mr4NoxCw0SOKAvXOTH8/EOe6hmViZH6A4w
 0sZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3Jb3XPqGT0UyOog6MdLPaBCha1Od4q16D1ORylEYSWoUH4LErsQNj/AyFqDIaSaC5fP5HAKNaVr8Xm0uhWUtJvUc
X-Gm-Message-State: AOJu0YxqAm+YTo/PjI0w+v1ckC5vzUDfnJtcuyhCAW+SvJv16j2GTgEr
 tv0l8TmM7qSI9Op2rZT6bkKFGRgNMpPL9ofhztuacZYW6QLCcC7zrbwEmhG3
X-Google-Smtp-Source: AGHT+IG83Fk7HNG7A97VFE/7OPUylJDHfsrD+QSzNWVEjViG2JLYI++sqkA5sRh+S46aBpP2KHrcVQ==
X-Received: by 2002:a05:6a20:4e08:b0:19e:a1a1:5360 with SMTP id
 gk8-20020a056a204e0800b0019ea1a15360mr7776578pzb.23.1708331601712; 
 Mon, 19 Feb 2024 00:33:21 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 46/49] target/ppc: 4xx don't flush TLB for a newly written
 software TLB entry
Date: Mon, 19 Feb 2024 18:29:35 +1000
Message-ID: <20240219082938.238302-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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


