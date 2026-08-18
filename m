Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE9EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJvq-0003n7-VA; Tue, 18 Aug 2026 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvm-0003lj-Sz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvj-00008b-V4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so2946856f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787059958; x=1787664758; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+jDim19iBFmebWRV3oEtOp0uuBONKIVk2nTBz2GCZ0=;
 b=K5umEP1AHN3PDVMbLoSvqz3zB/o+Sa0/OdnzwlvlxneeOic4Q1/DOf/gq76sdsD8rx
 QeBvaQij732BdntOdrXwfRMPe/dYShyM3k2YJqJi2G/MRJc75f8jaQhKO5Jf8g+nFY4p
 k45RwgMve+B+Src2V1Nbb+DfKN5FPg2XxrFP4/FthOMWFILNBUBBYRn8v74EVDjQ4A2T
 eu4IC1XLeTTpc21Ux0YFhsBLEaeONkaBdLehiEyD5tMLq4sMauBSGetA+024HAnHR1+x
 YAayQ50pUuDZcX//5AiqqY5uNJXgd2qt6XNcrWeiUVbIJuXi812erhduMVD0MSkuagt1
 riQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059958; x=1787664758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W+jDim19iBFmebWRV3oEtOp0uuBONKIVk2nTBz2GCZ0=;
 b=clWXkZMpUCgkPWRylmxEGnFHCZflAgjoeeYWKav112vjr0WupT83tpbvmBdIOhWENk
 XuycP+gntK6gL//Lv+DipqmY01pY99k4fBLRJ2cnpSCtoQImu7O91946HqOfoeiYke+2
 ArT5MWyQXgPKyWEocXFd3dHPgBQxeNSRyr776C5fsASODML2ZMVO3noSnLJThNP6n/+g
 TzpuKupgAVfp0Zr2sHB7k6fFiGiA0pDZX1CbjbfM2IA1q3hsNkSB4WFeP3hfq448G+9W
 av6vzza9SnAWkH6f3yaGVwOrzCkaiMufJstZVYHeYcYfh6RsX5BWuptVpnRLQ0CHQjc4
 ucig==
X-Gm-Message-State: AOJu0YzfOw8jUKHKUVWgZr+/L3sDDiRmB9zeQZrmqYr8kRDYly7pHart
 MTnNxjx79RvsiGz85UBb8uFlMvLtzvYwoGTz9vIBKrhRoedhahMO8RG4KqpiXVjBlNUy3H+1qVD
 P237FAtQ=
X-Gm-Gg: AR+sD133kVdZ9O9YOb7Rv1Rnn0doIrlLOH/z9ECfKvrTeFPMJP4MfcEHP5jgwIc353o
 ICWs7yYactLMoV1jYUUXump5A2ZqCtsTlWq9l8Fs6iNc4lbpgMk9eQDUXTdAtr4ZV18dCt3jzgF
 sowS1pL7sEWEt7aPsFGjjsfyP2dCrgqcWLc6QR1LeSBKCw+Fs1i5hW3sOLl8GsnHmNg93WQYZSK
 QqeMnB7iF6PVoCHRdqFC3Wwu/Te8kPcrqsCQJ1bTsYA4uOC2j1CVNOsiS52LFuqS4J4vF8fsSXq
 bCIkYDevmjdjtwpxqmIZ0bhHZQBefJGeF3Fk1ajFrPwGqdlqElPCZIgi3wWFDGvHgUM2GbrGyPc
 FzpdLzlaF1GEzkk5lJ/GewHLXPqacaVswHPoOrAv1aKgkCvJjq6pbYgv51bI1NXyLSduZBx5Xsf
 2C2jyOEALaEd8xguJYiQhsn3tGNODW9lb53p3jgWG9BoHoRwQAA2G+yUSFtJ0Lo1tZGLXSZw==
X-Received: by 2002:a05:600c:64c6:b0:499:84ff:b16 with SMTP id
 5b1f17b1804b1-4999fb4d60bmr167148815e9.14.1787059958322; 
 Tue, 18 Aug 2026 06:32:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:c289:2687:e46c:f7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm298360625e9.3.2026.08.18.06.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:32:37 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 18 Aug 2026 14:32:00 +0100
Subject: [PATCH RFC 2/4] sata: add SPDM + IDE + TEE pci support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-jmac-rme-da-prep-v1-2-30fab951bc75@linaro.org>
References: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
In-Reply-To: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42a.google.com
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


