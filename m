Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A74C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1kD-0006Bf-Nb; Thu, 08 Feb 2024 05:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rY1kC-0006Az-0g; Thu, 08 Feb 2024 05:35:00 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rY1k9-0004Cw-E3; Thu, 08 Feb 2024 05:34:59 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id C94FBA06FC;
 Thu,  8 Feb 2024 11:34:54 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id AH66khSCDzEv; Thu,  8 Feb 2024 11:34:54 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 2C1F1A06EF;
 Thu,  8 Feb 2024 11:34:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 2C1F1A06EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1707388494;
 bh=VGDfsgpdvlXAJDDyzZSMSv3Gd8qzky2HHnBllKZxmLM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=wpjxOHfvjLeFF0FsICVRjwB4fhV3TUuspVi6R4RfJi8xG56/OYeH2wxJcdEJSalEq
 XyATvrQJRXFf4zFccKaL1X6/jr5Pb7Sy7pAgsBDVSaMroSrQsA76B63dUZlh08hODK
 G2yB6zy7vSDP8V6lwmL980Nhvkc3ij4swldOwfII=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id D6AQ2QA_r4kW; Thu,  8 Feb 2024 11:34:54 +0100 (CET)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy3.enst.fr (Postfix) with ESMTP id BF83DA06C0;
 Thu,  8 Feb 2024 11:34:53 +0100 (CET)
Date: Thu, 8 Feb 2024 11:34:53 +0100 (CET)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 qemu-arm@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, 
 Alistair Francis <alistair.francis@wdc.com>
Message-ID: <1921238046.591194.1707388492770.JavaMail.zimbra@enst.fr>
In-Reply-To: <5a7594d9-3fbd-4d90-a5f9-81b7b845fba7@linaro.org>
References: <20240109160658.311932-1-ines.varhol@telecom-paris.fr>
 <20240109160658.311932-3-ines.varhol@telecom-paris.fr>
 <5a7594d9-3fbd-4d90-a5f9-81b7b845fba7@linaro.org>
Subject: Re: [PATCH v8 2/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_0c589f4e-91b5-4b54-be9b-d5d761903ff9"
X-Originating-IP: [::ffff:80.125.0.74]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraModernWebClient - FF122
 (Linux)/9.0.0_GA_4583)
Thread-Topic: hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Thread-Index: IOgIHmd0TWUC9N/BQ6cWQF1+AdeUCA==
Received-SPF: pass client-ip=137.194.2.222; envelope-from=ivarhol-21@enst.fr;
 helo=zproxy3.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--=_0c589f4e-91b5-4b54-be9b-d5d761903ff9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


=20
=20
Hi,

