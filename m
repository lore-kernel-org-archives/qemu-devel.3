Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC03FC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HNU-0002D7-RA; Tue, 07 May 2024 05:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4HNS-00022C-KU
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:50 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4HNQ-0000ca-F8
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:50 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-36c9c603b1dso6037085ab.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715075087; x=1715679887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDABy5HAOxnzlJ8M2TYozHuK6oLtg1StJK56pYStw4s=;
 b=W7/ghvxE9xvfiRTufGbEE5tjvNKkv5CGTgUh8qcUIg5opR/QFthQvn4MlM5xPCq3uw
 hsIc9SnZgTjDv/5raQudQVPgkO6WL1wMXAFfqJuC7v9o12kInaAlA+Yq0sDA32qhiALs
 xkmMczEtz2MNKnrjbZ00TQgv/L8n8aEk9u9nh6QH/5mkFMoQdV260qVvGfYTBs9GZRb2
 vhIFowAUsHJ5i6OF25ech1qIaQIlFN6uonxevzZqOvW1dV86M5v4UJp/nPpSRBGmdUwb
 T8qumafDiC0tY2mcCrKwM4ynae3bNin8VA7mE77MgdL2cX7ErT72RfyhF32ahjmQRa72
 KUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075087; x=1715679887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDABy5HAOxnzlJ8M2TYozHuK6oLtg1StJK56pYStw4s=;
 b=C3wg6oi0L9oOSd45P1B/NE6sOdQpjsFi96SZAU4eRziEzUAkKW2q9T1MmXg5ODEHvE
 voVReYKRql/B2pywwYYwAyMDzKry5mZ1G0DdrnWTdBWojMIj6FfRMdQgfqpoMh8555nY
 R6QK+pWyJ78JUM2JjoOO15qWjvZeFPbUxmIOM9gwwRLDi3iG1Fy1g2o5LkdRJ32B67rg
 qLarl7GYKPO/9khgY6Taj5/by4sXty5K/r2cSOzhIKwWJB2Mqob2dCtarUS/yGbHhHlb
 VSNk6ZAKzKdMUGITlG2apDTOFJxrdW4I66ZaDJYr/omRA7YsFhCkDb0lj3yljbg6Z1tv
 juqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZhi9Ad0e64fx7CAwuCCt7FRSFE2emFKSTp2s3ev1ekQx0y82oTpzvbnysueFXr8F8JouiUNmoGugzZHzKZDT38QOeMUo=
X-Gm-Message-State: AOJu0Yze6P025RCOEVK6ShYqMy7oVMHzWp8R19G1CE6WJExJXHsdU/Ib
 OBmovwg/V+Uskoif0sbkzhan4TdWXwB4wkvWZEVRH9nxJq0VRiJoJWf3ZEAIfRY=
X-Google-Smtp-Source: AGHT+IGBuqn/T2a9M+Vi8LGaCroRNJVsZ5Qi3/XxRVErCD+x/fxoll4GZ9UemH3YIEB3HuF/1Tzikw==
X-Received: by 2002:a05:6e02:13ad:b0:368:efa4:bdf8 with SMTP id
 h13-20020a056e0213ad00b00368efa4bdf8mr16411027ilo.21.1715075086920; 
 Tue, 07 May 2024 02:44:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a92cd85000000b0036a3e54b6b1sm2625988ilb.13.2024.05.07.02.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:44:46 -0700 (PDT)
Message-ID: <264a1de0-1c1e-44bc-bf9b-f1082b9e0e9a@linaro.org>
Date: Tue, 7 May 2024 11:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] backends: Introduce HostIOMMUDevice abstract
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507092043.1172717-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 7/5/24 11:20, Zhenzhong Duan wrote:
> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
> 
> Introduce .realize() to initialize HostIOMMUDevice further after
> instance init.
> 
> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
> for VFIO, and VDPA in the future.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS                        |  2 ++
>   include/sysemu/host_iommu_device.h | 51 ++++++++++++++++++++++++++++++
>   backends/host_iommu_device.c       | 30 ++++++++++++++++++
>   backends/Kconfig                   |  5 +++
>   backends/meson.build               |  1 +
>   5 files changed, 89 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c


> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> new file mode 100644
> index 0000000000..2b58a94d62
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,51 @@
> +/*
> + * Host IOMMU device abstract declaration
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +
> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> +
> +struct HostIOMMUDevice {
> +    Object parent_obj;
> +};
> +
> +/**
> + * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
> + *
> + * Different type of host devices (e.g., VFIO or VDPA device) or devices
> + * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
> + * can have different sub-classes.
> + */
> +struct HostIOMMUDeviceClass {
> +    ObjectClass parent_class;
> +
> +    /**
> +     * @realize: initialize host IOMMU device instance further.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @opaque: pointer to agent device of this host IOMMU device,
> +     *          i.e., for VFIO, pointer to VFIODevice
> +     *
> +     * @errp: pass an Error out when realize fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +};
> +#endif
> diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
> new file mode 100644
> index 0000000000..41f2fdce20
> --- /dev/null
> +++ b/backends/host_iommu_device.c
> @@ -0,0 +1,30 @@
> +/*
> + * Host IOMMU device abstract
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/host_iommu_device.h"
> +
> +OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
> +                            host_iommu_device,
> +                            HOST_IOMMU_DEVICE,
> +                            OBJECT)
> +
> +static void host_iommu_device_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +static void host_iommu_device_init(Object *obj)
> +{
> +}
> +
> +static void host_iommu_device_finalize(Object *obj)
> +{
> +}

All these stubs call for a QOM interface design instead
of inheritance IMHO. See INTERFACE_CHECK in "qom/object.h".
But maybe I misunderstood this series :)

