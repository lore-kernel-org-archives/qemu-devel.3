Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10F2C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 03:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7oKn-0001be-Aw; Thu, 16 May 2024 23:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7oKk-0001aq-Tp; Thu, 16 May 2024 23:32:38 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7oKj-0000gX-1a; Thu, 16 May 2024 23:32:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so1786005ad.3; 
 Thu, 16 May 2024 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715916755; x=1716521555; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sS00pXkjFqnUJWTNKOqdHSvE/hgCycvqfhLxDxfnC4c=;
 b=CXffVRPZ7S/1BG0Lw0V1ItB8d5l/husZOvzk9i4/ETbgO0ogCmzYIc2RYg9qPfXhK3
 iqXWPez7gNCc/EY20FaKWtbSLfveCKCMgufwbNCfxiDAE/54HuGmvbvt2rMvVVcMsqnc
 /UoJgno7gVWj88yGqu4ncxlLWD5jnBJnVUIogfUKQiE83B0hArN17ZIZyF0UPZ1Uc9nR
 I7+dOOd8PZyBLNghoDZigv5mskIA7zguG0ze6W1fzF8yKBIWTnkKSxShLuzGQNMj8JH5
 /bk5BCPTNn3WS2nyk+P+/IJUHHf2HOA48wvjQJWrGfSg4WKD9X8oh4RzCCeG7wKFA7p4
 U9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715916755; x=1716521555;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sS00pXkjFqnUJWTNKOqdHSvE/hgCycvqfhLxDxfnC4c=;
 b=p1URy7VwYcyA1I0G/Kf4VdDc+RToY2ttOIsJT7o3qCPNzxxiP/Frhn7ERLoI+PlU0Q
 bcfaoOHpeGTUDqY1gHg+ICsG0r7BkfgADpU8QslY053xfaMdzeIau5LePdIP2ABBG+xw
 sYDvWtXx1BfJ/l2ytTEOSE1ZBj8VXKTch8ljn9vzW07QzLv+Pp95Lrzb+16JPRCPnJqp
 NifWaXRmyoV+DPnNZJ5heK+amoiHJseotUkTw3QDI5uiNVwSRSNlID4KD7gPrl0el4eV
 pGcy3qVNfeNZuYYcH7qhrX4LfpR/juL4NuORteOjKIawF8NvcEzZjsSas9LagAjVnS4E
 8dKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU9sWXC2maj0M77x0710ilewIO40LcFx54j8fCoGefr1XWsGPZ/c8JqaEKH4tb6frY28As84btkR0wuxBNMYDXT81L
X-Gm-Message-State: AOJu0YxgabnsowgTZ5q5PkCDtvDwID8DzRD+TYcUrzCW92CBOPjKiX5s
 vcuBudZGWivr8wVBnu3c+DCVVBirpv30LJgCPKTkfnTOWbTHlgO/
X-Google-Smtp-Source: AGHT+IEosbd2iee5tve7hPRZSXC3twpZrmd4hS4S37FxNPO3+RR6PkQj4vqyCe7O5YMkAL+/deZHqw==
X-Received: by 2002:a17:903:11c7:b0:1ec:3c71:eae7 with SMTP id
 d9443c01a7336-1ef44160d99mr244883175ad.47.1715916754723; 
 Thu, 16 May 2024 20:32:34 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f1e1275ba5sm20212755ad.201.2024.05.16.20.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 20:32:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 13:32:28 +1000
Message-Id: <D1BLQ0370ZWR.3OFWPZTX3TWGF@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240510143026.109098-1-npiggin@gmail.com>
 <cf991fe4-046e-435f-973b-3a27bd6eba6a@kaod.org>
