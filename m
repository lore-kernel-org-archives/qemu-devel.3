Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0C5C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ses0R-0000pz-NJ; Fri, 16 Aug 2024 04:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ses0I-0000V4-IR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:08:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ses0G-0001n8-FT
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:08:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc47abc040so14706175ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723795687; x=1724400487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqOLdwiPSDslVN5BH5CrZvhHvw25bbg85+CZ6vr3JBk=;
 b=Hvudz57Nk+8eDxZZ8fCdKwNMmVtgBlPhek+O+T96/v7S568Xd34yUUinGWKESs2kfK
 sWAH3SMSjGUAX1EGiFrajRlKOykZTwJjhMOsWIQOcmklTM7lrNjR4EmCGq9QDfhDnMJI
 3MIP7tvwNKkRxmiL8FexcDGB7mIDFuN6cC0eCj7PPzMu3owtqeKqz6Uv/uusesyxcRDD
 /3N4+mW3+61jhUurVqP70d9W52PPpeJWa1tNyrFv8W59jTX60SJLbAmVit3+vMvu8gXT
 ztxjA7daLQCm0sZnkKN3TBH1EXlfbIATiiJij0odoBp1FRpzy+kKLyA0BXaeKnaoysT/
 9l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795687; x=1724400487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqOLdwiPSDslVN5BH5CrZvhHvw25bbg85+CZ6vr3JBk=;
 b=qDNXpTedJ5oKu/0nn5wHOfCxeSltn7XoU9kMMBK95N2IJxvbVarkAlz137vHjTSfiN
 lres0aNU8piKV6HKorL/McAScpsrLMD6txVS+198wqtd7eipFcPsX9RaHp8/E702icUl
 pUdWJRzKHPGJ5bMCBR2Pnz0ggrIPWbh719MMIY+0yUzdVCwZshRg3ufG/SUwNKTAk4NC
 2l0ftE1Iof3lmQEHVIkxirsc1ZAJtpQkvxza9NyZyDRxJnL29z3rTSe0gDbV29Yl1NRl
 uNxHu+V+k3yqdHRA9romiR9R5lKDwC5YEnr9HGk4jZoYW/VEJ/f5rA/IQH0BvmaiUppm
 wZTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp4a/wFcnW2n/CQNtARyIDUpjcjtZ7lum+1HE4L8JYk0OCJUdbmeiao/VypbtK9Ap7uKS5hjqZYS2A+lpLgRMdXTb6JP0=
X-Gm-Message-State: AOJu0Yyk7UV/lxL9si8i6Ts6Dq0+mfmJJmcGRoQRdTlglNtYlL17eWpU
 fm3pHvHMCe4TIXZT/EVmOKg+BUO9S5ySYkpdvpSYsDqjUwLpnAJFiF1r3gPvPROt9CLxcCsL/AN
 ZbcI=
X-Google-Smtp-Source: AGHT+IERTSHg0hPXVpcZ6d/ZYKH2Agh6xgtvb60IZhvpW62/CoSuChP91z+zk6gHMLtLSkivcsK1SA==
X-Received: by 2002:a17:902:ecc3:b0:1fb:54d9:ebbb with SMTP id
 d9443c01a7336-20203ea1da0mr27589425ad.22.1723795686587; 
 Fri, 16 Aug 2024 01:08:06 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0379ab3sm20778165ad.137.2024.08.16.01.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:08:06 -0700 (PDT)
Message-ID: <a04f056e-4903-4001-879c-6cd4329701f3@linaro.org>
Date: Fri, 16 Aug 2024 18:08:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/m68k: Implement packed decimal real stores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240812004451.13711-1-richard.henderson@linaro.org>
 <20240812004451.13711-4-richard.henderson@linaro.org>
 <f2c4d863-1c54-4f28-9215-2d9d55d0de03@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f2c4d863-1c54-4f28-9215-2d9d55d0de03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/16/24 16:37, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 12/8/24 02:44, Richard Henderson wrote:
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2488
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/m68k/helper.h     |   1 +
>>   target/m68k/fpu_helper.c | 112 +++++++++++++++++++++++++++++++++++++++
>>   target/m68k/translate.c  |  27 ++++++++--
>>   3 files changed, 137 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
>> index 2c71361451..21af6adb39 100644
>> --- a/target/m68k/helper.h
>> +++ b/target/m68k/helper.h
>> @@ -127,6 +127,7 @@ DEF_HELPER_3(chk, void, env, s32, s32)
>>   DEF_HELPER_4(chk2, void, env, s32, s32, s32)
>>   DEF_HELPER_FLAGS_3(load_pdr_to_fx80, TCG_CALL_NO_RWG, void, env, fp, tl)
>> +DEF_HELPER_FLAGS_4(store_fx80_to_pdr, TCG_CALL_NO_RWG, void, env, tl, fp, int)
>>   #if !defined(CONFIG_USER_ONLY)
>>   DEF_HELPER_3(ptest, void, env, i32, i32)
>> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
>> index 50b0e36cbe..0c9c3b7b64 100644
>> --- a/target/m68k/fpu_helper.c
>> +++ b/target/m68k/fpu_helper.c
>> @@ -750,6 +750,29 @@ void HELPER(fcosh)(CPUM68KState *env, FPReg *res, FPReg *val)
>>       res->d = floatx80_cosh(val->d, &env->fp_status);
>>   }
>> +/* 10**0 through 10**18 */
>> +static const int64_t i64_pow10[] = {
>> +    1ll,
>> +    10ll,
>> +    100ll,
>> +    1000ll,
>> +    10000ll,
>> +    100000ll,
>> +    1000000ll,
>> +    10000000ll,
>> +    100000000ll,
>> +    1000000000ll,
>> +    10000000000ll,
>> +    100000000000ll,
>> +    1000000000000ll,
>> +    10000000000000ll,
>> +    100000000000000ll,
>> +    1000000000000000ll,
>> +    10000000000000000ll,
>> +    100000000000000000ll,
>> +    1000000000000000000ll,
> 
> 10**18 is never used, is that expected?

A previous version did.

> Could we define KFACTOR_MAX = 17 and use it as
> array size?

Seems reasonable.

>> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>>       int done_mac;
>>       int writeback_mask;
>>       TCGv writeback[8];
>> +    uint16_t insn;
>> +    uint16_t ext;
> 
> Maybe worth commenting here what this field is used for?

Ok.

r~

