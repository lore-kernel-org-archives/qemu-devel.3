Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E719CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqt0m-0000Or-6R; Tue, 26 Aug 2025 08:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqt0d-0000NP-2Z
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:42:43 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqt0a-0002fJ-8l
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:42:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61c21e50168so5151709a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756212157; x=1756816957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xB+m/Njpeko7F+DXOSjRqBAryLXXLSlzx8vPXdVMBeM=;
 b=J6s26puftLcx8J2+lfTiUWGg/Luscnxr/qgBuvJ79qPi9T2GDjsjYpB0mktJnvZjbs
 a6OGrd1feo0aU+1VwI8wJ6hsiApSVPac34j1JFdBPDDKlFJ7UsCH7lYdUMk/EytYjr6r
 tsVUwVL/hjTZqSh0yFAoLvMujZWN8NKR2CZiXV52GGNQrIHHxGx8+eUTd23F+DX4ST+C
 NYyq3KpVzlI0dt+X5oF4SeJ61xhVlGwbKGupRTP0/Ap6rs5F1CnILOpJG938N5quD1+v
 MyvO950YWDJHM33cHr0V+YKH0GPGOhGT+iD5RmaKynOU8grc/A+oz1COIge0T0hm3W9L
 VXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756212157; x=1756816957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xB+m/Njpeko7F+DXOSjRqBAryLXXLSlzx8vPXdVMBeM=;
 b=xPyN7rQBusCICIWJhqrkUndDb71NkwGNviQx7TITv91vd0i82eJAPXncSqUvn9ZLPD
 XbJqyCtkULW3UErs/ADeLIc9AnWgqYSln2vrgDzR7VFnvoAJ41sH6gTI6Ripyb/i2ytx
 zWVKaVI2nmXH6zYSh6ScEU2T4QSi79nFfqjY2ZPlxF0+veV8HfZ3F5TwCxherq8ibCA8
 II+UsScrb6cA8bloBVJL/D4001ARYfuIVWvEKc/th0iO/mmxxqmBvsOzgILUiZMXituz
 n1EdGte+m2r0FILLpbURMBg5YfeJ4epbOK2kwTp8nY3KyYHngHIyKZGAL0HiHJ7Aon3n
 7/AQ==
X-Gm-Message-State: AOJu0Yy9hD6fwdgvT2ON+B83oq2l0hGU5S0V2UUP8A/bSmJGM7n5LSjC
 dAFOEPl74qu8R1DzN3U7CRwpB14opWKhTvlbMxzfIr2XPThGTe5+my/IwD1ocAPxvnNsonPVMA7
 A/sMWovieiw2Iq3lLZWnD6M/mkSdwlNO4ZLyKSohZCBtPdTxK99IAt+rj/Q==
X-Gm-Gg: ASbGncuGLCn7isbrK8iEkMqXI8tNhGCEEJauCzJMuOXandzlq+qpowoG1zbU8wKepRU
 Hg8FGc81jY3RmyWRJvOzO206XEzBwWdvsgIIeigjdDXqyf7WQk1EkhqAFFdPHr7t93S3HYAZOmj
 p/EOEVd/Dc3jox7Crl/HBEV+InbFi/aXjeZO/3oYam9tYgcyq/rYTrQkUNVOnBV+n7wc/ZkzSYg
 CReNqmT
X-Google-Smtp-Source: AGHT+IHUy7K1RU2KA4G5NOeCeevGTwYx6ilhFX3PdW7HAjjV8BzdnTBPA9v8fOZBKznIMrzl6iNJ9IVIxEcbr6BySks=
X-Received: by 2002:a05:6402:4406:b0:61c:527b:150c with SMTP id
 4fb4d7f45d1cf-61c527b16a5mr7337394a12.32.1756212157031; Tue, 26 Aug 2025
 05:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250826123455.2856988-1-peter.maydell@linaro.org>
In-Reply-To: <20250826123455.2856988-1-peter.maydell@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 Aug 2025 15:42:10 +0300
X-Gm-Features: Ac12FXxa9WeSi_O0JdyDKLVi_-SfdvZ1VrJMXhzwH8JTiEp5_1fJIRYJJUiXhLc
Message-ID: <CAAjaMXaiBg3ODFhbyoOYPeofTKmfx_AVcdveea97F-etDJphbg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip test if EGL
 won't initialize
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, Aug 26, 2025 at 3:36=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> If you are using the Nvidia drivers and have installed new versions
> of those packages but have not yet rebooted the host kernel,
> attempting to use the egl-headless display will cause QEMU to fail to
> start with
>
> $ qemu-system-aarch64 -M virt -display egl-headless
> qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
> qemu-system-aarch64: egl: render node init failed


Could this error ever mean QEMU is doing something wrong in general? I
think not, but I'm not 100% certain. Better to skip it indeed.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>
> together with this complaint in the host kernel dmesg:
>
> [7874777.555649] NVRM: API mismatch: the client has the version 535.247.0=
1, but
>                  NVRM: this kernel module has the version 535.230.02.  Pl=
ease
>                  NVRM: make sure that this kernel module and all NVIDIA d=
river
>                  NVRM: components have the same version.
>
> This isn't a problem with QEMU itself, so reporting this as a test
> failure is misleading.  Instead skip the tests, as we already do for
> various other kinds of "host system can't actually run the EGL
> display" situation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I run into this fairly often so I got fed up with just ignoring the
> spurious test failure messages...
> ---
>  tests/functional/test_aarch64_virt_gpu.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional=
/test_aarch64_virt_gpu.py
> index 38447278579..4e50887c3e9 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -76,6 +76,8 @@ def _launch_virt_gpu(self, gpu_device):
>                  self.skipTest("egl-headless support is not available")
>              elif "'type' does not accept value 'dbus'" in excp.output:
>                  self.skipTest("dbus display support is not available")
> +            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.out=
put:
> +                self.skipTest("EGL failed to initialize on this host")
>              else:
>                  self.log.info("unhandled launch failure: %s", excp.outpu=
t)
>                  raise excp
> --
> 2.43.0
>
>

