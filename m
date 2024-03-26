Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2300C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 04:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roynT-0001IG-Fx; Tue, 26 Mar 2024 00:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1roynP-0001Ho-B2; Tue, 26 Mar 2024 00:52:23 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1roynN-0000c6-BV; Tue, 26 Mar 2024 00:52:23 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4d44fb48077so1880945e0c.0; 
 Mon, 25 Mar 2024 21:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711428738; x=1712033538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Se6h2sk+23XBqGDt5WxIERqzHReoO5syAQ+oMHecUs=;
 b=ekCbDmoAK4fNbWPuRN4e/zdYj0vCiAM6DbN5vWfVYvBAGUQG5dHXEKnUFZacn+fxgc
 khaontMOLnnZadObQSuO0powX7AY5KNnwCWx49oYWwjW+xje+/S8dwsJK3M4MFLuaCBu
 gcBmorrEDy2h/mSx4SpD7mmdmM+25Tco0votFmDKAylCEeBE4zrUHvDOLlazMYB2b9Re
 /wCDF+/iyunuTPIFAJ3ow2maR30/Kyc7LTImE/usQXpVVvlRZCfbLPt93fUIPyFQ3E7G
 26bdiEic4bEmyFp5gbCvZ+JCoCXt3VUKo5SkbZT3Y2JaGeJ/pek4NCUgcjxVMoPxIuy1
 //Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711428738; x=1712033538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Se6h2sk+23XBqGDt5WxIERqzHReoO5syAQ+oMHecUs=;
 b=RvfjoFdtPXs/9Wn5BhMi9IAtuf5DWWrIo/frc2iQoZvxfsCa3Opkh3aWvu9CWLdtQ6
 BGD9Llfc40SSE//6js2+u+jLooZrV0fbBF/wWl/c77MnVoJfC1WQt7ZR1DM/uxb2pG9Q
 QWx79tZmNHaC4ogAPYp+9ioFtWyq9Q6agnyImzGd+zGtv16t/vvgKrn34nH7i1qunw1z
 qfpQbgzg33AK5B6nVmEulRHj0zjpm94qqYq6+RHrgSzJ1NocJTPI+33UxUIVEBSzjUd6
 lDxBrfhvYo4lzJBnx/I6LE1ZINFY9rVhnl8USNKqJLUg3icVPXbigwGTblOEM6nbXPXX
 4MMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXs+yz9RVmfbx91Q4BEFj+6+n0srZqCznlMPiVL/c9waq7O+99PpH+TWi+0+oUWsG9Pxst7t4XJ/LDrVA7wMfTkgd
X-Gm-Message-State: AOJu0YzsCIehDcXOrtAVyD5OBgsoJH/nzx3JeIHbtlB9xexptXDqVjWC
 1I0cMRc3fK4gINb4egf2n0KLgpHWYA1pxizYUSTjDiR9LEH3ruH1NHda+LoYZ2CfeOvHQrgfOgY
 VQL47PqHD4C82NDeKwsopaJ68X6s=
X-Google-Smtp-Source: AGHT+IFgbyD3FzbKl3BIlrgcYAVeawvt7psWrtPAN1/xCVybEowpZC7B3D6uyxCL7GL/vss5zHoneZc44Nxn8uO0IVg=
X-Received: by 2002:a1f:cd02:0:b0:4d4:2fc1:b252 with SMTP id
 d2-20020a1fcd02000000b004d42fc1b252mr5209944vkg.6.1711428736732; Mon, 25 Mar
 2024 21:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240325152827.73817-1-philmd@linaro.org>
 <20240325152827.73817-2-philmd@linaro.org>
In-Reply-To: <20240325152827.73817-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Mar 2024 14:51:50 +1000
Message-ID: <CAKmqyKMfYDrs07yNhOp+3Am-LTmwupcmA8aWxLRSnBUeP6qJaw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v3 1/3] hw/clock: Let clock_set_mul_div() return a
 boolean value
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>
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

On Tue, Mar 26, 2024 at 1:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Let clock_set_mul_div() return a boolean value whether the
> clock has been updated or not, similarly to clock_set().
>
> Return early when clock_set_mul_div() is called with
> same mul/div values the clock has.
>
> Acked-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/devel/clocks.rst | 4 ++++
>  include/hw/clock.h    | 4 +++-
>  hw/core/clock.c       | 8 +++++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> index c4d14bde04..b2d1148cdb 100644
> --- a/docs/devel/clocks.rst
> +++ b/docs/devel/clocks.rst
> @@ -279,6 +279,10 @@ You can change the multiplier and divider of a clock=
 at runtime,
>  so you can use this to model clock controller devices which
>  have guest-programmable frequency multipliers or dividers.
>
> +Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
> +the clock state was modified; that is, if the multiplier or the diviser
> +or both were changed by the call.
> +
>  Note that ``clock_set_mul_div()`` does not automatically call
>  ``clock_propagate()``. If you make a runtime change to the
>  multiplier or divider you must call clock_propagate() yourself.
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index bb12117f67..eb58599131 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -357,6 +357,8 @@ char *clock_display_freq(Clock *clk);
>   * @multiplier: multiplier value
>   * @divider: divider value
>   *
> + * @return: true if the clock is changed.
> + *
>   * By default, a Clock's children will all run with the same period
>   * as their parent. This function allows you to adjust the multiplier
>   * and divider used to derive the child clock frequency.
> @@ -374,6 +376,6 @@ char *clock_display_freq(Clock *clk);
>   * Note that this function does not call clock_propagate(); the
>   * caller should do that if necessary.
>   */
> -void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider=
);
> +bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider=
);
>
>  #endif /* QEMU_HW_CLOCK_H */
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> index d82e44cd1a..a19c7db7df 100644
> --- a/hw/core/clock.c
> +++ b/hw/core/clock.c
> @@ -143,14 +143,20 @@ char *clock_display_freq(Clock *clk)
>      return freq_to_str(clock_get_hz(clk));
>  }
>
> -void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider=
)
> +bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider=
)
>  {
>      assert(divider !=3D 0);
>
> +    if (clk->multiplier =3D=3D multiplier && clk->divider =3D=3D divider=
) {
> +        return false;
> +    }
> +
>      trace_clock_set_mul_div(CLOCK_PATH(clk), clk->multiplier, multiplier=
,
>                              clk->divider, divider);
>      clk->multiplier =3D multiplier;
>      clk->divider =3D divider;
> +
> +    return true;
>  }
>
>  static void clock_initfn(Object *obj)
> --
> 2.41.0
>
>

