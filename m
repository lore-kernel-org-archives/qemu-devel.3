Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA7C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGHE-0001Mg-Cx; Mon, 17 Jun 2024 13:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJGHA-0001Il-KL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJGH7-0008CM-OZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718645772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxI5iVshJquNI/TqRcQHFevNIbkEjKSgsfyxVppwjdA=;
 b=EJUEQpfZxZP+VQeXlybw5HgLfFGoKK6zYVVZk17go050AqELRQXv7KHTs+f4eLJzyoxaZk
 JA9Qq9ynwWPAuQW+r4WXmIUOBVvufcJ+X4wXowMv9ptHxwOvN0n8M1O44hYEN3/nWBWPuL
 2w7APz0PxyTEOOKFkvk82BcP/on6MkA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-aLAOn6FqPOWr4_n_YuuO6g-1; Mon, 17 Jun 2024 13:36:11 -0400
X-MC-Unique: aLAOn6FqPOWr4_n_YuuO6g-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dff151b19f0so6851205276.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718645771; x=1719250571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DxI5iVshJquNI/TqRcQHFevNIbkEjKSgsfyxVppwjdA=;
 b=S/3vaR7S1dx+okP1aHfih1q9oWU7jd7ZHfqI9occNiAeQh1Owz65WfEE5u7wHwVeJW
 cJCH7kiBNkiLLutFARKpSFss4A6zW5YSwgm8IgBHW3LXYvXQjqF7xeE4upzKaWONEWuC
 iqUQiE1zFp5lNsjBbR93wucH9cmREhO1yPyoUNtqrwigYse+tW/FNDSNbzYdZE0F5n+/
 5D3EdMsz5q7QOSb1DmKlkf1CeQpbJINOOiakdzGQNJ65gQanHmt1ozEyTa4t5aFVJBB4
 bRcOf0JKCvKcXstZl+IEiTVxQPQ6880rxma8L0mVVBR9Up9NTZHtMSzLPr/nkVsocKxn
 bFbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQPpXWezKbbOBVtGxZZ/axLwcSNhKR5TEZxOOR1yFDlc2om4ZL/9PPnVxzr4S4U8ogKqOEtC+3FrNrw67NvVZXzsj4oM=
X-Gm-Message-State: AOJu0Yw4pjxnYcEHivGw2GOfTrvhTVHWOGg6AaffJxf6ptSaRpQvBeDG
 gb1c3KyQNDrgDD7d0ez11xMsxKf5Sa+xijJBdDJH/umYOI2fCoHfedCXBPOR5oUgLauTDu+21Ae
 N65+h3w2FRhdOauHoVQ03f6qdJr/zb4KgJA9ZTbguhj7yVCpi2Jqo
X-Received: by 2002:a25:aea4:0:b0:dcd:19ba:10df with SMTP id
 3f1490d57ef6-dff154c4a34mr9856567276.56.1718645770811; 
 Mon, 17 Jun 2024 10:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNHRwqDgQP1evwZy3k1hAiDt1Et/QL078o6Px4he7oHpTUtH9KFR+UKu72UcNziLUW4H4GA==
X-Received: by 2002:a25:aea4:0:b0:dcd:19ba:10df with SMTP id
 3f1490d57ef6-dff154c4a34mr9856546276.56.1718645770422; 
 Mon, 17 Jun 2024 10:36:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5ee0346sm57483816d6.115.2024.06.17.10.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 10:36:10 -0700 (PDT)
Message-ID: <94056c98-21bd-4a19-9c33-a549e0cb5dd1@redhat.com>
Date: Mon, 17 Jun 2024 19:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] Add a host IOMMU device abstraction to check
 with vIOMMU
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Michael,

