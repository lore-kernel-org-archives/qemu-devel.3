Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96274C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVz8-0000fl-9Z; Fri, 21 Feb 2025 11:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlVz5-0000f1-TP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:34:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlVz3-0004bZ-Ed
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:34:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f3486062eso1922985f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740155675; x=1740760475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nqmVlUR9MQn3TMjSmABJ403iQfkwgBrhsgkmfFCqmQ=;
 b=W8DzMY/6F+WH+YdO9iff6fZXLrxcSCPIWB7AB5eHvlDqXE6+fRijA0Tqw33gO2/wEA
 clC1RlV+XEYd4kb3pmC9f4uUOxbPaRYVySCKXzKzWwlBHCF0QE1fWLTZP6l1Q7wo7key
 NUsMPX/LjsJMUpKC7nF5B1QJ05Obvc0A8wOGM/cUfv9uDy7UDGTQ9myjQvIAI8wRCeV7
 j4CcnopeLE1YNYfEa9JDgBIx3Pt7rHKWJNAl/nQdtySD3I3HVeUZf9YShRsoZozbNYMq
 5HcX+07C2DPEcuPsuazXiA2Z29M+Svo5U6sPN8ak7jnZxncQaVFM8QpvfXTt6h/Ro0+m
 Ypzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740155675; x=1740760475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nqmVlUR9MQn3TMjSmABJ403iQfkwgBrhsgkmfFCqmQ=;
 b=PgY0TRlFOHiptGIFT8ZXWSmoVLdftn6C71kNPjn9h0tm38GSCBD2l6hib0d+yci3UW
 FPSmcBCGayEL+E72iQank6nkbKPE513iXFv2WOTCqL5AEyNvqr9yCl70Gjw6m17hULoA
 nWwY/IVBCNKHAN8lW7fS7YXZwSsybt8TUOn4qyPXhoCRzcW3oWJFFLAJHxLIyP6a1ya6
 vJJJy2DkuxQYAs3lCrRz3J/mb7gKfhGid6SxRYShILpoQ1zfEjk4xQLdai0KtVVIGnOq
 xM0b596MedLXLsWF8qutlwiMle3Tnl+l4YpYnmLyahSQbNp0UqXBIalKQRhVJJuaVSGV
 H+FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSuG0q2VWPXOPTogQQ46xki8xWAQT0POkFRJoRx7Q5ED9YDlX/n1LpYtwx17NGP6N8qXLcw8vi2sTt@nongnu.org
X-Gm-Message-State: AOJu0Ywa+vp7vc/72ggph+HnJGH9QC56YLo8zOijSPaW+ofw5Vlvs7nE
 jM1C/BIJekjzdGBrjKYcYufwDlFWzi1qTDd3rC+Lsq+T8cHI2vW/QO18cC5s3ttcpr+nw/se4BS
 zwKA=
X-Gm-Gg: ASbGncvpgjaY76jduOrZ5qP55d5ECBp1H4fjPJut4WpVx9tZl6H1I01dSyUozF4yq7+
 49Xf7E/mnHBMbsLYW140r6MyL39Yk3JsnfuvZVjaCyHtyoA7G6XgtIwW+CVEeOYDx8gPN2JgPTm
 o5hgaZh4CeMPR9uQ8nzEypF+yWH/8jttbJ7R9TByIqzQjk0phlRdwC1mXLRY4kSzOk2NHWqrGho
 8u+F01sRKoFU44pc6bAAV5kOJ9QflLGwuSlVE94jKkLUOQ4zTD66Had389lGvhsk77WePi2mcbW
 yPTn6YkzvXOTMglc2Yj1MfNitZUXKc+RJhI9+i38yCoA+b44fvvmQVxTidRGekYYORL87A==
X-Google-Smtp-Source: AGHT+IEd2/rnOw6Shc5v36pSaGNCKLUWZ6yUALds3ED5Y70j8mWmqQcfIQWBgUIuit9iyAnCoZyFFg==
X-Received: by 2002:a5d:5011:0:b0:38f:44eb:40e with SMTP id
 ffacd0b85a97d-38f6f04fcfbmr2402416f8f.30.1740155675251; 
 Fri, 21 Feb 2025 08:34:35 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25914d73sm24206283f8f.54.2025.02.21.08.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 08:34:34 -0800 (PST)