In-Reply-To: <cf991fe4-046e-435f-973b-3a27bd6eba6a@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 13, 2024 at 9:49 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello,
>
> On 5/10/24 16:30, Nicholas Piggin wrote:
> > The POWER8 LPC ISA device irqs all get combined and reported to the lin=
e
> > connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
> > host controller irqs use that line, and the device irqs get routed to
> > 4 new lines connected to PSI SERIRQ0-3.
> >=20
> > POWER9 also introduced a new feature that automatically clears the irq
> > status in the LPC host controller when EOI'ed, so software does not hav=
e
> > to.
> >=20
> > The powernv OPAL (skiboot) firmware managed to work because the LPCHC
> > irq handler scanned all LPC irqs and handled those including clearing
> > status even on POWER9 systems. So LPC irqs worked despite OPAL thinking
> > it was running in POWER9 mode. After this change, UART interrupts show
> > up on serirq1 which is where OPAL routes them to:
> >=20
> >   cat /proc/interrupts
> >   ...
> >   20:          0  XIVE-IRQ 1048563 Level     opal-psi#0:lpchc
> >   ...
> >   25:         34  XIVE-IRQ 1048568 Level     opal-psi#0:lpc_serirq_mux1
> >=20
> > Whereas they previously turn up on lpchc.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv_lpc.h |  12 ++++-
> >   hw/ppc/pnv.c             |  38 +++++++++++++--
> >   hw/ppc/pnv_lpc.c         | 100 +++++++++++++++++++++++++++++++++++---=
-
> >   3 files changed, 136 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> > index 5d22c45570..57e324b4dc 100644
> > --- a/include/hw/ppc/pnv_lpc.h
> > +++ b/include/hw/ppc/pnv_lpc.h
> > @@ -84,8 +84,18 @@ struct PnvLpcController {
> >       /* XSCOM registers */
> >       MemoryRegion xscom_regs;
> >  =20
> > +    /*
> > +     * In P8, ISA irqs are combined with internal sources to drive the
> > +     * LPCHC interrupt output. P9 ISA irqs raise one of 4 lines that
> > +     * drive PSI SERIRQ irqs, routing according to OPB routing registe=
rs.
> > +     */
> > +    bool psi_serirq;
> > +
> >       /* PSI to generate interrupts */
> > -    qemu_irq psi_irq;
> > +    qemu_irq psi_irq_lpchc;
> > +
> > +    /* P9 introduced a serirq mode */
> > +    qemu_irq psi_irq_serirq[4];
> >   };
> >  =20
> >   struct PnvLpcClass {
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 6e3a5ccdec..3b1c05a1d8 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -744,18 +744,48 @@ static ISABus *pnv_chip_power8nvl_isa_create(PnvC=
hip *chip, Error **errp)
> >   static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp=
)
> >   {
> >       Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
> > -    qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_=
LPCHC);
> >  =20
> > -    qdev_connect_gpio_out(DEVICE(&chip9->lpc), 0, irq);
>
> The pnv_chip_power8*_isa_create() routines also need an update.

Good catch, thank you.

> > +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "LPCHC", 0,
> > +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> > +                                PSIHB9_IRQ_LPCHC));
> > +
> > +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 0,
> > +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ0));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 1,
> > +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ1));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 2,
> > +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ2));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 3,
> > +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ3));
> > +
> >       return pnv_lpc_isa_create(&chip9->lpc, false, errp);
> >   }
> >  =20
> >   static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **err=
p)
> >   {
> >       Pnv10Chip *chip10 =3D PNV10_CHIP(chip);
> > -    qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ=
_LPCHC);
> >  =20
> > -    qdev_connect_gpio_out(DEVICE(&chip10->lpc), 0, irq);
> > +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "LPCHC", 0,
> > +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> > +                                PSIHB9_IRQ_LPCHC));
> > +
> > +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 0,
> > +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ0));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 1,
> > +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ1));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 2,
> > +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ2));
> > +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 3,
> > +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> > +                                PSIHB9_IRQ_LPC_SIRQ3));
> > +
> >       return pnv_lpc_isa_create(&chip10->lpc, false, errp);
> >   }
> >  =20
> > diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> > index d692858bee..e28eae672f 100644
> > --- a/hw/ppc/pnv_lpc.c
> > +++ b/hw/ppc/pnv_lpc.c
> > @@ -64,6 +64,7 @@ enum {
> >   #define   LPC_HC_IRQSER_START_4CLK      0x00000000
> >   #define   LPC_HC_IRQSER_START_6CLK      0x01000000
> >   #define   LPC_HC_IRQSER_START_8CLK      0x02000000
> > +#define   LPC_HC_IRQSER_AUTO_CLEAR      0x00800000
> >   #define LPC_HC_IRQMASK          0x34    /* same bit defs as LPC_HC_IR=
QSTAT */
> >   #define LPC_HC_IRQSTAT          0x38
> >   #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down t=
o ... */
> > @@ -420,6 +421,34 @@ static const MemoryRegionOps pnv_lpc_mmio_ops =3D =
{
> >       .endianness =3D DEVICE_BIG_ENDIAN,
> >   };
> >  =20
> > +/* POWER9 serirq routing, see below */
> > +static int irq_to_serirq_route[ISA_NUM_IRQS];
>
> This static is not friendly for multichip machines. Could we avoid it and
> move the IRQ routes under PnvLpcController ?

Ah yes I don't know what I was thinking. It's trivial to move under
the controller. I will post a v2 in a bit.

Thanks,
Nick

