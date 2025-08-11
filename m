Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C702AC88CB9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQfY-0002tH-6f; Mon, 11 Aug 2025 07:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfW-0002sq-6H; Mon, 11 Aug 2025 07:26:22 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfP-0004cd-Fl; Mon, 11 Aug 2025 07:26:21 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DB0657A0083;
 Mon, 11 Aug 2025 07:26:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 07:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1754911568; x=
 1754997968; bh=i/mw+hQG5A6p2/B45mPVdyaSEbYyrQOqN7pCLNhcZvs=; b=D
 4QLYoFRpX++txeH/Zml4O84wrLZzWmYqlbQb3I/ydrJ8mCwcqxKUJONFInPM+Zks
 2pupz8g7od9WeA+BGUUfMm4RgpXjsmYPVt31Wkth61JAZswbJxVrGeQA2+hc5ZXj
 7YN884lT+cS6pzBaHmTPhnCnxMaivRY4Uc3VVhHfTTlzq7dxgjBgpPUSMFMQ5QOL
 WdbxBYJWyO1ep2uRFL370q6MX7gl/8NO7fmvrhZo/78vG+p+JUBv3cdoH9v17qGo
 hLQww1jq3kKBIpHjDSnvQFKznEDm5Bak5fu6W89IhYDKKaG4RFHZsnOTa1WQJtjd
 y0UMhTw4NvxDXCihRZfSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1754911568; x=1754997968; bh=i
 /mw+hQG5A6p2/B45mPVdyaSEbYyrQOqN7pCLNhcZvs=; b=GBmb9rVolhfQ47qTq
 MPodGB3xtRMszUQyiQCZV2tA1wDVviKGpyMqelnI4d7GMBhHlKmLRGsAKPpjk1Nr
 GWKXNq4IpUCf0MlcoQ5it8iPzjACNHVdwqYRbDftZX2Y5Zssz2sdiXVJ4hrV5vfK
 mPT4qFAcljEucouSkRufixg9GD0Gu9csb423D+4pHe4EPe99mZUDGwzjVdLfy6tg
 ALAAl+vfa4oULar+JcTwedvFPOBnVOHKfjl6FAUaLErUt41jJkMAHeB6h0RgATfD
 ViuIh8EMcPl5DSw0yw4WC7lkEIIE07kKDXRC0Ks3nQltEZBxIL8uzx0q1Zyw4CBO
 YEf4w==
X-ME-Sender: <xms:T9OZaNoYEU4nasX9NCqLQGgd01A5hcDyOqGjBb0GNhlDmhi9aBdFEQ>
 <xme:T9OZaHDnm5z0p2x-32ebyd86VHB8aguM3XKH1YfdjBBcZK4cI2rCdpICivmgCi0IG
 SO2tSclwZrhL9l9Rt8>
X-ME-Received: <xmr:T9OZaPwuXjqeCR9svC5Tg4BY8MlBB0NIk_hL3ZZ8GzvBzZShyY11c5-pzqP5DKYKWLFgELYv1gG3g2rP54DbGX55>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeehteeghefffeegkefghfegieejkeevfffhjeevfeekudeiieevheetledujedu
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuh
 dquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhigu
 vghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmsh
 hunhhgrdgtohhmpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghp
 thhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirh
 hrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhn
 uhdrohhrgh
X-ME-Proxy: <xmx:T9OZaE1F5DtXd0Vg5YpxOFaUFiCnnQBRfolU8SVCewYzeTuM0jCD8w>
 <xmx:T9OZaPwdIM7yHlS0yRpksQGRM_31pCuqgTb4ugV7ba7cYUePtqFn8g>
 <xmx:T9OZaLEAohJw9skH0iwpHmkb9GVkJjwWRYFrhYl8dByx93AFlO_e5g>
 <xmx:T9OZaCaxEu__7-bwhdR6dbeQuVd6YG4Z--Er0IzgWkrMhXeMUTLcYw>
 <xmx:UNOZaGZNCiUua47D8u0DJl1DcEHZhUS3gOZ9VnkTBEPxK33TzpFH9NtO>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:26:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 1/3] hw/nvme: fix namespace attachment
Date: Mon, 11 Aug 2025 13:25:55 +0200
Message-ID: <20250811112557.521-2-its@irrelevant.dk>
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

Commit 6ccca4b6bb9f ("hw/nvme: rework csi handling") introduced a bug in
Namespace Attachment, causing it to

  a) not allow a controller to attach namespaces to other controllers
  b) assert if a valid non-attached namespace is detached

This fixes both issues.

Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2976
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e764ec7683ab..6c06d7f8f9dd 100644
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


