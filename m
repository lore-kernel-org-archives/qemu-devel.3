Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C321C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErvH-00046w-Sz; Wed, 05 Jun 2024 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sErvF-00046L-He
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:47:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sErvC-0005IG-19
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:47:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4214fe0067fso17615915e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717598843; x=1718203643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UwrLbKEU0CFTya0nZ+h3iT7mF9tXfSoC70VVlca/dzU=;
 b=lH09UfgxXK8eJe6PuKm/dn8rtHMSl1/ALFfW+5JUgKxAL7aNm+Vjw1WkIFz8CePmBB
 BEnEKwNSK8qHTreIeOfzjM/xT4TAt+EEWu6jW/lXyVEaEdMYgUsmdXb3yckSWPIkdEWF
 2eKXQHtLfnT95I1qFN0w/d0C++qvTyaMiM7sOMBTXvMRec9bQ1Jb1DAsl5jgCkMMzLUs
 r3/cXXMFxKp6n1oxjlpYQWtVyKtbThnQ7H4lSIE5jWyLebBQjRMtRSLL/LIfoIvSzAjP
 NJDtkt6/coHcXoawO+su5k/m+O4LaXpWbjx0YFN5gom9D9Lbq4CGSQPEpskALTXPeBHi
 6yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598843; x=1718203643;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwrLbKEU0CFTya0nZ+h3iT7mF9tXfSoC70VVlca/dzU=;
 b=vDcCLSzM5hGX9xNYmqhYEymUY2f1gHciUW27aMaD66lWLWCtinL6IiTsElMqHW2uEG
 /SA5AtJbFdJ8oD7XIGkgEdxjscaaEef386lo7hRyh7jLPTmwQPvVJCrzeOTj5FYyTnSJ
 5cHy7LB9xY8m1bEckqKqBHBOplqAHmHSbCLXUmVBhjT9FydsQtmW96RyZrg21lomk2hm
 700La9EB1wRaJ3BIn1Oks3fXZ/g+f/86GFMx1ZRDbFxRE0ZKOCi/7W43ruxwEbigSaRm
 0iq+OBHDQpEauWVgqAtVHuZuyJ6t+Md8pogvbsLha2ZUZ6qSLbesE5/Jar47U54q8oyV
 7vAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRvDDbl7rE73QdeHrMHXW2iPvdbkEzF4MyNK0YB6X8ur1O+wptSAKGoGGw0mcVplfpmgxRD4K0+S9c13R3Bk/kGjzY4ck=
X-Gm-Message-State: AOJu0YwsXZANy1BcJU8VoUCXGUaaP1RV5U4bkv1S9LCYwb7hK3hFpTek
 OtTEBMJw6PzpuF+TIBjuuK3JzpxTIpcamuoD+fiJTol12BtAxfFdFXqVnhU+FDQ=
