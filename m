Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D5C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2PDj-0007Gx-2P; Wed, 09 Apr 2025 02:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u2PDh-0007Gh-La; Wed, 09 Apr 2025 02:47:33 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u2PDf-0002pl-AO; Wed, 09 Apr 2025 02:47:33 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 89E9325402A5;
 Wed,  9 Apr 2025 02:47:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 09 Apr 2025 02:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1744181249; x=
 1744267649; bh=5qjpxwCCuq6Q/XUxOxVE5hdXXhZvJ86xZVAXe42y9ik=; b=U
 0cJx+11sHJ+GltBXwgs2lKMC7FLk2u56ofi9gLjMWkpP7Fzjae3+Csrh1MWwuWN6
 M4cMyMY+BUx9ER81P8BDWKoAFXdf+cqKbqUSgGXSk/aROzgOGnmSsIUgld+fC1dK
 EoYb5xkPcyyCLubwqwmkNpzz/E4TirH4xRmn7cTBaA+YwSehsunBErRMhcbEfvNh
 Y3iePu74davzHOlOXUK6+Mr7o77E+QTMfRewfUoXSgMsp5WRFhZVOI9yJ3O/w/pz
 ADD+szEMqzp9e1BJ96SheYDNcHEQJyPhK4mHoEfTHKDSOZncwpdxbannRNRQFJJj
 rYvKX2Msdvi3idjO1HtUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1744181249; x=1744267649; bh=5qjpxwCCuq6Q/XUxOxVE5hdXXhZvJ86xZVA
 Xe42y9ik=; b=npD3hshjAbbJF6YtkQUGOwuRaeltv5gL8UN3LIzPigtDRk9Urk1
 HrMpW9MjfixxxJYbQfvWNTnOK01scQk3YT1wr/pow/xNkmO/UdZzm17GhHajHbpM
 WBPgqn10pfZfUR1YaN0LShJhzBWQRMBQtZQ2HdANViYO/f5qjOaTBp+iYDI5x5Ry
 2xJylIaRCDHJ5ObhVk/OmgrF+DUucRg5vm4a+S91jHmGjjPwhKm+wYFQXdfjs0oa
 6xmrtmmqLBcAd60v5EDrhQ40EpND+ct8ivvZVgHYPFJEV7I0NyR2E6h6DIlp9MgY
 9EHbEOohziLttjNWoEDqVidQeS6m6ncK07w==
X-ME-Sender: <xms:ABj2ZxgQAKbV3VejPZJ9aDH0TFtxvKfIO5mGcq87Jv2ixUUtixPONQ>
 <xme:ABj2Z2CGkqrnbcOiF8ngxnVLV8L9qDUrfVc8WTrakEwUyyAXs4mupW128Yg8yVcFv
 7lc6AroZCzjVJdpk1g>
X-ME-Received: <xmr:ABj2ZxHP_Vyx75C34igSxU5aKhwGscdlOnelxGUy8jRgAv1mf36nuiDn-NgMcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehfeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
 jeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnh
 htrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudek
 veejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghp
 thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmh
 hsohhnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtg
 hpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdq
 sghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukh
X-ME-Proxy: <xmx:ARj2Z2TcqYbVxrBw4kmjUadPDLxer12soTTgFPT8Ewo_xh28aebhMA>
 <xmx:ARj2Z-xyyBKhXA9RyULfenG9rl5LbBUna8RsXvurs0lZIcBV0z7cKg>
 <xmx:ARj2Z86SDzFnHKMOckXQgu2BfZ4dCCiYN8vVbbmB168NrnJvPvM1LA>
 <xmx:ARj2ZzwnDE4ZFFXAEMXvY44R7DK67OGPWT_5qnr_8IY0hKmd0rpqEQ>
 <xmx:ARj2Z0p5wTBo-jzUC7DxDo5RNl5SVu1OGOkKXer-h7jgOA90xymj0OUz>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 02:47:28 -0400 (EDT)
