Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E9BF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJNg-0002vq-DJ; Tue, 21 Apr 2026 18:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJNb-0002vJ-Oo
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:15:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJNY-0005sR-Ci
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:15:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso63716815e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776809734; x=1777414534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEcT6Z9zHm5gjm4x1LoMjlZxu8dV3x4OWoRZ2dZxU4s=;
 b=SxXJAx6Z1VAQaGMD4euJuPrrj5XQOTLV7BZzALYB9/bQgxKyjCvT9nYik3CZidkbAV
 FgWPqdcyaM4CIoCIhxdTZ1EzXe56O2ToGdvLDQVNC84nUgFXX/zlv6eN4VxEgXC4YRFA
 DGOcoMdskjyMMhaNCvMjZnl34hZrGzDYctBqBl0EVt9xzmnnB6EOzhrACupIPGiFIvNs
 v0ENeth6KJbcKrmbTL/6Zc97lURm6imTdVBjInsKGD+KvtqkDl/BAzn1a74Jvq75Q3ff
 dTegI6BJZfX8nmKVHhTJIzG54gu7yEsTRvLKYjNzqzM95i+s/xN5fK4t8Qkf1Hn3CjTe
 yMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809734; x=1777414534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEcT6Z9zHm5gjm4x1LoMjlZxu8dV3x4OWoRZ2dZxU4s=;
 b=Bj85SeUYBaPqvzly5HBAqUWnAsdJCC0CCTIS0RbpUMw7/qPuIxrW2Mcl0M1T+/Q7E4
 Jq1vIALmmsghUBK56t7G08ovU5NRFEYEiAugi6iyE6YxO4zXz34dVzPfSo3+o7+z2OQA
 J+b25eG/mfGYbd0C4Sq+Xfs5bsC5OfLPNJwPtMZKWv5xDL1XXusoWss2n18myhWTGCBv
 jwlOipHnnpzWBkpE34C9zyZvr7T1Z40rX0nvFMfpG9EUJbD6LZSvwuqM+Xhzj7sRiK22
 PwWdWvYT4ePYRHdZKzKMqJFX41OVqS9GBUFbvoheCf0Jlz5kYA0kr3N+EAXzYLItohh/
 4G0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PCoCLOifhNGfcoE7nK4QTaB61gIaAHWTxyUC2ssr1QIf4jrqDsIi8NQcAe63BURiAC/z7mtU8vItH@nongnu.org
X-Gm-Message-State: AOJu0YzTKGmyaXoqO9cQ4EmJNNiiG2AySZcK5PyzEg7PsdlZLrtRJb3A
 2oEzK9vnUo+CkkrmMs5rfM/b5Shg2Rw3CYMtvYUL+2lDcH4xKVK5YTMb8DuCS18/+PA=
X-Gm-Gg: AeBDiesHqhKa6bLcoCDEY8R+gaehlqIHRCXRVazZT6MCNLpRA/IhxOIbm/4kgGpB6bi
 BdUzupqbiDaBJEgZvHqbk4yT5loL6S5pfHyd252nN3V50XPe5brMGNKAk+EsF7P/ksOaVfr9cnm
 R84h3JTTRqZkGfWqSneZbTY3J0Eb5vEqZAE6oaHYTOPYguYEyJTWZNsasLT6f67pznCWFrzTxGY
 y5+wuRA95BOaluz+yHhpx4X87gAy2AwRQIaYmsV2qPVIpoc8lfVNynAFA0y3G6D5aNqiwvzsc/9
 MQFAjy/TaazuxtEgiDweBKNAfAt0WAgZkclthZuvmKhDZdh6NNqDMpw+5UYO4jg4U5ayKATDZwh
 RK7vHPZC96CJcnsTzDv0PMiCFlmNlDwxj6Ro59F3oGVb50lwkartdazPfIMj3Ft0ZNid98embeu
 UcTn9qOZ9rbvwt/br9liVUhnWvzrdkDq9K44gLOlcpJ902n9wur/qT054lTZ/f4SfE6N3y25FUj
 IsR
X-Received: by 2002:a05:600c:444a:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-488fb793580mr261690935e9.31.1776809734007; 
 Tue, 21 Apr 2026 15:15:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e591cesm54373124f8f.36.2026.04.21.15.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:15:33 -0700 (PDT)
Message-ID: <5519481d-371e-4b6a-b281-06baf5d1d429@linaro.org>
Date: Wed, 22 Apr 2026 00:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
 <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
 <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
 <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
 <01eb4b4a-b77f-421c-8ff8-bbd061482c8d@linaro.org>
 <082b5146-23ca-422f-854b-807ceab50427@linaro.org>
 <0dccc934-78f3-4423-8a75-214243f6f855@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0dccc934-78f3-4423-8a75-214243f6f855@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/4/26 23:44, Stefan Berger wrote:
> 
> 
> On 4/20/26 4:31 PM, Philippe Mathieu-Daudé wrote:
>> Hi Stefan,
>>
>> On 28/3/26 00:37, Philippe Mathieu-Daudé wrote:
>>> On 27/3/26 19:17, Stefan Berger wrote:
>>>>
>>>>
>>>> On 3/27/26 11:21 AM, Stefan Berger wrote:
>>>>>
>>>>>
>>>>> On 3/27/26 11:18 AM, Stefan Berger wrote:
>>>>>>
>>>>>>
>>>>>> On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
>>>>>>> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
>>>>>>>
>>>>>>>> Philippe Mathieu-Daudé (5):
>>>>>>>>    hw/tpm: Factor tpm_ppi_enabled() out
>>>>>>>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>>>>>>>    hw/tpm: Remove CRBState::ppi_enabled field
>>>>>>>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>>>>>>>      TPMState
>>>>>>>>    hw/tpm: Simplify tpm_ppi_enabled()
>>>>>>>
>>>>>>> Series queued for 11.1 (typo fixed), thanks.
>>>>>>>
>>>>>>
>>>>>> Here's another TPM PPI related series. It would make sense to 
>>>>>> upstream them together. Do you want to queue that one as well?
>>>>>>
>>>>>> https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi- 
>>>>>> v2-0- d8ec84d25dbc@redhat.com/T/#t
>>>>>>
>>>>>
>>>>> Actually, they will have to rebase on this series first...
>>>>>>
>>>>>
>>>>
>>>> v3 is good now:
>>>>
>>>> https://lore.kernel.org/qemu-devel/20260327173209.148180-1- 
>>>> mbawa@redhat.com/T/#t
>>>>
>>>> If you want to take it let me know, otherwise I will have to wait 
>>>> for your series.
>>
>> I'm not seeing your R-b tag on v3 on the mailing list, did you
>> sent it? (asking because the list had some issue the last weeks).
>>
>>>
>>> Thanks for the head up, I'll queue it along and send the pull
>>> request after 11.0 is released.
> 
> https://lore.kernel.org/qemu-devel/20260327173209.148180-1- 
> mbawa@redhat.com/T/#m42a888b82b87432799e53c0426e65f95e9a27708
> 
> All 3 patches have my R-b as far as I can see...

Indeed, even in the pull request I prepared... I suppose I was
looking at a previous version 🤷‍♂️ Sorry for the noise!

Waiting the git tree to open before posting that PR 🤞🏻