X-Google-Smtp-Source: AGHT+IE0AEkzhDKbO6fX9rrqHo3zA8PPM4mRWnkO4chtg6uNJM0z0fJ7Lb6HMJ2L6SAEn2lCI6+9hA==
X-Received: by 2002:a05:600c:470f:b0:420:2ca9:1b90 with SMTP id
 5b1f17b1804b1-421562c7f59mr21544535e9.5.1717598843365; 
 Wed, 05 Jun 2024 07:47:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158135c3esm23972115e9.35.2024.06.05.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:47:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E4A05F754;
 Wed,  5 Jun 2024 15:47:22 +0100 (BST)
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
Subject: Re: [PATCH v12 00/13] Support blob memory and venus on qemu
In-Reply-To: <6bc5a3fc-8fbc-4449-a5e6-cd654655be35@collabora.com> (Dmitry
 Osipenko's message of "Mon, 27 May 2024 02:46:09 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org> <87jzjni569.fsf@draig.linaro.org>
 <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
 <874jaqi5m0.fsf@draig.linaro.org>
 <6bc5a3fc-8fbc-4449-a5e6-cd654655be35@collabora.com>
Date: Wed, 05 Jun 2024 15:47:22 +0100
Message-ID: <874ja7fnut.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

> On 5/22/24 12:00, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> On 5/21/24 17:57, Alex Benn=C3=A9e wrote:
>>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>>
>>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> This series enables Vulkan Venus context support on virtio-gpu.
>>>>>>
>>>>>> All virglrender and almost all Linux kernel prerequisite changes
>>>>>> needed by Venus are already in upstream. For kernel there is a pendi=
ng
>>>>>> KVM patchset that fixes mapping of compound pages needed for DRM dri=
vers
>>>>>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM =
error
>>>>>> from Qemu.
>>>>>>
>>>>>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@go=
ogle.com/
>>>>>>
>>>>>> You'll need to use recent Mesa version containing patch that removes
>>>>>> dependency on cross-device feature from Venus that isn't supported by
>>>>>> Qemu [2].
>>>>>>
>>>>>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155=
e26987befae78b6ccbb7ae242b
>>>>>>
>>>>>> Example Qemu cmdline that enables Venus:
>>>>>>
>>>>>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,=
venus=3Dtrue \
>>>>>>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>>>>>>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>>>>>
>>>>> What is the correct device for non-x86 guests? We have virtio-gpu-gl-=
pci
>>>>> but when doing that I get:
>>>>>
>>>>>   -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtrue
>>>>>   qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3D=
true,venus=3Dtrue: opengl is not available
>>>>>
>>>>> According to 37f86af087 (virtio-gpu: move virgl realize + properties):
>>>>>
>>>>>   Drop the virgl property, the virtio-gpu-gl-device has virgl enabled=
 no
>>>>>   matter what.  Just use virtio-gpu-device instead if you don't want
>>>>>   enable virgl and opengl.  This simplifies the logic and reduces the=
 test
>>>>>   matrix.
>>>>>
>>>>> but that's not a good solution because that needs virtio-mmio and the=
re
>>>>> are reasons to have a PCI device (for one thing no ambiguity about
>>>>> discovery).
>>>>
>>>> Oops my mistake forgetting:
>>>>
>>>>   --display gtk,gl=3Don
>>>>
>>>> Although I do see a lot of eglMakeContext failures.
>>>
>>> Please post the full Qemu cmdline you're using
>>=20
>> With:
>>=20
>>   ./qemu-system-aarch64 \
>>            -machine type=3Dvirt,virtualization=3Don,pflash0=3Drom,pflash=
1=3Defivars \
>>            -cpu neoverse-n1 \
>>            -smp 4 \
>>            -accel tcg \
>>            -device virtio-net-pci,netdev=3Dunet \
>>            -device virtio-scsi-pci \
>>            -device scsi-hd,drive=3Dhd \
>>            -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>>            -blockdev driver=3Draw,node-name=3Dhd,file.driver=3Dhost_devi=
ce,file.filename=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap \
>>            -serial mon:stdio \
>>            -blockdev node-name=3Drom,driver=3Dfile,filename=3D(pwd)/pc-b=
ios/edk2-aarch64-code.fd,read-only=3Dtrue \
>>            -blockdev node-name=3Defivars,driver=3Dfile,filename=3D$HOME/=
images/qemu-arm64-efivars \
>>            -m 8192 \
>>            -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
>>            -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtr=
ue \
>>            -display gtk,gl=3Don,show-cursor=3Don -vga none \
>>            -device qemu-xhci -device usb-kbd -device usb-tablet
>>=20
>> I get a boot up with a lot of:
>>=20
>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>>=20
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>>=20
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>>=20
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>=20
>> In the guest I run:
>>=20
>>   meson devenv -C /root/lsrc/graphics/mesa.git/build fish
>>=20
>> to bring in the latest Mesa (with virtio enabled). Running vulkaninfo
>> reports two cards:
>>=20
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>>   VULKANINFO=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>>=20
>>   Vulkan Instance Version: 1.3.280=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>=20
>>=20
>>   Instance Extensions: count =3D 14
>>   -------------------------------
>>   VK_EXT_debug_report                    : extension revision 10
>>   VK_EXT_debug_utils                     : extension revision 2
>>   VK_EXT_headless_surface                : extension revision 1
>>   VK_KHR_device_group_creation           : extension revision 1
>>   VK_KHR_external_fence_capabilities     : extension revision 1
>>   VK_KHR_external_memory_capabilities    : extension revision 1
>>   VK_KHR_external_semaphore_capabilities : extension revision 1
>>   VK_KHR_get_physical_device_properties2 : extension revision 2
>>   VK_KHR_get_surface_capabilities2       : extension revision 1
>>   VK_KHR_portability_enumeration         : extension revision 1
>>   VK_KHR_surface                         : extension revision 25
>>   VK_KHR_surface_protected_capabilities  : extension revision 1
>>   VK_KHR_wayland_surface                 : extension revision 6
>>   VK_LUNARG_direct_driver_loading        : extension revision 1
>>=20
>>   Instance Layers: count =3D 2
>>   --------------------------
>>   VK_LAYER_MESA_device_select Linux device selection layer 1.3.211  vers=
ion 1
>>   VK_LAYER_MESA_overlay       Mesa Overlay layer           1.3.211
>>   version 1
>>=20
>>   Devices:
>>   =3D=3D=3D=3D=3D=3D=3D=3D
>>   GPU0:
>>           apiVersion         =3D 1.3.230
>>           driverVersion      =3D 24.1.99
>>           vendorID           =3D 0x8086
>>           deviceID           =3D 0xa780
>>           deviceType         =3D PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
>>           deviceName         =3D Virtio-GPU Venus (Intel(R) Graphics (RP=
L-S))
>>           driverID           =3D DRIVER_ID_MESA_VENUS
>>           driverName         =3D venus
>>           driverInfo         =3D Mesa 24.2.0-devel (git-0b582449f0)
>>           conformanceVersion =3D 1.3.0.0
>>           deviceUUID         =3D 29d2e940-a1a0-3054-0f9a-9f7dec52a084
>>           driverUUID         =3D 3694c390-f245-612a-12ce-7d3a99127622
>>   GPU1:
>>           apiVersion         =3D 1.2.0
>>           driverVersion      =3D 24.1.99
>>           vendorID           =3D 0x10005
>>           deviceID           =3D 0x0000
>>           deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
>>           deviceName         =3D Virtio-GPU Venus (llvmpipe (LLVM 15.0.6=
, 256 bits))
>>           driverID           =3D DRIVER_ID_MESA_VENUS
>>           driverName         =3D venus
>>           driverInfo         =3D Mesa 24.2.0-devel (git-0b582449f0)
>>           conformanceVersion =3D 1.3.0.0
>>           deviceUUID         =3D 5fb5c03f-c537-f0fe-a7e6-9cd5866acb8d
>>           driverUUID         =3D 3694c390-f245-612a-12ce-7d3a99127622
>>=20
>> Running weston and then vkcube-wayland reports its selecting "GPU 0:
>> Virtio-GPU Venus (Intel(R) Graphics (RPL-S))" but otherwise produces no
>> output.
>>=20
>> If I run with "-display sdl,gl=3Don,show-cursor=3Don" and the same other
>> command line options the results for vulkaninfo are the same. However
>> vkcube-wayland gets a little further and draws the initial cube on the
>> screen before locking up with:
>>=20
>>  MESA-VIRTIO: debug: stuck in fence wait with iter at xxxx
>>=20
>> where xxxx grows each time it prints. On shutting down I see some virgl
>> errors interspersed with the systemd logs:
>>=20
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x120=
0 (command 0x209)
>>   [  OK  ] Stopped systemd-logind.service - User Login Management.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  475.257111] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR*=
 response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x120=
