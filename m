Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EABC02199
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 15:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1th9ce-0005Ac-EI; Sun, 09 Feb 2025 10:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1th9cc-0005AN-0E
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 10:53:26 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1th9cY-0007Qf-IR
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 10:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739116384; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FPUsvQsM5arme8Fm8ef3AaKEsOfWossRlh/b3YsvY4qO62ak9z9r0LFS2aleA+bVm8B11nNoows6B+JC/Oe0L9jXPDzSLNYuTJ9HSNgQII5o7NfuZ4lK1dpENU6NHCaSwFp6SoqBq0/+WqKTpwxeBvn2674N0ZuUpx/sp3kQuXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739116384;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tlDfCNjIyTnuytLqet8QHg0c5VX9rUa6JW11TRcyhtU=; 
 b=HsZtk8gC6ZcvQ9ws12dLNuHblpucY8z+L257h/XYGg6PN+TYMIAQ7KmEpxGK4kuEr9MdNoIFF99BmTiEL5BdR+/GwJ6Lnr0tWIOJIOT8SAnja2J4/+luldH2Hr/wbYWm6NOaLldkz8ds8DiFX6lzt7CvXxTn1mWFXbA/tZ24ndU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739116384; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tlDfCNjIyTnuytLqet8QHg0c5VX9rUa6JW11TRcyhtU=;
 b=QdOT7Vl3DVlW6NtGwf/PwX387Ga2fUTeqo7SRUI3Wr2S0BTOIukET0LaEh2ocWDN
 mbjYWQ/FY+18bO5UAsPM87G5Cd07A/YdroAZp1XCfy6ImfY9e0DdneANSAnBQVuMsLP
 iL0v4LLtbh32p9Vwo5Rs9/7jgQdMmHIODrdPTsb4=
Received: by mx.zohomail.com with SMTPS id 1739116375108536.2370733007449;
 Sun, 9 Feb 2025 07:52:55 -0800 (PST)
Message-ID: <c9e1534a-a74d-47c8-acfc-8eeb4f165278@collabora.com>
Date: Sun, 9 Feb 2025 18:52:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
 <20250202232136.919342-11-dmitry.osipenko@collabora.com>
 <2ecfebe3-43a3-4d47-9873-41a8fadf5dcf@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <2ecfebe3-43a3-4d47-9873-41a8fadf5dcf@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/3/25 09:04, Akihiko Odaki wrote:
> On 2025/02/03 8:21, Dmitry Osipenko wrote:
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
>>   docs/system/devices/virtio-gpu.rst | 92 +++++++++++++++++++++++++++++-
>>   1 file changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/
>> virtio-gpu.rst
>> index ea3eb052df3c..56950a76aa2e 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -5,7 +5,9 @@ virtio-gpu
>>   ==========
>>     This document explains the setup and usage of the virtio-gpu device.
>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>> +The virtio-gpu device provides a GPU and display controller
>> +paravirtualized using VirtIO. It supports a number of different modes
>> +from simple 2D displays to fully accelerated 3D graphics.
>>     Linux kernel support
>>   --------------------
>> @@ -56,6 +58,17 @@ on typical modern Linux distributions.
>>   .. _Mesa: https://www.mesa3d.org/
>>   .. _SwiftShader: https://github.com/google/swiftshader
>>   +3D acceleration
>> +---------------
>> +
>> +3D acceleration of a virtualized GPU is still an evolving field.
>> +Depending on the 3D mode you are running you may need to override
>> +distribution supplied libraries with more recent versions or enable
>> +build options. There are a number of requirements the host must meet
>> +to be able to be able to support guests. QEMU must be able to access the
>> +host's GPU and for the best performance be able to reliably share GPU
>> +memory with the guest.
>> +
> 
> What about having a bigger section for "host requirements" that includes
> the "Linux kernel support" and "3D acceleration" section?
> 
> Also it's better to note that the details of 3D acceleration
> requirements are described later as this section only contains an
> abstract description.
> 
>>   virtio-gpu virglrenderer
>>   ------------------------
>>   @@ -94,6 +107,61 @@ of virtio-gpu host memory window. This is
>> typically between 256M and 8G.
>>     .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> tree/main/src/drm
>>   +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
> 
> "Mode" is not a word used elsewhere. Perhaps you may call it "capability".
> 
>> +    - Kernel
>> +    - libvirglrenderer build flags
> 
> Just "virglrenderer" for consistency.
> 
>> +  * - OpenGL pass-through
>> +    - Linux any stable version
> QEMU's support policy is different from Linux's own idea of stable
> releases. Perhaps you may refer to any Linux version compatible with QEMU.
> 
>> +    - N/A
>> +  * - Vulkan pass-through
>> +    - Linux 6.13+
>> +    - -Dvenus=true -Drender-server=true
>> +  * - AMDGPU DRM native context
>> +    - Linux 6.13+
>> +    - -Ddrm-renderers=amdgpu-experimental
>> +  * - Freedreno DRM native context
>> +    - Linux 6.4+
>> +    - -Ddrm-renderers=msm
>> +  * - Intel i915 DRM native context
>> +    - Linux 6.13+
>> +    - -Ddrm-renderers=i915-experimental `mr1384`_
>> +  * - Asahi DRM native context
>> +    - Linux 6.13+
> 
> Asahi does not need patches for virglrenderer but requires patches for
> the kernel too as the upstream kernel doesn't have the GPU support at all.
> 
>> +    - -Ddrm-renderers=asahi-experimental `mr1274`_
>> +
>> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> merge_requests/1384
>> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> merge_requests/1274
>> +
>> +.. list-table:: Linux Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - OpenGL pass-through
>> +    - 16.0.0+
>> +    - -Dgallium-drivers=virgl
>> +  * - Vulkan pass-through
>> +    - 24.2.0+
>> +    - -Dvulkan-drivers=virtio
>> +  * - AMDGPU DRM native context
>> +    - 25.0.0+
>> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-
>> virtio=true
>> +  * - Freedreno DRM native context
>> +    - 23.1.0+
>> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
>> +  * - Intel i915 DRM native context
>> +    - `mr29870`_
>> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-
>> experimental=true
>> +  * - Asahi DRM native context
>> +    - 24.2.0+
>> +    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
>> +
>> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/
>> merge_requests/29870
>> +
>>   virtio-gpu rutabaga
>>   -------------------
>>   @@ -133,3 +201,25 @@ Surfaceless is the default if ``wsi`` is not
>> specified.
>>   .. _Wayland display passthrough: https://www.youtube.com/watch?
>> v=OZJiHMtIQ2M
>>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/
>> rutabaga_gfx.html
>>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>> +
>> +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Kernel
>> +    - Userspace
>> +  * - rutabaga-gfxstream
> 
> This notation is not consistent with the table for virglrenderer.
> Following the description of capsets will allow creating a consistent
> table.
> 
>> +    - Linux 6.13+
>> +    - rutabaga_gfx_ffi or vhost-user client with `gfxstream support`_
> 
> rutabaga_gfx_ffi is a crate name but not mentioned in other
> documentations. This page already contains a link to
> https://crosvm.dev/book/appendix/rutabaga_gfx.html so let's make it
> consistent with it.
> 
> vhost-user is irrelevant with virtio-gpu-rutabaga. Also note that QEMU
> has its own vhost-user-gpu implementation that doesn't use Rutabaga in
> contrib/vhost-user-gpu.

Thanks for the review! I applied all your suggestions for v8. If I
missed or got anything wrong, please comment on v8.

-- 
Best regards,
Dmitry

