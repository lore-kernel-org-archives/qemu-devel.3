Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB51075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38oM-0000Ah-6h; Thu, 19 Mar 2026 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38oJ-0008TA-34
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38oH-0000iN-50
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qyDSqx2jnDXF5CJkfXnT/89YC0AyfkAM5XLXGP+I0uA=;
 b=ClCi4Yy8Vf1clD0ZGRQi6UxQmlkOSZHbkqTf9WkT7LbaLV5jJnDsDE5mlK7VyqcW2IR9+j
 GaGUTZjchNbrAFvoNusnhE7T7Bbf+LRA/LBFhFGyjxB103xZ3Gu0TEyhiU8JUN8lr8pWGZ
 v70gq2OVb8INfhbyUqJPbz5UWLSmz80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-HVCxLj6pM1ucNhaT9NdhBw-1; Thu, 19 Mar 2026 04:32:51 -0400
X-MC-Unique: HVCxLj6pM1ucNhaT9NdhBw-1
X-Mimecast-MFC-AGG-ID: HVCxLj6pM1ucNhaT9NdhBw_1773909170
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b4dcdb372so368507f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773909170; x=1774513970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qyDSqx2jnDXF5CJkfXnT/89YC0AyfkAM5XLXGP+I0uA=;
 b=CzdAon799uNxXmbWIEDLApuKeBb2Q1l39pIQyIHC+r5olQJeGfNxxqsDF3vUyh/ui/
 HZIIt1ZGXe+kTOTGnYaDW68JL4YPQhCUdaWxff7784hAsAivJSjMeCNvNZF5JhKtSb3F
 UveLWc8zK8tq+znn7NIqRM1geSssOM+YYGcyPQB8yWuxAod4HQznnoZ1D7jt2RVW9qZQ
 W+KpytKgkg+N646bajlHtw936aFLvz61s6Kq1zvSgCk9vKjB2WQL9Cqv+IKVQmkl63Pp
 zbMZl2v19soNIGj9MLy0fomwN3+0AYobCe2O/w4iRAC9z44kPJA6jVXI0LA1o3XoOc+p
 PLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909170; x=1774513970;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyDSqx2jnDXF5CJkfXnT/89YC0AyfkAM5XLXGP+I0uA=;
 b=jt9ZFjXItPa/ySUNPfIo4JhtXcBvit394cuUxUIXsRrTUTVV81CoM6KuSZfJfUJWmj
 wyBggsFrUcPyYFPWOxOffq7BtmBiXar88b4nx4pnRbukBsh98wv1VhODEuo7spnz+6ND
 yALLsRQWPIaluxaWerR0uQ36JcOzpuufRMCYiGBOPN+szPxdgR2OJdV3Gxu+7oJwL9B3
 UVOyPGK3Vq1HY9Dd1BfcTFRhMy/a9Ua9+fn0eGWK8pyNbo2J1I3UXgxOEgQE9QjUBo9/
 Leqals6vOmPsPtZIkJdcJW6U+0z5I2kTmqPpK7e7Q7c0aWzibnZIi6x0JZFv1KuHqAYy
 Cvgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEua/G1QW4oo1YCFLw2Ea16RSxYN4qoWY5VoCBJHHRy3OsYX9N1Qc7UHjaS2f/n9Tr7fAY0RFHouwu@nongnu.org
X-Gm-Message-State: AOJu0YwFuRk0H1uPH3yL3Bbh/W4P2x1vgXb42J7P07LLbPvYgEw8z09R
 kBwa9ld5FF6V74Cz/7j2y+TmixV6xqdHHF4rUhncMzBXN/rPLhSrT8Zwxd+TMDVhEq67M5tkMxO
 yEkwTXbUZ413b7FTnkZ5eZyQs9pERd7OIs1CZbBd6/th4+lkoaDHfojxp
X-Gm-Gg: ATEYQzypPhXQ2acph4UNSDQ4kjf1oR3F9M3S/I1pJy6Wr3vZlOXxQESVcDzLtfcntgy
 FYaFfUM1ySqhkLtK6LuVoccDJ18LmFc6emW5Bst85SEXdN2DxIiCVIA7EguzayswAdnzznnGS/L
 eRCzUGcj7rE7bI1AHe3aSE7KrOXmt5ecWbQL/YiBFB+cwn2LRcFGaDM6CihgEkdKFbrx6rq8Tn8
 4SRhW0Jhn7BMKEeojSVst71wCcKwZTtY2Iib25kZveJDvvHO/yUN8m2q/38F5Qi8A/yC3pMDAGs
 3ejy5JRJNHfWfgppMMNMz6r+2/GZZIFVlyZUS4808h5bRP8k3uOA73benVhOVo/J2znDVWuyaTE
 kodWhLh8XjqF7V0XR+D+ZWs/OKWy1deFl2tr5XCNQ408EPeQ6eGRuYM/zfGM6
X-Received: by 2002:adf:ffc9:0:b0:43b:5192:ebfe with SMTP id
 ffacd0b85a97d-43b527c8fbfmr8359638f8f.35.1773909169582; 
 Thu, 19 Mar 2026 01:32:49 -0700 (PDT)