0 (command 0x209)
>>   [  OK  ] Stopped target network-online.target - Network is Online.
>>   [  OK  ] Stopped target remote-fs.target - Remote File Systems.
>>   [  OK  ] Stopped NetworkManager-wait-online=E2=80=A6vice - Network Man=
ager Wait Online.
>>            Stopping avahi-daemon.service - Avahi mDNS/DNS-SD Stack...
>>            Stopping cups.service - CUPS Scheduler...
>>            Stopping user-runtime-dir@0.servic=E2=80=A6er Runtime Directo=
ry /run/user/0...
>>   [  OK  ] Stopped avahi-daemon.service - Avahi mDNS/DNS-SD Stack.
>>   [  OK  ] Stopped cups.service - CUPS Scheduler.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  475.357543] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR*=
 response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x120=
0 (command 0x209)
>>   [  OK  ] Stopped target network.target - Network.
>>   [  OK  ] Stopped target nss-user-lookup.target - User and Group Name L=
ookups.
>>            Stopping NetworkManager.service - Network Manager...
>>            Stopping networking.service - Raise network interfaces...
>>            Stopping wpa_supplicant.service - WPA supplicant...
>>   [  OK  ] Stopped wpa_supplicant.service - WPA supplicant.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  493.585261] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR*=
 response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x120=
