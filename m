Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE24CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 06:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssz9N-00042i-9F; Tue, 24 Sep 2024 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ssz9K-0003zs-Mg; Tue, 24 Sep 2024 02:35:50 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ssz9I-0006my-Ik; Tue, 24 Sep 2024 02:35:50 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ACC9B114031E;
 Tue, 24 Sep 2024 02:35:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 02:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1727159746; x=
 1727246146; bh=/GVMZWAW2IQisXmNAp82O/ytrdZmasPh21arTOnvM4E=; b=h
 wuUvpEn/qyCesHGcPkxT9a3EdNgMvaWfpPcs5pbkczLBW2rsXpOUImWURufUecZR
 UxbTeWTV37ghmZWdoi01KatPJsdgSlz3y2vsCiLcnUhOXLzyJyAZcoBFtl1/gnYf
 Mzqm8XIU6w3gjfAQFFvxd6AOv+Y+yJfhqeTAehWn8MTUaPnbrKnJJMdpuDoOJ+7i
 EgMIKQQaEB9zOm2u9OXROrUDLhRrDHSAGr5FO50E7J1pjMB6jxOMG1oRLrBi7LUn
 sJsv85lGntXnUA6jK7ZVSQOzzlbYix2wwoVrTpv/A9uLk4DHfQrAEgGlH+5H9WLJ
 6waj0PNAbTbLgeNbhX/vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1727159746; x=1727246146; bh=/GVMZWAW2IQis
 XmNAp82O/ytrdZmasPh21arTOnvM4E=; b=bG6/Y1GZwTOler6akazZ47nxG7fjp
 IWG/DQzZdxjTHNtNHUrz8b+VmRieKSejejeo2dr+l0wqskIIvFdHqrgpe2P6n7uU
 h7XbLiHxoEW6n8riHR8QccRrnqk+bCqCUmh5EejuAcbkKD6eUaP6P4gYIbwVPMpC
 98lXMW1igBIgsImtHvigggqm/+onz0x9pRxOFRKwOlQg9Ug8Lb3hyM7i9VW9ZO9k
 Tkp+IMcXFrBDvDpOr1sl4CgV4e2Oh+GSS211Vfva4VCTWys2w8iyDY0VJtQYU8M/
 tsDMKikuqKhy+xgwrAJFeXo6pb1LWsQK8cGUBtWZnXznRP6iDVeuf2bqg==
X-ME-Sender: <xms:wV3yZnRDAQfpPI2Q9sIJwdYnfxCjtqfL6dM3lnWV0cWn54ZBqtjkmQ>
 <xme:wV3yZowMCi0IoiK-rzdI44DMBipf2nnjFBT9KeB9jFi8ASJEe5j4GyubdBaOc317m
 b-pYWl5WNT69_u95Kk>
X-ME-Received: <xmr:wV3yZs13_STP56MLGEQuYD91fKuZkhwPjVZE6LG30kxeFKirGq6r1xpouhYpeW2NX6V2xT6daZtj2W6lbGG23Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpedtheevjeeihffggeeihfefheeuiefguefglefhtdff
 veehffekhfekgeetteffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthho
 peejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtph
 htthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghu
 shgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:wV3yZnCcbfXKqSgueUryhaG2Lq7I8FnNMzD70xWK25ZVav_zZsCjjw>
 <xmx:wV3yZggAvI0aRNb9fFvyrGPuE9EyHnxdSBOl8129JAh5LP59bETOng>
 <xmx:wV3yZrrPWbnm-lNPsOfk1y5jT9pLCbLz6BsM2dEX8UFs__y3O2LNUQ>
 <xmx:wV3yZrgf9NnhZCTn4eTQ_Xsh8oK3XL9lbXx_jr2LaDWvLmI3fDJlVQ>
 <xmx:wl3yZsjRf6UC-ojhBmossUBZCF74Gy_cnmPd4oAQzZsOj5Fa3HMnCFh2>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:35:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 24 Sep 2024 08:35:40 +0200
Subject: [PATCH] hw/nvme: add knob for CTRATT.MEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
X-B4-Tracking: v=1; b=H4sIALtd8mYC/x3MTQqAIBBA4avErBtIs0VdJVr4M9UQWqhEIN09a
 fkt3iuQKDIlmJoCkW5OfIYK0TZgdx02QnbVIDupulEq1M6hzVHnjJ48HuE0qEmpXshBWCOglle
 klZ//Oi/v+wHqQ3ZeZQAAAA==
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, Arun Kumar <arun.kka@samsung.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=ON+cOO0iBGECpQWy+CtmAVfTpZLYPt6SvhmXcFNQmso=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2J5WGNDbEdVVis0TnYxOThQbmxMUDBTblRtCnQxM2RwSmY1K3RYMDlYRTRH
 ZUE4UDRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbThsM0F
 BQW9KRUUzaHJ6RnRUdzNwNFQ0SUFLT0dnaXI2N250Rk9xT202emM3aHNiWmZtMHMzKzhFWWpWTw
 pHNzkyVnJ1TXUvaGl2MHZqaGd1ZVJFYW5Gdmd4YTVqOW9VY09TMGh0aVhCQUludHN1L09oNG4xL
 3ZPdCsrdis5CjUzMThBVkxvOFdtcnJ4MzBVbFVxbmNzbXpvTWZNRFRPOFhGT29nWWtiL2VXN2Y5
 NERSamRLaW1rT29wRDc0eFUKZ2UrTmRIck1BVlNqRlNCajR5OFJKY3JsaGxyUm1WVkhCREh0Q1l
 qVldhTnZOT2d6QWxLd2VkQTZ1a2tTKzE4MQpWTmt2Z1BMYmV3NnNOTm82L3FMRHA5MEVXNjJuL0
 J6OTZTVlZwaVZRcjRWaEhuMmY3Z2EzY1JTUEUyZlVBUG9ZCkhWSnYraUY3SG5KMnptZXF6SVo1Q
 kYvUWVRY0Z1UHphdHV0M05RaUQ1c0x2TnJBNm96SkR2SzhUCj1yMzBsCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-a6-smtp.messagingengine.com
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

Add a boolean prop (ctratt.mem) for setting CTRATT.MEM and default it to
unset (false) to keep existing behavior of the device intact.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 ++++++-
 hw/nvme/nvme.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f36c45931821..8556f3e61fa0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8492,7 +8492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cntlid = cpu_to_le16(n->cntlid);
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
-    ctratt = NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
+
+    ctratt = NVME_CTRATT_ELBAS;
+    if (n->params.ctratt.mem) {
+        ctratt |= NVME_CTRATT_MEM;
+    }
 
     id->rab = 6;
 
@@ -8751,6 +8755,7 @@ static Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 781985754d0d..bd3c6ba33a67 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -538,6 +538,10 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vq_per_vf;
     uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+
+    struct {
+        bool mem;
+    } ctratt;
 } NvmeParams;
 
 typedef struct NvmeCtrl {

---
base-commit: 3245de3f3d002bc9ce2ecae61e8d86cb9e375808
change-id: 20240924-add-ctratt-mem-knob-ae4431251cb1

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


