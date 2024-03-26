Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD964C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 04:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1royq6-0002gs-6I; Tue, 26 Mar 2024 00:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1royq0-0002eB-9w; Tue, 26 Mar 2024 00:55:04 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1roypy-0000xi-1P; Tue, 26 Mar 2024 00:55:03 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d452e2f0aeso1948630e0c.1; 
 Mon, 25 Mar 2024 21:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711428900; x=1712033700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDto20CjZopmIFKXilu7ietmczZxyfrzm+oC59FLg6U=;
 b=UGJvmjcx5sMFF0HQUK+5LQL4KVhmi7YYnFzezIMJcQ4ncUwEJU6w1kD9Id8GGRQe4X
 gzAXNyxZ3Q7GdHzuOy+SB15aXXyvNMUCMP8y8hh7kjIXVegGIIy+2z6Vuc3sLy1wBAA8
 cSUUollONb2ZU4E+NqZykYZY4/NRn4CAfizxRU8iBNM7wE6TSVX6Xly+4LSgCaSgHRzr
 QQZUNd69CrSNq2H5df/c/Hx9zS3zZo4IkIw5VnE7CpAwd89yKsxrjTSYz/FTFE8cMtz1
 zT7w72M8vvmO6/qKTVWDfIktitv75NlTsUEin7bgRkMZVfLstJwerH8JD4fIdufrKTkX
 qmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711428900; x=1712033700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDto20CjZopmIFKXilu7ietmczZxyfrzm+oC59FLg6U=;
 b=bWV8XOm0rnc1eARvfN87PT3WQTKMCcpuWf2ma9DxadOGEzKdwRYltQCTkbv9027NzU
 FV9WgzAm3xdYF1PrWRsD/b3+KwBkGQ73jUcsmik6yDhp7+/olHTxELMgMVyiCpGKdATd
 X6SEmNYCfyvHdxKXRZ1cV5ufAiUq5k+QJZIH+VPMUZoRDA4tS5PZ08O2Dwj0rhjLcBUX
 Vku320OUK/w+QsoA+Dwez5SzrGkVgy/aypCH57XW9jTO4blAbneK1almLidMAehEMIRl
 l0tBtMcoaXqEJML4M2tTMUD2nmxxwBubbJboTty3yHPR6PyhEI0WWJx/lClLIymlKA8C
 qV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHityWI03RRAJoB2l22idP/OCfmfo7CWzmjHOJ/vPIMxwMm0BJgtvATS0Xe5nKHzwzUz3AH5zZ+hnnLjWUnfK4XPmi
X-Gm-Message-State: AOJu0YxyNq31M1RVeVQzFUvtsn3yvsXDdwcWfOowgCUMoN9DOwxdgyHI
 Te6K1Si+6/O0vdmD0BsP5qqLSccT5Jpj5xuPMmKUCHMvsbbl43tJsVrLrEoXnz2VGWd/yJSwZk9
 9bPCWmKllwa6i1J32PSsdCWbUgVI=
X-Google-Smtp-Source: AGHT+IHsNEflE4ALOvCiGMtfIttGAuPQqpQqDSW93EaQs89TD1F8F6oNj6Uo1PYjrF+oK5glZGUefYYPclPUD/47ARk=
X-Received: by 2002:a1f:f843:0:b0:4d8:7a5e:392f with SMTP id
 w64-20020a1ff843000000b004d87a5e392fmr5912129vkh.12.1711428895420; Mon, 25
 Mar 2024 21:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240325152827.73817-1-philmd@linaro.org>
 <20240325152827.73817-4-philmd@linaro.org>
In-Reply-To: <20240325152827.73817-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Mar 2024 14:54:29 +1000
Message-ID: <CAKmqyKMm9RLMweqCBpHBmu8PaLavFh8rcOLLSMVLVpxim6AGqA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v3 3/3] hw/misc/stm32l4x5_rcc: Propagate period
 when enabling a clock
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Tue, Mar 26, 2024 at 1:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>
> The "clock_set_mul_div" function doesn't propagate the clock period
> to the children if it is changed (e.g. by enabling/disabling a clock
> multiplexer).
> This was overlooked during the implementation due to late changes.
>
> This commit propagates the change if the multiplier or divider changes.
>
> Fixes: ec7d83acbd ("hw/misc/stm32l4x5_rcc: Add an internal clock multiple=
xer object")
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Message-ID: <20240317103918.44375-2-arnaud.minier@telecom-paris.fr>
> [PMD: Check clock_set_mul_div() return value]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/stm32l4x5_rcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index 49b90afdf0..ed2dbd9dc3 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -61,7 +61,7 @@ static void clock_mux_update(RccClockMuxState *mux, boo=
l bypass_source)
>          freq_multiplier =3D mux->divider;
>      }
>
> -    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
> +    clk_changed |=3D clock_set_mul_div(mux->out, freq_multiplier, mux->m=
ultiplier);
>      clk_changed |=3D clock_set(mux->out, clock_get(current_source));
>      if (clk_changed) {
>          clock_propagate(mux->out);
> --
> 2.41.0
>
>

