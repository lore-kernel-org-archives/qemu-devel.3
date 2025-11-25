Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6769CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNoiI-0008Bi-U7; Tue, 25 Nov 2025 03:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiG-0008A4-NK; Tue, 25 Nov 2025 03:47:52 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiF-0008Ct-5j; Tue, 25 Nov 2025 03:47:52 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E73E97A00FE;
 Tue, 25 Nov 2025 03:47:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 25 Nov 2025 03:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1764060469; x=1764146869; bh=7IS0y0KL6f9wIcEoT4675tOP1YM8wZ2g
 L3bKB8rQKTI=; b=SyoFkkAyEIMfn0/TaTFITKdFI7+Epjci+wlkOyLMzH8E47EI
 bPEuC2PVm9jAjQ8A8jka8Wt8U59zKysgg9lhKgN8ArJXmdcCRnxd5qnIWKcBh7Rl
 +W8cWrzpEe4XnxopNJQnJrYdrXs/RN+A874mEUKRpZv40fqtyfZaAdZUThmD9Prv
 MJk/BFde9rSVqguNL8nTfvpiVkBuPveFhb4TaT3lFygbaoIWUyCYKt5iVsENLJ/G
 i2Pyr65aY16aU1RoQLHJnd3HobeqeoZjcwy+eRv14llek3tRofDjHxDMDLMid+d9
 M4pv3tyCUT21czbrjvj78Q8aSP2vERV/5qfjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764060469; x=
 1764146869; bh=7IS0y0KL6f9wIcEoT4675tOP1YM8wZ2gL3bKB8rQKTI=; b=a
 QfusAA6ca15pCgxi214wetINa/CF3UObMdO4j6mBjNPW40KG+/607SwCjAd/AErQ
 SlK0Yd+uXzx4l8zvGZIucMI6hXqkA9XYxEgzvwzZ8eCFfLkMKaA7tpYY7optskZN
 THcXg7uqzwuYLbLl6KeDaz4L3fH1pO3U8k0AJXFQ7kwi1U9uppyO184Js0RCHDGy
 EZe0lgMLMMGW3xbhp+oj1dl4t9pRK8VdMvpUFoRUA/ka3/5Tpf0kc0SYgXpm/20S
 quagh6CgwA/BKsK7qCyw5iok3eyRb8s5pQkdT/0xjmI9wzRKYIqEz/Xy2R3SKUhE
 kKpPFBnL2h+wk3ArzZzbw==
X-ME-Sender: <xms:NW0laUtz7eM655LUrM6nXKpMIylS5_4GulyRRaTt3G3Bkhfd9mrrjQ>
 <xme:NW0laXfw1Y3aBEj2o3dQLsERG0fwgmPTIXQIR-alNWqyblgAP_e7Ocy6PK5c6GaMS
 hAJPsOgkyQBdo6I8pTDiQg5kmxda45maz_sK4hbaGdNlqIb2bBtQ1M>
X-ME-Received: <xmr:NW0laam1lg2BUSy5Ote9usF6hqloLebG_NerN5iItFS-6LWQzuj-MEkcXacWJg7QIwCyqgolO8zqo0acWdipOIlF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedutdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteejiefh
 vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgt
 phhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnh
 hsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpth
 htohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepfhgrrhhoshgrshes
 shhushgvrdguvgdprhgtphhtthhopehlvhhivhhivghrsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:NW0laaA_n_h3K-o6ms_x7PN4t9T6x58mkp5XythWoWQ4VARB2mgCfg>
 <xmx:NW0laUOZ8t_xmPXpwQMoROym_MVk7mStsv4qz6odBAqZv8Yg7Ecf-w>
 <xmx:NW0laZP5ORYP6DPDjwzGSJ51t6-_nA5WS-jVM6Su-0ioOES-ZAcfzQ>
 <xmx:NW0laUmZuxFS4EpNj9bRU7qTjg-3FPtNaApkmTKY_E0uLlHNKvXfZQ>
 <xmx:NW0laW4syO6f6rKOxLtWjfZcmH-zYgSASzFoVZVenzg92oEza8ggGyPZ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 03:47:47 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 3/3] hw/nvme: Validate PMR memory size
Date: Tue, 25 Nov 2025 09:47:25 +0100
Message-ID: <20251125084725.4632-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125084725.4632-1-its@irrelevant.dk>
References: <20251125084725.4632-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per the PCI spec 3.0, in section 6.2.5.1, "Address Maps":

  A 32-bit register can be implemented to support a single
  memory size that is a power of 2 from 16 bytes to 2 GB.

Add a check in nvme_init_pmr(), returning an error if the
PMR region size is too small; and update the QTest.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c          | 13 +++++++++++--
 tests/qtest/nvme-test.c |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 901d4d863355..cc4593cd427a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8814,10 +8814,15 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
-static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
+static bool nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     uint32_t pmrcap = ldl_le_p(&n->bar.pmrcap);
 
+    if (memory_region_size(&n->pmr.dev->mr) < 16) {
+        error_setg(errp, "PMR device must have at least 16 bytes");
+        return false;
+    }
+
     NVME_PMRCAP_SET_RDS(pmrcap, 1);
     NVME_PMRCAP_SET_WDS(pmrcap, 1);
     NVME_PMRCAP_SET_BIR(pmrcap, NVME_PMR_BIR);
@@ -8832,6 +8837,8 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
                      PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmr.dev->mr);
 
     memory_region_set_enabled(&n->pmr.dev->mr, false);
+
+    return true;
 }
 
 static uint64_t nvme_mbar_size(unsigned total_queues, unsigned total_irqs,
@@ -9050,7 +9057,9 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->pmr.dev) {
-        nvme_init_pmr(n, pci_dev);
+        if (!nvme_init_pmr(n, pci_dev, errp)) {
+            return false;
+        }
     }
 
     return true;
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 5ad6821f7af9..4aec1651e6e2 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -149,7 +149,7 @@ static void nvme_register_nodes(void)
         .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
                            "file.read-zeroes=on,format=raw "
                            "-object memory-backend-ram,id=pmr0,"
-                           "share=on,size=8",
+                           "share=on,size=16",
     };
 
     add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
-- 
2.51.0


