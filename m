Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E111EC47BE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4u0-0005zR-GO; Tue, 06 Jan 2026 06:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd4ty-0005yv-Lo
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd4tw-0000Xc-55
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767697618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voyuBBx65BkCSnO96WQJn4n/Lo4E1Le+Ia/zHeJKm2U=;
 b=FjnwxkJiFBXeVVj3MpYWsnoG0mdZ8zNzZDyCQjxL2gPLfqcb7q7IUIZunTnp+GfcD/I+rf
 oXRC4K++aOw5Lgdy7RVhE3CImF2AohST/gUnTeLnVwD6PBXBOPZgTb5N+pI8EM0jMvPDI8
 EvCeh2oHsbEHPFI5xyJ+5njzAbO5yPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-QJexyNNcP9aDQ5F1zGMyHw-1; Tue, 06 Jan 2026 06:06:55 -0500
X-MC-Unique: QJexyNNcP9aDQ5F1zGMyHw-1
X-Mimecast-MFC-AGG-ID: QJexyNNcP9aDQ5F1zGMyHw_1767697614
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so7676795e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 03:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767697614; x=1768302414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voyuBBx65BkCSnO96WQJn4n/Lo4E1Le+Ia/zHeJKm2U=;
 b=TU4F0KvL1M8lJorf8445HAVSGTmCwPT/q5IC+DuaZvppgMDJu/QvghwSeS4Zs6i+1o
 E5i22L6wCLo4zuknjpquH+nLSzMOw+zSZMsIL1z1ZnDA8oBXhoCRTE0dUEIXTI0rize/
 EbQQrR/99bDYk8fnmR1MOOMc//bkEg4Co9xtmlis6EzQVDKZH7n0A3HyUpoVPrnVzfeS
 qa1zkbnI/aTCM7s8yFgrdeT9irF1B63ryfycJy4RpZV+jAZQmTVpjTFpAkP1OFrBXTCE
 memXyu173vxy4GyMWf2W7CLTvrKg87SJwG/0LBevFbfjYfITZk0r4U+9/pQubrPSMwQi
 N6Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU637v+mQVmvY72HKbAafXzv2wnngJ193BFZybndiLgLLaNsPQ8tNZqYjpInt+JNkqHBR4mg7yL3AYs@nongnu.org
X-Gm-Message-State: AOJu0YwV9Gjh+Cfv/qhinR0BaUfZIzueJQAMigoMT17aF/Wk17W/qiRD
 wOTBovKVZT3Vr+97BONVkLLdT2bU7BftHERgXfBiksFLGraw1TgXjNhzXgBdsu1vSwJBOM3nyQo
 n+Z+RPzykrJZpZktbQZsfhez+DRtDucG0pcT0rPfuu/bBTD7HcZKOMfjn
X-Gm-Gg: AY/fxX5axKNDf4S8McsYQkfVQiOoT69/Jp5YIh5vo+cuMVBiyqyc5QW9daKElzLkqF4
 AlGqNkOciT+JrPxw+ku+rgwvEJW6z2ldvvWTpfQX223G50Aa7v4Z8mrBCHRQ0jSiD0J/8cqUgIW
 3opYxheLWP1le4rcNkJbaMNiTB+XEO/iQc5o/+bnsgFT9Vf3inKsNvvsV78vbTGUtEL+ftGKC/O
 sM4G0VTZtIRoPp0z2wjYQ5W9PkDKczD/8iaHp0XMQFO/aDnrT+/YW1gGhq3Q+sAq1IZNS55ObcT
 2Y25U7zZs5aMy+Q79MtmlAOpgXrNHP1WnCyhWOhoxb/djUjZoEHp8dVNF8esOHFrzOloiOtrgbl
 llF94tY01YDlbCdy/TXRMbg6+ywpN13eWmtVqFE6dkXomzkEREKfnUWfnKw==
X-Received: by 2002:a05:600c:848c:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47d7f075bb8mr33925815e9.16.1767697614322; 
 Tue, 06 Jan 2026 03:06:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5ulg3oXxX4pg4zWvaFFrESLs/jdKFcH2VeTEvsj/Oup0it3eR1sgAjIdXIeXicNDVgMYQ+A==
X-Received: by 2002:a05:600c:848c:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47d7f075bb8mr33925325e9.16.1767697613808; 
 Tue, 06 Jan 2026 03:06:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8384646fsm1155195e9.15.2026.01.06.03.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 03:06:53 -0800 (PST)
