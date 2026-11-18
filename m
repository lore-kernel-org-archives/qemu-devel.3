Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AB606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=kpAv6Zok;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=teJRTK1E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTncs-0000v1-7d; Wed, 18 Nov 2026 16:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTncq-0000qn-CE
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:55:32 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTnco-0007SH-R8
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 16:55:32 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0E5617A01E5
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 16:55:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 16:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795038929; x=
 1795125329; bh=D/4aljzIZpXOYzzNcMxojUB/HHZ+46L0ZubG00cpaB0=; b=k
 pAv6ZokOpCBWu/21PkW92JmPtEGdydN1ildS8KECPYnSQfYhtf6hlw8MrR6vl+7X
 0fVuvAKwWgS5gTD8sZa5iLAzyK9wGD0g//BnDqEr8CF4s9o//hKiyczSfq7kY1HX
 xAprWefPUJBpTKX4UlfCHTEU4IR+rV0J5RBN0Xd4WH1t7BC6JTcCTJk8CTeST32E
 Y+Pwl5wl8uIcU+WS2utLvMZ/i/yRHUVlt/ZP3NRAmyoqBDyfnNatvvMDdtYWNobr
 0usa4iOMjixW8pZgujzVZDuV1wZmmtdyNp3RpFwSIuHSeqhk4sONWCUbnqppY7+E
 M6N5eU6eEfSumz3qG5g7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795038929; x=1795125329; bh=D/4aljzIZpXOYzzNcMxojUB/HHZ+46L0Zub
 G00cpaB0=; b=teJRTK1EhJP6sxCfOk7WMFVMFGR+d7qgF3vWErvyZ0e7uMc7ak5
 Vu/j2DNEVtdvKCXITe4AJaCp6pcTJ0l37f4l1AwLEGCGeMRZLRfIrw/CopddttNs
 RrggtY7JF0T859rzbhMi66leBwnySy1yXbaeV+Yj0nIZmKeOULZj4E8hJTfwqcqK
 5YUQpzWuGszn4BIyM6QV01DUWEBxLLURf/C5VIRP834n3SyAhiZzhSiLdSU/yJyZ
 K7Fyy1s9FJLNvH7kx9ujqvTZWuk4Htgc3ASsr8T3J0uqC+wG+DvK0g9RagaMZzFs
 jgVSwUgpCbl4iKluIwuouPO31FaAMayFCaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038929; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:oTqPAcNu44hmE48Fdrfjcilop4/P4lcZpHsJQYxBq/oX0IT
 C1Qsaep4DIY9+hYVi/AH/52lc/8vE+Bt+1oqXVQoeuidRLzqQKx89T/kr6ZGk+8U
 7MeWpZWSZr8Cfwam4ClMyq+Rqt8S5opACHFsNbTAlx0lOTkuP4vm6MFHej7UhJne
 1n4sCPngBKTsGV/VZsIvIoi1kyyGaPlrDZaDpF1v3mAp7Mdh1F2JtUXDIeEzQulw
 bMuQa2+TyjUL0FIOkqQDhRu/lZE32mZ/xF6kSRxJPUD2w3bnScqbQ3Zv+5asaIga
 vKpIeXxfunHdhHu5L32J3Y8pWWC0scwoVXXeqLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:dg626OTwR4PUAvNZJK4k5oQHzJFaG1YBKDSgcInIySo=:lNmzdcAfwKBlTZ9yIJWi6zPcAIeu0g0ahDtohz+aBvk=;
X-ME-Sender: <xms:0R7-av-JuMRu9gKtBdHs0XSwRbYqah7JMQiEXoela8WsRmrice0gfg>
 <xme:0R7-ako1nuuJdreLcDN_zO6gD87-dAl78BoGAG04NnXRjmhZmNKhPGPbL7wq0ogxp
 ojINrCL448EymZQBztPUr3D2FwPjtvc2pas5_lik_m07XV9MZUq8XoS>
