Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33118CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 20:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v19DW-0002U7-Ju; Tue, 23 Sep 2025 16:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19DR-0002Nm-0P
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:02:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19DO-00056s-Gw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:02:20 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-329a41dc2ebso4878328a91.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758657737; x=1759262537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMaTO3+HaQQ4gVXtybHWgy4ho36Fuioac4nouTUlQbQ=;
 b=NWfiAO+rWnt72jLRn9FQB2A6NS1yeqNwDUc/xaiFFtjPCii/D99PfvSQ92dOcfwmw9
 w8RUdEkeiiPb2LHuopmO+pi0Hm/JtI1Fpn6VUB6/jcfGTyPsdFeoaOk4ggRz3/fIbIoU
 awDt92+g6hUgZh+I6m54FOKBKe2V8AzQdv07lPgqlCH2p0X/kyZ3ZlUDVDZnpWuMkVRk
 97534EeiENNYmIPau1NuJLIdJ8g6MYcV4d9l7AMSdfJY80g0T20SWiY//JpGZ7J86XYR
 UTfemHWFmFbSotWRDzX2q/jSeG/qRU8vb1deCRon/z4OdOPwTHi4nYEnrf9Fm5djjOKV
 PlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758657737; x=1759262537;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMaTO3+HaQQ4gVXtybHWgy4ho36Fuioac4nouTUlQbQ=;
 b=OeBx+4O6/eJxtqxNP7ax4GDQN3qpwd9ZApbHEDJabcsfoHJMCGJG9FSyUo8jYQZKl0
 YMy9p0mFZwpr0nHjW17mIOpbP22zX5oyilDS1WtKDiMG85lUUIhQPM8iIJw8KDtdO8pn
 O4SwwkVyEaNEeK36Qbs8LjXEj9AHq7XCLSVRsAxHG7/iqHgQdIoRtvICaB4HAylDipYV
 Q5NtsdkW9+U+HR7ybiSePVd7atgrrIay6UbMRPrWdvgeUkHtPmrg7G79YatwZpVaHWiL
 uV44AeVCkOvIxufU3nTWUbxK89B1PI2VuD6CibymRiMTinJSgC/2g5AyeMTNbW0p3dfU
 IZnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHEPMEm1QbcygLILvcPtQiDA7YR03WyzfN7pBBfZIi6ZqVIUr0eD7jlBUP9VoyXaf25udhJ3wTC/q@nongnu.org
X-Gm-Message-State: AOJu0YwvUAJXqYeRUtqTDcWWJGEgmaBRqjLOfUwjBsuuT5eNofvWI+LN
 kfadHqxTP++4XDYV4JnRUsweH0iCd5C/fG6B8qIkM9h1gBTH2nSVc0705XIcnjhWon4TzylVosu
 5iDH8
X-Gm-Gg: ASbGnctaZh7kYGlYFshfidte9+rNAhLMUuQLkMNq2bdf6lwY1gsY2Q1UvZkN318IY7G
 WdJ9S7ERtjlU0HvrClkuEktgdyLuT86B3ZyjpIplYD1Mgye4sNlv5cKCrpBrElBcuASg82UnQJT
 7dLhRPUuZkJivOXX3Rc0e9mgu3SPyiZVjEokNFNNm/zDFLU8LMqXzdsDOSc+BHbaxJJkrObm3cX
 X4fQrz+Rg9PNbi7EeQr6peQcCt1Gm0zD2Zo951bH9lw2lgICYc8iuc0cbVjnOq4kt488hXZC3Ll
 FFI3zQ5MgiopwBHTVx9sNht9ubaozSXZm9eahQGz+2lhVYWaSF4GNRsYSNNhmVNKLq6ZrUPoGft
 hmjqWvKdAA8mjKcq1v3YBWMSUWqdF/+8RuQ6l
X-Google-Smtp-Source: AGHT+IFp0fCWgvlWYxZRwQHgKc90FyGkbbwj9L30YBZMecPy4sBB1sQVrpnVY0uFAqlU6XM7xp+Nnw==
X-Received: by 2002:a17:90b:4a42:b0:329:e2b1:def3 with SMTP id
 98e67ed59e1d1-332a94f055bmr4687166a91.10.1758657736678; 
 Tue, 23 Sep 2025 13:02:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-330606509e9sm17382931a91.9.2025.09.23.13.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 13:02:15 -0700 (PDT)
Message-ID: <cf928b24-4c1c-497d-bb8d-7308b9cd70b1@linaro.org>
Date: Tue, 23 Sep 2025 13:02:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] accel/tcg: Introduce EXCP_TB_FLUSH
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-10-richard.henderson@linaro.org>
 <67f2c84b-4bb3-437b-8184-e7dfb9947df9@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <67f2c84b-4bb3-437b-8184-e7dfb9947df9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 9/23/25 00:10, Paolo Bonzini wrote:
> On 9/23/25 04:39, Richard Henderson wrote:
>> We are going to disallow tb_flush from within the context
>> of a running cpu.  Introduce a tcg-internal exception to
>> return out of the cpu run loop and perform the flush there.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> One small difference is that different CPUs can fail tcg_tb_alloc() at the same time and 
> flush multiple times.
> 
> I think the check on the generation count should remain.  Instead of introducing 
> EXCP_TB_FLUSH, you can keep the guts of tb_flush() as
> 
> void tb_queue_flush(CPUState *cpu)
> {
>      unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
>      async_safe_run_on_cpu(cpu, do_tb_flush,
>                            RUN_ON_CPU_HOST_INT(tb_flush_count));
> }
> 
> With the unconditional async_safe_run_on_cpu() hidden behind a function, this patch goes 
> away while the next one survives as
> 
>       if (unlikely(!tb)) {
> -        /* flush must be done */
> -        tb_flush(cpu);
>           mmap_unlock();
> -        /* Make the execution loop process the flush as soon as possible.  */
> -        cpu->exception_index = EXCP_INTERRUPT;
> +        tb_queue_flush(cpu);

You have a point.  It's not even that unlikely a scenario.


r~

