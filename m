Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3E5C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 01:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfpXj-00083B-TI; Fri, 03 Jul 2026 21:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wfpXi-00082p-4g; Fri, 03 Jul 2026 21:51:42 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wfpXe-0004ew-Kz; Fri, 03 Jul 2026 21:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783129884; bh=GIHkPAOxHMj8iB01CA8an103xT7On/NtJDLK2vjbVQw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=UM/E432yn/TG5ejcdb4wxlqs5p59L0LWQloWrg5QoCpJgR+oSbujgqHYDSrl9O1Ba
 UuOoSTrsvpUIl1qmS8mtNSAwKqLJEA682RzvAe2C+EyDnHROVln14ePHyx5kQH5unC
 JWSwCAIqUPa+pAUIXSs4Ugz7JXunI/8ezJCXiiXI=
Received: from [192.168.1.10] ([118.116.35.199])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id CD60480A; Sat, 04 Jul 2026 09:51:22 +0800
X-QQ-mid: xmsmtpt1783129882txar8jxck
Message-ID: <tencent_C1EF85ECC23DFCE1482A6EAD0489775ED405@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgGJpEAz2RUHJc1Qm/RRVoeCwSdSAwqU5lk8K1I9ttUA/axA71On
 E43sb03AY/oQiCbnueML+GFfxIbumVMOJnsWPDRwrPIJM3ooQhymp/mKkY0sZ15hHSJNlNDhDZlB
 FSjEcKk4Req6EDO+6CDpOEzlgjTAp3OIBQg078f1f8rXx6DXPL2+8z3TxWoBNd+/ZDLObkImDFre
 T1PBHVJ3cAgmxgBofZ1v5Cm9qciKES3CyQyj6EVR0lZ20bFAHSCzkZwqqLqY6o2K2lFj0O2UgiZZ
 bqBr+n71sr0vRmnwCFiRbwfJdF6rqGi/cC+AZxnXp4URd1Mig2OHqVIuaBVNENV/DDxT3Kn+T8Lh
 JIrSZTeKQZZ7aTNSzNlvRNu0P0OvYt41kBiHp6Mr8AJ/EZK7i6+B/ft8WnRlcp5/UiC9PeH/ZZYP
 L5AvpQUW5/pWchjizviDJ6QiykZQRXfEgVobjQfJZoEa6GksxG/wPT2p8LSv+dmVnH6g23ulO+O3
 3t9zEvsVEj9lDuLPf9+SVNtDJizAvUnvi5d9NkTITPDQXnaqCTXe9BcyVyhSNGW5BPrnUfqdZRMK
 THIBscnfH7uqWjhfVG7pBO7nzulW7Vn6eG8wCTaRs2BLI7S6zCTcra8SAh/ERCcduVJFOO8QrkFJ
 mmEq6TIqV1Di6D5PEFF8tSZ3IZa14aXIT/3Np01w/5Yr6l8Gog53yuVYuuBqZQ0t9yDA1xExnc+H
 dchwom5yjRdTLYHnJkcArH4mcVvj/TwlNURiUyEym4hB8je9Mz3isnA2YhAK5r7SdOpHbGGZqZp6
 mJu/HLPjinCDe0CAiVSQUnGp0viWFKwQF5T/EwAQYWcY77SSGkg24uKOh3uam9VLRbxqIJDPLyH0
 4kWUfU3HGhIEVHGZ5R4GGNCtmO3a6p9Sc5kuop1XSGWl/ilcwGRXso2hX2CaxZxkzcH/pA/pCp3V
 DRSGKBuEVHOFJMBjV3ENW4+gSwnbecsVakoV7TWWK3GyHvDcGfQN8YoJpmmDhEkk7gNWcfwVCkSj
 jBpMNZDcrCVy/fs/NIToXU6xDHIi8nllimET2QoLdOz75TPnsXHLWoGw9cWodkQ7p5OMjK6Aw/0J
 vqGBre
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <9026bc1ffe535da4755f3f0bdf820819ecd6b924.camel@qq.com>
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
From: Yanfeng Liu <yfliu2008@qq.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Date: Sat, 04 Jul 2026 09:51:22 +0800
In-Reply-To: <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=162.62.57.87; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Philippe,

Thank you!

Actually v1 creates UART1 carelessly, then Peter suggested following
5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce breakage of
existing guests.

I looked around and noticed the `if (serial_hd())` pattern is still
used in arm/virt, arm/msf2-soc, arm/kzm, xrtensa/sim, and ppc/e500 etc.

Guess I need consensus before moving ahead.

Regards,
Yanfeng


On Fri, 2026-07-03 at 11:31 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> On 3/7/26 06:24, Yanfeng Liu wrote:
> > This adds optional UART1 to RiscV virt board if required at
> > runtime to simplify multicore development.
> >=20
> > Note that UART0 remains default serial_hd(0) and it is:
> >=20
> > - the lowest address UART
> > - first serial in DTB
> > - behind /aliases/serial0 in DTB
> > - the /chosen/stdout-path in DTB
> >=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
> > =C2=A0 docs/system/riscv/virt.rst |=C2=A0 5 ++++-
> > =C2=A0 hw/riscv/virt-acpi-build.c | 12 ++++++++----
> > =C2=A0 hw/riscv/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 39 ++++++++++++++++++++++++++++-----
> > -----
> > =C2=A0 include/hw/riscv/virt.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0 4 files changed, 44 insertions(+), 15 deletions(-)
>=20
>=20
> > @@ -1567,6 +1579,13 @@ static void virt_machine_init(MachineState
> > *machine)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, qdev_get_gpio=
_in(mmio_irqchip, UART0_IRQ), 399193,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hd(0), DE=
VICE_LITTLE_ENDIAN);
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0 if (serial_hd(1)) {
>=20
> Checking for chardev backend connected to map a peripheral block
> is an anti-pattern; the block exists on HW regardless.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_mm_init(system_memor=
y, s->memmap[VIRT_UART1].base,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, =
qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ser=
ial_hd(1), DEVICE_LITTLE_ENDIAN);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->uart1_present =3D true;
>=20
> Thus we want to always instantiate all UART peripherals.
>=20
> If you drop the uart1_present field then the patch LGTM.
>=20
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_create_simple("goldfish_rtc", s-
> > >memmap[VIRT_RTC].base,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_get_gpio_in=
(mmio_irqchip, RTC_IRQ));
> > =C2=A0=20
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 18a2a323a3..7d57c8292e 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -59,6 +59,7 @@ struct RISCVVirtState {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int aia_guests;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *oem_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *oem_table_id;
> > +=C2=A0=C2=A0=C2=A0 bool uart1_present;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OnOffAuto acpi;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const MemMapEntry *memmap;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct GPEXHost *gpex_host;


