Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66696CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoO3-000693-00; Tue, 26 May 2026 05:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoO1-00060H-7L
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:47:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoNz-0004X7-NL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:47:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso47824785e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779788862; x=1780393662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQByfkMHXiTZOgUeLWC3Vb1eVe9KeDhrLn6kjkPuEfA=;
 b=IwGLblqxaDs+gYw6KqUORLc837lIOQVPpiWtahpw3NbTxv0DwFtqMrn51WpBCfnMfh
 VkHIUwk29+Iw4pbKqGnHMDGI0384MvgJ1vy/RnHkslPAF3nTrQuoO2cMrOAvPKwpnN9Z
 P8HVn6mpOFqSdguFEkVHCowTVqblL5mwcBRBMtgj91zHbqpnuSyNW6X2HvxoArRBWGI2
 llBSLJ7hUW9rOhuBMQTDlN9GzxO89LwvBYBjmwow6EMLgYR3TjYYB2F+HqRRJGiVVzI/
 2LTO1GcsQx13R/XLl55ZkoCv0LGbJQgmXuy+aHO+BGglvLoeKUiX2N52Vf6Ro061df9D
 Yscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788862; x=1780393662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQByfkMHXiTZOgUeLWC3Vb1eVe9KeDhrLn6kjkPuEfA=;
 b=imNEAJfBGPgP4LqxWNsHEnRnW/r8YKdIphG4RdTaigVY9wJ8j1UHa4i+5r1Ebcz5Ve
 rQUmqNiLtqpy+oJSx+x5PvnB40IaICe3aelifeENsNsxhBwGDEYVKC5tOTUYrxIdEU7C
 sjK4+QZ6x6qc3d7q+ywnIg8Sl/i6vLUCUPrqXy+9FnMJmoknCflgZHXwv13wOaB96fsx
 jl79b/rbVk+6kGjfaQ7D6oPYwDKcc3yP0mSqNXg6HB230adEhy1uAvfUvs5EMiia2LSd
 qKGRRZwEooDSsLn1zMe0IJo3/1qCuTTAN4h3YM0X0tx2zxwR3foNI/BtbxK0BcZQKYFf
 95RQ==
X-Gm-Message-State: AOJu0Yy3TUYwzsTeHijMWvbC2GdnLIuFouurKVThq4vHapJRp4vs1DGI
 NnZkAueFCUk6+MmOLjjsySDcSkpTdk4F6bJ+0bBxMBbnNjLuYvziHxPmCxoUx6L4GTg=
X-Gm-Gg: Acq92OFldNJuWkdLpfgkDoUDV69EBPyQVGE0NyUbANCWK9611dcMMPUQNlGB3MrSP9y
 Ze9Tk2xgE+k6n6ZFMwEnuJ0TMp+3ak7L05aYgJbZLMuIwm5rgV2jTtAIOPrIxuhW3pO0Zna8xXM
 jhbBBkX5LxCHTTyAi59WJSE+QNKNzvG74ak5yNdBHwnA1Bh66B/cpVjznla5qGHE/qVL9eGE81C
 I6gSZ5fcUNz6JniDvhq3IX4hjZijobSfSMnUvMtF06byFqQM0yhe56vYmKxXb6IasRSrdDHN/FO
 PMmdlyfolzdpkZzxcFnE5qEW79HNK3Hj6zi0hO1Yedf/ZNzJv5Zw2KOfg7kG5P5nA4IYHtuNa6g
 6Vf3/8bnJi6L+f+WFSyI1gEzh/aWX4nuwThcqNtyXMHlZW2JKBZKzzkxVCYJZR3VBWxB+iU9snS
 Qb21k901zBK14A1KficHnQcHwlcye7wfIOzjdGdJXtJkLOlhwXgJZYmkkW1V995v7o4g==
X-Received: by 2002:a05:600c:4e4b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-49069da61c3mr95571345e9.21.1779788861946; 
 Tue, 26 May 2026 02:47:41 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904d239184sm129100225e9.2.2026.05.26.02.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:47:41 -0700 (PDT)
Message-ID: <ccf24c74-bd7c-4ffd-a483-49919869119a@linaro.org>
Date: Tue, 26 May 2026 11:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] target/loongarch: Move CSR registers to struct
 CPUSysState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
 <cb1a9261-d59d-411b-a066-a9e186f26668@linaro.org>
 <2532f1cf-0f1b-e536-6781-bf5a1292545b@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2532f1cf-0f1b-e536-6781-bf5a1292545b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/5/26 11:35, Bibo Mao wrote:
> 
> 
> On 2026/5/26 下午5:11, Philippe Mathieu-Daudé wrote:
>> On 26/5/26 08:50, Bibo Mao wrote:
>>> Here new structure CPUSysState is added in CPULoongArchState, CSR
>>> registers are move in CPUSysState. In later with LVZ supported, there 
>>> will
>>> be two copied of CSR registers, so it is simply to add CPUSysState 
>>> array.
>>>
>>> Also new field curState is added which points to CPUSysState at
>>> beginning, and it can be changed during VM exit/enter entry. There is no
>>> function change, all is code movement or variable rename.
>>
>> Isn't curState misleading? What about:
>>
>> -    CPUSysState *cur = get_current_state(env);
>> +    CSRState *csr = env_csr(env);
> 
> get_current_state() actually is misleading. In future "QEMUTimer timer" 
> will be added in structure CPUSysState(). It is not only CSR registers. 
> How about something like this which is copied for yours :)
>    -    CPUSysState *cur = get_current_state(env);
>    +    SysState *sys = env_sys(env);

LGTM!


