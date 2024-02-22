Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC42C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdDyZ-00050J-Eu; Thu, 22 Feb 2024 13:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdDyW-0004zr-D9
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 13:39:16 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdDyM-0008N5-K5
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 13:39:16 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d71cb97937so765885ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708627143; x=1709231943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5w8L/FhZ1WzIaiqItJofMyraJS2uSRvjwOlAvu5YBeI=;
 b=mRYX2S1hWNfDSp2Rx5RsplaMYtV1RZKKxKIHe3iVXi3dGtg4EF9sI+aLfhUYIWAQkK
 /+NLK9tFfOZw/D1+nTTP62OLTc71wgV1EC1FgrMJhEpMPYkxx6DOB2eC+kXka9eo9/tM
 9VJtteiR17hRrf0bcRWozoQqcXPxrP977y7SmjpRnJHRRtZhLzx1s/s2v5hjl+sVIGMl
 xGW7h+vDYt5GQHDhqCKM89NHLPTfNET+E2ARRd7NjeEeSmzxz9Kf/sOJKDVxiCeC+1jv
 vasy/oY8lkyFOdYo+4wTJ4HW107LcZZsWlt/ReyYG0HRqVJ4RXXAZQ90gAmcoU96AGEp
 ir4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708627143; x=1709231943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5w8L/FhZ1WzIaiqItJofMyraJS2uSRvjwOlAvu5YBeI=;
 b=B8ZfXxwQAlBblwnCbcMLjax1G3p9RslamUCGZxS0eMUEoQvnnrpNkdHMNO8f/2+tKc
 lUngsYKLESZUBJ48Nzku2Q+snfxFSKy1dRh5nSjvkyj5PcyD8UZcJp1MhBQCL5L6XmRp
 HpA4maYYG5dkZ4+gFDz+VVPQwR9z2HCzUJifFBJZ6Pjucz90qr5pVpsyHwNkTpdYSmZi
 NYGSJ2SIaLnJqzwxefbbPzE+vWu40cnhgjd+d3u298INvrgRgxGqWw4Bx73mOSDFOVIr
 aB1R3YkaIfgEOtYIZguN2jWEhCejGNWH/8ZlgagOBTgUzdtNaoc+XF8zahNLAZS2D1Yh
 Wl9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6WzXscvyRH680jMNVESUo12xZZhCn8qpxgqwiNYMSNY2KYMdTTzi9bdj+lSi37Q2Ch6yCcOm9KH7kzMVhYzAMOtKIGd0=
X-Gm-Message-State: AOJu0Yx7GerFlmNDIv96LcJnnpNp3U6Joi/HzJyRCBDQpEMB3nOzxzkI
 tooV31CUXD4dAuD6qMXbnlxwjBES81kypeSbBzsfcFtVN5EesETwvRvnVjJOjPI=
X-Google-Smtp-Source: AGHT+IGkL6yO8fFzYOleF/EzSwgVBVkxnsfnw7W3YgLEcEP5/oB8r3q4GNtGk9AYXAP+jkEt2NnDHA==
X-Received: by 2002:a17:902:e843:b0:1db:ba1c:1b99 with SMTP id
 t3-20020a170902e84300b001dbba1c1b99mr18152775plg.37.1708627143636; 
 Thu, 22 Feb 2024 10:39:03 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d17-20020a170903209100b001d9ef7f4bfdsm10281083plc.164.2024.02.22.10.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 10:39:03 -0800 (PST)
Message-ID: <1b690345-55eb-4655-b0d8-b9cac39dd851@linaro.org>
Date: Thu, 22 Feb 2024 08:38:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/22] target/arm: Add support for NMI event state
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-8-ruanjinjie@huawei.com>
 <c02228ea-4f24-46f9-b6b3-34cba3059d69@linaro.org>
 <a4c733be-450b-4d28-b869-fd80630f3ecb@linaro.org>
 <fc4c1ca9-09bf-89c7-a2bc-521f7972766c@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fc4c1ca9-09bf-89c7-a2bc-521f7972766c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/22/24 01:52, Jinjie Ruan wrote:
> 
> 
> On 2024/2/22 5:25, Richard Henderson wrote:
>> On 2/21/24 10:10, Richard Henderson wrote:
>>> On 2/21/24 03:08, Jinjie Ruan via wrote:
>>>> The NMI exception state include whether the interrupt with super
>>>> priority
>>>> is IRQ or FIQ, so add a nmi_is_irq flag in CPUARMState to distinguish
>>>> it.
>>>>
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> ---
>>>>    target/arm/cpu.h    | 2 ++
>>>>    target/arm/helper.c | 9 +++++++++
>>>>    2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>>> index 5257343bcb..051e589e19 100644
>>>> --- a/target/arm/cpu.h
>>>> +++ b/target/arm/cpu.h
>>>> @@ -603,6 +603,8 @@ typedef struct CPUArchState {
>>>>        /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>>>>        uint32_t irq_line_state;
>>>> +    bool nmi_is_irq;
>>>
>>> Why would you need to add this to CPUARMState?
>>> This has the appearance of requiring only a local variable.
>>> But it is hard to tell since you do not set it within this patch at all.
>>
>> According to Arm GIC section 4.6.3 Interrupt superpriority, NMI is
>> always IRQ, never FIQ, so this is never required.
> 
> There is a bit of ambiguity here. The processor manual says that both
> irq and fiq can have superpriority attributes, but the gic manual only
> says that the IRQ has superpriority attributes.

Yes, it is possible to inject a superpriority FIQ via HCRX_EL2.  But you don't need an 
extra variable to handle this.


r~


