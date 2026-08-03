Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE7CC55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqsvv-0002zb-Kk; Mon, 03 Aug 2026 09:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wqsvt-0002vc-0A; Mon, 03 Aug 2026 09:42:21 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wqsvq-0005e3-Q7; Mon, 03 Aug 2026 09:42:20 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7A8CE140005A;
 Mon,  3 Aug 2026 09:42:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 03 Aug 2026 09:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785764535; x=
 1785850935; bh=Yf+4Fzg7f0snJO6beJsfUmDHnJi35JliFYCVVt+uQAE=; b=l
 ClM+nTKWfGv0Qlw2EU/xL9Qg/81rO0GVF6XdIzcJnXAdJSTklBqPeHhYYESLeoZm
 531unUen2wCyVhs61+DiEnfj5/VvZw8W6OFEDgAQ5Spg2b5sqjaT9LJar0WnRAzr
 fdmxn1DBTkZvwRWrXB+2uXmY6m1RUmsPWWQtpm4F+6C8JXSsGxcUuh1padwrnEzM
 Vuqxwu4WGKfFCGEWkvmdr26T7Uv9ghlk2J2GfvMYXePO5tibEt9eI8sPMbbCQoUM
 01EQy7W5oVJukSavdDXoI8ARt1k5z7MrtLBes2VPxS6mABi4N2pT98ctxY45fpqa
 iZ7eotnIXe/E9B++lqC3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1785764535; x=1785850935; bh=Yf+4Fzg7f0snJO6beJsfUmDHnJi35JliFYC
 VVt+uQAE=; b=b7XmYVV4jzhirS454gX6uQikK9FJmfh4gs6aW09A6teofelCfSF
 PPZLsOVN7zn/gL93ph+n/mR9Cxe1F3uR0HuCQ1c6QBYbXXlkmbgXkoHLXnwxyGiU
 oZ4UdMaWJDTh358ZIuMwfRGimTE08Q3Nnq/7KNPc2HNCag7+dx6MoIo//fQA3swF
 Kx+yjKxsKvofOq/E3664+gn+qdm5TUdQFg+ifwGJI1aU60dVWUzhMGRRkfIbcLpb
 nnzAd7ZMXi2URX0iapTJ+FmXjcwvPdSsqewC/IiREp0L0/Ne5BxaIxITE/Avk+Rl
 dqjQEiEMxcxjJIu+CB1gRPl5qn1PVpYUuBw==
X-ME-Sender: <xms:tppwalYUbO4eGthagUFIxm5FhS2tKlqI314r1pfrcxS4dnJc4BimJg>
 <xme:tppwamdM30OwI__yl7sgS-2jPI-uASAaabnnnAUxN9qNuvBKdziWDSuimgNdkoxBT
 m5qSTGrXyMZWnAS25NPCH_5eoyqr6gdTkGseNocVLyaCunwQQ9aTeU>
X-ME-Received: <xmr:tppwan1thrnerF_RnB-vM_Ji4PLN4Mev5fomtm6ZWoL2vWG--4jN6XEG>
X-ME-Proxy-Cause: dmFkZTEFX7S3CrIZ2Q969ISaDx9N61yiBWeeOE6QgYRBh/Y0njSV2LglHSCevB/Et6x9h/
 QZM/56V/vmxZk+sJp/qTT/8VLS1XwftckgdnqVg3Pf0RES8Pzk3sbkDi6EL2Ehdk1ZTedr
 gDBf7aNDqmTYmjrXpsRlfIzC6cnigkglEbm86Hb3kvYGkmpB8y4gm7bN9b1pqhfAbV6QaL
 53vtBmvvQ/gag3eYR/Y+uVY3qweApaSskicXd6EmOwZXoi23KJviyzSzOs2uvxvpc6sy3U
 EreDMT2OdNaj2gQavIzA8hhk9PLRJVPO46IBi7NTk/3o4bya9nVZutRmGNdr0LW0+wamly
 9iIkUOCH8ONaCcCNkkAQdWdUlWy1FmHIgmu/Ead0bH6m9HRRuA1STC8IfeoTcFrFFOr2B+
 HzRfJNFDMqN3yFGdKrqHHDvuqagfbJnkB82J1cj/yc3eMtNUImDYYpcy4zCQaysGhx6w/+
 tFe1o4ZmeQ136tsNZ/xMp59M8FrvJY1F9ov+Z1G07UxHNMitcwwV1crzPsQz6jR4/PvBiE
 PpIqzK2QT+MPaaxYvLqqU1GkEcEeeX41WCvMwtNbck43/3p/RZkH4Kme4TQRYhcCvlbG+X
 NRvkikL6NUy1NZWyCX8S0sLtFm0kMnXWtcsUmXN4cqwqyBr7ANpajSlWX+AQ
