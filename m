Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8431EC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr1P0-00057N-EJ; Mon, 03 Aug 2026 18:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1Oz-000570-CQ; Mon, 03 Aug 2026 18:44:57 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1Oy-00056Q-2R; Mon, 03 Aug 2026 18:44:57 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AD1BB1400144;
 Mon,  3 Aug 2026 18:44:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 18:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785797094; x=
 1785883494; bh=pK99277ZRIB+F3LySItCEjYQAHjcaVfqLnt6i3fHIM0=; b=H
 CCw9G4ubb+BvQGn8OS5Bj0/qEaUkvZqLKcgqiLTdh3wYNNSEEQQjATgHJmUmyhus
 IwQ7Avzj5u/M/q2Or2laD6EqDMTzrCl0Ds4ef58jydFeGBmigzQ0Nw2oSteb47/o
 MiLfssTkt+vNg672ZMD/I6ZzSqRhLkXIBNzYZ5GwFjPBnOwdWDg8RHUS7f4Tnqsr
 DBwYszcJdMKmZe0DpaSdcB6AThkPTXUGAur+riHG550DfL6zi8JPrlZQifmb6D2M
 jCgqTDaT3hi/LcG5A7+Uw6I1pGnpckKhOcj8Y7XQU6z9WN6VlLN/Ie29o59nNjdl
 ZtmluyHjlIlefQMizObHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785797094; x=1785883494; bh=p
 K99277ZRIB+F3LySItCEjYQAHjcaVfqLnt6i3fHIM0=; b=itOVSJRSGIoksn2Ad
 FawTHAe07TSC8018TJDkUc5/p5kLOhS3elspYM3KrbU73FQdrzCh2iOyXgSoFSfX
 X8IjonJtc18TEBzenZTHXeJuKsqaEtS3wUp30TnqpqgW2EQFoWMQmQ3mZsaloKCJ
 MkwgotbMj0fp/HEjF5768sem2nYVVMTMFkW+lJqXGaSKBf+FBHcROYSy0WdIpU0z
 Hj5KWi3x/hyELUQdUcAnRvLvBp4hw42bCNBqqejLCOdhMKy24bAEMQhPyfM20L4J
 NykkUpdah0b5KV3g/Jv6HI5ecYFLQNKulT5UwqZekMv2JRDtvxLjiNMnuLnx7Uzp
 AXkuA==
X-ME-Sender: <xms:5hlxalKoN1wcqqPgJkt663lLYeuS85fw6eTV7h3sbqZsWbyjQ_nDRg>
 <xme:5hlxahkNJp5LqzZ1Y1qZrC-rHgUW6-sYUQfPKIKrwIadGwIBwGsgJcCwTe4529KE6
 DhRVwgoSW7n0Bw5oXWHOR1RIJq0C1QOqua2squxm7NbYoePH8siX25j>
X-ME-Received: <xmr:5hlxauYFCxCCnRl9UjnUyBlyhYsg8l0ZEXNkT5PQsmZ7cbgzoE2ilbhOIlvClRz4i7hPOJVgwHGQ2uuzviuzq7ZQjx-3Sr3Ke_Sn_eAIjzA13w>
X-ME-Proxy-Cause: dmFkZTFeYi8b03TbMhsFw7/oxx/QrEVsMwlPi+oaba5QCP69t8QrgketamvRj8WkFvrAR+
 DZnowf3ijlnjgkMrNhPwzyJf+CeU/gVrhoMStZ3AeNquyEbKN1pd8OaBik9dfnStlbPiGl
 bEzo4w3pwxmzoCU4GhOSut/DC3EUTMVoH4IhsBWVontBvwLinUs91fRMicF74mGHxFXg/d
 mzyD6vlH4ENWopYcfYB78XmcHQfQKeIdVMRV9ecSdz4hwu1DEpIgZ2VL4UqdEJth9+GSKg
 Q8GcssenJ51ghx5TAvOH20mB8nWpuYquKBpGUyPGkY3sm6c/PGBw0dMerxRoJLHCL9qQR8
 uFJiqkNV/slhRzr9VIXU67SY45fACjGaOFKyzLm+smphc3/sDjTnohfqYPg9tmGaJtex5N
 5XV85Hp1uSi3Yu4AbY1DSeZQHMUEy9t1zTNVJGMQsskU+Dv2j999bztw7HgnlK3QTXmpiN
 41YBXadN++OXJ4vtKBFzasUadxWSNOd/QiIfsoqkirTjfHccz4igmgCBNmEX8cAXe32WDO
 Y3MjhX51BM1APG+6wGAayptHIrxQxVy3RtoilBKQXO8HoalfCgjd1nVU49l4Xy7+mM2vfw
 mU9UZDF5jlCTiLyrDYfe3Yihpk79i6Y1MeB8FsGwj65wG0Gj+ZVFbXDAgQjQ
X-ME-Proxy: <xmx:5hlxat8N0hc0madhrI9roVLahnLsEorVWw5rVF0Ycd4o7MsrzuoUQA>
 <xmx:5hlxatZ6IHyG8t528frhvN4WoGTYJUE087_krCNo9AJtV3ktw59OKg>
 <xmx:5hlxaneS7QkbbBzs-o7kxeaJ0b4xhCvcpktYLccEKt062m_OEVWS8w>
 <xmx:5hlxaqkekD9o7xLk1LLSIdoKtIKJiUnEuzTOd4X4CKo6cFIC7_ftDg>
 <xmx:5hlxag1eVB1ZA3IGHHoZC18GbMFILjOeMIDDEpxbMlWK4OxAy4fCyrQb>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 18:44:48 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>, qemu-stable@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 1/4] hw/nvme: drop AER requests without aiocb in nvme_del_sq()
Date: Mon,  3 Aug 2026 15:44:32 -0700
Message-ID: <20260803224436.38768-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803224436.38768-1-its@irrelevant.dk>
References: <20260803224436.38768-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

nvme_del_sq() asserted r->aiocb was always set when canceling a
queue's inflight requests. A pending Async Event Request has no
aiocb (nvme_aer() parks it without issuing any block I/O), so
deleting a queue with an outstanding AER trips the assert instead of
just dropping the request.

Cc: qemu-stable@nongnu.org
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index bd6ad64b2000..e3eadf3d1dd0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4862,12 +4862,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
         r->status = NVME_CMD_ABORT_SQ_DEL;
-        blk_aio_cancel(r->aiocb);
-    }
 
-    assert(QTAILQ_EMPTY(&sq->out_req_list));
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.53.0


