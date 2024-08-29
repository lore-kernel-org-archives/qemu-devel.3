Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D4C83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhGf-0005Vg-9u; Thu, 29 Aug 2024 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sjhGe-0005VC-6A
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:41:00 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sjhGa-0001H5-Qj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:40:59 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so1079690a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724946055; x=1725550855; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ERbFzOwVPlGwpXVkv2XYWXs4JWWracOiCiXw9VVI8gg=;
 b=ai+z4go6omzR0A+Xpp8RMxuSe3afjUSfM9jo8jitEZk19kClwZV5r4uWas+rIbRUkY
 tS7XTTvUPM2SJFfPvGoy7mG7eT1aVZaaYJTU3FD8BAo3Il2/QeNPuLILE4Wwx9dZNTIC
 FVYowlvdX49/oGmbQMENhIdmnxK5rDhYbL2qRVWS7OdE/QAZb5p6l1FY3dZ6ppXy0E6w
 yXY7a5MwWZQMzTDcx88NbA3oLw5xQfPfdkvECsrXAXlAmkXIegPZ0BSY9v0UvDmWSE4Z
 GPX7o6IFqtPyriphjsod5ODwcIwA8CuhA1FOef4usCTU0SZWfhwi75RqLhE160cMLVov
 //MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724946055; x=1725550855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERbFzOwVPlGwpXVkv2XYWXs4JWWracOiCiXw9VVI8gg=;
 b=iRebPioau9BlXWt4O24epXuWmbaZlJbIzO2GZIV2/qPJRkjxh3lvGi46tYU98vdtYF
 wkIC008iloMh/gkxZkxhd8UvxnIvzRjDLVa3QhL8dfc0nU4Yabube+OZWIqATpd1lwud
 hE6HseBALwaoeSe4ZAJaB4L/ldmRO3hgtvXQfUS8BgprxvwHFzo/ONmtBqr2JXovOj7i
 7KjwjQYlq1ZQVDja7F+y5rCKsDLx6PHt3LNP+46cA+MzuyLHlXRJ6f40bQU5CHKZ0YEH
 LQ0Gp6K3Ws3zqsmDbiG0QP6b9QpdAvx2ig7HPykZUc815eAi4UCXbYkwd1kR3jA5bofB
 DMWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqtAp418pAvTwC3ej5T4CnerXsnFpR3sb/XmnfPMzPvo2U2XG9bYkbpFTmoF+12hKWmxjOhgbW5vwp@nongnu.org
X-Gm-Message-State: AOJu0YztLN9Fs4WFN3LqW79Zqk3Ey39ouu/OpKZ+YfIqCHUHifnVUUaB
 R5U3r3RTbEkgLix4a70VJbttNQdhGpuhhyedJImwmpv+TRW6Kjjq
X-Google-Smtp-Source: AGHT+IHXWUl93EzdzAUbMUJfW464wG9ArFmqcJl0AGwHaswWIB5XtR5xZoh8agZ8gjePnVcEXVw8Tg==
X-Received: by 2002:a17:907:7f1f:b0:a86:a090:5caa with SMTP id
 a640c23a62f3a-a897f8e2be2mr297923666b.34.1724946054498; 
 Thu, 29 Aug 2024 08:40:54 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891d6f7bsm91974566b.157.2024.08.29.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 08:40:53 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:40:52 +0100
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-devel@nongnu.org,
 linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZtCWhGD8vIv1e88a@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec> <ZssWudpcVotQWr45@zx2c4.com>
 <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
 <Zs4grgFlhYFMjO4j@antec>
 <CAFEAcA-ty1FDvjK+p+CtYVQcWVzgrNTW4jcamWFEbYgHkgXLuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ty1FDvjK+p+CtYVQcWVzgrNTW4jcamWFEbYgHkgXLuA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shorne@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Aug 28, 2024 at 04:38:49PM +0100, Peter Maydell wrote:
> On Tue, 27 Aug 2024 at 19:53, Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Sun, Aug 25, 2024 at 03:09:20PM +0100, Peter Maydell wrote:
> > > On Sun, 25 Aug 2024 at 12:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> > > > > Also, I will wait to see if Jason has anything to say.
> > > >
> > > > So long as this doesn't change the assignment of the serial ports to
> > > > device nodes in Linux, I don't think this should interfere with much.
> > > > You might want to try it, though.
> > >
> > > It looks like this board already creates the fdt /aliases/
> > > node and puts uart0, uart1, etc, so that part should be OK.
> > >
> > > However I notice that the openrisc_sim_serial_init() code
> > > will always set the /chosen/stdout-path, so this means
> > > (unless I'm misreading the code -- I haven't tested) that
> > > the last UART we create will be the stdout-path one. Before
> > > this patch, that would be serial_hd(0), but after this it
> > > will not be. So I think we probably need to fix this too
> > > in the same patch, so that we only set stdout-path for uart0,
> > > rather than setting it and then overwriting it on all the
> > > subsequent calls. This patch on its own will change the
> > > stdout-path value I think.
> >
> > Hi Peter,
> >
> > I suspected the same and tested the theory.  Now when running linux with
> > or1k-sim machine we get no stdout output from qemu.  Upon debugging and
> > looking at dmesg via gdb I can see the wrong uart is getting setup in
> > Linux:
> >
> >     [    0.080000] workingset: timestamp_bits=30 max_order=17 bucket_order=0
> >     [    0.100000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >     [    0.110000] printk: legacy console [ttyS0] disabled
> >     [    0.110000] 90000300.serial: ttyS0 at MMIO 0x90000300 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.120000] printk: legacy console [ttyS0] enabled
> >     [    0.120000] 90000200.serial: ttyS1 at MMIO 0x90000200 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.130000] 90000100.serial: ttyS2 at MMIO 0x90000100 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.130000] 90000000.serial: ttyS3 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.150000] NET: Registered PF_PACKET protocol family
> >     [    0.160000] clk: Disabling unused clocks
> 
> Interesting, that seems to have assigned ttyS0/1/2/3 in the
> reverse order, which suggests it might be ignoring the /aliases/
> nodes entirely? Though that would surprise me, so perhaps
> something else is going on.

This got me thinking, the /aliases/ defined in OpenRISC are "uart0", "uart1"...
this is different than almost everything else which use "serial0", "serial1"...
I don't know why OpenRISC chose to use "uart0" and I think this is an issue.

I tried the patch below.

After switching to the more standard "serial0", ... everything is working well.

It seems only one driver uses device tree alias stem (prefix) "uart" and that is
drivers/tty/serial/bcm63xx_uart.c.  Which we have no intention of supporting.

All other drivers look for aliases using the serial prefix via call:

  of_alias_get_id(np, "serial");.

> For the Arm virt board we ended up taking a conservative
> approach of making sure the UARTs were listed in the dtb
> in the exact same order we'd traditionally done it, for
> the benefit of any guests which didn't honour /aliases/
> or /chosen/stdout-path. But we were thinking more about
> that being old firmware rather than the kernel.

In this case only the openrisc_sim board has been setup with multiple
UARTs.  I think making sure the first/qemu default serial device
stays the same is the most important for this point, which the original patch
fixes.

-Stafford

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bffd6f721f..2a15a3a4f0 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("uart0")];
+    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   serial_hd(uart_idx),
                    DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
@@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
     qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
 
-    /* The /chosen node is created during fdt creation. */
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    if (uart_idx == 0) {
+        /* The /chosen node is created during fdt creation. */
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    }
+    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
+
     g_free(nodename);
 }
 

