Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C66C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3ES-00039f-6O; Wed, 29 Jan 2025 03:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1td3EG-00037m-QR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1td3ED-0003Hd-Bk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738138516;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLk0PP7DXX7kwB63HESm9vgBr/1hpqhZ8qpB/vFHkCs=;
 b=V5NkFDyPsVfRjlpS3AScK6j6/o8C7gtJ2vNKp2NOOWEHViIuoy2Mm7XyxzWJN4Q4ItgY9R
 2/oHgtO1R9uYm9g0B0DT0EOIRh2Ez8C0DCyxbOC8OseMpw0+nUF4OuIKYlp6xHBYN1NsIO
 I9xQG29/HDEiXztO90zZQqK8v+zg7Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ToDJr4PKPumrVKY7_5fuIg-1; Wed, 29 Jan 2025 03:15:14 -0500
X-MC-Unique: ToDJr4PKPumrVKY7_5fuIg-1
X-Mimecast-MFC-AGG-ID: ToDJr4PKPumrVKY7_5fuIg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso35198675e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738138513; x=1738743313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLk0PP7DXX7kwB63HESm9vgBr/1hpqhZ8qpB/vFHkCs=;
 b=Nsi+C4dKifbQaeDZFfp8ADnu3beRngR87A4TUs5RVDCP0GamGtf+itDhAQkN5mjjMW
 gcRB1f3gwLTx0DVC7/b4MkLZ1DobfbnBI59d59FCwTpDqhDVBs/Slta/3Hm5JBGb1rHx
 Z8iN1AGjlecM9dLgXWmLxAHwCpc/XTe92EsOHVUGk/NhtxKcOap+CtgzhZyfSQb8pFUK
 ffras+hKV0GvQg/XSPehIKsJQzlMNl3TV2TNslJepY1ENrOxoH7eguPUtxja1ysD//wJ
 boI2RFEZfBrMucGo3nnp9Pf++84JQoYh56nRMW/ve9C4UNK9piSG0sxWOjJQv3EWpbUv
 4Icg==
X-Gm-Message-State: AOJu0Yz5/DXmactWAFIQ/dVv1bbd9x09nFOEc0tjh5HlI4if93k2naTn
 uozK0pwV35Te7uMbub/cuFgB8YFQWZ3u6mvNXtOPMB2JsNViXyB1uvr8BQ68nEjZQXJKIYvSbbN
 /N0b9oxwBfj8uVUrrwruFwC6ADrRqhQZ5xwXMe8F0p/RiESVUcyZN
X-Gm-Gg: ASbGncv7eOBuDCGsZn+gKo2sIkrzv0+oeKflR67zsCmr/4KWJ2XCeBc0rkrMQSaGqUe
 0I49DYHu1KcxUFiYGMA9WzCUd2+4CMZJCUN0aMWZM1F+mgsKiyqWwQY52uDJGh3Nfqg7vem4iZm
 FKxd0zM2p/Ie5t6xSUY6TeEiVvdhLJfS31CBizeRQGuii60BQn+ZQQKzPPUwL/0a9MDHYnU+Z/6
 FfOPFTPgK5GS1FDjJoWdmLzxmiEEkiLIzyZJvXTofn0BObotXhftHZkFz/V+Ofecdzg/WEDKmiP
 0r/lU3YKItoyuVPrchx/hzY49PIo2Rz1KUIdrNCdevcR2XEzAWre
X-Received: by 2002:a05:600c:4e01:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-438dc3a3e77mr16138165e9.3.1738138513142; 
 Wed, 29 Jan 2025 00:15:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhjZsdjQnrm2SsoZ9MgrYKG/me9DPHNhA4r0CsvC3R7v0HqFMxnz4kUMsYUpeUeqWIPRwTFQ==
X-Received: by 2002:a05:600c:4e01:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-438dc3a3e77mr16137905e9.3.1738138512750; 
 Wed, 29 Jan 2025 00:15:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e3a6sm13873815e9.20.2025.01.29.00.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 00:15:11 -0800 (PST)
Message-ID: <7d470652-6439-4b5c-afee-d74826ead969@redhat.com>
Date: Wed, 29 Jan 2025 09:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Matt Ochs <mochs@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Nathan Chen <nathanc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
 <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
 <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
 <0d303a69-0779-4309-9c00-c76afc82d324@redhat.com>
 <188a25cb7640462ba1cb81456a2fdd90@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <188a25cb7640462ba1cb81456a2fdd90@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Hi Shameer,

On 1/29/25 9:10 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, January 29, 2025 7:56 AM
>> To: Matt Ochs <mochs@nvidia.com>; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>> Cc: qemu-devel@nongnu.org; Nathan Chen <nathanc@nvidia.com>;
>> ddutile@redhat.com; Nicolin Chen <nicolinc@nvidia.com>; Ankit Agrawal
>> <ankita@nvidia.com>
>> Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
>
>>>>>> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
>>>>> Not sure it is better to fallback to default size here instead of setting
>> error.
>>>> I think if the user sets a value it shall be obeyed
>>> Agreed.
>>>
>>>> Note that per the dynamic memory map algo, changing the size will also
>>>> change the base address. See
>>>>
>>>> virt_set_high_memmap(). By the wayn why do we forbid a smaller size?
>>> That’s a good point, I will remove this check.
> Is there really a use case where a user will want a smaller size than default?
>
>>>>>> +    object_class_property_add(oc, "highmem-mmio-size", "size",
>>>>>> +                                   virt_get_highmem_mmio_size,
>>>>>> +                                   virt_set_highmem_mmio_size,
>>>>>> +                                   NULL, NULL);
>>>>>> +    object_class_property_set_description(oc, "highmem-mmio-size",
>>>>>> +                                          "Set extended MMIO memory map size");
>>>>>> +
>>>>> I think this probably needs backward compatibility to keep migration
>> happy.
>>>>> Isn't it? See the no_highmem_compact handling.
>>>> I guess if we keep the same value as default we are good. The difference
>>>> with highmem_compact is it was set by default from 7.2 onwards hence
>>>> changing the mmio layout. Here by default you keep the same IIUC.
>>> I’m not sure I see an issue since the code is directly modifying the size
>> value
>>> in the extended_memmap array.
>> I meant that if by default we keep the size value equal to 512G (the
>> existing default value), I don't think we need to care about compats.
> Yeah. If it has default size , it should be Ok I guess. But what if,
>
> Your source is something like,
>
> ./qemu-new -machine virt-9.1,...,highmem-mmio-size=XXX
>
> and has a target VM started with
>
> ./qemu-9.1  -machine virt,...
>
> The migration will be still successful but will have memory map differences, right?
>
> Or the above is not considered as a valid use case and the onus of making
> sure we are using it correctly with default size is on the user. 
To me when you migrate the qemu cmd line is supposed to be the same on
both src and dst. But worth to be tested.

Eric
>
> Thanks,
> SHameer
>
>
>
>


