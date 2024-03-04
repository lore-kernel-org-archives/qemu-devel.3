Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E64C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 04:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgzll-0007eL-BU; Sun, 03 Mar 2024 23:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rgzlj-0007dQ-Oa
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 23:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rgzlh-0003IO-Qu
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 23:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709525856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLoJeu/MJgO02S24yafKoCZcFLLHzlFUnHlQNssRjLA=;
 b=TLRMW/v99A0xg8Q7x0vt4c+kewcXGAXEV5F059y8PxOjbv2jb133k9kNNU4n+3GmhpTWBT
 G+IPXzOarNSsGz1u2YF5XLSLy1Fd8ACq/cVbQ4zDiplZRz1lJWOYTsWzUgLd5Jq5K6YmSV
 Wh7+dmFRsANgg7cKOz8JXdbia/3Ulj8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-KJotuOUYPxWMQKI0PfAe6A-1; Sun, 03 Mar 2024 23:17:34 -0500
X-MC-Unique: KJotuOUYPxWMQKI0PfAe6A-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2992c1d4e7fso1766284a91.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 20:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709525854; x=1710130654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLoJeu/MJgO02S24yafKoCZcFLLHzlFUnHlQNssRjLA=;
 b=ejD28YJF+HVBZfZYCr3EjQMXbyEikreZDLBdpZDd9w8nxFt/GGLXW7v978crD7aVoc
 jkJuBpU4DqlUMN+oY7OAzYtSZcCKEiX3rpl1owH0+l5WPQWgBjBVeVDLp4lbJ8ts2xFv
 0JyY55oSKcDwf7ILgnLSpgXIRxvnsQkKrIqz4zA7CKipgC74W6JZwRxLf6OMLFTg3atu
 vZ3oY/vCUnnG/d5UfW6JtVQykwXulHtTPs1bHRui2Azz5iLlLRVCjf8qE1rZ29/1jhDW
 j+ELMtH+BcDFlBPJJzfPFdSCR+CsY83s+HHza75urc+DokGtwesgLHk5BQsghhxd4GZW
 0TUw==
X-Gm-Message-State: AOJu0YyS5GeegqBsNzCVQ5Kw0VLLpYJjVFV/I2OL42h70HQqIwgjk41j
 hubq55L3NX+flvg7ANQ1Lo3Wbp36qn/OG3GpFp6SqsAiaSBVrKSR05lECXuXa6eMrvJNH6Ngjnn
 xkTb66GVcWBHOgGobtA634renaBr0qFzuoAIqrmnaNxxGa3mUSE0+jEXwsRxy2ev0FjKUtAN+0t
 eLM8DW7Uik/2acbDuT8231a8Rlofo=
X-Received: by 2002:a17:90a:9f8d:b0:299:544c:4933 with SMTP id
 o13-20020a17090a9f8d00b00299544c4933mr5672354pjp.14.1709525853834; 
 Sun, 03 Mar 2024 20:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnJHT8tjJe7xHJC/K3zuiLv1+lSTiN6eQ1/cZ/xECHgtnO4Fyt8zROllsP6Xh32U055vIFAHqDPrWEN2Sxzb0=
X-Received: by 2002:a17:90a:9f8d:b0:299:544c:4933 with SMTP id
 o13-20020a17090a9f8d00b00299544c4933mr5672340pjp.14.1709525853555; Sun, 03
 Mar 2024 20:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Mar 2024 12:17:22 +0800
Message-ID: <CACGkMEtadjC7sX+ssc=5LTaqrrkVZzs4DDMMiUPdPVXRLD0hJw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Check and sync host IOMMU cap/ecap with vIOMMU
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, peterx@redhat.com, mst@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com, 
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Feb 28, 2024 at 5:46=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Hi,
>
> Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
> is further splitted to host IOMMU device abstract part [2] and vIOMMU
> check/sync part. This series implements the 2nd part.
>
> This enables vIOMMU to get host IOMMU cap/ecap information by implementin=
g
> a new set/unset_iommu_device interface, then vIOMMU could check or sync
> with vIOMMU's own cap/ecap config.

Does it mean that it would supress the cap/ecap config from the qemu
command line? If yes, I wonder how to maintain the migration
compatibility.

Thanks

>
> It works by having device side, i.e. VFIO, register either an IOMMULegacy=
Device
> or IOMMUFDDevice to vIOMMU, which includes necessary data to archive that=
.
> Currently only VFIO device is supported, but it could also be used for ot=
her
> devices, i.e., VDPA.
>
> For coldplugged device, we can get its host IOMMU cap/ecap during qemu in=
it,
> then check and sync into vIOMMU cap/ecap.
> For hotplugged device, vIOMMU cap/ecap is frozen, we could only check wit=
h
> vIOMMU cap/ecap, not allowed to update. If check fails, hotplugged will f=
ail.
>
> This is also a prerequisite for incoming iommufd nesting series:
> 'intel_iommu: Enable stage-1 translation'.
>
> I didn't implement cap/ecap sync for legacy VFIO backend, would like to s=
ee
> what Eric want to put in IOMMULegacyDevice for virtio-iommu and if I can
> utilize some of them.
>
> Because it's becoming clear on community's suggestion, I'd like to remove
> rfc tag from this version.
>
> Qemu code can be found at:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_par=
t2_v1
>
> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.=
duan@intel.com
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg06314.html
>
> Thanks
> Zhenzhong
>
> Changelog:
> v1:
> - convert HostIOMMUDevice to sub object pointer in vtd_check_hdev
>
> rfcv2:
> - introduce common abstract HostIOMMUDevice and sub struct for different =
BEs (Eric, C=C3=A9dric)
> - remove iommufd_device.[ch] (C=C3=A9dric)
> - remove duplicate iommufd/devid define from VFIODevice (Eric)
> - drop the p in aliased_pbus and aliased_pdevfn (Eric)
> - assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (C=C3=A9dr=
ic, Eric)
> - use errp in iommufd_device_get_info (Eric)
> - split and simplify cap/ecap check/sync code in intel_iommu.c (C=C3=A9dr=
ic)
> - move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (C=C3=A9d=
ric)
> - make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (C=C3=
=A9dric)
> - block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
> - add R-B
>
>
> Yi Liu (2):
>   intel_iommu: Add set/unset_iommu_device callback
>   intel_iommu: Add a framework to check and sync host IOMMU cap/ecap
>
> Zhenzhong Duan (4):
>   intel_iommu: Extract out vtd_cap_init to initialize cap/ecap
>   intel_iommu: Implement check and sync mechanism in iommufd mode
>   intel_iommu: Use mgaw instead of s->aw_bits
>   intel_iommu: Block migration if cap is updated
>
>  hw/i386/intel_iommu_internal.h |   9 ++
>  include/hw/i386/intel_iommu.h  |   4 +
>  hw/i386/acpi-build.c           |   3 +-
>  hw/i386/intel_iommu.c          | 287 ++++++++++++++++++++++++++-------
>  4 files changed, 245 insertions(+), 58 deletions(-)
>
> --
> 2.34.1
>


