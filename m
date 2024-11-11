Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F648D12D71
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 05:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMvm-0001Ye-PZ; Mon, 11 Nov 2024 00:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMoY-0000s3-5W
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:18:14 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMoV-0000b4-Ob
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:18:13 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ee7e87f6e4so3083142a12.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731302290; x=1731907090;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bGTdGE3aVW2/2Ja67NIBqxnIhoynkF5Bpp02IpBQolg=;
 b=Ur+LySpgI/qB0Rrf/C5qJRFI9jgWJHY0CdohwT6egyznnILoHI9T4DehYwIxHACVoo
 lMTXgHhGUx0NoS4iHDsJuR2QjKWM5cXo3GMe5LDx4m5BI3LCh0lw209cVD94d1JMYON6
 lSpd0a86VfET9maRj8tM+kICliA+3E3GAiVH/DMa6eR+LFpxy4m0Yu1MQ4GnwME1U4Rc
 qRHHBbGs1OtCUWF8vIZrXa1OC5bZH0IFWCGMOrv47PkZYv89x8Bm7Tnj471t3Shw37nh
 CfGtyUuRri326ahA/uq6qmuowjTAO8iSaLWcvGfHAevSVkbIm3g+gWuBnkEjCfcNE3UZ
 WbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731302290; x=1731907090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bGTdGE3aVW2/2Ja67NIBqxnIhoynkF5Bpp02IpBQolg=;
 b=mgIrW8sXnNd05zvR4EL+FZUcKuQTKtrhTmVrQfEpiFJDluTc5oTxskNZW8Qxngh4aJ
 ViBtBiaGAqn+VNYjYT3oV/i1WeQ/SRPnKSvKU4+KLMsE6zGRoDCfMaAfUln58nKxZqte
 k5NO6PPRU+qny4/eqTTlv56u3YTFmp/j8VXDQRzKH8QEPDQD6O7b8nMhqeFAM0EqVesp
 SwffP1avWzMZejGtZgFQyliREfo8bIVB6cJuPxnjU6wY8pH2jBQ2vErgkfTGYbs6SJZc
 FvbFP1jRKSGP1j5zyosx/mEmL40gEWe3rjZpl4Bh4ux248l3n9JFCBfpSfPZDtceBSYG
 N9sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX89GFqpUEiTU1K9IIekHDHBwz/yc9ZOT7KxB7PwObrZZPyqB14UW14tiNe8s6kJI1rFIi0+dYbp1F@nongnu.org
X-Gm-Message-State: AOJu0Yx0jGjLoMi+gYpTXA0r4CaUv4oIbVkFCP00JeEVIayen0vYj5hy
 sGXMCxJ2OE6AJLqDLa+xbU29dfjW5mVBqcYlHWo0HjwiGLbkD3E0njS16EfGB7Y=
X-Google-Smtp-Source: AGHT+IEyAaGZ1hl0TQr7GvsiTZcJwdkNPswa9ed33GM2MGACMgK6BtSltmfTiIzN8GLz7tO9iCffJw==
X-Received: by 2002:a05:6a20:9147:b0:1db:ee51:6d7b with SMTP id
 adf61e73a8af0-1dc22a1f504mr18248699637.24.1731302289716; 
 Sun, 10 Nov 2024 21:18:09 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a7d75sm8351680b3a.68.2024.11.10.21.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 21:18:09 -0800 (PST)
