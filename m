Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA9FC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgIMh-00053h-Kb; Sun, 05 Jul 2026 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wgIMf-00053H-Ef; Sun, 05 Jul 2026 04:38:13 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wgIMb-0004Ka-R9; Sun, 05 Jul 2026 04:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783240677; bh=sRWiZQefGv8WeptAlHH3G8SJBlcfpjAileWd9a1oEfE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OvL57mF2rxqb6MiXblUGiMOrj8FBM5fkOsxt5Lo8CRNTY7FZ7TwB3dTf1uvQ68Zgj
 W96WqY7qbklVZXC0oiluGGv0fIAhhpp5blhEcmIYWVN0DyA8lExQtzgif/jMAOxvu/
 /lkz88U+xqM9EIfRjrHyCec/CJhitGRXrJTrK4jU=
Received: from [192.168.1.10] ([118.116.35.199])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 97729437; Sun, 05 Jul 2026 16:37:55 +0800
X-QQ-mid: xmsmtpt1783240675tf068a468
Message-ID: <tencent_A1FCB4C882DC8F1F98A462D6F490DCE75309@qq.com>
X-QQ-XMAILINFO: MTHjzKFGhY7IJLgJhXfExtWpIlF6PQOvZ/A4sVOpfnljFlxRAK+12cJxyzGp+p
 BWqByUHdGswnH6LrBO3jcocLS8iGFx6OJsxP7vXl6JaXGJ1VkaV/sAFJNfPyZ481I8lTT19rgM2D
 Ha2tHu55h/wsR+B6W0bT5h0dYFt2P0NEE5M78sx9nC564xvalGsktU3mK+asNKiwYaiC0fMHfR9O
 RAF69UKugFOMmCWf4UnDzD66B+R0u9mH2DjYXzv7lEdvqKGhPmIlAw0loTpg7R8yTGWckUfhF1aL
 OFQ5pCTZq1Cle/2Rg7oKklB1liQgGlPNM4aJq6r/7zq6algdVxCPy1ouy9iTBQ4MnXfIrxsJGmXM
 MBLNv3gaZvpJjoJk+4x07gkGscJgdQyxHREUBQV40j0hX67QPDGuKWI5I+FVhR3nQ9MBkP0dKu6a
 lR81cLUXc/JtDdAl47tiKuFKkddTrDAdpYzoV5QXxlq1rtNfsP73+zTneEq8W3xnQStUZTf1zDvk
 iEnMpCJgC4HZcioU+vOOYcMnWoOWueERtM+ZGlPu/4uYpFIXhf5YqMNGRZa+Aq7uPOxIz2qhYAaF
 TnIxWL1197gaxUe3vtPHAOJ4QO6zBylT5Y5H7w+wg2sF7zfNxBeLMaeo7B6TFmSkdsqkokTccmVq
 t8hMvIPSFWsIVse/ygsYRU0+sWJiAIRXj+x1cuuemxaeu9SeWyvavNkwycYji2KG8h/v1puddF7I
 yyDc3bVVhqEtyfqVXIDRIMXCi75h+Zr9x3Z7/omfDq6sC22dncVbYMIBj/pOjhqgV9zPd7hlzvnm
 Y41MxlfZrDUgL38eRdQ8N9KHmz/3Ksu22C8YRv2Oq/mPGkE1yAG14VnPDbpvg+5JXSsje28nyYWj
 xqyYs1VeTDdv/JVetQK1k9Xw3SRc/CSXQ9yFZWhCFpjdeCXB3IyzRLVVu5Y3rZGeCNwpeAISTwhK
 JHlsrvnjI7jBRqLHczyZKT44NhPVxQ96TtfCkb0MOSpa/SxGPUq/4Q0fwE9S6fqlCIwDKaL4bCdA
 p6u/p9IA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <42ff47f5510e4e5fc1f47c5062887af34f045372.camel@qq.com>
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
From: Yanfeng Liu <yfliu2008@qq.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Date: Sun, 05 Jul 2026 16:37:54 +0800
In-Reply-To: <tencent_C1EF85ECC23DFCE1482A6EAD0489775ED405@qq.com>
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
 <tencent_C1EF85ECC23DFCE1482A6EAD0489775ED405@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=162.62.57.210; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Resending below as I haven't seen this in mail list.

On Sat, 2026-07-04 at 09:51 +0800, Yanfeng Liu wrote:
>=20
> Philippe,
>=20
> Thank you!
>=20
> Actually v1 creates UART1 carelessly, then Peter suggested following
> 5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce breakage of
> existing guests.
>=20
> I looked around and noticed the `if (serial_hd())` pattern is still
> used in arm/virt, arm/msf2-soc, arm/kzm, xrtensa/sim, and ppc/e500
> etc.
>=20
> Guess I need consensus before moving ahead.
>=20
> Regards,
> Yanfeng
>=20
>=20
> On Fri, 2026-07-03 at 11:31 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >=20
> > On 3/7/26 06:24, Yanfeng Liu wrote:
> > > This adds optional UART1 to RiscV virt board if required at
> > > runtime to simplify multicore development.
> > >=20
> > > Note that UART0 remains default serial_hd(0) and it is:
> > >=20
> > > - the lowest address UART
> > > - first serial in DTB
> > > - behind /aliases/serial0 in DTB
> > > - the /chosen/stdout-path in DTB
> > >=20
> > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > ---
> > > =C2=A0 docs/system/riscv/virt.rst |=C2=A0 5 ++++-
> > > =C2=A0 hw/riscv/virt-acpi-build.c | 12 ++++++++----
> > > =C2=A0 hw/riscv/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 39 ++++++++++++++++++++++++++++---
> > > --
> > > -----
> > > =C2=A0 include/hw/riscv/virt.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > > =C2=A0 4 files changed, 44 insertions(+), 15 deletions(-)
> >=20
> >=20
> > > @@ -1567,6 +1579,13 @@ static void virt_machine_init(MachineState
> > > *machine)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, qdev_get_gp=
io_in(mmio_irqchip, UART0_IRQ), 399193,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hd(0), =
DEVICE_LITTLE_ENDIAN);
> > > =C2=A0=20
> > > +=C2=A0=C2=A0=C2=A0 if (serial_hd(1)) {
> >=20
> > Checking for chardev backend connected to map a peripheral block
> > is an anti-pattern; the block exists on HW regardless.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_mm_init(system_mem=
ory, s-
> > > >memmap[VIRT_UART1].base,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ),
> > > 399193,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
erial_hd(1), DEVICE_LITTLE_ENDIAN);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->uart1_present =3D true=
;
> >=20
> > Thus we want to always instantiate all UART peripherals.
> >=20
> > If you drop the uart1_present field then the patch LGTM.
> >=20
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_create_simple("goldfish_rtc", s=
-
> > > > memmap[VIRT_RTC].base,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_get_gpio_=
in(mmio_irqchip, RTC_IRQ));
> > > =C2=A0=20
> > > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > > index 18a2a323a3..7d57c8292e 100644
> > > --- a/include/hw/riscv/virt.h
> > > +++ b/include/hw/riscv/virt.h
> > > @@ -59,6 +59,7 @@ struct RISCVVirtState {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int aia_guests;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *oem_id;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *oem_table_id;
> > > +=C2=A0=C2=A0=C2=A0 bool uart1_present;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OnOffAuto acpi;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const MemMapEntry *memmap;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct GPEXHost *gpex_host;


