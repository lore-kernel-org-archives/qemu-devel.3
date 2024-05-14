Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5E2C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nwy-0003SD-Rp; Tue, 14 May 2024 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6nwv-0003Rb-8k
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6nwt-0007f4-QK
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715676951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UnUaCPcuoCpmEy7bmqFp5ozHy3RwA2ZgfpPv08ESAM=;
 b=YD5VYPoiU8NN3UlfCvvldq758YYq2B58c3NSV4dkaFeiBBnlBR5HADMHlHktuPTN37+d9d
 3yLIYLi1TcYtxtYSXGghg5TlXRmVChv/kJHnsaHOkRvaqhmXqLgxHmeby96ulJfmA3wL2U
 e/BmJrNQm0vLGqrxQL2WyqOLlAIUTi8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Y5gBCK6GMtK8q1ykHuXUyQ-1; Tue, 14 May 2024 04:55:49 -0400
X-MC-Unique: Y5gBCK6GMtK8q1ykHuXUyQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792ba069a97so771742285a.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 01:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715676949; x=1716281749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UnUaCPcuoCpmEy7bmqFp5ozHy3RwA2ZgfpPv08ESAM=;
 b=pLsKZY/ZEZu082OusvzpQm5v+vGqawU+XvgggvE/jnKQswqBdYtGWlGdAnAaEU+9jA
 6RYTax7d68Ex/DWjQw0Hf72yyUczynL6f2xphC6puIM7HollR/74gB78csnu9RXUxXdA
 99TgkG1di6vhotYUxjHFF+Oo0M6BdddXvmHxFo4pZ3dmvsEgFLOYV6t8/lyL7asUQP8p
 +RqwD0Nm8+Zrov5AK1sfZ5krD+5OZvw/ZQSHKZRFcZO7jgUe5zvwIXjAZ4dCa11/DJa0
 Khtb9tnwjWX+fNaVM6gIEHTmMaT5xnn4J49M0ajvv7iwjVjrXBOfDbZ+3r3g7Te43Zsb
 pxHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVms5blDEO+voDtP3i7bjST6VxNw6lO5JNgt86/LJwXHXYHTqfEXQYsrHi3dCRDb1VHMPMdEjD96KPe/jk8Wk1amLBsMv0=
X-Gm-Message-State: AOJu0Ywf1b75UCx9qtv+c7U3f6Rhhhr49VFzCellb1PfHubryJpuHuWv
 QgpK07mMsmzYktUWkPomvSOjnnF6LjHFNN/JPrqCEY3aXe5CaF9hLflJvix0zS3y6w+bry5jsUq
 LdmKS8syXfzKvXTNCMOHADZ2CgaKTc9SS/zeywJg/SYlNlc+DLwCp
X-Received: by 2002:a05:620a:4543:b0:792:9232:c93f with SMTP id
 af79cd13be357-792c76036d3mr1599951285a.77.1715676948936; 
 Tue, 14 May 2024 01:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECy3mNPm9T984aI5xx3qMm8dt45znAj6p6akPwxZVJB/8kNAI7wqspWTNTBHRbIhqwrYtV7A==
X-Received: by 2002:a05:620a:4543:b0:792:9232:c93f with SMTP id
 af79cd13be357-792c76036d3mr1599949585a.77.1715676948442; 
 Tue, 14 May 2024 01:55:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a4b38sm545871385a.66.2024.05.14.01.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 01:55:48 -0700 (PDT)
Message-ID: <9169d9fb-ef47-45e1-8394-25751f049078@redhat.com>
Date: Tue, 14 May 2024 10:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] vfio: Reverse test on vfio_get_dirty_bitmap()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-7-clg@redhat.com>
 <12989e97-362b-4ef9-9b3d-1f5550e393ac@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <12989e97-362b-4ef9-9b3d-1f5550e393ac@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/13/24 15:42, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
> Title should be: Reverse test on vfio_get_xlat_addr()?

It could.

> 
>> It will simplify the changes coming after.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c..b929bb0b7ac60dcef34c0d5a098d5d91f75501dd 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1224,16 +1224,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>
>>       rcu_read_lock();
>> -    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> -                                    translated_addr);
>> -        if (ret) {
>> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
>> -                         strerror(-ret));
>> -        }
>> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> +        goto out_lock;
>>       }
>> +
>> +    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> +                                translated_addr);
>> +    if (ret) {
>> +        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> +                     "0x%"HWADDR_PRIx") = %d (%s)",
>> +                     bcontainer, iova, iotlb->addr_mask + 1, ret,
>> +                     strerror(-ret));
>> +    }
>> +
>> +out_lock:
> 
> s/out_lock/out_unlock?

yes. better naming.

> 
> With the above,

both done.


Thanks,

C.



> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
>>       rcu_read_unlock();
>>
>>   out:
>> -- 
>> 2.45.0
>>
> 


