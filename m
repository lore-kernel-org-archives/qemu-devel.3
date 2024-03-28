Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AB9C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpk41-0007Fr-ML; Thu, 28 Mar 2024 03:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpk3z-0007FK-QS
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpk3x-0000E1-6h
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711610435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/raSgnR5Flpm5xYnPZQmx/dBouS2XEbVWQJ44VVP4E=;
 b=FEqH1iqcvDoLq1k0YU243rP6/2Erjnc24xo8xWJ8ltuIQ8HygEwWr6hTgRgLl1aOFiexo4
 XIVqochEk/xwu+j+CMsS8TgEEPFJsgrIrdgsxhpMP7L6+0xVwYWa6MMnfPPqse7a+u0f71
 RgzZpUq2w1UAwZwQ8+iodbBidUzMS8w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-qJNkBSmkPJ2faTZEn4WBgQ-1; Thu, 28 Mar 2024 03:20:31 -0400
X-MC-Unique: qJNkBSmkPJ2faTZEn4WBgQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a474ac232e9so29537566b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 00:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711610430; x=1712215230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/raSgnR5Flpm5xYnPZQmx/dBouS2XEbVWQJ44VVP4E=;
 b=w3H69p3WLHpUN+WR/RRTk2LEkqQ47dEmhIe1OuR8JUOCMnQ3y3tPODyn/lQaHkGBdP
 m+yP7dxV55GZnrp314fyCUieMCGzPjsvIxbKDxKy7ifYvuBDUDnqqBogZ5e9iPj2ciiX
 L7PNDZVEX6EoRyZKFZCmCvv6W/8C9b6c1VIFcqdUZKsHCav74RpiRXDewqm0PJQGWcB5
 AG7Kdmif5b6UCfA9aUsxMlsXpRtOflaBtyoVoh5YfUELZds6oDhcn8v3EmYfK6okUiDA
 3g54EGXhY1czgAhBwaaHL5mXtK0ePyqLrXSSoFAOOlP3tnJ9m5uOPPQ7FRoQiAJTO0Vi
 HFSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsAdd6WSLd1Xw3gb/Qm00yjGmRns0Rn37oSdFbXYRaSiSP9hioPwVVi0tde9ZBzqFA0vMeSGyxpGioujgVT/fFMZiX/1A=
X-Gm-Message-State: AOJu0YySke/0ctA1xHZDaBevtslyYvUpXYH5TLIR9ZTFtrqJuIAB6GnC
 7LfrVVLpeh4hN4Yq0IAVR1LThgToNbj3cI30228Z+y+kkq9rKuaZWlCwz0+C7Y0SUrjPRfM5N45
 nExn9vve0e7vWyAZLtdX/E83QchBmyhLCMNc0rqxx6uRxMdJgyWgO
X-Received: by 2002:a17:906:fa04:b0:a46:bfe2:521f with SMTP id
 lo4-20020a170906fa0400b00a46bfe2521fmr1318273ejb.24.1711610430245; 
 Thu, 28 Mar 2024 00:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmfQYIEboJ8bIec628kSm20IUFPtWq+LnQH4CNZX2py3QaCJ8el81uV8H45k5zVIeA6Ic3Gg==
X-Received: by 2002:a17:906:fa04:b0:a46:bfe2:521f with SMTP id
 lo4-20020a170906fa0400b00a46bfe2521fmr1318240ejb.24.1711610429627; 
 Thu, 28 Mar 2024 00:20:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 qu20-20020a170907111400b00a46e2f89a9csm409303ejb.32.2024.03.28.00.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 00:20:29 -0700 (PDT)
Date: Thu, 28 Mar 2024 03:20:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Message-ID: <20240328030023-mutt-send-email-mst@kernel.org>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313030303-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB6744F2805D8EF6722C725DAC922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313071647-mutt-send-email-mst@kernel.org>
 <b6ca5e9f-5ba2-4133-b7a0-2e3932fcd051@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ca5e9f-5ba2-4133-b7a0-2e3932fcd051@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Mar 18, 2024 at 02:20:50PM +0100, Eric Auger wrote:
