Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A22AC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4ka-0002jm-Ah; Thu, 20 Feb 2025 06:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4kY-0002j1-6u
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:29:50 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4kU-0008IJ-Gt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:29:49 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5dab9cd918so1683869276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 03:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740050985; x=1740655785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYvtCaOUilZxoVI3teCxdE3xc/8dUrS1U5eBBCdYFeM=;
 b=VC12Apg1Vyk+gAf7i2eeyaiVFBRkCjoVwQxyHcZxYZ/3UrMsJ+ConQ7iOAe4oEhEz/
 xWptUhJePG62M83b2BKESFaSqLM2j3bjhvs+eLFjSHOgoJ/fnF1y7rndR7zjKgiYg63r
 JGI9K8nueEFBWJ0hOdr0uihgQC3QV66Q+Fa5EgbHQPdjSdG6j+yo6k1RHT4PsO9mFy8m
 sElhm4/YnkAAhAAavI5cq8VQnASiTE2frdLVYkH+sTYgT48z3kMgCyQHBWoZkZKhWW7r
 8Cl+qfNcBuRplPzaP+t6nXsQ67m73l+XHKDVUlcnGE1gO4wknBQYNex3gaRYP7q2HeyC
 BL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740050985; x=1740655785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYvtCaOUilZxoVI3teCxdE3xc/8dUrS1U5eBBCdYFeM=;
 b=Pfk492OySC7Nudc61HT7g+MNrybW0WFpAa6Zdv26LrCBqsODU3Z7A16hHgQDPRXlSs
 chb5agBMd6e6DoXvCZ1X4xlT+SvDvWlAWyRuJXKPxb8Qy2Rj8DgR0b3AW1zlLlN9Avj9
 MwwgLUjTDLxuCfoZXi91fgjJwuov1YQZFDV4NjAPkIh/E459Jo6icejVZAcaZ6zXFtq7
 grZXsnIuQ/mCEZ2uH+BBkBWx9jbw1+R+E4zc/duM/gNub3WDdgynIGSf2HAzhfUZbjhw
 B/mv40XeQAw8gsEx2vc8U7uo6xVgKEzKFKtuqEXIS7bghA66icvzLaH4v1q9lkDndC4w
 MNVw==
X-Gm-Message-State: AOJu0YxJnvBm+22vV4HUhb+JQkQ7vaRtTIv2RyTVdibUOqCfR+puzK4h
 K2xfO5YX8bS8/DxcJlOLB53XrCx4qHZlxKEF8XyJj5SDNmBKqLl9lnr/il/VAcFHjB1wPOdFJ6v
 55+j5efpjE9+OQVhJi5Ree50AlreNH/tkJOu/9w==
X-Gm-Gg: ASbGncsIlPg9K/5iPU2kPE/LUoq7Ai247jB8NPUTkEAA7AnZj6juGBjW1ZPi15Cvwlv
 82NdH69lMlYGy9dMSAVINNNJduNrmoV+ju51y4M6Pa7TLYSUq3qaD9a/itqRN1eUSItgZplpxWw
 ==
X-Google-Smtp-Source: AGHT+IESlkncuzTlienwxRqWW4diDBsaPjX/9Vu+FcyHLyQ28vIIJtEZje/zJZXHYM/ULJUqLgmjiG2k1j13TfdiYp0=
X-Received: by 2002:a05:6902:11c9:b0:e5b:4760:f567 with SMTP id
 3f1490d57ef6-e5e19238f9cmr2630244276.16.1740050985049; Thu, 20 Feb 2025
 03:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
In-Reply-To: <20250219150009.1662688-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 11:29:33 +0000
X-Gm-Features: AWEUYZlJQq5UYfSpdZ4s4yzZg7uTgnEiAbwjQkyXmV_eWCTtQYW95nUnEt0fT-A
Message-ID: <CAFEAcA_TJhgrcfZ-9JY74OvkiGXPuYHJF16=_3Y+=r6+JfXMGA@mail.gmail.com>
Subject: Re: [PATCH 0/4] testing/next (aarch64 virt gpu tests)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 19 Feb 2025 at 15:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi,
>
> As I was looking at the native context patches I realised our existing
> GPU testing is a little sparse. I took the opportunity to split the
> test from the main virt test and then extend it to exercise the 3
> current display modes (virgl, virgl+blobs, vulkan).
>
> I've added some additional validation to ensure we have the devices we
> expect before we start. It doesn't currently address the reported
> clang issues but hopefully it will help narrow down what fails and
> what works.

