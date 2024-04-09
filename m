Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E38CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDOZ-0000X5-5g; Tue, 09 Apr 2024 11:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDOY-0000Wu-7k
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:28:22 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDOW-0003GP-Ls
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:28:21 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51fd94c0bfso93650066b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712676498; x=1713281298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YcuDfxLS/17fvdj4MOOhMrE9s0vfY1BZzacqaws/XZ4=;
 b=u7bFcdToQxN87qBn1h3htW0yuXjp1CUZH60b7yTdSpt55Vb/KO+5BzCcBm836qbQNX
 8pN59ryw/loQHYQdhtpSx1T3auU5siuhgua757mqp6WqC5tjnl892VuSk1t/klHvFqWm
 5fWgoZx1gDK6vD+4ut7fKgYyCGTg7dfXpZD4OrCiqVkhknPGNZpnHSBzpUt9+rKi6Ouy
 lZO2+Mx4AO5E2+LYFWeuSOfdK07NGfNAJzA1VXsfwWiNyKAxHUbKFhRv2Fk4PpcSaaD3
 wbsCleNGQAowb5TC4lWRuR8FS2dmjK3egbsR94li277roFD9CuYQitlIzkn3OkGMnms8
 CdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712676498; x=1713281298;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YcuDfxLS/17fvdj4MOOhMrE9s0vfY1BZzacqaws/XZ4=;
 b=EL+jpBtYfImVnI5hA6gyJQLKSMrIBwDHq59b31JyVVpNfnZR0SnmBcQHKEGgKWNcW6
 j15ivuAnZ3jfgctG6XUgIrkNm8NhoCAPPYKHp0sT64dgAJ/oe4j0Yzk4k9YUhX+vV6RW
 8P7aOH2ve8c5bTpCszlkhWZw4Q/X6S99zvqoesWMS48xPOZ16pb1Cgl4zjNsA2gBbt03
 d6CAqmiUXpcI8G+Kji2o+33vn2VudjmOUZzyblHc/Q6PT+4rm8noMy58S+lD8BJ/K+n8
 y+YI+LICvFIAZiskE+Gy67xVx6aI8GAuM/9UwrhceG/rRo5WkFHAFwf11zOP1vISp5zA
 HnlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyVJJlaMa06eKwRI0o2/4SRtwDNRs/rnWa9wsX0PNzRmIiXVVz55VaH2OYG6x/4cxFqHLULQpHcgN05yU36OzbHrplXaQ=
X-Gm-Message-State: AOJu0YxGOmWH0S+LN+47GkJvyB/lSaRvQYapFiuRyGYzjypuaUYTiE+F
 GVCeGvJMLWWvqWDZz+E35s/L4SQcdahrVwaTDyM5lG9P+UEdlTtR3UUPDFhTNRo=
X-Google-Smtp-Source: AGHT+IG6+HiUVr1zn4mni0ZrsJ8GBOvRbjLaGJxDvPNdXnpVoLIP+ndRrPCGTQKztsjgDgfoxfG0mw==
X-Received: by 2002:a17:906:da8d:b0:a51:c1e0:3049 with SMTP id
 xh13-20020a170906da8d00b00a51c1e03049mr8410189ejb.12.1712676498282; 
 Tue, 09 Apr 2024 08:28:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a17090618e900b00a4655513f0bsm5807113ejf.88.2024.04.09.08.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 08:28:17 -0700 (PDT)
Message-ID: <99e4fb4a-6248-46fa-8e6e-ed767c3f771e@linaro.org>
Date: Tue, 9 Apr 2024 17:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start
 across rewind
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-6-richard.henderson@linaro.org>
 <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Content-Language: en-US
In-Reply-To: <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 9/4/24 17:23, Philippe Mathieu-Daudé wrote:
> On 7/4/24 00:32, Richard Henderson wrote:
>> When aborting translation of the current insn, restore the
>> previous value of insn_start.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/i386/tcg/translate.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> 
>> @@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState 
>> *cpu)
>>           /* END TODO */
>>           s->base.num_insns--;
>>           tcg_remove_ops_after(s->prev_insn_end);
>> +        s->base.insn_start = s->prev_insn_start;
>>           s->base.is_jmp = DISAS_TOO_MANY;
>>           return false;
>>       default:
>> @@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase 
>> *dcbase, CPUState *cpu)
>>       DisasContext *dc = container_of(dcbase, DisasContext, base);
>>       target_ulong pc_arg = dc->base.pc_next;
>> +    dc->prev_insn_start = dc->base.insn_start;
>>       dc->prev_insn_end = tcg_last_op();
>>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>>           pc_arg &= ~TARGET_PAGE_MASK;
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And:
Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
(also to patches 1 & 2)

:)