> Hi Michael,
> 
> On 3/13/24 12:17, Michael S. Tsirkin wrote:
> > On Wed, Mar 13, 2024 at 07:54:11AM +0000, Duan, Zhenzhong wrote:
> >>
> >>> -----Original Message-----
> >>> From: Michael S. Tsirkin <mst@redhat.com>
> >>> Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
> >>> sync host IOMMU cap/ecap
> >>>
> >>> On Wed, Mar 13, 2024 at 02:52:39AM +0000, Duan, Zhenzhong wrote:
> >>>> Hi Michael,
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Michael S. Tsirkin <mst@redhat.com>
> >>>>> Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
> >>>>> sync host IOMMU cap/ecap
> >>>>>
> >>>>> On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
> >>>>>> From: Yi Liu <yi.l.liu@intel.com>
> >>>>>>
> >>>>>> Add a framework to check and synchronize host IOMMU cap/ecap with
> >>>>>> vIOMMU cap/ecap.
> >>>>>>
> >>>>>> The sequence will be:
> >>>>>>
> >>>>>> vtd_cap_init() initializes iommu->cap/ecap.
> >>>>>> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
> >>>>>> iommu->cap_frozen set when machine create done, iommu->cap/ecap
> >>>>> become readonly.
> >>>>>> Implementation details for different backends will be in following
> >>> patches.
> >>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>>>>> ---
> >>>>>>  include/hw/i386/intel_iommu.h |  1 +
> >>>>>>  hw/i386/intel_iommu.c         | 50
> >>>>> ++++++++++++++++++++++++++++++++++-
> >>>>>>  2 files changed, 50 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/include/hw/i386/intel_iommu.h
> >>>>> b/include/hw/i386/intel_iommu.h
> >>>>>> index bbc7b96add..c71a133820 100644
> >>>>>> --- a/include/hw/i386/intel_iommu.h
> >>>>>> +++ b/include/hw/i386/intel_iommu.h
> >>>>>> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
> >>>>>>
> >>>>>>      uint64_t cap;                   /* The value of capability reg */
> >>>>>>      uint64_t ecap;                  /* The value of extended capability reg */
> >>>>>> +    bool cap_frozen;                /* cap/ecap become read-only after
> >>> frozen */
> >>>>>>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
> >>>>>>      GHashTable *iotlb;              /* IOTLB */
> >>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >>>>>> index ffa1ad6429..a9f9dfd6a7 100644
> >>>>>> --- a/hw/i386/intel_iommu.c
> >>>>>> +++ b/hw/i386/intel_iommu.c
> >>>>>> @@ -35,6 +35,8 @@
> >>>>>>  #include "sysemu/kvm.h"
> >>>>>>  #include "sysemu/dma.h"
> >>>>>>  #include "sysemu/sysemu.h"
> >>>>>> +#include "hw/vfio/vfio-common.h"
> >>>>>> +#include "sysemu/iommufd.h"
> >>>>>>  #include "hw/i386/apic_internal.h"
> >>>>>>  #include "kvm/kvm_i386.h"
> >>>>>>  #include "migration/vmstate.h"
> >>>>>> @@ -3819,6 +3821,38 @@ VTDAddressSpace
> >>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >>>>>>      return vtd_dev_as;
> >>>>>>  }
> >>>>>>
> >>>>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
> >>>>>> +                                 IOMMULegacyDevice *ldev,
> >>>>>> +                                 Error **errp)
> >>>>>> +{
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
> >>>>>> +                                  IOMMUFDDevice *idev,
> >>>>>> +                                  Error **errp)
> >>>>>> +{
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int vtd_check_hdev(IntelIOMMUState *s,
> >>> VTDHostIOMMUDevice
> >>>>> *vtd_hdev,
> >>>>>> +                          Error **errp)
> >>>>>> +{
> >>>>>> +    HostIOMMUDevice *base_dev = vtd_hdev->dev;
> >>>>>> +    IOMMUFDDevice *idev;
> >>>>>> +
> >>>>>> +    if (base_dev->type == HID_LEGACY) {
> >>>>>> +        IOMMULegacyDevice *ldev = container_of(base_dev,
> >>>>>> +                                               IOMMULegacyDevice, base);
> >>>>>> +
> >>>>>> +        return vtd_check_legacy_hdev(s, ldev, errp);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    idev = container_of(base_dev, IOMMUFDDevice, base);
> >>>>>> +
> >>>>>> +    return vtd_check_iommufd_hdev(s, idev, errp);
> >>>>>> +}
> >>>>>> +
> >>>>>>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
> >>>>> devfn,
> >>>>>>                                      HostIOMMUDevice *base_dev, Error **errp)
> >>>>>>  {
> >>>>>> @@ -3829,6 +3863,7 @@ static int
> >>> vtd_dev_set_iommu_device(PCIBus
> >>>>> *bus, void *opaque, int devfn,
> >>>>>>          .devfn = devfn,
> >>>>>>      };
> >>>>>>      struct vtd_as_key *new_key;
> >>>>>> +    int ret;
> >>>>>>
> >>>>>>      assert(base_dev);
> >>>>>>
> >>>>>> @@ -3848,6 +3883,13 @@ static int
> >>> vtd_dev_set_iommu_device(PCIBus
> >>>>> *bus, void *opaque, int devfn,
> >>>>>>      vtd_hdev->iommu_state = s;
> >>>>>>      vtd_hdev->dev = base_dev;
> >>>>>>
> >>>>>> +    ret = vtd_check_hdev(s, vtd_hdev, errp);
> >>>>>> +    if (ret) {
> >>>>>> +        g_free(vtd_hdev);
> >>>>>> +        vtd_iommu_unlock(s);
> >>>>>> +        return ret;
> >>>>>> +    }
> >>>>>> +
> >>>>>>      new_key = g_malloc(sizeof(*new_key));
> >>>>>>      new_key->bus = bus;
> >>>>>>      new_key->devfn = devfn;
> >>>>>
> >>>>> Okay. So when VFIO device is created, it will call
> >>> vtd_dev_set_iommu_device
> >>>>> and that in turn will update caps.
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
> >>>>>>      s->iq_dw = false;
> >>>>>>      s->next_frcd_reg = 0;
> >>>>>>
> >>>>>> -    vtd_cap_init(s);
> >>>>>> +    if (!s->cap_frozen) {
> >>>>>> +        vtd_cap_init(s);
> >>>>>> +    }
> >>>>>>
> >>>>> If it's fronzen it's because VFIO was added after machine done.
> >>>>> And then what? I think caps are just wrong?
> >>>> Not quite get your question on caps being wrong. But try to explains:
> >>>>
> >>>> When a hot plugged vfio device's host iommu cap isn't compatible with
> >>>> vIOMMU's, hotplug should fail. Currently there is no check for this and
> >>>> allow hotplug to succeed, but then some issue will reveal later,
> >>>> e.g., vIOMMU's MGAW > host IOMMU's MGAW, guest can setup iova
> >>>> mapping beyond host supported iova range, then DMA will fail.
> >>>>
> >>>> In fact, before this series, cap is not impacted by VFIO, so it's same effect of
> >>>> frozen after machine done.
> >>>>
> >>>>>
> >>>>> I think the way to approach this is just by specifying this
> >>>>> as an option on command line.
> >>>> Do you mean add a cap_frozen property to intel_iommu?
> >>>> Vtd_init() is called in realize() and system reset(), so I utilize realize() to init
> >>> cap
> >>>> and froze cap before system reset(). If cap_frozen is an option, when it's
> >>> set to
> >>>> false, cap could be updated every system reset and it's not a fix value any
> >>> more.
> >>>> This may break migration.
> >>> No, I mean either
> >>> 1. add some kind of vfio-iommu device that is not exposed to guest
> >>>   but is not hot pluggable
> >> Not quite get, what will such vfio-iommu device be used for if not exposed to guest.
> > It will update the IOMMU.
> > And do so without need for tricky callbacks.
> >
> 
> At the moment the only way VFIO can pass info to vIOMMU is through the
> IOMMU MR API (IOMMUMemoryRegionClass).
> Unfortunately this API is not fully adapted to new use cases because it
> relies on the IOMMU MR to be enabled which causes the VFIO
> 
> vfio_listener_region_add() to be called and call the relevant IOMMU MR callback. Before the IOMMU MR enablement there is no way to convey info from VFIO to the vIOMMU. That why, for several years and since the beginning of discussions related to nested IOMMU, Peter Xu, Yi Liu, myself headed towards the usage of PCIIOMMUOps instead.
> 
> 
> You will find in 
> [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
> https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
> yet another example of such kind of PCIIOMMUOps. In that series instead of relying on a HostIOMMUDevice object as proposed by Zhenzhong it uses a direct callback but it is still the same principle and the HostIOMMUDevice looks better to accomodate both iommufd and VFIO backend.
> 
> 
> host reserved memory regions is not something we can easiliy describe at vIOMMU level. The info are fetched from host and propagated to the vIOMMU
> 
> I think nested stage setup would also need this PCIIOMMUOps trick to setup stage 1 info. So the introduction of the so called HostIOMMUDevice object has a broader scope than a gaw option or ecap option set I think.
> 
> If you don't like this approach, please can you elaborate on the "vfio-iommu device" proposal above so that we can explore it.
> 
> Thank you in advance
> 
> Eric


Hi Eric,
Sorry about the delay in answering - was on vacation.

My concern is with user interface not with the internal API used.
The concern is simple - assymetry and complex rules in handling devices.
E.g. a non hotplugged vfio device adjusts the vIOMMU, then you can
remove it and hotplug another one and it works, but if you start
without vfio then hotplug then it might fail because it's too late
to adjust the vIOMMU.

And what I am saying, is that we either want something on the qemu command line
that will tell the vIOMMU "please use info from the host" or
have management take info from the host and supply that to the vIOMMU.
The former seems more user friendly, for sure. The disadvantage of it
is that one can't e.g. take the least common denominator between two
hosts and make things migrateable in this way.
If we limit our ambition to VFIO that might be acceptable, after all
VFIO already assumes very similar hardware on src and dst of migration.
The later is what we did for aw-bits.

I see lots of acceptable options, but yes it seems nice to have
something single that will work for all IOMMUs and also maybe live under
VFIO? Thus I came up with the idea of a stub device living under vfio
who's job is just to be present on command line and adjust the guest
machine (ATM the viommu but we might see other uses too) to match host.


-- 
MST