Message-ID: <0b0f6b2d-a70b-406d-86bd-00588b6570c9@redhat.com>
Date: Tue, 6 Jan 2026 12:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <52dc1984-da99-47bc-87f4-cc29cbe6b749@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <52dc1984-da99-47bc-87f4-cc29cbe6b749@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 12/11/25 3:03 PM, Cédric Le Goater wrote:
> On 11/20/25 14:21, Shameer Kolothum wrote:
>> Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
>> translation (Guest Stage-1, Host Stage-2). In this mode the guest’s
>> Stage-1 tables are programmed directly into hardware, and QEMU should
>> not attempt to walk them for translation since doing so is not reliably
>> safe. For vfio-pci endpoints behind such a vSMMU, the only translation
>> QEMU is responsible for is the MSI doorbell used during KVM MSI setup.
>>
>> Add a device property to carry the MSI doorbell GPA from the virt
>> machine, and expose it through a new get_msi_direct_gpa PCIIOMMUOp.
>> kvm_arch_fixup_msi_route() can then use this GPA directly instead of
>> attempting a software walk of guest translation tables.
>>
>> This enables correct MSI routing with accelerated SMMUv3 while avoiding
>> unsafe accesses to page tables.
>>
>> For meaningful use of vfio-pci devices with accelerated SMMUv3, both KVM
>> and a kernel irqchip are required. Enforce this requirement when
>> accel=on
>> is selected.
>
> There are multiple changes in one patch. I suggest splitting.
>
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 10 ++++++++++
>>   hw/arm/smmuv3.c         |  2 ++
>>   hw/arm/virt.c           | 22 ++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  1 +
>>   4 files changed, 35 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 65b577f49a..8f7c0cda05 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -392,6 +392,15 @@ static void
>> smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>>       }
>>   }
>>   +static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void
>> *opaque, int devfn)
>> +{
>> +    SMMUState *bs = opaque;
>> +    SMMUv3State *s = ARM_SMMUV3(bs);
>> +
>> +    g_assert(s->msi_gpa);
>> +    return s->msi_gpa;
>> +}
>> +
>>   /*
>>    * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
>>    * endpoints can sit downstream. Accelerated SMMUv3 requires a
>> vfio-pci
>> @@ -496,6 +505,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>       .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>>       .set_iommu_device = smmuv3_accel_set_iommu_device,
>>       .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>> +    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>>   };
>>     /* Based on SMUUv3 GPBA.ABORT configuration, attach a
>> corresponding HWPT */
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 42c60b1ec8..f02e3ee46c 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
>>        * Defaults to stage 1
>>        */
>>       DEFINE_PROP_STRING("stage", SMMUv3State, stage),
>> +    /* GPA of MSI doorbell, for SMMUv3 accel use. */
>> +    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>   };
>>     static void smmuv3_instance_init(Object *obj)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 25fb2bab56..ea3231543a 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -3052,6 +3052,14 @@ static void
>> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>               /* The new SMMUv3 device is specific to the PCI bus */
>>               object_property_set_bool(OBJECT(dev), "smmu_per_bus",
>> true, NULL);
>>           }
>> +        if (object_property_find(OBJECT(dev), "accel") &&
>> +            object_property_get_bool(OBJECT(dev), "accel",
>> &error_abort)) {
>> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
>> +                error_setg(errp, "SMMUv3 accel=on requires KVM with "
>> +                           "kernel-irqchip=on support");
>> +                    return;
>
> Couldn't these checks be done in the "smmuv3-accel" model realize
> handler instead ? 
currently smmuv3-accel has no kvm adherence. If you look at virt machine
code, there are quite a lot of similar checks for various other devices
so it does not strongly shock me. Nevertheless I have no strong opinion.

Thanks

Eric  
>
>  
>> +            }
>> +        }
>>       }
>>   }
>>   @@ -3088,6 +3096,20 @@ static void
>> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>               }
>>                 create_smmuv3_dev_dtb(vms, dev, bus);
>> +            if (object_property_find(OBJECT(dev), "accel") &&
>> +                object_property_get_bool(OBJECT(dev), "accel",
>> &error_abort)) {
>> +                hwaddr db_start;
>> +
>> +                if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
>> +                    /* GITS_TRANSLATER page + offset */
>> +                    db_start = base_memmap[VIRT_GIC_ITS].base +
>> 0x10000 + 0x40;
>> +                } else {
>> +                    /* MSI_SETSPI_NS page + offset */
>> +                    db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
>> +                }
>> +                object_property_set_uint(OBJECT(dev), "msi-gpa",
>> db_start,
>> +                                         &error_abort);
>
> IIRC, this plug handler is called after the device realize handler
> and setting properties after realize is strongly discouraged.
>
> C.
>
>> +            }
>>           }
>>       }
>>   diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index e54ece2d38..5616a8a2be 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -67,6 +67,7 @@ struct SMMUv3State {
>>       /* SMMU has HW accelerator support for nested S1 + s2 */
>>       bool accel;
>>       struct SMMUv3AccelState *s_accel;
>> +    uint64_t msi_gpa;
>>   };
>>     typedef enum {
>


