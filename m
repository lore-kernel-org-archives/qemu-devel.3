Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B3E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBlo-0000iu-BX; Mon, 16 Dec 2024 09:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBlm-0000iN-Eu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:08:22 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBlj-0007E1-Pr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:08:22 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f145e5cd83so33687227b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358098; x=1734962898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0GyJjjnZ37UxeSbRujj75zDGS5Zc2xrI0ozr18gJP0=;
 b=lAxkyt09Fn5VuXe+vhlHlDxLVnfT5ge5vwc0rwAe2YfhNsrJWUD+zSATWiqWnmjgVP
 1CIgSQw9cyLMT9hEj2iYEq70/O+BcImkMKZ85AFX6FXvpjUBkglDJ0NWZqJNmAf2b1xI
 WwllOF40XjQGzhEHWyynjtp2Vv7CGBSU5K2NbUjpnmX+EW2NNP03Ycl3C+LP6lIt8nWU
 0UYHRRwyPGTFMuDon49lEXVigMxMNzIkLzNdr0BYTKf3F+m/wy1ayWMzhHzSicwufPFV
 7yDGcrbZ/yqy38R6YmHkHy5WtgKzsC5aGZ9IAm4THK34bJ8+C++P4SkXtgLZ9aZSY9KL
 XdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358098; x=1734962898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0GyJjjnZ37UxeSbRujj75zDGS5Zc2xrI0ozr18gJP0=;
 b=on/trrsl+d5le02tViLNKTHKuqC5Jb7jvN8RYhkTQO0qD1BXjq1gWG4vEJGXy2mIuM
 tCcvAmMnxptTiPGGIZG+VQ8VYcw9mmIH83rhw5GaFIMaC/1rGEAPYmTCVUegU8JAWP5U
 VbP9EdRmvlKEg+yHb9Mmrild0Yrkd0L853W1UxCUvi5Gx0zNh80BGjL5mYffc7w2oblM
 ynh6cGVga+kJatD2pUIMB34qJ6QkQNKCQT0d22jbG+C/1J9Ofd8qAO7RcqJ6fiV9ytHp
 UW/dqEJIw3bBXc1GSA2AQeXl6ppxs/1F6xoijiRvT1030VTPEfIHlyojEotvXnKVY3nY
 VAVg==
X-Gm-Message-State: AOJu0YxMDCXmnrfy9FUi0LQ0aACnjsjw3v5tQdxAdIM1Cks+hpDisw4/
 FshAJGWYaYk5wMPK+KqKxVzCoNka6yLyef29B7e57o0GewlZNXbVDnfAg+q8+iRf5tN181oVTC/
 3f8aqFLIRKBktwFAkGRXmQm2y7pkpABXiIeCJ2SuhGGliazKR
X-Gm-Gg: ASbGncsSJqWTMYjaWRLHlSFifGkfDUhzXVG77rB9eJWAja0tkhgOVh/LnK2dE5SwTe7
 Wunr7d5p78T6ylh5cmk0s5IpR+oiSAd5HDZUYSos=
X-Google-Smtp-Source: AGHT+IGHI7ww0IgT30GDBuj4f1NsFwPnMgLXb6BGOS9hRJKPihfY46vY2jfVEf8j98FO/i6vf+iO7/2ffJJ9pBNM/nc=
X-Received: by 2002:a05:690c:ecc:b0:6ef:6107:69c9 with SMTP id
 00721157ae682-6f279adc3e8mr90559587b3.4.1734358098551; Mon, 16 Dec 2024
 06:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-2-alex.bennee@linaro.org>
In-Reply-To: <20241206160239.3229094-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 14:08:07 +0000
Message-ID: <CAFEAcA_TEaikCWjfMBNMc9Ra09+Zbt4X-9L-0ty=euxt2tLHyQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm: document the architectural names of our
 GTIMERs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Dec 2024 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> As we are about to add more physical and virtual timers lets make it
> clear what each timer does.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  target/arm/gtimer.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
> index b992941bef..de016e6da3 100644
> --- a/target/arm/gtimer.h
> +++ b/target/arm/gtimer.h
> @@ -10,11 +10,11 @@
>  #define TARGET_ARM_GTIMER_H
>
>  enum {
> -    GTIMER_PHYS     =3D 0,
> -    GTIMER_VIRT     =3D 1,
> -    GTIMER_HYP      =3D 2,
> -    GTIMER_SEC      =3D 3,
> -    GTIMER_HYPVIRT  =3D 4,
> +    GTIMER_PHYS     =3D 0, /* EL1 physical timer */
> +    GTIMER_VIRT     =3D 1, /* EL1 virtual timer */
> +    GTIMER_HYP      =3D 2, /* EL2 physical timer */
> +    GTIMER_SEC      =3D 3, /* EL3 physical timer */
> +    GTIMER_HYPVIRT  =3D 4, /* EL2 virtual timer */
>  #define NUM_GTIMERS   5
>  };

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

