Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DEDC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9hpj-0006FM-9i; Wed, 22 May 2024 05:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9hpZ-0006EU-KW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:00:17 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9hpS-0000hd-On
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:00:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a5a89787ea4so883856566b.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716368409; x=1716973209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3verJuMTVclz9wteuNhFF89Hcc8n4OpH4Y0Mtp7HDD4=;
 b=ezFvLlBgy5k9dyl7bkWEKMnKfGhCBeVdY5LoCAyPgy4eM33BIJV0W2DUM7pU5CL2z6
 UmebLyk4msVSWylCgf09d/FGo94aJHwM3Grn0p+lLNwYgTz+E26tNGwcTOEz3HALMivF
 60rSKpBLA1aLImSoA9ma/nBRp99RZPagszKiCGTVbPpWGB8W/IXcOvyDk8Z8LGSIS6Pt
 SjTdboWJMoks+UCgdm+p0MyOUn941hGwgUrQH538bCdFC5vHX3P5UOgoaF4VRi1ZD7OA
 4M+giTUD+lWIJMwy1Jnxj9LMuRzXR5AkqcqDcvpO2yOjtQIhK8pSZ3a2Z60JLq5Dsjt3
 1DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716368409; x=1716973209;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3verJuMTVclz9wteuNhFF89Hcc8n4OpH4Y0Mtp7HDD4=;
 b=XmUIgL0GQcOIEOPOaJKqOnTbLqlDT1jI/hhPPSQApnC/UEG97xIuuuZnGzUOTvKHEX
 MnT5XS/skOllrEXjbrRvDUoKPreOhYmYPoLhf/xI2l4fuARuE4TBGb85L2svDG7RUZaN
 gbwKqHdxWxzPHqVNJ0yIjBakmNdPVZhgYq5BFl7XDu9BXSTDzHDXL7SqI1Sg8Io7kXE+
 /B/AV2Q5i09aaAy2JwhDPXZJcpD7Z0DM6bSU9pdej0D9GpDhiZRfyeM8AK31DNWduvzL
 rHhc1vg5qAo5njHcExgl5W2trKESvF4sspbA9w48yX9V0g5iox24jWKMYRuxq+CxAYev
 uOdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwl9WvtYAZueG5X1BWSwdTH3IrTJVzX2xx67yI2A9wjzZMpEnO+fCBi4b5x7RXC3NYlDs59z/vk5FODcNBYQPUDNgs0Q=
X-Gm-Message-State: AOJu0YxA5ZZwQG1BP5SLEAczN5B72ngzQdEEVmFpEDG9RjT2huu6yuID
 PYhdeCgyPPxokwLII4Z4Rrkq11/wC58JZufmsuPO3s3HrN6807rVIHKxotnlI9E=
