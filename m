Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747CDC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPG5-0005Iw-N8; Tue, 04 Jun 2024 04:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPG3-0005Hw-UN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPG2-0000kh-9G
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717488661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbE+s9OyPIw9zsDw1kedZAk+TUKcPlIGDOGi0oyYE7o=;
 b=Uq2FsCLNSz24lnDWPsKv+axSFUoog8Z+L2Zw0OeQSyvEGK9q+n3l+FJmhMgAR+FpakGnVh
 KMTLlVY/91le2/V1tbmSiejvUxrFcFKwM1LzLCsFNcEuHuARolHo3NIGdf/HzmL8l59G1I
 V2EiTVt0Wipx7W3mLePO0k2Ekyel8yI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-bJazV9HxPLO26d3JaQ48tg-1; Tue, 04 Jun 2024 04:11:00 -0400
X-MC-Unique: bJazV9HxPLO26d3JaQ48tg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2eaa7dfc983so19674961fa.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 01:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717488658; x=1718093458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbE+s9OyPIw9zsDw1kedZAk+TUKcPlIGDOGi0oyYE7o=;
 b=jEVSoSNpEli5J8slGM5jMUwp93ocjj/FBlbuW2W4S0HBt5y79K5soXRmf1ITYPe0AW
 LWnrDhSqlDIgFJ7FdOWQM0CLpMPwdF3YWKd3km0vHP5wOUgx16HBNg7vNE8bY8o+56KK
 V+KVq0dh+tqB1scs1TkROA3WLTH6WDmPYV1C431w9JQj9TPWyVXXGaNn/kO3TROLhdWF
 +tuWwmHde7vG169V4i5J++wdHAhF6cXnOjIKuozxev8U/TyP/ikiOfUhzkxKsPVSMj4i
 +5m99WvmiY9Qo4FUdfQvWx2DbijwgyO8eKLr1HV1LKRngqmlfBGbxBcWcq5sQvT17xYm
 l5oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGHSiloLWbmZRx2woubRlC0mjvTKZBAtl8R6yKr1crY303pRdLOk1iEYyiPzBmY6Ogse8nIDfQ3sicYRhi8Fo5uVp43S8=
X-Gm-Message-State: AOJu0YxMWRYKtp7Yaegw4diBgl2BGC1gQ1yNNZLJBfZ10p6T7iIsXYuK
 EhM2gGWKKgRdRoVcSjsjXN3DhpAlsvrlWzLCKq16CZCt8LyIDEmklvbu5s6zfWqwj/jnCl86Ddm
 u9N0YUeZKmzZ2Uy2r1hteRKXDvI9p25j/9e6yMCSChnZ/SnGFX2YF
X-Received: by 2002:a2e:88d8:0:b0:2e0:14bd:18f2 with SMTP id
 38308e7fff4ca-2ea951d563bmr67137411fa.47.1717488658631; 
 Tue, 04 Jun 2024 01:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm+pGnRcLysqX9bCW0JwdsbZVmaQ8mTTLWX/w+86T3C7KmaT1JBZkO4DDqhmF2SUph0isTIg==
X-Received: by 2002:a2e:88d8:0:b0:2e0:14bd:18f2 with SMTP id
 38308e7fff4ca-2ea951d563bmr67137261fa.47.1717488658241; 
 Tue, 04 Jun 2024 01:10:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d96f6sm10794048f8f.61.2024.06.04.01.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 01:10:57 -0700 (PDT)
Message-ID: <175f9e2d-8ade-4e44-a7bd-d8c7a4c85378@redhat.com>
Date: Tue, 4 Jun 2024 10:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
 <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
 <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
 <SJ0PR11MB6744B71456C0686F70F023C892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744B71456C0686F70F023C892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 6/4/24 05:23, Duan, Zhenzhong wrote:
> Hi Cédric, Eric,
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
>> HostIOMMUDeviceClass::get_cap() handler
>>
>> On 6/3/24 13:32, Eric Auger wrote:
>>>
>>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>   backends/iommufd.c | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index c7e969d6f7..f2f7a762a0 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -230,6 +230,28 @@ bool
>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>>       return true;
>>>>   }
>>>>
>>>> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap,
>> Error **errp)
>>>> +{
>>>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>> +
>>>> +    switch (cap) {
>>>> +    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>>>> +        return caps->type;
>>>> +    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>>> +        return caps->aw_bits;
>>>> +    default:
>>>> +        error_setg(errp, "Not support get cap %x", cap);
>>> can't you add details about the faulting HostIOMMUDevice by tracing the
>>> devid for instance?
>> yes.
> devid isn't added to make this series simpler.
> It's added in nesting series, https://github.com/yiliu1765/qemu/commit/5333b1a0ae03b3c5119b46a1af786d199f103889
>
> Do you want to add devid in this series for tracing purpose or adding trace in nesting series is fine for you?

what would be nice is to get a common way to identify a HostIOMMUDevice,
can't we use the name of the VFIO/VDPA device? devid does not exist on
legacy container. At least a kind of wrapper may be relevant to extract
the name.

Eric
>
>>> I would rephrase the error message into No support for capability 0x%x
>> I was going to propose "Unsupported capability ..."
> Sounds better, will do.
>
> Thanks
> Zhenzhong
>