=20
> De: Philippe <philmd@linaro.org>=20
> Envoy=C3=A9: mercredi 7 f=C3=A9vrier 2024 23:02 CET=20
>=C2=A0=20
> Hi In=C3=A8s,=20
>=C2=A0=20
> (this is now commit 52671f69f7).=20
>=C2=A0=20
> On 9/1/24 17:06, In=C3=A8s Varhol wrote:=20
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=20
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=20
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>=20
> > Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>=20
> > Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>=20
> > ---=20
> > hw/arm/Kconfig | 1 +=20
> > hw/arm/stm32l4x5_soc.c | 52 +++++++++++++++++++++++++++++++++-=20
> > include/hw/arm/stm32l4x5_soc.h | 3 ++=20
> > 3 files changed, 55 insertions(+), 1 deletion(-)=20
>=C2=A0=20
>=C2=A0=20
> > +#define NUM_EXTI_IRQ 40=20
> > +/* Match exti line connections with their CPU IRQ number */=20
> > +/* See Vector Table (Reference Manual p.396) */=20
> > +static const int exti_irq[NUM_EXTI_IRQ] =3D {=20
> > + 6, /* GPIO[0] */=20
> > + 7, /* GPIO[1] */=20
> > + 8, /* GPIO[2] */=20
> > + 9, /* GPIO[3] */=20
> > + 10, /* GPIO[4] */=20
> > + 23, 23, 23, 23, 23, /* GPIO[5..9] */=20
> > + 40, 40, 40, 40, 40, 40, /* GPIO[10..15] */=20
>=C2=A0=20
> I'm sorry because I missed that earlier, and I'm surprised=20
> you aren't chasing weird bugs. Due to how QEMU IRQs are=20
> implemented, we can not wire multiple input lines to the same=20
> output without using an intermediate "OR gate". We model it=20
> as TYPE_OR_IRQ. See the comment in "hw/qdev-core.h" added in=20
> commit cd07d7f9f5 ("qdev: Document GPIO related functions"):=20
=C2=A0=20
Better fixing it now than later :)
I must admit I didn't pay attention to the particularity of EXTI5 to 15.=20
Current exti tests don't even use these lines, a testcase will have=20
to be added. Otherwise we mostly ran executables using GPIOs as output,=20
so no weird bugs encountered.=20
=C2=A0=20
Thank you for noticing !=20
Ines=20
=C2=A0=20
>=C2=A0=20
> * It is not valid to try to connect one outbound GPIO to multiple=20
> * qemu_irqs at once, or to connect multiple outbound GPIOs to the=20
> * same qemu_irq. (Warning: there is no assertion or other guard to=20
> * catch this error: the model will just not do the right thing.)=20
> * Instead, for fan-out you can use the TYPE_SPLIT_IRQ device: connect=20
> * a device's outbound GPIO to the splitter's input, and connect each=20
> * of the splitter's outputs to a different device. For fan-in you=20
> * can use the TYPE_OR_IRQ device, which is a model of a logical OR=20
> * gate with multiple inputs and one output.=20
>=C2=A0=20
> So for example for the GPIO[10..15] you need to create a 6-line=20
> OR gate as (totally untested):=20
>=C2=A0=20
> /* 6-line OR IRQ gate */=20
> Object *orgate40 =3D object_new(TYPE_OR_IRQ);=20
> object_property_set_int(orgate40, "num-lines", 6, &error_fatal);=20
> qdev_realize(DEVICE(orgate), NULL, &error_fatal);=20
>=C2=A0=20
> /* OR gate -> IRQ #40 */=20
> qdev_connect_gpio_out(DEVICE(orgate40), 0,=20
> qdev_get_gpio_in(armv7m, 40));=20
>=C2=A0=20
> /* EXTI GPIO[10..15] -> OR gate */=20
> for (unsigned i =3D 0; i < 6; i++) {=20
> sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti), 10 + i,=20
> qdev_get_gpio_in(DEVICE(orgate40), i));=20
> }=20
>=C2=A0=20
> > + 1, /* PVD */=20
> > + 67, /* OTG_FS_WKUP, Direct */=20
> > + 41, /* RTC_ALARM */=20
> > + 2, /* RTC_TAMP_STAMP2/CSS_LSE */=20
> > + 3, /* RTC wakeup timer */=20
> > + 63, /* COMP1 */=20
> > + 63, /* COMP2 */=20
> > + 31, /* I2C1 wakeup, Direct */=20
> > + 33, /* I2C2 wakeup, Direct */=20
> > + 72, /* I2C3 wakeup, Direct */=20
> > + 37, /* USART1 wakeup, Direct */=20
> > + 38, /* USART2 wakeup, Direct */=20
> > + 39, /* USART3 wakeup, Direct */=20
> > + 52, /* UART4 wakeup, Direct */=20
> > + 53, /* UART4 wakeup, Direct */=20
> > + 70, /* LPUART1 wakeup, Direct */=20
> > + 65, /* LPTIM1, Direct */=20
> > + 66, /* LPTIM2, Direct */=20
> > + 76, /* SWPMI1 wakeup, Direct */=20
> > + 1, /* PVM1 wakeup */=20
> > + 1, /* PVM2 wakeup */=20
> > + 1, /* PVM3 wakeup */=20
> > + 1, /* PVM4 wakeup */=20
> > + 78 /* LCD wakeup, Direct */=20
> > +};=20
>=C2=A0=20
> > + busdev =3D SYS_BUS_DEVICE(&s->exti);=20
> > + if (!sysbus_realize(busdev, errp)) {=20
> > + return;=20
> > + }=20
> > + sysbus_mmio_map(busdev, 0, EXTI_ADDR);=20
> > + for (unsigned i =3D 0; i < NUM_EXTI_IRQ; i++) {=20
> > + sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));=
=20
>=C2=A0=20
> ^^^^^^^^^^=20
> > + }=20
> Regards,=20
>=C2=A0=20
> Phil.=C2=A0 =20

