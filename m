Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D70C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaFG-0001SN-HD; Thu, 27 Feb 2025 04:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEG-00088q-6G; Thu, 27 Feb 2025 04:30:55 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaED-0008J4-2O; Thu, 27 Feb 2025 04:30:51 -0500
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id D69F91382F86;
 Thu, 27 Feb 2025 04:30:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 04:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648643; x=
 1740735043; bh=Ytpy2MAeryNuZDqCBhYnozRv17jn2pwOzpfP3w683+c=; b=d
 iU+gVmAkwVTpWL8tdL/yfcxbuCTPaW0m2pqkhX7gsQBpJydl0+mJi57coeQA0lzn
 CsfnmEtaXm1qOEX66CrP/Fxtu/nenkRg4RwS6ugiRtDKSoNh5cJFp12vZ+sEkbJu
 yaZ0HhZutKeJH3cfaoJ+kAgQQvTzKInRpzSPhTDErtjWKZwPGfx3Egux7ySBo6EF
 T0mySm/TNvAb/1QpBhQB3n6fX8di85ADO0yGsNNVYY4ZvijxjYOko5IvWC9mOD2H
 0zbzLpcocJEK0Z6GL1epjlzrNnMfgoearrOCe35TUbqqZIDtiZ9txpC/cRrZJb8Z
 /X0mImcXHmi4ZPHQfzx+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648643; x=1740735043; bh=Y
 tpy2MAeryNuZDqCBhYnozRv17jn2pwOzpfP3w683+c=; b=qqI1g/YwdEj3/3Thr
 k48kCzxmG7HGb+KgkPmvwXFKQad58yIpLKKeqWntqCBPEycevHnGOzsJbppf8hZX
 V8XK4vzrSPjJVTjjlRZmiiiqRx3mvIOFmMDvpldBOnqeD9RRH7n51QmQkSbV+jcI
 IgyPE0w8w5/GlE8YIaoGvOX7PdavnD9Jj6k4GXx7LPexRpqRvedK1MAwUYpDVAtv
 O2B8EhSVmLbRU4RZlu+Uzpi25OSKiZctWUSMGpqt3DQ61WQo5VSq3e4G8KhzbvlF
 SQmrByzVd8hWr54ssD4xXnSvYPtX5txaJoie+2GkugOhXci34H5ogKIcD1y2Np6F
 Q2yzQ==
X-ME-Sender: <xms:wzDAZ3rD9aG8smKqk6pnGkZQV_-aRsMO9mVJpm2Od8A-wHqHJ_GCHg>
 <xme:wzDAZxrzsQv7hwyrSrRAHouXGTqgKfN9bv_bR5Y_LCtMMn6JH8pocN1YLGJ-ou-rU
 Y1dQ1odBr_H0TvOBE8>
X-ME-Received: <xmr:wzDAZ0M2hnrcDr-VZY3JtOkBfw-Zz1-Dat13hQF0nH5voEXbRdKQkJZuxDDkjPo66_KInuJonMO-FpLf-e5bwT4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:wzDAZ664jCQlh7FS805SoilypiRKchacUWD5OsILu--6U5r3_YkQBQ>
 <xmx:wzDAZ266gl4zhfmJKFQ4S-fo77_LWBuaUTrc_8xxzJp6lPqdGY7yPw>
 <xmx:wzDAZyjRdnNP0SUQPrBXlY9isLim68IXLt49OyJWJ1ye5LbRwEh3RQ>
 <xmx:wzDAZ46P_txz-0DnQbevaVXICTmETDemncd7YrfhD6foXSL3Egskxg>
 <xmx:wzDAZ2yPxQw7FPqyWqxA0o9H9dMhxpByZZJceBkGk48rfWKDvg41dcwY>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:41 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 09/10] hw/nvme: set error status code explicitly for misc
 commands
Date: Thu, 27 Feb 2025 10:30:16 +0100
Message-ID: <20250227093018.11262-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

The nvme_aio_err() does not handle Verify, Compare, Copy and other misc
commands and defaults to setting the error status code to Internal
Device Error. For some of these commands, we know better, so set it
explicitly.

For the commands using the nvme_misc_cb() callback (Copy, Flush, ...),
if no status code has explicitly been set by the lower handlers, default
to Internal Device Error as previously.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 28 ++++++++++++++++++++++------
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 07cd63298526..b7222fd9ac02 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1771,7 +1771,6 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_READ:
         status = NVME_UNRECOVERED_READ;
         break;
-    case NVME_CMD_FLUSH:
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_ZONE_APPEND:
@@ -2157,11 +2156,16 @@ static inline bool nvme_is_write(NvmeRequest *req)
 static void nvme_misc_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
+    uint16_t cid = nvme_cid(req);
 
-    trace_pci_nvme_misc_cb(nvme_cid(req));
+    trace_pci_nvme_misc_cb(cid);
 
     if (ret) {
-        nvme_aio_err(req, ret);
+        if (!req->status) {
+            req->status = NVME_INTERNAL_DEV_ERROR;
+        }
+
+        trace_pci_nvme_err_aio(cid, strerror(-ret), req->status);
     }
 
     nvme_enqueue_req_completion(nvme_cq(req), req);
@@ -2264,7 +2268,10 @@ static void nvme_verify_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2363,7 +2370,10 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2445,7 +2455,10 @@ static void nvme_compare_data_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2924,6 +2937,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        req->status = NVME_WRITE_FAULT;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
@@ -2988,6 +3002,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        req->status = NVME_UNRECOVERED_READ;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
@@ -3510,6 +3525,7 @@ static void nvme_flush_ns_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        iocb->req->status = NVME_WRITE_FAULT;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 366739f79edf..358e516e38b0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -906,6 +906,7 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_INVALID_PRP_OFFSET     = 0x0013,
+    NVME_COMMAND_INTERRUPTED    = 0x0021,
     NVME_FDP_DISABLED           = 0x0029,
     NVME_INVALID_PHID_LIST      = 0x002a,
     NVME_LBA_RANGE              = 0x0080,
-- 
2.47.2


