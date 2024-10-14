Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45FBD1813D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Q9X-0004lZ-S0; Mon, 14 Oct 2024 14:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t0Q9V-0004l1-Tl; Mon, 14 Oct 2024 14:50:45 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t0Q9U-0001O7-Ab; Mon, 14 Oct 2024 14:50:45 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so401757266b.1; 
 Mon, 14 Oct 2024 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728931841; x=1729536641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Afn4YpkfgdO2F5nizDrDa38curFp/Rk7aAYjRgQ498=;
 b=cCUnlN31Dn4E5ujfcbVaCAec8TuaxZnEobFf2PZvBu5ozWIBy2yEO8u1BCzARUPlt4
 fu9g5gY8O+KETdGN87Rh8pNfzYSDy2fDeXgPJ+jeTxoGWaYjwYR9lQtFxtBqjUU3HY+m
 x0pFBl6zS3QkIclMcl+gNC93v3eZE4WGk6kw6l1BRU7nmfxvPQnVcKjqBmtoRgdH8xoh
 3J7atJ4zqdzCrQKmGI173XlzYpBp1HLu6xyijME1P4OQJc0xLCxIkWfyJlTJjYatyhop
 LEmOlcu2LZ3/yIMY7lcnRH1ptEbIuSCieu9BrnVLRppPpHo4nZHk/T3YKeHKXkWPQJOD
 0Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728931841; x=1729536641;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Afn4YpkfgdO2F5nizDrDa38curFp/Rk7aAYjRgQ498=;
 b=XFkzwV9zppIZPTUijslr8izDSlfuJqevC8IGFmc6tSHMpwB5mWV6oVSAkXPogV6gf0
 ywx1wtQszbTKt9Lm13zYDicZR9RDn9Ppet3rrJlV0GPl5QP4lycSYUDdWYSWhBAVQhaB
 iN75L/4JlQGH3z1XTZFAS5/IF3KiAYOGRfuukfCzfX1HzTBdf+gbute9vGTc1zy4qkep
 ZtM1uGjcqTrBq2rzaPgrWQyNJrgCu5CObEyCWr9uiYEHWeGK8lev2KTGW0Ts2FBy+pvb
 nXs3agyubPZBrqbFsptGLGoNQTkynDbhdt9lTAr0CLLlcFNz8PIRTq4n1BT0EB+fbrMb
 Ah5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1f5FUbIIgiyDC2l1Cj1B9nDfkgi9hIesF6wOeeMKPQOv/UiPTijqkQQzMdBxZhQsnBOxcFBOuQ==@nongnu.org
X-Gm-Message-State: AOJu0Yye7Cu1ZRGy6fyoRSh3XrO2OEVBw6sdLnSLMefN94Gnd8HAZVVg
 1p5hGqFof+h162ShK9dWoh6NtYBubzXaIm4vExmNsoGX6AI0hNWpeRNBWw==
X-Google-Smtp-Source: AGHT+IFIx3+0Z3gdpNm7+01uc+vKkq2UjZvDvTifRLjotdTAENoU/QJ46E0F8H7ATDKh5j7xubjqNw==
X-Received: by 2002:a17:906:478e:b0:a91:1699:f8eb with SMTP id
 a640c23a62f3a-a99b89f0ef7mr1288347266b.28.1728931840983; 
 Mon, 14 Oct 2024 11:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99f2ea1dd1sm348302466b.68.2024.10.14.11.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 11:50:40 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:38:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
In-Reply-To: <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-2-shentey@gmail.com>
 <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
Message-ID: <E3D8FB20-605D-4E29-A430-DD3C4B01102D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 14=2E Oktober 2024 12:47:52 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Sat, 5 Oct 2024 at 21:57, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> A very similar implementation of the same device exists in imx_fec=2E P=
repare for
>> a common implementation by extracting the code into its own files=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  include/hw/net/lan9118_phy=2Eh |  31 ++++++++
>>  hw/net/lan9118=2Ec             | 133 ++++++---------------------------=
--
>>  hw/net/lan9118_phy=2Ec         | 117 ++++++++++++++++++++++++++++++
>>  hw/net/Kconfig               |   4 ++
>>  hw/net/meson=2Ebuild           |   1 +
>>  5 files changed, 174 insertions(+), 112 deletions(-)
>>  create mode 100644 include/hw/net/lan9118_phy=2Eh
>>  create mode 100644 hw/net/lan9118_phy=2Ec
>>
>> diff --git a/include/hw/net/lan9118_phy=2Eh b/include/hw/net/lan9118_ph=
y=2Eh
>> new file mode 100644
>> index 0000000000=2E=2E50e3559b12
>> --- /dev/null
>> +++ b/include/hw/net/lan9118_phy=2Eh
>> @@ -0,0 +1,31 @@
>> +/*
>> + * SMSC LAN9118 PHY emulation
>> + *
>> + * Copyright (c) 2009 CodeSourcery, LLC=2E
>> + * Written by Paul Brook
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later=2E
>> + * See the COPYING file in the top-level directory=2E
>> + */
>> +
>> +#ifndef HW_NET_LAN9118_PHY_H
>> +#define HW_NET_LAN9118_PHY_H
>> +
>> +#include "hw/irq=2Eh"
>> +
>> +typedef struct Lan9118PhyState {
>> +    uint32_t status;
>> +    uint32_t control;
>> +    uint32_t advertise;
>> +    uint32_t ints;
>> +    uint32_t int_mask;
>> +    IRQState irq;
>> +    bool link_down;
>> +} Lan9118PhyState;
>
>This takes state that was in a QOM object, and moves it
>into something that's kind of a device but not a QOM
>object=2E I think we should avoid that, because at some
>point somebody's going to have to QOMify this=2E
>
>Making this a QOM device is a bit awkward for migration
>compatibility, unfortunately=2E

Do we care about migration compatibility here? Or is it sufficient to chec=
k the version? In the latter case I could QOMify it=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

