Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2655DC636B2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-000897-Bv; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASB-00084q-Vn
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS9-0006nP-Sy
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Z2tVFmaYSwzGEpyq4V6ueV4IT/I1gX5l24piymDD74=;
 b=C2hcPQXHN0ddqnMSbT/bnJvq297XZ60xI5zC+JIWyrKLfUu/z+U1FnDPnWXSeSOrfwlJEJ
 kQHrz8sDNCAV1pQrhopsLw5dr9Tp/JfASR2DmIFHf0Jq3QBfU03ltFxd5s99C1o+8iLpj0
 z9HBDYBRT4IwiETJAg7MM/BGI13bSd8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-QhIMeO8wPz6Pj3a7-ZOljQ-1; Sun, 22 Feb 2026 09:28:55 -0500
X-MC-Unique: QhIMeO8wPz6Pj3a7-ZOljQ-1
X-Mimecast-MFC-AGG-ID: QhIMeO8wPz6Pj3a7-ZOljQ_1771770534
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4376ec2b1cfso396107f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770534; x=1772375334; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Z2tVFmaYSwzGEpyq4V6ueV4IT/I1gX5l24piymDD74=;
 b=lXlvMRQa5rclt8cVyFOZ0u8A6XivcY4DR4LSLyU5sI1KO9g0wwuIawiUYeC2DmKv6H
 XDSwb/Q+vqNtG8dWF43OWRQsEwZW/oCvTVd9jsok6aRFbdBbifTF7GcOb3AOwIiqRMj7
 FRbVqtgxMLXRgIAnJHt4e0ghfTsxLCRuRlHl1OuBvIySLnvILq9Foot+2ZKntKbfu86W
 WkMw+2LmSrFp3dtyVdhmLpkp3Zt/PnJchHV8aKiPYnUvMbEcMt4ynRKxjKN1stGE6wGq
 YPvjsMFI+V5CNRaqI4Ebn5EspRrL1FiRC+HFPVmGlq53Zf7ZiiFZ6O6cDA8WlqKIl7nb
 yi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770534; x=1772375334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z2tVFmaYSwzGEpyq4V6ueV4IT/I1gX5l24piymDD74=;
 b=g3xnNL2/5l5ktqlH4QRG3fefm5TJnofc5E5zx33EiFdFmxwtAXo3pCqA/pzIPBXQpW
 T0hsfYpM3ZXjo4Iigcy/04QPehSCIjaZhyGGhgZpbYREid7JaKQwgOACjnv8tP8a5gbs
 A3YPULvBjDOBGoEssVO6e1UvePEO+//03pJyZasKUt7z/UIcB9JWAWeHmZVyiJBQ+LC/
 9zpzfSMD0xH5lRZAjRN3J2h0gzcFtr7Q51TutEzhfMyOWSHKRzJUWa2lnuqrR+D5kU+S
 GXEqJtgvixUWigni0qtzB/woMzj5/ZDd1gaszCfelQrF3ioYjX5jW28SfCGICFggI/Iw
 1zpw==
X-Gm-Message-State: AOJu0YyVKxxS0syRmlL+dixi+Jodz3AnPPMfYFagvWdbc+LlnxghlbTH
 4XrqRZdh62apb2tXrvG1unT+otlYJPxrNBFIhsDi8SJQ7ib2WUybszpIKTkNkdfRajDbwWH2yen
 YffmDenQ+83HPpfkNo1dB83pdNLV4od13VhcTFD3HTKFQqF+1HvupnxLj9VMPLgN611VWrhCm2+
 aigpKEeYnOUX442Egr71kKPtpmpKuhjGVD8g==
X-Gm-Gg: AZuq6aLyjCq6JlKIQpnW37sgfuSYHNjsMkAjk4om/xqXkehouamZeZyQ2dT+gUdQomH
 BrjILm3IcfoSwRyt3+oL7ZGJeOZxNf0o3mDZQxgTSScTi7qfhJst9ouZnHjeyTLxAXxHvYEVEye
 X6UY6qJdRZpiICCUKBCP+NTX5sd/KThMIkPPXfYillwcDzJZ0NZwI8a6B55yKwXYjrVSDtfMgcY
 w22ZgRYxp75TwsRZ4+Z0VHrR6iyD8wSCHh3lO/FQi07a/2cg03jHqvjvaqxXkHTwSu1TBgH/wOW
 4bGfSn6tT+tw4Ml6N18o9Mp9AZFlF6+0qaEyE/EE+1MDwp1puJy8nb4cWCnP3CiI1i9HwvwIebl
 C8uxLWj2Jb0m8xVpC8ImxynAWc1/LGETTPl0DrX0sDvXcgQ==
X-Received: by 2002:a05:6000:2c0e:b0:437:6e55:a736 with SMTP id
 ffacd0b85a97d-4396f153a10mr10698692f8f.7.1771770533872; 
 Sun, 22 Feb 2026 06:28:53 -0800 (PST)
