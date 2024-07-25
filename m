Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28CAC49EA1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JF-0008Jg-H5; Thu, 25 Jul 2024 19:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JB-0007ii-0D; Thu, 25 Jul 2024 19:55:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J9-0000y5-5j; Thu, 25 Jul 2024 19:55:40 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb56c2c30eso256558a91.1; 
 Thu, 25 Jul 2024 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951737; x=1722556537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAlgpIQYgFpaRkyINeUW5affW7H0QVJ5/b4EoIQ4G54=;
 b=kMj29tKxYylNuhJssSR17DJDmYgxiBCm5ldD0kkmBHulftb/rG6r+eDKs5TgNjsbGO
 zfdvGMUPjCZqso61LAfq8WyclgMbsmzxguTDikceYQ33TnZZILkCGhpWTl/TN+rGSk1I
 cOQ4qgxAkJb1tDwmOKLY1hwZwfmcJzjxQsbmElUkNWoSYXACCpYhGBLq6W5SXGMzGThY
 jAZrPyLB7x6d/WsicblJaGHzcyTuQxdZXyVWgw6ohW+egoehsUKXL1DZooE0Uyok1zy6
 D87yLgFRxlgg1NUbPJrfLM1xHRmXWW2LBOxgpIrpq7N1VdD28LrgoMGwsaDYgSALySJE
 QhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951737; x=1722556537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAlgpIQYgFpaRkyINeUW5affW7H0QVJ5/b4EoIQ4G54=;
 b=I4MLVjnDTB5AmA160L/jbuYMBZ7cBpkxT8ovB/4+SDI0V7+2zMjfdUgCfrC5O+LOgO
 yvDhZGPmQ9/3wl8+BzbkzekVl77Z5OI/ZQHyn9UTN8LQLX5hAeb2+z7i38nib5t4pyP7
 /Cq3/2nQj3uJv2i18SjqV2rv9UsF5UC4YT7lEV30jFVEPuEdta/0qqWT/9p0Nk5NrRhV
 GtILjm+ZpelVNCtQ9KfdvY/KsrXQEXePK7fJXbpCfLNn+CV8XDvAfAmxT1FcE+v3AbPS
 dQRW6QZKFgMF39KyVDVEJe0zDDlB7FtTE55kzgBrKDy0q6TESxGhaIiKz6HD09Ufsa6n
 GHGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFTBlZyeuru+8FbVZWVvBLqAmpwRZBfpzaNRbFR/IPQEFv3DKLuW30CJUOsdjAfGROswxDGDCg7pc3Ee+XkuCQFV1U
X-Gm-Message-State: AOJu0YwHV04eoW8SzZRBxRRiQdrUFrutx0H/ooqH7xj28UHOVPJZzIGC
 74t1yeit0tpwF97J+3mA9/Rqfo6dGcKM3He3wtNpHjteZWB7YuzG58I3HQ==
X-Google-Smtp-Source: AGHT+IFcoIvAuYpIU5q2wU/5CBKzuRLL9jpJ0rjXQs5zT4vqXfU9VGNS54Lhzmog4llwubSP9l/dYQ==
X-Received: by 2002:a17:90a:4e0e:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2cf21547c29mr7440204a91.9.1721951736657; 
 Thu, 25 Jul 2024 16:55:36 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 19/96] ppc/pnv: Add pointer from PnvCPUState to PnvCore
Date: Fri, 26 Jul 2024 09:52:52 +1000
Message-ID: <20240725235410.451624-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

This helps move core state from CPU to core structures.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c         | 3 +++
 include/hw/ppc/pnv_core.h | 1 +
 2 files changed, 4 insertions(+)

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
 
-- 
2.45.2


