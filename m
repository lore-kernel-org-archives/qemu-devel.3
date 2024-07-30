Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA2C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYkzx-0001ID-AM; Tue, 30 Jul 2024 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYkzw-0001H0-AV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYkzt-0002ZT-SS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722338788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68Bv3qUhugllW5feZfpnaJ6Nwxgo67qRQ8KH325FnCA=;
 b=fvzoDlYYpCDP/TtzymWxzJF6ENaxPWP0M4RbAyEI96keLW9IKyf9jVpL/O7hgcLjDKMz/l
 CSvGCE+AY9kBa07rIY5Q+Xf9LGVnT3PMdkWTYBwM/TG2fUo2xLictNt2g9FHmiz/KTu/wq
 zvfwmwct0uu0hAjvvGwErBzUWBYRCtk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-v-q8QyJzNh6NxotF0gubow-1; Tue, 30 Jul 2024 07:26:25 -0400
X-MC-Unique: v-q8QyJzNh6NxotF0gubow-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280a434147so25910605e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722338784; x=1722943584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68Bv3qUhugllW5feZfpnaJ6Nwxgo67qRQ8KH325FnCA=;
 b=n1zFt6JxFHMpb4Hv4zvtRLZ359NP1vGKX9gBIlldcqalFgpClQaoCuBRA7umVpQQgC
 jsZMlIUpZM54IKTwO2go22bExv3s2uKByML0VFl+jJulxcDjkOA8w5HSv2SlT721rePm
 GASc0errD43BGehFg4lBwV37Rloang1QGaRgjHeMQiQOidGEL9v/WSl4bmS6wC6bp0fP
 fcGBMHBlHTBYnU2tFmLmFPdJA3zlEmWKW2MI1kl5UPzjzW4vqeQEjdvlSB7fTkCEJ3WK
 RERG3AypzR2U9MQpl2Fq2nDL1Pti/Q6CK1bhEnUZvIm/0O/NNpcNf6/lfTrSJlUsWEiP
 b9lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDHqmiee+jqlIL5EWsUV6Tw4dgFUDSeMI/BlcrH+G1BRyLI4FhKKwZ3yQ21s3pDomYgcIuRtQHWiNGmPAVceigGH+l7CU=
X-Gm-Message-State: AOJu0YyfKJiGCTVmnyk564wLnWnJeLJkeRYHyXDg4fHH5leOe4mUzFg/
 zu906Wr/bffYpZB0Doco5XwmZZQuk/C4rA9jHwRyj+vN5a4qCKYese3Rc3m+8D6Jc2jHmearqbc
 x78v/ji0s4kcj8YEZYKeHz35xyeqf1KMT/7/wx420JKIaN2/vLrqp
X-Received: by 2002:a05:600c:1515:b0:426:55c4:ff34 with SMTP id
 5b1f17b1804b1-42811d85b96mr64691645e9.15.1722338784286; 
 Tue, 30 Jul 2024 04:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX4Fvg5r3WYj/PUi3J/w154wlHxOXM06fmMmCdkHfMhJI1esBXcgg9hvSYrzFzFEAp+RIVFA==
X-Received: by 2002:a05:600c:1515:b0:426:55c4:ff34 with SMTP id
 5b1f17b1804b1-42811d85b96mr64691525e9.15.1722338783818; 
 Tue, 30 Jul 2024 04:26:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281dae1479sm64171485e9.44.2024.07.30.04.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 04:26:20 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:26:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
Message-ID: <20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
 <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
 <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 30 Jul 2024 09:29:37 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 22 Jul 2024 08:45:53 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  
> > > Having magic numbers inside the code is not a good idea, as it
> > > is error-prone. So, instead, create a macro with the number
> > > definition.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index b0c68d66a345..c99c8b1713c6 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > >      if (s->acpi_dev) {
> > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > >      } else {
> > > -        /* use gpio Pin 3 for power button event */
> > > +        /* use gpio Pin for power button event */
> > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);  
> >
> > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > you are passing 3. Is this a bug?  
> 
> No. The gpio_key_dev is a gpio-key device which has one
> input (which you assert to "press the key") and one output,
> which goes high when the key is pressed and then falls
> 100ms later. The virt board wires up the output of the
> gpio-key device to input 3 on the PL061 GPIO controller.
> (This happens in create_gpio_keys().) So the code is correct
> to assert input 0 on the gpio-key device and the comment
> isn't wrong that this results in GPIO pin 3 being asserted:
> the link is just indirect.

it's likely obvious to ARM folks, but maybe comment should
clarify above for unaware.
 
> 
> thanks
> -- PMM
> 


