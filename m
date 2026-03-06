Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77E0FCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZGe-0004xt-14; Fri, 06 Mar 2026 12:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZG3-0004mn-8H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:46:40 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZG1-0006J1-Aq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:46:38 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3598b2318c2so3592351a91.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772819196; x=1773423996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BgkS2zNtivFEOfDi+Lk+jx5/Bi2g70++M/SqCD2AsU=;
 b=VLw2STP5HH3NWhQ8k6lgKV4xjkuCEE3z5QnrynJSa/8J4JMQwYN7Z4u5sulkHA6VPl
 2Xd17OFHZRSFOqdyKSl6/UzcIggse/Yd/jeRmv16eos/uDSV8e0oGGj2SEP4t6WVmAWO
 Zhp5uZrVLFkIY5mZbq7qe6ANRvZqTAolI+nMLykcTZI5PMcvipENmcV7uPWvND/SSbhm
 8BdiZiZ8cwHqOqp7uJno7yRuDip+xrYZa/nxR5y0bXQIKfdisa+OF2kFOP3wA2fOiPtW
 jJnWQjNLnzIwRZCkr0TIprmdep4mTc/q2efNwoaGluk+BxlKX3yKo6QGoTExWGfgPmLS
 zBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772819196; x=1773423996;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3BgkS2zNtivFEOfDi+Lk+jx5/Bi2g70++M/SqCD2AsU=;
 b=EfceHPD3v5TVuUOpTpCltd+3ZpVJsLQRfCEmHZDYFcesRJpI5ShnlRNDBM8C1MBt9v
 vj9AFuQQbp770x2HDR2q6k1i4P0+VpmLA96o76t/kLA7iCNNoAoAIA3g/ypRu2THNcY+
 Z2pC0tQ81OeUxq9NPrQVomVnKjXzsoI77SNfucNj7G/ax0zw9KcAqCjLt1wYCJ+GQoZ9
 cpH/Bsk2/kK+HTCcayCMbnNHFI3buZMNd4h8MqwE1SQYQ9kkCTUanq8G7zmwuIFAq5Wa
 aPZ/T6pQ1gO/ULN3E3AMnWaYK7QkTvkrnLhWvbkpKETUZQslb0COA3x2RGECLI2gMHdp
 5nFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP/2czDsPp06XtbQyCGTCQX7tO9nxTxxPCv+8iDSfAulthbv6YKC6ZSPsmnM3HWVw45Sln6WoBe02E@nongnu.org
X-Gm-Message-State: AOJu0YzK5+7ip/ATBdMhf+H4zCE5DM5pJgViP21w2zih7vCP/I2Ux9bw
 8+BaNaqmAkUFyzjwZAHyuzarnF+J2Df8CjrjUy6RS3CtgCrTrlib6LFJ9sDMF44R/HK5NCfYzER
 r58he
X-Gm-Gg: ATEYQzxB98H4JxzhTZ5bnFxIqszDrQjY6AWEr1sx4xePM7wu+33G7KJRD+cjrPfVUYg
 n6ouI/5sYj043F7IRApdLbzZriwbvkV2E58WWaPRX91OwYBT3nHM2xfgOVnqMW0gbgvIG+RuWKc
 SbJF2HGxNssngeujT2UEHoWFblwowcRaJgzZVaVBZkVZhDtqEwRG/EMTwq6yc25HGwRGAE64dgw
 1acPtKh2omS05a6iO18thdRKnxC2FP6hCecKzEdNWPmyzcvAxLO8JTs3zLObjR+oLUGbDacPeko
 a1hqIMCDZNvWcbbj9tJam7ZSt2KsH6fv6YUqgOs2xRod6Rhsbx/QJKwn33G/Tlep8381X4eXDWG
 hKypEHpGp83Pkk8joy9hPFtDoTjyVn2vY517kLfHZH1B4sqvBSb+PhqGIqjrBGTFoKgq9CrStGi
 x0/eIUPWLPgqbUxmZ501wSPb3ow5Ggv5oiXOFyJ/tewwAtI0KABYcTzHXXcX1lUEFswbrt
X-Received: by 2002:a17:90a:da8d:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-359be3475c1mr2631940a91.22.1772819195734; 
 Fri, 06 Mar 2026 09:46:35 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359c0179a67sm2462491a91.13.2026.03.06.09.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:46:35 -0800 (PST)
Message-ID: <d7ef44e6-4883-47e0-8f13-90ac9e0e3df1@linaro.org>
Date: Fri, 6 Mar 2026 09:46:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target is
 32-bit
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
 <81547e70-5b7b-41dd-89fc-732f4209ef61@linaro.org>
 <6a344053-bbed-4d3d-b12a-aa8664ce132a@linaro.org>
 <793d5cb4-686f-47fa-9188-b13818f2a283@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <793d5cb4-686f-47fa-9188-b13818f2a283@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/5/26 11:46 PM, Florian Hofhammer wrote:
> On 05/03/2026 18:38, Pierrick Bouvier wrote:
>> On 3/5/26 9:33 AM, Philippe Mathieu-Daudé wrote:
>>> +Laurent
>>>
>>> On 5/3/26 11:05, Florian Hofhammer wrote:
>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Syscall arguments are abi_long in user code, and plugin syscall
>>>> interface works with uint64_t only.
>>>>
>>>> According to C integer promotion rules, the value is sign extended
>>>> before becoming unsigned, thus setting high bits when only 32-bit lower
>>>> ones should have a significant value.
>>>>
>>>> As a result, we need to clamp values we receive from user-code
>>>> accordingly.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     plugins/core.c | 21 +++++++++++++++++++++
>>>>     1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/plugins/core.c b/plugins/core.c
>>>> index 42fd986593..d6173422e9 100644
>>>> --- a/plugins/core.c
>>>> +++ b/plugins/core.c
>>>> @@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>>>>         }
>>>>     }
>>>>     +static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
>>>> +                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
>>>> +                                    uint64_t *a7, uint64_t *a8)
>>>> +{
>>>> +    if (target_long_bits() == 32) {
>>>
>>> IIUC this is related to the target ABI, so maybe we want to
>>> unconditionally use:
>>>
>>>       const uint64_t mask = MAKE_64BIT_MASK(0, TARGET_ABI_BITS);
>>>
>>> Maybe guarded with #if TARGET_ABI_BITS < 64?
>>>
>>
>> More broadly, I really wonder why we use signed type for syscall arguments in linux-user, while I think they should always be unsigned.
>> But since soft freeze is coming very soon, it's not the time for a refactoring solution, thus this pragmatic, but correct, patch.
> 
> If you think it makes sense to refactor this for the next development
> cycle/window, I'd happily give it a short and prepare an RFC patch for
> it.
>

Sure, I would like to get feedback from Laurent and Richard first to see 
if we have a specific reason to have signed syscall arguments.

Regards,
Pierrick

