Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43505C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSDW-0006ws-7X; Wed, 26 Jun 2024 08:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMSDU-0006wA-Bf
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:57:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMSDE-00035U-1u
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:57:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so231723a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719406636; x=1720011436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WtG4m9Utz5M+zu25p1aXt/yhnygvOT0cR527ODxScvo=;
 b=GYrogNdWWzk7PvwSRPnhuFdpTpN6KWb5iqnO+jj03JLPYuLbMR77ot0IXv5FmR3poi
 7eVUexQPI64R5A+qqSph7KdPTI8mG4xenLasmwtAv7SnXJQ+C/W9JQEFwnfBw/CRqp40
 ynT7LGAmoya03twr+EoIWssuhvrzUWN/2VMTWUNVJJvE+RuymfGhRs2AvFo8eHadC+4A
 ACkIlTl+eJ36UbLdr4RImhHhrWeq4l4mZ89l8bKtjeiDwIniv+G1rC5FqaNFdeWQ5AZN
 mROSxPR7/Gywxx4P5RCKXGthVex5eoDcGOFHGUdaFftKntL5haQVuLFEtmWpk+cjYGW3
 1sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719406636; x=1720011436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WtG4m9Utz5M+zu25p1aXt/yhnygvOT0cR527ODxScvo=;
 b=Z0hqYoK7UQ+gq1KP8uceogZm+3V8OVDBPxyABcbCtbwVDa+qGlyqXbE9CGLthuEuP3
 oeYRbcvmmfxNXtmA7HhxHd1jJ0/9kPCYDcl2fEcF0RSDQtV/YC+TExqJx1ESJZnDWRbN
 4JJ2gwbkqGTIe2l+HzmboTFWSclOvebaFcoj3t7tZB3Jcy9KJhGBByrpR3sC5a6C7qcU
 lGS/5N5e15STIf02PoSrAD2S/mYdr9fKe27zPAaBWBZQxvAfIYSINb9hpSLHzWqnL3LL
 ov20pyAA0HdcDFNnNE9tzshConX3stesxfu37D26kPXcagcABil42cin+yKSjj9XUbuB
 Dwcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SNPN1EXUrN33QethsquZVO35B13+hUwOn6y4pm/e0E6GmMK/Utrxtk4JY3etc/EHSKNM6Pl5+T5pttQoOynCaHvGQ3o=
X-Gm-Message-State: AOJu0Yzm5wJtZrOHwaPeNwpyQqudF3AEXex4IbLfYVCtPEqnwYvBrb0w
 OMID5ou91hP6QvtbCs0xWPDkuJLHeZn4EGBPGk5C0tQrCaHzFKpX3fJbHY8bydVhwsOC6g13pmU
 mvoflbetEzJPXwHKnOVZAlFaMyjJef3PRH3DrkQ==
X-Google-Smtp-Source: AGHT+IE6rV9Ij3MUBI+4vABAm/HxN5dNQnBlq3IrKnlqp57GH8GiNwfyarSrw/rYanQ32DFeZ74lVLfcl1nole4y2gI=
X-Received: by 2002:a50:f61d:0:b0:57d:5c0:9dc0 with SMTP id
 4fb4d7f45d1cf-57d7007f509mr4340248a12.38.1719406635772; Wed, 26 Jun 2024
 05:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-3-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-3-f3cc42302189@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jun 2024 13:57:04 +0100
Message-ID: <CAFEAcA9Jg8vm5EtazbnTRn5ADNSr_7yvWaLnWYgJJt7ub6Q-LQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] hw/isa/vt82c686: Free irqs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 26 Jun 2024 at 12:08, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This suppresses LeakSanitizer warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/isa/vt82c686.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 8582ac0322eb..189b487f1d22 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -721,7 +721,6 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>
>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>      isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>                            errp);
>
> @@ -729,7 +728,9 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>          return;
>      }
>
> +    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>      s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
> +    qemu_free_irqs(isa_irq, 1);

This looks pretty weird -- we allocate the irq array, and
then immediately free it. The memory ought not to be
freed until the end of the simulation.

The ideal way to resolve this kind of leak with qemu_allocate_irqs()
is to avoid using the function entirely, and instead use IRQ
arrays allocated via qdev_init_gpio_* or the sysbus IRQ APIs.
qemu_allocate_irqs() is old and a sort of inherently leaky API.

The less ideal way is to keep the pointer to the array in the
device stuct.

If you look through 'git log' for qemu_allocate_irqs() you'll
see various places in the past where we've refactored things
to avoid this kind of uninteresting memory leak.

>      isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      i8257_dma_init(OBJECT(d), isa_bus, 0);

thanks
-- PMM

