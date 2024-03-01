Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938CDC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6wP-00049J-Kg; Fri, 01 Mar 2024 12:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg6wO-00048E-0x
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:45:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg6wM-00009k-Do
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:44:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1748183b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709315097; x=1709919897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnZmTKzygX56ppgLY7ShI3HckZ75xFz/UpH6ipSd57w=;
 b=y5ZNZgrymeiy6TZenDKN2uFe7oF90D8OaLj0xvZ6nhCq7wNKPlpATRpzGyr+ECmLhL
 2Lh+hoMG8S9i0szmxcRGBw8PuqmG5ENOYLqafqPi6AVLpg2KA80P/DupRhmSKx6+fBkW
 OYAUARG0XfifBjqDwRo3SBDWvy5yqQf9vhGqIk8KO7PlxHULPKRrk9+USHOklQ+uoNbr
 dzql9ZZqxvH3+osbaFQzrJdTKtTxMygm/eXaUzEyTywUkJSUcgvYeFYAsUx0BTHNPbbw
 qesFMXK2vZyAMxemDgzoPdlANZ4R9CBCWcRlKNCENnkuZxtW8TP8MeUIXuPayRERrThA
 f53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709315097; x=1709919897;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnZmTKzygX56ppgLY7ShI3HckZ75xFz/UpH6ipSd57w=;
 b=IHCapzhm6hx8tkP4FkpOMxyMyBd/76CS/2JpW+zMtRemnDwAQ3KFJLKsx62JXftjI2
 t9Ck4KvrFYHqsGK1Sibxao5Hio0kRJeyvKMvQRq/ro7IVoxSB99VXlu6uO/l/sy3CvXl
 +ZbEyznCC9KUcp7KGdLzrceAedk1I6hrFMFrNHbinQFRNbx5Z1owVf9eXf6s9d1ZYRuf
 3n51fZ62YZmPtzgXbpU5GA1s13zYpo6F4+sUBHTj08YUiKNS9ABIlxmGTAxxCq71UKGb
 v3M5n5sjEegADZlYNGFPo+hEqWYPlFHfQP/IlpCSGhD1yq0Nay5QEoO10XExvH5huWuG
 5+Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUbrPVKFI+WtH3SuzTH8fkVEjDyplTkv7PxB3g/97do0Wy2sJwUZkLlFiw8upHZkfk8hVo32AbqoNocTsNqpQxVMx+0M=
X-Gm-Message-State: AOJu0YyePH0ruzYNkFdgB5L/Y/Xnj1D1onf+D1ObyOsD6EJEuDwwct0I
 RC/XYUQrSZMdf90XdZKCcJeMPET21REsUH2vM0dCs1NWjiCq7M7oUCDTx/23iEEYKyf6uHMaOXG
 x
X-Google-Smtp-Source: AGHT+IGdLCEa0j6WRuhoAP6yXyHNn811PdScQhIsxjIbdaPBHORg0VV2wAHWyLz/f+1LBfxrauksxw==
X-Received: by 2002:a05:6a20:38a4:b0:1a1:1f7b:9b0f with SMTP id
 n36-20020a056a2038a400b001a11f7b9b0fmr1839312pzf.42.1709315096798; 
 Fri, 01 Mar 2024 09:44:56 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 o6-20020a056a001b4600b006e56ff4f0bdsm3217749pfv.29.2024.03.01.09.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 09:44:56 -0800 (PST)
Message-ID: <1f5627a4-a96a-4548-90bb-97fe13c6ab4a@linaro.org>
Date: Fri, 1 Mar 2024 07:44:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 12/22] target/arm: Handle NMI in
 arm_cpu_do_interrupt_aarch64()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-13-ruanjinjie@huawei.com>
 <e7fd1fba-ee1d-4b78-b743-128fa8217ed8@linaro.org>
 <10add4f2-68c5-14df-59d7-f6e27457c8b5@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <10add4f2-68c5-14df-59d7-f6e27457c8b5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/29/24 17:42, Jinjie Ruan wrote:
> 
> 
> On 2024/3/1 7:09, Richard Henderson wrote:
>> On 2/29/24 03:10, Jinjie Ruan via wrote:
>>> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
>>> with superpriority is always IRQ, never FIQ, so the NMI exception trap
>>> entry
>>> behave like IRQ. However, VNMI can be IRQ or FIQ, FIQ can only come from
>>> hcrx_el2.HCRX_VFNMI bit, IRQ can be raised from the GIC or come from the
>>> hcrx_el2.HCRX_VINMI bit.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>> v4:
>>> - Also handle VNMI in arm_cpu_do_interrupt_aarch64().
>>> v3:
>>> - Remove the FIQ NMI handle.
>>> ---
>>>    target/arm/helper.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index b796dbdf21..bd34b3506a 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -11459,12 +11459,21 @@ static void
>>> arm_cpu_do_interrupt_aarch64(CPUState *cs)
>>>            break;
>>>        case EXCP_IRQ:
>>>        case EXCP_VIRQ:
>>> +    case EXCP_NMI:
>>>            addr += 0x80;
>>>            break;
>>>        case EXCP_FIQ:
>>>        case EXCP_VFIQ:
>>>            addr += 0x100;
>>>            break;
>>> +    case EXCP_VNMI:
>>> +        if (env->irq_line_state & CPU_INTERRUPT_VNMI ||
>>> +            env->cp15.hcrx_el2 & HCRX_VINMI) {
>>> +            addr += 0x80;
>>> +        } else if (env->cp15.hcrx_el2 & HCRX_VFNMI) {
>>> +            addr += 0x100;
>>> +        }
>>> +        break;
>>
>> By not combining VFNMI with CPU_INTERRUPT_VNMI, you don't need this
>> complication.
>> Just
>>
>>       case EXCP_IRQ:
>>       case EXCP_VIRQ:
>> +    case EXCP_NMI:
> 
> Not understand it. both VIRQ and VFIQ will set CPU_INTERRUPT_VNMI and
> cause EXCP_VNMI if they have Superpriority, the distinction jump here is
> necessary.

In my comment against patch 5, that's exactly what I said *not* to do.


r~


