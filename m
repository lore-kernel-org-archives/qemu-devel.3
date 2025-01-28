Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE7C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgb6-0002PQ-9B; Tue, 28 Jan 2025 03:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tcgZU-0007XL-Hp; Tue, 28 Jan 2025 03:03:48 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tcgZP-0002MN-Ik; Tue, 28 Jan 2025 03:03:41 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 4CA941140122;
 Tue, 28 Jan 2025 03:03:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 03:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1738051415; x=
 1738137815; bh=mTPayiI5jpxnB9+wnjAcN6+nTOeFHZYUQ0Z5D+OfENw=; b=D
 CS30vE4YgR6wRb4wTc4OntrescIs9bHLuLNQMrW27NQa48reMIr2lRJd8WQwbPSq
 dMtfBMWT3+LUC+uC8h2wu/6VB3P5b/QpVWloH9EeLkgWwEqF9qdD3+ZdOn62R0aV
 MYkU75Ysbz1mj9BOvxZeJ3t4gz5RWuZNRcCq+IWL91avI2awPoF2YHqlqLdjANT6
 rLQ0Tth/tLYnqyIQbjdd/gQ67HNGkqkr1v4D6mLbFmb9hKQadabUSFa+XxpiQEkA
 Mx41J3QQwVubTjF5cZ17T/lxjYZywcKfU9HRr0/UwnlFSVKqDHFHTm5tqZ9VX5Wa
 3o7DXJ+QyZ5fx/WR2+C8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1738051415; x=1738137815; bh=mTPayiI5jpxnB9+wnjAcN6+nTOeFHZYUQ0Z
 5D+OfENw=; b=UQqEdhsE6FvjMOZ1oKnunpUzpoPV1Fedci3a+jvjYGwuP8Qb68o
 IJHJJkbqK5ufNEGA+EFWkt10uD6tnnXapUyp9WNNhA9PQYo5z6QM448G0u02L09y
 SPTZq+vBI1HESzWYff23YB4BaP0uqyGwOmmIHJDB+7LNeWNNlea6Qp0q2n0s6C4m
 vIUzQWH5YY1aVJUGEcP8/s9tao2NycEfcdkTLme0vADy3HKQFe8tkFiOlP8lTZF8
 aBElFo6fga4QE+Df6C3DxLq6AoJaQRrPOSoXsc9DEkPzT1p6c4MnUX4tk6IPUEYc
 T9VYF92GRfbmw8U5rysOD3Ajlh0DYCd7eBg==
X-ME-Sender: <xms:VY-YZwbXHZyoBH0p3vApvoYyh2WuUJzXp9oaGK-YDrnJHQOT7muahQ>
 <xme:VY-YZ7YNYv04m_ighQugRdx-Oy2KPWRQvEfxzlQP6MJe_s0PhYET5oGXCVHKxVC27
 uXOShX6fWA9gBnB0ns>
X-ME-Received: <xmr:VY-YZ6-yOWpc5GqekHOsBu0C5Nw6TSt39WHmfoQpkGceYAsA7R13014YiweU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
 jeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnh
 htrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudek
 veejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghp
 thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhlfhhrvggurd
 hmrghllhgrfigrseifuggtrdgtohhmpdhrtghpthhtohephhhrvghithiisehrvgguhhgr
 thdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsthgv
 fhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrd
 hnvghtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopegrlhhishhtrg
 hirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:VY-YZ6q6UdEFCOS4LlZ9kE7TP4AvZ6fBKDbkduBwzDRxqGigbtXLIw>
 <xmx:VY-YZ7r6fEqyHsD0UMKluMAgO6GHaMQ_N4ZGejCeECf0Rk-WApJM8w>
 <xmx:VY-YZ4R52PAvE-Gg1vAu5EDuuKMR9duP2TuZPvUu5jyMWfXqrfDH8g>
 <xmx:VY-YZ7rmpfkwqn7kn6OLtQvr8HzE_OOT_0pNV1R9YSeL_0uevLgPnw>
 <xmx:V4-YZ2DDEJZEoz6YWD4wvHtgcTkThPaQGYyAOdsT5QnA7ar6XnVA8y85>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:03:33 -0500 (EST)
