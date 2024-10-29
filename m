Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A0D2AB33
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l8I-0004Hs-4o; Tue, 29 Oct 2024 08:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5l8E-0004HE-6D; Tue, 29 Oct 2024 08:15:30 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5l8B-0007tU-Ms; Tue, 29 Oct 2024 08:15:29 -0400
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 492A61380196;
 Tue, 29 Oct 2024 08:15:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 29 Oct 2024 08:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1730204124; x=
 1730290524; bh=QXVZ9+iSSJqIuyrzT1vd2HxKUeG5sPiQ55Pkc9oEttQ=; b=Q
 bFSHdWE8+tDmYiPKmLGA7owchLf+yTnjzUis/GrN0/wM4pg99YlhK2DXmr1LDQ34
 JJQjhFTt5HT3+v5FORGaGh/z5K+o901Npz3+4YogtHs0hY7+eUGN25TXFnrLkVDO
 geq8Zq4Ki8LMmxHca1PxWjmlFfbsf9A7JcYuTEPa/D1X0L0KZhfFb71nL1jBnICO
 rQllIMQ4nikKb2zDcXN3s+FxicnB/55u+Y4b1KUvWQKfm6uD9FAPgoneygSOS2US
 9NqH63mrN6AjvIOoXym94i+GooBIuB9lrdh4rIzUTQlIsSTrud3Y9NHPyyXlUBxw
 kPOpiGtZ89MM05ftVAC1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1730204124; x=1730290524; bh=QXVZ9+iSSJqIuyrzT1vd2HxKUeG5
 sPiQ55Pkc9oEttQ=; b=lZFa7Fo4aMixTZy49DzduRuEtzvs+Mw0cMwtVp3LKemt
 5i+8u4PWCMyE5rpFhSeDTPqVrRb3tiOasFq6W+q33tg1P2B8q/PkASz9xqlL1GWq
 kQWNUZ/516rl1APIJW6zFdK8EHSG4zPJ1U2/hGuhb0b5jv1yzhVgV6dL5pXMBUTZ
 NwuhPoZKAz4Z6aEkcJSaiSAXW97a9R2lw8VdPUcl/Y1hF9hhskrwsPpzFu5kIwjb
 fuwoYFHsmdVXzWqd/32uU9pbM6053fNP+m2PZltYgfvaXuyUrHthhjmE+fTyhjjP
 /GdJB10e78KTu10TPKfRfop8Rry4FRcqgT9fVRA53Q==
X-ME-Sender: <xms:29EgZxgYa6B1KB_APGpUs6-5SkQkZZISCnnPPSQV0c-cgATgGgFbGw>
 <xme:29EgZ2DuVNPH7gC8hHY4An_M7E93bEVCCC-gPH-ozZjdIo255qWzhAPVUFZVWwFeY
 rXMYNr42zipN5rki7M>
X-ME-Received: <xmr:29EgZxEXNEFhX3lOXxEnCQ724IDu1H6naZYd9zRDYpaDZgRsdJ9_evj7KrC7a80cmyKaRjxnpgYy8KZKFXAudg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpedtueejtefhuddvieegieekfeevkedtudeglefgvdfg
 udejtdeuvdevgfdvleelleenucffohhmrghinhepghhithhlrggsrdgtohhmpdhkvghrnh
 gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeekpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtth
 hopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhifkhho
 iigrtgiiuhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnh
 gvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphht
 thhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuh
 dqshhtrggslhgvsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:29EgZ2SEdtZ19VE9TI7TZeTOzmD9HeearoLp8Dm6GTtfFsbOLVMKyQ>
 <xmx:29EgZ-z628t7tdXmFXkpXnW1rjk8ldGPbBYZKBE1fl1-im9vXcb1Ig>
 <xmx:29EgZ856kOqYXW6uObSzy2OQAnRnFULq3wgJzELeWYmtvffbNvL2ug>
 <xmx:29EgZzzvXvpezzeh5OqQwAylAuDQ7ZRCtKvwO7uAw888ttF7Qo9Rnw>
 <xmx:3NEgZ9nlygHi2x_ycYd8F4MLw3IJ_wU2QqYvytIoCPod5au9hE-Lgp-4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 08:15:21 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 29 Oct 2024 13:15:19 +0100
