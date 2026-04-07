Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F61FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACWS-00020o-ER; Tue, 07 Apr 2026 15:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACWO-000200-6m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:55:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACWM-0006dH-Kg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:55:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2addb31945aso38815485ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591733; x=1776196533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QyEMqWGumRUu1pPeeU7ZcpnY3SMPn9Jtym/seu+iFA0=;
 b=xwsj91sMuy5rXBsPm/QLKwsj2R0WoxMP2NvKp+mWuBx53XTJHNtAsq39qYJHj+pEnv
 OJtbq/Z34IgrNNFitxfMRpV9CajGZIyiARt32TAhclecyf9awNk0JgjlAuCyHY1VDgMM
 0+sNlzKdX4B/XVQNza2GHheum1HMG9aI9f6nSkX5xgHftq2GMGnL6ua6YhzVb9JLoN7z
 BDInsG+q1xaP1Z5jwxPdCVebXyxqrpX4X3kLsqXTnQEeitXkGnKxPBGSVXCQistCNCcv
 IQJeej0xmxPq0JHVl0Y46L+AU+hFvuJwt0/Uof8LFwgAkAjiKGAl+p4Pkuw0cRa3AAX/
 n6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591733; x=1776196533;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyEMqWGumRUu1pPeeU7ZcpnY3SMPn9Jtym/seu+iFA0=;
 b=aO9Mj3eyMzAVlrQ7AHsWsROj/KORNx/yL10ke5RYGaoTPIjpCDehwz2vho3I+ibatP
 1ZcsijMTbuKgtmLdzRlj62IKoVZ8h8kXOrcHIl5ZuzsRDaeKBh+0H6avmfUG5XQaIbac
 26//4Vx3UnN9cpmP0miTQ3uBEJCFQVcQufbvEdOkq2JrzUu0eFDdJCPHJane1XpNwXe7
 GZF0xvjegUiuGUTvynM/PjL/Qj8IQee/HE9yEXsho7u80OE611VRLx21Zwdjcj7p9UsJ
 EdrV8wODePxizfE1foRkbXmE/8LDx34IqFgaew1IxUguYB3d7KoI7TFQoTV1sh2xA6Oi
 bt5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzVMUMu4CTRMhgWybXv/rZSBW/4LWotrTwQFUPDMB4mmJyJiznC0rQQuLIjQF1UrpuBYjdxj/p0Lzw@nongnu.org
X-Gm-Message-State: AOJu0YxRTCz6JglCxiH+JXvJmse+qMh3HLCfGowSEtTWqcTao05lQ11K
 nixP6Iaj7GKeTGmlMHK+YsOIAialyPR9XEXT5+rRZ041sauQ2roUijmLCvYV++/UemQ=
X-Gm-Gg: AeBDievoBsvNAVqJbfQqos8VG+RgLZRRQd6Sc8hd3bcRSWOa/yscyNpX0Sc52OtnMMo
 /Y1BOLdVJA6jvIn0Ew6RP+mbZ3w2WvdnzgKZRQItxsgBBlHKuWDG2QnVKGlnAuFLFe2kwx3EDsP
 kRxlxPtnHzV0E1H5xs06Tp5WS0Qk4AXS9b9ZtHxPWlYef1nbYeIEfiMvPKV9xfptBNfKPizB7pN
 XnzCvtesDEwndl/AWY9RXmyzCfR8CSCG7YqyYzAFgxL33sCYfDTPsZe3mMNdRjzUdEGWH4ORJno
 W9YacrrPzDyCd3XNfhlYmigr3bDbZThSbFf0vVYd4AheVzTvdmELO2E4fLcJFBQChEJ18Ys4PPT
 iXyYEv68czoF+w1bOlClYbYX6jQ99KKm49dtytTZv1SQW+PB2o0WTgGC9wOpgiV1rh0+iccCxla
 8am10x2P8jy3aqzKQM6Q75QDfqYba9iObd1NDg3/6I7w0Ubj6DcK70RQTmr/MzuQpJbRZyrQ==
X-Received: by 2002:a17:903:185:b0:2b2:41a9:8e10 with SMTP id
 d9443c01a7336-2b2819180d1mr191112835ad.23.1775591732837; 
 Tue, 07 Apr 2026 12:55:32 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27475ff56sm179048305ad.22.2026.04.07.12.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:55:32 -0700 (PDT)
Message-ID: <d8d0f960-90ab-4a26-82b8-15dcd908a5fe@linaro.org>
Date: Tue, 7 Apr 2026 12:55:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/20] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-17-pierrick.bouvier@linaro.org>
 <974cdf32-cd30-4267-b785-bad9abae088d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <974cdf32-cd30-4267-b785-bad9abae088d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/7/26 12:13 PM, Philippe Mathieu-Daudé wrote:
> On 7/4/26 04:27, Pierrick Bouvier wrote:
>> Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/translate-a64.c | 5 ++---
>>    1 file changed, 2 insertions(+), 3 deletions(-)
> 
> 
>> @@ -10812,7 +10811,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>        }
>>    
>>        s->pc_curr = pc;
>> -    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
>> +    insn = translator_ldl_end(env, &s->base, pc, MO_LE);
> 
> Maybe worth a comment /* Code is always little-endian on Aarch64 */?
>

Just added it, thanks.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>        s->insn = insn;
>>        s->base.pc_next = pc + 4;
>>    
> 


