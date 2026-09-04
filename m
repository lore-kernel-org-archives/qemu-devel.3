Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CEAC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WPz-00013U-0K; Fri, 04 Sep 2026 12:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPr-0000s8-46
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:24 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPk-0006FT-1e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:22 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso158717966b.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537912; x=1789142712; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+jDim19iBFmebWRV3oEtOp0uuBONKIVk2nTBz2GCZ0=;
 b=EoBTSDXqNGRB9HUy6rG8Bqn+5ROySjvPyRSYKgksR81G1MBuLCsjY16KUJqLgcSfDF
 Rfr+McbthaM9Yk65VqZLVavyrEnfyb7kveHepGUTudW1fr10cM5pEKdy5KvPQwjtToEC
 /mjPprf6tTFYpfSLQlwy984n3JwUgphmKnVgr1hEh00Vb9sCHqlXdqLOlrFJzN+7yZx1
 MMdSvsxgfiNhbOHDWDQyzmFLKE/ezME1gvwtT58ZBdrBF0SiNnav9ZYaItD+wT+jyPR2
 3LfYIvtozzXSg/aAE4dfhdZwP5hW6o7aoY103sc+UPqOHEqCmmYXrU4Pkz2MV/393ATN
 u/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537912; x=1789142712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W+jDim19iBFmebWRV3oEtOp0uuBONKIVk2nTBz2GCZ0=;
 b=syXFwmdeTduS14LKXwk8EX71E4GLPOKgRlFtOzZSonP5tzwBQ+BrFFIaGtICOvjzP7
 Pvyk4o/ZUclfBMo1SINpJML6JgeQkE8Z7Z9CWBw3DHXYPZ4wk0B/UzyJgBbwt92bWcCv
 LFs9RaLAYPg616MsH9bAA6SCf/F2KoorijyIWuaQjKdcSWu8EQq8xZsQN45tMWF32KiT
 GqbqFyIx7UWI/IZ4s5AoMPO+AQaocoxBiaJyq58ldTvBifvWpGITlLEiF3qVKCUF5K8J
 N2hQI+ynXKmXZUWx+ORslROM0N3L2y0uCIDTk1qPPuGNDsgzKYvM0fK8TLY9ngXh8G54
 W1Aw==
X-Gm-Message-State: AFuF++msYzHgMTu+Hn06uEliyuEDPyC8wy+5seOaq/rQyJ3KbHSqCo2z
 6oIzji9NeagKwW87dRk/UdGugEZCOJ7UXUu75W8FecbDm1fCSFw5R3arEGTeG6Oqk0WgNfLl8V7
 wnEn92Lo=
X-Gm-Gg: AYBFou19XGMun8GvuJu9RIyUOiY4zY9BTMTVGlYC4hRHgS7cZQ8fZXLKE5v0Nlr0f9l
 XtQ8KGDaPwEWSY+5t0+MS5CGZH4uuGV9rB6G+HSsd4Wj50/kG+/BELeq8QOgWd9gqlQ7fmj+g3o
 9Re63qvIR/dumd5IswZi1sbV91A1U7bKS+4hyixLaRK9mSy1MzAy0AzplhiR602F2VGKYXpTj9l
 QSAWF97N3N+9TntJdmNb4HVJzTc+1CiaPPCjisWv+xnPK6C1ZWYvbwqhCYzuFB4s6aK60nPyUd+
 YLRN1eYpWYpMCrpTfsQBiYhMILUDS5pPNUDnIWlLig2/w7keg2p3iLakGrAIfZWA84l7ouSbRSJ
 08G51iSmo6dDD2rK9AvfFSRK8Zwnf8f6laif7Fh61/VrHKLZbJJynlihinhJRhxX976vsh7fqGG
 xrNVDlSTrgrecbp9TFFaDPQ9RSyveQTNytH1gpiyqPiVL9pG4yVpDX3TrlqYYfeki9
