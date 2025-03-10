Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D71BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbZA-0003xI-NQ; Mon, 10 Mar 2025 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trbZ2-0003tf-Jp
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:44:57 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trbYw-0006MN-4E
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741607069; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cyCWJ8/JST0mlvcNMwXs6D6zwgyGblR+zBnFNJoVU1rdSwBu2L+FLQuoq38XVhY0ZLDPqn0YZr8Pgs2fbc4m2BwtfB2RfAB9WQElefprTjeePk+nWahcFOkf6Qi2Abrx78uvNY3/MmUtIczSHM8cM1uJxXTs4wouBUxIjdTshm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741607069;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=P3aF8Nms3RjOTio/34ntzya3TH5DVIXstCqXXjS+tkk=; 
 b=T2eyVxslMGd1GDZiXQSzs0U8JFW8hpqlGiDrlRAMfJNf49uYOppmYaniYdSGVsx/Vu91xUxqbm4/LrrrBHGLks8Awzjng4GaLzb5h649aSk+KXEhBS6gSjHfLi/MG807P4o8m+bXfBU2Mkdo5iZMJ2txZT9Xo0lRKFI1Kdrohq0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741607069; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=P3aF8Nms3RjOTio/34ntzya3TH5DVIXstCqXXjS+tkk=;
 b=UgrUWl7xLJG1hhIgG5lf/Nhfcz3JiiBlhAjfmqcdKxHYuI10xevcyyKckyxTjx/O
 MUQ4sXiBel0tAxgn7BvtYvai69qnIo9vqMI23/JkvscwU3xKrdI2jCgKHbmYClgQPfD
 yy0pfZs2dq5t98VG5pCsBz267FZ1EvwpPJQdtmI0=
Received: by mx.zohomail.com with SMTPS id 174160706756555.1271089134608;
 Mon, 10 Mar 2025 04:44:27 -0700 (PDT)
Message-ID: <92f3bca7-1873-4140-be5a-65494768a421@collabora.com>
Date: Mon, 10 Mar 2025 14:44:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250310111234.145891-1-dmitry.osipenko@collabora.com>
 <20250310111234.145891-11-dmitry.osipenko@collabora.com>
 <d06c83b8-09bd-4e71-a616-a1b771f7ae13@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d06c83b8-09bd-4e71-a616-a1b771f7ae13@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/10/25 14:35, Akihiko Odaki wrote:
> On 2025/03/10 20:12, Dmitry Osipenko wrote:
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
>>   docs/system/devices/virtio-gpu.rst | 94 +++++++++++++++++++++++++++++-
>>   1 file changed, 91 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/
>> virtio-gpu.rst
>> index ea3eb052df3c..3e4a1e2c87a0 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -5,14 +5,28 @@ virtio-gpu
>>   ==========
>>     This document explains the setup and usage of the virtio-gpu device.
>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>> +The virtio-gpu device provides a GPU and display controller
>> +paravirtualized using VirtIO. It supports a number of different modes
>> +from simple 2D displays to fully accelerated 3D graphics.
>>   -Linux kernel support
>> ---------------------
>> +Linux guest kernel support
>> +--------------------------
>>     virtio-gpu requires a guest Linux kernel built with the
>>   ``CONFIG_DRM_VIRTIO_GPU`` option.
>>   +3D acceleration
>> +---------------
>> +
>> +3D acceleration of a virtualized GPU is still an evolving field.
>> +Depending on the 3D mode you are running you may need to override
>> +distribution supplied libraries with more recent versions or enable
>> +build options. There are a number of requirements the host must meet
>> +to be able to be able to support guests. QEMU must be able to access the
>> +host's GPU and for the best performance be able to reliably share GPU
>> +memory with the guest. Details of 3D acceleration requirements are
>> +described in a further sections.
>> +
>>   QEMU virtio-gpu variants
>>   ------------------------
>>   @@ -65,8 +79,14 @@ intermediate representation is communicated to
>> the host and the
>>   `virglrenderer`_ library on the host translates the intermediate
>>   representation back to OpenGL API calls.
>>   +By default OpenGL version on guest is limited to 4.3. In order to
>> enable
>> +OpenGL 4.6 support, virtio-gpu  host blobs feature (``hostmem`` and
>> ``blob``
>> +fields) should be enabled.  The ``hostmem`` field specifies the size of
>> +virtio-gpu host memory window. This is typically between 256M and 8G.
>> +
>>   .. parsed-literal::
>>       -device virtio-gpu-gl
>> +    -device virtio-gpu-gl,hostmem=8G,blob=true
>>     .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>>   .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
>> @@ -94,6 +114,56 @@ of virtio-gpu host memory window. This is
>> typically between 256M and 8G.
>>     .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> tree/main/src/drm
>>   +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Kernel Version
>> +  * - OpenGL pass-through
>> +    - Any Linux version compatible with QEMU if not using host blobs
>> feature,
>> +      Linux 6.13+ otherwise
>> +  * - Vulkan pass-through
>> +    - Linux 6.13+
>> +  * - AMDGPU DRM native context
>> +    - Linux 6.13+
>> +  * - Freedreno DRM native context
>> +    - Linux 6.4+
>> +  * - Intel i915 DRM native context `mr1384`_
>> +    - Linux 6.13+
>> +  * - Asahi DRM native context `mr1274`_
>> +    - `Downstream version`_ of Asahi Linux kernel
>> +
>> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> merge_requests/1384
>> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>> merge_requests/1274
> 
> These links to virglrenderer merge requests are nice additions. It's
> better to have a column for virglrenderer like the "Mesa Version" column
> in the "Linux Guest Requirements" table.

Ack

>> +.. _Downstream version: https://gitlab.freedesktop.org/asahi/linux
> 
> I think you want to refer to: https://github.com/AsahiLinux/linux
> The linked repository of Asahi says it had a last update a year ago.
> The repository on GitHub is updated 4 days ago so it's newer.

That's why I wasn't adding links to Asahi, it's odd and non-upstream :)
Will change the link.

-- 
Best regards,
Dmitry

