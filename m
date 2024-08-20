Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B37DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMLd-0000h3-46; Tue, 20 Aug 2024 06:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgMLb-0000fJ-PA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:44:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgMLa-0006JS-15
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:44:19 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5befd2f35bfso2296366a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724150656; x=1724755456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EEzFRs2teKTCp80TPRn9qMI2bcuuxKjdKatKywvsk94=;
 b=M3vhxJVgR93uhee3f1+7TJlT3hN5Ky39D0d9HyqQfCR7tSkv/Q14h0PqH9pCg3YI4k
 2eH6Jy2quq2qmv2RAUmCg6TzeIbynZvAJMIi/CYnOddQ4BL8u1g1ax0LsMqvVJ/uMHbU
 e31PByxoDu4SA6o1TyNQJtLRas7G3No6kMc76d7qL0XwNpiSGlrNPUiZAcDZzRUWiyay
 wJ6Qe9GT2DIf5IKllTdjkqyTEtJ9hMmjhni0aVJiERlO8zZA3MLvFriCh7HL6DIKMxqb
 sjhTRONCL8uqzBeFWhbVuNmF5+eGMTEU/3OtG4OGg1DHXttEAFBztrECZDCvvUdjD1wQ
 enLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724150656; x=1724755456;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEzFRs2teKTCp80TPRn9qMI2bcuuxKjdKatKywvsk94=;
 b=R5hLCqEfNpIB5UF1adnoSnfX18G9qKXGX2CfhrIVIV9Pr/vxEL6p3m0rfUNhol66fF
 y6VbYjceQVOGbJCURn+7JG1muZZE4M+bnWMX56M3pmWNDaqv+/Zm5XNruqL41Kwjrlox
 gluAhVmJgJ2qkdAkkrR7SZEV/8lSj4klKa5fb3uiL2Pshe88vk8cN1wPxQuFFpzKyxCQ
 kjrz2xKC13dKR/y5K3gbNRpM8ZHXhTWWlObuMux2BNxjTvcJwHSujECtOPmq81cd6BDh
 +VJvvYIznIHZKj/CmK2mpUpzoCVRlNCzxaMStTDP+XoJ646c9ItuMsU3U0EwnAkDQHx5
 aQOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJAXXRTOZQzoGZoKydTqlMWf+wZpPifPeO/NZ1ioLBQe7qzs7EZsA6mRSTkHTGB9BUjbrY6Ne6Rg3LKWogxBWqnpYYNjs=
X-Gm-Message-State: AOJu0Yw3t0pjv3q7BYPpy4OFBtPYjV0qTpUM6JDacWMBGXXOkyqOk6pS
 NvUxGhb6S1Tp7JTnW3Jsafr19ne6atNM3eQZzB5XSRV1d11KdgbL6JriqeCnd5I=
X-Google-Smtp-Source: AGHT+IE/dOyVeJ5OF8dtyBxNR2lIHENOJRP5XyCqiDtO+pnIQvQAvZRKBtNemYOvkTWn4LFEWp51kg==
X-Received: by 2002:a05:6402:2745:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5beca7b03d5mr9527617a12.36.1724150655692; 
 Tue, 20 Aug 2024 03:44:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc08140csm6615972a12.83.2024.08.20.03.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 03:44:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 183435F7A3;
 Tue, 20 Aug 2024 11:44:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v16 00/13] Support blob memory and venus on qemu
In-Reply-To: <20240623152343.328436-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 23 Jun 2024 18:23:30 +0300")
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
Date: Tue, 20 Aug 2024 11:44:14 +0100
Message-ID: <87o75nmq2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Hello,
>
> This series enables Vulkan Venus context support on virtio-gpu.
>
> All virglrender and almost all Linux kernel prerequisite changes
> needed by Venus are already in upstream. For kernel there is a pending
> KVM patchset that fixes mapping of compound pages needed for DRM drivers
> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
> from Qemu.
>
> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.=
com/
>
> You'll need to use recent Mesa version containing patch that removes
> dependency on cross-device feature from Venus that isn't supported by
> Qemu [2].
>
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e2698=
7befae78b6ccbb7ae242b
>
> Example Qemu cmdline that enables Venus:
>
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,venus=
=3Dtrue \
>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G

For the following profiles:

Host Setup:

  x86 host
  Intel Corporation Raptor Lake-S GT1 [UHD Graphics 770]
  Debian Bookworm
  Kernel 6.11.0-rc1-ajb-00146-gf690c27fbc92 (basically https://lore.kernel.=
org/lkml/20240726235234.228822-1-seanjc@google.com/ + UDMABUF enabled)
  Hand built Virglrenderer (main/4fc19d919f/v1.0.1)
  Hand built Mesa with Venus support (mesa-23.3.6)

x86 Guest Setup

  Current Trixie guest (as off 19/8/24)
  Kernel 6.11.0-rc1-ajb-00146-gf690c27fbc92
  Distro installed:
    weston
    vkcube-wayland
    vkmark

  QEMU: KVM guest with -device virtio-vga-gl,hostmem=3D4G,blob=3Don,venus=
=3Don

Aarch64 Guest Setup

  Current Trixie guest (as off 19/8/24)
  Kernel 6.11.0-rc1-ajb-00146-gf690c27fbc92
  Distro installed:
    weston
    vkcube-wayland
    vkmark

  + Hand built Mesa (012323a1d, enabled with meson devenv)

  QEMU: TCG Guest with -device virtio-gpu-gl-pci,hostmem=3D4G,venus=3Don,bl=
ob=3Don

Have a:

  Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
  Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Next steps:

  - test on Arm AVA (x86 and Arm guests)
  - build some buildroot images with all the right deps for testing

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

