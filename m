Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA6CC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQfa-0002uf-2o; Mon, 11 Aug 2025 07:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfY-0002ta-94; Mon, 11 Aug 2025 07:26:24 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ulQfQ-0004eW-Ec; Mon, 11 Aug 2025 07:26:23 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 157997A0081;
 Mon, 11 Aug 2025 07:26:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 07:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1754911572; x=
 1754997972; bh=mi9pZ3LFQVGMrdUdfVF65b2q7BTmwvZnwSwFJjAwaCc=; b=g
 VO8dMLaiNQZaDLTBHXJ6x6MvoA7Fh2jS04/jCi8sM2TrvjZmonGwcBzc+PXt/bXy
 EL9iFO4j1KurjnTygDC9tKC9yu+OnBzJWBweDvfV1+DDSsluGkaX1AEwj8KxAUP8
 /Eb/KuV2X5H8eaolgY5uLGARuScgyzSKJ92QatnBPfbyLryDATGKBK9XN1c5cEuj
 hHkvcxteIJUR1F0YRKwxfMjtooQmWo8QuLKth5oKJcqxyVWZz974vHdiny6JMLTi
 qF4/rQL7Z88pZ+A9/cG/aqOy5FPIIMhYESNqzj4hTjQqYRuqZkhhQOMHuK6cq4fp
 OW539Z/lec633/mj55KFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1754911572; x=1754997972; bh=m
 i9pZ3LFQVGMrdUdfVF65b2q7BTmwvZnwSwFJjAwaCc=; b=VQcKm+r5ses9FD+FO
 SKb80SuHbyPvCUMlUTCyx7HyhcqcoDZrS4LSNaNdytTU51p72vilR0cKHTICQA3X
 V6dYJY4VOcGrQ4dQ7mRwpRamJrhSYHfdrncD72+a2rUDzJNeJJde3PNChTuTkQm3
 VWO0kZ16NHuUVNASrfnImOpJ53yoT11bqVi55n7/ZJJR2IJshPFxTKoO/cheRvwb
 OTbOlkJm78Fg03gyB+UX52Wp9Oz9j+8w3nzaSPhinqyH/aBt+E4fmHYuywUOhYPJ
 PzC6gIsALypMUXVvA606zOlPb+kzqtDf5cL3tl51Ix4E5xX2sztfocEo4ncXTUAG
 g0Tgg==
X-ME-Sender: <xms:VNOZaAtpxbuw2gtHMIGgJ9Qh7OSylK9yVlIAtJpM19JQYo-kH47UPw>
 <xme:VNOZaE0Smr0uqUkEaDJmZtVD0HfFZMBjB_Bx6urGpOjOQvw9wdy5OAY5IY_5aayAf
 JNj0hsZRGDAK23z_PU>
X-ME-Received: <xmr:VNOZaBX91MoK17U_UA0kXpjRXhsZ0w_f35ZPp-PKa768xqpX6iq6s48FcUgVCkrHPiStigO67ZGnGQt0PFRZxkdR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvg
 hnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhht
 rdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhope
 hqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:VNOZaPJ7sCgKZNxAYrUwUimsXvdgu7p7HSmNs554_JaePVjR6YdkmQ>
 <xmx:VNOZaD2gR5DZR8BaBht4Zj6sElFSn83O57A9axumZpEw1ix3NfCoZg>
 <xmx:VNOZaF7cZq6LndRxVaY2EWOUaw-3LlKr1Fx57MQ1XoaSQeJ-Iuxjrw>
 <xmx:VNOZaM-nvaig_u4Gq4mulB_3fgNODl4T3YwfkZ3y79JPhPpyvCwq0Q>
 <xmx:VNOZaHvetKOFEU9bnjmiFNfANWfRYYirafJ81STxa4AG4RxlhoBv_ECN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:26:11 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 3/3] hw/nvme: cap MDTS value for internal limitation
Date: Mon, 11 Aug 2025 13:25:57 +0200
Message-ID: <20250811112557.521-4-its@irrelevant.dk>
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

From: Keith Busch <kbusch@kernel.org>

The emulated device had let the user set whatever max transfers size
they wanted, including no limit. However the device does have an
internal limit of 1024 segments. NVMe doesn't report max segments,
though. This is implicitly inferred based on the MDTS and MPSMIN values.

IOV_MAX is currently 1024 which 4k PRPs can exceed with 2MB transfers.
Don't allow MDTS values that can exceed this, otherwise users risk
seeing "internal error" status to their otherwise protocol compliant
commands.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fa48412ef48e..f5ee6bf260f1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8339,6 +8339,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
+    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
+        error_setg(errp, "mdts exceeds IOV_MAX");
+        return false;
+    }
+
     if (n->params.zasl > n->params.mdts) {
         error_setg(errp, "zoned.zasl (Zone Append Size Limit) must be less "
                    "than or equal to mdts (Maximum Data Transfer Size)");
-- 
2.47.2


