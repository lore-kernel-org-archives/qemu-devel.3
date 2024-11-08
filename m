Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA4D5E149
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 09:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9LJU-00074C-56; Fri, 08 Nov 2024 04:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t9LJR-000742-Ui
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:29:53 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t9LJQ-0005To-0e
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:29:53 -0500
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t9LJI-0007B0-RX; Fri, 08 Nov 2024 10:29:44 +0100
Message-ID: <eaf053e4fa01827a188bfa5abe3af92e1f90fabd.camel@pengutronix.de>
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>
Date: Fri, 08 Nov 2024 10:29:43 +0100
In-Reply-To: <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
 <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
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
Reply-To: jlu@pengutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2024-10-29 at 15:06 +0000, Peter Maydell wrote:
> On Fri, 18 Oct 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> > On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
> > > For testing eMMC-specific functionality (such as handling boot
> > > partitions), it would be very useful to attach them to generic VMs su=
ch
> > > as x86_64 via the sdhci-pci device:
> > > =C2=A0...
> > > =C2=A0-drive if=3Dnone,id=3Demmc-drive,file=3Demmc.img,format=3Draw \
> > > =C2=A0-device sdhci-pci \
> > > =C2=A0-device emmc,id=3Demmc0,drive=3Demmc-drive,boot-partition-size=
=3D1048576 \
> > > =C2=A0...
> > >=20
> > > While most eMMCs are soldered to boards, they can also be connected t=
o
> > > SD controllers with just a passive adapter, such as:
> > > =C2=A0https://docs.radxa.com/en/accessories/emmc-to-usd
> > > =C2=A0https://github.com/voltlog/emmc-wfbga153-microsd
> > >=20
> > > The only change necessary to make the options above work is to avoid
> > > disabling user_creatable, so do that. The SDHCI-PCI driver in the Lin=
ux
> > > kernel already supports this just fine.
> > >=20
> > > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> >=20
> > Applied to target-arm.next, thanks (unless anybody would
> > prefer it to go via some other route).
>=20
> I'm dropping this from target-arm.next since it seems like
> we have a problem with the handling of boot partitions
> and how the user should provide an image for an emmc card
> that has boot partitions). Since that's an emmc specific
> thing, sorting that out with a minimum of breaking
> compatibility with previously working setups is going to
> be easier if we stay temporarily in the state of "emmc
> only happens for the specific board that creates them
> and the user can't arbitrarily create them on the
> command line".
>=20
> I expect this to just be a temporary delay while we sort
> out in the other thread how emmc boot partitions should work.

With C=C3=A9dric's e8f3acdbb8 ("aspeed: Don't set always boot properties of=
 the emmc
device") and my c078298301 ("hw/sd/sdcard: Fix calculation of size when usi=
ng
eMMC boot partitions") in master, compatibility for existing setups should =
be
taken care of.

As mentioned in C=C3=A9dric's patch, allowing user creatable eMMC devices i=
s still
desirable. With my patch, that would work for machines where the SD control=
ler
is user-created as well (e.g. x86_64 with sdhci-pci).

For machines where the SD controller and SD/eMMC are pre-created, additiona=
l
changes seem to be needed. Would you consider taking this patch to solve th=
e
simple case first?

Thanks,
Jan
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

