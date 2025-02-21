Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A48C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4R-0006RP-QR; Fri, 21 Feb 2025 07:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4N-0006A9-Jb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4L-000775-1v
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kmJLONp2OhkpfuMOLSYnuEY7cqZckWFV/n/C9H76MQ=;
 b=Upxms1YHOWG1HTX7YPWUx2MTcZGX8qcEK1fUFi+qU3usn/hiJi7D2L6cJ9Vp92vRaVY4v3
 zYXr0vZJ1nIet28uXhRzPNFw6U2OqJtnxWJrT5eAm827ise80flb9OGM/eRBieDYSHR2Cd
 jI6OMGlk3vUhrVvkfTkR8SZZB24itTE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-x8ONGrvdNPWE5i3WXFvBGA-1; Fri, 21 Feb 2025 07:23:45 -0500
X-MC-Unique: x8ONGrvdNPWE5i3WXFvBGA-1
X-Mimecast-MFC-AGG-ID: x8ONGrvdNPWE5i3WXFvBGA_1740140624
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so1468734f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140624; x=1740745424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/kmJLONp2OhkpfuMOLSYnuEY7cqZckWFV/n/C9H76MQ=;
 b=r1x5dmhzirera+fKUDS2IZ9maeewJp1epaHKgQ2pG3zWyH2uFgMhQdNao4AwdxFZ43
 cmRVXXZWZ5iR4eHd24SAyU9ti7wAsONLavFWilbaXyt4g0ZW99msJFXBzOmBch6Qv4Ul
 gIDqfrfOYYWWV74rDiSGuxy2nmptcKVrC4EIkgsDIqfcK6KraQ0XBJtpKMdqZNpHKC/r
 tx0hiN3Xh9LTfWbUzrVL8koyBklphZv9vj1mj+4wTK+OeSeLg8F53q1gs7UQSGFfVOr4
 2hCe3PVc1056CUFbl0lf8LgUhXd9arZBkJ/Z1UOBSD2ovDbuHGQnIUjRNOPeRoT8SPaw
 bpxQ==
X-Gm-Message-State: AOJu0YyqLepf9EWory3z+ZzLEfL09lj61juEV52sjC71xJkeA9WKi0wG
 eNRKSeymjrxbTUqumsZ9r+AjBX5FvKjiEgWHtmKrNeI8zp+tVMMFaxbx0nobwdpe6d/oMmlah7w
 /gcfuyTGEIVoQGWtXwxJB1cpWaiD9e+Qw86PQULioOkxNaW7xcOEWPUjBgIGchNBgIip8nGJkYj
 jBBBZSRjzuHW6/gtOn4YLg7f8yg9Jx1A==
X-Gm-Gg: ASbGnctylFVvilgCN9q7jxq59CCoYsDpHf120TjbsWcMfHT4AgSt3CWLlEpAP7lZZI1
 3nefuEN+6woB7FCfIR/9GNbK1yy7N9FINn8IokZQTKlTiDv9kjyqNF3VHdkLxwiYZAXAk8boPI2
 InAHYTGQhFjMgO579en1luPezI6oz0QdhbPPtMLoI4IdE+tYyGVxhOE/o/qpwcb+227/yvTxqvk
 4Oe8mfeYpcuabarCsq8JkiqHKxDJea3P0lGBL+5E3bhgzQGFlM1MgpBZFdOkKW+CRlIBSkNBEy7
 B3o9HA==
X-Received: by 2002:a5d:584a:0:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-38f614991f2mr6180249f8f.6.1740140623766; 
 Fri, 21 Feb 2025 04:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFDL+zlxYKdIihf74iUeeE4fGEfxbyh9v74/Wv9N8hj3ncytNmdrEaDkcUWhVFnarzzBvS7g==
X-Received: by 2002:a5d:584a:0:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-38f614991f2mr6180221f8f.6.1740140623274; 
 Fri, 21 Feb 2025 04:23:43 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce435sm16127735e9.3.2025.02.21.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:42 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 20/41] hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
Message-ID: <8f90a54cfafe8c93a71930a96a63ccbd074f4142.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhijian <lizhijian@fujitsu.com>

Introduce the `CXL_T3_MSIX_VECTOR` enumeration to specify MSIX vector
assignments specific to the Type 3 (T3) CXL device.

The primary goal of this change is to encapsulate the MSIX vector uses
that are unique to the T3 device within an enumeration, improving code
readability and maintenance by avoiding magic numbers. This organizational
change allows for more explicit references to each vector’s role, thereby
reducing the potential for misconfiguration.

It also modified `mailbox_reg_init_common` to accept the `msi_n` parameter,
reflecting the new MSIX vector setup.

This pertains to the T3 device privately; other endpoints should refrain from
using it, despite its public accessibility to all of them.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250203161908.145406-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  4 ++--
 hw/cxl/cxl-device-utils.c   | 12 +++++-------
 hw/cxl/switch-mailbox-cci.c |  4 +++-
 hw/mem/cxl_type3.c          | 20 ++++++++++++++------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..3a0ee7e8e7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -264,8 +264,8 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
 typedef struct CXLType3Dev CXLType3Dev;
 typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
-void cxl_device_register_init_t3(CXLType3Dev *ct3d);
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n);
 
 /*
  * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..52ad1e4c3f 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -352,10 +352,8 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
     }
 }
 
-static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
+static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate, int msi_n)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -382,7 +380,7 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->memdev_status = memdev_status_reg;
 }
 
-void cxl_device_register_init_t3(CXLType3Dev *ct3d)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -398,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
         CXL_MEM_DEV_STATUS_VERSION);
@@ -408,7 +406,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -423,7 +421,7 @@ void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 65cdac6cc1..833b824619 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -17,10 +17,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 
+#define CXL_SWCCI_MSIX_MBOX 3
+
 static void cswmbcci_reset(DeviceState *dev)
 {
     CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
-    cxl_device_register_init_swcci(cswmb);
+    cxl_device_register_init_swcci(cswmb, CXL_SWCCI_MSIX_MBOX);
 }
 
 static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a34..ebc0ec536e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,14 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 
+/* type3 device private */
+enum CXL_T3_MSIX_VECTOR {
+    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,
+    CXL_T3_MSIX_EVENT_START = 2,
+    CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_T3_MSIX_VECTOR_NR
+};
+
 #define DWORD_BYTE 4
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -843,7 +851,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +891,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +916,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_T3_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
@@ -1202,7 +1210,7 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_t3(ct3d);
+    cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
MST


