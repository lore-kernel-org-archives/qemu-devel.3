Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF50C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJgr-0002O0-8H; Tue, 04 Feb 2025 09:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJgN-0002GF-3U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:13:44 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJgK-00031T-5V
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:13:41 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so5655980276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738678419; x=1739283219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nlu5T2bogCzgYYiWWaNBgtj4Bx6LB5+nciCf3px8pb0=;
 b=kDJG6qIllszQYaTmGBzr7Tv3MACeZorUKsYKulvXJfp/Gh4OJUDQRgaZmhtc+d5UAp
 qXHa6PNwjM+7U1bkrUrpqczU77PaTqVINjzzN5aN4LmaIl711QZPKGJ9PnIOQVtIRH9r
 0KNK+plsecQrCcveDfzK8kADyfV03VWLVc4ADF9N8D4GBG4uBK2pah1hWb65a6tR3/Fv
 7nLIWa+44fjGPBoz92CPJY6vYLL9kGX6P1NSPr02HQWt2dROynOntMtDFNXKd6jBnIPp
 n5YvPBL/Wpmad/vFBaOxJgqc1N1Qe/DfQpysNJHjOvhZsVo+IVV+8AswArMnt6lef+dc
 aqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678419; x=1739283219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nlu5T2bogCzgYYiWWaNBgtj4Bx6LB5+nciCf3px8pb0=;
 b=cgGZxp872Sn2nY5VfTe2KFQAcxgCLWrgKYyVwL+MMTPLMnL3RbsmX/Y6z/ikeVgScs
 fcFf2Kj01qQRIa/4pQwRIBQGfovJbK2ZWhoO4k/JBeUAV6IBa6VDv8ICjV/6pBseB/w4
 wdeC9kKFOxIrkj7800/e+lLkUBbeQpB8QOg9WUA1TAFnl+qmZHHAlUJV7qrYkiQWLcAF
 jwPU/cl5wgsSDRb5f4WOFvfhApLt5muvKLyZ2J4rJk34ETK4r4KMZARKrdJsiFS/rDti
 tU31TbzAk6OjLRPF/bJ9kUrx8UvL6Px3+2GGY4QtAweW1poguCSofJoKNhJNLGmcg2sS
 79KQ==
X-Gm-Message-State: AOJu0Yx0O9cht5yLsj6UZKGxiP+qmdLuwRNoAMCnrLDXlRImhrO4i6qp
 jTJTJgQlf/FK2rmu+Vf4CMxVK1FP0gtOXHUWwE0kBjo3/JStE5XtGoQ/6rHSFPI20RFJn9yp8GP
 qWUEXwRYVVbKNibNzcq88pJJS3tW3GE8UdPCvY2YjI5f5oH1i
X-Gm-Gg: ASbGncuKJWrpt9SaTQ7I5htRfOTeWZwi4gOH3FDSe6uKMHRGm8rAhuM6g3eGzllnOfh
 Y7sZDCn2czaEM+x6DDwCnWFXzUhV9sf0Gr+yBv1qJ7kOljGg2fxcpJA3U7BM1kyi+qpdBmAQ6tw
 ==
X-Google-Smtp-Source: AGHT+IExUoMvTgVWXxVbRc1VZD9eljqmq7MTIcSQXRQiaPNUD63K40YB777ce+5JssZnBasDRM/Jbym+aKpMV5psyGo=
X-Received: by 2002:a05:6902:2e04:b0:e58:3990:3f77 with SMTP id
 3f1490d57ef6-e58a4b02ccdmr20490317276.22.1738678418591; Tue, 04 Feb 2025
 06:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-9-philmd@linaro.org>
In-Reply-To: <20250130182441.40480-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 14:13:27 +0000
X-Gm-Features: AWEUYZlm_bASjdgxOE3Y52KoDiyX0THDP9sh1OAgHWGMw2WMkCmYZ2THVFVFyu8
Message-ID: <CAFEAcA-ZtcP8epex5rJ5Y5F1mS6aURkaeJdzVZJ+Nty3uStZ4w@mail.gmail.com>
Subject: Re: [PATCH 8/8] hw/cpu/arm_mpcore: Remove default values for GIC
 external IRQs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
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

On Thu, 30 Jan 2025 at 18:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Implicit default values are often hard to figure out, better
> be explicit. Now that all boards explicitly set the number of
> GIC external IRQs, remove the default values (displaying an
> error message if it is not set).

> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index 3b0897e54ee..372b615178f 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -58,6 +58,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error=
 **errp)
>      bool has_el2 =3D false;
>      Object *cpuobj;
>
> +    if (!s->num_irq) {
> +        error_setg(errp, "Property 'num-irq' not set");
> +        return;
> +    }
> +
>      gicdev =3D DEVICE(&s->gic);
>      qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
>      qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
> @@ -146,13 +151,7 @@ static void a15mp_priv_realize(DeviceState *dev, Err=
or **errp)
>
>  static const Property a15mp_priv_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
> -    /* The Cortex-A15MP may have anything from 0 to 224 external interru=
pt
> -     * IRQ lines (with another 32 internal). We default to 128+32, which
> -     * is the number provided by the Cortex-A15MP test chip in the
> -     * Versatile Express A15 development board.
> -     * Other boards may differ and should set this property appropriatel=
y.
> -     */
> -    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 160),
> +    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 0),

I think it's worth keeping at least some form of comment here
to document the valid range and that the value is internal + external
interrupts. Something like:

    /*
     * The Cortex-A15MP may have anything from 0 to 224 external interrupt
     * lines, plus always 32 internal IRQs. This property sets the total
     * of internal + external, so the valid range is from 32 to 256.
     * The board model must set this to whatever the configuration
     * used for the CPU on that board or SoC is.
     */

?

(I suppose we could also actually check the property really
is between 32 and 256, but a simple "did the board actually set
it?" check like you have here is fine.)

> @@ -160,13 +166,7 @@ static void a9mp_priv_realize(DeviceState *dev, Erro=
r **errp)
>
>  static const Property a9mp_priv_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
> -    /* The Cortex-A9MP may have anything from 0 to 224 external interrup=
t
> -     * IRQ lines (with another 32 internal). We default to 64+32, which
> -     * is the number provided by the Cortex-A9MP test chip in the
> -     * Realview PBX-A9 and Versatile Express A9 development boards.
> -     * Other boards may differ and should set this property appropriatel=
y.
> -     */

Similarly here.

thanks
-- PMM

