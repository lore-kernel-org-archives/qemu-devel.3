Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F99E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcM-00070O-9z; Mon, 16 Dec 2024 07:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAby-0006dG-G7; Mon, 16 Dec 2024 07:54:10 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbw-0004sP-U7; Mon, 16 Dec 2024 07:54:10 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 30B78114010B;
 Mon, 16 Dec 2024 07:54:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 07:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353647; x=1734440047; bh=vhSco4gcriDq04rx4WWzfriM2dprAZWn
 sff5e2aVQKE=; b=CZTCVnHgmwtPwMnbgSGutAi+UDX3dlkfpwc7uRWIqb8ku0vl
 B4m7jvrJPeP4NxIVKaCOLsekRzZdpJ2AiUrOARQXB0S9dbIkoq8nB5BcYX83Y9kJ
 wLZmhsaW8UlKd8OYzC8RsVWazFyWS5QVnmMbO2RdFYLjSUDvaCVfn6I/lr8WBCpC
 IcBAzdR0vruLySxNpct9qOTjAc8G/G+Oy/WyNDLtCBLdb7UA6CfCxeM8XjXmykeB
 LNwMnyr/9hGqCCklzzGyzHQShx+/N5I7TNSc1NSW/gf/2DqFKQQhl2NW4P9tG+UK
 kU2Dfe0zPsrfrO1vRk6RbU3t8FsexByjO6SzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353647; x=
 1734440047; bh=vhSco4gcriDq04rx4WWzfriM2dprAZWnsff5e2aVQKE=; b=G
 sCBBJ2Qzv1mXfMWhOkzdefNkH3zr7AoLlT2IssJuFT5nja+qs7eugdEzpzB1L8T/
 FOOzlMiZ1xU7ClzAdoRdsuQWwnTt42ERQXXddiG/Y65s+deUE5iWD7na976Scypg
 DffGboP8EKiMzrRpItNOuvAerfzqWQkjCHhbr/UnVGizlrEa3Glrcndj7gcp8X9o
 JPyG0cpHgGMnGEki8cCVYzXJMw+oBZNybO11xaugY45r915FWnjPRYWba2U0KXX8
 CH6t454XsyT35q95kutXp4jRzUgkff7AMsq0pgHPTFdxCvW7b2RqsevRmdxd3Rul
 PQU0PIJnB9YsHxzDrkUJQ==
X-ME-Sender: <xms:7iJgZ5jAC8vHgMOCKxdK1UmPdhC622rWiDx6PIEQtyEUlNKenbnsKA>
 <xme:7iJgZ-CsH6dcEq7sB3OimlByPGwStmlEMskCJa1wMRssHAsKCIy7jvA4jY-O-Fztj
 pDOzHGNdL_eDJbZvzI>
X-ME-Received: <xmr:7iJgZ5EzrjPCQWyEr7G2O6JZ3PZqROpj9kG6f35FSElh6CYu7Q-uwETG4WyImmIysAOosy5kc58O1twO8yx2iPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:7iJgZ-SmDxBJX7sZWfK3Z-NIuxf3n1HLgvLnI8rbj12b7rZnBVMt5A>
 <xmx:7iJgZ2yrDrX3X6fiEswhFoOK_OHp_PBpqDQ8-XWZv8c92YkEEdG-_w>
 <xmx:7iJgZ06huHUlDYUfVArU8qAWoZdI8GlIYLkMnUIY9MOEwonJPiX1Zw>
 <xmx:7iJgZ7xTDsvznHVuclPAFxw9e3Fu3huIMG8vr7krJIA2oZanx0-LZg>
 <xmx:7yJgZ9l7ypW2mTlbmOaQxI5KBvRULbzyWjXf_IfqkrcrC3GInMCWuKc5>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:54:05 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:10 +0100
