Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32149C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6u9-0001J6-Mx; Thu, 20 Feb 2025 08:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl6u5-0001I6-PJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:47:49 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl6u3-0001rd-5q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:47:49 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so787332276.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059265; x=1740664065; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRXbKCZYAbAUSTZO6GXGqX5QlIgXZzqmfvbZFu52Bso=;
 b=HHi+j7d3DU25r/yxwl+tZfNWNoozERD+UMuuwOZB7QlLZIYUtLS9DvnyafNYHs1ySs
 2k32E8GgAUlWtQGbj/kj7IP/R4znp720drM4HoNiy4TgpwDByxO7x4F/FzPhLLpfLly5
 j43zFz1hcWu8nbMdtB3U+++5068j7IIexURtjSlrXHuxPS2RMBd42m06tLg07m+EPHTX
 Uv4/f8ilhznwsUKN28p+6/75C3gnXdKIJEZRMy2wxwx1LYZIro/YO1tP8w1MPUXn6A1f
 Ik/e5s9ZILBdo/MtP6CHuOhhhjYD036yi3NdP2/Pv3Lp8+4L26mjxPCAgV/0iF+UPHH9
 D1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059265; x=1740664065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRXbKCZYAbAUSTZO6GXGqX5QlIgXZzqmfvbZFu52Bso=;
 b=SL3Pcb1xSCv9EH1HYl3pAN35LhDDyo3xJ6gn48zxwsj0rRmAp3JJabRT/W+QZjNZws
 AIa7/bAotNEYn/VHXQi+qaTVLfvFdEUScM78TfTXYrIcqh5M+yzpHuNK99XvoI8oz99W
 gtZ04zlCFFE+V702mJ48H4RlVkOeQZBod8GGp2nD+PMaJ7tKwpcSJJbK9Rs+WvWe7DDe
 X7njv6JaWZtAaV0x5LHmTk79soCmpCBhyUhHoCQlqtF7zLV/CZ5n5QmkkBZ6hGP+4Zm8
 xbdms3UGkULAE5TiTEfSgUyErOe1NdcSbuf91OxQBmViUzcDcyhe+NntaQU0a7u7zblE
 NQ1A==
X-Gm-Message-State: AOJu0YyB8Iri8+s1CRGU8qvgm8k0zU1e1j5OAMjTXKF8p4Vin9XJfSLm
 kjqHHLdS+rwa8YMiid5F8wfPT6BPj/W0zQXzz+tOHBXdshQbF1V/1dxhyz++WdtSxKVolUJjiez
 aqSq6Tqx/uMgnGuSMauWTIalgSIxJbauxg+prOg==
X-Gm-Gg: ASbGncudtnn1rtUiRmzeTh0t/yaUpc0DwKIL7NLBQXkr5kbU7lBzYgCrNbqBejcwqPB
 XzzOKhQPPxj5px1dLxJqM1uHu9HsJ1Ut6B0XNtKY6ODYjl5WHvBKWAsi9gWHVsYWJdGpo5pvT7A
 ==
X-Google-Smtp-Source: AGHT+IGmYS6MprX09YyQXwXopVtqlVkaGZkPDhPVIEiGapAzZHcTRMUy7RSTVf+/WQ7h7JWRidIyiCwSHu4kjoayFM8=
X-Received: by 2002:a05:6902:270a:b0:e57:2ff6:945a with SMTP id
 3f1490d57ef6-e5e09faa9b7mr5744161276.0.1740059265073; Thu, 20 Feb 2025
 05:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
 <CAFEAcA_TJhgrcfZ-9JY74OvkiGXPuYHJF16=_3Y+=r6+JfXMGA@mail.gmail.com>
