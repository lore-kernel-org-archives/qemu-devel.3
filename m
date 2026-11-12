Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F561606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=jtIfQzum;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wvo6zE+d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRVY-00078G-Ma; Thu, 12 Nov 2026 04:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV9-0006sP-9M
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:54 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV6-0003WD-In
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:49 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id CF2EF1D00171
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794477227; x=1794563627; bh=YwTgv3LNyz/pCfRoAKxnGKvSiswVvmJ8
 mCJJO0GputY=; b=jtIfQzumHypNqvLbv1y3Jg1y4QA0KBZwh1Y42vmX6JbKQvbc
 DwXa+1RkrSau7sxY+I5nA7sD7JGRz683aMwSdfUkC3YGLtHPTZgTwH4q+RtE8r/+
 ukywqVgy5bEvq8iqUGJ8idp3xnhlIqlwyuKyMFLtCmExtl2jGzCRYr1nPR9tTKpl
 +STc+Rjdgb9T4/Cl42jT5XAR/Vp5Em9Mh2gR8/RdX4Vy4hRDw00LybVG1J+E0eo/
 A5gPaZaC/pseTjIvA8wPjGophDDonRzuDabE3IvEhdVwAkLdOBO8Z5rnbf4A6Atx
 t9HkyfE91B9Qf75/qACN8MlKHsIALd38hqINPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794477227; x=
 1794563627; bh=YwTgv3LNyz/pCfRoAKxnGKvSiswVvmJ8mCJJO0GputY=; b=W
 vo6zE+df3rAYrUy6RzUKNHe28gOQ0iYuVr1b/UNkfsfLNgdjOMQo7wb8UyDunM3V
 KLNus7RnTkbGrcqfH8R24vATswkySVAZ40qiXLAZOdsRQFXPOF438UDht/k5DOks
 eqiSoMnwpqtOENS89aiPb7IDZ95HeZ3mE+FRnPcBhpGlGSLVq1rmwf8YJUx1iO5F
 WCv0hT8wZbLD1dsp7/F1do3D6yBn/9Ao02Gk+Ws9doG1V790Q+oq2gnggUdrAfX2
 RXBaOIdKqw0M7v0Qq/o/PRBiGr5ijin8UsqLAhJTsae/NeH0VqsnnfCo8cCfPEmd
 sMumGDRDooXJnLUkzMtIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794477227; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ahVL1w5GmCaqRyS1HJKop0J01UXTC3ri0tRCM6ZIHo5H9Vu
 ji1ephStofRP0o9mPlfPA3FENtw+pX8qrg230d9ukq/BAagcyiuv3p84sXMChj3t
 Jav64pYD6hHk54BZ5LUchu8Vh3JsozLujljLINYxbTMJgjxgs2PN+y0h/DSLvrJ8
 6UrHk9gECZokcmFu1Howg2dBwkV4SD+8D7jcpcfXd7inLCouB/Lq1WAYVX26S8d0
 hNR+QIIxmfDJbtsqXJI6DkIc67F7JORRMcLrbDxNgDYfDA1ipvdkbob90C7aLqVr
 2q5yEAciC4WlokZ7DYfGjsNr2bCqw2tCSYZxlsg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:2HF+RdRFF2cmU9cwhek2F1TUifAeDPr84mxmHAZnlcM=:BDjNZ2E7EsZsZT20QI8yKbPqXdQujFzvU2ndPRU5Gp8=;
X-ME-Sender: <xms:qoz1aszcARK7tfMrguqXMci2-Lawrr_NFwz1zfiFPaQ1JHrUny7vtg>
 <xme:qoz1apOkNs8zQ7HNZesotkZIunNWr7Z-wSsheRwHNDZQPJvYIPnfd4-eUv8AHhZsK
 _RSYdqCTWrNvieAtgBa4V-7dVwkumVezoA0ZlB5nDTpH_hUO0fi8FtT>