0 (command 0x209)
>>=20
>
> I've reproduced this with qemu-system-aarch64. Vkcube works for a second
> and then stops, Qemu compeltely gets frozen after closing and re-running
> vkcube. Doesn't feel like this is a problem with venus, but with arm64.
> For now don't know where is the bug, will take a closer look.

I'm guessing some sort of resource leak, if I run vkcube-wayland in the
guest it complains about being stuck on a fence with the iterator going
up. However on the host I see:

  virtio_gpu_fence_ctrl fence 0x13f1, type 0x207
  virtio_gpu_fence_ctrl fence 0x13f2, type 0x207
  virtio_gpu_fence_resp fence 0x13f1
  virtio_gpu_fence_resp fence 0x13f2
  virtio_gpu_fence_ctrl fence 0x13f3, type 0x207
  virtio_gpu_fence_ctrl fence 0x13f4, type 0x207
  virtio_gpu_fence_resp fence 0x13f3
  virtio_gpu_fence_resp fence 0x13f4
  virtio_gpu_fence_ctrl fence 0x13f5, type 0x207
  virtio_gpu_fence_ctrl fence 0x13f6, type 0x207
  virtio_gpu_fence_resp fence 0x13f5
  virtio_gpu_fence_resp fence 0x13f6
  virtio_gpu_fence_ctrl fence 0x13f7, type 0x207
  virtio_gpu_fence_ctrl fence 0x13f8, type 0x207
  virtio_gpu_fence_resp fence 0x13f7
  virtio_gpu_fence_resp fence 0x13f8
  virtio_gpu_fence_ctrl fence 0x13f9, type 0x204
  virtio_gpu_fence_resp fence 0x13f9

which looks like its going ok. However when I git Ctrl-C in the guest it
kills QEMU:

  virtio_gpu_fence_ctrl fence 0x13fc, type 0x207
  virtio_gpu_fence_ctrl fence 0x13fd, type 0x207
  virtio_gpu_fence_ctrl fence 0x13fe, type 0x204
  virtio_gpu_fence_ctrl fence 0x13ff, type 0x207
  virtio_gpu_fence_ctrl fence 0x1400, type 0x207
  virtio_gpu_fence_resp fence 0x13fc
  virtio_gpu_fence_resp fence 0x13fd
  virtio_gpu_fence_resp fence 0x13fe
  virtio_gpu_fence_resp fence 0x13ff
  virtio_gpu_fence_resp fence 0x1400
  qemu-system-aarch64: ../../subprojects/virglrenderer/src/virglrenderer.c:=