--=_0c589f4e-91b5-4b54-be9b-d5d761903ff9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-size: 12pt; font-family: arial, helvetica, s=
ans-serif; color: rgb(0, 0, 0);"><div>
<div>
<div>Hi,<br><br></div>
<div>&gt; De: Philippe &lt;philmd@linaro.org&gt;</div>
<div>&gt; Envoy=C3=A9: mercredi 7 f=C3=A9vrier 2024 23:02 CET</div>
<div>&gt;&nbsp;</div>
<div>&gt; Hi In=C3=A8s,</div>
<div>&gt;&nbsp;</div>
<div>&gt; (this is now commit 52671f69f7).</div>
<div>&gt;&nbsp;</div>
<div>&gt; On 9/1/24 17:06, In=C3=A8s Varhol wrote:</div>
<div>&gt; &gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;philmd@linaro.org=
&gt;</div>
<div>&gt; &gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;philmd@linaro.o=
rg&gt;</div>
<div>&gt; &gt; Reviewed-by: Alistair Francis &lt;alistair.francis@wdc.com&g=
t;</div>
<div>&gt; &gt; Signed-off-by: Arnaud Minier &lt;arnaud.minier@telecom-paris=
.fr&gt;</div>
<div>&gt; &gt; Signed-off-by: In=C3=A8s Varhol &lt;ines.varhol@telecom-pari=
s.fr&gt;</div>
<div>&gt; &gt; ---</div>
<div>&gt; &gt; hw/arm/Kconfig | 1 +</div>
<div>&gt; &gt; hw/arm/stm32l4x5_soc.c | 52 ++++++++++++++++++++++++++++++++=
+-</div>
<div>&gt; &gt; include/hw/arm/stm32l4x5_soc.h | 3 ++</div>
<div>&gt; &gt; 3 files changed, 55 insertions(+), 1 deletion(-)</div>
<div>&gt;&nbsp;</div>
<div>&gt;&nbsp;</div>
<div>&gt; &gt; +#define NUM_EXTI_IRQ 40</div>
<div>&gt; &gt; +/* Match exti line connections with their CPU IRQ number */=
</div>
<div>&gt; &gt; +/* See Vector Table (Reference Manual p.396) */</div>
<div>&gt; &gt; +static const int exti_irq[NUM_EXTI_IRQ] =3D {</div>
<div>&gt; &gt; + 6, /* GPIO[0] */</div>
<div>&gt; &gt; + 7, /* GPIO[1] */</div>
<div>&gt; &gt; + 8, /* GPIO[2] */</div>
<div>&gt; &gt; + 9, /* GPIO[3] */</div>
<div>&gt; &gt; + 10, /* GPIO[4] */</div>
<div>&gt; &gt; + 23, 23, 23, 23, 23, /* GPIO[5..9] */</div>
<div>&gt; &gt; + 40, 40, 40, 40, 40, 40, /* GPIO[10..15] */</div>
<div>&gt;&nbsp;</div>
<div>&gt; I'm sorry because I missed that earlier, and I'm surprised</div>
<div>&gt; you aren't chasing weird bugs. Due to how QEMU IRQs are</div>
<div>&gt; implemented, we can not wire multiple input lines to the same</di=
v>
<div>&gt; output without using an intermediate "OR gate". We model it</div>
<div>&gt; as TYPE_OR_IRQ. See the comment in "hw/qdev-core.h" added in</div=
>
<div>&gt; commit cd07d7f9f5 ("qdev: Document GPIO related functions"):</div=
>
<div>&nbsp;</div>
<div>Better fixing it now than later :)<br>I must admit I didn't pay attent=
ion to the particularity of EXTI5 to 15.</div>
<div>Current exti tests don't even use these lines, a testcase will have</d=
iv>
<div>to be added. Otherwise we mostly ran executables using GPIOs as output=
,</div>
<div>so no weird bugs encountered.</div>
<div>&nbsp;</div>
<div>Thank you for noticing !</div>
<div>Ines</div>
<div>&nbsp;</div>
<div>&gt;&nbsp;</div>
<div>&gt; * It is not valid to try to connect one outbound GPIO to multiple=
</div>
<div>&gt; * qemu_irqs at once, or to connect multiple outbound GPIOs to the=
</div>
<div>&gt; * same qemu_irq. (Warning: there is no assertion or other guard t=
o</div>
<div>&gt; * catch this error: the model will just not do the right thing.)<=
/div>
<div>&gt; * Instead, for fan-out you can use the TYPE_SPLIT_IRQ device: con=
nect</div>
<div>&gt; * a device's outbound GPIO to the splitter's input, and connect e=
ach</div>
<div>&gt; * of the splitter's outputs to a different device. For fan-in you=
</div>
<div>&gt; * can use the TYPE_OR_IRQ device, which is a model of a logical O=
R</div>
<div>&gt; * gate with multiple inputs and one output.</div>
<div>&gt;&nbsp;</div>
<div>&gt; So for example for the GPIO[10..15] you need to create a 6-line</=
div>
<div>&gt; OR gate as (totally untested):</div>
<div>&gt;&nbsp;</div>
<div>&gt; /* 6-line OR IRQ gate */</div>
<div>&gt; Object *orgate40 =3D object_new(TYPE_OR_IRQ);</div>
<div>&gt; object_property_set_int(orgate40, "num-lines", 6, &amp;error_fata=
l);</div>
<div>&gt; qdev_realize(DEVICE(orgate), NULL, &amp;error_fatal);</div>
<div>&gt;&nbsp;</div>
<div>&gt; /* OR gate -&gt; IRQ #40 */</div>
<div>&gt; qdev_connect_gpio_out(DEVICE(orgate40), 0,</div>
<div>&gt; qdev_get_gpio_in(armv7m, 40));</div>
<div>&gt;&nbsp;</div>
<div>&gt; /* EXTI GPIO[10..15] -&gt; OR gate */</div>
<div>&gt; for (unsigned i =3D 0; i &lt; 6; i++) {</div>
<div>&gt; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;exti), 10 + i,</div>
<div>&gt; qdev_get_gpio_in(DEVICE(orgate40), i));</div>
<div>&gt; }</div>
<div>&gt;&nbsp;</div>
<div>&gt; &gt; + 1, /* PVD */</div>
<div>&gt; &gt; + 67, /* OTG_FS_WKUP, Direct */</div>
<div>&gt; &gt; + 41, /* RTC_ALARM */</div>
<div>&gt; &gt; + 2, /* RTC_TAMP_STAMP2/CSS_LSE */</div>
<div>&gt; &gt; + 3, /* RTC wakeup timer */</div>
<div>&gt; &gt; + 63, /* COMP1 */</div>
<div>&gt; &gt; + 63, /* COMP2 */</div>
<div>&gt; &gt; + 31, /* I2C1 wakeup, Direct */</div>
<div>&gt; &gt; + 33, /* I2C2 wakeup, Direct */</div>
<div>&gt; &gt; + 72, /* I2C3 wakeup, Direct */</div>
<div>&gt; &gt; + 37, /* USART1 wakeup, Direct */</div>
<div>&gt; &gt; + 38, /* USART2 wakeup, Direct */</div>
<div>&gt; &gt; + 39, /* USART3 wakeup, Direct */</div>
<div>&gt; &gt; + 52, /* UART4 wakeup, Direct */</div>
<div>&gt; &gt; + 53, /* UART4 wakeup, Direct */</div>
<div>&gt; &gt; + 70, /* LPUART1 wakeup, Direct */</div>
<div>&gt; &gt; + 65, /* LPTIM1, Direct */</div>
<div>&gt; &gt; + 66, /* LPTIM2, Direct */</div>
<div>&gt; &gt; + 76, /* SWPMI1 wakeup, Direct */</div>
<div>&gt; &gt; + 1, /* PVM1 wakeup */</div>
<div>&gt; &gt; + 1, /* PVM2 wakeup */</div>
<div>&gt; &gt; + 1, /* PVM3 wakeup */</div>
<div>&gt; &gt; + 1, /* PVM4 wakeup */</div>
<div>&gt; &gt; + 78 /* LCD wakeup, Direct */</div>
<div>&gt; &gt; +};</div>
<div>&gt;&nbsp;</div>
<div>&gt; &gt; + busdev =3D SYS_BUS_DEVICE(&amp;s-&gt;exti);</div>
<div>&gt; &gt; + if (!sysbus_realize(busdev, errp)) {</div>
<div>&gt; &gt; + return;</div>
<div>&gt; &gt; + }</div>
<div>&gt; &gt; + sysbus_mmio_map(busdev, 0, EXTI_ADDR);</div>
<div>&gt; &gt; + for (unsigned i =3D 0; i &lt; NUM_EXTI_IRQ; i++) {</div>
<div>&gt; &gt; + sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, ext=
i_irq[i]));</div>
<div>&gt;&nbsp;</div>
<div>&gt; ^^^^^^^^^^</div>
<div>&gt; &gt; + }</div>
<div>&gt; Regards,</div>
<div>&gt;&nbsp;</div>
<div>&gt; Phil.&nbsp;</div>
</div>
</div></div></body></html>
--=_0c589f4e-91b5-4b54-be9b-d5d761903ff9--

