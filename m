Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9602C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg4zE-00074X-KE; Thu, 06 Feb 2025 11:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg4zA-0006zH-E4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg4z7-0005Y7-Qm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738860251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJO+sTH+JvPNIYxt4RBcmG5zc5ZBCPAAnh0ES/qJR2s=;
 b=Pr3MoL4rnA1iT5KYex3T8QqMYeYHHXIJSpTSGwbKEtUrSzw8CIYW0MkBgBcuPYhfsfNgZI
 uKgLR8tOrE/12++SNI27xfcvYcGqIWUcI6fNhV0YiTnOBUYqiBfLsqQImbc6loTqY58MdJ
 59YgoKB8tQzP9xuR2eMdyIv7h0EY9Ik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-VDTr92VrOqepOt7qXDWCMQ-1; Thu, 06 Feb 2025 11:44:10 -0500
X-MC-Unique: VDTr92VrOqepOt7qXDWCMQ-1
X-Mimecast-MFC-AGG-ID: VDTr92VrOqepOt7qXDWCMQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so9136085e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 08:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738860249; x=1739465049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJO+sTH+JvPNIYxt4RBcmG5zc5ZBCPAAnh0ES/qJR2s=;
 b=habDL69bcT2SbGAZvJmJLoJgjM/X3H/AurUIvZixJOKVcet5biJsjzWahN8yr38S3e
 EtAHzOtQpkPdRnTKl1K40nGdeZWVh7gGMuROPZdrXLZhzziZ7+640lq1e7Nc7S/xiBVk
 55zkbBtV8/6+He2bEmDoBEn2Ebw4LUsB/AOcWDt/Sak01PL+KXggCEGgLUkl3amezslw
 E3IzOmaKBZdOoyyQ9O4II/DFktBNN60G+jQhn8FcyWHjL4lt/7JAxaH53a7Pg6tf/0mU
 3MYtpcSxJJDgk+kYfsSCYWzLve1pvBZ2qOKVEw1NsJ0vDLNeJQ4XkXlzPjW/hV8GRwUv
 5H8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnydxwYaGzhhJLabfuD4k21kgk4YKCbFcFx8GceiOfzjBfv6u5TXpkZeEbQGZyc1k6YNH8gM8wCiD/@nongnu.org
X-Gm-Message-State: AOJu0YxtsuzFJxGS+yz8syC5dzbpLpDMjeS3q4kRxMKMRlguGZfeVAbo
 ijsCmAun2c+ybKzj03d3ZGltQ0/2/7/cn+oTXE4AQF5Z9rhY7dK/1DLp4YVCwe98XywUVokAsrc
 bReO4R8hAOgE6ysW/aZS2q+2Iuq/hWhsuJEhuCTxNN3oF4VrtaUQk
X-Gm-Gg: ASbGncsvmx1HZ0rnuqthOdBRk4DNeW4uTopXnROUkMqORHjvfldBaBON6pbsUgsahdv
 6yGZjaJdLvjqxTBijtyPWs27leus/CYMH0muuadF5f8ulzJOPKF/W5R8K5YM4VUW9tp/FE3npm+
 cwjFu15XTBUmHnxNHL8Htwg3tPjgov7xgripJuFldhWZpt29Iwy02TY57ba6o0/A20op8BYwcGV
 cjIdl4u+MBlRS/vmgvrwAMhITzBqZQz1K7wurRODigdXmIV09tKeTQlonTtADoY7tgRKTq/bEUD
 n0lQzqGBPbewnUo6Pp0T7y1AIBEw1y2xXAjgIj5COEKdExeTjZpo
X-Received: by 2002:a05:600c:4706:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-4392498d6cemr1202405e9.11.1738860249352; 
 Thu, 06 Feb 2025 08:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDWnGx3JMTLJdjtasMoKz9gYhuXIdOae7fToErfU/5OoLG+MF811t0JiDnq6ZoX+62n5+bUQ==
X-Received: by 2002:a05:600c:4706:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-4392498d6cemr1202095e9.11.1738860248958; 
 Thu, 06 Feb 2025 08:44:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd5c87csm2212774f8f.52.2025.02.06.08.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 08:44:08 -0800 (PST)
Message-ID: <455143f1-db4f-40d0-a2e2-fc983476f76e@redhat.com>
Date: Thu, 6 Feb 2025 17:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com> <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
 <20250131142404.GP5556@nvidia.com>
 <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
 <20250131145411.GR5556@nvidia.com>
 <20039bbc40df453a8a41a863d74b9ff9@huawei.com>
 <c292ab40-3620-4e72-b043-4e3cbd7fd297@redhat.com>
 <Z6R4fXAuNlx12kG9@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z6R4fXAuNlx12kG9@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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




On 2/6/25 9:53 AM, Daniel P. Berrangé wrote:
> On Fri, Jan 31, 2025 at 05:08:28PM +0100, Eric Auger wrote:
>> Hi,
>>
>>
>> On 1/31/25 4:23 PM, Shameerali Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Friday, January 31, 2025 2:54 PM
>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: Daniel P. Berrangé <berrange@redhat.com>; qemu-arm@nongnu.org;
>>>> qemu-devel@nongnu.org; eric.auger@redhat.com;
>>>> peter.maydell@linaro.org; nicolinc@nvidia.com; ddutile@redhat.com;
>>>> Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>>>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>>>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>>>> zhangfei.gao@linaro.org; Nathan Chen <nathanc@nvidia.com>
>>>> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>>>> nested SMMUv3
>>>>
>>>> On Fri, Jan 31, 2025 at 02:39:53PM +0000, Shameerali Kolothum Thodi
>>>> wrote:
>>>>
>>>>>>> And Qemu does some checking to make sure that the device is indeed
>>>>>> associated
>>>>>>> with the specified phys-smmuv3.  This can be done going through the
>>>>>> sysfs path checking
>>>>>>> which is what I guess libvirt is currently doing to populate the
>>>> topology.
>>>>>> So basically
>>>>>>> Qemu is just replicating that to validate again.
>>>>>> I would prefer that iommufd users not have to go out to sysfs..
>>>>>>
>>>>>>> Or another option is extending the IOMMU_GET_HW_INFO IOCTL to
>>>>>> return the phys
>>>>>>> smmuv3 base address which can avoid going through the sysfs.
>>>>>> It also doesn't seem great to expose a physical address. But we could
>>>>>> have an 'iommu instance id' that was a unique small integer?
>>>>> Ok. But how the user space can map that to the device?
>>>> Why does it need to?
>>>>
>>>> libvirt picks some label for the vsmmu instance, it doesn't matter
>>>> what the string is.
>>>>
>>>> qemu validates that all of the vsmmu instances are only linked to PCI
>>>> device that have the same iommu ID. This is already happening in the
>>>> kernel, it will fail attaches to mismatched instances.
>>>>
>>>> Nothing further is needed?
>>> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
>>> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
>>> -device arm-smmuv3-accel,bus=pcie.1,id=smmuv1 \
>> I don't get what is the point of adding such an id if it is not
>> referenced anywhere?
> Every QDev device instance has an 'id' property - if you don't
> set one explicitly, QEMU will generate one internally. Libvirt
> will always set the 'id' property to avoid the internal auto-
> generated IDs, as it wants full knowledge of naming.

OK thank you for the explanation

Eric
>
> With regards,
> Daniel


