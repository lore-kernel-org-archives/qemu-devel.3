Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E4606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=LEQUrpCC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GhXgobgz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRcVl-0007Cm-91; Thu, 12 Nov 2026 16:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRcVj-00075c-9h
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:39:11 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRcVh-0007mL-6D
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:39:11 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 826241D006F2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:39:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 16:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1794519547; x=
 1794605947; bh=QUx12Fccjl5gJiHazeF8Xf0j7TK/m/7nZhEh8VCcxVI=; b=L
 EQUrpCCRLPxKWhXYr08meWXK9aMSPzZguyeGDC7jvgqJeqsermtLG/+JagVjdK+y
 j/TyUQL+NICc+uk+WsTGy2ZrV15FVWEMhUo3cMJBwgD28WWI2ySqo0UlHNBOZ2m3
 EERdB8hJk5BIDWk/4rfB8/TCR+iMRhkSSxb2shZ0ZxHjyhrGDxJxhKPqo/X1SNJp
 OQFDsOm3ahCrRXS0vaAYMPFRLIqe8Dae0d2LRXl8/Kf6QJYuWmckclVxAlvzDlih
 zwtAgUx4ofyDE0oTzD0n3GdFnwgrg15HIDm1mnmI+2hMotaNmgQefRvxFlgiV9F0
 uMMzE5vk8qhxtJ3YvoVmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1794519547; x=1794605947; bh=QUx12Fccjl5gJ
 iHazeF8Xf0j7TK/m/7nZhEh8VCcxVI=; b=GhXgobgz802CGbzNZ5GDYAaeso9WN
 g1GTHMFXBUz0kCM2QsO79eMKifUcxDUp0QXcm2P4FRUZgRsdJSNPbvDmlV1Mz+Ra
 mDwby+CkGK2KEiWKQOEkw5koQkrEY5bcXKQOOkghfrTFlVpACJYO+kXqPMOj1JIF
 vn2bPg1BFoEfWK1rNTiP4SYkvCB8fpYu/sDHefjdhDtxN1ZNop/YblwjI6lzb7Pk
 Zjl8BwPwhx8BInmhIEwL0aW4EQEdDcxkss1mdTbrVm3QLByZPklNbymaqvleLRI6
 iPKeJJtWPIdMMHay49Q1T5n3OiDzGRQSb375TtOPTmSOb7rHLFwsAsahg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794519547; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:mbt4IZGHZlVfl/Dz5IG6qwIAneFLNZcJZ3QbSEQcT5adUbg
 CXQoe6/UIMPxBdRHSSjneogEnWDJBUW3AgrqkrdL3RyL7FHGAR5QJHIHMfKZ3VON
 s8rILD1YS4wzKbciMpqv4qJ/96SC1A0UDQSBLubbABGb/BtPU4a8G7I2YwyXmkK4
 nOgLIwrR78gPfosw5yS0k0dRPosikBZlOw9JgzpN2BjunnWjhG2Adjtcdbv3X5aH
 QljDkPUuM0gqRVj1kjFNiF9yi63H8tCnA699Ia3VQLtKPmKcQ5wRtcM0uhOIGq6I
 8ySFtu+jrc3VoCoppBzCXs8aQKGVsdtULg5zHIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:57b7xIOPfZaYMiYCVB5rlJFNFR3vKYmOsy7tDTF0Kho=:qKuhgxPniHBBQarUCm5dKDDMmxsllJMj95kaw0lCdIM=;
X-ME-Sender: <xms:-jH2aiJvisfgCBzZFuIirahv_7yoBSn1Zx8aJeexjq4eMy7JcnD7FQ>
 <xme:-jH2alkruJOSyVz8H2TpOLfIuow4jKIY2Oe-GlTA7pElxjhJcpyv3SM7WNV6Orgd9
 NBoksQklQhm6WtV2U8xkqGaONvpFT-Eg6GIMFz4ZXZ6eU8VY_g8qIY>
