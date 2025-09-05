Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07189CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuS8s-0007Lc-9y; Fri, 05 Sep 2025 04:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuS8i-0007Ig-N9
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuS8d-0001Lr-22
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757062179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66e5B7zvSFLQHnxFRBirIlHQsN7RL6vMUZZe+5Ont50=;
 b=gjhW3GqKr/8zow/qTWMxLHmR5l+nEVyMY1LD/zgGDgJvWjvh5ZDzGxLtGsP+FWBRWiqFYv
 fhDMSdyF5/R5R9L/e+SkrlFbdc2yRXfNWET56ZfjkiIq+R6u8dhW4/gpXAAfMEJZkSXXWV
 fQ8UXGyk/ShygffpLqVI95LghgU6qyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nrV-VhZ4MLafGRADHHm9gA-1; Fri, 05 Sep 2025 04:49:38 -0400
X-MC-Unique: nrV-VhZ4MLafGRADHHm9gA-1
X-Mimecast-MFC-AGG-ID: nrV-VhZ4MLafGRADHHm9gA_1757062177
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e424a186fcso178418f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757062177; x=1757666977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=66e5B7zvSFLQHnxFRBirIlHQsN7RL6vMUZZe+5Ont50=;
 b=gWYvxW31pm7CRlAbjp3dayxYO01KDs/NXWVVvrVqj7y0Q4+vkBh19G6wJBs2QfG0u8
 BqRlCFututUJsjPBpvp8yd9kuUMnIWaGzwJKjnQRUtLfX129USBDnwmDYq810Ed3vzXq
 wIS/GSHHLWSRraAvXkYsxhel7JCpDvXJuq7kENucXDLARqX050BODQ/JPqNCZ4eUHhwX
 P/CU5wnRxz3sBJJ7WQZVsPbhtkE7Bw6CzSZkLfMW/ynpSh2t+6ISsu+4ie8HHW3Hi5w2
 ezEEIcsGJN9JOaCNn2vEhS19w5nknocOMjVW/aseiaIgwleVWbOYGNDhWD8SjfhCXkL3
 iVaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqEtTB4T+PPfjHWWv/CXKLrScC3RlBtZfZQts3PjfSphKeU6wu6+KATXNTbcpy61bqzcRu5U3gKOBY@nongnu.org
X-Gm-Message-State: AOJu0Yye63rrmmC9zOHZ92GroCMNyqcOBrhmFpiWGFr64jL5JsYx9uBO
 Rw1I0xcC/ihdx2riaYEHZk9agjk77tveXLsiykC8Z3JtDbGsSlwO+qW/z85z22akAbPHXsnHhlW
 7TAFaOpnnv5M+SoSGutrfuagrUpMNLwPxjsQTTsVdXAyoivsE9MZJFT6L
X-Gm-Gg: ASbGncvawSfjqxE+6nZxwSXKYurKgij8jVtuuyhsNEV9Vq+P/HX20og4aXvJQoatQXI
 IlWTjeC8Afwlosy8kJxaZ0X5HSAg/dEZIkJqKn7Beku1Petk7SH774hFLvD2lyBBpD7ScV+9RsU
 UPfY/HGZz66SlolBAcqNtsaeROKxjXbhkLyDv6nS06sEs7sfMZvMh7oFOa12k7e2UasR0ozUXcX
 lpBoYsLb3om09QUqdIRrtk4hDkdS4B/ilYalB4gZeUsDFDC7tAHr1tK4ispE4D8UGyS9wsD9vhK
 Ie/LAUFCvkXNe2OWY2p+hsJ/LZZeC9ZUP9VaPfrwym6EadEY+C6TecAfX17KRd00NVzPBcReFaj
 ChaWdTrf3qdg=
X-Received: by 2002:a05:6000:1887:b0:3e2:4a3e:d3cf with SMTP id
 ffacd0b85a97d-3e24a3ef8a9mr3609682f8f.5.1757062176639; 
 Fri, 05 Sep 2025 01:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjfSgfUWunXZYrQGkFKNoLx5I9ZoNnZfHKUCbzmpIxoKVO6QZE0MCAg8LAK2Uss/T2uYGKJg==
X-Received: by 2002:a05:6000:1887:b0:3e2:4a3e:d3cf with SMTP id
 ffacd0b85a97d-3e24a3ef8a9mr3609656f8f.5.1757062176154; 
 Fri, 05 Sep 2025 01:49:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d701622b92sm19391101f8f.58.2025.09.05.01.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 01:49:34 -0700 (PDT)
Message-ID: <b13d3596-1498-462d-ab2c-1a626f050dbe@redhat.com>
Date: Fri, 5 Sep 2025 10:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, skolothumtho@nvidia.com
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> For accelerated SMMUv3, we need nested parent domain creation. Add the
> callback support so that VFIO can create a nested parent.
>
> Since 'accel=on' for SMMUv3 requires the guest SMMUv3 to be configured
> in Stage 1 mode, ensure that the 'stage' property is explicitly set to
> Stage 1.
nit: strictly speaking couldn't we have a stage2 being used at guest
level implemented by a stage1 at physical level?
but it is totally fair to restrict the support.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c | 15 +++++++++++++++
>  hw/arm/virt.c         | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 0b0ddb03e2..66cd4f5ece 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -10,6 +10,7 @@
>  #include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/iommu.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/vfio/pci.h"
> @@ -81,8 +82,22 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static uint64_t smmuv3_accel_get_viommu_cap(void *opaque)
> +{
> +    /*
> +     * Accelerated smmuv3 support only allowes Guest S1
> +     * configuration. Hence report VIOMMU_CAP_STAGE1
> +     * so that VFIO can create nested parent domain.
> +     * The real nested support should be reported from host
the actual nested support at host level will be queried from the host
later on?
> +     * SMMUv3 and if it doesn't, the nested parent allocation
> +     * will fail anyway.
> +     */
> +    return VIOMMU_CAP_STAGE1;
> +}
> +
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
> +    .get_viommu_cap = smmuv3_accel_get_viommu_cap,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 22393cf39e..fdb47eda6a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3053,6 +3053,18 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                  return;
>              }
>  
> +            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +                char *stage;
> +
> +                stage = object_property_get_str(OBJECT(dev), "stage",
> +                                                &error_fatal);
> +                if (*stage && strcmp("1", stage)) {
I am not sure you need to check *stage
> +                    error_setg(errp, "Only stage1 is supported for SMMUV3 with "
> +                               "accel=on");
> +                    return;
> +                }
> +            }
> +
>              create_smmuv3_dev_dtb(vms, dev, bus);
>          }
>      }
Thanks

Eric


