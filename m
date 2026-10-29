Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA9606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QMttcau5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRhE-0000gb-TP; Thu, 29 Oct 2026 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgw-0000Uf-5i
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgr-0001x0-Vq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so8045965e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286316; x=1793891116; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dIosixHSeWmI855bbvysxZIprj8kr0dxJvid8Zb2/B4=;
 b=QMttcau5E8RkrWKbXsCiPaoWZxDMkJNfeYEF/1ORn4cpwqlQDkCDd4lYngY7OBJdAU
 WnlKQZB0u0h4sWjEE8w6mZ4xriR+fOMdyIR54oQncd1nwNC8xkDpFSXbuwigpaZTmzGI
 yqEovsRa6Y9ZqsiMHw8xdHdN4ydxZ+aV4HXMBIDcfg/4T7pXc5iV7fVBvNRsFJ9A2abx
 dwIwuHEM1TFV/jFZi7n2D9/c3+goa6Z0Eq9CbTZPI7ybl5BoNGWwBhWpH0PlnJ/jx8oV
 eL1q5X6xRzWt8J6/xzIxLfL3jUQuVohlV2Tfo7GsWXUKguZrKhnZBipB04OPMKbVTV7o
 aBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286316; x=1793891116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIosixHSeWmI855bbvysxZIprj8kr0dxJvid8Zb2/B4=;
 b=DvtgUGs1g+qQcjhgXUK6EsG69Z3bljksifH2ek5i+cB7DbJo/fJPqEhFvF+4Tq8BbS
 hXLz5UYQbc4vUN4c9gysYSiSPQCnQXbPOIBbgNeoFNyp03qvbJ+EsEFUk9myhvgKKqbT
 1wuqcP6zN3cZjNfsW3aodu2WLS1jqufXwbY71bqVbxgggivFXGt5rnHWxXE6nM9Qgnwf
 p7kphEq0pnF15bZcGp29PgEBpX9Jp2XFhegT4Cn4hGU1WkAbArZt2x5RqeX+6we6Kb9s
 sK9LqTBlvBLIGKncvEgyo0SffMyRPCalkBecYru4lAYxqIkFVDjnmS+bbae11WQpAb8Y
 ja9g==
X-Gm-Message-State: AFq9FYJBX5ejCFFnd+Jza35Yuw3Tc+dFFoGsmE6owM0UwvDzBnxJseIC
 G554A44ANhYwhaT94eXJWAEQxYZiiD+hSoGrj2KFviHAd/7F1hdXSqeiBB3gYbO8CiY=
X-Gm-Gg: AYBFou1cTRN1Ap6a3P6gGtuR5ETLLU+o1+BLJk5dZhQiIzGhUSIOzFUZ3IfXT7KRblA
 BwP6JAg3HjfoAjmUfY4+ohWksRPOk+MhUra/VLYQu05kZQvt4ZPshmhZrbzXLtaU/JxT3xZ1XKV
 wgdJDtIpBM8yX3GGrFz5+ZatJZZDp1GJhhX2wHEGlFpepnDU/0Bktr7G/ANy4+nAlgyGJSRlo1P
 BK1lVlN9mipMJNSrGazU3gnQyblp7m3HG630RKTYKH1IBtnSuYTC6sPfo9+VavEmyvDycFxxbmh
 QQtEn7tvR6rUModIkhB8S5j5bcv97vLrsdVSMgo4rqSbe32/V/E/dlC5UxgyvELwGf5d35rImP7
 CSNlBze7MySDRPMEqLER23+KfQp60JHIfXP2rpl61NQ9EUEo1XWHuBkyxBS32LlXN1rGYerqPkJ
 YCSdD3UXkBUJVJf4HoEp+KBGg58F7BKEPlBYmEpsjK8INqTuUvG2xaxDvWBQbm31P2M4dNhzSx2
 0B8ugkRYfUtG+U/khDEYs5fJYrrsI+oeMGUWZnwZ+rlzjAf7D/52zpn/9CkpjtYOxxj50X7S5yB
 B8WZfDMNDvIGjX9myOOBc9ZOKhEonyz1
