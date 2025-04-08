Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3CBC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2651-0006Uz-5v; Tue, 08 Apr 2025 06:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u264e-0006Sr-QB; Tue, 08 Apr 2025 06:20:59 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u264c-0005r8-Es; Tue, 08 Apr 2025 06:20:56 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4E6E911401FB;
 Tue,  8 Apr 2025 06:20:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 06:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1744107649; x=
 1744194049; bh=ifMAfKKYk/6PpekIEcWvUHCZhnPyCH1up3hwdFkQGo8=; b=S
 0DCFDjYaLn4FxRb0hw1uHy/eWSFJSaf9MQnuly8rN/BumqdR3CXnEahSA9YJhI09
 FAO/NCX2ICHXalMXxsjcq7VmVkirkkUGlPSxjGDd0xTUnU5x6aFBzOjrh/3QsP9H
 OuQcQhdN3UjvZfaU+F+98d4hQ7CVTnqQ8SE42wAOyeO5ZmP8RH9bPUMFF1OjZBP5
 QtUXNmgsx7mQM3wkp/hSUsPj/vJ76AOFb6mpyB1W8rhfvdcFa+05IHOC9K1tFR10
 HE1IYHax+wYz3WFlS7HY4kMxgaHLB52H+hvI1Tk5zgdWOfX39bX8PScG3XXFMDVc
 sbCYRD7RgESNx0RvUHEnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1744107649; x=1744194049; bh=ifMAfKKYk/6PpekIEcWvUHCZhnPy
 CH1up3hwdFkQGo8=; b=Yrp1dhtXP1PGbDc2IdcwHRYDprXqNhqpwtOmdZ2cTNHC
 eFi1Uukgq2mUy1TA2Ytt81FJVoTFDP9Q19lZCKhqRA+Z+PUz3iltEj8F8ILe4PSk
 bK4o/x+wt1iLQmnSl7gwXTs95fC7dBKEba1CNCCN15Nz+J4NaJeKruRljljwb8eF
 X4oWmsoHSOUkL9RjEJc38zHf871VkXPn5v+twD3EN29MjSnSw+qBr58uz7FDF6fi
 SGiPRou8j47UTKBtXhnynLEknrWezV0gzA+PIdlzY5Jko1B324Ji7juiymmzyj/i
 o4nuR/BVMxSIDm0qSCpyRTqyeCNcC4RFE/wXoqHjgA==
X-ME-Sender: <xms:gfj0Z37kPpApV2f5eTU3nLciA6oSUZgYDEKLolmFvoKttemwo5KmDQ>
 <xme:gfj0Z86ZLhzTWkiZ-5_r65zuNU7_FgSg6_AdcaUnQbMPvav6T5yLCT7AO_5uY5vnj
 Z4A_2kaSJpGoayYbU0>
X-ME-Received: <xmr:gfj0Z-foTkPrc37kUzWu7_GOTspdQII_-Tj11lqxmFRUbjb34kO51Zi6lmctijCShfhycMyCUVe7mcTWJaobkv1l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpedtheevjeeihffggeeihfefheeuiefguefglefh
 tdffveehffekhfekgeetteffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfohhsshesuggvfhhmrg
 gtrhhordhithdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhg
 pdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrd
 hjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprghlrghnrdgruggrmhhsohhnsehorh
 grtghlvgdrtghomhdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:gfj0Z4IgsNlqYmD41uZv6kciA_vw1VQ2hL4CUU_ak6dOIbccKPQJIQ>
 <xmx:gfj0Z7JnTt1GOTV5grrwrsg_lrU_BLVcY5a3Fy55rGJQ_Us6ipJMcg>
 <xmx:gfj0ZxyviiDXgB1j9fQuz6iF_0-RZWzhGnKawTUmd2An1CAKtIztOg>
 <xmx:gfj0Z3JIzZyafJBVW0hAHPjC8oWKuk-pL8IYDKjOvbIMV14aTHhWmw>
 <xmx:gfj0ZyYQnuh6UPrtRTBycnYLsVEki6FGXqcNk2JwaqxXVEFPMBchGQmA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 06:20:47 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 08 Apr 2025 12:20:46 +0200
Subject: [PATCH] hw/nvme: fix attachment of private namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
X-B4-Tracking: v=1; b=H4sIAH349GcC/x2MQQqAIBAAvyJ7bkGlpPpKdLDcai8mGhJEf2/pO
 DAzDxTKTAVG9UCmyoXPKGAaBevh407IQRistp1udY8b35gyV38RxoJmWOwSNmfd4ECilEmMfzj
 N7/sB5NjSK2AAAAA=
