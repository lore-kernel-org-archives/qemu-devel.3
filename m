Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C283C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz49-0003ME-BK; Mon, 19 Feb 2024 03:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz47-0003Fv-OP; Mon, 19 Feb 2024 03:31:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz45-0002WE-Uq; Mon, 19 Feb 2024 03:31:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d746856d85so21987955ad.0; 
 Mon, 19 Feb 2024 00:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331512; x=1708936312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNu7LbnPyEXqAmNz1J8vUk98CtltlRUnNqB1Qw24DM8=;
 b=jEw1K5gkxMkWOYIOFYqIG+BaTWn6vqv7KAx5NOUKlHdg+dFWY21Fk5Lgvtj4EEYtyI
 WESukXYkB5ZbM1DXDCnsKMwIhd4F6Gho/yuZtX8ZZAcmvn57GXh7J4qiSgCMzfkO5+77
 ogjRQAhQo5bq/OAvhzak1IruXfYzhHJxC94ZvctvVDCh/J7nBR35lTlcdjuUlXEVPr9m
 YtWgJM4keTxgYFVhTQTqX9AbHtwZcR1sQD2Yt63AmtN5PwR7U7EjatZvsOab7RzS4HEe
 gDhBTlpTEdok/9aR2YRU0p4eTGNEvQuuOTMa/RusZSfhdzf5c+H8/Vo1W+cgNPBXycq7
 5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331512; x=1708936312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNu7LbnPyEXqAmNz1J8vUk98CtltlRUnNqB1Qw24DM8=;
 b=lX4ADHQEYO4nyqfD7cNRTZVF1onB57AdptaJ+S820h83alQAVAovAmVi45eBDJAxTM
 gZSQWm7Pt5K6KRA5hLv3NazQqoChO+2t6xkRe74ZYU80P0q0t2U6kc36tWB1nJlQJBCQ
 EhVuvhyMLQUaECYmj1tMtD+OdqFJzHkNfvc+Mej8NiIbiQwpgI4rvwSbgj7XSpMcltpr
 OoDjfiqHIA/9EjH6GgnMqw41JZzXdGN0HD2eRgKOvt5tb1g8ImSgOdO1bRIVFNSsrJs1
 YJL6Tuumx59DvINoVUC1FR7CLNGXFeD4roDXdTLZc9z68dotjUNGJmemfl8Pe8z85ipV
 G/Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZRuIbtahYGfXRa203bQIjeimKlDFubsrpAvtnOu0Pfoh+qOmZ0AQZfTL94HRx4g+BtLsmE6MqICx3YVZhPCfo9VQI
X-Gm-Message-State: AOJu0Yz83MenesIwc97tqq1ZSqEuagDELtLSleQohZN3bnvZBrBrucwn
 DMES8iZE0Fm8Tp8jOm67Nek7m9trGlSN+YvpBs2dytjDXa6gFc9j9LsPReup
X-Google-Smtp-Source: AGHT+IGTO6HdLL18/EkKkbKJh/xmlhRDy63SA/5w8nzzGj2GWTPT7UMJxji3H7UhQx03OovpAMdqEg==
X-Received: by 2002:a17:902:7286:b0:1db:cf57:7bad with SMTP id
 d6-20020a170902728600b001dbcf577badmr4321017pll.22.1708331512297; 
 Mon, 19 Feb 2024 00:31:52 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 25/49] ppc/pnv: New powernv10-rainier machine type
Date: Mon, 19 Feb 2024 18:29:14 +1000
Message-ID: <20240219082938.238302-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Create a new powernv machine type, powernv10-rainier, that
will contain rainier-specific devices.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b949398689..33b905f854 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2249,7 +2249,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
-static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
@@ -2261,7 +2261,6 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
         { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
     };
 
-    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
@@ -2276,6 +2275,22 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
+static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
+}
+
+static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2381,6 +2396,11 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
+        .parent        = MACHINE_TYPE_NAME("powernv10"),
+        .class_init    = pnv_machine_p10_rainier_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10"),
         .parent        = TYPE_PNV_MACHINE,
-- 
2.42.0


