Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A9C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Rdt-0006fq-CA; Thu, 02 May 2024 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2Rdo-0006eG-Kv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2Rdm-0007eI-SP
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714637885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKgy3TBfCZa7Ap+OIswkyrHyWh0RPrOTdkLOKvIL5v8=;
 b=TECWGyzDH0mR1K2N/SLkCR2C20QbXS8ie7rrWvv9S6QAZsWJGgji8QQX7lyPa6QqpE5o/p
 9VLyFUe/UCehhJ0jzSWpgOTncJqn7eWgoI1GbsIicDFqOLDSqLb+crrvnF3G5HDb5BIrXX
 uyulX8CaaDWHtQpnlpk3qoiC0HystMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-pIHhpBztMpSCaTbtSu3NVw-1; Thu, 02 May 2024 04:18:04 -0400
X-MC-Unique: pIHhpBztMpSCaTbtSu3NVw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34d91608deaso1409096f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 01:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714637883; x=1715242683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UKgy3TBfCZa7Ap+OIswkyrHyWh0RPrOTdkLOKvIL5v8=;
 b=DfRKMIx2ZsZuemA9y99EZx5dLsmgUbWorGntL1skIgv5ijY9uudUPaElYMsfvWc9qB
 Pz2+/UpFt4fNp9AxHY1+Zp6Wz5GH+uOV4slsAWRYh670Gat+0zcsi8PmEZOHCVwtPcC4
 m7aaR4tK4ebM0KlH+T+jDpPzV6bSVQ9YHeKmatdEUcQm68jhPwWvoDxozUjfAj+yGfts
 rDYedT7in2BzrsV39BKKnag49SpwoEr6g3E+ZpfkK9kmTDf3/tYJf0FwKJtlxllV8zoS
 VNAH6TLfmen4Ydd3IhcMVTfsyJVGmoD8TD6NPf1CAsVslrx14wDml6nUDziTmh+vP8/d
 rV7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdfysKVtMtT1stMrj3LKqH9bjgWGl4kFM2odYylQ6uRliTMqc+Xm7dluAsEKcbWJhhrvocdOdV2AKOTksDs93jUfp372U=
X-Gm-Message-State: AOJu0Yxd9tjA36P+452Fg6sMLEVAxNlG1JW3VrVWoT6v99LKRZe6CrQq
 HA1+cf/v6smcd7Yo00vflt/MIdxLEwK/2Y/g0y5ZWw05JM/oGNWB0DwjhEp1rhnqKaJOY+PWARH
 x59VuKxpVd9yDp2N/CNz5RB3tZ2kqUIXIoa1f7W5VAG3iKPD79P/p
X-Received: by 2002:a5d:43c4:0:b0:34b:640e:ad0e with SMTP id
 v4-20020a5d43c4000000b0034b640ead0emr3120227wrr.31.1714637882984; 
 Thu, 02 May 2024 01:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiIg0pVq1QPxBXajyiMVSY5m1iG/nVWzqyVXTqpWnWaYRQXx+RpZ/vQzSKC4AfTCkOZ8Zs/g==
X-Received: by 2002:a5d:43c4:0:b0:34b:640e:ad0e with SMTP id
 v4-20020a5d43c4000000b0034b640ead0emr3120203wrr.31.1714637882611; 
 Thu, 02 May 2024 01:18:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d420d000000b00346f9071405sm644667wrq.21.2024.05.02.01.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 01:18:01 -0700 (PDT)
Message-ID: <241f5575-b177-4d38-91e5-e6f3ad276a05@redhat.com>
Date: Thu, 2 May 2024 10:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
 <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
 <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <47877e84-cf7d-4b51-997a-f61cd208a55c@redhat.com>
 <SJ0PR11MB674486E8B903DF6B182936F492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674486E8B903DF6B182936F492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

>>>>> +static int hiod_iommufd_check_cap(HostIOMMUDevice *hiod, int cap,
>>>> Error **errp)
>>>>> +{
>>>>> +    switch (cap) {
>>>>> +    case HOST_IOMMU_DEVICE_CAP_IOMMUFD:
>>>>> +        return 1;
>>>>
>>>> I don't understand this value.
>>>
>>> 1 means this host iommu device is attached to IOMMUFD backend,
>>> or else 0 if attached to legacy backend.
>>
>> Hmm, this looks hacky to me and it is not used anywhere in the patchset.
>> Let's reconsider when there is actually a use for it. Until then, please
>> drop. My feeling is that a new HostIOMMUDeviceClass handler/attributed
>> should be introduced instead.
> 
> Got it, will drop it in this series.
> 
> Is "return 1" directly the concern on your side? 

I don't know yet why the implementation would need to know if the host
IOMMU device is of type IOMMUFD. If that's the case, there are alternative
ways, like using OBJECT_CHECK( ..., TYPE_HOST_IOMMU_DEVICE_IOMMUFD) or
a class attribute defined at build time but that's a bit the same. Let's
see when the need arises.


Thanks,

C.





