Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296E5C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjH6z-00013o-6B; Sun, 10 Mar 2024 07:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH6s-00011C-4p; Sun, 10 Mar 2024 07:12:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH6m-0006d1-Qm; Sun, 10 Mar 2024 07:12:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id C82075C003B;
 Sun, 10 Mar 2024 07:12:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 10 Mar 2024 07:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710069162; x=
 1710155562; bh=rmhVH6ZbmNgHsyIvlpQKufN3edNaF6XuDxNGrDyKWQI=; b=I
 yWtJ139nrIwGf+xWArsOEXdx07rteXOaQDJvzEpJHXXgROb3lgWwvNKxB2vTg0kt
 0SmynlEdf3U921Xt2mXoFt7JlHz2bKxlRIKjwjsRLnf2RWgh5zRHrYDug499C+2i
 FxYT32vH343yea6hL8W2eU9yNpn/lkjSopcXDLt3T60XifyLwDwMR46us4X2AXbB
 gzj0Gbdoi5Hv948ux7yK43fLbpJ+3DoiQqmjeT3Gt74zz2B64/u8Ii/XXfim652r
 DKu8Ta/RgcdOhV14/QuASc45ZUWTmpVKoINGgz9YcAH++mj3H0lH7bmX6crY0SRD
 EnpmpRiZ0GPjXsA3G4TPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1710069162; x=1710155562; bh=rmhVH6ZbmNgHsyIvlpQKufN3edNa
 F6XuDxNGrDyKWQI=; b=ASorf88x72LEnMN3ahObwCNV7Dt2CWNGEnpH4XTS/5tU
 zu6G8BAWFjiv7853Ultl/xAUEs7Yrxsn5t9cLXB1SIS4ySnfBXBEx/dx3CSpGYS0
 l7SdVcSo5GFgfT5Gj+j79heNn3fcm+EpQvGk6wTEqADNrhhWNtDDHKH9/w3Z8cso
 AqhFVc1MVGFnuwCZ8fmBYlMNoBV5pMAIzIXwAbuto36G9B9GFVoHLBbAnzQl5jV1
 f0OYprMyAEH2BRYdYumoHirCIwL+LAZhdN/eIp9fs/UUkB91mued9BF30QEPkB81
 cvhdGui/hx7T7lIBYdRQmALhCSxAPerANWFaLPytYw==
X-ME-Sender: <xms:qpXtZWMSCiT__TryBiYWximyCT4TaPjrwtgQCvgIXHmCfCTB9u8Aww>
 <xme:qpXtZU_iCHr6-VU5H4FrD-i5kgTD2-074T8aAt8qoJbRWX9TBCJVJgw0bw2BtyrUE
 NBjSzl9yuxL-KeFEmw>
X-ME-Received: <xmr:qpXtZdStTwtowonwnw1y3O8CDCblw7b5hzATmW3Hm6t2aiuEqzOwm1yTGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieelgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qpXtZWvnbMMS30kexSB95HCGzWqIks5xcZ8qqSaUJP94f3MCLnqMkA>
 <xmx:qpXtZeduMGpkv4dw_f9WjN5WTiFFrngvwjQkM295-7fFhfP0Ip3lkQ>
 <xmx:qpXtZa1eHcpQkW6RlvQr34DeDpaT1uuYE5Q3crTSKubIgmGOk9Qa8A>
 <xmx:qpXtZe64BpKjurea-6y2AmvP1kSFSvFyDn92xTWmboxuItiOftHxiQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 07:12:41 -0400 (EDT)
Date: Sun, 10 Mar 2024 12:12:35 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: Julien Grall <julien@xen.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 0/2] hw/nvme: fix hibernation-based migration
Message-ID: <Ze2Vo_RhXCjtLwkp@cormorant.local>
References: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X5f41pQnLb1Pct7V"
Content-Disposition: inline
In-Reply-To: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--X5f41pQnLb1Pct7V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 10 12:07, Klaus Jensen wrote:
> Julien Grall, in #2184, reported that hibernation-based migration with
> hw/nvme is broken when suspending on a pre 6.0 QEMU and resuming on a
> more recent one. This is because the BAR layout was changed in 6.0.
>=20
> Fix this by adding a machine compatibility parameter that restores the
> old behavior.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Klaus Jensen (2):
>       hw/nvme: generalize the mbar size helper
>       hw/nvme: add machine compatibility parameter to enable msix exclusi=
ve bar
>=20
>  hw/core/machine.c |  1 +
>  hw/nvme/ctrl.c    | 73 ++++++++++++++++++++++++++++++++++++-------------=
------
>  hw/nvme/nvme.h    |  1 +
>  3 files changed, 50 insertions(+), 25 deletions(-)
> ---
> base-commit: f901bf11b3ddf852e591593b09b8aa7a177f9a0b
> change-id: 20240310-fix-msix-exclusive-bar-d65564414a2c
>=20
> Best regards,
> --=20
> Klaus Jensen <k.jensen@samsung.com>
>=20

Whoops, forgot Fixes: and Resolves: tags.

Will add that on the pull.

--X5f41pQnLb1Pct7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXtlaMACgkQTeGvMW1P
Dencggf/W9qwf0XUiscVRlRCxFKTZ5ISgtEe/uvSzU+7n3heUy5Cr6rxkr65qGbv
PugEk95/0X5lz+INpXFkpAOIPSDukp7yFe5K6Mx3/qNcXO4lnbUqt9ci4EKrD2ON
jh0Msuwa9jcs3GETn0Ru83wIzDj2ncJNDdaNN3rWBLwezKSpnUFO/Eeg+HaJAXzq
Bkn8X3YrNv8pwJr9JjOIsB4LDT2zi7ePoQsV4pSmmPJgHrHtDzgjSfE8Q21IDMO+
05ZFuIoQgC2Ro6GSG/q2bkweUDLTE75kULOYY5utLYDcuD8zBTrL7we6RKmHzGb2
4PrVL3EqMngOObToKi/2YwaIw/9jtQ==
=N+dP
-----END PGP SIGNATURE-----

--X5f41pQnLb1Pct7V--

