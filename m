Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E252AC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 01:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfpOV-0005RX-3k; Fri, 03 Jul 2026 21:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wfpOR-0005Qp-CX; Fri, 03 Jul 2026 21:42:07 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wfpOO-0003A6-0U; Fri, 03 Jul 2026 21:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783129309; bh=8UiYExRzb0ydHhMSG377dt1h0betdwJy9fRX1ofXiqY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=fmhzg3Vy3MzZJ8JH3bOIFPkDi6/9X7cWKH2g2lTFHOahHzc6WmKnSXzFfqFmvOy8T
 01jpRAhwaR1NIkbn1f/W9aQz9RdAe8vc2tSTiu0jKlKKWLWKPqWqOH7MlGpQpmICO8
 fRXa1ZH9ddhBsGWCyA0yC8JJm8523l6NSjzIyMu0=
Received: from [192.168.1.10] ([118.116.35.199])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id A6E95AAA; Sat, 04 Jul 2026 09:41:46 +0800
X-QQ-mid: xmsmtpt1783129306tnvg1eiq5
Message-ID: <tencent_3045B23CF7A9872F29FC351E24D8F9373F07@qq.com>
X-QQ-XMAILINFO: OfxHHOU34G6ptlvlEDmH4PRFaanFNPFCKlyotBuh7s4PVoyjue7A+Q36rWhHRB
 3ZamH7UgxDrYMwB19ZADRjw8UTWps8hVKQba2clRA1NsQ3dkxKX790W1sW4xPyeX18yhe8jzT3le
 rlsDZRj2nPM3vt9DE1GPpzCiFzjMJlTt0HUxpyqGkt9JgM0PJWC6Djw4ZWu9u3a/vZe3RhpEBEk+
 di5XKMFlnyeiMH/kIN73UsQQi3dTnSWNsCbIYD/HzPQiMzKbyDP6vo/Tz9IUxJf95tU16RjTcRbr
 Mmr+y/dWXCaxA0oeuSZEIJfZLk7cmh+ckwUBE4sQfkcEDicIsLSzwUzGsUW+vzcBHZZzJfv9mJ7A
 UnzlVzHElo//2awmuX/ecMu/7h3OhAHAH1p11muORXRC4bEKvlvsItI10NtpkF9+6h8knIeCtwQV
 Elb6HtbraiNgmpoQ0UZSc3971dlsbwh7u3S12mtqlGUQUWdbQABEkhT1yCmSBzBknrSSUMY5oRt3
 5XGV0HlBRv4sXYVxX8iiDDarGoX1tpVat3j82d0MU3taEKwPoiDxmpOKFwVhru15nZtMEgBgOTwl
 1Sy0kA45qJv9bKMzkB97YzsTo009InwZVH2M8nuyQ+Rvl8lGiehiY16vG0RYfDS9wZDndwi2Gkug
 E3Gso27ePPDus4EPkYY6fSHZo4lmhUBAy+bLqWr9PZydNKVcvMwHi36wxnNefeVjGC+AKlJymDfM
 TthXAP6kC328+dI0CzXx8/h4pgTs2YqV6XkzYGHfHgZYJUobZWAHfwEfc5aq4sIlmnSKzPs9Jczr
 HqJrAE2sJoELuG5tFMxzFDRywadIQwyHC17XB9u6l2iwd1RpKZ/cZBg/z/buHZuh0UcFk76PUbuQ
 XAvpcjbrKx5oDMH23NhQa7T4XqA0ytx2nlKz5yE/QlztN69YUcdDnc9pZ2WHBxTSLhSkF4iGxrWO
 F2NUekBldfZETTO2giouKVYqki3+dXg/AoIV+kg5TrGwY6FhWTsnQ4JuERoTYfH6N98etfj8SsHQ
 VloB10fw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <7a9ca5f6910c5150bc3d0a8f36eb9d166e1ad6b4.camel@qq.com>
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
From: Yanfeng Liu <yfliu2008@qq.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Date: Sat, 04 Jul 2026 09:41:46 +0800
In-Reply-To: <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=162.62.57.64; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The v1 always creates UART1 carelessly, then Peter suggested following
5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce guest breakage.

I looked around and noticed the pattern is used in arm/virt, arm/msf2-
soc, arm/kzm, xrtensa/sim, and ppc/e500 etc.

Please give me clear direction here.

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


