Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C97AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3l-00021L-64; Mon, 06 Jul 2026 18:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3j-0001zP-9P; Mon, 06 Jul 2026 18:45:03 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3h-00013G-KX; Mon, 06 Jul 2026 18:45:02 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 2CD421D0019A;
 Mon,  6 Jul 2026 18:45:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 18:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377900; x=
 1783464300; bh=E1dAo5JLe6EAjfgzmGKUJ5FQZTZEt2TARKRnulPjjSU=; b=g
 y3YXhvM3VCO+Rv5Fk/ba56QW8L6IYpO4Qbe5SOrs057ndHTZ5TVcVmM9ZaDyOZwV
 BCO3PicWewcHzeVKgNGXStwrmVlce3JpoEDSNFzRoJE3uCmDcZZI7qlBHHUD6Ls/
 vMo6T68qVHGYc0G+3jq3xIgH6/Lgs9dOsELcgcazER3FeQghi+bnNKkiM0juwzvi
 VOu1+As+s8lSFGg88DvAhiiu5u7yCk78Mrn5nFDtjrUwwto5dtzQNdw7aLFAjAMF
 hiXzTV6JEle7HxnQz+mp+nDGBP+2XMxq9zfRanDNECbNw4Jg5HI7MUX5YLYbYYsx
 Mom67sS3V6YWcmWsScN3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377900; x=1783464300; bh=E
 1dAo5JLe6EAjfgzmGKUJ5FQZTZEt2TARKRnulPjjSU=; b=DlRcXYZrE5pnlrn14
 ULqseZsAuS518VSWA/Llyq4WuT3jsDQzJzw8ZXonTOOaYZYTm7cYQhGyjwXSqLwX
 1XZzaXBaACYKVWs/ViUjICbjQrzQmBhvP53zOuHjZrvK8Jh8iDDU07Pqpdd557BW
 HXa6c1zq7IQ69yHRw6I5N/n4ToeYENQXmq7/YOze1w9mmZ7rkGnXqgJKqZPDaySs
 B0E7dG5p+l9I5tVO6aQv0VUJoYVxjzlAjvWIcQoL36KjhYnGcB1iokbkJFDFbCye
 0VSW0NoCu0C8BfYzbCPdZkrptL/RzCd3yrNiaqLxBpqLc6FUgLlwYZfq30acJI4x
 JDugA==
X-ME-Sender: <xms:6y9Map1T2gOnBvpdP1wd63Op7UZRZnZ1jnQr1QpP6f0EDUgjVZFUnA>
 <xme:6y9MasGliOY_8ERspLsdUeAs2AwBzcIeXQUW1-2970FHq-MidNcSoCZPvyorcFA1Y
 UxhvCVhnPVjK5XdCSOI2QCoDr1XRaRD24O4zXhwH_GFS7rrd6euxao>
X-ME-Received: <xmr:6y9MasFJyZuyhULM-OxBgjjCRz06wIp36pXHUrZvKFeByyh3Y-Lt-R2tKyj6D2YszfErYvt9Lt4PD_RsROJWWvQloyCiQLcFtl1dBIqE3PtWx18RoeIqRmsC5A>
X-ME-Proxy-Cause: dmFkZTEHwWeRLRRHVATDLNRfGQdRW51BWy91UTgjZ9xms8WPZJx8wttvEDTZHq3D5TFnJS
 JpcAgiFleC6RH6VVkO7NFh7cPeOyvzTMt8kiBIgMvJ4O82Cb5ONjBhLhNCgmFcZiXZbuu8
 tK0hyFWfL+mY2UOnglFNd3yTMYCJhcfGnABldkkx3GjyDaCcoIFX8hAst1GxVzxmhbXW0k
 F8UIcTspuQlxCQXcrxEh4GVVUAX4dzjd0CDDWTl+p5dr6SaWjo/RsLcOrG7kStv357ZQCZ
 GlA7ExVk+WvZJzn98nWFkIGSyJXQk3XeuIUuoACpyYvPYfpBzamyJfg8xH90ZKXdZL/5t7
 gAksx4GFFYGUnie+wQ5yY8Sayg6n0/bDLVVylk5x2nSxAyFch5fh4k9ahashjTXJSR1mT/
 zzuaPAZwgKX1yEiXAJPjsznGvOOp0B8S3LOwJ/Iokb2OSmHYzrSqD9HhzoM+r0gsRN3olN
 tD/aUr1D9WHLF1D+7ur6fc63O5bVsmajYXDw5eNXNpQAxhR1bwj8x1r63tsyrcp661+2z2
 QS9QrubAGg3aQURapaihcPp1gkfFJIB4Fd+JPxymgRc8wYnI0o/3Umk+yUhth8rzFbPWzT
 ev3iGg4QxSHans8p/Zxh1NAOqmjK5hBceFr7/jKcned4GPihxZUK938Py4eg
X-ME-Proxy: <xmx:6y9Man6tl7smizJI35_fS0PMN3WDWG_AyyvmSHmIr2aCRJ7DLZRd_A>
 <xmx:6y9MapznueCpgitc083cQcuf_DoVwax9eNZZs4JznIQGyjKd8AwmYg>
 <xmx:6y9MauN6mo6b55wNJK9bl5TXtQlSXG-Ol9zAa8EaXylgzxSBHqqiOg>
 <xmx:6y9Manl08iYCBoDNlOiSY_6P39emWPC2XJVDyxTGlhsWkV_pkQuCPQ>
 <xmx:7C9MatKNq8ZepwIG5QEfh_yLx_NjYx_0bAOmesO99_mJuGGwV5-A7W47>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 07/11] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Tue,  7 Jul 2026 00:44:19 +0200
Message-ID: <20260706224426.14156-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Instead of unmapping req->sg in nvme_post_cqes(), we can do it earlier in
nvme_enqueue_req_completion(). When req completion is enqueued we don't
need to access req->sg anymore. We only care about req->sq, req->cqe and
req->status.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 92825022a4a9..cd30735e86d2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1549,7 +1549,6 @@ static void nvme_post_cqes(void *opaque)
         QTAILQ_REMOVE(&cq->req_list, req, entry);
 
         nvme_inc_cq_tail(cq);
-        nvme_sg_unmap(&req->sg);
 
         if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
             qemu_bh_schedule(sq->bh);
@@ -1579,6 +1578,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
                                       req->status, req->cmd.opcode);
     }
 
+    nvme_sg_unmap(&req->sg);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
 
-- 
2.53.0


