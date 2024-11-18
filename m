Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F8D49211
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD02I-0001Qc-53; Mon, 18 Nov 2024 06:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1tD02G-0001Q7-OK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:35:16 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1tD02E-0001Bl-SR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:35:16 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1tD029-0001u8-4e; Mon, 18 Nov 2024 12:35:09 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1tD025-001O2W-30;
 Mon, 18 Nov 2024 12:35:05 +0100
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1tD025-006914-2b;
 Mon, 18 Nov 2024 12:35:05 +0100
Message-ID: <3bb20561d50f28cb34ec51d64981b9aaf7f95ccd.camel@pengutronix.de>
Subject: Re: [PATCH] docs: aspeed: Reorganize the "Boot options" section
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Nov 2024 12:35:05 +0100
In-Reply-To: <20241118090648.187720-1-clg@redhat.com>
References: <20241118090648.187720-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=jlu@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2024-11-18 at 10:06 +0100, C=C3=A9dric Le Goater wrote:
> Add subsubsections for possible boot methods and introduce a new
> section on eMMC boot support for the ast2600-evb and rainier-emmc
> machines, boot partitions assumptions and limitations.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
> =C2=A0docs/system/arm/aspeed.rst | 99 +++++++++++++++++++++++++++++++++--=
---
> =C2=A01 file changed, 86 insertions(+), 13 deletions(-)

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>


