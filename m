Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3DFCE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZym-0007uN-Gw; Fri, 06 Sep 2024 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smZyj-0007qA-74
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:30:25 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smZyh-0006kQ-JR
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:30:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 165195C59B2;
 Fri,  6 Sep 2024 14:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFAAC4CEC4;
 Fri,  6 Sep 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="PumYDTtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725633016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mchsogWORzO01+wcGnHKcfJHD2A8sOv1WvxNGnUmZQ=;
 b=PumYDTtmMYQf90W7o3xuPEZD8+i3AbCEZJnTqzJyf8poWy16YRHbzT/wTazDT9C9WyxR8k
 UCauxTRONP9JS0/1Dur1LGRjwMqx8zptoON40XCs+k6Todyuf85blK2iZi3AE0yebe5pOm
 J40uJmZoF0U2+WQ38MUbybrBRQjUbxE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db96013b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 6 Sep 2024 14:30:16 +0000 (UTC)
Date: Fri, 6 Sep 2024 16:30:14 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>
Cc: gaosong@loongson.cn, jiaxun.yang@flygoat.com, qemu-devel@nongnu.org,
 thomas@t-8ch.de, xry111@xry111.site
Subject: Re: [PATCH] hw/loongarch: virt: support up to 4 serial ports
Message-ID: <ZtsR9nQkKjfHDYAe@zx2c4.com>
References: <ZtqJuTTR0wdcVXdz@zx2c4.com>
 <20240906044944.2427297-1-Jason@zx2c4.com>
 <1718b6db-0535-ea6d-76ae-268fde30384b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1718b6db-0535-ea6d-76ae-268fde30384b@loongson.cn>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Sep 06, 2024 at 04:34:53PM +0800, maobibo wrote:
> > +    for (i = 0; i < VIRT_UART_COUNT; ++i) {
> How about adding serial_hd(i) checking here, such as
>    for (i = 0; (i < VIRT_UART_COUNT) && serial_hd(i); ++i) {

That doesn't seem to do anything, unfortunately.

> 
> > +        hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
> > +        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
> > +        serial_mm_init(get_system_memory(), base, 0,
> > +                       qdev_get_gpio_in(pch_pic, irq),
> > +                       115200, serial_hd(VIRT_UART_COUNT - 1 - i),
> is it serial_hd(i) here rather than serial_hd(VIRT_UART_COUNT - 1 - i)? 
> In general serial_hd(0) is default serial.

They've got to be added in reverse order. The chosen calculation needed
to be fixed though, in the line below:

> > +        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);

That now checks for the last index.

> By the way, serial port for acpi table should be refreshed also, such as

Thanks. Will send you a v2.

Jason

