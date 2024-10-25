Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD7D0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4H5L-0008Ig-1o; Fri, 25 Oct 2024 05:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t4H5E-0008I9-GD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:58:17 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t4H5C-0006Bn-SS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:58:16 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t4H4x-0008CR-CF; Fri, 25 Oct 2024 11:57:59 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t4H4w-000LLu-0V;
 Fri, 25 Oct 2024 11:57:58 +0200
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t4H4v-006Mwp-1O;
 Fri, 25 Oct 2024 11:57:58 +0200
Message-ID: <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>
Date: Fri, 25 Oct 2024 11:57:57 +0200
In-Reply-To: <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
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

Hi,

On Fri, 2024-10-25 at 08:55 +0200, C=C3=A9dric Le Goater wrote:
> On 10/24/24 19:59, Philippe Mathieu-Daud=C3=A9 wrote:
> > Cc'ing Jan.
> >=20
> > On 22/10/24 12:04, Guenter Roeck wrote:
> > > On 10/21/24 21:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > Hi Guenter,
> > > >=20
> > > > On 21/10/24 11:02, Guenter Roeck wrote:
> > > >=20
> > > > > Unrelated to this, but I found that the sd emulation in 9.1 is al=
so broken
> > > > > for loongarch and sifive_u, and partially for ast2600-evb (it has=
 two
> > > > > controllers, with one of them no longer working). That is too muc=
h for me
> > > > > to track down quickly, so this is just a heads-up.
>=20
> It would greatly help if we could merge some of your testsuite under QEMU=
.
>=20
> > > > Please Cc me with reproducer or assign Gitlab issues to me,
> > > > I'll have a look.
> > > >=20
> > >=20
> > > If it wasn't funny, it would be sad.
> > >=20
> > > hw/sd/sd.c:sd_reset() calls sd_bootpart_offset() t determine the boot=
 partition
> > > offset. That function needs to have sd->ext_csd[EXT_CSD_PART_CONFIG] =
configured.
> > > However, the value is only set later in sd_reset() with the call to s=
c->set_csd().
> > > One of the parameters of that function is the previously calculated s=
ize.
> > >=20
> > > So in other words there is a circular dependency. The call to sd_boot=
part_offset()
> > > returns 0 because sd->ext_csd[EXT_CSD_PART_CONFIG] isn't set, then
> > > the call to sc->set_csd() sets it ... too late. Subsequent calls to
> > > sd_bootpart_offset() will then return the expected offset.

> oh. I didn't realize that :/ I guess we only tested our own scenario when
> we were working on the ast2600 bringup.

Ah, I missed that early call to sd_bootpart_offset() as well.

As this function calculates the *runtime* offset which changes as the
guest switches between accessing the main user data area and the boot
partitions by writing to the EXT_CSD_PART_CONFIG_ACC_MASK bits, it
shouldn't be involved in the calculations in sd_reset() at all.

> I think the change in the reset handler should be :
>=20
> -=C2=A0=C2=A0=C2=A0 size -=3D sd_bootpart_offset(sd);
> +=C2=A0=C2=A0=C2=A0 if (sd_is_emmc(sd)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size -=3D sd->boot_part_size =
* 2;
> +=C2=A0=C2=A0=C2=A0 }

Yes, that seems correct.

> > > I have no idea how this is supposed to work, and I don't think it wor=
ks
> > > as implemented. I'll revert commit e32ac563b83 in my local copy of qe=
mu.
> > > Jan, can you have a look at this bug report please? Otherwise I'll
> > > have a look during soft freeze.

Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the
boot partition size would be 0, meaning that the eMMC has no boot
partitions.

In that configuration, your backing file needs to have space for the
boot partitions at the start (2*1MiB) and the rootfs starts at the 2
MiB offset.

Jan

[1]https://lore.kernel.org/qemu-devel/8f3536a0-2685-4aa4-b26d-f460e738d387@=
roeck-us.net/#t
--=20
Pengutronix e.K.                        |                             |
Steuerwalder Str. 21                    | https://www.pengutronix.de/ |
31137 Hildesheim, Germany               | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686        | Fax:   +49-5121-206917-5555 |



