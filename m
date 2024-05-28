Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A918C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsdU-0006Wt-Ss; Tue, 28 May 2024 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sBsdT-0006Wj-8v
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:56:47 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sBsdR-0008MS-8B
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:56:46 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5d67064885so79879266b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716886602; x=1717491402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGQT7B8+ToCiJcB7dCXTyM2BHU3v0xR2SR2qeBbgm0=;
 b=XPekx6VWooqfrJLCDzyHRwLYQkmhmOPCVAsN67sVZs2S3uTio7hOxgiH2dh2FMct9p
 Ic2AmdGzezhd11mSmT6zmx+xlsZR9n4Rd75EL4N+z1jAp5aT/U2q1feupAgPe5IjVUMc
 J9YTPiwHWt5TODl6inERfChYRSC+L7U1UfBF5kvNv87njzygz6T8azsNQKvcL6SRz3y8
 4wpgYOW5LVC6Vafp3Eg3LPiM6sc3L/FVvmxySt3eCuISqKL+yKE5kerPEBcMGvfEJoy0
 G7EXAV7xnzGRgtt+ywQwk3Ln4evSvNdB4GzC1yBvR5nqx2QDzfSfCQ/7JPmIcLG820yO
 fW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716886602; x=1717491402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SGQT7B8+ToCiJcB7dCXTyM2BHU3v0xR2SR2qeBbgm0=;
 b=rBdaTacbUEbsysLcMbY84MhiR2dHHhuuQ7xbOPuHTjjDh+Gp98BdKuDBptuXqxJiYd
 8o6CYhc6c63ExhZUw3jdPu1HMZXfQqCg7R7wHsEBR5AbgjV0hdtH1we6R1vP5ywxn10K
 gjz9ogzbxGnM9yM3ND+tL44xUb3IsgTTB1FlzxLNStGAtEcMT1hp61hmkT3dAPDrARWD
 ZQlMqAsk7oqjX6NVgfpyGswWYQT9Kxzq+00FaHNie2tobaeIS7LiNNgFuVnM8TvZj/bJ
 ADs5epUgd0+uRIGriG1ihw4OlAKame7h+8KUWIgaDqHJPgypkvOH9esGTF3HST+3bQM9
 nNEw==
X-Gm-Message-State: AOJu0Yweta1EINwS4F/5mqagVj1LNxZRjiKPdqWOYdHRCmDHEyCNH+sa
 s42inJkdj9qO4HIxwHZ9HGVFQkjF/iipg6+qMvyhGFPcmreFMQJeyB757xgJSlm8V4Q565OpB3F
 yqnyhu7Cg9k3Y1dHgLaW6NzNtAiCSN6nJrWGSirNt5jMKhUdFt3sN3Q==
X-Google-Smtp-Source: AGHT+IHdkneil0xg2sd6KMd/mYNgh4OclCmRUygO4+cZnHEmltwdXJ6mtiAhITv4skn1eSh5ZDp36er8IFSBZBQW3Sk=
X-Received: by 2002:a17:906:90d:b0:a59:9da0:cc1 with SMTP id
 a640c23a62f3a-a626511b172mr1254969466b.58.1716886602569; Tue, 28 May 2024
 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240528083858.836262-1-kraxel@redhat.com>
 <20240528083858.836262-2-kraxel@redhat.com>
In-Reply-To: <20240528083858.836262-2-kraxel@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 28 May 2024 11:56:26 +0300
Message-ID: <CAAjaMXaucLgfWVuf96ZbjDyXxw3yZ-yzuJeZGK66ib0oCq6r6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] MAINTAINERS: drop audio maintainership
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Tue, 28 May 2024 at 11:39, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Remove myself from audio (both devices and backend) entries.
> Flip status to "Orphan" for entries which have nobody else listed.
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  MAINTAINERS | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448dc951c509..58e44885ce94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1913,8 +1913,7 @@ F: include/hw/xtensa/mx_pic.h
>  Devices
>  -------
>  Overall Audio frontends
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/audio/
>  F: include/hw/audio/
>  F: tests/qtest/ac97-test.c
> @@ -2389,8 +2388,8 @@ F: hw/virtio/virtio-mem-pci.c
>  F: include/hw/virtio/virtio-mem.h
>
>  virtio-snd
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +R: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>  S: Supported
>  F: hw/audio/virtio-snd.c
>  F: hw/audio/virtio-snd-pci.c

While extra reviewers are always helpful, someone like Volker would
make sense, not someone without any contributions:

$ git log --format=3D"%an" hw/audio/virtio-snd.c
hw/audio/virtio-snd-pci.c include/hw/audio/virtio-snd.h
docs/system/devices/virtio-snd.rst | sort -u
Manos Pitsidianakis
Michael Tokarev
Philippe Mathieu-Daud=C3=A9
Richard Henderson
Stefan Hajnoczi
Volker R=C3=BCmelin
Zheyu Ma

I'd suggest leaving adding reviewers here for a different patch submission.

Otherwise:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> @@ -2768,7 +2767,6 @@ F: include/hw/hyperv/hv-balloon.h
>  Subsystems
>  ----------
>  Overall Audio backends
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  S: Odd Fixes
>  F: audio/
> @@ -2784,13 +2782,11 @@ X: audio/spiceaudio.c
>  F: qapi/audio.json
>
>  ALSA Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/alsaaudio.c
>
>  Core Audio framework backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Christian Schoenebeck <qemu_oss@crudebyte.com>
>  R: Akihiko Odaki <akihiko.odaki@daynix.com>
> @@ -2798,36 +2794,30 @@ S: Odd Fixes
>  F: audio/coreaudio.c
>
>  DSound Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/dsound*
>
>  JACK Audio Connection Kit backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/jackaudio.c
>
>  Open Sound System (OSS) Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/ossaudio.c
>
>  PulseAudio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/paaudio.c
>
>  SDL Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -R: Thomas Huth <huth@tuxfamily.org>
> +M: Thomas Huth <huth@tuxfamily.org>
>  S: Odd Fixes
>  F: audio/sdlaudio.c
>
>  Sndio Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  R: Alexandre Ratchov <alex@caoua.org>
> -S: Odd Fixes
> +S: Orphan
>  F: audio/sndioaudio.c
>
>  Block layer core
> --
> 2.45.1
>