Running on my setup with a clang sanitizer build I get

ok 1 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt_with_vir=
gl_blobs_gpu
ok 2 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt_with_vir=
gl_gpu

and then the third test timed out.

For the timing out case, the console prints


2025-02-20 11:12:55,208: # weston -B headless --renderer gl --shell
kiosk -- vkmark -b:duration=3D1.0
2025-02-20 11:12:55,288: Date: 2025-02-20 UTC
2025-02-20 11:12:55,288: [11:12:54.841] weston 14.0.0
2025-02-20 11:12:55,289: https://wayland.freedesktop.org
2025-02-20 11:12:55,289: Bug reports to:
https://gitlab.freedesktop.org/wayland/weston/issues/
2025-02-20 11:12:55,289: Build: 14.0.0
2025-02-20 11:12:55,291: [11:12:54.847] Command line: weston -B
headless --renderer gl --shell kiosk -- vkmark -b:duration=3D1.0
2025-02-20 11:12:55,298: [11:12:54.850] OS: Linux, 6.11.10, #2 SMP Thu
Dec  5 16:27:12 GMT 2024, aarch64
2025-02-20 11:12:55,299: [11:12:54.855] Flight recorder: enabled
2025-02-20 11:12:55,300: [11:12:54.857] warning: XDG_RUNTIME_DIR
"/tmp" is not configured
2025-02-20 11:12:55,301: correctly.  Unix access mode must be 0700
(current mode is 0777),
2025-02-20 11:12:55,301: and must be owned by the user UID 0 (current
owner is UID 0).
2025-02-20 11:12:55,302: Refer to your distribution on how to get it, or
2025-02-20 11:12:55,302:
http://www.freedesktop.org/wiki/Specifications/basedir-spec
2025-02-20 11:12:55,302: on how to implement it.
2025-02-20 11:12:55,308: [11:12:54.865] Starting with no config file.
2025-02-20 11:12:55,322: [11:12:54.879] Output repaint window is 7 ms maxim=
um.
2025-02-20 11:12:55,333: [11:12:54.890] Loading module
'/usr/lib/libweston-14/headless-backend.so'
2025-02-20 11:12:55,407: [11:12:54.963] Loading module
'/usr/lib/libweston-14/gl-renderer.so'
2025-02-20 11:13:06,936: [11:13:06.491] Using rendering device:
/dev/dri/renderD128
2025-02-20 11:13:07,083: [11:13:06.640] EGL version: 1.5
2025-02-20 11:13:07,084: [11:13:06.641] EGL vendor: Mesa Project
2025-02-20 11:13:07,085: [11:13:06.641] EGL client APIs: OpenGL OpenGL_ES
2025-02-20 11:13:07,088: [11:13:06.645] EGL features:
2025-02-20 11:13:07,089: EGL Wayland extension: yes
2025-02-20 11:13:07,089: context priority: no
2025-02-20 11:13:07,089: buffer age: no
2025-02-20 11:13:07,089: partial update: no
2025-02-20 11:13:07,090: swap buffers with damage: no
2025-02-20 11:13:07,090: configless context: yes
2025-02-20 11:13:07,090: surfaceless context: yes
2025-02-20 11:13:07,090: dmabuf support: modifiers
2025-02-20 11:13:07,206: [11:13:06.763] GL version: OpenGL ES 3.2 Mesa 24.3=
.0
2025-02-20 11:13:07,207: [11:13:06.764] GLSL version: OpenGL ES GLSL ES 3.2=
0
2025-02-20 11:13:07,207: [11:13:06.764] GL vendor: Mesa
2025-02-20 11:13:07,208: [11:13:06.764] GL renderer: virgl (Quadro
P400/PCIe/SSE2)
2025-02-20 11:13:08,201: [11:13:07.757] GL ES 3.2 - renderer features:
2025-02-20 11:13:08,202: read-back format: ARGB8888
2025-02-20 11:13:08,203: glReadPixels supports y-flip: yes
2025-02-20 11:13:08,203: glReadPixels supports PBO: yes
2025-02-20 11:13:08,204: wl_shm 10 bpc formats: yes
2025-02-20 11:13:08,204: wl_shm 16 bpc formats: yes
2025-02-20 11:13:08,205: wl_shm half-float formats: yes
2025-02-20 11:13:08,206: internal R and RG formats: yes
2025-02-20 11:13:08,209: OES_EGL_image_external: yes
2025-02-20 11:13:08,210: [11:13:07.767] Using GL renderer
2025-02-20 11:13:08,211: [11:13:07.768] Registered plugin API
'weston_windowed_output_api_headless_v2' of size 16
2025-02-20 11:13:08,215: [11:13:07.772] Color manager: no-op
2025-02-20 11:13:08,216: protocol support: no
2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
EOTF mode SDR and colorimetry mode default.
2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
profile: stock sRGB color profile

