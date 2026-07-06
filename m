Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2688DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnwU-0003at-AK; Mon, 06 Jul 2026 14:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wgnwS-0003aC-7Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:21:16 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wgnwQ-0001bp-59
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:21:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so1177425ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783362073; x=1783966873; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GriSkIGDui5yjwnMkhCIUYjRUaaEmOV86zeoJYH5WCE=;
 b=mfNZQLytcNTJFHFGxFvEZQuftHcRDlQcsUyRk1Uu4e5MUqz2X6CBxiY65rfN+Ui5T0
 uRICSW1SAP4OoD8YM+yX8zZQ3oToJDEYHyFU/PLOZO5BrUmRp89/IRhbCTDNaShSvMti
 zKhlB7DNgbxmqsLZy+D646Cz8Np7+Oab171vwjGhUQTCnlWHlIEyMyJivzmyZqvYDw8p
 wVGsI309BKUOYkYgCXxNh3afjIk/oXHXQxujriRVgCmrGzhQIqX+1+gi36ubSnyPFoPN
 blyT7lQDNEbJHsWKHR6ai0Xy71jgFifY72dmTv9G1REiBeFYCz7jiSeRDcBoW4r20jVr
 Tjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783362073; x=1783966873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GriSkIGDui5yjwnMkhCIUYjRUaaEmOV86zeoJYH5WCE=;
 b=G8lQyF6U/RKDnnFC3lzLA0oXuQcnKo1r8eRJfTYdnwgwqOcnpNbQxnI8F/AlaCVpNG
 piaR53uFAeDA0keX9HBS31P//ZIiiu8n9hLekAayZh74XKFj0SQA2MmNVwaqgaxigKGs
 Jy1RTfIrhSkXHiaYbauu0iBAfiFHX0tWNgwgyUQZZwJ0qxHwpaZw4GYuBJk+TumT5bVX
 bHwTcJs5RJsIFlKoA/plEqVV3FjhfH87emZloUkYC3s+28kU/sTdZCConClYFK3W5hRH
 KK4oSI7iC6eVQCtZlEQysFab3LYAeK9kJD82JLoS+vi0w+KxWcX1dtuJx1ci7BJJx766
 EhUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz7V9m2HkwDddlaNcPtWYc8LHr6CYva1+GoRNopkkQLsNqi08UgwZdurAQNp+nbRJ3GTrSMRehuLdZ@nongnu.org
X-Gm-Message-State: AOJu0Yz34Nqp6X3tVCVrYGnImUwQQeecaIQkCn9swJVb3BCh0kJEYqdo
 S7bGZRUnVgaavj6QDJiLmSlyq3BEaVm9rRkdFiixvzsnoyMohjJhsseS
X-Gm-Gg: AfdE7cmAzrEZXhXYNaKJhiYpDYo0ftVdyqo0xWfabya8NNp6Eahs7G/7E+aAbK6E28n
 idcC3vrT1oZlvpZSyfW+EzavzGbEj+Hip0a6rcduj5kXrtVZarmMAaa+mVe9AC/D95Dp1VeeYP3
 GXcYutgTS8DP7h5jbDH3tfNpRfgAQUdu/SmVrjkkNBVNdB2YE0nLa/PnlVBubcojsHYevRJIP7x
 t/j2s1BgOFigdbHeLXETG+zJVxxZW8dHn1eaDwdCB4gZT/8KsrNR+3gzvDEn8vGH76/Mt8xNkDg
 8kAdx0WpmJrag0/8yzw/BcCq3RiL/wk/iU3QIeFa9vJhnPxXp3Xi1jtNovFfND2rpB3umAKvJ9M
 iyRuvvwTAf5pFKfZgUHyAomIhhA0dzZ17/nJwx0LIhg7NmOXxlzl3p1UdWCpBimcczYwQl6Y1Bn
 vKjSR6V9jlDZc0Htt+K8SJk2EYhQ==
X-Received: by 2002:a05:6a20:c996:b0:3a3:adea:83bc with SMTP id
 adf61e73a8af0-3c08e7f7ccemr2018610637.15.1783362072416; 
 Mon, 06 Jul 2026 11:21:12 -0700 (PDT)
