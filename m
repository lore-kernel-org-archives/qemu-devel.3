Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0131FD78308
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI44c-0000oD-El; Mon, 02 Dec 2024 05:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI44L-0000ld-D7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:54:22 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI44H-0001Rq-Nr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:54:19 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso2621653a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733136854; x=1733741654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4rGCcL4wb7banKis5dRQXKaHohM5FKHfH+AgESSX7o=;
 b=VABrjjQZ4IcsYrdc6SQtVD9R/meV8/Kcww3o/UQBYyP2mcYPutgc8F5eFKOdR+xtAA
 MeoTWV90WkahV2STk0/g+81jAHT9PvzMu8wl5cmxs11TGumqlpEneBPkYlz9SzJvcBmj
 exfh870c+Kr0B7WtR+0b1VimJgvimARhKN6B+nhggFVZEb0T3BfUaDT1gjAZu66EgjH/
 ck27Ox0SV4LdU8WLd08tRLQJ0kd6YljEDY5SJqu4Aia2tfSRVjcaVP04lH/2McbiaMeD
 EL6A4usdKL7WJhQCwxzFRuINfF30l/96LAkHDGOoewhD1v1DTAaTFZYd8waKSJMGzniZ
 IQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733136854; x=1733741654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4rGCcL4wb7banKis5dRQXKaHohM5FKHfH+AgESSX7o=;
 b=JMw3qe8wYvJk0YnQfa6SPwOypyvdPCrILxRvGL3rw7Ot6OC8zybM/6hjvM/inpiWay
 0X7/64jJOzKZ4T6PUO6RbgmN+BiVMQKomAmGNHvgTl9bSNJaeiFMxf0bnTOmwBqY1FYg
 0kRYhAV8JiBRdmG1NyIhsaXJ1q+EHdozoK9jqn+ZhWbfky4dGDwBrpVgPbW5wYTD/Dqf
 dHWqwwEaIz9USM7C4LaVvXI1RYumvSxEVogrX4KltDV1ltBpkMZOUL5W28MIDTVLqzW4
 Wd6m5uoXD+iMULJgJg90p50XW+Fud/0CmkbMQxeizuoWR9vNwk74U1oLGhAv3rBsn+0Q
 Kw5A==
X-Gm-Message-State: AOJu0YzlDs2aCoYGFLJJxrvCF1n0rpcrFSNW3PZk/T/gXavwl31ZDeAQ
 fDV1A9dZcnz98YbsqT1psX3Wbh/Q6SW2JBB4Po5uWoQ1AsQI3RVLU8gibkxYP4L49tATrdnrmVw
 g/Qf88DF0boG924HO4bRu6HUHSS9pihZ+491QR31pqa+ipaqV
X-Gm-Gg: ASbGncsIWXA1QBXrq8bpmq+Bkt2C5M/abh8Y3a/tnDpQxxvgHOVazz8Knhjrt2DmSzT
 +lLfB2eVc559MMD8hhmuJNp/NEE1codo6
X-Google-Smtp-Source: AGHT+IHOQTQlX2VVbm1FVz9qvLuCkJ+8/vvOClj9N4Gd9gK1ELNl4hxH7Asz5LtxfouMNkWySewp+oYU//kvTc4d9DI=
X-Received: by 2002:a05:6402:501c:b0:5d0:ef55:8451 with SMTP id
 4fb4d7f45d1cf-5d0ef558c5fmr2873842a12.8.1733136853852; Mon, 02 Dec 2024
 02:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-2-shorne@gmail.com>
 <CAFEAcA8SS6oBrNJzByghx8qc3QiZXQs2aM3xnqk0dtswij3i1A@mail.gmail.com>
 <Z0wF1xH1NYDDdxY4@antec> <Z0wI4O1woOmkgZrK@antec>
