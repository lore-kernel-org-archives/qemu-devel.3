Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFED2C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaFF-0001S6-F5; Thu, 27 Feb 2025 04:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEF-00088l-VU; Thu, 27 Feb 2025 04:30:55 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEA-0008Ii-6D; Thu, 27 Feb 2025 04:30:50 -0500
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfout.phl.internal (Postfix) with ESMTP id D26201382F74;
 Thu, 27 Feb 2025 04:30:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-13.internal (MEProxy); Thu, 27 Feb 2025 04:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648639; x=
 1740735039; bh=GvTnraR+2MP/8ph9LPge6clrDgvwgCdnBj6bJcKTw18=; b=J
 vXyFrQyhzI+OeLa2HPLDyQamZOcrJZQQZYHVHpIHruD9j4EejzSw3Lt59Hg8rSHA
 vHB8sLb23dZErCJIxYlVjGlIlOZHZdBo2lg5OxGZ/8Hk6DJW9O9/C242Mliuu+DH
 Dc8IseBtmX7D2F/36AbihCHEzR7s6k6yWo6aJIGUojajqyQ3914sBD2YfiCW5rPy
 TbLV3c9bp4SS6VBEQ8qWlsuPOmpLlkzb8W3HpdR14qIiNl/hndJjATX2uJhCSGZI
 RG9LDKkmYqlKCPxMCWSMX3axu3z3lFnGbVsauAbDOO3ii9/o8mq/oJPQ2Svi19Ni
 8BhRzZQ4v05klUgT4YESA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648639; x=1740735039; bh=G
 vTnraR+2MP/8ph9LPge6clrDgvwgCdnBj6bJcKTw18=; b=Ftv8sHfDrHvhSPLQI
 uf5EZfSiZhruxxaTDL+U6YDUZ8meWJPzC1fGeHj0OpPMJfCPpgmJvA21riXvcBZj
 EMgVU42GQuw5Rc0+GZUNF0GTp0/gFFmzKrskuQgT+7h1XRtjRrYCh0Eb1SXdwYZG
 WYQJcND7oumIXbJsM6dAaSEB+fLeJC6Drs7Bx1Pt5FG6xhhjEjtAdZXV5HuCvYXb
 0mvS86sDHSPIrMxBvsKzdTJ7DilgXpnwpmRtVE8c+vQQwnV13THgS8WGJdeApoOV
 1XaSOyQRDyCN9XnCSPttLdEp3+yMI5cB72kyDNGy5F7W0qVM5dGmdjr7YuI6WX7E
 Gsjzg==
X-ME-Sender: <xms:vzDAZwHN7hHP38gbevCQLCImWW850OQjpG6J6OMl8fUZ0rHtTMEVFA>
 <xme:vzDAZ5VLvlER-EUbWP_4yDf4tXpVo2ng1OYZN6eoqOPjYlfq6J12zxjD35taVFw-m
 xxZKw3SQjnup1ZC3hg>
X-ME-Received: <xmr:vzDAZ6JkqqCT8WgvJfy7Q9Fyqv-2dOud0SxmMw7vhfJZFLPLtEor3-9n4IzSqx73ImNXwmKDvadzw1Da9zFo2e9T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedutdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vzDAZyHRMQU9oYSoFuHoDEMtYVCW2x2UY6QHzuyPqSDXvVVJo8R0Sw>
 <xmx:vzDAZ2V1yZyhNsmP-Ugz4vXUyAfmXAVV8tFIVYa22JCItP53Xqxf7Q>
 <xmx:vzDAZ1NWQhHyrgq3Pt3Y6O7ydQq9iVv2Dst1y_ViJpHFgEUrzqRnKw>
 <xmx:vzDAZ93k7vNa2z8luPqhX7rpiQrNOqo1OcLMZ-dOVe-DRYpmOBy49g>
 <xmx:vzDAZ3vWQQjFUHy_eE8JpChEZLDnxJ9NNaHQn3Ah30lDyDKNd9_JvZFX>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:37 -0500 (EST)
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
Subject: [PULL 07/10] hw/nvme: rework csi handling
Date: Thu, 27 Feb 2025 10:30:14 +0100
Message-ID: <20250227093018.11262-8-its@irrelevant.dk>
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

The controller incorrectly allows a zoned namespace to be attached even
if CS.CSS is configured to only support the NVM command set for I/O
queues.

