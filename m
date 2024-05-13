Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C014C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 04:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MyW-0002Oh-DK; Mon, 13 May 2024 00:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6MyF-0002OA-8Y; Mon, 13 May 2024 00:07:28 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Mxx-0002UT-Ve; Mon, 13 May 2024 00:07:26 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4df3f7b93a7so984470e0c.1; 
 Sun, 12 May 2024 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715573228; x=1716178028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5IKMKHDMv2So9ueaEu7fZnePMMLqzgNKoCO9ZCKWec=;
 b=QHGqpY4slLIITH52nem5HvHDpgGybPx7GXk8i/7DjPZB36CoJwiiHrKTR8gc1+eNvz
 Bdp6YdIc3khFPmNsPyh4XIvr3R5/yfmVQsvufo3+fJ1tzFlJYB+FOFl3qRCjFEIwhuAw
 xdy9aBaGVazcg9a0AwzFBsPyvbXE6cWcHYwXRu+wdAx/x6mFlT0vQ5LZmW491Tqj+Gpu
 MoRoCarW8Stcb6eWSo6Ks1IbpgQv5jYZpZgOh6Xz1EUIICQzyZ63yIVoameTqXY/Rhvd
 7yjNY4bbiKM4hsbVbseOgUgLbD4EVgtBbZ/B75wNOoDCo9hiD10z8cQ6AotwQp3sz9Ot
 wJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715573228; x=1716178028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5IKMKHDMv2So9ueaEu7fZnePMMLqzgNKoCO9ZCKWec=;
 b=UrUrat1P6zZhSD1IA2iC+JhU+NtbokstY88Q+U5OAcxTgW7Q6gLt97/uyQkabU8Pal
 pJLkxySA/huCdKsoEYSTVSN1ZEdNEgTd7LiGM+NnhH1Vga5v3INQavqjZSNT0o33gxp3
 q1YgMJv/jQ4BAz6nTm1pwTQqKxdRiWz6+G5/bPJCBIlPpvRdIlCyxKkSFOxeqyOuQgNm
 FVtkgXijfXKKUpEHpvitHWCZ8SR5sfAQmo6foCsg+hKllcJLEN2i822iP2KU5iM/fugV
 91GibdDBoZq0hm91J37EP7Xi//NvisyD0kTAL/fHF3aOJswva1buQvMdH8kvuwnGIhrw
 QwtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDbGvjILA9iFwQ6QUHR6SfMvd9XLjlEQAYXs8qtU2e+6GR2P2yvuTOCCrZv/Vpy4S/C6jQ7a26JBlHYuAHOjOyfigpfURnWw==
X-Gm-Message-State: AOJu0YzzqyUa2WPk3WiWOLIEn8GQIqIA5XRBGWVlQGz94FHiXt1OXSCt
 v/vkLN2hG/ddqizAxjadfNJmqUNmcADNpVLAG5S/TTKvBMwOekpH+lniShPLU9Bsb1gfPx9ZcEP
 int/i/iyIuwlYzttyTR9xKihHhNw=
X-Google-Smtp-Source: AGHT+IGWmyfCDeckncnUt7RQ8IAlMvLUdwX4ffoBM5fBH/bVAbdYda6fsGhl0yvrcCMmm8SPfNIEMRWiU1lp13fcA8s=
X-Received: by 2002:a05:6122:3128:b0:4db:1b9d:c70a with SMTP id
 71dfb90a1353d-4df88180aefmr7050950e0c.0.1715573228199; Sun, 12 May 2024
 21:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240503071634.841103-1-mjt@tls.msk.ru>
In-Reply-To: <20240503071634.841103-1-mjt@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 14:06:41 +1000
Message-ID: <CAKmqyKOC+o5-H-Yo=8J1XaDJzTavqvUAQ9CvDk8muFeiWrAUBg@mail.gmail.com>
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 3, 2024 at 5:17=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
> This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
>
> riscv64 in debian has been non-functioning for almost a year, after the
> architecture has been promoted to release architecture and all binary
> packages started to be re-built, making the port not multi-arch-co-instal=
lable
> for a long time (in debian, multi-arch packages must be of the same versi=
on,
> but when a package is rebuilt on one architecture it gets a version bump =
too).
> Later on, debiah had a long time64_t transition which made sid unusable f=
or
> quite some time too.  Both such events happens in debian very rarely (lik=
e,
> once in 10 years or so - for example, previous big transition like that w=
as
> libc5 =3D> libc6 transition).  Now both of these are finished (where qemu=
 is
> concerned anyway).
>
> Hopefully debian unstable wont be very unstable.  At the very least it is
> better to have sporadic CI failures here than no riscv64 coverage at all.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: drop a TODO comment which turned out to be confused, replacing it
>  with the description why debian riscv64 were unusable.
>
>  .gitlab-ci.d/container-cross.yml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cr=
oss.yml
> index e3103940a0..dbffed3f21 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -77,7 +77,6 @@ riscv64-debian-cross-container:
>    allow_failure: true
>    variables:
>      NAME: debian-riscv64-cross
> -    QEMU_JOB_OPTIONAL: 1
>
>  s390x-debian-cross-container:
>    extends: .container_job_template
> --
> 2.39.2
>
>

