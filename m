Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=U3in7DcV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RGLR5LQo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bW-0000e1-G1; Mon, 16 Nov 2026 16:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b3-0000CH-Al
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:43 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b1-00055l-6N
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:40 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 5BC661D00147
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 16:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794865838; x=1794952238; bh=+cAGA+uLVe3sDgAEw6qH75oAIXqoY6FT
 zPbmI4hrLdg=; b=U3in7DcVPM9whGxrP+adKxXVjf+hcq2FOTOt1/A6FMUhLJBG
 ciPaprQEjzd8++i1tEb6yPitnyC1vNKtTWPBl0wffSqgzZa+xXkQLOmCfMRBYKan
 rVxRDPpjidTsDAwpgXIJsIUzW4aEGnYEIm9MNs6TnZGRNTZ1ssd19CNmVvYVcHj9
 RP4fnZbo/2xzsFC7CJ9nwWe9xPCQ/I8jJqty2qSlG7RIng5LU4ruxipP3O/BBe4C
 jK36VJbwsJgC/mg85hjGj/YCtmX8tzyNPEIokQeFdkeAfuG1kx0iYyoRKg9W1zE0
 vJEULHLtonb11dgFN5duLxRhSK8UdnxJvt1gNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794865838; x=
 1794952238; bh=+cAGA+uLVe3sDgAEw6qH75oAIXqoY6FTzPbmI4hrLdg=; b=R
 GLR5LQoJz1fC1h+H+Na2o71+P1YIXrHxJFfSiU9kaPJG/uH6r3Mj0u9Fp4iVJGO4
 b/NolJxbnXI6Avwind6BjhDsljUSW5Dz7mNMHWRNbV8Us4+r3QUb3Z/p75KiCsFX
 b6N/vXsKhRmZKf+xnohyyIoD+wC79NYD2WCaAixipn4brI/D4BPe9n96IQcobSGD
 ob73iNfpilx62o30ph8vPuoDtUBd7P7hISA385WpGkK8NmXGZNC3V1RSQoriXzeI
 jaTSpD1tRUowUU+IMyIUisKdJHoUhzwXxnHupPyM1HGYpkAXPfGBQc9bG66Eco49
 8wAfE6BkxxjJ4vhZ/YPKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865838; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:HBXR69m1lG3tGAesBIucvtc2B+YsqjTYzjTXQoAIgav0BK4
 Btdg+KEySPtEk+RJgWuY9OVguthcMfDpylJrsClhXC4sBGBiv6os7wfJnzX6LbC+
 rh5GxBhxCzVk2lt2kZoR37pfi1ADKQj387XCxTSBZeSddzgsGh5bcjwBCKyJT7Wm
 opxtnLRoT2N+DAYyqcEQhYSngRhcYHlnEa3eeyOaKeR/6MLsMaH8EHW3MvpKMaVW
 vcEeNSxTiLF3e9D0H2my4GqDaWrQmo2Of28as2Ejl+ETROOystAM54NTESpWQdtU
 f4Mq10xbnTThwg8OCQIQwox7HwptygisRkrPTkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4HkBnRmNs59sqcJR8crRYVS0dr0fKn7+0X2rGw8CjfA=:lSFvTUv5Sfhu10nBTkpXRmnbNU4v1k43HxNdSo4dGq8=;
X-ME-Sender: <xms:rXr7ageGE4RpnFMRTDFsGjP7udTWZax7SbF-tC_igqaNTCOe8NLYuA>
 <xme:rXr7auNY5kfhxu4BsV1FYMMCgZDGX3XDejmHXs78EcL48MSHGQhMw_DwTtqmSwaAR
 hmqoCUu-dsFfstewTI5tW1jHx_h9hUfwrF2VViDXvrIlQOVZ-IZqy0A>
X-ME-Received: <xmr:rXr7ajsb99599SVhv1vMGgsO6WSoI6ADyapH7za-lpFCw2CtoZjonlyjAt7ikPISXoAKyRitTGYRcwuVGilc9bFwWMTz__kYUYFEyJYnpFJlfGd-E7lnlk719w>
X-ME-Proxy-Cause: dmFkZTF1MANP5a6KGRygogZctHchavWPiKruQh9ID8GOuPTdWG+FVLLc2ROnNPjnrzPyzK
 AuKGRPhkXaEIhyC8Di/OWSTR1Zmj1vMdVAmMwXmZuu6+usslqYBgbwfTdvd0z0P4kWvqY1
 6812fOL4INvrQfRvCKOtREMiMLlLrH9ww/BuhpCHpIvTX6SPiM+iHSxLsKZgokgwtbTeEb
 0+ynhbr2nJljUy3lL7F3xIw8Tat2Poxz0Qrg1nU0Lqd6BWBq3zuP8ftZ3Z41JiKCcnK8wy
 ktgHnDQuSKfzFdYeZlmCIwenuAWCXMmbhemX0XWRW5IW8a06okGn3YDKrwELR3xo7DmPL5
 40AYrr8FjyqOZtWA53t2X1FI8akBCt2j0cBhP1M6euXoAHkzBqVzqZTCZDkhw6VfUZqW4C
 wI0DpQt7HsIWHQmDtTSPlnq7KkXVM38K8qPrB5DINWEfaesldWCAMHPwH5z1kuYTtcQ3BW
 fF+Bdi1U+HZE96ofcDGLIzuZV8loAse+1mLzTIy6a3o+kjiurs5m6UirP5BjbsSx+2TzKt
 PhYjs/OyNp/MA7QEjofRD+Z3N5JdZdwhxJDf8I7BygUVDy+xiyyxwjF5Y2MgfK5KTNnoOx
 HWdM5pBJDIiebH2WO08Lqgoe6GXUXXrt/dETpUVZt5ENHIskeqphNMlAZOpA
X-ME-Proxy: <xmx:rXr7anB6xWjKf8qMIHy7V194tnM7B3BUs4ewlF5wjjDIjIPzOCs23g>
 <xmx:rXr7aqaWc46J1rYJ5pnbgBloVeGPDnrgq887wDT7QbsyplkpS1D5Aw>
 <xmx:rXr7aiX-JGMQMftyusuneA0vQLQ626i1wchN1rahfQl0qVO8NMjPKA>
 <xmx:rXr7apOjsVSFmoaVKymzc0yk8-H2w2cdOEY-T0XrmEXKrY2pIFUqnA>
 <xmx:rnr7auX2QW1_9qrhGbK0i3Tbu11Y5IRBa_cpiwgIT4cNIBRR4QRAlgGN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:36 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 3/7] hw/nvme: clear interrupts on controller reset
Date: Mon, 16 Nov 2026 22:50:09 +0100
Message-ID: <20261116215014.59993-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markku Ahvenjärvi <mankku@gmail.com>

Clear stale CQ interrupt state and ensure the interrupt line is
deasserted when resetting an NVMe controller.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4142
Fixes: 83d7ed5c570d ("hw/nvme: fix pin-based interrupt behavior (again)")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 52fa4b327c1f..4a626203cad8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8136,6 +8136,10 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     stl_le_p(&n->bar.intmc, 0);
     stl_le_p(&n->bar.cc, 0);
 
+    n->cq_pending = 0;
+    n->irq_status = 0;
+    nvme_irq_check(n);
+
     n->dbbuf_dbs = 0;
     n->dbbuf_eis = 0;
     n->dbbuf_enabled = false;
-- 
2.53.0


