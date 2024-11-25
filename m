Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A77D58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZg5-00009t-FL; Mon, 25 Nov 2024 09:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZg2-0008UR-5F
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:02:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZfz-0005h1-0l
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:02:57 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ceca0ec4e7so5590814a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543373; x=1733148173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vXvZj7uFwTR4IieYQbxReAn9oUm7CEEui6P4K+L+C9Y=;
 b=WU2DQ8kEZonCmNCggnqBVNpNK/HdBBlPdz4QH0tOPfZM/lL7kW0Jpr+79GSU5HoBR2
 K8uSZp4XelkjdZifjPSazB2gTKkzKY91eMThjtq25a3620xvZpIRdtQPzF9zedbFBUhJ
 iRcvdhSOdsDjjAObn1vKdJlgjVXSYUEVi2goZzcVffqpNeh6+vScKrYlpZxXmkqNSAzj
 shphw6hm58oBk5Ec3MEz1GEPPgZzuVVZBlsAIkhdn257NfL6SOy1XcACOBNDhD07BiZG
 6UhubN293sWD1DUyeHi13Ljag7AAk2O1P+7o+RbEvYLf1twSMjIbjn9Fmhfb/3GJP21n
 YMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543373; x=1733148173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXvZj7uFwTR4IieYQbxReAn9oUm7CEEui6P4K+L+C9Y=;
 b=J1QQT52PUG17qbC+BkoCsEIbUkpciEznI/JW8sQGdrsBuopjU5GLsRUzfgKKO4F1Cw
 IPREDUV8LpITYB3Q3/djxhmh+Aun4NlsQPTHvt5HqKiCCTi5CB8F6w/A9mSESU0vhTKC
 aGM5f7tPvoBZXPY0eNJLrEeKSR+cakqUjGvWAQeAxRrTHTDigHM7AojLlsIZLdRGhnak
 0h6ppzB3+FnXyjlvOWGF3M0P5YhhtEPb/RcGx/ApHMmBRr0iFWgRdW1YdBqwydJqpu/3
 v20ZvGzexWJmBorcIIRjAQduhaF52UiFC4gz4uAemN2iQxsEBogl7JbxqTm1/WXtyt8R
 lALg==
X-Gm-Message-State: AOJu0Yz9Zw5K9nUEK7lR6ICZPp2jJTMSaLqKK8T0ZDnHDYQDG1laCKL2
 XpEeh/PtvpSt2NGxi5bEXM8wtbZBFyAn17hOXXJ6eNIOgMHOIRwq9jX/FSOERnrSWHCmvHLcQTj
 PY0FX0i/7yHOeTPn5XUnXywuaiG9XW5Gv7iDe2A==
X-Gm-Gg: ASbGncu8CuZk+aAnX4jBU7JvsLtojW05z4Syef3Bb3Vyqccc+6ghHTohjpqVsTjYzBB
 TkWZhZ659TsI2onkeOd6c5wqKtFx5hXJD
X-Google-Smtp-Source: AGHT+IGDmT8kqkyoLTl8fW4vtmvYmJqh6gLgWxQaLkbTJLwBCVmJzywBW19CmXkvee4dR7Z2U8o83pRFz7jNhvyAX0g=
X-Received: by 2002:a05:6402:1e89:b0:5cf:dcd4:1277 with SMTP id
 4fb4d7f45d1cf-5d0205a7f3bmr13208075a12.7.1732543366363; Mon, 25 Nov 2024
 06:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-2-shorne@gmail.com>
