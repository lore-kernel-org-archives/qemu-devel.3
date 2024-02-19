Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7A9C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc7nz-00044B-JL; Mon, 19 Feb 2024 12:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7nx-00043I-HP
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7nt-00086L-1l
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708365103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8H1eFPOhtSw8K5hz/X/ZhKjJEt2LFUFnC9oN0PdPSg=;
 b=bUs0oOvEyCE1aoWDTGwaHsI8kuYWscvwkrFAtgJAT6OP1raUTkBwmraVEtU4W4j5GJfzr4
 zk67R5WVgSODl1ozrEyzBYc4orHE3CvfZyYCyxfDCBo5hlXaKQ9LoAjDqWxjZv0nWmhq/x
 8rA2TIh3NG+LKfpE7CURyJHU/mdO6ic=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-dzGjr6LvOoS1BFivRZu78w-1; Mon, 19 Feb 2024 12:51:42 -0500
X-MC-Unique: dzGjr6LvOoS1BFivRZu78w-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c13db33d54so4797767b6e.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708365102; x=1708969902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8H1eFPOhtSw8K5hz/X/ZhKjJEt2LFUFnC9oN0PdPSg=;
 b=bNZnMi75kkKRVzTxP+NFIaDwgvEt/PDoSTwZtqek0RrtOkuydQxXfnvMWcVY2pL98l
 fidxvScmAnia4yV7YFXPVEyOJ39Ik59fb8uI48OTgg9ueA64eYfu5AtyrdIlQxXp0oDh
 /k+N7SSZ4L99bKDgeJ6r4q7XfBeLEiELWguKLZX3xtnb8r3fwAn02Kvn5SI/rYVUOPvd
 Z/8Kvs80nEbYhTef8n3qF4yUF85iWuHL0I6d0W1Iq8k3x6K3q8UhOhINiE8mXKaOX4ve
 tY7pP9/mpl0N3GwbllybrLVwLfBuTCPHi3V9sBxdRAgxtvFICopcszZ2bSNpHPHO+v36
 wq8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6mkHQdzHjxbupgHmP/ftdX/j/iQ5FeizmxhZHeMpEl+R4xHNpbDHgT0Cc8rAP20IF5RUAHIGOsZliqf3GW3T1mu4pKbY=
X-Gm-Message-State: AOJu0Yx370TOI3UGp31rNJB6q/Efkl9tZCzyw0RPVUC7L+YJCvkvL0A8
 itg83E2sgE6Q0gSD9nfksw3iJHJGo2qtsOFI9xTj1gXq18XJo0sEOzXTIbuIWY5n+iCnuBn0xP2
 c2Q0TNjDOTdx2bOU2weiK43cYd5erRh/OFCRhpSWcZ9ZukscxApa2
X-Received: by 2002:a05:6808:198d:b0:3c1:55ad:dd25 with SMTP id
 bj13-20020a056808198d00b003c155addd25mr5283386oib.59.1708365101807; 
 Mon, 19 Feb 2024 09:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW0jhIH1yFerNZyZRBqTOlc44rLY5TC+d0zzXGiwAfbFXWchyoTQ7O9IQRqhpxWY9LturGGw==
X-Received: by 2002:a05:6808:198d:b0:3c1:55ad:dd25 with SMTP id
 bj13-20020a056808198d00b003c155addd25mr5283354oib.59.1708365101445; 
 Mon, 19 Feb 2024 09:51:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 qp19-20020a056214599300b0068f160a09c5sm1675062qvb.49.2024.02.19.09.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 09:51:40 -0800 (PST)
Message-ID: <750f1f96-5e6f-4ef0-9436-9b7947515e05@redhat.com>
Date: Mon, 19 Feb 2024 18:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check and
 sync host IOMMU cap/ecap
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240201072818.327930-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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



On 2/1/24 08:28, Zhenzhong Duan wrote:
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
>  hw/i386/intel_iommu.c         | 41 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
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
> index ffa1ad6429..7ed2b79669 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3819,6 +3819,31 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
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
> +
> +    if (base_dev->type == HID_LEGACY) {
> +        return vtd_check_legacy_hdev(s, vtd_hdev->ldev, errp);
> +    }
> +    return vtd_check_iommufd_hdev(s, vtd_hdev->idev, errp);
Couldn't we have HostIOMMUDevice ops instead of having this check here?

Eric
> +}
> +
>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                      HostIOMMUDevice *base_dev, Error **errp)
>  {
> @@ -3829,6 +3854,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          .devfn = devfn,
>      };
>      struct vtd_as_key *new_key;
> +    int ret;
>  
>      assert(base_dev);
>  
> @@ -3848,6 +3874,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
> @@ -4083,7 +4116,9 @@ static void vtd_init(IntelIOMMUState *s)
>      s->iq_dw = false;
>      s->next_frcd_reg = 0;
>  
> -    vtd_cap_init(s);
> +    if (!s->cap_frozen) {
> +        vtd_cap_init(s);
> +    }
>  
>      /*
>       * Rsvd field masks for spte
> @@ -4254,6 +4289,10 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
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


