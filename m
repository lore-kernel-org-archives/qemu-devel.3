Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651FAC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdugJ-0002Aw-81; Fri, 31 Jan 2025 12:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tdugA-00029g-7s
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:19:42 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tdug8-0001zM-2G
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738343962; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZW6DoAlz4UKQB+B97A3JT2T8Fg8Or7kra7Xpza+4+MAjxJr0Zejk80l4DfIyCbLEHGYXwOquFbZ0j3aJzZVzbBotOSC+vY+Z2UvGVnDq4qrFl8ZFBpRkE1l13bA0N94zoG6hoO1UWWsRoc8kuBrz/W6ONEmnvBg8SifAsTqcBWY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738343962;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xFiQgldifdKfMxABi5UxpHIcdv/VX9eIO8ivC9G/BNA=; 
 b=RdhTbhfgX769g5FQsVkHqbMM7Y7lCINhEmRMLd6THL0qa9errow2cP0uf/rberOwuo1mhb1VR3KxxiWiyF5v16YVVFCbfh7LU8/qNVO4RgOcgtdE1QYrDhABd79CIa+QqeyeYDhHaufi5g+75EixdVPq2GypwsNDDGQ+9TRzi5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738343962; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xFiQgldifdKfMxABi5UxpHIcdv/VX9eIO8ivC9G/BNA=;
 b=EzdkyMhPvw62IPDFkMDAuaySn7u93NTgBP4qS9N0OheK/PDW+Kjzs25WBRr7+zJD
 v+DyRi/XCCb2SjKCmbtyzH4mQiRkjMF1QvUCIuXTeY4j1CqChBRbGYOurBxexy4ORQz
 ePZYwas2q4FJk27Xw1xuJPDfHcc+YN0x+g6kxIJE=
Received: by mx.zohomail.com with SMTPS id 1738343957200689.4037741470463;
 Fri, 31 Jan 2025 09:19:17 -0800 (PST)
Message-ID: <443be392-982b-4a2f-a28e-e9db93577e4b@collabora.com>
Date: Fri, 31 Jan 2025 20:19:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-11-dmitry.osipenko@collabora.com>
 <CAAfnVBmrCSk-TBMD7NnVkHtHf9mECMtmxg=ExZF5WZs1mtmqPg@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAAfnVBmrCSk-TBMD7NnVkHtHf9mECMtmxg=ExZF5WZs1mtmqPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/29/25 04:18, Gurchetan Singh wrote:
