Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0ECC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oXd-0006PO-Ty; Tue, 30 Apr 2024 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1oXc-0006P8-QU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:33:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1oXQ-0001ee-PY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:33:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34c90082dd7so2923518f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714487574; x=1715092374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oy94RXbzt1o7Hb4z2TgF6TZY1GSlS5ytTYwKB2CcKEo=;
 b=EmOyc5VxXrlKq91d4XN5JZEFBrfGJtDfa7UPpSrHRHQuS1FxaDMbC44Ks6zq4YPekD
 z9qyNqI/m+68waQyq9QR9RpvHtwLuHHksM1WbQIbmIqQyVf376TGnnmU6sEr35Ch35UD
 XAJ4of+IMfUiqYuhPY/tkPoXgaFTE4NLjcH1X6oDQFEARTf7v21yyTbdh4FQjtABst/h
 KvVkHGlYBVg/pRGHAHCh3U6+6ascOsdWg5MFev5FRyi+B9RrkWw8tmI1/VILgl29R1T/
 sqq9ULN25CU+CxMm64+aefsWL15O5CapRMHWxutIaem3IrT9GdQbJvqblRjwAftH9UJo
 sjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714487574; x=1715092374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oy94RXbzt1o7Hb4z2TgF6TZY1GSlS5ytTYwKB2CcKEo=;
 b=ZdoGdLGj/TeC/8mqHnTw/eBA6IHvPWZzYWAQftE7QrOflB8s6ijTnL7I9mzu06q9W+
 97OvAwj0DGCW9LJHiLRAXRRW9pWxz7jfKTS+1r1DsegnJH0PBdqSD8Ok9IhA0TFxSBmW
 QPojPz98jsIlkg4wUk9eRh7IYv2wkV2MFQ2F0YsqSn4jZROIKT7gl1UAceq62Hip0fvK
 sl7ZXJ9DnCpG/p/HUIU39mjTDGCK9GJ3CXz/HDCWbOD84L9V6ZjblPeiIhp8xy3T7TBR
 /RZy8FpLay0wemQUuG3AW0pqk0exSdwriyp6bxbMeu1kRIDZSKECvE/Y1ZhHJkjgeqGL
 HSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG6VTKN3saGZS9MXOPEcHWu2EK0l8J33J+MVOA8ps3QYu8R+A6ujFReP0Q1x+lmId6mGJigiO70sJJ2jGSJl2WuDdQjvA=
X-Gm-Message-State: AOJu0YzYT/+qVmt4A9M80TEa5AvghtEGnhA8uMgVbeTqp+rrZZAYHRdh
 D9OyVl+GjJUZ4UQWxP4yT6qS4TGyZhCRq+qzk1RuTOFCLHo1/WONoKarNk8Z7+I=
X-Google-Smtp-Source: AGHT+IEvKkWzpet2FPZmc7i0cBEhhTAkRJgUnEzKe1AjCj0z7iHiqiqNlVClr/h2R0Ih9mMyr0WC4Q==
X-Received: by 2002:a05:6000:4ee:b0:348:4519:15b8 with SMTP id
 cr14-20020a05600004ee00b00348451915b8mr8560613wrb.40.1714487574058; 
 Tue, 30 Apr 2024 07:32:54 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600001ce00b0034d720141a9sm2079020wrx.79.2024.04.30.07.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 07:32:53 -0700 (PDT)
Message-ID: <84cb5da9-fdae-45d0-83c8-5d61be396c43@linaro.org>
Date: Tue, 30 Apr 2024 16:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/sh4: Fix SUBV opcode
To: Paul Cercueil <paul@crapouillou.net>, qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-stable@nongnu.org
References: <20240430120650.70539-1-philmd@linaro.org>
 <e21812c1594771f0a396e7ab14a1cb4b05324387.camel@crapouillou.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e21812c1594771f0a396e7ab14a1cb4b05324387.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 30/4/24 16:16, Paul Cercueil wrote:
> Hi Philippe,
> 
> If I'm not mistaken, the overflow / underflow can be calculated like
> this:
> 
> T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31
> 
> Looking at what Qemu does (before this patch), it was doing this:
> T = ((Rn ^ Rm) & (Result ^ Rm)) >> 31
> 
> I changed line 936 to this, and overflow / underflow with SUBV now seem
> to work fine:
> 
> tcg_gen_xor_i32(t1, t0, REG(B11_8));
> 
> So a change from REG(B7_B4) to REG(B11_8).

Correct, thanks!

> 
> Cheers,
> -Paul
> 
> Le mardi 30 avril 2024 à 14:06 +0200, Philippe Mathieu-Daudé a écrit :
>> The documentation says:
>>
>>    SUBV Rm, Rn        Rn - Rm -> Rn, underflow -> T
>>
>> While correctly performing the substraction, the underflow
>> is not detected.
>>
>> While we can check the high xored bit for overflow, for
>> underflow we need to check the xored value is not negative.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
>> Reported-by: Paul Cercueil <paul@crapouillou.net>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/sh4/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
>> index 4a1dd0d1f4..1c48d8ebea 100644
>> --- a/target/sh4/translate.c
>> +++ b/target/sh4/translate.c
>> @@ -937,7 +937,7 @@ static void _decode_opc(DisasContext * ctx)
>>               t2 = tcg_temp_new();
>>               tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
>>               tcg_gen_and_i32(t1, t1, t2);
>> -            tcg_gen_shri_i32(cpu_sr_t, t1, 31);
>> +            tcg_gen_setcondi_i32(TCG_COND_GE, cpu_sr_t, t1, 0);
>>               tcg_gen_mov_i32(REG(B11_8), t0);
>>           }
>>           return;
> 


