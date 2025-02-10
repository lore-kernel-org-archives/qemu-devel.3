Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5DAC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWVs-0007hO-LF; Mon, 10 Feb 2025 11:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWVo-0007I2-LI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWVm-0002N0-NC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739204393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ekHirI7ltc4uuRS2oNgLGI7+BCPwKVRAVnA+2hZlg6U=;
 b=Pjh7kSPyceYtfoKrtbK+pw6Jfi6WwR5RRvA2ZNYmtpq3bKB50vdBEwR7VmSDUnlkAyS5+q
 iajktNG89T5cvPNErcqOZkF69zjcqMorKjKyKfp1lnc4fbsIBr3My1nlA7gpov4cWQyS8m
 5lYaR3o2nVI1zR333L/x6ESSCCCpsQI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-p-bwtVkgPamQ5TDmLi4kfg-1; Mon, 10 Feb 2025 11:19:52 -0500
X-MC-Unique: p-bwtVkgPamQ5TDmLi4kfg-1
X-Mimecast-MFC-AGG-ID: p-bwtVkgPamQ5TDmLi4kfg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935bcec74so10559415e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204391; x=1739809191;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekHirI7ltc4uuRS2oNgLGI7+BCPwKVRAVnA+2hZlg6U=;
 b=X7vFVYmp+ukLQDBifXe8fV1rv1vUbc1sxecTXCCWPQqzOWK0gg9hqsbdTjVSGGxV/q
 ARc5IvAYOOa4+8ixPRxC6YXRKlfmp3A9ZwKTt+VFup7upODuqaNDBwSjOM4MOxXCe8nY
 tVce061t2HgnoUt/3aJguX3Y9cxaAHR2M8LkwH6/zwNIl9jWNWpbMAZ0PoE0MGWkgOOx
 DsNjgqkIJWj4z1izUwEQCOqC9iCPlniDX/ELvZKfcUGLLoZhsJObdJTfyolFAqJnARLR
 zvy+criLaF4scl6aEHOomMI5VZWAIWTFj4Zr5+HG8HLN8eaHKRgouUPBOQo3JU4hV8XF
 fSKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlYXeFtpK3U/op96TbvqnBl/0+KyrUo4EEaMJB+3tYRlJMwGwyx98ouXiZIh0+L8b8Gsfb4edjAqJO@nongnu.org
X-Gm-Message-State: AOJu0YzYpama5MxVRPySQ2sFbYMBn4YzyfD32CRbYID+ygZ6nYeTa+E3
 iUabnEMMMFEWpKJDHq7+++kjxtFDBSUsARmO7vLiyVFbUsi2gkwhIyVohCAWv/ZHy3+3PCvxPo1
 GnK3i8+fvrKiany8boom7WZP6Arigh0xyeKZUcCfKu/6AlReCkdCV
X-Gm-Gg: ASbGncudTQhaOkLya3Zh/Er7fm7piyKi0mBmGzvSZslpfthHeJxw2hrbhjcZJ/K8R9+
 IAac28EzCUGds+1UXaMZiC4EBWN2lPAfDdNHP7ZugjfUMRpFqMtAo5nyApnaPpgOOtY4BRpbt7N
 G9+fnrzyycXf/mAyT0qdyDbtC9aAxeJtWF0NmkY7DdIHAKU24VArDSv4hdqlDWS78K4nNsTjrvB
 2cJftYMhi7SglqxNzd1jQPwhlwcT+fMrCMugdpxG8iZkkptuU4iwX6h2TEadwvWBOgIG8U7sxdO
 e336S543uVUMequyY2lDpwBedwTWreSfoRzVqZaJvFo=
X-Received: by 2002:a05:600c:511d:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-4394c8461a1mr3371565e9.21.1739204391218; 
 Mon, 10 Feb 2025 08:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExEw3mk7vkd4GVZ2EF6TKETQt8yUR+VtLpAJSMgpKKajfq/2HGsEERHbwIlUp8Yv7Xda6q7Q==
X-Received: by 2002:a05:600c:511d:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-4394c8461a1mr3371445e9.21.1739204390916; 
 Mon, 10 Feb 2025 08:19:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439471bf782sm25139465e9.39.2025.02.10.08.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:19:50 -0800 (PST)
Message-ID: <9ff6b8cb-e30f-4e5e-bd8b-714388e7a7b6@redhat.com>
Date: Mon, 10 Feb 2025 17:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] vfio: Introduce vfio_get_vfio_device()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-5-clg@redhat.com>
 <281482d8-f6db-440f-a892-ad1600e7dc56@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <281482d8-f6db-440f-a892-ad1600e7dc56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/25 15:32, Philippe Mathieu-Daudé wrote:
> On 30/1/25 14:43, Cédric Le Goater wrote:
>> This helper will be useful in the listener handlers to extract the
>> VFIO device from a memory region using memory_region_owner(). At the
>> moment, we only care for PCI passthrough devices. If the need arises,
>> we will add more.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/helpers.c             | 10 ++++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 0c60be5b15c70168f4f94ad7054d9bd750a162d3..ac35136a11051b079cd9d04e6becd344a0e0f7e7 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -252,6 +252,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>   void vfio_detach_device(VFIODevice *vbasedev);
>> +VFIODevice *vfio_get_vfio_device(Object *obj);
>>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 913796f437f84eece8711cb4b4b654a44040d17c..4b255d4f3a9e81f55df00c68fc71da769fd5bd04 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -23,6 +23,7 @@
>>   #include <sys/ioctl.h>
>>   #include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/pci.h"
>>   #include "hw/hw.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> @@ -728,3 +729,12 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>       return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
>>   }
>> +
>> +VFIODevice *vfio_get_vfio_device(Object *obj)
> 
> Can't we take a VFIOPCIDevice argument?

It could be some other VFIO (AP, Plateform) device type and we wouldn't
need to do the cast below in that case.


Thanks,

C.



> 
>> +{
>> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
>> +        return &VFIO_PCI(obj)->vbasedev;
>> +    } else {
>> +        return NULL;
>> +    }
>> +}
> 


