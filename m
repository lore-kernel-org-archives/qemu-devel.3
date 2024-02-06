Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E73FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLn4-0005iq-Rd; Tue, 06 Feb 2024 08:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLn3-0005iW-1k
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:47:09 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLn1-0003sx-H3
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:47:08 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cf4d2175b2so65098561fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707227225; x=1707832025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYZHBgDpXXmGEn5czzfjRmYJvcYABvyjAKf0rvOwL1Q=;
 b=ZhVHdFnP9zeTYD+SFIKwhGAaMR+vSwSQ8ednVVup/xb0HDFz58FELeUxe4MzwP2L89
 Xb/3rZWpitwIuz00a7maCVADE+AnvTV+J0fybk8zjT4gBNS9TgDW3HG6CfjsWtZdZOEE
 We4EHMuhPcuQ0SHY3usW/nTFg5PhbYFZgzaklmxYwIYHbMmKg+1BM6dAhW5wZTwpFr2F
 Jb2PexBiBvoH0DXWDrtxu9kkuH6LuydSZA2OG28z9B4i12ZTB7CgNrg+y7l6eGI3/dLm
 qgDHrp324/LEIU26+hGjdChxvFPLrtkvprehEvT9vflo9jc+UaNr3xdQG8JbfElNOGwO
 +QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707227225; x=1707832025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYZHBgDpXXmGEn5czzfjRmYJvcYABvyjAKf0rvOwL1Q=;
 b=A1cORGu7ca7wlitUkEQ1S6cBihgKEtLCrdo98qyi09mBdkcNB2pyO1jCwCLLIk7XlI
 /xpqCcJa2UdGRECjBk6R48pjXxWc4Px9HSaqhSuoWzxK1kIkP3sYsCmr/Gm/L9zybktG
 Ht1psTzRU+3jt6f29jjDVa+57zqf2MWt3im3+KjS1Oyi83Lr/VMQ0Ex98RPBcrhp2XVi
 szwdGhy2YTSk6gD+l0ow7vyASfXv9Bx6TwbAGXblQtNwr98lkx7qmpxVfc/eldRwDL2j
 8zeMn7icaN01lVN6R0RHWaeU6M6Cb4B5JvKr7cSwnbXSMF+n/BIz9LPIBxwkAZHagwIz
 BmZg==
X-Gm-Message-State: AOJu0YzjDh/pdFJPmDv/TKFH0yzt+L0FIsHaL4hl3YHLvXkCtqrZIRYX
 V+by7lh31+9HyoKzB+SMqEpseudHnYcQV7Bs+JAmE4MKjZfdv/WV2JKBxIhMlaptNGt3QoWL9uc
 oICQQHGs6NbRg7SVMLaPNFuWn7TZjJf5hf46WzA==
X-Google-Smtp-Source: AGHT+IGi9n9wXNBVo9ltMAycuqUHlmmCEcdebg56qD+Y4ECRtgAK2a3sDnah0K3OieiTnHNlpABLjkR2+AnIs63Ygu8=
X-Received: by 2002:a05:651c:b06:b0:2d0:772a:e5ae with SMTP id
 b6-20020a05651c0b0600b002d0772ae5aemr1969879ljr.14.1707227225389; Tue, 06 Feb
 2024 05:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20240130152548.17855-1-philmd@linaro.org>
In-Reply-To: <20240130152548.17855-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 13:46:54 +0000
Message-ID: <CAFEAcA8Zuq0UjXZ1FZPGn7TVfAJ96tfxg0W=jtxjgxRBUzByiA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 at 15:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Similarly to commits dadbb58f59..5ae79fe825 for other ARM boards,
> connect FIQ output of the GIC CPU interfaces to the CPU.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/xilinx_zynq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 66d0de139f..ffad058107 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -246,6 +246,8 @@ static void zynq_init(MachineState *machine)
>      sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
>      sysbus_connect_irq(busdev, 0,
>                         qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
> +    sysbus_connect_irq(busdev, 1,
> +                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ));
>
>      for (n =3D 0; n < 64; n++) {
>          pic[n] =3D qdev_get_gpio_in(dev, n);
> --



Applied to target-arm.next, thanks.

-- PMM