X-ME-Received: <xmr:-jH2amN-Uwg1XYsY-rOb5Y2kLiXI15IJYVgULq2vXusa5j0TpeuZ0eUnRCvw7ccKEQIk5Arf5_h4F8GK4XlkMfTs3Q>
X-ME-Proxy-Cause: dmFkZTGOTKAe1TFmXgAkMA7vXR9wQGFsKgUWxDLzcufigxuRAsQcrSiZsgqopPaPG58Jhl
 FmoR5k3e7q4ci8/I4ToxXjrYY27qvnWAFRD4vHSP+6YzYW/Wx/UxfLrlwJwN8sy78xUPs4
 bvv9NAZZ9+xvtEKGVIx/QFBsjKHzd/WvjugmpTuLP8KpOpxf8Q+i3aJJrOAoOWgWoFTVWg
 4zZ1R3x+YAE0NFWQ5XOL31/tjTv9MecwalLDXEit8Hv7dzRim5oQMG5rBe3YWu4dA0nWTR
 6Zz80aADcP/waXFD4hs7o58DG2jHV73r2MVJ0pDLMQkJICjTgFMVfzB1kx1VEXzFTODzt3
 VlreRapX9EFMowTszhrZAklvvFoGuZ8+w8uOUHcNzaPTR0H/Ty19c9sZQLdtpTvW/dHqku
 I9yqLEUQtOKpUUY5U9LtmgBs/mZ6Rpmqs9uNl+OVLNrjEfMb4SUh6DYRTPDvNqbVE313/c
 RDJpT/IHvDArBerz/vMFsCPfR0s7NtoB/qfCmkFMVfjE1Vp1CMf0tENW6tqP+lqyMMDUYv
 ozzq3vq1a3auayCcOYpzWL80loz5597iHxYPgP1GYIRlsP8gGws9l6IAnDDXwOh+HQJDPq
 LPT4pGrCvG3jrxD0urbBAYjYMbhSyspKbfdWRpKPZGwSt8p1yAEEkBiiYdIg
X-ME-Proxy: <xmx:-jH2ar2oigdtcJWK98aDYQHuNhMZznA85MEw4CZ_VShvccN93I4rhg>
 <xmx:-jH2alk58uBVSv0lrss2PXMn6rx8MRaZLjvyYWuYFBwqzgoEU0vBTA>
 <xmx:-jH2aiWLVfjUQQVt444gTEEuwoR9OMQ7DrihafoyUkG47sJ_A5f5ZQ>
 <xmx:-jH2ars5oShePj-kjGvrQWwTy4mBFeuR0YbfB7cCX6TVEmI05R1QRw>
 <xmx:-zH2aicnaKgSmbuEOIreocr22ihd4lfRKo8mvAxmcXg1o3RD2-ItkG62>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:39:05 -0500 (EST)
Date: Thu, 12 Nov 2026 21:38:53 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 1/3] hw/nvme: reject fdp.runs smaller than the lba data
 size
Message-ID: <20261112223853.0-foss@defmacro.it>
In-Reply-To: <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-12T22:38:53+01:00
Received-SPF: pass client-ip=202.12.124.147; envelope-from=foss@defmacro.it;
 helo=fout-b4-smtp.messagingengine.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 12 Nov 2026 10:53:28 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
> is configured to be smaller than LBADS.
>
> Reject such an invalid configuration upfront.
>
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ns.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 2ae26a9acbd0..37d45bb4d533 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -485,6 +485,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
>      char *r, *p;
>      uint16_t *ph;
>  
> +    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
> +        error_setg(errp, "fdp.runs must be greater than or equal to the "
> +                   "lba data size of the namespace");
> +        return false;
> +    }
> +
>      if (!ns->params.fdp.ruhs) {
>          ns->fdp.nphs = 1;
>          ph = ns->fdp.phs = g_new(uint16_t, 1);
>
> -- 
> 2.53.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>