X-Change-ID: 20250408-fix-private-ns-19b2bdf62696
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, 
 Alan Adamson <alan.adamson@oracle.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3713; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=FmsBNd2XeETOdMyfFEA/YTWsVbCcEgt5qUw2+xzVDEI=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2YwK0g5Y3J2SlpIdS9oT3o3NjArVldhN0RSCmJTM1BBV2lJQk4rSkpqNHQr
 S09vWUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbjlQaC9
 BQW9KRUUzaHJ6RnRUdzNwUnlNSUFKM1g4YkpEeVNoRWRtSHMrWWRFT25hOG1OaXZIaDE2eTVTUw
 pWbDFZZC9JQ2t0TGdTOUovTTZNeGNINHJUalJ3RVNTRWJ2SGRXQVVGMzZIc0V1TnRnc3c4U1BpQ
 WFTRVlHQmhHCm5qRkptMzJMaGZCSzlwcUJsRW85VktxMEZsU1FHWHBNTG9SSGtvY1BkYTNzNjlN
 SjdCUlo4eWNRU01HVWIzQTEKK3RsdWZ3ZG9oU09LMmd2VjF2VFZ2WlJpSHBzUWpsQkVjdHJPcTh
 lQWdzRHF6bnFPb0dSRGh2OUZzYmZvRUFCbQpBcldGbkcwVzA0WGNubi82N2FCNXdWZ2tSZlZXS2
 lMNllwMEZPRlpQNmdWT2JNUVQ1RktlbVRHSVlyOUVXUWNqCmMwd2E3SzJ6d0paV0tXRWNkV25Pd
 UJXNjA2WDNCQUZXM0hYeFgvTzNzTXBEWVJDVmpTTnJkYWo3Cj1TNnBqCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Fix regression when attaching private namespaces that gets attached to
the wrong controller.

Keep track of the original controller "owner" of private namespaces, and
only attach if this matches on controller enablement.

Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
Reported-by: Alan Adamson <alan.adamson@oracle.com>
Suggested-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c   | 7 ++++++-
 hw/nvme/ns.c     | 4 ++++
 hw/nvme/nvme.h   | 3 +++
 hw/nvme/subsys.c | 9 +--------
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 518d02dc66706e2d2e86f1705db52188a97a67fc..d6b77d4fbc9def4639d53074c93f35ca882c4a02 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7755,7 +7755,11 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
         NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
 
-        if (ns && nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+        if (!ns || (!ns->params.shared && ns->ctrl != n)) {
+            continue;
+        }
+
+        if (nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
             if (!ns->attached || ns->params.shared) {
                 nvme_attach_ns(n, ns);
             }
@@ -8988,6 +8992,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (n->namespace.blkconf.blk) {
         ns = &n->namespace;
         ns->params.nsid = 1;
+        ns->ctrl = n;
 
         if (nvme_ns_setup(ns, errp)) {
             return;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 98c1e75a5d29627351f1aa741da3625c984a2d40..4ab8ba74f51b346a50419869b6f4a7f4b2d0e9c2 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -763,6 +763,10 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     ns->id_ns.endgid = cpu_to_le16(0x1);
     ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
+
+    if (!ns->params.shared) {
+        ns->ctrl = n;
+    }
 }
 
 static const Property nvme_ns_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6f782ba18826d3ff8db7198d3a29c7654262bb7b..b5c9378ea4e524abacced613fbc4ce5a404350c0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -268,6 +268,9 @@ typedef struct NvmeNamespace {
     NvmeSubsystem *subsys;
     NvmeEnduranceGroup *endgrp;
 
+    /* NULL for shared namespaces; set to specific controller if private */
+    NvmeCtrl *ctrl;
+
     struct {
         uint32_t err_rec;
     } features;
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 2ae56f12a596198e93a118428579301f8c8275d8..b617ac3892a32efebcaedca837eff59104dcc751 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -56,7 +56,7 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
 {
     NvmeSubsystem *subsys = n->subsys;
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
-    int cntlid, nsid, num_rsvd, num_vfs = n->params.sriov_max_vfs;
+    int cntlid, num_rsvd, num_vfs = n->params.sriov_max_vfs;
 
     if (pci_is_vf(&n->parent_obj)) {
         cntlid = le16_to_cpu(sctrl->scid);
@@ -92,13 +92,6 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
 
     subsys->ctrls[cntlid] = n;
 
-    for (nsid = 1; nsid < ARRAY_SIZE(subsys->namespaces); nsid++) {
-        NvmeNamespace *ns = subsys->namespaces[nsid];
-        if (ns && ns->params.shared && !ns->params.detached) {
-            nvme_attach_ns(n, ns);
-        }
-    }
-
     return cntlid;
 }
 

---
base-commit: dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed
change-id: 20250408-fix-private-ns-19b2bdf62696

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


