Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6086CC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRFP-0000An-FT; Tue, 03 Jun 2025 09:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREq-0008Fh-LN; Tue, 03 Jun 2025 08:59:32 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREg-0003TY-0l; Tue, 03 Jun 2025 08:59:24 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 03271114011F;
 Tue,  3 Jun 2025 08:59:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Tue, 03 Jun 2025 08:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1748955556; x=1749041956; bh=y5V6W/JEblkbq3E1JPZF28lW5KxLIi1B
 kon1d74WZs8=; b=CYT/RXfmCGODDRWMsSY7vls+ELARj8PFfW/CFn+4Q1vH0FGb
 DjH7G9LMKJSRodwOMrziTNvvmjQnPZ2M+/MBVsONTC2GYfFo0QPwhT9mlVJTgjgG
 Yr7nmpjHmOJtaNPQlb6LqZXDSAMMEThhQ1z8NZNdU+QjviHTffltBMS1We91WIVS
 NR057O6Cssidj+xccO5Exvl3ive1F7IQirwSYZhW0/RkW1nghQX2oADaEesyLnng
 EcShf/ln3LzOKuBDy9WYLkkAwn+WmEa/Q1H3Hgcu6/mpGn5he9Tws3tabGLQKLuG
 UaNkM37mqfqljaPflOtmcK1FPq7eft4tkIPkcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748955556; x=
 1749041956; bh=y5V6W/JEblkbq3E1JPZF28lW5KxLIi1Bkon1d74WZs8=; b=g
 ZC3BhJ10QwcZWdDVYbouQzEmyyJE8PcEPzcptRvWxo5KSXiL0lRkChOJUD7eTjYQ
 fYiVfHZdh4b6kAj/41yxMG9HdDD8gnJDIjFjJH5CaeWYBF6MNTD0KjqIkpV7Lvje
 xqwruaCp4oD9jPL2uXwJhAthtc3SAlu0gPzUIWryE9rIW89pLw230MhcXJTFymOr
 TPCKDs+5KantGxDrSzpaWqXsYmlGyI0jy3pOiudrzT7l0FFd5U+DuvIdyrQv1/zM
 cSVrb0FcN3J2NGEwsVaev30GzCFxi3KtFwPfLHE1konNkPsgW+NwHOWLEin8tljs
 tpA0EhUkOgIawSh4KPCWQ==
X-ME-Sender: <xms:pPE-aG_RPGHduJ5YHZiHcVHhsxU9X9LBPbMYZmkao7VZc4eECDn_BA>
 <xme:pPE-aGsCWadPkchvC_sItspyw5Xd6lZ6b5jnIhC_4hmLELaCdvBqHYcMQNUqCMY0D
 DZKV3Qc-c1_udmiIRA>
X-ME-Received: <xmr:pPE-aMCBFjVlDy-mR9_swdHOKGFq_PwAJ7eqqcQYzQ4Fjl9KskR-1ryXUOEPsARDa9b9bFwQjccZgNQo8Ri0bV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeftdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeugfdvhffghfduveevhfdtudelteekiedvjefg
 hefgiedtkeegkedttdejheehnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehithhsse
 hirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhu
 nhhgrdgtohhmpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpth
 htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pPE-aOcqCzUVHbedlc5U7cl30sNQ3B9igoa0MSwEGfY4JiWAYzzJEw>
 <xmx:pPE-aLOShLmHV7yTlyG3DlxZ5_B_0F0ALtsvfElheX8WBsF_6yWlzQ>
 <xmx:pPE-aInkKREavVFRTreDC2h5OdIngHXhmWkEdEj3YNB7ESAlCealNQ>
 <xmx:pPE-aNv1EuEoc7ql17C02ytV8Xdpnthw21w0xPggbTspsFo-dHhFJg>
 <xmx:pPE-aLb8mmVH1pQytXUIdC1dLDLM2EuBTt6J7f2li3PJiSjL_koChil3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 08:59:15 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 03 Jun 2025 14:59:05 +0200
Subject: [PATCH 1/2] hw/nvme: fix namespace attachment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nvme-fixes-v1-1-01d67258ffca@samsung.com>
References: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
In-Reply-To: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=DdKAdqERNmRTfjfQ+jQi3HjMm1UV8DhmXEUgpbxFjxU=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekF4ZWo3Y0wxaHJqL3ZTO
 GJUYWtrTUdYWWZGL2htU0Rycjk2dDVYTjU5MTBnOVE2cnlYOGZOCjdGai9UWHd1Zno1eU1ZWFVy
 dTlrTkdaaFlPUmlrQlZUWkFuU01GNVYrdWpPczBYdWFRZGdCckV5Z1V4aDRPSVUKZ0lrOGttWC9
 YeW5BZStxWVI3YUNpOVpucmZJTGQzOUx1VTFkbkt0dmwrTm5yOWVkcjc5VGQ5dkpYeXRWWng1dA
 pPMjdXYzlaWU5TYndWNHFlbDJQZlJBNXoxa3U3bGRiNWJFcW80elhmNWxuQ2MxbEY0L3JkYTgrK
 3JLbm92ODczCkl1VVBaOXZzNnpNa21Rdk1SUXYxTnluK1BqVlAzdmw5M0pIeVVPbnRtOXI3RlA5
 ZU9ycks0VEovdVcwMSt5LzMKakJOMkNpdk1md1VWS3U1ejVUMjE0ZTRGWlpYMG5CS0pndHB2dml
 FbGlwMi9EcVJxWHQ4N2lVLytxZGI2UFJhMgpDdDdCSjZjRjJXNXM5N25XejdZNXJVbHNsMTNZRV
 pQYytyV05reThZYy8zWUhwUi9iVk9ldW9lb3VwbHJ6cVUvCkNUL0NiZjlkZXlGU3ZhVlZvcjFJT
 VgraDIxdUxzOHVyNzg1c0xOZnNlaG0vcGhRQURSMmpMQT09Cj1ld3d2Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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

Commit 6ccca4b6bb9f ("hw/nvme: rework csi handling") introduced a bug in
Namespace Attachment, causing it to

  a) not allow a controller to attach namespaces to other controllers
  b) assert if a valid non-attached namespace is detached

This fixes both issues.

Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2976
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd935507bc0280c1f49822f9e3cb035df596ae47..8de900ef8aca9b510b072892f9f82c01acee4f7d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6816,7 +6816,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 
         switch (sel) {
         case NVME_NS_ATTACHMENT_ATTACH:
-            if (nvme_ns(n, nsid)) {
+            if (nvme_ns(ctrl, nsid)) {
                 return NVME_NS_ALREADY_ATTACHED | NVME_DNR;
             }
 
@@ -6824,7 +6824,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_PRIVATE | NVME_DNR;
             }
 
-            if (!nvme_csi_supported(n, ns->csi)) {
+            if (!nvme_csi_supported(ctrl, ns->csi)) {
                 return NVME_IOCS_NOT_SUPPORTED | NVME_DNR;
             }
 
@@ -6834,6 +6834,10 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
             break;
 
         case NVME_NS_ATTACHMENT_DETACH:
+            if (!nvme_ns(ctrl, nsid)) {
+                return NVME_NS_NOT_ATTACHED | NVME_DNR;
+            }
+
             nvme_detach_ns(ctrl, ns);
             nvme_update_dsm_limits(ctrl, NULL);
 

-- 
2.47.2


