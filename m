Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C83FC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetqt-0002B6-DA; Thu, 24 Jul 2025 07:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetqk-00027I-VP
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:11:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetqj-00039w-6x
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:10:58 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso1604883a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355455; x=1753960255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keXKCvnGJc52LSMXS3MsCy/799rpMCNJ1q5oNdxpLkE=;
 b=rwNKHXH1uomjFOg+CBr82Zow6jXl+vQ/b7iSeE6dDiHRmF4Z4ClwbALN/pm0oxIJXO
 J6bvO8bYjeQnowEh++vSmcc6YnSTIT2HlPYPOzIk1izK7xlJ3AIkabco/QUHlMw8SUf8
 qfuW6b/Zda0WMsvoFQzcEUfRVbLKNW5lk9qiz4zKHtwgaMTnER1xbETKzZskFJoPerh7
 ju0vM0fNiUTud00z1JgE7cMxcl9HtEGBIYgbE5aNZ0unBWtBA7YLxwTUOz0m+vlcGR0B
 9gO0Lx1axf245vA1dBxbLi1+d0cfd6/uTKZdf8BZphTVBTTU6HslRGl8dNezU+xIgb80
 HLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355455; x=1753960255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keXKCvnGJc52LSMXS3MsCy/799rpMCNJ1q5oNdxpLkE=;
 b=A74bzfAxqnFcdxps/IDdeS2gty887VZOpyskUj2ShC5s1ZgwdqPMZB6lCnT7pDbXTd
 k66anPBx2gEFFRmysu+6j5PgDnKBbK2fZxT+CJlMz+s7LcZUWJJ15F4R+nSAd9KsHGUl
 JdVXZ4+t7U8I9RDGcDDXMkiKroe2LxLknfRduN3gLUnVt1vu+yazrCGCe4FK0+TTkyMZ
 XBF9lTIeyMAiBnojKgu+QlG69hFpXR8ujsr3UxcMON/qgZIDrQtql+2jtKoVNPtIwlFn
 vnMGm6/l0P/XiqdnSN3OLcutUgO49XygZhkai9vXiQaiOR9Sm0vFmXrrkJx7gsxjCaPz
 Hllg==
X-Gm-Message-State: AOJu0Yw8AT//nTpML1oCt8zzfuAEi8VW8n7QvfcA/bg/t+7/uegRznXQ
 T5xXh1k29L0neLjtNaYXNlTV+lILLeh0E25RvxIwDKc7yF5mCOFAuxerQKWKh8Lms/65Re97R7I
 mzr2qfl8bs/qY0EqDW2THDB+e1ID98Bwm0LngHDPSVpnxhKNHOjrrnNM=
X-Gm-Gg: ASbGncsH14K+04ONcU2a4F9aesh5v2ieaaxjC+SPvt/S4PGZ6VqY/U0LNgMjtc7Ft06
 LYCyajcc/x4fIUjjU4U8zp7PZTRoZ9O7/aLorensW+ZhbPy0Z97E3R5g0+SKIaVOgojEI7bwTiS
 zFjejZ2C8ezuhhlRnzBH7yRYZmN9KpNGlSUjTXdCkwcGD5rGWikemwg6qCQlEfPEitTYrf4/RBt
 mKp1g==
X-Google-Smtp-Source: AGHT+IEGGamHM8nz3Rk4OGPWH/PxU8WZb5qXe+aTmnG2mghtzr4xZjRDcHKfDIcvF3T7OScnX4qighe+fwpLlSs7Ea0=
X-Received: by 2002:a05:6402:26d3:b0:612:b03d:7652 with SMTP id
 4fb4d7f45d1cf-6149b5ad7e5mr5472033a12.32.1753355454904; Thu, 24 Jul 2025
 04:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-5-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-5-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:10:28 +0300
X-Gm-Features: Ac12FXwGz6rm-w3SFj2gS_8MTTLwYjNt7o73P2UG9vzcQfLVV6NidZ3hETMPFQk
Message-ID: <CAAjaMXZxkX2k4CO-Ozy6ccMniBbvUu7mX4dp5TKGcxHHsUtuUg@mail.gmail.com>
Subject: Re: [PATCH for 10.1 04/13] docs/user: slightly reword section on
 system calls
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Expand the description slightly and quote ioctl(). I did ponder
> mentioning something about why DRM ioctls are often missing but I see
> we have the I915 ones so I guess its just no one has done them.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/user/main.rst | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index b8ff203c212..05de904225c 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -20,10 +20,14 @@ QEMU user space emulation has the following notable f=
eatures:
>  System call translation
>  ~~~~~~~~~~~~~~~~~~~~~~~
>
> -QEMU includes a generic system call translator. This means that the
> -parameters of the system calls can be converted to fix endianness
> -and 32/64-bit mismatches between hosts and targets. IOCTLs can be
> -converted too.
> +System calls are the principle interface between user-space and the
> +kernel. Generally the same system calls exist on all versions of the
> +kernel so QEMU includes a generic system call translator. The
> +translator takes care of adjusting endianess, 32/64 bit parameter size
> +and then calling the equivalent host system call.
> +
> +QEMU can also adjust device specific ``ioctl()`` calls in a similar
> +fashion.
>
>  POSIX signal handling
>  ~~~~~~~~~~~~~~~~~~~~~
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

