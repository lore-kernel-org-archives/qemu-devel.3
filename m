Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD77C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaEC-00081q-TZ; Thu, 27 Feb 2025 04:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDy-0007lZ-57; Thu, 27 Feb 2025 04:30:36 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDv-0008Fk-FT; Thu, 27 Feb 2025 04:30:33 -0500
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 5867C1382F7E;
 Thu, 27 Feb 2025 04:30:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 27 Feb 2025 04:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648630; x=
 1740735030; bh=/mc3xBeqRFRxpB4/dFAIRqOEU9FtF9Vd+rUYFybqzVk=; b=G
 /xg9IiC8plS3JeLqFv2nx2gkuAAX+CMjPNKGCNc+eyvxyJAUMEeQnEV9x/4ooGDr
 57h/4R6enWeCFSZem/Lb1fYcywQIDjxhBGSRq91sm/j0/rf0xHOOaMXjanrN7qxB
 dQOrDjlpNGM9em/XQUdRdGHMwfltmWB1fobGvxy/VO6Et2Vfe/TnM+7S6hwz8NKl
 xPq7Y7aVaE4GUVhJQQCSAxkDTyQMv+ImIjI35/GwCEW1LO1H3GOVsDwhXZRMzzkO
 ChWkAG8GJC/Ot9mr8zcUBLQdTe1jRJJ0QmcIm3HJ57IPGL7Kx9fERAbMzDWWwSPp
 mDDwphhspre0NOwnTEs1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648630; x=1740735030; bh=/
 mc3xBeqRFRxpB4/dFAIRqOEU9FtF9Vd+rUYFybqzVk=; b=GckOcuKxAbBCBS1TP
 qjztyjMn0iX4IBjmMdcZcV1QF2JjyyZwFNujixc9O+4lLIyLOnbEa0sklpFpkFS/
 Ghkh+V27pPNZjmYFOiIrKayGLetaW0mna4nfXYzQ2tK91diCviFGCf0USHZqvJDQ
 VxcipGEP8+UABz01kPsA0Isg5jvTA3akLPXxekahTRfpE2XWJhbx8ENpl/6C0C4u
 nyN8faJE9EUNeFIIRh3M0NNF2WDRYJNKp+JDVLmHD2yoqPR7FM58StY9t2/o9AVQ
 RCkVl0RVpQ8WY8k4xofLHQUm5p3jQsATzse7ipW/tMLyE6PWFxSm/+nrFzE1Kxhx
 NkunA==
X-ME-Sender: <xms:tjDAZxuXM1HMpAfT9igoc7DWkWAX4pRMd3i6gYu3qjrVmJ6Hf3iXhg>
 <xme:tjDAZ6e0k-svcHxSnlUrilUVpBEqbRjQLAw9GfkCeyUjbe7XjQp8oTy2287tEKx96
 _G2j3f6rHofTQ5SSs8>
X-ME-Received: <xmr:tjDAZ0xNhlXXJ_LnFKb-FnaFSMytWWm8Qsuq-jzxgSZ9QnorpU_p_e-Qq1dd5HyNas9h-rcAgZvqivifdVDtgMfD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:tjDAZ4OdlILMmnQYWavBNlZ5aK4dQ_qg6Gsco6hKvrgdRJ9TJUQL9A>
 <xmx:tjDAZx-H0inxgv41XdgpzMGvU9gyC8NEJnWDRbj7QOg7BGeOJtc8hA>
 <xmx:tjDAZ4X-g-d8O0GqEuC4bQTOHYntLcRZfJKWyMccWx0vMi_hN6dsJg>
 <xmx:tjDAZyduGJX0m06s7H4zPHOx10NPH850EydsbnJ1tfQr18BNSRS_Gg>
 <xmx:tjDAZ0VGaDymJSRhDrhKnmlDBcFcZiiYgugt-e5FZcb9RPua45u7P4wx>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:28 -0500 (EST)
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
Subject: [PULL 03/10] hw/nvme: make oacs dynamic
Date: Thu, 27 Feb 2025 10:30:10 +0100
Message-ID: <20250227093018.11262-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

Virtualization Management needs sriov-related parameters. Only report
support for the command when that conditions are true.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 25 ++++++++++++++++++-------
 hw/nvme/nvme.h       |  4 ++++
 include/block/nvme.h |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5a7ccbcc1b80..4ee8588ca9ae 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -266,7 +266,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_FDP_EVENTS]               = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
 };
 
-static const uint32_t nvme_cse_acs[256] = {
+static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_DELETE_SQ]        = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_CREATE_SQ]        = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_GET_LOG_PAGE]     = NVME_CMD_EFF_CSUPP,
@@ -278,7 +278,6 @@ static const uint32_t nvme_cse_acs[256] = {
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
-    [NVME_ADM_CMD_VIRT_MNGMT]       = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DBBUF_CONFIG]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
@@ -5174,7 +5173,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
         }
     }
 
-    memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
+    memcpy(log.acs, n->cse.acs, sizeof(log.acs));
 
     if (src_iocs) {
         memcpy(log.iocs, src_iocs, sizeof(log.iocs));
@@ -7300,7 +7299,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode,
                              nvme_adm_opc_str(req->cmd.opcode));
 
-    if (!(nvme_cse_acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+    if (!(n->cse.acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
         trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
@@ -8740,6 +8739,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
     uint32_t ctratt;
+    uint16_t oacs;
+
+    memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -8770,9 +8772,18 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
-    id->oacs =
-        cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT | NVME_OACS_DBBUF |
-                    NVME_OACS_DIRECTIVES);
+
+    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DBBUF |
+        NVME_OACS_DIRECTIVES;
+
+    if (n->params.sriov_max_vfs) {
+        oacs |= NVME_OACS_VMS;
+
+        n->cse.acs[NVME_ADM_CMD_VIRT_MNGMT] = NVME_CMD_EFF_CSUPP;
+    }
+
+    id->oacs = cpu_to_le16(oacs);
+
     id->cntrltype = 0x1;
 
     /*
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index e307e733e46a..b86cad388f5a 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -584,6 +584,10 @@ typedef struct NvmeCtrl {
     uint64_t    dbbuf_eis;
     bool        dbbuf_enabled;
 
+    struct {
+        uint32_t acs[256];
+    } cse;
+
     struct {
         MemoryRegion mem;
         uint8_t      *buf;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 975d321c5c08..80fbcb420d48 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1232,8 +1232,9 @@ enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY      = 1 << 0,
     NVME_OACS_FORMAT        = 1 << 1,
     NVME_OACS_FW            = 1 << 2,
-    NVME_OACS_NS_MGMT       = 1 << 3,
+    NVME_OACS_NMS           = 1 << 3,
     NVME_OACS_DIRECTIVES    = 1 << 5,
+    NVME_OACS_VMS           = 1 << 7,
     NVME_OACS_DBBUF         = 1 << 8,
 };
 
-- 
2.47.2


