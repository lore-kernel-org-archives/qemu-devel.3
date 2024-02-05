Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDEC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1l0-0005Ye-3W; Mon, 05 Feb 2024 11:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rX1ky-0005Wr-7L
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rX1kr-0000Qp-TM
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707150212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVUzUhq1mlN9+ApWt8fAm937WttibYcQ3x62aI1sh8Y=;
 b=Udh8gtb5uJiws87G0VUmvceQcSE8VmktxzJ6mCNMq83IDh8lhl3W8VFM4PLRSrdKwRzTL0
 UKMrWqVEIJmaUzzJ0UF6G0CACeeAQ5bsUX+BHlBSwwvsmtU0044rgc/Vhwc+GuJT1ZIjAy
 L4xjWiBP4J8+tkMA9WKD1TBmLE7KJ6M=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-KjyihsrwPJyl607MpBR9jg-1; Mon, 05 Feb 2024 11:23:31 -0500
X-MC-Unique: KjyihsrwPJyl607MpBR9jg-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57b8so1880660241.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707150210; x=1707755010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVUzUhq1mlN9+ApWt8fAm937WttibYcQ3x62aI1sh8Y=;
 b=NTVU3yJRHkny7KvWrk5z6S3V1CotLLYVUnXSZgjEhKobBiD8KYHCIYlyuV9lqn5n2E
 18HqgsJrjVicmOvSuXpQlJ8aEShGs0qPTZDT34v/mvCduWA4OLkBp6nzOwlVyUsl5u/Z
 rHEz5QQmNU/5tGVhXXTxxt3tlNLD/6zEZB7eBa/T2KMLKl8Dag0XU+AF6KOBaAB6DS/S
 fcOmAufibWFQ+ozOGtBBJH4Goj4iB6j+vOULTogm/EzEV3VFffGcoWa4ESAwdjFo7Rwu
 CmS0G2r7jRpSj5gFpm0+ho4XG9TWmwK85DtNMZT4U41A8XpfxC+lGGjEaoNtJVZP3msV
 tZew==
X-Gm-Message-State: AOJu0YzzELhkIz5nW7WrdrdXwvKJxgfsBIB76uzlsPLbbMTc1a6ows9k
 lUvc90vR4dcC8xSOCKBuoQnOCO5riWTbOE7Swz7I9u0ZHS04n3I57o51Rpgl4uoddKNsMrLeWVe
 Cieb5agbpxJ7u2JWRls0sfpDnN+epaMUDjLttw6i2dfulRWBtza7K
X-Received: by 2002:a05:6102:34e3:b0:46d:238b:7b5e with SMTP id
 bi3-20020a05610234e300b0046d238b7b5emr367975vsb.0.1707150210671; 
 Mon, 05 Feb 2024 08:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIeS9kZ/CbZpDIdiJ8MXmJ4OmHAZcaguXjK+px4F/83g6XcMXFt/xmCZg7dPMN5z/DqcULuA==
X-Received: by 2002:a05:6102:34e3:b0:46d:238b:7b5e with SMTP id
 bi3-20020a05610234e300b0046d238b7b5emr367946vsb.0.1707150210348; 
 Mon, 05 Feb 2024 08:23:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXsVaHsdJfNi+Cg71oYIhYjE+4RFgkOymurVRQPyHJRwqsoHhwYfsQqtH8PnyN+uYWbzjJ/X4zcwPZJDORKWZr7Qwde9ADvkWhuTCokk1Ys4Ky8awM/8Y2YPtlAT+i+nN6qFS60CxLlGZazfNZxKl0CDfiDd+IZdIU1p3LqVDLT/hYQ1TlstSDV/rfRSMWxkKiji5sGfS4KOfvrMFtJgegL4eYxVSio2lo2YPfarFc/eTOAldSzCBJZpQnwAtyhvHBUkLNp0TDCUKrBF9XkhS+rgqp4xcaM0d/OLaE/eeshp31tFhbNov1sQg8U4CHEGOmavj9o
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a0cf514000000b0068c440bc7d0sm109511qvm.105.2024.02.05.08.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 08:23:29 -0800 (PST)
Message-ID: <e5c70c36-d309-4a28-8649-67cfb701dd4c@redhat.com>
Date: Mon, 5 Feb 2024 17:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com, mst@redhat.com,
 clg@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
 <20240205101322.GA2086490@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240205101322.GA2086490@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jean,

On 2/5/24 11:13, Jean-Philippe Brucker wrote:
> Hi Eric,
>
> On Thu, Feb 01, 2024 at 05:32:22PM +0100, Eric Auger wrote:
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
>>  include/hw/virtio/virtio-iommu.h | 1 +
>>  hw/virtio/virtio-iommu.c         | 7 ++++++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 781ebaea8f..5fbe4677c2 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>>      bool boot_bypass;
>>      Notifier machine_done;
>>      bool granule_frozen;
>> +    uint8_t aw_bits;
>>  };
>>  
>>  #endif
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index ec2ba11d1d..7870bdbeee 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1314,7 +1314,11 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>       */
>>      s->config.bypass = s->boot_bypass;
>>      s->config.page_size_mask = qemu_real_host_page_mask();
>> -    s->config.input_range.end = UINT64_MAX;
>> +    if (s->aw_bits < 32 || s->aw_bits > 64) {
> I'm wondering if we should lower this to 16 bits, just to support all
> possible host SMMU configurations (the smallest address space configurable
> with T0SZ is 25-bit, or 16-bit with the STT extension).
I have no objection relaxing that check. Alex suggested this 32b low
limit with his knowledge of x86. I am a bit reluctant to add extra
machine specific checks though. Anyway I assume that some [low] aw-bits
will fail with some guests and this will be difficult to understand from
bug reports.

Thanks

Eric
>
> Thanks,
> Jean
>
>> +        error_setg(errp, "aw-bits must be within [32,64]");
>> +    }
>> +    s->config.input_range.end =
>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
>>      s->config.domain_range.end = UINT32_MAX;
>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>>  
>> @@ -1525,6 +1529,7 @@ static Property virtio_iommu_properties[] = {
>>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                       TYPE_PCI_BUS, PCIBus *),
>>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> -- 
>> 2.41.0
>>


