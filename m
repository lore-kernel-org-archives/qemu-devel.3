Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026C1C25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CqJ-0007WL-0f; Sun, 28 Apr 2024 18:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CqE-0006zh-F6
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:50 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CqC-0005tg-RH
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:50 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a58d0aea14cso291871166b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342667; x=1714947467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qucrbK2hViP6M1Jh6rXQKhaOH45MSaOYAasgcvW/rQw=;
 b=Bk8M28q+S1MgUBbzGk8BU4ymWNPpaHqygLxi2Xx+si3kFC7iTqe6n2BccRSy5wLD0l
 jeuRYTMMTv+2zbE32eg8dRuxFq4TWOOZcBpWQOeIMC0wCbaVLN4VeyZDHVu3EIs2o38S
 xQRn60jy/G3NHCFNSkcu4k1QFDTqeA4X+tb/J73PZA//9d6YW8iMpeztSCXiWck3LtmP
 P1U8Ke2svBnEb4Rh92QtDQPpml/w9kqs5X3SGR/nipJr7UkD6Ye9Dw4dEG8rjMtwgA99
 JYxQw4UrNChJTZy+yMW/K3/XwyfBBaI+FTgYkV5vAY0w/G/Kv/hWHHMRd7RZFkeJR/am
 s+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342667; x=1714947467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qucrbK2hViP6M1Jh6rXQKhaOH45MSaOYAasgcvW/rQw=;
 b=DWr82P5u/KKD0M6aHykdeqRw3PyNfq+VB2GtQWSFN1OZ0WY6J10veq08KMuHPibd6z
 FrAv4qIiAE2++AcOSm4njl7bo1TBPaLVOmdouc65pAo8l5vB+hgTaweVtiyNKOGkVG5L
 zi0Gzv0/iORgIAbNU2a6AP0Bx5wYsthxoQbrIiIOxxEMsSroTe5zPGsAJk3cx7UPqyvT
 Du2geELVnsAj8knJLdWIvZYu3h7nu6rMUHSwtztQZXfFqxLslRBqgwAMKwWKNldtGl5f
 9N7Khiop0shTxsPPfdMLgKPFg7wqdsI10DbD1K+ErLC3fo5Dbw6pQ2zRRaZ8btxvFl4i
 M99w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVh/E0gNztbq1yxdObsIjMSpneaGaa+MnAGVZsKaWmkXb+RgE51e7oN/CMaBNtvMHh+tXrzQY0TW9FZEgJxCXsFmD2awY=
X-Gm-Message-State: AOJu0Yxo9cdPHYb2VFWYfiLl+PD8NbOetYZz4xrGnSNX9m+zzlWjjNhJ
 tt6JKJeUfU4Jfp4ziLtqAQ/2Is4rxjFd+vhvLHqGUqGm5aF45J0lH2LMkn7wII4=
X-Google-Smtp-Source: AGHT+IHgGQ71v8MdYvVZSEacCdi1lyZ9BgjEESVEe0IRU4ubENkrkmn/cmiRZn/0dw+xjFJdetAwGA==
X-Received: by 2002:a17:906:1c8b:b0:a55:9278:3056 with SMTP id
 g11-20020a1709061c8b00b00a5592783056mr6194442ejh.57.1714342667386; 
 Sun, 28 Apr 2024 15:17:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 bu6-20020a170906a14600b00a57c75871d8sm7735611ejb.106.2024.04.28.15.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 15:17:47 -0700 (PDT)
Message-ID: <92fb184a-9301-4dd0-9271-7c169449e5a5@linaro.org>
Date: Mon, 29 Apr 2024 00:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] accel/tcg: Restrict cpu_loop_exit_requested() to
 TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240428214915.10339-1-philmd@linaro.org>
 <20240428214915.10339-10-philmd@linaro.org>
 <28f02378-b01a-4986-9dcd-9c397297d25a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <28f02378-b01a-4986-9dcd-9c397297d25a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 29/4/24 00:08, Richard Henderson wrote:
> On 4/28/24 14:49, Philippe Mathieu-Daudé wrote:
>> cpu_loop_exit_requested() is specific to TCG, move it
>> to "exec/translate-all.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   include/exec/exec-all.h       | 17 -----------------
>>   include/exec/translate-all.h  | 20 ++++++++++++++++++++
>>   target/arm/tcg/helper-a64.c   |  1 +
>>   target/s390x/tcg/mem_helper.c |  1 +
>>   4 files changed, 22 insertions(+), 17 deletions(-)
> 
> I guess we could dither about whether this is the best place, but I 
> guess it doesn't matter.  Do you really need the CONFIG_TCG ifdef?

Right, actually 50 patches later it ends in "exec/cpu-loop.h",
and "exec/translate-all.h" is removed. I need to check whether
or not this patch is required at this stage, maybe not. Otherwise
I'll directly introduce "exec/cpu-loop.h" I guess.

> Either way,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