X-Received: by 2002:a05:6000:2c0e:b0:437:6e55:a736 with SMTP id
 ffacd0b85a97d-4396f153a10mr10698655f8f.7.1771770533322; 
 Sun, 22 Feb 2026 06:28:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54760sm12542521f8f.35.2026.02.22.06.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:52 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dongjoo Seo <dongjoo.seo1@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/33] hw/pcie: Support enabling flit mode
Message-ID: <d29f3f5cddb2614b3eebe216cce59ef9350db0a0.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Davidlohr Bueso <dave@stgolabs.net>

PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
fundamental change in how data is transmitted over the bus to
improve transfer rates. It shifts from variable-sized Transaction
Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).

As with the link speed and width training, have ad-hoc property for
setting the flit mode and allow CXL components to make use of it.

For the CXL root port and dsp cases, always report flit mode but
the actual value after 'training' will depend on the downstream
device configuration.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c                        |  6 ++++--
 hw/pci-bridge/cxl_downstream.c            |  8 +++++---
 hw/pci-bridge/cxl_root_port.c             |  8 +++++---
 hw/pci-bridge/cxl_upstream.c              | 16 +++++++++-------
 hw/pci/pcie.c                             | 23 +++++++++++++++++++----
 include/hw/cxl/cxl_device.h               |  1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 include/hw/pci/pcie.h                     |  2 +-
 include/hw/pci/pcie_port.h                |  1 +
 9 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 10ad3b8b59..328322b1ef 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same as capabilities */
+        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
@@ -1315,7 +1315,8 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+                              ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
@@ -1354,6 +1355,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index f7b131e67e..64086d8ec2 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -94,8 +94,9 @@ static void cxl_dsp_reset(DeviceState *qdev)
     latch_registers(dsp);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
@@ -107,7 +108,7 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -182,7 +183,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_DOWNSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(d, cxl_cstate);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_DSP);
     pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -217,6 +218,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 197d3148d2..5641048084 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -104,8 +104,9 @@ static void latch_registers(CXLRootPort *crp)
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
@@ -126,7 +127,7 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* IO, Mem, non-MLD */
         .ctrl                    = 0x2,
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -176,7 +177,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_ROOT_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = pci_dev;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(pci_dev, cxl_cstate);
 
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_ROOT_PORT);
@@ -211,6 +212,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 6d708fadc2..c352d11dc7 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -101,28 +101,29 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
-    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(CXLUpstreamPort *usp)
 {
+    CXLComponentState *cxl_cstate = &usp->cxl_cstate;
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
                                EXTENSIONS_PORT_DVSEC_REVID, dvsec);
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x27, /* Cache, IO, Mem */
-        .status                  = 0x26, /* same */
+        .status                  = usp->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
@@ -132,7 +133,7 @@ static void build_dvsecs(CXLComponentState *cxl)
         .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
         .reg0_base_hi = 0,
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, dvsec);
 }
@@ -327,7 +328,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(usp);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
     pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -369,6 +370,7 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 50fc4aa8eb..cae5061e69 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -113,7 +113,7 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
 
 /* Includes setting the target speed default */
 static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
-                              PCIExpLinkSpeed speed)
+                              PCIExpLinkSpeed speed, bool flitmode)
 {
     /* Clear and fill LNKCAP from what was configured above */
     pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
@@ -158,10 +158,15 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
                                        PCI_EXP_LNKCAP2_SLS_64_0GB);
         }
     }
+
+    if (flitmode) {
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                   PCI_EXP_LNKSTA2_FLIT);
+    }
 }
 
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
-                               PCIExpLinkSpeed speed)
+                               PCIExpLinkSpeed speed, bool flitmode)
 {
     uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
 
@@ -175,7 +180,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));
 
-    pcie_cap_fill_lnk(exp_cap, width, speed);
+    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
 }
 
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
@@ -212,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
@@ -1175,6 +1180,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
     if (!target || !target->exp.exp_cap) {
         lnksta = lnkcap;
     } else {
+        uint16_t lnksta2;
+
         lnksta = target->config_read(target,
                                      target->exp.exp_cap + PCI_EXP_LNKSTA,
                                      sizeof(lnksta));
@@ -1188,6 +1195,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
         }
+
+        lnksta2 = target->config_read(target,
+                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                      sizeof(lnksta2));
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                     PCI_EXP_LNKSTA2_FLIT);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                   lnksta2 & PCI_EXP_LNKSTA2_FLIT);
     }
 
     if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d5906afb19..7d9236db8c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -726,6 +726,7 @@ struct CXLType3Dev {
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index f208397ffe..e3d6a27acc 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -15,6 +15,7 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index d4e065db82..71ba94874b 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -144,7 +144,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
-                               PCIExpLinkSpeed speed);
+                               PCIExpLinkSpeed speed, bool flitmode);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 7cd7af8cfa..53cd64c5ed 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -58,6 +58,7 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
-- 
MST


