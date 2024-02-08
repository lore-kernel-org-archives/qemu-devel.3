Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586AFC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 08:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXzaU-0003Eg-3d; Thu, 08 Feb 2024 03:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rXzaR-0003EF-JI
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rXzaP-0004uO-IV
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707380203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNFhr0w3eENUWizh5QT/Cx/sdgdBCpB/dUJcwMwp9Yg=;
 b=dkPd9l3YzRaYgRaE+OUrpJN/hr+a6nAenbeUhFhiXNkNi5mJ8Nsw/rMM9bWlADCiaYCQti
 MfUUSQTPIeBEyYtpYGqzDkjD7sIuJfDCDJhpDdpBPmVU2kAtYXkodf7LIYcLsq/fi/Soju
 pIPYh9YwJdOeRRMfZwrMk2RH7Ei9pQY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-c3n5l4ktMIyP7PbmQiLHdg-1; Thu, 08 Feb 2024 03:16:41 -0500
X-MC-Unique: c3n5l4ktMIyP7PbmQiLHdg-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-46d3b546328so560525137.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 00:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707380200; x=1707985000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNFhr0w3eENUWizh5QT/Cx/sdgdBCpB/dUJcwMwp9Yg=;
 b=DT90t965hU2tR27ddhandIJMMnHrWmXLndvHZg2nUh9/kbzp89wggJeQEkU6FatpWB
 oDQgurn1VucWtHbrEnwegJjdMMPg/+kUESX2pn6MIWJx4CuWTGox3vRxNfatUVUK6ocz
 fNxW1RBLGNowzDpOHMbeCm6ApB71kBNeSANdGeaQyZyfJwEQ3EKSrlZlQ09uYukxCZdD
 BqrPT/libCfTeMxwrTUztiZAAOypKeSgolVrX7PVtZyzrSgQhHjX3CHy70FlMofocIa9
 VXvmzuUPVj/jlkSMM/1sLLxFu3g/SKdhyFa96qOUK7wH2GM1BOxtlWTQ2T1YK8ElTZ0+
 Knag==
X-Gm-Message-State: AOJu0YxDOPvWrtL0u/l7aWysaUj39vPLH5i7DvlrMRvPDqeeYO/f4DtG
 7R8IqPpsr12sggVbQaAAD8rInbQx/7YssUZG6GxnLbo49Ylrv89kpigR4QLQsebyIEMqjOvFpju
 RIs++avHO31lB+oJAGm1Otk7d9EqW+RUAnntyCSbKKEkMhPXzW4p4SiJjUFqE
X-Received: by 2002:a67:ff9a:0:b0:46b:303d:471a with SMTP id
 v26-20020a67ff9a000000b0046b303d471amr5281425vsq.31.1707380199871; 
 Thu, 08 Feb 2024 00:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6HT1Sob21B7nlMcl1bGXfqxgAl9UTULpm4+oji3Gaii4CoOfHcK/Mih+8cbcqVwmCSsJ0gA==
X-Received: by 2002:a67:ff9a:0:b0:46b:303d:471a with SMTP id
 v26-20020a67ff9a000000b0046b303d471amr5281412vsq.31.1707380199492; 
 Thu, 08 Feb 2024 00:16:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWYDWEveP5G16Wt1GBcCHuFkoTVzS0+8jJ+fghFnEE3lTwSRSWW7xGko9RZ4dPmNf7dLM9E1P+uFLe6/J1FC/ccO/dzH8PV8MTDvPKyQY4lqEzGI60/54fHi7jC8ticK5AGWXhGDYNh/VN55JpuSsatO6cWfZnjAsx4HStli4UEZd5iPKT8bdyq/CZrXypZNiefjXteutQKkqC8FznKr9GCxCWoQFmDf3FEa/OeGSAZUdC/JDs2n/d4dwodKMjgGhC4WWbgHrXbEIEMuyhMBXVMQWUXl/Bf7nqTdIWw9rArRlx/xwibrYJ/hTmqCP6o3xowGFL6
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 mb10-20020a056214550a00b0068cbfb3df1fsm1174901qvb.97.2024.02.08.00.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 00:16:38 -0800 (PST)
Message-ID: <1790d917-9360-4ce4-b1ad-aba9b72bc418@redhat.com>
Date: Thu, 8 Feb 2024 09:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com, mst@redhat.com,
 clg@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
 <20240205101322.GA2086490@myrica>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240205101322.GA2086490@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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
Is it a valid use case case to assign host devices protected by
virtio-iommu with a physical SMMU featuring Small Translation Table?
It leaves 64kB IOVA space only. Besides in the spec, it is wriiten the
min T0SZ can even be 12.

"The minimum valid value is 16 unless all of the following also hold, in
which case the minimum permitted
value is 12:
– SMMUv3.1 or later is supported.
– SMMU_IDR5.VAX indicates support for 52-bit Vas.
– The corresponding CD.TGx selects a 64KB granule.
"

At the moment I would prefer to stick to the limit suggested by Alex
which looks also sensible for other archs whereas 16 doesn't.

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