Message-ID: <9295fab8-6675-4b58-a91b-64214b0f1375@daynix.com>
Date: Mon, 11 Nov 2024 14:18:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
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
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/11 7:18, Dmitry Osipenko wrote:
> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
> 
> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support it.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
> a real/native host GPU device for GL/VK applications.
> 
> [1] https://www.youtube.com/watch?v=9sFP_yddLLQ
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
> 1. DRM context uses host blobs and requires latest developer version
> of Linux kernel [2] that has necessary KVM fixes.
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
> 
> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
> and AMDGPU native contexts. For Intel use patches [3].
> 
> [3] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
> 
> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
> Mesa patches [4], for Intel [5].
> 
> [4] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
> 
> 4. On guest, use latest Linux kernel v6.6+. Apply patch [6] if you're
>     running Xorg in guest.
> 
> [6] https://lore.kernel.org/dri-devel/20241020224725.179937-1-dmitry.osipenko@collabora.com/
> 
> Example Qemu cmdline that enables DRM context:
> 
>    qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
>        -machine q35,accel=kvm,memory-backend=mem1 \
>        -object memory-backend-memfd,id=mem1,size=8G -m 8G
> 
> 
> # Note about known performance problem in Qemu:
> 
> DRM contexts are mapping host blobs extensively and these mapping
> operations work slowly in Qemu. Exact reason is unknown. Mappings work
> fast on Crosvm For DRM contexts this problem is more visible than for
> Venus/Virgl.
> 
> Changelog:
> 
> v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config
>        option, better handling EGL error and extending comment telling
>        that it's safe to enable SDL2 EGL preference hint. As was suggested
>        by Akihiko Odaki.
> 
>      - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
>        the async-fencing patch for more consistency of the code. As was
>        suggested by Akihiko Odaki.
> 
>      - Added missing braces around if-statement that was spotted by
>        Alex Bennée.
> 
>      - Renamed 'drm=on' option of virtio-gpu-gl device to
>        'drm_native_context=on' for more clarity as was suggested by
>        Alex Bennée. Haven't added added new context-type option that
>        was also proposed by Alex, might do it with a separate patch.
>        This context-type option will duplicate and depecate existing
>        options, but in a longer run likely will be worthwhile adding
>        it.
> 
>      - Dropped Linux headers-update patch as headers has been updated
>        in the staging tree.
> 
> v3: - Improved EGL presence-check code on X11 systems for the SDL2
>        hint that prefers EGL over GLX by using better ifdefs and checking
>        Xlib presence at a build time to avoid build failure if lib SDL2
>        and system are configured with a disabled X11 support. Also added
>        clarifying comment telling that X11 hint doesn't affect Wayland
>        systems. Suggested by Akihiko Odaki.
> 
>      - Corrected strerror(err) that used negative error where it should
>        be positive and vice versa that was caught by Akihiko Odaki. Added
>        clarifying comment for the case where we get positive error code
>        from virglrenderer that differs from other virglrenderer API functions.
> 
>      - Improved QSLIST usage by dropping mutex protecting the async fence
>        list and using atomic variant of QSLIST helpers instead. Switched away
>        from using FOREACH helper to improve readability of the code, showing
>        that we don't precess list in unoptimal way. Like was suggested by
>        Akihiko Odaki.
> 
>      - Updated patchset base to Venus v18.
> 
> v2: - Updated SDL2-dmabuf patch by making use of error_report() and
>        checking presense of X11+EGL in the system before making SDL2
>        to prefer EGL backend over GLX, suggested by Akihiko Odaki.
> 
>      - Improved SDL2's dmabuf-presence check that wasn't done properly
>        in v1, where EGL was set up only after first console was fully
>        inited, and thus, SDL's display .has_dmabuf callback didn't work
>        for the first console. Now dmabuf support status is pre-checked
>        before console is registered.
> 
>      - Updated commit description of the patch that fixes SDL2's context
>        switching logic with a more detailed explanation of the problem.
>        Suggested by Akihiko Odaki.
> 
>      - Corrected rebase typo in the async-fencing patch and switched
>        async-fencing to use a sigle-linked list instead of the double,
>        as was suggested by Akihiko Odaki.
> 
>      - Replaced "=true" with "=on" in the DRM native context documentation
>        example and made virtio_gpu_virgl_init() to fail with a error message
>        if DRM context can't be initialized instead of giving a warning
>        message, as was suggested by Akihiko Odaki.
> 
>      - Added patchew's dependecy tag to the cover letter as was suggested by
>        Akihiko Odaki.
> 
> Dmitry Osipenko (4):
>    ui/sdl2: Restore original context after new context creation
>    virtio-gpu: Handle virgl fence creation errors
>    virtio-gpu: Support asynchronous fencing
>    virtio-gpu: Support DRM native context
> 
> Pierre-Eric Pelloux-Prayer (1):
>    ui/sdl2: Implement dpy dmabuf functions
> 
>   docs/system/devices/virtio-gpu.rst |  11 ++
>   hw/display/virtio-gpu-gl.c         |   5 +
>   hw/display/virtio-gpu-virgl.c      | 158 ++++++++++++++++++++++++++---
>   hw/display/virtio-gpu.c            |  15 +++
>   include/hw/virtio/virtio-gpu.h     |  16 +++
>   include/ui/sdl2.h                  |   7 ++
>   meson.build                        |   6 +-
>   ui/sdl2-gl.c                       |  67 ++++++++++++
>   ui/sdl2.c                          |  42 ++++++++
>   9 files changed, 309 insertions(+), 18 deletions(-)
> 

Now this series looks good to me.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

