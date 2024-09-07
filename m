Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB1EB64C8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 14:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smwt8-0008Jz-Jg; Sat, 07 Sep 2024 10:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=+fej=QF=zx2c4.com=Jason@kernel.org>)
 id 1smwt4-0008Iz-PI
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 10:58:07 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=+fej=QF=zx2c4.com=Jason@kernel.org>)
 id 1smwt1-00057O-3l
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 10:58:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 85E6CA40579;
 Sat,  7 Sep 2024 14:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96847C4CEC2;
 Sat,  7 Sep 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="L60Fnpa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725721078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSD6+mki2epGYXGToONt7y5oDVfMZkl3ywv+6yHPnsY=;
 b=L60Fnpa3OLoPXSY4qhHyho1/2uRhbogZAETAIwb7mOd0eZQCS7TmnzSbUuk6DUxi4DLsqg
 901wxUV7YaXyZV8rT+NmJasKEHtP5AW/KrWCe5Pi5g2Gxbfk6mwuT0ocL2hBxZcJZ1a2VK
 Nqn380oWk2QfAMHTeu247HONO2X9CC4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6aaf330
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 7 Sep 2024 14:57:58 +0000 (UTC)
Date: Sat, 7 Sep 2024 16:57:56 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>
Cc: gaosong@loongson.cn, jiaxun.yang@flygoat.com, qemu-devel@nongnu.org,
 thomas@t-8ch.de, xry111@xry111.site
Subject: Re: [PATCH v2] hw/loongarch: virt: support up to 4 serial ports
Message-ID: <Ztxp9BxTAyao6cb7@zx2c4.com>
References: <ZtsR9nQkKjfHDYAe@zx2c4.com>
 <20240906143146.2553953-1-Jason@zx2c4.com>
 <50f6e8e8-2030-0c4a-7659-5c902b1e0906@loongson.cn>
 <Ztxm3YFqC-PlN94K@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztxm3YFqC-PlN94K@zx2c4.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=+fej=QF=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

On Sat, Sep 07, 2024 at 04:44:45PM +0200, Jason A. Donenfeld wrote:
> On Sat, Sep 07, 2024 at 11:37:09AM +0800, maobibo wrote:
> > Hi Jason,
> > 
> > It works well with ELF kernel, however it fails to boot with UEFI BIOS. 
> > Maybe it is problem of UEFI BIOS, can we create UART in reverse order? 
> > so that it can work well on both ELF kernel and UEFI BIOS.
> > 
> > Also for develops they usually use as earlycon with command line 
> > -serial stdio --append "... earlycon=uart,mmio,0x1fe001e0", this 
> > requires to uart with address 0x1fe001e0 as the first serial port.
> > 
> > Just small code base your patch like this:
> > 
> > -    for (i = 0; i < VIRT_UART_COUNT; ++i) {
> > +    for (i = VIRT_UART_COUNT - 1; i >= 0; i--) {
> >           hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
> >           int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
> >           serial_mm_init(get_system_memory(), base, 0,
> >                          qdev_get_gpio_in(pch_pic, irq),
> > -                       115200, serial_hd(VIRT_UART_COUNT - 1 - i),
> > +                       115200, serial_hd(i),
> >                          DEVICE_LITTLE_ENDIAN);
> > -        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 
> > VIRT_UART_COUNT - 1 - i);
> > +        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);
> >       }
> 
> Fixed: https://lore.kernel.org/all/20240907143439.2792924-1-Jason@zx2c4.com/

By the way, I don't know who is picking patches into which development
tree from the list, but this is starting to be kind of a lot of patches,
so I've queued them all up here:

   https://git.zx2c4.com/qemu/log/?h=loongarch64

In case that makes it easier for whoever the maintainer is to pick them.

