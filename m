Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C495606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=TXjUz0Ij;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ah/EAnDn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcI-0001vN-EV; Mon, 23 Nov 2026 10:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbI-0001KU-R0
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:02 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbE-0003g5-41
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:00 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 81C51EC0BA6
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:04:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 10:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446294;
 x=1795532694; bh=kzEDz15we3uMY6G1+g2sEvyj1tnQIbYRCsOeuuINZ+w=; b=
 TXjUz0IjGgy5d1xXGZEa9jgtJytgFJor5u2oO6aWlR5ntBzsEW34vUis9pEM1dvd
 OOx6ql3B/w826QiLVFd/OB8q1YZalJyIOheK1x3On74e3lv32decd7rrv9OyqneJ
 osguPejmVGRgN3xmN5BW6GX1BnaZk1HKLGllfZrh/4j48hxC1dvL833QzVF1ctgg
 Ed0aF9J9BdmXrBUl6OSlsCCnO5uze4dJS4Ptlw4AF5Sf2pDQ+1KEJuxV6VOjL/kk
 LImhypC9VGdjss1LEvGtR3G3oWf+PoFnzMWm4zl8IDbK8BEWu6cjEDmOC5fu20zd
 HUGFCms5q4Ue6BNmhiyGQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446294; x=
 1795532694; bh=kzEDz15we3uMY6G1+g2sEvyj1tnQIbYRCsOeuuINZ+w=; b=A
 h/EAnDnroB9RWejAjHV6+SF6J4IzFksQhnxC5Np18QaT9YA/SE0pWMqnzsSsIV4M
 p0TyYTNPWBwZg5dGmlwcRL5c/AaYKGymjCuq7EfB3yCZe5HmIBrE0ev/h2mm4ZX9
 zmCA1Ip0vWz5RJhFCG05/NR2GOSAlKsioU7+p2/ktcPpCPGi6oGcVEZZqkrJBTq0
 5PPrBZT+hIyIc20TJamQpPaC5NAsDuVrtx+qGLu7oClArLnKLweMBEJkRLmUL55U
 dqqZX/gi567fgmPXo6VEB/2WkfmYnePQq51zRw3Np6uIhNRae655Fgub8VZrLUMC
 5L2ppNOhmS6TxKrxxf08Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446294; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:GxpYOiy8AzHUkhxmjCiOdiWAe5RbXEtl3MTqmb0BmE0mDcv
 CpC9uV5B3+U9xLrrDVfn3Y+MHMTXAiJ3knVgVTTFG2NndCZ9aT+yo80axjTmE4g9
 sh/fQ/SoX86HWNN9de2UlecgiPhC/ZFMfY8fIJ0mM4iO5vNeUDqvhcoWiAKVcuIU
 lPvQQA8Y9i+IUVVxpjKLGxD5N1AMn6gTkFCB8Vk8AZfl5RKawcwzH4c9+V5QRB8b
 iCpcHtorWCFdSJ9XVWefhszhRlZp5QOevGQ4LHQY6S9wT62FDelB8/eX+1D9ja1p
 OhW4ILVCgmvoYrgC5jlEeg53x6qK1Zwj7s/QPLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:g+QaToAoA4ytBgn2JbAL5CANjuwBCdlVkGJJ6zXuhXI=:fW4UIGhNlgcc0gkvopQftxX5/BdEwhTM1GNYER0x8Ng=;
X-ME-Sender: <xms:FlYEa2M-yHbbvH9tOQpLwZi72UqUMpIIlQwhnRi8Ix9kD34imN4UHA>
 <xme:FlYEa1Y4Neo4QkySeFPbSYNCYrt4-91ZB_ml6O5m_zWOrqkKmvlDWuPojwRDnEBNu
 KzS8kNp9tJWbzK4TjUeC8seehyGot2D9J-AX2nvJPTHv0odjipwjK81>
X-ME-Received: <xmr:FlYEa988ldVka0U2ysywEWTMHYCeN6nbeCkZdo1sR0FvKG22ssQIw8tzU2z6rqh2k83vo-v7hFJYJoM5xp4DnRHNFyEtnONr2HJj>
X-ME-Proxy-Cause: dmFkZTE+oIySUTencSDrezjdlYlA3KRh/B+gt/B7pvsu4MYYZUmi9LXvi9Ffrqz4t56wFH
 eDEN1nNdacz5DD1luGTgKjOqmCi06+6FPKXqnvYVkitPCyyh5BZizsVnUsjbYqWs7QIb+m
 KHSxtZhJEfsjm2cF5L++Mi7A+djysq2nH/FN84chbpJMoWKoEui2Lm3b3ikSnZ5VKaUqbI
 nwmFM4Ie4ZaT4pNhF1HIQWpJZ9q9IkC/OfP7nGHsmxwKnRtVil+fcHNEgWhQG+7qx11qUr
 3uSsMPiQDMStnjDIePLvIjHwJ8aCzUSJ50KHyZNdCVN5tVRmohrAi9u15+uOtwQMfFJ0qe
 qzGIJWMb9dSRWQ/lDvUXkhuQifGN67eRcnUwHH9HOBP0qImzK47TWiLMhDTFiq9qW9fXkk
 /ZjOqTnwwW9/jWWJAojB5hprcGmToydfsofLEJB/mYebIxpYnlaoCip6ESUFcwD24HPZ9O
 C0mS2PpBdUIGPOGN4y0gB/sqnquDxwXEZbaZ7m748Cg508vY4YJN4eLVHgc6/VgGlFFwvb
 NWmB49e5ZcZySi3jlUD7WBtmnigXmiLdoskkETy3Zdjnk/s6SUxlWQC1F5fkrlAbC7tfi8
 9lH90F7gVsfA/DOYGBGm7qxtFM+mrQfq/Zj+4zvc2oQaCCzt1tGx3kPqO7Ag
X-ME-Proxy: <xmx:FlYEa-Qrm_wzMDnTml9C8S_eRLfbMJIPzj_kBIjwiHbYNueWDh_ZYQ>
 <xmx:FlYEa_fAVpkuNyy95hrMmlcpVpUO6PUYWbJOh88wo1tmSLOifFI0IQ>
 <xmx:FlYEa4QUd4E6Zw9gMPopUV4HYIJf252wfoR70NAWYU416Fpj8uLOCg>
 <xmx:FlYEazIs8NkJye15tU8leZlZg4iltLdZ0bPmBzIike_K7rxOfwzfNQ>
 <xmx:FlYEawU7SLF9ZmbHpcEUX7BmXGCt-RKVDdBHXd2ZfEKXeAlw46hy0vAL>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:04:52 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:48 +0100
Subject: [PATCH v2 01/12] hw/nvme: get feature - return invalid field if
 sel is reserved
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-1-4c9893537cd1@samsung.com>
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

Base 2.4, figure 198, bits 10:08.
Get feature will now return invalid field if the value of sel
is in the reserved range.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 71c24dc02b6..ee670481876 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6462,6 +6462,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_GETFEAT_SELECT_CAP:
         result = nvme_feature_cap[fid];
         goto out;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
     }
 
     switch (fid) {

-- 
2.51.2


