Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D21FD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpj-000857-OE; Sun, 03 Nov 2024 19:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpW-0007se-6E; Sun, 03 Nov 2024 19:20:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpT-0002bP-EH; Sun, 03 Nov 2024 19:20:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-207115e3056so33152875ad.2; 
 Sun, 03 Nov 2024 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679621; x=1731284421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2ew3CyVLXi8mBOhBcW6uwQfd5spGfa4C9fjmp/PKBQ=;
 b=EeJ/WyGDfdV4hZJw8Kq2jhZOs8Ge9mbo91eLE0mFwPX4I0P00OZCjjLk4o4PxKnuYI
 +yCxb1Pr1ccfzFkcYFuHJULtyxvn7FFinCBBdPNjz2lTHjAtxWpibl0cY0lI6ZEKbBM4
 U48Ipjl1qweOxs89CFjZklv+G1sbo56NddEMhvdcyXrzprq9WjM32QOSOKWfbZDvKVWU
 q+Q0E1CmIUA+Ng1moh9sqNhj8KDOO3FmDbekvM+nTs+DjuJ8lcEFCx9Q6rtp62uvxIXz
 udTEegUgq+Y1polvlUUeAhPIeUNItIDEHxa+ToXZzlxHZdUziZ3V2H4pSEK78eSTIkSm
 UVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679621; x=1731284421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2ew3CyVLXi8mBOhBcW6uwQfd5spGfa4C9fjmp/PKBQ=;
 b=Vu8rWj+QUV7w0PQ/Qrvd5k4KbzVYh8c5WwJzpra6aI40TVP51R2V8ZvY6KnY2m0arf
 eepkT1KemEN8PZ//EwuC6IlhFo1m/fMX7nlJ6smFO3AA9g/xhbuC6nW/Y3esd14sGBB0
 FVJjJdxXw3jtPagfr2rwomEff0Fnxp+LpvIqL47Wao762pcqGtar88W615LFOpqtRj4w
 r/iWXf3trMpOLM7Oz1uYF7zlsHM7Mjg8sa/OT2WpDx3oZvl1apBxB51hloi4ILd58gGR
 6WMpvKI5xnRidyDVNQqg9hmGMtkFmn3tHe4gIR1B9QmVJidayQswysPuks6XmxoMOKNh
 Cp5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbKBiyUM+R0Q6U2boY5c1WjO44qAX+ClDx3aEEpvlALoN32TDaWjhKSBNLUCSga/GMfKeEBxClIA==@nongnu.org
X-Gm-Message-State: AOJu0YwJGBYkfqHRB2fduhBIJCB8yEo+7OYSfwUV0Aal18xaJXkfeclL
 PCrIVDXOIsOHEm2B+nfC7i4aeAA/kleLkjnQNwhahDjzKZls77SQlS2uSQ==
X-Google-Smtp-Source: AGHT+IEntoyZ6tveFP0+JxzUDcL28RX2zlm0Ic4SBwxfa0c6W6Kq8abe+Em9f37Jbw/rnylKf1fsvw==
X-Received: by 2002:a17:902:da8c:b0:20b:79cb:492f with SMTP id
 d9443c01a7336-210c6c3446bmr452597295ad.43.1730679620711; 
 Sun, 03 Nov 2024 16:20:20 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/67] ppc/spapr: remove deprecated machine pseries-2.3
Date: Mon,  4 Nov 2024 10:18:08 +1000
Message-ID: <20241104001900.682660-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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
Removing pseries-2.3 specific code with this patch for now.

While at it, also remove the dynamic-reconfiguration option which was
introduced to disable it by default for legacy machines until pseries-2.3.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/core/machine.c           | 13 -------------
 hw/ppc/spapr.c              | 15 ---------------
 hw/ppc/spapr_pci.c          | 35 -----------------------------------
 include/hw/boards.h         |  3 ---
 include/hw/pci-host/spapr.h |  1 -
 5 files changed, 67 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2bbfcd1ede..0f10b4f992 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -281,19 +281,6 @@ GlobalProperty hw_compat_2_4[] = {
 };
 const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
 
