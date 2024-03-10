Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A53DC54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 18:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjNgU-0001T0-2N; Sun, 10 Mar 2024 14:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjNgS-0001SW-MQ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:14:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjNgQ-00009U-Vp
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:14:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd6198c4e2so24395705ad.2
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710094441; x=1710699241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXt91NIiTjKQaj0RlZZ6mADCIBVYFAJXW1zt0xhpVfk=;
 b=LVpgFeHPrgLlXKauo65lvTQsEm1oiLPM6FNGtClcrtHvXhr8s3m2uApC9EjRfNoY3t
 eaNh4Be66mduZaBl17L/2gjVRht5u7snaaevmL3noFGEtcuvq0dMx9TEEMaCwpPt3HVo
 jUNt7UjYCoZG62UDvt4lX2eZvhAiRwkKPM9REUpth5pjb7wh6Y9vzBBdO/tgLmzbVFvo
 otjO5xmbx/IUt1TALaS2eEwhR+A6koCURmUhPAS89FRgfpnXUwxb8ljY10OJL5nmDx9w
 79OxN3zWpUnt0VC1rxyLMAe+nggbmxtrP+v/7Wm1bC52ykQTZPhDeTg3V3fxc5wT7rtC
 hWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710094441; x=1710699241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXt91NIiTjKQaj0RlZZ6mADCIBVYFAJXW1zt0xhpVfk=;
 b=EamMnL96V0qD7vUnNGIY3kIJ5LUxHfyDQTa0kUzW3ioK30Qmx6SCKsH4i5I8sj9/fR
 RWMebbA4dD0zzTGlLApc2oaGV/2Ln3OpZo9/6XiysfHCfY1nJf2h0wRqMAq2KsyOuien
 UrQ6RnU/CBOGdKdgL+tInYJpEMmi+2aDaXMQ7fXtKls2TNx8mBVj+qCqh1XifMDQpwSJ
 ALpfJAJC2fAEfVKDHNrb4GHFTrzhVQlButbu3feHarbzCbKlwGaRWHQURziTjlZ+7edH
 iX5SCiJksriDjwsjB5KEyVeWsQxKp+G3iQyogSORi/jnpoBNVHcyxmdyO6b0RBnEixqc
 uN2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYjKoDCtUNlhS6a/9cWRVMqbp8ei/kDWFOdTJZHRKDGRi4jgB9KpPYh/KB1bhsfq4rW1pH5pdufWPtpKTSNca3FZqsNPE=
X-Gm-Message-State: AOJu0YykJLyhbA4p9SVPweZDXABaMMITG+bh2K6hdXJ7xbJipGKbsSBf
 m2tEvdawf7ET/Uqh69JB8az4qoJJ91KdU8PsmR5qOHoqftMgp2OcEfFdisehpWQ=
X-Google-Smtp-Source: AGHT+IF15BSlMxa1IQ3yItyqIQ0tPrOSr7gXC4/aTSRuCxjoHt18ek0D1rPJov6BaQ8f0AC1dSB4PA==
X-Received: by 2002:a17:903:192:b0:1dd:5f85:1197 with SMTP id
 z18-20020a170903019200b001dd5f851197mr6414049plg.64.1710094441540; 
 Sun, 10 Mar 2024 11:14:01 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001dc3916853csm2952200pli.73.2024.03.10.11.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 11:14:01 -0700 (PDT)
Message-ID: <1f5e8229-18d5-46e5-afba-3fecf2c5504b@linaro.org>
Date: Sun, 10 Mar 2024 08:13:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix 32-bit SMOPA
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhuojia Shen <chaosdefinition@hotmail.com>
References: <20240305163931.242795-1-richard.henderson@linaro.org>
 <ffe7207d-c88f-444f-804f-a3597976ee3e@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ffe7207d-c88f-444f-804f-a3597976ee3e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/9/24 08:40, Michael Tokarev wrote:
> 05.03.2024 19:39, Richard Henderson wrote:
>> While the 8-bit input elements are sequential in the input vector,
>> the 32-bit output elements are not sequential in the output matrix.
>> Do not attempt to compute 2 32-bit outputs at the same time.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ...
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
>> index cded1d01fc..ea3e232e65 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -67,7 +67,7 @@ endif
>>   # SME Tests
>>   ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
>> -AARCH64_TESTS += sme-outprod1
>> +AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
>>   endif
> 
> I tried to pick this one up for stable-7.2 (since the fix is for older commit),
> and faced a fun issue in this change to tests/tcg/aarch64/Makefile.target,
> since 7.2. doesn't have CROSS_AS_HAS_ARMV9_SME yet.  I went on and found out
> that the following commits:
> 
> v7.2.0-374-gbc6bd20ee3  target/arm: align exposed ID registers with Linux
> v8.0.0-2358-g3dc2afeab2 tests/tcg/aarch64/sysregs.c: Use S syntax for id_aa64zfr0_el1
>                          and id_aa64smfr0_el1
> v8.0.0-2361-g1f51573f79 target/arm: Fix SME full tile indexing
> 
> applies to 7.2, and lets this "Fix 32-bit SMOPA" change to apply cleanly,
> including this very change in Makefile.target.
> 
> Now, 1f51573f79 "Fix SME full tile indexing" is Cc'd qemu-stable already, but
> it is not in 7.2.x for some reason which I don't remember anymore, so it is
> a good one to pick up already.  3dc2afeab is tests-only.

Oh wow, I didn't expect the fix to get propagated back that far.
I was expecting only back into the 8.x series...

> And bc6bd20ee3 (from Dec-2022) seems like a good candidate too, is it not?

Sure, couldn't hurt.

If it all applies without drama, all is well.


r~

