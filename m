Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB7BD10399
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MC8-0005Az-Jh; Fri, 25 Oct 2024 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t4MC5-00059s-NG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:25:41 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t4MC4-000087-32
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:25:41 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t4MBp-0004XG-Uv; Fri, 25 Oct 2024 17:25:25 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t4MBo-000OFW-2e;
 Fri, 25 Oct 2024 17:25:24 +0200
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t4MBo-006ahU-05;
 Fri, 25 Oct 2024 17:25:24 +0200
Message-ID: <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>, =?ISO-8859-1?Q?C=E9dric?= Le Goater	
 <clg@kaod.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>
Date: Fri, 25 Oct 2024 17:25:24 +0200
In-Reply-To: <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 2024-10-25 at 06:59 -0700, Guenter Roeck wrote:
> On 10/25/24 02:57, Jan L=C3=BCbbe wrote:
> > On Fri, 2024-10-25 at 08:55 +0200, C=C3=A9dric Le Goater wrote:
> > > On 10/24/24 19:59, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > Cc'ing Jan.
> > > >=20
> > > > On 22/10/24 12:04, Guenter Roeck wrote:
> > > >=20
> > > > > I have no idea how this is supposed to work, and I don't think it=
 works
> > > > > as implemented. I'll revert commit e32ac563b83 in my local copy o=
f qemu.
> > > > > Jan, can you have a look at this bug report please? Otherwise I'l=
l
> > > > > have a look during soft freeze.
> >=20
> > Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
> > aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the
>=20
> I tried both enabled and disabled.
>=20
> > boot partition size would be 0, meaning that the eMMC has no boot
> > partitions.
>=20
> That is what I would have expected, but it does not reflect reality.
>=20
> > In that configuration, your backing file needs to have space for the
> > boot partitions at the start (2*1MiB) and the rootfs starts at the 2
> > MiB offset.
> >=20
>=20
> boot-emmc doesn't make a difference, because
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (emmc) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qdev_prop_set_uint8(card, "boot-config",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot_emmc ? 0x1 << 3 : 0x0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> in hw/arm/aspeed.c sets the boot partition size independently of the
> boot-emmc flag.=C2=A0

Ah, yes. :/

So you can have SD, eMMC with boot from boot partition *disabled* or
eMMC with boot from boot partition *enabled*.

> I suspect that the expectation is that I always provide
> an emmc image with a 2 MB gap at the beginning, but in my opinion that is
> really hyper-clumsy, and I simply won't do it, sorry.

I was surprised that the boot partitions' contents are stored in the
same backing file as the main area (instead of being separate files).
But I've not researched why it was designed this way.

> I can work around
> the problem by changing the above code to only set boot-partition-size if
> boot_emmc is set, or I can revert commit e32ac563b83. For now I chose the
> latter.

With e32ac563b83 reverted, your backing file layout will change *at
runtime* depending on whether booting from the boot partition is
enabled via EXT CSD registers. You should be able to try that using
'mmc bootpart enable <boot_part> 0 /dev/mmcblk0' (with boot_part=3D0 for
disabled and boot_part=3D1/2 for enabled).


I'm not sure what the best way forward is... perhaps make the boot-
partition-size zero if boot_emmc is false? e.g.

@@ -339,7 +339,12 @@ static void sdhci_attach_drive(SDHCIState *sdhci, Driv=
eInfo *dinfo, bool emmc,
         }
         card =3D qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
         if (emmc) {
-            qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
+            /*
+             * Avoid the requirement for a padded disk image if booting fr=
om
+             * eMMC boot partitions is not needed.
+             */
+            qdev_prop_set_uint64(card, "boot-partition-size",
+                                boot_emmc ? 1 * MiB : 0);
             qdev_prop_set_uint8(card, "boot-config",
                                 boot_emmc ? 0x1 << 3 : 0x0);
         }


Then you'd have the choice between:
- an eMMC, but without boot partitions (and simple backing=C2=A0file=C2=A0l=
ayout)
- an eMMC with boot partitions and need a backing file with=C2=A0
  the=C2=A0boot partitions at the beginning

That might be the lesser evil. :)

Jan

--=20
Pengutronix e.K.                        |                             |
Steuerwalder Str. 21                    | https://www.pengutronix.de/ |
31137 Hildesheim, Germany               | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686        | Fax:   +49-5121-206917-5555 |



