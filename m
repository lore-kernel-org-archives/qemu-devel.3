Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEBFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOr3-0004LM-26; Tue, 04 Jun 2024 03:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEOr1-0004L6-7y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEOqy-0007YC-N4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717487107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvhHV7qP5nr1AHosLpAk/J0Rc30B5KPr//dMoQl920w=;
 b=f7v1IugsvWs2rgRCDk1deFnQT+XUe2nspxD9QrWEKt1FpEzcxnMxt9nSCAu48g+Kd+1taB
 l9vWgeRPkdKm4zngB4E2K2hoLGp2WGL+YNWvXa5+1TyghUtZwpajTVF6YRgx+KuERJVSvB
 VjTj3ntGzrRVjICvSV435SNTiH9AqXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-os5lUh2SOs-ZH2WYeGXctw-1; Tue, 04 Jun 2024 03:45:03 -0400
X-MC-Unique: os5lUh2SOs-ZH2WYeGXctw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso21498455e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717487102; x=1718091902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvhHV7qP5nr1AHosLpAk/J0Rc30B5KPr//dMoQl920w=;
 b=lGWGqslpuA66nZbqlvXwKeARDtHHVhXyPy7BhNPxu4+9Djo0Qlw8NPK7+Iq0kG4iYT
 UeYAa0bnh5IqNNrNfHT+s/DlMGmt32QLHSBwdPeq3cdN8CNNngJKYhouBVU3w2Bc5lmA
 SjdOlONLoFNnF4mhnDDjehTEDT7GFjQ314ldG8Iz7qLYGz8Mscq43Zdz/sh0AIKrsUEi
 AaLWpUOStjVfq/MMyYz5n5EqfAyeBT1H42Hd9igTQIJWheWO2kSXDHntKte0DT3unSL/
 +CWi0Bpz6JOlsTJBmucMuanwAO85gD3TnQLparXN6JJ/VEwT5WLavmKxf3S3Mfex8SIR
 rBDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf+GCi+rbJZMEA4P9/FJje44nDKM0XC5bLnPSc8Ay0bPGtKpq21+x6ahsNWBFhhfPjiapeeVG1NAszZowq3xcmNNwp3Ak=
X-Gm-Message-State: AOJu0YyyisUKxtrmwIGsxxH0kcj6GBODcbmKQl71bM9ub3lnDhcXUAfi
 RZE4/Jj5/KPk18mEkfG8NOCa6vIpUGxDgpFPtYgtcOuZcNYbQA4yjWOz0B+/dbPjxF8yQ11S7lb
 zwxgT8NiAnkVY0xocUccBT1gXayL9wd5xlcCFs9Rn5dc4J51hz7xN
X-Received: by 2002:a05:600c:524f:b0:421:494c:9e92 with SMTP id
 5b1f17b1804b1-421494ca326mr16197335e9.14.1717487102672; 
 Tue, 04 Jun 2024 00:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmeu+G9zGEr8If3orBlCm075lS/5phedCxToKZjrTa7CSLtI7NJZVjDHkiqfJXadSrppGkQ==
X-Received: by 2002:a05:600c:524f:b0:421:494c:9e92 with SMTP id
 5b1f17b1804b1-421494ca326mr16197145e9.14.1717487102228; 
 Tue, 04 Jun 2024 00:45:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cc0b6sm10623165f8f.44.2024.06.04.00.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:45:01 -0700 (PDT)
Message-ID: <a677709e-0bd8-4fa7-aa81-34bc5eb90648@redhat.com>
Date: Tue, 4 Jun 2024 09:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-8-zhenzhong.duan@intel.com>
 <1a188365-7101-472d-adfb-89a74dab055b@redhat.com>
 <SJ0PR11MB674405457470C87189BE09CA92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674405457470C87189BE09CA92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 6/4/24 04:45, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 07/19] vfio/container: Implement
>> HostIOMMUDeviceClass::realize() handler
>>
>> Hi Zhenzhong,
>>
>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>> Utilize range_get_last_bit() to get host IOMMU address width and
>>> package it in HostIOMMUDeviceCaps for query with .get_cap().
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/container.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index c4fca2dfca..48800fe92f 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -1136,6 +1136,31 @@ static void
>> vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>>>      vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>>>  };
>>>
>>> +static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void
>> *opaque,
>>> +                                     Error **errp)
>>> +{
>>> +    VFIODevice *vdev = opaque;
>>> +    /* iova_ranges is a sorted list */
>>> +    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
>>> +
>>> +    /* Only support query HOST_IOMMU_DEVICE_CAP_AW_BITS with
>> legacy backend */
>> I don't get the comment as HOST_IOMMU_DEVICE_CAP_AW_BITS support
>> seems
>> to be introduced in [PATCH v6 11/19] backends/iommufd: Implement
>> HostIOMMUDeviceClass::get_cap() handler
> Sorry about my poor English, I mean legacy backend only support
> HOST_IOMMU_DEVICE_CAP_AW_BITS, no other caps.
> May be only:
>
> /* Only support query HOST_IOMMU_DEVICE_CAP_AW_BITS */
no problem. Then I would put this comment in the commit msg instead.
Something like "the realize function populates the capabilities. For now
only the aw_bits caps is computed".


>
>>> +    if (l) {
>>> +        Range *range = l->data;
>>> +        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
>>> +    } else {
>>> +        hiod->caps.aw_bits = 0xff;
>> why this value?
> 0xff means no limitation on aw_bits from host side. Aw_bits check
> should always pass. This could be a case that an old kernel doesn't
> support query iova ranges.
>
> Will add a define like:
>
> #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX 0xff
Wouldn't 64 bits be a better choice? Also maybe add a comment explaining
that iova_ranges may be void for old kernels that do not support the query?

Eric
>
> Thanks
> Zhenzhong
>
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>>> +
>>> +    hioc->realize = hiod_legacy_vfio_realize;
>>> +};
>>> +
>>>  static const TypeInfo types[] = {
>>>      {
>>>          .name = TYPE_VFIO_IOMMU_LEGACY,
>>> @@ -1144,6 +1169,7 @@ static const TypeInfo types[] = {
>>>      }, {
>>>          .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
>>>          .parent = TYPE_HOST_IOMMU_DEVICE,
>>> +        .class_init = hiod_legacy_vfio_class_init,
>>>      }
>>>  };
>>>
>> Thanks
>>
>> Eric


