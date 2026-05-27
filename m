Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718ACD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSJBC-0001J9-Cl; Wed, 27 May 2026 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkl@pengutronix.de>)
 id 1wSJB9-0001Ie-CO
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:40:31 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkl@pengutronix.de>)
 id 1wSJB7-0004YK-Cy
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:40:30 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <mkl@pengutronix.de>)
 id 1wSJB3-0004CE-Rw; Wed, 27 May 2026 20:40:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b]
 helo=bjornoya.blackshift.org)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mkl@pengutronix.de>) id 1wSJB3-0029Q0-0Y;
 Wed, 27 May 2026 20:40:25 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: mkl-all@blackshift.org)
 by smtp.blackshift.org (Postfix) with ESMTPSA id 600B5543420;
 Wed, 27 May 2026 18:40:25 +0000 (UTC)
Date: Wed, 27 May 2026 20:40:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei VOLKOV <andrey.volkov@munic.io>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>, 
 =?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>,
 Matyas Bobek <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, linux-can@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260527-hysterical-cuddly-oriole-dba44f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
 <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
 <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
 <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wlqdkxxfjfyqloqg"
Content-Disposition: inline
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=mkl@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--wlqdkxxfjfyqloqg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
MIME-Version: 1.0

On 27.05.2026 20:38:10, Marc Kleine-Budde wrote:
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

Typo: Sascha

Sorry,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wlqdkxxfjfyqloqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCahc6lgAKCRDMOmT6rpmt
0sdmAP4zeDvmu2UenbT9Dny01/A0N58VZcNL+bd5pitKo7jGkwD+OZM2kBFufsth
KvYJxwZ5ofRp1602HuM6kPllw6U4HgY=
=OMs/
-----END PGP SIGNATURE-----

--wlqdkxxfjfyqloqg--

