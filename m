Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF234606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u/SLjSWv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdx4-00026w-2m; Wed, 04 Nov 2026 11:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwn-00023o-4W
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwi-0007vf-3E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so6753215e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793810081; x=1794414881; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t+5JbQ0HHUceD7ap36KqXuS9pKy22l4YxJlfYhSYyes=;
 b=u/SLjSWvDA3hTHyssx15Bhh7BselS471k9KiSQhZTI+mJ8MHuCoda3M+26hhroNcaA
 eQJZzyeZ2g4itzgMJijyycajMw1dlXhQDReunZgK/d7h4MjyVM8phNkm96SSzIoDMgQ5
 sjvKDgWNK0i4ENZttTps2OnKjmtp+0Ls4MwFFKiKFuo+LoPYwVc6ELZd/G9sxTXBlmml
 eyef82C9xgZjrUK93p0HKZbYvdTs5/aTpeKmsFkiFHDw/zbYaD35/8oyzly0+7ulxlvl
 X4VrIjYMTrvsH1iq7v/beqSEYKd5mZieKx74TxpZHmY4JmLXPEFSYCFpoTwpyqK2DMbb
 yjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810081; x=1794414881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+5JbQ0HHUceD7ap36KqXuS9pKy22l4YxJlfYhSYyes=;
 b=WhDUTapHPhD4W0jyRH2v/7X33htq36KRmy7AVbl+bel5JNDjbYuyEiMxK2VMbSGbq+
 4P9MMYudmQbKDTb3xMcbcOwjdLH91EVUbHBbtr+qsLvhI4ypEoh5tZPL9uL0f4aVEiXG
 FFsE9ow9peOVRQKE01s9mO3uUVyMzN8G58KtW6VvRcD9LjMtGWOz3RoxT5YBVhdJwmx2
 zIqwlRVami8o22XOvvOXseV/CABVA+kTXYjBJ3jXGpsCP01ZBhF2hoGTDH2mxeeNfpCm
 BkArNRfmVTHEsiRzRNZOp+k3YpN0mdD9+qIRlacBP33WrAr/VDX66i8VSSXv3YpTQmN7
 hb4g==
X-Gm-Message-State: APuU4Z8cAtokksbL1se0hn7ioFqLccEbNtqKRN/lSm8f4cJvnRmUWDKf
 /mAU+em51LzBRQWyOomOaZcS+vuwhQE34b7DzyTzZ45+EwTdbE/tPrZN80l3HF71q2zB3NKLBP+
 OBMLRDRA=
X-Gm-Gg: AYBFou2nFn2W/eeMlrtMEe16CuTlsQtdshbjxkKK3MAxRHLEi4UdyKDsdVYDgAcJ3nm
 EExZ49X+Rep6ZDWBe3bqi8/cLMyONERyWkkPN5AlD/NJlEvlYUzGBFe5fGKr4YITMdB/cXzrgaF
 LAaIWF8rQ3Hgb8h4sWIlrWroEIqyBt5XryPojQGKI/pPPb0KmgnzA7dSJvW57gsPOdpYiUavHAK
 QqfR7V6jqYxpRkJ61Fe5V9Tjvoxpb3L5+czTbtNWMvSyXMoacBycuJ18LletBU43sIURkMzb+CN
 gHRaDPymkAtwPAgvG0PzdNBiXDAWuiRPem9NFFkPLf+nzHOnpmMr5Ja6mzPGqs9zvGbh1614Acz
 n3Fl4NfNy2hjz2Z0bknVjQBztgLEaYd+tL1ugKtyQAIP1TbiwKm+BZLK5LXNF4wx+UBB4xM1zLi
 bcE0ekk6Ngo6/NWrmyhCVIHUAF9BNC2yRh9RK3guDV+ZCEjQJJxGuIYPLVWSUmIMbvJwt/9U0HQ
 5RAW7iyNkA4pOymfV+T8OspE+IOrkCifr7kQv/hSGMZdvnwrtvKtNZxEB2njzPwYfsU2bqwj4+D
 IbHBs9HYoWkenhuqUBjKEIeVWFHvG/dEMg==
X-Received: by 2002:a05:600c:46d2:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4ac187a6a38mr381693335e9.19.1793810081550; 
 Wed, 04 Nov 2026 08:34:41 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:ace5:d1f9:7e3c:8531])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda203b6sm4658544f8f.48.2026.11.04.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:41 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 04 Nov 2026 16:34:36 +0000
Subject: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
In-Reply-To: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d..58e2d3b998 100644
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
@@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
     d->ahci.irq = &d->irq;
 }
 
+/* Sends an SPDM message and receives the response */
+static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
+{
+    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
+    void *rsp = doe_cap->read_mbox;
+    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
+
+    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
+                             SPDM_TRANSPORT_TYPE_DOE,
+                             req, req_len, rsp, rsp_len);
+    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
+
+    return recvd != 0;
+}
+
+/* SPDM protocols: plain and secured SPDM messages */
+static DOEProtocol doe_spdm_prot[] = {
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
+    { }
+};
+
 static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 {
     AHCIPCIState *d;
     int sata_cap_offset;
     uint8_t *sata_cap;
-    d = ICH9_AHCI(dev);
     int ret;
+    uint16_t cap_offset; /* Next offset for extended capabilities */
+
+    cap_offset = PCI_CONFIG_SPACE_SIZE;
+    d = ICH9_AHCI(dev);
 
     d->ahci.ports = 6;
     ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
@@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &d->ahci.mem);
 
+    /* Legacy capability for ICH9_SATA_CAP */
     sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
                                           ICH9_SATA_CAP_OFFSET, SATA_CAP_SIZE,
                                           errp);
@@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     /* Any error other than -ENOTSUP(board's MSI support is broken)
      * is a programming error.  Fall back to INTx silently on -ENOTSUP */
     assert(!ret || ret == -ENOTSUP);
+
+    /*
+     * Initialise a capability in the legacy space after the ICH9_SATA_CAP.
+     */
+    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
+
+    if (dev->spdm_port) {
+        /* Set up the DOE extended capability, mailboxes etc */
+        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
+                      doe_spdm_prot, true, 0);
+        cap_offset += PCI_DOE_SIZEOF;
+
+        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
+                                                            errp);
+        assert(dev->doe_spdm.spdm_socket > 0);
+    }
+
+    /* IDE extended capability */
+    pcie_ide_init(dev, cap_offset);
+    cap_offset += PCI_IDE_SIZEOF;
+
+    /* TEE capability bit in legacy space*/
+    pcie_cap_tee_init(dev);
 }
 
 static void pci_ich9_uninit(PCIDevice *dev)
@@ -176,18 +231,41 @@ static void pci_ich9_uninit(PCIDevice *dev)
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
@@ -199,7 +277,7 @@ static const TypeInfo ich_ahci_info = {
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