Message-ID: <e3719c95-a086-4aa6-a587-8daf3a350e09@linaro.org>
Date: Fri, 21 Feb 2025 17:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250221160101.2318357-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 21/2/25 17:01, Alex Bennée wrote:
> While running the new GPU tests it was noted that the proprietary
> nVidia driver barfed when run under the sanitiser:
> 
>    2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
>    EOTF mode SDR and colorimetry mode default.
>    2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
>    profile: stock sRGB color profile
> 
>    and that's the last thing it outputs.
> 
>    The sanitizer reports that when the framework sends the SIGTERM
>    because of the timeout we get a write to a NULL pointer (but
>    interesting not this time in an atexit callback):
> 
>    UndefinedBehaviorSanitizer:DEADLYSIGNAL
>    ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
>    0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
>    T471863)
>    ==471863==The signal is caused by a WRITE memory access.
>    ==471863==Hint: address points to the zero page.
>        #0 0x7a18ceaafe80
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #1 0x7a18ce9e72c0
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #2 0x7a18ce9f11bb
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #3 0x7a18ce6dc9d1
>    (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
>    (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>        #4 0x7a18e7d15326 in vrend_renderer_create_fence
>    /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
>        #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
> 
> The #dri-devel channel confirmed:
> 
>    <digetx> stsquad: nv driver is known to not work with venus, don't use
>        it for testing
> 
> So lets implement a blocklist to stop users starting a known bad
> setup.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   meson.build                               |   4 +
>   include/qemu/host-gpu.h                   |  23 +++++
>   hw/display/virtio-gpu.c                   |   4 +
>   stubs/host-gpu.c                          |  17 ++++
>   util/host-gpu.c                           | 102 ++++++++++++++++++++++
>   stubs/meson.build                         |   4 +
>   tests/functional/test_aarch64_virt_gpu.py |   2 +
>   util/meson.build                          |   2 +
>   8 files changed, 158 insertions(+)
>   create mode 100644 include/qemu/host-gpu.h
>   create mode 100644 stubs/host-gpu.c
>   create mode 100644 util/host-gpu.c
> 
> diff --git a/meson.build b/meson.build
> index 4588bfd864..8f4a431445 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1373,12 +1373,16 @@ if not get_option('qatzip').auto() or have_system
>   endif
>   
>   virgl = not_found
> +vulkan = not_found
>   
>   have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
>   if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>     virgl = dependency('virglrenderer',
>                        method: 'pkg-config',
>                        required: get_option('virglrenderer'))
> +  vulkan = dependency('vulkan',
> +                      method: 'pkg-config',
> +                      required: get_option('virglrenderer'))
>   endif
>   rutabaga = not_found
>   if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
> diff --git a/include/qemu/host-gpu.h b/include/qemu/host-gpu.h
> new file mode 100644
> index 0000000000..45053c2f77
> --- /dev/null
> +++ b/include/qemu/host-gpu.h
> @@ -0,0 +1,23 @@
> +/*
> + * Utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HOST_GPU_H
> +#define HOST_GPU_H
> +
> +#include "qapi/error.h"
> +
> +/**
> + * validate_vulkan_backend() - verify working backend
> + *
> + * errp: error pointer
> + *
> + * If the system vulkan implementation is known to not work return
> + * false otherwise true.
> + */
> +bool validate_vulkan_backend(Error **errp);
> +
> +#endif /* HOST_GPU_H */
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 11a7a85750..816eedf838 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -32,6 +32,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/host-gpu.h"
>   
>   #define VIRTIO_GPU_VM_VERSION 1
>   
> @@ -1498,6 +1499,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>               error_setg(errp, "venus requires enabled blob and hostmem options");
>               return;
>           }

Why don't we check VIRTIO_GPU_FLAG_VENUS_ENABLED in 
virtio_gpu_gl_device_realize()?

> +        if (!validate_vulkan_backend(errp)) {
> +            return;
> +        }
>       #else
>           error_setg(errp, "old virglrenderer, venus unsupported");
>           return;
> diff --git a/stubs/host-gpu.c b/stubs/host-gpu.c
> new file mode 100644
> index 0000000000..7bf76ee4f6
> --- /dev/null
> +++ b/stubs/host-gpu.c
> @@ -0,0 +1,17 @@
> +/*
> + * Stub of utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/host-gpu.h"
> +
> +bool validate_vulkan_backend(Error **errp)
> +{
> +    error_setg(errp, "No vulkan library present");
> +    return false;

Do we really fail virtio_gpu_device_realize() in this case?

> +}
> diff --git a/util/host-gpu.c b/util/host-gpu.c
> new file mode 100644
> index 0000000000..5e7bf2557c
> --- /dev/null
> +++ b/util/host-gpu.c
> @@ -0,0 +1,102 @@
> +/*
> + * Utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/host-gpu.h"
> +
> +#include <vulkan/vulkan.h>
> +

static

> +const char *extensions[] = {
> +    /* needed to query the driver details */
> +    "VK_KHR_get_physical_device_properties2",
> +};
> +
> +/*
> + * Info for known broken drivers. Sadly driver version info tends to
> + * be in the driverInfo text field which is free form so tricky to
> + * parse.
> + */
> +struct VkDriverBlockList {
> +    VkDriverId id;
> +    const char *reason;
> +};
> +

