Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B89ECFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkLh-0007gi-2K; Mon, 07 Oct 2024 05:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkLe-0007gW-5J
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:48:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkLb-0005gh-V8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:48:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so29682425ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728294489; x=1728899289;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cWx/cRXhfMwlzkxSzOG7+OOGKBShq0ghMJyWEiyZxM=;
 b=1QozT08a7rTWTLfXhqyWJhRcrAkMIAQ/L+JboxItZHrbQyg36WCg7sih3cPHtyT+M4
 15BbcHkvtnLmw+RW8toR8Q7KwLalfk4zuMd86LWPM8Ef6j9yARo/e5CtFZH3ItgQTT2z
 NgHajG4fPf3Wp/hVXCviTEdItvJpFEVa87mcjH5dbKS2LEtwb4R6PSxaf0DYaHdNyQCx
 DcuPVgTah0neawEQNVSboYBDO5ON+PKug0P4j9PrnZbcUqjBRCO+WUE9v5JoQr3VbFM0
 8Ol6720vPrkBOPmXfExvwnLXjUJF1/9rHbOFi1MAFe5nUT1QCbO8mtgTvO7njVtw8tqv
 o4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294489; x=1728899289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cWx/cRXhfMwlzkxSzOG7+OOGKBShq0ghMJyWEiyZxM=;
 b=h8FklXD6ZZb4i2SFIJZj3/fsKHed0ykw+9biufudODWzI5JqNoyZWbaScXUQ7evbCy
 UzHi6if18WlZm2BjeLH2Fy4fEBRfuJBeUT2u5cFoJsBOQJRA2JlnojzRSrdpoqJX1Bf9
 5cBig7cfozpu2XJwIwGtQvj3xot49NcxcVqmjPjckVlS8cWkckdRWM7na4HyRIervMUU
 G9Nj+r2vGhOmj0ZPqpyqAQ+uIMlYreAPjyiusYzUqz5Vuo7n0Img0GQs2kZ+Xqw6sxtG
 /i5YL9UUPa9MyqdHhYW/LJKW/iiNIA09HUPyISE0cM60stLsDGC/92Vu7rbRb7ZiEHE0
 FtSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7lmg3u+HdbJ7mbL8P0HT+xVN0zzwk0E389nJLU/FSaLgtLJGK3Sy9XSMCC1ijXM9IaGLoet1Vn50l@nongnu.org
X-Gm-Message-State: AOJu0Yx4H6pkx1ne3B/i7KUX+ikl44CSMfEGZPA22JvFZeE4/IQKffIJ
 juCJ8FhuXRiZ66G0a8LbsZwuNHgXge6jP1HRql0TU2fpfbBUTCB+y1577nNEYhBvKQMZaItt9om
 aM94=
X-Google-Smtp-Source: AGHT+IHbYMmFu5Sx27YE3ORuqGQtYZNZ1aF0fPve4JqXe1ZUpRtqLX3+Y5Irrnma1NKRHwW1vwrnxQ==
X-Received: by 2002:a17:902:dac5:b0:20b:b132:4dec with SMTP id
 d9443c01a7336-20bfde57e80mr186477405ad.11.1728294489410; 
 Mon, 07 Oct 2024 02:48:09 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13994f84sm36340235ad.290.2024.10.07.02.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:48:09 -0700 (PDT)
Message-ID: <1bd2bf2c-41a8-40f4-a086-17e7fbb21682@daynix.com>
Date: Mon, 7 Oct 2024 18:48:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Support virtio-gpu DRM native context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 8:23, Dmitry Osipenko wrote:
> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
> It's based on the pending Venus v17 patches [1] that bring host blobs
> support to virtio-gpu-gl device.

Hi Dmitry,

Thank you for submitting this series.

> 
> [1] https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osipenko@collabora.com/

Please use Based-on: tag.
For details, see: docs/devel/submitting-a-patch.rst

Regards,
Akihiko Odaki

