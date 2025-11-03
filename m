Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C76CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFu1C-0006hv-Dl; Mon, 03 Nov 2025 07:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vFu16-0006hT-VN; Mon, 03 Nov 2025 07:50:37 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vFu0t-0003Eb-Ay; Mon, 03 Nov 2025 07:50:36 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B986C1400128;
 Mon,  3 Nov 2025 07:50:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762174213; x=
 1762260613; bh=OTGuDwESw41DfTA1vqt73DVrtcGVHJfu+xYHS2R5Gkw=; b=z
 vK5c7XMySfpG3/4pVKZl8oxwqobTl2WYBWOLwH4rfQXOkOL2MgI8ZZCfyQDky9jS
 xqb5j1WTXsbQGmvJET2L9IhpGJuuVVD5f+T74xG/uJjK895tplIuvqT70ao3tZCN
 TSEqJCLu9zPXd41q0/M1yz3beNFr8Lu8WmdKb/5IjiLhVbL9Y5UUryZdSoVYMvgv
 yuXaJkxCrEK5vQsO8+P/dcK0yQ8YLC2uGk0Q2bu9o+18qpGRZQ4Vf8QTeRnzXm0H
 Yo2NTbNpe88M3dDQ36rXzsBSlc1G4dYjHAM4lC2tFgTRlC/m7gdaqtwpEUMMfwOi
 3v3eo4QWoCL9Vt9WQpHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762174213; x=1762260613; bh=OTGuDwESw41DfTA1vqt73DVrtcGVHJfu+xY
 HS2R5Gkw=; b=ACyZdF25AuTDERKwsCrJOH7dAcmNLaLRsoZ0N7K/vi5QciEZxKn
 HZjpzUdqLVj/Q2guEeFzxgd1sSNx/w/aHSJoNheb0ulb8pFOJRyNAAZh0MNz15YF
 0slheHk/ba2TiwwUHVx6AkyeR9pD4DTGcqixpFBvOaD1XFv7wLKBX3ANGYGxSVTQ
 wMtth4jb87ufVn7R/p9bzS32O4+2wlquNaXcVIgiX7/uPVievxv6NGGrZD+yHRBV
 839ARrZ/GLl6ScTiN7SMw45ONuAwdN8JaFlTv2RW5OeV23P6Qxv5md3x6Rg76Iq1
 /7cepHkyToX2HCnD1E0Lblgsi603reL3Ojg==
X-ME-Sender: <xms:BKUIaa5w7JBC-Hnm8orJaAFfS3D2Hn_HClZOsA-eNAR-48B8-PKm1A>
 <xme:BKUIad-tnThKjQuwtPiG32Fbtxh9asM5bW0citSUuqCBf_OBtCsAWLbGlNO0Xk8JG
 wfwDegu1wwwfHdTrn2H0VllJWr9wgIqUR-Wfoe6fqyrpob1QFBeWao>
X-ME-Received: <xmr:BKUIaZW9x-TbcBfaoV33UwPvcVtX1WAfOacNaGxklyvE8xpSjk7wgHXI1gY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphht
 thhopegrlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghm
 shhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:BKUIaYqRJGddGEFzD7_NtGRJIN5n6riW9Ikkgauv3fJNpjD12F6cnQ>
 <xmx:BKUIabmxGDDzZqfeZptj6GxGeRa-2OJggefSMIsXZYvfdwv3MCTqgg>
 <xmx:BKUIaY3_pGOrNeB4z6a24bOoehtwFTRgRbKqUKofNPZaSlUHR0RFiQ>
 <xmx:BKUIaYQLFK_xQxMHKHsSQGHT0gTMGOK-uWsu2QBfsDAqqNuSrSr--A>
 <xmx:BaUIaZnM8pnHb0MSr_2kThDlMLpxqa6B1A1rufe16kb9-49xY6FcuDff>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 07:50:12 -0500 (EST)
Date: Mon, 3 Nov 2025 13:50:11 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alan Adamson <alan.adamson@oracle.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org
Subject: Re: [PULL 6/7] hw/nvme: enable ns atomic writes
Message-ID: <aQilA2tNUB8Z1t-y@AALNPWKJENSEN.aal.scsc.local>
References: <20251030072956.1194-1-its@irrelevant.dk>
 <20251030072956.1194-7-its@irrelevant.dk>
 <CAFEAcA__RHC6oG=3801eS6wi-NDh9b4hC41Z44kpaix+YsphjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DjE2ghr8jlX+xyIT"
