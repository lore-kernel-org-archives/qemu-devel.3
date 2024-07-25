Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42732C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Js-0004wG-E0; Thu, 25 Jul 2024 19:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jq-0004cq-34; Thu, 25 Jul 2024 19:56:22 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jo-00015g-5y; Thu, 25 Jul 2024 19:56:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso319675a91.1; 
 Thu, 25 Jul 2024 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951778; x=1722556578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6FBdMNHCZUUqDpX7j41+3H0BUDGjqOF7k9dubLKYuI=;
 b=acVoLMbiN5ha5ShsuuW2EXb34hFdtJVxhEgP90ETrukfgcH/4sM7TeQ9JM9RcrC+IZ
 1b+ddcY2p6eZXu3A6Ok9xp8l1EPJ5JTsvHfXPIW7gFweWfIiUhyi4eExY6lVwD1cfTsv
 m5ymbZIC4PlJnwEnxo2mHXs8kbPEG7jUuN64AJH1x9rxL0JezyxafkA6Sv386UPEWy9F
 tjCzwhW1NzJ3jaWfo+Mv6yLJomo/VPaYDy69C+ZdazULb1jyfz924+miueqZ/w0x1mXM
 rduLPBdiPjV3+8PUgqos2jbTCjL+svThMpaQ/G87bSdwduFpmxFINZtjG6BPgIO7iEJI
 wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951778; x=1722556578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6FBdMNHCZUUqDpX7j41+3H0BUDGjqOF7k9dubLKYuI=;
 b=el+0b00V33azVzol8ckTjsbE33xWzYtEj+Be/kwP2o/9TL2byAirRlIvY7fJ/G8uWH
 ihle1ZP0UK5WMXJ54OpCjYJWn/4lgqvVLMu3cnp/8kqsu1H7dhoLYdS6OLXNLk9wfWZF
 u/kCYemh/gHH2fo3XmAYEeYgbW5x3w9LdnQXEEuisgftPuO/zpYgsN0hNvfpvssG/VNo
 G82e3kNoyj8clQCMSY0WX8kIx0SmffXedRplZ19C1eTL+wpf7R/nIJF4mt+c2izVWefs
 UAg+XHa8WK8Iz5k69F/NsEfSATPhkvBFe2NLkPyxcZolrFehiQEyy/NdggkikwGd1C64
 JgXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfjlK20tXDA3X7Gl7bzmvI0JF+yZ1NAiuOwX0mNh9ohT0HRi19rkmEUeuwI8LozL+KAIIZSV5EvHMCRE+UPghWRDoY
X-Gm-Message-State: AOJu0YyoI4lVyuVC4wH9e6bB3b2kR8OJqYn1bHoSMFKDAxdTwXO2sidq
 DVspJ84k8K7XNLGqSNuZB1sOnYMjUpRKWoS+iityVeRBY9/djxEbl+95YQ==
X-Google-Smtp-Source: AGHT+IEJwJCn+EsCEn82m64pT5EodutAtm/gKt9lY/ipVRpfUB4d4SnzIh9kqP3PMOCC5uGH3XL29g==
X-Received: by 2002:a17:90a:6788:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2cf2ea27054mr3971780a91.20.1721951777957; 
 Thu, 25 Jul 2024 16:56:17 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/96] ppc/pnv: Add big-core machine property
Date: Fri, 26 Jul 2024 09:53:05 +1000
Message-ID: <20240725235410.451624-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

Big-core implementation is complete, so expose it as a machine
property that may be set with big-core=on option on powernv9 and
powernv10 machines.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 61 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4605a49d28..d19516c2d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2581,6 +2581,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
     return total_count;
 }
 
+static bool pnv_machine_get_big_core(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    return pnv->big_core;
+}
+
+static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    pnv->big_core = value;
+}
+
+static bool pnv_machine_get_hb(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+
+    return !!pnv->fw_load_addr;
+}
+
+static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+
+    if (value) {
+        pnv->fw_load_addr = 0x8000000;
+    }
+}
+
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2632,6 +2660,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
+
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
 }
 
 static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
@@ -2668,6 +2702,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 
     pnv_machine_p10_common_class_init(oc, data);
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
+
+    /*
+     * This is the parent of POWER10 Rainier class, so properies go here
+     * rather than common init (which would add them to both parent and
+     * child which is invalid).
+     */
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
 }
 
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
@@ -2680,22 +2725,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
     pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
-static bool pnv_machine_get_hb(Object *obj, Error **errp)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-
-    return !!pnv->fw_load_addr;
-}
-
-static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-
-    if (value) {
-        pnv->fw_load_addr = 0x8000000;
-    }
-}
-
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     CPUPPCState *env = cpu_env(cs);
-- 
2.45.2


