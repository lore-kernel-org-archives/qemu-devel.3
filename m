Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5E3C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 19:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLTJs-0001zF-Oe; Sun, 23 Jun 2024 15:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLTJq-0001ye-5f
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 15:56:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLTJo-0002lw-DB
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 15:56:09 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7187e6b3584so967617a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719172566; x=1719777366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sF50FXkLt7ae7FezQjnZDaJuFbpC8unLPk4kpEIIaIE=;
 b=gvFt85VSjUjNvy8geFz4qnMQqKAR18OE0ZsESYe5y4QrtPH86L3LgWq2lU1Ri/x2i3
 HltkMMCEmoQPf7FLnhnkv8vuu6HRWk66LF+mPAAYDWczl/HaY3z6+Gdu54HA913epN73
 ulHkWyKpAG86W9vVVCZnBpEnIGcS262JESmMjC9Gm+gOkuU5JcvhSHPvB2DK4NqvE5dz
 cMOF748ttcXP3RMuV4tzto1B6FdTDdRdZ6uFEVNvYChoz4uhYUYe2GyfIXMwGsv3E/eP
 TdooxFSbwR7EPtUUZZN3BXFAvYRhniBwXE86Xlv1BdrYIlrcj8UOlFtnEE2vEF0O4lGL
 F7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719172566; x=1719777366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sF50FXkLt7ae7FezQjnZDaJuFbpC8unLPk4kpEIIaIE=;
 b=Zm8q3Kv8KcbDE7m4jwQemMGgyazK00X3xBE+5Jw2aJ8uK28bw5e59Iq8caNe0DFqdf
 jqi+ArRcPwyvRFNRffqvNY2Vph+fNv+OZG73oS+2ALCyDqohg4/Y1j3kHA2S2BY3qugo
 0QkB83zNvo6Qg0/DRSNfa179NXg5vcoFsDEfYe+Mq6BM/VRMky2nosunKnA99DChDaPJ
 AZVD1aed9JI46qB6ASwg0LVkT917vb3ByXETPNv0QP7mfwd9p2Ila1lNtNIfnNDahoRq
 8++obn0Hfx00K2RLt2nDaM3j3UzSfztoUb86t1Met5YfvRFHKHoz5faXNLa0hPa1POuO
 He8A==
X-Gm-Message-State: AOJu0Yx+3Q/i3RbAfA5TbHcFYSo8KgxZt1Dmj3L4JLZPwsOzFtnk96Xg
 Y5VjHU0PJuJwUxSieWgO0fT241Uflci4twe/A7l/t+T3XaomjhHC3rT2JWKwexw=
X-Google-Smtp-Source: AGHT+IGQJdBtYsW2U/NB88Fr7OVXbSRXcXNZD+aNy5/1sHLNhcnNeRVq9B5hxWdmavvkWfBRXkF1cQ==
X-Received: by 2002:a17:90a:dd82:b0:2c7:ce24:8598 with SMTP id
 98e67ed59e1d1-2c8581cda3amr2230797a91.12.1719172565467; 
 Sun, 23 Jun 2024 12:56:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a622f0sm5192630a91.8.2024.06.23.12.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 12:56:05 -0700 (PDT)
Message-ID: <80b6c7dc-1a85-4ad0-b715-8ead8c1c0448@linaro.org>
Date: Sun, 23 Jun 2024 12:56:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/m68k: pass alignment into TCG memory
 load/store routines
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
 <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 6/23/24 08:23, BALATON Zoltan wrote:
> On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
>> Now that do_unaligned_access has been implemented for 68k CPUs, pass the required
>> alignment into the TCG memory load/store routines. This allows the TCG memory core
>> to generate an Address Error exception for unaligned memory accesses if required.
>>
>> Suggested-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165
>> ---
>> target/m68k/translate.c | 18 +++++++++++++++---
>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 445966fb6a..661a7b4def 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -303,13 +303,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
>>                             int sign, int index)
>> {
>>     TCGv tmp = tcg_temp_new_i32();
>> +    MemOp memop = opsize | (sign ? MO_SIGN : 0) | MO_TE;
>>
>>     switch (opsize) {
>>     case OS_BYTE:
>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
>> +        break;
>>     case OS_WORD:
>>     case OS_LONG:
>> -        tcg_gen_qemu_ld_tl(tmp, addr, index,
>> -                           opsize | (sign ? MO_SIGN : 0) | MO_TE);
>> +        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
>> +            memop |= MO_ALIGN_2;
>> +        }
>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
> 
> You could swap the order of these so byte comes last and fall through to it from word/long 
> to avoid duplicated line.
> 
> Maybe this answers my question about where it's restriced by CPU type. I wonder if this 
> check for M68K_FEATURE_UNALIGNED_DATA could be avoded here and done by checking it in init 
> and only set the unaligned method for CPUs that need it to not add overhead for most CPUs 
> that don't need it.

No, there's no overhead in having the unaligned method present always.

But swapping the order of case labels, or sinking the tcg_gen_qemu_ld_tl call below the 
switch, is a good idea.


r~

