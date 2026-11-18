Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B74606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=aLWs6XtM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XYMK5epx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTf2u-0007Gp-Bw; Wed, 18 Nov 2026 07:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2s-0007FU-0A
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:50 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2q-0000lr-Bo
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:49 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9D6627A029E
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:45:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 07:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1795005947; x=1795092347; bh=dxgRb5MzaldBT7lEhA9i5Ra2ISln9URq
 P1SVjWkVvpM=; b=aLWs6XtMilKli1sQrqk9RgDVznW1LbuPjCdrjV4Pq2GsJGq4
 jU10Qa6UApS9t6YX3Pg3R5mWNv0IBxA9TO7UgJA1ciggXUJZ6rJXUgvwWqRmOvJ7
 3dDh0bG8lNEaoupNrqz3joLHuMWmtkdPOzIY+/k/uaHyOiscJIqQbLwy8C7T0NoP
 BAASpZauGWhF4xL0ZlFpTh9VHu0AZcCsbGLn2jHkRyu8+ZuDvq7JG72gKRxm2vSP
 G+gXjhfzLteOK6uV3F47lPuq4QDw5gsQUuxyUkFBR+xTeeoYXVYId//IdK1+pJ7q
 Pf7Hl67RXndFEetZ5SqyFd5KbghYFeuY3ywkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795005947; x=
 1795092347; bh=dxgRb5MzaldBT7lEhA9i5Ra2ISln9URqP1SVjWkVvpM=; b=X
 YMK5epxZrRzbCCpG7xvHLbWBD+QtXcGC+LzomwqlhaZRnYOl/+HkXNuI8Gv9Tprh
 OAYiJ10JZBLo/v4X/9c8eea5XCXA9llKkvLGVjtVW7dhyI1SlFJsuEKwB7R1uzph
 MffyJ5HsoAL/G62FC10nIj4a6dTlaWAG+p3jnRtlM2Oa9u/paFe3nbhajYJQK+id
 Lfwb2IQDn/MlKAIfoWw6/D05kNaLV5aj0/RAOZ/8PN6j35wsCYApaKFrLotQLYEU
 RUyUJtFn1rakudL74+96Ga9xC6r6X8wmC2LhrFvT2Lm9GzrLw9s61CL7oKtdP5Qp
 uud6O05pcXKrOuOgonXlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795005947; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:LzhVvw474GToU+qXOq6fJR1oQTNpAQB9hearq6fUXBKVnSO
 geUUOSli47vt+9S29YYTP29SugTOcCMTZEULwEQ67z7/G4/LmR7d9DMPCZfidEuZ
 MzpVfrvZ5oZ8NKbXOWwzEfMgNDdVU9DbBOm2q7/87d31HmvxtyM+eiCImvFA1ZVK
 Ky7XYIwmH5JbHL0SDWaCdnlB+WeK4FHhYnf6J7rdcbhoLja8GQZOz+oAmwAYWP2G
 CjIdwwmBXeI6ZAFt3XJ/d36vgmRzj5NDE7ydioqbkSYrC6q4Bfm657xwEuM2PUN/
 u7QAeV8AqoNxtgfWmNCvDEsKG/sRoeBgJg/CiqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:U3GovAEUrSGCxiJH23fF/vUCDGbDhezHtcOFLPJGQSM=:S26Cl+W51QL8iCpBweXmpQineW0djJ+K7NetBsQUFNc=;
X-ME-Sender: <xms:-539amsmD6flfGXFoXBhlbT9frOeyl96C1uuUxEzmHKgICTOV5Mmaw>
 <xme:-539ai30owCpfjxeD-8kL28VgAH1vZ7HaWAqA8Yz0tNsPBOb6bRxwhwGR8W2mlCKc
 -0xxQOdpG82tAd3Sf5bUCM1StsGaovvlPcfTkzdBEBjsBMylxFfGyi4>
X-ME-Received: <xmr:-539anVpebFGM_AFTC1lFgwUqDqL-UvdMskbeyla27q66bnQeCvjOMzri53Gpzigilk7zwSq_Mfmh6W9G40uQZ4>
X-ME-Proxy-Cause: dmFkZTFMzlKcAbeg7nCayXFh3m2ixILkVmRb1Jmm7Bn8QvOUB0ggmGBrZ9PayJ3c1eVXeU
 qW2OOrtTggFL8Lcvr44gEgfOsvJxFX2cyph9Trb25fT/PMWf+OvgLpy4A5bcKDyuNMmzBz
 gbAFtLA3C6n6STIW+xvIfPW76HZ3IdjBZ3wq8Ov6lMh0wUHiyt4l1ktl1+iY6Evd4w/5vQ
 DgYOIHvaSko2UiDcDKUtHXRnz8V8yfeGxFGtqtRBkSJoxa9fhrZk08PaNSx6Aw88y8MngN
 vFr7A5pVva5tNYHBpXOk7RJGLdQ+wYwrUXwo9NkHkol/oxAg+/lE0LasMLlMdfSe/uzzGP
 Qer0zAYi3dk8GiRBxVMmI2bX4eRL8HrjRsd7aXrJolUXdrmDk0xWF9p2VlxqB9VhmCwk3v
 FSnXsya0DJIf/rr7RTCN44O678ICBjdesGsYPlYJwXjvLRcs8zvfxcjFSZs5zmyAbt6Mu7
 moyHAwTqvPPsF63znNYpki+sevodsUgsEHN8A2R65xPLw2qrIWIFhYGtt97j6GjiYlpS/m
 JGlBB0PKY7WV1Jj5gA+2T+VURKselpR0hXY+wUNmLDr/4RbT0AklCcIQ5QZn8d7gnAWd0j
 IKKmupyDbm2bQ86BVjq2iAucTQYNZMV/XM9GKU2j1+YVUpT5qxK/a6p8QkqA
