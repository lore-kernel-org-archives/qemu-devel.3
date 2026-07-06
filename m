Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A937C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3i-0001z4-Ma; Mon, 06 Jul 2026 18:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3g-0001vd-Iv; Mon, 06 Jul 2026 18:45:00 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3f-00010Q-63; Mon, 06 Jul 2026 18:45:00 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0E9EB7A01E4;
 Mon,  6 Jul 2026 18:44:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 18:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377897; x=
 1783464297; bh=68I28SvF6NliEu1oHD4j7MXavEgdixjiWJFe+FDCopk=; b=K
 Dda73KgTa8MPQJ1/pfJzy4UoeY1O5DkGkyfPBY6ZZexn2tfYKPOxCdOG4nU7PK1N
 vkJN3NGFBiCYoIAsRFpOz4xp0Kc4pF101NthevyAXB82VsqyEY/TmumoFMiIYM6d
 5Cjv5SPmlAMJzAXLOaqs9ESuDbBNsRpbihNxIsQQOnpbuAry+rWwlR0Gvu/aX9na
 ap+h2jKPeuqAUXT6un+D2J/Pyb3v3aVF8tE4CYnfWya1oYHuwVMZJh+9F1lLeQUb
 i8EsoHR2hjbY6FIXeRBrIVY1nw9Id/4vpr2Q8AydC81xwdWBX6fv/XCQ4w1+x+ve
 554RuEjRu1EnswPsqAZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377897; x=1783464297; bh=6
 8I28SvF6NliEu1oHD4j7MXavEgdixjiWJFe+FDCopk=; b=NNf6IlYTBR+jupXLv
 naOqkNdpXcBULzpQOV70shL23mc1UIRGHwd7UwSTilDAQmcsGY3cIqj4tNyq2cyD
 ZLtg3sht/XTuG+405kV9qrmk7/Z7jndzVN2cJ5/lqaZmcJME9wA/Spb981+s5ig/
 LWA+hMozPK/BhrIHM91A9OJrcAGbM/4w4jH0386iWimYy+QNDTAVkzKG00vtxune
 TsUW0lqqVP/wp4fMAn4WRuUt/XmMcKSSM1cCtaXtjoURisqzRyqIggu5jetuKZP5
 0UjJ5TqW4eFGwUpEDhsi5MQVC8y7VeS6Zp/AZzJZ3iWd5dzveIlXMBg1JaB0m2oX
 i6pNA==
X-ME-Sender: <xms:6S9ManmG-G9BpAJ81biJWh7Ipu4GQJjRitzEI47cLlGtC7QDYusPvQ>
 <xme:6S9Mam315bu_qxmLq5nevTeEg-2bfeWRbjBQIdv19U30p2dMZgqmpxtDJifAXKLZT
 dZ-SADAz-337LLI7ZWN3j4K06EmeKTxdW5K1BcXRz8O17LFwfZVkvw>
X-ME-Received: <xmr:6S9Mav29qOQjBqbOreGLcflv4H9dcDfU2b5TvwTdUJajdu_jKEPCy79d1Eznuk-dIOkqPi4iTRe0q1G6pB6W2kde40woJKskygXLCHPUkTO_RWMuL0axdXDOAw>
X-ME-Proxy-Cause: dmFkZTEHwWeRLRRHVATDLNRfGQdRW51BWy91UTgjZ9xms8WPZJx8wttvEDTZHq3D5TFnJS
 JpcAgiFleC6RH6VVkO7NFh7cPeOyvzTMt8kiBIgMvJ4O82Cb5ONjBhLhNCgmFcZiXZbuu8
 tK0hyFWfL+mY2UOnglFNd3yTMYCJhcfGnABldkkx3GjyDaCcoIFX8hAst1GxVzxmhbXW0k
 F8UIcTspuQlxCQXcrxEh4GVVUAX4dzjd0CDDWTl+p5dr6SaWjo/RsLcOrG7kStv357ZQCZ
 GlA7ExVk+WvZJzn98nWFkIGSyJXQk3XeuIUuoACpyYvPYfpBzamyJfg8xH90ZKXdZL/5kQ
 e6JB+z8bdnVehlFxKYjqhN43n/Yepf7lb03MFXgjI+TCR4VnK5zDVTR4x8z/z2Rg0w2Zs6
 fzyueak0zm6DcC66vLttGwMpcAfQe3vN7+lWEDaDlE5nQxLEeEonCCZRXa262Y08B2eb+y
 TdxypRWlFKYay+jvVJ9UzTObwyNNA0leOV8BObPHLUnPUelLGtWPNbwcXX+N7okpLybHlK
 h02OY06+jvMTQOpyFHMJllWTGtp9EOAa2eDgArO69C78EXpj0zz/hkZnbXCazF7QG7lL4K
 Q9aq3p2RcJ0KnE51h8jKAEPirZL9kvHG7AyAxyPXMyui/Zr2qlkKVYYVhIlg
X-ME-Proxy: <xmx:6S9MagoTerR_4ZKkdbj9x8a5QIlJG_02gX5Suoz9IPYGfc4VtnOM3w>
 <xmx:6S9MajjsakUrtwu_u5MitJ61zPtpJQfaiHiOhc3c3PGpmtlaQmj1-A>
 <xmx:6S9Mak-Z7f_E8lT8frPF3zNveGhPCXZvhKrU34skTrdI4ZGJOrxbog>
 <xmx:6S9ManVwO8hcVeBvepamK8-fNnMceMmnYiI0oYXzcG8v1dZI0lFw0A>
 <xmx:6S9Mah6YkTdf0lL2yuV0DgUMOCWMcAr1UHFv8Ahc7bLPJJi5oCg_r_cz>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:56 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 06/11] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Tue,  7 Jul 2026 00:44:18 +0200
Message-ID: <20260706224426.14156-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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

Instead of filling req->cqe.sq_id in nvme_post_cqes, let's set it earlier
in nvme_process_sq.

This shouldn't cause any issues, because req->cqe.sq_id never changes
during lifetime of req.

This will help us for migration support.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 386a698ba858..92825022a4a9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1535,7 +1535,6 @@ static void nvme_post_cqes(void *opaque)
 
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
@@ -7875,6 +7874,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         nvme_req_clear(req);
+        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-- 
2.53.0


