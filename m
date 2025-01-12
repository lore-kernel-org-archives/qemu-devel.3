Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904C6E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX7c4-0001Ur-7l; Sun, 12 Jan 2025 18:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7c1-0001UX-Q4; Sun, 12 Jan 2025 18:43:21 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7bz-0007Ng-PH; Sun, 12 Jan 2025 18:43:20 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-518a52c8b5aso1207725e0c.2; 
 Sun, 12 Jan 2025 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736725398; x=1737330198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/DFP6yJ/sumZjVXldmaiLNXJ7Xf54Lp9fI8av/ELsw=;
 b=QxhGKtP65qOZFYKa5YurdUoN02lAJaWobpMkZxbfMKvURQf4KP4apV646af7T3N/43
 RNQRJzH66QN6JCBrhNaS4HyLQ8yHwTLZBlS8hhl9kvBz6B8ibM/5zo4eaQ241qY0vkT+
 4dSD0dzvJobsI8LvvCleaOT4f9aZnYo37gTIo37P+fi/d5DXKoKHctSC3H2ehnPUC9oP
 BRgtLjtdxgBMnF2RjEF/1Jbnn4Gja70GtMqv7XYDeaTpuDxRW8OfHgMrADZ+T/XezG0h
 wTvgtnaCL6UGcTV2BgFbixtmajIlNjOjydraRSrtM1yNVYjjPLFtO9ddMmG9eJ7yeMSk
 QPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736725398; x=1737330198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/DFP6yJ/sumZjVXldmaiLNXJ7Xf54Lp9fI8av/ELsw=;
 b=HCJTvLewKyDrKlnXcrN9VfBqDXqOjZDvfs2OH4IhloQ74j0ZtxmKME+Z/Axnxd5NXT
 EPF/21FZkaZ23BUr1+W2Zex/NljJkNo61/9+F2O/X5wZYUVMV2gDKxpA4YgxhrXYjktN
 Eh3drv/N/V7UFh0QGERbotgD42zksfMYWDmP5Msf9SdR+1MIFIo7yUFuQo4FTTIgJfF2
 Kdlbqyt7YZL96FCDsQxVimt3m/9GHLsDcTcZ/FB/i6JkVERDaQkdkR+vwAtapqaorqwx
 K2rLgsIbkk/svXd8UxOvDd6FPfAMM9U4hmkFEjoF8QtsC4/zaxVN4q0hD4Uu25B8FG8t
 ZyWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUByUMZ0ns0eqtMKSjZFagNE40WjQfxuY/43rDt9qkaWQ2rP3OVn/gtROyZrebXleKhYLdxTJHP2g==@nongnu.org
X-Gm-Message-State: AOJu0Yw7TKvxzYkfXV+21tKZjGn8cbKqx17c5smSPdgxVTJLcazoImcF
 Yk5BXCiovAML939wHyqyrxPMT6LevNti24F8NToJNl4eR9K2qpeFNztLmGv6yTeL4ZfnI/dqf0L
 JbhY3UZ/e92y5WnPBOaGzNJ1WV9M=
X-Gm-Gg: ASbGnctDZPRvzzZ/XJK89LeXwSYq/8cvdc3XnE3zDeEbdFG3RA/6wz/Oer1ZGP0rgd+
 r19Opsxk/HhAQxkHXnb5zeSYosgko1t6AYNPkw9wfeJSi7oFlY/8A4bJFzDsKR+1jozc=
X-Google-Smtp-Source: AGHT+IFT7QQQzrxcfixq3P0g6BNhRkT7LpJy23n8n0qnOPWPJnlmuUbRzY7PyXQyJuknEtq7+Fz92+vZk9YcIBm9MJ8=
X-Received: by 2002:a05:6122:50b:b0:50c:9834:57b3 with SMTP id
 71dfb90a1353d-51c6c46b338mr16503853e0c.4.1736725398238; Sun, 12 Jan 2025
 15:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20250112225614.33723-1-philmd@linaro.org>
 <20250112225614.33723-3-philmd@linaro.org>
In-Reply-To: <20250112225614.33723-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 09:42:52 +1000
X-Gm-Features: AbW1kvZT0RufijVamFGSdjzbi5Z--_YeeC4jQQHEcLlwpM4mOdBeTqK0QlMUEfs
Message-ID: <CAKmqyKPhDpHM68qKpr=6UrQ4z_md9kdqdRA-FamyxZgZyXCzJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/arm/stellaris: Add 'armv7m' local variable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Joel Stanley <joel@jms.id.au>, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Mon, Jan 13, 2025 at 8:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> While the TYPE_ARMV7M object forward its NVIC interrupt lines,
> it is somehow misleading to name it 'nvic'. Add the 'armv7m'
> local variable for clarity, but also keep the 'nvic' variable
> behaving like before when used for wiring IRQ lines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/stellaris.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 1bba96df14e..7303e096ef7 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1031,7 +1031,7 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
>       */
>
>      Object *soc_container;
> -    DeviceState *gpio_dev[7], *nvic;
> +    DeviceState *gpio_dev[7], *armv7m, *nvic;
>      qemu_irq gpio_in[7][8];
>      qemu_irq gpio_out[7][8];
>      qemu_irq adc;
> @@ -1095,19 +1095,20 @@ static void stellaris_init(MachineState *ms, stel=
laris_board_info *board)
>      qdev_prop_set_uint32(ssys_dev, "dc4", board->dc4);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
>
> -    nvic =3D qdev_new(TYPE_ARMV7M);
> -    object_property_add_child(soc_container, "v7m", OBJECT(nvic));
> -    qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
> -    qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
> -    qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
> -    qdev_prop_set_bit(nvic, "enable-bitband", true);
> -    qdev_connect_clock_in(nvic, "cpuclk",
> +    armv7m =3D qdev_new(TYPE_ARMV7M);
> +    object_property_add_child(soc_container, "v7m", OBJECT(armv7m));
> +    qdev_prop_set_uint32(armv7m, "num-irq", NUM_IRQ_LINES);
> +    qdev_prop_set_uint8(armv7m, "num-prio-bits", NUM_PRIO_BITS);
> +    qdev_prop_set_string(armv7m, "cpu-type", ms->cpu_type);
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk",
>                            qdev_get_clock_out(ssys_dev, "SYSCLK"));
>      /* This SoC does not connect the systick reference clock */
> -    object_property_set_link(OBJECT(nvic), "memory",
> +    object_property_set_link(OBJECT(armv7m), "memory",
>                               OBJECT(get_system_memory()), &error_abort);
>      /* This will exit with an error if the user passed us a bad cpu_type=
 */
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(armv7m), &error_fatal);
> +    nvic =3D armv7m;
>
>      /* Now we can wire up the IRQ and MMIO of the system registers */
>      sysbus_mmio_map(SYS_BUS_DEVICE(ssys_dev), 0, 0x400fe000);
> --
> 2.47.1
>
>

