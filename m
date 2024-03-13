Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001E1C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIi1-0000nj-2z; Wed, 13 Mar 2024 03:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIhx-0000nK-8T
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIhv-0003te-BM
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710313642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7DKq5PcXeHM/abQRnM+o2AzpRzQT0ZPM/wJ+zROiuA8=;
 b=Dosv+bF9uaWpfymSVM0Iq8fzGQYP/5wAx+qjk/TjfFHNKtWsPtK2dVMBaswoEOrhrBzVs5
 zqA7ImPMivpfwRbG99c7aPsduFExM6nWN+FjtpmRbEPFuxqYzagkYMeKnSekuCvQKZt6D+
 Dt8IfEG60gvIAMSDz03Kjnb6eaK1eXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-EEPQH-0RNe6N_i4qnKR_hw-1; Wed, 13 Mar 2024 03:07:20 -0400
X-MC-Unique: EEPQH-0RNe6N_i4qnKR_hw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4132a5b38adso2716395e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 00:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710313640; x=1710918440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKq5PcXeHM/abQRnM+o2AzpRzQT0ZPM/wJ+zROiuA8=;
 b=bTZNKp0yEn1ZXB2pnjPxrD6trKvsQESAfIeQb551aYKbMtggrLZehZEJsBZDueo7cF
 javaOmEdX46Ym55/yUN04FPQOlC7RW/qUb+Z55Z8GzBZIoz+zONU2IAT3sDXxUs74gri
 SQvTmLyrs5b6Puxab9dSGxVTS/W2goFQr5zpL5l/VJWOf8FQo8k+58KJLBYyzCVcu6BA
 QsBgkjT38P/lcuqiAdxqNsEPHR1vL/0KdqiKOD+lDgGMOb1Q3ye9bVYFHUst32TNRXuH
 XYyqVczrJ3kzQG46uwW8WKOwuqvNtfE5+3G1VL7D6umsQcuYXtpRdHeD/d/hBDytmQ9q
 H1vQ==
X-Gm-Message-State: AOJu0Yzym52WYq+oA4gGKIIu7eUsib9BM79aQ3TeJflwOFQFB9z4uLQu
 ekn5rZmHwdHahqS2gq/Bb4oK88iNPsxSqQprWi6W3wlfB7b5eTuMdhetK33EJ07yhUktE74M9K3
 cRnnUHjFUBPevzOtOYGEi2gDx2s9rWzUiNd99O8UEdX04LoCwGR2Q
X-Received: by 2002:a05:600c:5119:b0:413:88a:4265 with SMTP id
 o25-20020a05600c511900b00413088a4265mr1365164wms.12.1710313639669; 
 Wed, 13 Mar 2024 00:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzFni/tNlZ+zAfDdQCJzCKUbc1SeUwMRYkRU+udBNYzxVSIJTcosU1I51ASB+zf3MKUTAPag==
X-Received: by 2002:a05:600c:5119:b0:413:88a:4265 with SMTP id
 o25-20020a05600c511900b00413088a4265mr1365133wms.12.1710313639093; 
 Wed, 13 Mar 2024 00:07:19 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 n26-20020a05600c3b9a00b00412d4c8b743sm1322256wms.30.2024.03.13.00.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 00:07:18 -0700 (PDT)
