Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F754C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMLe-0000n3-Ga; Tue, 20 Aug 2024 06:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgMLc-0000fm-Ie; Tue, 20 Aug 2024 06:44:20 -0400
Received: from fhigh6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgMLa-0006JQ-6p; Tue, 20 Aug 2024 06:44:20 -0400
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal
 [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 500031151C18;
 Tue, 20 Aug 2024 06:44:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 06:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724150656; x=
 1724237056; bh=DTW8UrFp9WKlfbSbTQXXST2MEtJhSFn7Rwqi0gp4D2A=; b=c
 yHesu8N2kmR/em4Zc9djzEBIUtpwklfU9gySqjjZ1Ai6eeNWzpL3PXD4yfDAF7nX
 wFf4/cvm5wgG4rXsqrxE9zOm4YwzLJsQi4Oz6jhFDo+cwFLcnvbAt1Wb1f+Z3vEa
 I4r1EBT5EoDMGsPvaM6oYNKcTtTOxOPq54LDNL775bncYbxtZPdAFGB80z1oX39N
 eGqnMlvQZF/NXNVosSfxr6J0cveWDtfvDC1f/7cpGQ38rP+DzMw8kEDi7GTlKgF0
 No+v8e14EiPPIZaGCf2vPFsAhvT9itoUIJ1llxlqyiRy0Atpmw9MBfox1NU0gNr+
 htbm2RIHq4NGL40WuM+pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1724150656; x=1724237056; bh=DTW8UrFp9WKlfbSbTQXXST2MEtJh
 SFn7Rwqi0gp4D2A=; b=VkG44jyKRlEokJxgpeb9Pm18jhmLbAaeZ62yHEN22KTE
 x04nXImrncO7P6wv6bOdqkAWyDSwkii7Uz5nyCKiNk0b9cHPAYiDC9M0J6cYqOx7
 LIjaRCGIEtHCQdI8OiGpTOuW3RG7WAxw2zzsw7PuvNBXnZEX7wfAiVi9I+pv1KCs
 FVrZcbZo2Z1L6RDKpTfBcBdfn+6pkoZC11ygGaKqdsIQqBxVhhlBRZBk6buMqyP+
 57hsTZqkoLX31TKFGNrLyiHvWGNOCY3sOQIGhCTefAbCMCvHgddMfC8agCQTwHnD
 KciU0CUgbjXhs8+MAyUstLQGL3ovHyvMpsiEEig+5Q==
X-ME-Sender: <xms:f3PEZqyKc7VqSJttQUL16UW4T_zZxMZ2kCvKu4JOobW6btA76f7-VQ>
 <xme:f3PEZmSvTldzehr720QZ4qr49zJrEgPoLZnKbxdIXQP6MvrEI0ne0qSyQQcjOPvgo
 zptrWUFFXXp7hBbCHg>
X-ME-Received: <xmr:f3PEZsXdpD0bN9wEMIdM39xbT1aJOl4Crx1PcrQjhfzQl7CjyyZwkQiRAagI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinh
 grrhhordhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhgvmhhu
 qdhsvggtuhhrihhthiesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslh
 hotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhho
 rdhithdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtph
 htthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:f3PEZgjX8OrcL4B7t1Cvltu9fvNeCIVjoop9U0ZB6Z-UprB_vOJciw>
 <xmx:f3PEZsCCYNGA5Y4lFFuqnA5Nj-eF5I3nID8-GXtKXBJk2l93_YUE6w>
 <xmx:f3PEZhLIdmU_2B2xfWpe2bgwZGAYHoYCRJ70dXKyAdEJB4wRVIczlQ>
 <xmx:f3PEZjDtiGo93UyLu2f9qib_5-lGR2kkUjMY6nk7Q8OHREu06LOZ_A>
 <xmx:gHPEZlIDd1doxiwaIjo405XKzfUilcXBzZ04TPcmPNUBff8mOxo5IeSN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 06:44:14 -0400 (EDT)
Date: Tue, 20 Aug 2024 12:44:09 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, qemu-security@nongnu.org,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Yutaro Shimizu <shimizu@cyberdefense.jp>
Subject: Re: [PULL for-9.1 1/1] hw/nvme: fix leak of uninitialized memory in
 io_mgmt_recv
Message-ID: <ZsRzeRry-7-GrMxR@cormorant.local>
References: <20240820044505.84005-3-its@irrelevant.dk>
 <20240820044505.84005-4-its@irrelevant.dk>
 <65bac872-f461-4e2b-b959-7bf020139fd5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M04zsA8dMw/sCa6m"
Content-Disposition: inline
In-Reply-To: <65bac872-f461-4e2b-b959-7bf020139fd5@linaro.org>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--M04zsA8dMw/sCa6m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 20 12:30, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20
> On 20/8/24 06:45, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Yutaro Shimizu from the Cyber Defense Institute discovered a bug in the
> > NVMe emulation that leaks contents of an uninitialized heap buffer if
> > subsystem and FDP emulation are enabled.
>=20
> Was this patch posted on the list for review?
>=20

I wanted to get this into -rc3, so I might have jumped the gun. Didn't
add internal Reviewed-by (I should have done that). Jesper reviewed it.

Reviewed-by: Jesper Devantier <j.devantier@samsung.com>

> Usually we log here backtrace, reproducers.

It doesn't crash anything, so no backtrace; but Yutaro did provide a poc
to show the leak - those are on qemu-security and I did not request
permission to make that public.

I realize that my commit message is too brief; I will add that and post
as PATCH instead.

>=20
> Which fields are leaked?

Parts of the NvmeRuHandle descriptor are reserved - they are not set
explicitly here, so they end up leaking heap content.

>=20
> Let's avoid the proven unsafe security by obscurity.

Apologies - that was not my intention!

>=20
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Yutaro Shimizu <shimizu@cyberdefense.jp>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index c6d4f61a47f9..9f277b81d83c 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -4474,7 +4474,7 @@ static uint16_t nvme_io_mgmt_recv_ruhs(NvmeCtrl *=
n, NvmeRequest *req,
> >       nruhsd =3D ns->fdp.nphs * endgrp->fdp.nrg;
> >       trans_len =3D sizeof(NvmeRuhStatus) + nruhsd * sizeof(NvmeRuhStat=
usDescr);
> > -    buf =3D g_malloc(trans_len);
> > +    buf =3D g_malloc0(trans_len);
> >       trans_len =3D MIN(trans_len, len);
>=20
> The malloc could be done after finding the min length.
>=20

Yes we could do that but it complicates building the data structure.
Here, what we do is build the data structure to be returned in full, and
then we transfer the minimum of what the host requested or the size of
that data structure.

Regardless, zeroing the memory somehow is required. We could also set
the reserved field to 0 explicitly, but g_malloc0 is more clear I think.

> Shouldn't we check len is big enough?

len is a host provided number of bytes. It does not have to be big
enough to fit the data structure; we transfer the minimum of the data
structure or what the host requested.=20

--M04zsA8dMw/sCa6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbEc3gACgkQTeGvMW1P
DelOoggAplfOrZpUxZVS1s7QRIOwjUNwueZAu7pcnVVodTk3IddrEHIHr1nPw34m
F7HmM2ge6HAytyRaLUHJTPWUTXbrGxrczUQeYnzNFeHBnUvqDh09aDQR7HImRTtL
U8p/v2LKJt6/U2v7ej+N2W+I9D45AfhFX/fw5F9z8IAoEdFN3NGDaf4UUIFN4Ezh
Wp0j4c2jGWKETRgYDAvaszntFtyjul0oAc3fD9EuTlvMNyGep3dYlHNabgtebnXo
6xizrR6lpwnmeZhBXgir1hQ15VwAHOVSfYFb9tWeOVP5jKKNH7CVUPZ2UWWUqBWb
Wb4Fuku2tWW7hxf6QsMHmhAPIE+suw==
=N39N
-----END PGP SIGNATURE-----

--M04zsA8dMw/sCa6m--

