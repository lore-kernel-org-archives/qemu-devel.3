Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20198E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcK-0006vc-4g; Mon, 16 Dec 2024 07:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbu-0006bd-L3; Mon, 16 Dec 2024 07:54:06 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbt-0004rm-1e; Mon, 16 Dec 2024 07:54:06 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id E076F114009C;
 Mon, 16 Dec 2024 07:54:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 16 Dec 2024 07:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353643; x=1734440043; bh=vVfMVAx+eVbV5OtdkXmcg0eIqsMNcBLL
 hgn4WD9j0D0=; b=YakfKyK/E1wYql1+A8RpuaPA8LtXDTM8zd1nBCMZ1woEt+Kw
 SNO5e17gZB3XdxXm0oVEQ4PG4mhR4ehJhIN+xhISNO6zeV5pSxsZEVOvW51c7/ud
 u3A4I5IYlNc+OZkJlNUV7c6YiyBSTTbrBLIqQgylTk5DppkjoRmkaCGKWdBymz4o
 GArTYcERoFultkzcADkxyFQUu6Q0AII4Vm1hl2KfxAkArLtEej9yMfs19jgmwPE+
 Yg5zFxejXLLZug6qRqNQ8lxSRkhoVM1mrMQQGxGuMobStRuc9Zsh//O8pV6/lNAE
 RbjK0FBQGDpz/NegROfAeckTYpa8K9bkZo8f0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353643; x=
 1734440043; bh=vVfMVAx+eVbV5OtdkXmcg0eIqsMNcBLLhgn4WD9j0D0=; b=R
 vbWzMdViXAwwn+gh0a+AoKbZ3SNZPF7u7B1/ObIjjuY4Zpnm+fnVPwJkbsXsY10p
 rDPvHUsETGphoHfAzeerlnmf9DPH4GESCtpOxIZNmp3ViW/E00Z+FCOLveh4V2Cl
 4oAOGx+uzbRcs1vxzW+ouiNAXPGWRaDjtmJJEbdp2id2kYqqePv5sqodF8gAJfBP
 Ay8AR6YFj0zSi2eui9Sdn92MDX7z2dXCS4NbEJWmVCcwNb7oNuxyuDgq0dD+zq1h
 NFArJxNCY/7jLQvQU3+XPnZQYmPB2gf+DPcc6G6Rb1MU5FDsws4DEy05YRVBnfMd
 YvMlaAucAsTtbmG0mmCfg==
X-ME-Sender: <xms:6yJgZ9kaW_0RXDmMBYgpJSrXAbIIghNsbBQr7H7L0_mHDfpAvoFh6g>
 <xme:6yJgZ42A6-81Gp_KNNoxY1H7zEfFGcZAv5dKiUEgzbDybHGzkx27UZxaO9rW7V8SR
 ojql7QPwaf90v7y7uc>
X-ME-Received: <xmr:6yJgZzrCIHy5oiQBTvo2Rm9PxUlFfL7xOPuoh0Wi5JK8vhWDGnt1ATV4JMq2m3UEuNSbgjnrBE6Hty1NbD8oVog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:6yJgZ9k6zuYwuC5h_Uf4vF9yiIHmFXWf2o4QfoD4i6vndAfCemLs8A>
 <xmx:6yJgZ73I_Tg1LXG-iDXWZXkFRNYQj0JoG8vsmCqxj-Ink_9cBqa17Q>
 <xmx:6yJgZ8viirtYVW1o1nejqKiI1KQm3nF8SpH5VAzjEwR03dJEX0ZGYw>
 <xmx:6yJgZ_WDpjFtGdEX2z5VrHe32KxvPE6Kisu3QgzxXTpAz6mrymgXiQ>
 <xmx:6yJgZ1roGEBZDFezBuPsA5gfyPRmRzfBKR6iijfDthkHGvhwPRU8VdK3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:54:02 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:08 +0100
Subject: [PATCH 7/9] hw/nvme: only set command abort requested when
 cancelled due to Abort
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-7-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=Lzmkuk5YaMJzGtZSA4ffX7+4Au6vE0d8ay3Yh5W3tCI=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRwUHlsd3lUeDRic0liN3hPMW9lZHJyClZ4bC9kcEFRMmQ1cXRLc2FW
 Q2c2S1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTGF
 BQW9KRUUzaHJ6RnRUdzNwdkpVSC8zVk1WMnd6TThjbVdDeXZTeWtsaWF5cUg2WmVxY2UwTVJEZw
 pZMzBvWnRETXN3TU94bVljTkplQk44elJLbGk1RVZmNERhaVpkNU5GV1lxZ05CTDIzOExCdi9GR
 ThkY3VvWUYwClJGb2pRRWxCNUJ4TEhLS1pBR0ZKQnFhbXc2SzZSaGw0KzIwU2VxNXlaalh3TlB2
 STZmeVplWDUzWWNUZG0zL0QKMW9Uc1F1L0k4eHZQTUJrTXhsTEpGKzRQeHJ6dEN5VG5iNXJBZXd
 ZU0JjeGpNTkUycTZsODMyZTFxY2N0K0FGcQo0aDVwejd2OTJYelUwY1BmckJPR1l1RUhZS3F0MF
 ZPakdXTW9GUkVNSUhteU9vdmluR09iSXBWbVhjeWdwVmlqCk96RUVwR1BES1NiUDdzTnh0RThmY
 i93RXFEc01MMk9XcWNYVmRuRm1pQkFOdlcycStjcmVnNmVFCj1pYWVUCi0tLS0tRU5EIFBHUCBN
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

The Command Abort Requested status code should only be set if the
command was explicitly cancelled due to an Abort command. Or, in the
case the cancel was due to Submission Queue deletion, set the status
code to Command Aborted due to SQ Deletion.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8d3f62c40ac14fdc4bdc650e272023558cbbae0f..5b1bac020f049cc2a2f869b12e1d2a7e13cef316 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1777,10 +1777,6 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
         break;
     }
 
-    if (ret == -ECANCELED) {
-        status = NVME_CMD_ABORT_REQ;
-    }
-
     trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
 
     error_setg_errno(&local_err, -ret, "aio failed");
@@ -4821,6 +4817,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
         assert(r->aiocb);
+        r->status = NVME_CMD_ABORT_SQ_DEL;
         blk_aio_cancel(r->aiocb);
     }
 
@@ -6073,6 +6070,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
     QTAILQ_FOREACH_SAFE(r, &sq->out_req_list, entry, next) {
         if (r->cqe.cid == cid) {
             if (r->aiocb) {
+                r->status = NVME_CMD_ABORT_REQ;
                 blk_aio_cancel_async(r->aiocb);
             }
             break;

-- 
2.45.2


