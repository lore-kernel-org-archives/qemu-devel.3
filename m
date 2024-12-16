Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8DCE77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcL-0006zW-Bm; Mon, 16 Dec 2024 07:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbw-0006d9-QB; Mon, 16 Dec 2024 07:54:10 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbu-0004s4-M9; Mon, 16 Dec 2024 07:54:08 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8757B254015A;
 Mon, 16 Dec 2024 07:54:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 16 Dec 2024 07:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353645; x=1734440045; bh=7VYhBCDI5Xi9dHyV4nyGNN4Y0oYF0wnx
 7wNTd3egdec=; b=a5aIyNZiy+H5VgXzFsa/5l+jMIQetDUX9XKOoZuWSrqEVwF9
 qJaTAevPdJYU8A9LMK4Qajf6xSPyN+PYNU+sn4fW0Bki01QVo8xIEY0C0r/qavbr
 t7RxQageAthAn2PraxXJNTykPTby/KQAEQjPlqcLRsE2mc7ad+SWcJF8P1g9Fg8k
 JGM9UfDyPTn/OeqxYBIC/m0WOLHKUmGleZBXV9qy30DdBTQm6kpaFepe4JNrRKMI
 g3D5ew1RYOH4p6Xy7ahfmCpUNXjguo7iylKsDuSVU9ZHa/f31kHewOkCF1YMKzJB
 UYRSh2iDbNkbCs7PqGU+oyJ/QBfsPr7Nqu4ScA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353645; x=
 1734440045; bh=7VYhBCDI5Xi9dHyV4nyGNN4Y0oYF0wnx7wNTd3egdec=; b=C
 DgDeoqb7g/2kRJ50g0wNgKPkMN3VFfHlBlNexpUNmi3yceed8VriIhQs8UCK6Z+Z
 urQ5+7NnT/TOPGxiwA2kEXZKLrrnkL4bPJlKJFD42Su1PIZH+eBbLhYNj4vXz95e
 +4WIHKRn82y9geK3s9SthkLdVy2paxVPXQ6tETbxFTE2cfgx1/VNCq/rgnJofuXe
 veo/4yCNfYzaQnf2cHP+8N3yXLBuCCJBoZlr0AqPYrcJhGVktANgupVgNDvtR/rX
 II/Vor2SWl5bSy2x8BXYhD3bK6HxHU07axg2rMbut1C/0tJBt5pklxbbVA3+m+x6
 GKhsKI9RpQpWm7ZeLqhJg==
X-ME-Sender: <xms:7SJgZ1IPTZUqwKYGY1alSVppFySc5uU96cag4z_98RT3LAJ2lh-DLQ>
 <xme:7SJgZxJOIVG6aIzzcM5CpyeKABGUk6LEpCys3FJD91fhp26O0TQyGclAqGFFGyq8a
 imtRP-vTF9Fkjv573E>
X-ME-Received: <xmr:7SJgZ9vBSgP-32s2py9EwHyzWnpFjhniORNbTR-NjrPfcsxMYPBSOJtwQoGCLmK75BqYMeBRUMdlglAIQWFFDG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdegiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:7SJgZ2a4xnVWhs8tzPDxITBXqM1CR0tLGqEbPlzfrZis2CZ7SNVYZA>
 <xmx:7SJgZ8brk10-6JAdqN1Cjeo8MAJESoeiSnaSgYRkeSsV-cuaU4KKig>
 <xmx:7SJgZ6DjPU0CStEQ3TxAQcKa7VaTWsWnkT8LpD7XnOPhB7hh8L1sYg>
 <xmx:7SJgZ6Y8-YcETPZvaUi1RaL4t68GuHK4MVLdzyy-1iEeTAi32rnOsQ>
 <xmx:7SJgZxPtRN-Jy--f5v01rLdeGKUGLEsNsq6M9Ug09d29ODbjnTAGP7un>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:54:04 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:09 +0100
Subject: [PATCH 8/9] hw/nvme: set error status code explicitly for misc
 commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-8-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=hxOM4hD4Xb6bWY7Wjdk928pX9fL0ZwzmOu8los/ey2w=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXR1OG11bUNIWmcxREtscmZNejZGbXZlCkhRZ1E4YmtNTWVjbjErV29U
 cGRaVFlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTGJ
 BQW9KRUUzaHJ6RnRUdzNwcFNBSC9qWVE1bTNKYmtuL1owUlBBMmtsUG0zMXpnTWYreERRVE9hNw
 o2bWxENmhWRUNKSXBPcHhjS0krWkpBa0VIaVNtODNxeTBqRUFhQkZNS0VvL1UvdWhSSVBlZzhqW
 DhoMndXd3IwCnZHQ1BtamRMSDRWcFErUlNxbXdqbXk0ZHhvWWZjMHEreENLeStId0w5N0lSd1ZS
 dzM5UjkzYlNlRG43R25wVHYKNDV1SGs2dTF1N25tM0NiQVhmRFBzYSsvRVliZ3o3YjJpNnRseG1
 IREh3WnZ0bWRGL0V4R01nL0FHdVU5YUF3SwpFZmVWOVc4Z1VWbEZTK2JDU1BFUGNnVGRSSTYyT1
 pRbGs0U1Z5YUljNjNkUWRlbHNQdGJFQnBBYzJwR3N4c2hVCnNlLzkrWjZDRzJ0Tnk0TnVUTmMxS
 ktRc2J6elRKa3MyRkhLRHpjUUFNY0FFVG9ibHVUQ05jS2NzCj1xMVVuCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

The nvme_aio_err() does not handle Verify, Compare, Copy and other misc
commands and defaults to setting the error status code to Internal
Device Error. For some of these commands, we know better, so set it
explicitly.

For the commands using the nvme_misc_cb() callback (Copy, Flush, ...),
if no status code has explicitly been set by the lower handlers, default
to Internal Device Error as previously.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 28 ++++++++++++++++++++++------
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5b1bac020f049cc2a2f869b12e1d2a7e13cef316..8192f92227d6509b8d15fde9d9197a59277eb86f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1765,7 +1765,6 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_READ:
         status = NVME_UNRECOVERED_READ;
         break;
-    case NVME_CMD_FLUSH:
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_ZONE_APPEND:
@@ -2151,11 +2150,16 @@ static inline bool nvme_is_write(NvmeRequest *req)
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
@@ -2258,7 +2262,10 @@ static void nvme_verify_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2357,7 +2364,10 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2439,7 +2449,10 @@ static void nvme_compare_data_cb(void *opaque, int ret)
 
     if (ret) {
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+        req->status = NVME_UNRECOVERED_READ;
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
         goto out;
     }
 
@@ -2918,6 +2931,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        req->status = NVME_WRITE_FAULT;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
@@ -2982,6 +2996,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        req->status = NVME_UNRECOVERED_READ;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
@@ -3504,6 +3519,7 @@ static void nvme_flush_ns_cb(void *opaque, int ret)
 
     if (ret < 0) {
         iocb->ret = ret;
+        iocb->req->status = NVME_WRITE_FAULT;
         goto out;
     } else if (iocb->ret < 0) {
         goto out;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 66d49b641aa1e89c12103e548320d89995fbbfae..3c8a9ba3c7956c1d475857a1068074338643f77f 100644
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
2.45.2


