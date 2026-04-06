Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086CFB5173
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9sM9-0002FV-UK; Mon, 06 Apr 2026 18:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sM8-0002Ex-TP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:23:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sM7-0007mh-9y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:23:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso3054925b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775514217; x=1776119017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HKRVohwNgS3GPEAyBveVYL94MygZVVE7VquFlECQoQg=;
 b=cCKGwx9CzDK31sU+Ac+5KMh/QmpsgaU2O+x6fXgDR5gN+70VclCh5Y0AT0TW3bDKDk
 ia2E8f7PWlkpYj4feAzX5bFi3QpxeS3Jp4IoSFljcaosTTxNB1pdyqyeyBk3jDh/Do8p
 8TTfsfbk0/KOAJVMTqisuPxixMNo695yPYiVFuCxvnyO2zDaN9BYPCye9EYFn0klu3vZ
 PDKioailNeYwhdbuwt+SLPcTALnOxycmvoy8//Uhs/CXAfbWxUzvrLv8LgM69jDalpg1
 cnfmGlxbN/nWZ/M9rREbmVaNUJz74+YPMqa8K0wpJRrhnlCG5HA95JyHnL1ZLCyOeOnq
 rkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775514217; x=1776119017;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKRVohwNgS3GPEAyBveVYL94MygZVVE7VquFlECQoQg=;
 b=JY9m99KHGywBnjPC8iDyw6NZANJ9lS03CS1QGEWwK0OPZx8xYVdBnKX4+nQ72w0xOK
 oiDAe4RHlnIj/vDSgndENXGcnhhc3BXSeTzppj0PyZBZRDU5yH2wFpPe1dWVbSr5DZ4r
 sXJP06a17QI0bx3ZE9c4+veo3sqeBWc+f7arT67kYnDV1mHMUdejTw6Iz/U6lvVWEO7y
 miYN8chyN45SzVLdQ1UemGNf17vZgQ+v0k9dE6znhC3IDVvkOXT2qta4sZppOfTLzGq3
 zC5DTXrld1CDQmF221enPxF3QcUe8ZH28nORqCDo1OO9t0R7k4LMEIA5Drzt1gEZwFC8
 QTLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/6S+XnbQgFLJblabFxtSu2xx0J0qwPwkmpBAK8EJD0FNTmz8+AwUsUiQzSf+FKstbs64VDMz0Co5@nongnu.org
X-Gm-Message-State: AOJu0YzZBmxMDSZDZmanpQUVCy7SfmmP3e32sAVjeP1CKi5YYBxGBtUC
 +tKb9yGNLeUtFaxV9/et8HM52+zw/10dbusUZadRRmDkXJdgTsTtVqXEMh+tIDo0s0Y=
X-Gm-Gg: AeBDievOGTDiOiBq5tpm5+Hkhn//xTLwcnOgDWxIJNAzY3qhylWeHgUQaVUh+zP/Xhe
 +qLFBDU4Mn8/nPFNmV9foMPy3jGcqCgGUDuOF+J/t1cd93RLfb69s8chnZWCiu6Np5SM/ArGdyV
 hvRiGeCRTMNPpJPZ/qYc5zkpwgJh7Kqc47rsO4Je2l0iPfTeR3KzUYERUb9Fwoez463veEnZmLg
 E6sstBNKEWu43TGvNkLCiXlhEZQNhBH94Xr8/jrUa53G/4Rxu6tT6vI3pdyYYkLir+1W+rqNdVa
 a8ifY3Zu1OXjrfI400sCdi37pVgRwtwaDkUoEaXvxWb1InlBh/+Aq3jsEKWJSdByhx/Wx1u4nUA
 SVGuwIe2kEwtjLwtVxlp41/N6oIcyU8Xu3Xq1aPM8+mQLq2Zot3ljCaKMWNJDRrMZii0MPBH1L9
 XE/QyClGTGkvdAh1VLp2V/rHftM+E+7tLWwjIaR55kduQdfkYc8/+/dHO3dIXSTX1/QF+pQw==
X-Received: by 2002:a05:6a00:10c4:b0:829:6e8c:bcf4 with SMTP id
 d2e1a72fcca58-82d00006e7emr14849429b3a.0.1775514217453; 
 Mon, 06 Apr 2026 15:23:37 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c4126bsm14880557b3a.36.2026.04.06.15.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:23:36 -0700 (PDT)
Message-ID: <0ecc3a63-be69-48d9-adac-2fd8840496c9@linaro.org>
Date: Mon, 6 Apr 2026 15:23:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/20] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-15-pierrick.bouvier@linaro.org>
 <c7a00ec3-2a75-4c90-ae7b-7ce16db05d85@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c7a00ec3-2a75-4c90-ae7b-7ce16db05d85@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/6/26 2:31 PM, Richard Henderson wrote:
> On 4/7/26 04:26, Pierrick Bouvier wrote:
>> @@ -6881,6 +6882,7 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>>        DisasContext dc = { };
>>        const TranslatorOps *ops = &arm_translator_ops;
>>        CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
>> +    TCGType addr_type = is_a64(cpu_env(cpu)) ? TCG_TYPE_I64 : TCG_TYPE_I32;
>>    
>>        if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
>>            ops = &thumb_translator_ops;
>> @@ -6891,6 +6893,5 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>>        }
>>    #endif
>>    
>> -    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base,
>> -                    tcg_default_addr_type());
>> +    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base, addr_type);
>>    }
> 
> This is wrong.  You set TCG_ADDRESS_BITS to 32 in the first hunk.  You're generating
> 32-bit addresses in gen_aa32_addr.  You cannot then set addr_type to TCG_TYPE_I64.
>

Yes, I think I will reorder commits to introduce aarch64_translate_code 
first, which clears the confusion.

> 
> r~


