Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DDCC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYu-00022o-7Q; Sun, 01 Jun 2025 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYl-0001wf-Nl
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYf-0004aH-NL
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNH2pN0u94IUph1O8LRlSEdPOqYaYPrObBwYqpFSiHs=;
 b=AL1EeyWVcSmtd1/VzuBLgb8SLbWmDtWJuX0QO07jIl/wjTfdQWiAdylVHggMwAw676xPTJ
 4uyZpoEctyxVTTQbW0whq+Z6sitsZtF1n2uskM6BLlin5CrRcA8CJ23qjZWj/dn4Hd28ih
 F3WZHI4F/TLAdF61/moj4WFFl6D3QWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-e1IWxMe3PuSRCyJf5JDXew-1; Sun, 01 Jun 2025 11:25:05 -0400
X-MC-Unique: e1IWxMe3PuSRCyJf5JDXew-1
X-Mimecast-MFC-AGG-ID: e1IWxMe3PuSRCyJf5JDXew_1748791504
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so4822475e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791504; x=1749396304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNH2pN0u94IUph1O8LRlSEdPOqYaYPrObBwYqpFSiHs=;
 b=wN51aOhjZ62yrFRh5wmoDeWEZIwmvXWTenRKP/QEdyAIOlRUGqS8GhCd+W0FWxro4+
 CXtCBzZzqgYWfBeeQgwZvRHTG7E08T55+FLKyQHGP8gBiKpKUGMyjYQl5parQNPjupxe
 XN2HwjHCR8RMNMFe0TVqSVFv8cFgFuXxyOS94MWT4/R/4DVVlZq+Ji8w16xLcPp8LoFY
 qRZ1fMwWxjDSNCcoix1+JkcCfhXqJR9dGzTc36BLexI0a/Z9Du1+2pG5W30QfZD3ZN8F
 NNPnFTqU+1g0dVpdK5IX67DiojaMXkpyCyJU91XyfY24zf52GfDvHYzVpxG05HbXnfai
 B62w==
X-Gm-Message-State: AOJu0YzejCfS6u6+a9XSyiNPW2DdYXZwzV5pzfuo4EU0dMu21XyKrDB2
 c/lv5V743fvynJSLEpK+qPsjirjFGYG+9aUrJzK6yk4s4gnG3FbSGsjDaGl2w2r7Fn23oLonrjM
 FIAZTky6LOIQM9JRLx2WCEwBw+XsaU9V7mEHEKwU7U8ShqU0AHS9HZm2H35//c2LBA+8OSwO82v
 aufuBwnsaHY3kQ42j70ffvbwpPJVVXB5DZKg==
X-Gm-Gg: ASbGncvfZbY/N4qmpyAf2UBSRpuIejoHZ6O20+s/w+jMI6K/fWnwSEoQhnfcQiOBoyL
 2YsJ3kyAcWL5w+K6yFhzT5yxQ62HLjzvWGDls2fMvfjH9JknIxbT0biDsgMLQ4/xuqJGq5knZ/3
 YKEaZ9TMK74zB1XAvfX0l1KuCsnUApb8E9V6O1SkSAWtLCkuMrkZmfyTmCBxejSVtCL36LZClxZ
 NIaDxvSNgqA88sE8PgEUhorNXNLd16IXauaKG8rDuuvIgOy9LovcwqmdB8IA2VZxs4Vn5OqCL9c
 +09/VWUGi0BXP/pq
X-Received: by 2002:a05:600c:3f10:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-450d6591a0cmr81504115e9.32.1748791504021; 
 Sun, 01 Jun 2025 08:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcpYmUcW4ddwEGeMlju21OGvKaEaOH0ahLk/BxKlzlyAKq2Anx4271y3mjDyF9gW9m00/yCg==
X-Received: by 2002:a05:600c:3f10:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-450d6591a0cmr81503945e9.32.1748791503616; 
 Sun, 01 Jun 2025 08:25:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8edf9sm87826135e9.3.2025.06.01.08.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:02 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 07/31] pcie: Add a helper to declare the PRI capability for a
 pcie device
Message-ID: <dcad6cb2abf4ffc4f911041d0547c4b54c2f92e2.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-5-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h      |  5 ++++-
 include/hw/pci/pcie_regs.h |  3 +++
 hw/pci/pcie.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 497d0bc2d2..17f06cd5d6 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -70,9 +70,10 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
 
-    /* Offset of ATS and PASID capabilities in config space */
+    /* Offset of ATS, PRI and PASID capabilities in config space */
     uint16_t ats_cap;
     uint16_t pasid_cap;
+    uint16_t pri_cap;
 
     /* ACS */
     uint16_t acs_cap;
@@ -154,6 +155,8 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
 
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
+                   bool prg_response_pasid_req);
 
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 4d9cf4a29c..33a22229fe 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -91,6 +91,9 @@ typedef enum PCIExpLinkWidth {
 #define PCI_EXT_CAP_PASID_MAX_WIDTH     20
 #define PCI_PASID_CAP_WIDTH_SHIFT       8
 
+/* PRI */
+#define PCI_PRI_VER                     1
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 36de709801..542172b3fa 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1240,6 +1240,32 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
     dev->exp.pasid_cap = offset;
 }
 
+/* PRI */
+void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
+                   bool prg_response_pasid_req)
+{
+    static const uint16_t control_reg_rw_mask = 0x3;
+    static const uint16_t status_reg_rw1_mask = 0x3;
+    static const uint32_t pr_alloc_reg_rw_mask = 0xffffffff;
+    uint16_t status_reg;
+
+    status_reg = prg_response_pasid_req ? PCI_PRI_STATUS_PASID : 0;
+    status_reg |= PCI_PRI_STATUS_STOPPED; /* Stopped by default */
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PRI, PCI_PRI_VER, offset,
+                        PCI_EXT_CAP_PRI_SIZEOF);
+    /* Disabled by default */
+
+    pci_set_word(dev->config + offset + PCI_PRI_STATUS, status_reg);
+    pci_set_long(dev->config + offset + PCI_PRI_MAX_REQ, outstanding_pr_cap);
+
+    pci_set_word(dev->wmask + offset + PCI_PRI_CTRL, control_reg_rw_mask);
+    pci_set_word(dev->w1cmask + offset + PCI_PRI_STATUS, status_reg_rw1_mask);
+    pci_set_long(dev->wmask + offset + PCI_PRI_ALLOC_REQ, pr_alloc_reg_rw_mask);
+
+    dev->exp.pri_cap = offset;
+}
+
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
-- 
MST


