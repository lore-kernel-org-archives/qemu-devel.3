Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C5606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=grqbZCdz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRhG-0000h5-3F; Thu, 29 Oct 2026 11:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgv-0000Ue-O5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgs-0001x9-SB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso20688925e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286317; x=1793891117; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n0KLLLT16+igxzivXL3SIC7X+OCWYePHlHCe94z57M0=;
 b=grqbZCdzbQCVihsrA0ytFddopondd4I4JKWFUWAKXPp7dYB8DVivLmBctC+ud8QFIL
 86QfLfur/qO6PsLB0DgehyZkz7r3pucmMaY9O2o7NDCFTO0QX0uGMlIEYOi5tfVNFRmU
 HbbCvluOQBvIn21wEslgV9hGTyVBST0KEzhj1KNfNAiOe09VJFoglzClliIc40Ottiaa
 vJbLNlqX9dYQtY4kNMm0A4xLGyNfsy4giU45C5jHRYcczDMb92x3S0kc1rOOnSHytaLC
 SkNXxXELkGZF2Dvcx6rejWT9ntzszD7lTAmVSAiHxnJMpszdwTxiS36IgHXzCwmSXnEa
 aGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286317; x=1793891117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0KLLLT16+igxzivXL3SIC7X+OCWYePHlHCe94z57M0=;
 b=qAjpjKQXPy/nh2br3Totf/0g4jwfmArMb41rIvCiSn1cp5xN9gKs7H/GI8VxwbXOaV
 GWS3j5UC90MvK6xsXBf4GRzRDm0jBXt0Z2tlBv6pBHH4KIVnFXXd+YAfrleMIFSvoAkk
 k6Qxg9nfOjJeNdH7j+xga12U5sygiJbgLBkhLnIdCjxLl7XiaVNsTj8/MbNDrZhIEUER
 /TW7NfyTHq68xW3VfKlWZuIQ2ltxnOw5/C65GN1KWTyBj3R4/PIt9LjLV6nDjQRrUwgl
 dalxKsTPdcmveL8GyPjLQpQmvvtpvK0EbYrrMLV1paKQA5SulbHyyVD6PBwn2fj2NgT2
 b0CQ==
X-Gm-Message-State: AFq9FYKkifwP2CEhBoby0cLa/MJKypIspLBDGfGLPTyKABodoIFX4LL4
 P84CyYs12OO6GN7Gv0BVjkHwhvWVd6Cap44ttKdJsu+YKhUzC9Vc0PQmnFpoBy/6e5sQxHEDpTO
 23msL0Yc=
X-Gm-Gg: AYBFou2ejFFKwa35urZiMuX6fugJVR71g0Ck6DAcF0iXxrUC42bKHqjsoK4ZbpONjlP
 aKC7QjGAHd2DafdTfexLGZsOyQ9HBoL9tX9ZAq578Spv9jedQc6AODtXX/akloFmQBeQQXCzxyh
 PThR90iplPYBb0vpTNPXsJiblD0Af7C1bh4KqPDAt9hsn6f5ECBY+TFWDmZB5kNozik/PfVJRmv
 62khsRLRQp9G4ZAXOC0SdBC9ApDWT+RmfULiPmpAHc1l9mqhZ4JKnzJJ8V+8ItPZ65nY8Livii9
 4+42b9O4uR3OWdnubXKFQEqmf7pg0qp1wy3iZt6ip6CwvNxzRmHmos3HzuhtNX1yiUX1kVv1YrT
 vFEYQGdyk2dIthEBKNTI5VSIyiFSNFoG7Yv/2609bHK4EeMumofCsMKGrxY7TOMWykmddkmCOKx
 VDciANc2Kxl+CnO0n8JYbwaXDgufs6dB4SFVrZwL/shSKo/+0hymxb6IzfqUnqtbkoRpamkH4iD
 MKVvu5QEjGCAoZ0ChbLWvSoSpx2/y5hCrnqN1SVnn2wQHavaJ7uIy/Aw/Xr48sFW2FRAr1vaoUn
 nb6YNZaIGU54JfeyqRWYkTJTN2+yZkLP