and that's the last thing it outputs.

The sanitizer reports that when the framework sends the SIGTERM
because of the timeout we get a write to a NULL pointer (but
interesting not this time in an atexit callback):

UndefinedBehaviorSanitizer:DEADLYSIGNAL
=3D=3D471863=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown addres=
s
0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
T471863)
=3D=3D471863=3D=3DThe signal is caused by a WRITE memory access.
=3D=3D471863=3D=3DHint: address points to the zero page.
    #0 0x7a18ceaafe80
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #1 0x7a18ce9e72c0
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #2 0x7a18ce9f11bb
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #3 0x7a18ce6dc9d1
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #4 0x7a18e7d15326 in vrend_renderer_create_fence
/usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_ren=
derer.c:10883:26
    #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/display=
/virtio-gpu-virgl.c:973:5
    #6 0x55bfb66086ba in virtio_gpu_process_cmdq
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/display=
/virtio-gpu.c:1048:9
    #7 0x55bfb661b69b in virtio_gpu_gl_handle_ctrl
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/display=
/virtio-gpu-gl.c:100:5
    #8 0x55bfb74a7782 in aio_bh_call
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/async=
.c:172:5
    #9 0x55bfb74a7b58 in aio_bh_poll
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/async=
.c:219:13
    #10 0x55bfb74625ea in aio_dispatch
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/aio-p=
osix.c:424:5
    #11 0x55bfb74aaaea in aio_ctx_dispatch
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/async=
.c:361:5
    #12 0x7a18e8dc15b4 in g_main_dispatch
/usr/src/glib2.0-2.80.0-6ubuntu3.2/debian/build/deb/../../../glib/gmain.c:3=
344:28
    #13 0x7a18e8dc16ff in g_main_context_dispatch_unlocked
/usr/src/glib2.0-2.80.0-6ubuntu3.2/debian/build/deb/../../../glib/gmain.c:4=
152:7
    #14 0x7a18e8dc16ff in g_main_context_dispatch
/usr/src/glib2.0-2.80.0-6ubuntu3.2/debian/build/deb/../../../glib/gmain.c:4=
140:3
    #15 0x55bfb74ab96b in glib_pollfds_poll
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/main-=
loop.c:287:9
    #16 0x55bfb74ab96b in os_host_main_loop_wait
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/main-=
loop.c:310:5
    #17 0x55bfb74ab96b in main_loop_wait
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../util/main-=
loop.c:589:11
    #18 0x55bfb64799e6 in qemu_main_loop
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/run=
state.c:835:9
    #19 0x55bfb7340356 in qemu_default_main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mai=
n.c:48:14
    #20 0x55bfb734032e in main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mai=
n.c:76:9
    #21 0x7a18e6a2a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #22 0x7a18e6a2a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #23 0x55bfb59b6554 in _start
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aar=
ch64+0x15dd554)
(BuildId: df0d680785eeda685de951dbbbbd220f5c9e773d)

UndefinedBehaviorSanitizer can not provide additional info.
SUMMARY: UndefinedBehaviorSanitizer: SEGV
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
=3D=3D471863=3D=3DABORTING



-- PMM

