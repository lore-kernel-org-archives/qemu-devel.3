Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA504C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 14:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWdr5-0008Da-LX; Sun, 04 Feb 2024 09:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWdr4-0008DR-Mg
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:52:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWdr2-0006db-FO
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:52:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso29769395e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707058338; x=1707663138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/adSQzk+2YK7Z+c0OIaOKumnx2TiuSS4b2wDfNOU7Qw=;
 b=m2+Qxeej//4Nf62vLydMxRkIGEr+KTJDuCSq94gHby9EQYDJLisQRK2IEbReSUSWW4
 rursqUpOG8EguqhJdY4E1q8lrEBHNj6XiNAgYnsYHi5eC53L9pqbCFdmnz7ORF0/1sWs
 R5o3asw7QsPh9ffRHjc4N2YqHpnaJxgckTDbrTwMTdhN34od8CvkTcnKrBYMQp7e7f7Y
 LDMZCd5pLY54einI6Hy/gEzYrt+4toj6XD75+Z/+7GAwxfumTpcgWs4hSrmzimO6eZVJ
 ReeX7KHLCn4SV91nplCiJun4nLSjbzPZafrd/17gvarqMBJQmNysmJQprVYLMotHpY+a
 Wwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707058338; x=1707663138;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/adSQzk+2YK7Z+c0OIaOKumnx2TiuSS4b2wDfNOU7Qw=;
 b=kMF11ggQNVSUnUrBryaVL5IaMUjuzAPW9sxecw6MABeD0+cqEDKR+WHhsjWi8QcYzm
 xeYyaO+FjvrWlwuSE0qMJ8wBWm26VTDofJBzF4EDB4tf2/+pb3R984oyFOQVCC7DTtvs
 V2ZSLn/WY9oAwbQbZ4tOVZf5HsJSsLS/h2+OsYWaMVplvbnQn0hlNF20A7JxfEx00cH7
 GqKmYXXqzWMqUE9E/JkSFF43ueYvTpaB+HY1nugCq3kzKaH6y/bOnvEtDb/QRUjqAI4a
 FIz5b7+GHVB3yO4q5V+UnRCPKsWXu51EXCOdbEVoEqoTr0yli7FM2UQzmpHL6PwqCoJD
 aVCg==
X-Gm-Message-State: AOJu0YwsKuTAq0NBGsBNZZq/1Hb3nU8hVk4eOBQBvk3V2nAzVvNaTuaI
 9TcHqt8j3N8WC/3iXM6zYqfj5ELCj0idCVg3Z/yD/gqSkDeCZzNcNoOyntwX8Mw=
X-Google-Smtp-Source: AGHT+IE20GxRi94rJTEWkc2G2cquwW0cYhAfw47276t1CARIWG5fV7DUHSZeix+pJgOPsqxcl0tRAg==
X-Received: by 2002:a05:600c:154f:b0:40e:68a9:ab56 with SMTP id
 f15-20020a05600c154f00b0040e68a9ab56mr2643391wmg.36.1707058338183; 
 Sun, 04 Feb 2024 06:52:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU1kXjFXR3yTC/UTNP6/uClTuupPUzo7yvSQrXOjQo1XDLMoENB7HcezWib/DbCwjElVSGB2ok2jrduu1PVVixC4+/X/vdN6qFHZBrcJrRpq3OGs3ECmzA77cnXkhd9piECKndEbM3xbKk7qBVhJofXHS5VPXfIGJuUlpuGm/tEIzmlZsUmds9Kt1AjIrSJsZwihZU1nv6y16QUBKOHgILaxbaYmcg7JMuXkJvDPW8okcP5KQ==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c510f00b0040d5ae2906esm5920821wms.30.2024.02.04.06.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 06:52:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 607AB5F9DC;
 Sun,  4 Feb 2024 14:52:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: virglrenderer-devel@lists.freedesktop.org
Cc: qemu-devel <qemu-devel@nongnu.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Huang Rui <ray.huang@amd.com>,  Antonio Caggiano
 <antonio.caggiano@collabora.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: Help understanding allocation and mapping flow of virtio-gpu 3D
 resource blobs
In-Reply-To: <87r0hso5ds.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Sun, 04 Feb 2024 11:06:39 +0000")
References: <87r0hso5ds.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Sun, 04 Feb 2024 14:52:17 +0000
Message-ID: <87le80nuxq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