Rework handling of namespace command sets in general by attaching
supported namespaces when the controller is started instead of, like
now, statically when realized.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 213 ++++++++++++++++++++++++-------------------
 hw/nvme/ns.c         |  14 ---
 hw/nvme/nvme.h       |   5 +-
 include/block/nvme.h |  10 +-
 4 files changed, 131 insertions(+), 111 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 86e1c48fab82..21496c6b6b81 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -277,15 +277,14 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
-    [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
+    [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC |
+                                      NVME_CMD_EFF_CCC,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
 };
 
-static const uint32_t nvme_cse_iocs_none[256];
-
-static const uint32_t nvme_cse_iocs_nvm[256] = {
+static const uint32_t nvme_cse_iocs_nvm_default[256] = {
     [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
@@ -298,7 +297,7 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
     [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
 };
 
-static const uint32_t nvme_cse_iocs_zoned[256] = {
+static const uint32_t nvme_cse_iocs_zoned_default[256] = {
     [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
@@ -307,6 +306,9 @@ static const uint32_t nvme_cse_iocs_zoned[256] = {
     [NVME_CMD_VERIFY]               = NVME_CMD_EFF_CSUPP,
     [NVME_CMD_COPY]                 = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+
     [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
@@ -4603,6 +4605,61 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     };
 }
 
+static uint16_t __nvme_io_cmd_nvm(NvmeCtrl *n, NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+        return nvme_write(n, req);
+    case NVME_CMD_READ:
+        return nvme_read(n, req);
+    case NVME_CMD_COMPARE:
+        return nvme_compare(n, req);
+    case NVME_CMD_WRITE_ZEROES:
+        return nvme_write_zeroes(n, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, req);
+    case NVME_CMD_VERIFY:
+        return nvme_verify(n, req);
+    case NVME_CMD_COPY:
+        return nvme_copy(n, req);
+    case NVME_CMD_IO_MGMT_RECV:
+        return nvme_io_mgmt_recv(n, req);
+    case NVME_CMD_IO_MGMT_SEND:
+        return nvme_io_mgmt_send(n, req);
+    }
+
+    g_assert_not_reached();
+}
+
+static uint16_t nvme_io_cmd_nvm(NvmeCtrl *n, NvmeRequest *req)
+{
+    if (!(n->cse.iocs.nvm[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    return __nvme_io_cmd_nvm(n, req);
+}
+
+static uint16_t nvme_io_cmd_zoned(NvmeCtrl *n, NvmeRequest *req)
+{
+    if (!(n->cse.iocs.zoned[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    switch (req->cmd.opcode) {
+    case NVME_CMD_ZONE_APPEND:
+        return nvme_zone_append(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
+    }
+
+    return __nvme_io_cmd_nvm(n, req);
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -4644,11 +4701,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (!(ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
-        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
-    }
-
     if (ns->status) {
         return ns->status;
     }
@@ -4659,36 +4711,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 
     req->ns = ns;
 
-    switch (req->cmd.opcode) {
-    case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
-    case NVME_CMD_ZONE_APPEND:
-        return nvme_zone_append(n, req);
-    case NVME_CMD_WRITE:
-        return nvme_write(n, req);
-    case NVME_CMD_READ:
-        return nvme_read(n, req);
-    case NVME_CMD_COMPARE:
-        return nvme_compare(n, req);
-    case NVME_CMD_DSM:
-        return nvme_dsm(n, req);
-    case NVME_CMD_VERIFY:
-        return nvme_verify(n, req);
-    case NVME_CMD_COPY:
-        return nvme_copy(n, req);
-    case NVME_CMD_ZONE_MGMT_SEND:
-        return nvme_zone_mgmt_send(n, req);
-    case NVME_CMD_ZONE_MGMT_RECV:
-        return nvme_zone_mgmt_recv(n, req);
-    case NVME_CMD_IO_MGMT_RECV:
-        return nvme_io_mgmt_recv(n, req);
-    case NVME_CMD_IO_MGMT_SEND:
-        return nvme_io_mgmt_send(n, req);
-    default:
-        g_assert_not_reached();
+    switch (ns->csi) {
+    case NVME_CSI_NVM:
+        return nvme_io_cmd_nvm(n, req);
+    case NVME_CSI_ZONED:
+        return nvme_io_cmd_zoned(n, req);
     }
 
-    return NVME_INVALID_OPCODE | NVME_DNR;
+    g_assert_not_reached();
 }
 
 static void nvme_cq_notifier(EventNotifier *e)
@@ -5147,7 +5177,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog log = {};
-    const uint32_t *src_iocs = NULL;
+    const uint32_t *iocs = NULL;
     uint32_t trans_len;
 
     if (off >= sizeof(log)) {
@@ -5157,25 +5187,26 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
 
     switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
     case NVME_CC_CSS_NVM:
-        src_iocs = nvme_cse_iocs_nvm;
-        /* fall through */
-    case NVME_CC_CSS_ADMIN_ONLY:
+        iocs = n->cse.iocs.nvm;
         break;
-    case NVME_CC_CSS_CSI:
+
+    case NVME_CC_CSS_ALL:
         switch (csi) {
         case NVME_CSI_NVM:
-            src_iocs = nvme_cse_iocs_nvm;
+            iocs = n->cse.iocs.nvm;
             break;
         case NVME_CSI_ZONED:
-            src_iocs = nvme_cse_iocs_zoned;
+            iocs = n->cse.iocs.zoned;
             break;
         }
+
+        break;
     }
 
     memcpy(log.acs, n->cse.acs, sizeof(log.acs));
 
-    if (src_iocs) {
-        memcpy(log.iocs, src_iocs, sizeof(log.iocs));
+    if (iocs) {
+        memcpy(log.iocs, iocs, sizeof(log.iocs));
     }
 
     trans_len = MIN(sizeof(log) - off, buf_len);
@@ -6718,25 +6749,29 @@ static void nvme_update_dsm_limits(NvmeCtrl *n, NvmeNamespace *ns)
     }
 }
 
-static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
+static bool nvme_csi_supported(NvmeCtrl *n, uint8_t csi)
 {
-    uint32_t cc = ldl_le_p(&n->bar.cc);
+    uint32_t cc;
 
-    ns->iocs = nvme_cse_iocs_none;
-    switch (ns->csi) {
+    switch (csi) {
     case NVME_CSI_NVM:
-        if (NVME_CC_CSS(cc) != NVME_CC_CSS_ADMIN_ONLY) {
-            ns->iocs = nvme_cse_iocs_nvm;
-        }
-        break;
+        return true;
+
     case NVME_CSI_ZONED:
-        if (NVME_CC_CSS(cc) == NVME_CC_CSS_CSI) {
-            ns->iocs = nvme_cse_iocs_zoned;
-        } else if (NVME_CC_CSS(cc) == NVME_CC_CSS_NVM) {
-            ns->iocs = nvme_cse_iocs_nvm;
-        }
-        break;
+        cc = ldl_le_p(&n->bar.cc);
+
+        return NVME_CC_CSS(cc) == NVME_CC_CSS_ALL;
     }
+
+    g_assert_not_reached();
+}
+
+static void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->attached > 0);
+
+    n->namespaces[ns->params.nsid] = NULL;
+    ns->attached--;
 }
 
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
@@ -6781,7 +6816,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 
         switch (sel) {
         case NVME_NS_ATTACHMENT_ATTACH:
-            if (nvme_ns(ctrl, nsid)) {
+            if (nvme_ns(n, nsid)) {
                 return NVME_NS_ALREADY_ATTACHED | NVME_DNR;
             }
 
@@ -6789,19 +6824,17 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_PRIVATE | NVME_DNR;
             }
 
+            if (!nvme_csi_supported(n, ns->csi)) {
+                return NVME_IOCS_NOT_SUPPORTED | NVME_DNR;
+            }
+
             nvme_attach_ns(ctrl, ns);
-            nvme_select_iocs_ns(ctrl, ns);
+            nvme_update_dsm_limits(ctrl, ns);
 
             break;
 
         case NVME_NS_ATTACHMENT_DETACH:
-            if (!nvme_ns(ctrl, nsid)) {
-                return NVME_NS_NOT_ATTACHED | NVME_DNR;
-            }
-
-            ctrl->namespaces[nsid] = NULL;
-            ns->attached--;
-
+            nvme_detach_ns(ctrl, ns);
             nvme_update_dsm_limits(ctrl, NULL);
 
             break;
@@ -7652,21 +7685,6 @@ static void nvme_ctrl_shutdown(NvmeCtrl *n)
     }
 }
 
-static void nvme_select_iocs(NvmeCtrl *n)
-{
-    NvmeNamespace *ns;
-    int i;
-
-    for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-        ns = nvme_ns(n, i);
-        if (!ns) {
-            continue;
-        }
-
-        nvme_select_iocs_ns(n, ns);
-    }
-}
-
 static int nvme_start_ctrl(NvmeCtrl *n)
 {
     uint64_t cap = ldq_le_p(&n->bar.cap);
@@ -7733,7 +7751,18 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 
     nvme_set_timestamp(n, 0ULL);
 
-    nvme_select_iocs(n);
+    /* verify that the command sets of attached namespaces are supported */
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+
+        if (ns && nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+            if (!ns->attached || ns->params.shared) {
+                nvme_attach_ns(n, ns);
+            }
+        }
+    }
+
+    nvme_update_dsm_limits(n, NULL);
 
     return 0;
 }
@@ -8748,6 +8777,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint16_t oacs;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
+    memcpy(n->cse.iocs.nvm, nvme_cse_iocs_nvm_default, sizeof(n->cse.iocs.nvm));
+    memcpy(n->cse.iocs.zoned, nvme_cse_iocs_zoned_default,
+           sizeof(n->cse.iocs.zoned));
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -8859,9 +8891,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NVM);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_CSI_SUPP);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_ADMIN_ONLY);
+    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NCSS);
+    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_IOCSS);
     NVME_CAP_SET_MPSMAX(cap, 4);
     NVME_CAP_SET_CMBS(cap, n->params.cmb_size_mb ? 1 : 0);
     NVME_CAP_SET_PMRS(cap, n->pmr.dev ? 1 : 0);
@@ -8908,8 +8939,6 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
 
     n->namespaces[nsid] = ns;
     ns->attached++;
-
-    nvme_update_dsm_limits(n, ns);
 }
 
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
@@ -8965,7 +8994,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
             return;
         }
 
-        nvme_attach_ns(n, ns);
+        n->subsys->namespaces[ns->params.nsid] = ns;
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 94cabc6a5b8d..98c1e75a5d29 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -763,20 +763,6 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     ns->id_ns.endgid = cpu_to_le16(0x1);
     ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
-
-    if (ns->params.detached) {
-        return;
-    }
-
-    if (ns->params.shared) {
-        for (i = 0; i < ARRAY_SIZE(subsys->ctrls); i++) {
-            NvmeCtrl *ctrl = subsys->ctrls[i];
-
-            if (ctrl && ctrl != SUBSYS_SLOT_RSVD) {
-                nvme_attach_ns(ctrl, ns);
-            }
-        }
-    }
 }
 
 static const Property nvme_ns_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b8d063a027a9..6f782ba18826 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -237,7 +237,6 @@ typedef struct NvmeNamespace {
     NvmeLBAF     lbaf;
     unsigned int nlbaf;
     size_t       lbasz;
-    const uint32_t *iocs;
     uint8_t      csi;
     uint16_t     status;
     int          attached;
@@ -587,6 +586,10 @@ typedef struct NvmeCtrl {
 
     struct {
         uint32_t acs[256];
+        struct {
+            uint32_t nvm[256];
+            uint32_t zoned[256];
+        } iocs;
     } cse;
 
     struct {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 763b2b2f0ec7..366739f79edf 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -142,9 +142,9 @@ enum NvmeCapMask {
     ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
 
 enum NvmeCapCss {
-    NVME_CAP_CSS_NVM        = 1 << 0,
-    NVME_CAP_CSS_CSI_SUPP   = 1 << 6,
-    NVME_CAP_CSS_ADMIN_ONLY = 1 << 7,
+    NVME_CAP_CSS_NCSS    = 1 << 0,
+    NVME_CAP_CSS_IOCSS   = 1 << 6,
+    NVME_CAP_CSS_NOIOCSS = 1 << 7,
 };
 
 enum NvmeCcShift {
@@ -177,7 +177,7 @@ enum NvmeCcMask {
 
 enum NvmeCcCss {
     NVME_CC_CSS_NVM        = 0x0,
-    NVME_CC_CSS_CSI        = 0x6,
+    NVME_CC_CSS_ALL        = 0x6,
     NVME_CC_CSS_ADMIN_ONLY = 0x7,
 };
 
@@ -938,6 +938,8 @@ enum NvmeStatusCodes {
     NVME_INVALID_SEC_CTRL_STATE = 0x0120,
     NVME_INVALID_NUM_RESOURCES  = 0x0121,
     NVME_INVALID_RESOURCE_ID    = 0x0122,
+    NVME_IOCS_NOT_SUPPORTED     = 0x0129,
+    NVME_IOCS_NOT_ENABLED       = 0x012a,
     NVME_IOCS_COMBINATION_REJECTED = 0x012b,
     NVME_INVALID_IOCS           = 0x012c,
     NVME_CONFLICTING_ATTRS      = 0x0180,
-- 
2.47.2


