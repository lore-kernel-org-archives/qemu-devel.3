Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAABCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yK-0008It-0R; Tue, 21 Oct 2025 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yH-0008IS-AK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:43:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yF-0000tb-3v
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:43:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so2758483f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036233; x=1761641033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BOIFmB8Gn53IMH61nQhvpTXlwuNqzhANPdE60gyPKw=;
 b=pIudn02MZYD4oXxNvrqZw8qtlEP24FeF2oF3l/YdcZ+5Bq5wCRjRTC8hMSd8xBKBNq
 0lwrzXe9xCC7S5ccF+IgnvI2IH6Rja90D+p3CuLwnNhDe7wOFeONP15qHkoSAPOHdAgQ
 GiiMirrtd1uvX9dDHQbIZAl8f0d/MlJK0jMojU4m6znz2Xtzc0vC3wibXi+jy01zn2n7
 k6cl5NqxhGUW+nwtTK3pGkWEK9VEBoptyKcMGYvwA0AVf+UBkoZdF+bvE51qn6OzrKDR
 48fzI3DlBeF4PSOSaizE9+p8/YjBAvjTQy7FWFORrBwyEtX0fF+Pw7NoRrG2j7F9EY9T
 pevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036233; x=1761641033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BOIFmB8Gn53IMH61nQhvpTXlwuNqzhANPdE60gyPKw=;
 b=xVZInnmqn2zsfsQU67weXE6s1EbOQoeRVe73k9hanVRAQhe8XXxbDUzncOclgEGCe8
 qBJ33whvKUE9s2AuEUsLdxVj1RbO8buNA4qNnfcGBdQoA0T+ozOwF5YCZf6Uknlkjliw
 HUo88Jvw2PflUW7KuYp8cH7y7HC0UvPBU45ZCwOGZvSvZ1xQlYXpeDVazZsnXi8Y58Gi
 6jzqQU8mdCYPXp7s9mVN+tK+tTAZH/iTnNF3eK1E2glslTCKooSCDmRlU9f+jWCF+hsA
 vl7aR/B5NMnTFw8AJ2zGQ98JxBYjaJlFl49EupPUOjCCujuJIguCMK5zY4gmR3H2utdv
 Wlcw==
X-Gm-Message-State: AOJu0YxC8weDqNoprJWdG24ZNrSig52lfl4I3zVsEh5LCyIpFxqVAqj8
 FjV9ggUaaPOFNxI1YKVogquU2yeqs1rbamjT1oOpjVrOFzBJzGKbBCVKleXT47KgkbZjWxxuOjh
 rQ7ynpXk=
X-Gm-Gg: ASbGnctO8ARQjA4CzePmsG6GFSzSbU6T/xMf2KhUG+XMQmV4GeND2OnuMm7Qs5iNFWf
 oZh/Vryxousb6yubWWeGg1xESuWY8JXKl9NFUP4imBD76y+PDy+hKo46do4YaJ14mmrhkpsGNxJ
 jwirJYe8bAFHQ98F9yCkm20D6ly2Slwsoy5jNjdWL9Ethehd1A642AsNo0inOwGCgwOp6w52w3n
 7BWRGIOwXlqYUKIlsm541wwiHnkY6Q2f/zw9WJtkgiNTgYwSYZ9m1BrxYeMv4ASlVKa8uq4CV+G
 7rLefyp67SMZuQoujlByrzeaPV5ygcpE/X+HnL5es6VfyLErT5BILbbxAaXkDzklD0PCm3IM1j0
 74UNRT0PVj7SOaIvezxBlHBI6/TQgoQxzlT/FeljUjlsLfKintmoRXQTP7YogLs+nyevd8/BNe/
 P+wmBLXgKQKvqfBh3qSThYT8ztWcla8LbVMgFnsMVorzWhz/LG6sLWQVbiRVoJ
X-Google-Smtp-Source: AGHT+IEZQr+iw/M9Ku1VF0WsywySY59sTo/B64DAO6tXU21KFPgALdQagDHy/sfU9C7qrWv2wKiXIg==
X-Received: by 2002:a05:6000:186e:b0:428:3cff:3240 with SMTP id
 ffacd0b85a97d-4283cff3389mr6857358f8f.1.1761036232772; 
 Tue, 21 Oct 2025 01:43:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm19379117f8f.9.2025.10.21.01.43.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:43:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/11] ppc/spapr: remove deprecated machine pseries-3.0
Date: Tue, 21 Oct 2025 10:43:35 +0200
Message-ID: <20251021084346.73671-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

pseries-3.0 had been deprecated and due for removal now as per policy.
Also remove legacy irq support which existed for pre pseries-3.1 machines.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h     |  1 -
 include/hw/ppc/spapr_irq.h |  1 -
 hw/ppc/spapr.c             | 27 +--------------------------
 hw/ppc/spapr_events.c      |  8 --------
 hw/ppc/spapr_irq.c         | 16 +---------------
 hw/ppc/spapr_pci.c         | 32 ++++----------------------------
 hw/ppc/spapr_vio.c         |  9 ---------
 7 files changed, 6 insertions(+), 88 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed3..0c1e5132de2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool legacy_irq_allocation;
     uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index cb9a85f6575..5ddd1107c39 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -100,7 +100,6 @@ typedef struct SpaprIrq {
 } SpaprIrq;
 
 extern SpaprIrq spapr_irq_xics;