(doh, replying to virglrender-devel thanks to autocomplete failure)

> Hi,
>
> I'm trying to get an understanding of the blob allocation and mapping
> flow for virtio-gpu for Vulkan and Rutabaga. Having gotten all the
> various libraries setup I'm still seeing failures when running a TCG
> guest (buildroot + latest glm, mesa, vkmark) with:
>
>   ./qemu-system-aarch64 \
>              -M virt -cpu cortex-a76 \
>              -m 8192 \
>              -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
>              -serial mon:stdio \
>              -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/b=
oot/Image \
>              -append "console=3DttyAMA0" \
>              -device virtio-gpu-gl,context_init=3Dtrue,blob=3Dtrue,hostme=
m=3D4G \
>              -display sdl,gl=3Don -d guest_errors,trace:virtio_gpu_cmd_re=
s\*,trace:virtio_gpu_virgl_process_command -D debug.log
>
> which shows up as detected in dmesg but not to vulkaninfo:
>
>   [    0.644879] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   [    0.648643] virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
>   [    0.672391] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>   [    0.678071] Serial: AMBA driver=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   [    0.682122] [drm] pci: virtio-gpu-pci detected at 0000:00:02.0=20=20=
=20=20=20=20=20=20=20=20=20
>   [    0.683249] [drm] Host memory window: 0x8000000000 +0x100000000
>   [    0.683420] [drm] features: +virgl +edid +resource_blob +host_visible
>   [    0.683470] [drm] features: +context_init=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   [    0.695695] [drm] number of scanouts: 1=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
>   [    0.695837] [drm] number of cap sets: 3=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
>   [    0.716173] [drm] cap set 0: id 1, max-version 1, max-size 308
>   [    0.716499] [drm] cap set 1: id 2, max-version 2, max-size 1384=20=
=20=20=20=20=20=20=20=20=20
>   [    0.716686] [drm] cap set 2: id 4, max-version 0, max-size 160=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
>   [    0.726001] [drm] Initialized virtio_gpu 0.1.0 0 for 0000:00:02.0 on=
 minor 0
>   virgl_resource_create: err=3D0, res=3D2=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   virgl_renderer_resource_attach_iov: 0x55b843c17a80/2=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>   virgl_resource_attach_iov: pipe_resource: 0x55b8434da8f0=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   vrend_pipe_resource_attach_iov: 0x43=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>
>   ...
>
>   # vulkaninfo --summary
>   WARNING: [Loader Message] Code 0 : terminator_CreateInstance: Failed to=
 CreateInstance in ICD 1.  Skipping ICD.
