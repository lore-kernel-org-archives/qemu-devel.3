Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645CDC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSCY-0007Zy-A7; Wed, 26 Mar 2025 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txSCX-0007ZY-7L
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txSCV-0001qQ-5q
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743001070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvgUxv96I8YzIhQNuavV4Xt77sDQInH/cRNnhI12BVo=;
 b=co2aotub33t/Ipc6vT9XNzsPR9Na4emqhuawE8+zoSDyHkqt2upPAh244IS7FkPl76x4Ea
 NTXwRgoWRyeio66CzFM64zdy34hoinM4afxEXnACL6a/W6i30ndE+SIvIDLM+sOSQR4GPM
 mhFiEJqyibm2cGtxhZsS8KJchTkL+D8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-NOh_aEMwM8O1bXS6zccH2Q-1; Wed, 26 Mar 2025 10:57:47 -0400
X-MC-Unique: NOh_aEMwM8O1bXS6zccH2Q-1
X-Mimecast-MFC-AGG-ID: NOh_aEMwM8O1bXS6zccH2Q_1743001066
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so5505385e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743001066; x=1743605866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvgUxv96I8YzIhQNuavV4Xt77sDQInH/cRNnhI12BVo=;
 b=ui/bE4fvFWEgYOokbKeZUYMcyBOsUkMjlR4JbwZALDoupNi4frXOFUH6aYJsWbkvHz
 vGDKERgKvTMieu45yWSBh1GGTZ6SWU9PpMAXNGPr3iTExLNGPESusGR8STgJXnicQopc
 cjDVZJM7fJVakApoxl+YPob9hS+OiHFiiU+fGnN9TWbhmYJJNPIokwacN/iTMgjucq/+
 FdEiNC0QpHLC6pmblKxcJXw2fzLmw+ybZbgK730yi3mUiHsb+84o4UD9yr+DQBgAUwoE
 GYJSk6RWCffwxHuT38d1xmQXjesTCYH3h4TtSaRiop6NhooprxxEeWnLXL1E97Y48NqP
 ImkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQvjZkRkRi5ZYYmO/9J8ByA7Uho+jG82/8tKYczP2jHn2lV76d3Vkc/TNsWjUcHLmBBAoPG70+FyU+@nongnu.org
X-Gm-Message-State: AOJu0YyM2qf96cLG9FvQQi/R9CYrMmMI5fhKkxFslHpFCMGDFVoa09f3
 IeOcM6p7uejfu9fVK1ZivUgzaSDcMw1RVFgfUMrT8PdVo+5b+Z87LMF6Y6IR85JiX95aI6ZFKol
 zPncFM/OTwTb4uRbwh7xkVLaGeuvvqa5JGKIFsWtnVU7CybfZ2qCZ
X-Gm-Gg: ASbGnctv/lyFwNmfaVzRPOVVnBjnO9MAJVwbDGIoMsMXkTfWVPPpLwsfu2bXjyt3b5J
 KN8gQO7XwJlONaCWbQrFNnEr4uF3DUxUskhWAt3vVss6qA311NqQSF3tWehNeafgvarXg9WuQLR
 WTRu7xau9pxOzHT9Vtyk0Wm8ASTVeppfmPbhkZ0Gdv0bNSKPB6H0LkMX1Na8T3AXuKbxo6PMmol
 rjPaLwJRdWqHK+lvxZchg8x0TJIVk/+d2hh1MFSmOXudiibTwxdOicO9yYIaquA7h5RJ98Zi+Ht
 0AVuOGU8gfR5yzWoUSc+6jHxLLtUrREpx75DTRmGMv17CpMtt2PEkUDTUhIbGLg=
X-Received: by 2002:a05:600c:2152:b0:43b:c305:3954 with SMTP id
 5b1f17b1804b1-43d775be4d0mr28219955e9.8.1743001066006; 
 Wed, 26 Mar 2025 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7b6fAHG598uJAL2SlGe9HBld1G/wqU54RYGAK2+uRUJTx+zESsjvcQQsLfeB8wN64uyOiiw==
X-Received: by 2002:a05:600c:2152:b0:43b:c305:3954 with SMTP id
 5b1f17b1804b1-43d775be4d0mr28219745e9.8.1743001065505; 
 Wed, 26 Mar 2025 07:57:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957aasm17259892f8f.10.2025.03.26.07.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 07:57:44 -0700 (PDT)