X-Received: by 2002:a17:907:d18:b0:c25:4cff:5d01 with SMTP id
 a640c23a62f3a-c260c9f4a3bmr279304266b.18.1788537911764; 
 Fri, 04 Sep 2026 09:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:60d5:49d3:5d47:8dbd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d036674sm133815966b.8.2026.09.04.09.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:05:11 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 04 Sep 2026 17:05:02 +0100
Subject: [PATCH v2 2/4] sata: add SPDM + IDE + TEE pci support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jmac-rme-da-prep-v2-2-fb461d78bbb2@linaro.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
In-Reply-To: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Replaces the ICH9 config_write/config_read which versions which will use
DOE to write/read config if we have an SPDM port and DOE capability.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/ide/ich.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d..d2731598ea 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -70,6 +70,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "ahci-internal.h"
+#include "system/spdm-socket.h"
 
 #define ICH9_MSI_CAP_OFFSET     0x80
 #define ICH9_SATA_CAP_OFFSET    0xA8
@@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
     },
 };
 
+static const Property ich_props[] = {
+    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+};
+
 static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int level)
 {
     PCIDevice *pci_dev = opaque;
@@ -120,6 +125,27 @@ static void pci_ich9_ahci_init(Object *obj)
     d->ahci.irq = &d->irq;
 }
 
+static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
+{
+    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
+    void *rsp = doe_cap->read_mbox;
+    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
+
+    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
+                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+                             req, req_len, rsp, rsp_len);
+    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
+
+    return recvd != 0;
+}
+
+static DOEProtocol doe_spdm_prot[] = {
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
+    { }
+};
+
 static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 {
     AHCIPCIState *d;
@@ -145,6 +171,8 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &d->ahci.mem);
 
+    pcie_endpoint_cap_init(dev, 0xa8 + 0x8); /* right after SATA */
+
     sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
                                           ICH9_SATA_CAP_OFFSET, SATA_CAP_SIZE,
                                           errp);
@@ -165,6 +193,25 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     /* Any error other than -ENOTSUP(board's MSI support is broken)
      * is a programming error.  Fall back to INTx silently on -ENOTSUP */
     assert(!ret || ret == -ENOTSUP);
+
+    uint16_t cap_offset = PCI_CONFIG_SPACE_SIZE;
+
+    if (dev->spdm_port) {
+        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
+                      doe_spdm_prot, true, 0);
+        cap_offset += PCI_DOE_SIZEOF;
+
+        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
+                                                            errp);
+        assert(dev->doe_spdm.spdm_socket > 0);
+    }
+
+    /* ide */
+    pcie_ide_init(dev, cap_offset);
+    cap_offset += PCI_IDE_SIZEOF;
+
+    /* tee */
+    pcie_cap_tee_init(dev);
 }
 
 static void pci_ich9_uninit(PCIDevice *dev)
@@ -176,18 +223,41 @@ static void pci_ich9_uninit(PCIDevice *dev)
     ahci_uninit(&d->ahci);
 }
 
+static uint32_t ich_read_config(PCIDevice *dev, uint32_t address, int len)
+{
+    uint32_t val;
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+        if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
+            return val;
+        }
+    }
+    return pci_default_read_config(dev, address, len);
+}
+
+static void ich_write_config(PCIDevice *dev, uint32_t address,
+                                  uint32_t val, int len)
+{
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+        pcie_doe_write_config(&dev->doe_spdm, address, val, len);
+    }
+    pci_default_write_config(dev, address, val, len);
+}
+
 static void ich_ahci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_ich9_ahci_realize;
+    k->config_write = ich_write_config;
+    k->config_read = ich_read_config;
     k->exit = pci_ich9_uninit;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801IR;
     k->revision = 0x02;
     k->class_id = PCI_CLASS_STORAGE_SATA;
     dc->vmsd = &vmstate_ich9_ahci;
+    device_class_set_props(dc, ich_props);
     device_class_set_legacy_reset(dc, pci_ich9_reset);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -199,7 +269,7 @@ static const TypeInfo ich_ahci_info = {
     .instance_init = pci_ich9_ahci_init,
     .class_init    = ich_ahci_class_init,
     .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
         { },
     },
 };

-- 
2.43.0


