Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F96C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOMp-0007Nr-0H; Mon, 01 Jul 2024 17:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOOMm-0007NX-BZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOOMd-000823-L4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719868505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO7j13VWjFaBpcr4aWZs5ErUrepl2gPxfFFabPaQ2PQ=;
 b=HcRTthx31tKMCL9PyLieC1D07FR6ySpsdWj6SuJcCDebewu8SLsO6W9nzL5v51VUDfxMKL
 //NXI+9XJVbKURgonfjDmUCDygOLNGq2rNjXxzM4ru4LNSM2U+F6UX+Nd3dUfLK3C0frxD
 bcKckDB+PjvCXVRoziY4DmyIj7+iF+I=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-DYH1tdzYMwaxH_m2MnerqA-1; Mon, 01 Jul 2024 17:15:04 -0400
X-MC-Unique: DYH1tdzYMwaxH_m2MnerqA-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4ef63cc7451so1252752e0c.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719868504; x=1720473304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tO7j13VWjFaBpcr4aWZs5ErUrepl2gPxfFFabPaQ2PQ=;
 b=IZeG/VW5H4o0p+Zi1P2axM3jqzmZkeaXM8DdIWWD9Xaks8nJ+cV5lmTTuejeTP08Hd
 KIomLTsrlQ4cuxCc51e63rUpvfy0fd3IE4BcIoWjiItGcQu6vJz9+oK3/hredqYmd604
 ZX44/c2Bqg3Ip+xj0iacu0Eh+HRVfaH/q5K1IOoYaVNPqLXGf6XHsDg8nOCEKTvcrl4h
 VnwlwZWsL+ZfEhwN/UhdWWaQarTXoWjACzPkHQlYXeO+bWAtnhlEUoOISlbRb9aOMpnp
 +l1eZwwKdUfzOFhlGRa+AvOzkyJG9ebpdlC8uqfo2koxAooFd7D4mWN4aKlzfsbEi/Vb
 I0WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9pIy/AiZpyRrJ/tI6v4QbbX6tjWRuih4GhiTEIYup2v+23ID/P0iA2bvmURpe527QfGp0JiRgZlmG20hdsYfXh48Gzzg=
X-Gm-Message-State: AOJu0YwWIAGWikwP69gjTIRTItMiVnudH/0eVuENsZwVs5DVKehdiYyD
 5aea67vQaQqT/qObGtbCbHgNIzwuqgM2tYRlAFUXQwbJtwcI623i8KJRXgvPwOIv8arzflNQ95d
 zk2MNqxYrdAm8h/8YPVRARSZ3wSC1ygRvkgtP2g3KEasW0/l8Ng/4
X-Received: by 2002:a05:6122:608a:b0:4ef:668f:2438 with SMTP id
 71dfb90a1353d-4f2a5511b8fmr8830872e0c.0.1719868503838; 
 Mon, 01 Jul 2024 14:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWVaFSKf8fcg+9zyZbS7ewBddU++DqTSM78z/CnIlue1eKH+5SFGD8DLsJKnSh0CLmpOvcBQ==
X-Received: by 2002:a05:6122:608a:b0:4ef:668f:2438 with SMTP id
 71dfb90a1353d-4f2a5511b8fmr8830856e0c.0.1719868503535; 
 Mon, 01 Jul 2024 14:15:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d692f24e6sm386377985a.73.2024.07.01.14.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 14:15:03 -0700 (PDT)
Message-ID: <86060667-4f53-4d92-a4d6-25d9bfb6f457@redhat.com>
Date: Mon, 1 Jul 2024 23:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size
 mask rework
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
References: <20240701084957.1567641-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240701084957.1567641-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/1/24 10:48 AM, Eric Auger wrote:
> The 2 first patches are fixes of
> cf2647a76e ("virtio-iommu: Compute host reserved regions")
> They can be taken separately of the rest.
> 
> Then the series uses the HostIOMMUDevice interface to fetch
> information about the page size mask supported along the assigned
> device and propagate it to the virtio-iommu. This is a similar
> work as what was done in
> 
> VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling series
> 
> but this time for the page size mask. Using this new
> infrastructure allows to handle page size mask conflicts
> earlier on device hotplug as opposed to current QEMU
> abort:
> 
> qemu-system-aarch64: virtio-iommu virtio-iommu-memory-region-8-0
> does not support frozen granule 0x10000
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> With this series the hotplug nicely fails.
> 
> Also this allows to remove hacks consisting in transiently enabling
> IOMMU MRs to collect coldplugged device page size mask before machine
> init. Those hacks were introduced by
> 
> 94df5b2180d6 ("virtio-iommu: Fix 64kB host page size VFIO device
> assignment")
> 
> The series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-psmask-rework-v2
> 
> ---
> v1 -> v2:
> - Don't update mask if the granule is frozen (Zhenzhong)
> - Collected Zhenzhong's and Cédric's R-bs
> 
> Eric Auger (7):
>    virtio-iommu: Fix error handling in
>      virtio_iommu_set_host_iova_ranges()
>    vfio-container-base: Introduce vfio_container_get_iova_ranges() helper
>    HostIOMMUDevice : remove Error handle from get_iova_ranges callback
>    HostIOMMUDevice: Introduce get_page_size_mask() callback
>    virtio-iommu : Retrieve page size mask on
>      virtio_iommu_set_iommu_device()
>    memory: remove IOMMU MR iommu_set_page_size_mask() callback
>    virtio-iommu: Revert transient enablement of IOMMU MR in bypass mode
> 
>   include/exec/memory.h                 |  38 --------
>   include/hw/vfio/vfio-container-base.h |   9 ++
>   include/sysemu/host_iommu_device.h    |  11 ++-
>   hw/vfio/common.c                      |   8 --
>   hw/vfio/container-base.c              |  15 ++++
>   hw/vfio/container.c                   |  16 ++--
>   hw/vfio/iommufd.c                     |  21 +++--
>   hw/virtio/virtio-iommu.c              | 123 +++++++++++++-------------
>   system/memory.c                       |  13 ---
>   hw/virtio/trace-events                |   2 +-
>   10 files changed, 119 insertions(+), 137 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



