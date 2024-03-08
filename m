Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D419C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribjD-0006aG-1T; Fri, 08 Mar 2024 10:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ribj8-0006ZN-Ct
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:01:39 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ribj3-0007QA-C9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:01:36 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29b70bf6c58so749184a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1709910091; x=1710514891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgb4/nwWcRVUazmGKiAvCcoOR0ZggHLtVCwE62RSFCs=;
 b=Z6fhbJBrpBF59OdtDEwr2O4lQrKNX6KJlmnBVopQrwwEP0OnPQgZ3Z6DtIv91yKA+/
 7VW84EBHrlSHdY7oa8F6Wdv5oHbj9NWBCc4dYJADWRSFKd93e2+OR49E37kfX0/kqks7
 BvIDGoAltrwh+tT0j9sVvm/dZGMBe6ndTXsAdrahZR9LtOvnUAwZG59zFkhGjOx+Yv7A
 366HJ++S+JRb+yAFEBAf5i2SfWxtEVexX3pD3i3Giwo87u51+pgL78hiGDcCUd1JsaLi
 D1pJxYBrqxXVyb8TFREqFXwdbWrSC77eLy+RbbFp9OlWeWCZ8sRE4SviK4oHnR6SSLAX
 TESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709910091; x=1710514891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgb4/nwWcRVUazmGKiAvCcoOR0ZggHLtVCwE62RSFCs=;
 b=ErD5TPKjt6g3A5mRgxORHgLq9vF1d5D8r9VJCcq524cqVNBnMD9EsTnyItQDuQyBEe
 F0zFhY+jGXZgI/+CiDu1AZK9/fCDMXBLZc0qeNMxtKu0usr5HKLFarn5KdlAJXmQmELk
 MkeFpa8SVKTBgPdy8MLAfky0qV1H+t8a27NQ4sImpBnHBY6wfq5MxE3xg30Ic8rwgDTk
 JdmfSK/bxOH0UGjYvH0pry3P3I1IVHzL9QjVG5Nu/5odtyjjxeQ1v80DGvPGaJohj2YL
 gT1vGksjU3pC9vbRhjWEoQEInSZ+d08fCB7LWAxNu311X5uUO6nBkaEg8LYaL/F+zBIW
 gASA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC4CgE5q9VlqGeKeE7vGAHYMGraDYg2F9j6Lvy+LZLyNvuAyYvPpIoxVmJtMoRU2rTrGizSbrjZcXKUBQwC405RQfwI5M=
X-Gm-Message-State: AOJu0YyaRY4BXQXQ8XSFx8t9K+z7Uf+Z6NfEkeiK1zParIfmrh/cywvz
 x7NBEjYq2CELo1RhDrHvf3cqfpyT8RcRr5YkF9+pJnfwAih5IjfCIaDRFB0dWCo0SNBlIFDX9F4
 KpSuGncb76ZrRFugt7bMlqTRLzkdJth+ddCdq
X-Google-Smtp-Source: AGHT+IGpcKDhzHzRC0jynvLJzW/d6THioRVtB9D+SYqhSTmOgqw/WP3dRBW3ZF0NdNHNKGs1fVUZ93lR+ntNC5YMrUc=
X-Received: by 2002:a17:90a:e544:b0:29b:178e:d9cb with SMTP id
 ei4-20020a17090ae54400b0029b178ed9cbmr208905pjb.44.1709910090977; Fri, 08 Mar
 2024 07:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20240215175752.82828-1-philmd@linaro.org>
 <20240215175752.82828-35-philmd@linaro.org>
 <CAFEAcA-HpKCk-n4HsnZPiz09xq9sk=Sh5nt05KpRymy-NQ2HEg@mail.gmail.com>
In-Reply-To: <CAFEAcA-HpKCk-n4HsnZPiz09xq9sk=Sh5nt05KpRymy-NQ2HEg@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 8 Mar 2024 16:01:19 +0100
Message-ID: <CAJ307EhHYucqcYSDPzX6Bt9YYUxfWkOSEXLGwNTb2ivJhm=j3w@mail.gmail.com>
Subject: Re: [PULL 34/56] hw/intc/grlib_irqmp: add ncpus property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 8, 2024 at 2:27=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 15 Feb 2024 at 18:04, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > From: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >
> > This adds a "ncpus" property to the "grlib-irqmp" device to be used
> > later, this required a little refactoring of how we initialize the
> > device (ie: use realize instead of init).
> >
> > Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Message-ID: <20240131085047.18458-3-chigot@adacore.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Hi; Coverity points out a bug in this commit (CID 1534914):
>
>
> > -static void grlib_irqmp_init(Object *obj)
> > +static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> >  {
> > -    IRQMP *irqmp =3D GRLIB_IRQMP(obj);
> > -    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> > +    IRQMP *irqmp =3D GRLIB_IRQMP(dev);
> >
> > -    qdev_init_gpio_in(DEVICE(obj), grlib_irqmp_set_irq, MAX_PILS);
> > -    qdev_init_gpio_out_named(DEVICE(obj), &irqmp->irq, "grlib-irq", 1)=
;
> > -    memory_region_init_io(&irqmp->iomem, obj, &grlib_irqmp_ops, irqmp,
> > +    if ((!irqmp->ncpus) || (irqmp->ncpus > IRQMP_MAX_CPU)) {
> > +        error_setg(errp, "Invalid ncpus properties: "
> > +                   "%u, must be 0 < ncpus =3D< %u.", irqmp->ncpus,
> > +                   IRQMP_MAX_CPU);
> > +    }
>
> We detect the out-of-range 'ncpus' value, but forget the "return"
> statement, so execution will continue onward regardless, and
> overrun the irqmp->irq[] array when we call qdev_init_gpio_out_named().

Indeed, I'll send a patch.
Thanks for pointing that out.

Cl=C3=A9ment

> > +
> > +    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> > +    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
> > +    memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops=
, irqmp,
> >                            "irqmp", IRQMP_REG_SIZE);
> >
> >      irqmp->state =3D g_malloc0(sizeof *irqmp->state);
> >
> > -    sysbus_init_mmio(dev, &irqmp->iomem);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &irqmp->iomem);
> >  }
>
> thanks
> -- PMM

