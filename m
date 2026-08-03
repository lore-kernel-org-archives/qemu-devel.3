Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEA4C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr1PD-0005Iy-C6; Mon, 03 Aug 2026 18:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1PB-0005Dm-8Z; Mon, 03 Aug 2026 18:45:09 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1P9-00057b-7W; Mon, 03 Aug 2026 18:45:09 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 1EB81EC00F8;
 Mon,  3 Aug 2026 18:45:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 18:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785797106; x=
 1785883506; bh=tswvNfYH4AJpc79MQDqgtGTxdPbU+FUqD4Y4hrIGJL4=; b=l
 YYx0wbNMTJWIqtMJwNy1MMwgv2GKz3VVOC5aH/QBnyilIrkqlrUvZVjXyLzq+ErW
 UmA2YTOT+RTU9nhLumhKDICpWfuPRKiU8UGyCs1pYgW4yx4fdXZCMEmgHSry9g8f
 gNdefImoHN3MGTqdUHNZbGBXKCrahqYN4THRCczBJJElOmaQPVu6sc/pHCRxTWPm
 qUyV5ZNFAm3MyFvQBiYdtILnEigT6dsJq32VIrSUk1sIVuPG+V4bQaFgTW70pUfG
 cisnFI+ckurYatZKhh106CHd6nKOyODvO9rnZL6mPNjveg8lhuZjB0KxO6CLzmy8
 RsYO3txjHQ6s3xCqgEonA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785797106; x=1785883506; bh=t
 swvNfYH4AJpc79MQDqgtGTxdPbU+FUqD4Y4hrIGJL4=; b=GMq+B4/kZ2RIGrtek
 WKa4IsF098dxSwnej440x99yetDZJmRW9lAOs0YWZqffAwupgiIoKQIaUn8OGCwZ
 zVaAB3bCRm/wLuDg9lSP8vLHGcztrX3F63+knQ+eDOczh48CcJNwN4t0QnWTUIce
 w6+89xbuAOK/7jL5Fom8Q0toHqAOZRdUF9FZgMRlZgOnOsS55LxAKCTyeFeiAJCF
 j2uyGR/7D9Nq7L1MPN/tnmr3WTwM1jikEmnIHny6emmvz/ddFgpG/+Ol8rrpK9AO
 ClGaHcdWjei8N5ccmmjmmXWzKafZ0qsOyUWs8ImP7YMwvN0Qnhw49UbAPVvzhuAu
 3IQMg==
X-ME-Sender: <xms:8hlxasVUamhLuRXzDKtaYryrVkJx_cVFzKIifMSjBB-329oSnyQilQ>
 <xme:8hlxahDMrApdVUEEfTl7qv5D_YIse8QxQC5-GfYNiyg6P7JESYT6huuMFBOSWWilg
 DFVrcl11MpLylk0eUM5h2T32jGMp19kXDDB6wtN3BqMXZ5qL-1HL5Y>
X-ME-Received: <xmr:8hlxahE_sJINjgNhTH0LqcRW2GhxZwMSHiJgWBhE-wxsbGpV0tbu9NLXH1gjrY_CtrvjyuPJDJl0MHcltRE4GWrVhL1Qj7VFof1NjRFtjo9SGg>
X-ME-Proxy-Cause: dmFkZTFtqVo6kF7gYj7UH29WRVRgnHsa7j0SPqjL6nyeOfplmNT/oInijOEL4gWZBU35KZ
 jNX/Hnnpa35lzSHSRuXuiR5/snxpi+qMrooSjWr3bYdtlh7Gaw2Uwpm5PcVs8lI/E/bgXU
 Wi4CKrXL9QDJBC5DeUYID3tGKXnBSi4DDno05kypn/P0z890IYpJstjUn2OBGmUx7dqFgQ
 R/HPPULFJC8odpjYvicCQSMuGH5a/A6XYvWSlk3f1tJSPi1u1+69IxnXIhts38fZYE6R/q
 36A+hKxCkaEl1KlFs/ftxXbbOERXSMsfg4hXj3xCjKssQgU4qslE9xgGpwIjoBvt0HjZds
 sxWZBOtE03IqUQpaolaJaMTskwW7a6SgHws+R/r8Kzf4yqi29VM4cDk0zrDPizk2/h4oeR
 JtdKIT5GFmq2xgx5UgqDnU+FkUTZsm9Ra2XgspXTJBtx1Z72uFLYRzYs63DMmDztAwjYDp
 Tu+1i8qWjig4sWAE3ob5IlOeqO2eg6m7ybqleysffaI7llcShM+MH2MkgSaahavR+VHyrn
 WL9sccUy/MfXTd2r1RKXmkRCK3bEyjpvC+0PXGkBr7cMEptqJV7rsXKoeNpquokGoQU8b1
 buAiiqQRD7qAjcnRiuNPFiwcr92wHaPZkJtGOayO6fSo65fm5xBlApyaZ3tA
X-ME-Proxy: <xmx:8hlxai4HLCcaU3XZgNoLVm3JJ-yBR_PEECefHTgBVex9b7WgUo7_vw>
 <xmx:8hlxanmbQDJcKQ_YL7XSFzIIqLqBaSiFHmBXSPWKHeg8Ezc4GZbHTQ>
 <xmx:8hlxat7pMeN4SxI7qGFy2tyCDE0wnxqv9Crk2yYvSS-LE2J5yVQKRQ>
 <xmx:8hlxaoTfIw1mgFjc0HvbFxllxdq2mr35uPHLcBQs6c4CSW7UUpDoXw>
 <xmx:8hlxarjOi3NpmNZiqGqBdGFrQln-364rj83qTG39gKY3S5oIAF7OrNyg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 18:45:00 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>, qemu-stable@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 3/4] hw/nvme: cancel inflight requests on controller reset
Date: Mon,  3 Aug 2026 15:44:34 -0700
Message-ID: <20260803224436.38768-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803224436.38768-1-its@irrelevant.dk>
References: <20260803224436.38768-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
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

nvme_ctrl_reset() freed every SQ/CQ right after nvme_ns_drain(), which
only waits out requests on a per-namespace BlockBackend. That is safe
as long as the guest first tore down I/O queues gracefully (Delete
I/O SQ/CQ), since nvme_del_sq() already cancels and waits for
anything left on a queue before freeing it.

A reset that happens without that graceful sequence first (e.g. an
abrupt/asynchronous controller reset) can still have commands
inflight on blk_aio_*. Freeing sq/cq before those complete leaves
their completion callbacks (nvme_rw_cb() and friends) to run against
already-freed NvmeRequest/NvmeSQueue/NvmeCQueue memory via
nvme_enqueue_req_completion(), causing a use-after-free/segfault.

Run nvme_sq_cancel_inflight() over every queue in nvme_ctrl_reset()
before the free loops, so no in-flight blk_aio_* callback can fire
after sq/cq memory is freed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3398
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3883
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4068
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4072
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e355c256a561..8461b6fbdeae 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8040,6 +8040,18 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
+    /*
+     * Cancel and wait out every inflight command on every queue first. A
+     * reset is not required to be preceded by the guest's graceful
+     * Delete I/O SQ/CQ sequence, so sq/cq must not be freed below while a
+     * blk_aio_* completion for them could still be in flight.
+     */
+    for (i = 0; i < n->num_queues; i++) {
+        if (n->sq[i] != NULL) {
+            nvme_sq_cancel_inflight(n->sq[i], NVME_CMD_ABORT_SQ_DEL);
+        }
+    }
+
     for (i = 0; i < n->num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
-- 
2.53.0