Content-Disposition: inline
In-Reply-To: <CAFEAcA__RHC6oG=3801eS6wi-NDh9b4hC41Z44kpaix+YsphjA@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--DjE2ghr8jlX+xyIT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  2 11:50, Peter Maydell wrote:
> On Thu, 30 Oct 2025 at 07:30, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > From: Alan Adamson <alan.adamson@oracle.com>
> >
> > Add support for the namespace atomic paramters: NAWUN and NAWUN. Namesp=
ace
> > Atomic Compare and Write Unit (NACWU) is not currently supported.
> >
> > Writes that adhere to the NACWU and NAWUPF parameters are guaranteed to=
 be
> > atomic.
> >
> > New NVMe QEMU Paramters (See NVMe Specification for details):
> >         atomic.nawun=3DUINT16 (default: 0)
> >         atomic.nawupf=3DUINT16 (default: 0)
> >         atomic.nsfeat (default off) - Set Namespace Supported Atomic Bo=
undary &
> >                 Power (NSABP) bit in Namespace Features (NSFEAT) in the=
 Identify
> >                 Namespace Data Structure
> >
> > See the NVMe Specification for more information.
> >
> > Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> > Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
>=20
>=20
> > +    /* Set atomic write parameters */
> > +    if (ns->params.atomic_nsfeat) {
> > +        id_ns->nsfeat |=3D NVME_ID_NS_NSFEAT_NSABPNS;
> > +        id_ns->nawun =3D cpu_to_le16(ns->params.atomic_nawun);
> > +        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun)))=
 {
> > +            error_report("Invalid NAWUN: %x AWUN=3D%x", id_ns->nawun, =
id->awun);
> > +        }
>=20
> This error check is about NAWUN, but the condition looks at id->awpuf.
> Is that intentional ? (Coverity wonders if this is a copy-paste error:
> CID 1642811.)
>=20

The check is as intended, but I can understand why Coverity thinks it
may be off. I'll rework it.

> We should return early if we've detected an error case in the properties.
> By default we'll fall on through. Similarly below.
>=20
> This is a realize method, so error handling should be by
> setting the 'error' argument, not by error_report().
>=20

True, I'll fix that up.

> > +        id_ns->nawupf =3D cpu_to_le16(ns->params.atomic_nawupf);
> > +        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf=
))) {
> > +            error_report("Invalid NAWUPF: %x AWUPF=3D%x",
> > +                id_ns->nawupf, id->awupf);
> > +        }
> > +        if (id_ns->nawupf > id_ns->nawun) {
> > +            error_report("Invalid: NAWUN=3D%x NAWUPF=3D%x",
> > +                id_ns->nawun, id_ns->nawupf);
> > +        }
>=20
> Personally I find this stack of checks a bit confusing -- we
> are presumably catching various different invalid combinations
> of the properties, but the error messages we produce are rather
> unspecific. If it's the case that (for instance) the NAWUPF
> cannot be larger than the NAWUN, we could tell the user that
> specifically rather than just saying "Invalid" and making them
> go look up what the requirements are in the spec or the code.
>=20

I'll fix up the parameter validation.

Thanks Peter!

--DjE2ghr8jlX+xyIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmkIpQAACgkQTeGvMW1P
DenNcgf/fqS6yb0YMqezsWdPkUjPFqf2LbLNY+ziUxvfEXqGqkDr0ij9nVYHwwTr
G0wHVQlKVFUrps4DmOG35AWVVsVxc+sow97MI8fsX/ufegpgoPRZivpmguo+JQzw
TtwwyYR6soyXDUiZv0W4TZkwhjXbhpA8/bUXiyqyHCl0YuH0SZ+weC4g3Pe64xUx
FJz81/xloWUMnfRbnl5B09VGDD3yv0be3dHK9XOdWc8p3BiNCk/legC7iy4llzAV
k25ELBbq4fEZN5P7liiJRldY+VPBlGT0SYa+o7Qc+FUUIfwT8TgzvbaGErznflX6
N0r83PW6Y0Xr3BDn144xBx+QlXI3rQ==
=7zXr
-----END PGP SIGNATURE-----

--DjE2ghr8jlX+xyIT--

