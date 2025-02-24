Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F9C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmW4t-0000ES-Vu; Mon, 24 Feb 2025 05:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tmW4s-0000ED-4j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:52:46 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tmW4p-0004ej-Sc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:52:45 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abb892fe379so678486266b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1740394361; x=1740999161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWX1DP/kEshvZIQfhnaQNi6FCUcnB97Vew+UqGUTxL8=;
 b=XuyBTuBmhcMp+0iC2e4r5LsuzgEdbz0BXrEF4i/lMlTfrB2jMD+Mbf8/4RTFdVYECd
 73WpaPf9NG60SBWc+LSjLQ0suMcAqpowBTQWXVMixKTbxIE4QwNFF6eh9eQ21iyE4oPh
 L4be691s0J8F/Cy9N874Mm6/4cls+HykJh2xoRs2EZ6M4aogmYONwR72OhW1CIjX4WTM
 hYnzLdUfWwBLwp3dnWH3X2yhHYL+JmEnLm+x/DqaGsqZoviuQENCiObHeN0kPIoYAPzj
 1x+rwcBmnMK3RZBVHyYiRZZ+045B6ejQEEWoBb9ZniSnSJMrZ1VnBisRpSUqEVroDz2B
 Ly3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740394361; x=1740999161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWX1DP/kEshvZIQfhnaQNi6FCUcnB97Vew+UqGUTxL8=;
 b=UcxhDH8L9FxvECJ1LjxnI7hIfF1KB4AinGu4EBCe1LWmxFuejuEAUAEqSwwM/eiUAm
 +6uWZpag++S377DBoCA97teeFNldGJAOpoLCvwbGCVk7mehhGVnybBTLKkzQoo2tYLYb
 1JmHqvJdTS86PNR5dvHcYOI3XCbKwr4uIInIenmwtWFeh6y+s+GKH3mOFTfMA2w4MMve
 tyfYEQqsqRXcz+mNGyYaaRPubNZnospP81Hv9erxRcyQ5VHraWP6ZW6ovB/3gQmrRxUP
 KyVX78dWiF4AZkBldru1si/vGk7d7BJYyCy0u2cZ3vUUBoO7lJx8brGXurZDCN1E+AYp
 j/gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX/G19gSFkis9h6bPUivRIN11PISbqNCj76MgIQc/GOpjIZPS4+nDcftrUMNoUzYm55cHKjzicQjJs@nongnu.org
X-Gm-Message-State: AOJu0YwhhpYyu/O/udrNfKxDNu1afUrYd5Y/DdfZJRh+nn0M4FEDRKfc
 xohp5eCn13VD5fm8FeBl/+BhHh7QBW/WyKwtTuWBQ32AnkyH28BOpiGaukNKz/Gqj/WyumQL6o4
 BIGIaoZllkDS6gP7iz1b9Ki0Zs0bp/E04PwLQ
X-Gm-Gg: ASbGncuDRwpSC969FOVkTPmIKfHcBSzGbTpADx6TLdmgg8CVG5THx64wCJAJunpJ//E
 vnnEZpWKW1tdYdVVc3rl/bB1EYt6smtOw4Q3sVLP/BMAXXl2nY6Tpdg8AvVeHP4b2hK9ubFodHi
 xinBXHL74=
X-Google-Smtp-Source: AGHT+IF4H/qXmsBgxxGCNNT3cp0+tYl5xibBBWPQ/0iBY0kFFf2iKu1GUJHXMJYsG9NHQlVy2hqDVBt77Y4yaI61/Ts=
X-Received: by 2002:a05:6402:3495:b0:5e0:82a0:50ce with SMTP id
 4fb4d7f45d1cf-5e0b7265baamr31547914a12.27.1740394361484; Mon, 24 Feb 2025
 02:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-16-alistair.francis@wdc.com>
 <CAJ307EhFCpK8aO7r7PHF7H=k=f9tstPe=aVKrMWv1y7m3_HSNw@mail.gmail.com>
 <CAJ307EhOKFyK3ULJ2NEj+zYcSbVQ1RxGcVj40_HFBbwt0UJL9g@mail.gmail.com>
 <CAKmqyKNa4=r2eqRL1OsndU0kVFY23Kq6GaZfm5dqF4mavRkyaQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNa4=r2eqRL1OsndU0kVFY23Kq6GaZfm5dqF4mavRkyaQ@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 24 Feb 2025 11:52:30 +0100
