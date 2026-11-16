Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC21606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=KKGNlyw8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RaFAs0F6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bs-00015U-B8; Mon, 16 Nov 2026 16:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4bP-0000ZU-6K
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:51:06 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4bM-0005iQ-GQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:51:01 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CCB7C7A00C6
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 16:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794865849; x=
 1794952249; bh=hg/nfdaLuv3cSRj4xPBlxqvtgqssfNexReQpgCtwlXQ=; b=K
 KGNlyw8KuMFosJ+D3Vwbd3/m/4B4SOXtYfjIaopFUBztGSAZpZto7HvpRYHuwqCi
 j6Mc/WnDmFZHrIjIDqutH3YhOEG5qVB4NQkg2OMZ6CoKCe8dGH2hP0TPn6/kMEZQ
 XtWuw8mvbVxItLdGZ3Ld2V/muYMXnIX4w0wpiBhciC25nS3m8KNej6myk+hZnl4w
 eUWuAE81bsFoJvKC4DoKqgYr97eHgM6xZQkbRUpbkiHcKOvvwA7oCGXgSwipclSL
 kfSjKanO2RAvlINVcVIrcJdE4H4S7nvvwzXFCQU9QHUIWYG1pwzdBz2Z2r/ZNDni
 hU2yQBeJit5ftjeB1qzFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794865849; x=1794952249; bh=h
 g/nfdaLuv3cSRj4xPBlxqvtgqssfNexReQpgCtwlXQ=; b=RaFAs0F6dRfSsjYx6
 XxOUGwLd6Pt6ZzLfwQqFJtAq9mqzSq6JJKgWhN+GDO7iswgZi/4NngJ7/0rXJG07
 5ch668nxMVMHe0KZvU9ItCTqQiH8pwUq7XNEcHGElVAH3ItPwbY3SVLSmwMAQ/Vn
 X7tr3aWveRjB07x0dhKlSIFMSNrYJf4gU5EulpZa2w22L6hbRi013Q+xdahRvv4u
 nagyv74cIoxuzPcimSpG7INzqHAfzdmh1NjdeH0zfoWp+0YHtRC28EO5Mlq5mTSs
 7mVh+hhpAav0t6P/L/ucge0dwO1CNxs10YLMb2eG8Y+btOajXp4npUhJjPaXzt99
 9KQzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865849; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:BhKP/66Lq4tHyIMMN1nrGF+Pv7dhSZv/S7o/C8d4cUjbMfO
 wCAE+ngfTJl0l1QJEJj4UJZo+hQVY0LW3xUpyAv6yCLJKJoetT4a+bFYh9sNtS+K
 mMfgRpikXBgTw7WKdm6/wOl7A5DR9TeAv9iJN3CEDsaYsqZuz3uDGNdy4ZW29uTE
 uvX7Qk5LluDgQs71cPxjlVvLqDjFTzjo2RExMbgOtUFwDNqz3HBtrvsouqx8n0Yz
 WsuAwMmxYkMmvO3lkExS+QerqKjmHF2CbR0Yd97HZj+Ae1aSzab7M+OVB8183zYi
 3vRZeI5EnfnUidMC9WhyamKv3G8p0LVec+BBIgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:utUnPTvA9icpEIYjOk+ffNJC4Y1KgR7BeLQV8XLlHiI=:PwOBXO1ymwFg1xrA0ttO8qA2Vt6g81a+dcmjNC24VFU=;
X-ME-Sender: <xms:uXr7anQ-VCAI3_8ZtA6Cr7rnoIWCIOa-MTIuBAjAy6M5Z2yYDAma5g>
 <xme:uXr7agYrxRLGOOfCCJEWunlXC_hgVXexm5RocqFe7zrO1rHHQYgb2cqt9TXc-wzP5
 TjNO9iWdCkx21RKU-RlNKS_U-J8bo_8K3pMQGonKka8XcwSdcDkZThb>
X-ME-Received: <xmr:uXr7aqewi458KryxxrO5oii5rKyCq48lKBXlg6reiJ10a0-7xdtUaL6TnNc7-Wy5czqMLv1VUW4mQ_OhCg7sBu5mJaGJmZJw-htoMe3uZuhtDIp6lDJtvzV4wg>
X-ME-Proxy-Cause: dmFkZTEV+RmlZ3Jobw8xLg0FFfmh/l+nEcXFjda+0aGwP3bTjJPyGQk8VX8ANMfPlOeNHy
 53bHciVCYz+f7Isfonp4Ez+Zz6s4TGaW55UuCN5Hh1mi5vDIp6pN1TcxFADIdGx0JQFZjn
 5IbSEPmX0bf1j0E/HYhZ0SWuId1PchdDBYQ65Z/Ftmkq4+X+OQajv6lDNSW4XCzDnaztoy
 C0RjapWPT9ZVvjn/qsSyF5r3Xyo5CFpsAzjgoWXy+jMui1OeGZjrpkKgharlApXDSEf9UL
 sCpJNJxR/h6dLWZY+Qj3Rnbc71zjq4oS9MeM3munjvMqvDGe+Yj2UYFQ9djqTWiSRKNXUW
 rh2Hto0VKt1W3Y2T/YRsmXlODMkWKgNQaOtqmZqYi1RcMFuFawC/uFdErxVo6bPUkgjWnS
 flgxVVGN6gCB9Qz+nAOMEca0S2JCh6olxeSUa2paOaUjeWodVGZP3Bw4EPwacLR/792cYZ
 tw6yFpYh2KW8AjXs1eBTqYQHMKXi5qDmmGc6hTCgSRMNi1RY9wi/0nwe2JsG8N8z4uFpQy
 i8l+ZhcheneHcgJ5Cvij6dolbKJ9pCvGUnPxmd6s/XfZfzbTYAtvQpfjV9hJFaGhFFrPg9
 uXz0lnlEsWkmtVx8dtnwDCexi9eK0rVDepLj3ZZ7F7j4KFWxOu1NTiLd33GQ
X-ME-Proxy: <xmx:uXr7ahL_sHHPSUio4DN1UGVhbjU5GzCRXmtX4DfDizDpHBGJdPTgtQ>
 <xmx:uXr7anLkB6M_WE2hrE2H8wpFLShi9z8H1gHGLYQzldZN0oNM_gGHZA>
 <xmx:uXr7agU_8R7o9I-moBJjBstDdyEnPM83alqz479Fhed7MRxyEDnj0w>
 <xmx:uXr7aglRqjqX2NxxnbQ8-Y2lrN8VolNmcmcRYxjUcJZ7iGULTRXo7A>
 <xmx:uXr7ahgm8rOOwYuFIGHIRS971KcwP77-rDZMklWdB1XNfV2VWheNWxCE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:48 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 7/7] hw/nvme: fix broadcast fdp events handling
Date: Mon, 16 Nov 2026 22:50:13 +0100
Message-ID: <20261116215014.59993-8-its@irrelevant.dk>
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

The Set Features handler for the FDP Events feature asserts that a
namespace is passed in the command because the feature is
namespace-specific. An invalid namespace is rejected prior to reaching
the handler, but the "broadcast nsid" (0xFFFFFFFF) is considered valid
and causes the assert to abort QEMU.

Reject it with Invalid Field in Command instead as per the
specification.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4792
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a0d22dacedfa..71c24dc02b67 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6636,7 +6636,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     g_autofree uint8_t *events = NULL;
     NvmeRuHandle *ruh = NULL;
 
-    assert(ns);
+    if (!ns) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
 
     if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
         return NVME_FDP_DISABLED | NVME_DNR;
-- 
2.53.0


