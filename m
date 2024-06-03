Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FC8C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6uH-0007je-KM; Mon, 03 Jun 2024 08:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6uD-0007jN-4v
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6u9-0006G4-8E
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717418109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtEU1HKSrjIVloskIOpVwiKxH8I9q/MCDq/Dq8GocjY=;
 b=Ovxc6WeJ7XaCgh2aEHmkqgD9pk7F+Gmu1FwtAHQqRNwWgAMjmDy7a8QEqI/Q7s7wPpC3wy
 lx2WscmSG8WwjtupAKT/pL1+qLBD4RuAMp+ebgLcnZShzLVpbJEgX68pOl9LMkUt5ObUyu
 jUY6U4Jh2Y3x3iOGaPScikIvz7QXxIw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-esu3CutZM5urSvzGGiawdw-1; Mon, 03 Jun 2024 08:35:08 -0400
X-MC-Unique: esu3CutZM5urSvzGGiawdw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43e40216800so42981231cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418108; x=1718022908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rtEU1HKSrjIVloskIOpVwiKxH8I9q/MCDq/Dq8GocjY=;
 b=aNI+Wn0MxmI5KkdslXRW4cXiyS50iv67BDr0y6U0bChGwKEVNWcMYS9415M0QaBemq
 lsv/KKLqYALK4uJ0X+HCoQjASQpY2V3h1qWPZg80mDSRCk1sYNEqN1LvKSqPUKUwhISW
 b+zo/LKS9aKuky9IuCyPBrWWiUUIFfD9168ck6kkNc0x8a+p2//21Ld/qpfltVnb4rVO
 vnReq67xZEWkuVco5NlhggQcIxGbbNSO3bI21OPlFAHHvh4QTuv+Q57BSdxLhW+zg4oE
 WemNBXFUa+luaWbt2MmfalYPRDQtJai8etvk9jJxZE6uniQyY+70V6Yv/m2JN5vLEWds
 FZRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIz+1ZGqjpp40CCEtPCBhZR8P5RK4JwMxSGt5KcQ35LUB/ZkB/3+hQHdYKpjFRC5j6lsW6aWhCvdV5L+ewYRaXeyEUJV4=
X-Gm-Message-State: AOJu0YyE8b7ChLkgNhhwzbJCncC509R/ZWlnw0PClZL5PxeZXnNP40dJ
 lsEL6EcMnmJE5rc0xg7LBC6PJ+di6dH6zuc7thZr9fxxTxskhpULFhj/e12CENCNrlCxwFEpP4n
 ga1JQGp5kgjHVFITf/gWaNlLZgRQOTEPTi+mzPAhG/v2xmeuhoOMd
X-Received: by 2002:a05:622a:164c:b0:43f:ecd7:4fdc with SMTP id
 d75a77b69052e-43ff5263576mr86201551cf.7.1717418108072; 
 Mon, 03 Jun 2024 05:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv3YEy+GA4UeU9ePcLTiH9V318burhQR65E7Q8dNjcG6ZZf+x5cye0UswvU/+ETtX3+Is2/g==
X-Received: by 2002:a05:622a:164c:b0:43f:ecd7:4fdc with SMTP id
 d75a77b69052e-43ff5263576mr86201251cf.7.1717418107526; 
 Mon, 03 Jun 2024 05:35:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff7833015sm34577681cf.18.2024.06.03.05.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:35:07 -0700 (PDT)
Message-ID: <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
Date: Mon, 3 Jun 2024 14:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
To: eric.auger@redhat.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
 <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 13:32, Eric Auger wrote:
> 
> 
> On 6/3/24 08:10, Zhenzhong Duan wrote:
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   backends/iommufd.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index c7e969d6f7..f2f7a762a0 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -230,6 +230,28 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>       return true;
>>   }
>>   
>> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>> +{
>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>> +
>> +    switch (cap) {
>> +    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>> +        return caps->type;
>> +    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>> +        return caps->aw_bits;
>> +    default:
>> +        error_setg(errp, "Not support get cap %x", cap);
> can't you add details about the faulting HostIOMMUDevice by tracing the
> devid for instance?

yes.

> I would rephrase the error message into No support for capability 0x%x

I was going to propose "Unsupported capability ..."


Thanks,

C.



> 
> Eric
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
>> +{
>> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>> +
>> +    hioc->get_cap = hiod_iommufd_get_cap;
>> +};
>> +
>>   static const TypeInfo types[] = {
>>       {
>>           .name = TYPE_IOMMUFD_BACKEND,
>> @@ -246,6 +268,7 @@ static const TypeInfo types[] = {
>>       }, {
>>           .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>>           .parent = TYPE_HOST_IOMMU_DEVICE,
>> +        .class_init = hiod_iommufd_class_init,
>>           .abstract = true,
>>       }
>>   };
> 


