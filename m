Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D9DF47CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyDMi-0004Ri-So; Thu, 05 Mar 2026 13:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyDMg-0004RW-Ir
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:24:02 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyDMf-0007pg-1c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:24:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so37008025ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772735040; x=1773339840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8w06LgTi3OvHMjIGI6+FVYERdrl/LwN2mU3b/nWUyw=;
 b=EwzKgxLFkD7cAJDGorozcKI/Fxtjw0znL0LUxEo7RUzX8gAM+A/vqgXH+FJNIPhXrx
 7hYk12s5a3YkbBIQVWH634CE88c1EpgkodI/BJaTdAzQYVWDlgrbJnDM3UzGCbzOFxYN
 bXv2p255n09CObQATbfoBXaLQTfSJ1TNcu//butZYc5NYJBQ8BE0i13krfn6/Sra1e44
 WobLVKGsnu0yAQlRcAesovWhtRwMeEBHv09maV9jUvIb532q9uYPG8PJeOLbCRPTOQ1L
 XGIdFIlwbtQ49a2m4+vkJCTMaQOwgbS/6lKpjh1xNzKnDlKySxLWyusSg3aeGuB9NJAm
 1pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772735040; x=1773339840;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8w06LgTi3OvHMjIGI6+FVYERdrl/LwN2mU3b/nWUyw=;
 b=SO0NrIKeCnq9XBP8gITLHtGWDMIpmpaP+LzJdQe1dQ+8vW0PMaMcCe5EHa/rJ08qQT
 ++laWwL6fNfDCqv5KQu7ofZabNxuGsrDEv/XB5crJ2ob88ubMtrL2D8R0AAw4Y5+D/YE
 k4NS79Jg2DLs1ngF/WjieIo2p9isUTQbXeXnU88Q0cvZqyZUD42QWRVKtHYHpWkcnzm7
 ja6E6E3qt5g7UJo6K4L5A3uhZAnqtsnU/Kzl2+vKIBhN3XAaJ5B5xlDuVkBD1miTFVck
 XCy/jEnRB/gG8HTHSmayQItJJajElc2cghRyJqkseIl6MqzkdNHGM+VDXPg474FnBvEy
 K3Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rQVNMDMpxPfn0NPChTIcgyfMswrzlwnFepE0vFAloLNMUjty567LWqePhl7HMB/IyryyTn2zeXuU@nongnu.org
X-Gm-Message-State: AOJu0YyUuNdG/tCQov3bzTaHVXMpo/86UlNfRuYj2gi4RP3ldMjkidah
 5z3pqsghozHGc13mZp02l6vZnTwiyspw43Dfl6iaYie1TAllJUQKw1RbD/XEWfE3q0s=
X-Gm-Gg: ATEYQzzHr98tn6+Tq7dIFQlcz17/+OG8Wo3ArPpnyUtjAP8l23t/nwFP22ozXtX0Ex/
 keWmKacy4NHxUa4aCtLwef/FgQX/u6PKPn9AAKGKB9DWlxIMedmgijNNTJZVfJYIDTu8biyxR4i
 edy3ldH1H4DGIF0HYPLgCtiJOkpDzP+oh65Po/5FTtnIJbjF35nA6w4kUI9GREEO6hBuDMYJo9Q
 OoIiB3LlcKNKOcrxZaQ53xuNk7v280DlXskcrug2H8zTpaabVnOUhUICkBJiGmepEQxZ6IyClAa
 2xx3d7VidZnqjYjnqNIaPJCii1lsuUhMoyWm20kFknG0hsl0E5HOGmhuP8/XXuQbf+gCp9uMcOZ
 0/AMV0CkBd4/mlCh4wEtXtJ9XpDCRQukwf/RqIOzGkwMIBbJAxzFBoioP3O0fQ9vvvcN5lUoBS2
 H9AxhxiKDY223+JIA9bXp4jeo8yhnUyESQASBKOTsez9IZW80IPx4HKOV4vYHa0OvXZiPq
X-Received: by 2002:a17:902:e80b:b0:2ae:7f29:c1b6 with SMTP id
 d9443c01a7336-2ae7f29c239mr9842635ad.57.1772735039392; 
 Thu, 05 Mar 2026 10:23:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69f996sm226317655ad.50.2026.03.05.10.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 10:23:58 -0800 (PST)
Message-ID: <653f877e-9183-43fa-b5cf-3ca3ea021bdc@linaro.org>
Date: Thu, 5 Mar 2026 10:23:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target is
 32-bit
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
 <81547e70-5b7b-41dd-89fc-732f4209ef61@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <81547e70-5b7b-41dd-89fc-732f4209ef61@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/5/26 9:33 AM, Philippe Mathieu-Daudé wrote:
> +Laurent
> 
> On 5/3/26 11:05, Florian Hofhammer wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Syscall arguments are abi_long in user code, and plugin syscall
>> interface works with uint64_t only.
>>
>> According to C integer promotion rules, the value is sign extended
>> before becoming unsigned, thus setting high bits when only 32-bit lower
>> ones should have a significant value.
>>
>> As a result, we need to clamp values we receive from user-code
>> accordingly.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    plugins/core.c | 21 +++++++++++++++++++++
>>    1 file changed, 21 insertions(+)
>>
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 42fd986593..d6173422e9 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>>        }
>>    }
>>    
>> +static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
>> +                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
>> +                                    uint64_t *a7, uint64_t *a8)
>> +{
>> +    if (target_long_bits() == 32) {
> 
> IIUC this is related to the target ABI, so maybe we want to
> unconditionally use:
> 
>      const uint64_t mask = MAKE_64BIT_MASK(0, TARGET_ABI_BITS);
> 
> Maybe guarded with #if TARGET_ABI_BITS < 64?
>

TARGET_ABI_BITS is a target specific define, but we are in common code 
here, so it's not usable.
As well, since this path is only exercised by linux-user (and not 
system), target_long_bits() should not be different from its runtime value.

>> +        const uint64_t mask = UINT32_MAX;
>> +        *a1 &= mask;
>> +        *a2 &= mask;
>> +        *a3 &= mask;
>> +        *a4 &= mask;
>> +        *a5 &= mask;
>> +        *a6 &= mask;
>> +        *a7 &= mask;
>> +        *a8 &= mask;
>> +    }
>> +}


