Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09435606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=EerXxB+d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uw0vLvTq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo3o-0007sR-4r; Fri, 13 Nov 2026 04:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3m-0007rt-Kw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:59:06 -0500
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3l-0004W3-4r
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:59:06 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.phl.internal (Postfix) with ESMTP id D4D991382257
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:58:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 04:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794563932; x=1794571132; bh=lvDx2zS5hnxkVV6y+Wp9xY6T21L02EKL
 57bJmmWL/QE=; b=EerXxB+dzxTjGENFMJ0sI4QXIjOUCzWe0sXt+JRu4pqfxIA4
 XR5si1I/VsXrDxyQ/n1XilFLjGdiHwAuyEI+z4J+rW8+ijLNmAiOirZpEMT4zC3W
 ruiDE9GJNCllFRWKcGqK3S8lIIbC3BoMkxiHoxK8+Cc3HS/RTBuZPEn41TCmh2q5
 rvowmoiIaYNkShIWe49B6gg7jl8VmUkSBMy3+lNJuk9tZvexAr/SitUnptfuMoH1
 afYdDmR+pQIHBums9kR7Fb2EN7ojSH4B+5FTotENhv+esFFXURx7b1fTheJyJXOB
 tvh6X5crV5jb0Ju3ierWqMyPVUFpbxWoJ5gTdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794563932; x=
 1794571132; bh=lvDx2zS5hnxkVV6y+Wp9xY6T21L02EKL57bJmmWL/QE=; b=U
 w0vLvTq+ZBmNNWMLf+wQ5pIecfi7WMmmezHtxOisHAxA8aSLOJy/PnKo8veUDLyq
 FqS510PhcaTDV4nWXG+1ym81eeY1CKLTN+/56NRWH+XQp/BkuZDga7AaJ7dAXdU/
 Uja+9PVKImFixoNyfwr9DTJjotUCw52NuJ8cnmpVakxP0lVkMFpbD1V6Mg1Jnknb
 5WC8rQBvO8re98B/q/GIXAc6n+7PX5GSiyZBu0Y0rl3mtl8S8Eh9KjbOUNykDwL/
 cYyTQ/BUwEXwaIVeQ7bbhRZ8T06rJaQA34dwPjTuvdk/z3HSKo2GlOskxvQN2bm7
 wlAb2qzLEWeRoMVGCoeQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794563932; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:PXtLkkFt2hyxRHaIcgLs3uw3SOBzS/PZmEhG7Ola5ktSOd8
 NkVpwktKp5+8UYf+HDHgeFlCBTs0Rz40AaQis+owuNjJKcblmgGYCB6IRFIydZgc
 btxGQFurMzmCUz/7I1gpBrqoOLx+Bn049oc9kos2gZGrjJCSsDD7CMKs79177GQo
 1P0zW9NaHb4Raxc+TN/GBkaxs3UN6pcbsujYXe2Cx7ZExiqaZ25b1JTEV7pRgudW
 DUwn4TaqfUPdF3SGZOpfe8YmxtzXdtA2wGnMuHs6Zb6trA8xe5X09GEySYoX7A9G
 FdcL4P9dHMjK/5+2Dl5NTmy/Ew91kqMxJYr04oQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:myVBYRiy/F0UlvrbpLCc7KOKGyfCNrna/vWdVzzBZT0=:vQSgMx56b5PHsEtbFLH0UX/qr5zEnWHiUk3lJd3QrSY=;
X-ME-Sender: <xms:XN_2aksnxwWBz2stfbOBtKv6OzbJlo-HJrMJSDRfDgTpRMDei4ir1w>
 <xme:XN_2asY7bTW1NbJ9gLI2ApBw1FJ_uQQh4LHcU-FEcFFbF7SHpyNhkn74cr25Tkqrx
 YT57o8E4CyqU6O55xInZm1mLvM_aTgA4JS90A-3tsP5B9Uhwe7Jouz5>
