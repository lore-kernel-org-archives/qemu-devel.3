Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B8FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 02:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDZDM-0008SA-68; Mon, 27 Oct 2025 22:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1vDZDK-0008Rn-Un
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1vDZDH-00025b-Ok
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761617597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLYe9AOWl7pPQRY2B72dm5ypE/vO29Drc46QIp7wmwE=;
 b=AOzaVmVhUbQl46kJnYmLxseBJXWEysHq2LLJcO9Cl8mj+5qQyX+9GXvcCZASXfqWc+cXWn
 JxaF/BzEYAE0SVSlyv1Nzore44LiWicUEXWZNliB0tP/Rbw4CRi+M+dIlBW8LMzDj71XyO
 8LmuYbUg9mXCp4WQq8e2d6HBobAhLDM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-EVe9aJR_OnSAo6uLMVwpsw-1; Mon, 27 Oct 2025 22:13:15 -0400
X-MC-Unique: EVe9aJR_OnSAo6uLMVwpsw-1
X-Mimecast-MFC-AGG-ID: EVe9aJR_OnSAo6uLMVwpsw_1761617595
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8904a9e94ebso1135195285a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 19:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761617595; x=1762222395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLYe9AOWl7pPQRY2B72dm5ypE/vO29Drc46QIp7wmwE=;
 b=N2LnHer5dcFILQDWs7LEC79yjvJyhNCTq6eMqrc8Fr8/j3LdPToMV2w6rRB89fuMiP
 a0JZOyyIqooS0YyOt92Fx0Dj9RkLQEiT9A4X73QQrwomKSPqbu+GATXi48JoiZhg4sed
 vL7PS5r7rD2L3jesUJ20hKo4VCSm9RwzXVudHsJGXSuiWiNYAWojrVogcqVbvaCc6tN7
 yMNreU1q1hp3nd3Q0i/atopoGKdFeOEidLvuNvf1FGCwcab6XrXL37z+nmtVUr4/9QjS
 gZI/bHoCcktS0oGLqigLSHVQDjvgOpV5QOshjatu4XXNVHK7f8fSBfPWKUmJEK0cC4vl
 e8Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCyOHFYtZ+vFWupIr2/hkm6DcHd72chQGSXe02IbsaFOkdf6SKX/M1MGljoaIbaEDJQvcQvrHBlihb@nongnu.org
X-Gm-Message-State: AOJu0YxjiUvZdGA4nSOwzm7YgY5gk9JRY5nwLoCP/19R4/fuxduzExQv
 Q/xZQCWeBubwbVxGlWnf2sWeffMhf35BhaffEkyYHYcJs/W+Nqn+B7ACPAh+KPAcbAWPDEJSx61
 9UTq9hT6PC3OYpHCuL2V9DJWncqvh5Nm3/LRsN7uI9MP5EhxwJv5vJvzr
X-Gm-Gg: ASbGncsBq/1ru+L1uYekuM9kV4ObYS2WpqThz5n7ShN+eZMhW/Juz2LOuAY7RzpMmgL
 idLL6f53/4ZC91ubxDNYBnkPa6dJk2aDx0Gi0emQ7iUT8ntWXmeMjOnfcFua7j3lkli5AIyHqy8
 UjoLVTCb7u/3+RrCLIBdDyE9nOIBEZqkxoRPm6DBotWS6CdrdIxv8Awzf/7ORe5EF4XSDuaZPR0
 mOSzWK+1ekhZ25Zt+Az/NnWs5XmHZgTjztQa7YLHz/+HYh5MvBQfbQqbe4AyqoyGq2CspojZuU8
 xGtnfOzy+/j60b93fjzlQj7o2K29fpZkX+/r6EogV9VH2CsZGvUTrg1vfR2+y1zqX2oa2m831GU
 =
X-Received: by 2002:a05:620a:450f:b0:892:7dd2:9f14 with SMTP id
 af79cd13be357-8a6f47d049cmr275747685a.25.1761617594984; 
 Mon, 27 Oct 2025 19:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHktz2vJHRa9etpRmyqikOSZkSMHecWN+F5LxZn+rGi5z6+eGx2o9R/xf7px/SUvkxnkbmv0w==
X-Received: by 2002:a05:620a:450f:b0:892:7dd2:9f14 with SMTP id
 af79cd13be357-8a6f47d049cmr275745785a.25.1761617594613; 
 Mon, 27 Oct 2025 19:13:14 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fc4csm717517185a.10.2025.10.27.19.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 19:13:14 -0700 (PDT)
Message-ID: <5e897607-2c33-46f2-b2ab-579a2f4b6385@redhat.com>
Date: Mon, 27 Oct 2025 22:13:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Content-Language: en-US
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jonathan.cameron@huawei.com
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
 <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
 <c21641fd-1a35-4b47-a361-bfc2daf7dbd7@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <c21641fd-1a35-4b47-a361-bfc2daf7dbd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On 10/27/25 10:13 AM, Eric Auger wrote:
> 
> 
> On 10/27/25 12:27 PM, Peter Maydell wrote:
>> On Fri, 24 Oct 2025 at 09:46, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>>> The virt machine now supports creating multiple SMMUv3 instances, each
>>> associated with a separate PCIe root complex.
>>>
>>> Update the documentation with an example.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Thanks. I have some minor word-smithing tweaks, but I'll just
>> apply them to this patch in target-arm.next if you're OK with
>> that:
>>
>>
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst
>> @@ -224,23 +224,24 @@ SMMU configuration
>>   """"""""""""""""""
>>
>>   Machine-wide SMMUv3 IOMMU
>> -  See the machine-specific ``iommu`` option above. This allows specifying
>> -  a single, machine-wide SMMUv3 instance that applies to all devices in
>> -  the PCIe topology.
>> +  Setting the machine-specific option ``iommu=smmuv3`` causes QEMU to
>> +  create a single, machine-wide SMMUv3 instance that applies to all
>> +  devices in the PCIe topology.
>>
>>     For information about selectively bypassing devices, refer to
>>     ``docs/bypass-iommu.txt``.
>>
>>   User-creatable SMMUv3 devices
>> -  Allows creating multiple user-defined SMMUv3 devices, each associated
>> -  with a separate PCIe root complex. This is only permitted if the
>> -  machine-wide SMMUv3 (``iommu=smmuv3``) option is not used.
>> +  You can use the ``-device arm-smmuv3`` option to create multiple
>> +  user-defined SMMUv3 devices, each associated with a separate PCIe
>> +  root complex. This is only permitted if the machine-wide SMMUv3
>> +  (``iommu=smmuv3``) option is not used. Each ``arm-smmuv3`` device
>> +  uses the ``primary-bus`` sub-option to specify which PCIe root
>> +  complex it is associated with.
>>
>>     This model is useful when you want to mirror a host configuration where
>>     each NUMA node typically has its own SMMU, allowing the VM topology to
>> -  align more closely with the host’s hardware layout. Supporting multiple
>> -  SMMUv3 instances is also a prerequisite for future accelerated SMMUv3
>> -  support.
>> +  align more closely with the host’s hardware layout.
>>
>>     Example::
>>
>>
>>
>>
>> (I deleted the sentence about SMMU acceleration because that
>> isn't upstream yet. When it lands then we can update the
>> docs if the version of it that lands can't support acceleration
>> of a single machine-wide accelerator.)
>>
>> thanks
>> -- PMM
>>
> Looks good to me as well
> 
> Fell free to add my R-b
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks!
> 
> Eric
> 
+1; looks good; can add my r-b if another is desired/needed.
- Don
> 
> 
> 


