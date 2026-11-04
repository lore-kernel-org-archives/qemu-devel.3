Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EF606A330
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MenO/nYT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZJq-0003Wx-Nn; Wed, 04 Nov 2026 06:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZJo-0003WQ-DJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZJl-0005CP-Ol
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:16 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20261104113804epoutp01e25c8af55b85933b4419fe42dbfc82ab~k1JQiM4993027130271epoutp01J
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20261104113804epoutp01e25c8af55b85933b4419fe42dbfc82ab~k1JQiM4993027130271epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793792284;
 bh=xoWhSvTg6fY+bu1sbnwUxbdA5T90p3JpGb15UCwiuac=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MenO/nYTihP4cb4n/nNvlPqEg315uN0Lq8iKjZWlfUCYJMQqqeet/qrljzpC0j0Bs
 tslIaz1U0v0jX4qXoL1BtoQhZYrFELljJMOdaPUmG4k7gIt615zdL8jzxJe2VBOMSu
 OiPSxSIEyuFRuhGTlz4wP4U0XgOviGGKwbmw/i/Q=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20261104113803epcas5p2f56d2b7ae8773bb15e157a7db8bc7a50~k1JPzXVbt1387013870epcas5p2S;
 Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4jKNjR3KrDz6B9m4; Wed,  4 Nov
 2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f~k1CgjSlA51814518145epcas5p3A;
 Wed,  4 Nov 2026 11:30:20 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261104113017epsmtip10536a07f8b7f0d7456c9d5eace70cd7b~k1CePRkmm2317923179epsmtip1k;
 Wed,  4 Nov 2026 11:30:17 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@intel.com
Subject: [PATCH qemu v1 2/8] hw/pci: Move 'x-256b-flit' property from
 cxl_root_port to pcie_root_port
Date: Wed,  4 Nov 2026 17:22:36 +0530
Message-Id: <2052256418.81793792283466.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104115242.2035807-1-shrihari.s@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <CGME20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Relocate the 'x-256b-flit' property from cxl_root_port to its parent
pcie_root_port so that all root port types inherit the property.

The cxl_root_port and cxl_downstream_port no longer carry a local
property definition; the property is inherited from pcie_root_port
and PCIEPort respectively.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c  | 1 -
 hw/pci-bridge/pcie_root_port.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 01463dbb07..e82685d1ab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -237,7 +237,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced5685..bc173dbf30 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,6 +152,7 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.34.1



