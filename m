Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E515C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE72H-0003O9-0Z; Mon, 03 Jun 2024 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE72D-0003Np-G7
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE725-00084B-52
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717418603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZI7X32II4ZPjRiOU43nHHWy5d8vIUGVlH9nPD6o8cH8=;
 b=ENyy+8cT455J/zF9R4LTRmxqsyeyu72mWJzlCLsaVKO8ZhGsUVNxXZklVi5WWkRsWu89UX
 LSnlyOiUTd0lgCGlf7Mx1nPnfClaB3xiDuWKn8wbZpd3Cww5LRjdq5cbbxbD5UY8JYabk7
 hM1mMMsRrART1EzGO/Vy3y4zG127GQ0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-vATzhDXpMt-W12t0SKTDRQ-1; Mon, 03 Jun 2024 08:43:21 -0400
X-MC-Unique: vATzhDXpMt-W12t0SKTDRQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-62a08436241so74290397b3.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418601; x=1718023401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZI7X32II4ZPjRiOU43nHHWy5d8vIUGVlH9nPD6o8cH8=;
 b=NEaLlbsb3Ct/IgZVwCIF4eLTuYiO62coW1UD5NdqJTaIW0BLLmWpFFfEyTEw9uVBNM
 3H10wP3gzFY2mCghbZdvO/xJe/Tw37xyybtqfHJZ7KV2INMHCqnd9dzh0Sn26QhNed9X
 ov5BV46Hu252OOtC7wKwPjQ748dW2nHjXxGD7pWSJ1kRIshuMV0aWoWhh+R909VoaTJy
 uV6od85HmZ04kxInBLbi+3e/g5Kec6HQmJiAM6gL2dxCV4td5fh9IAU8vAfcCJRRv7Rb
 AHXZP5/2zCboK1irBvI7ZhWVarcoZOkbFBo1S/E4O+7x3pn5bxK1H28WVYvxuKzrzQnr
 cOIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTaTPeI385u0hc5uCGyUFyIJUnN+Co8gkpYP0peEC/e6oe6soULseGRiN5yyh8LYjV3wNUDan/HvVWj3HB4WDN3Gopr68=
X-Gm-Message-State: AOJu0Yy4+9Bn9bnGv65QcRfz89jK4wet6z+mbyGq/RhoaOPr9ooqCKpY
 LKoAt/M+hlrz1PL5gEFtDpVDcVw2EBhFk4I8u6iZYaznTH3GPc9jAP6W+Go63p42R+H/aEZeKIC
 HmJFNK46Lxu2XTWJJ+iQvOLHW6lOxPCkUsWCl5yb9PS0V2TpxqBtk
X-Received: by 2002:a81:e344:0:b0:615:3332:f352 with SMTP id
 00721157ae682-62c7982afb9mr83101537b3.52.1717418600979; 
 Mon, 03 Jun 2024 05:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOFaWXxK48TpbFL5gTEGqWDMLhN1NjI8P/jsQj/UNZdRaHEPiW0clrVTTcyFVPNCNn03UhjQ==
X-Received: by 2002:a81:e344:0:b0:615:3332:f352 with SMTP id
 00721157ae682-62c7982afb9mr83101177b3.52.1717418600333; 
 Mon, 03 Jun 2024 05:43:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f2efc664sm279701385a.4.2024.06.03.05.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:43:19 -0700 (PDT)
Message-ID: <b2540fc5-482e-4dd0-bca9-60fa1d78d6a6@redhat.com>
Date: Mon, 3 Jun 2024 14:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/3/24 08:10, Zhenzhong Duan wrote:
> Hi,
>
> This series introduce a HostIOMMUDevice abstraction and sub-classes.
> Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
> between vIOMMU and HostIOMMUDevice.

I think we should have a textual description of what is a
HostIOMMUDevice. Because to me the terminology may be confusing as the
reader can understand this is an abstraction for the physical IOMMU.

Would it be correct to say:

A HostIOMMUDevice is an abstraction for an assigned device that is
protected by a physical IOMMU (aka host IOMMU). The userspace
interaction with this physical IOMMU can be done either through the VFIO
IOMMU type 1 legacy backend or the new iommufd backend. The assigned
device can be a VFIO device or a VDPA device. The HostIOMMUDevice is
needed to interact with the host IOMMU that protects the assigned
device. It is especially useful when the device is also protected by a
virtual IOMMU as this latter use the translation services of the
physical IOMMU and is constraained by it. In that context the
HostIOMMUDevice can be passed to the virtual IOMMU to collect physical
IOMMU capabilities such as the supported address width. In the future,
the virtual IOMMU will use the HostIOMMUDevice to program the guest page
tables in the first translation stage of the physical IOMMU.

If such kind of description is correct, I would also suggest to embed it
in the patch 1 commit msg.

Thanks

Eric


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
> * i.e., for VFIO it points to VFIODevice.
>
> PATCH1-4: Introduce HostIOMMUDevice and its sub classes
> PATCH5-11: Introduce HostIOMMUDeviceCaps, implement .realize() and .get_cap() handler
> PATCH12-16: Create HostIOMMUDevice instance and pass to vIOMMU
> PATCH17-19: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)
>
> Test done:
> make check
> vfio device hotplug/unplug with different backend on linux
> reboot
> build test on linux and windows11
>
> Qemu code can be found at:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v6
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
> v6:
> - Open coded host_iommu_device_get_cap() to avoid #ifdef in intel_iommu.c (Cédric)
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
> Zhenzhong Duan (17):
>   backends: Introduce HostIOMMUDevice abstract
>   vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
>   backends/iommufd: Introduce abstract TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>     device
>   vfio/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
>   backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
>   range: Introduce range_get_last_bit()
>   vfio/container: Implement HostIOMMUDeviceClass::realize() handler
>   backends/iommufd: Introduce helper function
>     iommufd_backend_get_device_info()
>   vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
>   vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
>   backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
>   vfio: Introduce VFIOIOMMUClass::hiod_typename attribute
>   vfio: Create host IOMMU device instance
>   hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
>   vfio/pci: Pass HostIOMMUDevice to vIOMMU
>   intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
>   intel_iommu: Check compatibility with host IOMMU capabilities
>
>  MAINTAINERS                           |   2 +
>  hw/i386/intel_iommu_internal.h        |   9 ++
>  include/hw/i386/intel_iommu.h         |   3 +
>  include/hw/pci/pci.h                  |  38 ++++-
>  include/hw/vfio/vfio-common.h         |   7 +
>  include/hw/vfio/vfio-container-base.h |   3 +
>  include/qemu/range.h                  |  11 ++
>  include/sysemu/host_iommu_device.h    |  88 ++++++++++++
>  include/sysemu/iommufd.h              |  19 +++
>  backends/host_iommu_device.c          |  30 ++++
>  backends/iommufd.c                    |  76 ++++++++--
>  hw/i386/intel_iommu.c                 | 198 ++++++++++++++++++++------
>  hw/pci/pci.c                          |  75 +++++++++-
>  hw/vfio/common.c                      |  16 ++-
>  hw/vfio/container.c                   |  48 ++++++-
>  hw/vfio/iommufd.c                     |  44 +++++-
>  hw/vfio/pci.c                         |  19 ++-
>  backends/Kconfig                      |   5 +
>  backends/meson.build                  |   1 +
>  19 files changed, 623 insertions(+), 69 deletions(-)
>  create mode 100644 include/sysemu/host_iommu_device.h
>  create mode 100644 backends/host_iommu_device.c
>


