Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367F7C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSf3-0006A9-4n; Mon, 29 Jul 2024 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSf1-000682-AT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:51:43 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSez-00069z-JB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:51:43 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso41893771fa.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268300; x=1722873100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVeYyd38oI4ymekSrtGt52u8IpbVV/D3aJ4+z1VG4jc=;
 b=ryAckw+YSeE10ktxzxpGbEqDscxduheqN1uNKTRINE3uXM0WWhgnjc8iyQfM49aWQ9
 x0RNcN+qLCFo7FFEj+n87/V0riC0vjcSRXUgm0IQ7GL1ffzOFBfTGTHDh4HeEFE5OCNK
 YGV4KKgr3yL0By8OXYN+v/kD6VlQfQgn8jSYIWut/qrIwP8FqWCGpcDcTz5wwjZ8SAnA
 b2W7jgjQf+3S8RbqrsB3DtVsluJ+nQdc3m8KDn8tkzCyUEprfxI6HdRw79qGfomnjzLY
 R+XcXzWZ6d/E9Fu1NlRggLHhiwjDfWhg8zF51SpnfkAn/n9SwjHVphPQs9KbApGyyUeE
 J5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268300; x=1722873100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVeYyd38oI4ymekSrtGt52u8IpbVV/D3aJ4+z1VG4jc=;
 b=KMnSJd656nFeLzC2g/m2qacmXTT/nq9e/r2Y7LbDJG8ZIUrU6UMOVgYfyMrMUzqnPj
 xOs3DTmYXFursiES26RYE9ZZWYxU0WdVcJloVkT8NEgJIfiPiOL2gwUyF16QT+uXqO1Z
 zU1kAXafV9Gp9zfIdvC/L/6BesWeLZDc0dNgHkjEmsrpHvwsPPFXsDmZ0yA3M0PZ8YKH
 izZrm0uo3AsCAtG6YRgKY3T11mqgsjj5Qq3f4y4iIws8iFjlvi1VuI38smdxQtGkuz1W
 qxSTDcxlkGgmUUS6AwI+dQcwh95ZdTUF4FPhW2BK4S/tOYbv4oChfdvibZVtfFoATJ/Z
 pmHg==
X-Gm-Message-State: AOJu0YzrpVsZf//zWqBgf6Tht6Q66I7xom/hGgzljuVgC6V2flo5IU8X
 7UQ2aAXxbr9sMZKn1jkkj1BZDE2i8rMWoHq6Sw2U7kPn37NxRRoFuvBiXpdR5Mbii7pG3bSrF23
 /7+0tBkvicunXESWINYD2J9eMUFCj9KzQv8OEpg==
X-Google-Smtp-Source: AGHT+IGgfLNaGF2nDylIei4IZk1IQfK8UJMfLyn/o4nGYkGfmSUAIZA0oVrrVrdpRtREQq2C77aP60y0NFmiV4Vt0IE=
X-Received: by 2002:a2e:9903:0:b0:2ec:5b17:29a2 with SMTP id
 38308e7fff4ca-2f12ee423c1mr55661621fa.32.1722268299607; Mon, 29 Jul 2024
 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-11-philmd@linaro.org>
In-Reply-To: <20240719181041.49545-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:51:28 +0100
Message-ID: <CAFEAcA-ibEzUWFCxA3iQLUoHwZeGnD5kM6c4Ni3BbgaoAs1gKA@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] hw/char/pl011: Check if receiver is enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Do not receive characters when UART or receiver are disabled.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/char/pl011.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index c76283dccf..0ce91c13d3 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Ch=
ardev *chr)
>  #define CR_OUT1     (1 << 12)
>  #define CR_RTS      (1 << 11)
>  #define CR_DTR      (1 << 10)
> +#define CR_RXE      (1 << 9)
>  #define CR_TXE      (1 << 8)
>  #define CR_LBE      (1 << 7)
>  #define CR_UARTEN   (1 << 0)
> @@ -481,9 +482,11 @@ static void pl011_write(void *opaque, hwaddr offset,
>  static int pl011_can_receive(void *opaque)
>  {
>      PL011State *s =3D (PL011State *)opaque;
> -    int r;
> +    int r =3D 0;
>
> -    r =3D s->read_count < pl011_get_fifo_depth(s);
> +    if ((s->cr & CR_UARTEN) && (s->cr & CR_RXE)) {
> +        r =3D s->read_count < pl011_get_fifo_depth(s);
> +    }
>      trace_pl011_can_receive(s->lcr, s->read_count, r);
>      return r;

I have a vague recollection of a previous conversation
where we discussed whether tightening up the UART-enable
checks would break existing only-tested-on-QEMU baremetal
simple example code. But I can't find it in my email
archive -- do you remember a discussion about this or
am I misremembering?

thanks
-- PMM

