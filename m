Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FD0C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1yb-0000Hv-DQ; Tue, 12 Mar 2024 09:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1yE-00008a-1B; Tue, 12 Mar 2024 09:15:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1yC-0006sh-3l; Tue, 12 Mar 2024 09:15:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6ac00616cso347958b3a.0; 
 Tue, 12 Mar 2024 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249302; x=1710854102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snN27fvobYyrptE+93yJyph56eOVotswARSPWE4FtYw=;
 b=jhYPJ99GP6I4Si2LzG+u6UR8MDeNaQvSx9ZWQe+K00VAce8zTCCoDRhmEcICjrpLFV
 fp+rGanxqGOTfPRVS7chvs3TDfdD4R2a/l+QrArdDgFPiPoQYn2R08fFJUXswCrMqgSo
 2CPcFQV9gubt9YHlsN6hQqj7gbY+12PUa8sX8CXWzat5sJGrX4dNo5VAe6gAUxsyzuIC
 giFxfnM0UD4hN/8Qovg1zoeNnGjRQugIzOWxgXM+lHLEphHpOJUc6JZ5737fN7vJR2aX
 xNudKqjkeYPMuYscOfnBzwzMWiiupd4LQXvc0qM4wVVqKN2W1oM/nKj/whM1w6i4kkH4
 DHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249302; x=1710854102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snN27fvobYyrptE+93yJyph56eOVotswARSPWE4FtYw=;
 b=vreWY2eOIVYeGRCbH0efLboi8K/hweRmVYJ3rescx2UiTFPxLJrlRj7JxjD68rEFZb
 /bHNnZoEhQ5DZJ//L6HKKQel7yEDH73J1/k/zRfd8NWZ1JxUfkeojqkWx65gWvMNr37f
 ohy9J3lRoH+Z71NPQw7bVd3KfgPYBrw2XoJmXfLyq+kGDRaxhbi2Rig8tqmvwr8jxkiB
 gWGOU7CDGZUfDAaRb0hER1Q0UrjZFM+2GbM95PouJyxny4ScafrxXjkoMVutwzvcXfeH
 loWW80wUZJL/RV6WoyEQqa8ypSwdTK4Te7Dr2EBtepqzNAZViuL7C+NZRm2oftVA/LJ2
 PDYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkatODM+xsRBpPhDk4HKR7on41zLaCnlV9wh8xGAtjTKqEjhMyX5hNy/FjPN1uBuLMr9DtJeBhgLmGSXm8jifhFJ/Xf38=
X-Gm-Message-State: AOJu0YzR+Ru2AQyP+AClljQBxdLKQDpih7r/KWCt5xzRBtEpZf7v/SmF
 o04odZJDrQ7+aOC7jJ8mHmbx4m7dBbeOuSQArUti6jDxCE6p58ir/YuT/qgrXHk=
X-Google-Smtp-Source: AGHT+IHS9budt8by+5GT9e58gtz5j1+FLg6LGkeL40Sb6ceMt0YN8TjwvmqFfzzr6JGmfF6tWCUS4g==
X-Received: by 2002:a62:b61a:0:b0:6e6:9561:5999 with SMTP id
 j26-20020a62b61a000000b006e695615999mr4613411pff.11.1710249302260; 
 Tue, 12 Mar 2024 06:15:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:15:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 10/10] spapr: set MSR[ME] and MSR[FP] on client entry
Date: Tue, 12 Mar 2024 23:14:19 +1000
Message-ID: <20240312131419.2196845-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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
index 50523ead25..e7c9edd033 100644
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


