Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E60BE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAbw-0006cY-M0; Mon, 16 Dec 2024 07:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbp-0006WH-16; Mon, 16 Dec 2024 07:54:01 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbm-0004qC-7h; Mon, 16 Dec 2024 07:53:59 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 01D2C114010F;
 Mon, 16 Dec 2024 07:53:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 16 Dec 2024 07:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353636; x=1734440036; bh=9z/YDyajUnGWonhABTYCxOkzMyeMtyCB
 LStW9KJXm6I=; b=M5ySqa5PoquflqIgLQ/DT5A3TQ4d0cEAbNiby1mOUhsPAdM5
 cR+eevKt1LQ9v+oCqm2ojDXzqbIh2n/fhSuAoTm+2oePLjrEPybab5OnpgDcd104
 ySdDRHAMGHB9Pc/f071unwdkhyg6KaBMo62Ctx/b1p4gQc9we3PD0kqn6RHfv5t/
 0CyPhaV2vnON9SdSGcpvMt/KmH6i1bhVli3DpEbOsG2x5JwcetquQ+CAqNwsDaOe
 re8pv1+lWbuWlK36vSBHH6ITycHQx7n4ZVPFoK2bq+clFyewPb0FIPRJU73MWbER
 FZxDOjuBe7Efu9WAeQi2U6byHThNgGzqWsPWGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353636; x=
 1734440036; bh=9z/YDyajUnGWonhABTYCxOkzMyeMtyCBLStW9KJXm6I=; b=R
 cwg5wqote14QFNwx2U5DHMzTgC+yLFwYXCi9dMj5spGDeYSgt0PjtV7+iC0NeZkE
 zY1foPJtZcGweQcj9X2I3low+1OVa5JptJubRaK14NvNaGup5Etm8NrUMAONB2t5
 ECm+7VXYpsiKOA+C9UEPrS40pPesXmVmXrUDWlTIfKX9s+U/KREN5edLYEquxpfj
 kmt4+ckdNRcBKUnQ2HkLGLP2G63dPCdlWVxee9Z311Bfdzdbh2WQrArzvJAWgUEk
 +i3jAEGmxMJxIW/JxYMaMoHxMl7v1wCFjICQID+GhQZ4/SsALTZApQNRYelAv5jH
 QicV7xu/zkP9XZqv4USNQ==
X-ME-Sender: <xms:4yJgZyHebqkJnwOEaLtSMGSMAEvLS44G8peVpHke5lQuMryHJT93lw>
 <xme:4yJgZzVWKGwS8Wy_obe-UyjR-RUe4TUlvasKfCms1eA7NZJycMfV5H1S3Yjlj5_TE
 n6DpDEZmK3vTqpC0A8>
X-ME-Received: <xmr:4yJgZ8Kq3LCBxCTqdP9AJWVqQbf67tEDQhNitYDr1vqVm1OZd8cKE_teOwWf5JhLzSYkthGdsuM7wO8l-qEx374>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdegiecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:4yJgZ8FsGns95CL2IzEsKoLC2Dsq8WCGfUWxtehokDe9YzqRDGQYJQ>
 <xmx:4yJgZ4V4JQQuLvOVwrH_ycRMxr68ukjH8QWMWxHcEfQnhF3ftHaMFw>
 <xmx:4yJgZ_Nqvl9himnBZ1ztRN86BMrCw-YuNiKKa2bmSqdr5Nl85BHLLw>
 <xmx:4yJgZ_1sy5xUBQfNDdzDDLBuNcvydSxSfazU4dNDc8yiD9Vn2tI6Dw>
 <xmx:5CJgZ6INRJW0DhVBpMjY-rcgcsSNmeHOSgaKWpLXDtimDzEM32W8Gu8i>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:54 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:04 +0100
Subject: [PATCH 3/9] hw/nvme: add knob for doorbell buffer config support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-3-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=fmOgDBvOD2dhh117ujn12LpGBM6Ktn4dln6NNvtv1L0=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRsOE1RNnZtUklmL1ZZOEJiZzRnVnV0Ck15SElNNkN4d2pod3NwektG
 Uk1YZUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFp
 BQW9KRUUzaHJ6RnRUdzNwdklFSUFMb2YyVHE4M2gvS1d0NkUzTjcvemxVVTloYllOZGQ3djRLTA
 poUEJBVHJhUWhRR0JKc1VWSGM2aTJZQkZVRld3akNYbUtUOExlb2ZVVXM1UFJpcmdIbEpjQk93Q
 lpzSDNMaDFRCktic3NlWXdYRVNWWjZheFQ0Wko3WkR1UzlYRFlMaWEyUm0zSXAwZTFnd0Z3WjRa
 ZmFCVXh5SHlsdE9MMXZRZE8Kc0EyaDFUOFlmNUZxV005b3RvQUcyN2ZYV01pRldpSG50QjFFbU8
 5OFR4c09JWmlhN04wUkpubGpWR2EwQXB0NApuTmY2ZnJBL3FDdE84MjVGbUZoaGE3dVVjMnNQZU
 9CS2s3TnFQeHNueWFIemh0Z1VoTURwbUc2TW1SUEs1T3dMCmh1em44N3g5bTJkVXg3Z3dzcHI4V
 3BuYkF2Y004TndaNFJxWVQxVDFjK0Z6a0hOZVUvVk5IS2V4Cj1ZQ3JQCi0tLS0tRU5EIFBHUCBN
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

Add a 'dbcs' knob to allow Doorbell Buffer Config command to be
disabled.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 11 ++++++++---
 hw/nvme/nvme.h       |  1 +
 include/block/nvme.h |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 0e95c07c5314fa33674963ef2cea74c78954e86b..d544789f92ffe6b758ce35cecfc025d87efb9b7e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -278,7 +278,6 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
-    [NVME_ADM_CMD_DBBUF_CONFIG]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
@@ -8709,8 +8708,13 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
 
-    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DBBUF |
-        NVME_OACS_DIRECTIVES;
+    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
+
+    if (n->params.dbcs) {
+        oacs |= NVME_OACS_DBCS;
+
+        n->cse.acs[NVME_ADM_CMD_DBBUF_CONFIG] = NVME_CMD_EFF_CSUPP;
+    }
 
     if (n->params.sriov_max_vfs) {
         oacs |= NVME_OACS_VMS;
@@ -8960,6 +8964,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_BOOL("legacy-cmb", NvmeCtrl, params.legacy_cmb, false),
     DEFINE_PROP_BOOL("ioeventfd", NvmeCtrl, params.ioeventfd, false),
+    DEFINE_PROP_BOOL("dbcs", NvmeCtrl, params.dbcs, true),
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 191b6c5398d0c4583051a6a9773c677a49caffd6..cb314e91af32a20f47e0a393e2458b7d4bdd03d9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -539,6 +539,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
+    bool     dbcs;
     uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9ebee69369d6bfa6835154a91b2bdaaf7984bf0c..a68a07455d0330b8f7cc283da0a5eadbcc140dab 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1195,7 +1195,7 @@ enum NvmeIdCtrlOacs {
     NVME_OACS_NMS           = 1 << 3,
     NVME_OACS_DIRECTIVES    = 1 << 5,
     NVME_OACS_VMS           = 1 << 7,
-    NVME_OACS_DBBUF         = 1 << 8,
+    NVME_OACS_DBCS          = 1 << 8,
 };
 
 enum NvmeIdCtrlOncs {

-- 
2.45.2


