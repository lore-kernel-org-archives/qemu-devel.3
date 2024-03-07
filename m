Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E807CC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8IT-0006Cg-Lp; Thu, 07 Mar 2024 02:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8IP-0006C1-Gx
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8IM-00046Y-Rh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709796962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1WfqLZgDka9rQY484/u0YexWs9lTrfR0ok04P3iYdo=;
 b=OVYcQjxFFw9DedTDawnJFrboTaJ5bbPm0h4yd3AY+GyauCNd6GYIO1VvhUswiIDPHBKumX
 6IJpKVOUoC+9hFJp3xhXMWOqSaxCI0EDgq19oiBtweCfajIPGKAWBxVoEhiRsftaMA4Kcz
 7RzloqZNhfRuTnJ//9+ABBfb1abXw4o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-9ReiTBAoP_CrAlTs7-lYmg-1; Thu, 07 Mar 2024 02:36:00 -0500
X-MC-Unique: 9ReiTBAoP_CrAlTs7-lYmg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d2b256e617so3280231fa.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 23:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709796959; x=1710401759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1WfqLZgDka9rQY484/u0YexWs9lTrfR0ok04P3iYdo=;
 b=uayN1QwLxwWUQv/ywJ5zbVbtkt/g4Fwe3v6qGWcssSCH8Zf8vK/W1zixvwRe4MKCg/
 RdZE776lr+v9ozSL/6fJrLGigVg4GV6pvC61sZ5SSerslr0pddr/DWGArHna1OQTOGRI
 60Zx0TSRe1zOQhLk5hEv3h1pBqM+cszGHaOZOIRt6+iMphgQp+RPgQ6dRQLn2rShZ7vu
 XWk0Z8jR0jzEWIeZxSDUkIsl8v8bZ4jQL1QdjCB4DXI7pzvpZWga1ocmI9vwExdPQF/N
 WKJ9yRpKJ6KuQLBiqU0B6EJ3ddEEq5PWqf8pFFp+NKoYgV0nepyBKeHdNSIT5bQryPyO
 iLIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8uzcykEydnphD4ibU0ogFTZsetoYl0z+nHwY4rw4A7BzYfK0QBrd2+0DKRM7jzohmIsZmahteGYm235HxITXm+O0nRCU=
X-Gm-Message-State: AOJu0YxaJ1DFTGRmF1o/u2a/GPnsX86PvBvDLsuEpfheyCHiY+l0KZzj
 tg/YIU3t7pjn/nCRnuhYpQ1G74ARoJu8ThFZ8FsahbI3HE0CXwbMS1Zoi6OWQLl1xR/FmRzqNZq
 QZgRrqX+/UyYdbqN5TJhy+WWsYHgg+jj4l19V3haP5M2NqBOq5FfI
X-Received: by 2002:a05:651c:198c:b0:2d3:ffa0:8782 with SMTP id
 bx12-20020a05651c198c00b002d3ffa08782mr851550ljb.43.1709796958993; 
 Wed, 06 Mar 2024 23:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU35r3PD245DpUSuAHitRhUkBYnLcO/6SCrRi0EKEyW5OEWUGzSFO911p6GI5sMzkzhYWmNw==
X-Received: by 2002:a05:651c:198c:b0:2d3:ffa0:8782 with SMTP id
 bx12-20020a05651c198c00b002d3ffa08782mr851536ljb.43.1709796958628; 
 Wed, 06 Mar 2024 23:35:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a5d6590000000b0033d56aa4f45sm19575005wru.112.2024.03.06.23.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 23:35:58 -0800 (PST)
Message-ID: <0b2dea01-f587-4ef8-bf56-e56b881b693e@redhat.com>
Date: Thu, 7 Mar 2024 08:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] virtio-iommu: Add an option to define the input
 range width
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, imammedo@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-7-eric.auger@redhat.com>
 <708f7eb4-f1fb-4f8e-8cba-7d270c84847c@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <708f7eb4-f1fb-4f8e-8cba-7d270c84847c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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



On 3/6/24 21:45, Philippe Mathieu-Daudé wrote:
> On 6/3/24 21:32, Eric Auger wrote:
>> aw-bits is a new option that allows to set the bit width of
>> the input address range. This value will be used as a default for
>> the device config input_range.end. By default it is set to 64 bits
>> which is the current value.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
>> diff --git a/include/hw/virtio/virtio-iommu.h
>> b/include/hw/virtio/virtio-iommu.h
>> index 67ea5022af..83a52cc446 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -68,6 +68,7 @@ struct VirtIOIOMMU {
>>       Notifier machine_done;
>>       bool granule_frozen;
>>       GranuleMode granule_mode;
>> +    uint8_t aw_bits;
>>   };
>>     #endif
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index aab97e1527..9b2813188b 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1314,7 +1314,11 @@ static void
>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>        * in vfio realize
>>        */
>>       s->config.bypass = s->boot_bypass;
>> -    s->config.input_range.end = UINT64_MAX;
>> +    if (s->aw_bits < 32 || s->aw_bits > 64) {
>> +        error_setg(errp, "aw-bits must be within [32,64]");
>
> Don't we need to return?
It looks better. Nevertheless this was tested and it gives the expected
behavior.

Thanks

Eric
>
>> +    }
>> +    s->config.input_range.end =
>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
>>         switch (s->granule_mode) {
>>       case GRANULE_MODE_4K:
>> @@ -1544,6 +1548,7 @@ static Property virtio_iommu_properties[] = {
>>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>>       DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
>>                                GRANULE_MODE_HOST),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>


