Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D57606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bGFOKPFR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRhD-0000g6-SN; Thu, 29 Oct 2026 11:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgx-0000VB-LT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgt-0001xG-Ie
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso18887795e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286318; x=1793891118; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FGTa5GnchLgQZjl4QxIS3WSO0RUlMLzirsL9WDXylzA=;
 b=bGFOKPFR7Roev2d0qOInjlgH8VjDSQEQMybmyJiaxctvAYwx9hPA/7YmDF36qmMayA
 GlteSIno2qxbeqSi0eh+YSCvSPNBLWZwgljUMvehwEsL6/rm/p1CvGgO0ZPQlDkAp0kf
 0+7mL9tIDwHyWtCbIsoSHCwT+bVAXmuKeCWGcuM8I17ZvA+MKWbcdZLQ6nAI0lGMVI+R
 dVtt9j3QJ3AztQRXpG/fXM15k6ZQLT44pa2uUMJHGKiIO7iaLd/eDVUcO4JDpCOpV8m2
 rWWuOhshAKDamemR2rO3UK6nVsMHvlFRxzyp0LZa7qhn0TJMBhMfjbEOzkzb8N9YWoUb
 ntXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286318; x=1793891118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGTa5GnchLgQZjl4QxIS3WSO0RUlMLzirsL9WDXylzA=;
 b=rk1MKXUZCHy9T/zLgMPsbXy29vBG8MfUnD3O3rlTkg/HPQwMzsCGtmP5Rjg/F7SPzH
 TDkUIczG6ckqEcEcByZhzb8fgB2tD1ysWpfVSldWHYNQ9pu47qgO4QRZaJQWTZW4Nvji
 CsL5f/LpaVaN/sXOGRY+p02YYjfY8A3Drhfvmf2JxyzYidrFd1t+GER4iYVAOTxAzt4d
 xFDRtkfEJhym33Q+IPmKXqrRkgaTcEChtbeUUcqbTgaOqiVYpX9RfY60JQCUyZu7Fa0X
 /3SRWOCOa4RjfWDoWLDIBYQTkj72ZJg6XMImfxmpKxnvCf/2X6NLvs5O7svP02Aszfuy
 U0Bg==
X-Gm-Message-State: AFq9FYKqlnps84/0qDOEV9+gY0aTvUJuI2lk3JRVGX/ruGKOQtQVO3H2
 sN7R3TYOU3ceoOivvajgHG/TvEBdmgo220INSbTY0fkv4fYP4zl91eLfuuo4/G2AtTOn97j6O4M
 wGcm9xeY=
X-Gm-Gg: AYBFou3zriADo8C6VfF7gQEGbPuVaYtjnS0/oQWkyvo/K4okkEyCS7JsdXMmkXRNqPo
 W2gajjKh3iYAAMiVxxlc8XARKlKCTDS8Rj3CGTzTdtfmgzV8t09fVK+hvw0ndMqJXtgPo+4nCiQ
 AyW7ZlO+3tGleV/k5vHmZA+7TaWbZ6sINL6lFZbB9wUpgRswLBzGI5IkxucWfrd8Us3Tap8EtDA
 fhrSCa71vB0q+eXRWw+g5HC27ZLAN9N3hI+d51vR43KQK1YYWkR2WaN72hT9T/9CQ3ZTYI21bsJ
 ZuyEUQ6dOmVSros+bWorJ91tHWXdHVEufTPeRhhjxjce+4fliF7s3kbtKM2YnGx+PSKZlnfq7Gq
 hAhpn4eR9o5T3UXNzTL1hdFv7Agln4qT7i7PpapD/jRyiAicDX99ratxynJOwYJnSmr/+FlEUw/
 awprAJDOeOs3XBmfc7dGxCGl8dkZR31QtYSxmch/U189QCiQPV3wA8LxuyNO9ROpoG64URIxWai
 Z8lgD9uG9oUdq3XtiG51NzdEWBki2f1u499pVnmyLaM3SR0A0GHL72H4tP7wmvRTW1Kd4fg781d
 cKBVt+q8g7idL7MI3Zlqi9G+sg+b706yuWjk1Q/ysZEGbGbH/rIoRQ==
X-Received: by 2002:a05:600c:5309:b0:4a2:526b:d3fd with SMTP id
 5b1f17b1804b1-4a966a54f16mr128757865e9.15.1793286318063; 
 Thu, 29 Oct 2026 08:05:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6ea5:6074:196c:9c53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm80999075e9.2.2026.10.29.08.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:05:17 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 29 Oct 2026 15:05:13 +0000
Subject: [PATCH 4/4] hw/pci: More comments in pcie.c
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jmac-pcie-rme-extensions-v1-4-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci/pcie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index bf2c184cfc..c333ae01b2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1017,12 +1017,15 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
  * uint16_t ext_cap_size
  */
 
+/* Looks through the capability list and finds one matching the cap_id */
+
 /* Passing a cap_id value > 0xffff will return 0 and put end of list in prev */
 static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
                                           uint16_t *prev_p)
 {
     uint16_t prev = 0;
     uint16_t next;
+    /* Find the first header, after the main 'config' (legacy) space */
     uint32_t header = pci_get_long(dev->config + PCI_CONFIG_SPACE_SIZE);
 
     if (!header) {
@@ -1030,6 +1033,8 @@ static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
         next = 0;
         goto out;
     }
+
+    /* Iterate through the PCIe config space, using the next cap offset */
     for (next = PCI_CONFIG_SPACE_SIZE; next;
          prev = next, next = PCI_EXT_CAP_NEXT(header)) {
 
@@ -1049,11 +1054,19 @@ out:
     return next;
 }
 
+/*
+ * As above, but ignoring the 'prev' parameter.
+ * Returns offset of that capability in the config space.
+ */
 uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id)
 {
     return pcie_find_capability_list(dev, cap_id, NULL);
 }
 
+/*
+ * Given a capability at position pos, set that's capability's
+ * next capability offset to 'next'.
+ */
 static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
 {
     uint32_t header = pci_get_long(dev->config + pos);
@@ -1083,6 +1096,7 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
 bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
                             uint16_t offset, uint16_t size)
 {
+    /* Start at the PCI Extended configuration space */
     uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
     uint32_t header;
 

-- 
2.43.0


