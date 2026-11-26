Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC165606A337
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=V8b/k5KA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4NeO7PWD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWVUS-0004pp-JW; Thu, 26 Nov 2026 04:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWVUQ-0004p0-8a
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:10:02 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWVUN-0001qu-J5
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:10:01 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 3D45C1D0058A
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 04:09:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 26 Nov 2026 04:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1795684198; x=
 1795770598; bh=bxMqqKPIpGcMF/m2fyLXLt035QNtwA1y0obzAAa/G6I=; b=V
 8b/k5KAkn/oz/4XscsYtlxkhHapzjKhpNosKH2RqR+CLsy2SI5xkIcZngHodZLVp
 zpCjirg4ogVnaJ5h5jWkLvpYAVPI18ZCz2yh4KmzHMQf6CcxI93j337DvdTOVh73
 A0dYIwqf1kQJnwDqzYeYi5RYezrz64pQLjV6gFGFp+wkZ2PwvddvOvGcygEm9FVh
 q3UVDDbk5Oyhf7pSsnHxVxfVb47f8qF5bTD34xBNhRUIr7Ukf22KmKKpVpzA5LeC
 Q/MGKg8zZu+dYDEippQa1ep4a5Jg2yrpSk3+WGhMUaVk2HfynHpFvmZzDDReoMpC
 0mFQ5ArCJ4SsfVb/eCdsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795684198; x=1795770598; bh=bxMqqKPIpGcMF/m2fyLXLt035QNt
 wA1y0obzAAa/G6I=; b=4NeO7PWD0bpBRob9T34WUsmzeHP8g1ZBUeF5UwTu3v7J
 7wo1WWt9ogfa2Wz03YpyMmFM+bINI4Lbm3KBRFtrINn+H3+j6qYGX5/5SwDVvWR9
 UB8tMqZUzZU29xYbhwjD/lwpD6hg805oqJFHbw2U/s0VzeW/P2qai/fR+uAIJyuK
 gCx79KKO+FshQ6e7UTILND8J7cxnqC1jynVdxG32q6l3r+mUaDGqifk6ktc/AymZ
 HNJR/DzEYSTZSgRynOoB5eFqLj1ACtIhinCYQNNkRcU6UFXRbvGs99BOjuJtLLDc
 U+msnhpmq5qEUEPReladplvZ9MRTbFFQXIYvG1Sszg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795684198; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:Nb5NuNK2rbEDEW4Jfe2lGwIrqhVuFRngtFqebyxIsVDXRC7
 cLk62Mveme1tlvt7xLBKcWE0NXZB+CFx4r8k9rRuJwEqIuVHUygizlssYV/AU/6B
 uHOyeaWqtmFMcpe1eiKediKmUxdxZC6dMdm1ghxiBwgVdYZCcQNUoqOZsT2vJ1f7
 KvSvubleINXb4rD/vRPGlmlUpm6jHiOlJYPvTzw0m0mC6SKfM6JUkTTIAIYpYz9V
 3LU0bEa3EqRqbJ4XYfoNHps+Iw4VdnWI91v66CRlWwe6pvRjwMBMERfIGldBM30G
 dl9VPFOKLKYzO51u/qLnSrbDI8vVIKI0s6VcfaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:RKvkTW+qmnZSvf3zyqJssER/8eOH927+0L7egYLVjv4=:TiFwvYLwE6YYkPCtZB0IIhETwoz0x8pSDCUA7+b+ves=;
X-ME-Sender: <xms:ZfcHa2SzRWxloNYyHOd9zAbbQ1DobF9Lv4ghW4kJyy5LWvzqqwbvAw>
 <xme:ZfcHa2tYOWCgtQeVlULRUe7onREM4x7-cjghJFL38YbIzwBI7ArVT1FcPg3En54zX
 5QIvFhwRQF2lpw_8l7rDrskXd_-LJRdnWk4gVTn8F2_8V61gLouHg0>
X-ME-Received: <xmr:ZfcHay0-h9iRAyjqPWL574yVBmkCEo_ab3ZyIJuRVVVrtJ3otWRhn_S131-Qhc6JZHyUEt2y6Y2Dw0IYBWPAF5bX8cHHrY9-REvaSXRunELw6VXRfFKGGvbWkg>
X-ME-Proxy-Cause: dmFkZTFDq7onSLxmSMiSY3DkbhCSZnimU8jagqZX0E7qPzMEGXqqQWFVZ7Ri09n5wqnoo9
 ozMc0JTg7riecxX+IAzpvIkTLEpbwuYOvRwj70DQTmAORK0/Gz8wbbUJLM2uflw+24HiFZ
 ffTJ44FfSmHJ4LESxLEGWIPpYirsSRkJlIAko16rq7p1DLvQmSbu8qehaSE8zXqOM/hfi0
 l6Ukack9dhsudr6iX9vUxnz0zGhExgKvzr5ymF3sMWQ4F80V/v6/YySZriPpNP7bIAtpsO
 PibyhJ9HkzrQykmEl0Imjqsw69GElutA+1JhAZsWC47K/l8dU1c1yzCqAtLGh0im+9BPuA
 7YsW6hNPYxEOAnsr1J9imlXPzz5c8btBXniG27k3/LtBd+bsT6qqlpqVa2EVk9Vksgtec6
 2d++WIVk9Kc4rCxsH6Op5hx/VrpHnimbgXpHLh6ju5cy2yxQi5zMS5RzWvn1vdPOZFG7ow
 CbnqgeDl1TIwYDw6JA80/BYj9dScD+XDztd1fuE1E/pEXVUbkXP/LOI4QVuXrQaihV3jkN
 FYIwepitR2WBartVzbJGIsa2HpRo8uBq9HHOQAuJTOeL8aLA6A+ECFYdVMbxMupaIxTijV
 PAvtlp+ZUe0egORc7aZFu1DdIO+5iYUNnzCwISzpRJeiDTMMh3/Yc89XaG+w
