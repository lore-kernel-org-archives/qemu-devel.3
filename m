Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8998BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlShE-0003JY-MU; Fri, 21 Feb 2025 08:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlShB-0003J6-F5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlSh9-00048f-Fu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740143032;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFjHqFyAnv+78dDrlFr/ESysa443ItyqjogZyb4M6Nc=;
 b=HC44a7psSDL1ysxXn2zRq0P4T6oLlMhPN0JsFAgiZoTf9q6/ZL3+A+dVbgq2HaRmZ6kW3/
 D2MkbMOXG/1qGX/bVz9DQ+JT1XU1UtZ76OufFcrsuEL2UQwGpm19ZU9r+vuD5E+r37Ek8g
 B/bjt/2W1WkGfRSiLvnkO0BLw/8iKb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-UosEvuClNqeCf277N7Kxjg-1; Fri, 21 Feb 2025 08:03:51 -0500
X-MC-Unique: UosEvuClNqeCf277N7Kxjg-1
X-Mimecast-MFC-AGG-ID: UosEvuClNqeCf277N7Kxjg_1740143030
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so14308855e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740143030; x=1740747830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFjHqFyAnv+78dDrlFr/ESysa443ItyqjogZyb4M6Nc=;
 b=NOQrkkkRW87CA0zn4Qdqp32FOGNwkk1alyiZqefpICvEcH4D3/rQoB3m/dblJeEFaM
 vmhTSCZbGXATAEKwbC2jtWKbEJ+LfOMT4Fj3OZAz0a3FZPIhiaRqwilxIVOj8IYcgJKn
 bmBbEJBK6y4SENpb1N8dWbsXK/8Xx0a8sDLmNybDSs4QausrQ7hs4qC2bS79QBa9iJ08
 yPAsXaxCg3hedkimX1wwDf69AsW35ZOqeBw7l8MGz+6+KCTwABm3Epn48F2RVDEB6BQN
 tHb+IcBwoEXBwE+JWGkQ8Egw8NDlCqPLxB6jv5ZK+I5aSC9D5wKhh0Eoq8QoJ7FfzJEq
 Tisw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcBsM4pxKahXKX0acpmUQfbHxibtxpk4Hm+Y4TCScjvRE9enh/JvD/EmCO9jNxq+mZgyjdcFBrIur1@nongnu.org
X-Gm-Message-State: AOJu0Yx2yQwKhsaRtaJwk53ByqegClNTh/vSH9QeURNJkm+b8RiWwH1T
 iNqRCf9FxycybbEpxmGUPhx9W66PCtn5vP8BmO325mOGEkxi21O6zQlK1Owo1b7nV4h8pfPCrYB
 rSq8WCBny0TztxTMhed87fPCDDXqenAdTzbMMbt2lCXcrZ2tdwzhF
X-Gm-Gg: ASbGnctyy6XsSFu6f2zrLWvUF2q49snV7joV9K2ThtSlvwVK9BcZquCIO9J+6LCVTdk
 x4teMX/3h2tAy5H9BIW2nj7nzSYK/KO7De2yUwwmrnB60f5K6iPNCh5dxIbxfrlYSEPY8iozKFP
 Jqwg4F2Vx5Eav7nUUuA91jyTqWvdGyybtywKccXI0Dm4RYS/Vspczj3Lp+naPQkrz8buDMKVGd3
 9jyBkVzmGDBh1oEsa4zCaA3Owui0EkrswMNjqSLsKJH/5jAuGcOLsDrvdPDcQDDTMW9tnZMMaWh
 tN1VEX6K8zJt3HckBCqHq7LKZowrpZY/dPpu8k+HqMOzBz6HnEheDU6Z27XkHPQ=
X-Received: by 2002:a05:6000:18a9:b0:38f:30a3:51fe with SMTP id
 ffacd0b85a97d-38f6f09c087mr3005088f8f.42.1740143029746; 
 Fri, 21 Feb 2025 05:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcqG8UheAlLpfAAmAxGbcS8S7rAApjYKwYnXm/Ez8Q+LIgfX6p/DKmIx9XsqG8LvAUhwzp5Q==
X-Received: by 2002:a05:6000:18a9:b0:38f:30a3:51fe with SMTP id
 ffacd0b85a97d-38f6f09c087mr3005017f8f.42.1740143029233; 
 Fri, 21 Feb 2025 05:03:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915785sm24012762f8f.58.2025.02.21.05.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:03:48 -0800 (PST)
Message-ID: <d74a5804-4a93-4eb9-b8dd-62426663e8b2@redhat.com>
Date: Fri, 21 Feb 2025 14:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 12/20] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Introduce a new structure VTDHostIOMMUDevice which replaces
> HostIOMMUDevice to be stored in hash table.
>
> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
> also includes BDF information which will be used in future
> patches.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  7 +++++++
>  include/hw/i386/intel_iommu.h  |  2 +-
>  hw/i386/intel_iommu.c          | 14 ++++++++++++--
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2cda744786..18bc22fc72 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -28,6 +28,7 @@
>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>  #include "hw/i386/intel_iommu.h"
> +#include "system/host_iommu_device.h"
>  
>  /*
>   * Intel IOMMU register specification
> @@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
>  /* Bits to decide the offset for each level */
>  #define VTD_LEVEL_BITS           9
>  
> +typedef struct VTDHostIOMMUDevice {
> +    IntelIOMMUState *iommu_state;
> +    PCIBus *bus;
> +    uint8_t devfn;
Just to make sure the parent

HostIOMMUDevice has aliased_bus and aliased_devfn. Can you explain why do you need both aliased and non aliased info?

Thanks

Eric

> +    HostIOMMUDevice *hiod;
> +} VTDHostIOMMUDevice;
>  #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e95477e855..50f9b27a45 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -295,7 +295,7 @@ struct IntelIOMMUState {
>      /* list of registered notifiers */
>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>  
> -    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
>  
>      /* interrupt remapping */
>      bool intr_enabled;              /* Whether guest enabled IR */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 9de60e607d..fafa199f52 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
>  
>  static void vtd_hiod_destroy(gpointer v)
>  {
> -    object_unref(v);
> +    VTDHostIOMMUDevice *vtd_hiod = v;
> +
> +    object_unref(vtd_hiod->hiod);
> +    g_free(vtd_hiod);
>  }
>  
>  static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
> @@ -4388,6 +4391,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                       HostIOMMUDevice *hiod, Error **errp)
>  {
>      IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hiod;
>      struct vtd_as_key key = {
>          .bus = bus,
>          .devfn = devfn,
> @@ -4404,6 +4408,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          return false;
>      }
>  
> +    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
> +    vtd_hiod->bus = bus;
> +    vtd_hiod->devfn = (uint8_t)devfn;
> +    vtd_hiod->iommu_state = s;
> +    vtd_hiod->hiod = hiod;
> +
>      if (!vtd_check_hiod(s, hiod, errp)) {
>          vtd_iommu_unlock(s);
>          return false;
> @@ -4414,7 +4424,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      new_key->devfn = devfn;
>  
>      object_ref(hiod);
> -    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
>  
>      vtd_iommu_unlock(s);
>  