X-ME-Received: <xmr:XN_2auzNxr83ErCWjtYl10wkCUTCn5hmzhpwZ7_imxozMJHT2KCEsY5Bwc0ZiJYtFGYUm4gnD1BaTwamF8NM_Q9g>
X-ME-Proxy-Cause: dmFkZTGoW/r+HHkPvpDPhLJ23+QC4nYba1HxO91KJlnQiR9zkGCwEYw+hslx7rW1vDbE4+
 kz5VFVK/snpzGpHFah5+BrQC5Odi347Kgy2Mlr5HAFrBCN6MezvbAWNNiSKcqirBY4p9YX
 Ku8dAAjbQsE4uZSQQ2Syh0wYsOxS/RAvnuRHNaXbbHga8A5xc+kCsfPUk9C/MLQ0RFzI+V
 28Zx/R3JCwUdoXIA8xPHpDV9qjOGPp4XXUOEV6BJxGO/m3rCoWoHVH2BcSg1+XollOGVCj
 rAyb3zo9XG9yafFAn9+wIglY5hkk3wGupF0KxnPeauCJX1uNNPPE5qwh7TjjzAKlG28qay
 C+QjPJe/Np75Md2tpnWK8+BEEdpVQVYHjDFDAQ1XytaF/2TZctQjG01WQfUEcgc62OAYkE
 P3752o9da1xXzCUFm5mcutA++wUHbxu5sHXWjoH6iQGUBYaQ9fC1/eQE9Edmf+iaXJKB1P
 LJkgEeNyYwkG4jON1saB8RCw9v+c1gEbe3nPBniskMkeSAndXzD2e5Zc3V7V8MrIl55XPS
 9bTYpNrGGYIXU/eiB7gMstizM/VQyhHOFh8G2FcjBw8ASugF9WQcRJgee7b0OG4AFoqx30
 AdKYWecNgWajpOff2A+f6sOkk5GLLfk3YLXEdgGLkR1ixvIk+/j+6TS40wPQ
X-ME-Proxy: <xmx:XN_2asi5BcFB7XGpgA04uEF4GkTrusjTU2skmltH1f8AAh5GnOjH3w>
 <xmx:XN_2aimm_fORfS9mjhAGV1hHZDLVQ905uti_IplwGwyVNBT2-zBqmg>
 <xmx:XN_2aqgDxBAMllhlY9pxSR8JMymA89Lmjst8_7TrSJsoLoAcqmCFvg>
 <xmx:XN_2au1SU5XWWlt6VSM47_rQjIu0DOaISMvUSko3yFJ8MSRPJu_TJg>
 <xmx:XN_2aizD16NKOIhljkL4kgYliAJyTBSFNQy1UpDRnREkRZJJ0thYlMYF>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 04:58:51 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 13 Nov 2026 10:58:40 +0100
Subject: [PATCH v2 3/3] hw/nvme: fix broadcast fdp events handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-for-rc-v2-3-e458fd0e12ca@samsung.com>
References: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
In-Reply-To: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=bZ6FSzTGekAUrxfzNnfqXvXj92ap8NZ8rnIXtCAZxwQ=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IyMzFaQmFjQkExalNuaWM0VnpzVloycnNZCmhQVTZSSGpSdElKdjRabmtk
 dHpiVUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTl0OVd
 BQW9KRUUzaHJ6RnRUdzNwMjNvSC9pR2p0OWdYcFJwZG5OdDMwNGlSR2p1SnVRalh3eEVsUGthRw
 oyUDBaMVNzdSsyTzloWTZtMXo0bWYzMTB3SXdvMlpaeTk4d1Zla1Qxbm9zTmo4bENldUhsZDBHR
 k1NL2ZkUmd2CnI1TVZMQ01GOHh1cWxpdjczYSswaXAyZUlwM21nMTNmTzFzMDYzZTBocytkbFh6
 aG10WGN6WHJ4VkhEZFZac08KRHk3ZkJoa3BMbys1MUZwSTg2eXVlblpBM3k1L3oxZDAzUjd3TmJ
 VckZTN0IvcDhjRllIU3dUajFJV1cyNjdOVwoyNk8yQ2VmYy9pVzE3WkJaZW9MN0JHYWJVOVpxKz
 I4WmVnRGdROVllYnl0MzM1WFNlZGNFbWh0UzJxM0xiWUUrCnN3Wkx2VVBmTXdsZDZrZXZVZnphZ
 jErVUJzb3RHdVpWVGdzd1VMeEhBL1Nqc055WkIxeElTTEJXCj14MlIvCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.136; envelope-from=its@irrelevant.dk;
 helo=flow-a1-smtp.messagingengine.com
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