X-Received: by 2002:adf:ffc9:0:b0:43b:5192:ebfe with SMTP id
 ffacd0b85a97d-43b527c8fbfmr8359600f8f.35.1773909169136; 
 Thu, 19 Mar 2026 01:32:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518986fcsm13495836f8f.26.2026.03.19.01.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:32:48 -0700 (PDT)
Message-ID: <f977b52c-5e11-4d0d-ba3a-2fbe165fbbcf@redhat.com>
Date: Thu, 19 Mar 2026 09:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce
 to hw/vfio/kvm-spapr.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-8-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260318174733.1717643-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/18/26 18:47, Pierrick Bouvier wrote:
> Since this function needs kvm specific types, we need to extract in
> another file and link it only for KVM builds.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/kvm-spapr.h | 12 ++++++++++++
>   hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c |  8 ++++++++
>   hw/vfio/spapr.c     | 30 ++++-------------------------
>   hw/vfio/meson.build |  1 +
>   5 files changed, 72 insertions(+), 26 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/kvm-spapr.c
> 
> diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
> new file mode 100644
> index 00000000000..b1f68c686a7
> --- /dev/null
> +++ b/hw/vfio/kvm-spapr.h
> @@ -0,0 +1,12 @@
> +/*
> + * VFIO sPAPR KVM specific functions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hw/vfio/vfio-container.h"
> +#include "qapi/error.h"
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp);
> diff --git a/hw/vfio/kvm-spapr.c b/hw/vfio/kvm-spapr.c
> new file mode 100644
> index 00000000000..ad71c5a85e2
> --- /dev/null
> +++ b/hw/vfio/kvm-spapr.c
> @@ -0,0 +1,47 @@
> +/*
> + * VFIO sPAPR KVM specific functions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include <linux/kvm.h>
> +
> +#include "hw/vfio/vfio-container-legacy.h"
> +#include "hw/vfio/kvm-spapr.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "vfio-helpers.h"
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp)
> +{
> +    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
> +    VFIOGroup *group;
> +    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +    struct kvm_vfio_spapr_tce param;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_VFIO_GROUP,
> +        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> +        .addr = (uint64_t)(unsigned long)&param,
> +    };
> +
> +    if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> +                &param.tablefd)) {
> +        QLIST_FOREACH(group, &container->group_list, container_next) {
> +            param.groupfd = group->fd;
> +            if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +                error_setg_errno(errp, errno,
> +                        "vfio: failed GROUP_SET_SPAPR_TCE for "
> +                        "KVM VFIO device %d and group fd %d",
> +                        param.tablefd, param.groupfd);
> +                return false;
> +            }
> +            trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> +        }
> +    }
> +    return true;
> +}
> diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
> index 5a489d1b711..78c51b99155 100644
> --- a/hw/vfio/kvm-stubs.c
> +++ b/hw/vfio/kvm-stubs.c
> @@ -6,6 +6,7 @@
>   
>   #include "qemu/osdep.h"
>   
> +#include "hw/vfio/kvm-spapr.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "qapi/error.h"
>   #include "vfio-helpers.h"
> @@ -24,3 +25,10 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>   {
>       return 0;
>   }
> +
> +bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index a9f093c3570..42690e4323d 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -16,6 +16,7 @@
>   #include "system/address-spaces.h"
>   
>   #include "hw/vfio/vfio-container-legacy.h"
> +#include "hw/vfio/kvm-spapr.h"
>   #include "hw/core/hw-error.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> @@ -406,33 +407,10 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
>       vfio_host_win_add(scontainer, section->offset_within_address_space,
>                         section->offset_within_address_space +
>                         int128_get64(section->size) - 1, pgsize);
> -#ifdef CONFIG_KVM
> -    if (kvm_enabled()) {
> -        VFIOGroup *group;
> -        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -        struct kvm_vfio_spapr_tce param;
> -        struct kvm_device_attr attr = {
> -            .group = KVM_DEV_VFIO_GROUP,
> -            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> -            .addr = (uint64_t)(unsigned long)&param,
> -        };
> -
> -        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> -                                          &param.tablefd)) {
> -            QLIST_FOREACH(group, &container->group_list, container_next) {
> -                param.groupfd = group->fd;
> -                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                    error_setg_errno(errp, errno,
> -                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
> -                                     "KVM VFIO device %d and group fd %d",
> -                                     param.tablefd, param.groupfd);
> -                    return false;
> -                }
> -                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> -            }
> -        }
> +    if (kvm_enabled() && !vfio_spapr_kvm_attach_tce(bcontainer, section, errp)) {
> +        return false;
>       }
> -#endif
> +
>       return true;
>   }
>   
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 6c00a7f51bb..bab5f2b7f15 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -10,6 +10,7 @@ vfio_ss.add(files(
>   vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
>   stub_ss.add(files('kvm-stubs.c'))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
> +vfio_ss.add(when: ['CONFIG_KVM', 'CONFIG_PSERIES'], if_true: files('kvm-spapr.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'pci-quirks.c',
>     'pci.c',



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


