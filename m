Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E26C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkQM-0002WA-8F; Wed, 24 Jan 2024 16:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSkQD-0002Ve-Qc
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:04:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSkQA-0001OE-69
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706130266;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzumg2ibmjGB8BsT1tRBbbHW7FHEV7ESfyDIgA5MVVY=;
 b=KJCeklE/IMSZhmfL9Iiz2RGHgbIQthdEiL3f9mIsIcnWs9jbp8SwUzKsNt8w3I5KJD+vX7
 1W8IyNA2UmU2oVD+8XhFVvAbxdOG6iS6t7e1CPEY9VXqsEk97qleKzhnAPRT6/8fQIhI/1
 Tt8bsbcssiu02jBC6hDMCYAol+RZexE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-wsPJCeOmPyWgZ7N_7qMk-A-1; Wed, 24 Jan 2024 16:04:25 -0500
X-MC-Unique: wsPJCeOmPyWgZ7N_7qMk-A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-781720619f9so895450085a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130264; x=1706735064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzumg2ibmjGB8BsT1tRBbbHW7FHEV7ESfyDIgA5MVVY=;
 b=ZLOA1G6zL2hC18Io5ssYfNY8AlUErny3rm49y8pUY1bXM8+D1nwgDDBi0NQZ/E0CaM
 Bkn2wfw9TsjFxyV+ZoOEtYYr2RP1JFKSx65fYjG1C7RNtCDn4H2ka9a2JOt/2Sc6ol+6
 UDil+e/jVl5pX+7gaISLM/d5HynJrnUZDTiDNAnES35HNb3PQZx4meOiFL0a6mJ66cNu
 e0/uELpaZHozNSXEddI/YImGMYcZITZj1oLGwuSq5JJ6uqTyTHZ7TdTLXCTFqo/55jds
 PsG5t1PIbpwlOupiUieRIPjNHDZJWvCzGtGlYkVfhHjk4cQ6ok8Uy+BYOL1yA7TWeZd9
 rspw==
X-Gm-Message-State: AOJu0Yxa2fc6yZdMT1ycw7GgaJ6hgauihTOz4UGORiFPe7Pm83HEeQsW
 DFWXsCZOdw5ZwbcBTXSTmXKEbLBW28f2aAw4K60FybFLPCoE2+jnCiDX7+dFu8jW6F+jXHkJHN2
 d8NCnTQrvSb/3MzX8cNLIFXctSFHt91tPlj0aj6xVcUsj9qLPGVmL
X-Received: by 2002:a37:e301:0:b0:783:4b92:3b3b with SMTP id
 y1-20020a37e301000000b007834b923b3bmr8931013qki.121.1706130263872; 
 Wed, 24 Jan 2024 13:04:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGk6ZsWoDpoXUt0dPdS4Aa3VxW7YetY8+xBZvjLqGld+O2hjjmLpFvEU/MKwo9BPm58Y7OmQ==
X-Received: by 2002:a37:e301:0:b0:783:4b92:3b3b with SMTP id
 y1-20020a37e301000000b007834b923b3bmr8930996qki.121.1706130263585; 
 Wed, 24 Jan 2024 13:04:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a05620a215d00b00783958079b0sm4015507qkm.123.2024.01.24.13.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:04:22 -0800 (PST)
Message-ID: <ef080ff4-1fd5-4639-a316-6e09949608c7@redhat.com>
Date: Wed, 24 Jan 2024 22:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
 <20240122064015.94630-2-zhenzhong.duan@intel.com>
 <c47b95f9-ca42-4f8e-85d1-8fc72404e441@redhat.com>
 <SJ0PR11MB6744E96BE6A6014F7E43899892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744E96BE6A6014F7E43899892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/23/24 11:03, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache
>> when system reset
>>
>> On 1/22/24 07:40, Zhenzhong Duan wrote:
>>> IOMMUPciBus pointer cache is indexed by bus number, bus number
>>> may not always be a fixed value, i.e., guest reboot to different
>>> kernel which set bus number with different algorithm.
this cannot harm to reset it but I don't know if this can be encountered.
>>>
>>> This could lead to endpoint binding to wrong iommu MR in
>>> virtio_iommu_get_endpoint(), then vfio device setup wrong
>>> mapping from other device.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   hw/virtio/virtio-iommu.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 8a4bd933c6..bfce3237f3 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -1264,6 +1264,8 @@ static void virtio_iommu_system_reset(void
>> *opaque)
>>>       trace_virtio_iommu_system_reset();
>>>
>>> +    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s-
>>> iommu_pcibus_by_bus_num));
>>> +
>>>       /*
>>>        * config.bypass is sticky across device reset, but should be restored on
>>>        * system reset
>> you could remove the memset in virtio_iommu_device_realize() then ?
> Good suggestion, will do.
By the way what about the vtd implementation. s->vtd_address_spaces is
hash table but I don't see it reset either?
Also if is requested here we would need it on smmuv3 as well.

Thanks

Eric
>
> Thanks
> Zhenzhong


