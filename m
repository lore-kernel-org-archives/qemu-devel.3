Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2072DD3E775
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RzA-0002zv-L8; Tue, 05 Nov 2024 17:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8Rz8-0002xl-JF; Tue, 05 Nov 2024 17:25:14 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8Rz6-0000HC-Rx; Tue, 05 Nov 2024 17:25:14 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84fc818f518so2001049241.2; 
 Tue, 05 Nov 2024 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730845511; x=1731450311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwOa7p3OlaATrioEOLE8Gozv/YHcDzoNnyvAkZRc32U=;
 b=nikz4N8BwUDqJBrzAeXk8Nlf08Z7beJq0pQ1qH+iv48W5fwq0u3F224s0NHptG1VV7
 XiUVMLJ9oyZzKVmyi+/qfXOHS1RkQkbIVa+FpL+vr5evcaJHTwh2nvgpiv4+RWDg0mrM
 cfPpmGFZ/xEgLxH6bnF1TKrmZuZBA2SQsvZy3DJjJi179gwZmGnmHe4+KfwjKLry1kWB
 Nxe/y6hBOKi31kkgHdiux9Hg97hVolw8N+29GmvFUz0iULwuRns+/rpRPDaqAkFO+FRG
 c6VLZ/gk71bzLME4lnrKruu6Pw6EXBjiDiHa5n6cSE3tyrXvBIvL89IQFUwmVPicJb/s
 PLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845511; x=1731450311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwOa7p3OlaATrioEOLE8Gozv/YHcDzoNnyvAkZRc32U=;
 b=bI3BSluf3Tn1SNeD9C9xrqiogfS1O+k3f20fRIDqMNp/3FiwLE4KKJ7fD6Oxv553md
 4QMAUMVWfYYpipEfxH5DnugPOlvgp0h1rcJq5W4a3qL2jFqk1FEcLL9l/4YKAzLiUhZE
 eJC7/IvEOGQsxy/K+ubp5rCnsFRe+sVK9LVJXLFO0HOL4A+byqn3mEFkUu1hwNLJyhs1
 X4j03RxNhWrns1zlAPWqI/kzHvDn1AKx4nFBFROgNs4SkXCF9YklCBpH1mXHSeKtJ4vS
 w09dtCHXeVoECCdADvRZuOgutzqNfEAgiaKxqvt/lAwIak2ULLc/fx/b3uADo1ieOqQc
 wUAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwuy4zfasM0iPfUZlcG+r+00LTLwDtOkDURtLdNa9ja4sZdUROfbrV9ULJg8EshviiZiWwW4Jy5Q==@nongnu.org
X-Gm-Message-State: AOJu0YwaGlxwBDHP/X2x9APx8Sh9TraLZkRBOQiNXK65arL8UDGmYifE
 KJL9+tzeAQMxIcxtDDAJ9FGhpCKwu4fU8cmA2ptvpl/bx6VmqkzMbyEWz+5mxEDKvBMlPGNLhlR
 +6BejrSkzOzaow+pkXHMlWqdJgQs=
X-Google-Smtp-Source: AGHT+IFOyrnAaNoMCMg6U/gdr9YNWShOZBmIgW0k9Aby1S0/MHfH4CA2Jx1SLWqhr/nRRUi2CYCaUayHDd+l0kCRxm4=
X-Received: by 2002:a05:6102:3f0d:b0:4a4:6098:1fec with SMTP id
 ada2fe7eead31-4a962d6cbc9mr16539935137.2.1730845511380; Tue, 05 Nov 2024
 14:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-10-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-10-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:24:45 +1000
Message-ID: <CAKmqyKN6TzFbPSeQyBN4QrVLxAvTr--nsu7nbA+VFGq=cv7Y3Q@mail.gmail.com>
Subject: Re: [PATCH 09/19] hw/intc/xilinx_intc: Only expect big-endian accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 5, 2024 at 11:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Per the datasheet (reference added in file header, p.9)
> 'Programming Model' -> 'Register Data Types and Organization':
>
>     "The XPS INTC registers are read as big-endian data"
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/xilinx_intc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
> index 1762b34564e..71f743a1f14 100644
> --- a/hw/intc/xilinx_intc.c
> +++ b/hw/intc/xilinx_intc.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (c) 2009 Edgar E. Iglesias.
>   *
> + * https://docs.amd.com/v/u/en-US/xps_intc
> + * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
> + *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
>   * in the Software without restriction, including without limitation the=
 rights
> @@ -143,12 +146,20 @@ static void pic_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps pic_ops =3D {
>      .read =3D pic_read,
>      .write =3D pic_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    /* The XPS INTC registers are read as big-endian data. */
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
>      },
>      .valid =3D {
> +        /*
> +         * All XPS INTC registers are accessed through the PLB interface=
.
> +         * The base address for these registers is provided by the
> +         * configuration parameter, C_BASEADDR. Each register is 32 bits
> +         * although some bits may be unused and is accessed on a 4-byte
> +         * boundary offset from the base address.
> +         */
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
>      },
> --
> 2.45.2
>
>