Date: Tue, 28 Jan 2025 09:03:31 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "hreitz@redhat.com" <hreitz@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "foss@defmacro.it" <foss@defmacro.it>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [RFC 2/4] spdm: add spdm storage transport virtual header
Message-ID: <Z5iPUztJrvJs-9A7@AALNPWKJENSEN.aal.scsc.local>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-5-wilfred.mallawa@wdc.com>
 <Z4DihskLy0wS9ts3@AALNPWKJENSEN.aal.scsc.local>
 <6b521ea30dfae69b447cb7c5d158ffcd0dbbf2d6.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uhLGbKEAH+7CGJCF"
Content-Disposition: inline
In-Reply-To: <6b521ea30dfae69b447cb7c5d158ffcd0dbbf2d6.camel@wdc.com>
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--uhLGbKEAH+7CGJCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15 02:16, Wilfred Mallawa wrote:
> On Fri, 2025-01-10 at 10:04 +0100, Klaus Jensen wrote:
> > On Jan=C2=A0 7 15:29, Wilfred Mallawa via wrote:
> > > This header contains the transport encoding for an SPDM message
> > > that
> > > uses the SPDM over Storage transport as defined by the DMTF
> > > DSP0286.
> > >=20
> > > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > ---
> > > =C2=A0include/system/spdm-socket.h | 12 ++++++++++++
> > > =C2=A01 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/include/system/spdm-socket.h b/include/system/spdm-
> > > socket.h
> > > index 2b7d03f82d..fc007e5b48 100644
> > > --- a/include/system/spdm-socket.h
> > > +++ b/include/system/spdm-socket.h
> > > @@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t
> > > socket_cmd,
> > > =C2=A0 */
> > > =C2=A0void spdm_socket_close(const int socket, uint32_t transport_typ=
e);
> > > =C2=A0
> > > +/*
> > > + * Defines the transport encoding for SPDM, this information shall
> > > be passed
> > > + * down to the SPDM server, when conforming to the SPDM over
> > > Storage standard
> > > + * as defined by DSP0286.
> > > + */
> > > +typedef struct QEMU_PACKED {
> > > +=C2=A0=C2=A0=C2=A0 uint8_t security_protocol;
> > > +=C2=A0=C2=A0=C2=A0 uint16_t security_protocol_specific;
> > > +=C2=A0=C2=A0=C2=A0 bool inc_512;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t length;
> > > +} StorageSpdmTransportHeader;
> >=20
> > Does it make sense to pack a bool? Is this defined by the SPDM server
> > in
> > use? I can't find the definition of this header anywhere.
> >=20
> This is essentially a virtual header containing essential storage
> transport data as per DSP0286. For example, this is defined in the
> upstream effort for=20
> `libspmd` to add storage binding support [1] and in DSP0286 [2], this
> is defined in section 5.1.1.
>=20
> Current implementation of the SPDM server (i.e in `spdm-utils` only one
> to have support for storage), will just pass this header to `libspdm`
> to be decoded. Once decoded by `libspdm`, `spdm-utils`/server will
> contextually check for validity of the message.
>=20

OK, understood.

> As for inc_512, it just need to be yes or no, is there a better way to
> represent that here?

It's a byte, right? Then I think using uint8_t is more clear here.

--uhLGbKEAH+7CGJCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmeYj1EACgkQTeGvMW1P
DenzuQf+OsGidZbJUykxLmQhg/MTAFKNYnFXRs7aBktGca3LauAfGT/p4Y+ODihE
Nz7E31eg+GUXVM+rc47tKMFKJ+s3X3dlf2UBr2VWUepYu77if5ShATTq+HM3bMz/
+SgKXoZOzd6VA3nNqQ4+m8JhTa7Sf0wm2Egkt6zkavBf2I1nzygeC6lAlxloyYXt
5d3G9Srkvitoh7a1H5GVMarq11vVg+DjExihms9QlvulsQAqM/5M+ZZte+1lXGJk
m9517GN/uN6Pl4bEesNb02XP31lr+n3sCW6bfRopUnQvNIf4q1NISyIvumqTpImB
n3wXKqtVGeumvEQJDYSjatirDBaoag==
=Pp++
-----END PGP SIGNATURE-----

--uhLGbKEAH+7CGJCF--

