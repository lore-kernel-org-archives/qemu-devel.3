Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40662C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricOH-0005kn-Nl; Fri, 08 Mar 2024 10:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricOC-0005ie-6O
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:44:04 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricOA-0002ms-Lo
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:44:03 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso2407085a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709912640; x=1710517440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yjIHGI8PiVw1qzNmSWLp6HHD4/WeGG/5twfE1v2y2s=;
 b=Na/e+wNV9gRApgR54qvSRNFPKG7zYdzIiC3cZIm7YP+uv68rJbPYGU8tyt+5G5ICDW
 Lg62tMAxAQ+fLg8FqgrKmkvGozPa3H2v5i9nV09TlBT8mL3n6CJUpJz59Wap1j2kA21X
 aGGMDqJHIDX/Xjdk048Eb5m1UaItMiWcEyHAJupCBMMuXUv3zOOxw9nyETnYrYXOiLOE
 NtEOpCTPLhXDl64u/fTpifsQy/v4XsZIT0tiyxnN3Pzte854H6CR77KNT4QZjfT3T1rg
 T8TVEUS135CCLK5BVPq5DevN9DK7z2HXho+cAP+AIbtqq3dZg6J2sqRRIH0dg20mJUUs
 KcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709912640; x=1710517440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yjIHGI8PiVw1qzNmSWLp6HHD4/WeGG/5twfE1v2y2s=;
 b=iEFL9g4yF/BuhwYAz4ffDdyybXt28Oveow9ia9hOdvrrzF/UFwJeHv8uZoKXPPmVat
 STEa4eWHLR9kkO/d4HUpbQbWijsiXtbIZCfqwNNU3a+SHNBywTh3f+2ryvxIa9xQ8ZqH
 6GAwdFVEMdTt5uGjUtEmubjDrvWirqfchQwAdhYHRUVEh4C666VJfdfoFMeSK2jXc0yh
 A0/KRs3YDuEeAX7u9mBuAgx1O+PRfSOCL1opkmoa+S3984Z4dIG/obwHWPbZ5Tfqm9Rt
 WWfyBZo+Dg+oMfV0I1mgZPGrfyhR/VPk4GD5jBxk9sxyExlcTZV95bohiaiHe0yvBbLl
 0hEw==
X-Gm-Message-State: AOJu0YxN7RxknKoOhBQ+5gGk8tx9BxlWAtBVvHNVa29nARcfjkOjW+mg
 9usQdZD5U9baSWkBD2a1pdvLvoahU02uwMF6ge+jn7WUz9D2RtFVaooZkPWxBh/joI6TsCR3vRY
 5OTj3XTqHrC8yyGgyfTGZFEaGlHR/hjbQuhlmvw==
X-Google-Smtp-Source: AGHT+IEUJhCDxAYhFVGIiT4alT8yVf0AO7npBarUj7+6BQPQ9BKIPy1Gzx+EadZw8E4e7zKrj/63s7Cr9FsFh8VLbzY=
X-Received: by 2002:a50:ccd6:0:b0:568:3362:cccf with SMTP id
 b22-20020a50ccd6000000b005683362cccfmr913267edj.7.1709912640090; Fri, 08 Mar
 2024 07:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20240308152719.591232-1-chigot@adacore.com>
In-Reply-To: <20240308152719.591232-1-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 15:43:49 +0000
Message-ID: <CAFEAcA9AmjW-7u2Vkv8vdrKLgq_5zWZ=mEXBQmSRvFsqtoKjrw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/grlib_irqmp: abort realize when ncpus value is
 out of range
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, konrad.frederic@yahoo.fr, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 8 Mar 2024 at 15:27, Cl=C3=A9ment Chigot <chigot@adacore.com> wrote=
:
>
> Even if the error is set, the build is not aborted when the ncpus value
> is wrong, the return is missing.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> ---
>  hw/intc/grlib_irqmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index 144b121d48..c6c51a349c 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -356,6 +356,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Err=
or **errp)
>          error_setg(errp, "Invalid ncpus properties: "
>                     "%u, must be 0 < ncpus =3D< %u.", irqmp->ncpus,
>                     IRQMP_MAX_CPU);
> +        return;
>      }
>
>      qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

