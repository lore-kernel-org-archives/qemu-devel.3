Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B93C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmQEf-0003Ax-SL; Sun, 23 Feb 2025 23:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQEb-0003AZ-1s
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:38:25 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQEY-0003QF-FT
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:38:23 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4bfb4853c29so946769137.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 20:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740371901; x=1740976701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BISsHNwx0FXRb1gqRGhGSwYTwFPT4yMOK3SVWnfZ9I=;
 b=bL+3hJr3VjanvXu9hSKlApVXsbb2McijML8nc+aGumNSXqFeraQBzzg27HhBk4rcpY
 WbsklPIwwKnEfzf8g8Ld1YwvEEUtew9mfByVvACNY7dEjmaueWZJAGpBJ4p4i38JpiEs
 MHsVEi3iQeF6SR6+ZpNr8gwNPk2+fwVPtcdK92YEnSHePCWu8DiKYxBnK3pt+zYlhguY
 r865+ZHgxAXmNjIPZ1R473Hu8WPGn22U+Caa9TTWTh8JuZ7ES82iSYVDQtDYI6B8q84H
 hOilYMZUcP6KgSMelQkwCROhxqxLYsczOtk5akEkrfp5hQX7ornnatGCxPngXOl+wuEC
 2uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740371901; x=1740976701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BISsHNwx0FXRb1gqRGhGSwYTwFPT4yMOK3SVWnfZ9I=;
 b=b9M+DrQRdHdmfpWHgRdjenrAk3sETLM6MfmdSkKz149TbIjZNPp02Q0xOYznPZxDn+
 5yYZJ5/sYVvRnbzmNEVRHJa5rhpXbLB6H7XiYIMauotSZwzjo7ZH4F2sxLadabxcL7Vq
 hS6K7cNayyWN2HV8egSCUO386a8iNERxiusoXxDuNQUVri0eXz0eE0DnmKlJerEpLDre
 z1msOS9fSFy4nrhXo2uWb1ACRdYaigQV1lcO4rYW/zc9bj8AX7iUUZfYx1s/fL6fWXD7
 uTE4mgJjVw+Ol0uAx+TxlrVZRY4YP3PDDRoIQAOck34CtalgBJBv7n4skxG7/CkpMVLD
 wPuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0mDH9x9Y5dUWRgLGeuodj6p8G0CniXDWnBZdXxqn2pUp9mog1w5bjiQD0jPaQX9DIqIWRHKCu+1Lh@nongnu.org
X-Gm-Message-State: AOJu0YyJR9XRZ6FdJ2Fw4LinKtOULNO444hTzw/IwOmt0IXqrLhEcQ6B
 UPQS3NwdAnpTnHOSw93klb2GTjjjFNfDrvxwsPVjPToE0P829p3Qf0iUo7aTPd+h5Pjw+hFGEBG
 iQqAvc0KigiBDIcUZQ7jW1lBrLaw=
X-Gm-Gg: ASbGncvT+xla1Oud5GD9vfoIvEO3NXIekdT1xjFpy4nnxs+zn+IhEGnLGgRhL9ygNEY
 XaA9S2Tb0JTh+UnoP5cStwv++/0Mr9xgd/mfI/lhIoImgtVXTl3tOKyq+URJiXc/Rl4M9hAdV1S
 RJb63LLVdehxDTZuNWzO8R+gCdBYEq5yCv+xwc
X-Google-Smtp-Source: AGHT+IFQDAvYlC22XaGHLa2SzLEBXzoMeb4/ostlfl1IFIGwKgASr/AbAStcNZWbFByPb4U+8doonPoJRL6lSKZDtMk=
X-Received: by 2002:a05:6102:4b18:b0:4bb:c0a7:39b8 with SMTP id
 ada2fe7eead31-4bfc022708fmr6093522137.17.1740371900832; Sun, 23 Feb 2025
 20:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-16-alistair.francis@wdc.com>
 <CAJ307EhFCpK8aO7r7PHF7H=k=f9tstPe=aVKrMWv1y7m3_HSNw@mail.gmail.com>
 <CAJ307EhOKFyK3ULJ2NEj+zYcSbVQ1RxGcVj40_HFBbwt0UJL9g@mail.gmail.com>
In-Reply-To: <CAJ307EhOKFyK3ULJ2NEj+zYcSbVQ1RxGcVj40_HFBbwt0UJL9g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 14:37:54 +1000
X-Gm-Features: AWEUYZnzlAAkr6ZX2Cf-p4MKFtDQPHMyhcSpiQJbDndqr6ByXScm8UfOBwKv-Ow
Message-ID: <CAKmqyKNa4=r2eqRL1OsndU0kVFY23Kq6GaZfm5dqF4mavRkyaQ@mail.gmail.com>
Subject: Re: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Feb 22, 2025 at 1:27=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
>
> On Fri, Feb 14, 2025 at 1:52=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adaco=
re.com> wrote:
> >
> > Hi Alistair,
> >
> > I've an issue following this patch. When the system is reset (e.g
> > using HTIF syscalls), the fifo might not be empty and thus some
> > characters are lost.
> > I discovered it on a Windows host. But by extending
> > "TX_INTERRUPT_TRIGGER_DELAY_NS" to a huge value, I'm able to reproduce
> > on Linux as well.
>
> The root cause of my issue was unrelated to these early shutdowns. On
> Windows, the character device behind `-serial mon:stdio`
> (char-win-stdio) doesn't provide an `add_watch` method. Therefore,
> `qemu_chr_fe_add_watch` calls always result in an error, flushing the
> fifo. I saw in @Philippe Mathieu-Daud=C3=A9 patch about pl011 that
> `G_SOURCE_CONTINUE` is returned instead of calling it and it does
> work. @Alistair Francis  do you remember if there was a reason for
> calling `add_watch` ?

qemu_chr_fe_add_watch() is used in a range of UART devices, I am not
really sure of a different way to write the data out.

I don't see `G_SOURCE_CONTINUE` in pl011.c either

>
> > I've tried to flush within an unrealized function but it didn't work.
> > Any suggestions ?
>
> FTR, I still have found a solution here using
> qemu_register_shutdown_notifier. Though I'm wondering if this is
> useful: the cases where a shutdown occurs between two "fifo_update"
> seems really narrow, but they could happen.

What does the actual hardware do? I don't think it has a shutdown
notifier. I think this is up to the guest to flush the UART.

>  @Philippe Mathieu-Daud=C3=A9 AFAICT, the new pl011 and other char device=
s
> implementing write fifo have the same issue. Thus, pinging you here to
> get your advice.
>
> Thanks,
> Cl=C3=A9ment
>
> > >  static void sifive_uart_reset_enter(Object *obj, ResetType type)
> > >  {
> > > ...
> > > +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
> >
> > I'm also wondering if that part could not lead to memory leak.
> > `fifo8_destroy` is never called and AFAIK, there are ways to reset a
> > device dynamically (e.g snapshot, though not sure if it's supported
> > here).

Good catch, I can send a patch to fix this

Alistair

> >
> > Thanks, Cl=C3=A9ment

