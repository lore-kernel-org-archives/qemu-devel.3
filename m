Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E56C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOuUB-0005po-N3; Wed, 03 Jul 2024 03:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOuU4-0005oK-EP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:32:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOuTz-0003Nc-NP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:32:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so2944464f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719991970; x=1720596770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FpsB9s20UCTB0SZs0L1kH+zkRRB/ERXs9I1d0JuM5TA=;
 b=MgX5QA/STMKh7vcr/k/GNdAbnb+ttlUy0YJp548f+jBDJ8UAfIQVgDonpetdH67SYN
 erZBjGCkaf2JoFboOkHYILolnLfeuIhK88OfVZWRjaYvJhtYV/A4Bge9ZY33DI/9mJWN
 SDRMlC0GtA9ORoe+lyXnAaAGHP4ED1FucA58koh3Xpx5kaip84ib6gn4cvMGVDhTaf7R
 V5MKobJaRqa2/+F6UVWMlFgZovy35/KNT8F4EGPIwAW7fVDxqU1VzRPkrjx0HkZbCOIn
 5VNZyo+TWAqWgsN+HG/4ElPAg2zOJHm5IBnZImCdd/nebe+akP6eQmJmN/+tc00sI3r0
 /OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719991970; x=1720596770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpsB9s20UCTB0SZs0L1kH+zkRRB/ERXs9I1d0JuM5TA=;
 b=sIMMcuUHiUvtxXO2HbDCsD57FC+OWmry/f7HqV5vhXFPY0x/zvcD8YdN0368PKe5XU
 aCFJ1WPSE//ojhkl2M/SOoGiraOGBWdAYsv3kpRxNdUOOA9hfqrWR/W6OYxWjm/Q9vYU
 /fpVCTJoSKTq9+WKPcsQpJqQUoawaI/2jvQZj+TPR8CT2vW2yFKp17++h1cj/15Honb0
 bebGoJ8L6vRPWmqWod4f6i0QZ0LKingFAsEDwQjnD9GH6MpB5PXpM31j1RCuAMLi6WQt
 uZX0cipnxkGPaf4cIgTYQe3AvhFuX/leVM/BmhmFtQatODbhbbSgN2JXfR1LfBH40968
 bKUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRErEzmNz8/Q5CUtJw5M8bk5vvtfTC9Xuj5EP+szZjhdoc3L36bHSF5bw43KMgwWyzV1HbW+agNWmdWrWVGtnfyzdaPgQ=
X-Gm-Message-State: AOJu0Yx1KL5wxsx1FTbBy1ykDSbahwiltNmaDOmdhpw+A3VSziRWDklt
 uVMxzY6AW4mFmM9tp8OmxwemXVC/bsB6mlUOU1vX983+TT7qICmuQ0Qjx9uWeNo=
X-Google-Smtp-Source: AGHT+IEJo7nTX0DRFWc7yq0X7A6wDfzCwcy/Qn1RtUC+O+q6SSohP94k6lUO4Gp9smh+C3RDs0KSOw==
X-Received: by 2002:a5d:6708:0:b0:366:e31a:500e with SMTP id
 ffacd0b85a97d-3677572ffb1mr6151228f8f.63.1719991969714; 
 Wed, 03 Jul 2024 00:32:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103e5esm15070956f8f.108.2024.07.03.00.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 00:32:49 -0700 (PDT)
Message-ID: <d024c596-bc89-41aa-8c41-0aa170daa6ed@linaro.org>
Date: Wed, 3 Jul 2024 09:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-2-richard.henderson@linaro.org>
 <360734c3-df2a-49cb-892a-0eb7953fa1c1@linaro.org>
 <57829ece-acde-4719-a82c-e3eef0daca84@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <57829ece-acde-4719-a82c-e3eef0daca84@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/7/24 01:04, Richard Henderson wrote:
> On 7/2/24 12:55, Philippe Mathieu-Daudé wrote:
>> On 27/6/24 20:03, Richard Henderson wrote:
> ...
>>> +            info |= !got_sigill * CPUINFO_ZBA;
>>
>> A bit too optimized to my taste, 'if (sigill) info|=ZBA' would be 
>> simpler to follow. 
> 
> I switched to "info |= got_sigill ? 0 : CPUINFO_ZBA".

Thanks :)


