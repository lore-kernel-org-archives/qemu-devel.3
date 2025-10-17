Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C87CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 17:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9o7A-0005rd-7c; Fri, 17 Oct 2025 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9o77-0005r5-Bt
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9o70-0007NI-AW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760721566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqKQOA7IIgOldgwfrDPBw5DFY0Ez/V7/yqopDGqLJaY=;
 b=hGYIY9942KFCVBevcLO3rGsWMX0wkaoU0Z1sLitiveKxp81hbhkBp7wVI6Eg7sSuvNdToV
 gZ6Yc/XAawRUypbQsEds8NLfUq7R5qXw6HogHa3HKZrluE/p4/H29RjHxp7Gkl73SOnYFf
 Rbj1B33QkR9IhybqPf0hN7nNHVOKFPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-oX3IEY98PXegsu2PUI8_Eg-1; Fri, 17 Oct 2025 13:19:24 -0400
X-MC-Unique: oX3IEY98PXegsu2PUI8_Eg-1
X-Mimecast-MFC-AGG-ID: oX3IEY98PXegsu2PUI8_Eg_1760721560
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-427a125c925so151817f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 10:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760721560; x=1761326360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqKQOA7IIgOldgwfrDPBw5DFY0Ez/V7/yqopDGqLJaY=;
 b=q3h1x6/1uUJSFqmrROWhAICCGP0x4AuBeeAQWxk3M6veQa9PWQZ3Gjtyi1fT6G/JKj
 mfE+RyUGx2JKjalYFBfVWXqxL+LfL5XpLEJPLgibLCDtsfdCCLtlRXONKyYWCTcQvd1B
 Sg6o5uMjyGVS6Lvf5LXPc77VbzO/tgp4sQgjEsPu1J89lkrceoVVZkLlfiGqPHQgKu3e
 drlSgdoESK3AeCSqZUlUA7DoGDP7H2Z+NK9cwEYFoq7c1Brm+5iE5qUfO7wjF2A55gAk
 EF0iczNW4M3M6iCEGtmDda0JSBkm5FyoWRtmXplZ+LRa4Yy4l1IwTgOxnT3edbaFWhzm
 p22g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefm0k586lXTurE0jubpeexgdV3cC+ZoK1G+pjYu5G2G3H5ZhJKjz107KKGWaVhOdrda7SjnuHiAev@nongnu.org
X-Gm-Message-State: AOJu0YztI6mo9wuNnFNbAapHGSbaEjQ3QAN/SxF8RtyDHpyW+lfkZH4X
 1OmDqAV6hIGFL2yYoROqk6BdeaxtNFop6rPqBdMd5l4axb2C7sh9N4xK6Jp7b9Y+/vZV/r83i+M
 3A7X0Ibpm9nWC+sZi+26NpbYZS3fXN8cSSi5a8Y6mhBiTVX+kLwQlTSwa
X-Gm-Gg: ASbGncuRMIqkiqyW2hpYktUKHe4H3np/lSzDsphUD3m8BCxam3Pn7vN+KuEUK9QGv+s
 5Jl8GI5GtrFi5+oPTUnbQRRd0LjZKvyP5dLfcmVVIyMy+/qRLEMvUqEelUn+Wy3hqgLcRCIEmJW
 jfDf+6zH0zU2gQ5qZbmIokf2NZ4oVcX7RcCJDxHiKrzTrzvKTRfPMyP7K23BYY4qq4KAsNreZaO
 LOM4S83eJGBpMyOqzt1pQc/7mb20QWzCmwasAqBgcR58b/2kpqjUb7YItlOlTERk+50SwWicuJx
 MEavLueb4emuuRtFXO8LJLygtU8xS68nK18v5ze55pRo+RaPY4TNUWW3TFbfEp70ImaHScdLKPl
 Zu50Pvtl5ybL9mhse5rHXGsEcgHHweGXN/5Ek5xTFaKKNlw==