-GlobalProperty hw_compat_2_3[] = {
-    { "virtio-blk-pci", "any_layout", "off" },
-    { "virtio-balloon-pci", "any_layout", "off" },
-    { "virtio-serial-pci", "any_layout", "off" },
-    { "virtio-9p-pci", "any_layout", "off" },
-    { "virtio-rng-pci", "any_layout", "off" },
-    { TYPE_PCI_DEVICE, "x-pcie-lnksta-dllla", "off" },
-    { "migration", "send-configuration", "off" },
-    { "migration", "send-section-footer", "off" },
-    { "migration", "store-global-state", "off" },
-};
-const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 34d655d0b3..599a59910c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5349,21 +5349,6 @@ static void spapr_machine_2_4_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 4);
 
-/*
- * pseries-2.3
- */
-
-static void spapr_machine_2_3_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
-    };
-    spapr_machine_2_4_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_SPAPR_MACHINE(2, 3);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5c0024bef9..8f1964ce52 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1237,10 +1237,6 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
     int i;
     uint8_t chassis;
 
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     chassis = chassis_from_bus(bus);
 
     if (pci_bus_is_root(bus)) {
@@ -1260,10 +1256,6 @@ static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
     int i;
     uint8_t chassis;
 
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     chassis = chassis_from_bus(bus);
 
     for (i = PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >= 0; i--) {
@@ -1548,17 +1540,6 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
     PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
-    if (!phb->dr_enabled) {
-        /* if this is a hotplug operation initiated by the user
-         * we need to let them know it's not enabled
-         */
-        if (plugged_dev->hotplugged) {
-            error_setg(errp, "Bus '%s' does not support hotplugging",
-                       phb->parent_obj.bus->qbus.name);
-            return;
-        }
-    }
-
     if (IS_PCI_BRIDGE(plugged_dev)) {
         if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
             return;
@@ -1591,14 +1572,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
-    /*
-     * If DR is disabled we don't need to do anything in the case of
-     * hotplug or coldplug callbacks.
-     */
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     g_assert(drc);
 
     if (IS_PCI_BRIDGE(plugged_dev)) {
@@ -1673,12 +1646,6 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
-    if (!phb->dr_enabled) {
-        error_setg(errp, "Bus '%s' does not support hotplugging",
-                   phb->parent_obj.bus->qbus.name);
-        return;
-    }
-
     g_assert(drc);
     g_assert(drc->dev == plugged_dev);
 
@@ -2089,8 +2056,6 @@ static Property spapr_phb_properties[] = {
                        SPAPR_PCI_MEM64_WIN_SIZE),
     DEFINE_PROP_UINT64("io_win_size", SpaprPhbState, io_win_size,
                        SPAPR_PCI_IO_WIN_SIZE),
-    DEFINE_PROP_BOOL("dynamic-reconfiguration", SpaprPhbState, dr_enabled,
-                     true),
     /* Default DMA window is 0..1GB */
     DEFINE_PROP_UINT64("dma_win_addr", SpaprPhbState, dma_win_addr, 0),
     DEFINE_PROP_UINT64("dma_win_size", SpaprPhbState, dma_win_size, 0x40000000),
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7e849bb30d..eea592b720 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -822,7 +822,4 @@ extern const size_t hw_compat_2_5_len;
 extern GlobalProperty hw_compat_2_4[];
 extern const size_t hw_compat_2_4_len;
 
-extern GlobalProperty hw_compat_2_3[];
-extern const size_t hw_compat_2_3_len;
-
 #endif
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 3778aac27b..79187e80fd 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -53,7 +53,6 @@ struct SpaprPhbState {
     uint32_t index;
     uint64_t buid;
     char *dtbusname;
-    bool dr_enabled;
 
     MemoryRegion memspace, iospace;
     hwaddr mem_win_addr, mem_win_size, mem64_win_addr, mem64_win_size;
-- 
2.45.2


