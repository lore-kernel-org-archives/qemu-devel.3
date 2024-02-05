Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22F0C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWw5k-0003nu-GV; Mon, 05 Feb 2024 05:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWw5h-0003n6-A4
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWw5f-0003sJ-Nb
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707128439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUPTNvY8Nr+3a8iI0upUi4LqIuPeIsfzu+X/LeJIEKI=;
 b=FpsoOSY/Lo6EKKOk6HFjg+IBLOHBeJdAg8Zlzy35PRaUiCg1YO8UQJutFPVycFSXDwR7CG
 S5ZDNuWNB2NIwB36P7I1BnlU00Sovdu3QtzgCKJFpYUMdgXV0D2j0voZQXg23ptd22aXZe
 nisf4r5TCeSjWICcgDXh8C6l7A+z/Z4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-rVeJtqh8Oo6STEEccHQhgw-1; Mon, 05 Feb 2024 05:20:35 -0500
X-MC-Unique: rVeJtqh8Oo6STEEccHQhgw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc6b2682870so6992553276.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707128435; x=1707733235;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUPTNvY8Nr+3a8iI0upUi4LqIuPeIsfzu+X/LeJIEKI=;
 b=eXA24QmKMcsqU03irdMQr30eCkLvH20y+ZZN83+9Q4tihk+wfN295iOjXepPptlvKM
 +MuQ+VfGvWTRy1KMcYwodD6/brsri4mlCZm/KSGzaTEhpseaxxIW9m54btB9/QrooGkC
 GBQ6v5goXFp108qQd4TUwgJ8Zlg+sIr8lXfE2eA3UBMKhTbmoYIR80hryUsoug/pGlk6
 RSREC6NxOBG4HTBM+/Y1J8QpikwTcDz7boRBerFjQMUBOtAjfwFj6nczZfQm0lWkgLyr
 07dMVB3XZ/o7q6lQJF3RDRTmEFHrLHbiQTWd3qrM5JBqrWhgaJrXEIxsPBOP5UGmdMRE
 2GOw==
X-Gm-Message-State: AOJu0Yx4IJhf0DxxyMy67heOYEjFfpWt8Zd8WkRoqzAljpT/uvWH7mZW
 SqPP61S8y7QxLEDx50+z4JmKa/WKgj9ELR2D/wdjRzEcxu7mDJ8c6vKYuzDEIH52MkaRb05cKOW
 /81674XSqzRBVnDvtG9ea/CHE3zjxKLi0MSyNpehUiK4n/YQUFZyI
X-Received: by 2002:a25:4e87:0:b0:dbd:5bfa:9681 with SMTP id
 c129-20020a254e87000000b00dbd5bfa9681mr13967205ybb.37.1707128435257; 
 Mon, 05 Feb 2024 02:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt41qHFMiyxq11t2hJ+C0GdT/WEfLvEqAB3vdjb3WO14o1HTBo3e/W7kR5zkG5sotlCniFsQ==
X-Received: by 2002:a25:4e87:0:b0:dbd:5bfa:9681 with SMTP id
 c129-20020a254e87000000b00dbd5bfa9681mr13967190ybb.37.1707128434999; 
 Mon, 05 Feb 2024 02:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUAKPA88/z24Wed9eNja1QCWxXQiPgddsvd+BACKYTOl1jbMdB9OusYHzTh0uogku3M2xthQE+Q00hpu+783fA00ZIP281f40vvz/0cwKEBbQPiVli0twjOL5oWGNoW8NR77CBSl2l68OuQfPpsqvTnd4/27Z0Erep83+VzdPdBgOERVujz49mv8cCg0zjpxf2paLIbP3dxSUus1Kd/zUptG8C5etYBd/VkWheDyaqxp95ZCNHpajaEkSavoSgvzmc+2kXWMZjFemZV8XLWkScRapWHeMMSMAoNxTl7MVWQ7sWKAp/W0poztCQLIgQJWpJE6J5V/g5xiH3SEwmFIdwj6v8wYQc6GEw=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm3554263qvb.109.2024.02.05.02.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 02:20:34 -0800 (PST)
Message-ID: <183d0606-8fbe-4783-bb71-4ec3732a78f3@redhat.com>
Date: Mon, 5 Feb 2024 11:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
 <319bda87-1d7e-40e3-812f-0f9c4d61f357@redhat.com>
In-Reply-To: <319bda87-1d7e-40e3-812f-0f9c4d61f357@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2/5/24 10:14, Cédric Le Goater wrote:
> On 2/1/24 17:32, Eric Auger wrote:
>> aw-bits is a new option that allows to set the bit width of
>> the input address range. This value will be used as a default for
>> the device config input_range.end. By default it is set to 64 bits
>> which is the current value.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - Check the aw-bits value is within [32,64]
>> ---
>>   include/hw/virtio/virtio-iommu.h | 1 +
>>   hw/virtio/virtio-iommu.c         | 7 ++++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 781ebaea8f..5fbe4677c2 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>>       bool boot_bypass;
>>       Notifier machine_done;
>>       bool granule_frozen;
>> +    uint8_t aw_bits;
>>   };
>>   #endif
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index ec2ba11d1d..7870bdbeee 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1314,7 +1314,11 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>        */
>>       s->config.bypass = s->boot_bypass;
>>       s->config.page_size_mask = qemu_real_host_page_mask();
>> -    s->config.input_range.end = UINT64_MAX;
>> +    if (s->aw_bits < 32 || s->aw_bits > 64) {
>> +        error_setg(errp, "aw-bits must be within [32,64]");
>> +    }
>> +    s->config.input_range.end =
>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
> 
> 
> This could be simplified :
> 
>    s->config.input_range.end = BIT_ULL(s->aw_bits) - 1;

Forget that. We would need a int28.

Thanks,

C.



> 
> Anyhow,
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 
> 
> 
>>       s->config.domain_range.end = UINT32_MAX;
>>       s->config.probe_size = VIOMMU_PROBE_SIZE;
>> @@ -1525,6 +1529,7 @@ static Property virtio_iommu_properties[] = {
>>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                        TYPE_PCI_BUS, PCIBus *),
>>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
> 


