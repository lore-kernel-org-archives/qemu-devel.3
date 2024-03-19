Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D2C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeZ4-0004rv-4P; Tue, 19 Mar 2024 14:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeZ0-0004nh-CS
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:51:54 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeYy-0007ua-M2
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:51:53 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29c731ba369so4493748a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710874311; x=1711479111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6p7+/y+sGFcXDnS2Rurl1GYR0YUYkAkZTkGg5ALOT2k=;
 b=plp0uXNwj4LcVL7JOGQeqCiXtS22gCUNTrG8YXGt0VbGwskfI52n+wvB7eFtL0Xyrb
 xHTGXEoRJ5VGtyI6FtWPltaEa5Edlkvo+hpC4K/ojkGrLIH6hl22Jaz4cNUdh6OLqkD4
 pflRsUq0JW5cNxj5DVIdGG+uHdkq+9RiuO39x4qo/2ONEfEkvMhUhIMCtYqeRdbxxsje
 QADdYA6WFXLItq0S6IxbKSB24zjHQ7OR/PmNLxDXUS4tafOLRm/mrBvlsiTzwqiruxVA
 X5tYZmS21+p5OCepZ6xoK+nw9wy+UFILBSB5XeSgZ4xicP+STZNV8kkDVJcCLqQI/+n6
 xjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710874311; x=1711479111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6p7+/y+sGFcXDnS2Rurl1GYR0YUYkAkZTkGg5ALOT2k=;
 b=RRL1zJT09LxYCDA0YcVfSXivRUHESj9R2IcD8+aegFktsFo1FI5GlqI0gZc/Rg9GLU
 dNk11iTLEtV1ZbrG89mW5i4C9/5RqmfnaCcCvOO8XnTfdVkyUPyIMJbN9SCUVY9Dee9A
 vWEI2MaREeIKRo2kbSEqsxeJwg8wEacTpmhGcQ9O21oB14iICvwpFI47+ZZYUObQTZbo
 ZWT4DOkotiXvfPC5jGs36ZwF/ow3vOEnEZ5H4qOMBAnETfx7OtZ7VVIWU2O4d8dnz8vW
 RJ5ANYG3QdvyImpyT8TKuzgSuKbXGE/8IXTtTTTXF+F3TYeLZj5hvQmT2LQn5UL56bg5
 auGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU3SOBZ2d+HIM/9R5nH+8EKN9Gq6QWSv+rY2G3278azsxOexF3vjOlkyuoLIzZFflinL7fhTllW/cOfOOiy6CXMmesQag=
X-Gm-Message-State: AOJu0YxZI8Xp6bnkX6GeNPRwE4QiPUl4aInfonDFnwunBnAa//EuEhcv
 j2pD4Eu4u0l3/wbX9L2ivLUkBdV0hzJu081W44H+r1Da+lhJXyyTMoAPMOHNbR0=
X-Google-Smtp-Source: AGHT+IFeAYnBNFrUW3N+NhFG+VRKjkXl80pCagL9yQuKsRzD8ue0lxRvJbCTHIv35y8VeetBkTvX3g==
X-Received: by 2002:a17:90a:8b17:b0:29c:776f:8911 with SMTP id
 y23-20020a17090a8b1700b0029c776f8911mr47097pjn.21.1710874311097; 
 Tue, 19 Mar 2024 11:51:51 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w13-20020a17090ad60d00b0029baef194f7sm9953012pju.38.2024.03.19.11.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:51:50 -0700 (PDT)
Message-ID: <cb5d981a-6db4-479c-9eaa-bca49c40bc72@linaro.org>
Date: Tue, 19 Mar 2024 08:51:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
 <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/19/24 07:28, Peter Maydell wrote:
>>       switch (excp_idx) {
>> +    case EXCP_NMI:
>> +        pstate_unmasked = !allIntMask;
>> +        break;
>> +
>> +    case EXCP_VNMI:
>> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
>> +             (hcr_el2 & HCR_TGE)) {
>> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
>> +            return false;
>> +        }
> 
> VINMI and VFNMI aren't the same thing: do we definitely want to
> merge them into one EXCP_VNMI ?

We do not, which is why VFNMI is going through EXCP_VFIQ.  A previous version did, and I 
see the comment did not change to match the new implementation.

> The use of the _eff() versions of the functions here is
> correct but it introduces a new case where we need to
> reevaluate the status of the VNMI etc interrupt status:
> when we change from Secure to NonSecure or when we change
> SCR_EL3.EEL2 or SCR_EL3.HXEN. We either need to make sure
> we reevaluate when we drop from EL3 to EL2 (which would be
> OK since VINMI and VFNMI can't be taken at EL3 and none of
> these bits can change except at EL3) or else make the calls
> to reevaluate them when we write to SCR_EL3. At least, I don't
> think we currently reevaluate these bits on an EL change.

We re-evaluate these bits on EL change via gicv3_cpuif_el_change_hook.


r~

