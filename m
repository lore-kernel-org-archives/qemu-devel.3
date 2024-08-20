Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 04:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgGkU-0007rC-3x; Tue, 20 Aug 2024 00:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgGkB-0007gT-A9; Tue, 20 Aug 2024 00:45:31 -0400
Received: from fhigh2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgGk6-0004Rz-IO; Tue, 20 Aug 2024 00:45:17 -0400
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal
 [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B62BE1151BB3;
 Tue, 20 Aug 2024 00:45:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 00:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724129112; x=
 1724215512; bh=HVAtgXy50HM9RFO1/6tZGIwc/XjCv1WORDOYVlqO4CY=; b=D
 lNC7UqXytsm9orx4QBKx5EBuKSlkF5KnqWPIH3FyGeKumC1xBCkT+c3kJ6JUVya9
 z6oSj4lsHMsWFba0G7r1tFeKveOQhUyBrLDHFdhyh9jYkAJOnT0eaoBJeZ6k011t
 qF66PkAwX4jnYO0Wca7IZ9q16g10Zbuf3U2EDanUEwmb4KPOpzZG3kE61RvCI+Io
 UQVxWRjZxdMiQhpr3WDWO6NcSDTBxOyCU2JoY36Rdd8Letshkc5mwmW3aMzc9xP+
 x0mkqwYrVRoBdTYO4BLZjXEnibRlJ68U11V1pWK0KAazR0+cY5qgL8GYNKpPjhHQ
 QOuFkcsBIvq1GryKa9ePg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724129112; x=
 1724215512; bh=HVAtgXy50HM9RFO1/6tZGIwc/XjCv1WORDOYVlqO4CY=; b=K
 3/mk2VDoX1/771DtnRlw6An6tnd5+SONOM4cI+vkan5dfrS0ukj+T7zQoz49y8md
 +/qDHfYrRTJUO2CZhbYtzstyqzTxKoIEZwEi9kVKbqgs1a1sfAIb0jvtC0nN09cQ
 1mpjpHdMrRltv9sSj3LuifMvwiFEtvoiMWeeot9NF8oJeU0/OP5MfffBgkP7KoJD
 D580wSoUk7C3Ooy391MoganVuRflGzfp82fugSA/AO6aION6quf1qdwaIuZv4ljE
 EBcHMVMdusLpL6WdsyVF5WU8EHuCGLWyUhKjsi9CdjHz80VJvsOKFJQxPxHdyzgm
 XggxyprPryOqnJRyeBfBA==
X-ME-Sender: <xms:WB_EZtTBkfTvShFLpFYDEJJSxqbA8ML1H_eMYpgTJJ_kT-T1-Kvl2A>
 <xme:WB_EZmwbmuXCKng8Bm6wRpCLh21GSJrGiQXm7uo2qQPFc4elKac0Nru3LV8IAJiff
 I5f0k1JdgkGzR_frn0>
X-ME-Received: <xmr:WB_EZi0NMR5RVV3sfvOLIQMYon-PV_YvxS4--m11AY3BuvwcQXzoIRe83ydNMmJN-EkrL-cuv2j9haklyra3yC7-QlG83eofNM-M2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfeh
 fefgjeejhefffeegudejudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghrrdhmrgihug
 gvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehqvghmuhdqshgvtghurhhithihsehnohhnghhnuhdrohhrghdprhgtphht
 thhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhosh
 hsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhht
 rdgukhdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtph
 htthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:WB_EZlB2GF13GDK0JIsf83fzjZSj3tJQBJ97xfc041WE9tJ4ZaKbgw>
 <xmx:WB_EZmgEuktSxJTV6Cf3t5Bwftzz3KdsuFfLRA87DUH3-cudnMt1YQ>
 <xmx:WB_EZprs7x4BaXeeJ1ekC-jwFEoZPZ1RWkWrdH0M1RN0Osq8-OJcLw>
 <xmx:WB_EZhirT9e0zsaRrKrSIRnuIwJNJqyPnah5-GV8K-WxPvbX0fOr5g>
 <xmx:WB_EZraAyj3BMegTKFOei_jzKD0ijsXGCPoxAjBrlXeym7sCCK8tz0iV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 00:45:10 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, qemu-security@nongnu.org,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Yutaro Shimizu <shimizu@cyberdefense.jp>
Subject: [PULL for-9.1 1/1] hw/nvme: fix leak of uninitialized memory in
 io_mgmt_recv
Date: Tue, 20 Aug 2024 06:45:07 +0200
Message-ID: <20240820044505.84005-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820044505.84005-3-its@irrelevant.dk>
References: <20240820044505.84005-3-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=k.jensen@samsung.com;
 h=from:subject; bh=dmvovNmsI1IDFQuXVJiFls1WySo1nP5aa4y1cnkMalw=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGbEH1HhSw7IDeD0skseRiuzJqX3JkHJ0ioN0
 +KN5hl5WzPNbYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmxB9RAAoJEE3hrzFt
 Tw3pUHAIAK6JNXpTdFrxcQanezOo13p6TjFMmPDHa6AMbXoRuszBX1PBYxYkIq1EqjdriGXntoo
 lWvmwzPhtDkOwavocTsY6PL+yaeqdcicVskNnql43Gzo8utpTzGWrByqc5Bf+iLrp+Et+plQ8g0
 dSBKWfs9CaelvBLztqUtcBe41RCIj27JofvsTD40c5o9x1pf6K2UNRmC5tHNd+KkBhZ7yIbG0ML
 aEYkECz4VQX85T8yQYDvEKO+YKO2pnsTV1rvgyrF7YNgp1Ie75sng8j/FZehl7lM/XwEs7b9QFf
 NoRgax9b8d2/6iQToFHm6D0fKTuGUwAJAaH+SmdUyM5wpSgzfEAC9KQ+
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Yutaro Shimizu from the Cyber Defense Institute discovered a bug in the
NVMe emulation that leaks contents of an uninitialized heap buffer if
subsystem and FDP emulation are enabled.

Cc: qemu-stable@nongnu.org
Reported-by: Yutaro Shimizu <shimizu@cyberdefense.jp>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c6d4f61a47f9..9f277b81d83c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4474,7 +4474,7 @@ static uint16_t nvme_io_mgmt_recv_ruhs(NvmeCtrl *n, NvmeRequest *req,
 
     nruhsd = ns->fdp.nphs * endgrp->fdp.nrg;
     trans_len = sizeof(NvmeRuhStatus) + nruhsd * sizeof(NvmeRuhStatusDescr);
-    buf = g_malloc(trans_len);
+    buf = g_malloc0(trans_len);
 
     trans_len = MIN(trans_len, len);
 
-- 
2.45.2


