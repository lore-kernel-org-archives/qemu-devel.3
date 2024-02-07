Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A1CC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXlfl-0001zz-L8; Wed, 07 Feb 2024 12:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rXlfi-0001zK-QF; Wed, 07 Feb 2024 12:25:18 -0500
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rXlfg-0006jF-BA; Wed, 07 Feb 2024 12:25:18 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id DF7D220711;
 Wed,  7 Feb 2024 18:25:10 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id gdFCzteI6p0S; Wed,  7 Feb 2024 18:25:10 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 061F720719;
 Wed,  7 Feb 2024 18:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 061F720719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1707326710;
 bh=Wq2Af0a9zWJ82wJuePhM6JjSsKF7cUO4CiI/Rp2Xnus=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=jbAi6WTlGo/ubt8rfG90vkSH0OpJNoUuLxJQ/JTUzEXKHv/etcPkWtC7TmRf99Wcw
 pKkoviF2NL4BFc7/H/npVoJjtsR1iPON5qTPizgYudLDubuPAsowKnQVff1eaeHS3z
 YKZXi44MnZ3u1e7sSqc9t4D7GLfRX59t9G6TtK38=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id y114GT9DGWV2; Wed,  7 Feb 2024 18:25:09 +0100 (CET)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy4.enst.fr (Postfix) with ESMTP id 3F42020711;
 Wed,  7 Feb 2024 18:25:09 +0100 (CET)
Date: Wed, 7 Feb 2024 18:25:08 +0100 (CET)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, 
 Samuel Tardieu <sam@rfc1149.net>, 
 peter maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Message-ID: <2124605303.230522.1707326708850.JavaMail.zimbra@enst.fr>
In-Reply-To: <22defe7a-6c67-4aae-b028-838ee6aa4e1a@linaro.org>
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
 <20240126193657.792005-3-ines.varhol@telecom-paris.fr>
 <22defe7a-6c67-4aae-b028-838ee6aa4e1a@linaro.org>
Subject: Re: [PATCH 2/3] hw/arm : Connect DM163 to STM32L4x5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:80.125.0.74]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_4583)
Thread-Topic: hw/arm : Connect DM163 to STM32L4x5
Thread-Index: Az504CBTFdo4vraccJ8mb6QpSnn+eQ==
Received-SPF: pass client-ip=137.194.2.223; envelope-from=ivarhol-21@enst.fr;
 helo=zproxy4.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello !

> De: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Envoy=C3=A9: Lundi 5 F=C3=A9vrier 2024 14:46:58
>
> Hi In=C3=A8s,
>=20
> On 26/1/24 20:31, In=C3=A8s Varhol wrote:
> > Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> > Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> > ---
> >   hw/arm/Kconfig                 |  1 +
> >   hw/arm/stm32l4x5_soc.c         | 55 +++++++++++++++++++++++++++++++++=
-
> >   include/hw/arm/stm32l4x5_soc.h |  3 ++
> >   3 files changed, 58 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 3e49b913f8..818aa2f1a2 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -463,6 +463,7 @@ config STM32L4X5_SOC
> >       select STM32L4X5_SYSCFG
> >       select STM32L4X5_RCC
> >       select STM32L4X5_GPIO
> > +    select DM163
>=20
>=20
> > +/*
> > + * There are actually 14 input pins in the DM163 device.
> > + * Here the DM163 input pin EN isn't connected to the STM32L4x5
> > + * GPIOs as the IM120417002 colors shield doesn't actually use
> > + * this pin to drive the RGB matrix.
> > + */
> > +#define NUM_DM163_INPUTS 13
> > +
> > +static const int dm163_input[NUM_DM163_INPUTS] =3D {
> > +    1 * 16 + 2,  /* ROW0  PB2       */
> > +    0 * 16 + 15, /* ROW1  PA15      */
> > +    0 * 16 + 2,  /* ROW2  PA2       */
> > +    0 * 16 + 7,  /* ROW3  PA7       */
> > +    0 * 16 + 6,  /* ROW4  PA6       */
> > +    0 * 16 + 5,  /* ROW5  PA5       */
> > +    1 * 16 + 0,  /* ROW6  PB0       */
> > +    0 * 16 + 3,  /* ROW7  PA3       */
> > +    0 * 16 + 4,  /* SIN (SDA) PA4   */
> > +    1 * 16 + 1,  /* DCK (SCK) PB1   */
> > +    2 * 16 + 3,  /* RST_B (RST) PC3 */
> > +    2 * 16 + 4,  /* LAT_B (LAT) PC4 */
> > +    2 * 16 + 5,  /* SELBK (SB)  PC5 */
> > +};
> > +
> > +
> >   static const uint32_t gpio_addr[] =3D {
> >       0x48000000,
> >       0x48000400,
> > @@ -116,6 +143,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
> >           g_autofree char *name =3D g_strdup_printf("gpio%c", 'a' + i);
> >           object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X=
5_GPIO);
> >       }
> > +
> > +    object_initialize_child(obj, "dm163", &s->dm163, TYPE_DM163);
>=20
> The DM163 is another chip, not a component part of the SoC;
> it belongs to the machine and should be created/wired in
> b_l475e_iot01a_init(). Similarly to the IRQ splitters.
>=20
> Keeping board component states in a Bl475eMachineState structure
> could help organizing your model. You can find an example on how
> extend the MachineState in hw/avr/arduino.c.
>=20

Yes thank you ! that's done :)

> You might call qdev_pass_gpios() to exposes the SysCfg lines out
> of the SoC.

I was wondering what's the reason to expose Syscfg lines and not Gpio lines=
?
(Should GPIOs also be moved to the machine ?)

Best regards,

Ines

