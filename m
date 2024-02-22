Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301E2C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd64q-00007M-2F; Thu, 22 Feb 2024 05:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd64k-00006U-7M; Thu, 22 Feb 2024 05:13:10 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd64h-0001Yk-Va; Thu, 22 Feb 2024 05:13:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 27F365C00C9;
 Thu, 22 Feb 2024 05:13:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 22 Feb 2024 05:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708596786; x=
 1708683186; bh=7/6hbQYSLlrGJ5jAW+4VhpXCqUEZi6bfd+Kl1LOMg2k=; b=f
 XeFWvtyI4DFhKboxDNgrY98ovQmFNMAmnfXcccoZFgv+1JbG1jOIrIsf5FHqAvu9
 TssPVuLBlwlZuv9g2GE9wtrVn5J90YIvXZDPLoq/btdSymZ3ivh5saXnDnMFe7T2
 7ldVIIPJZmpU07Uxb/wnzFqwKWWvmR4qksX1r5EnH4QIXfWcnfDKSXisbg4KSCZs
 597v37bPM7Hxk4K+lTyCp6hUE3UUErPxK6y3B2Wp8dfqpLwpLz8wSbLl0H9XLkX9
 y30olm8qakDpMstwNT2mpZw4z2lOlXMsFAChrtP0MQ/V/58fvKj593Y3Ut7jzr/m
 FaqrgAcMi9iFGvmebqrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708596786; x=1708683186; bh=7/6hbQYSLlrGJ5jAW+4VhpXCqUEZ
 i6bfd+Kl1LOMg2k=; b=TIUIBrMCS2twHDe/tLxtuy6QooC6scd1FoSLlv9cdCZX
 b4JO3i2oQqrMvJje3g9Yv4iAj/bJwKH5jI2TT7meW9MlPNKNOK5eau04a+zUgWrD
 v+oJENCXsjO38FQzILHiBB2DQM1/Nk5PDh0UOUYO1RcRRceW0g46g2+7GZbhYBPD
 hlL8VvSEt1MdtT9Sy3KW5CX6Z+S02HaWIUAzftTjISkiCWOX0ILrFGc/zOE5HJKv
 3C2jSWJoaOcM/yU6lIawQPH0eDrgp7kDbH7xsX3xVathkeAw8uGA7Qxi/OmOFhkV
 eFklr8kTlTUZDFdyDdK1OwTx17XomlT55NCKy7WnDQ==
X-ME-Sender: <xms:MR7XZU5n1HOOXDUxNieYOqRSVvyLNAPXXzPCU--8x4AGLpbKjb0BEw>
 <xme:MR7XZV4sHk5utuC-rIxcHIIAxFJPsidjp_TNcLaA37RFhNjcCz4FTvJoX6J49ibfU
 P4e_NNYwEJ_JEJj0MU>
X-ME-Received: <xmr:MR7XZTewvcD4ZwP1ro26v4D_PDmQqrouulFxXRUixUORP5jVOi4eqmTk-jUd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeivefffffhledukeehhfetueelkeffudeuieektdegtefhgeefleeiudelveel
 keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:MR7XZZLdrOa3oopAqRoLaoharDYXzTmK_qFXOz6V3Z04vHX1kPzcng>
 <xmx:MR7XZYJHh6G1MYrn6I2rYxbaWgLrVkktQJ5cO4ess4A5GnYeQ5Ne8w>
 <xmx:MR7XZazalnlljsXPcDOgp20b57RKObhM9BLeaQkDnv6-HA5-k-CYxw>
 <xmx:Mh7XZQ88gsw19aP0IOeOlJZcw3Sy6SuYmrwkyxdPTZcDemO02eounQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 05:13:05 -0500 (EST)
Date: Thu, 22 Feb 2024 11:13:00 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix invalid endian conversion
Message-ID: <ZdceLDayLzLsGWJq@cormorant.local>
References: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
 <42681015-53e0-40df-8de3-3f93e83ba002@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XIwDPZuthy6JqNu0"
Content-Disposition: inline
In-Reply-To: <42681015-53e0-40df-8de3-3f93e83ba002@linaro.org>
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--XIwDPZuthy6JqNu0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 22 11:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20
> On 22/2/24 10:29, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
> > hosts results in numcntl being set to 0.
> >=20
> > Fix by dropping the endian conversion.
> >=20
> > Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for pri=
mary/secondary controllers")
>=20
> Isn't it commit 99f48ae7ae ("Add support for Secondary Controller
> List") instead?
>=20

Thanks Philippe,

Yes, that is the commit that had the bug originally. I'll fix it up.

--XIwDPZuthy6JqNu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXXHisACgkQTeGvMW1P
DelCAQf/bSgoW+cNxrqA2HqbiVotijwoIFolT3wXrAuh0U4oO+0N5+FiYSNzqMJl
Lo4IOG018WjsUN+8ZldrwTJMloft8NgFnXWebPr3lEqS/8pMnRMcy/muWFsKPm7m
lo7xyOh4tZN3xKUc9lnhcQGEJ+VGK0gNC7dDKbFd5DjTrb/U4ESCTigVZduRyzlh
VY4Yp5344gKPaP2toXcW3PAEpTYSk3WZGqiMrbiHyfwdfd5LwO3Uj5/3BWTPNa94
85EyDT9YRTMv2+NIHTB/qq0X36HnQAt4b2KHj804Rifwwg2fWJNy5A+op9PhFbbl
trg1GaW8YDPMKqjM6wJwcbNM74e0nQ==
=G089
-----END PGP SIGNATURE-----

--XIwDPZuthy6JqNu0--

