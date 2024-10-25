Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B5CD0C5FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 10:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Huq-0005g2-GM; Fri, 25 Oct 2024 06:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t4Huo-0005fb-AN; Fri, 25 Oct 2024 06:51:34 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t4Hul-0004A9-A3; Fri, 25 Oct 2024 06:51:33 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 525F41380147;
 Fri, 25 Oct 2024 06:51:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 25 Oct 2024 06:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1729853487; x=
 1729939887; bh=K1HsLM0w0dLUOiVJq2rqs7rAKcCVgY8sabIVebI1pJ8=; b=M
 zFJS6urK89KnmQIBY3eb7FYo3qguvvb4UyLKaB6yxhXnW+iSH/R6c+qU2cyC2WUZ
 Hbt0CF9jgvA8fBctbCuYW8ubVBaYn+yLmDhOCbXHLX4Hp73uegvcFVUWSihcM/Aq
 4sIebQ5i0FhruN8RnzNzW4ickwHSf/v6Ajjjjv0GsZKOiZor5JdrEuUEdwCOZTgx
 YPvE2t5lt4a2E57/BNNXirNoOnbOND/EDhzwjTaPQFdM3+4y/JKLtNfi97GlMVOA
 giXqqyBanuUm5NuwLi5neHwfBXai22SzVM4EcqVhbuTewbgZx2rcv56cyKji2Rea
 d3vu+5PLfc/G1yWLdalzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1729853487; x=1729939887; bh=K1HsLM0w0dLUO
 iVJq2rqs7rAKcCVgY8sabIVebI1pJ8=; b=Gi8JaVaNjlPGJkedQTPtB2UWsU7Id
 cV0JDp6H/a0TpuhnZElDVZZ3Ssk1qnpxGV6QsM8K19kXPXL60if3nPlx5fDKSUXA
 EnkQAstQRtg7ExiXGeP4ttBT5NZG6EN+u/EoPW1hHNLgzz9IBs4xqoVMaLsYfm5v
 c4ft6JQUQ0HR0NE50EArCpiqieww1tuhuhH2YsL5DbXB+V6EjwgCuNnU5p0uwEfm
 axvf8qu5WTm/K8Wzeq90OqQBLfPmWE9tmoLTdtTB1GNn3HcimvbLB1H59EadkzXq
 UvTjQt11BKU86AMt/UqHFDLT1VDZ4oklAs/ErBxdBtErNNtQzheBd3ZLw==
X-ME-Sender: <xms:LngbZ7j2_3-CkFB6eTVjLAMvZ2t1LqXYl0m2o_LmnxCCBhWg7oyYwQ>
 <xme:LngbZ4B4O8F1MtMLYwj-12sC1I_sd9Fq1ysi2ocFHWuFDKWuBVpwUmcy36A9xBeTb
 YY6qh27wgne9cB57dk>
X-ME-Received: <xmr:LngbZ7Gm9cEFsCgO2XU52xKO14s7c6kaAMatTgzDRfPIlvNjqAzqYMGhVswPdID5Mk-NWP-W6M9Di9TNLfc-WDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpefgjedtvdelkeegudelkedttedtffevfefhgefhtdeu
 vdevuefhhfefuddvveffieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgv
 lhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpd
 hrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohep
 khgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjfihkohiirggtiihukh
 esghhmrghilhdrtghomhdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
 pdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehfohhs
 shesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonh
 hgnhhurdhorhhg
X-ME-Proxy: <xmx:LngbZ4RrareDQuV_JwJwpPOCzjGq7prxnBBkb8A9UroyMFPWF03LeQ>
 <xmx:LngbZ4wj3Iaz5Ue0wLMKPo7vzR7fpiN68wr57XKtbLL_sBi7WF56rQ>
 <xmx:LngbZ-6GoeFa9jxjlkDzd9T_KN7Il0heptplLwetZBLhbVC94OgWuA>
 <xmx:LngbZ9zYBWsC5na61E-1hFf9Y8z0Z49npDE4YLBvWKpzY4WWcFqrnQ>
 <xmx:L3gbZ3mdj0ocCDGLh4GHK8OwmtzkKjVGL5TezZgDT7-BAEyDtOvkwT65>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 06:51:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 25 Oct 2024 12:50:45 +0200