> On Sun, Jan 26, 2025 at 12:14 PM Dmitry Osipenko <
> dmitry.osipenko@collabora.com> wrote:
> 
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> This attempts to tidy up the VirtIO GPU documentation to make the list
>> of requirements clearer. There are still a lot of moving parts and the
>> distros have some catching up to do before this is all handled
>> automatically.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
>> ---
>>  docs/system/devices/virtio-gpu.rst | 107 ++++++++++++++++++++++++++++-
>>  1 file changed, 106 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/system/devices/virtio-gpu.rst
>> b/docs/system/devices/virtio-gpu.rst
>> index ea3eb052df3c..b3db984ff2d3 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -5,7 +5,9 @@ virtio-gpu
>>  ==========
>>
>>  This document explains the setup and usage of the virtio-gpu device.
>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>> +The virtio-gpu device provides a GPU and display controller
>> +paravirtualized using VirtIO. It supports a number of different modes
>> +from simple 2D displays to fully accelerated 3D graphics.
>>
>>  Linux kernel support
>>  --------------------
>> @@ -13,6 +15,24 @@ Linux kernel support
>>  virtio-gpu requires a guest Linux kernel built with the
>>  ``CONFIG_DRM_VIRTIO_GPU`` option.
>>
>> +Dependencies
>> +............
>> +
>> +.. note::
>> +  GPU virtualisation is still an evolving field. Depending on the mode
>> +  you are running you may need to override distribution supplied
>> +  libraries with more recent versions or enable build options.
>> +
>> +  Depending on the mode there are a number of requirements the host must
>> +  meet to be able to be able to support guests. For 3D acceleration QEMU
>> +  must be able to access the hosts GPU and for the best performance be
>> +  able to reliably share GPU memory with the guest.
>> +
>> +  Virtio-gpu requires a guest Linux kernel built with the
>> +  ``CONFIG_DRM_VIRTIO_GPU`` option. For 3D accelerations you
>> +  will need support from guest Mesa configured for whichever encapsulation
>> +  you need.
>> +
>>  QEMU virtio-gpu variants
>>  ------------------------
>>
>> @@ -56,6 +76,16 @@ on typical modern Linux distributions.
>>  .. _Mesa: https://www.mesa3d.org/
>>  .. _SwiftShader: https://github.com/google/swiftshader
>>
>> +.. list-table:: Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Kernel
>> +    - Userspace
>> +  * - virtio-gpu
>> +    - Framebuffer enabled
>> +    - GTK or SDL display
>> +
>>  virtio-gpu virglrenderer
>>  ------------------------
>>
>> @@ -94,6 +124,61 @@ of virtio-gpu host memory window. This is typically
>> between 256M and 8G.
>>
>>  .. _drm:
>> https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>>
>> +.. list-table:: Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Kernel
>> +    - Userspace
>> +  * - virtio-gpu-gl (OpenGL pass-through)
>> +    - GPU enabled
>> +    - libvirglrenderer (virgl support)
>> +  * - virtio-gpu-gl (Vulkan pass-through)
>> +    - Linux 6.13+
>> +    - libvirglrenderer (>= 1.0.0, venus support)
>> +  * - virtio-gpu-gl (vDRM native context/AMD)
>> +    - Linux 6.13+
>> +    - libvirglrenderer (>= 1.1.0, DRM renderer support)
>> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
>> +    - Linux 6.4+
>> +    - libvirglrenderer (>= 1.0.0, DRM renderer support)
>> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
>> +    - Linux 6.13+
>> +    - libvirglrenderer (`mr1384`_, DRM renderer support)
>> +  * - virtio-gpu-gl (vDRM native context/Asahi)
>> +    - Linux 6.13+
>> +    - libvirglrenderer (`mr1274`_, DRM renderer support)
>> +
>> +.. _mr1384:
>> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
>> +.. _mr1274:
>> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
>> +
>> +.. list-table:: Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - virtio-gpu-gl (OpenGL pass-through)
>> +    - 20.3.0+
>> +    - -Dgallium-drivers=virgl
>> +  * - virtio-gpu-gl (Vulkan pass-through)
>> +    - 24.2.0+
>> +    - -Dvulkan-drivers=virtio
>> +  * - virtio-gpu-gl (vDRM native context/AMD)
>> +    - 25.0.0+
>> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
>> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
>> +    - 23.1.0+
>> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
>> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
>> +    - `mr29870`_
>> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel
>> -Dintel-virtio-experimental=true
>> +  * - virtio-gpu-gl (vDRM native context/Asahi)
>> +    - 24.2.0+
>> +    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
>> +
>> +.. _mr29870:
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>> +
>>  virtio-gpu rutabaga
>>  -------------------
>>
>> @@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not
>> specified.
>>  .. _Wayland display passthrough:
>> https://www.youtube.com/watch?v=OZJiHMtIQ2M
>>  .. _gfxstream-enabled rutabaga:
>> https://crosvm.dev/book/appendix/rutabaga_gfx.html
>>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>> +
>> +.. list-table:: Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Kernel
>> +    - Userspace
>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>> +    - GPU enabled
>> +    - aemu/rutabaga_gfx_ffi or vhost-user client with support
>> +
>> +.. list-table:: Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>>
> 
> Shouldn't this be `virtio-gpu-rutabaga` instead of `virtio-gpu-gl`?  If
> we're including WiP MRs, can we include Magma too??
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33190

Indeed, will correct it. And add the link. Thanks!

-- 
Best regards,
Dmitry

