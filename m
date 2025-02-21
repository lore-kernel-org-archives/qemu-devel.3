Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438FBC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTs6-0002SJ-2N; Fri, 21 Feb 2025 09:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlTrx-0002R6-I0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlTru-00076o-2Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740147543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIZvGJ9om15Atj2sx3YliQoL+eBXiISi2wgs2MUDwvY=;
 b=IY/kpLa92AlzFkx+3tDb0oiE58ZEUhtN/nHEiwjE0jEVY6fZznEv1O32ncy440lOiPJFmf
 9j6Rp0NrPY29fjnA1Yg4Nr3jccQrzN599tdQx7tQ42xIQPpQLKgulGzXQy1eocJGKJZ6W9
 1Cy9S6F0UgyKODyf9SMwjqYAIgP7Hyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-HaFKm9oANXO5rAffzNxHeA-1; Fri, 21 Feb 2025 09:19:02 -0500
X-MC-Unique: HaFKm9oANXO5rAffzNxHeA-1
X-Mimecast-MFC-AGG-ID: HaFKm9oANXO5rAffzNxHeA_1740147541
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f3bac2944so980214f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147541; x=1740752341;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIZvGJ9om15Atj2sx3YliQoL+eBXiISi2wgs2MUDwvY=;
 b=Xdat2pjYKmCrAxjEA3smR+bj+xtT7GnYNsbBXlDcw9RkHOjME19d7V98/wQs7moxbV
 GHeQY3+e8RYemLOd+U+Xrb+IPkrKKJKSip17OBqwmzEPHyoz7Q+4vnm29wDNj9NxPRvL
 uLTlVAqKd2dbRH5F92nXfGANw2LHIgVl7petuJ8IxzIWneBOo4TveHfKYtMWld45WSw9
 hPj3wyBFYOLIDtIGUIoK+NADl4q63Avyl70JUuxEezg2SY3zbxJupOw7KDrC+YUbd4W5
 sEuf41FG/m0zieFeARgASh0twAlOB7WZfmtuTl3HqcEoucKmdarXA6ALBuuOcjrt0KVP
 aG5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxRJhSNgnSYAeWehLD0eNthIsvTDeNn4eoVKMIFLu67T+xvkYqlznbtZD9g4XKKKo98giDMZSdbUCB@nongnu.org
X-Gm-Message-State: AOJu0YwW5+BavPbltbsMfyzoI+WmxmPcgcZNCNPAHMZMh4ZmgMHPBiti
 1WK0p8KWXkbbtdRyoX6XfA6UAIshRcXQSwhwjLyb2OaGS8KioYJvUAPD3lXFuzRyxODuMvIuvif
 7ZiCT59l4EZORwELEj4tCjwfilCbcly8oSffpcR1xkXsKVLB+FUi8
X-Gm-Gg: ASbGncvA1IZ6gQXIQ0QTAiyE+QoK/pgiYhcTXvjTeP3LiHX0a2asxCMNk5kAv8I9Vn9
 aQlFb+EU7jcgeG+g4VrhJuhUtA8BzG/1jEXwPxLNu7FcggcOwVNRzh8JGWVky6cnzFlk6pyFQkm
 qeQh1O1hIykFVJUE/uXwncSs2O3MS/vza8v/F/tnz9iA+nRdfgu1lfLagZ7mnChNjesZmX5kIpb
 2fwkG8/Rd6W2L4FtoK+2GGoSeY7Wlk8qZXHu+NoVi5AzD3QtDTDsNQEO5k73U1EX1AZbiVAdM+q
 W0Q7fvi6hDmwGP6z8Tbv4I9ANY5p0Rg0DQJwyzN9eYht2MEc7YqoYbh5KhDEx08=
X-Received: by 2002:a05:6000:2:b0:38f:3392:9fd8 with SMTP id
 ffacd0b85a97d-38f6e95f455mr2844838f8f.18.1740147540574; 
 Fri, 21 Feb 2025 06:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtLrlQW55aWDncDkeZiZ6gphXb08mPBfz5rY97AvpAXflRJYikfZc6J9Af0WUikUTHxd5SZQ==
