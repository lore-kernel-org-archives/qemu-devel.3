Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6422BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2aB-000285-IA; Fri, 14 Mar 2025 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2a9-00027q-OF
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:48:01 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2a8-00086S-4o
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:48:01 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6fead317874so16855917b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741949279; x=1742554079; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSjsvE1dNi9hRuVJPjIqokxOEex8D7F5p517hdaJ4uw=;
 b=o+QwK0P57qx1/p93h3mieEa828TlsgWh4E/RQo55Px24Q/eCHMyg25qn1+fktbqPUw
 efcMfXXwkujC5ttZ5cOFK2nOnIKns+KbwDmhR2xlNBf2hZUM3SXho4SrldaC2Lrryczr
 SoY10Lr2rd+FgM+TaRie2II6FbBlqGWq7P8Z+9NNp/MvAltVlHsCwRcYyPkkdy/PXV9n
 VSo6JHEDAEacTWCu8FjYR0QZp7K/RwJO/zm8ZkvuUIZXcdvC2f7hCmlOal1JKKnr676o
 iPO4VPk98eIhEiJpTbNfxjsfCtquYGWxeoZUf8U4Azs+KTk3joKRHZ42OdlKCDGFu98X
 GFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741949279; x=1742554079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSjsvE1dNi9hRuVJPjIqokxOEex8D7F5p517hdaJ4uw=;
 b=G7ljPr1FY3Szf/lGwRTckK/Jjw4Gd9pr6IhkSTwWx/RWDFrbVnShwoPgqqZ64t7axM
 hZlqxx6K9w5fWrgHfXgO52acwily53W0i2VFp9GT/DRno988lcH2DENKbrJzkgAdAKzd
 DZSY5lJEFn1cR18c11vRx2eiLl0trZmhJVTlygH7pPuUb/lhbAfEDFtZr1gp3T0b3PY+
 +nexoeQA965UcJGKuqM4z4j6xazmtrA+lsj33HVf1TODYtNHEaQuZBHEyVUpPm1uBRIe
 dY8vB6wodkttH0n5rWoRjMceSzugvwkr4Ty1ZU3Ik/tr5N6oZydpWpyKUGf+0OdTXfsP
 /WJg==
X-Gm-Message-State: AOJu0Yyf4LWcNoepTDLWVlzPidWzzjpJ5hDe7JDmkqMuYtNhkKPuVfAH
 iYLmtmCqO6cfCZWV6kYWKc4TgDy8p3Zoxc06gR6MiGVExrxSx9rRtrJjgxrHZFFafPfqJdv8CTu
 YzimkNiXYsyXy9Ca61Cuy+DcR7kcb75uzvDBbOA==
X-Gm-Gg: ASbGncvlfthYEkSyhAoLhtp0qZDDV4m42jrndQqvFyOAkt0vWfSpodIziSfZ6Rs1+Na
 IhTQ0ACeq+jQOu4AJxmJuEibB3VlTMiWCFHTGTDdtTpDXo3z0sPUrGRk4c6kqwnoMxMJ9QFpJC2
 9Xbvf4HOq0a/35hk8NOY6yyjyFqRQ=
X-Google-Smtp-Source: AGHT+IGy6FAW6i6kbd9JemBk+3cRwQGwfdLzDJrLnteN3TN3885IvmF/H/TEAaksXmP5X1dZeuAh25qxGT1NSjho01Y=
X-Received: by 2002:a05:690c:380e:b0:6f9:50aa:8605 with SMTP id
 00721157ae682-6ff46024a48mr20655087b3.34.1741949278771; Fri, 14 Mar 2025
 03:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250314102307.2806696-1-alex.bennee@linaro.org>
In-Reply-To: <20250314102307.2806696-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Mar 2025 10:47:47 +0000
X-Gm-Features: AQ5f1JrGBzoppu3XtBt6jeGwEHwxzjXByjXyZPKX4WMWYwGYeBwArhmp_mudPj0
Message-ID: <CAFEAcA-P+h+Aj5ZSyxvQZ7-gTzqdzKP_aQ4f3z+dYjQj2msYOA@mail.gmail.com>
Subject: Re: [RFC PATCH] meson.build: don't bother with split-debug for windows
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 14 Mar 2025 at 10:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It was reported this breaks the final artefacts on windows when run
> under Wine.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  meson.build | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index c2c71b6f8a..9b1af6d030 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -601,8 +601,10 @@ if get_option('tsan')
>    qemu_ldflags =3D ['-fsanitize=3Dthread'] + qemu_ldflags
>  endif
>
> -if get_option('debug') and get_option('split_debug')
> -  qemu_cflags +=3D '-gsplit-dwarf'
> +if host_os !=3D 'windows'
> +  if get_option('debug') and get_option('split_debug')
> +    qemu_cflags +=3D '-gsplit-dwarf'
> +  endif
>  endif

Can we have a comment saying why we need to special case
Windows, please, preferably one with a URL to a bug report
about the compiler problem or to where it's documented that
this option isn't intended to work for Windows ?

thanks
-- PMM