X-ME-Proxy: <xmx:ZfcHa3XruwlLL1Nt5AGnYlMk_7SElcG1TyByt9nddpd8k4P13FW66g>
 <xmx:ZfcHa9I6rmsrkOwqd_4hjIFAJGMd4RpmHAOa4e6E-4zBj7Amy5jCng>
 <xmx:ZfcHa50lT0aX3IfTl4KedjUnQ7bVn1-zHQD7Y5yXSbpfZwMWthpOQg>
 <xmx:ZfcHaz7m7iWKE2tnDnzJqgDKzbXOrTN1L1Shnwp5UmI-DKdVp41clA>
 <xmx:ZvcHa1sVlC24fqVcIsHmqcFx0GrcDPU06MvJdEzDmLezycKxWplTudCJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 04:09:56 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 26 Nov 2026 10:09:55 +0100
Subject: [PATCH] hw/nvme: fix pin-based irq assertion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-fix-4520-intx-assert-v1-1-bd20dd253365@samsung.com>
X-B4-Tracking: v=1; b=H4sIAGL3B2sC/yWMSwqDUAwAryJZN2DiB+lVShd+ok0Xr+XlKYJ4d
 6MuB2ZmA5OoYvDMNoiyqOkvONAjg/7ThklQB2fgnGsirnHUFcuKc9SQVmzN+4RUNQWXNDZUDOD
 pP4p71/b1vtnm7it9Ol+w7wf7Yjr0eAAAAA==
X-Change-ID: 20261126-fix-4520-intx-assert-1583241f813d
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=9YEW3YNwk7M/b/vFc0OGY9lc7+ObOiz32B/Gu5GwGkM=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3NIOTJRS1V3YXR3eHNTb0tTZGlQOGhUR1FpClg2R0RJVGMxajRnZ2wxU0Qz
 bDIzajRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKckIvZGt
 BQW9KRUUzaHJ6RnRUdzNweHpzSC9pcmxrWDFsaTFHOGJ3d2RNanFTSENybmhpZ0RsekZ6dzNqRA
 pTRE8xblJKQTNhUFYvWU5xc08rV1I1dGdiaXRBMllFUCsrZ2JVQ3JjcktGVmZObDhrSlFHamlqW
 DlBK0NhSTI2CnMvdFpCc3EramlMQzd5eCthdEZ3RkMydWxleUlXVVplZHd2VHhxSUMvTjgyUDZY
 V3l4dXNnSG5ndVpLd2EyZUQKY2o0ajZ5VDN1MFBNNDhxckRXdXpzcjJ6WUtxVkY0WXgySXRIbVl
 WbEJ5OTRmNEx3MWpnV29tS205c2VnZUUvaAprbE8rR1c3T2pSMzd3cEZ0SUk3OC8wWk1SWTk0dj
 VCRjlxaWMwWDA3bGhweUptb0VPazBaM0Npa2lLTTBZVFJRCmUvUlAvbWZTQUtTR2hOUHZML0RPL
 25BMHZuaDUrL0RmWDhmU2JLNjRWamRpL2VQZ091Y0J6YTBzCj1zUFJECi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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

If an existing queue uses a vector larger than 31 (MSI-X) and the host
then disables MSI-X, the next completion on that queue hits the
pin-based interrupt path and an assert on the vector number fires.

Only intentionally bad-behaving guests would hit this, but replace the
asserts with a check and fix potential undefined behavior in the
following shift too.

Cc: qemu-stable@nongnu.org
Fixes: ca247d35098d ("hw/block/nvme: fix pin-based interrupt behavior")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4077
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5755aad1fa72..4858bd41552c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -688,8 +688,9 @@ static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
             msix_notify(pci, cq->vector);
         } else {
             trace_pci_nvme_irq_pin();
-            assert(cq->vector < 32);
-            n->irq_status |= 1 << cq->vector;
+            if (cq->vector < 32) {
+                n->irq_status |= 1U << cq->vector;
+            }
             nvme_irq_check(n);
         }
     } else {
@@ -703,9 +704,8 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
         if (msix_enabled(PCI_DEVICE(n))) {
             return;
         } else {
-            assert(cq->vector < 32);
-            if (!n->cq_pending) {
-                n->irq_status &= ~(1 << cq->vector);
+            if (!n->cq_pending && cq->vector < 32) {
+                n->irq_status &= ~(1U << cq->vector);
             }
             nvme_irq_check(n);
         }

---
base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
change-id: 20261126-fix-4520-intx-assert-1583241f813d

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


