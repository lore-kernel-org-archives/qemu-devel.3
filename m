Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D41BC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAuya-00073q-6H; Fri, 02 May 2025 14:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAuyU-00072X-Ir
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAuyR-0007eK-Pk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746209937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDjWZPuYAZ6fL/XWlHDIG5yQLFlDguF16OfoRgLLhtQ=;
 b=PJL1Z8OCep4JrDDJk2mXrcVDdDyck3y2sv3ZYC3+bUbn9WNPpFaa/PXjMY+PQ3MFYKZX+i
 8mxIAVQ8o7nLgP37tugl2hkoapK8W9tftkZfvwN7Lcgep3vxVvZOmpUDqVY+obEnm/VDLn
 Ob5rhKWS3BR3mr3p9uHROwTACTrbB88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-x6QuP_DtPcq-v7rWUsHA1A-1; Fri, 02 May 2025 14:18:54 -0400
X-MC-Unique: x6QuP_DtPcq-v7rWUsHA1A-1
X-Mimecast-MFC-AGG-ID: x6QuP_DtPcq-v7rWUsHA1A_1746209934
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47ae8b206a4so41831231cf.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746209934; x=1746814734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDjWZPuYAZ6fL/XWlHDIG5yQLFlDguF16OfoRgLLhtQ=;
 b=JdvIpdaE70hXxpt828TDhsxQELJfUMKxR4v8g9JxCeG5X12weV2sPjc1nm1K6tvsNG
 VGeW2XEhYzytjW2nkLeos8aLkw7VT5OZgQFPI3fER2OlUHMgDNdD9daWvelydT+fCF3E
 j3nZn7yCyv77y8D7JWvTMA9MxNI7SW9BWSOd/b9JXY1TtngTR+lGOYsNwS0Gw4idGLhp
 FMoRoLSbd1L+8RU6wxef5CzAerLFrRXLbs8/H2IGfa4wuFIalXlW+7vECaVGmjiG8IA+
 JmSV9zDTmZlwjFHutLx9cRKrvp9hks9mjUUOqCH56DAauv4Yjwlpamfgd3noUP429iba
 qpzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX22P1uFJ7XQh4yZyYa5m9KrV+4RTJ8tCzxsx63bV2aBMciXDsNHURrm8xVr4ANbIpG3SCkCpOvvHn3@nongnu.org
X-Gm-Message-State: AOJu0YwhFu+VfZZtrbAVMJ4yyeHIN5TCzXROelXPLYPU+zw0fERpxMs5
 RS52Mit+nuHg8iSALyep3JQogV2pcXnB/d9/Mq5cqEiVUktTeYsUyU9fKE0bd6N9olD1iR6I64Q
 +6Miz3LAPFIoLBO62LyofCG3ik/LndKrOL9mEO/0edwdxpsAeaCS6
X-Gm-Gg: ASbGnct2cYyPDD18+2qyNEKPfVdmc248WwLo5fuvehvKlabLtTHSrENLO3S/tslmLmY
 qpTXlEfFTp5cPJUye8uOBOQ75kj3/b3Gh9wui/wj+sjDvMqGoCtm1tD6S9dfUOu0M6VAziHEfEs
 MRFZpt3XKIER7KjL8xqilS9QzqseUHkzjpAfkCY7OKRAb2Bx9Iqu+Q+9yexS8xXrIBCa93zWGjh
 qZ+sFCJPwRBvDOn11RE5gTg4K5vmjCGfkUuE1ZBB2qh0LXKxhql4J+4X9cshyiI5tpP2RFhspJj
 AvYVVgLSQS7U
X-Received: by 2002:a05:622a:2444:b0:476:8825:99ba with SMTP id
 d75a77b69052e-48c31353328mr56499631cf.12.1746209934092; 
 Fri, 02 May 2025 11:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPeRCXjRVsfQzLvSHRKOwbqqgBOt60MslhJERbAhfvjAL4GFoPiO0WnS03qZDbORstq4yWEg==
X-Received: by 2002:a05:622a:2444:b0:476:8825:99ba with SMTP id
 d75a77b69052e-48c31353328mr56499381cf.12.1746209933799; 
 Fri, 02 May 2025 11:18:53 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b98d0fb2dsm20974591cf.77.2025.05.02.11.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 11:18:53 -0700 (PDT)
Message-ID: <29e1775b-b35d-4510-a3a6-d49af81cca06@redhat.com>
Date: Fri, 2 May 2025 14:18:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
 <aBT9S25tQTVGKkii@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <aBT9S25tQTVGKkii@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/2/25 1:13 PM, Nicolin Chen wrote:
> On Fri, May 02, 2025 at 11:27:03AM +0100, Shameer Kolothum wrote:
>> @@ -43,6 +43,7 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/acpi/tpm.h"
>>   #include "hw/acpi/hmat.h"
>> +#include "hw/arm/smmuv3.h"
>>   #include "hw/pci/pcie_host.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pci_bus.h"
>> @@ -266,6 +267,75 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>>       return idmap_a->input_base - idmap_b->input_base;
>>   }
>>   
>> +struct SMMUv3Device {
>> +    int irq;
>> +    hwaddr base;
>> +    GArray *smmu_idmaps;
>> +    size_t offset;
>> +};
>> +typedef struct SMMUv3Device SMMUv3Device;
> 
> "SMMUv3Device" sounds too general, like coming from smmuv3.h :-/
> 
> Given this describes SMMUv3's IORT node, I still think we should
> name it something like "IortSMMUv3Node" or so.
> 
+1.. the more generic name had me thinking it was broader than IORT..
the IORT-related naming is an improvement.

>> +static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
>> +{
>> +    SMMUv3Device *sdev_a = (SMMUv3Device *)a;
>> +    SMMUv3Device *sdev_b = (SMMUv3Device *)b;
>> +    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->smmu_idmaps,
>> +                                              AcpiIortIdMapping, 0);
>> +    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->smmu_idmaps,
>> +                                              AcpiIortIdMapping, 0);
>> +    return map_a->input_base - map_b->input_base;
>> +}
>> +
>> +static void
>> +get_smmuv3_legacy_dev(VirtMachineState *vms, GArray * smmuv3_devices)
> 
> GArray *smmuv3_devices
> 
> Or maybe align with the non-legacy path, i.e. "sdev_blob"? Or the
> other way around.
> 
> Otherwise, lgtm
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 


