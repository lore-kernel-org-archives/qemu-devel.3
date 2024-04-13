Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41EDC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 09:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rva0K-0002TN-As; Sat, 13 Apr 2024 05:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rva0I-0002St-4E
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 05:48:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rva0D-0002lz-Mx
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 05:48:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-343cfa6faf0so1350270f8f.0
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713001732; x=1713606532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXdpzhcljKxwFeCjPC31atfXxlX/3Lka6nbkKu0vUDI=;
 b=y9Q5H+RXmGg+kZU+xjugYm1vMROZ5okChxnPJQiPEufqUiEc2NKRVoCQMb1se0QXoi
 YvRYM7hYCygC6OocNI4cdypVtSVO5LtYZ21u0Su5FWvysEYuzfqjNSCL48rBWJfaK0HA
 I0w4HlMZaX7NRtVUsfr+1dRcBjm9rJrp7p5G8OW0WlRNTTGwsY5KjdLhkcSwJ699Ct6Z
 buOGNTwuak5ky/Hz2v5QFzfdkMwyNgR0F8pOethzhgZnbUjqNPlbTAtxpmMhHFy98lXN
 vIr1x7wu8Sic87r3g0qit9V+rdkoYpa3Wdg2zuJEvslehmUZtASpepmvyPwMOA69wp3+
 UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713001732; x=1713606532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXdpzhcljKxwFeCjPC31atfXxlX/3Lka6nbkKu0vUDI=;
 b=rTMrKKwxm9otWCOoNxBNKad8/iXaCm9+jkkWD4/Dq6F1Ko0flhUcegJjGHnoKrlx0X
 qSoLcLq1Fj//Cdcv8/yMw77iaDInRs6b3fLDYxEciCnGwjjEBvRv11bkkwpuW6y5uvBV
 Rt8bpPoLbIRF6pT+gWRDnLdwUufFTBBd9/N93EOkVjbdLXGTzbMQZmYdFlJ/2TWKAkOL
 /PpTj4K7CTeqOhjt0fExaJbimnSiHRRK+cRWg14Vhoilv/RNinfnPYUyZcDWn25r8vGr
 42leZdw5asgWDWhOVKs/ncA4aQq0eTjzS0Q3KWfBXZcXKrSHy5hSjxvnLi2H4dj4DNcI
 jAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxZjjO7sJEYhkzx3OYEpg7X1qN4A/V3+LbxkdYI84C8gIVuTrvANT6K0X/tNDDLjrV1AXjvafVCPKAZ4JSkpQc3yd5hJA=
X-Gm-Message-State: AOJu0Yw6rePjC3jeeWkyPFd3zAROR9xQikpGTLLt93dF2SDqgvmrwr7X
 5gkM/7uZsMvBjFjQguHB2jdoccJxhSKHZsehQ9NhfXHxH2J+CFSOcHfFnYUDz9w=
X-Google-Smtp-Source: AGHT+IFdgfFJmMCzuCBCCHwf4X7LqDyN5gZrDqWkMitQ/4Tih71y1E4Refu1nrLTQycJ8M5VK2LgDw==
X-Received: by 2002:a5d:4049:0:b0:343:6b76:251f with SMTP id
 w9-20020a5d4049000000b003436b76251fmr3872935wrp.42.1713001732191; 
 Sat, 13 Apr 2024 02:48:52 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 k5-20020a5d66c5000000b00346406a5c80sm6143871wrw.32.2024.04.13.02.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 02:48:51 -0700 (PDT)
Message-ID: <fad7296f-1870-4b87-9b05-e367c7422d14@linaro.org>
Date: Sat, 13 Apr 2024 11:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw: Fix problem with the A*MPCORE switches in the
 Kconfig files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240412062042.105174-1-thuth@redhat.com>
 <20240412062042.105174-2-thuth@redhat.com>
 <35ea1f53-5c7a-45e8-9fa1-0df8fc7a0cba@linaro.org>
 <f75a5002-8292-4383-9d62-ebd8f3587c20@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f75a5002-8292-4383-9d62-ebd8f3587c20@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 12/4/24 13:32, Thomas Huth wrote:
> On 12/04/2024 13.10, Philippe Mathieu-Daudé wrote:
>> On 12/4/24 08:20, Thomas Huth wrote:
>>> A9MPCORE, ARM11MPCORE and A15MPCORE are defined twice, once in
>>> hw/cpu/Kconfig and once in hw/arm/Kconfig. This is only possible
>>> by accident, since hw/cpu/Kconfig is never included from hw/Kconfig.
>>> Fix it by declaring the switches only in hw/cpu/Kconfig (since the
>>> related files reside in the hw/cpu/ folder) and by making sure that
>>> the file hw/cpu/Kconfig is now properly included from hw/Kconfig.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/Kconfig     |  1 +
>>>   hw/arm/Kconfig | 15 ---------------
>>>   hw/cpu/Kconfig | 12 +++++++++---
>>>   3 files changed, 10 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/Kconfig b/hw/Kconfig
>>> index 2c00936c28..9567cc475d 100644
>>> --- a/hw/Kconfig
>>> +++ b/hw/Kconfig
>>> @@ -48,6 +48,7 @@ source watchdog/Kconfig
>>>   # arch Kconfig
>>>   source arm/Kconfig
>>> +source cpu/Kconfig
>>>   source alpha/Kconfig
>>>   source avr/Kconfig
>>>   source cris/Kconfig
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 893a7bff66..d97015c45c 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -678,21 +678,6 @@ config ZAURUS
>>>       select NAND
>>>       select ECC
>>> -config A9MPCORE
>>> -    bool
>>> -    select A9_GTIMER
>>> -    select A9SCU       # snoop control unit
>>> -    select ARM_GIC
>>> -    select ARM_MPTIMER
>>> -
>>> -config A15MPCORE
>>> -    bool
>>> -    select ARM_GIC
>>> -
>>> -config ARM11MPCORE
>>> -    bool
>>> -    select ARM11SCU
>>> -
>>>   config ARMSSE
>>>       bool
>>>       select ARM_V7M
>>> diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
>>> index 1767d028ac..f776e884cd 100644
>>> --- a/hw/cpu/Kconfig
>>> +++ b/hw/cpu/Kconfig
>>> @@ -1,8 +1,14 @@
>>> -config ARM11MPCORE
>>> -    bool
>>> -
>>>   config A9MPCORE
>>>       bool
>>> +    select A9_GTIMER
>>> +    select A9SCU       # snoop control unit
>>> +    select ARM_GIC
>>> +    select ARM_MPTIMER
>>>   config A15MPCORE
>>>       bool
>>> +    select ARM_GIC
>>> +
>>> +config ARM11MPCORE
>>> +    bool
>>> +    select ARM11SCU
>>
>> I thought 
>> https://lore.kernel.org/qemu-devel/20231212162935.42910-6-philmd@linaro.org/
>>   was already merged :/ I'll look at what is missing and respin.
> 
> Oh, ok. But I'd prefer to keep the hw/cpu/Kconfig file since it will be 
> used in the 2nd patch here, too.

Fine,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