X-ME-Received: <xmr:0R7-aol0rhhhgNufs-N7joTCzFZ9heX7ooNVFLia6RPbou-6gawiMLcKtJpIkWnU-UYg46pSIzvNlI_IzOW1C311RwYiH-A>
X-ME-Proxy-Cause: dmFkZTFGuu8CD/3+TSDwkY6CZ75VQfaEytTDPiRpJ+0i2xh1FqiVlCV1kZEGiYxASD2ZRr
 uPk0EYSZ9sNDg7ZOnLufi0LcCD2eVkDDUUCCfJrOWPeBuzPEPWyvenZqL5i8tVBfLXuF0i
 UdO1YefMBBFPl/UNhtdEQqjNjanDVNGnoxTlA7ET3uSuafyqLMd1VEgSU8nm42MkETN00x
 ZZH1IgT8NmoiNJCOivrlI2TGjW8RlvqWAesMY7sTE/s1dhGvq9iGXlakeAomKUQJ82NSMT
 ZPTpcwHiGS5lQud1TMHtb6c5MV4HeD1N0t5InOjGcMdk6y6kRS8BjbiE7r351TNxF570Ru
 zFs0gO2PZ8o8iFj6B9S5gHCN3KvJNRtiPzTkE21xv9JhfXZLEjDe6C9KbJVwGQQKkaDVlJ
 g7bkvXZ4yq4b8A2c3zpMhtcC/RQuCYlt0sE51xw9dA5Pj7h3qGPCDlmw4jEoMzNAUvI0cw
 4T2d7FVlI20lfg0HNKMDUipOkBASPh2lX8kehPDdM1hBdo5peuCWvookgVgpe8PU9C5tOL
 9oe55v4WkLeJJRBv1R5D3AacBaz6u73Vf7rR0x9TlV7guTcu6KW2et+fG52B8OkC0unPUC
 D/dJkU8PAYAzma9YqgIKAYv3sZhV+3Usj1Q41VX5r0EqMrQcSWspwojsLXmA
X-ME-Proxy: <xmx:0R7-arj1t3LNNKLM8j85chjGB0vjGADXoTTe5XHfEAvduQXVjXYBfw>
 <xmx:0R7-agdKen1xFpMZD3AF5kQYZlvierU43_eMDeKDBsknLkWvShiWBw>
 <xmx:0R7-arg-9X9WbUFOxYQzniTbcYwBAWKfFBucTro8DHXaU9taQtMK0A>
 <xmx:0R7-aozT2pnT2ZXJQy4PGAWGikeOyWTsOcXpQQ4c4xtoUKMfad-fGw>
 <xmx:0R7-anD5IIXqtdx7U5dfOtUuxzY549kk9xpqa2MmunUyYSoV0k_oUg0W>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:55:29 -0500 (EST)
Date: Wed, 18 Nov 2026 22:55:28 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PATCH 4/7] hw/nvme: get fdp events, use helper
Message-ID: <av4e0O2rSv5ByeFk@AALNPWKJENSEN.aal.scsc.local>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
 <20261118-jwd-181126-fdp-fixes-v1-4-ed76fad7861d@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MuXrl61xnhqh8+O3"
Content-Disposition: inline
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-4-ed76fad7861d@samsung.com>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--MuXrl61xnhqh8+O3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 18 16:01, Jesper Devantier wrote:
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
> Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5d4122309ea..8fc0884fcda 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6372,7 +6372,7 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtr=
l *n, NvmeNamespace *ns,
>      NvmeRuHandle *ruh;
>      NvmeFdpEventDescr *s_event;
> =20
> -    if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
> +    if (!nvme_fdp_enabled(n)) {
>          return NVME_FDP_DISABLED | NVME_DNR;
>      }
> =20
>=20
> --=20
> 2.51.2
>=20
>=20

--MuXrl61xnhqh8+O3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr+HtAACgkQTeGvMW1P
Dem/lwf/b07ZO3Qh1fgPY6hriyDLyGy+XokwKJ9XxWIlT1IiSOEixmzRSSbeRzse
Wi6c4lPa7Uc1wtaghyMOdKcFL3H2szE0pavANI0BFglPsmRAtITOSTo42mYdtPPA
vgmNMcidcPFf/5TVI+vUhqwsrODAAK80gKo7joF3PehBW9xTWOPt9yLmAeQO4QG+
BHTZLySlxH6iNPoeKu/UtSxdXNUHEerlEd8niq5usfnPBRQtsFK9AV5H05zvjHYe
cBlkiyZoaxhB28ATBkxYt0OJeKUlNrPZTGI64GouPubu3FRv117xREUmPprWHzDJ
XjsheFlscV5hxFTDxUeo8biGvaUh5w==
=ffjx
-----END PGP SIGNATURE-----

--MuXrl61xnhqh8+O3--

