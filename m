Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmER1-0004u0-JG; Mon, 18 Mar 2024 10:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEQz-0004tq-OK
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEQu-0007fG-NY
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710773868;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMIBgqI3MkwAF4ZPtjxTDESi3HDz0gCjneWLhECjKps=;
 b=cPDjCeCz/25n72u1OaK8LrEw829Rh/y+tSwos6j5A2sG6JEwjKJBCzbk09Kl59yicU8Kcq
 KzkmIUduzPApRiO5TR0Ypb8FB9bl+OkPpDe+A0qpgoDVRK4HLoIZv60CcbTQCaB5klimVf
 3334gLfs7Oi+R5KRNhsSvhoptXm3nqw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-kdXGbToEM62HgHwEgBdA6A-1; Mon, 18 Mar 2024 10:57:40 -0400
X-MC-Unique: kdXGbToEM62HgHwEgBdA6A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690e820dd84so81684786d6.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710773860; x=1711378660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMIBgqI3MkwAF4ZPtjxTDESi3HDz0gCjneWLhECjKps=;
 b=qZpWlX544VIDBisBAUulaqsfCHMzFs6knl4KsMQVmdw7QZUoA8UglRs5qwnV8UisXp
 wliSdN+SkmLYm0hMTf3+4AUKGEP32U+Nc4l9cPPH2nC2W4nKL+s9IxnAAVkcFw3p2/fV
 bOEPY1F1DSmAgT5Cm5ApX08+TNYicBU96vnN2+vx22HfU77Y5UYCWm9xh7DxmI68dl1x
 SX2RXcm9lMm/vhZEQHoOcb8oM4RWBXp8JsUeYx6NGtB6VGpDE5dLd3qcHD8M00NvRZWD
 I0Uw5TOqYB/kbj2BAfDilbOogKEfzhriLwBGlHKQHt7tCDM7uux1IHdYhNoBEebFBqDT
 wILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoWpvrMlTotqjH2cGLEHpwQcq1wX0AbJj10PItICxV/4eK/oV+d7LcoWvm4ias0cx1H739fB2PG+ZfxVLBmBb4dNyoHbc=
X-Gm-Message-State: AOJu0YzskxsmVshO27NMfJOKLP17e1Yia7NugyFRJLGo9PojjC4TTY13
 0nT524hWpxEvwh8Tjs3U4+ELfCx2+A5Y90PXTTRmvYJYT6+w3qRji5xdy8qfKo8Wtmg4N9IVZ32
 BRukKiB1hn0XHAOpGzOqagC5EVt04YgZlfC6xZdRA5klEF17Gcg3x
X-Received: by 2002:a0c:9c0a:0:b0:691:2de1:296c with SMTP id
 v10-20020a0c9c0a000000b006912de1296cmr17472023qve.11.1710773859978; 
 Mon, 18 Mar 2024 07:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1YTy0gW5z94WC0hKqeeD7D/OroJPX58zlVDKX3KidzjVLP9dhgPegweN3F0XB7QQwbM0KGA==
X-Received: by 2002:a0c:9c0a:0:b0:691:2de1:296c with SMTP id
 v10-20020a0c9c0a000000b006912de1296cmr17471992qve.11.1710773859658; 
 Mon, 18 Mar 2024 07:57:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 pp26-20020a056214139a00b00691732938a8sm4484902qvb.73.2024.03.18.07.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:57:39 -0700 (PDT)
Message-ID: <0d8cba1e-a422-421b-9c02-c60452cf5f80@redhat.com>
Date: Mon, 18 Mar 2024 15:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Add a host IOMMU device abstraction
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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



On 2/28/24 04:58, Zhenzhong Duan wrote:
> Hi,
>
> Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
> is further splitted to host IOMMU device abstract part and vIOMMU
> check/sync part. This series implements the 1st part.
>
> This split also faciliates the dirty tracking series [2] and virtio-iommu
> series [3] to depend on 1st part.
>
> PATCH1-3: Introduce HostIOMMUDevice and two sub class
> PATCH4: Define HostIOMMUDevice handle in VFIODevice
> PATCH5-8: Introdcue host_iommu_device_create callback to allocate and intialize HostIOMMUDevice
Introduce, here and below

Eric
> PATCH9-10: Introdcue set/unset_iommu_device to pass HostIOMMUDevice to vIOMMU
> PATCH11: a helper to get host IOMMU info
>
> Because it's becoming clear on community's suggestion, I'd like to remove
> rfc tag from this version.
>
> Qemu code can be found at:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_part1_v1
>
> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/
>
> Thanks
> Zhenzhong
>
> Changelog:
> v1:
> - use HostIOMMUDevice handle instead of union in VFIODevice (Eric)
> - change host_iommu_device_init to host_iommu_device_create
> - allocate HostIOMMUDevice in host_iommu_device_create callback
>   and set the VFIODevice base_hdev handle (Eric)
> - refine pci_device_set/unset_iommu_device doc (Eric)
> - use HostIOMMUDevice handle instead of union in VTDHostIOMMUDevice (Eric)
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
>
> Yi Liu (1):
>   hw/pci: Introduce pci_device_set/unset_iommu_device()
>
> Zhenzhong Duan (10):
>   Introduce a common abstract struct HostIOMMUDevice
>   backends/iommufd: Introduce IOMMUFDDevice
>   vfio: Introduce IOMMULegacyDevice
>   vfio: Add HostIOMMUDevice handle into VFIODevice
>   vfio: Introduce host_iommu_device_create callback
>   vfio/container: Implement host_iommu_device_create callback in legacy
>     mode
>   vfio/iommufd: Implement host_iommu_device_create callback in iommufd
>     mode
>   vfio/pci: Allocate and initialize HostIOMMUDevice after attachment
>   vfio: Pass HostIOMMUDevice to vIOMMU
>   backends/iommufd: Introduce helper function iommufd_device_get_info()
>
>  include/hw/pci/pci.h                  | 38 +++++++++++++++-
>  include/hw/vfio/vfio-common.h         |  8 ++++
>  include/hw/vfio/vfio-container-base.h |  1 +
>  include/sysemu/host_iommu_device.h    | 22 ++++++++++
>  include/sysemu/iommufd.h              | 19 ++++++++
>  backends/iommufd.c                    | 32 +++++++++++++-
>  hw/pci/pci.c                          | 62 +++++++++++++++++++++++++--
>  hw/vfio/common.c                      |  8 ++++
>  hw/vfio/container.c                   |  9 ++++
>  hw/vfio/iommufd.c                     | 10 +++++
>  hw/vfio/pci.c                         | 24 ++++++++---
>  11 files changed, 223 insertions(+), 10 deletions(-)
>  create mode 100644 include/sysemu/host_iommu_device.h
>