In-Reply-To: <CAFEAcA_TJhgrcfZ-9JY74OvkiGXPuYHJF16=_3Y+=r6+JfXMGA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 13:47:31 +0000
X-Gm-Features: AWEUYZnI94sD-sjuHR9Xv11WRR5BfWfHATHRosMwlxXVYvTJIDzU3XeJvtJXigk
Message-ID: <CAFEAcA8MpGGGeYvBKB4kcx9-_F2KTViwKtbbixBF9jNhE3Ok5g@mail.gmail.com>
Subject: Re: [PATCH 0/4] testing/next (aarch64 virt gpu tests)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 20 Feb 2025 at 11:29, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 19 Feb 2025 at 15:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > Hi,
> >
> > As I was looking at the native context patches I realised our existing
> > GPU testing is a little sparse. I took the opportunity to split the
> > test from the main virt test and then extend it to exercise the 3
> > current display modes (virgl, virgl+blobs, vulkan).
> >
> > I've added some additional validation to ensure we have the devices we
> > expect before we start. It doesn't currently address the reported
> > clang issues but hopefully it will help narrow down what fails and
> > what works.
>
> Running on my setup with a clang sanitizer build I get
>
> ok 1 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt_with_v=
irgl_blobs_gpu
> ok 2 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt_with_v=
irgl_gpu
>
> and then the third test timed out.

vulkaninfo --summary as requested on irc:


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
VULKANINFO
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Vulkan Instance Version: 1.3.275


Instance Extensions: count =3D 24
-------------------------------
VK_EXT_acquire_drm_display             : extension revision 1
VK_EXT_acquire_xlib_display            : extension revision 1
VK_EXT_debug_report                    : extension revision 10
VK_EXT_debug_utils                     : extension revision 2
VK_EXT_direct_mode_display             : extension revision 1
VK_EXT_display_surface_counter         : extension revision 1
VK_EXT_headless_surface                : extension revision 1
VK_EXT_surface_maintenance1            : extension revision 1
VK_EXT_swapchain_colorspace            : extension revision 4
VK_KHR_device_group_creation           : extension revision 1
VK_KHR_display                         : extension revision 23
VK_KHR_external_fence_capabilities     : extension revision 1
VK_KHR_external_memory_capabilities    : extension revision 1
VK_KHR_external_semaphore_capabilities : extension revision 1
VK_KHR_get_display_properties2         : extension revision 1
VK_KHR_get_physical_device_properties2 : extension revision 2
VK_KHR_get_surface_capabilities2       : extension revision 1
VK_KHR_portability_enumeration         : extension revision 1
VK_KHR_surface                         : extension revision 25
VK_KHR_surface_protected_capabilities  : extension revision 1
VK_KHR_wayland_surface                 : extension revision 6
VK_KHR_xcb_surface                     : extension revision 6
VK_KHR_xlib_surface                    : extension revision 6
VK_LUNARG_direct_driver_loading        : extension revision 1

Instance Layers: count =3D 4
--------------------------
VK_LAYER_INTEL_nullhw       INTEL NULL HW                1.1.73   version 1
VK_LAYER_MESA_device_select Linux device selection layer 1.3.211  version 1
VK_LAYER_MESA_overlay       Mesa Overlay layer           1.3.211  version 1
VK_LAYER_NV_optimus         NVIDIA Optimus layer         1.3.242  version 1

Devices:
=3D=3D=3D=3D=3D=3D=3D=3D
GPU0:
        apiVersion         =3D 1.3.242
        driverVersion      =3D 535.183.1.0
        vendorID           =3D 0x10de
        deviceID           =3D 0x1cb3
        deviceType         =3D PHYSICAL_DEVICE_TYPE_DISCRETE_GPU
        deviceName         =3D Quadro P400
        driverID           =3D DRIVER_ID_NVIDIA_PROPRIETARY
        driverName         =3D NVIDIA
        driverInfo         =3D 535.183.01
        conformanceVersion =3D 1.3.5.0
        deviceUUID         =3D 0a44d8af-913b-892f-1603-e76ce29ac9b5
        driverUUID         =3D 526ab2c8-1f4a-5dd0-9559-81dab18f1e08
GPU1:
        apiVersion         =3D 1.3.289
        driverVersion      =3D 0.0.1
        vendorID           =3D 0x10005
        deviceID           =3D 0x0000
        deviceType         =3D PHYSICAL_DEVICE_TYPE_CPU
        deviceName         =3D llvmpipe (LLVM 19.1.1, 256 bits)
        driverID           =3D DRIVER_ID_MESA_LLVMPIPE
        driverName         =3D llvmpipe
        driverInfo         =3D Mesa 24.2.8-1ubuntu1~24.04.1 (LLVM 19.1.1)
        conformanceVersion =3D 1.3.1.1
        deviceUUID         =3D 6d657361-3234-2e32-2e38-2d3175627500
        driverUUID         =3D 6c6c766d-7069-7065-5555-494400000000

-- PMM

