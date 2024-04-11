Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6A8CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 11:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rusgD-0000Ro-BI; Thu, 11 Apr 2024 07:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rusfm-0000NK-Qe
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:32:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rusfk-0006Fr-Eo
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:32:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so5572451a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712835171; x=1713439971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKW27QqBx2ht5r59ew3GF9HDkfUQawGcCPc7HVvCMwk=;
 b=Y6V/KAYks98/K5ima+xgnU4xKC61hkhQ+gDslVxqftOg8EoQSsOWW2RRXBvCjJGVLQ
 lvkpbQAyv+NA42dB0I8Mu8kcEhJ5rm+KyWtaxC9pKLA5oJv+hzwGvdf1hD2B/wARMcXi
 Fcn3MJqYsdmmrr0XkSr4jjrVH3fK/bV1JJgtchJhz50MKBsfPpI+NMnK3K9QE0WZzGT5
 DZ9CxpKHolrL9RO1ZrTcYMu1LnTkTR/Jeewo8h/vqCEUV1yYjInNIXgQSztwS/dG8Nfv
 LzpTyqXpW4AouqePrzq8gbZS1bSkCk1kiHdYkUJe+daP9PUNpN1BMHtqYy6f00HHDtWb
 qong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712835171; x=1713439971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKW27QqBx2ht5r59ew3GF9HDkfUQawGcCPc7HVvCMwk=;
 b=XF7P+SthdddSDBztWLfQ9IxMKBkgbRx8z1G8U98Mk/shHE76Du1WJdS4vUNRHMIEzn
 8o4ACTxrYYBIfD+/FPSjs2w7oPv1mY9B6lxyd2651OMUA1U9blSKpK+EXZZeY+CaGTt0
 YKnOi3jIjgK4YkF+IHG+LOfNtLVRwc7n7yrJ89080KdgJxFzzi21GlkL3eaLW3H0nFiE
 fYnDHgmOhS95jACfTF7L9K5HKLZuzNC+z21d5I+z7UuHbq+6EPWPDy+sE1z9vAQGUko0
 zCurWLl/3OF97jjcphMpIrX/wUduWkejj9Lsgh1jmkFHv8SgyKSfMW/NzYP6EfZjpWb6
 z7SA==
X-Gm-Message-State: AOJu0Yw5QpJhRoq00ieWCcOlKr2Gi6pFKIToNhKjlRLNgY+An1ErJlvK
 Smu3YyWdyW9X/cUVAX0yRd6rYYo5uqkP9Z+nJubuQNuMPNrrIownKGa006Dkz0se5O2e3VGXjK2
 5C8jUqyyb00slExg05IFUXxDkcoJJl9ZQhyThTQ==
X-Google-Smtp-Source: AGHT+IGMxi7mNHEK6ElvMbN4l63YR5wesesQnIfm9RF0dY01ebFD7Y80oJeu2PAOm2Bf+bA3LO2YipHXiRtbAc1d6P4=
X-Received: by 2002:a50:8e50:0:b0:56d:f3a7:60e with SMTP id
 16-20020a508e50000000b0056df3a7060emr3752165edx.22.1712835170769; Thu, 11 Apr
 2024 04:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-9-philmd@linaro.org>
In-Reply-To: <20240411104340.6617-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 12:32:40 +0100
Message-ID: <CAFEAcA_2=3-jCR0FDPAE=Y-wG+LCx-Pqq-Oe4ageuUi=beGCrw@mail.gmail.com>
Subject: Re: [PATCH 8/9] target/arm: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 11 Apr 2024 at 11:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/arm/cpu64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 985b1efe16..f0f4fe6714 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -433,7 +433,7 @@ void aarch64_add_sve_properties(Object *obj)
>
>      for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
>          char name[8];
> -        sprintf(name, "sve%d", vq * 128);
> +        snprintf(name, sizeof(name), "sve%d", vq * 128);
>          object_property_add(obj, name, "bool", cpu_arm_get_vq,
>                              cpu_arm_set_vq, NULL, &cpu->sve_vq);
>      }
> @@ -458,7 +458,7 @@ void aarch64_add_sme_properties(Object *obj)
>
>      for (vq =3D 1; vq <=3D ARM_MAX_VQ; vq <<=3D 1) {
>          char name[8];
> -        sprintf(name, "sme%d", vq * 128);
> +        snprintf(name, sizeof(name), "sme%d", vq * 128);
>          object_property_add(obj, name, "bool", cpu_arm_get_vq,
>                              cpu_arm_set_vq, NULL, &cpu->sme_vq);
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

