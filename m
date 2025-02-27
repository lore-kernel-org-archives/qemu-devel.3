Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D8AC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaEN-0008KQ-7o; Thu, 27 Feb 2025 04:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEA-000836-AK; Thu, 27 Feb 2025 04:30:48 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaE2-0008IR-FY; Thu, 27 Feb 2025 04:30:40 -0500
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7F17D1140BC5;
 Thu, 27 Feb 2025 04:30:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 27 Feb 2025 04:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648637; x=
 1740735037; bh=dZuF08uJ1a3asratCM7/aWSmjseMjsdnXiaM51iax7c=; b=a
 +setTad8dwBoTL3q7bqaxDl4T9l+wkl/JiqX3XLNKAn2FAGc1Rxqf972e0e/RKNB
 aSQnrId4Q5Ao6hlgoGUD0fBBKnUWfKiC+PP1gn1UF8ScPA1Mp1IkmD2PnHXJIT2N
 lZTp2LK402icLqGkTPerIPQX9fqKiDJk4dgcHFjy8y6XUOPhVxMRLmgPE1jnADoc
 OSRVTxirM+iEnMIDl005kghQxppe4xbmZTb5EL+q5Hm+JdKnWvQlKDHG2qbgxsjl
 2QnT/OJyDAlGOCAbSsxYKATYRAAPxZoEBxPb19IbgSYR83I5Wi9ngYVXDtIQ89f4
 +LU/NP0KqV0MzQiPNIBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648637; x=1740735037; bh=d
 ZuF08uJ1a3asratCM7/aWSmjseMjsdnXiaM51iax7c=; b=1HWJQODbtZpGuCLGJ
 /ihDO+wJ7ZzkY8/bIy3EHTkpmU/4Vkc4R6uVSreq6F841BKkgSirL5G5qyMvO6vl
 b+Wl9pw2Ia8jOw8+tcaiCPxEoekTcfBo0GC+enbolyXM5zew3Pmlxv5URhFhmtm5
 2hFOVzbLfH8GWV0ID65ikcWXd5AYSTSv1dWIhRD4fMa8HSBNfPNa7fkzWOyXOfuM
 oMyR2df3Yb5bGw2/+exd6oPUHq2g1kcjxgi7DBKDjmYH3k7uTaeoJNgRk2MxlQVz
 OmWioyZYie5AoO8h1jx9YZy1i2+LR2pAKj3ynZ3aOhB3uhwdmquk1Gxmzkq7wF5f
 f6QVg==
X-ME-Sender: <xms:vTDAZ888TbspuB-hYZ06s2g2UbOIdUh-9XxO_TQPdlb9gaqvTBYTiQ>
 <xme:vTDAZ0v6Tv1GwrokCa7V5uDynZSfkzAexku6o1NaEcHpBCI7fAaRdSAAUxW1zVCtS
 _2ZQKlxc20LP2QU6zg>
X-ME-Received: <xmr:vTDAZyBMBI6d6mKm-Yi9TWsTCDRGf_onmaGsMDux953NfMiUCZsRghrMCPbVwngLt_f-VTeK3ZoPFLlHjRx_tnrl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:vTDAZ8eVnIZ86TFyb3XeTW46iUFQrb52dPTXRhhOVpyZWBQu_iQNCA>
 <xmx:vTDAZxNU9OAxVKuK-1p-RmpqFibf3IIqWGzksOhQKpnrYBt1wI7EAg>
 <xmx:vTDAZ2l6-8eUMrkDlcNvzAP6J5irifHz1osuwi7owHDgRnjmhPVBFA>
 <xmx:vTDAZzsGd29xHrvIn-5tQ5WPDxsm9QN3Dq-1cBJWacyFUjYKrPBAww>
 <xmx:vTDAZ1kLrdTWLYutfDWVvmtHsKTUb5EVc_LmnV3ORQyWmxzIc5-Gmnrs>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:35 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 06/10] hw/nvme: be compliant wrt. dsm processing limits
Date: Thu, 27 Feb 2025 10:30:13 +0100
Message-ID: <20250227093018.11262-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

The specification states that,

> The controller shall set all three processing limit fields (i.e., the
> DMRL, DMRSL and DMSL fields) to non-zero values or shall clear all
> three processing limit fields to 0h.

So, set the DMRL and DMSL fields in addition to DMRSL.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 24 +++++++++++++++---------
 include/block/nvme.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2b73f601608f..86e1c48fab82 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5639,7 +5639,9 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     switch (c->csi) {
     case NVME_CSI_NVM:
         id_nvm->vsl = n->params.vsl;
+        id_nvm->dmrl = NVME_ID_CTRL_NVM_DMRL_MAX;
         id_nvm->dmrsl = cpu_to_le32(n->dmrsl);
+        id_nvm->dmsl = NVME_ID_CTRL_NVM_DMRL_MAX * n->dmrsl;
         break;
 
     case NVME_CSI_ZONED:
@@ -6696,18 +6698,23 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static void nvme_update_dmrsl(NvmeCtrl *n)
+static void nvme_update_dsm_limits(NvmeCtrl *n, NvmeNamespace *ns)
 {
-    int nsid;
+    if (ns) {
+        n->dmrsl =
+            MIN_NON_ZERO(n->dmrsl, BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
 
-    for (nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
-        NvmeNamespace *ns = nvme_ns(n, nsid);
+        return;
+    }
+
+    for (uint32_t nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+        ns = nvme_ns(n, nsid);
         if (!ns) {
             continue;
         }
 
-        n->dmrsl = MIN_NON_ZERO(n->dmrsl,
-                                BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
+        n->dmrsl =
+            MIN_NON_ZERO(n->dmrsl, BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
     }
 }
 
@@ -6795,7 +6802,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
             ctrl->namespaces[nsid] = NULL;
             ns->attached--;
 
-            nvme_update_dmrsl(ctrl);
+            nvme_update_dsm_limits(ctrl, NULL);
 
             break;
 
@@ -8902,8 +8909,7 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
     n->namespaces[nsid] = ns;
     ns->attached++;
 
-    n->dmrsl = MIN_NON_ZERO(n->dmrsl,
-                            BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
+    nvme_update_dsm_limits(n, ns);
 }
 
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index aecfc9ce66b4..763b2b2f0ec7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1207,6 +1207,8 @@ typedef struct NvmeIdCtrlZoned {
     uint8_t     rsvd1[4095];
 } NvmeIdCtrlZoned;
 
+#define NVME_ID_CTRL_NVM_DMRL_MAX 255
+
 typedef struct NvmeIdCtrlNvm {
     uint8_t     vsl;
     uint8_t     wzsl;
-- 
2.47.2


