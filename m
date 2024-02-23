Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7775C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR2o-00054o-F6; Fri, 23 Feb 2024 03:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdR2l-00053l-HM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:36:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdR2k-0007R5-2S
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIHPfxiEGQ8I0mM0SsKR+SeFGMww3Fic7nWRjyuhtvY=;
 b=Q/dkHQWrXLbToN43Ar9MqW/5UeGVEVWxwA0vQQfrv/m2nwFdTPNG22eyErPdycPyCnRWXm
 ZlCibQekKtsGweTBwDGVRqbUiV8ncSFS+xz16wOYFFCduKyEVkVAoZ/AEbbtvUhsCE3ZQW
 mM4FiC39+Ovkniu2m8MAgdxUA+aZM1U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-pSgUkaC4PKikD6mo9RAvWg-1; Fri, 23 Feb 2024 03:36:27 -0500
X-MC-Unique: pSgUkaC4PKikD6mo9RAvWg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-787a609ea37so60233085a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677386; x=1709282186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CIHPfxiEGQ8I0mM0SsKR+SeFGMww3Fic7nWRjyuhtvY=;
 b=WUGK54os+QkUpItNyI4sdn0I3/EHolhPChXAPQgQJDwJaQyHhO3ZMSFUaOLIrbADHg
 BPsDvkWLbCOVIRPFKsBXLAXIcGDCAIRmC4gjcd2exbLz76/4zZKFa5ggQWP8zmJRUovN
 IJMm4PUz2cZu5OFji295yra8qzGL62kF5f/RGfF9vyRka3NJwIPi6t6siPLadKHtU1rn
 fhOXn9G+3GtSPD7rvB309gVUMkoha8ESDVIJEupls6UIES/rDM6MEqx/zrlznU0kOFSv
 kN/nd3r40P150Czu1n8sHdCWveFGHV4nSbF82YNmpxW2IImN2zM0XhFtefDTdVbSaw8H
 jXzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnj6G6Lz0uMigiq9QxQolyXDu7f9pmEippn7hDPKVN59m+7Nn7JhxZpsw4+XtE569GVEvLjJ45cjA6PHHXTxX2U2ggBnM=
X-Gm-Message-State: AOJu0Yy0yVfDPu8mEviO7/UUDuQEWXcD1VCeFTjBmSmEVaZu/Nmbrliv
 3Y6fzvpfpzd8YyQ3eNC5jYIFUu97kmVzo2eQBOJteaVEGK8vcL0p7m+DTDNC7bETwLszhBAE6e/
 36ZC0Y5jPjk9pF6P3IDIMrVe7sGnpMbOrJ7PDmlGeVNgmTf13Qqnh
X-Received: by 2002:a05:620a:1011:b0:787:a7fe:c48d with SMTP id
 z17-20020a05620a101100b00787a7fec48dmr1308487qkj.3.1708677386692; 
 Fri, 23 Feb 2024 00:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvjJIraFuwNRx/+/SD7l6yCqsAUcWt/bxhPBwhdnysWKK4u3asMK72gQUs12fEgOIiv2q1wA==
X-Received: by 2002:a05:620a:1011:b0:787:a7fe:c48d with SMTP id
 z17-20020a05620a101100b00787a7fec48dmr1308467qkj.3.1708677386320; 
 Fri, 23 Feb 2024 00:36:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 vu5-20020a05620a560500b00785d893a692sm6202961qkn.27.2024.02.23.00.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 00:36:25 -0800 (PST)
Message-ID: <97b34139-eb49-492c-b77c-fe389f11b60b@redhat.com>
Date: Fri, 23 Feb 2024 09:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] virtio-iommu: Add a granule property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-3-eric.auger@redhat.com>
 <fcca3389-7862-4ecc-865a-404091e3d697@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <fcca3389-7862-4ecc-865a-404091e3d697@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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



On 2/23/24 08:57, Philippe Mathieu-Daudé wrote:
> On 23/2/24 08:27, Eric Auger wrote:
>> This allows to choose which granule will be used by
>> default by the virtio-iommu. Current page size mask
>> default is qemu_target_page_mask so this translates
>> into a 4K granule.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - granule_mode introduction moved to that patch
>> ---
>>   include/hw/virtio/virtio-iommu.h |  1 +
>>   hw/virtio/virtio-iommu.c         | 27 ++++++++++++++++++++++++---
>>   qemu-options.hx                  |  3 +++
>>   3 files changed, 28 insertions(+), 3 deletions(-)
>
>
>> @@ -1324,7 +1324,26 @@ static void
>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>        * in vfio realize
>>        */
>>       s->config.bypass = s->boot_bypass;
>> -    s->config.page_size_mask = qemu_target_page_mask();
>> +
>> +    switch (s->granule_mode) {
>> +    case GRANULE_MODE_4K:
>> +        s->config.page_size_mask = ~0xFFF;
>
> Alternatively:
>
>           s->config.page_size_mask = -(4 * KiB);
Yep that's more readable.

Thanks

Eric
>
>> +        break;
>> +    case GRANULE_MODE_8K:
>> +        s->config.page_size_mask = ~0x1FFF;
>
>           s->config.page_size_mask = -(8 * KiB);
>
>> +        break;
>> +    case GRANULE_MODE_16K:
>> +        s->config.page_size_mask = ~0x3FFF;
>
> ...
>
>> +        break;
>> +    case GRANULE_MODE_64K:
>> +        s->config.page_size_mask = ~0xFFFF;
>> +        break;
>> +    case GRANULE_MODE_HOST:
>> +        s->config.page_size_mask = qemu_real_host_page_mask();
>> +        break;
>> +    default:
>> +        error_setg(errp, "Unsupported granule mode");
>> +    }
>


