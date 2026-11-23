Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2930606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=ayIFWg8W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rw+EI6Av
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcH-0001sT-JO; Mon, 23 Nov 2026 10:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbM-0001M6-0Z
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:06 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbK-0003hf-Al
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:03 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2F07BEC0BA1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 10:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446299;
 x=1795532699; bh=A9q2SC81qbfg1j120eXPaQtkG8p0iseFyCNltrrxaIE=; b=
 ayIFWg8Wnd4QivR77CD3Pm7IfmH8VeGiDiMl2ltM1dMXjMz8A4N3OM9MpxeH08OZ
 T/AvANTdwbkB7ukw4XvpIrVsc+asqj00W2NAmM1zVpAm0Z/iCT0a9L3Fg32srEgn
 nZDgih5KcVC2lBFKJej7OHsi+l15loVKycsW5gMkIqZZY56ffCy3zFhIebuGNLXN
 DJFxTXhwJByW01DgjxW91mw/tND9wCH4m9XVujpU8xamR4TjGyoYmI0BencI3qqj
 TQ81y3n1IG9c/gu5zkTjlk5XbVxAJz1LKJMX9XZyU/57bZmZF3OZVr3vqYixBYww
 dd0Fv+0rpiVIFqEAZlC9IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446299; x=
 1795532699; bh=A9q2SC81qbfg1j120eXPaQtkG8p0iseFyCNltrrxaIE=; b=R
 w+EI6Av+QZpyejobEOq9m6CYr6PIC/16GsgZrP/vIXExUhwBKlFRfvtP3Tvg8GuT
 q9hR8i/arS17WcevGaBFu6e61tLpx7pvzPVDyTkAS8yqwFo7yCf4cCx709VRrYLT
 ydEm7FfDrUt3mwMIG5lWtN39cGXNfGYkVFdYQVyZd67rCyMI/phlaQNoUw6cf1/L
 +vNsO9kw5CS254r7UlXC5EZfG8g7sCyOmtcEAq0pOUhDjb3DuVQ01UwOQ3puF1Gr
 mDGxb5SqWl4Y3758lF8R5IM/SrXEJcdFxuT0rHOAberlsV4PcmXbq19PeHz+hKg2
 9eWk4EsMeG+gtknK+PL3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446299; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:nFeMDMszrKI2WUihyTTwWL2Aw42k8vZiWYA2IwQ+EWtfF9r
 Yo13ucoStWeRV30MutnCamtCP5HYeIu0Kh8Mu0Eu6HVEEOms08pTgintKICSiOWz
 R+56sgJfFoFbUxWdpaDqwO7qQnKa7mXI9Ar4DK9rE8R0s9Fu2ydBpffLnHpovfYo
 J3Bn1s7xFmyhG0nFrJwAUpnQlAl4o820nwBFg8ud37UgZZ0VX04hWfYABfHgB/7z
 wDrF8B0fyBsMG51YLHAvS+bPenBQB92Rx4u+loKwGDCYWdp2P7wvBJb4ligOsLY1
 1xXHOsloGJQpTBwaZO1lQVgYgzZT40iQC39Xq2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YR3IYcjgoeE3kXYQBP18tEomKZmU9VaXCTBSElDN60E=:4nyWdp4G21MIx2iDnZLkd4om62RtzW5WGwGT3bz+Zzk=;
X-ME-Sender: <xms:G1YEa6bZz6TNUiz4LfeRH5gMnMrBvv8D6LGN8SrHJP9-0Sy3t5s_OQ>
 <xme:G1YEa92FtJSc-H9RYlgHgQw35-_lh9SQ6koqyhgsiDY3BvuFlIaLJU5oetQ_wr2pu
 g4eQGT39DLEGZwZwW1qIRVB6TSZ4uYCJVOP7ViN4vTPFzFFmFNhc-6->
X-ME-Received: <xmr:G1YEa1qJ5FcMHAxPiDOyU9iHSqpxMKsYX2JeoQnL5NUdbE5Qd7JasvcmNHOPyG3uQiDGlueCNPfqnIh2xM3snfLw8LGGaoqKXiTT>
X-ME-Proxy-Cause: dmFkZTE+oIySUTencSDrezjdlYlA3KRh/B+gt/B7pvsu4MYYZUmi9LXvi9Ffrqz4t56wFH
 eDEN1nNdacz5DD1luGTgKjOqmCi06+6FPKXqnvYVkitPCyyh5BZizsVnUsjbYqWs7QIb+m
 KHSxtZhJEfsjm2cF5L++Mi7A+djysq2nH/FN84chbpJMoWKoEui2Lm3b3ikSnZ5VKaUqbI
 nwmFM4Ie4ZaT4pNhF1HIQWpJZ9q9IkC/OfP7nGHsmxwKnRtVil+fcHNEgWhQG+7qx11qUr
 3uSsMPiQDMStnjDIePLvIjHwJ8aCzUSJ50KHyZNdCVN5tVRmohrAi9u15+uOtwQMfFJ0oU
 HX8ZfuSFe10AWCkLKs17zIanvn7TTlZRTp96ngmuv1MAVt+AJuTi8KPqAVZuCz5M/VCCv8
 CbdFFR5yqgiTfkVivALckjvWkDdF+AcAbpzGnepBiqdM37nlDhIUHcVmdecfQNfLfa0lA6
 95pBUSL05dF8CUddmzHXSBgHCahe+fNmcchcJaOd8ELji0adrNlTHUoXMTXL5Axe5VsP1+
 W0Hxv7y4kja5tPNFfGOcSdyO4iytdYGqJ0+44uKNqHOJBqhwziFnGX5h8TGKKLoR6EfyPj
 lrgjrmD4zcElCYk6aWNen15t1/iUlZ25jkd44u+1g8u05W1sdNXK/ufEZn7g
X-ME-Proxy: <xmx:G1YEa0M-eeJKuHX5x-33fjlxAR2bP0HdhbX0i1pMuZ2DKLmONAWLGA>
 <xmx:G1YEa2rt-U7Ef3NkFhs04E-XCAnK3yL21-Z6qHpHTfMHbefooaXk2w>
 <xmx:G1YEa3tT5CW_ftZDkWMpuLpEPI2E4SLG8o1rUwau_zvNq-adiZAgRg>
 <xmx:G1YEa13luUBBdmmwfzXMoxKnbNufmDU_a5vqU9IvkkV_WYGn9Il2Og>
 <xmx:G1YEa5hIaUBjpkWxfCCVp_2xFovl7b8G7wh4dY3akEwO0gEVRPNJgeOz>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:04:58 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:51 +0100
Subject: [PATCH v2 04/12] hw/nvme: get fdp events, use helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-4-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.150; envelope-from=foss@defmacro.it;
 helo=fout-a7-smtp.messagingengine.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5d4122309ea..8fc0884fcda 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6372,7 +6372,7 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeRuHandle *ruh;
     NvmeFdpEventDescr *s_event;
 
-    if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
+    if (!nvme_fdp_enabled(n)) {
         return NVME_FDP_DISABLED | NVME_DNR;
     }
 

-- 
2.51.2