static const

> +struct VkDriverBlockList vulkan_blocklist[] = {
> +    /* at least 535.183.01 is reported to SEGV in libnvidia-eglcore.so */
> +    { VK_DRIVER_ID_NVIDIA_PROPRIETARY, "proprietary nVidia driver is broken" },
> +};
> +
> +static bool is_driver_blocked(VkPhysicalDevice dev, Error **errp)
> +{
> +    VkPhysicalDeviceDriverProperties driverProperties = {
> +        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES,
> +        .pNext = NULL
> +    };
> +    VkPhysicalDeviceProperties2 deviceProperties2 = {
> +        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2,
> +        .pNext = &driverProperties
> +    };
> +    VkPhysicalDeviceProperties *deviceProperties = &deviceProperties2.properties;
> +
> +    vkGetPhysicalDeviceProperties2(dev, &deviceProperties2);
> +
> +    for (int i = 0; i < ARRAY_SIZE(vulkan_blocklist); i++) {
> +        if (driverProperties.driverID == vulkan_blocklist[i].id) {
> +            error_setg(errp, "Blocked GPU %s because %s",
> +                       deviceProperties->deviceName,
> +                       vulkan_blocklist[i].reason);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +bool validate_vulkan_backend(Error **errp)
> +{

static const

> +    VkInstanceCreateInfo instance_info = {
> +        VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
> +        NULL, /* pNext extension */
> +        0,    /* VkInstanceCreateFlags */
> +        NULL, /* Application Info */
> +        0, NULL, /* no Enabled Layers */
> +        ARRAY_SIZE(extensions), extensions, /* Extensions */
> +    };
> +
> +    VkInstance inst;
> +    VkResult res;
> +
> +    res = vkCreateInstance(&instance_info, NULL, &inst);
> +
> +    if ( res == VK_SUCCESS ) {
> +        uint32_t count;

g_autofree

> +        VkPhysicalDevice *devices;
> +
> +        /* Do the enumeration two-step */
> +        vkEnumeratePhysicalDevices(inst, &count, NULL);
> +        devices = g_new0(VkPhysicalDevice, count);
> +        vkEnumeratePhysicalDevices(inst, &count, devices);
> +
> +        for (int i = 0; i  < count; i++) {
> +            if (is_driver_blocked(devices[i], errp)) {
> +                return false;
> +            }
> +        }
> +    } else {
> +        error_setg(errp, "Could not initialise a Vulkan instance");
> +        return false;
> +    }
> +
> +    /*
> +     * It would be nice to g_autofree the instance, but returning
> +     * false will abort start-up anyway.
> +     */
> +    vkDestroyInstance(inst, NULL);
> +    return true;
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index b0fee37e05..c18501aa6d 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,3 +89,7 @@ if have_system or have_user
>     stub_ss.add(files('hotplug-stubs.c'))
>     stub_ss.add(files('sysbus.c'))
>   endif
> +
> +if not vulkan.found()
> +  stubs_ss.add(files('host-gpu.c'))
> +endif
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index 7a8471d1ca..9a0e694049 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -79,6 +79,8 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
>                   self.skipTest("Can't access host DRM render node")
>               elif "'type' does not accept value 'egl-headless'" in excp.output:
>                   self.skipTest("egl-headless support is not available")
> +            elif "Blocked GPU" in excp.output:
> +                self.skipTest("GPU is in block list")
>               else:
>                   self.log.info(f"unhandled launch failure: {excp.output}")
>                   raise excp
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..7c6cc36e07 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -132,3 +132,5 @@ elif cpu in ['ppc', 'ppc64']
>   elif cpu in ['riscv32', 'riscv64']
>     util_ss.add(files('cpuinfo-riscv.c'))
>   endif
> +
> +util_ss.add(when: vulkan, if_true: files('host-gpu.c'))