Date: Wed, 9 Apr 2025 08:47:27 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, foss@defmacro.it, kbusch@kernel.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/1] hw/nvme: create parameter to enable/disable cmic on
 subsystem
Message-ID: <Z_YX_0KLEfcjWHNh@AALNPWKJENSEN.aal.scsc.local>
References: <20250408225644.814616-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zvWEwf/qUux0pPR5"
Content-Disposition: inline
In-Reply-To: <20250408225644.814616-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--zvWEwf/qUux0pPR5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  8 15:56, Alan Adamson wrote:
> While testing Linux atomic writes with qemu-nvme v10.0.0-rc1, Linux was=
=20
> incorrectly displaying atomic_write_max_bytes
> # cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
> 0
> # nvme id-ctrl /dev/nvme0n1 | grep awupf
> awupf     : 15
> #
> Since AWUPF was set to 15, it was expected atomic_write_max_bytes would
> be set to 8192.
>=20
> The commit cd59f50ab017 ("hw/nvme: always initialize a subsystem")
> introduced this behavior. The commit hardcodes the subsystem cmic bit
> to ON which caused the Linux NVMe driver to treat the namespace as
> multi-pathed which uncovered a bug with how Atomic Write Queue Limits=20
> were being inherited.  This Linux issue is being addressed, but the
> question was asked of why the subsystem cmic bit was hardcoded to ON.
> Most NVMe devices today don't set cmic to ON. Shouldn't the setting of
> this bit be a settable parameter?=20
>=20
> <subsystem>,cmic=3DBOOLEAN (default: off)
>=20
> Example:
>     -device nvme-subsys,id=3Dsubsys0,cmic=3Don \
>     -device nvme,serial=3Ddeadbeef,id=3Dnvme0,subsys=3Dsubsys0,atomic.dn=
=3Doff,atomic.awun=3D31,atomic.awupf=3D15 \
>     -drive id=3Dns1,file=3D/dev/nullb3,if=3Dnone \
>     -device nvme-ns,drive=3Dns1,bus=3Dnvme0,nsid=3D1,shared=3Dfalse=20
>=20
> Alan Adamson (1):
>   hw/nvme: create parameter to enable/disable cmic on subsystem
>=20
>  hw/nvme/ctrl.c   | 5 ++++-
>  hw/nvme/nvme.h   | 1 +
>  hw/nvme/subsys.c | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.43.5
>=20
>=20

Hi Alan,

I agree that it would be better for CMIC.MCTRS to remain zero for
single-controller subsystems, but I'd rather not add the parameter
without verifying it (it would be invalid to have a multi-controller
subsystem with CMIC.MCTRS zeroed).

An improvement would be to just set it if the subsystems contains
multiple controllers.

Prior to commit cd59f50ab017 we would also statically set CMIC.MCTRS to
1 if a subsystem was configured, regardless of the number of
controllers.

--zvWEwf/qUux0pPR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmf2F/wACgkQTeGvMW1P
DelUSwf+PR5tXJhqCs7a5HLumr+DcIazt0NJk7EGXX6ARhmdSKhlg2j1ccXl/Xqw
2W+xRWb3II1kb+ccTYvncUxJcjNy0XQDGGnhFGg09QjCqozRuY5RvWgSvofxth3s
xiJf0m+dcaoQusE+b88Y7IgH+5HNr6Gp5IIObQJv7iXVT08uyNcjGLPR2kGh7fv3
VgcR5kdH8JcbuUwosldbIRZ0VPWcK4r/HXtgVLV0ha6VmWuxBLhKlK30z9UMUlL5
V8u1Lqvjck5Rfg2WoV/7LacyEky96mN7KV3fqKocd4ko2tGphZJ+Asq+mAt23GPa
USwxR8mrgEQGezyEWPHS13KA2FJQ7Q==
=Aq/G
-----END PGP SIGNATURE-----

--zvWEwf/qUux0pPR5--

