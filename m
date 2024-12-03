Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD5EE6C609
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 05:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tILtg-0003vH-Ko; Tue, 03 Dec 2024 00:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tILte-0003ub-F1; Tue, 03 Dec 2024 00:56:30 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tILtd-0002yS-4K; Tue, 03 Dec 2024 00:56:30 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4af16d741dfso1070051137.3; 
 Mon, 02 Dec 2024 21:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733205387; x=1733810187; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCinEncFBuiY4obiFoWp8FUfxul26qD2FivgdMUgdvk=;
 b=hwSmakeKPbLH9mvi1P/RIHLxfm8dH/dhNeULBdPKd5Bz48gJWXF/3akNPQ5+gXyPYo
 /s8zry5VdfJjgGRZjXsre9LGKohRXEzjO7YT+RZcmbdvikLn3XgDpCHZmQ08VgCm+yMX
 M49VTeVgW99+axjoLKUGP0dB37wzpw9YQLw2raYOAMPMqpZEWBzc6RtTCTPXZPJxdnmm
 Ed7qmvb8zJImvmgiaK+O6l+VWBiYZeBZuWPIjO3oWR1ySh5zQfH2rv2YIYaRGb9iTtS1
 KaVFrPgYIYZOZTYRx1YCZmB8GMB9R8hQbeQedQnP3dquhPzqAJWpAZo3W65Wmseyv1gP
 q2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733205387; x=1733810187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCinEncFBuiY4obiFoWp8FUfxul26qD2FivgdMUgdvk=;
 b=eb+CXb/iKAyeWZF4sddbDmLFyuEICDyvLrKFx0zIT4WNU34UVXrpxEoCd/W171gWPB
 Gn9TqVPOrt2f/xVUJ2V2hA7yfNgejc4Y8kUytvb5Vdwwlth5PTim6C3XGrlMwUghl5gS
 pnZv0D9T+T0keAu+2uzCGoQxdhUIv5c/8NyfnMQZ9LVphj0DSB6zJCjtX+xXx2L4Rb9a
 V3yRwRKZHoInLHlz1nzx2f/Xexxx3zpO5VT6eQQC5fSWZB4sJGDnzKEfa9uKFK85sdqY
 PmTm5oQiBVZoHbSpbvCGxgpB2LguR2J72+a/Vhn7FiaJbpe3aa4ovWLMFekuY3trsSor
 0xaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNCJxAXCNncie7l9TnqYYHWR15PD/z017DcmNHZ5y3hGa1iOuZgt2DR+T/gwmalWpkzAYp74fO3AgS@nongnu.org
X-Gm-Message-State: AOJu0Yzj/nBrNNs6LE/R3vRL7+yhTCnDqTurx/Wy4nm9a7RbHKDz9E5m
 9a85OTYwL+NoTgAf/v1e6VvITOip3SC7dGVdh5SlsIIpM0xZYzOdgqnXEL2Sj3v6LSt/UUJwdGe
 7HwRxP8KGEAqPLXKj0Vynee43Rgc=
X-Gm-Gg: ASbGnctqpAO80cy/vLZVC2ujJtZ6l/LjsHoYT0UIlQnkhCQD6dFqU89mDiBwL/viyZc
 EFTh+MRcN1K3KFTHXyHPlyndWuZaI6v+K
X-Google-Smtp-Source: AGHT+IHwPnSgfLOhxzj4VRGvA1gpvPpyUg9qyOKbvNuG+svemZF39k/mUzYPCKZTQjLZPfcqBsCCWY/CkVtP5n2m4dM=
X-Received: by 2002:a05:6102:6cc:b0:4af:56d1:5ccc with SMTP id
 ada2fe7eead31-4af971b8c56mr2232203137.14.1733205387591; Mon, 02 Dec 2024
 21:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-4-philmd@linaro.org>
In-Reply-To: <20241129154304.34946-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 14:56:00 +0900
Message-ID: <CAKmqyKN8VryKSyN5040o2Q21AuxQmCRjXuiSk1JCBv_e1TotpQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 3/3] hw/char/riscv_htif: Clarify MemoryRegionOps
 expect 32-bit accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Sat, Nov 30, 2024 at 12:45=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Looking at htif_mm_ops[] read/write handlers, we notice they
> expect 32-bit values to accumulate into to the 'fromhost' and
> 'tohost' 64-bit variables. Explicit by setting the .impl
> min/max fields.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Notes
>
> 1/ these variables belong to HTIFState but are declared statically!
>
>   static uint64_t fromhost_addr, tohost_addr, begin_sig_addr, end_sig_add=
r;
>
> 2/ I believe a 64-bit implementation would simplify the logic.
>
> 3/ This is a non-QOM device model!
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/riscv_htif.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 3f84d8d6738..db69b5e3ca7 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -325,6 +325,10 @@ static const MemoryRegionOps htif_mm_ops =3D {
>      .read =3D htif_mm_read,
>      .write =3D htif_mm_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
> --
> 2.45.2
>
>

