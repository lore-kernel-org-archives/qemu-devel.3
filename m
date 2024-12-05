Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C72E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDLE-0002w7-7N; Thu, 05 Dec 2024 10:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.fatoum@pengutronix.de>)
 id 1tJDLA-0002v8-Br
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:00:28 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.fatoum@pengutronix.de>)
 id 1tJDL6-00011W-Eh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:00:28 -0500
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tJDL0-0000tU-B5; Thu, 05 Dec 2024 16:00:18 +0100
Message-ID: <b020f8b2-f485-4658-bcfb-f24df5f910d4@pengutronix.de>
Date: Thu, 5 Dec 2024 16:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jia Liu <proljc@gmail.com>
References: <20241203111513.402641-1-shorne@gmail.com>
 <20241203111513.402641-2-shorne@gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241203111513.402641-2-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=a.fatoum@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Stafford,

On 03.12.24 12:15, Stafford Horne wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
> 
> Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> [stafford: Change to serial0 alias and update change message, reverse
>  uart registration order]

Thanks a lot for your subsequent iterations on the patch.
The changes look good to me.

Thanks,
Ahmad

> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 9fb63515ef..42f002985b 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>      void *fdt = state->fdt;
>      char *nodename;
>      qemu_irq serial_irq;
> -    char alias[sizeof("uart0")];
> +    char alias[sizeof("serial0")];
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
>  
> @@ -326,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
>                                  smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
>      }
>  
> -    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
> +    /*
> +     * We create the UART nodes starting with the highest address and
> +     * working downwards, because in QEMU the DTB nodes end up in the
> +     * DTB in reverse order of creation. Correctly-written guest software
> +     * will not care about the node order (it will look at stdout-path
> +     * or the alias nodes), but for the benefit of guest software which
> +     * just looks for the first UART node in the DTB, make sure the
> +     * lowest-address UART (which is QEMU's first serial port) appears
> +     * first in the DTB.
> +     */
> +    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
>          openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
>                                          or1ksim_memmap[OR1KSIM_UART].size * n,
>                                   or1ksim_memmap[OR1KSIM_UART].size,
>                                   smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
> +    }
>  
>      load_addr = openrisc_load_kernel(ram_size, kernel_filename,
>                                       &boot_info.bootstrap_pc);


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

