Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76078606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVqsrE5a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdwv-00023u-5P; Wed, 04 Nov 2026 11:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwl-00023G-Ir
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwh-0007vR-EL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so225254f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793810081; x=1794414881; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mnXTXFEM6xp7dmWyu6ar6a4boNwn6sCrd6fIbiJ37/c=;
 b=wVqsrE5aVOrgeMmZYSnmRniBMulKhRVvCo/oqtRoJ0DRct9pjOoSD/Kf0XBWTFtjG2
 jRZ1quBgXpVQMUH6TlQmEsixGXm32vjzAnTsEqEPkvhHieA86o0bTpc1NZjKP86drNBa
 vjTKbX5L7CpvNsEUVucrueKvuOulok/dhNu4mnN+MfinptYG5IyqIUPYLK+C8kNjBdAJ
 zcuh/cVTJMUaNNan12mbOElhxP26X4VkXHXvGKfm34QEtMZ7/MHDk5kqOO7y3r8/+HIf
 qZ2ggWGa9jSkJURqWQnS/klRtKBpYGzfJ7ePkijZ+/EMromczw6AaOo6CTBKdntHwiTj
 CmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810081; x=1794414881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mnXTXFEM6xp7dmWyu6ar6a4boNwn6sCrd6fIbiJ37/c=;
 b=kIVlf7ShIFz7dxwbtY+OHZ/rdeXR2TPFkvNVU2IOBLGPK5RevvgQNeve9W5akvUqIp
 o62ujs9DEb0zHQAw8fV22yqKQUzpSXWNmPiY4XGkaMq3zIBbwMzrd2w4ipFCRyPsvILT
 7tbXCEF6WiQUKlaYtUBroXja7VtBDH8nkK0IHryaH3bbsaThBnLApbrNC/wVcqos48dl
 cvHuhN08jbzCeW6N+UbGCH6e2RvYFt7jJeQ/VBwPBzUxYjAxPRFM8IVhASnfmbQwPjdJ
 R8qcs6il4frV1NyNNhej5q8FLlnevDznvpieTUVf/30gCBfD1q8fwYR3gbjVTYZ2IoBM
 LZDg==
X-Gm-Message-State: APuU4Z+WkCUqz6vZ0yUgQZRqqQ8YpmRT1LXa4QECyq/Xd+hjEE8+2Nyb
 SzFh7NPKImoaQlw4rL/j/+YHPQZ1ueMMUjvIT4b8QUzt61My04YZc+lqhCd0xwuQm25dVl2rYIf
 yplChmsQ=
X-Gm-Gg: AYBFou00M0DAjoeqRqFSC5apCRQZ00G/wxHKs4NEemG1A7XI+qcQTQwOsbmY7ljczYN
 n5+XP9YkIXRx10xEBp7u92IUgz/JGOeCcIQgSrjARpsLvFhGZL5yD86MuCbxWJQUi7ePF2X2MZ6
 bEo6ULS0Rgzzs5tJA3Oh8KZ/PGpMoS2PdJxuMP8iWwWubdxUjETQtT8cP8SeYWy+eQ4mF8lrWxG
 EiaFlA+hG97brzURpt0OKOFwYbvYvzr+p9Ky9WC6QCtx9nsYiQtta7psMhHfv5WD4epVX60YwiU
 7UjEg3qHZMb7dyn3Mz2ltUpz0ObEtjzfzKq05Wqbt+scuF3sJts7z6Nd4R44yJerahQzyoH7Na3
 UwmhUPYDGimpxP1ArCuTTfy4UHNye59h8G1g5Cl0VP7Vuwf1oHESrfOfHIUCvDZOMkCr7X2TNOE
 L235c6fcB5Erysuea7j0Ug5mUAFbUEHOvwH5pw5uSFFYtspBo4h28bba5ST99RNea3VVqIf+eql
 +jg8DJ2lZoBVyxHotznFJQsLMrNB/+fRGz4ShXaWpodLMLQ/JXJ445CghrYciNIUl11zRrAEpIc
 rcdJF2XWj6iWldgH+650TA+etRcFaCpKgw==
X-Received: by 2002:a5d:64e3:0:b0:48d:f876:f370 with SMTP id
 ffacd0b85a97d-48e6e309763mr35069141f8f.48.1793810080824; 
 Wed, 04 Nov 2026 08:34:40 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:ace5:d1f9:7e3c:8531])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda203b6sm4658544f8f.48.2026.11.04.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:40 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 04 Nov 2026 16:34:35 +0000
Subject: [PATCH 1/2] hw/pci: IDE, TEE support functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ich-driver-spdm-v1-1-60d361bc0417@linaro.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
In-Reply-To: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42b.google.com
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

These were introduced in the PCIe Root registers patch series, but need to be
duplicated for the ICH9 driver patch.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci/pcie.c              | 15 +++++++++++++++
 include/hw/pci/pcie.h      |  2 ++
 include/hw/pci/pcie_regs.h |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index bd00305ecc..7dfb0af801 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1389,6 +1389,21 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
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
+void pcie_cap_tee_init(PCIDevice *dev)
+{
+    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP,
+                               PCI_EXP_DEVCAP_TEE);
+}
+
 bool pcie_pri_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pri_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de..bdebbfffe9 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -161,6 +161,8 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
                    bool prg_response_pasid_req);
+void pcie_ide_init(PCIDevice *dev, uint16_t offset);
+void pcie_cap_tee_init(PCIDevice *dev);
 
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 33a22229fe..5f527abf35 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_DOE_VER                     0x1
 #define PCI_DOE_SIZEOF                  24
 
+/* IDE Fields */
+#define PCI_IDE_VER                     0x1
+#define PCI_IDE_SIZEOF                  12
+
 #endif /* QEMU_PCIE_REGS_H */

-- 
2.43.0


