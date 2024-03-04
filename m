Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA37C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhApx-00041M-Rg; Mon, 04 Mar 2024 11:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhApw-000417-8T
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:06:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhApu-0006KC-ML
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:06:44 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso41704205ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709568400; x=1710173200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BotBHHJxq/7wzdFpe6g9ywN1bmJFUFIIFEQ/UIBMD3M=;
 b=NPemz8HEStkO8CEKIQxPAZk556IjhY09mCCSbx2lyqp2JQ7HXQcKNizeSUDcxu3bV7
 ktMgdRrhxZUvZKCr6kcea4Yq0Ws1vmiE6e2w8otjQVD4Lem8gHuoIU+EcegOvO0zIlz/
 c7uYw3yiTXTxuWZ0JPFaaNvynyl9RX+DqWWDr8Oymo1Rn3hqW4+HaSJ2tcCFnjXcSB/n
 gcewy91YYCxW5rhP5ry0GMgJksotd/d5LcSHEjYGrMEe4EvVpX/gqQfwt0cryS+RF/u/
 kx0kkhif2wE1AXhyU1gW3B+oLyW8en63dxDZJoEcwH8AMgg1AgSsJ2IxjtAK1hNrC3Hk
 /IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709568400; x=1710173200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BotBHHJxq/7wzdFpe6g9ywN1bmJFUFIIFEQ/UIBMD3M=;
 b=CzUKcERfs/hyFGyveloPMF3Ms4rJCt7et9wUeD6U/zzRyldHMUn0B861jktr9dhRJO
 4aC9scTL9UhajiV3bG+c6fsdD1tpVlgb8VKEuQWgmudp778FTHpNc5L5eBXLHiJjVNaO
 7/+M1V3CHJOkjNCoSV7fuZccBdpELJjL2lDttEg+EYPy9H+6CnTRxiDIWe0CF6J9BvRT
 iKpHGxPBc0OgBtdtOTfu6lzQ8UQhGEAQ2H82sIOf56nU1xnyLm4cfTSxR7cnG8D+ox/t
 lLFedUTMbg+kyx/6kplGV1Iz2c5TwFkVtxo1g2A7U91S7L1rAUcPRc85D+FKkXekPp/a
 fOUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw/Yiefd6cJXzeG6NzcGVwKCXkIo4GIkHJtpFYDv53vgkMimWKf2+7N59vDMC/hwuD+7BZ3e4FrKf1b+pjDsgHgySPS5c=
X-Gm-Message-State: AOJu0Yxh9c7smKye6kI1Tps3s1iqJUOySutaNNajYdO+9bKzS7nu5tBC
 4pOaA3pXnLbyjfMQ8fMKjrj1M/tBozb+ad01b+3g6XNr61aTn9Na14xTNtnoqBeny2iWvHw6IOV
 2
X-Google-Smtp-Source: AGHT+IE8UKvsh/QFmQjG+siugqREM1LcCzPFQqaqTNjcEf+GOFNf+Rqm8pq5l5+qvQAJOCulDnCj+g==
X-Received: by 2002:a17:902:dac4:b0:1dc:ca43:307 with SMTP id
 q4-20020a170902dac400b001dcca430307mr13513680plx.60.1709568400489; 
 Mon, 04 Mar 2024 08:06:40 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q12-20020a170902a3cc00b001dbad2172cbsm8895050plb.8.2024.03.04.08.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 08:06:40 -0800 (PST)
Message-ID: <3591c2e0-7713-4fba-83b0-214c9159b49e@linaro.org>
Date: Sun, 3 Mar 2024 20:44:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: Fix assemble_11a insns for wide mode
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240303021925.116609-1-richard.henderson@linaro.org>
 <20240303021925.116609-3-richard.henderson@linaro.org>
 <d71b8c47-336d-466d-bfbb-c04f955b20e7@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d71b8c47-336d-466d-bfbb-c04f955b20e7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/2/24 20:52, Helge Deller wrote:
> On 3/3/24 03:19, Richard Henderson wrote:
>> Reported-by: Sven Schnelle <svens@stackframe.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/hppa/insns.decode |  7 ++++---
>>   target/hppa/translate.c  | 23 +++++++++++++++++------
>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
>> index 0d9f8159ec..9c6f92444c 100644
>> --- a/target/hppa/insns.decode
>> +++ b/target/hppa/insns.decode
>> @@ -24,7 +24,7 @@
>>   %assemble_sr3   13:1 14:2
>>   %assemble_sr3x  13:1 14:2 !function=expand_sr3x
>>
>> -%assemble_11a   0:s1 4:10            !function=expand_shl3
>> +%assemble_11a   4:12 0:1             !function=expand_11a
>>   %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
>>   %assemble_12a   0:s1 3:11            !function=expand_shl2
>>   %assemble_16    0:16                 !function=expand_16
>> @@ -305,8 +305,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      
>> @fldstdi
>>   # Offset Mem
>>   ####
>>
>> -@ldstim11       ...... b:5 t:5 sp:2 ..............      \
>> -                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
>> +@ldstim11       ...... b:5 t:5 ................          \
>> +                &ldst sp=%assemble_sp disp=%assemble_11a \
>> +                m=%ma2_to_m x=0 scale=0 size=3
>>   @ldstim14       ...... b:5 t:5 ................          \
>>                   &ldst sp=%assemble_sp disp=%assemble_16  \
>>                   x=0 scale=0 m=0
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 585d836959..6dcc74e681 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -121,12 +121,6 @@ static int expand_shl2(DisasContext *ctx, int val)
>>       return val << 2;
>>   }
>>
>> -/* Used for fp memory ops.  */
>> -static int expand_shl3(DisasContext *ctx, int val)
>> -{
>> -    return val << 3;
>> -}
>> -
>>   /* Used for assemble_21.  */
>>   static int expand_shl11(DisasContext *ctx, int val)
>>   {
>> @@ -144,6 +138,23 @@ static int assemble_6(DisasContext *ctx, int val)
>>       return (val ^ 31) + 1;
>>   }
>>
>> +/* Expander for assemble_16a(s,cat(im10a,0),i). */
> 
> Typo above, should be assemble_11a().

No, that's the pseudocode in the manual.


r~

