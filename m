Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE4C83F15
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjebS-0008OE-QI; Thu, 29 Aug 2024 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjebR-0008NH-GM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:50:17 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjebP-0003OV-KT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:50:17 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a866cea40c4so69090066b.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724935813; x=1725540613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2wRSRQffSI3jvGx4sR+FNXzobzhljUOnvnpFox4nMKE=;
 b=RwtSw+I1ZuCa3XwzZBIdEMDDwFwcmwYgmTr3UP/LWxcrbi2M4Ro1IuhaU1lLXNDtCz
 qp7vgOwTOukPjTIHdaBGMLjRnp91n2ZeJlczpS3a8nLiWP/W8jRu5CJSCxjw4F30legr
 QRI0TT52UHFtyAvog+ODrlfeZNBSXtcDxELCAKGeoijwfKQUk2ESqlxfMKjrou/uQ+uq
 HHaHJVQim/poyCLXrbviccJ9hQzOJ4+5/VaKHQ+cUj0yprRq2CA6E+WCmcgLmfeY8b/s
 RqD9cA6VGm4SiznQ3PlhOeb06M9kfme37jQHdQZF77RCzWTk07eJxC6S6gXzNHMCgBkW
 3/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724935813; x=1725540613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wRSRQffSI3jvGx4sR+FNXzobzhljUOnvnpFox4nMKE=;
 b=sqOeaV3Sl39QsZQh2bsX9aHIZhl8JhIzQxQ8+ca0NWJl+08o+Y8KpvepwjeUuvG2eS
 2ikiyHE9vA+tyvMUIlo7O71nZKTO6rhGbYZI15Ha+6yaTK1YMlM8k+1CWu4LwkxmBWAC
 oKj+KaYD6RK0GfU/hRLtgdCQbIvn3BgTOe6LPZwuTtBbM2ejIFpuGR6LvWBSXVbPFx2i
 nZdmTKtYjDxz5GwKJb1CQ9fYLx14xvB1/X+1Bdi7O0RM/bJS3XZObFy0ZMpF2TDE6M6u
 JY+Ddk3rAQRdJkOLTmxU8j20qsYJFdrzNuNDF6Pkkb1duvWTk7whNqM2XnFBTkxuLmxT
 1Cig==
X-Gm-Message-State: AOJu0Yyvou1LD31OnblMT1TO+Vt4XX0sI2LfHveV//DEO8EooNgxldhD
 fJpE2VQK6k1MP/HpesXVcmXPnUwy6mJrvRYLqq/r6d4OqV5Sazkd6O4oloZK9gxyRjfY7vVw3dm
 r6PsZoKjcYM/YFh6XBw0w+c+V6mY8HMHY2bTTbw==
X-Google-Smtp-Source: AGHT+IEsvJzLk6edFPQgUf+ojCTi7/5sj2WOgy5fdEQI6A0SdJv3GO12cTLoUXUSnczWoG++kPwdFK9IX/kAKi7q7Hw=
X-Received: by 2002:a17:907:d8c:b0:a86:a30f:4b0d with SMTP id
 a640c23a62f3a-a897f930927mr259336266b.38.1724935813430; Thu, 29 Aug 2024
 05:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240828005019.57705-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240828005019.57705-1-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 13:50:02 +0100
Message-ID: <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Enable Security Extensions
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 28 Aug 2024 at 01:51, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> The system supports the Security Extensions (core and GIC).  This change is
> necessary to run tests which pass on the real hardware.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

(Added the maintainers to cc.)

Does the system have any secure-only devices, RAM, etc?

How much testing have you done with this change? (The main
reason we disabled has-el3 on this board back in 2014 was
as a backwards-compatibility thing when we added EL3 support
to the CPU model -- we didn't have a ton of images for the
board so we erred on the safe side of not changing the
behaviour to avoid potentially breaking existing guest code.)

> ---
>  hw/arm/xilinx_zynq.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 3c56b9abe1..37c234f5ab 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -219,14 +219,6 @@ static void zynq_init(MachineState *machine)
>      for (n = 0; n < smp_cpus; n++) {
>          Object *cpuobj = object_new(machine->cpu_type);
>
> -        /*
> -         * By default A9 CPUs have EL3 enabled.  This board does not currently
> -         * support EL3 so the CPU EL3 property is disabled before realization.
> -         */
> -        if (object_property_find(cpuobj, "has_el3")) {
> -            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
> -        }
> -
>          object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
>                                  &error_fatal);
>          object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,

thanks
-- PMM

