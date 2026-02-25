Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF17FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvNpQ-0000vI-97; Wed, 25 Feb 2026 17:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvNpN-0000ux-ML
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:57:57 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvNpL-0008Vm-UZ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:57:57 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-65f9763e8d1so641410a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772060272; x=1772665072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z77WNUnCvLS0F4LrKoi7hWpSFRaWDNV/kKur+MNJlH0=;
 b=F8uYSFr1zZK9zVFqSijqgIarZEl628dSv/aZ6/9Lt4nWYbcX2+ajQ2eVu2udLXBz9G
 lUxxMXjGrl78VF8iDzQgjLrxY1gfRQ0l66ajajJ9ynJnrSymOpyUHZlPvemZJO7PO0ja
 Qn3+OyJ8Qsc7GI2d2B4+SFeQ8HszUDzHudPqTEpy4FvBiRTb5uZ33dEU5w0jrHSko10Q
 i9OQtLCN42N9+utOwmuRLo5WV7UlKy7Lg5RbCvwXWdtBbHHdYA97ZsWvoONQMK4TIxvH
 V7czOq+kVRB7cnbCP8DHuQn5AHfW05fQBj3ysPq3Xf7QaGn5+Euq5AuQmQOYhzv/ZIur
 vhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060272; x=1772665072;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z77WNUnCvLS0F4LrKoi7hWpSFRaWDNV/kKur+MNJlH0=;
 b=pvUX2xk+rzPjqm867a6pwnqJPMPZcIWBqH/m8uvrHbjs9QyE1VgvxLHh7hRINGqZKL
 57rve7HvqMbh4b4K/OTaBT0NKADLMqLtjGGu0UsizECq25uHkAsPIlRRDViW1KGfwmHm
 3W2PHno7Growtm8x+lq2xC/2skVjPGT9/SIRYDiT24j1qrrkgaonznC4wszxr7lU/js9
 ZnQLK5Oh03jk657DuFHhaMW9c/MoMY6+GsoUPSfZDkmrdtbJ/tDwjsnqK52Hn4n6giz5
 6WenBEY4It/cW6tgcRN2BuCDbnpkwOZyMCVYqCfLEDZWRnDuC1sNuLKaFaNpbHXEt/RE
 k3FQ==
X-Gm-Message-State: AOJu0YxSVbR7w4M2Lh0JxrSfmMdFDn0yLu0XjGJUXXd1mariPYWdMFQ6
 NDDJA0SeLqf5nLduShLDFNpRC1cwruqLpLOSyOpdK7th5oNVzFU3/R+YFB4UJJkZeLo=
X-Gm-Gg: ATEYQzwRFWat+jWIxENNbFoKFdnIEygIiGoD3EJjnLnvcsyIipFgdD1po642VlimRN0
 hvdKbnCsVX5Ffj/vpMCVveJlkZQ5ZVZ7UyVWM0SYqmoRlcpoOPQWghC6ivctPvaOYp3qDxhEvnO
 s+zP2/jLnqZlckJSZzty9o0oKj7YMTo/riS7E2eMkDBqpndNoWuCm47Yabkt2hTooyXDVLZ7qJ+
 e//bAB7QBD0eVh6D70T0wWJY5+rsIfRLwfeMDy8CdBBftzFsX0obm7g3+wgQlByOvJ+mvwwRuow
 VeMBKw7HubUrvMVl9QCllHM8mNbgNh2bmAgKhJd8NwnexNoL9rlDBI45knD9NCm7aUUG7csyUlp
 P5aS2KbFQB/LaeVGKiRdj8NkemQLXFe0rEiMoMB+SiIhfI+YRYNrobWSXDOJzUYPQDgh936bTsv
 YrvrULsfGpDE0OyZNTm2HhnPI=
X-Received: by 2002:a17:907:3f8a:b0:b88:16dd:d835 with SMTP id
 a640c23a62f3a-b935b4a526bmr6991566b.1.1772060272256; 
 Wed, 25 Feb 2026 14:57:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aead96bsm3418366b.51.2026.02.25.14.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:57:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AD465F7CC;
 Wed, 25 Feb 2026 22:57:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/3] tests: upgrade debian-legacy-test-cross to
 debian 13
In-Reply-To: <20260225193856.959771-3-jsnow@redhat.com> (John Snow's message
 of "Wed, 25 Feb 2026 14:38:55 -0500")
References: <20260225193856.959771-1-jsnow@redhat.com>
 <20260225193856.959771-3-jsnow@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 25 Feb 2026 22:57:50 +0000
Message-ID: <87wm00zb0x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> We no longer require Debian 11 to run these tests; they work properly
> under Debian 13/Trixie.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
=20
If these all work with Debian 13 we should just punt the compilers into
debian-all-test-cross and delete this container and redirect its users.

> ---
>  .../dockerfiles/debian-legacy-test-cross.docker  | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/t=
ests/docker/dockerfiles/debian-legacy-test-cross.docker
> index 5a6616b7d39..293f31a07d6 100644
> --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> @@ -1,18 +1,13 @@
>  # Docker legacy cross-compiler target (tests and minimal qemu)
>  #
> -# Compilers for some of our older targets which we cant currently
> -# upgrade. Currently:
> -#
> -#   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.c=
gi?bug=3D1054412
> -#   sh4-linux-user: binaries don't run with bookworm compiler
> -#
>  # As we are targeting check-tcg here we only need minimal qemu
>  # dependencies and the relevant cross compilers.
>=20=20
> -FROM docker.io/library/debian:11-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
> +# Add deb-src repository sources
> +RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
> +    /etc/apt/sources.list.d/debian.sources
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -35,12 +30,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          libc6-dev-sh4-cross \
>          python3-pip \
>          python3-setuptools \
> +        python3-tomli \
>          python3-venv \
>          python3-wheel && \
>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\n=
' --show > /packages.txt
>=20=20
> -RUN /usr/bin/pip3 install tomli
> -
>  ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
>  ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
>  ENV MAKE /usr/bin/make

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

