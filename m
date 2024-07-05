Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC4C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfdm-0005GT-2X; Fri, 05 Jul 2024 05:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1sPfdk-0005G1-TU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:54:04 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1sPfdj-00056G-CQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:54:04 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so854679a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720173241; x=1720778041; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcMAES0TeQejEHoI81Ev3/AnWZuhBypgA5sKzzUCOt8=;
 b=Smlpq86QMOgIX92mi72Mf+SwXEs/WnSJfWjmhHrA7gDheucqpJ1SiOI1OMuqy8zsQk
 A6LAMOVHtSnuXJWR7SMDl9WnRcs90f3kwgzBhC/oJ+CyeVvcIuFGJne0/yTXhUrNKIa4
 nL4RSW7I5N4jX4DbZ57pXwuyHE5pW1bgrLIDV3PrxZoow3OscalJet0Us/D3bJvvSotk
 3KecLc/nGCHuTOLHs+VDxG+Iz1YZhVchwXEpchaOAFzv0iylAnF0HHUtbLfpi8z7f9z2
 PAwhHDD5+E7PpIG3p41XHJ267ePMtfyBpoEkafyH3G7kFD+VzKREzdT1ewm2DdpzNCst
 Vopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173241; x=1720778041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcMAES0TeQejEHoI81Ev3/AnWZuhBypgA5sKzzUCOt8=;
 b=UAU455kzlRHGUwHRPP/pWuoL0El7r30MM7KYC6kDaP0awus73YtAEwKWPM8hEY6ICR
 J565ash5xr6/gZstEl0kNXsT4BP6VVP1fMo3Smphlo2amR1CSjEzFPrRjoGJSgRmD861
 A32zeT1D3Y3OjMToA/qYZWgjTX5U/+v+e12Hf3XQ8ke/LFO2ARHxpXx3Ejv4UZ4Q8So7
 AnaG4VmTGMG3AN4ulSQ53nJQV0YPshEc15vT8j4tm2kZXr0X9F4nTL7Pr8LwBl3qleU/
 APGvf8ixIExr0JI3cbS+X2wcAnSN1MRm0+CcNIi6/adxtCoz/fEbsdOVeEQRRVCQ2M5u
 eflg==
X-Gm-Message-State: AOJu0Yx3tpB30pBqXb0ux2c+PdFCGyksgU2cZllaFCADfwix56A1K/1j
 1UlFp6N0MslwhXpBCyHzg1IzUHC5lN66PWH2vZ2RXRyFq9mK88eGc/Izs5LGFP2oCEaPdeUkUXH
 bFAW7Ly/RwASDfoBMcE0mYWPn/Eg=
X-Google-Smtp-Source: AGHT+IHbevoFcimZPyCfD2nOYPgUlarQqfDK7erCyDV+7sPfb0OPoxS5CriTdWU8S4JjBK8PFTJzFk8F+hbsncnoc8w=
X-Received: by 2002:a05:6a21:6d98:b0:1be:cc74:5818 with SMTP id
 adf61e73a8af0-1c0cc73adcamr4028225637.12.1720173241471; Fri, 05 Jul 2024
 02:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240704124904.276603-1-alex.bennee@linaro.org>
In-Reply-To: <20240704124904.276603-1-alex.bennee@linaro.org>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Fri, 5 Jul 2024 11:53:50 +0200
Message-ID: <CAGQJe6pcN0hL=F=+sTSeBzA2ZGvEMYQ49mFmJQbnqQRu66xe0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/core: ensure kernel_end never gets used undefined
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=arikalo@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 4, 2024 at 2:49=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Really the problem here is the return values of fit_load_[kernel|fdt]() a=
re a
> little all over the place. However we don't want to somehow get
> through not having set kernel_end and having it just be random unused
> data.
>
> The compiler complained on an --enable-gcov build:
>
>   In file included from ../../hw/core/loader-fit.c:20:
>   /home/alex/lsrc/qemu.git/include/qemu/osdep.h: In function =E2=80=98loa=
d_fit=E2=80=99:
>   /home/alex/lsrc/qemu.git/include/qemu/osdep.h:486:45: error: =E2=80=98k=
ernel_end=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized=
]
>     486 | #define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
>         |                                             ^
>   ../../hw/core/loader-fit.c:270:12: note: =E2=80=98kernel_end=E2=80=99 w=
as declared here
>     270 |     hwaddr kernel_end;
>         |            ^~~~~~~~~~
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/core/loader-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 9f20007dbb..7ccc9d5fbc 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -267,7 +267,7 @@ int load_fit(const struct fit_loader *ldr, const char=
 *filename, void *opaque)
>      const char *def_cfg_name;
>      char path[FIT_LOADER_MAX_PATH];
>      int itb_size, configs, cfg_off, off;
> -    hwaddr kernel_end;
> +    hwaddr kernel_end =3D 0;
>      int ret;
>
>      itb =3D load_device_tree(filename, &itb_size);
> --
> 2.39.2
>

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

