Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEEEC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhvI-0006sP-Px; Fri, 22 Mar 2024 12:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhvH-0006rx-0O
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:39:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhvF-0005Vh-5t
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:39:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56bdc2a2c96so1573380a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711125551; x=1711730351; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2V/kZFCfcWi0KYped6O13E5wkq/N08mYcZSpS8jksA=;
 b=wc2HF3CQSoVwvouwklCqbJGsJ/dxsiYEQJ830ZVuQ9RS5Mo5I8MHXzJtmeUq/d6zXb
 NQU74tJntlycPi9sHMJeWn+44bV0CcGyRwbC469OlQIkMxI/oGy/y5lLyz+2vT6qoYfB
 Ok0Se/vKfwu83RJTB4eHfMuW5YB6B3OG/NyrDwqrKWm3ti+LnKqDugpH0MHWvatH4Ztw
 mXTrEz/cUfcO1sRTooRmZr8/mMP8LLt335+WLELG76mBd96t22Awa31Yg5Xcp3n2RIP6
 PlUBUOgbaUXLJlBfs7wO80GyxJdT2zTvz0XruL02oLxcj+P+lM6+s765t1iys2I1hgzx
 fW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711125551; x=1711730351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2V/kZFCfcWi0KYped6O13E5wkq/N08mYcZSpS8jksA=;
 b=tpld69JHoR2/LO/G5LNUQ70VpZMh0qCVrq6l4Ccb9ekOvcbIn7IltyTK0nSbgeRDsA
 lp2bopbVmqTIYGtBZRcJ34G4Fbd/YZA2T6ouXAyoMhZ5s6munyEFo0UYijcAhDPxnRFu
 CBtx8UKzMx/0SjB5eYiT7f4JUz+1xjL/BALd8+VlBW8FHMAz4RvJyX2c2sAh7zi9M6bE
 P2R/feEAigJWFP056t0ryaBL3gHI27ZDnAZbR2SDKoonmYG3sMGPiV8a6HtC0d7AS0EE
 ZW+uklpQLXLLRChwjvKCOKSe3V5xLRfgkM8pwC8fZGJxotEl9YruCBjRPbNw/2aynFB1
 gLiQ==
X-Gm-Message-State: AOJu0YwLYoyFZesk5/o91H1JTmSsix8puKR7J93VZXq+pNtYKTGf2ebA
 sG7K4/rAsROvmj1bnhK+NN86degmPblU+IkDwYlJ8+htTLZOlslfHYir4WhZBzhv5Q746TwqT65
 M16HiKhh64VvVNvnVL63kQnv96fO5AiuoWYdffQ==
X-Google-Smtp-Source: AGHT+IFwc84WnRS99LsEyqSrMG5tuR62Q6JTnWgdf7XFXIBWAnMTJYvyjIywNIxjRCaIdo3eBd05AvUP24SXbyUGPiE=
X-Received: by 2002:a50:d5d5:0:b0:567:504e:e779 with SMTP id
 g21-20020a50d5d5000000b00567504ee779mr19991edj.25.1711125550871; Fri, 22 Mar
 2024 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240322155810.5733-1-philmd@linaro.org>
 <20240322155810.5733-3-philmd@linaro.org>
In-Reply-To: <20240322155810.5733-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 16:39:00 +0000
Message-ID: <CAFEAcA_nFsWfXckLBJ72X6PTjmBYSRF77UoYs=gPB_GNshoyRw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 2/2] hw/misc/stm32l4x5_rcc: Propagate period when
 enabling a clock
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>,
 Luc Michel <luc.michel@amd.com>, Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 22 Mar 2024 at 15:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
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
> ---
>  hw/misc/stm32l4x5_rcc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index bc2d63528b..7ad628b296 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -59,7 +59,10 @@ static void clock_mux_update(RccClockMuxState *mux, bo=
ol bypass_source)
>          freq_multiplier =3D mux->divider;
>      }
>
> -    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
> +    if (clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier)) {
> +        clock_propagate(mux->out);
> +    }
> +
>      clock_update(mux->out, clock_get(current_source));

clock_update() also calls clock_propagate(), so this doesn't
seem entirely right: shouldn't we figure out whether we need to
do a clock_propagate() and do it once? (Maybe what seems odd to me
is that clock_set() does clock_propagate() for you but
clock_set_mul_div() does not...)

(Also I think we should have the information we need now to be able
to do the "reduce log spam" in the comment -- if neither
clock_set_mul_div() nor clock_update() needed to do anything
then we didn't actually change the config.)

-- PMM

