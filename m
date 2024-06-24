Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42559C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLr3n-0000BE-KQ; Mon, 24 Jun 2024 17:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr3j-0000Ap-A1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr3h-0005O5-8j
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719263824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ks/lyash70NDg5KJt5IjvzjkVpCb5S9X3Q4+YXug5PI=;
 b=CD7xxj58mt6PUuuMrTYE/mNiLwvlEITBSmvzlokxluPGHqI2mLFLch89nV9y7mUn+x3iGz
 DUeWyfTgysVRiP61u62SxRAqMdDtJJTU8tClTD4lupIitCEl8ai5Teu+kiEF5Hol8EFI4k
 RuXm7TyggjTu/2ji3G2VlX/mV5Wkut0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-OGSHQiaOPQSQrQnTjlm4gQ-1; Mon, 24 Jun 2024 17:17:02 -0400
X-MC-Unique: OGSHQiaOPQSQrQnTjlm4gQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-795509afe3cso502229385a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 14:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263822; x=1719868622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ks/lyash70NDg5KJt5IjvzjkVpCb5S9X3Q4+YXug5PI=;
 b=xJ+orroWoR3qZl2Gb/Au/W1hYzVP66fbJU0oZVJyUVRJF0DdJvAlPUP9s5G9VLLcMB
 sNZQDMEsDLrGXnCHvnHLPt+TCLyq6qhh+tMGAu6nuvPhK/9ksbEU6kLTXgalA8c6UiGq
 Xp9FWOrfUVKRgfei+njC4l1477UP9F1H3LzktzG6t05N5aT65J1BRW21MMdVvtiuznkX
 xwBivF6bhv9z2w+AVM4QBkgYhhvyOdG7I1GOEgEepqc0G+60aYIiGeoSSX/uYxv23Bzd
 8l3+Ty6ggKMIHbUVvIwoOzAF/fPSjcu3jcNK45KYaOh/U7sLoIVGKxYaNg4Ga+8ZgC+h
 oZhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW46ck6FHrB1GeroRDWv5H4FQSGFMiaRjEOg5zkIOo5BtsMHsHq0gk9f0ar+9r+Z0RbcT0Y79iKqsDmfPaBVYtBmMy2NUg=
X-Gm-Message-State: AOJu0YztvlJYGUMn1inoRHO89vH8ZNjejxGlL1YOf3yhnJjYDcam38ri
 BzME1SLCAoR+hgpEDOxfTke1cJHEsyTkCQJ1ws79gA67qIA1thC4vg9K2fnYGqEKyP6je8+aLuL
 ueTAoJ2MxSU5sSd14KvHDVJOTMaJkEVfMKhjM7ulYXtwXJb51hAsf
X-Received: by 2002:a05:620a:179f:b0:793:b91:2dbe with SMTP id
 af79cd13be357-79be6efbfe0mr765562185a.40.1719263821960; 
 Mon, 24 Jun 2024 14:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gcPOtpjhbrbiQ2jDYdlDHjM51RL08UIxZkjbVmhWcqtFY3x2M6r2XZkTLHrv/15pp4JPvg==
X-Received: by 2002:a05:620a:179f:b0:793:b91:2dbe with SMTP id
 af79cd13be357-79be6efbfe0mr765559985a.40.1719263821599; 
 Mon, 24 Jun 2024 14:17:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce8b38acsm349567185a.41.2024.06.24.14.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 14:17:01 -0700 (PDT)
Message-ID: <5dd941b4-9731-4486-a652-cbcbbd1694b0@redhat.com>
Date: Mon, 24 Jun 2024 23:16:58 +0200
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
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> 
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


Applied to vfio-next.

Thanks,

C.




