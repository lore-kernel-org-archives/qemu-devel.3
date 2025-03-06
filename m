Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CC2C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDdl-0005uZ-Mk; Thu, 06 Mar 2025 11:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDdc-0005WG-N4
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDdY-0007Nv-FC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741276790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bobaLhRHul//cvP8MQrT14uvIx1z/vjGDTXE77jjM2k=;
 b=ZTj9TQbM0AV4FpGZVmUCgobFDwJzIkl3/ndyFIdivJGr/2kQdA72B0kBhJ/Zq0uwcTxbZn
 NwxakvhVnHelQxSXIXl+VNqa39GRW16mW9d15DCB5/zkz6aPyN5H/A9OiQQ+oTYrgg3ngU
 5ffkRKYj9c27YHSKj7TkLVHJiwg3X1s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-XfPB1T32PLyrHRDPBPT1SA-1; Thu, 06 Mar 2025 10:59:43 -0500
X-MC-Unique: XfPB1T32PLyrHRDPBPT1SA-1
X-Mimecast-MFC-AGG-ID: XfPB1T32PLyrHRDPBPT1SA_1741276782
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bce8882d4so3951835e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276782; x=1741881582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bobaLhRHul//cvP8MQrT14uvIx1z/vjGDTXE77jjM2k=;
 b=ULotnFBM+Sshy4oxBPY0B2OvBNKmGndxyYwcEHDdYfk//tbXdE3PZMgWgf4/lGUtod
 xwpZ3AWFBT+vQkFcdDxSJqh5uRkWMCOJllTyEG27xs94h0DKWUoJwkxnvHGu7fwBDKee
 Ljk7wV3ZSwlBaGYFarG30QrDJBRsIhp+/Ech+Bp2ANtwnwCBXOHlaF3kf8ngBcAmwj2V
 bmol1ghnH0J8GCGGUTq4UPUOp5NmUfN6P5k0AZWYVi7VqSuejqpY6ma91HGYK5PDsevZ
 6iTncJ6VZ3B4mpCMins2y9iZYWFbOR/miFziUpH0IWE1Tt6ouXQNXCo2qF7UjqARdZv0
 2J5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExcRMaTMZLoC0XyBb+7Cpmue9PD9oA7SjdgatOMb3yzXN4pFJHpayyQYcIAVji9Sqt8ufoM2yJars@nongnu.org
X-Gm-Message-State: AOJu0YwyniGoFEJZWai6OGtww1ru4jathXYyWcOervyjAoTSumhlQ03j
 ipiEeWwNqNhAUm9KQ0j6jUJAq6bYm21r0jFrVLRkF9qBRtJx0YthcoFo23GGLj5qBtVel1UsyBb
 5KTu2wKxfuZi9c9rYp2TIcKudCZsV0+BuxqUzpoU6a/O3JhP/T7Rh
X-Gm-Gg: ASbGncvr0UTKCVt/EkQHNeuzxO7u9x/C+EwUxnzDjG+mxUjzUy6/8FJv/mrme7OtuGa
 dEYABCuBC2GUzkR2ovUmCfNFqYZzb+8g0vFeyxM5pion4qXKBrpaoxQPsmYOE4DBY7booBFyndE
 CSxwH7+QnQuBL+6LNk0PEMzYDL8M1XJmtolPlT3Uk7WkQWE5+7UWLtP159+XC7bGwIb0FHqWvIy
 Zhlph67PEjntYeWSkNb5t8HCkmkxefWsNvVt/GwunWOJXu/litU5nTcgYEggDmWveau5nt34sRL
 McbQ9Iox8WxuLkHC1fIw76zjSjjQsITiHt6u0q/jf70xPVca6iXPPtJOPYUz0IQ=
X-Received: by 2002:a05:6000:2808:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-3911f7c5802mr3868578f8f.49.1741276782442; 
 Thu, 06 Mar 2025 07:59:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeZbNRGXn0wfJ038vIe6HzSqG4oTdl02SbWhggmVMax7GV5lBBMVVA5Jx+Fk2qUagITlZvfQ==
X-Received: by 2002:a05:6000:2808:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-3911f7c5802mr3868563f8f.49.1741276781994; 
 Thu, 06 Mar 2025 07:59:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb799fsm2428541f8f.2.2025.03.06.07.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 07:59:41 -0800 (PST)
Message-ID: <0ccbf699-e6be-4936-89f7-b4f69672516f@redhat.com>
Date: Thu, 6 Mar 2025 16:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
 <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
 <SJ0PR11MB6744FAC917F2DF9A7BF9FF9992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744FAC917F2DF9A7BF9FF9992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 2/28/25 9:29 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
>> capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>>
>> Hi Zhenzhong,
>>
>>
>> On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/system/host_iommu_device.h | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/system/host_iommu_device.h
>> b/include/system/host_iommu_device.h
>>> index df782598f2..18f8b5e5cf 100644
>>> --- a/include/system/host_iommu_device.h
>>> +++ b/include/system/host_iommu_device.h
>>> @@ -22,10 +22,16 @@
>>>   *
>>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
>> represents
>>>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO
>> ioctl)
>>> + *
>>> + * @nesting: nesting page table support.
>>> + *
>>> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
>>>   */
>>>  typedef struct HostIOMMUDeviceCaps {
>>>      uint32_t type;
>>>      uint64_t hw_caps;
>>> +    bool nesting;
>>> +    bool fs1gp;
>> this looks quite vtd specific, isn't it? Shouldn't we hide this is a
>> vendor specific cap struct?
> Yes? I guess ARM hw could also provide nesting support at least
> There are some reasons I perfer a flatten struct even if some
> Elements may be vendor specific.
> 1. If a vendor doesn't support an capability for other vendor,
> corresponding element should be zero by default.
> 2. An element vendor specific may become generic in future
> and we don't need to update the structure when that happens.
> 3. vIOMMU calls get_cap() to query if a capability is supported,
> so a vIOMMU never query a vendor specific capability it doesn't
> recognize. Even if that happens, zero is returned hinting no support.
I will let others comment but in general this is frown upon and unions
are prefered at least.

Eric
>
> Thanks
> Zhenzhong
>


