Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762E9C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwEL-0003WE-Cr; Wed, 19 Mar 2025 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuwDm-0003DF-Ud
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuwDi-0008Js-94
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+BPo7DV4isdCerOqmtm4s5LeZq5pcN2etZ3ZBw9b/A=;
 b=DLCljeTYmAL9qN8NAEDiV6YPj0SdRYm/N+7rFlVsnLWjoiXwvjCalp5er3em12cZGN3+nW
 7LvM0GX7OPsW9bij0qnLkUvD7S7q2Fh1c5JV00SYXtJKvJgRhX95CATmKgVEDs0MM6SXu9
 m/4XByOZYl5sC7BhZaPCsaeJQvAlROA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-DThh2ai0PZSU9lqyKIXjbw-1; Wed, 19 Mar 2025 12:24:36 -0400
X-MC-Unique: DThh2ai0PZSU9lqyKIXjbw-1
X-Mimecast-MFC-AGG-ID: DThh2ai0PZSU9lqyKIXjbw_1742401475
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85db19e5e0eso648825839f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401475; x=1743006275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+BPo7DV4isdCerOqmtm4s5LeZq5pcN2etZ3ZBw9b/A=;
 b=iwpI0WLhhCft9YsNj2fdj8Ff2f3QtGKE6mREe04zslBfJuHRLNZg5CraEUi5+pOuTE
 4ES56Pat+bR1XrcuFYZuPSZ42h5SDlyNGI8MMxPfEm0Fi65KfyUQkn4dUUbZFXKPlV99
 A6lJd24FDhln9NYzNRDYe4zpS3jG6NSW9Z99GByXM+Oa5doCo7En5YLMyud6nUEm0bAp
 aAuV0xceNqoHjmWw9xGGYSTrWh9tGqG85tDrFjA2Y8xKU1/7gp7IURC/RZJZFyDwcH6K
 HO2PCrtmzkQkFi/Uom59NDf5CapAUv1AqO13y/lGHaeCpIKB8eSY1dB4iMizkSizU/pk
 c1Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVov7yh7+p7T1vvUewf0oWQanAc6yoqFot5DlXne09n2cPC4n0bz56UVF2tTigW1phPwE1tRfarp/CT@nongnu.org
X-Gm-Message-State: AOJu0Yz2ZYhzrSn15rns6HhGwBF0X9OddQUvVQYiZgXxa3BKTzRt9LSn
 lhGgQjqkBmkBP/vDQxztmW3vZDhftXDNQwO7G8MA4bg3M4j/SmXIErNGXJ8ZLL6UI560SceeD4L
 H0Ozn0SyfjH/0t3pZpi2NtRO7pdEEdkLVjsqL0lhQ/FKH45WnRg41
X-Gm-Gg: ASbGncvIsd0QV4xhHMp/X6DXyntScaUOAN9LJ29qvWSBUqa1mC0ooS3SR2Rdkn2YKCX
 FkyjW1PCSC+4VgJBOOUnV4pTilNy90kODk+A6ikxcOxnjrxHmiYCHi93nBlzHKeED6Wfw+SN2G8
 EQRtDCqMZYgvw1kcwuofwTWhKOcpZxHXRECB4QPVSkAEJprPwW+yv6JnbJsd6iGh/The6uBJBu/
 HcbPVnhPw5e6+QLjTnULYrh94I6VAuTqhfZC2njMXLgcqNaVlJaSlrcTqnzbuE7k1PcnQ3EleWA
 CmQzhv7/NgNb/Dgk
X-Received: by 2002:a05:6602:378d:b0:85b:601d:dfb3 with SMTP id
 ca18e2360f4ac-85e137c0ce7mr396476439f.5.1742401475308; 
 Wed, 19 Mar 2025 09:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjxszjskMMHgJqdtxbQyTAYt/R3aJD5w/JW4UaSZna/EsbTkIMn907ESurQayJgeXsC8ABlQ==
X-Received: by 2002:a05:6602:378d:b0:85b:601d:dfb3 with SMTP id
 ca18e2360f4ac-85e137c0ce7mr396473139f.5.1742401474938; 
 Wed, 19 Mar 2025 09:24:34 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f290aa0e42sm1655305173.61.2025.03.19.09.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:24:34 -0700 (PDT)
Message-ID: <16998464-b8d8-459b-80c4-69da2cafa477@redhat.com>
Date: Wed, 19 Mar 2025 12:24:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
 <28452954-7be2-4114-8d37-a208250b6f83@redhat.com>
 <42f9953fc7dd40d9bcd4919914530b89@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <42f9953fc7dd40d9bcd4919914530b89@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/19/25 5:48 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Sent: Wednesday, March 19, 2025 1:31 AM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers
>> to batch and issue cache invalidations
>>
>> Shameer,
>>
>> Hi,
>>
>>
>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Inroduce an SMMUCommandBatch and some helpers to batch and issue
>> the
>>     ^^^^^^^^ Introduce
>>> commands.  Currently separate out TLBI commands and device cache
>>> commands to avoid some errata on certain versions of SMMUs. Later it
>>> should check IIDR register to detect if underlying SMMU hw has such an
>> erratum.
>> Where is all this info about 'certain versions of SMMUs' and 'check IIDR
>> register' has something to do with 'underlying SMMU hw such an erratum',
>> -- which IIDR (& bits)? or are we talking about rsvd SMMU_IDR<> registers?
> 
> I guess the batching has constraints on some platforms, IIRC, this was discussed
> somewhere in a kernel thread.
> 
> Nicolin, could you please provide some background on this.
> 
A lore link if it's discussed upstream, thanks.

>>
>> And can't these helpers be used for emulated smmuv3 as well as
>> accelerated?
> 
> Could be I guess. But no benefit in terms of performance. May be will make
> code look nicer. I will take a look if not much of changes in the emulated path.
> 
Thanks for looking into it.  The push is to use common code path(s) to invoke (or not)
an accel path.

> Thanks,
> Shameer
> 
> 


