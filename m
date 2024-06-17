Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0043C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5mj-0001a1-5T; Mon, 17 Jun 2024 02:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5mi-0001ZY-1M
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5mg-0002jP-25
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718605444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUjPEcJygmqh88A3E2HTiznvD7K/obHptczgW4nqY54=;
 b=QNu0KeFkvWnE4NZOTkKCIGofJFJm/8G5ykJC0jLU5K3jux0Js/6R0ebeTHhfehZ+f9vf67
 8w84yYfE22inkJEj3uRJL+aI1r228BEdcW2lhbiPIoR17/CP/EtYmO3VhOS0xXEyJzL0hO
 bpnh6UHhOSWf0Vh0yzO/2EO6xKIIeOE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-4ZZC_N4JMLK20ALabk2Gzg-1; Mon, 17 Jun 2024 02:24:00 -0400
X-MC-Unique: 4ZZC_N4JMLK20ALabk2Gzg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad706fab2aso51697226d6.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605439; x=1719210239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUjPEcJygmqh88A3E2HTiznvD7K/obHptczgW4nqY54=;
 b=i1Auy6EU+6ncPRn8bhqwsXmYD1x2bsdfDoUpRANmRSSkBMnKoopEs7pucaqivmPh9O
 uBtvqvklePM5EpPCFhv2Tu9ONayVQ5bXjV1jBp5kc8fOVAAF96lyCEqqQ0OrDVnSNIJt
 yc79kqklipSqTllsdXUM+MBZlHsF18L0cfk+w5DBBOlVsLEVQqXfrwjCZ9rskv5rAkiY
 JVsUdcx88jQepV4wu77p12rwojYd0X8rj66JC77fguC4U4rkPST03/oesyF6xpKlnnHH
 2LlHAcmko9TvdLZF5yKOM7L7Ba4LbHYMsCUdtkYaIecQxT/9aJVYayAC45Gkbycmh5Cw
 TKRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWgpLRCRKH/lRKF+EL7Z10eCcfvgIi6bS3cOPaBwXZqs4QvP6sBgrxethO4edg9THap1KGko9EmE61uOl2deyuJAMA9xQ=
X-Gm-Message-State: AOJu0YwebE/VX5/80kevl8I1cMqNkC9ocHZ7blWD++lALbdv2TnYqJIq
 sGUV44LvWqMnoD1ON7QsZ9tCsDiI73Cl4mndY7er9Mi5P9AjHDM0ZoB99K9SnEzVNJboYNi4NY0
 DP68tTRLzE0UwT07FwDn4Z0CXLH+hW/lFN7aqErsB1VG8dqFnAzhP
X-Received: by 2002:a0c:cc13:0:b0:6b0:6cb3:1c0d with SMTP id
 6a1803df08f44-6b2afcd996emr91165806d6.28.1718605439723; 
 Sun, 16 Jun 2024 23:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5uV7mqx0nBCBox/B3LH/mgpQ12BUvoouRLX7GMTFC9GeIzW4vhsRCdnwueCQ16Qouh/DefA==
X-Received: by 2002:a0c:cc13:0:b0:6b0:6cb3:1c0d with SMTP id
 6a1803df08f44-6b2afcd996emr91165676d6.28.1718605439445; 
 Sun, 16 Jun 2024 23:23:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5eb4f4asm52021396d6.98.2024.06.16.23.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 23:23:59 -0700 (PDT)
Message-ID: <6753f002-2c9e-4491-8d6e-ccc91ff3c22d@redhat.com>
Date: Mon, 17 Jun 2024 08:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-2-eric.auger@redhat.com>
 <ef400920-dcf4-4f37-b4ce-c5560b92d9c5@redhat.com>
 <f6473f76-1d8f-41cb-9488-73edc960c996@redhat.com>
 <ec740f33-44ae-4d50-be65-5f717122f4f0@redhat.com>
 <SJ0PR11MB674408FB45B20DC52E42193692CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674408FB45B20DC52E42193692CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/17/24 3:25 AM, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, June 14, 2024 6:05 PM
>> To: eric.auger@redhat.com; eric.auger.pro@gmail.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; mst@redhat.com; jean-
>> philippe@linaro.org; peter.maydell@linaro.org; yanghliu@redhat.com; Duan,
>> Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: alex.williamson@redhat.com; jasowang@redhat.com;
>> pbonzini@redhat.com; berrange@redhat.com
>> Subject: Re: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
>>
>>
>>>> Talking of which, why are we passing a 'VFIODevice *' parameter to
>>>> HostIOMMUDeviceClass::realize ? I don't see a good reason
>>>>
>>>> I think a 'VFIOContainerBase *' would be more appropriate since
>>>> 'HostIOMMUDevice' represents a device on the host which is common
>>>> to all VFIO devices.
>>>>
>>>> In that case, HostIOMMUDevice::agent wouldn't need to be opaque
>>>> anymore. It could  simply be a 'VFIOContainerBase *' and
>>>> hiod_legacy_vfio_get_iova_ranges() in patch 3 would grab the
>>>> 'iova_ranges' from the 'VFIOContainerBase *' directly.
>>>>
>>>> This means some rework :
>>>>
>>>> * vfio_device_get_aw_bits() would use a  'VFIOContainerBase *' instead.
>>>> * HostIOMMUDevice::name would be removed. This is just for error
>>>> messages.
>>>> * hiod_iommufd_vfio_realize() would use VFIOIOMMUFDContainer::be.
>>>>
>>>> That said, I think we need the QOMification changes first.
>>>
>>> OK I need to review your series first. At the moment I have just
>>> addressed Zhenzhong's comment in v4, just sent.
>>
>> Yep. Just take a look at mine. If both of you agree with above
>> proposal, I can care of it and resend all 3. It's a small change.
> 
> I would suggest using opaque pointer and VFIODevice for two reasons,
> 1. in nesting series vIOMMU needs to attach/detaching hwpt which is VFIODevice operations.
> See https://github.com/yiliu1765/qemu/commit/3ca559d35adc9840555e361a56708af4c6338b3d

OK. I realized later on that we needed the device id anyhow.
> 
> 2. If we plan to support VDPA Device in future, the opaque pointer can also point
> to an VDPADevice structure.

Thanks,

C.