X-Gm-Features: AWEUYZnHs8keJ-t0ObK0nMLcEhagiqmII8qyf8jdc6N-IaKVx-bTkTPg-CNUJCk
Message-ID: <CAJ307EiffX2dWuDzuLLL96vcon8yT8gRzdd_GGsOZOHAYPS2EA@mail.gmail.com>
Subject: Re: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x634.google.com
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

On Mon, Feb 24, 2025 at 5:38=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Sat, Feb 22, 2025 at 1:27=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adaco=
re.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 1:52=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@ada=
core.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > I've an issue following this patch. When the system is reset (e.g
> > > using HTIF syscalls), the fifo might not be empty and thus some
> > > characters are lost.
> > > I discovered it on a Windows host. But by extending
> > > "TX_INTERRUPT_TRIGGER_DELAY_NS" to a huge value, I'm able to reproduc=
e
> > > on Linux as well.
> >
> > The root cause of my issue was unrelated to these early shutdowns. On
> > Windows, the character device behind `-serial mon:stdio`
> > (char-win-stdio) doesn't provide an `add_watch` method. Therefore,
> > `qemu_chr_fe_add_watch` calls always result in an error, flushing the
> > fifo. I saw in @Philippe Mathieu-Daud=C3=A9 patch about pl011 that
> > `G_SOURCE_CONTINUE` is returned instead of calling it and it does
> > work. @Alistair Francis  do you remember if there was a reason for
> > calling `add_watch` ?
>
> qemu_chr_fe_add_watch() is used in a range of UART devices, I am not
> really sure of a different way to write the data out.
>
> I don't see `G_SOURCE_CONTINUE` in pl011.c either

The patch has not yet been merged to master AFAICT. But here is the
code replacing `qemu_chr_fe_add_watch` in `*_xmit`:

+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission if we couldn't transmit all. */
+        return G_SOURCE_CONTINUE;
+    }

However, it seems that Peter has detected some issues with those
patches (see [2]). So, I'll wait for the patch to land on master
before anything.

[1] https://mail.gnu.org/archive/html/qemu-devel/2025-02/msg01637.html
[2] https://mail.gnu.org/archive/html/qemu-devel/2025-02/msg04209.html

> > > I've tried to flush within an unrealized function but it didn't work.
> > > Any suggestions ?
> >
> > FTR, I still have found a solution here using
> > qemu_register_shutdown_notifier. Though I'm wondering if this is
> > useful: the cases where a shutdown occurs between two "fifo_update"
> > seems really narrow, but they could happen.
>
> What does the actual hardware do? I don't think it has a shutdown
> notifier. I think this is up to the guest to flush the UART.

I don't have access to real hardware. But the reference manual doesn't
mention any shutdown notifier. So I think you're right.

> >  @Philippe Mathieu-Daud=C3=A9 AFAICT, the new pl011 and other char devi=
ces
> > implementing write fifo have the same issue. Thus, pinging you here to
> > get your advice.
> >
> > Thanks,
> > Cl=C3=A9ment
> >
> > > >  static void sifive_uart_reset_enter(Object *obj, ResetType type)
> > > >  {
> > > > ...
> > > > +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
> > >
> > > I'm also wondering if that part could not lead to memory leak.
> > > `fifo8_destroy` is never called and AFAIK, there are ways to reset a
> > > device dynamically (e.g snapshot, though not sure if it's supported
> > > here).
>
> Good catch, I can send a patch to fix this
>
> Alistair
>
> > >
> > > Thanks, Cl=C3=A9ment

