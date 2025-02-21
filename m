Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BEC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUvo-0003Qo-Po; Fri, 21 Feb 2025 10:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tlUvn-0003Qe-U1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:27:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tlUvm-0006QW-1t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:27:11 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5ded69e6134so3729327a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1740151626; x=1740756426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCfzdZFAis7iwYHQxA39AZr4EzGKFzC029C6zErowuI=;
 b=ZrWP70HwNiZ0n8qVzCcN0dGJtu+PxGCXhPwDU22Nkf7mhZbm9RoAGOxC3J0MuI4h55
 j95z94GfTXjOoixcJqiggqXY/26TateXagw0234WIvNV77jegdjNqR2qZ53t6wY80wbe
 xfV9e1HGd9pTDT1rjb1Enkl3NjJzqGhZSIN0p1fYioUNh1USqOjpnf6ina/0KNQ5zTBM
 0u03BJCcbe8l+ncRWy6Q5bgkfQeukVMw41QJA3H+INGslX9zyScudHL+iTZJMClYEPLq
 vF2zaCMHUacl6FwBk8ArvtFBtw7otylikuhgYsE6XxVY3kybW6zCoCcapsO6RRkjKYDS
 eYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740151626; x=1740756426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCfzdZFAis7iwYHQxA39AZr4EzGKFzC029C6zErowuI=;
 b=CV4qzfa0Wx1s5U1WdlcTKoXNXABbXOr7i1PwxP8ZPydHwKQZLugr/VFNVieKpWsIuq
 xki+oUsD1MnO4u/g/GyA+IlZk40rCpEbNmZI9zLKClEHzIFaVKMO6kX5RhssY/ZVrSCC
 qum/TeHZUqwaTPRjlf0wteOsPzJKDlO5DMLOdWpKBklEbcVp3G9y6p5TYCy7kJIoMdWq
 JtdOg/GtAn+O56vrt23vRT+QAE5LhKjGyX0PDd0CMfXGLkIQUCKYj03lylgTZwG6FFFi
 KWaUsm3bD0AFh0QWfdMvnnPPeFEg9cmHc+3NHC64DbIUYO9XBsjrqTMhmZdDnvQbt52S
 XOVg==
X-Gm-Message-State: AOJu0YzG7Zi10Z11sn6aMvHnLx22yaSgJOm8lPR8TdX5OuKKiUgsFt17
 hsqJgcIqYu/+ugfzpAXKFg9+Uy+uCqMwnDzLeDLMNu4oM3D3IznlIBVqCcIOSJ0h2dPeDBZW7Fx
 xoTUv+55fy4EzQQjXtU0JZdQsjPYlowcgQGss
X-Gm-Gg: ASbGncsfcmVw1/XZJlzL1OT6SdyyW997A625npxNCKJGbWrZdWOubdMU41mAweXiybR
 Q6cDFhJDsmOKcAhbljjMTnPO62fv9t0VlXryngKRtcUM4/bKC3A2IEi3kVzfDS0By0UyEiQT9Z9
 vUv6dHcNVPLHAcrbf0v3Wj85Li1DcXJnk19Vnfv0b91w==
X-Google-Smtp-Source: AGHT+IEkIgp3gZCtjd9hFotKbtIFqRelIdsQ5wWnYuCw9/2IYiOmNWgLTvmRn7X5TB1fDU+UJA7NqrImBlYH6yF98ck=
X-Received: by 2002:a17:907:6095:b0:ab7:be66:792f with SMTP id
 a640c23a62f3a-abc09e563b5mr341669866b.49.1740151626302; Fri, 21 Feb 2025
 07:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-16-alistair.francis@wdc.com>
 <CAJ307EhFCpK8aO7r7PHF7H=k=f9tstPe=aVKrMWv1y7m3_HSNw@mail.gmail.com>
In-Reply-To: <CAJ307EhFCpK8aO7r7PHF7H=k=f9tstPe=aVKrMWv1y7m3_HSNw@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 21 Feb 2025 16:26:55 +0100
X-Gm-Features: AWEUYZmbmd2J65bTnfw9dR83HJikDvuyLc6sgpM1oF2F5fEWHlTdV8OQacnGybk
Message-ID: <CAJ307EhOKFyK3ULJ2NEj+zYcSbVQ1RxGcVj40_HFBbwt0UJL9g@mail.gmail.com>
Subject: Re: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52f.google.com
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

On Fri, Feb 14, 2025 at 1:52=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
>
> Hi Alistair,
>
> I've an issue following this patch. When the system is reset (e.g
> using HTIF syscalls), the fifo might not be empty and thus some
> characters are lost.
> I discovered it on a Windows host. But by extending
> "TX_INTERRUPT_TRIGGER_DELAY_NS" to a huge value, I'm able to reproduce
> on Linux as well.

The root cause of my issue was unrelated to these early shutdowns. On
Windows, the character device behind `-serial mon:stdio`
(char-win-stdio) doesn't provide an `add_watch` method. Therefore,
`qemu_chr_fe_add_watch` calls always result in an error, flushing the
fifo. I saw in @Philippe Mathieu-Daud=C3=A9 patch about pl011 that
`G_SOURCE_CONTINUE` is returned instead of calling it and it does
work. @Alistair Francis  do you remember if there was a reason for
calling `add_watch` ?

> I've tried to flush within an unrealized function but it didn't work.
> Any suggestions ?

FTR, I still have found a solution here using
qemu_register_shutdown_notifier. Though I'm wondering if this is
useful: the cases where a shutdown occurs between two "fifo_update"
seems really narrow, but they could happen.
 @Philippe Mathieu-Daud=C3=A9 AFAICT, the new pl011 and other char devices
implementing write fifo have the same issue. Thus, pinging you here to
get your advice.

Thanks,
Cl=C3=A9ment

> >  static void sifive_uart_reset_enter(Object *obj, ResetType type)
> >  {
> > ...
> > +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
>
> I'm also wondering if that part could not lead to memory leak.
> `fifo8_destroy` is never called and AFAIK, there are ways to reset a
> device dynamically (e.g snapshot, though not sure if it's supported
> here).
>
> Thanks, Cl=C3=A9ment