On 6/5/24 10:30 AM, Zhenzhong Duan wrote:
> Hi,
> 
> This series introduce a HostIOMMUDevice abstraction and sub-classes.
> Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
> between vIOMMU and HostIOMMUDevice.
> 
> A HostIOMMUDevice is an abstraction for an assigned device that is protected
> by a physical IOMMU (aka host IOMMU). The userspace interaction with this
> physical IOMMU can be done either through the VFIO IOMMU type 1 legacy
> backend or the new iommufd backend. The assigned device can be a VFIO device
> or a VDPA device. The HostIOMMUDevice is needed to interact with the host
> IOMMU that protects the assigned device. It is especially useful when the
> device is also protected by a virtual IOMMU as this latter use the translation
> services of the physical IOMMU and is constrained by it. In that context the
> HostIOMMUDevice can be passed to the virtual IOMMU to collect physical IOMMU
> capabilities such as the supported address width. In the future, the virtual
> IOMMU will use the HostIOMMUDevice to program the guest page tables in the
> first translation stage of the physical IOMMU.


This series has been the subject of reviews and tests on various
architectures and platforms. It prepares ground for more IOMMU changes
related to the new IOMMUFD backend.

I have queued them in the VFIO 9.1 tree for now, awaiting approval
from the PCI maintainers. Could please take look at the pci part which
introduces new IOMMU callbacks ?

Thanks,

C



