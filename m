Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE524D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCynT-0005Xp-3u; Mon, 18 Nov 2024 05:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymm-0005LQ-GE; Mon, 18 Nov 2024 05:15:12 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymk-0008Jf-OC; Mon, 18 Nov 2024 05:15:12 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F0DE32540169;
 Mon, 18 Nov 2024 05:15:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 18 Nov 2024 05:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1731924908; x=1732011308; bh=wn0FDtj1v/m1iBQtnIW92oDW3NoKo76q
 4MrOju+Mbr0=; b=JzQ9NbbT8OW0x+wdQFqnyESdyyVXe6iR+fp7HVhbHxdtw8ar
 8/97tqEq+xqEHn2/Pn/9TmiWuvAo74fEu7MiFjEj004D/MiIhEfM6HHLFzhLTVyP
 dX87Mf7HkHNcmoHRZ5Qq7Xsy6vrJ2GnA49/xnG2LLbgDWTkBOOpnwX9htEA4zPzq
 P2z+lg6uS7vSzspYQtQUEtTPTSE/3J3rnu/TeskfWM36hKyKr3NMzOsYfn1VIUHw
 jQrenlr5IOec1P3jVgyChrIoFthU26RKAFIAB7d00yuZL9p88H8bB3gt/CHuVmJW
 nruOb/xSMvbsHXTGbMVzqojmIACoI8qINv6ljw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731924908; x=
 1732011308; bh=wn0FDtj1v/m1iBQtnIW92oDW3NoKo76q4MrOju+Mbr0=; b=c
 HsS0V70ytWvozQpu8jobdBhl2fvPs6OZgrmALwP4OZC9N39OapauRoiNi77ZyABk
 2rwRMWjTfX4s18hk6K2MiRMvlg8lVycRQFBH0xgbDY9ZvlHB3+YyzQ2v8fAMDvvd
 V8LQ/DyS0gZK285NRU2m/qIdT7zhgAurJsws/rhaZo6l9FA3OnLJI01lOt6/BqDW
 UEZwT3cwNOumCR9j7xs/LFRdsnfQekguvQdR+KrBABJ5ptlm3oH7tf2nM4BSIZI4
 biC2LwrN5Hc8AyV3ZEZkU1tjJ/wXXb5sJ1pzjAPltrkA7dhTPm4QJDTJNB727Nyw
 D9lptUfR8Nvp4fn+y+HPA==
X-ME-Sender: <xms:rBM7ZxcWH90p-avHRgC0c54S4k_qGjcOii8naj3c9h8cRZDjXFkX1g>
 <xme:rBM7Z_MtP6vxw3WNlRznvAZ7qhvXbgeZdPKOawIvDt_dJTzEwAN4zHswAgHqw6WPx
 uWr4vSPuvKHaWVrZRw>
X-ME-Received: <xmr:rBM7Z6g6k7rhContl5v0vsEUk3OIR_mph1WaqINYvg2uBz5zjvQCzGPzSPrwQpHC5MxtVyhpRp1ufiO2m73euA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphht
 thhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuh
 hstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:rBM7Z69VJr-xdZvS0TBUtxAxX85BoPeUxzgyBWurbqWX4_KLQYkNqw>
 <xmx:rBM7Z9t55c-Ye1r4vTbwV1FDvfTtGDIAzi0DZPplZnoBeUNwK9v1sg>
 <xmx:rBM7Z5FA-nDBlLvdAThH4Iue7rr9xTzfDXxYWvwUOQWBwIwybxTD0w>
 <xmx:rBM7Z0NV2aZSWtdTtp72VKXXzXoXm7G-yqQ49gkb6W3NpwjWsrkdTg>
 <xmx:rBM7Zxgv6rB3mGiRA2nERHl2N4rlQCfm_i6qp4Ru592Zwl9iyhZvZ7yk>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:15:07 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 18 Nov 2024 11:14:18 +0100
Subject: [PATCH for-9.2 2/4] hw/nvme: fix use/unuse of msix vectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-nvme-fixes-v1-2-02d107dbdcc0@samsung.com>
References: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
In-Reply-To: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=On2tnR5FtbLyphu7V88G7B3jZ5QwBKDAjv+OiR4JC0E=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2M3RTZYZnhubUJhUnBIU0lmVEZIa3VnSGd6CmRFQzFQendibXBWdGc1OHBa
 cjcxVzRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbk94T2x
 BQW9KRUUzaHJ6RnRUdzNwQi9jSUFKYWdoUEFyb3FCRllyc3Qwb0d2SVpWakowUWR4S2RxdVZtVw
 pHZ1BJOXFpMmNHd1YwT2FqNXRRcitKUEJrMHJLM0pZQkhqNVVMR3NtVUlRUHdxMkVqd2w1b3VMR
 XNJbi9FVDZwCkNhVGtsTHRtd1lDenVob3YzNDZuQTVtOE9lZU9EUnZtMlBqZGxIMlR4Smh4RWph
 cU9meUlyTkx3NDBMdzB0YzgKTEpESTlJbFJLYmVQYXprY3NRdUl0N0VJeTBzWkgzdTYwUTN1czh
 TaE0wcjR3OWNhdW5EQ1ZYb0VTc2pJdmVUTApLSUY0T1Jqdi9xTVE0OU8yVHdab1c0S0NTbVh1QT
 lEbTZXNEtDb01EOEY1V1N2LzE0YlR3blo0bGN2K2RnTlYxClkxRnZ2SHRYdWs1NTJTNVNaSWx6S
 TdQTkNDTGNrVzlOYmxUeFFRN21tTmVWVEpoQkhyT0FSS3daCj12SFp6Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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

Only call msix_{un,}use_vector() when interrupts are actually enabled
for a completion queue.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 13898d58278ed2155d45a9120fc07ea60bc64a32..a38f460a78599bc191c17a2a376e865a74744e58 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5423,7 +5423,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
         event_notifier_set_handler(&cq->notifier, NULL);
         event_notifier_cleanup(&cq->notifier);
     }
-    if (msix_enabled(pci)) {
+    if (msix_enabled(pci) && cq->irq_enabled) {
         msix_vector_unuse(pci, cq->vector);
     }
     if (cq->cqid) {
@@ -5464,9 +5464,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
 {
     PCIDevice *pci = PCI_DEVICE(n);
 
-    if (msix_enabled(pci)) {
+    if (msix_enabled(pci) && irq_enabled) {
         msix_vector_use(pci, vector);
     }
+
     cq->ctrl = n;
     cq->cqid = cqid;
     cq->size = size;

-- 
2.45.2


