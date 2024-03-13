Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C11C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 16:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkRWy-0007qi-N7; Wed, 13 Mar 2024 12:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkRWu-0007oW-VW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:32:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkRWr-0002Yk-SW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:32:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e94c12cfaso959685f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347552; x=1710952352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uLdp+4a29Jj1iGtXidLzisuCYYorO5rJNzr9LgiJdHA=;
 b=Bs2X2+GLz3OgFLbbT5OPS/bJkd7yhYncsyrITCX1nJhdXEtdyOTl3AE4z16GQr26N7
 Z9erL4JG8f07GPNlL6gHhpjSYdR2KaEXiWoYhg0bh4Ug0ynxm92OzmZMDwfoRUZPqnKN
 c3mQjNXe41MiXmxrfijSAfQb9PpvJ7IqaB1zrNLkdqtTgZ1sA6zvLrlFoFs+fkaeMXJV
 E4LuNH7agnMCF4RyX55/rttXl3fXQx8p6vAs+qnLESmf7e7HX8JWEWFMBxTWmQxsNxhp
 3BKsC7hlns079wCAccst/GhoJz58EXQhKFOgbFAp153MEnI5OkUdDA+ruOs7fczQ6WTI
 bcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347552; x=1710952352;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uLdp+4a29Jj1iGtXidLzisuCYYorO5rJNzr9LgiJdHA=;
 b=ZPCZcchoc5T/GKFMr/kaPSPK+7clGGarl+qnSZC/0YMhjgtp1Qfrm7azyl0nBmZ/z/
 A4LHxuJOYWRFr7KxtEAYlzqQ4yRoPzsb1/7Y+1oNvLy3f6PsMamEWskmUiBNLCJ1EX0d
 kb6OnWz3nCgRCuLcG0NLDeb0ZF1+SmYufLNbj8fH3Cn2eWTM69O3Yr9sFTh2uouAPbq3
 s+gBo0tM8Wa8RIbjuFHAiX4+WdurMag6/Szp/S7OwX439i4xwv6PJ717zhTdYD62nC/Y
 uIVM/DKnFiwIOQ5RDuMa7qwTwbp8jWqXpWfWSwgO1oLAx+Olq8ZT7C4dFDm2O1IuoIfh
 dfMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW27FFAizgSBJFLl7joUgafs/+HvAHQ1n22n8UthHlGAnTFWqEJ3iuDFCkJodNZNwCvYtU9vqnMTlDGGezKxsz1369ODM=
X-Gm-Message-State: AOJu0YwZqyF0SeRmdOR0vtaWz5F2e/dD0/Q9dSH1K3zN8YGd44agJlfy
 m6b//J6zH7G8BSX3IUIqqV2jdwXWV2Dwg480wFUpKy6YRgu+OrdJjHaqK4Yh5+U=
X-Google-Smtp-Source: AGHT+IFZ/uWW3F31LDIVpg01gRiTGiGQ271BwaBNc0C/1TmfQaAupYlg3Gp3RBWLGtAFVbIAP5dI3Q==
X-Received: by 2002:a05:6000:192:b0:33e:77b5:746d with SMTP id
 p18-20020a056000019200b0033e77b5746dmr1992530wrx.18.1710347551939; 
 Wed, 13 Mar 2024 09:32:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bv10-20020a0560001f0a00b0033e033898c5sm12127389wrb.20.2024.03.13.09.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 09:32:31 -0700 (PDT)
Message-ID: <3f99efda-7ceb-4632-9701-739a1955614f@linaro.org>
Date: Wed, 13 Mar 2024 17:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
 <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
 <8c197bfe-0cab-47dd-beec-c9752d434a47@linaro.org>
 <fe2abd47-be73-496d-94a4-0b6d95f31bd1@linaro.org>
 <06fb4fce-fd61-4813-9bbe-aeffdd5fd429@linaro.org>
In-Reply-To: <06fb4fce-fd61-4813-9bbe-aeffdd5fd429@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/3/24 16:06, Philippe Mathieu-Daudé wrote:
> On 13/3/24 14:39, Marcin Juszkiewicz wrote:
>> W dniu 13.03.2024 o 12:44, Philippe Mathieu-Daudé pisze:
>>>> -        :avocado: tags=cpu:cortex-a57
>>>> +        :avocado: tags=cpu:cortex-a57,os:openbsd
>>>
>>> IIRC for some reason we must use one tag per line... Even if
>>> named 'tags', this is handled as a single tag, so we couldn't
>>> filter on "os:openbsd". We need:
>>>
>>>    :avocado: tags=cpu:cortex-a57
>>>    :avocado: tags=os:openbsd
>>
>> OK. It worked when I tested this way:
>>
>> $ make check-avocado AVOCADO_TAGS='machine:sbsa-ref,os:openbsd'
>> [..]
>>   (1/3) 
>> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_cortex_a57: PASS (16.18 s)
>>   (2/3) 
>> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_neoverse_n1: PASS (16.06 s)
>>
>> $ make check-avocado AVOCADO_TAGS='os:openbsd'
> 
> Oh great news, TIL!

Still thinking a bit about it, using one line for one tag
reduce patch churn when adding/removing tags, and eases
rebasing / cherry-picking.

