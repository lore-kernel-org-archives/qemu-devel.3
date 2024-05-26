Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645A6C25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxR-0006Cb-3F; Sun, 26 May 2024 08:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxJ-00069f-92; Sun, 26 May 2024 08:26:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxG-0001GP-Im; Sun, 26 May 2024 08:26:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8f34cb0beso1656694b3a.1; 
 Sun, 26 May 2024 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726384; x=1717331184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SWt+UBqWS6BkUOr1LmvWYqUO1wob+XTyl2tr9UYGfs=;
 b=M7kOonYePab56KqDpU1HG9SvqQQyzCCzc1ixEkiVyLRlH74wIKM8Q/yN420NXLIvPK
 /wZoHPFgagcDeEM8JGtg9Sq1xqegiVH99ObDIlJZJeBDyRSKZhsLvweVqTOwcqocjffR
 LpS55Yu9aFAzT3s9dU9DttkB56axSeHIhsTatoLwYW8YI0NWhar2wUxW8gtruqN/wM2U
 slPG0dQIwHcfBVH74qMjPNKSHI0VaQgPKc5SfeuriBapk1kfX4BfCKtqqsWpFuBfI2bh
 Sdvcf38PQkaQl8VousgYz8CreIxLs39mdEUAmFupeVnAUKszr2ijcfIfEIId5pzgJffJ
 B6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726384; x=1717331184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SWt+UBqWS6BkUOr1LmvWYqUO1wob+XTyl2tr9UYGfs=;
 b=GADYtzf5kgadrWlMQftkkNyBzX3XC1WuvYkabPLXYAWYr27FBDbggVzddg3mmMmIya
 VtoZ2+8yTMfrirdS/tCbLYqRTaHw36NYtywkIWpkOHRXLG7udcHlQiPa7vBD8AhXNYkY
 v4H/FC+qPy9oaRGeMMeHi7UrC5i4mPL8TIZT094P4Fm+O0ajCB/tFCHJboSM+8jIMx1T
 enN45yAj6kOwAxl91/2WJbmIyzGI0muVcK96VumuzoDRSzXFHv1L/rCIP3qCsYaYPD7B
 D2eStCHPgoOEqVdeEN+v2Dn1UOOVExMYG9X/Jv3/AQbkNGgtuOFfIdKpELfW3hSmcf8t
 LaDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMExy0J59Nee/qdWY5ru21nsNBzeWVQMgB2ElUu1qe7P6mGmR2bvvNulE1G5guCQk3ZZcYhhrF79k9ld+ydPOM0RtSOHk=
X-Gm-Message-State: AOJu0YxTG/U9P4CGEzxXZJRBpPZH38fAOL4WNfpzCG1iNmIjFDS8DPAh
 e8FfRWsF2Ux9d2Gz+pU1a4UX25WmYcRdrBEdD5tW08EWVKqKJ04jbmRS1w==
X-Google-Smtp-Source: AGHT+IFVlEFzCtVePnSeVb3gYpyI+62+SBWqjYumamArgDJxT19tkCIfesX+cdFpZ2o/j+TVh/bP1Q==
X-Received: by 2002:a05:6a20:394c:b0:1ac:dead:68 with SMTP id
 adf61e73a8af0-1b212dd1572mr10822737637.24.1716726384439; 
 Sun, 26 May 2024 05:26:24 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 01/10] ppc/pnv: Add pointer from PnvCPUState to PnvCore
Date: Sun, 26 May 2024 22:26:02 +1000
Message-ID: <20240526122612.473476-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

This helps move core state from CPU to core structures.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h | 1 +
 hw/ppc/pnv_core.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c6d62fd145..30c1e5b1a3 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -54,6 +54,7 @@ struct PnvCoreClass {
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
 
 typedef struct PnvCPUState {
+    PnvCore *core;
     Object *intc;
 } PnvCPUState;
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f40ab721d6..7b0ea7812b 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -225,6 +225,7 @@ static const MemoryRegionOps pnv_core_power10_xscom_ops = {
 static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
                                  int thread_index)
 {
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
     CPUPPCState *env = &cpu->env;
     int core_hwid;
     ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
@@ -232,6 +233,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
+    pnv_cpu->core = pc;
+
     if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
         return;
     }
-- 
2.43.0


