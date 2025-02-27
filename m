Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B1C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfe7-0005aL-N7; Thu, 27 Feb 2025 10:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnfe5-0005T6-BR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:17:54 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnfe3-00072L-IF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:17:53 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso742353276.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740669470; x=1741274270; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCNOXy199FhXHMWM/2yxrJDCJEORr4pnLCkiOhqKb5M=;
 b=Jprxz0d7bgTbAenZCDV+ekwznfrj7GQ/uC7KVFdtaE5gKR/Yl/GiDCJ/NtCgxLFT0P
 dTNSU0sO4pZ39HhPtoSDMqJYxgdRZNhzZ5tGXOeGTqPUNEVYt4d3S41cjL3zqB35PnwK
 fjX6JUdojlfEVSkS9zogYIwFkuvPCRDCGeU1mFrndkr9tYurBuvhn8YYBYwD8SKNSP1h
 1jsvzrXZl+6NpL+JWthRk4h2yOG/NgHUgkHklvZd40e9cmJ8o1c+xTb6saUY0GhqUHb3
 4rHRa77tC8/eZgM4TMCmEVW+bRWxBNyZKSJ+uS7NgQq/moOo6W5HBXeY9tvaLioZc3jC
 ZbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740669470; x=1741274270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCNOXy199FhXHMWM/2yxrJDCJEORr4pnLCkiOhqKb5M=;
 b=fAyTbRNiYJLDnTzBMipKqefVjJ/kfESJc981tGq9Dq6Znj7XyyyK8MF3I7a2gx3Ovu
 oAuFTfSsPJlzXR1qUqoC8F4iTshTOSUeJ4DVo1R8JzgCJf5fi3xOzN3/yqN9QQYYyNjV
 Xwvv6qKSFC8xYxvCAiwGfCgQVLnO+B96CaP6t/0JIZN65LwXxrRlSocm0QSty6SDREaK
 tzh31ICQ7ySgZENHw6GG6RkuD7mnuK0EvBbrjmtqoQvn1doP4+E0NjgLtvOtRtPnTy19
 hTAzc+oSDmrfCG4/qDiyLC4i0TO1JjwDeBXRFTqrbsrzLa5odel5ZbnrWfz8aJLtZSq+
 TzMw==
X-Gm-Message-State: AOJu0Yy2H4zxPA9CFkHyPhfQX6lSpVuQqFYwe+rClVXfdtiNXJgiar9n
 uDRjBLgJbBuyrnwDWbDTsG4aolQokDQSYMbcdRlCsafOXHNUfgyKdb3Z9WPm+VQLv9ZMJTzzRvA
 FOoGbE/00c9PY1yRiGwLLSuFenSPn9dWaa4lszg==
X-Gm-Gg: ASbGncv1Ty75IikjcWmfP3lj1bB7vFybSa/OzQzTY5F+FQ742vCjvyJdGxipbojlKJI
 vzDc6a6Ii4TBnWOXQ7lleYTTnRdIF+Q+F0wdnUZfepvh63lF6HRX2MqpmvTBEO6HVB3VigWqTky
 F5OPG8irkB
X-Google-Smtp-Source: AGHT+IFaKXoe6HfBSvHUn+1nf/LPNvBFvhCy7ojq/wm/Vkj0aIj7mKJWhJajTDQsI+cZBPq4iPGWmH/yr2Ia8rGCHLk=
X-Received: by 2002:a05:6902:708:b0:e60:a525:264e with SMTP id
 3f1490d57ef6-e60a5252d60mr2768269276.43.1740669470074; Thu, 27 Feb 2025
 07:17:50 -0800 (PST)
MIME-Version: 1.0
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
 <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
In-Reply-To: <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 15:17:37 +0000
X-Gm-Features: AQ5f1Jofy-N_7pw4vI_CvfZeM5uZwIFAlKkw3eflyH-Tod0AOeIM5rkUn0f-1k4
Message-ID: <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Thu, 27 Feb 2025 at 09:15, Sourojeet Adhikari
<s23adhik@csclub.uwaterloo.ca> wrote:
> > The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
> > being wired up in the function bcm_soc_peripherals_common_realize()
> > in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
> > interrupt controller), and it isn't valid to wire one input
> > directly to multiple outputs.
> >
> > In fact it looks like we are currently getting this wrong for
> > all of the interrupts that need to be wired to both the
> > "legacy interrupt controller" and the GIC. I think at the moment
> > what happens is that the wiring to the GIC will happen last
> > and this overrides the earlier wiring to the legacy interrupt
> > controller, so code using the latter won't work correctly.

> I'll try reading through the relevant sections and send an
> updated patch later next week. From what I can tell it falls
> under the bcm2835_pheripherals.c file, right?

Yes. To expand a bit, QEMU's qemu_irq abstraction must
always be wired exactly 1-to-1, from a single output to
a single input. Wiring either one input to multiple outputs
or one output to multiple inputs will not behave correctly
(and unfortunately we don't have an easy way to assert()
if code in QEMU gets this wrong).

So for cases where you want the one-to-many behaviour you need
to create an object of TYPE_SPLIT_IRQ. This has one input and
multiple outputs, so you can connect your wire from device A's
output to the splitter's input, and then connect outputs
from the splitter to devices B, C, etc. (In this case A
would be the timer, and B, C the two interrupt controllers.)
Searching the source code for TYPE_SPLIT_IRQ will give some
places where it's used. (Ignore the qdev_new(TYPE_SPLIT_IRQ)
ones, those are a code pattern we use in board models, not
in SoC device models.)

In this specific bcm2838 case, it's a little more awkward,
because one of the two interrupt controllers is created inside
bcm2835_peripherals.c and one of them is created outside it.
Since bcm2838 is already reaching inside the bcm2835_peripherals
object I guess the simplest thing is:
 * create a splitter object in bcm2835_peripherals.c for
   every IRQ line that needs to be connected to both
   interrupt controllers (probably easiest to have an array
   of splitter objects, irq_splitter[])
 * in bcm2835_peripherals.c, connect the device's outbound
   IRQ to the input of the appropriate splitter, and
   connect output 0 of that splitter to the BCM2835_IC
   correct interrupt controller input
 * in bcm2838.c, connect output 0 of ps_base->irq_splitter[n]
   to the correct GIC input

(This is kind of breaking the abstraction layer that ideally
exists where the code that creates and uses a device doesn't
try to look "inside" it at any subparts it might have. We
could, for instance, instead make the bcm2835_peripherals
object expose its own qemu_irq outputs which were the second
outputs of the splitters, so that the bcm2838.c code wasn't
looking inside and finding the splitters directly. But I
think that's more awkward than it's worth. It's also possible
that we have the split between the main SoC and the
peripheral object wrong and either both interrupt controllers
or neither should be inside the peripheral object; but
reshuffling things like that would be a lot of work too.)

(PS: for the other "not 1:1" case, where you want to connect
many qemu_irqs outputs together into one input, the usual semantics
you want is to logically-OR the interrupt lines together, and
so you use TYPE_OR_IRQ for that.)

thanks
-- PMM

