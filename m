Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2CEE6B243
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6pl7-0004xl-J9; Fri, 01 Nov 2024 07:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t6pl5-0004vo-0J
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:24:03 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t6pl2-0005q6-Nz
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:24:02 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 7C3901380166;
 Fri,  1 Nov 2024 07:23:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 07:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730460239; x=
 1730546639; bh=/IO3LHSRPNm6dEghav1NSCErfilgt9M9CVQ931ZimMU=; b=Q
 TlbPLXe82NrgP6NPKq7VkMXG2V8OLeFAMVYmAKEWvjLp+xqsOuh0YLLuhuf/8apb
 p1pEEpgULm94DXHej9YxN2JuLtLQic7sTLgMv86+6JxWoiu6aevM2vuFLjT+trOH
 azvk+t7+epM6U7eePhFxL0jcSyRs0nkofXMgHGZ7A9JOlpSkXiVG0i4xGG0OJNcf
 9j8zymFI86CD62jYMqqPLowTyGn9pKkHoSpREK2x7kVQZ8J0nrbpgXwAh8ndg4w0
 QZSuAeqOVvh4tpfv1CXAzczR1be+3Ri8y7TveHFZ6EyebPCveC3qYm1pS6LlSEGz
 xdJbKj+n4MNSmGuzYBHsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730460239; x=1730546639; bh=/IO3LHSRPNm6dEghav1NSCErfilgt9M9CVQ
 931ZimMU=; b=jT0BQEyBe5w3o4CShvw62f2iVDbVIBkFenOkJAjErDdT0KLZJAf
 0qVQB9HMZ+MivgKErDyw04G6Zjy/HUOwteZelCXKz/hSVPLNnYZwgCM+VXwxr+sJ
 gHj8RalUlQp+W2BXsrR4KxEaXfLQpNTP4sKRdwEEVZHRVN1Z+fB4pBnPZbg6jK2y
 POiXbP4Wd1h3mq6I1bdVP73pC6QWzaRQ82OrezDuVRgcF/EqntI9k1tjuO0dKGDH
 LaCGO+tuALhTmPCXW7fQadYM0pNpBjO5SG+dKrKDj131rhwAih4do1y7D0Ev2Mt6
 XLGGVbXVscYNNtmR1ykI1cxyfXInDU09w3A==
X-ME-Sender: <xms:T7okZ61IQaGJm_VJ_EbSlz5MRpR58IvWR6fL6rWcR_6RxSx7Hb6ehA>
 <xme:T7okZ9F7iZ3ZDB1GhyUxDFk9sd8RFRgjj6hyvJB3gKe1b0dAMFYSGGKSZSA7z3S-6
 aBbYdjEmu6958mVVR0>
X-ME-Received: <xmr:T7okZy7W0_KkIx3E6xLch20s1DEA0pNSYZhEjNlCLdeS86sqjleDLKPfCsZn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
 fukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcu
 oehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeejgfejfe
 ffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvg
 hvrghnthdrughkpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:T7okZ73x6lH_QkB-Fhx05mUVAvHcigA9zCUIVgCVHcPrAdBtd0In8A>
 <xmx:T7okZ9F_uPLkeFsysr-4MbnR9U3A0glHAsdyJMyulo3_LtbwNxDL1w>
 <xmx:T7okZ0_O9q5UMfdF1JcQIe-ASZK6oF_mKMRMtL6IYencKsPAxCUOkg>
 <xmx:T7okZylj4mF3g_K6aByWEXH7lUFwtAahyR4L-aDpFO-vf7lwSVKD1Q>
 <xmx:T7okZ2NGUcVCcwFn4FhoAKzRF1A8f582-L3A5WpO-BAit6V1SlBCsj0->
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 07:23:58 -0400 (EDT)
Date: Fri, 1 Nov 2024 12:23:57 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme : remove dead code
Message-ID: <ZyS6TQgySZxmWTan@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20241023035127epcas5p241a150fcb18cbfc6975af8a8fc29d4c6@epcas5p2.samsung.com>
 <20241022222105.3609223-1-arun.kka@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NElsNcpjFo1Umfud"
Content-Disposition: inline
In-Reply-To: <20241022222105.3609223-1-arun.kka@samsung.com>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--NElsNcpjFo1Umfud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 23 03:51, Arun Kumar wrote:
> remove dead code which always returns success, since prchk will have a
> value of zero
>=20
> Signed-off-by: Arun Kumar <arun.kka@samsung.com>
> ---
>  hw/nvme/dif.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
> index 01b19c3373..2805128498 100644
> --- a/hw/nvme/dif.c
> +++ b/hw/nvme/dif.c
> @@ -575,11 +575,6 @@ uint16_t nvme_dif_rw(NvmeCtrl *n, NvmeRequest *req)
>              uint8_t *mbuf, *end;
>              int16_t pil =3D ns->lbaf.ms - nvme_pi_tuple_size(ns);
> =20
> -            status =3D nvme_check_prinfo(ns, prinfo, slba, reftag);
> -            if (status) {
> -                goto err;
> -            }
> -
>              flags =3D 0;
> =20
>              ctx->mdata.bounce =3D g_malloc0(mlen);
> --=20
> 2.43.0
>=20
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thanks, applied to nvme-next.

--NElsNcpjFo1Umfud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmckukwACgkQTeGvMW1P
DekXRQgAqXY91iQMselCqx58RKVRX6OZe/6ZRqoRS7CaBxi7MvVW41vN6a6qTTKX
oJRRH0Mk/XBU8ajLz7yA+wipBUGKzG52eMIs9C2tIg+xpYwoHoYRLbgFVXLZ4inW
iL+rH1Oa5bwxvLh+7UBvMfpykaPeno1xxdfEEFSEQzRzeIJtuRn5PsRFxXqds/vX
AfZNCzsEpFfAKN+40KSD/Z1I6Syc/yEMCmw+lPXRtVfjMkyMiNBBf8ad7DGrIzQu
Zx9grLk3S+Up1WcI9bz10ddPL/K4wQltS4qUW2QShKiczXyr1vhBE82hbApdQLMV
76Xnzx9+b8p9mLjfC2W8BPAeSyMtWw==
=52Jv
-----END PGP SIGNATURE-----

--NElsNcpjFo1Umfud--

