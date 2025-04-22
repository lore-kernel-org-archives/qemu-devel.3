Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A193EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GWl-0005Vi-BD; Tue, 22 Apr 2025 12:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GWN-0005I7-Lm
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:31:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GWK-0008FQ-1E
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:30:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso41453325e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339448; x=1745944248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vL5DeZyFwZdkKipZSPU4qZ5Rcwwo0U4pzKTcb0HWnoc=;
 b=BRbvEf3MBybOv0w2EpUNW3UKbiHsuuHUbf750RPEaB8WJzhCeN5IK0PDgOFtcTKwUh
 caS2Cc0baF9OdlKy7JYYc3q3M35+qVJEnNfe8sO2C5HBDq9g+odIY5Z5kGtQ54FNkp1a
 Lk/Rz31cKn9LV6dMB/H+ALuCH8LZQBamMq1gNpk5eP/a/lKSfg+vb/VmH4RMRzx0jljN
 ZytFI+VBXccJtt8C+ejjaVZYs0HHngrPeCJASAxLuje6PD+/ngheykeeIhATEviegA9u
 H1XlPN1iNztQcU98B64TYcRiyluSBWZipqDKiXv9veROvLesnmmqo6tq6CRP+hXfVB0t
 dL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339448; x=1745944248;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vL5DeZyFwZdkKipZSPU4qZ5Rcwwo0U4pzKTcb0HWnoc=;
 b=OyKmxHqG8nvX5Lj/0abktFCFF5QMcdA9JaAEFUrCvO+uQ02xFf4xq8o1hqyLbebraL
 z0yJiyReRhb2wa5UEYu3TMe79dup2tgeZ4KpV3v12Qom44KbI+I7VJi8r1RZyhO7xKmt
 s3j0ZOP3M9SZpdId2uP+lKBJu/Ibr4fNe/TTlvf4GsFYlbA9lBBXu9bLb+4hbzJQB4Eo
 prhiRKJQU5gKv/wzVAnCmzUqZ7Fhlf7dK5npCuwLZrq9/tNwd2QQFME3mxQr6pYKLrhL
 IUIgdoVVmQ6PIYhsiEkBSS/P1JX6ipnKXzfkGxn8hnMBdk0ZIkmQrLdu5KuErj7DHBZ+
 gOiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlm7bG1UvWcCcctHyybYcOowcOcF0BUTY+Rdh8ZtoQOdIwdX4X0BkU7kr/tByKY9XGtftr5Cm6BoZg@nongnu.org
X-Gm-Message-State: AOJu0Yyqc85VSvmmFkaHs7wplLYTZDm2q+s78pwKkN/ZRJodIWgH4iOI
 tkC0AB5CMwiYz9tpmQJcF6ByKvIrSzdlfEHU69foHYzL4UlwqIfzRCX/zxrzlpP2DYwFihpDCpk
 y
X-Gm-Gg: ASbGncsQvQEsN8qCkAL94FATRGFWxG7CHgvS1yGPBBYC3c5+/05nhhlu77kI2HhCf8p
 lmzo1ZdAvb0y0EMYTNmvTcy0iNLawfyI8H4pmp6b6Sfl2dnsan59dKv7AFKeHyWEIKiyquDSUyB
 Cf1rs8hwLKxxdcDBj6kkbZkk3uJGOPYHDG/1lNwquW6Ibed7/bK+hkMqOkXhzMthZSk2nr+d9H7
 V9jjbeLaU5kex6CXIVAEdOHevS214Zy1+dpeKNdRA2RG0F3kNcbz6oxGFGk9c6hn+l7Qwv3/Sf7
 4SXWUd9cND3bKceJCQTQvRNMNOA1nWgsyWXKDR7EvhVmzATIlfCI58iRDQEN2TDVmpy7rt11S+u
 wYdGfYToKh9dmAP0TX0o=
X-Google-Smtp-Source: AGHT+IF1oy29iPkPTnXzjOV2AGoqAL1womfpqk8LCoeUm6YFY5b3MMcV/2j38UEQZ6jeQWbZo/jdaQ==
X-Received: by 2002:a5d:5985:0:b0:391:1222:b444 with SMTP id
 ffacd0b85a97d-39efba5299fmr13089018f8f.20.1745339448134; 
 Tue, 22 Apr 2025 09:30:48 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43c023sm15522147f8f.46.2025.04.22.09.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:30:47 -0700 (PDT)
Message-ID: <8e18c29d-3a0a-41fa-92e7-c495918090a6@linaro.org>
Date: Tue, 22 Apr 2025 18:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 123/163] tcg: Add tcg_gen_addcio_{i32,i64,tl}
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-124-richard.henderson@linaro.org>
 <53dd58bd-a11f-468c-a5e1-94692b1f5367@linaro.org>
Content-Language: en-US
In-Reply-To: <53dd58bd-a11f-468c-a5e1-94692b1f5367@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 22/4/25 18:13, Philippe Mathieu-Daudé wrote:
> On 15/4/25 21:24, Richard Henderson wrote:
>> Create a function for performing an add with carry-in
>> and producing carry out.  The carry-out result is boolean.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h |  4 ++
>>   include/tcg/tcg-op.h        |  2 +
>>   tcg/tcg-op.c                | 95 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 101 insertions(+)
> 
> Please add brief documentation in docs/devel/tcg-ops.rst.

Sorry I missed it in patch #113 "tcg: Add add/sub with carry opcodes and 
infrastructure".

