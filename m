Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F20C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTim4-00028w-Oj; Tue, 16 Jul 2024 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTim2-00025M-Ka
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTim0-0003MX-K0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721138599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO8mbhe8N0AV+I6/SCM/ZbHuea1bTs1IHvzVUC/H6vo=;
 b=YZy6c8ooq+7Nb8e4sLO+wTVDlmTy+lc1LTAGPvnYQHpSHg1ziGoRoFtZJcFvUkF31UI0Wi
 gHXjSSNtWLKpgbuVGn5PoEqXrSsmoJiqD2N2Z/bn9Nj995vPYF4IBh4pCNNAiywTdOakd8
 b7GNxXAqmBJYTAFOiH8tTvLPXaVszUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-dZh3ASXOPICdcTv0WLbvCg-1; Tue, 16 Jul 2024 10:03:00 -0400
X-MC-Unique: dZh3ASXOPICdcTv0WLbvCg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4272718b9b0so39744905e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721138575; x=1721743375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aO8mbhe8N0AV+I6/SCM/ZbHuea1bTs1IHvzVUC/H6vo=;
 b=wetpi1hxiSBYrlNVM0T66RyF88PBtM9VXSolb9CK79s/bKJklBejCfuAxFYzkzF2M7
 fHFHVIsnLQuKJ07EUWkbQlqqdrF0LbdXpCEN1z5i9Qk7K0sWIrtr8XybCNcvG0gCtxqe
 ZMZebOwlJF1aGkRRd9xQr+zVDWorPI5uxk/SiNj07e2sZ+IH8fOoBVm00SgVGdSqfd96
 x5zU6m0Bt1PTWcEhETmPB7RqKQYx+wPVd1JPUfX8T48MjlcIxz3XDl3FQ7MiI7Ccy+GQ
 t/rssX8AvNPyHb1UCxsUNe75HoySPgnOQGEisxufqKTEJ/Sn6C9t6hbjYEROr1vNL0iI
 fR1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpcSDftp7gftu59zCGr2kUP1EUjPI1lxIRoydyTde+F+m6FCa+A+STXB8vOWjh62mDWJCK5j6kTckTwgzgqSMu4dh3UxU=
X-Gm-Message-State: AOJu0Ywe39HhEBZ8uH1pZ+EUFVCKmiIh5E7Ewjsmi6Ginqh85KM21LKV
 KRghkvpBtVzTHl1orBhWzNi+GfSmJiklxeLIjOdWTwvV1zAO6fiq3csFyMQrLJXVSSdGFnO4JN5
 +j53o9KmDmUCAOHvdenAKfnOL97AMua7AAAEgEin2CObw21WFnd8Lj1nL3Vy5
X-Received: by 2002:a05:600c:45d2:b0:426:647b:1bf7 with SMTP id
 5b1f17b1804b1-427ba6b0e9emr17144335e9.32.1721138574899; 
 Tue, 16 Jul 2024 07:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnhLyP60kxlRMuFWBMJuZzCBaFG1RjRO220g3sLVmHMRiKSvBtz+Ihfy96a77BKakO6s77EQ==
X-Received: by 2002:a05:600c:45d2:b0:426:647b:1bf7 with SMTP id
 5b1f17b1804b1-427ba6b0e9emr17144105e9.32.1721138574520; 
 Tue, 16 Jul 2024 07:02:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e994c6sm127643545e9.26.2024.07.16.07.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 07:02:53 -0700 (PDT)
Message-ID: <5f64db5d-7690-4d18-8c31-cfe8e2083f5f@redhat.com>
Date: Tue, 16 Jul 2024 16:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] VIRTIO-IOMMU/VFIO: Revert IOMMUDevice clear and fix
 hotunplug
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/16/24 11:45, Eric Auger wrote:
> 1b889d6e39c3 ("virtio-iommu: Clear IOMMUDevice when VFIO
> device is unplugged" fixes the VFIO hotplug/hotunplug/hotplug
> sequence by clearing the IOMMUDevice which backs the VFIO device.
> However this brings other troubles such as a memory corruption.
> 
> Even when fixing some cleanups that were missed on the first
> attempt the memory corruption still exists if the IOMMUDevice is
> freed. Until we understand the exact cause let's make things simpler:
> let the backing IOMMUDevice survive the unplug as what is done
> on intel iommu for instance. Clean up/reset resources that would
> prevent the device from being hotplugged again (probe_done is removed,
> [host_]resv_regions are reset). By doing this we also rule out the
> use case of aliased BDFs which is known to be not functional with
> virtio-iommu (missing guest kernel support) and the virtio-iommu device
> implementation is not ready either.
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio_iommu_device_clear_fixes_v1
> 
> 
> Eric Auger (6):
>    Revert "virtio-iommu: Clear IOMMUDevice when VFIO device is unplugged"
>    virtio-iommu: Remove probe_done
>    virtio-iommu: Free [host_]resv_ranges on unset_iommu_devices
>    virtio-iommu: Remove the end point on detach
>    hw/vfio/common: Add vfio_listener_region_del_iommu trace event
>    virtio-iommu: Add trace point on
>      virtio_iommu_detach_endpoint_from_domain
> 
>   include/hw/virtio/virtio-iommu.h |  1 -
>   hw/vfio/common.c                 |  3 +-
>   hw/virtio/virtio-iommu.c         | 88 +++++++++++---------------------
>   hw/vfio/trace-events             |  3 +-
>   hw/virtio/trace-events           |  1 +
>   5 files changed, 35 insertions(+), 61 deletions(-)
> 


Tested-by: Cédric Le Goater <clg@redhat.com>

with a vfio-pci device (mlx5 VF) and a virtio-net-pci device.

Thanks,

C.