X-Received: by 2002:a05:600c:e547:20b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4a96667c854mr84263055e9.7.1793286317348; 
 Thu, 29 Oct 2026 08:05:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6ea5:6074:196c:9c53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm80999075e9.2.2026.10.29.08.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:05:16 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 29 Oct 2026 15:05:12 +0000
Subject: [PATCH 3/4] hw/pci: add DVSEC RMEDA capability to PCIe root port
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jmac-pcie-rme-extensions-v1-3-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32e.google.com
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

Again, gated by the rme-cap=on flag for pcie-root-port.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci-bridge/gen_pcie_root_port.c | 35 +++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie_regs.h         |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ab8087da87..fb8dbb7959 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -28,6 +28,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
         (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
 #define GEN_PCIE_ROOT_PORT_ACS_END \
         (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
+
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
 
@@ -67,6 +68,39 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
     msix_uninit_exclusive_bar(d);
 }
 
+static uint32_t add_rme_dvsec_capability(PCIDevice *device, uint32_t offset)
+{
+    /*
+     * dvsec rme-da
+     * https://developer.arm.com/documentation/den0129/latest/
+     * Arm RME System Architecture
+     * 0x0000 RMEDA_ECH See B3.2.6.2.1 RME-DA Extended Capability Header
+     * 0x0004 RMEDA_HEAD1 See B3.2.6.2.2 RME-DA DVSEC Header 1
+     * 0x0008 RMEDA_HEAD2 See B3.2.6.2.3 RME-DA DVSEC Header 2
+     * 0x000C RMEDA_CTL1 See B3.2.6.2.4 RME-DA Control register 1
+     * 0x0010 RMEDA_CTL2 See B3.2.6.2.5 RME-DA Control register 2
+     */
+    const uint32_t ARM_PCI_VID = 0x13b5;
+    const uint32_t RME_DA_DVSEC_ID = 0;
+    pcie_add_dvsec_capability(device, PCI_EXT_CAP_ID_DVSEC, 1, offset,
+                              PCI_RME_DVSEC_SIZE, ARM_PCI_VID,
+                              PCI_RME_DVSEC_VER, RME_DA_DVSEC_ID);
+    const uint32_t ctl1 = 0x1; /* support tdisp */
+    const uint32_t ctl2 = 0x0; /* unlocked */
+    pci_set_long(device->config + offset + 0xC, ctl1);
+    pci_set_long(device->config + offset + 0x10, ctl2);
+    device->wmask[offset + 0xC] = 0xff;
+    device->wmask[offset + 0xC + 1] = 0xff;
+    device->wmask[offset + 0xC + 2] = 0xff;
+    device->wmask[offset + 0xC + 3] = 0xff;
+    device->wmask[offset + 0x10] = 0xff;
+    device->wmask[offset + 0x10 + 1] = 0xff;
+    device->wmask[offset + 0x10 + 2] = 0xff;
+    device->wmask[offset + 0x10 + 3] = 0xff;
+    offset += PCI_RME_DVSEC_SIZE;
+    return offset;
+}
+
 static void gen_rp_realize(DeviceState *dev, Error **errp)
 {
     PCIDevice *d = PCI_DEVICE(dev);
@@ -106,6 +140,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
     }
 
     if (grp->rme_caps) {
+        next_cap_offset = add_rme_dvsec_capability(d, next_cap_offset);
         pcie_ide_init(d, next_cap_offset);
 
         /* Unused value, but may be useful for the next capability */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index aa21177411..da812d32ff 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -186,4 +186,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_IDE_VER                     0x1
 #define PCI_IDE_SIZEOF                  12
 
+/* RME DVSEC */
+#define PCI_RME_DVSEC_VER               0x1
+#define PCI_RME_DVSEC_SIZE              20
+
 #endif /* QEMU_PCIE_REGS_H */

-- 
2.43.0


