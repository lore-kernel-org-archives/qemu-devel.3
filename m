Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AF6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 00:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mSP-0008BD-5s; Sun, 05 May 2024 20:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mSN-0008An-58
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:43:51 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mSL-0002GF-DJ
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:43:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 0032B1C00123;
 Sun,  5 May 2024 20:43:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 05 May 2024 20:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1714956227;
 x=1715042627; bh=GSTBJNSEtl8MwjGUTXO9Irkbt9SMO1bvpJFfCxULEdk=; b=
 jD1TZwyPzPt4dO3thb15WX/xsDD+AanvfIg/yz/6c6iIx5SJ6EUzke6NXMrqqqIL
 +sUJJRxRMESyBmeGNdeOmEXkCnRt1C1OcQf3Tsff+TPGIeTK9+ZYRcO/TlOXP/ty
 86Is6vmf0EKfU0rq0oJCvr95TsteFhs+Smc1ldYLZymAToatwaz3RXHfenzAIUmb
 pEEZ0tTClPrFzE+n3uj8q3fBCk3U1ZPGax28cghZEXvq+ekQnvD01uqBufEh3Jsc
 tYywbWhmAknM/kdmjeR6gYJ6f9Z4AvSAm11KpSfUB+KrzHfBDphjH0TGHOi+ALPG
 QqEE1i9sh3GTx3KO8HioQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1714956227; x=1715042627; bh=GSTBJNSEtl8MwjGUTXO9Irkbt9SM
 O1bvpJFfCxULEdk=; b=b9klGxDDCj442mToWgJY15IcU5X4Sf4Mt/ZodLeBMpfx
 pMISYm1bvqYLXd/4tVbxb4p0igcwJc3ILmIAZ3YxHKjMBKF9K0YV4kNS7oNZbFek
 57QBdWOZho+mIaQDD2tHxVrWLdn/YwkFIaf4uDOlvxsWHu1JSIjU8v1IJLgeBa4f
 tV25IXt8lGDdK+rZeoHKlZD1FjH0apuD08ljovQaTUgCvUFEqKU9P0ekxkGqfoVu
 GDh+SYeGImCnDLk/hBZYcrJeTNwR1b+ugZM6ZOxuwCLyo20RkbRB38bN8ZTBh+zg
 BL0rX2NDXz2ttLawbQHK4u7SAikuc6ICI5NoeDVpNQ==
X-ME-Sender: <xms:wyc4ZuNuPOwstAw5XkcjCoRIlun8tg4T3OBr11-GC7xZxYmX9ORR3w>
 <xme:wyc4Zs9ElTyNvUBgCwcGJ8WMBWPOWrhiwNhvpNbWuqE5qwTUxcU80ZoBD71qhnAOH
 7-lqeGmJ7jW_Q>
X-ME-Received: <xmr:wyc4ZlSelM8ZZcGC5V2ItfyywTuK11vzbovNAEJUraIFHQLdemM4sZ6iMjRPxpMaUwOYakB2FvdN7Nshjqj5E8c_hsCaJ0BmjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
 erredttdejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgv
 tghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
 hmqeenucggtffrrghtthgvrhhnpefgudelteefvefhfeehieetleeihfejhfeludevteet
 keevtedtvdegueetfeejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggs
 rdgtohhm
X-ME-Proxy: <xmx:wyc4ZutN2vpf2tzmYpUD_JWnUmUE_vOIOc0TCNw80YSmo2iOZlg5lA>
 <xmx:wyc4ZmcT3MvnimRHyoHYlIKBRMAkBc7vBAaLv2W5Ez_iwFZo76t_4Q>
 <xmx:wyc4Zi1p_TvKPIZpZAUaKZWFYnprQth70xV6khNGmNX6YIQX9KZlqQ>
 <xmx:wyc4Zq_HfaWwQZDBLmBv4bVFs8X7YXrfBwCPbVAuA9uK8NaTcnwy-w>
 <xmx:wyc4ZqEL1z8ujawolbPm8EwH3j7-iCnTRbPhs2viPpF1VUnae-ZjTyJc>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 20:43:46 -0400 (EDT)
Date: Mon, 6 May 2024 02:43:44 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: anthony@xenproject.org
Subject: Re: [PATCH v3 0/3] Fix MSI-X handling for Xen HVM
Message-ID: <ZjgnwLZ__HbNauHW@mail-itl>
References: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fSX2++y3p9WVUB3a"
Content-Disposition: inline
In-Reply-To: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
Received-SPF: none client-ip=64.147.123.148;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--fSX2++y3p9WVUB3a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 May 2024 02:43:44 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: anthony@xenproject.org
Subject: Re: [PATCH v3 0/3] Fix MSI-X handling for Xen HVM

On Mon, May 06, 2024 at 02:33:19AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> This series fixes handling MSI-X when device model is running in a stubdo=
main.
> The main part is to avoid accessing /dev/mem, which also fixes running do=
m0
> with lockdown enabled.
>=20
> It depends on a behavior change of Xen that was just comitted, and signal=
ed
> with a feature flag. If Xen is too old (and XENFEAT_dm_msix_all_writes fl=
ag is
> not set), fallback to the old behavior.
>=20
> The other part is a fix to enforce read-only registers in the config spac=
e.
> This fixes MSI-X setup for iwlwifi Linux driver, as it happen to write to=
 MSI-X
> capability id reg (as a workaround for some older device which has another
> register there). It should be no-op, but due to a bug in xen_pt code,
> it broke MSI-X detection.
>=20
> All those patches have been shipped in Qubes OS 4.2 already, and prove to=
 fix
> the issue.
>=20
> See individual commit messages for details.

Initially I sent the series with the old Anthony's address, but just in
case I forwarded it to his new address too.

> Marek Marczykowski-G=C3=B3recki (3):
>   hw/xen/xen_pt: Save back data only for declared registers
>   Update Xen's features.h header
>   Do not access /dev/mem in MSI-X PCI passthrough on Xen
>=20
>  hw/xen/xen_pt.c                     |  7 +-
>  hw/xen/xen_pt_msi.c                 | 94 ++++++++++++++++++------------
>  include/hw/xen/interface/features.h | 17 +++++-
>  3 files changed, 82 insertions(+), 36 deletions(-)
>=20
> base-commit: 2358f1b60f73287fe606c7ff48043b4f9e1c2d0f
> --=20
> git-series 0.9.1

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--fSX2++y3p9WVUB3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmY4J8AACgkQ24/THMrX
1yyslwf/fZ3h+ODQqbgt5MSSsOYekZRwcU3wZawlDx5gb/nhX5clI5qTmd0clobn
wgTsuqV/0G5Cc3T5m9B7exB4A2Sp/ukb7XAUeUJPBgwFJarzk9ajgU/mWNUQm/yZ
E2PqzMy18Ad0NisdfEtPMcATQDsti/uUVZ5bHXvWgDU03EeVzbD33Rl7mTO/+S2t
ucZZJGNWzDDLaxu4l1ZABPsglHeArbT8KewD8wi2qFdgXHiRCtirn8TKsk8v9uo6
IGQRY3Lk/g2YFyGwZQLBPBU3cOibs5RRVWgLtCqoF7J3QzZT33X9/9QtD/piQMl4
EGO7Xf9B0pyPIpokQmLV7keE3dBHuA==
=LTG+
-----END PGP SIGNATURE-----

--fSX2++y3p9WVUB3a--

