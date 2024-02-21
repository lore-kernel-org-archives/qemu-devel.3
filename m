Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37EBC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoa6-0005fA-18; Wed, 21 Feb 2024 10:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rcoQM-0007yB-AW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rclyw-0000kN-8v
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708519548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0rMCtexgvyL/jrBXkcmUZwK4PEevrktJT3ywti7/q4=;
 b=cta4tJ7C1Y1I0pk64xuBpGc5Y5eaTZHxa/nTo/YWdGjCSNkV74dBtdxPxRmThYYMrohv48
 awu+K96H1xgiiOmJmrVa9OiizbiJHTvFDTHc+T8t5A46G9cbWd2RKNjTaE8jwLNr2Eeo2U
 TQjplwLmpQ2nOjjaL+qWCOt3YJQzmzE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-QI4msnRPPxqN9g_PQlEgrg-1; Wed, 21 Feb 2024 07:45:46 -0500
X-MC-Unique: QI4msnRPPxqN9g_PQlEgrg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68f8b4cc3f1so19201176d6.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 04:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708519546; x=1709124346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0rMCtexgvyL/jrBXkcmUZwK4PEevrktJT3ywti7/q4=;
 b=VNMkng1Emz4l4JxHp1bRy5BW2OOVHjV/wbV6GWWVt1tvDSFPrBKYQo7vdseDZ7v69Y
 3rYCk/fGZFKH7UkvvVenOrKNZpQhhJFAyJaBAEVoeZunNELtqkOd41jaeWp3sMpPSFMf
 ZMRH5ZwB9y2yp4ngO8/KaCoqEYgiM/u9FfJfGvMDa7l23OvR0+TVeDkv/ODcOQDwOQOr
 pN0rj9FZGXjQD28S69OCw6nVdlmr4vcBUbbP4iwTdr+OesSEs4gdOSOUHjAJk+IG1hUY
 IGq7oP4+X6dklhNxWDVGhqAdvVO7E1tmIOL1012BTflsLSmhQgM3RxP6tYIToqHS8nGC
 owsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0rbUE28UpAOTOJBVHzpqLIp2Q/jF4rkfxHIzywfrgl65+GBsS3PYfVEc6QzoXixQxgIWgFFfiEWLfSjvI+qoGXCRFrg=
X-Gm-Message-State: AOJu0Yy6xnReLwMObf7rmdS9t0wPPovMzB7PGtsBDShLRYzJCVicTQbz
 jhRcdhNFnjpxj3W3brw4URGDwnZH6T/JheegIN7o9P9ArAXt0fYfKQdpXEVOOCQFVoPcgNQ5cmC
 QZ3Jrs/KWMXR4boM0ZLnBQwOmPsFksHm3VOmM6IpYW+r0Q7o1aVMt
X-Received: by 2002:a0c:f084:0:b0:68f:a250:7a07 with SMTP id
 g4-20020a0cf084000000b0068fa2507a07mr1767883qvk.19.1708519545944; 
 Wed, 21 Feb 2024 04:45:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLrw+/3tMyJ+gBoAD3aLUKNifm7Y4Igdym/h7PHgz790+CvS8DGsc9LOPV25qD/+7wNDT9sw==
X-Received: by 2002:a0c:f084:0:b0:68f:a250:7a07 with SMTP id
 g4-20020a0cf084000000b0068fa2507a07mr1767863qvk.19.1708519545642; 
 Wed, 21 Feb 2024 04:45:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ng9-20020a0562143bc900b0068f455083fbsm5130548qvb.63.2024.02.21.04.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 04:45:45 -0800 (PST)
Message-ID: <fa751e58-0b98-4b86-900d-83b128d1c829@redhat.com>
Date: Wed, 21 Feb 2024 13:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org, Peter Xu <peterx@redhat.com>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060731-mutt-send-email-mst@kernel.org>
 <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
 <20240213064017-mutt-send-email-mst@kernel.org>
 <8c0f6a91-7ae2-46c6-a8ad-18ca096a6115@redhat.com>
 <20240221113106.GA4121556@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240221113106.GA4121556@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 2/21/24 12:31, Jean-Philippe Brucker wrote:
> On Wed, Feb 21, 2024 at 11:41:57AM +0100, Eric Auger wrote:
>> Hi,
>>
>> On 2/13/24 13:00, Michael S. Tsirkin wrote:
>>> On Tue, Feb 13, 2024 at 12:24:22PM +0100, Eric Auger wrote:
>>>> Hi Michael,
>>>> On 2/13/24 12:09, Michael S. Tsirkin wrote:
>>>>> On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
>>>>>> Do you have an other concern?
>>>>> I also worry a bit about migrating between hosts with different
>>>>> page sizes. Not with kvm I am guessing but with tcg it does work I think?
>>>> I have never tried but is it a valid use case? Adding Peter in CC.
>>>>> Is this just for vfio and vdpa? Can we limit this to these setups
>>>>> maybe?
>>>> I am afraid we know the actual use case too later. If the VFIO device is
>>>> hotplugged we have started working with 4kB granule.
>>>>
>>>> The other way is to introduce a min_granule option as done for aw-bits.
>>>> But it is heavier.
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>> Let's say, if you are changing the default then we definitely want
>>> a way to get the cmpatible behaviour for tcg.
>>> So the compat machinery should be user-accessible too and documented.
>> I guess I need to add a new option to guarantee the machine compat.
>>
>> I was thinking about an enum GranuleMode property taking the following
>> values, 4KB, 64KB, host
>> Jean, do you think there is a rationale offering something richer?
> 16KB seems to be gaining popularity, we should include that (I think it's
> the only granule supported by Apple IOMMU?). Hopefully that will be
> enough.
thank you for your prompt reply. I do agree.

nevertheless I am going to prototype passing the whole page size mask I
think. That could be useful to test some weird configs

Thanks

Eric
>
> Thanks,
> Jean
>
>> Obviously being able to set the exact page_size_mask + host mode would
>> be better but this does not really fit into any std property type.
>>
>> Thanks
>>
>> Eric


