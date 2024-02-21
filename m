Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A7C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuc9-0004Ko-Bi; Wed, 21 Feb 2024 16:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuc7-0004H5-Gx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:58:51 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuc3-0000wn-RT
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:58:51 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so18583985ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708552726; x=1709157526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n9A+cu7xXPk9cD8IaN/wEZD9MJ03QTnk70UdEcyhrkw=;
 b=C7zCjbFNa+iujCsyYra30hQF7HegLHmNiKVCYFty9Xe1dfJnBjNwz/1DwL/0o+uCa0
 M+NZesAF7Zvomtuyh5cTUEEQzWyHVkDqop7qRd3j5QyghGcL+hkilmQ5NfKaguqnLrAr
 MLXocCB4AlKOVQht+beFt5YrN+Vqk2lK17XE6+8oHXxqoQEgb5+u+wXC7MIAY5dt4Hqu
 6IfnZm9oX0lpMM9L+3QxdWt0r1GTsyc6Ys9+1fQRvBv036K0n1yYxvkKgQciaDfshMEE
 Lo7YRh4ZkO5NF4gNuEzqY7WrpwL5t+rxMLzm0Btm/nfhxQDaoDr419nw2DCbjhm64zf2
 NbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708552726; x=1709157526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9A+cu7xXPk9cD8IaN/wEZD9MJ03QTnk70UdEcyhrkw=;
 b=IkBcsHwDfoz+T8VrexQoLXMcZjpX0Oz1m5TZjzjsZLRFt/vIZCxY2+LHEXUkU/una9
 gKE3BBnAXFzjrHqD7obMHR4ngkKfp4sV45cdI6mJzKFa53ccfqbr3vCzQl4vNKjgvKeu
 xcc4bg3CYHT6Xhn50wv/dY7hrYHnrIp1k6yrMAzPzLd1wL3ykg20Sj8/0aS6GFnf4BCn
 6CWBvyfVJgNUvsOLMaNkPYLmYOo3kKFBLuiE4t1iKoM1FCvL7G8UMNi9ja3y0uhdXqho
 3NlT4jXSk2JrgQCh24l+4gYLLpLTsFJbk53A4ob2IuE+hEKJunEVdjxQSxqA7adcvyZe
 12KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Do82RYu4odmwnfOLLfYI88e72nfQgf9fG1Nf957mazoew7C0w6Lqp//Rg3zkL/NZuS7eXKlo1zs1aE5BqxXn3tC1B44=
X-Gm-Message-State: AOJu0Yw/QC2LIuCEpXE+dJgpeuFNfRJz133fMZAQCLMjbiPKc3kUQqzL
 KsVtIFv48XQ4MeJdSMZNDTCNzPbC/qTh7Hr7DF86YQgjZ7UsbEDDg26iDd+eZU0=
X-Google-Smtp-Source: AGHT+IHKrzjLk9Xm92cuptbvdT7dofVawjajN39d2kk202PZMMG+QqKloZhCLNstuxsgfxox8oU0DQ==
X-Received: by 2002:a17:902:6808:b0:1dc:1bc2:5d3d with SMTP id
 h8-20020a170902680800b001dc1bc25d3dmr4807885plk.8.1708552726120; 
 Wed, 21 Feb 2024 13:58:46 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h15-20020a170902f7cf00b001db4433ef95sm8515886plw.152.2024.02.21.13.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:58:45 -0800 (PST)
Message-ID: <a3cefe21-f988-4269-9048-ffe4c5d18508@linaro.org>
Date: Wed, 21 Feb 2024 11:58:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] qdev: Add a granule_mode property
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240221205926.40066-1-eric.auger@redhat.com>
 <20240221205926.40066-2-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221205926.40066-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/21/24 10:58, Eric Auger wrote:
> Introduce a new enum type property allowing to set an
> IOMMU granule. Values are 4K, 16K, 64K and host. This
> latter indicates the vIOMMU granule will matches the
> host page size.
> 
> A subsequent patch will add such a property to the
> virtio-iommu device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/qdev-properties-system.h |  3 +++
>   include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
>   hw/core/qdev-properties-system.c    | 15 +++++++++++++++
>   hw/virtio/virtio-iommu.c            | 10 ++++++++++
>   4 files changed, 39 insertions(+)
> 
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index 06c359c190..626be87dd3 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
>   extern const PropertyInfo qdev_prop_reserved_region;
>   extern const PropertyInfo qdev_prop_multifd_compression;
>   extern const PropertyInfo qdev_prop_mig_mode;
> +extern const PropertyInfo qdev_prop_granule_mode;
>   extern const PropertyInfo qdev_prop_losttickpolicy;
>   extern const PropertyInfo qdev_prop_blockdev_on_error;
>   extern const PropertyInfo qdev_prop_bios_chs_trans;
> @@ -47,6 +48,8 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
>   #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
>                          MigMode)
> +#define DEFINE_PROP_GRANULE_MODE(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_granule_mode, GranuleMode)
>   #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>                           LostTickPolicy)
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 5fbe4677c2..a82c4fa471 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -31,6 +31,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
>   
>   #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>   
> +typedef enum GranuleMode {
> +    GRANULE_MODE_4K,
> +    GRANULE_MODE_16K,
> +    GRANULE_MODE_64K,
> +    GRANULE_MODE_HOST,
> +    GRANULE_MODE__MAX,
> +} GranuleMode;
> +
> +extern const QEnumLookup GranuleMode_lookup;
> +
>   typedef struct IOMMUDevice {
>       void         *viommu;
>       PCIBus       *bus;
> @@ -67,6 +77,7 @@ struct VirtIOIOMMU {
>       Notifier machine_done;
>       bool granule_frozen;
>       uint8_t aw_bits;
> +    GranuleMode granule_mode;
>   };
>   
>   #endif
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 1a396521d5..3a0b36a7a7 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -34,6 +34,7 @@
>   #include "net/net.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pcie.h"
> +#include "hw/virtio/virtio-iommu.h"
>   #include "hw/i386/x86.h"
>   #include "util/block-helpers.h"
>   
> @@ -679,6 +680,20 @@ const PropertyInfo qdev_prop_mig_mode = {
>       .set_default_value = qdev_propinfo_set_default_value_enum,
>   };
>   
> +/* --- GranuleMode --- */
> +
> +QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
> +
> +const PropertyInfo qdev_prop_granule_mode = {
> +    .name = "GranuleMode",
> +    .description = "granule_mode values, "
> +                   "4K, 16K, 64K, host",
> +    .enum_table = &GranuleMode_lookup,
> +    .get = qdev_propinfo_get_enum,
> +    .set = qdev_propinfo_set_enum,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>   /* --- Reserved Region --- */
>   
>   /*
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 2ec5ef3cd1..2ce5839c60 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -44,6 +44,16 @@
>   #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>   #define VIOMMU_PROBE_SIZE 512
>   
> +const QEnumLookup GranuleMode_lookup = {
> +    .array = (const char *const[]) {
> +        [GRANULE_MODE_4K]  = "4K",
> +        [GRANULE_MODE_16K] = "16K",
> +        [GRANULE_MODE_64K] = "64K",
> +        [GRANULE_MODE_HOST] = "host",
> +    },
> +    .size = GRANULE_MODE__MAX
> +};

Does it ever make sense to use anything other than host?
Especially since 4k fails on a 64k host, as you report.
Why would we want to be able to select a granule that doesn't work?

There are a few older hosts with 8k pages, e.g. Alpha, MIPS, Sparc.


r~