X-Received: by 2002:a05:6000:2:b0:38f:3392:9fd8 with SMTP id
 ffacd0b85a97d-38f6e95f455mr2844789f8f.18.1740147540202; 
 Fri, 21 Feb 2025 06:19:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5d8bsm23512951f8f.70.2025.02.21.06.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:18:59 -0800 (PST)
Message-ID: <6848480a-d588-4b81-a286-4bee983b7831@redhat.com>
Date: Fri, 21 Feb 2025 15:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-12-zhenzhong.duan@intel.com>
 <ba276dfd-fe0a-43ab-90bf-163e1ad76d06@redhat.com>
In-Reply-To: <ba276dfd-fe0a-43ab-90bf-163e1ad76d06@redhat.com>
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



On 2/21/25 1:49 PM, Eric Auger wrote:
> Hi Zhenzhong,
> 
> 
> On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
>> is passed to host to construct nested page table. We need to check
>> compatibility of some critical IOMMU capabilities between vIOMMU and
>> host IOMMU to ensure guest stage-1 page table could be used by host.
>>
>> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
>> does not, then this IOMMUFD backed device should be failed.
> is this 1GB huge page mapping a requiring for SIOV?
>>
>> Declare an enum type host_iommu_device_iommu_hw_info_type aliased to
>> iommu_hw_info_type which come from iommufd header file. This can avoid
> s/come/comes
>> build failure on windows which doesn't support iommufd.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/host_iommu_device.h | 13 ++++++++++++
>>  hw/i386/intel_iommu.c              | 34 ++++++++++++++++++++++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
>> index 250600fc1d..aa3885d7ee 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -133,5 +133,18 @@ struct HostIOMMUDeviceClass {
>>  #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>>  #define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>>  
>> +/**
>> + * enum host_iommu_device_iommu_hw_info_type - IOMMU Hardware Info Types
>> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not
>> + *                                             report hardware info
>> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
>> + *
>> + * This is alias to enum iommu_hw_info_type but for general purpose.
>> + */
>> +enum host_iommu_device_iommu_hw_info_type {
>> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE,
>> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD,
>> +};
>> +
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>>  #endif
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 7709f55be5..9de60e607d 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -39,6 +39,7 @@
>>  #include "kvm/kvm_i386.h"
>>  #include "migration/vmstate.h"
>>  #include "trace.h"
>> +#include "system/iommufd.h"
>>  
>>  /* context entry operations */
>>  #define VTD_CE_GET_RID2PASID(ce) \
>> @@ -4346,6 +4347,39 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>>          return true;
>>      }
>>  
>> +    /* Remaining checks are all stage-1 translation specific */
>> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
>> +        return false;
>> +    }
>> +
>> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE, errp);
>> +    if (ret < 0) {
>> +        return false;
> Can't you simply rely on the check below?
>> +    }
>> +    if (ret != HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>> +        error_setg(errp, "Incompatible host platform IOMMU type %d", ret);
>> +        return false;
>> +    }
>> +
>> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_NESTING, errp);
>> +    if (ret < 0) {
>> +        return false;
>> +    }
> same heere
>> +    if (ret != 1) {
>> +        error_setg(errp, "Host IOMMU doesn't support nested translation");
>> +        return false;
>> +    }
>> +
>> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_FS1GP, errp);
>> +    if (ret < 0) {
>> +        return false;
>> +    }
>> +    if (s->fs1gp && ret != 1) {
> looking in the vtd spec I don't find FS1GP. Is it the same as FL1GP?
I am now looking at spec rev from june 22 and it seems it has been
renamed. So please ignore this comment

Eric
> Maybe I am not looking the correct spec though. Why do you need to check
> both ret and fs1gp
> Even why do you need a member to store the cap? Looks FL1GP can only
> take 0 or 1 value?
>> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>> +        return false;
>> +    }
>> +
>>      error_setg(errp, "host device is uncompatible with stage-1 translation");
>>      return false;
>>  }
> Eric


