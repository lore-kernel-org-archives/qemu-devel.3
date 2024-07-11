Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C26DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueg-0007wP-6l; Thu, 11 Jul 2024 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueV-0007Fr-7g; Thu, 11 Jul 2024 10:20:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueS-0005Zg-6D; Thu, 11 Jul 2024 10:20:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-706524adf91so821932b3a.2; 
 Thu, 11 Jul 2024 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707602; x=1721312402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAo6xjY7Z7H7lkRVE4dfescS0XtE27pY+OFTM0PcwTU=;
 b=MAxXNraym6WhSrZ4zifBrOPJ5GkyWCU1nMDZq0njqVcbT1dlXq6+VKJliUMFBrqqIr
 H9CPMW+GXRMaZNe4i5IHmGPGRWMrEn/EjimM9NQjMcUhrRze7O4idgs7GEVSuGo6pXX7
 Se9X6P0WL+PGVyWr78394k7cDGdvgkrS9X1P7ibBJlbUH617SsCe9kpIQWyJPTNEwU/+
 pSaaiMT294HFzpwUcoH4VXmhH9gDgsGgDUUGdqKaYhSzMBxLMCyGoaYd15uCqHA5IJIM
 7s3w3VTiThZgp+zwQYqb6AZlokSF4aVHp7qvbZ7nDZzcCet9rOwHZ3uwHP0BeLorqDxs
 y4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707602; x=1721312402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAo6xjY7Z7H7lkRVE4dfescS0XtE27pY+OFTM0PcwTU=;
 b=e2U+GMb+LAwqiuCv/1l9XD8yUstxpU65YuQNfGc6gBhng47gmN9JPanL0JQzpzO7sA
 223G6CYKY2u1p8jnedj2asSpbHEIQdkG02yjviNXqzTFGim762K8eJhV+LsAlZOyo2ui
 fPOt6UvwJsiNl8YpIetc4k+v778FS7SrXO/rePaPzgP0tQPtM6fZtapCIcQzmzjeYsc+
 BQFk7XwZw+LacpEgio/J5vzD305Hj4jANB9Cjv/NwL4XTOTZbaPagzUns+8odyP0tTEh
 yolxpRo6JWlSj1F6OtiMoVJxDzHTsGQeyibLviP8OKN+WlC0hJRNg03A/n5Lldg6TFmu
 1pQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSgaMthBaQM1Oacf/grsFYOT48oaUF1EoIt3yCYuePzzsF1uwDKVVe9j7/o4tPAqM6oFI5/aw6XEv0vHTQKPziFtU9vxY=
X-Gm-Message-State: AOJu0YwTfX2BCWmoqg8qx1Lg+32odTdP9Y+WcEOsNQy3SA2fPkf740BY
 SfGK5b68DGb0aOW8uOGu0fJ4DlW+9tk8emqhlFB2/gFF5QxtNHZSOZtXdLaw
X-Google-Smtp-Source: AGHT+IHlLJVIWzbwfLUUlAMIszhPbIaPasfkXc0jU+xMNGqk6PEMmZlXJw4ZXOCEtj57XACByGTGBw==
X-Received: by 2002:a05:6a20:3d84:b0:1c3:b102:bfd2 with SMTP id
 adf61e73a8af0-1c3b102c10emr3668059637.14.1720707601607; 
 Thu, 11 Jul 2024 07:20:01 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:20:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 16/18] ppc/pnv: Add big-core machine property
Date: Fri, 12 Jul 2024 00:18:48 +1000
Message-ID: <20240711141851.406677-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c      | 61 ++++++++++++++++++++++++++++++++++-------------
 hw/ppc/pnv_core.c |  6 +++--
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index efc9cf2cc3..575f18958d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2577,6 +2577,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
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
@@ -2628,6 +2656,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
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
@@ -2664,6 +2698,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 
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
@@ -2676,22 +2721,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
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
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 68cc5914c6..e03ac5441e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -280,7 +280,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     PnvCoreClass *pcc = PNV_CORE_GET_CLASS(pc);
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pc->chip->pnv_machine);
+    PnvMachineState *pnv = pc->chip->pnv_machine;
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pnv);
     const char *typename = pnv_core_cpu_typename(pc);
     Error *local_err = NULL;
     void *obj;
@@ -289,6 +290,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
     assert(pc->chip);
 
+    pc->big_core = pnv->big_core;
     pc->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
 
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
@@ -299,7 +301,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         obj = object_new(typename);
         cpu = POWERPC_CPU(obj);
 
-        pc->threads[i] = POWERPC_CPU(obj);
+        pc->threads[i] = cpu;
         if (cc->nr_threads > 1) {
             cpu->env.has_smt_siblings = true;
         }
-- 
2.45.1


