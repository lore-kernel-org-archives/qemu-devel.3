Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8AAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg2la-00086t-Tl; Fri, 01 Mar 2024 08:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rg2lJ-000850-PB; Fri, 01 Mar 2024 08:17:20 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rg2lC-0007iJ-NV; Fri, 01 Mar 2024 08:17:17 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id EE6225C00F1;
 Fri,  1 Mar 2024 08:16:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 01 Mar 2024 08:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1709299019; x=
 1709385419; bh=0lxVxcNRaEdqrQNi3+Pbki3o9bLRSnSjk3HGAhA11Qc=; b=Z
 e1Cgzs6uVERyn5YFGt47k1yZeoS9rJf9wJ6HiohcK8JfPYTcYTUfyOF8SZs1XjBT
 4FXeYrJeMrzxcKDrpgehiL/tP5sE8Qn3jbIP6vj0z9X1Cofzdj3AgBpK7+iAXkBD
 UyGwOC6MNAJxULkKF5l8kqyfMOHRKfspNtFmbNbh2a6iUch4BqEsr5tHu4GGXEsz
 kOxqR0DzZVcnJS10icdFtzYn4gQFp23yvPJ45zalZ5JV/p2jPKZIVZMeOQG9RGiP
 93FjfP2w183snP5uMXVpDy1FKVM8Ar404CHo+PJ893K12IEDXNNhTvpr6Cabtocv
 X8cAjTUM5TXihSJ7aQc3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1709299019; x=1709385419; bh=0lxVxcNRaEdqrQNi3+Pbki3o9bLR
 SnSjk3HGAhA11Qc=; b=l1fqvDnRrfphHsIcVSa6B3U3DxS8Hg2P/WugIHaOxRsf
 aSMBmAG/z01y/kacsBNDGnIsOvbkeW4twCl87+wRaMqmr1iQU8OUux4xtE5HP8vn
 qrtif9xXS2yFzzxEUWnL5nu+S3s/Ihi6hol1zxAZHxH2uziKosLexRo1RNM+6bbx
 VCVIk/kIMdYDR7NObF+lttSdjOUBAuY/PidbtaZuoxrNLNTGJ9M/eRg54+g7KJti
 vlDrwIwTe8gmfvrXUfhRVDcQSKs6u77AyiuLapocf060CIttSFjZ4KHA3N22HwHx
 COyCtTgRufCyRsRhZGCoZKC7RNK2KqxD1KCF+bbTjQ==
X-ME-Sender: <xms:S9XhZYzB7QFPstwJMC4dbsZr6DEbQsI6V0J1yB3xGY11JUFACDN1WQ>
 <xme:S9XhZcRMJYvGoGA0VMzsQqP5fv-tMAy6kD1ns-uU-3RTNtsFdUa93JBBknwaYAu47
 ELFinMHH-N48mql7VA>
X-ME-Received: <xmr:S9XhZaUf6nXiU3fSVJwBCYzkVExcLUsZxh4ihuy9ZZ8h34DymcWSng0E2cUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdehtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:S9XhZWgjHRTifuECo-IdawzCMJ9oQeaxmir5mVwVyNBfG2xYCZSYgQ>
 <xmx:S9XhZaBHW867_T8I9cAS2laxZDpWEcViunPucv28LVn-xVdvEG_hKw>
 <xmx:S9XhZXLbnScX4Tfk0bGkNo2QPoUTDEVhPI5l6wC2bdU2Tm9injTI1A>
 <xmx:S9XhZc2hvjdT5-IwDqYQtPo3hJ3IOAFKmtKGqxoBTlHmEZfCknoq6Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 08:16:58 -0500 (EST)
Date: Fri, 1 Mar 2024 14:16:53 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 roqueh@google.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2] hw/nvme/ns: Add NVMe NGUID property
Message-ID: <ZeHVRXsa5V04Yxdd@cormorant.local>
References: <20240222175017.2200940-1-nabihestefan@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ogJN83cpUGg62aK4"
Content-Disposition: inline
In-Reply-To: <20240222175017.2200940-1-nabihestefan@google.com>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--ogJN83cpUGg62aK4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 22 17:50, Nabih Estefan wrote:
> From: Roque Arcudia Hernandez <roqueh@google.com>
>=20
> This patch adds a way to specify an NGUID for a given NVMe Namespace usin=
g a
> string of hexadecimal digits with an optional '-' separator to group byte=
s. For
> instance:
>=20
> -device nvme-ns,nguid=3D"e9accd3b83904e13167cf0593437f57d"
>=20
> If provided, the NGUID will be part of the Namespace Identification Descr=
iptor
> list and the Identify Namespace data.
>=20
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thanks, applied to nvme-next!

--ogJN83cpUGg62aK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXh1UQACgkQTeGvMW1P
DekvPggAixGHMiVKvOrp5gisqwL/qxAAbu0/rH8KTsW60t0whzDy2//Jkrb40prT
OJtuFDC6TLvKGZ4wc2APn4k2fC/EXLwwQKrXQCv6lUiRmCOnzK7OH929WPMM5Bgv
R75AQUVcyDafpposaTiM/Qd1tZl2Hmm5+kcAekw53VqdOiLU+bvsFrYNdNeNLoGl
g6nQyoJaOJLQbQXUbn+wrHtJH8kphKg7OZ9tl8wRMU2a+X4o9TqPLF8xIMxEJZvp
FYUpFqe3llR9DWoDTy4lUeud33dukC7UlHIHwhsBo0t5d+xUV2NlVMGRV8NJufNa
ozGjyeaLGokzfzGUNHeO/KWUJr6oMg==
=hIvY
-----END PGP SIGNATURE-----

--ogJN83cpUGg62aK4--

