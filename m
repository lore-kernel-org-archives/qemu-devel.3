Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB4C5B54A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKlI-0008Hl-1B; Wed, 28 Aug 2024 11:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKlG-0008Dx-FF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:39:06 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKlE-0006vT-8l
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:39:06 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bec87ececeso7569351a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724859542; x=1725464342; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hu0BLh+neH5Pct8LNO86hxf/vTX+WEQGyL6quhBbHNc=;
 b=fvKkQhyZCUFcT8iYD9V1RUl9+kisYduX6jeSD1nX8HnztvrQjPOVl/6vjt+txIZGtE
 fmJBJjyPlK/WzvqHqpAQ53yTI6i9zeB2zU7ogo5EdxDvSApq8RbTOuuBELUuJ8us0Vaw
 IKaSeehfRMeABkNcyZ2Z0CDE3heEDbDe+AQcY5tPRRvHIsHAmP4vWFnQIOAHWLjvrqDf
 dip9GuI2WRDCl/R51i6Wrtq0zxaLZTkh5FJQ585AXAGr9lTNHSI2vd4fPChheI88eiXR
 hoGwSfrSJHEWzCmpM4ihjNMu2YKOAkG4CrCvlSW/wmhjQ0r8B6SO+JVo6u3pCFjvnfRu
 UIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859542; x=1725464342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hu0BLh+neH5Pct8LNO86hxf/vTX+WEQGyL6quhBbHNc=;
 b=TonMiJJ3I61rJHvzEQtov4ZlRHP2qGRLb/05xE/rUuJ0SfO8x6lIM0vj+QyOX8VeS9
 SsXV3iH4ZEv21bUKUbyHE84/RL2pyWphE3ZFRo0UPIkdYvFXe8/j07BNO4QaOJYm4NVo
 uXH2d7Ug7X27+sWGGTkaFzYX/J39rAg79N61XrZJvE1ScRXfBeubag6C0a34Tm0+wVb/
 9iUn9eosCRRVuvcFEf6u6iKOJ+jcRse0whbrukCRa9OhOVFAfj9pTp6BewH31Dl3cKI0
 CwdZFs2yR2mEdMYEug1WnIO3ux44KHvQ62+nVDRdk2O6hzJS53kG8pqHjhqZ+60xFdpt
 lsvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KyBSGXkUz10OxN4p8SmguhkpBheaIUIFF3srGdAc1L/KtUnfvHaizqy7epdFUlTmwwlgQzhC7IUz@nongnu.org
X-Gm-Message-State: AOJu0Yytrsnm9MBQ5eJjOhFPiHREMODx9ICtBjK94P8V5W2X1epv3lkR
 9KJFN/IRApA5hKxdRR3XPY4KQgny0iIaIp2EACcwrNN4oE6TguxDztIndQzkSyckUsPLfnEHpou
 +t5d58AxeBEOd2CSNNgu1UoE1/xCG5Wo3wcgnWg==
X-Google-Smtp-Source: AGHT+IGp/KpMJ3grfOIzPsNHfERWr7HWw2GMpj0bfTUpWy6EQgHpGQBoLI+PpfCNX/I0d1jdz4QsPAu1U9TGzJF4mbA=
X-Received: by 2002:a05:6402:2690:b0:5be:eb4f:d4bd with SMTP id
 4fb4d7f45d1cf-5c2138e0f6amr2476908a12.7.1724859541761; Wed, 28 Aug 2024
 08:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec> <ZssWudpcVotQWr45@zx2c4.com>
 <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
 <Zs4grgFlhYFMjO4j@antec>
In-Reply-To: <Zs4grgFlhYFMjO4j@antec>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 16:38:49 +0100
Message-ID: <CAFEAcA-ty1FDvjK+p+CtYVQcWVzgrNTW4jcamWFEbYgHkgXLuA@mail.gmail.com>
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-devel@nongnu.org, 
 openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 at 19:53, Stafford Horne <shorne@gmail.com> wrote:
>
> On Sun, Aug 25, 2024 at 03:09:20PM +0100, Peter Maydell wrote:
> > On Sun, 25 Aug 2024 at 12:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> > > > Also, I will wait to see if Jason has anything to say.
> > >
> > > So long as this doesn't change the assignment of the serial ports to
> > > device nodes in Linux, I don't think this should interfere with much.
> > > You might want to try it, though.
> >
> > It looks like this board already creates the fdt /aliases/
> > node and puts uart0, uart1, etc, so that part should be OK.
> >
> > However I notice that the openrisc_sim_serial_init() code
> > will always set the /chosen/stdout-path, so this means
> > (unless I'm misreading the code -- I haven't tested) that
> > the last UART we create will be the stdout-path one. Before
> > this patch, that would be serial_hd(0), but after this it
> > will not be. So I think we probably need to fix this too
> > in the same patch, so that we only set stdout-path for uart0,
> > rather than setting it and then overwriting it on all the
> > subsequent calls. This patch on its own will change the
> > stdout-path value I think.
>
> Hi Peter,
>
> I suspected the same and tested the theory.  Now when running linux with
> or1k-sim machine we get no stdout output from qemu.  Upon debugging and
> looking at dmesg via gdb I can see the wrong uart is getting setup in
> Linux:
>
>     [    0.080000] workingset: timestamp_bits=30 max_order=17 bucket_order=0
>     [    0.100000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>     [    0.110000] printk: legacy console [ttyS0] disabled
>     [    0.110000] 90000300.serial: ttyS0 at MMIO 0x90000300 (irq = 2, base_baud = 1250000) is a 16550A
>     [    0.120000] printk: legacy console [ttyS0] enabled
>     [    0.120000] 90000200.serial: ttyS1 at MMIO 0x90000200 (irq = 2, base_baud = 1250000) is a 16550A
>     [    0.130000] 90000100.serial: ttyS2 at MMIO 0x90000100 (irq = 2, base_baud = 1250000) is a 16550A
>     [    0.130000] 90000000.serial: ttyS3 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
>     [    0.150000] NET: Registered PF_PACKET protocol family
>     [    0.160000] clk: Disabling unused clocks

Interesting, that seems to have assigned ttyS0/1/2/3 in the
reverse order, which suggests it might be ignoring the /aliases/
nodes entirely? Though that would surprise me, so perhaps
something else is going on.

For the Arm virt board we ended up taking a conservative
approach of making sure the UARTs were listed in the dtb
in the exact same order we'd traditionally done it, for
the benefit of any guests which didn't honour /aliases/
or /chosen/stdout-path. But we were thinking more about
that being old firmware rather than the kernel.

-- PMM