>   error: XDG_RUNTIME_DIR is invalid or not set in the environment.
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   VULKANINFO
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Vulkan Instance Version: 1.3.262
>
>
>   Instance Extensions: count =3D 12
>   -------------------------------
>   VK_EXT_debug_report                    : extension revision 10
>   VK_EXT_debug_utils                     : extension revision 2
>   VK_KHR_device_group_creation           : extension revision 1
>   VK_KHR_external_fence_capabilities     : extension revision 1
>   VK_KHR_external_memory_capabilities    : extension revision 1
>   VK_KHR_external_semaphore_capabilities : extension revision 1
>   VK_KHR_get_physical_device_properties2 : extension revision 2
>   VK_KHR_get_surface_capabilities2       : extension revision 1
>   VK_KHR_portability_enumeration         : extension revision 1
>   VK_KHR_surface                         : extension revision 25
>   VK_KHR_surface_protected_capabilities  : extension revision 1
>   VK_LUNARG_direct_driver_loading        : extension revision 1
>
>   Instance Layers:
>   ----------------
>
>   Devices:
>   =3D=3D=3D=3D=3D=3D=3D=3D
>   GPU0:
>           apiVersion         =3D 1.3.267
>           driverVersion      =3D 0.0.1
>           vendorID           =3D 0x10005
>           deviceID           =3D 0x0000
>           deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
>           deviceName         =3D llvmpipe (LLVM 15.0.3, 128 bits)
>           driverID           =3D DRIVER_ID_MESA_LLVMPIPE
>           driverName         =3D llvmpipe
>           driverInfo         =3D Mesa 23.3.2 (LLVM 15.0.3)
>           conformanceVersion =3D 1.3.1.1
>           deviceUUID         =3D 6d657361-3233-2e33-2e32-000000000000
>           driverUUID         =3D 6c6c766d-7069-7065-5555-494400000000
>
> With an older and more hacked up set of the blob patches I can get
> vulkaninfo to work but I see multiple GPUs and vkmark falls over when
> mapping stuff:
>
>   # vulkaninfo --summary=20=20=20=20=20=20=20=20=20=20=20=20
>   render_state_create_resource: res_id =3D 5
>   vkr_context_add_resource: res_id =3D 5
>   vkr_context_import_resource_internal: res_id =3D 5
>   virgl_resource_create: err=3D0, res=3D5=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   render_state_create_resource: res_id =3D 6=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>   vkr_context_add_resource: res_id =3D 6=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   vkr_context_import_resource_internal: res_id =3D 6
>   virgl_resource_create: err=3D0, res=3D6=20=20=20=20=20
>   error: XDG_RUNTIME_DIR is invalid or not set in the environment.
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>   VULKANINFO=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Vulkan Instance Version: 1.3.262=20=20
>
>
>   Instance Extensions: count =3D 12=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   -------------------------------=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>   VK_EXT_debug_report                    : extension revision 10
>   VK_EXT_debug_utils                     : extension revision 2
>   VK_KHR_device_group_creation           : extension revision 1
>   VK_KHR_external_fence_capabilities     : extension revision 1
>   VK_KHR_external_memory_capabilities    : extension revision 1=20=20=20=
=20
>   VK_KHR_external_semaphore_capabilities : extension revision 1=20=20=20=
=20
>   VK_KHR_get_physical_device_properties2 : extension revision 2
>   VK_KHR_get_surface_capabilities2       : extension revision 1
>   VK_KHR_portability_enumeration         : extension revision 1
>   VK_KHR_surface                         : extension revision 25
>   VK_KHR_surface_protected_capabilities  : extension revision 1
>   VK_LUNARG_direct_driver_loading        : extension revision 1
>   VK_LUNARG_direct_driver_loading        : extension revision 1          =
                                                                           =
                   [0/7869]
>
>   Instance Layers:
>   ----------------
>
>   Devices:
>   =3D=3D=3D=3D=3D=3D=3D=3D
>   GPU0:
>           apiVersion         =3D 1.3.230
>           driverVersion      =3D 23.3.4
>           vendorID           =3D 0x8086
>           deviceID           =3D 0xa780
>           deviceType         =3D PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
>           deviceName         =3D Virtio-GPU Venus (Intel(R) Graphics (RPL=
-S))
>           driverID           =3D DRIVER_ID_MESA_VENUS
>           driverName         =3D venus
>           driverInfo         =3D Mesa 23.3.4
>           conformanceVersion =3D 1.3.0.0
>           deviceUUID         =3D 29d2e940-a1a0-3054-0f9a-9f7dec52a084
>           driverUUID         =3D b11fafe9-8706-9ab8-0f16-8b272cf893ca
>   GPU1:
>           apiVersion         =3D 1.2.0
>           driverVersion      =3D 23.3.4
>           vendorID           =3D 0x10005
>           deviceID           =3D 0x0000
>           deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
>           deviceName         =3D Virtio-GPU Venus (llvmpipe (LLVM 15.0.6,=
 256 bits))
