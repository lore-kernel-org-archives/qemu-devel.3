Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3523FD46BE6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 18:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlACO-00031b-17; Wed, 28 Jan 2026 13:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vlACG-0002z4-Pu; Wed, 28 Jan 2026 13:23:20 -0500
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vlACE-0004qa-0w; Wed, 28 Jan 2026 13:23:20 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 85950140006F;
 Wed, 28 Jan 2026 13:23:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 28 Jan 2026 13:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769624594; x=
 1769710994; bh=ufq0w4YBkmVoE1OX91JenmuAQyaJcWUsrvgYAXBOyJk=; b=v
 +Z6qyyPh4baFzaECtOf+mYEVu7n7Pf6PbsnAk4TEt69rQn/MwpNV5U2S8a8+IlD7
 mFCm7N8cQ6WrxNHaWHJIFNPoZk9rkP7cNtts+kauZ9Ow1vHDd1603b17XLXpxB+u
 LJePemsRAtSKOt1X0mHZnEnEjJdiatLd1H9O//xxCTfX9XQg7RKXzzexRaoxWu47
 LeWhrXavOTszTauVgG15/V0DmfM/eFvBVb9Px4A+8K0q28GSiug3MH4mZ2N9XOtk
 FM41XlV6W0w2FYIJCu+MeWBpcOAIQ008OHXQdS+imXylrH8siYIzrSM8Kuu5g1vM
 VwMkWz5lzMaYfSfXIAh1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1769624594; x=1769710994; bh=ufq0w4YBkmVoE1OX91JenmuAQyaJcWUsrvg
 YAXBOyJk=; b=GKWNZfWDok/RkK/BoHLUuYvkWljEzSELR3Vqfjo6rdSsAoKNue5
 JPHRP/7Au0yFBFEpI+pHH6HudXblwU55JUNVBYQyBhgiMMc3EES7I5GQnRmW82Dg
 ins+GJpbYf7p0/2yw9sy12z3bUD3RD92SOIxqy93VFfnuyj8HBTaIfhmnyoCTObK
 46ElaoDMvNSwe7CNqQrZ6+w1zDf9auxEvv+rrn8Yw3vyHaiJDb7Qo9lP7Zqsacr1
 YrjNP29xnuccFGn8QOpzzc14gmZSAb0TOp7pM7oHlBo0Hx7Ik0OAD+pKiugJU0qR
 fSMrUvBPfO9K0fvUKpx6oZJm7ddIZlcTovQ==
X-ME-Sender: <xms:EFR6aVHH97GVoVQKzctI_FfPjykIulaEDLL0AZyHPxJA9-Xq1EB5UA>
 <xme:EFR6aawW6ZPShwxJzsUpR0yqoOwa9FI8IvpK6Plr0yKe2MOkdfWm6xK-u7wx6Eg9H
 vvoJzUCpwIR-DgNoDoPBU3DuCJNkgKxq-UQpEFfskKE2f_5j0L66xg>
X-ME-Received: <xmr:EFR6aW6fENQVggRjJExZY-SI_tG30gaH5MWRSxaEMzua82qrxexFeyo1K1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegtddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpth
 htohepohgurghkihesrhhsghdrtghirdhirdhuqdhtohhkhihordgrtgdrjhhppdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehvih
 hkthhorhdrphhruhhthigrnhhovhesphhhhihsthgvtghhrdgvughupdhrtghpthhtohep
 rghlvgigsehshhgriigsohhtrdhorhhgpdhrtghpthhtoheptghlghesrhgvughhrghtrd
 gtohhmpdhrtghpthhtoheprghrmhgsrhhusehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehmihgthhgrvghlrdhrohhthhesrghmugdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:EFR6aXeFSu6qpNrWWFoEOpmNQErmBx6WT2bHrj8c63DknN-WTtZ79A>
 <xmx:EFR6aVHIAsCOwZoQv-BvBkRoElVUvECUs9XQesuo0Arp82esECY0OA>
 <xmx:EFR6af5vh92s3hqjoX-tq5qYl0mrN4xDRfoe_G-MF2a9rVqLRDfIbA>
 <xmx:EFR6aQtrwpcXRdQbUWKLX5YpnnRmFy5O9fVMt8A2AWvfTA-HNAVDCg>
 <xmx:ElR6aSe_zk_N_YbqXUuv_0dVFrXHdK3iPOaE8ZY7xv3nGpdww8pdOZ_J>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 13:23:12 -0500 (EST)
Date: Wed, 28 Jan 2026 10:23:11 -0800
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
Message-ID: <aXpUD4s7LrC9-AMa@AALNPWKJENSEN.aal.scsc.local>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <d74ef37a-b423-457a-b2c1-31989243b1a8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cfdbx87ZrHmYMy+c"
Content-Disposition: inline
In-Reply-To: <d74ef37a-b423-457a-b2c1-31989243b1a8@linaro.org>
Received-SPF: pass client-ip=103.168.172.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-a3-smtp.messagingengine.com
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


--cfdbx87ZrHmYMy+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 25 17:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 25/1/26 07:42, Akihiko Odaki wrote:
> > The bootindex suffix can be used as long as the property is alive.
>=20
> True, so:
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> But maybe it shouldn't (we should g_strdup it like other QOM fields).
>=20

Do you mean that device_add_bootindex_property() should g_strdup the
suffix? And then free it in property_release_bootindex()? That would
make sense to me.

My grepping tells me that nvme-ns is the only device where the suffix is
dynamic. In all other places it is a literal.

--cfdbx87ZrHmYMy+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAml6VAwACgkQTeGvMW1P
DemYGgf/aEHPJFOortkV25O4cUOZy2Li6Rz8R8iHweAnGqpWg1jUrcSceIOrXovM
ZNu0v4szzJwgsMl/u5S2niPu6yWXOSkVC2J//P0eOpX7fsWbW2jgooHSMhejVkkj
8HgWwC96sbSgQLIuGCX7+tZNCWEWKTafe8jjT6GDIdHrQlsq0+I3vFCDsJXrM8qX
CNNOOMx/Qv66nO6sECf0ys5AEglievHHyZgekLpawrFnHXLWZpsZ0TKAbDAxbt8i
e4X0FoxuX3umc41iTrXiqDvdHQxp73IkxbsS2GQRk+yIzheugl2mKWBGXhHh80zB
pcgcHJzjTGkxi7uWW5l125krX+YEBw==
=Xq6T
-----END PGP SIGNATURE-----

--cfdbx87ZrHmYMy+c--