In-Reply-To: <20241123103828.3157128-2-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 14:02:35 +0000
Message-ID: <CAFEAcA8SS6oBrNJzByghx8qc3QiZXQs2aM3xnqk0dtswij3i1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Jia Liu <proljc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sat, 23 Nov 2024 at 10:39, Stafford Horne <shorne@gmail.com> wrote:
>
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> We used to only have a single UART on the platform and it was located at
> address 0x90000000. When the number of UARTs was increased to 4, the
> first UART remained at it's location, but instead of being the first one
> to be registered, it became the last.
>
> This caused QEMU to pick 0x90000300 as the default UART, which broke
> software that hardcoded the address of 0x90000000 and expected it's
> output to be visible when the user configured only a single console.
>
> This caused regressions[1] in the barebox test suite when updating to a
> newer QEMU. As there seems to be no good reason to register the UARTs in
> inverse order, let's register them by ascending address, so existing
> software can remain oblivious to the additional UART ports.
>
> Changing the order of uart registration alone breaks Linux which
> was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
> Linux we fix two things in the device tree:
>
>  1. Define stdout-path only one time for the first registerd UART

"registered"

>     instead of incorrectly defining for each UART.
>  2. Change the UART alias name from 'uart0' to 'serial0' as almost all
>     Linux tty drivers look for an alias starting with "serial".

I would recommend for maximum backwards compatibility also changing
one other thing. With this patch, the UARTs are listed in the
device tree starting with the one with the highest address and
working down. You can see this if you run
 qemu-system-or1k -M or1k-sim -machine dumpdtb=or1k.dtb -kernel /dev/null
and then
 dtc -I dtb -O dts /or1k.dtb |less
-- the output shows that "serial@90000300" is first.

This happens because (due to an implementation quirk that I forget
the details of) nodes we add to the DTB in QEMU end up being listed
in reverse order of creation. I would recommend making the
UART-creation loop in openrisc_sim_init() run backwards rather
than forwards, so that the nodes end up in the DTB in ascending order.

This should not affect any guests that do the "right thing" for
finding their UART, i.e. look at stdout-path or at the UART alias
nodes; but for Arm we found that at least some guest code had been
written to just find the first UART node in the dtb and use that.

(I suspect, incidentally, that this is the reason why 777784bda468
was using "serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1)" -- it was
trying to fix this but didn't quite put the change in the right place.)

That would correspond to squashing in this change on top of your patch:

--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -329,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }

-    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
+    /*
+     * We create the UART nodes starting with the highest address and
+     * working downwards, because in QEMU the DTB nodes end up in the
+     * DTB in reverse order of creation. Correctly-written guest software
+     * will not care about the node order (it will look at stdout-path
+     * or the alias nodes), but for the benefit of guest software which
+     * just looks for the first UART node in the DTB, make sure the
+     * lowest-address UART (which is QEMU's first serial port) appears
+     * first in the DTB.
+     */
+    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
         openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
                                         or1ksim_memmap[OR1KSIM_UART].size * n,
                                  or1ksim_memmap[OR1KSIM_UART].size,
                                  smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
+    }

     load_addr = openrisc_load_kernel(ram_size, kernel_filename,
                                      &boot_info.bootstrap_pc);


> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
>
> Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> [stafford: Change to serial0 alias and update change message]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/openrisc_sim.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 9fb63515ef..5ec9172ccf 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>      void *fdt = state->fdt;
>      char *nodename;
>      qemu_irq serial_irq;
> -    char alias[sizeof("uart0")];
> +    char alias[sizeof("serial0")];

Using g_strdup_printf() (and a g_autofree pointer) is better than
a fixed-size array; but I guess we don't really need to clean
that up in this patch.

>      int i;
>
>      if (num_cpus > 1) {
> @@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>          serial_irq = get_cpu_irq(cpus, 0, irq_pin);
>      }
>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
> -                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
> +                   serial_hd(uart_idx),
>                     DEVICE_NATIVE_ENDIAN);
>
>      /* Add device tree node for serial. */
> @@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>      qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
>      qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
>
> -    /* The /chosen node is created during fdt creation. */
> -    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
> +    if (uart_idx == 0) {
> +        /* The /chosen node is created during fdt creation. */
> +        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> +    }
> +    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
>      qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
> +
>      g_free(nodename);
>  }

thanks
-- PMM

