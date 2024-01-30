Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47B6C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiuA-0002xy-9s; Tue, 30 Jan 2024 02:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUiu0-0002u8-BV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:28 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUitw-0005wh-6X
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:26 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bda741ad7dso3200657b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601083; x=1707205883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQFKKcs5tT1iOwZ+4rpkGIj5Z5YTUnJ+BYc6PQfVZsI=;
 b=hTGQkk9+2OP1EvOjCwS/iMo/3BGa239hJeY4W4lorPmvHpF8tvG+17NEeI/IcTpG/i
 YHmpu50+pXXpnVXLdAFNviSg77FSbYfn7WQ0cZahcPc9h6M98hBEQTRFHmnT90eZrPLG
 WeINlq/U1gl7Av13lKPWbPuyZEZpC/oVR+WZRNovBB1TXLiQ3G/t+D5A9+BfeDReTIY/
 O0efBnp0Id7CkiPgaykCByXTho6LAm7FRWtpbme4ZyFBZGGGXyKz4cQkffvxrZE1se/j
 1XVSWJ8amK6fPJGGYQ/uDSKFLQJ0Xb07VOd4BTqjjX5qQb9HmnswLwd3vC6R8Y6K3/Yw
 elcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601083; x=1707205883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQFKKcs5tT1iOwZ+4rpkGIj5Z5YTUnJ+BYc6PQfVZsI=;
 b=T0o6zmkbzBI0W1GJqcE6jCXSM2IqjTZyZWqn2K/VsP1K19nRgAn/BaWe5Kwo0RWTWI
 ntR8PpM+gqXv0vaYBUOyBOjMqNMeKe00btDy3TerAqh8JuCxMyfXkNi1ACdu6ynqS55E
 n9P00uRAIxKSLkzfmaKF3XQ8fpwY/iuEa6dIAyt9+9z+jxYeGTVkhBahjuBggMJEYdoc
 G4+rg4Prywe6uEcHE0OgtNRvm7kr9t02hKV4DCoEYgj7LcJpZfSxLWV98yqIRtDLmC30
 fhbS7cIOzST+sMYRRjQtbivMABOHn8Rk+JElm/41uFXcRrl1km8pUguOB60fLcOatC8M
 wXCw==
X-Gm-Message-State: AOJu0YxUApXosORoOgrjKRX1nTAdX9bKw4xPN8h91f7SqXeKjr96fr2H
 fffp4dpx2YS2TDpGTlr5A2GcOLuYXqkkqSJX2dbnRW9xg1yfMk11Y5IHy639OKE0jFNZcYRbTlc
 0isw=
X-Google-Smtp-Source: AGHT+IFzDn7jvdB3s414/45SD20J8h/gZeA8M2XGL7ra1xyHTkZDer/KmNlPrNf/xtrH+696ErAvkQ==
X-Received: by 2002:a05:6808:2111:b0:3be:9b30:e4d6 with SMTP id
 r17-20020a056808211100b003be9b30e4d6mr352762oiw.49.1706601082995; 
 Mon, 29 Jan 2024 23:51:22 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 y10-20020aa793ca000000b006cbe1bb5e3asm7044649pff.138.2024.01.29.23.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:51:22 -0800 (PST)
Message-ID: <ab8d0b2c-4ee0-43ff-98a1-afaf02320dae@linaro.org>
Date: Tue, 30 Jan 2024 17:51:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-2-richard.henderson@linaro.org>
 <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 1/30/24 17:46, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 30/1/24 00:30, Richard Henderson wrote:
>> To be used after all targets have populated the hook.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/hw/core/cpu.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 2c284d6397..4385ce54c9 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -103,6 +103,8 @@ struct SysemuCPUOps;
>>    * @parse_features: Callback to parse command line arguments.
>>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>>    * @has_work: Callback for checking if there is work to do.
>> + * @mmu_index: Callback for choosing softmmu mmu index;
>> + *       may be used internally by memory_rw_debug without TCG.
>>    * @memory_rw_debug: Callback for GDB memory access.
>>    * @dump_state: Callback for dumping state.
>>    * @query_cpu_fast:
>> @@ -150,6 +152,7 @@ struct CPUClass {
>>       void (*parse_features)(const char *typename, char *str, Error **errp);
>>       bool (*has_work)(CPUState *cpu);
>> +    int (*mmu_index)(CPUState *cpu, bool ifetch);
> 
> Can the index ever be negative?

No.

> Would it be useful to also have a mmu_index_max() so we could
> check mmu_index() is in range in the final cpu_mmu_index()?

We have NB_MMU_MODES, a target-independent constant.


r~


