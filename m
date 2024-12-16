Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD2EE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAbp-0006XQ-CU; Mon, 16 Dec 2024 07:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbl-0006Sb-Ed; Mon, 16 Dec 2024 07:53:58 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbj-0004pY-IR; Mon, 16 Dec 2024 07:53:57 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 2FD33114010B;
 Mon, 16 Dec 2024 07:53:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 16 Dec 2024 07:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353634; x=1734440034; bh=QC1CzfddL2J0n0Ggg7BuuXFGbGNmT3Jm
 TpOp7uOJnYI=; b=fHtCPTMRPf4Ch0iIMjAFC33VYdaD/+XRWONxFCxyUzVycjJM
 IF3J3Jwq4/Dn/inVToYSR5WoHQD6fCVdHWZkmpb+y0tLUSGshXRmjloAmuurc/7P
 B+xIBubvr9+3BddjJEUX+ThmYiWb1obzjJ4maOgcTjUbWlcI8LZhcWP3n0XOWtOa
 z7NrN37pIi5iqeafiox1pz5FHo/IdH70NP2nVIsyh4TdePtJR5TfdjDHHu9+S2Zj
 MAp/doztSS6dy/YCp11FHshoqJmMmM6U0qKpeVI3KMaFQeKr87WAAF7TWE8vHji6
 WQMDbqbdq1FluD7AB14EvYYjLFP4J9xt1uaCWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353634; x=
 1734440034; bh=QC1CzfddL2J0n0Ggg7BuuXFGbGNmT3JmTpOp7uOJnYI=; b=F
 Hy+ZHNSFMH2IG+o1+5hicwTpUgvTDeoLRGXA1S9iYedg69zwEednm9fQFMjz2AgM
 fdDJyXbC0d4I6/Ia/vyGDcOirmPt3KjiBVByBqkFhFqVDHgCl0FSLwxHAgT/55hz
 5iqvSKh+odBUsAr3pTRNFcxWy7BiFYfAHwVm9VdxpHrENpOYfeXJexZNi0TQ5RZl
 yR3v1o3PYiS66wcG9g71u/a6rFEapOtW/FRsYDnrK356q3oe/wYU4fkCjbsD/JTD
 X/z9wqcOmg5+buFPDtWKWzx/uBB42u59B/StUpbNhWBMq3ESizjBUOzZkwACJv/6
 0r7wAq/Pmgi7ON8A7fcqQ==
X-ME-Sender: <xms:4SJgZ7b76msW8-tJilfKKlhttBWHRZLQMU4LJKtvDSw37Pa281N-zg>
 <xme:4SJgZ6bM8DhbWK553W5RXy15JVvrxsJqK9QFLYVlAeMBpWCiiL7h2EqTW6p8boLPu
 Is1hJWcq3NoNTReKhs>
X-ME-Received: <xmr:4SJgZ9-ezCppc8ohBv9Hkk5GQuNMk7Hlo5LF13DWyN9dZwPdw0kapjm3XAeVuYV7KZQ1uOR5lcBL5eb_qk7fYwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:4SJgZxprUywJ7QRNyqsu9HkpilF7YKpfyw4eVydZZiIRNGUf7eC9Sg>
 <xmx:4SJgZ2q6-VXKrGRstfWfp99R1bk4fTNmsE3mfk66wbJOZfe5VsMUtA>
 <xmx:4SJgZ3Q3bj9UDauX-xNIP4henm47KG3hHsmd7G0rYNMAARDzz2900A>
 <xmx:4SJgZ-plTTG3JjuKnauTeUY0z0SYlh3DgI-c-V0soxCGT2-GZ3fyVQ>
 <xmx:4iJgZ3e6hjZVRpxujvBBzaG7S7wJH-j_5TmcIPAOuRB8Y-O-5TJPGNtD>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:52 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:03 +0100
Subject: [PATCH 2/9] hw/nvme: make oacs dynamic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-2-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4432; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=58uwSgkiT8hh4hZnwccDV1UIm+ZNGURgwi/2bJqJPMA=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRpcG1VQlRyQWFqaE9EODUxK1F6TG82CmRHaS9LUmZHUzM3QllPdjNH
 eCtvN1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFl
 BQW9KRUUzaHJ6RnRUdzNwa0RRSC8xTC9HclFEaWpaN0ZSODUva0JGY1NpMm50amhDUEE3YnUrbg
 prWUl0aTJYNWJBdkF2TGlzN3BFa3Q4VnF5dHhIUXVKYW1TbUo2TTJVYmNmQnNVaG82WXZudHRIT
 WUxWmVKWVI0ClRpMGMxdVpWT0ZYR2xWMTNMbmZFcGd2TDZrOSt2RWtIVnlrMFFkUGlsMkhKbUdN
 Uktod1RIK09lVUhEeHZpNFoKNGZSdzd3NUVQRkZkYXVyS3poTTFPZG1YYU52YWFXNkNEZVlteFF
 YT2ZWMjdtK0pOM2w3dTJ4U0VhTnR5K01mUgpOYmVMSCtyK0NSTDdVc3Q5TVVOalBGZFIydHBWRE
 szRmd6YjJUOWhoeDRvMWRHTGRZcXVqYXZDdFE5N0czUEZqCnRCenZ0NzBqS283RkxNdklLS0s0T
 WpWV3Fjb0d6UnplQUxGcUM0d1VWZHhIdHY0eDVGM0svcTlGCj1HbHowCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 25 ++++++++++++++++++-------
 hw/nvme/nvme.h       |  4 ++++
 include/block/nvme.h |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e1d54ee34d2cd073821ac398bc5b4a51cb79e0e9..0e95c07c5314fa33674963ef2cea74c78954e86b 100644
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
@@ -5135,7 +5134,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
         }
     }
 
-    memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
+    memcpy(log.acs, n->cse.acs, sizeof(log.acs));
 
     if (src_iocs) {
         memcpy(log.iocs, src_iocs, sizeof(log.iocs));
@@ -7242,7 +7241,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode,
                              nvme_adm_opc_str(req->cmd.opcode));
 
-    if (!(nvme_cse_acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+    if (!(n->cse.acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
         trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
@@ -8676,6 +8675,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
     uint32_t ctratt;
+    uint16_t oacs;
+
+    memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -8706,9 +8708,18 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
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
index 724220691057063a972be2a0ada44d2164266144..191b6c5398d0c4583051a6a9773c677a49caffd6 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -583,6 +583,10 @@ typedef struct NvmeCtrl {
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
index f4d108841bf595f1176e9cb2c910e230181c67f6..9ebee69369d6bfa6835154a91b2bdaaf7984bf0c 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1192,8 +1192,9 @@ enum NvmeIdCtrlOacs {
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
2.45.2


