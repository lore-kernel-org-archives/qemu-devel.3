Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03313D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpm-0008Fj-Gs; Sun, 03 Nov 2024 19:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpY-0007sp-5d; Sun, 03 Nov 2024 19:20:29 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpW-0002ba-Ay; Sun, 03 Nov 2024 19:20:27 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso2804359b3a.3; 
 Sun, 03 Nov 2024 16:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679624; x=1731284424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydcmNb8ZVMOpigyLu4GKmE325dcL0UnR4ztZJAQ53/Y=;
 b=V9AW9EVYHgv8jqAEKBDWD1x8HsnClXJVos6oNBnoy6FWohGjXpLc9+lipmIA1vDVKn
 +wWqFlzf7K/PxqNUEJS2rySeF0Pv7zrmd+IutY3oeNZkhLYsS950Bc1E8i8Pzagg4BRc
 R00Pmhy47IN2ZS87WoccKi4MUuTzWeCO1i2YYdTBLVgPZRz2y5RuNkxMEUMzqubhzBR9
 ilsojqJOs46tPnEAaD5kvsR8Uq1Ns2heSDRP/cOhUkByGBVwnIumEZY20+tSOWCLXlLZ
 hDY9YZQSC7qLqrAjKKMb0MqxyDm742Co14z0bbiERCTF8boi8ywEjLajsD7J80Y/AKnB
 WtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679624; x=1731284424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydcmNb8ZVMOpigyLu4GKmE325dcL0UnR4ztZJAQ53/Y=;
 b=SeLvQGj+GtYjunoLtmEpEwSi9OCs3YAbalqMTJplsMpUaMQstFVc2k4NyDMyw5y3Fe
 yCPzkreGwCtsaY0rkxW9O5tI3oeDcdrfqO+ghGgrTnL2PcfVb6s33Vo9pDMuxc+y6WKQ
 c7AhlILvn/I1JYbvmzPq/EMJWRsc/fE8it6kWXyuHNja3EtuW4xSvSeoapHFDCrFakgm
 vMBR4jKmCaJdRssJ0i6UgjyuAJOmIUb5xc/kIg9Q5gqJAN2xUpGQKr82sD5H+Nkl2Vo7
 1vw3qO58PHExRorbkgWxu4+jMcC979AS7uu2GycF1tftQwuNsykCqdnamQ/rbaeFCalK
 sTQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlUyhAosav73mjkebvMj7Zl9yiMrKeJm1pemuUZgfCGXuy4NcYan47GAz7iCPGUqarmHIv4hPDuQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxjxm5ydmrRvkeILDYwlpvonvNN084ykma0/2ufoSpKYSXKFyiD
 TDVYN/N73KLdM8NajncTc1XDQVxSKOKNX20Kx9MfQ031ZNTLIju3jOHNVw==
X-Google-Smtp-Source: AGHT+IFiTZ86vxB0Q7u6qY+EspfV3Sknr28jftc7QCkP5RgkDAckyWQePfCuzOTmpwg0S413D8H5dQ==
X-Received: by 2002:a05:6a21:31c8:b0:1d9:a80:bcfe with SMTP id
 adf61e73a8af0-1dba552944cmr15452084637.41.1730679624268; 
 Sun, 03 Nov 2024 16:20:24 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/67] ppc/spapr: remove deprecated machine pseries-2.4
Date: Mon,  4 Nov 2024 10:18:09 +1000
Message-ID: <20241104001900.682660-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.4 specific code with this patch for now.

While at it, also remove SpaprMachineClass::dr_lmb_enabled which is
now turned useless.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 38 ++++----------------------------------
 include/hw/ppc/spapr.h |  1 -
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 599a59910c..4d7705c89f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -682,7 +682,6 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
 static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr mem_start, node_size;
     int i, nb_nodes = machine->numa_state->num_nodes;
     NodeInfo *nodes = machine->numa_state->nodes;
@@ -724,7 +723,6 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
     if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
         int ret;
 
-        g_assert(smc->dr_lmb_enabled);
         ret = spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
         if (ret) {
             return ret;
@@ -1307,9 +1305,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     spapr_dt_cpus(fdt, spapr);
 
     /* ibm,drc-indexes and friends */
-    if (smc->dr_lmb_enabled) {
-        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
-    }
+    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
     if (smc->dr_phb_enabled) {
         root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
     }
@@ -2929,10 +2925,8 @@ static void spapr_machine_init(MachineState *machine)
     spapr->ov5 = spapr_ovec_new();
     spapr->ov5_cas = spapr_ovec_new();
 
-    if (smc->dr_lmb_enabled) {
-        spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
-        spapr_validate_node_memory(machine, &error_fatal);
-    }
+    spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
+    spapr_validate_node_memory(machine, &error_fatal);
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
 
@@ -3016,9 +3010,7 @@ static void spapr_machine_init(MachineState *machine)
         machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
-    if (smc->dr_lmb_enabled) {
-        spapr_create_lmb_dr_connectors(spapr);
-    }
+    spapr_create_lmb_dr_connectors(spapr);
 
     if (mc->nvdimm_supported) {
         spapr_create_nvdimm_dr_connectors(spapr);
@@ -3662,7 +3654,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
-    const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
@@ -3671,11 +3662,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Object *memdev;
     hwaddr pagesize;
 
-    if (!smc->dr_lmb_enabled) {
-        error_setg(errp, "Memory hotplug not supported for this machine");
-        return;
-    }
-
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -4713,7 +4699,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
@@ -5334,21 +5319,6 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 5);
 
-/*
- * pseries-2.4
- */
-
-static void spapr_machine_2_4_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_2_5_class_options(mc);
-    smc->dr_lmb_enabled = false;
-    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-}
-
-DEFINE_SPAPR_MACHINE(2, 4);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f6de3e9972..1821ef96c7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,7 +141,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
-- 
2.45.2


