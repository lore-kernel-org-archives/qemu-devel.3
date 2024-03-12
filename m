Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9350C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TM-0004g2-Ct; Tue, 12 Mar 2024 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TD-0004ar-Ri; Tue, 12 Mar 2024 12:59:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TC-0007wl-Bh; Tue, 12 Mar 2024 12:59:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6ab012eb1so789287b3a.3; 
 Tue, 12 Mar 2024 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262755; x=1710867555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbdn/uveWvd2PFXff/mZFgoDGVsNpp8ewKrdvUUPnz0=;
 b=A6GTud+/fXJGEC6ejhrBxkxAuFotFRzElXh125M1ZGAYC2c7dEsXMGpaAnxlyJLfjB
 0xYZN/oPv5Gtm2IZ3m0qkKMYq04M8pbfQlfVAvwEQuX632EC0pPHQpbMmDeN2clDBvYv
 2jBevQQh/pw0jj0V7VRk4gNAM3q9mAY8I5BFlGAiVjGF8f/Dz9DyBLsC5PsoQVY+Lf7s
 F5NjXSibOP3guLwuBwC77SZ/Z0eyIWslEBnNmPXrXheTsZWu1dx8W59MJHnvC1Cu0RMe
 OUD5PCE8bkE5oripv+DKyZBcISrLV1e8RwcjlO41Mo97uMhKXOiPY++0KCE60IgjRJ8N
 rx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262755; x=1710867555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbdn/uveWvd2PFXff/mZFgoDGVsNpp8ewKrdvUUPnz0=;
 b=ME1gflrsfyfRu1h0RFnaTMR9MkkJaSvGDxlleN4tTC0lqRYZMKS/0x+Ya3ar3HiUC3
 qCkWQ1yIkUa7fsRZD57RzyLj4wNmm3yJLZznN9XqrtaqIsSwTNAa0PiO50slO7zbA+v2
 Kwq6BzArYLwTakf5lW88b97Gn8+o7Yvszc4sIBaCRkpOjymnIt8yUJ85YmP0lXC8gw+2
 WIDWSn/B4B6Y5aCJPTJTqSb/R+8D8Bi4EyG2HGpMtyzGfR9+QRrqvqqo+AJAcKfnJjOB
 va5le2jdCv5AQ7rNL099NxR9R7ekyC16Wrf83hH3YRzPQP0sUsSlKOkMfCf8zwfS0Ma5
 WCEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfypupp/6HZxcrSFuvpHP7+sT+wVmPVXShYecJjNZh1xHR4zXob/xhyqyawHiVnXk0tcNka6HAbwG4q5xAtB+eKqN4
X-Gm-Message-State: AOJu0YwKsHBQlMg17BWfN08aDNspH0c7KPMB4nvKuFBBd0VPClVL3/Ih
 Yibqa8Jccb6l/hcxE2+0+7U7ibFQ5Qm9BYQNwgEp0W1MWs94nQMc/zo82TqgOQQ=
X-Google-Smtp-Source: AGHT+IHdGcGg69wSlDkf8NVkKtITCvwFnrs8ytDghHyL1IigZtloERgTy9GeDWZ/ruQ1WA6ysJMZCA==
X-Received: by 2002:a05:6a20:7d8c:b0:1a1:6ab9:9139 with SMTP id
 v12-20020a056a207d8c00b001a16ab99139mr8560049pzj.11.1710262754843; 
 Tue, 12 Mar 2024 09:59:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 03/38] spapr: set MSR[ME] and MSR[FP] on client entry
Date: Wed, 13 Mar 2024 02:58:14 +1000
Message-ID: <20240312165851.2240242-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

The initial MSR state for the OpenFirmware binding specifies
MSR[ME] and MSR[FP] are set.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 40b7c52f7f..58cb992609 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -39,9 +39,13 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     /*
      * "PowerPC Processor binding to IEEE 1275" defines the initial MSR state
-     * as 32bit (MSR_SF=0) in "8.2.1. Initial Register Values".
+     * as 32bit (MSR_SF=0) with MSR_ME=1 and MSR_FP=1 in "8.2.1. Initial
+     * Register Values". This can also be found in "LoPAPR 1.1" "C.9.2.1
+     * Initial Register Values".
      */
     env->msr &= ~(1ULL << MSR_SF);
+    env->msr |= (1ULL << MSR_ME) | (1ULL << MSR_FP);
+
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
-- 
2.42.0