Subject: [PATCH] hw/nvme: fix handling of over-committed queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
X-B4-Tracking: v=1; b=H4sIAAR4G2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNT3czi4tJUXSNjCwvdpBQDE3MTC/M0c5NkJaCGgqLUtMwKsGHRsbW
 1ABgV8VNcAAAA
X-Change-ID: 20241025-issue-2388-bd047487f74c
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Waldemar Kozaczuk <jwkozaczuk@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3886; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=mCvhtCzEj6dSkBH8aSEomtZHCEU/6z19GmVHUHtKu1g=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2NiZUN4bmJyc2t6ekNCb3k3VWhoelZjZHpWClVXUmg4NzdTQm9HYWhEeE1K
 TXBUYllrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbkczZ3N
 BQW9KRUUzaHJ6RnRUdzNwSjRJSC9qSDBYMmxsSDdzN0hXNFlJV3dJWUlYMEJ4dTl3WW1MQ3BXWg
 pKSWN0VmtNSCswaGtnK3g5QkNoT05VZVM2aDJBeTZHdmpvcmhFejlhNU5pTmdzTXBhRkxjeitCc
 FI3QXU2UWQzCkZaSUNON0Rva0NVbzhmYjMwYUFGVkZ1SXJvSE91bGh0ZkNDS1BQcFVMUmpIVlVH
 aUdBV2RUNkttQzdORTRpUy8KRCtzbzBqdVZIRFdqWVZkbml2azZ1ZjI3WlJTVWI4R2lKTWxSREF
 ud3VpeUhxRUZ3dnZ6SzAwTHFjbHM2VklReApVcGtIeHRTWnNOREx6bzJEWWFHYTRjdmFZR0VrRG
 ZqRlA1dE9TZnRpalZ3eW92K3RCN21BZjhYNkdXR2YzL2tPClBpY1cyRzhjZElad0prWEF5SS9Db
 lh0RExBRmo4ZFd3MVFoSlRtcnRIaHdldUl1MnpXR3NuYVFPCj14MHJ2Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
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

If a host chooses to use the SQHD "hint" in the CQE to know if there is
room in the submission queue for additional commands, it may result in a
situation where there are not enough internal resources (struct
NvmeRequest) available to process the command. For a lack of a better
term, the host may "over-commit" the device (i.e., it may have more
inflight commands than the queue size).

For example, assume a queue with N entries. The host submits N commands
and all are picked up for processing, advancing the head and emptying
the queue. Regardless of which of these N commands complete first, the
SQHD field of that CQE will indicate to the host that the queue is
empty, which allows the host to issue N commands again. However, if the
device has not posted CQEs for all the previous commands yet, the device
will have less than N resources available to process the commands, so
queue processing is suspended.

And here lies an 11 year latent bug. In the absense of any additional
tail updates on the submission queue, we never schedule the processing
bottom-half again unless we observe a head update on an associated full
completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups
(in the absense of over-commit of course). Incidentially, that "kick all
associated SQs" mechanism can now be killed since we now just schedule
queue processing when we return a processing resource to a non-empty
submission queue, which happens to cover both edge cases.

So, apparently, no previous driver tested with hw/nvme has ever used
SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
shows up with the driver that actually does. I salute you.

Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f4e89203c1a6e3b051fd7185cbf01ec9bae9684a..b13585c4da911b9e8ae4a722761fd85dfa24be4d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
         QTAILQ_REMOVE(&cq->req_list, req, entry);
+
         nvme_inc_cq_tail(cq);
         nvme_sg_unmap(&req->sg);
+
+        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
+            qemu_bh_schedule(sq->bh);
+        }
+
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail != cq->head) {
@@ -7950,7 +7957,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         /* Completion queue doorbell write */
 
         uint16_t new_head = val & 0xffff;
-        int start_sqs;
         NvmeCQueue *cq;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
@@ -8001,18 +8007,10 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
 
-        start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
             stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
-        if (start_sqs) {
-            NvmeSQueue *sq;
-            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
-                qemu_bh_schedule(sq->bh);
-            }
-            qemu_bh_schedule(cq->bh);
-        }
 
         if (cq->tail == cq->head) {
             if (cq->irq_enabled) {

---
base-commit: e67b7aef7c7f67ecd0282e903e0daff806d5d680
change-id: 20241025-issue-2388-bd047487f74c

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


