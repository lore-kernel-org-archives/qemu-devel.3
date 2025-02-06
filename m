Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA25C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3TY-0004yI-DI; Thu, 06 Feb 2025 10:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3TU-0004xB-EG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:07:28 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3TS-0008Hl-EH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:07:27 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so824293276.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854445; x=1739459245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfcJUiFlsDogNboBdiDs61IEt50XRRY35RapyCs+uSY=;
 b=FphfESR/IKsBCGopg8J1sWsGeBr2OlWpGBC4guo2RQ6eirmDvFfyC/zkIvCGlAJDQ9
 +VLqOVwJK28IVlQeam3hvmKdIDUOqRX8e8UKcn4xvduhJeTD4SWgBuZlvEi8RgCCMtKY
 iN5mdyYExfgsbsGyPJmKven6l7i/FgzqQi2NYpr+q3FdK0ZAS1brpdVxXV6FOaUUHULp
 5C/zbawphvGwBkTAveh6lVrlwZJlYLWo6SYaFSS8Hou0F7gqe7SyenvYwZiGkLxB6uU5
 Z/W8d0GMRmWUNoo5sgXWwh7SbpLPGf/buL8Mkq89phiJlNJBykxV7cXWkEqa0VvXRd5x
 UF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854445; x=1739459245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfcJUiFlsDogNboBdiDs61IEt50XRRY35RapyCs+uSY=;
 b=KcoJr/Dh4hM/6HVky+U/EgsjwdjJg0eHOcXwaoaUDtN1Qx3x51cquEqeqXRDgzxVab
 vYlnWoI4RrG904f5j9GVrkk4NJO74bkEHXs1wX3yzNYzLTCUGQLpPCp6GbLfcu8YWMRZ
 OSE1YGc7cMKLqXfJ0KctspaLsrPd9RDjNECzmtpEOKB4QnuE2edYvkLOHH7QdBdP47he
 bIcWpJbG2W46X1gLXK+3s10FrRlki/tXOhXdbItlyVn8t/b/XT992Q9KzbevhEt/9DfQ
 Sz3c60Eb+v3lmtq5ngZSsjEHCgEHKdHTSTNo3/UOadnGBjewHtbJnwcZHlPdUBR2HJU3
 ttaQ==
X-Gm-Message-State: AOJu0Yxh/+9PiQkukpS7QNvJykdfobcY10Vm0eLM8tWLHdDrJ6xWJT4Y
 v7zQchHNcRoLNt9QiCYJzwsi6kZDQHF5bwLAAt3KevQ78r1h927pz7cLx5+Z2YRjN7/105ihVXx
 gknWaDbcvDF3OSXYv/DDmzSkkQGlECzk7tmYpQQ==
X-Gm-Gg: ASbGncsv8g4Sny8sJl9RVHe1YZs6XNC7ZP9+swlLJnpm7oi2Snp5kCowgaBaDoTR6p5
 sCu4zwZ+ZKq3T2jMWvZe4iM2cNz4B28vlKW1sc0QBd/OdyndQPXdGv8tdsVHU8FDiOnl7uxPngQ
 ==
X-Google-Smtp-Source: AGHT+IEmZinX7IHqz03Prn8ZjXMB283UqwZ8fz9CoGIcKrDKge6s7q+0Mvb9UrMG3eG0E8lD7AFcAfUtOg5egq3fjJw=
X-Received: by 2002:a05:6902:2842:b0:e59:a174:85e7 with SMTP id
 3f1490d57ef6-e5b353d4a07mr2892167276.17.1738854444913; Thu, 06 Feb 2025
 07:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20250124175053.74461-1-philmd@linaro.org>
 <20250124175053.74461-3-philmd@linaro.org>
In-Reply-To: <20250124175053.74461-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 15:07:13 +0000
X-Gm-Features: AWEUYZmWC03PJbtGv6LiGMzkXPRoc4ZLYcdoCDsUS-uYrQdE_KlUqQ1OQ7xq11I
Message-ID: <CAFEAcA_nnASmHgPnDsBi61dhVnrNajO_YgOQr4pC79hH8f4Cjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/char/sh_serial: Convert to TypeInfo
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>, 
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Fri, 24 Jan 2025 at 17:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QOM types are now registered using as TypeInfo via DEFINE_TYPES()
> or type_init(). Update TYPE_SH_SERIAL, removing the empty QOM
> instance_init/finalize handlers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/sh_serial.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 29ac9f9e5e7..b1db91656fe 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -78,10 +78,6 @@ struct SHSerialState {
>      qemu_irq bri;
>  };
>
> -typedef struct {} SHSerialStateClass;
> -
> -OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
> -

This was definitely wrong, because OBJECT_DEFINE_TYPE()
is only for cases where the class needs its own virtual
methods or some other per-class state in its own class struct.

>  static void sh_serial_clear_fifo(SHSerialState *s)
>  {
>      memset(s->rx_fifo, 0, SH_RX_FIFO_LENGTH);
> @@ -443,14 +439,6 @@ static void sh_serial_unrealize(DeviceState *dev)
>      timer_del(&s->fifo_timeout_timer);
>  }
>
> -static void sh_serial_init(Object *obj)
> -{
> -}
> -
> -static void sh_serial_finalize(Object *obj)
> -{
> -}
> -
>  static const Property sh_serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SHSerialState, chr),
>      DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
> @@ -467,3 +455,14 @@ static void sh_serial_class_init(ObjectClass *oc, vo=
id *data)
>      /* Reason: part of SuperH CPU/SoC, needs to be wired up */
>      dc->user_creatable =3D false;
>  }
> +
> +static const TypeInfo sh_serial_types[] =3D {
> +    {
> +        .name           =3D TYPE_SH_SERIAL,
> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size  =3D sizeof(SHSerialState),
> +        .class_init     =3D sh_serial_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(sh_serial_types)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Do you have a view on when we should:
 * use DEFINE_TYPES like this
 * longhand write out a type_init() and a function
   (maybe only if you need to programmatically construct
   the type structs, e.g. in a loop ?)
 * use OBJECT_DEFINE_TYPE()
?

Currently docs/devel/qom.rst leads off with the
"write it out longhand" approach, then mentions
DEFINE_TYPES for if you want to register "several
static types", and finally documents the OBJECT_DECLARE
and OBJECT_DEFINE families of macros.

thanks
-- PMM

