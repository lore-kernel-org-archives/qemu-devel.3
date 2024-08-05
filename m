Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E01BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sazXk-00034A-Hc; Mon, 05 Aug 2024 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sazXg-00030V-0A; Mon, 05 Aug 2024 11:22:36 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sazXb-0005AT-5e; Mon, 05 Aug 2024 11:22:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A432B60C55;
 Mon,  5 Aug 2024 15:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21125C4AF0E;
 Mon,  5 Aug 2024 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722871340;
 bh=8abpcgimZ8zhWhHlWs9YVGQE18wAOSsWG48ZhjBiE8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=J+EcWmFrHfavILP+4wyerdS0sBKsXIKEo3qbw9viOT6Bs+G+kubhy4Fl8O/dMnFtG
 WqjI/2UQgkmzntO+dtXM5QNqfz3EtVaZ8v4pyFUvFr43pWlZDPVUCNP3zT3Kxsc4E/
 ZT9omEnyzxHC0mJhbzLQ9e91Y78JaRqIHwC8eTT2oHKML+gCszAlkAbrbM55Ml605u
 jb5bACG5+6otD/RqFVCU3pzBXI1Lbqf8wLej5cEnVgs/XlOCD27LlcLCVxmxqGL8Ll
 +9wNpzgXZWENUSsa08mq4Zap2rDloxyKIShZGl+XRvVQjzJZadd23YlO5qv0x2yRUJ
 9qDfaS9A2Hjzw==
Date: Mon, 5 Aug 2024 17:22:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
Message-ID: <20240805172215.0c8c2597@foz.lan>
In-Reply-To: <20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
 <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
 <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
 <20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
 <20240801151544.2f315598@foz.lan>
 <20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Em Mon, 5 Aug 2024 16:04:39 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 1 Aug 2024 15:15:44 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 30 Jul 2024 13:26:20 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Tue, 30 Jul 2024 09:29:37 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >     
> > > > On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:      
> > > > >
> > > > > On Mon, 22 Jul 2024 08:45:53 +0200
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >        
> > > > > > Having magic numbers inside the code is not a good idea, as it
> > > > > > is error-prone. So, instead, create a macro with the number
> > > > > > definition.
> > > > > >
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>        
> > > >       
> > > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > > index b0c68d66a345..c99c8b1713c6 100644
> > > > > > --- a/hw/arm/virt.c
> > > > > > +++ b/hw/arm/virt.c
> > > > > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > > > > >      if (s->acpi_dev) {
> > > > > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > > > > >      } else {
> > > > > > -        /* use gpio Pin 3 for power button event */
> > > > > > +        /* use gpio Pin for power button event */
> > > > > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);        
> > > > >
> > > > > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > > > > you are passing 3. Is this a bug?        
> > > > 
> > > > No. The gpio_key_dev is a gpio-key device which has one
> > > > input (which you assert to "press the key") and one output,
> > > > which goes high when the key is pressed and then falls
> > > > 100ms later. The virt board wires up the output of the
> > > > gpio-key device to input 3 on the PL061 GPIO controller.
> > > > (This happens in create_gpio_keys().) So the code is correct
> > > > to assert input 0 on the gpio-key device and the comment
> > > > isn't wrong that this results in GPIO pin 3 being asserted:
> > > > the link is just indirect.      
> > > 
> > > it's likely obvious to ARM folks, but maybe comment should
> > > clarify above for unaware.    
> > 
> > Not sure if a comment here with the pin number is a good idea.
> > After all, this patch was originated because we were using
> > Pin 6 for GPIO error, while the comment was outdated (stating
> > that it was pin 8 instead) :-)
> > 
> > After this series, there will be two GPIO pins used inside arm/virt,
> > both defined at arm/virt.h:
> > 
> > 	/* GPIO pins */
> > 	#define GPIO_PIN_POWER_BUTTON  3
> > 	#define GPIO_PIN_GENERIC_ERROR 6
> > 
> > Those macros are used when GPIOs are created:
> > 
> > 	static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> > 	                             uint32_t phandle)
> > 	{
> > 	    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> > 	                                        qdev_get_gpio_in(pl061_dev,
> >                                                          GPIO_PIN_POWER_BUTTON));
> > 	    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> > 	                                          qdev_get_gpio_in(pl061_dev,
> > 	                                                           GPIO_PIN_GENERIC_ERROR));
> > So, at least for me, it is clear that gpio_key_dev is using pin 3.  
> 
> if you switch to using already existing GED device,
> then this patch will go away since event will be delivered by GED
> instead of GPIO + _AEI.

This patch is actually independent from the rest. It is related to a power
down event, and not related at all with error inject.

The rationale for keeping it on this series was due to the original
patch 2 (as otherwise merge conflicts would rise). It can now be merged
in separate.

Btw, this is doing a cleanup requested by Michael and Peter:

	https://lore.kernel.org/qemu-devel/CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com/

Thanks,
Mauro

