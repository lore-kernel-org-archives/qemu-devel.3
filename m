Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA3C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSFM-0008PR-Cr; Wed, 26 Jun 2024 08:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMSF7-0008LO-BZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:59:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMSF1-0003RO-Fp
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:59:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so304562a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719406753; x=1720011553; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RfjqgRQN62njRMxr0q0bMCSpuB1g6VKOAlFWkM4SAj4=;
 b=TzakKqmgcjnryvm7FUc3pmte2APtZsZCqwMwGZvQrGaJ/HgSxisI5Bq6P8x3z1hrqk
 pUasQc5A6qHWu4CTUPCikfwJZRiRdN7LKC1ogCs56GqhNGkW99EnXUa99Ikh8+/E7vFQ
 PuCKnvIYDn81P/9QAuVp7nu+iz6y6tGsQMGkr1P9FEk5zl30l2fhQOsewxzLriCv1tnt
 T4KIj8cTtQq7e5kFKrVWcK6CMAfKeKVD18hQnrlAe5IalgDINp7RHr/IxptLJqeEr3kt
 0WtvjHtceJtqlqhyGb2hPc7I4wMLkRy9fnwLn0YOoRkzxCEE+XdU6nQA24nYXagUA5hB
 8upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719406753; x=1720011553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RfjqgRQN62njRMxr0q0bMCSpuB1g6VKOAlFWkM4SAj4=;
 b=KKcZlG68ysxu79anTjBCeN525ij3ebZCsP61WcBrxf/b57KwQqX6M8ua7sLUDWqc0t
 7xJJXlIiHzurit5ON4Ko4V4rC9jxyZzhn6HBtzXDbI1n1JClQmHBYEWLUwRkrkYHpAjU
 7cWmkct032kmaBXnfHHCGsi77Jbx77VpyQbGfsOdhU+TGw8JHs+HWSqgAJ7n0Qovu8vK
 xeKTK2zuGKSyYGj2CzA7H7TSQxEGtMSeFu4EwT3Y52o36OI8cskQl0GBU/qDiChpqM63
 ytDqlEbt+gpU1YYJoeFSNO5hG82xq5wFAmQGzL5PpNmWp9qf46ywpr0Li2bh88RPa0HG
 ulUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWly+5UHy108mPw0nQ/7EyaHJvGCQFPcH30pT1WlaSrOX8pjGmaVGb8HSV43E1qlvBhupAA0DYMFcRPydLjml3hMbx+TNQ=
X-Gm-Message-State: AOJu0YzbMNCGZc5Qcxj/uvBSYi/k8Ew70ZeAWkGqjIpkaZZa1xxOQg/B
 UZ59PyJnbUqFyUGIdKIKAUyS1VDijiwS1W7YR1cjtuDQmLVTylYmLYS02iUjA6No9U0ZK1jGdgE
 ny4OYzKpIBjBYvGGxM0ipbserKGqz7cWbZI4lqA==
X-Google-Smtp-Source: AGHT+IFwfuCv1nIAAensBiLVIG0MYsmQY/GTxY9qCP04zDpxbswBfRmwy98QhtZ3qAOrHaXibuKuuKBBX1szgxEMJoc=
X-Received: by 2002:a50:d50c:0:b0:57c:bec1:ff4b with SMTP id
 4fb4d7f45d1cf-57d701edfbemr4666485a12.10.1719406753231; Wed, 26 Jun 2024
 05:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-2-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-2-f3cc42302189@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jun 2024 13:59:02 +0100
Message-ID: <CAFEAcA-DNieFTV7VbM1MBTbEr9zd5kJ4oaWcsUrsPxCzQki+_g@mail.gmail.com>
Subject: Re: [PATCH 02/14] hw/ide: Free macio-ide IRQs
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 26 Jun 2024 at 12:09, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This suppresses LeakSanitizer warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/ide/macio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index aca90d04f0e8..d8fbc1a17ba6 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -464,6 +464,14 @@ static void macio_ide_initfn(Object *obj)
>                               qdev_prop_allow_set_link_before_realize, 0);
>  }
>
> +static void macio_ide_finalize(Object *obj)
> +{
> +    MACIOIDEState *s = MACIO_IDE(obj);
> +
> +    qemu_free_irq(s->dma_irq);
> +    qemu_free_irq(s->ide_irq);
> +}
> +
>  static Property macio_ide_properties[] = {
>      DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
>      DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
> @@ -486,6 +494,7 @@ static const TypeInfo macio_ide_type_info = {
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(MACIOIDEState),
>      .instance_init = macio_ide_initfn,
> +    .instance_finalize = macio_ide_finalize,
>      .class_init = macio_ide_class_init,
>  };

Rather than this, I suspect macio_ide_initfn() should not
be using qemu_allocate_irq() in the first place. Looks like
maybe a QOM conversion that left a loose end un-tidied-up.

thanks
-- PMM

