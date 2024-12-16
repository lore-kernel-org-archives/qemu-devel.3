Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B847E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcH-0006o5-VO; Mon, 16 Dec 2024 07:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbs-0006YN-Co; Mon, 16 Dec 2024 07:54:04 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbq-0004qp-Dd; Mon, 16 Dec 2024 07:54:04 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 58210254015B;
 Mon, 16 Dec 2024 07:54:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 07:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353640; x=1734440040; bh=VPWCRxCkP/txFScLrXgxYvXqGl2JLpgI
 ktmLuQFkXA8=; b=g76iTodrPe4Qh7efZMTfiXoCs8rNnQi1yS+f13RAXUTxEzI5
 gRp8io+08nn02eYaheSA2YchmRyP3edt84KZvp0Khr5ILAZkKVt4eur1ll08C2Jo
 xDvDCzbMPlp4OFM62uZl/LfOlJFkFvrxHgd+O8TsSQHicbQxanwTKS/DvIHqYOZ2
 /zgqNpzX3Lfp/ZJh5PdksYC54n2vkT4sOrEE513mXhn1nIC+Yo9jOiEnKCHvbrX6
 jrc4hdSd0pJq8tt8gU0unKXoWA/t5LpvopYISD9YHediPcpaKUW7PcTeg3Muz5PK
 T+p0KJ0F69pEYJgbscoS2fjfkrQ6OntioHbgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353640; x=
 1734440040; bh=VPWCRxCkP/txFScLrXgxYvXqGl2JLpgIktmLuQFkXA8=; b=M
 GuI/EWipohWUm1xDKtQGYUtxc0FVnWR9hjaE9MbUDX/MS1G+Tn8Egb0eU62K+RrI
 lvTUmIKF4YXB4i/V87bHqLybBkDdFuylsoDA78shgnUoyVcPYCUaS7Xwx4LUjFyB
 JLohMYgkA4dL9nqhHmqQ3/bGcBftbPvFPAsLya5dHrir2UL3vHvkGGN0USqgN+Aw
 iZcrX2/zmcQLnMCKXZXREkG56Q8bWznhB/G4j9oQLTTcvZvDOEfZEpWepG6Nzky3
 2qvLbzNDJiJ3RKcD7MIo+04wsy4kMOGfHYD1HOVlSQhHdNFiHuJgeGBbJtYM8HAp
 4A7/8/lJJyeDcR4x7kdUA==
X-ME-Sender: <xms:6CJgZz32XKgtv5oxaL-MdZdhbBU1YHNMnnNFWqKw-0v9Bza7y234Bg>
 <xme:6CJgZyHCAWNv2PihWxXYSv5CrFXW-m9VmNvlphwXftdG7ua2ZXI4NkSV3qAG7tN84
 5bS3R-1hhQw0XkpT-Q>
X-ME-Received: <xmr:6CJgZz6m9UeetTGv2pxYCas10fSwHEyd7xRsmycryLUL1pFHOdHyco0efDD3w7CMGTJZTg8SFq712hiwNVtSCpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:6CJgZ43o_qAGaCC3c7F6otcve4t1ooN7uR-rVYuAuA0vSBItuD1qeA>
 <xmx:6CJgZ2F2t3Vc9nUr4BYrv4WBloyPOI-npVgVtO_Iwxu5b3jQhResUw>
 <xmx:6CJgZ58py7ORahKa4p66XL24BTBOoFy281UGdIv0yEMPuqZxSYTulA>
 <xmx:6CJgZzkkF8g7S5sWNmLnVAamIyzyAMfXCN2-ggWwSiTMFhLjrBgDlQ>
 <xmx:6CJgZ75kmJggljFzYhsOtSA0zy2li7-gcrMgJrqL5FbMH838Mop0xEJm>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:58 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:06 +0100
Subject: [PATCH 5/9] hw/nvme: be compliant wrt. dsm processing limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-5-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=ILTqjT2oAVsQ3hrSwEkMsd15ebn+Mt8eGJNOidlyM/g=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRuZFBpTFpQL1k3TUZxenh6UEpSUHN3CmMzdmpjZDFWUmpad25wR0lY
 WWtnUElrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFp
 BQW9KRUUzaHJ6RnRUdzNwbFNVSC8yaENLZGRIdFJBZjVMM3JFTjg2eVhtaFFWcEZ5QzVySnhTVQ
 pNRTdvYVFCRDE0RlZBdmxhS2FzQzA3L25MckZUTWhpa0k5NmxiTWdWUFV2RFZ2cW8xVWdmeHJHb
 XR4TVl0UWNKCllWK0ZFM2RPdTErME1PSC9Ed3RSR09BNTFGa1U4dCtpUnkzdDNqQXFlSGNzUGo2
 SlFTTWdaMlpBVUh6SlpidTkKaTF0OXZBbUNFZnFxdUdkVVJBUlprNmRwekYxS0puMDB0Z2NCR0U
 wWDdMSTExZVlMRldFYWxwckhzTkVvMk1ReAorUHpJWEw0djJNUnBhQm9RWm45UlpRNXl4U0Rxb2
 VYaXdyQzl1UUYrWWdVb2FFMkhwamtTQWcvT3N1c0FxVjFJCldvZHZNQ0M0UXNxU3JKYW1jNGlUd
 0F5MlJHUC9ZYklSbkxHNkliMFpuQTZwTzdmSGR6TkdMWjVQCj0wdG9RCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

The specification states that,

> The controller shall set all three processing limit fields (i.e., the
> DMRL, DMRSL and DMSL fields) to non-zero values or shall clear all
> three processing limit fields to 0h.

So, set the DMRL and DMSL fields in addition to DMRSL.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 24 +++++++++++++++---------
 include/block/nvme.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 120a1ca1076c8110d8550a5e75082c6ed4f23e16..22a8c400bae332285d015e8b590de159fd7d1b7a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5581,7 +5581,9 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     switch (c->csi) {
     case NVME_CSI_NVM:
         id_nvm->vsl = n->params.vsl;
+        id_nvm->dmrl = NVME_ID_CTRL_NVM_DMRL_MAX;
         id_nvm->dmrsl = cpu_to_le32(n->dmrsl);
+        id_nvm->dmsl = NVME_ID_CTRL_NVM_DMRL_MAX * n->dmrsl;
         break;
 
     case NVME_CSI_ZONED:
@@ -6638,18 +6640,23 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
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
 
@@ -6737,7 +6744,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
             ctrl->namespaces[nsid] = NULL;
             ns->attached--;
 
-            nvme_update_dmrsl(ctrl);
+            nvme_update_dsm_limits(ctrl, NULL);
 
             break;
 
@@ -8838,8 +8845,7 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
     n->namespaces[nsid] = ns;
     ns->attached++;
 
-    n->dmrsl = MIN_NON_ZERO(n->dmrsl,
-                            BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
+    nvme_update_dsm_limits(n, ns);
 }
 
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 145a0b65933a699504d6d89222f7979a06f615df..f3f0317524d129f518698c6797ed37a7ac0ac847 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1167,6 +1167,8 @@ typedef struct NvmeIdCtrlZoned {
     uint8_t     rsvd1[4095];
 } NvmeIdCtrlZoned;
 
+#define NVME_ID_CTRL_NVM_DMRL_MAX 255
+
 typedef struct NvmeIdCtrlNvm {
     uint8_t     vsl;
     uint8_t     wzsl;

-- 
2.45.2