Subject: [PATCH v2] hw/nvme: fix handling of over-committed queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
X-B4-Tracking: v=1; b=H4sIANbRIGcC/22MQQ7CIBBFr9LMWgwFFOKq9zBdVDptZ1EwjCWah
 ruLXZu/ej95bwfGRMhwa3ZImIkphgrq1IBfhjCjoLEyKKlMK9VFEPOGQmnnxGOUxhpnJ2s8VOG
 ZcKL3Ebv3lRfiV0yfo53b3/s3k1tRd7XSohy1NqrjYeUtzGcfV+hLKV9n/UVspgAAAA==
X-Change-ID: 20241025-issue-2388-bd047487f74c
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Waldemar Kozaczuk <jwkozaczuk@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4434; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=80jYSiOHEqbS9sgBGXVuHcMzJ34R1Fr2MrnmMdGDnnI=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2NnMGRtUFZVOVIzV2Ziclk2b1lzTGYrR2NGCnJ1RmdHNTlnMzN5OCtXd2or
 UmhQam9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbklOSFp
 BQW9KRUUzaHJ6RnRUdzNwSXp3SC8wVTUrSEpUbjk5ZXorSks5V3ZYMXJ0QVFibkNLYmRaZ1Y4NA
 pLRytaSFVYdi9tczY4YWx0WXU4dHZMUmwvKzh2aG9hQmh1V0N5clROTlpjbVRPN250QkxmQ2prZ
 lhNbWZram9YCmtyNTNCWEk5Z1RlY2J3VFM4VlBYWkxmQzNBV2QwekhJK0orM3dDZDY0WlpPVkJG
 V3hTU2lGdE5EZUFKZzR3TXkKWTAyRTZHOUJ0aDdJMnNpUUgwNUcvTDhWdEJFRURlYVZLeGFPNG9
 NVjV6QVBiRUxsOVBsY09wR2ZaNE1mb2J1UQphWWdNNWphT2t6YnJXSDFxZFFUYXU3MXRaUTRtTE
 pHRm1ndDlHS3RVYjVuaGxTTURIdXNFOUpKWEhzcWM3ZkttCjBGOTlvUm5USS9MQW5wdVBDQ3p3L
 2dGYnVVdjgyOWs5NnpIOGFRd0tNa20xU1k5VW9WSXhTS3VOCj10SHliCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
submission queue, which happens to cover both edge cases. However, we
must retain kicking the CQ if it was previously full.

So, apparently, no previous driver tested with hw/nvme has ever used
SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
shows up with the driver that actually does. I salute you.

Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- Retain cq kick on previously full queue
- Link to v1: https://lore.kernel.org/r/20241025-issue-2388-v1-1-16707e0d3342@samsung.com
---
 hw/nvme/ctrl.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f4e89203c1a6e3b051fd7185cbf01ec9bae9684a..1185455a94c4af43a39708b1b97dba9624fc7ad3 100644
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
@@ -8001,19 +8007,16 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
 
-        start_sqs = nvme_cq_full(cq) ? 1 : 0;
-        cq->head = new_head;
-        if (!qid && n->dbbuf_enabled) {
-            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
-        }
-        if (start_sqs) {
-            NvmeSQueue *sq;
-            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
-                qemu_bh_schedule(sq->bh);
-            }
+        /* scheduled deferred cqe posting if queue was previously full */
+        if (nvme_cq_full(cq)) {
             qemu_bh_schedule(cq->bh);
         }
 
+        cq->head = new_head;
+        if (!qid && n->dbbuf_enabled) {
+            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
+        }
+
         if (cq->tail == cq->head) {
             if (cq->irq_enabled) {
                 n->cq_pending--;

---
base-commit: fdf250e5a37830615e324017cb3a503e84b3712c
change-id: 20241025-issue-2388-bd047487f74c

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