1282: virgl_renderer_resource_unmap: Assertion `!ret' failed.
  fish: Job 1, './qemu-system-aarch64 \' terminated by signal     -machine =
type=3Dvirt,virtuali=E2=80=A6 (    -cpu neoverse-n1 \)
  fish: Job     -smp 4 \, '    -accel tcg \' terminated by signal     -devi=
ce virtio-net-pci,netd=E2=80=A6 (    -device virtio-scsi-pci \)
  fish: Job     -device scsi-hd,drive=3Dhd \, '    -netdev user,id=3Dunet,h=
ostfw=E2=80=A6' terminated by signal     -blockdev driver=3Draw,node-n=E2=
=80=A6 (    -serial mon:stdio \)
  fish: Job     -blockdev node-name=3Drom,dri=E2=80=A6, '    -blockdev node=
-name=3Defivars=E2=80=A6' terminated by signal     -m 8192 \ (    -object m=
emory-backend-memf=E2=80=A6)
  fish: Job     -device virtio-gpu-gl-pci,h=E2=80=A6, '    -display sdl,gl=
=3Don,show-cur=E2=80=A6' terminated by signal     -device qemu-xhci -device=
 u=E2=80=A6 (    -kernel /home/alex/lsrc/lin=E2=80=A6)
  fish: Job     -d guest_errors,unimp,trace=E2=80=A6, 'SIGABRT' terminated =
by signal Abort ()

The backtrace (and the 18G size of the core file!) indicates a leak:

  (gdb) bt
  #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  #1  0x00007f0fa68a9e8f in __pthread_kill_internal (signo=3D6, threadid=3D=
<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007f0fa685afb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
  #3  0x00007f0fa6845472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007f0fa6845395 in __assert_fail_base
      (fmt=3D0x7f0fa69b9a90 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", as=
sertion=3Dassertion@entry=3D0x55c3e1b0762d "!ret", file=3Dfile@entry=3D0x55=
c3e1d306f0 "../../subprojects/virglrenderer/src/virglrenderer.c", line=3Dli=
ne@entry=3D1282, function=3Dfunction@entry=3D0x55c3e1d30910 <__PRETTY_FUNCT=
ION__.2> "virgl_renderer_resource_unmap") at ./assert/assert.c:92
  #5  0x00007f0fa6853eb2 in __GI___assert_fail
      (assertion=3Dassertion@entry=3D0x55c3e1b0762d "!ret", file=3Dfile@ent=
ry=3D0x55c3e1d306f0 "../../subprojects/virglrenderer/src/virglrenderer.c", =
line=3Dline@entry=3D1282, function=3Dfunction@entry=3D0x55c3e1d30910 <__PRE=
TTY_FUNCTION__.2> "virgl_renderer_resource_unmap") at ./assert/assert.c:101
  #6  0x000055c3e1958b50 in virgl_renderer_resource_unmap (res_handle=3D<op=
timized out>) at ../../subprojects/virglrenderer/src/virglrenderer.c:1282
  #7  0x000055c3e13d8507 in virtio_gpu_virgl_unmap_resource_blob (g=3Dg@ent=
ry=3D0x55c3e5fed600, res=3D0x55c3e6e67b60, cmd_suspended=3Dcmd_suspended@en=
try=3D0x7ffd5d720aaf)
      at ../../hw/display/virtio-gpu-virgl.c:188
  #8  0x000055c3e13d9af4 in virgl_cmd_resource_unmap_blob (cmd_suspended=3D=
0x7ffd5d720aaf, cmd=3D0x55c3e5bd9710, g=3D0x55c3e5fed600) at ../../hw/displ=
ay/virtio-gpu-virgl.c:797
  #9  virtio_gpu_virgl_process_cmd (g=3D0x55c3e5fed600, cmd=3D0x55c3e5bd971=
0) at ../../hw/display/virtio-gpu-virgl.c:979
  #10 0x000055c3e13d6019 in virtio_gpu_process_cmdq (g=3D0x55c3e5fed600) at=
 ../../hw/display/virtio-gpu.c:1055
  #11 0x000055c3e190c646 in aio_bh_poll (ctx=3Dctx@entry=3D0x55c3e4c03710) =
at ../../util/async.c:218
  #12 0x000055c3e18f562e in aio_dispatch (ctx=3D0x55c3e4c03710) at ../../ut=
il/aio-posix.c:423
  #13 0x000055c3e190c2ce in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>, user_data=3D<optimized out>) at ../../util/async.c=
:360
  #14 0x00007f0fa8b047a9 in g_main_context_dispatch () at /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
  #15 0x000055c3e190db78 in glib_pollfds_poll () at ../../util/main-loop.c:=
287
  #16 os_host_main_loop_wait (timeout=3D1882878) at ../../util/main-loop.c:=
310
  #17 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at ../../util/ma=
in-loop.c:589
  #18 0x000055c3e1348ac9 in qemu_main_loop () at ../../system/runstate.c:796
  #19 0x000055c3e174f786 in qemu_default_main () at ../../system/main.c:37
  #20 0x00007f0fa684624a in __libc_start_call_main (main=3Dmain@entry=3D0x5=
5c3e10286e0 <main>, argc=3Dargc@entry=3D47, argv=3Dargv@entry=3D0x7ffd5d720=
f18)
      at ../sysdeps/nptl/libc_start_call_main.h:58
  #21 0x00007f0fa6846305 in __libc_start_main_impl
      (main=3D0x55c3e10286e0 <main>, argc=3D47, argv=3D0x7ffd5d720f18, init=
=3D<optimized out>, fini=3D<optimized out>, rtld_fini=3D<optimized out>, st=
ack_end=3D0x7ffd5d720f08)
      at ../csu/libc-start.c:360
  #22 0x000055c3e102a3f1 in _start ()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