Message-ID: <4473e065-1993-4b21-8cba-a4fa30dd6a1d@redhat.com>
Date: Wed, 26 Mar 2025 15:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/20] hw/arm/smmuv3-accel: Read host SMMUv3 device
 info
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-17-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-17-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Read the underlying SMMUv3 device info and set corresponding IDR
> bits. We need at least one cold-plugged vfio-pci dev associated
> with the smmuv3-accel instance to do this now.  Hence fail if it
> is not available.
>
> ToDo: The above requirement will be relaxed in future when we add
> support in the kernel.
Can you give more details about what is missing?
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c         | 104 ++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events           |   1 +
>  include/hw/arm/smmuv3-accel.h |   2 +
>  3 files changed, 107 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 09be838d22..fb08e1d66b 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -15,6 +15,96 @@
>  
>  #include "smmuv3-internal.h"
>  
> +static int
> +smmuv3_accel_dev_get_info(SMMUv3AccelDevice *accel_dev, uint32_t *data_type,
> +                          uint32_t data_len, void *data)
> +{
> +    uint64_t caps;
> +
> +    if (!accel_dev || !accel_dev->idev) {
> +        return -ENOENT;
> +    }
> +
> +    return !iommufd_backend_get_device_info(accel_dev->idev->iommufd,
> +                                            accel_dev->idev->devid,
> +                                            data_type, data,
> +                                            data_len, &caps, NULL);
> +}
> +
> +static void smmuv3_accel_init_regs(SMMUv3AccelState *s_accel)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(s_accel);
> +    SMMUv3AccelDevice *accel_dev;
> +    uint32_t data_type;
> +    uint32_t val;
> +    int ret;
> +
> +    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
> +        error_report("At least one cold-plugged vfio-pci is required for smmuv3-accel!");
> +        exit(1);
> +    }
> +
> +    accel_dev = QLIST_FIRST(&s_accel->viommu->device_list);
> +    if (accel_dev->info.idr[0]) {
> +        info_report("reusing the previous hw_info");
> +        goto out;
> +    }
> +
> +    ret = smmuv3_accel_dev_get_info(accel_dev, &data_type,
> +                                    sizeof(accel_dev->info), &accel_dev->info);
> +    if (ret) {
> +        error_report("failed to get SMMU device info");
> +        return;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_report("Wrong data type (%d)!", data_type);
> +        return;
> +    }
> +
> +out:
> +    trace_smmuv3_accel_get_device_info(accel_dev->info.idr[0],
> +                                       accel_dev->info.idr[1],
> +                                       accel_dev->info.idr[3],
> +                                       accel_dev->info.idr[5]);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, BTM);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, BTM, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ATS);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ASID16);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, TERM_MODEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STALL_MODEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STLEVEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SIDSIZE);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, val);
> +    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SSIDSIZE);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, HAD);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, val);
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, RIL);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, BBML);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN4K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN16K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN64K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, OAS);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, val);
Are all those ID regs mandated? I would suggest to have props with
default values that can be overriden. Once we get a VFIO device plugged
we could check whether there is an incompatibility.

> +
> +    /* FIXME check iidr and aidr registrs too */
not, capital letters for regs and registrs typ

> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> @@ -484,11 +574,25 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>      bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
>  }
>  
> +static void smmuv3_accel_reset_hold(Object *obj, ResetType type)
> +{
> +    SMMUv3AccelState *s = ARM_SMMUV3_ACCEL(obj);
> +    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s);
> +
> +    if (c->parent_phases.hold) {
> +        c->parent_phases.hold(obj, type);
> +    }
> +    smmuv3_accel_init_regs(s);
> +}
> +
>  static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>      SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_CLASS(klass);
>  
> +    resettable_class_set_parent_phases(rc, NULL, smmuv3_accel_reset_hold, NULL,
> +                                       &c->parent_phases);
as Don mentionned this shall be exit now anyway

Eric
>      device_class_set_parent_realize(dc, smmu_accel_realize,
>                                      &c->parent_realize);
>      dc->hotpluggable = false;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cd2eac31c2..c7a7e58291 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -62,6 +62,7 @@ smmu_reset_exit(void) ""
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
>  smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
> +smmuv3_accel_get_device_info(uint32_t idr0, uint32_t idr1, uint32_t idr3, uint32_t idr5) "idr0=0x%x idr1=0x%x idr3=0x%x idr5=0x%x"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index 58e68534c0..9e30d7d351 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -52,6 +52,7 @@ typedef struct SMMUv3AccelDevice {
>      SMMUViommu *viommu;
>      SMMUVdev   *vdev;
>      AddressSpace as_sysmem;
> +    struct iommu_hw_info_arm_smmuv3 info;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
> @@ -68,6 +69,7 @@ struct SMMUv3AccelClass {
>      /*< public >*/
>  
>      DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
>  };
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */


