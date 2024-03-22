Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9ECD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMf-0006EZ-Av; Fri, 22 Mar 2024 14:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMe-0006EQ-EL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMZ-0006v5-HT
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFJEybjNBlNhQvwFFt4MhIGK0bhciTxSDQ/Ic7vginA=;
 b=YbBT2pXsgZdUe8zEY8DW5EanQpWJMtwTDU5lM6SLwbqy6wl0tQe6kpNsU9dipVeyOi6RJS
 +yV7eYOKClHUhPQdsrSjKA0q7+P9a4zEvGDRNPAuUUGuPGBNIsTNCQ0kOmMnLjaAHZe7aR
 bP6PnYzSYZOV8mHbHWY4nVeaDMaq1iM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UA8_Q8WyPX2oXtnc9CkakQ-1; Fri, 22 Mar 2024 14:11:29 -0400
X-MC-Unique: UA8_Q8WyPX2oXtnc9CkakQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5159663d035so1826425e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131087; x=1711735887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFJEybjNBlNhQvwFFt4MhIGK0bhciTxSDQ/Ic7vginA=;
 b=hTw5n9eWr/1H2IuHbHM+SQ/vxnNcF8mWvYtJBc6IR55WERxO04a3IK9JphQLj2qFai
 WvrDg17+MrKfBRS4zlFGkBGm8JhF/8fB/+v2l8xrO7/iRvEg7Nq5qssP3AgDGSPxOx1s
 qc0xwbeIcy0qNsOcMspaWexMkOJRRptZ2by0NcmTde7FN+LAUYvguy5vBCv9rEtFQKMq
 BqLz+dj7WmJtQ21qoFP0WaRaRXqBjRiVviLe400JlQaZdqFg5EO97NbfZU52LKXPx/v+
 TVeUUs6k0xkPbssNLzH0uJyAjRAwTY+0kQSgpZVgxb/ZxLoT0OLtJLSkwNDNt2+TVA9X
 +ejg==
X-Gm-Message-State: AOJu0YwolOzUgWm/ANF36nhQJ5P4TdWKN7xkRauN3zQFnAl6B8hIkieZ
 9ycwe1LupGwFIQXUFiDkAmVehmIN2X8w6jr2qny3jpmdWPpK/PEx9j8x25TnfwDzy5cCnF5UhCE
 mZiQy23Z3nRlgZvJw+xP0cV3RcUZLpqKOMKlQthn+Co/2u1Ejro4oF6YE1OYhAsKg7bxzDm+GqB
 5+5SJUtmRyATz7qmJ8jUpCkygHP5kPhr589zP3
X-Received: by 2002:a05:6512:32a1:b0:513:80b3:3eef with SMTP id
 q1-20020a05651232a100b0051380b33eefmr193386lfe.24.1711131086904; 
 Fri, 22 Mar 2024 11:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxx8c1OoHYtWrJKuLVFMqlmEZk+P1z+g1dQsrsYtFXiE99gF9FZ/zONQGFIX2F2CM3OryKnQ==
X-Received: by 2002:a05:6512:32a1:b0:513:80b3:3eef with SMTP id
 q1-20020a05651232a100b0051380b33eefmr193364lfe.24.1711131086521; 
 Fri, 22 Mar 2024 11:11:26 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 xa10-20020a170907b9ca00b00a454438091fsm75964ejc.70.2024.03.22.11.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 02/26] q35: Introduce smm_ranges property for q35-pci-host
Date: Fri, 22 Mar 2024 19:10:52 +0100
Message-ID: <20240322181116.1228416-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@linux.intel.com>

Add a q35 property to check whether or not SMM ranges, e.g. SMRAM, TSEG,
etc... exist for the target platform.  TDX doesn't support SMM and doesn't
play nice with QEMU modifying related guest memory ranges.

Signed-off-by: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240320083945.991426-19-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h      |  1 +
 include/hw/pci-host/q35.h |  1 +
 hw/i386/pc_q35.c          |  2 ++
 hw/pci-host/q35.c         | 42 +++++++++++++++++++++++++++------------
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d77..fb1d4106e50 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -161,6 +161,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 #define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
+#define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
 
 
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index bafcbe67521..22fadfa3ed7 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -50,6 +50,7 @@ struct MCHPCIState {
     MemoryRegion tseg_blackhole, tseg_window;
     MemoryRegion smbase_blackhole, smbase_window;
     bool has_smram_at_smbase;
+    bool has_smm_ranges;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b5922b44afa..7f2d85df75f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -219,6 +219,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->above_4g_mem_size, NULL);
     object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
                              pcms->default_bus_bypass_iommu, NULL);
+    object_property_set_bool(phb, PCI_HOST_PROP_SMM_RANGES,
+                             x86_machine_is_smm_enabled(x86ms), NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 98d4a7c253a..0b6cbaed7ed 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -179,6 +179,8 @@ static Property q35_host_props[] = {
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
                      mch.above_4g_mem_size, 0),
+    DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
+                     mch.has_smm_ranges, true),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -214,6 +216,7 @@ static void q35_host_initfn(Object *obj)
     /* mch's object_initialize resets the default value, set it again */
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
+
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
@@ -476,6 +479,10 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
                        MCH_HOST_BRIDGE_SMRAM_SIZE)) {
         mch_update_smram(mch);
@@ -494,10 +501,13 @@ static void mch_write_config(PCIDevice *d,
 static void mch_update(MCHPCIState *mch)
 {
     mch_update_pciexbar(mch);
+
     mch_update_pam(mch);
-    mch_update_smram(mch);
-    mch_update_ext_tseg_mbytes(mch);
-    mch_update_smbase_smram(mch);
+    if (mch->has_smm_ranges) {
+        mch_update_smram(mch);
+        mch_update_ext_tseg_mbytes(mch);
+        mch_update_smbase_smram(mch);
+    }
 
     /*
      * pci hole goes from end-of-low-ram to io-apic.
@@ -538,19 +548,21 @@ static void mch_reset(DeviceState *qdev)
     pci_set_quad(d->config + MCH_HOST_BRIDGE_PCIEXBAR,
                  MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);
 
-    d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
-    d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
-    d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
-    d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
+    if (mch->has_smm_ranges) {
+        d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
+        d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
+        d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
+        d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
 
-    if (mch->ext_tseg_mbytes > 0) {
-        pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                     MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+        if (mch->ext_tseg_mbytes > 0) {
+            pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+        }
+
+        d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+        d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
     }
 
-    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
-    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
-
     mch_update(mch);
 }
 
@@ -578,6 +590,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
-- 
2.44.0