X-Received: by 2002:a05:6000:4202:b0:426:d82f:889e with SMTP id
 ffacd0b85a97d-42704d74dc8mr3406025f8f.14.1760721560241; 
 Fri, 17 Oct 2025 10:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW05dIykKGzxbQKK/MbtwylPUzy4uySA73CqXJwXsG+Gmz0TxlbmsnMSvyCFmMiFNXFbVmYw==
X-Received: by 2002:a05:6000:4202:b0:426:d82f:889e with SMTP id
 ffacd0b85a97d-42704d74dc8mr3406003f8f.14.1760721559783; 
 Fri, 17 Oct 2025 10:19:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3f5esm312080f8f.20.2025.10.17.10.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 10:19:19 -0700 (PDT)
Message-ID: <c6007575-a32a-44fd-b23e-6d340928a5e0@redhat.com>
Date: Fri, 17 Oct 2025 19:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <cba0a4c0-9d0c-4137-ae0a-7460da56ac56@redhat.com>
 <CH3PR12MB754822A08B7D9D7317DBECD8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <646bbedb-cfa4-418c-80b2-f143f6f97544@redhat.com>
 <CH3PR12MB7548CA7BFC577C90C3876748ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548CA7BFC577C90C3876748ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/17/25 3:15 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 17 October 2025 13:47
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
>> SMMUv3 to vfio-pci endpoints with iommufd
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 10/2/25 11:30 AM, Shameer Kolothum wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: 01 October 2025 18:32
>>>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>>>> arm@nongnu.org; qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>>>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>>>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>>>> smostafa@google.com; wangzhou1@hisilicon.com;
>>>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>>>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>>>> shameerkolothum@gmail.com
>>>> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
>>>> SMMUv3 to vfio-pci endpoints with iommufd
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>> Hi Shameer,
>>>>
>>>> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
>>>>> Accelerated SMMUv3 is only useful when the device can take advantage
>>>>> of the host's SMMUv3 in nested mode. To keep things simple and
>>>>> correct, we only allow this feature for vfio-pci endpoint devices that
>>>>> use the iommufd backend. We also allow non-endpoint emulated devices
>>>>> like PCI bridges and root ports, so that users can plug in these
>>>>> vfio-pci devices. We can only enforce this if devices are cold
>>>>> plugged. For hotplug cases, give appropriate
>>>> "We can only enforce this if devices are cold plugged": I don't really
>>>> understand that statement.
>>> By "enforce" here I meant, we can prevent user from starting a Guest
>>> with a non "vfio-pci/iommufd dev" with accel=one case.
>> Ah OK I misread the code. I thought you were also exiting in case of
>> hotplug but you only issue a warn_report.
>> From a user point of view, the assigned device will succeed attachment
>> but won't work. Will we get subsequent messages? 
> It will work. But as the warning says, it may degrade the performance especially
> If the SMMUv3 has other vfio-pci devices. Because the TLB invalidations
> from emulated one will be issued to host SMMUv3 as well.
>
>  I understand the pain
>> of propagating the error but if the user experience is bad I think it
>> should weight over ?
> I am not against it. But can be taken up as a separate one if required.
>
>>> Please let me know your thoughts.
>> Can't you move the assignment of bus->devices[devfn] before the call and
>> unset it in case of failure?
>>
>> Or if you propagate errors from
>>
>> get_address_space() you could retry the call later?
> For now, I have a fix like below that seems to do the
> Job.
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c9932c87e3..9693d7f10c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1370,9 +1370,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->bus_master_as.max_bounce_buffer_size =
>          pci_dev->max_bounce_buffer_size;
>
> -    if (phase_check(PHASE_MACHINE_READY)) {
> -        pci_init_bus_master(pci_dev);
> -    }
>      pci_dev->irq_state = 0;
>      pci_config_alloc(pci_dev);
>
> @@ -1416,6 +1413,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->config_write = config_write;
>      bus->devices[devfn] = pci_dev;
>      pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        pci_init_bus_master(pci_dev);
> +    }
>      return pci_dev;

OK worth putting it in a separate patch to allow finer review of PCI
maintainers.

Thanks

Eric
>  }
>
> Thanks,
> Shameer


