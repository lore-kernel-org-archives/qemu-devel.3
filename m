Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5958ACEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdcB-0008CW-Jl; Tue, 01 Oct 2024 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbf-0007TT-IM; Tue, 01 Oct 2024 10:12:03 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbc-00034H-Gk; Tue, 01 Oct 2024 10:12:03 -0400
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1D2B81141AA5;
 Tue,  1 Oct 2024 03:04:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 03:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727766282; x=
 1727852682; bh=ytqbBQEEKPItfETLehQ2Mmw3aOWzfVEc2PMLnqbV+QE=; b=F
 zX0nfjVYpNpaSf7G5p9uwHn2/MF4S5ncghIpLh5tDHFX1D8ZlZIYGJdgg2efZrxE
 WQ4IrGrUURR2gyW/xNR56xTZ6It8wdokn+lwc86K8T3Tymj7JnUTn1bnim85yMQa
 1r/frhZ+jO61nCNwbAo8DttQpH8CEGORp7RmouiAcl3bz09cLUWYWTIAJBetRLSs
 FhBQC0ZjmlXVkPnMkWLSluTULGsudtla/fAIiy5MOytio7FTb6v/ncdPLFmqslUj
 btZZe+cciO7IjR9KPvud7jZlZWkIkiDP5wF//pqrJF98AlVda9Q0Tj0fDFlbGQxE
 NaZUvACQU68MIaQObpC1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727766282; x=
 1727852682; bh=ytqbBQEEKPItfETLehQ2Mmw3aOWzfVEc2PMLnqbV+QE=; b=k
 X3bRDI9eVdhSw/NNsH9gg1mTxl8GoO0sD6p0VZ8Kx2Ch/N9rpbK9p4kYKJQROC9e
 WT7f6NBMaBgYNhG/SO6pOfJFk9HA1gehhv3PZxA5LvhHp5SZ/ADvZbXfsE7MRfw+
 rXHevUbg1UoI6nLGfnbgUAzewwNFAt5fPg8GSvH2DE+9XmKRCrqilOAWkS3IOOLQ
 ORBsZrAmi6moOqBktJdGlCmebV3pSy2RDl8qhxMC8R7JAaZVJzfoPU+Jmx5uGbDY
 sRRmh2mJJlUIbUK85/xxzU1pDsyD+przcYEF+zzC8cpxr2hYfZcUnsvJLrXh0Uxf
 gRTvvD9yLSZdgY5lU3bJQ==
X-ME-Sender: <xms:CZ_7ZkCXOH0kBP241iyDqmVv06pr1FpdR2S7UFx79IG1sda1mFn_lQ>
 <xme:CZ_7ZmgC8l_KTRodxc46ueS4ONxanh2DuIkODSRaHVDTP17jCNyeUzjo7V7vRUiv2
 AFWubDddEyiDyiAaQo>
X-ME-Received: <xmr:CZ_7ZnnOdKezqUNTccxYHDKdZLiPdOm_iE8ckFTpL75cGmdF6k-ipe2yBQnEGR8z1nYkFCZItCzu7qAQkEbg7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphht
 thhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrh
 gvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdp
 rhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfh
 grmhesvghuphhhohhnrdhnvght
X-ME-Proxy: <xmx:CZ_7ZqwLrMhOEA9mgI6V_sTbQ6e2gjo8FL78NRPGnA1E_IJonLeYxw>
 <xmx:CZ_7ZpREkSr1VwCSTgND8x2b-eOjrHekEiT72apHP643gRB50xbdlA>
 <xmx:CZ_7ZlbHzbRYKaVkQzlEWWORxyvfoQYlTJ0L-FDv-v0azk6Lm1QnBA>
 <xmx:CZ_7ZiS1mqZpmIPgHz9GAwHc2B_e3fK28CtyCbUTmGVFPYqaH5CqNA>
 <xmx:Cp_7ZvBMxnxh2fkk05Ua0HyMEt3wVyc2FkRpNAHkw3xTc45sAQgLq8h_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:39 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arun Kumar <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 3/5] hw/nvme: support CTRATT.MEM
Date: Tue,  1 Oct 2024 09:04:15 +0200
Message-ID: <20241001070418.28737-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
References: <20241001070418.28737-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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

From: Arun Kumar <arun.kka@samsung.com>

Indicate that 'MDTS and Size Limits Exclude Metadata (MEM)' in the
Controller Attributes (CTRATT) I/O Command Set Independent Identify
Controller Data Structure.

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
[k.jensen: updated commit message]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 19 ++++++++++++++-----
 include/block/nvme.h |  3 +++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a720dbc354a2..050cb63e3390 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2653,6 +2653,7 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = le16_to_cpu(rw->nlb) + 1;
     size_t len = nvme_l2b(ns, nlb);
+    size_t data_len = len;
     int64_t offset = nvme_l2b(ns, slba);
     uint8_t prinfo = NVME_RW_PRINFO(le16_to_cpu(rw->control));
     uint32_t reftag = le32_to_cpu(rw->reftag);
@@ -2672,7 +2673,11 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
         }
     }
 
-    if (len > n->page_size << n->params.vsl) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
+        data_len += nvme_m2b(ns, nlb);
+    }
+
+    if (data_len > (n->page_size << n->params.vsl)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -3413,7 +3418,11 @@ static uint16_t nvme_compare(NvmeCtrl *n, NvmeRequest *req)
         len += nvme_m2b(ns, nlb);
     }
 
-    status = nvme_check_mdts(n, len);
+    if (NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt)) {
+        status = nvme_check_mdts(n, data_len);
+    } else {
+        status = nvme_check_mdts(n, len);
+    }
     if (status) {
         return status;
     }
@@ -3590,7 +3599,7 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    if (nvme_ns_ext(ns)) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
         mapped_size += nvme_m2b(ns, nlb);
 
         if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
@@ -3702,7 +3711,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    if (nvme_ns_ext(ns)) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
         mapped_size += nvme_m2b(ns, nlb);
 
         if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
@@ -8483,7 +8492,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cntlid = cpu_to_le16(n->cntlid);
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
-    ctratt = NVME_CTRATT_ELBAS;
+    ctratt = NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
 
     id->rab = 6;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5298bc4a2867..a37be0d0da8e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1182,6 +1182,7 @@ enum NvmeIdCtrlOaes {
 enum NvmeIdCtrlCtratt {
     NVME_CTRATT_ENDGRPS = 1 <<  4,
     NVME_CTRATT_ELBAS   = 1 << 15,
+    NVME_CTRATT_MEM     = 1 << 16,
     NVME_CTRATT_FDPS    = 1 << 19,
 };
 
@@ -1285,6 +1286,8 @@ enum NvmeNsAttachmentOperation {
 #define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
 #define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
 
+#define NVME_ID_CTRL_CTRATT_MEM(ctratt) (ctratt & NVME_CTRATT_MEM)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                = 0x1,
     NVME_POWER_MANAGEMENT           = 0x2,
-- 
2.45.2


