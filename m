Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D178ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWV1-0008PT-CE; Thu, 28 May 2026 04:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sha@pengutronix.de>)
 id 1wSWUz-0008OZ-4Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:53:53 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sha@pengutronix.de>)
 id 1wSWUx-00075q-4l
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:53:52 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1wSWUp-0003kh-Hb; Thu, 28 May 2026 10:53:43 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <sha@pengutronix.de>) id 1wSWUo-002FGE-0Z;
 Thu, 28 May 2026 10:53:42 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <sha@pengutronix.de>) id 1wSWUo-00000003ZfC-2dBa;
 Thu, 28 May 2026 10:53:42 +0200
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Andrei VOLKOV" <andrey.volkov@munic.io>, "Pavel Pisa" <pisa@fel.cvut.cz>,
 "Bernhard Beschow" <shentey@gmail.com>,
 =?utf-8?b?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>, "Matyas
 Bobek" <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Nikita Ostrenkov" <n.ostrenkov@gmail.com>,
 "Daniel
 P. Berrange" <berrange@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>,
 linux-can@vger.kernel.org, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "David Jander" <david@protonic.nl>
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:53:42 +0000
Message-Id: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=sha@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-05-27 20:38, Marc Kleine-Budde wrote:
> On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > As the original author, I have no objection to reusing (my part of) the
> > header under GPL-2.0-or-later. The reason it was not done that way in
> > 2005/2006 is simple: only GPLv2 existed at the time.
> >
> > All the more so since, as already noted, the code in question is essent=
ially
> > a direct transcription of offsets and bit-fields from the Freescale/NXP
> > datasheets, which leaves very little room for a meaningful copyright cl=
aim
> > in the first place.
> >
> > Personally, I would prefer that this code not be rewritten and be kept =
as
> > is, to avoid introducing subtle bugs in QEMU later on.
> > That said, @Sascha and @David may have a different opinion.
> >
> > PS: andrey.volkov@munic.io is my correct current work address, but I wo=
uld
> > prefer to use my personal one for this discussion.
>=20
> I've added David on Cc and given them a short overview of this
> discussion and linked this thread.
>=20
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

No objections from me as well.

Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