X-Received: by 2002:a05:600c:4694:b0:4a8:a341:2377 with SMTP id
 5b1f17b1804b1-4aa86a4250dmr72274325e9.3.1793286316575; 
 Thu, 29 Oct 2026 08:05:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6ea5:6074:196c:9c53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm80999075e9.2.2026.10.29.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:05:15 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 29 Oct 2026 15:05:11 +0000
Subject: [PATCH 2/4] hw/pci: add IDE + TEE capability to PCIe root port
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Jim MacArthur <"Jim MacArthur"@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Adds the TEE flag in the legacy config space, and the IDE
(Integrity & Data Encryption) extended capability. These
will be present when rme-cap=on is specified for the
pcie-root-port device.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <Jim MacArthur@linaro.org>
---
 hw/pci-bridge/gen_pcie_root_port.c | 21 ++++++++++++++++++++-
 hw/pci/pcie.c                      | 19 +++++++++++++++++++
 include/hw/pci/pcie.h              |  3 +++
 include/hw/pci/pcie_regs.h         |  4 ++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 5434d693d9..ab8087da87 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -26,13 +26,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
         (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
-
+#define GEN_PCIE_ROOT_PORT_ACS_END \
+        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
 
 struct GenPCIERootPort {
     /*< private >*/
     PCIESlot parent_obj;
+    bool     rme_caps;
+
     /*< public >*/
 
     /* additional resources to reserve */
@@ -71,6 +74,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
     GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     Error *local_err = NULL;
+    uint32_t next_cap_offset = GEN_PCIE_ROOT_PORT_ACS_END;
 
     rpc->parent_realize(dev, &local_err);
     if (local_err) {
@@ -100,6 +104,19 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
         d->wmask[PCI_IO_BASE] = 0;
         d->wmask[PCI_IO_LIMIT] = 0;
     }
+
+    if (grp->rme_caps) {
+        pcie_ide_init(d, next_cap_offset);
+
+        /* Unused value, but may be useful for the next capability */
+        next_cap_offset += PCI_IDE_SIZEOF;
+
+        /*
+         * Set up TEE (in the legacy config space, not an extended
+         * capability)
+         */
+        pcie_cap_tee_init(d);
+    }
 }
 
 static const VMStateDescription vmstate_rp_dev = {
@@ -133,6 +150,8 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("rme-caps", GenPCIERootPort,
+                     rme_caps, false),
 };
 
 static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 42c4997b42..bf2c184cfc 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -968,6 +968,16 @@ void pcie_cap_flr_write_config(PCIDevice *dev,
     }
 }
 
+/*
+ * Set PCI_EXP_DEVCAP_TEE flag in the PCI Express Capability Structure
+ * (in legacy config space) indicating that we support TEE-IO.
+ */
+void pcie_cap_tee_init(PCIDevice *dev)
+{
+    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP,
+                               PCI_EXP_DEVCAP_TEE);
+}
+
 /* Alternative Routing-ID Interpretation (ARI)
  * forwarding support for root and downstream ports
  */
@@ -1387,6 +1397,15 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
     return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ);
 }
 
+/* IDE (Integrity & Data Encryption) */
+void pcie_ide_init(PCIDevice *dev, uint16_t offset)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_IDE, PCI_IDE_VER,
+                        offset, PCI_IDE_SIZEOF);
+    uint32_t cap = PCI_IDE_CAP_SELECTIVE;
+    pci_set_byte(dev->config + offset + PCI_IDE_CAP, cap);
+}
+
 bool pcie_pri_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pri_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 86c29f7d8b..6c02c846df 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -123,6 +123,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
 void pcie_cap_flr_write_config(PCIDevice *dev,
                            uint32_t addr, uint32_t val, int len);
 
+void pcie_cap_tee_init(PCIDevice *dev);
+
 /* ARI forwarding capability and control */
 void pcie_cap_arifwd_init(PCIDevice *dev);
 void pcie_cap_arifwd_reset(PCIDevice *dev);
@@ -165,6 +167,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
                    bool prg_response_pasid_req);
+void pcie_ide_init(PCIDevice *dev, uint16_t offset);
 
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 33a22229fe..aa21177411 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_DOE_VER                     0x1
 #define PCI_DOE_SIZEOF                  24
 
+/* IDE */
+#define PCI_IDE_VER                     0x1
+#define PCI_IDE_SIZEOF                  12
+
 #endif /* QEMU_PCIE_REGS_H */

-- 
2.43.0


