Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E478C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl21-0008TV-Jg; Tue, 16 Jul 2024 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0j-0005ve-I3; Tue, 16 Jul 2024 12:26:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0e-0006Gt-3p; Tue, 16 Jul 2024 12:26:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70b0ebd1ef9so3770988b3a.2; 
 Tue, 16 Jul 2024 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147193; x=1721751993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=nhxZQ7/rbr+njicxKKOhiof+WFNl2/V0NLwFRcyEb4LcB5I9tM9MEWsoIUr3lOD/bM
 czcGcOdaM9fXZDHmnf20AF5twMutVfXhYDA0UhgwDUG9yKJc6P1iGYlNo/dbNO+Zicl+
 oAT4X/NsHfJdwg9iooepPDiyBZ2tZlKxeqxgD1CG34KOJaGE8+Y47yitiRcodRNLJbNo
 w/tVD+7+3VE0yFsYRAavsjFYIKh/s6vOR7klxJI3Wg0+kIQV6rP40qqcdEeLKpvhKzqc
 sPGh6rkioz0ELsU2/bsUa9ugVbsDktsm+F2KGqJb9VPdSFYqhfpLdBvIulyph9KTa1/C
 b8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147193; x=1721751993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=iwXMYFzcwz3HCeEvDklzO+w//6OHbM502NsjS9lXhqTljxr8nadqCRMo5iKm6uj+ZZ
 fhHaIHTwRvezybDJ3hryGnsc0YnW0NRsRwbuI+F2O3rIUM9BjqSyCnPKgCU/FMeO4psZ
 X9wVrlnyhmA+awpNk6FsgxeMgrFN9hDyHvbalPPwwaeGvSe/UhB2+qvUN6pd++JdMNUK
 kVEIQ41eKqYoBUSsdn6jWFAH7qoMtvtBUSgpHaEDt+KS1cPJZhs83BOCUBiSIWuGbEgp
 oz/XaMKqrYaaUkrffSumZRm7RwdYtA9rZ1owbhnuyNJuhoygrlDTxEYc53g3QCkjavzJ
 K12w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9WBtVl++ckSGMbld59PJqms+7LTCoDkXtgbU4FRua721HiOzIvq5sYamQuDv2aLvk0kmZrHI60qsXuty7Jd3kHobZHhw=
X-Gm-Message-State: AOJu0YwjXeZJRRVfgtECeYi7JVfFuw0K3O0/e+n5a2SfxQbISKEM4DK4
 TNPVttvkrl8uBS6Rb9Z9/KgePsD8jDynTA7woaBxgIuaFom27M0gsIsFyw==
X-Google-Smtp-Source: AGHT+IFQkw43f03d51sDbI8D2NSH4QU3UQGqOY90NaITd8eMjiRBa5H/qykOAJuLIfnRRjD/kAVm9A==
X-Received: by 2002:a05:6a00:2384:b0:706:aab7:655 with SMTP id
 d2e1a72fcca58-70c2e9bb1ecmr3393091b3a.26.1721147193467; 
 Tue, 16 Jul 2024 09:26:33 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 02/19] ppc/pnv: Add pointer from PnvCPUState to PnvCore
Date: Wed, 17 Jul 2024 02:25:58 +1000
Message-ID: <20240716162617.32161-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h | 1 +
 hw/ppc/pnv_core.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c6d62fd145..29cab9dfd9 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -54,6 +54,7 @@ struct PnvCoreClass {
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
 
 typedef struct PnvCPUState {
+    PnvCore *pnv_core;
     Object *intc;
 } PnvCPUState;
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f40ab721d6..2da271ffb6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -278,6 +278,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         PowerPCCPU *cpu;
+        PnvCPUState *pnv_cpu;
 
         obj = object_new(typename);
         cpu = POWERPC_CPU(obj);
@@ -288,6 +289,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         object_property_add_child(OBJECT(pc), name, obj);
 
         cpu->machine_data = g_new0(PnvCPUState, 1);
+        pnv_cpu = pnv_cpu_state(cpu);
+        pnv_cpu->pnv_core = pc;
 
         object_unref(obj);
     }
-- 
2.45.1