Date: Wed, 13 Mar 2024 03:07:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
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
Message-ID: <20240313030303-mutt-send-email-mst@kernel.org>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 13, 2024 at 02:52:39AM +0000, Duan, Zhenzhong wrote:
> Hi Michael,
> 
> >-----Original Message-----
> >From: Michael S. Tsirkin <mst@redhat.com>
> >Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
> >sync host IOMMU cap/ecap
> >
> >On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
> >> From: Yi Liu <yi.l.liu@intel.com>
> >>
> >> Add a framework to check and synchronize host IOMMU cap/ecap with
> >> vIOMMU cap/ecap.
> >>
> >> The sequence will be:
> >>
> >> vtd_cap_init() initializes iommu->cap/ecap.
> >> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
> >> iommu->cap_frozen set when machine create done, iommu->cap/ecap
> >become readonly.
> >>
> >> Implementation details for different backends will be in following patches.
> >>
> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>  include/hw/i386/intel_iommu.h |  1 +
> >>  hw/i386/intel_iommu.c         | 50
> >++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/i386/intel_iommu.h
> >b/include/hw/i386/intel_iommu.h
> >> index bbc7b96add..c71a133820 100644
> >> --- a/include/hw/i386/intel_iommu.h
> >> +++ b/include/hw/i386/intel_iommu.h
> >> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
> >>
> >>      uint64_t cap;                   /* The value of capability reg */
> >>      uint64_t ecap;                  /* The value of extended capability reg */
> >> +    bool cap_frozen;                /* cap/ecap become read-only after frozen */
> >>
> >>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
> >>      GHashTable *iotlb;              /* IOTLB */
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index ffa1ad6429..a9f9dfd6a7 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -35,6 +35,8 @@
> >>  #include "sysemu/kvm.h"
> >>  #include "sysemu/dma.h"
> >>  #include "sysemu/sysemu.h"
> >> +#include "hw/vfio/vfio-common.h"
> >> +#include "sysemu/iommufd.h"
> >>  #include "hw/i386/apic_internal.h"
> >>  #include "kvm/kvm_i386.h"
> >>  #include "migration/vmstate.h"
> >> @@ -3819,6 +3821,38 @@ VTDAddressSpace
> >*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >>      return vtd_dev_as;
> >>  }
> >>
> >> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
> >> +                                 IOMMULegacyDevice *ldev,
> >> +                                 Error **errp)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
> >> +                                  IOMMUFDDevice *idev,
> >> +                                  Error **errp)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
> >*vtd_hdev,
> >> +                          Error **errp)
> >> +{
> >> +    HostIOMMUDevice *base_dev = vtd_hdev->dev;
> >> +    IOMMUFDDevice *idev;
> >> +
> >> +    if (base_dev->type == HID_LEGACY) {
> >> +        IOMMULegacyDevice *ldev = container_of(base_dev,
> >> +                                               IOMMULegacyDevice, base);
> >> +
> >> +        return vtd_check_legacy_hdev(s, ldev, errp);
> >> +    }
> >> +
> >> +    idev = container_of(base_dev, IOMMUFDDevice, base);
> >> +
> >> +    return vtd_check_iommufd_hdev(s, idev, errp);
> >> +}
> >> +
> >>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
> >devfn,
> >>                                      HostIOMMUDevice *base_dev, Error **errp)
> >>  {
> >> @@ -3829,6 +3863,7 @@ static int vtd_dev_set_iommu_device(PCIBus
> >*bus, void *opaque, int devfn,
> >>          .devfn = devfn,
> >>      };
> >>      struct vtd_as_key *new_key;
> >> +    int ret;
> >>
> >>      assert(base_dev);
> >>
> >> @@ -3848,6 +3883,13 @@ static int vtd_dev_set_iommu_device(PCIBus
> >*bus, void *opaque, int devfn,
> >>      vtd_hdev->iommu_state = s;
> >>      vtd_hdev->dev = base_dev;
> >>
> >> +    ret = vtd_check_hdev(s, vtd_hdev, errp);
> >> +    if (ret) {
> >> +        g_free(vtd_hdev);
> >> +        vtd_iommu_unlock(s);
> >> +        return ret;
> >> +    }
> >> +
> >>      new_key = g_malloc(sizeof(*new_key));
> >>      new_key->bus = bus;
> >>      new_key->devfn = devfn;
> >
> >
> >Okay. So when VFIO device is created, it will call vtd_dev_set_iommu_device
> >and that in turn will update caps.
> >
> >
> >
> >
> >> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
> >>      s->iq_dw = false;
> >>      s->next_frcd_reg = 0;
> >>
> >> -    vtd_cap_init(s);
> >> +    if (!s->cap_frozen) {
> >> +        vtd_cap_init(s);
> >> +    }
> >>
> >
> >If it's fronzen it's because VFIO was added after machine done.
> >And then what? I think caps are just wrong?
> 
> Not quite get your question on caps being wrong. But try to explains:
> 
> When a hot plugged vfio device's host iommu cap isn't compatible with
> vIOMMU's, hotplug should fail. Currently there is no check for this and
> allow hotplug to succeed, but then some issue will reveal later,
> e.g., vIOMMU's MGAW > host IOMMU's MGAW, guest can setup iova
> mapping beyond host supported iova range, then DMA will fail.
> 
> In fact, before this series, cap is not impacted by VFIO, so it's same effect of
> frozen after machine done.
> 
> >
> >
> >I think the way to approach this is just by specifying this
> >as an option on command line.
> 
> Do you mean add a cap_frozen property to intel_iommu?
> Vtd_init() is called in realize() and system reset(), so I utilize realize() to init cap
> and froze cap before system reset(). If cap_frozen is an option, when it's set to
> false, cap could be updated every system reset and it's not a fix value any more.
> This may break migration.

No, I mean either
1. add some kind of vfio-iommu device that is not exposed to guest
   but is not hot pluggable

or

2. add a property to specify ecap, rely on management to set it correctly


> >
> >So if one wants VFIO one has to sync caps with host.
> >No?
> 
> Yes, check for compatibility. But it's not preventing the usage of VFIO
> with vIOMMU, it finds the incompatible issue earlier and fail hotplug instead of
> surprising guest driver failure.
> 
> Thanks
> Zhenzhong


I don't see where the check for compatibility and hotplug failure are.
Did I miss it?

> >
> >
> >
> >>      /*
> >>       * Rsvd field masks for spte
> >> @@ -4254,6 +4298,10 @@ static int
> >vtd_machine_done_notify_one(Object *child, void *unused)
> >>
> >>  static void vtd_machine_done_hook(Notifier *notifier, void *unused)
> >>  {
> >> +    IntelIOMMUState *iommu =
> >INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> >> +
> >> +    iommu->cap_frozen = true;
> >> +
> >>      object_child_foreach_recursive(object_get_root(),
> >>                                     vtd_machine_done_notify_one, NULL);
> >>  }
> >> --
> >> 2.34.1