In-Reply-To: <Z0wI4O1woOmkgZrK@antec>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 10:54:03 +0000
Message-ID: <CAFEAcA-Fz7p=JJTpk6Z_Lbyf0+uA5LV1xDeZNEok3NV9NB+g_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Jia Liu <proljc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 1 Dec 2024 at 06:57, Stafford Horne <shorne@gmail.com> wrote:
>
> On Sun, Dec 01, 2024 at 06:44:39AM +0000, Stafford Horne wrote:
> > On Mon, Nov 25, 2024 at 02:02:35PM +0000, Peter Maydell wrote:
> > > On Sat, 23 Nov 2024 at 10:39, Stafford Horne <shorne@gmail.com> wrote:
> > > >
> > > > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > >
> > > > We used to only have a single UART on the platform and it was located at
> > > > address 0x90000000. When the number of UARTs was increased to 4, the
> > > > first UART remained at it's location, but instead of being the first one
> > > > to be registered, it became the last.
> > > >
> > > > This caused QEMU to pick 0x90000300 as the default UART, which broke
> > > > software that hardcoded the address of 0x90000000 and expected it's
> > > > output to be visible when the user configured only a single console.
> > > >
> > > > This caused regressions[1] in the barebox test suite when updating to a
> > > > newer QEMU. As there seems to be no good reason to register the UARTs in
> > > > inverse order, let's register them by ascending address, so existing
> > > > software can remain oblivious to the additional UART ports.
> > > >
> > > > Changing the order of uart registration alone breaks Linux which
> > > > was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
> > > > Linux we fix two things in the device tree:
> > > >
> > > >  1. Define stdout-path only one time for the first registerd UART
> > >
> > > "registered"
> >
> > OK
> >
> > > >     instead of incorrectly defining for each UART.
> > > >  2. Change the UART alias name from 'uart0' to 'serial0' as almost all
> > > >     Linux tty drivers look for an alias starting with "serial".
> > >
> > > I would recommend for maximum backwards compatibility also changing
> > > one other thing. With this patch, the UARTs are listed in the
> > > device tree starting with the one with the highest address and
> > > working down. You can see this if you run
> > >  qemu-system-or1k -M or1k-sim -machine dumpdtb=or1k.dtb -kernel /dev/null
> > > and then
> > >  dtc -I dtb -O dts /or1k.dtb |less
> > > -- the output shows that "serial@90000300" is first.
> > >
> > > This happens because (due to an implementation quirk that I forget
> > > the details of) nodes we add to the DTB in QEMU end up being listed
> > > in reverse order of creation. I would recommend making the
> > > UART-creation loop in openrisc_sim_init() run backwards rather
> > > than forwards, so that the nodes end up in the DTB in ascending order.
> > >
> > > This should not affect any guests that do the "right thing" for
> > > finding their UART, i.e. look at stdout-path or at the UART alias
> > > nodes; but for Arm we found that at least some guest code had been
> > > written to just find the first UART node in the dtb and use that.
> > >
> > > (I suspect, incidentally, that this is the reason why 777784bda468
> > > was using "serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1)" -- it was
> > > trying to fix this but didn't quite put the change in the right place.)
> > >
> > > That would correspond to squashing in this change on top of your patch:
> > >
> > > --- a/hw/openrisc/openrisc_sim.c
> > > +++ b/hw/openrisc/openrisc_sim.c
> > > @@ -329,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
> > >                                  smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
> > >      }
> > >
> > > -    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
> > > +    /*
> > > +     * We create the UART nodes starting with the highest address and
> > > +     * working downwards, because in QEMU the DTB nodes end up in the
> > > +     * DTB in reverse order of creation. Correctly-written guest software
> > > +     * will not care about the node order (it will look at stdout-path
> > > +     * or the alias nodes), but for the benefit of guest software which
> > > +     * just looks for the first UART node in the DTB, make sure the
> > > +     * lowest-address UART (which is QEMU's first serial port) appears
> > > +     * first in the DTB.
> > > +     */
> > > +    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
> > >          openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
> > >                                          or1ksim_memmap[OR1KSIM_UART].size * n,
> > >                                   or1ksim_memmap[OR1KSIM_UART].size,
> > >                                   smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
> > > +    }
> > >
> > >      load_addr = openrisc_load_kernel(ram_size, kernel_filename,
> > >                                       &boot_info.bootstrap_pc);
> >
> > OK it makes sense, I will add this as well.
>
> Hi Peter,
>
> One comment on this, in the commit message from Ahmad he says.  The registration
> order... ''This caused QEMU to pick 0x90000300 as the default UART,''

The thing that made QEMU pick 0x90000300 as the first serial
terminal is that the current code
 (1) loops through calling openrisc_sim_serial_init() starting
     lowest address first and
 (2) calls "serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1)"
     to get the QEMU chardev.

If you do that then the uart that gets serial_hd(0) is 0x90000300.
This is completely unrelated to the order of nodes in the dtb,
or to any logic that the guest uses to select a UART: it's what
means that if the user only passes one "-serial foo" that's the
UART they're configuring. It happens that if the guest code
is doing the "pick the first node in the DTB" then the current
code will give them the UART that QEMU thinks of as the "first"
serial port. But if the guest code is doing any of a bunch of
other reasonable things then it will pick a UART that isn't what
QEMU is currently calling the "first" serial port.

 We want all of these to be true:
 * serial_hd(0) is the lowest-address UART
 * serial_hd(0) is listed first in the DTB
 * serial_hd(0) is the /chosen/stdout-path one
 * the /aliases/serial0 alias points at serial_hd(0)
   (and then up in ascending order for serial1, etc)

(I would probably reword the commit message a bit to make it
clear that this is what we're trying to achieve and what we
think the commit does.)

thanks
-- PMM