Subject: [PATCH 9/9] hw/nvme: remove nvme_aio_err()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-9-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=6MFFr7ovftAu1ssrPvwHNYhO0kA83E792RYldng9RiQ=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXR0RUo4LzFKVjJTTFpRQW9jcjlId3V2CkhRWWhwRlQrNjY4eTFScHVI
 S2h1aG9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTGJ
 BQW9KRUUzaHJ6RnRUdzNweHNVSUFMUDlUMjFvRjk4cE9nRnc4SzZDMzdiUFk4NVNpQWVQcldkZA
 pOdW8wM2o4WVN3dkxzUHdWMlQ5aC9tNWgyZzF0QjYrcnEzdE14RnIyWVZaT2RyT2JBK28vdUNiU
 URQWW9xR3RtCmxRL0E4N3RIS3BoV2dQSUtaSEcxWlExZzFDZFlmdDc3NWl0NFVHYTRzT1BRSTdT
 YWxCYmhOVE5Ub2tQYVJKN0cKUlN3c1RWZDBMY2hrUGNoNGVMS0ZkdExXT1RYNUNleUZKemtBem5
 BUHNVOXg2SFg1Qm1uYVBYZ2RvOEZ3VS80ZwovUWhwUjVJTmFRZSt4V0ltL1YzMDVPcHRKU0NiaU
 x1d0FBalRDT0dpYjJhakhQdHVkbUJjRGI5YldMTnpYNkdTCitZQXdrMldtOEExd1J1RmQ0UDNLT
 1BrR3hpNm9kUFl4cDdmWHAxdHFOcy9WRGhTQTdib2srS2R1Cj1lZitTCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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

nvme_rw_complete_cb() is the only remaining user of nvme_aio_err(), so
open code the status code setting instead.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 60 ++++++++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8192f92227d6509b8d15fde9d9197a59277eb86f..40f535b03316ed45f6cbb2894fd89f9ce258423e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1756,42 +1756,6 @@ static uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
     return NVME_SUCCESS;
 }
 
-static void nvme_aio_err(NvmeRequest *req, int ret)
-{
-    uint16_t status = NVME_SUCCESS;
-    Error *local_err = NULL;
-
-    switch (req->cmd.opcode) {
-    case NVME_CMD_READ:
-        status = NVME_UNRECOVERED_READ;
-        break;
-    case NVME_CMD_WRITE:
-    case NVME_CMD_WRITE_ZEROES:
-    case NVME_CMD_ZONE_APPEND:
-    case NVME_CMD_COPY:
-        status = NVME_WRITE_FAULT;
-        break;
-    default:
-        status = NVME_INTERNAL_DEV_ERROR;
-        break;
-    }
-
-    trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
-
-    error_setg_errno(&local_err, -ret, "aio failed");
-    error_report_err(local_err);
-
-    /*
-     * Set the command status code to the first encountered error but allow a
-     * subsequent Internal Device Error to trump it.
-     */
-    if (req->status && status != NVME_INTERNAL_DEV_ERROR) {
-        return;
-    }
-
-    req->status = status;
-}
-
 static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
 {
     return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
@@ -2176,8 +2140,30 @@ void nvme_rw_complete_cb(void *opaque, int ret)
     trace_pci_nvme_rw_complete_cb(nvme_cid(req), blk_name(blk));
 
     if (ret) {
+        Error *err = NULL;
+
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+
+        switch (req->cmd.opcode) {
+        case NVME_CMD_READ:
+            req->status = NVME_UNRECOVERED_READ;
+            break;
+
+        case NVME_CMD_WRITE:
+        case NVME_CMD_WRITE_ZEROES:
+        case NVME_CMD_ZONE_APPEND:
+            req->status = NVME_WRITE_FAULT;
+            break;
+
+        default:
+            req->status = NVME_INTERNAL_DEV_ERROR;
+            break;
+        }
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
+        error_setg_errno(&err, -ret, "aio failed");
+        error_report_err(err);
     } else {
         block_acct_done(stats, acct);
     }

-- 
2.45.2