X-ME-Received: <xmr:qoz1ap5s3dmhM2UraLl0f4QNu7CB1JH6E2nOacL_E-7yAQ8PKSNFXJa722jhH8MbYyfGA0B6G30EOqfdE_jdf_g>
X-ME-Proxy-Cause: dmFkZTEGowBYOuHyIEL9+MqUTJcFdgm8eB1mS6oW7NDPoxBCrBDmru1lBWLntlCNATWU9a
 lZfcJ2yUX4BIlGEKODiGmz8QAGxDIWKtkoo1iS06emXPW8CdE53FcXqdvUIRv6j4qqlSZR
 6IVxx7Fa8lAc8J00UDrgzoPmW3lr3BEZJYQ8lhKMTXKzo9SvDAJdMW+MktDtI6ZnDkB0Sa
 KUGUXK5TV4jI0/uD13gRZXU0pIaBip1HiWQrCzPNzlwGuckCT04xjv5fn42pnB6hI7xwXd
 I0AObkoXBWCcMrF+QOPuwg1YiYgsc7iNpOaIuDC9uDX37MIWjvDCx+7AJ0aCxnHWb23vW7
 qexB4i5liktqxr9lc1BG0LEMDpq5O6nWp6ZdxyXXgBLwCpXB46DfOK/t5ONlPUKmcZkaOQ
 CzB0HwA9sBtR2kWFozMBKOhFJJuVVkTkX3ABxLEuuhSeuR5lvcdSRut/qw8w7Hb5YTAK5G
 vSTUPYNSOjgsC874JzrMM+ZXnstma4kBo0UshcZeXSw2w+1cVqJM9eYMlY7dYYdj+Z3VnK
 47ncOm+2/sdJ4T+TQWLebXg9vDq8sWg/Of4RwUBT8TxivVse+ano6GTVdpBm+wZRFVIyZB
 1koG9zdsG7KmRbp26iwnQrrc+u/DHaMh4LOW2pj/NjiyGUbTZg+fPwOsBa8w
X-ME-Proxy: <xmx:qoz1aql09s96cg-F-wyoWjU-7zGimxMsT2d5jNm7F2qK4OxXUI_p2g>
 <xmx:qoz1aqTcTlsbNXI3060gWkEy8rC6x3K_fXnIlCS0obTjxpCr-qAYUw>
 <xmx:qoz1apG57D3n7F5bDQtRKiSuE3m1uyCRZS_oD9yF172SuPyltnOK1A>
 <xmx:qoz1avEXpUKnNM8B8hhlZzhkaocqaaBfPkcB72yH9rARcwKsehQKUg>
 <xmx:q4z1aohzemr8h54Mlp47ftD5M4GsvOQAtMBa72YOGwl_a8ijKj5je77Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 04:53:45 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 12 Nov 2026 10:53:30 +0100
Subject: [PATCH 3/3] hw/nvme: fix broadcast fdp events handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nvme-for-rc-v1-3-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=Dy8qO1O27odl73NekMuhMZ0dyB9d1hPStpTsNlBCnDw=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IxaktLemgrN1RvTTVIeTIvNjI5VndZNnIyCmFRV2ZDbHFWcVEyOFcrRkJF
 WGdMV1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTlZeWl
 BQW9KRUUzaHJ6RnRUdzNwVWNvSC9ScTc0U25qbmZjVXp1YnVvNDZHQTcrKzFMSktIdTEzMWJ2Yg
 o4NGpzTk1zR3JUdVJOVzRtUWRtMlpscmtDVEtIeWF0RENsS2FJMUVJb2Ftcko4bFUyejl5SGhqN
 UxINURwa0hYCmxNczlFUFAwMUluTExnZnV6cGgxbm1MYllBa1c5RVZtYW5RdDFSRUJuV3RBRUFP
 RmsvL3JIOURDUDBXMnlOenAKdnFkWkJ2MU1zbGpwdjkyMWJiVE9jRW50VHhXRWFra2M5cGVvbmE
 0c0ZDVUgwZnVNa1pKcGdxY3BrNGkzamkvUgpSQ3pXdVY4RmJHKzJXbDR5WTdiQm5RY3NoVFJNT3
 JqcHk0a3BRTktWZ2hsWjI2bUlGZy9RdEkxOE1tZmpNckVFCm9pL2psQkh5NWtPUFlmYUVXQnRxe
 nR6TThPR3czMkZ1YmJpTGJ3amZsTlNzelVnQ1BzbTNpYStzCj1zWEZWCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4792
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