X-Google-Smtp-Source: AGHT+IGmOEeEIG6P4d9qsirE241Pm7HAD+6LVU2ebDKfDA/rTvldIBwrCG4fu9F1Vj/vkQ5x23vmaw==
X-Received: by 2002:a17:907:26cb:b0:a59:f30e:fecd with SMTP id
 a640c23a62f3a-a622807a844mr107633066b.2.1716368408644; 
 Wed, 22 May 2024 02:00:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0125bsm1765608766b.143.2024.05.22.02.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 02:00:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7C415F78B;
 Wed, 22 May 2024 10:00:07 +0100 (BST)
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
In-Reply-To: <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com> (Dmitry
 Osipenko's message of "Wed, 22 May 2024 03:02:30 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org> <87jzjni569.fsf@draig.linaro.org>
 <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
Date: Wed, 22 May 2024 10:00:07 +0100
Message-ID: <874jaqi5m0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 5/21/24 17:57, Alex Benn=C3=A9e wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>
>>>> Hello,
>>>>
>>>> This series enables Vulkan Venus context support on virtio-gpu.
>>>>
>>>> All virglrender and almost all Linux kernel prerequisite changes
>>>> needed by Venus are already in upstream. For kernel there is a pending
>>>> KVM patchset that fixes mapping of compound pages needed for DRM drive=
rs
>>>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM er=
ror
>>>> from Qemu.
>>>>
>>>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@goog=
le.com/
>>>>
>>>> You'll need to use recent Mesa version containing patch that removes
>>>> dependency on cross-device feature from Venus that isn't supported by
>>>> Qemu [2].
>>>>
>>>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e2=
6987befae78b6ccbb7ae242b
>>>>
>>>> Example Qemu cmdline that enables Venus:
>>>>
>>>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,ve=
nus=3Dtrue \
>>>>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>>>>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>>>
>>> What is the correct device for non-x86 guests? We have virtio-gpu-gl-pci
>>> but when doing that I get:
>>>
>>>   -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtrue
>>>   qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtr=
ue,venus=3Dtrue: opengl is not available
>>>
>>> According to 37f86af087 (virtio-gpu: move virgl realize + properties):
>>>
>>>   Drop the virgl property, the virtio-gpu-gl-device has virgl enabled no
>>>   matter what.  Just use virtio-gpu-device instead if you don't want
>>>   enable virgl and opengl.  This simplifies the logic and reduces the t=
est
>>>   matrix.
>>>
>>> but that's not a good solution because that needs virtio-mmio and there
>>> are reasons to have a PCI device (for one thing no ambiguity about
>>> discovery).
>>=20
>> Oops my mistake forgetting:
>>=20
>>   --display gtk,gl=3Don
>>=20
>> Although I do see a lot of eglMakeContext failures.
>
> Please post the full Qemu cmdline you're using

With:

  ./qemu-system-aarch64 \
           -machine type=3Dvirt,virtualization=3Don,pflash0=3Drom,pflash1=
=3Defivars \
           -cpu neoverse-n1 \
           -smp 4 \
           -accel tcg \
           -device virtio-net-pci,netdev=3Dunet \
           -device virtio-scsi-pci \
           -device scsi-hd,drive=3Dhd \
           -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
           -blockdev driver=3Draw,node-name=3Dhd,file.driver=3Dhost_device,=
file.filename=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap \
           -serial mon:stdio \
           -blockdev node-name=3Drom,driver=3Dfile,filename=3D(pwd)/pc-bios=
/edk2-aarch64-code.fd,read-only=3Dtrue \
           -blockdev node-name=3Defivars,driver=3Dfile,filename=3D$HOME/ima=
ges/qemu-arm64-efivars \
           -m 8192 \
           -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
           -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtrue \
           -display gtk,gl=3Don,show-cursor=3Don -vga none \
           -device qemu-xhci -device usb-kbd -device usb-tablet

I get a boot up with a lot of:

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20

  (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20

  (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20

  (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20

In the guest I run:

  meson devenv -C /root/lsrc/graphics/mesa.git/build fish

to bring in the latest Mesa (with virtio enabled). Running vulkaninfo
reports two cards:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
  VULKANINFO=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20

  Vulkan Instance Version: 1.3.280=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20


  Instance Extensions: count =3D 14
  -------------------------------
  VK_EXT_debug_report                    : extension revision 10
  VK_EXT_debug_utils                     : extension revision 2
  VK_EXT_headless_surface                : extension revision 1
  VK_KHR_device_group_creation           : extension revision 1
  VK_KHR_external_fence_capabilities     : extension revision 1
  VK_KHR_external_memory_capabilities    : extension revision 1
  VK_KHR_external_semaphore_capabilities : extension revision 1
  VK_KHR_get_physical_device_properties2 : extension revision 2
  VK_KHR_get_surface_capabilities2       : extension revision 1
  VK_KHR_portability_enumeration         : extension revision 1
  VK_KHR_surface                         : extension revision 25
  VK_KHR_surface_protected_capabilities  : extension revision 1
  VK_KHR_wayland_surface                 : extension revision 6
  VK_LUNARG_direct_driver_loading        : extension revision 1

  Instance Layers: count =3D 2
  --------------------------
  VK_LAYER_MESA_device_select Linux device selection layer 1.3.211  version=
 1
  VK_LAYER_MESA_overlay       Mesa Overlay layer           1.3.211
  version 1

  Devices:
  =3D=3D=3D=3D=3D=3D=3D=3D
  GPU0:
          apiVersion         =3D 1.3.230
          driverVersion      =3D 24.1.99
          vendorID           =3D 0x8086
          deviceID           =3D 0xa780
          deviceType         =3D PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
          deviceName         =3D Virtio-GPU Venus (Intel(R) Graphics (RPL-S=
))
          driverID           =3D DRIVER_ID_MESA_VENUS
          driverName         =3D venus
          driverInfo         =3D Mesa 24.2.0-devel (git-0b582449f0)
          conformanceVersion =3D 1.3.0.0
          deviceUUID         =3D 29d2e940-a1a0-3054-0f9a-9f7dec52a084
          driverUUID         =3D 3694c390-f245-612a-12ce-7d3a99127622
  GPU1:
          apiVersion         =3D 1.2.0
          driverVersion      =3D 24.1.99
          vendorID           =3D 0x10005
          deviceID           =3D 0x0000
          deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
          deviceName         =3D Virtio-GPU Venus (llvmpipe (LLVM 15.0.6, 2=
56 bits))
          driverID           =3D DRIVER_ID_MESA_VENUS
          driverName         =3D venus
          driverInfo         =3D Mesa 24.2.0-devel (git-0b582449f0)
          conformanceVersion =3D 1.3.0.0
          deviceUUID         =3D 5fb5c03f-c537-f0fe-a7e6-9cd5866acb8d
          driverUUID         =3D 3694c390-f245-612a-12ce-7d3a99127622

Running weston and then vkcube-wayland reports its selecting "GPU 0:
Virtio-GPU Venus (Intel(R) Graphics (RPL-S))" but otherwise produces no
output.

If I run with "-display sdl,gl=3Don,show-cursor=3Don" and the same other
command line options the results for vulkaninfo are the same. However
vkcube-wayland gets a little further and draws the initial cube on the
screen before locking up with:

 MESA-VIRTIO: debug: stuck in fence wait with iter at xxxx

where xxxx grows each time it prints. On shutting down I see some virgl
errors interspersed with the systemd logs:

  [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (=
command 0x209)
  [  OK  ] Stopped systemd-logind.service - User Login Management.
  virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
  [  475.257111] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* re=
sponse 0x1200 (command 0x209)
  [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (=
command 0x209)
  [  OK  ] Stopped target network-online.target - Network is Online.
  [  OK  ] Stopped target remote-fs.target - Remote File Systems.
  [  OK  ] Stopped NetworkManager-wait-online=E2=80=A6vice - Network Manage=
r Wait Online.
           Stopping avahi-daemon.service - Avahi mDNS/DNS-SD Stack...
           Stopping cups.service - CUPS Scheduler...
           Stopping user-runtime-dir@0.servic=E2=80=A6er Runtime Directory =
/run/user/0...
  [  OK  ] Stopped avahi-daemon.service - Avahi mDNS/DNS-SD Stack.
  [  OK  ] Stopped cups.service - CUPS Scheduler.
  virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
  [  475.357543] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* re=
sponse 0x1200 (command 0x209)
  [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (=
command 0x209)
  [  OK  ] Stopped target network.target - Network.
  [  OK  ] Stopped target nss-user-lookup.target - User and Group Name Look=
ups.
           Stopping NetworkManager.service - Network Manager...
           Stopping networking.service - Raise network interfaces...
           Stopping wpa_supplicant.service - WPA supplicant...
  [  OK  ] Stopped wpa_supplicant.service - WPA supplicant.
  virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
  [  493.585261] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* re=
sponse 0x1200 (command 0x209)
  [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (=
command 0x209)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