> 
> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
> DRM native context [2] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support it.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
> a real/native host GPU device for GL/VK applications.
> 
> [2] https://www.youtube.com/watch?v=9sFP_yddLLQ
> 
> Today there are four known DRM native context drivers existing in a wild:
> 
>    - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>    - AMDGPU, mostly merged into upstreams
>    - Intel (i915), merge requests are opened
>    - Asahi (Apple SoC GPUs), WIP status
> 
> 
> # How to try out DRM context:
> 
> 1. Like Venus and Virgl context, DRM context requires applying WIP
> KVM patches [3] to host kernel, otherwise mapping of GPU memory blobs
> will likely fail.
> 
> [3] https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com/
> 
> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
> and AMDGPU native contexts. For Intel use patches [4].
> 
> [4] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> 
> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
> Mesa patches [5], for Intel [6].
> 
> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> [6] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> 
> 4. On guest, use latest Linux kernel v6.6+.
> 
> Example Qemu cmdline that enables DRM context:
> 
>    qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,drm=true \
>        -machine q35,accel=kvm,memory-backend=mem1 \
>        -object memory-backend-memfd,id=mem1,size=8G -m 8G
> 
> 
> # Note about known performance problem in Qemu:
> 
> DRM contexts are mapping host blobs extensively and these mapping
> operations work slowly in Qemu. Exact reason is unkown. Mappings work
> fast on Crosvm For DRM contexts this problem is more visible than for
> Venus/Virgl.
> 
> Dmitry Osipenko (5):
>    ui/sdl2: Restore original context after new context creation
>    linux-headers: Update to Linux v6.12-rc1
>    virtio-gpu: Handle virgl fence creation errors
>    virtio-gpu: Support asynchronous fencing
>    virtio-gpu: Support DRM native context
> 
> Pierre-Eric Pelloux-Prayer (1):
>    ui/sdl2: Implement dpy dmabuf functions
> 
>   docs/system/devices/virtio-gpu.rst            |  11 +
>   hw/display/virtio-gpu-gl.c                    |   5 +
>   hw/display/virtio-gpu-virgl.c                 | 153 ++++++++++--
>   hw/display/virtio-gpu.c                       |  15 ++
>   include/hw/virtio/virtio-gpu.h                |  17 ++
>   include/standard-headers/drm/drm_fourcc.h     |  43 ++++
>   include/standard-headers/linux/const.h        |  17 ++
>   include/standard-headers/linux/ethtool.h      | 226 ++++++++++++++++++
>   include/standard-headers/linux/fuse.h         |  22 +-
>   .../linux/input-event-codes.h                 |   2 +
>   include/standard-headers/linux/pci_regs.h     |  41 +++-
>   .../standard-headers/linux/virtio_balloon.h   |  16 +-
>   include/standard-headers/linux/virtio_gpu.h   |   1 +
>   include/ui/sdl2.h                             |   5 +
>   linux-headers/asm-arm64/mman.h                |   9 +
>   linux-headers/asm-arm64/unistd.h              |  25 +-
>   linux-headers/asm-generic/unistd.h            |   6 +-
>   linux-headers/asm-loongarch/kvm.h             |  24 ++
>   linux-headers/asm-loongarch/unistd.h          |   4 +-
>   linux-headers/asm-riscv/kvm.h                 |   7 +
>   linux-headers/asm-riscv/unistd.h              |  41 +---
>   linux-headers/asm-x86/kvm.h                   |   2 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   3 +
>   linux-headers/linux/const.h                   |  17 ++
>   linux-headers/linux/iommufd.h                 | 143 +++++++++--
>   linux-headers/linux/kvm.h                     |  23 +-
>   linux-headers/linux/mman.h                    |   1 +
>   linux-headers/linux/psp-sev.h                 |  28 +++
>   ui/sdl2-gl.c                                  |  42 ++++
>   ui/sdl2.c                                     |   8 +
>   32 files changed, 851 insertions(+), 108 deletions(-)
> 


