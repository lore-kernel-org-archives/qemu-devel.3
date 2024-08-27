Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E0EC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1K3-0001cI-Hp; Tue, 27 Aug 2024 14:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sj1K0-0001bh-Qh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:53:41 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sj1Jy-00087A-PB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:53:40 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-533463f6b16so6788705e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724784816; x=1725389616; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XlGOOKlpGr0zcAZ85kZ2W9UjC2P7TBXL1oy1T6ZrQr0=;
 b=ey+d+mKkQKwHYRmdi5OW1jFR2hlV5N0q5aw590vjvyolPqOV48ClI8sIq7NSbamJlu
 U7XwUkt84gmkZd3ZFMIBbSRr/ay7bq8S24/+KgI8OAAESu7fvHNmrB/MMaGJNeInG10I
 0/PR9SAYZA6FDMLdL2cd8rhN1ypUcxYmNXxYHw0NOPHV/mw9oz6ZCZUNH9Dio6KJo5fu
 ZScxAz98N6miGKnR3kLEWuwEwVNT6Zptxd3apuS8hq6axeuvd9+YuBjXNtl8HudUURBx
 NMqkjkJ46MP3vFFFVTYQPSm129+YZrVJ+W/cSchT5yqJ6DPTomoTEz7vVPiweJEfmaAZ
 rTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784816; x=1725389616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlGOOKlpGr0zcAZ85kZ2W9UjC2P7TBXL1oy1T6ZrQr0=;
 b=sG0onGLdm0Fo+EEt6f6hdcBKel0OzJCvBEulDPBkHVkNDJ+E+aTNp4mFOhqyT6lpaa
 7Nm1KZK5QxYF+cNThwo77iVV1Vafibk9vuNR6NkMmROUf392YdyguHP8sP0nQsYBMovJ
 Jtpg1KKvTEXSvz3n867RYcmFJ5E2JaklJC0DcssZsvWIDrmr++hFcMIWKaA+REemymzE
 wWxIa2xqZ6o32xuzPIjB234B7Tlyos8vIK6dtj6DsYabufhm7luryTKCVpIW2c5ibt+e
 KpajLUZ1sVtESAD8xel5MoWTEb4x5721EuUE6XNsgTJJcSIywA2+Ug79yjRl9qMLM7oE
 45tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXm/92VmxDVPfExb6qVev6QpaWWvxr36c+wAzDl7u8GGKm5TE9aWt7JUKgs9jOs0pYhNJP7+15NCD@nongnu.org
X-Gm-Message-State: AOJu0Yz1iSgdpH7io9KZr3MDqoh4LUJHMuR6IapFqB6uPBqp6aJ5VOPV
 10aUL75u7K+29ueoeTUvzODg+l+iJiH6fBRDyYYtuZgbB+OGxZk/
X-Google-Smtp-Source: AGHT+IEMJc2wzqoIaGEVksv/lMRKmW2/RHlMd5xPg04sWyNcnMP1T/oS1NyPXJpeKH/nhRxRuVA6UA==
X-Received: by 2002:a05:6512:6c8:b0:52c:80f6:d384 with SMTP id
 2adb3069b0e04-5343876c64emr10300788e87.3.1724784816060; 
 Tue, 27 Aug 2024 11:53:36 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb21109esm1299720a12.49.2024.08.27.11.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:53:35 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:53:34 +0100
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-devel@nongnu.org,
 openrisc@lists.librecores.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <Zs4grgFlhYFMjO4j@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec> <ZssWudpcVotQWr45@zx2c4.com>
 <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shorne@gmail.com; helo=mail-lf1-x12e.google.com
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

On Sun, Aug 25, 2024 at 03:09:20PM +0100, Peter Maydell wrote:
> On Sun, 25 Aug 2024 at 12:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> > > Also, I will wait to see if Jason has anything to say.
> >
> > So long as this doesn't change the assignment of the serial ports to
> > device nodes in Linux, I don't think this should interfere with much.
> > You might want to try it, though.
> 
> It looks like this board already creates the fdt /aliases/
> node and puts uart0, uart1, etc, so that part should be OK.
> 
> However I notice that the openrisc_sim_serial_init() code
> will always set the /chosen/stdout-path, so this means
> (unless I'm misreading the code -- I haven't tested) that
> the last UART we create will be the stdout-path one. Before
> this patch, that would be serial_hd(0), but after this it
> will not be. So I think we probably need to fix this too
> in the same patch, so that we only set stdout-path for uart0,
> rather than setting it and then overwriting it on all the
> subsequent calls. This patch on its own will change the
> stdout-path value I think.

Hi Peter,

I suspected the same and tested the theory.  Now when running linux with
or1k-sim machine we get no stdout output from qemu.  Upon debugging and
looking at dmesg via gdb I can see the wrong uart is getting setup in
Linux:

    [    0.080000] workingset: timestamp_bits=30 max_order=17 bucket_order=0
    [    0.100000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
    [    0.110000] printk: legacy console [ttyS0] disabled
    [    0.110000] 90000300.serial: ttyS0 at MMIO 0x90000300 (irq = 2, base_baud = 1250000) is a 16550A
    [    0.120000] printk: legacy console [ttyS0] enabled
    [    0.120000] 90000200.serial: ttyS1 at MMIO 0x90000200 (irq = 2, base_baud = 1250000) is a 16550A
    [    0.130000] 90000100.serial: ttyS2 at MMIO 0x90000100 (irq = 2, base_baud = 1250000) is a 16550A
    [    0.130000] 90000000.serial: ttyS3 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
    [    0.150000] NET: Registered PF_PACKET protocol family
    [    0.160000] clk: Disabling unused clocks

I will amend the patch.

-Stafford

