Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77930C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklW-0005SP-Bq; Mon, 11 Mar 2024 14:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklT-0005Ot-Ek; Mon, 11 Mar 2024 14:52:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklR-00058B-Vc; Mon, 11 Mar 2024 14:52:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd955753edso12903895ad.1; 
 Mon, 11 Mar 2024 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183163; x=1710787963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILc6eqa/vztnVjNaWFY1Tz+0fqSSJg3LmbPpscMupbo=;
 b=YCAypNtmS/xIdpXrDmy9M40qzSUtHwOLLLC6JZEKfT0MuIC58HX8DCt2hpF1I882ld
 aHv4qaxLK0a7ZO2hHMVyYhyFFJeJ7pFV+tkZVF2fu/bRKYXJUfED7olfczStsIW/46GH
 9ElU9sxTFjcgKdlhLpxmC31CIaLTqx94NC3k6AtxJ3b0+pywwrmkkYzYvfVMFMW7ucbl
 kdDMQsSrAmYT7OkBiwvaQhfoX3X2mTHVl3t3JvtO6MOCiz1uRhwtSQoHpivM0Qfo/lrn
 jJYvI043LPx3emYQ5iZQjmryfuo4I8+L1RwRKUMviBa0IXxcdwj8GyL2gZd94cvNYYNW
 URsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183163; x=1710787963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILc6eqa/vztnVjNaWFY1Tz+0fqSSJg3LmbPpscMupbo=;
 b=Jja5vcdpV2Zxjb2FoPkJAVTaw/825rKVjG0VnP5FTFZRAv1N861LgUjgOOFqVhyKFk
 dNySSoRHDp0L0auM9Yst4F9sPw9H4N8zzgfKpZX0ouWdsCC7eb0hGMzOe2mGC84AZm1I
 RBX7OyLuCvjheAXtM3Mn83CTDmExsAxDT2CpmWvZdy9/aCORarVJo1AMPFpBBt6oRHcN
 aupgg6b2hyjwX+T59Mzk735ElwB1vKOjYIrF1d2W7H+omqTNsHk1KCCLBzEBnirmmkXg
 0tto9uRpuHKM1hLgx4UvuZO80zkXXc44RVuWvS7tYhA94BIb5jFw/SFL593OIX8b8ug0
 0PWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmpBdvjdDVKB5HA0jkx/x3sPEZj8oOpBSDNSBB+L1LVMb9SvxCr2N5WNQmxagn3cATIeWV8JI8yAhbBfZyKnEGCnbg+YM=
X-Gm-Message-State: AOJu0YwekFxgq5QlTR751CjQ4JCPZg+AjUlGzPhdxzNd00wp6D5ICQ8z
 BBrXaskFIXnkv+W8K5BVqPE6xuSnIc0DAnI/QMNpLB7fDpu09U8i4DcxhGx2FJA=
X-Google-Smtp-Source: AGHT+IFL0/mrChSalSLTFxonKfGW0fFYqNETkdafX2sqSgzj//aw0yXWUbPI5Va7WSlQn/WjTCADfQ==
X-Received: by 2002:a17:902:e98a:b0:1dc:b531:833 with SMTP id
 f10-20020a170902e98a00b001dcb5310833mr6238135plb.63.1710183163504; 
 Mon, 11 Mar 2024 11:52:43 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 10/13] spapr: set MSR[ME] and MSR[FP] on client entry
Date: Tue, 12 Mar 2024 04:51:52 +1000
Message-ID: <20240311185200.2185753-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

The initial MSR state for PAPR specifies MSR[ME] and MSR[FP] are set.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 50523ead25..f3b01b0801 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -42,6 +42,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
      * as 32bit (MSR_SF=0) in "8.2.1. Initial Register Values".
      */
     env->msr &= ~(1ULL << MSR_SF);
+    env->msr |= (1ULL << MSR_ME) | (1ULL << MSR_FP);
+
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
-- 
2.42.0


