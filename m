Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A3FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Xy-0005x5-S3; Tue, 12 Mar 2024 13:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5Xb-0005PW-Qb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5XZ-0000OE-PW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710263027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rz0ihC0jHCYEZG2/MEdzd7dbq7ihTki2jY6XLgouo9E=;
 b=GudCN/LDD0/VsMe4w3f3tAK9pk+G+Gy/JpcDCqDjJ+vFzUc8zJCW2gCUmUEZuciJU1PxZu
 vJYMkYC/J5XooPWxgIyGve9RGZIYrjdy9LXeWZISI0BD22M6iNXlU2fXcM4EWhEzbi9JMw
 Ely2vXc3lSY8MR6R4UUHYRcpb7MjFck=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-rdzuboCFMiyeE1xgatl09g-1; Tue, 12 Mar 2024 13:03:46 -0400
X-MC-Unique: rdzuboCFMiyeE1xgatl09g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d359de20dcso40816661fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710263025; x=1710867825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rz0ihC0jHCYEZG2/MEdzd7dbq7ihTki2jY6XLgouo9E=;
 b=jzPi0TN3SFyCAj0Q8Uwbf6m8yXOaotc8BU3b+E9uLHTJQgJHcXNhPWSFP9Wx76ziOK
 z4xz58uSoKUzuYuJ47W29IDTsSnD3wKuUIIpv9MqqvGFboOZzQ1+CLpfefLtW1/uep7k
 pDaE5ebVMrEnZ6PP7O6RoeZ9VjClZ2yPKWtygv+2oE/q4P13V2P1V0XmiWOq7eGWecbc
 b6BVfgFyUB+9yZW8A9mpaDGwoqYKr68so5Wc4mQV8WFKvQTqQjEbmm3T6CXYaxKc0fmj
 44s3V/aW/PygAkUrBI5O9Lf1oHTgR/q5+/oF7kxHs3BbM6/lFQTf/H7BldAlzXrqD7D3
 jwpw==
X-Gm-Message-State: AOJu0YyqwOjaUuwT+w6qiEkjavnmiRIbQOPwzfRSsdOt3ftWhpGs25sC
 Ziiru3nY7BkhoVfuSgeWKhO5J1k2yd+ttCM+dvHZPVJTBVSv303ksnkPbFORy9HZnMnAI/mIg0c
 Pt8zYq+/vtSSCskOMh8wV960xqLex6xw0+vSihWPJhF7X+m/sa/z2
X-Received: by 2002:a2e:7c0e:0:b0:2d4:49d5:d9f with SMTP id
 x14-20020a2e7c0e000000b002d449d50d9fmr2965503ljc.11.1710263024571; 
 Tue, 12 Mar 2024 10:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoBz0m74ibo/jV33RCk9RRcHgIs82jCfI1rb/sLDsr2B3ZXGWp+hmfT/ELc0zaCAIS9iC3Kg==
X-Received: by 2002:a2e:7c0e:0:b0:2d4:49d5:d9f with SMTP id
 x14-20020a2e7c0e000000b002d449d50d9fmr2965464ljc.11.1710263023931; 
 Tue, 12 Mar 2024 10:03:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 ay6-20020a05600c1e0600b004133825e6cfsm2567056wmb.24.2024.03.12.10.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:03:43 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:03:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Message-ID: <20240312130058-mutt-send-email-mst@kernel.org>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228094432.1092748-4-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Add a framework to check and synchronize host IOMMU cap/ecap with
> vIOMMU cap/ecap.
> 
> The sequence will be:
> 
> vtd_cap_init() initializes iommu->cap/ecap.
> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
> iommu->cap_frozen set when machine create done, iommu->cap/ecap become readonly.
> 
> Implementation details for different backends will be in following patches.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |  1 +
>  hw/i386/intel_iommu.c         | 50 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index bbc7b96add..c71a133820 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
>  
>      uint64_t cap;                   /* The value of capability reg */
>      uint64_t ecap;                  /* The value of extended capability reg */
> +    bool cap_frozen;                /* cap/ecap become read-only after frozen */
>  
>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>      GHashTable *iotlb;              /* IOTLB */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ffa1ad6429..a9f9dfd6a7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -35,6 +35,8 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>  #include "hw/i386/apic_internal.h"
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
> @@ -3819,6 +3821,38 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
> +                                 IOMMULegacyDevice *ldev,
> +                                 Error **errp)
> +{
> +    return 0;
> +}
> +
> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
> +                                  IOMMUFDDevice *idev,
> +                                  Error **errp)
> +{
> +    return 0;
> +}
> +
> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
> +                          Error **errp)
> +{
> +    HostIOMMUDevice *base_dev = vtd_hdev->dev;
> +    IOMMUFDDevice *idev;
> +
> +    if (base_dev->type == HID_LEGACY) {
> +        IOMMULegacyDevice *ldev = container_of(base_dev,
> +                                               IOMMULegacyDevice, base);
> +
> +        return vtd_check_legacy_hdev(s, ldev, errp);
> +    }
> +
> +    idev = container_of(base_dev, IOMMUFDDevice, base);
> +
> +    return vtd_check_iommufd_hdev(s, idev, errp);
> +}
> +
>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                      HostIOMMUDevice *base_dev, Error **errp)
>  {
> @@ -3829,6 +3863,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          .devfn = devfn,
>      };
>      struct vtd_as_key *new_key;
> +    int ret;
>  
>      assert(base_dev);
>  
> @@ -3848,6 +3883,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      vtd_hdev->iommu_state = s;
>      vtd_hdev->dev = base_dev;
>  
> +    ret = vtd_check_hdev(s, vtd_hdev, errp);
> +    if (ret) {
> +        g_free(vtd_hdev);
> +        vtd_iommu_unlock(s);
> +        return ret;
> +    }
> +
>      new_key = g_malloc(sizeof(*new_key));
>      new_key->bus = bus;
>      new_key->devfn = devfn;


Okay. So when VFIO device is created, it will call vtd_dev_set_iommu_device
and that in turn will update caps.




> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
>      s->iq_dw = false;
>      s->next_frcd_reg = 0;
>  
> -    vtd_cap_init(s);
> +    if (!s->cap_frozen) {
> +        vtd_cap_init(s);
> +    }
>  

If it's fronzen it's because VFIO was added after machine done.
And then what? I think caps are just wrong?


I think the way to approach this is just by specifying this
as an option on command line.

So if one wants VFIO one has to sync caps with host.
No?



>      /*
>       * Rsvd field masks for spte
> @@ -4254,6 +4298,10 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
>  
>  static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>  {
> +    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> +
> +    iommu->cap_frozen = true;
> +
>      object_child_foreach_recursive(object_get_root(),
>                                     vtd_machine_done_notify_one, NULL);
>  }
> -- 
> 2.34.1


