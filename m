Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173AE74900
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAbk-0002rA-DO; Tue, 23 Dec 2025 17:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>) id 1vYAbj-0002qi-Im
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:11:55 -0500
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>) id 1vYAbg-0000aR-T1
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:11:54 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 19EEC7A0112;
 Tue, 23 Dec 2025 17:11:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 23 Dec 2025 17:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1766527909; x=1766614309; bh=eBkvmrnhQv
 xN06kDe/pPmb7sXtJ43MGpYNvRd10Oiao=; b=iAgEaiHg48wRaZWoesf/5knGdm
 QHCX2AgDVj+wz53Po4Pu/e5RiCxrjJCyj+xw63+r2tSuMB7zb24ic2DqGt2ZMV1c
 PC9XS2By9aYoDTgwEQ2AngIcfIQS8NMSRvyJ9atprXKSCWZam/0DzkZYd2CmYj5I
 /KkKzCmNRla/uL7f2rbgWFz0gCZ6lDJZvHH3YQOxlIn+G/kkvaI8DjMS3Q11oGLb
 zJsUGfpnKbvUlaCUHdrLYBq+UbeXGTma66pXBfa+qhu9Agk8JMJE9BWQLxSTJK67
 O44EMq9F/4UrbtRBcgZSJ0J+IjJ8uNeKpVOHzyV38pdyHG5BGjXFrpWVClbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1766527909; x=1766614309; bh=eBkvmrnhQvxN06kDe/pPmb7sXtJ43MGpYNv
 Rd10Oiao=; b=YQtSyQLlyjw0EoAVT6iwtTdDxHg3bidOuo9k3W+g0w35oNKdLYu
 gPYcKt++Vq+PnWaLBdCCDCn+40VSrghO74HOGX9y7nnj20+bt7cmS/WKNuX87j1b
 rIwvGj+9LGr+LBOG0D04TvqbyR4pnG7XFQ/p8tsEQsN4AewPcHkmTCrRtzVeZkgA
 SbhjdX8udzfLVqYS/yEZTpbMu5NIPw2OICm7rRntCl0YExLQsUCdJnSwRVczov3W
 71uXjKaEmVC9ZTAGspy+ptMWq1FUEGSkMKaAmXvY+hTXUGq8ZOik0WGFlwlAQHI6
 a/CIvQYc6SSDdZONCT+/nA73M5xb3LKVAdQ==
X-ME-Sender: <xms:pRNLac5or0DBfwIRjV1df87FQShTEY5OknbhlJrN1Rh3goxCdCt3qw>
 <xme:pRNLaZUBV7MaUcZZN1m0Bs4NyCU44CZDDFbbAQwOpLsa0Nk_kzUrvKnJx7cL8aYrH
 rrd2Y2eA4F8h7NVHg2bbT_79IkO1aS8Ll_XVTmYKti-ltJjjTFe>
X-ME-Received: <xmr:pRNLae-dvrpe4pYlPlWmHS8_7l10ABcO_sJXMrhTBWa2KPjHuu2cPLZqfOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtuden
 ucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhesshhtfi
 gtgidrgiihiieqnecuggftrfgrthhtvghrnhepgfekgfdvveegueekvdeggedtvdejveeg
 tdffvdefieduhfetledvgfdvudduffejnecuffhomhgrihhnpehgihhthhhusgdrtghomh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprght
 rhhitghksehsthiftgigrdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
 hpohhuthdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepthhhuhhthhesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdp
 rhgtphhtthhopegvthgrnhhouhhssehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:pRNLaVnfjrqOzmVgd6Js4ku1tqMzn-JSQNVnlAq942Px94D4bHmo-g>
 <xmx:pRNLacWhnYI11PMtIyTGVBjqUhCKv1naWz71WoFRXSXPD4QS4XOndg>
 <xmx:pRNLaSEJsrlc9PeXhmDKPiU5b2v07hLxNJZkq_YpEBeocGC9ZbH8zQ>
 <xmx:pRNLaQdGg0LpRzlxEhw65klKFi3ShKtg8-lGr6ZmKFpe6NyAxWGI8g>
 <xmx:pRNLaSAyENxR5aVT0QUzR-qt3BgY-UroBOuH_IoTkMjtI3ugwZmUftZ6>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 17:11:49 -0500 (EST)
Date: Tue, 23 Dec 2025 17:11:48 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ed Tanous <etanous@nvidia.com>
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
Message-ID: <aUsTpG0EGPh29pUL@heinlein>
References: <20251222073351.166720-1-clg@redhat.com>
 <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a6IdNjDPsXD+WBgv"
Content-Disposition: inline
In-Reply-To: <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
Received-SPF: pass client-ip=202.12.124.152; envelope-from=patrick@stwcx.xyz;
 helo=fhigh-b1-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--a6IdNjDPsXD+WBgv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 01:52:19PM +0100, C=E9dric Le Goater wrote:
> On 12/22/25 08:33, C=E9dric Le Goater wrote:
> >       ASSET_GB200_FLASH =3D Asset(
> > -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/m=
aster/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348=
=2Estatic.mtd.xz',
> > +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/m=
aster/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image-gb200n=
vl-obmc-20250702182348.static.mtd.xz',
> >           'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db=
0dbc')

Should we make these commits or tags rather than `master`?  Right now it
seems only Catalina uses a permalink where as all the others appear to
use `master` references.

functional/arm/test_aspeed_catalina.py
14:        'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef8124=
5b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina=
-20250619123021.static.mtd.xz',


--=20
Patrick Williams

--a6IdNjDPsXD+WBgv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmlLE6IACgkQqwNHzC0A
wRmssQ//WcrnZbksSpSC1L0xx/4/0wcb24d2TbC9QuFwv67XEVtmpgZEjd2TLk0L
jfhTsmCbUuG6bpBdcxYI76jP7Wy5PVfLhQ0gESWLPUIVEKPJ8//+3efoQORwv4TZ
+c56brHjFR5/aiqr9wu1+pRZMfXg1LjOczR3rD0XxUeiWoJQSHUHGhO7r1k2f89h
ZB3QZQka+Xisg1nnu9KdeR3D6Uk5wVIr8zsTt+OqmKGYwvdrGc0lhx2SGVCtpi5f
zSjBCXxRKqLBVBrZuLyqohhn73e5UQ08SjIsIOs8s1C740zgN0dzlSljoTkVkGOK
tnwgGqd7PcKAUy0I6UyxTku83XJG6P6w7byhuHWSo5yUFxpgdAbn2QXPrZEqsO7v
kpncPCUCgKV1l59JtysT39ZVP48P2hjX9ezM6/pnSVwWXN+D2NzO0cEiW3AX2M/5
FOrCS9QGByx9MInpx2YWxC0Qx/PMrnwh2tSY1dYWToWhzpv/tw4tONJr/6mqZ+Pr
jJhInArrnVEwG6fDvHnQdW/osz7cDgN4PL5OQgFPn7Un6Wn3PyEaj96BxGsTcjJz
ziXQUm3bcn+ebn/yVoqpM5rxGmpvzVAer7aJR7gLJr3QgHx2X5/VIPvcbgfleWcb
7K7mdMje1AtqJ7YVD5+6z0oj31IoHaZnEF95MUuleK1JH03e9mo=
=a3gI
-----END PGP SIGNATURE-----

--a6IdNjDPsXD+WBgv--

