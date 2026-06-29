Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAECC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weK1Y-0006Xd-FU; Mon, 29 Jun 2026 18:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1weK1X-0006XA-5R
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 18:00:15 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1weK1V-0004SX-3P
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 18:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782770408; x=1783375208; i=lukasstraub2@web.de;
 bh=sbkSSJaXiqVSLJnMk+Z1dL6cBBPx1YuGMyifmWR8N24=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MrScwuMSvd0d/PJUs6/rzN+RCT2GCY8tM63t76UmSs4WejMM63r7isDJDtgtkRY7
 QismfHqHCWZfzY+ftek2+5ZmVACIWJk43FNEabpjcKZQS7g+PxD9M+ayylvF/MPpg
 EQ5p1fnoD4OErgKJw2Hr6M0o6g6Afb3Lr1WVBZklhHAWPfG00nsVs0nDSSD+GM0pz
 vgZT4+1i1+zLA+QhkTaBtN/x424KDKWW6S0JSItQyn7+g6ayqMmGqbVCZHiRUj8mg
 UVohSzI89zBoRtu2B0U3FCtrweBWjpLZbwjLjMFIV99kx8S6oOkSNFIMBfgF/bm2W
 evka5+NYtXBxCZYkiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1x83Az1k0z-00tdQo; Tue, 30
 Jun 2026 00:00:08 +0200
Date: Mon, 29 Jun 2026 23:59:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Alex Williamson
 <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>, zhenwei pi
 <zhenwei.pi@linux.dev>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Daniel
 P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Eric Blake
 <eblake@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 13/14] qapi: convert intro sections for yank.json
Message-ID: <20260629235945.1d871355@penguin>
In-Reply-To: <20260629213624.936258-14-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
 <20260629213624.936258-14-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V2cQSu0Lc.A.rsdz=6GRhQg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/EwPtdDgyFIbTBEqdYpEXUeFvr/9IDWgHkwR4VQtA6CiiOHxzbm
 aKeTSSooDFeIcEbV8GTu3RjWIfucB+vhhB0YDGTvsEXGPuTsUbirFMOHyBt5A9x7lCnb3rN
 3Jxt+ZzDbMiX7vW9V3bxThL6Bzy+Exd9P6uVDQEdQNrEWePTPG0jVuOxKNdLACspRaQn6iY
 5avP1XL2+109AEj4gJ20Q==
UI-OutboundReport: notjunk:1;M01:P0:506qyFNA1hE=;c6Lr39j/MGPOjcPy/SLioGvATym
 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
 h0CLs60M26LSbjxCCEBsRgz+aRPlqA
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/V2cQSu0Lc.A.rsdz=6GRhQg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 17:36:23 -0400
John Snow <jsnow@redhat.com> wrote:

> Signed-off-by: John Snow <jsnow@redhat.com>

Acked-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  qapi/yank.json | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>=20
> diff --git a/qapi/yank.json b/qapi/yank.json
> index f3cd5c15d60..6fdf169084d 100644
> --- a/qapi/yank.json
> +++ b/qapi/yank.json
> @@ -10,9 +10,8 @@
> =20
>  ##
>  # @YankInstanceType:
> -#
> -# An enumeration of yank instance types.  See `YankInstance` for more
> -# information.
> +#     An enumeration of yank instance types.  See `YankInstance` for
> +#     more information.
>  #
>  # Since: 6.0
>  ##
> @@ -21,9 +20,8 @@
> =20
>  ##
>  # @YankInstanceBlockNode:
> -#
> -# Specifies which block graph node to yank.  See `YankInstance` for
> -# more information.
> +#     Specifies which block graph node to yank.  See `YankInstance`
> +#     for more information.
>  #
>  # @node-name: the name of the block graph node
>  #
> @@ -34,9 +32,8 @@
> =20
>  ##
>  # @YankInstanceChardev:
> -#
> -# Specifies which character device to yank.  See `YankInstance` for
> -# more information.
> +#     Specifies which character device to yank.  See `YankInstance`
> +#     for more information.
>  #
>  # @id: the chardev's ID
>  #
> @@ -47,9 +44,8 @@
> =20
>  ##
>  # @YankInstance:
> -#
> -# A yank instance can be yanked with the `yank` qmp command to recover
> -# from a hanging QEMU.
> +#     A yank instance can be yanked with the `yank` qmp command to
> +#     recover from a hanging QEMU.
>  #
>  # @type: yank instance type
>  #
> @@ -74,9 +70,8 @@
> =20
>  ##
>  # @yank:
> -#
> -# Try to recover from hanging QEMU by yanking the specified instances.
> -# See `YankInstance` for more information.
> +#     Try to recover from hanging QEMU by yanking the specified
> +#     instances.  See `YankInstance` for more information.
>  #
>  # @instances: the instances to be yanked
>  #
> @@ -101,8 +96,7 @@
> =20
>  ##
>  # @query-yank:
> -#
> -# Query yank instances.  See `YankInstance` for more information.
> +#     Query yank instances.  See `YankInstance` for more information.
>  #
>  # TODO: This line is a hack to separate the example from the body
>  #


--Sig_/V2cQSu0Lc.A.rsdz=6GRhQg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmpC6tEACgkQNasLKJxd
sli65hAAhPEdAkYvL0h1+dUqYJErkW+Ir6pxZlGsbKcFQhk3JcovQGr6FNfcQwmZ
pkiPc7B6x+LdUhg6IyNYZ6WqVC886p5bAbxMTbrMswrYYOn7/u7/79dAjYOylrXz
JvxhCegW8MhiXW7vLds4sSICS8HG0VQ4ESN3JeSneqbwd+31B/mYQqJURNdTkjzv
XY/jR3CaJxGwJEbMauQ4kIPHXun2RQv+BoxnJI8QM42uC1Xvv/uSxhKAwW//axRa
Lc8AQZ08wll7Dy3QKBwSzU+s6fToh3Jec0wYfWvGgWql/AvlKmImM4C2FI/8OFSd
27wksnw9HGELTeuEqnLKwrzmCKAjm8RwxV1A9p62k8o1dkTeF0yEPxhPXfBnOY0a
XRGWXtCzK0KvsF+YAFEFc7bUegvhTmXtjb1wC1MAeaBFXZ1ILvjm0zwpT/sgi48z
fGyDGOOq0K+OrFq/zwdObvV3wH1o5z+tK1axexcuGqVwxteWg7gJdz1sj26mWurH
cgQmfElpHWT/X/vq071eZw72zdQzni6o+zwYd6Oq6BNeezFUDz7TmaREtWx1EVJ6
WPYM/yAYoUXw+BBGthJPfpohDwloK+9UznxtgKQGjOP0coIVvbsv9NlcSc/bloFT
4zJlHMAIzwQaZIHfxhDWkHoO6BGDvTRlsA5xjCxEMbiJ5RGPAEA=
=Q8Qs
-----END PGP SIGNATURE-----

--Sig_/V2cQSu0Lc.A.rsdz=6GRhQg--

