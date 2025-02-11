Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E333C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 02:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thfxQ-0005Ue-VN; Mon, 10 Feb 2025 21:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1thfxJ-0005U5-6G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:24:57 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1thfxE-0003Bg-Kk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:24:56 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCngzPwtKpnp41YAg--.25585S2;
 Tue, 11 Feb 2025 10:24:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDX3YnmtKpnW+AgAA--.43854S4;
 Tue, 11 Feb 2025 10:24:42 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org, chenbaozi@phytium.com.cn, linux-cxl@vger.kernel.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Date: Tue, 11 Feb 2025 10:24:13 +0800
Message-Id: <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDX3YnmtKpnW+AgAA--.43854S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQASAWeqWwIBbQAAsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF1xGrW7Xw4xWFyUCFyUZFb_yoW8tr15pr
 WagFy5KFs7ArnxJrWvya45Jw1xWFsag34UAasxAw17ZF92vwn0qr1DKryFkFyDuayxAr1U
 ta12ga429w43Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The previous default value of sn is UI64_NULL which would cause the
cookie of nd_interleave_set be '0' and the "invalid interleave-set
-cookie" failure in label validation.

As many users maybe not know how to set a unique sn for cxl-type3
device and perhaps be confuesd by the failure of label validation,
so this defines '1' as the default value of serial number to fix the
problem.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/mem/cxl_type3.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a34..a6b5a9f74e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
     pcie_aer_write_config(pci_dev, addr, val, size);
 }
 
-/*
- * Null value of all Fs suggested by IEEE RA guidelines for use of
- * EU, OUI and CID
- */
-#define UI64_NULL ~(0ULL)
-
 static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_prog_interface(pci_conf, 0x10);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
-    if (ct3d->sn != UI64_NULL) {
-        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
-        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
-    } else {
-        cxl_cstate->dvsec_offset = 0x100;
-    }
+
+    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
+    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
 
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
@@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
-    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
+    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
-- 
2.34.1