X-ME-Proxy: <xmx:tppwalLnP6i39lII-Edxxck-r-1SI-rtKqWOhG5azxuZ8qYrqtZjHg>
 <xmx:tppwauHnLfwx5lDzltlaZVv7ZZV2Mm5MPTsiAJAKsIbZ89cRexktyw>
 <xmx:tppwapX-NPS71YRlpnDu-0JMfACx921mpn6xTVlQeuqJ83P3tdViwg>
 <xmx:tppwauzR5KZRqtVyfQtGoR9XJR75dDcr8oSXR3S45GhQ87QZK3fTjg>
 <xmx:t5pwamae6BzdOPZhRDnT2v8ybU6Clru1_BCf5-PdtxyX1SljkMqN0ZNL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 09:42:14 -0400 (EDT)
Date: Mon, 3 Aug 2026 06:42:13 -0700
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 0/2] hw/nvme: support online resize
Message-ID: <anCasYYUJBhDqOKS@AALNPWKJENSEN.aal.scsc.local>
References: <20260803083046.110121-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QvzZtpiYT/8oiZKU"
Content-Disposition: inline
In-Reply-To: <20260803083046.110121-1-alexander@mihalicyn.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--QvzZtpiYT/8oiZKU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  3 10:30, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Dear friends,
>=20
> This patchset is aimed to support online resize for NVMe emulated
> device. My approach is simple - I just implement (BlockDevOps *)->resize_=
cb()
> callback and ensure that AER notification is fired to all controllers usi=
ng
> a namespace that is being resized.
>=20
> Testing.
>=20
> I manually validated this with Debian 13 VM (a resized disk was a root di=
sk) and
> Windows Server 2022 (a resized disk was a secondary one).
>=20
> Git tree:
> https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize
>=20
> Changelog for version 3:
> - rebased
>=20
> Changelog for version 2:
> - checkpatch fixes
> - rebased
> - CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)
>=20
> Kind regards,
> Alex
>=20
> Alexander Mikhalitsyn (2):
>   hw/nvme: initialize ns->subsys for n->namespace
>   hw/nvme: support online resize
>=20
>  hw/nvme/ctrl.c | 10 ++++++++
>  hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h |  2 ++
>  3 files changed, 79 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.47.3
>=20
>=20

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--QvzZtpiYT/8oiZKU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpwmrEACgkQTeGvMW1P
Dem5ZggAmfMv7VyPoNEQMQkgR7fI2tIi6zCaNqlCBVvC3jzC6k7rLIQ7D+DyjHpb
HP6IBq8zIfa94Y1e+DF1uwgYv4lN0EIVhX3q2e6nOtn3yYJasAaFVS2yEXOMaBOn
vEpL17ToFrzqb3dBQ2JnXNTjBl8e8hauDeFnJUSmGJBWgwCGN78EKNX/Bncnm9+4
etrEKPb8Z2KGJr01zzn/RRKn14paAmW3YWkHzTh60aZLmaQPjHAfvEJYRBSUF6IX
rPgMjtY14v/+gxS0yXFX7KRdYN3LHb8JJJg4rDnoAP7FQt2n1hgR9WtymTOUONe9
3qRzy06jNgFbJI0cWiL5PTI2UCQdyA==
=wet8
-----END PGP SIGNATURE-----

--QvzZtpiYT/8oiZKU--

