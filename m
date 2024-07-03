Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3474C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvLa-0007mv-Jn; Wed, 03 Jul 2024 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sOvLY-0007lC-VU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:28:12 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sOvLX-0001Vj-5H
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:28:12 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e9a920e73so201326e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719995288; x=1720600088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IoSO2PAuZGif7rbZnYxoKrO42Ckut9KEDh24qTt2M7c=;
 b=lPF6RGb4/IiO9GJaRpn0B1Xjn4Hlqye2aT5FH0AXXrNxspqnwLpZV+Vk9Y1FFUXndy
 zTzZ0MAMaq+i4HR255v7BSMlC8Em5xEm02Fy7KszD+5A7ifg9FSdMlkmoehIpNtjoPRI
 ZxiFHnDKz08LKjJGgZELsw8jl7W+NnXcSJe6m7G0HqIlP7Ajk31aHAjZZTfn76J8gsoh
 pYfPJ29nClU6I3Dsxbp3glymkG7Vfd9OdbBsO2+AKf0vb367JbBeUUzOj2O3VKUoYRvc
 DML3ZrG9KvbRW6QqArcdGRV5N9M5dF59lhXhE7ufwmCNiFa9CCobJSudiZfXgKtQpKTH
 jhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995288; x=1720600088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IoSO2PAuZGif7rbZnYxoKrO42Ckut9KEDh24qTt2M7c=;
 b=RYNsILKeu9hnwh+gvngX5gFhTtDRdYdA8SNlMqL4kxSLbal8kyzRj9c87rVmMB78Lb
 n/mpYiIH5J9ZAD9+SSmTnxw6R9zmEpEfsyAbVPqKYDJ6AjxP88iMoVEWsnlXTE/xEUN1
 CyWzfl8hhqnnTKOVkic48OSnrbymbb1UgHNPrVZwcsRLttjOZU88lBlhhWBZhSEPAyAE
 qYAnJl1maf4EB9dO45MI8BYMOhLjj8jVTMSnXkOfCaNP+AkY6Js1+9vnsG0JjLvK18Pu
 S87svXbbl/GxcPQys1SPUPRES2MDMBjs2rcCI/zKbPTDD5VsYEu8SQaOV7PkfqqdNCvp
 dF2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8VMIVtLIv5qRtqWfN55737Ma/H/LtAHGhcjkhquvgSaCJlyJoxoP8zSl/Gc9QeMhZUxi6IkMDyvrQ5n8cCOEXj/HD4x0=
X-Gm-Message-State: AOJu0YyeEsfNVnSKKJtuU3fErKZNZKpghK+Tu6sS/ZiJPpP6TRPyMdLy
 tJ6nDAX3/PIKS6zC2W59B+dqCalqu5kGVPjnAWn85gP3ma+W84agSlFHmw==
X-Google-Smtp-Source: AGHT+IFoaQ/j9Fz8LeTPcZSUndcTZ4/93mft8cV0JMC7ylGPL6sUbq2yuJ9fa/mj2s2Jo4/wWVPVVQ==
X-Received: by 2002:a05:6512:2807:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-52e8266df15mr7589261e87.28.1719995288048; 
 Wed, 03 Jul 2024 01:28:08 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:b26:7100:7654:8924:d030:917?
 ([2a01:cb1c:b26:7100:7654:8924:d030:917])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36791d7a93bsm1332756f8f.81.2024.07.03.01.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:28:07 -0700 (PDT)
Message-ID: <263476c5-1136-4128-9d9c-76d107a78cf7@gmail.com>
Date: Wed, 3 Jul 2024 10:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
To: Yi Liu <yi.l.liu@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
 <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
 <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
 <6f94f4da-27fb-4f8e-adba-33a2f4c20fe5@intel.com>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <6f94f4da-27fb-4f8e-adba-33a2f4c20fe5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 03/07/2024 09:29, Yi Liu wrote:
> On 2024/7/2 23:29, CLEMENT MATHIEU--DRIF wrote:
>>
>> On 02/07/2024 15:33, Yi Liu wrote:
>>> Caution: External email. Do not open attachments or click links,
>>> unless this email comes from a known sender and you know the content
>>> is safe.
>>>
>>>
>>> On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
>>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>>
>>>> Signed-off-by: Clément Mathieu--Drif 
>>>> <clement.mathieu--drif@eviden.com>
>>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    hw/i386/intel_iommu.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index 98996ededc..71cebe2fd3 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -3500,6 +3500,11 @@ static bool
>>>> vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>>>>        } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>>>>            /* Interrupt flag */
>>>>            vtd_generate_completion_event(s);
>>>> +    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_FN) {
>>>> +        /*
>>>> +         * SW = 0, IF = 0, FN = 1
>>>> +         * Nothing to do as we process the events sequentially
>>>> +         */
>>>
>>> This code looks a bit weird. SW field does not co-exist with IF. But
>>> either
>>> SW or IF can co-exist with FN flag. Is it? Have you already seen a wait
>>> descriptor that only has FN flag set but no SW nor IF flag?
>> Yes, my test suite triggers that condition
>
> I see. Spec indeed has such usage. Please add a comment for it.
> Since it does not need a response, so QEMU can just bypass it. Also
> please adjust the subject a bit. It's misleading. Perhaps
>
> "intel_iommu: Bypass barrier wait descriptor"
Fine, will do
>
> Spec CH 7.10
> a. Submit Invalidation Wait Descriptor (inv_wait_dsc) with Fence flag 
> (FN=1) Set to Invalidation
> Queue. This ensures that all requests submitted to the Invalidation 
> Queue ahead of this wait
> descriptor are processed and completed by remapping hardware before 
> processing requests
> after the Invalidation Wait Descriptor. It is not required to specify 
> SW flag (or IF flag) in this
> descriptor or for software to wait on its completion, as its function 
> is to only act as a barrier.
>
>>>
>>>>        } else {
>>>>            error_report_once("%s: invalid wait desc: hi=%"PRIx64",
>>>> lo=%"PRIx64
>>>>                              " (unknown type)", __func__, 
>>>> inv_desc->hi,
>>>
>>> -- 
>>> Regards,
>>> Yi Liu
>

