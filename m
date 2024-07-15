Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47151C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 07:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFrJ-0004Pj-Fv; Mon, 15 Jul 2024 03:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTFrH-0004OD-NP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:10:51 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTFrG-00005l-4F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:10:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5854ac817afso4862130a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721027447; x=1721632247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2ZV8Ynk2UAY61Xzvah8MCDUqfL6LoAdSbCSpT3H1FFQ=;
 b=Xn41M6IMja0Dh3OkC41LsGQv+kze71GFSyfinIKGYR24YfJ3o/lga+ROjxifdEz4PW
 kebdIEO2ZIfRQ/KmU+HFjv9y8FJJC4WlD/myPGpLBSO44AFv/d++nW7JD+QYa4t4+qRo
 8nsADB9KRUzn8JEs0FehL6Lmg70I6jOSurf1Wy4ZCSoNX9HiETniF9ggrytsFgcsIb27
 5mP1o/ifXIVECC5V5mQZyyCX8k1cbimJjc/UUjqMR+YtVNmQoGDtcHjG+X0oqaiIriLa
 xTqimsBn1LmVBQp4DWGaLlNU8rzEVawpZ43/8Bf99Ckk0dypueeTWq4YXlrszMpGA3aL
 7iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721027447; x=1721632247;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZV8Ynk2UAY61Xzvah8MCDUqfL6LoAdSbCSpT3H1FFQ=;
 b=gGbCozPsoOwVK2jG9EtvIt69rt9tI1Rkat9Zr45Unh4NHiHe4HkoUvNh/FgUyQI/rP
 uHh3KGxjR27aj4dIQQfHIeBfzHuLZK94zxP08e+6/Xq+7XrwEg8RewBV09/U08dicK2W
 ZUSu5k99ekWkkaayk40bfaKvzhR1u7FVo39IbpEjpfrQbGHOtYch1mUiWJAsJk6X7p9h
 t2dkP0aiaeCurpMniibDuVdDmhSxkXrT8zw3PSLiSoH7c0YGLj2M2VIRHDkCx89TheDa
 P+ds8TeuoSMPWbY3Uu/8wgYcxMKkbe9izqW6IycA0z44VTdYp43Iq7g+JnV9QncAEERg
 Qe1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4XSa1F1MoNZpSNgru56n1iq7fNkCU54gWIBr2wMGNOUmGUboJWvMIbXnjxqpHa5oO/pZig7HGAuYOVgYDJxndgC9JfHY=
X-Gm-Message-State: AOJu0YxwAchfz08inBVAANeZMearhvZ8b7Pk2r7njzXGqYw5FRCNiS+q
 5c76FS1SVszR2MujQ3vhb0Spd+aFmof3kBcVs8IMISeT45uhGmT322DC0TWNMcY=
X-Google-Smtp-Source: AGHT+IFn9kOYkzDu9OJ4df9frilkoLssi5X445Sl8yESH0lpbN1kupFoU6rjbviCUXJHatby5T40GQ==
X-Received: by 2002:a05:6402:5187:b0:57d:6326:c658 with SMTP id
 4fb4d7f45d1cf-594b7d840admr15167391a12.0.1721027446772; 
 Mon, 15 Jul 2024 00:10:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a77201sm3044048a12.8.2024.07.15.00.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 00:10:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27B705F8CC;
 Mon, 15 Jul 2024 08:10:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Use -fno-sanitize=function when available
In-Reply-To: <20240714-function-v1-1-cc2acb4171ba@daynix.com> (Akihiko Odaki's
 message of "Sun, 14 Jul 2024 19:42:13 +0900")
References: <20240714-function-v1-1-cc2acb4171ba@daynix.com>
Date: Mon, 15 Jul 2024 08:10:45 +0100
Message-ID: <878qy3166i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
> -fno-sanitize=3Dfunction in the clang-system job") adds
> -fno-sanitize=3Dfunction for the CI but doesn't add the flag in the
> other context. Move it to meson.build.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  meson.build                | 1 +
>  .gitlab-ci.d/buildtest.yml | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 6a93da48e1b5..80447833f07a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -609,6 +609,7 @@ if host_os !=3D 'openbsd' and \
>  endif
>=20=20
>  qemu_common_flags +=3D cc.get_supported_arguments(hardening_flags)
> +qemu_common_flags +=3D
>  cc.get_supported_arguments('-fno-sanitize=3Dfunction')

What about checking the other hardening flags?

>=20=20
>  add_global_arguments(qemu_common_flags, native: false, language: all_lan=
guages)
>  add_global_link_arguments(qemu_ldflags, native: false, language: all_lan=
guages)
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index e3a0758bd9e5..a57822d65182 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -430,7 +430,6 @@ clang-system:
>      IMAGE: fedora
>      CONFIGURE_ARGS: --cc=3Dclang --cxx=3Dclang++
>        --extra-cflags=3D-fsanitize=3Dundefined --extra-cflags=3D-fno-sani=
tize-recover=3Dundefined
> -      --extra-cflags=3D-fno-sanitize=3Dfunction
>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x=
-softmmu
>      MAKE_CHECK_ARGS: check-qtest check-tcg
>=20=20
>
> ---
> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> change-id: 20240714-function-7d32c723abbc
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

