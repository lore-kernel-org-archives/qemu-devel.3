Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA54FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1zM-0000SF-P5; Tue, 25 Feb 2025 15:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tn1zL-0000Ro-O5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:57:11 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tn1zJ-0004Jp-Ti
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:57:11 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22101839807so22901535ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740517028; x=1741121828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IMNSqAp9thrhtD4StlLIG3Q7VY5zblai/MWKCabFFzM=;
 b=NsFXHogElIKgSxEnrecI8OyKjSpEYmLWeEGRxYI8XMD83MwrEYY/2pyT340zAw7vRs
 WNyQb+9pzRS7FoBD1mxVoyTcIRDfobCpnmiEEEFP77ujAS4WCFj2qbwqXChHmKPMUF5N
 Jgzc1z1y2CrhprfhTaoXUv18Pq4xhw2qYpzJk/s1BbWHhiye+Jl7OigEybG5kUN+y8ok
 G2Mz/yheDrFRYFB3+xIJOjC7zJhri2eBA9GFt9U3aGZr37eYfgTqXzFpH4v9JsCDlQU9
 rnQ4VvlchswW7Wczb7To1QgDk0ynuCO2muGRl43zdn9FqjsC4+CaF3wOOJ6zvo/3b8Pa
 2e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740517028; x=1741121828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMNSqAp9thrhtD4StlLIG3Q7VY5zblai/MWKCabFFzM=;
 b=kfx5UG91SRFWLTaFuapmBz0ziFhDC+fGHu+AEsZcn0/b+kRiiD193yI5OShcCGz2zO
 El+N5TE6GWJd89Zwlhey73yV8xpLoqixoUXNxh9juBCQOrd52nPHYs3naSPYHUzM4Cmv
 J2Zt7ZDuar07JbWHkC0imm0gGfXzsryLW5EkGqJTNNPKQZpRV+dgkLxFejat+bEnO9wS
 H/r9kUW/5y/AMEqhAExhuVAJuGY69QaMETsJxe2A9penVH1A6r/ZgqATAiO+Nc1q8rwo
 anBxBLbLOc+iFBg7ALyW/swJyTYWt30Yn2qOuEYH1Fzr3FZSth3fPG8LuvM4RgCbWkua
 5uEg==
X-Gm-Message-State: AOJu0YwY5JVvzIvCKv0dhIe1fgm8hx7ycVGagXqO7UzvRtWV/hLnUiSb
 yTITQI8hZo5rFXJekacTqnT8RM3a4A2RRfFCDzCyaH+9maa2O/bxhqhUzy17AMw=
X-Gm-Gg: ASbGncsVvXsVr0pi9ONWICxHg3DmOaxefEMvWP8eGHjkvDdbiIo1cqp0CbwKZivVU8/
 btb7vf6bn6vnr2Nbet9K3pVpaAgsLOmsasLYsD+RRH5PZfgdDONtHFugxAdcOFzGwbIn/hGbYAh
 C5qHJxQcMd2QJIf3wTWYiixeAM3IP8q3nuV6gmLIDpzCL8ej3fgTv87HnYsszNkOlFs6vukqDXW
 +Zy8ojiohxO6RxaLMlJ+TNuix7S2SmGdjBzg+lelesSW5UJA/cSM09cSsW0sZmbD1uo+l6p4/EL
 v64uAeky/MquPvwr4qCdgK693joxf6m8HQWckTU=
X-Google-Smtp-Source: AGHT+IEvm2qLQ70WTk1CPQJqweFTQO1nffNH1wGg0zXQtrwSnxloa+d3eAT0TlmeRIR+9TZz8qrdhg==
X-Received: by 2002:a17:902:ce8f:b0:220:d272:5348 with SMTP id
 d9443c01a7336-223200b2460mr12405825ad.29.1740517027764; 
 Tue, 25 Feb 2025 12:57:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a000536sm18664045ad.45.2025.02.25.12.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:57:07 -0800 (PST)
Message-ID: <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
Date: Tue, 25 Feb 2025 12:57:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, titusr@google.com, hskinnemoen@google.com,
 wuhaotsh@google.com, qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/25/25 05:41, Peter Maydell wrote:
> On Mon, 24 Feb 2025 at 20:51, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Regression introduced by cf76c4
>> (hw/misc: Add nr_regs and cold_reset_values to NPCM CLK)
>>
>> cold_reset_values has a different size, depending on device used
>> (NPCM7xx vs NPCM8xx). However, s->regs has a fixed size, which matches
>> NPCM8xx. Thus, when initializing a NPCM7xx, we go past cold_reset_values
>> ending.
> 
> 
>> diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
>> index d1f29759d59..0e85974cf96 100644
>> --- a/hw/misc/npcm_clk.c
>> +++ b/hw/misc/npcm_clk.c
>> @@ -964,8 +964,9 @@ static void npcm_clk_enter_reset(Object *obj, ResetType type)
>>       NPCMCLKState *s = NPCM_CLK(obj);
>>       NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
>>
>> -    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
>> -    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
>> +    size_t sizeof_regs = c->nr_regs * sizeof(uint32_t);
>> +    g_assert(sizeof(s->regs) >= sizeof_regs);
>> +    memcpy(s->regs, c->cold_reset_values, sizeof_regs);
>>       s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>       npcm7xx_clk_update_all_clocks(s);
>>       /*
> 
> Whoops, thanks for catching this. Applied to target-arm.next, thanks.
> 
> (Looking more closely at the cold_reset_values handling
> in npcm_gcr.c, that looks not quite right in a different
> way; I'll send a reply to that patch email about that.)
>

It may be a hole in our CI right now.
Would that be interesting for CI to run all tests (check-functional + 
check w/o functional) with both ubsan and asan?

> -- PMM

