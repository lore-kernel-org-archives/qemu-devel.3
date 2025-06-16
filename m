Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08DAC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDgB-0007tU-OL; Mon, 16 Jun 2025 13:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uRDg9-0007sw-Q4
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uRDg2-0003vp-VN
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750095076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihjeWi/0gcPpegSQ04JiCzsJbM1MCOCfpX5SzthJRl4=;
 b=ZxkPxIECwE8ikFVJouJO0qHjXjULMpxzbkiO2cQlGMAa2groUHjzakzBwnrRwCXTLTXEO9
 +aTPUFUUOcRH4y06JIfGlsvBYNp9cps2bq1yfTIdBBjBjMpqPi/utgk4Qn0EYgg2LY3Q2A
 1+dv+PYP/KNCW3c/Eg9t3bF9pVxyHgs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9Er3apkzPTCdD7J0VSLMPw-1; Mon, 16 Jun 2025 13:29:32 -0400
X-MC-Unique: 9Er3apkzPTCdD7J0VSLMPw-1
X-Mimecast-MFC-AGG-ID: 9Er3apkzPTCdD7J0VSLMPw_1750094971
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a6f89098cfso104387951cf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750094971; x=1750699771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ihjeWi/0gcPpegSQ04JiCzsJbM1MCOCfpX5SzthJRl4=;
 b=ZVs5lQMT7Ejfg00Ws4nDsqkap6XNwxIfBsPfV6t6VSA6896cy6SoYVfQP7VGA6B1Gh
 gduc34uOrm7GWYrWfPouax+ipf4ASqhpPNpGE6hTIeRQxrOlopvxTOpkTIGu25QX/j4g
 6ajIWO0HpS4boHnN8KF4O+Qzqr8MbHlSPVUJECXPBJTjoQR7HsFQmh9lH0IH4vaR2uSD
 nf5Pq3LBWAD7qg8kha4/y+DmRU1Ixr6ddA0GxVLRhcWc7raIU3HEglOKPr8ulgEL+Ykv
 A4DLki+eaUiy6ki6Dy1LM4Dgo4AcWfLez5aRV5LqKlv9uoqbdg2Ahm/HrNcrFEUhJ4MH
 5FNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWymfiG2P+FFFJFhF41Be+9NeADsAnZTCB0BtFCS/nfEkNi04SS4ITE3L08bmzPE2NhtuTdY+FyJa96@nongnu.org
X-Gm-Message-State: AOJu0YzUn4gDqYC6ztG3FDhsRL4hq7eXo7HGc8XS+Ij0mhYkDSfN1o8P
 Rgl1OPgYgJtlWeqxqmh5ZZQzLGc8IkoB/LhMSv8kVMyzMa+zwtxAzL4q2y8ggj0vdGifFX7n8Vv
 Qm8vpORZkCGif+SRV9WsA9CgitYr/Hs8rMV0A5FH34lfYpRfgroRSTch3
X-Gm-Gg: ASbGncu0ORbiJNV967YyyeTErLjuS8GwjF94R/3fYC7LZWr/oV7WmBkcNhfGQ47abB0
 j1wyoCa4gCWSKcdsOCs2g8B9Nbaf3XsYZHyk+jvMov+GvsVXpEKPcFq5eQwK+YI17CXsvVm/cqE
 NooGnsz8AGVEllukALaN4GpgEbd4kWjWy08cw4F1R4EHkoinaUtyIKanYtmhDtxdne2dWuS3I8O
 bzXnyizlDdjnrqxymt4Zj6m4idVVBgKMyVHRPYPKaxwkda6LoQRnsO76AZuklLj0yF4gfcraSkX
 XmEZhA/U4en58S2zZ/W7GMw=
X-Received: by 2002:ac8:5acb:0:b0:4a6:f518:6b19 with SMTP id
 d75a77b69052e-4a73c5faebemr158210181cf.28.1750094971345; 
 Mon, 16 Jun 2025 10:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj2qaweCyr9da+O4wWnjtlxF5wk2mZj9iamltjuRQnmZJySoH44uKzzAyKZGwRLBktgskMCQ==
X-Received: by 2002:ac8:5acb:0:b0:4a6:f518:6b19 with SMTP id
 d75a77b69052e-4a73c5faebemr158209631cf.28.1750094970803; 
 Mon, 16 Jun 2025 10:29:30 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a3103a5sm51516451cf.30.2025.06.16.10.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 10:29:30 -0700 (PDT)
Message-ID: <bee0abcd-2cf5-4640-a3a5-92955bac6976@redhat.com>
Date: Mon, 16 Jun 2025 13:28:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] qemu-options.hx: Document the arm-smmuv3 device
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, linuxarm@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 berrange@redhat.com, imammedo@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, zhangfei.gao@linaro.org
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-8-shameerali.kolothum.thodi@huawei.com>
 <20250616121245.00005b4b@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250616121245.00005b4b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 6/16/25 7:12 AM, Jonathan Cameron wrote:
> On Fri, 13 Jun 2025 15:44:49 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> 
>> Now that arm,virt can have user-creatable smmuv3 devices, document it.
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   qemu-options.hx | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 7eb8e02b4b..3edbde45bb 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1226,6 +1226,12 @@ SRST
>>       ``aw-bits=val`` (val between 32 and 64, default depends on machine)
>>           This decides the address width of the IOVA address space.
>>   
>> +``-device arm-smmuv3,primary-bus=id``
>> +    This is only supported by ``-machine virt`` (ARM).
>> +
>> +    ``primary-bus=id``
>> +        The PCIe Root Complex to be associated with.
> 
> Hmm.  Root complex or host bridge?
> I think an RC is allowed to have multiple heirarchy and hence multiple
> host bridges. Figure 1.2 in the PCI spec. So my gut feeling is this
> should be host bridge.
> 
+1.
the key word-hint: 'complex' -- a RP (a Root *Port*) can only host a single PCI(e) (sub-)tree,
but a RC can have multiple PCI domains, not to mention a bunch of platform-level,
acpi-defined PCI(e) devices.


> 
>> +
>>   ERST
>>   
>>   DEF("name", HAS_ARG, QEMU_OPTION_name,
> 


