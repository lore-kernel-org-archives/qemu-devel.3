Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2F4C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBiv-00037C-3J; Tue, 25 Jun 2024 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBgg-0002Un-Ai
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBg3-0002df-RN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719343021;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AEQjQ8J55hwIzfmoesWqLHpIacoHUj34dmwhha0SGcM=;
 b=Q2rrMsW5uosrY0NatUrWbBO8hkc5fl3cVCYxRYkweoclGk0KA891nOBTbaIp9CkX0bO/q5
 vvOY0NMSIE3kBDRUK/HqXTTbX8VK8qzJYdSlRY17cJuzyQozlJ4Nwk90Ru0X2UPJcbIB5Q
 2RhGAVQr3NA/tbezx8x8/BOh1tyWMAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-8qYm6tRuOymG68ScYeRX6A-1; Tue,
 25 Jun 2024 15:15:21 -0400
X-MC-Unique: 8qYm6tRuOymG68ScYeRX6A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1749E19560AE; Tue, 25 Jun 2024 19:15:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BD891956050; Tue, 25 Jun 2024 19:15:10 +0000 (UTC)
Date: Tue, 25 Jun 2024 20:15:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
 x-pl011-rust in arm virt machine
Message-ID: <ZnsXOyYJAlae1Ito@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
 <Znrt77XOc2YBNZyM@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Znrt77XOc2YBNZyM@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 26, 2024 at 12:18:55AM +0800, Zhao Liu wrote:
> Hi Manos,
> 
> On Wed, Jun 19, 2024 at 11:14:02PM +0300, Manos Pitsidianakis wrote:
> > Date: Wed, 19 Jun 2024 23:14:02 +0300
> > From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Subject: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
> >  x-pl011-rust in arm virt machine
> > X-Mailer: git-send-email 2.44.0
> > 
> > Convenience patch for testing the rust device.
> > 
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  hw/arm/virt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3c93c0c0a6..f33b58ae0d 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
> >      int irq = vms->irqmap[uart];
> >      const char compat[] = "arm,pl011\0arm,primecell";
> >      const char clocknames[] = "uartclk\0apb_pclk";
> > +#ifdef CONFIG_WITH_RUST
> > +    DeviceState *dev = qdev_new("x-pl011-rust");
> > +#else
> >      DeviceState *dev = qdev_new(TYPE_PL011);
> > +#endif
> >      SysBusDevice *s = SYS_BUS_DEVICE(dev);
> >      MachineState *ms = MACHINE(vms);
> >
> 
> I realized that if we want to merge the rust pl011 device, then this
> patch or similar enablement support is necessary, otherwise, the rust
> code is only used for compilation and cannot actually be run...
> 
> This is also an open for the devices that are rewrite in Rust.
> 
> I think there should be an option for the user to choose whether to
> enable pl011 in C or pl011 in Rust. What do you think?
> 
> Perhaps the easiest way to enable rust pl011 is to add an option for
> virt machine... But that's certainly not a long-term approach. I think
> the ideal way would be to allow rust pl011 to be specified in the
> command line via -device, but this approach would mean allowing the
> user to create pl011 and would require changes to the current buildin
> pl011's creation logic.

While having both impls present is reasonable for the RFC, IMHO, if
we're to merge this, then the Rust impl of pl011 should fully replace
the C impl. Maintaining 2 different impls of the same device in
parallel is highly undesirable. This would of course impl that the
Rust impls needs to be a feature match for the existing impl. If we
do a full replacement, then the question of how the user chooses
between the 2 impls is then entirely avoided.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