Received: from google.com ([2402:7500:46a:881a:bfa6:b3b2:ab12:133b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e8eb0ec76sm6475208a12.1.2026.07.06.11.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 11:21:12 -0700 (PDT)
Date: Tue, 7 Jul 2026 02:21:07 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com,
 alistair.francis@wdc.com, farosas@suse.de, lvivier@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 1/5] hw/char: Add dw8250 UART
Message-ID: <akvyEywAnPu1FPyt@google.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-2-visitorckw@gmail.com>
 <CACPK8Xc+AZyt9VJzvOCus4sGXEFT3VBmwLwLbsuaY2+CN_6oPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xc+AZyt9VJzvOCus4sGXEFT3VBmwLwLbsuaY2+CN_6oPA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x62e.google.com
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

On Wed, Jul 01, 2026 at 01:34:27PM +0930, Joel Stanley wrote:
> On Wed, 17 Jun 2026 at 04:31, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add the dw8250 uart support. This hardware is a widely used 16550A
> > derivative that includes additional registers.
> >
> > Without this specific device support, the Linux 8250_dw driver fails to
> > probe the extended registers (UCV, CPR, etc.), which are essential for
> > correct feature detection:
> 
> Nice. The atlantis board works around this by adding an uimp region,
> but having a real model is even better.
> 
> Some minor comments below.
> 
> > [    0.293566] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> > [    0.306929] Oops - store (or AMO) access fault [#1]
> > [    0.307020] Modules linked in:
> > [    0.307192] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0 #1 PREEMPTLAZY
> > [    0.307250] Hardware name: Milk-V Duo (DT)
> > [    0.307294] epc : dw8250_setup_port+0x22/0x520
> > [    0.307504]  ra : dw8250_probe+0x57e/0x5b8
> > [    0.307518] epc : ffffffff80708dd6 ra : ffffffff8070a49e sp : ffffffc60000b820
> > [    0.307525]  gp : ffffffff81a32ba8 tp : ffffffd602180cc0 t0 : 0000000000000073
> > [    0.307533]  t1 : 000000000000006c t2 : 0000000000000000 s0 : ffffffc60000b830
> > [    0.307539]  s1 : ffffffd6028c8640 a0 : ffffffc60000b848 a1 : ffffffff813162c1
> > [    0.307546]  a2 : ffffffff813162c0 a3 : ffffffd6028c8640 a4 : ffffffc60002d0b4
> > [    0.307552]  a5 : 0000000000000001 a6 : 0000000000000094 a7 : 0000000000000060
> > [    0.307558]  s2 : ffffffd60225d410 s3 : ffffffd60225d400 s4 : 0000000000000000
> > [    0.307573]  s5 : ffffffff80e31a48 s6 : 0000000000000008 s7 : 0000000000000000
> > [    0.307584]  s8 : 0000000000000149 s9 : 0000000000000000 s10: 0000000000000000
> > [    0.307590]  s11: 0000000000000000 t3 : ffffffd602007c00 t4 : ffffffff81601540
> > [    0.307604]  t5 : 0000000000000003 t6 : ffffffd602a42f82 ssp : 0000000000000000
> > [    0.307611] status: 0000000200000120 badaddr: ffffffc60002d0b4 cause: 0000000000000007
> > [    0.307652] [<ffffffff80708dd6>] dw8250_setup_port+0x22/0x520
> > [    0.307695] [<ffffffff8070a49e>] dw8250_probe+0x57e/0x5b8
> > [    0.307702] [<ffffffff80731f0e>] platform_probe+0x46/0x80
> > [    0.307708] [<ffffffff8072f67c>] really_probe+0x84/0x22c
> > [    0.307715] [<ffffffff8072f880>] __driver_probe_device+0x5c/0xd4
> > [    0.307721] [<ffffffff8072f9be>] driver_probe_device+0x2e/0xf4
> > [    0.307727] [<ffffffff8072fbe6>] __driver_attach+0x6e/0x14c
> > [    0.307734] [<ffffffff8072d5f0>] bus_for_each_dev+0x60/0xb0
> > [    0.307740] [<ffffffff8072f1b2>] driver_attach+0x1a/0x24
> > [    0.307746] [<ffffffff8072e8da>] bus_add_driver+0xca/0x1d8
> > [    0.307752] [<ffffffff80730aaa>] driver_register+0x3e/0xdc
> > [    0.307757] [<ffffffff80731c54>] __platform_driver_register+0x1c/0x24
> > [    0.307779] [<ffffffff80c334f6>] dw8250_platform_driver_init+0x1a/0x24
> > [    0.307793] [<ffffffff80011992>] do_one_initcall+0x4e/0x2a4
> > [    0.307800] [<ffffffff80c01362>] kernel_init_freeable+0x226/0x2b0
> > [    0.307807] [<ffffffff80bc3798>] kernel_init+0x1c/0x144
> > [    0.307813] [<ffffffff8001361c>] ret_from_fork_kernel+0x18/0x164
> > [    0.307820] [<ffffffff80bcefb6>] ret_from_fork_kernel_asm+0x16/0x18
> > [    0.307914] Code: 3683 2085 0b63 32f7 000f 0140 6918 4785 0713 0b47 (c31c) 2583
> > [    0.308041] ---[ end trace 0000000000000000 ]---
> > [    0.308180] Kernel panic - not syncing: Fatal exception in interrupt
> > [    0.315760] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> The kernel oops doesn't add much; I'd drop it from the commit message.
> But your call if you want to keep it.
> 

will drop the stack trace.

> > --- /dev/null
> > +++ b/hw/char/dw8250.c
> 
> > +#define DW_UART_RE_EN 0xB4 /* Receiver Output Enable Register */
> > +#define DW_UART_DLF   0xC0 /* Divisor Latch Fraction Register */
> > +#define DW_UART_CPR   0xF4 /* Component Parameter Register */
> > +#define DW_UART_UCV   0xF8 /* UART Component Version */
> > +#define DW_UART_CTR   0xFC /* Component Type Register */
> > +
> > +#define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */
> 
> I was curious  what this was used for, and it seems Linux has a
> dev_dbg but otherwise it's not important. The values here should be
> fine.
> 
> > +#define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
> > +
> > +static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > +    switch (addr) {
> > +    case DW_UART_UCV:
> > +        return DW_UART_UCV_VALUE;
> > +    case DW_UART_CPR:
> > +        return 0x00000000; /* No advanced features (DMA, extra FIFOs) */
> 
> Linux will detect zero and use a value from the platform data, but
> this is only to support a quirk on renesas rzn1, so again this should
> be fine.
> 
> > +    case DW_UART_CTR:
> > +        return DW_UART_CTR_VALUE;
> > +
> > +    case DW_UART_RE_EN:
> > +    case DW_UART_DLF:
> > +        /*
> > +         * Return 0 to indicate these optional features
> > +         * (RS485 and Fractional Divisor) are not implemented.
> > +         */
> > +        return 0x00000000;
> > +
> > +    default:
> > +        return 0;
> > +    }
> > +}
> > +
> > +static void dw8250_ext_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
> > +{
> 
> LOG_UNIMP (or LOG_GUEST_ERROR)?

Ack. Will add it in the next version.

> 
> 
> > +static void dw8250_realize(DeviceState *dev, Error **errp)
> > +{
> > +    DW8250State *s = DW8250(dev);
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(s->serial_mm);
> > +
> > +    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
> > +                       DW_UART_REGION_SIZE);
> > +    sysbus_init_mmio(sbd, &s->container);
> > +
> > +    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
> > +    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN);
> > +    sysbus_realize(serial_sbd, errp);
> 
> Return on error?

Ack.

> 
> > +
> > +    memory_region_init_io(&s->ext_iomem, OBJECT(dev), &dw8250_ext_ops, s,
> > +                          "dw8250-ext", DW_UART_REGION_SIZE);
> > +    memory_region_add_subregion(&s->container, 0, &s->ext_iomem);
> > +
> > +    memory_region_add_subregion_overlap(&s->container, 0,
> > +                                        sysbus_mmio_get_region(serial_sbd, 0), 1);
> > +
> > +    sysbus_pass_irq(sbd, serial_sbd);
> > +}
> > +
> > +static const Property dw8250_properties[] = {
> > +    DEFINE_PROP_UINT8("regshift", DW8250State, regshift, 2),
> 
> When boards have a value other than 2, does this affect the DW
> extension registers too? Or only the 8250 ones?

I current use hardcoded byte offsets which inherently assumes
regshift = 2. 

I'll update the switch statements in the extension memory region to
shift the addresses based on s->regshift.

Regards,
Kuan-Wei