> HostIOMMUDeviceClass::realize() is introduced to initialize
> HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.
> 
> HostIOMMUDeviceClass::get_cap() is introduced to query host IOMMU
> device capabilities.
> 
> The class tree is as below:
> 
>                                HostIOMMUDevice
>                                       | .caps
>                                       | .realize()
>                                       | .get_cap()
>                                       |
>              .-----------------------------------------------.
>              |                        |                      |
> HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
>              |                        |                      | [.iommufd]
>                                                              | [.devid]
>                                                              | [.ioas_id]
>                                                              | [.attach_hwpt()]
>                                                              | [.detach_hwpt()]
>                                                              |
>                                              .----------------------.
>                                              |                      |
>                           HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
>                                            | [.vdev]                | {.vdev}
> 
> * The attributes in [] will be implemented in nesting series.
> * The classes in {} will be implemented in future.
> * .vdev in different class points to different agent device,
> * i.e., VFIODevice or VDPADevice.
> 
> PATCH1-4: Introduce HostIOMMUDevice and its sub classes
> PATCH5-10: Implement .realize() and .get_cap() handler
> PATCH11-14: Create HostIOMMUDevice instance and pass to vIOMMU
> PATCH15-17: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)
> 
> Test done:
> make check
> vfio device hotplug/unplug with different backend on linux
> reboot, kexec
> build test on linux and windows11
> 
> Qemu code can be found at:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v7
> 
> Besides the compatibility check in this series, in nesting series, this
> host IOMMU device is extended for much wider usage. For anyone interested
> on the nesting series, here is the link:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v7:
> - drop config CONFIG_HOST_IOMMU_DEVICE (Cédric)
> - introduce HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX (Eric)
> - use iova_ranges method in iommufd.realize() (Eric)
> - introduce HostIOMMUDevice::name to facilitate tracing (Eric)
> - implement a custom destroy hash function (Cédric)
> - drop VTDHostIOMMUDevice and save HostIOMMUDevice in hash table (Eric)
> - move patch5 after patch1 (Eric)
> - squash patch3 and 4, squash patch12 and 13 (Eric)
> - refine comments (Eric)
> - collect Eric's R-B
> 
> v6:
> - open coded host_iommu_device_get_cap() to avoid #ifdef in intel_iommu.c (Cédric)
> 
> v5:
> - pci_device_set_iommu_device return true (Cédric)
> - fix build failure on windows (thanks Cédric found that issue)
> 
> v4:
> - move properties vdev, iommufd and devid to nesting series where need it (Cédric)
> - fix 32bit build with clz64 (Cédric)
> - change check_cap naming to get_cap (Cédric)
> - return bool if error is passed through errp (Cédric)
> - drop HostIOMMUDevice[LegacyVFIO|IOMMUFD|IOMMUFDVFIO] declaration (Cédric)
> - drop HOST_IOMMU_DEVICE_CAP_IOMMUFD (Cédric)
> - replace include directive with forward declaration (Cédric)
> 
> v3:
> - refine declaration and doc for HostIOMMUDevice (Cédric, Philippe)
> - introduce HostIOMMUDeviceCaps, .realize() and .check_cap() (Cédric)
> - introduce helper range_get_last_bit() for range operation (Cédric)
> - separate pci_device_get_iommu_bus_devfn() in a prereq patch (Cédric)
> - replace HIOD_ abbreviation with HOST_IOMMU_DEVICE_ (Cédric)
> - add header in include/sysemu/iommufd.h (Cédric)
> 
> v2:
> - use QOM to abstract host IOMMU device and its sub-classes (Cédric)
> - move host IOMMU device creation in attach_device() (Cédric)
> - refine pci_device_set/unset_iommu_device doc further (Eric)
> - define host IOMMU info format of different backend
> - implement get_host_iommu_info() for different backend (Cédric)
> - drop cap/ecap update logic (MST)
> - check aw-bits from get_host_iommu_info() in legacy mode
> 
> v1:
> - use HostIOMMUDevice handle instead of union in VFIODevice (Eric)
> - change host_iommu_device_init to host_iommu_device_create
> - allocate HostIOMMUDevice in host_iommu_device_create callback
>    and set the VFIODevice base_hdev handle (Eric)
> - refine pci_device_set/unset_iommu_device doc (Eric)
> - use HostIOMMUDevice handle instead of union in VTDHostIOMMUDevice (Eric)
> - convert HostIOMMUDevice to sub object pointer in vtd_check_hdev
> 
> rfcv2:
> - introduce common abstract HostIOMMUDevice and sub struct for different BEs (Eric, Cédric)
> - remove iommufd_device.[ch] (Cédric)
> - remove duplicate iommufd/devid define from VFIODevice (Eric)
> - drop the p in aliased_pbus and aliased_pdevfn (Eric)
> - assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (Cédric, Eric)
> - use errp in iommufd_device_get_info (Eric)
> - split and simplify cap/ecap check/sync code in intel_iommu.c (Cédric)
> - move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (Cédric)
> - make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (Cédric)
> - block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
> - add R-B
> 
> Yi Liu (2):
>    hw/pci: Introduce pci_device_[set|unset]_iommu_device()
>    intel_iommu: Implement [set|unset]_iommu_device() callbacks
> 
> Zhenzhong Duan (15):
>    backends: Introduce HostIOMMUDevice abstract
>    backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
>    vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
>    backends/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO]
>      devices
>    range: Introduce range_get_last_bit()
>    vfio/container: Implement HostIOMMUDeviceClass::realize() handler
>    backends/iommufd: Introduce helper function
>      iommufd_backend_get_device_info()
>    vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
>    vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
>    backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
>    vfio: Create host IOMMU device instance
>    hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
>    vfio/pci: Pass HostIOMMUDevice to vIOMMU
>    intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
>    intel_iommu: Check compatibility with host IOMMU capabilities
> 
>   MAINTAINERS                           |   2 +
>   include/hw/i386/intel_iommu.h         |   2 +
>   include/hw/pci/pci.h                  |  38 ++++-
>   include/hw/vfio/vfio-common.h         |   8 +
>   include/hw/vfio/vfio-container-base.h |   3 +
>   include/qemu/range.h                  |  11 ++
>   include/sysemu/host_iommu_device.h    |  91 ++++++++++++
>   include/sysemu/iommufd.h              |  19 +++
>   backends/host_iommu_device.c          |  33 +++++
>   backends/iommufd.c                    |  76 ++++++++--
>   hw/i386/intel_iommu.c                 | 203 ++++++++++++++++++++------
>   hw/pci/pci.c                          |  75 +++++++++-
>   hw/vfio/common.c                      |  16 +-
>   hw/vfio/container.c                   |  41 +++++-
>   hw/vfio/helpers.c                     |  17 +++
>   hw/vfio/iommufd.c                     |  37 ++++-
>   hw/vfio/pci.c                         |  19 ++-
>   backends/meson.build                  |   1 +
>   18 files changed, 623 insertions(+), 69 deletions(-)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c
> 


