Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BB606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=BLKKKvnX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jPQ3fmw/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bs-00017d-LH; Mon, 16 Nov 2026 16:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b8-0000F5-Oh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:48 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b6-0005JW-R1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:46 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2BF6D7A0021
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 16:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794865844; x=
 1794952244; bh=kJc7UF0ewDB2ZBijTug07HT75+V0/+30QifhuL0KcsQ=; b=B
 LKKKvnXTNudlOwZY32+7BuuI+kmbAlpYYsc+4xK6H9PXB+pg9VZdJ/jnoci6rjk6
 W/9Pbr32p27RQS4zraBHl/CztHn3sJ19096vLbGau9PHOKsaDKuDQuDWH8pz8rF1
 dldwOyRtDj7Rzz3wZM+MXoMVoK83GlNq42mUN8r1uzkxZdaouK+35VGGtnOKg7hP
 k2QZ0dAdhTtOhHgLLSdDhU1mr4Vh4WRz6bMUr0xiTZsMpjOVxO/7/38X/7gluZzW
 git1Cou4u55N9tTZ2If8By832iVksjsBvLglKu+SIDxbNvwZrqyTbU6FZ/hp5zcw
 w7ezD/K/MzLKX2ofx4ohw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794865844; x=1794952244; bh=k
 Jc7UF0ewDB2ZBijTug07HT75+V0/+30QifhuL0KcsQ=; b=jPQ3fmw/gWwes8Sxs
 +3AJHYKIN1sUeZUAvoF8PAUeKBQUXVLqc7q4fR2NPnJzvKahCyO2v1A3/ekrxDl8
 LR3uZhgLVdZgSEKDosFbhrNvfltyNAKcRUhYDtXKGR6XOjy/j8mI5nPGtvvGn7F9
 YH7CqE/3iAAmzlSCH02PUJrutiu4uucWe4xA7trMtd90VttrQMFzCbwRpfukp8HW
 F5rJkrTgf7ccAFHaMDSYdNdxGN4ItQZo7AxyeDiaJwDqJNRiy7N5Cas8U3QcA0r3
 wVmJI5ed5RJnv6LaUkHWfc2oLbhziiygJvtt9fO1mZMGPvyvnytH6y8ooUy6zgIE
 gscWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865844; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:g7ciKoRqu0iEGcfVpmz66xN/wCmrERmB7pNizuDHc4y34Hk
 BZ2rlR+MJcGQK4cHT6xBM3ZvGQpY80oeI4GZV8+g4nVE78SN/DiHgVWXcxjQ8OYw
 hEeQsuBCDau9MUdXJ3tH0HcIp9dAE682kTGbR6e4M6AsTimTP8DLDKqVzteYcmj5
 IOXuOyVYnyzQMwSF1qLlh/RtzghKQwNzsjwBn6yZLrditlZSSDXwIfcV84NzuJcJ
 042pQ+Wv6nt8Nhn49SvdWP/xuTUgi6wy8YMBXLeqrxEZvr/iJMqMEVC5hUZ87j/L
 mGZR5jhvCCTes+2f+4Ck7/JSjE2EH5oMdpnwnvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:10Ed5O8WqTip22PCrEnkYQrTbblDaFKHKb65jxjNYCc=:Hmt76ITSS43fV5Ani1J3YWRCpfxpqYetg4HYVVef614=;
X-ME-Sender: <xms:s3r7apJmkOlXOCaQmAaRIYkJ6bNz34Kyzsmd7FMz4ZWl2aSxTSuv9A>
 <xme:s3r7avM3iKsjp9BlXaUlI7bQU9kOlwR5b-ipe2CzeZujGe_d1mJ6gHEJZ8n-_U-Q6
 0YwtdvOmSNti4oSjtogaHme5a37whWhDj0IRLWCC7uDJfWe2gw_og0>
X-ME-Received: <xmr:s3r7ahmAIi1Oq-6tWPZJHuAYJboNWaPXqKYVPBOFKdmAoL6lIuHP9A_95cYI_6EhUoBjvqqAX4rLZfxeBmW8pms9Y6sDpAbirhHdAmr-uydc8VakjVdfh2Gqpg>
X-ME-Proxy-Cause: dmFkZTFy7iejwYF8R6pgM2a3CpNbLlro9fsD75g2yzrFNAd5PmdgvTYh1/eRSWnWpwbXu1
 HzGlgFWb5Mc6khiKfSe7BRN1Rj81GuJmBIFaiJAv6qgLhDJOFNTaISsau+71zNjhLftcQR
 tThKXPYRHDJ35YKr3GgpMxILGNcR1vRrtfuHeGzUEToUAjhCNcu/qY/WvVgUXTuPP3AQzG
 e8V3jTOnoARdVPR7ZO8iksdh0c8kdXA61/Jr4sCiGjOaEF2cz7wMg1s+Fb7Uqht3Mxjd8h
 HBjB3X5kUK3mVGVZ+b2KkYuP0BfX+FzDNfFBKEGW7jRm0nZ9iVo92bw3Ck+ZgKSAyLFEVj
 7GPazEvbx+OdER2Vhi66llvUwrB/0ofpt5VZ8BMTw/WJflM6HE537xDJKZRpxCuU6p/n09
 1SDpu350BixFPxpfuKiYHxT2v7xMmaVJa9VwBG7lP0usWCjcBsd2WLHZkU/NIQi9RZ7hJi
 y7+6495gdN7L6PawuyQb0EMwpThd/3HBcBsxGU4QGwZ/cnUlUELsY0rcSJ1Ri+suB8T6NW
 GZHQD4w7czfVvAlIqmu7n0lWVa/ZeyVeG2gApLOxg9FwrfJ2TqI4soEP161VxDFHno3cxN
 kCqYLKnLVssBv5h7Cmje0U5UoD+x4qksu7HCMGHQjynrUREkq02zyZlqVPzw
X-ME-Proxy: <xmx:s3r7ar77O4pE3CRFq0eJdhJYoLSJBKx9f1QdCd6lJjRsEpcLm6Q97g>
 <xmx:s3r7at2hayqjMn4E63HvnOON_jTu-WJZKpIkbZbSVlwNfq0zRLbycw>
 <xmx:s3r7auGW5RWldAgOwmiSfZ-rbqcAD3ejRp2uce056I2oy5LxuegpEw>
 <xmx:s3r7akjy-fUAA4O-FIv2lej8Zy4zq7qkTY0mPeFMoWDenezAJGqhjA>
 <xmx:tHr7amSKuKVaFdmu6ZCVl7b2QCpOvoXcWePJzFWX-ZoW8LWBlvHnv0n3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:42 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 5/7] hw/nvme: reject fdp.runs smaller than the lba data size
Date: Mon, 16 Nov 2026 22:50:11 +0100
Message-ID: <20261116215014.59993-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
is configured to be smaller than LBADS.

Reject such an invalid configuration upfront.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 2ae26a9acbd0..37d45bb4d533 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -485,6 +485,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     char *r, *p;
     uint16_t *ph;
 
+    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
+        error_setg(errp, "fdp.runs must be greater than or equal to the "
+                   "lba data size of the namespace");
+        return false;
+    }
+
     if (!ns->params.fdp.ruhs) {
         ns->fdp.nphs = 1;
         ph = ns->fdp.phs = g_new(uint16_t, 1);
-- 
2.53.0


