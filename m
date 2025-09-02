Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOSH-0005Rs-FF; Tue, 02 Sep 2025 06:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOSF-0005Rd-Gb
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:41:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOSD-0002DU-7r
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:41:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3cbb3ff70a0so3264576f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809691; x=1757414491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gUDo6zNB95Zm3AYI8zAP2Lnfdtiip0fMs9KZf4b+AmY=;
 b=eZNWnkrEb5/RUNaEtXdLU0v/YrzNSlNNe1RoILPV+iQboDHrEbUfTkXVfP5/Mk5/kI
 3L8lvAdXxHzXZUmzd8jCtZ3iTmGIAvPvCtz+P688h7DDRMQM3bpVj0gFctTvkJekXlPs
 Q42GTzb8kRFMoprA1c1z9loxY78+G2YgIES61+zAix4cYlDkp+d9gN6I2NhrrVkfUTs6
 IUaTLmAZqS2Ry4Ar8eBcvnv2dv6kqWoyw1MyXU5P74C+zbMAlEJlD/c2CGyGKYaygtnh
 FU1LooPRAnG49tugL2YtmP5ci47J7Vw9RluN0cg5M2SBikTR2FPWCKc9MC9grphnDV4r
 VJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809691; x=1757414491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gUDo6zNB95Zm3AYI8zAP2Lnfdtiip0fMs9KZf4b+AmY=;
 b=gj2Ffdx1+aiTsAPI+nwZNEx5HXTLvXrxJWvXH7rB8Zzb4bZba4EQmH/3pN2jL89ePc
 bvXYRpHKh+27mh6d5eP1SR1rNb+WgneoEuaOHytUTlDkLAo3q9K+4UiwIPCw4ctoLcl0
 OczjsWNVJ1X7gftDcqi9TMhWenCyYnoBDDk4DRxE36u84iaizuI7Q1F5ulyXgVgstA9p
 nArtqZfz7E0o0satI41umYaV+9jbt8zlPcyfD0NehnWmRsUFeiuLerWhzRratuWzswDc
 49moPWg2gnTRfMcmhOjs4Af72t5Y+xZVR7B0ny3hVkRelfZQovHVNXsOqmGeNuKXnRdt
 Bv1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoc5R9bpsaLXiF77Bp7uGvAYAPsfzjGcyvhxPTubC+GLfeIBcpULlRsJQtZc/6hdsLrNKn9HcL7U4s@nongnu.org
X-Gm-Message-State: AOJu0YwRjuakDN8CU5A0gTnpmDod+jFUm9Tac6M0K84hG/xf0iGJn1wH
 KTveNjpdw/s59XP0toDbgm/BVrfuxyHLx+5oNtAp7wND7APtki8bW1/a0OtTmzz3BfU=
X-Gm-Gg: ASbGncvhgPl02GrZQH6MPG+DSGFQKM1taMypcWDdDdDoqKQLdZm+GfK4Q+K9U3T9OXs
 GvTT19kyFQsr6fz9V6Q1NCcBLx9x1Px7Tl8IGxcTBdgwwobOqT2JnjBrKdYqEYTNIO1CsPtvCwu
 fUI9FFmcHyrnyDTQSMfribPfPWhF1+h0CwKKTPp5oZA2YPcvn1gHz1RxNiuq4FdJypzaJyKSY2W
 fwJI3pviIwinbluYeJK/vXdmldnoyS+bGQmF7qYNzTV32x+z6g2nwI7Hz5D29WOkwXLIqnWNKQ0
 4RF+HFDjBnjZmg1STXATdWrnw8ppTZU8/sOgdB0oifsrSBg4LalDhky5Uq+n9wI6INBFeKuHiX7
 fx+j5hsqM9st0vI5z4nRz08C7X7xF6afnohYfs5v3LDhzNnIwTLgU/Mo+KCaRatkoAFOnNHqeMa
 GLzpLsTsdDivA=
X-Google-Smtp-Source: AGHT+IH7s/WFoU74pm+CIlexktvXeNeXMou0UYvSY//nDCSNwRJWsAUuM7al3vdwSrlhCVbi/Y5H6Q==
X-Received: by 2002:a5d:5d86:0:b0:3d7:2284:b06 with SMTP id
 ffacd0b85a97d-3d722841157mr4691447f8f.24.1756809690641; 
 Tue, 02 Sep 2025 03:41:30 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm38469815e9.3.2025.09.02.03.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:41:30 -0700 (PDT)
Message-ID: <54fe9253-1e34-4411-afaa-4c17f2040fa0@linaro.org>
Date: Tue, 2 Sep 2025 12:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
To: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Thomas Huth
 <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250807110806.409065-1-lvivier@redhat.com>
 <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
 <20250818140313.GA7391@fedora>
 <CACGkMEvUq4ugS6PQ=mRH5Kx+rnDda5Wq3K8hSVrehv3=n5xk4Q@mail.gmail.com>
 <52f9eaaa-cf33-4558-b869-f4f66844f92e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52f9eaaa-cf33-4558-b869-f4f66844f92e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/9/25 13:57, Laurent Vivier wrote:
> Hi Jason,
> 
> On 19/08/2025 04:46, Jason Wang wrote:
>> On Mon, Aug 18, 2025 at 10:03 PM Stefan Hajnoczi <stefanha@redhat.com> 
>> wrote:
>>>
>>> On Mon, Aug 18, 2025 at 10:08:18AM +0800, Jason Wang wrote:
>>>> On Thu, Aug 7, 2025 at 7:08 PM Laurent Vivier <lvivier@redhat.com> 
>>>> wrote:
>>>>>
>>>>> A race condition between guest driver actions and QEMU timers can lead
>>>>> to an assertion failure when the guest switches the e1000e from legacy
>>>>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>>>>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>>>>> the pending interrupt cause can trigger an assert in
>>>>> e1000e_intmgr_collect_delayed_causes().
>>>>>
>>>>> This patch removes the assertion and executes the code that clears the
>>>>> pending legacy causes. This change is safe and introduces no 
>>>>> unintended
>>>>> behavioral side effects, as it only alters a state that previously led
>>>>> to termination.
>>>>>
>>>>> - when core->delayed_causes == 0 the function was already a no-op and
>>>>>    remains so.
>>>>>
>>>>> - when core->delayed_causes != 0 the function would previously
>>>>>    crash due to the assertion failure. The patch now defines a safe
>>>>>    outcome by clearing the cause and returning. Since behavior after
>>>>>    the assertion never existed, this simply corrects the crash.
>>>>>
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
>>>>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>> ---
>>>>
>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>
>>>> Consider rc3 is out. Can this be applied directly by maintainers or a
>>>> PULL request is expected?
>>>
>>> The commit description doesn't mention whether this fixes a regression
>>> introduced since QEMU 10.0, whether there is a security impact, etc.
>>> In the absence of more information, this looks like a regular bug fix
>>> that does not need to be merged for -rc4.
>>>
>>> Only release blockers will be merged for -rc4 (Tue 19 Aug). Please
>>> provide a justification if this commit is a release blocker. Reasoning:
>>> - From -rc3 onwards the goal is to make the final release and adding
>>>    additional patches risks introducing new issues that will delay the
>>>    release further.
>>> - Commits should include enough information to make the decision to
>>>    merge easy and documented in git-log(1). Don't rely on me to judge 
>>> the
>>>    severity in areas of the codebase I'm not an expert in.
>>
>> I see, I think it's not a release blocker so we can defer this to the
>> next release.
> 
> just a reminder not to forget to pull it now...

Since Jason Acked the patch, I'll merge it via my hw-misc tree; thanks!

