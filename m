Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A4ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxHG-0002eb-7m; Tue, 10 Sep 2024 05:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxHE-0002We-5L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:35:12 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxHB-0006yz-Da
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:35:11 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so44070321fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960907; x=1726565707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLPchcVdsrTiH/SbvNa6W5ML4Pf8wEFkqIc9ZZ0co9c=;
 b=Pu5aNdQYOQg/FpQPxy3VsxVu99iY0sCw2MuwFwBTFtnt2FcW38m7cTW1jecUtmjPoJ
 HmHU3cUCyjqiM1OHymdbhaa2MmrRxdBEg2QQtU7pUqIW3kacyBrCHQcN7wNdfTHzwaMq
 WJoIlaCpGS91N95msKYOR7xUDpOCYHRPlEmyk7AEDEuogPLHtOX2/d0Oo1HU0mgu2f4H
 wcOT6ObdJtikUdC4+eAPv2lJNMrILPyV77QeA4Y68R6FlV1zPgLs88fvNER/JinsxyLL
 QdFRSA5kWM9AJT80jVO5pfIDk5lnqWp7Bb3YFrt2iSvA0XaufTjJ1lbAJujahSb8Ut4I
 zweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960907; x=1726565707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLPchcVdsrTiH/SbvNa6W5ML4Pf8wEFkqIc9ZZ0co9c=;
 b=GxLJnat69NlK49/FnUuqu4yGysq6Hz9lCmSMviNq+K8U56LjtN6chiy647lyHqhdxI
 EjmSM4MbCvelJcqwnGf+PmEaZukFQw36RevzRI7IM0hemmRIeot7OfDZHzyhok6nOxlc
 u9ETHJLJRtkGtm7HGpPD1IG1csRV1A7tIq5JzFXoerlRqHjJ32NsrgevZeFgH1eaA4v9
 nYuVADRrqj5xFWhO77VdZ9oMzgTNS3DmYPDdTWa4ZLsg8gyM21iCtRl3SxJKr/yGGVfA
 w1WEy7mg4Nd7/mhjURuBU/v12iCpnc3JKDSWSGYiNzUfrfyMZdu6T9Gs3UoDjqPzA/7l
 lC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTXxwB19TsZqgG++TS5fqnKTC7PTR42YA0chIoo0A8DasEoweTSCgfY/BjIMJShhwCwF7KNMx4Wfc@nongnu.org
X-Gm-Message-State: AOJu0YwmhXHMhIDsegJCVkzfsOtY9zHs4VUC07+zuDu3+bOTuSC3nxbE
 3qPyq+yo4KlsJu/mvlu4FJV4FgUC3ZZuSosn92WFSO70efaEKhSw9LBISMUQFY9tcjjAeK2APFT
 4MIa+N7iu9lCsqdDlaXTm3z3RQYEnaI05dhfoyw==
X-Google-Smtp-Source: AGHT+IFsnE+xXeFTaU1vgcgWdA45voPx4fxvCJMQY7L5F9/h8pkL6PuONiE2hN6Q+aBodbbr7s2LyhVbMuzlyLtjjvA=
X-Received: by 2002:a2e:b88b:0:b0:2f3:d008:a54e with SMTP id
 38308e7fff4ca-2f752495f71mr75374971fa.36.1725960906795; Tue, 10 Sep 2024
 02:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
In-Reply-To: <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 10:34:55 +0100
Message-ID: <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Jacob Abrams <satur9nine@gmail.com>, qemu-devel@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 9 Sept 2024 at 18:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> (Cc'ing Arnaud & In=C3=A8s who are listed as maintainers)
>
> On 6/9/24 18:12, Peter Maydell wrote:
> > On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote=
:
> >>
> >> These changes allow the official STM32L4xx HAL UART driver to function
> >> properly with the b-l475e-iot01a machine.
> >>
> >> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
> >> likewise for RE and REACK bit.
> >>
> >> USART registers may be accessed via 16-bit instructions.
> >>
> >> Reseting USART_CR1 UE bit should restore ISR to default value.
> >>
> >> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and =
write")
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
> >> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
> >
> > Thanks for this patch. I have one question below, and one
> > minor nit.
> >
> >> ---
> >>   hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
> >>   tests/qtest/stm32l4x5_usart-test.c | 39 ++++++++++++++++++++++++++++=
+-
> >>   2 files changed, 64 insertions(+), 4 deletions(-)
>
>
> >>   static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
> >>   {
> >>       if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))  =
      ||
> >> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object=
 *obj, ResetType type)
> >>       s->brr =3D 0x00000000;
> >>       s->gtpr =3D 0x00000000;
> >>       s->rtor =3D 0x00000000;
> >> -    s->isr =3D 0x020000C0;
> >> +    s->isr =3D ISR_RESET_VALUE;
> >>       s->rdr =3D 0x00000000;
> >>       s->tdr =3D 0x00000000;
> >>
> >> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaqu=
e, hwaddr addr,
> >>       case A_CR1:
> >>           s->cr1 =3D value;
> >>           stm32l4x5_update_params(s);
> >> +        stm32l4x5_update_isr(s);
> >>           stm32l4x5_update_irq(s);
> >>           return;
> >>       case A_CR2:
> >> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_bas=
e_ops =3D {
> >>       .endianness =3D DEVICE_NATIVE_ENDIAN,
> >>       .valid =3D {
> >>           .max_access_size =3D 4,
> >> -        .min_access_size =3D 4,
> >> +        .min_access_size =3D 2,
> >>           .unaligned =3D false
> >>       },
> >>       .impl =3D {
> >>           .max_access_size =3D 4,
> >> -        .min_access_size =3D 4,
> >> +        .min_access_size =3D 2,
> >>           .unaligned =3D false
> >>       },
> >
> > The effect of these is that a 16-bit write not aligned
> > to a (4-aligned) register offset will generate a GUEST_ERROR
> > logged message, and a 16-bit write aligned to a 4-aligned
> > register offset will write the value zero-extended to 32 bits.
> > That seems reasonable to me.
>
> Peter, are you describing the .valid.min_access_size 4 -> 2 change
> or the .impl.min_access_size one?

I was intending to summarise the effects of making the code
changes above (both .impl and .valid), without any reference
to what the real hardware behaviour might or might not be
(as a starter for figuring out whether the change is reasonable).

> My understanding of the implementation is a 32-bit one:
>
>    REG32(CR1, 0x00)
>
>    struct Stm32l4x5UsartBaseState {
>        ...
>        uint32_t cr1;
>
>    static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>                                    uint64_t val64, unsigned int size)
>    {
>        ...
>        switch (addr) {
>        case A_CR1:
>            s->cr1 =3D value;
>
> Am I missing something?

If we make the .impl and .valid changes, then the result is
that we permit 16 bit writes to come through to the read
and write functions. Since we don't make any changes to
those functions to specially handle size =3D=3D 2, you get the
effects of the existing code. If the 16 bit write is aligned
to a 4-aligned register offset it will match one of the A_*
cases, and will write 16-bit-value-zero-extended to it.
If the 16 bit write isn't to a 4-aligned offset it will fall
into the "default" case and be logged as a GUEST_ERROR.

Did I miss some aspect of what the behaviour change is?

-- PMM

