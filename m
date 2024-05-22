Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384AC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9hDI-000140-AA; Wed, 22 May 2024 04:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9hDE-00010H-AU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9hDA-0002Xk-NC
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716366034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GQJMJaKvadWph4f5hLpSu9hgBLImxi3b6+1CHO09Fo=;
 b=WAUDLAZy6IaGghBEbq6vnQloHWkRz63oFAhsN5GH90XUB3yQPrKywOMPl8LruJV1YaAth7
 n5QGSjBJH63HWnsb9No1QG+zHlBgbd99WQLkla5KnNYCOxAZbYHKipfjdy+IT2RiPR+/EK
 GI/wBCCk6MIKdqsybNC6Ru+ZkxlZL94=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-YwZQzFTMOq-2Wya2R2Fijw-1; Wed, 22 May 2024 04:20:32 -0400
X-MC-Unique: YwZQzFTMOq-2Wya2R2Fijw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a884aca64bso52733326d6.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 01:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716366032; x=1716970832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3GQJMJaKvadWph4f5hLpSu9hgBLImxi3b6+1CHO09Fo=;
 b=iH4mH87otyimEq3otnl32/b+Lxs7jpTvjTV6lcEqQGUjsKFtDV5njkSul7DL3HWDnB
 Wq4CEGvo8n/10sao/7kgy+W+1UO27KZe+q7wLM+sTFPOL2dlCBa4cqqsawhYfuzze1YK
 WhMZfofmNvyoge3pzcg8Z2mPHJb2Ju8jxz1Pvw04wMdY7TJCsQonY5CNfTkYR+fW5Dsw
 3uRmdlA4tZLmPBnqWhHx+d7okp0gkaKv8v4VLdWcOsIOSjRJKVrmE60UyKFsN0eQNRFG
 G2tPUM2uB5XHg19wpe/hsom4j4pmr2viHxgTXhWTMDRJuaooCB+kfjLeYb8KEt9r9YYM
 kYPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV20TXD57CQ0eW+kKr16ft4wPhskpjFRrucjHvHbBMzLfyE9iA1r5tgUgxzUU5anNi9bsO9wyL/b1HlCeJ+8pA7GAdEDMU=
X-Gm-Message-State: AOJu0YyTapYcu9yYT42ZeATSZWLT8uu+0uTrBFupL5b5OEecW7YuCMFU
 5Npvnum2xz4EPieR6PKXgPRt3ocrNrKAw2zG1HieIywvOqegna7++ECPrSxN3bg3VHjmJGA3HDs
 JIhrrs7X8Ia3PNPDUKIa+A3A3A0X04Q7Ar1dklleA3cU0MmMGnnup
X-Received: by 2002:a05:6214:53c9:b0:6ab:6d0e:be3 with SMTP id
 6a1803df08f44-6ab809013c8mr10088426d6.43.1716366031787; 
 Wed, 22 May 2024 01:20:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYLA55Nky201WWSl6+Wj0PMwuBOe/bkn/KN1zg6ZYNRa8VopopmV1ub8PpuCqxqiHQH5UIRQ==
X-Received: by 2002:a05:6214:53c9:b0:6ab:6d0e:be3 with SMTP id
 6a1803df08f44-6ab809013c8mr10088226d6.43.1716366031372; 
 Wed, 22 May 2024 01:20:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35384037esm78771756d6.73.2024.05.22.01.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 01:20:30 -0700 (PDT)
Message-ID: <6be3e0e2-1a33-47e5-b6f4-94a2738c215f@redhat.com>
Date: Wed, 22 May 2024 10:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in
 error path
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-21-zhenzhong.duan@intel.com>
 <8e3efc39-b8a1-4750-86d3-1d2451ad2b65@redhat.com>
 <PH7PR11MB6722B0B1F6A3D0004BD77F7492EB2@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <PH7PR11MB6722B0B1F6A3D0004BD77F7492EB2@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/22/24 10:05, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, May 22, 2024 3:52 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-
>> devel@nongnu.org
>> Cc: alex.williamson@redhat.com; eric.auger@redhat.com; Peng, Chao P
>> <chao.p.peng@intel.com>; Eric Farman <farman@linux.ibm.com>; Matthew
>> Rosato <mjrosato@linux.ibm.com>; Thomas Huth <thuth@redhat.com>;
>> open list:vfio-ccw <qemu-s390x@nongnu.org>
>> Subject: Re: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in
>> error path
>>
>> On 5/22/24 06:40, Zhenzhong Duan wrote:
>>> When get name failed, we should call unrealize() so that
>>> vfio_ccw_realize() is self contained.
>>>
>>> Fixes: 909a6254eda ("vfio/ccw: Make vfio cdev pre-openable by passing a
>> file handle")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> If the realize handler fails, the unrealize handler should be called.
>> See device_set_realized(). We should be fine without IMO.
> 
> Do you mean when vfio_ccw_realize() fails, vfio_ccw_unrealize() will be called?
> Looked into device_set_realized(), I didn't see where vfio_ccw_unrealize() was called.
> Do I misunderstand?

no, it's me. I thought it was called in the failure path :/ Anyhow, let's keep
this patch for a ccw series.


Thanks,

C.



> 
> Thanks
> Zhenzhong
> 
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> ---
>>>    hw/vfio/ccw.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index 168c9e5973..161704cd7b 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -589,7 +589,7 @@ static void vfio_ccw_realize(DeviceState *dev,
>> Error **errp)
>>>        }
>>>
>>>        if (!vfio_device_get_name(vbasedev, errp)) {
>>> -        return;
>>> +        goto out_unrealize;
>>>        }
>>>
>>>        if (!vfio_attach_device(cdev->mdevid, vbasedev,
>>> @@ -633,6 +633,7 @@ out_region_err:
>>>        vfio_detach_device(vbasedev);
>>>    out_attach_dev_err:
>>>        g_free(vbasedev->name);
>>> +out_unrealize:
>>>        if (cdc->unrealize) {
>>>            cdc->unrealize(cdev);
>>>        }
> 


