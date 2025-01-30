Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D69C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZP1-0007ES-HQ; Thu, 30 Jan 2025 13:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZOy-0007DU-8h
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:36:32 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZOw-0003wH-KE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:36:32 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e4419a47887so1527060276.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738262189; x=1738866989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEwcy7h4f6qE+HwtPHkbkVOnvo40ozfrW8wEToVSXh0=;
 b=Xz31wYcxM/Y6FhSy4acQz5KyxpMMcCGS6wJ6YQF78WAkkB8t5Bfy2F7T74rkGnnx9P
 8yUt/yK3RCZITlMHSb2uOJIWQlq6iHP6tmIpzYIfR20ebO1FBMeWj+UFnocbQHlDqXvQ
 ombWFwJEAqyZl3jkwNsuhsGqbR4gzp2lLMbX/JAj4MuCAxlxd7vCN0L6MYeDWBU/5ael
 +M1Ws6NkU6jO6KQZaRPzhRhtui8rNbjt49J1CHm58l/X3dzY1RK/IcGXk+vMFBkjj44J
 4eRDHI9EtOBCKOKZ1vgLqcXH3b39LOlfPMqhFjr7r7lfePwxpjPYpRSaE1nsZA60J35R
 PJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738262189; x=1738866989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JEwcy7h4f6qE+HwtPHkbkVOnvo40ozfrW8wEToVSXh0=;
 b=mqSbrskhljB/6CsoEhMKQUM1q3/GoZSbR/sHcoWJD5/7TTljX6xVIz+C9k1jMTqqI9
 tKasAL/yDZrsU+fMU8qlzuoB1a2qNPuR0NCCQKyhvo7WyDPCSvs5CdLs1Nv1xWwLq/7u
 sd2lgf5J6lwgcWI+V1w6YrsYtLJoFzBEJV0qTkYXGy3k9oXndZ4v3Jvy6PqDS7H3l49I
 ZGl+o6rrT0j15m2N7bgAFDAKE2xgnA8kwBF1vnePCHikBAqBtFuzmDLsf8kPApZnBBwc
 CwhDlzpms0/ML9/Jx8LAvKoZVokANNtI7VjvjCwimdb9K6H27hlKHpY/eE+9vKdACcxE
 EjpA==
X-Gm-Message-State: AOJu0YybCai2IV6BtEyCrCXOxAnIFwKU4ixEoxSBmS7CMFSQORB5+LeW
 LHalsLCYqfTIgK4BItK5jDZBQhWnj4mQSQjgYzqkkNyOZTyHOXbd+pg8j+d/Sjo64Tzw7klYyjv
 7zyyHYASyI1LdayJ/0CmkNsFHnxxYaVpF7C/pXw==
X-Gm-Gg: ASbGnctED66WNrEeFc73kYm8CfWs0HINebLXYU9iH0tTIB5BHfb3rNRwe9YF8LCYBNW
 8lu57neZKDuhjX177qb2XBGsoghtz9+Re8GDzX3Y/ju5CU4AxzrVDp6Zn7kiOVHJ1uukhRox7rA
 ==
X-Google-Smtp-Source: AGHT+IHXeVz2BsmVR7RAJeOR5mmaHOxtjg3LNcri/jO0rYYBWKKjXVzhVK5PZRPPkxWHJajs+JBdCpGlALs5VQ3S/sg=
X-Received: by 2002:a05:6902:102a:b0:e57:caaa:fe60 with SMTP id
 3f1490d57ef6-e58a4bcb243mr5833702276.30.1738262189059; Thu, 30 Jan 2025
 10:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-4-philmd@linaro.org>
In-Reply-To: <20250130182441.40480-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2025 18:36:17 +0000
X-Gm-Features: AWEUYZnCnnaiudw6jv7nTwE4lc4CEaNyDGXyxBJIhOWFmnpL32Kah6sXkXtddIc
Message-ID: <CAFEAcA_PFSBdB0Uhb8K5aog0kj-HN=s_EBL=pQCkkNLuwUO42g@mail.gmail.com>
Subject: Re: [PATCH 3/8] hw/arm/realview: Explicit number of GIC external IRQs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Thu, 30 Jan 2025 at 18:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
> to make that explicit.
>
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/realview.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index 9900a98f3b8..4a62c83506b 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -35,6 +35,14 @@
>  #define SMP_BOOT_ADDR 0xe0000000
>  #define SMP_BOOTREG_ADDR 0x10000030
>
> +/*
> + * The Cortex-A9MP may have anything from 0 to 224 external interrupt
> + * IRQ lines (with another 32 internal). We default to 64+32, which
> + * is the number provided by the Cortex-A9MP test chip in the
> + * Realview PBX-A9 and Versatile Express A9 development boards.
> + */

On the other hand, this really *is* the Realview PBX-A9
development board. So we can just say that that's the right
number (and the vexpress is irrelevant, and the range of
settings the CPU itself can have isn't very important either).

(PS: there's no verb "to explicit" in English (ignoring some
obscure obsolete ones); French "expliciter" =3D> English "to make
explicit"; or you in the case of the subject line here,
"specify explicitly" is probably most natural.)

> +#define GIC_EXT_IRQS 64
> +
>  /* Board init.  */
>
>  static struct arm_boot_info realview_binfo =3D {
> @@ -185,7 +193,12 @@ static void realview_init(MachineState *machine,
>      sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
>
>      if (is_mpcore) {
> -        dev =3D qdev_new(is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore")=
;
> +        if (is_pb) {
> +            dev =3D qdev_new(TYPE_A9MPCORE_PRIV);
> +            qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTE=
RNAL);
> +        } else {
> +            dev =3D qdev_new("realview_mpcore");
> +        }
>          qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
>          busdev =3D SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(busdev, &error_fatal);
> @@ -201,7 +214,7 @@ static void realview_init(MachineState *machine,
>          /* For now just create the nIRQ GIC, and ignore the others.  */
>          dev =3D sysbus_create_simple(TYPE_REALVIEW_GIC, gic_addr, cpu_ir=
q[0]);
>      }
> -    for (n =3D 0; n < 64; n++) {
> +    for (n =3D 0; n < GIC_EXT_IRQS; n++) {
>          pic[n] =3D qdev_get_gpio_in(dev, n);
>      }
>
> --
> 2.47.1

thanks
-- PMM

