Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E405C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3kE-0005S7-3l; Fri, 14 Jun 2024 06:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3kB-0005OW-VB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3k8-0005JQ-VZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718359271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spMXs0hA1lUXNIprH3Oaitq4RHiLh0Qb0nwaEaL5KcY=;
 b=RdSufYXqqf3dG2DKNFkVz+5tt8nIMowOK/pRX56cPN2toZwY5UJvs3daW0E4LGAo9swzl/
 dwdQozZtThCOPtUKfEJJozENeVI6XIejk37szwe4LF+AAuB3jTW3D8LGPLDYz4RkM9hdIh
 bKeXxhZQxfHErVOQV3p8drGFKabXG5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-SuKom7b1OAeD2fIqEt3KyQ-1; Fri, 14 Jun 2024 06:01:10 -0400
X-MC-Unique: SuKom7b1OAeD2fIqEt3KyQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421292df2adso12888865e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 03:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718359269; x=1718964069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spMXs0hA1lUXNIprH3Oaitq4RHiLh0Qb0nwaEaL5KcY=;
 b=mPebooNWqSou06/eFlZpkZP9uDBNX/NiC8wCq3HHavAAVEO7EadyBumiw87j46Kjq9
 G4bPZNjwhtwLBb1JpWZuasbl5ZyFSoadSZXyBOmCiQRUtreeXRifk1c8p+OwanSJcYN+
 30v8aCZJlDOXanC3ecVceQG4pfYxWc9YXTPbipeNeSbXx3rqdGc+s5iikfiKZj1MzIUT
 /V88HpgawHuumWYz+8wN0EFPUB9YH00e4DNFc7S2KxgAeDLI0AHaCIhooXGbm6RpZm6a
 KESBLcxiKYGKKrvjghwgWUj19bvqMx70JU/wQCr7R8CjLKCRPXpGZlxwWanywoTyGQJh
 3YWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuv//ytf3r7ecBQdyXbejJ3oOCmkZVhAZrtvvxZcy/AXEcvp4yfV0nkjS6YBTR0owaEGffiez5CXGJD3BT6olGyC4jmy8=
X-Gm-Message-State: AOJu0Yxfc+1IygQMAig+bLgRZ9Av4LNPpnHMCUL+Sy6CTYRnRMZjOCEO
 eL/I3ooQ/bC+ygFwc1AxDhzIbtsviohaeBmEsRwFIWa/DeBA9A5uhUXJevW/YR9JnEBLyRiWMGS
 EhSPxYAwz/MzvsQMOJMPBCYZAYKdIgPJuX4rYiBKY2+bVXI2C+wyR
X-Received: by 2002:a05:600c:19d3:b0:422:aca:f887 with SMTP id
 5b1f17b1804b1-42304844ddamr20676405e9.28.1718359268888; 
 Fri, 14 Jun 2024 03:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEafPPeIr87XQdSeB39nCfAS5I7Iky6H6HQ5wCHNg7wfjDxsUm7hN71YQN7y0hvEATQbq8Xow==
X-Received: by 2002:a05:600c:19d3:b0:422:aca:f887 with SMTP id
 5b1f17b1804b1-42304844ddamr20676155e9.28.1718359268468; 
 Fri, 14 Jun 2024 03:01:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f23cdsm3918081f8f.77.2024.06.14.03.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 03:01:07 -0700 (PDT)
Message-ID: <f6473f76-1d8f-41cb-9488-73edc960c996@redhat.com>
Date: Fri, 14 Jun 2024 12:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-2-eric.auger@redhat.com>
 <ef400920-dcf4-4f37-b4ce-c5560b92d9c5@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ef400920-dcf4-4f37-b4ce-c5560b92d9c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Hi Cédric,

On 6/14/24 11:13, Cédric Le Goater wrote:
> On 6/13/24 11:20 AM, Eric Auger wrote:
>> Store the agent device (VFIO or VDPA) in the host IOMMU device.
>> This will allow easy access to some of its resources.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/sysemu/host_iommu_device.h | 1 +
>>   hw/vfio/container.c                | 1 +
>>   hw/vfio/iommufd.c                  | 2 ++
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index a57873958b..3e5f058e7b 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -34,6 +34,7 @@ struct HostIOMMUDevice {
>>       Object parent_obj;
>>         char *name;
>> +    void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
>>       HostIOMMUDeviceCaps caps;
>>   };
>>   diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 26e6f7fb4f..b728b978a2 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1145,6 +1145,7 @@ static bool
>> hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>         hiod->name = g_strdup(vdev->name);
>>       hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>> +    hiod->agent = opaque;
>>         return true;
>>   }
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 409ed3dcc9..dbdae1adbb 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -631,6 +631,8 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>           struct iommu_hw_info_vtd vtd;
>>       } data;
>>   +    hiod->agent = opaque;
>> +
>
> This opaque pointer could be assigned in vfio_attach_device().
>
> Talking of which, why are we passing a 'VFIODevice *' parameter to
> HostIOMMUDeviceClass::realize ? I don't see a good reason
>
> I think a 'VFIOContainerBase *' would be more appropriate since
> 'HostIOMMUDevice' represents a device on the host which is common
> to all VFIO devices.
>  
> In that case, HostIOMMUDevice::agent wouldn't need to be opaque
> anymore. It could  simply be a 'VFIOContainerBase *' and
> hiod_legacy_vfio_get_iova_ranges() in patch 3 would grab the
> 'iova_ranges' from the 'VFIOContainerBase *' directly.
>
> This means some rework :
>
> * vfio_device_get_aw_bits() would use a  'VFIOContainerBase *' instead.
> * HostIOMMUDevice::name would be removed. This is just for error
> messages.
> * hiod_iommufd_vfio_realize() would use VFIOIOMMUFDContainer::be.
>
> That said, I think we need the QOMification changes first.

OK I need to review your series first. At the moment I have just
addressed Zhenzhong's comment in v4, just sent.

Thanks

Eric

>
> Thanks,
>
> C.
>
>
>
>
>>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>                                            &type, &data,
>> sizeof(data), errp)) {
>>           return false;
>