>           driverID           =3D DRIVER_ID_MESA_VENUS
>           driverName         =3D venus
>           driverInfo         =3D Mesa 23.3.4
>           conformanceVersion =3D 1.3.0.0
>           deviceUUID         =3D 5fb5c03f-c537-f0fe-a7e6-9cd5866acb8d
>           driverUUID         =3D b11fafe9-8706-9ab8-0f16-8b272cf893ca
>   GPU2:
>           apiVersion         =3D 1.3.267
>           driverVersion      =3D 0.0.1
>           vendorID           =3D 0x10005
>           deviceID           =3D 0x0000
>           deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
>           deviceName         =3D llvmpipe (LLVM 15.0.3, 128 bits)
>           driverID           =3D DRIVER_ID_MESA_LLVMPIPE
>           driverName         =3D llvmpipe
>           driverInfo         =3D Mesa 23.3.2 (LLVM 15.0.3)
>           conformanceVersion =3D 1.3.1.1
>           deviceUUID         =3D 6d657361-3233-2e33-2e32-000000000000
>           driverUUID         =3D 6c6c766d-7069-7065-5555-494400000000
>   render_state_destroy_resource: res_id =3D 5
>   vkr_context_remove_resource: res_id =3D 5
>   virgl_resource_destroy_func: res=3D5
>   render_state_destroy_resource: res_id =3D 6
>   vkr_context_remove_resource: res_id =3D 6
>   virgl_resource_destroy_func: res=3D6
>
> running vkmark gives:
>
>   # vkmark --winsys kms
>   render_state_create_resource: res_id =3D 7
>   vkr_context_add_resource: res_id =3D 7
>   vkr_context_import_resource_internal: res_id =3D 7
>   virgl_resource_create: err=3D0, res=3D7
>   render_state_create_resource: res_id =3D 8
>   vkr_context_add_resource: res_id =3D 8
>   vkr_context_import_resource_internal: res_id =3D 8
>   virgl_resource_create: err=3D0, res=3D8
>   virgl_resource_create: err=3D0, res=3D9
>   virgl_renderer_resource_attach_iov: 0x55615acf7f40/9
>   virgl_resource_attach_iov: pipe_resource: 0x55615acf7db0
>   vrend_pipe_resource_attach_iov: 0x43
>
> this bit does nothing as VREND_STORAGE_HOST_SYSTEM_MEMORY isn't set.
>
>   virgl_resource_create: err=3D0, res=3D10
>   virgl_renderer_resource_attach_iov: 0x55615ae569a0/10
>   virgl_resource_attach_iov: pipe_resource: 0x55615a99ce20
>   vrend_pipe_resource_attach_iov: 0x43
>   Warning: KMSWindowSystem: Using VK_IMAGE_TILING_OPTIMAL for dmabuf with=
 invalid modifier, but this is not guaranteed to work.
>   vkr_dispatch_vkAllocateMemory: mem_index_type:0
>   virgl_render_server[2889817]: vkr: failed to import resource: invalid r=
es_id 9
>   virgl_render_server[2889817]: vkr: vkAllocateMemory resulted in CS error
>   virgl_render_server[2889817]: vkr: ring_submit_cmd: vn_dispatch_command=
 failed
>   MESA-VIRTIO: debug: vn_ring_submit abort on fatal
>   render_state_destroy_resource: res_id =3D 7
>   vkr_context_remove_resource: res_id =3D 7
>   render_state_destroy_resource: res_id =3D 8
>   vkr_context_remove_resource: res_id =3D 8
>   virgl_resource_destroy_func: res=3D7
>   virgl_resource_destroy_func: res=3D8
>   virgl_resource_destroy_func: res=3D10
>   virgl_resource_destroy_func: res=3D9
>   Aborted
>
> The debug printfs are throughout QEMU and virlgrenderer while trying to
> work out what was going on. While the eventual aim is to enable this
> stack on a ARM64 platform with Xen I wanted to make sure I understand
> the blob resource flow first.
>
> As I understand it we need resource blobs to hold 3D data for rendering
> that is visible to the underlying GPU that will be doing the work. While
> these blobs can be copied back and forth the most efficient way to do
> this is to allocate HOST VISIBLE blobs that are appropriately placed
> and aligned for the host GPU. For Vulkan there will also be the command
> stream which will need to be translated from the Vulkan's portable
> shader IR (as emitted by mesa on the guest) to the underlying shader
> commands on the host system (via mesa on the host).
>
> I can see the host visible region is created as a large chunk of the PCI
> BAR space and is outside of the guests system RAM.
>
> The guest creates a unique resource ID by submitting a
> VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB command.
>
> Q1: is the actual allocation done here? I assume this happens somewhere
> in the depths of virglrenderer or is it the kernel DRM subsystem?
>
> Q2: should the memory for this resource be visible to the host
> userspace at this point? Where is the mapping into userspace done?
>
> The guest submits a VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB command with a
> unique resource ID and requests it is mapped at an offset into the host
> visible memory region.
>
> Q3: Is all the mapping for host and guest handled by QEMU's memory_region
> code?
>
> Q4: Are there any differences between cards with VRAM and those with a
> unified memory architecture (e.g. using system RAM)?
>
> Finally should we expect to see any other resources
> (RESOURCE_CREATE_2D/3D, TRANSFER_TO_HOST, ATTACH_BACKING) if we have
> host visible blobs properly allocated and working?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

