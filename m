Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6619DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyY8-0005Lr-Hx; Fri, 14 Feb 2025 11:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tiyXp-0005KM-RP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:28:04 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tiyXm-0001h4-Hy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739550458; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JF433jN8JTOTk6N0vIJJ4omHqV5ydVlAT49fCWfCcIcMIiR3+nZ+wiQ+Agk3dJXcz7erPZsCnNvccB/DbnNAINLNBLJxuV0Gs/CihznVHv+TnKLt2fsJE1rur2WnQq9ML1x9E0/qkMcvdS0o1Y2ioBkjXD2ujn4lmMQaUC1cYPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739550458;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vbpllI3zZLfWuodargebJNroF7RUhIFU6ZRWfH73O8c=; 
 b=ToFSoG270qi6AokrFKsRmpzeF/ybpOlfFiD1VVpFiniMTSdpDnlMKvt4C3x8++IsQ4ebX0JmwrTxjzPjIpJWqgxoSr0BSq7hbSEBJGP9Zr7588Rlm9JvLGVy+X5o5Dych88SIHupmDPBTgJ2TGhA7+GzlKSnVD7IIYNYrSytP9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739550458; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vbpllI3zZLfWuodargebJNroF7RUhIFU6ZRWfH73O8c=;
 b=eSroquM4zeqhdLlazU7KLEga1phg7rPLZfEtEY0yznuomw9OpWyknXTBkA6sR7eS
 dgsOhBVOa+j2QO3rCN4MUzm7ve+oJ8DuMI22uptuYiidjNWYSqBvtSNIVGM9HU+GJlZ
 IrQWBVVPFowWcNhKCBC2/BH2t32W8DdTq77VzfJE=
Received: by mx.zohomail.com with SMTPS id 1739550455916839.183541414009;
 Fri, 14 Feb 2025 08:27:35 -0800 (PST)
Message-ID: <27c46923-53af-4185-afe2-0fd72fc7bb86@collabora.com>
Date: Fri, 14 Feb 2025 19:27:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] docs/system: virtio-gpu: Document host/guest
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
References: <20250209165649.544005-1-dmitry.osipenko@collabora.com>
 <20250209165649.544005-11-dmitry.osipenko@collabora.com>
 <c3fe5de2-8e16-406b-9f27-c7ad88201222@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <c3fe5de2-8e16-406b-9f27-c7ad88201222@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/13/25 07:47, Akihiko Odaki wrote:
> On 2025/02/10 1:56, Dmitry Osipenko wrote:
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
>>   docs/system/devices/virtio-gpu.rst | 106 ++++++++++++++++++++++++++++-
>>   1 file changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/
>> virtio-gpu.rst
>> index ea3eb052df3c..664fc4000fa9 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -5,14 +5,34 @@ virtio-gpu
>>   ==========
>>     This document explains the setup and usage of the virtio-gpu device.
>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>> +The virtio-gpu device provides a GPU and display controller
>> +paravirtualized using VirtIO. It supports a number of different modes
>> +from simple 2D displays to fully accelerated 3D graphics.
>> +
>> +virtio-gpu requirements
>> +-----------------------
>>     Linux kernel support
>> ---------------------
>> +^^^^^^^^^^^^^^^^^^^^
>>     virtio-gpu requires a guest Linux kernel built with the
>>   ``CONFIG_DRM_VIRTIO_GPU`` option.
>>   +Host Linux kernel requirements vary depending on a used virtio-gpu
>> +capabilities. See further sections for a detailed descriptions.
> 
> The section for 3D acceleration follows so let's defer the description
> for the host requirements to that section.
> 
> Perhaps the section title may be changed to clarify that it only
> describes the guest Linux kernel requirement to exclude the host Linux
> kernel requirement as well as guest Mesa.

Alright, think I now see what you meant in the comment to v7.

>> +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Kernel
>> +    - Rutabaga build flags
>> +  * - Vulkan+Wayland pass-through
>> +    - Linux 6.13+
>> +    - Follow `gfxstream-enabled rutabaga`_ build instructions
> 
> It is odd that the column header says "build flags", and this cell says
> "Follow `gfxstream-enabled rutabaga`_ build instructions".
> 
> I think you can simply remove this column. This section already says it
> leverages Rutabaga and the crosvm book provides build instructions.

In the other reply you said that you're strongly opposed to adding any
Mesa/virglrenderer build flags to the QEMU doc. I'm going to remove all
build flags in v9. Please let me know if I misunderstood you and you're
meaning something else.

-- 
Best regards,
Dmitry