X-ME-Proxy: <xmx:-539atLgkD6eUv6AfAq2JjObDFRNBnBD75BuUl1kS8nRi4y4XtM-Xw>
 <xmx:-539ap3T87kpSCV2tRXbyfvo60CHxoFsq-jIvX-R6b9y8eJs1pBejQ>
 <xmx:-539aj78YL8qFHdZ6Cslv5xFl0JpisR8hoiWZbpbr4xxeUS4vuTS0g>
 <xmx:-539ai96YD5G1or62EsBjCzzbsx9ujkAPZDeUM_IOF_-LOdBGAq7tw>
 <xmx:-539amXKrXzPq3mOHk7YjLh9EjikaeJmE3dHboJ6PXPl64DQPUM7q-k4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:45:46 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 18 Nov 2026 13:45:36 +0100
Subject: [PATCH 3/3] hw/nvme: advance zone write pointer only once the
 write is committed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fix-4520-v1-3-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
In-Reply-To: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=nTu5ppxMK2vp5KIlxBj+Dz6/PDQ4yv6p4vhdW7sLuRg=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I5bmZCTXlVNDBEKzdUazkzaVVCZG1OdXBSCi8vYmNxbnRTWjQvRzU0QTk0
 NXJTcElrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9aM3d
 BQW9KRUUzaHJ6RnRUdzNwRXRzSUFJZHlDN0tOY3Zxcy80YmJSbnZUemRvcHFoc2FxSlVBclhJYQ
 pQME1mUmdPWWJPbHlwUlN5WUs4cUVQTW9VVTBaOWRKN0wxYWZSUXBJMkpmdTdqWVNQQ3dqc0ZCO
 Uczb25DZ2RHCnp3bjdSNDRWOW9QK3RIWHo0WjZ1ZU95ME5BWnR1eHlFSHh5V2VoZEw3QnVxaTFO
 K0VWWWdOQm5PeDByQVNDQXEKSHJkQ1ZBVHpud3pSQ2lHemxnV0pxY3Foa3grRFhHVFBCY081Umd
 4Q0FoTXpMd0pycFhoZ3hRd05obTh2WllZaQp3YWRMZDhMYy95di9JR1U4TFQybTJ1M29rd09OaG
 x0c1hvakVFbHRWeElUdnhIVjdGVHBMUlRlZTl1dERTQWk1CmJTZTcwVEJubHllL3Y5c1E2U3JZU
 DJYTUJLNHQ3YjBGTUN2NHloREhCY1lhV2pQSGlBLzVoYUNoCj1vbHAzCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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

nvme_do_write stages the updated zone write pointer before data is
mapped. If that fails, the write pointer update is already staged and
subsequent writes will be rejected if attempted at the original
position.

Move the staging down.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 975b64665048 ("hw/block/nvme: refactor zone resource management")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 35e2c57851ae..5755aad1fa72 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3800,7 +3800,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
-    NvmeZone *zone;
+    NvmeZone *zone = NULL;
     NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
@@ -3893,10 +3893,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
         if (status) {
             goto invalid;
         }
-
-        if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
-            zone->w_ptr += nlb;
-        }
     } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
         nvme_do_write_fdp(n, req, slba, nlb);
     }
@@ -3904,7 +3900,13 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     data_offset = nvme_l2b(ns, slba);
 
     if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-        return nvme_dif_rw(n, req);
+        status = nvme_dif_rw(n, req);
+
+        if (status != NVME_NO_COMPLETE) {
+            return status;
+        }
+
+        goto out;
     }
 
     if (!wrz) {
@@ -3922,6 +3924,11 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
                                            req);
     }
 
+out:
+    if (ns->params.zoned && !(zone->d.za & NVME_ZA_ZRWA_VALID)) {
+        zone->w_ptr += nlb;
+    }
+
     return NVME_NO_COMPLETE;
 
 invalid:

-- 
2.53.0


