Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC87C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgum-0001kJ-7W; Mon, 24 Jun 2024 06:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgul-0001k4-5M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLguj-0000xE-5A
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719224828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXiPv1UxOq4niqoU+pRn5afymwTBIwtiDFY0c/tVEUk=;
 b=eAaxJFI8Ad0cGJAFpUE8VRE4guQmI5MgMlxHezjLdBKNRcuwakPRPvGCkTL1mjIZzI4UaT
 LNN6x6CCXuY+97e9AAbbf7Ii3y3NKk+kjHUTy+tqJoQoOLE5ov3W8W5UnMrQs2hIK6DycR
 ei5d5vEoJF/2WyxICp9EnxKIxO+iH48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-rVFQsN53Nj27WDSIO4WeZw-1; Mon, 24 Jun 2024 06:27:07 -0400
X-MC-Unique: rVFQsN53Nj27WDSIO4WeZw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso29877115e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224826; x=1719829626;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CXiPv1UxOq4niqoU+pRn5afymwTBIwtiDFY0c/tVEUk=;
 b=WUYnWdYHrYrcBW+FuGNLt80tkAQbxyzNybNPRCrPGA+rD1z9eiqeOuvYWiwLs1uMhh
 IqSZPgfcG4qYS3oEf6PFFT6mOuqDd92XxXlx5QlIxAa12waSz0eF3t71+BXa/+fSMqx8
 WcypmkYevK203aMMSsv7NB02nYkXwu7K1lnLi1tsLrMKpVIWHjx4DWIFXq2UfrDYe0ry
 hu/t3w6B+cNDooh26ZI/kTg8rPXONmVD/0HpsCNIPK75rUbO540nRTHoLyEf10ocMNH5
 WeoU8N5HNIYZECH7BQqnEGFB1xWXOT7+MmqWRe9eUmKs8HkBbD02cGRH3ySAcuJp7noN
 qqBA==
X-Gm-Message-State: AOJu0Yz3ScXjLkxVuvfKPoeyUiAf6alZg9rL/kZbhZ8S6E1uS5E3+p8t
 EuMcWqA2Pq+s/yA39zBIHfLt3g2C4oTL3clUvuNQkDrpTIWcNZb1qEUXZ76/+rml7WNZoZ5JIBX
 tfm09V1Og0ML4mq7ZY9SEAWPCNiX1sPCxiOBexzOK7ULEBA0BJO0S
X-Received: by 2002:a05:600c:3501:b0:424:8ff8:b12e with SMTP id
 5b1f17b1804b1-4248ff8b1b6mr20077015e9.11.1719224825824; 
 Mon, 24 Jun 2024 03:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVq8YwYCNHxLHR9iXKDfpE9hM/ieOngFEQstBFz2wXiKaUTTMq8uOwtrfYTmrghB8SbO9iw==
X-Received: by 2002:a05:600c:3501:b0:424:8ff8:b12e with SMTP id
 5b1f17b1804b1-4248ff8b1b6mr20076805e9.11.1719224825128; 
 Mon, 24 Jun 2024 03:27:05 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21225fsm166605795e9.42.2024.06.24.03.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:27:04 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v7 00/17] Add a host IOMMU device abstraction to check
 with vIOMMU
Message-ID: <20240624062552-mutt-send-email-mst@kernel.org>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jun 05, 2024 at 04:30:26PM +0800, Zhenzhong Duan wrote:
> Hi,
> 
> This series introduce a HostIOMMUDevice abstraction and sub-classes.
> Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
> between vIOMMU and HostIOMMUDevice.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Who is merging this? Me? Or Alex?



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
>                               HostIOMMUDevice
>                                      | .caps
>                                      | .realize()
>                                      | .get_cap()
>                                      |
>             .-----------------------------------------------.
>             |                        |                      |
> HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
>             |                        |                      | [.iommufd]
>                                                             | [.devid]
>                                                             | [.ioas_id]
>                                                             | [.attach_hwpt()]
>                                                             | [.detach_hwpt()]
>                                                             |
>                                             .----------------------.
>                                             |                      |
>                          HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
>                                           | [.vdev]                | {.vdev}
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
>   and set the VFIODevice base_hdev handle (Eric)
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
>   hw/pci: Introduce pci_device_[set|unset]_iommu_device()
>   intel_iommu: Implement [set|unset]_iommu_device() callbacks
> 
> Zhenzhong Duan (15):
>   backends: Introduce HostIOMMUDevice abstract
>   backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
>   vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
>   backends/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO]
>     devices
>   range: Introduce range_get_last_bit()
>   vfio/container: Implement HostIOMMUDeviceClass::realize() handler
>   backends/iommufd: Introduce helper function
>     iommufd_backend_get_device_info()
>   vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
>   vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
>   backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
>   vfio: Create host IOMMU device instance
>   hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
>   vfio/pci: Pass HostIOMMUDevice to vIOMMU
>   intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
>   intel_iommu: Check compatibility with host IOMMU capabilities
> 
>  MAINTAINERS                           |   2 +
>  include/hw/i386/intel_iommu.h         |   2 +
>  include/hw/pci/pci.h                  |  38 ++++-
>  include/hw/vfio/vfio-common.h         |   8 +
>  include/hw/vfio/vfio-container-base.h |   3 +
>  include/qemu/range.h                  |  11 ++
>  include/sysemu/host_iommu_device.h    |  91 ++++++++++++
>  include/sysemu/iommufd.h              |  19 +++
>  backends/host_iommu_device.c          |  33 +++++
>  backends/iommufd.c                    |  76 ++++++++--
>  hw/i386/intel_iommu.c                 | 203 ++++++++++++++++++++------
>  hw/pci/pci.c                          |  75 +++++++++-
>  hw/vfio/common.c                      |  16 +-
>  hw/vfio/container.c                   |  41 +++++-
>  hw/vfio/helpers.c                     |  17 +++
>  hw/vfio/iommufd.c                     |  37 ++++-
>  hw/vfio/pci.c                         |  19 ++-
>  backends/meson.build                  |   1 +
>  18 files changed, 623 insertions(+), 69 deletions(-)
>  create mode 100644 include/sysemu/host_iommu_device.h
>  create mode 100644 backends/host_iommu_device.c
> 
> -- 
> 2.34.1


