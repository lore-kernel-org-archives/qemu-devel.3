Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD3BC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQfb-0002vC-Qj; Mon, 11 Aug 2025 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfX-0002t4-2h; Mon, 11 Aug 2025 07:26:23 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfQ-0004dm-DJ; Mon, 11 Aug 2025 07:26:22 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 05B667A0054;
 Mon, 11 Aug 2025 07:26:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 07:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1754911570; x=
 1754997970; bh=s6MrAXazLw7EZfd/Th4/I6mHCEsNHvbAfXz8dOb5IzQ=; b=M
 knZwajPb2JLYWHkISXfbCYPGBnus4QVBEOqzN0AvrdmPz52XwW7EcbquwiVUPgIz
 cegG5r1ewzxQx9I/2pDZrJ4YJImj2pE9hy+HlqDdyDcUTBBECw8nwT9r8Flzos0u
 tp9AcpW7wf/M+7pYX7f8pvb7BxCs29N8r76l810LZzygEGsWiAeQVKf7yy6CBB7J
 Cla9CL2YFZmtLJqdE68IzPgm69G/9LlCSB3OM2Nmewix5tC4O5DlZX6UGP9+TYqy
 jfg9F8m74F1kCC9tlYMqsM5WyWMdXz2nmFi7m3KXoah4J/vW6TkB23FmWVU25kgd
 2bAoy63d0TY+BPqY5OTkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1754911570; x=1754997970; bh=s
 6MrAXazLw7EZfd/Th4/I6mHCEsNHvbAfXz8dOb5IzQ=; b=mMyCkbXRGMqne9Zhb
 O9mqpAC/ejLCH3TBlf0PVV/UM3SNb09QYOGchKjqJnQskLMidUVSU0InoR8Eaa7/
 ryYyA2WcdgplDDPRJpXHFSGOG6ZsGddXD9DgRXrVW3k2FkribAHZ7OLkp89lbPjP
 jNelc+F7H/5oRtbWMJ97zVrvXNWQMkKInHkxeXOPzsp5XsmC8AHGS/uX2ClIx7Ad
 xdgNyAzSrUTPFTdIkj/076GQyhyNKo2T57JkC77EONXuzNwMNNze8TQn98y1/jGz
 Zcfls/GfzS9FzIONWA0CzWEyFgdIxkU4QsuojrsH+cbyJbRMkuXOc8v9AmUbB8S0
 jRv3A==
X-ME-Sender: <xms:UtOZaOWCdaQDDR4dEUbXLyj9q3lRMTJ4RgZiSgSX8yUrr-ssz1uYEg>
 <xme:UtOZaCPVmE5dP1Er9_VfdKxklnEPTRzVnp7-xeU8TQtDcptpJttXlZie6gqqTXI_d
 SVVVdN0q14vVdJZ9eg>
X-ME-Received: <xmr:UtOZaAAtPSsvSgvTs4KVh0viapIhMriWmUx5_LmR4GgvYOwOFJ0bXBNreFhMJQliZ38N8AyNcc8EU6ViB0Iq9xXO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhgrnh
 drrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpd
 hrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepqhgvmhhu
 qdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:UtOZaPfmBm99qQLBlbK4ZMJzgafi-05cl-qc6QukiTIL0UQFnPOf3g>
 <xmx:UtOZaPNeDwzITVpS-KYK4jARWCVH7Ll1ehsA7hGKEr0YWibFOvfTNw>
 <xmx:UtOZaPJNHFwia5DIk2_D6tq4qFJXRMdhCPvy1Tp06IABdcrcnqqgAw>
 <xmx:UtOZaPKZ5D359BzkF_nUNa5yNjCYwRINxDe68faqzU_KIPmgQrQKaA>
 <xmx:UtOZaMurGr2wCQFUxkzaZeoYNFM8ySYgKgFwh3XqZkUEfbJKKAj6R2nr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:26:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Alan Adamson <alan.adamson@oracle.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 2/3] hw/nvme: revert CMIC behavior
Date: Mon, 11 Aug 2025 13:25:56 +0200
Message-ID: <20250811112557.521-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811112557.521-1-its@irrelevant.dk>
References: <20250811112557.521-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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

Commit cd59f50ab017 ("hw/nvme: always initialize a subsystem") causes
the controller to always set the CMIC.MCTRS ("Multiple Controllers")
bit. While spec-compliant, this is a deviation from the previous
behavior where this was only set if an nvme-subsys device was explicitly
created (to configure a subsystem with multiple controllers/namespaces).

Revert the behavior to only set CMIC.MCTRS if an nvme-subsys device is
created explicitly.

Reported-by: Alan Adamson <alan.adamson@oracle.com>
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
Tested-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6c06d7f8f9dd..fa48412ef48e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8780,7 +8780,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
-    uint32_t ctratt;
+    uint32_t ctratt = le32_to_cpu(id->ctratt);
     uint16_t oacs;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
@@ -8798,10 +8798,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
 
-    ctratt = NVME_CTRATT_ELBAS;
+    ctratt |= NVME_CTRATT_ELBAS;
     if (n->params.ctratt.mem) {
         ctratt |= NVME_CTRATT_MEM;
     }
+    id->ctratt = cpu_to_le32(ctratt);
 
     id->rab = 6;
 
@@ -8884,17 +8885,6 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    id->cmic |= NVME_CMIC_MULTI_CTRL;
-    ctratt |= NVME_CTRATT_ENDGRPS;
-
-    id->endgidmax = cpu_to_le16(0x1);
-
-    if (n->subsys->endgrp.fdp.enabled) {
-        ctratt |= NVME_CTRATT_FDPS;
-    }
-
-    id->ctratt = cpu_to_le32(ctratt);
-
     NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
@@ -8927,6 +8917,20 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
         }
 
         n->subsys = NVME_SUBSYS(dev);
+    } else {
+        NvmeIdCtrl *id = &n->id_ctrl;
+        uint32_t ctratt = le32_to_cpu(id->ctratt);
+
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+        ctratt |= NVME_CTRATT_ENDGRPS;
+
+        id->endgidmax = cpu_to_le16(0x1);
+
+        if (n->subsys->endgrp.fdp.enabled) {
+            ctratt |= NVME_CTRATT_FDPS;
+        }
+
+        id->ctratt = cpu_to_le32(ctratt);
     }
 
     cntlid = nvme_subsys_register_ctrl(n, errp);
-- 
2.47.2


