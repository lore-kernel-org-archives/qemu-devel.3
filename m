Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B948D132A2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7t5T-00054R-Qn; Mon, 04 Nov 2024 04:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t7t5S-000546-1A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:09:26 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t7t5Q-0002hp-4c
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:09:25 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t7t5M-0006t9-1Q; Mon, 04 Nov 2024 10:09:20 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t7t5L-001x1m-27;
 Mon, 04 Nov 2024 10:09:19 +0100
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t7t5K-00Cohd-2y;
 Mon, 04 Nov 2024 10:09:19 +0100
Message-ID: <80d49b179da1b9162141e8594be297d54be1a638.camel@pengutronix.de>
Subject: Re: [PATCH v2] aspeed: Don't set always boot properties of the emmc
 device
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Steven Lee	
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin	
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Guenter Roeck	 <linux@roeck-us.net>
Date: Mon, 04 Nov 2024 10:09:19 +0100
In-Reply-To: <20241103210829.2307729-1-clg@redhat.com>
References: <20241103210829.2307729-1-clg@redhat.com>
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

On Sun, 2024-11-03 at 22:08 +0100, C=C3=A9dric Le Goater wrote:
> Commit e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping") added support to boot from an eMMC device by setting
> the boot properties of the eMMC device. This change made the
> assumption that the device always has boot areas.
>=20
> However, if the machine boots from the flash device (or -kernel) and
> uses an eMMC device without boot areas, support would be broken. This
> impacts the ast2600-evb machine which can choose to boot from flash or
> eMMC using the "boot-emmc" machine option.
>=20
> To provide some flexibility for Aspeed machine users to use different
> flavors of eMMC devices (with or without boot areas), do not set the
> eMMC device boot properties when the machine is not configured to boot
> from eMMC. However, this approach makes another assumption about eMMC
> devices, namely that eMMC devices from which the machine does not boot
> do not have boot areas.
>=20
> A preferable alternative would be to add support for user creatable
> eMMC devices and define the device boot properties on the QEMU command
> line :
>=20
> =C2=A0 -blockdev node-name=3Demmc0,driver=3Dfile,filename=3Dmmc-ast2600-e=
vb.raw \
> =C2=A0 -device emmc,bus=3Dsdhci-bus.2,drive=3Demmc0,boot-partition-size=
=3D1048576,boot-config=3D8
>=20
> This is a global change requiring more thinking. Nevertheless, in the
> case of the ast2600-evb machine booting from an eMMC device and when
> default devices are created, the proposed change still makes sense
> since the device is required to have boot areas.
>=20
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Fixes: e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping")
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> ---
>=20
> =C2=A0Changes in v2:
>=20
> =C2=A0- Simplified "boot-config setting
>=20
> =C2=A0hw/arm/aspeed.c | 16 +++++++++++++---
> =C2=A01 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index e447923536b4..6ca145362cbd 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -338,10 +338,20 @@ static void sdhci_attach_drive(SDHCIState *sdhci, D=
riveInfo *dinfo, bool emmc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card =3D qdev_new(emmc ?=
 TYPE_EMMC : TYPE_SD_CARD);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (emmc) {
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Force the boot proper=
ties of the eMMC device only when the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * machine is strapped t=
o boot from eMMC. Without these
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * settings, the machine=
 would not boot.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This also allows the =
machine to use an eMMC device without
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * boot areas when booti=
ng from the flash device (or -kernel)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ideally, the device a=
nd its properties should be defined on
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the command line.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (emmc && boot_emmc) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_=
prop_set_uint8(card, "boot-config",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot_emmc ? 0x1 << 3 : 0x0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_=
prop_set_uint8(card, "boot-config", 0x1 << 3);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive_err(=
card, "drive", blk_by_legacy_dinfo(dinfo),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_fatal);

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>

Thanks,
Jan

