Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB654C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGc5-0001DL-9A; Mon, 01 Jul 2024 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGc2-0001Cj-RQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:58:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGc1-0006tp-6K
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:58:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso34731221fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838707; x=1720443507; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xodlcZ31VdwpGXnqDLyDh5KNbUH58jfIKN9g58QEqSY=;
 b=fSKJcH0umZOTzgYbLcpjSTB+A9XhMroHPvOlYG2V5FUHkqrO/DSItLU48hG/D5AeSH
 e5XHZyoT4Z/ddjcn+2xzJlW5KSRoy/snPk6ov140a+6eDPIxda8zP7hoGGe9wCU2XycF
 q78vYgs83UeJ0dtpEwoiIp+NZz9RQP6CNGGLBpRRgUyhysaCUlj+irVkf49lHeO9G1EK
 UOs4RYlfluixfv11v7GlENECQjvccEHRkGpj+LsII2n8uPfdny2KgW6+tsQI+bgt5UcE
 LSg5TT9/SGFRyoMC2SUh4sN6GwT4+EFqsG4SnW8RqJ/VMCvivjB3bEhEmxpviB4QR1ih
 ix8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838707; x=1720443507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xodlcZ31VdwpGXnqDLyDh5KNbUH58jfIKN9g58QEqSY=;
 b=s++T1OLOhho69F2hlgd04rcm7NpuW26ezITeEjgu9Z1Qp8GZvp7tR4+whX0F8I93ty
 qQoCJM11BtMBRxosWVjOxWxPY6wEPC6e9+LtKW8vGruk6qUwdhXjbKWqx1INYXyvzFNZ
 4h+40rfWDRadaFSgwWaWdsXrxxInwXrOXtm6GDAeMH8RU2EMRlTLFca5Hwrk0D4Wj9gA
 O3IucPMDYWFaG6EwvkghF7+hoyIdpNg6rQ3jBHdMN2XyWt0ag3iNh94YqHYd6B88lL14
 H6CufTPwmTIV/QAsKBOp+0bcYjB8v3gnDHOgf08wrL+mV/afNHlyqhs/iCU2ua76LquJ
 pQzA==
X-Gm-Message-State: AOJu0YwxuvNjeoIL3UagbytUheLfFzPwDLHUjfZ1O8UCsevOSUI8EegY
 8s14zonC6mPXrqUBgmNp1pAVGfLCjgcUg5EOV4uujkRL3eITYhq3NyCwcxYbtqFcmIX6JPpQ6YO
 HWat5PSSD5Mycwbjfg8zz+/Gqe3b28i0wNScOTQ==
X-Google-Smtp-Source: AGHT+IGdAC5vMoB33gKUrpbMI+TKAw7bIXCJtsTi9s168cB4Amsk1kCdnXf0w61ariVT/BCIg3KoZeW61fWi6O/BruE=
X-Received: by 2002:a2e:a889:0:b0:2ec:558d:4e0a with SMTP id
 38308e7fff4ca-2ee5e393e16mr50203781fa.19.1719838706659; Mon, 01 Jul 2024
 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
In-Reply-To: <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 13:58:15 +0100
Message-ID: <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/isa/vt82c686.c: Embed i8259 irq in device state
 instead of allocating
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
> device state instead of allocating it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/isa/vt82c686.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 8582ac0322..834051abeb 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>
>  struct ViaISAState {
>      PCIDevice dev;
> +
> +    IRQState i8259_irq;
>      qemu_irq cpu_intr;
>      qemu_irq *isa_irqs_in;
>      uint16_t irq_state[ISA_NUM_IRQS];
> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>      ViaISAState *s = VIA_ISA(d);
>      DeviceState *dev = DEVICE(d);
>      PCIBus *pci_bus = pci_get_bus(d);
> -    qemu_irq *isa_irq;
>      ISABus *isa_bus;
>      int i;
>
>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>      isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>                            errp);

So if I understand correctly, this IRQ line isn't visible
from outside this chip, we're just trying to wire together
two internal components of the chip? If so, I agree that
this seems a better way than creating a named GPIO that
we then have to document as a "not really an external
connection, don't try to use this" line. (We've done that
before I think in other devices, and it works but it's
a bit odd-looking.)

That said, I do notice that the via_isa_request_i8259_irq()
function doesn't do anything except pass the level onto
another qemu_irq, so I think the theoretical ideal would be
if we could arrange to plumb things directly through rather
than needing this extra qemu_irq and function. There's
probably a reason (order of device creation/connection?)
that doesn't work though.

-- PMM