-extern SpaprIrq spapr_irq_xics_legacy;
 extern SpaprIrq spapr_irq_xive;
 extern SpaprIrq spapr_irq_dual;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97ab6bebd25..426a778d3e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3347,9 +3347,7 @@ static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (spapr->irq == &spapr_irq_xics_legacy) {
-        return g_strdup("legacy");
-    } else if (spapr->irq == &spapr_irq_xics) {
+    if (spapr->irq == &spapr_irq_xics) {
         return g_strdup("xics");
     } else if (spapr->irq == &spapr_irq_xive) {
         return g_strdup("xive");
@@ -3363,11 +3361,6 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        error_setg(errp, "This machine only uses the legacy XICS backend, don't pass ic-mode");
-        return;
-    }
-
     /* The legacy IRQ backend can not be set */
     if (strcmp(value, "xics") == 0) {
         spapr->irq = &spapr_irq_xics;
@@ -5062,24 +5055,6 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(3, 1);
 
-/*
- * pseries-3.0
- */
-
-static void spapr_machine_3_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_3_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-
-    smc->legacy_irq_allocation = true;
-    smc->nr_xirqs = 0x400;
-    smc->irq = &spapr_irq_xics_legacy;
-}
-
-DEFINE_SPAPR_MACHINE(3, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 832b0212f31..548a190ce89 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1043,10 +1043,6 @@ void spapr_events_init(SpaprMachineState *spapr)
 {
     int epow_irq = SPAPR_IRQ_EPOW;
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        epow_irq = spapr_irq_findone(spapr, &error_fatal);
-    }
-
     spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
@@ -1067,10 +1063,6 @@ void spapr_events_init(SpaprMachineState *spapr)
     if (spapr->use_hotplug_event_source) {
         int hp_irq = SPAPR_IRQ_HOTPLUG;
 
-        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-            hp_irq = spapr_irq_findone(spapr, &error_fatal);
-        }
-
         spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6d368dd08c..317d57a3802 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -33,11 +33,6 @@ static const TypeInfo spapr_intc_info = {
 
 static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        /* Legacy mode doesn't use this allocator */
-        return;
-    }
-
     spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
     spapr->irq_map = bitmap_new(spapr->irq_map_nr);
 }
@@ -286,11 +281,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
-    if (smc->legacy_irq_allocation) {
-        return smc->nr_xirqs;
-    } else {
-        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
-    }
+    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
 }
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
@@ -588,11 +579,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
     return first + ics->offset;
 }
 
-SpaprIrq spapr_irq_xics_legacy = {
-    .xics        = true,
-    .xive        = false,
-};
-
 static void spapr_irq_register_types(void)
 {
     type_register_static(&spapr_intc_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f9095552e86..bdec8f0728d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -268,7 +268,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                 target_ulong args, uint32_t nret,
                                 target_ulong rets)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t config_addr = rtas_ld(args, 0);
     uint64_t buid = rtas_ldq(args, 1);
     unsigned int func = rtas_ld(args, 3);
@@ -373,13 +372,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     /* Allocate MSIs */
-    if (smc->legacy_irq_allocation) {
-        irq = spapr_irq_find(spapr, req_num, ret_intr_type == RTAS_TYPE_MSI,
-                             &err);
-    } else {
-        irq = spapr_irq_msi_alloc(spapr, req_num,
-                                  ret_intr_type == RTAS_TYPE_MSI, &err);
-    }
+    irq = spapr_irq_msi_alloc(spapr, req_num,
+                              ret_intr_type == RTAS_TYPE_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -393,9 +387,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
             if (i) {
                 spapr_irq_free(spapr, irq, i);
             }
-            if (!smc->legacy_irq_allocation) {
-                spapr_irq_msi_free(spapr, irq, req_num);
-            }
+            spapr_irq_msi_free(spapr, irq, req_num);
             error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                               config_addr);
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -1789,12 +1781,9 @@ static void spapr_phb_unrealize(DeviceState *dev)
 static void spapr_phb_destroy_msi(gpointer opaque)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     SpaprPciMsi *msi = opaque;
 
-    if (!smc->legacy_irq_allocation) {
-        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-    }
+    spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
     spapr_irq_free(spapr, msi->first_irq, msi->num);
     g_free(msi);
 }
@@ -1808,7 +1797,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SpaprMachineState *spapr =
         (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
     PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
@@ -1956,18 +1944,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PCI_NUM_PINS; i++) {
         int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
 
-        if (smc->legacy_irq_allocation) {
-            irq = spapr_irq_findone(spapr, errp);
-            if (irq < 0) {
-                error_prepend(errp, "can't allocate LSIs: ");
-                /*
-                 * Older machines will never support PHB hotplug, ie, this is an
-                 * init only path and QEMU will terminate. No need to rollback.
-                 */
-                return;
-            }
-        }
-
         if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
             error_prepend(errp, "can't allocate LSIs: ");
             goto unrealize;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7759436a4f5..c21a2a3274e 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -507,15 +507,6 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 
     dev->irq = spapr_vio_reg_to_irq(dev->reg);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        int irq = spapr_irq_findone(spapr, errp);
-
-        if (irq < 0) {
-            return;
-        }
-        dev->irq = irq;
-    }
-
     if (spapr_irq_claim(spapr, dev->irq, false, errp) < 0) {
         return;
     }
-- 
2.51.0


