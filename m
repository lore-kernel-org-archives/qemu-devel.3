Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708F5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeNp-00009f-2W; Tue, 19 Mar 2024 14:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeNn-00009M-NY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:40:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeNi-0005mm-Jz
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:40:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so5462055b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710873613; x=1711478413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cxA7qF4mgrEANZPhHQUVl/tVPzqjuidaffO6pTsMZnk=;
 b=BqaqB2ynQQ9vCu4MISNLgAdk3CsnJYIy1gb5MEeVyPMQ5pWH/conk1PoD3hNHKtErV
 sqqay36DdwApYgKUZBTidHfHq2jjdUsp6ip00afal6kDfSnZuJ7HWRZjCp00SELSxerh
 Pm/CT98RP4IPEKIU/iNENp4Amc47HbdcwA86apXH8ywwhh/I2n1ErZY40gIqBpSMcpfF
 FSICj74OFj4051z8O34GWQFpJozf6NkODgob2kv7PE3FDQ2O9mRi3yiRddMLygCiY3RY
 YlkWECbm0Zu+8Am92ygcu5hLSY7QTjn2j5+hcVIkW20gCelV3zC7Iwx9aaupMYwE1aa0
 ykyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710873613; x=1711478413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxA7qF4mgrEANZPhHQUVl/tVPzqjuidaffO6pTsMZnk=;
 b=tnonbCykAyGOmpvMQGRASp0rij7sOdeVeVVhsmmyt4eUuawpRH4rvefbkubeXlPmY6
 WOg7yBBDVzYFqNhEdn32FdgkVYGC8lMVSOxmQRAoR6/cM7iNjcniWJ3IxO5LNvhxPLYo
 6xheW53yjuo7z9OUJCxc6qe4esLownK5BZUb/8hKqN4TqMbWdObJ8P3Db+eft/UushIG
 A+rcMINk6F3wUSrqZzObNcmKsrbbIkfHc2rrj/pLbaF2t35/PQh1FxBzpz+3OzU1DJJ7
 J5cV4LlS2YkpclD14PuJI48FUgxno85qiR9bVmDR0jfzr1EqZ/uVu1lvZ/pa7JtaS7AU
 L3+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcm0rKxTijgkqQ7lZZT8GygzpfrebUDB2fkiIeUXa/ORSV/kbacOzwc+pqfV46fY5+NlWyIVh6fkXaB/cN01uT20/FjAg=
X-Gm-Message-State: AOJu0YyzG9mFs9gY3fYPnoZj/7PmZLgDBPE3TU7arXO0NMRKhV/2+JsC
 ZxFzV6zZPxwWUrSqRWJgkJsbuEUPfQSfKJy9+an+yiKQuqHDEcFflynJCVF8Cco=
X-Google-Smtp-Source: AGHT+IHWZWIDpQA3yAiWYDPbdN6Fvz0Uudq5hI1AKy7ALdiU97T78dAQOC0TbzDpQdwkL2fra+psxA==
X-Received: by 2002:a05:6a00:138b:b0:6e7:4abe:85a0 with SMTP id
 t11-20020a056a00138b00b006e74abe85a0mr2200037pfg.14.1710873612879; 
 Tue, 19 Mar 2024 11:40:12 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o8-20020a056a001b4800b006e68bff396csm10022896pfv.215.2024.03.19.11.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:40:12 -0700 (PDT)
Message-ID: <d2aac7bb-9b97-495d-a203-0244a50a721a@linaro.org>
Date: Tue, 19 Mar 2024 08:40:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 06/22] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-7-ruanjinjie@huawei.com>
 <8d494fe8-c0f0-47b3-9f59-ac69f10c1e64@linaro.org>
 <CAFEAcA93HZEvVxFWE8GoCEZwOMjCVX-_EdOoubyGSyoMc+f6LQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA93HZEvVxFWE8GoCEZwOMjCVX-_EdOoubyGSyoMc+f6LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 3/19/24 07:03, Peter Maydell wrote:
> On Thu, 29 Feb 2024 at 23:02, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 2/29/24 03:10, Jinjie Ruan via wrote:
>>> +    bool new_state = ((env->cp15.hcr_el2 & HCR_VI) &&
>>> +                      (env->cp15.hcrx_el2 & HCRX_VINMI)) ||
>>> +                     ((env->cp15.hcr_el2 & HCR_VF) &&
>>> +                      (env->cp15.hcrx_el2 & HCRX_VFNMI)) ||
>>> +        (env->irq_line_state & CPU_INTERRUPT_VNMI);
>>
>> Because the GIC cannot signal an FIQ with superpriority, I think you should not include VF
>> && VFNMI in CPU_INTERRUPT_VNMI.
> 
> The GIC can't, but a hypervisor can -- it just sets the
> VF and VFNMI bits if it wants one. (Architecturally, the CPU
> has a FIQ-with-superpriority, it's only the GIC that doesn't.)

Yes, I know.

The point was not to mix (irq from cpu or gic) with (fiq from cpu) so that we can 
correctly determine superpriority later.

Another way would have been to add an fiq-with-superpriority CPU_INTERRUPT bit, but since 
there's only one way to get that at present, I thought the extra bit was overkill.


r~


