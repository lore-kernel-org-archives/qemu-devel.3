Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74A9C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqpi-0005NP-Kd; Thu, 10 Jul 2025 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkl@pengutronix.de>)
 id 1uZqjp-0002KV-9W
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:50:57 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkl@pengutronix.de>)
 id 1uZqjm-0006Gk-UK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:50:57 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mkl@pengutronix.de>)
 id 1uZqjb-0003Cf-2a; Thu, 10 Jul 2025 14:50:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b]
 helo=bjornoya.blackshift.org)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mkl@pengutronix.de>) id 1uZqja-007kop-1A;
 Thu, 10 Jul 2025 14:50:42 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: mkl-all@blackshift.org)
 by smtp.blackshift.org (Postfix) with ESMTPSA id 0D04E43BD28;
 Thu, 10 Jul 2025 12:50:42 +0000 (UTC)
Date: Thu, 10 Jul 2025 14:50:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Matyas Bobek <bobekmat@fel.cvut.cz>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, qemu-devel@nongnu.org,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: i.MX6 SabreLite FlexCAN emulation for QEMU progress/working
Message-ID: <20250710-carrot-pillbug-of-election-eca4ab-mkl@pengutronix.de>
References: <202507101258.05760.pisa@fel.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v3mfxbb2tizlbdgt"
Content-Disposition: inline
In-Reply-To: <202507101258.05760.pisa@fel.cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=mkl@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Jul 2025 08:56:50 -0400
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


--v3mfxbb2tizlbdgt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: i.MX6 SabreLite FlexCAN emulation for QEMU progress/working
MIME-Version: 1.0

On 10.07.2025 12:58:05, Pavel Pisa wrote:
> Hello Marc and others,
>=20
> Matyas Bobek has implemented FlexCAN emulation for i.MX6
> targets in the frame of his bachelor thesis
>=20
>   https://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-M=
atyas-BP_Bobek_FlexCAN_final_4.pdf
>=20
> with reviews there
>=20
>   https://dspace.cvut.cz/handle/10467/122779
>=20
> Please, if you have problems to access documents, try that later,
> our large archive with theses and publications is under
> "AI" scrape-bots attacks almost permanently... or send me note
> and I send the document directly.
>=20
> The project continues and on base of Marc Kleine-Budde
> review, Matyas Bobek has implemented timestamping
> which should ensure correct messages ordering
> even if FIFO mode is not used in the drivers,
> Linux driver default case. There is even workaround
> to advance timestamp if the the QEMU virtual time
> is too coarse to provide unique values for for
> too fast delivered messages through virtual bus
> without real bits serialization.

Nice! Good work!

> The actual code is available on the "flexcan"
> branch of the repository
>=20
>   https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan
>=20
> The clean, minimal patches sequence will be prepared
> for review for the proposal for inclusion into QEMU
> mainline, hopefully soon.
>=20
> In longer term perspective, I have interrest in i.MX8
> and other FlexCAN variants with FD support, etc.
> I do not know if Mr. Bobek will have time and interest
> to continue in this direction. I can offer that as the
> another thesis or can offer that as summer job
> etc. But latter would need some funding for students
> motivation and their time compensation and I have had
> never and do not have any QEMU related project for such
> funding now and even minimal chance is even in future
> for other than CTU CAN FD IP core where we support
> silicon and FPGA products. So no timing, chances,
> estimates for something beyond i.MX6 FlexCAN.=20

ACK, I think getting things mainline is more important than CAN-FD
support.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--v3mfxbb2tizlbdgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhvtx4ACgkQDHRl3/mQ
kZy86ggAnbhPkkJr7adi7FBzYYsfah37OiI59qxCjNeWS1JduCA23CPGH9+Bp89H
rYZFNzSSSxI96hlLi+O76vMQ2ETFceyN0PQKQg5pHgS29J6P4xsRQ3xPXzu1jSwq
Zk1G4H7TlFKUIqG4UzLxBbb02BhP5+ZCjPLhkIW0Ztj+ogJ9muME/9248dxi9BQ7
rANwe+UUP/yEF3DpT+2SCGX2+VcXTkU7wMILpdMpKS+Piw1/4An6esb5MqJFX1Gs
CHCtaQ1VAA3SHbISEvIC2w2HOQfIJM2sI3G2tZZGydvORMLx344h9BZSXIHVounw
Acg68NImqsZNKz+Au29iro/ig7Efaw==
=53vH
-----END PGP SIGNATURE-----

--v3mfxbb2tizlbdgt--

