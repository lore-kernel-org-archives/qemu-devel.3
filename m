Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25E2C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfSc-0000vs-Ql; Fri, 21 Jun 2024 10:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfSX-0000vX-EX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:41:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfSV-00005w-PC
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:41:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f9d9b57b90so12671475ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718980906; x=1719585706; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EadQnRtkxnuKs9n7EVh0RBW5rPvMo6y9WTGkbjtPRQ=;
 b=Ar6XBMscMkGyrSvQ1uZ16CIidypzA1dmm+NUbjzS5XFZ8zg8g1G/WggTTgk3FODRU7
 oiltyoRE5YGkagTR36LICGYl2F5vJzfOsGTdRjC5+48bQB7XO5hlAy9+9e+XrwUXId6I
 M7M7Xc41Lb772sYZiIrcoQDkv49Yedo+Ul2JmuvguSe+LDC207njC95zT2fr1pcFEu7y
 cP3pIGPHvMbVinaEgE8gin9tA30LPpVl/Q1sqcfOJNjRz/50dZq6OE0gC4s6bZaxkHHY
 JfYp6vWHBdxKTzhHnvCuj/0RHMSK/njpYk0rVlwyiSq+Jkup2kIhqdk0qloP/Rdqwi1e
 2SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718980906; x=1719585706;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2EadQnRtkxnuKs9n7EVh0RBW5rPvMo6y9WTGkbjtPRQ=;
 b=r8oAiiH6kSGUjThIjrFFhjS7YM8JgI7JYjPhFH22hYRoxzpl+UGTEgeYimAzOtpl+h
 uafyi49J8kM0aakP/8VG8nsh6vxlx5ELN8y0gpbzgrWIjU1x6QviWFfD/KP325uGUrcc
 4uiNxMB+Saj9ebhFCopA/L2A0K9mLa2VZiVhHSbERUx5e2ovDf4NQ6UoRF5lmagEjVi8
 8ojerYIqVC1vP1thoAvtcBECkNgDFLNIUjo91x2lxFaDO5X02ChVp+YUP8hAU3vbo7Qo
 D6yP73NsQhiJ/mN2wByI1awL6loVXRu8mcmTL0Gyb405YMLPEAMkCrz3oZnnk3ddsFs3
 /Ccw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMzOUuXnZPLq91y/660IgLeB72SKrVQ6h/A3wmuuj9gE7dqwo2b7dSMECGxJaLr+l05pt1r/z4QwDWyM4yuJnlxDUIzGc=
X-Gm-Message-State: AOJu0YyYFjBTI/slNGUtcoPvgSmqee70Gae3Tda4Mqq4AbDuRvTpWF0P
 HDr5sAtMR3/So65OmPKFdVbl4kx7897u6xqeA0EIoa1XwM+cOuH2f9qBjFnuGlrFKvZbo5HY306
 H
X-Google-Smtp-Source: AGHT+IHXuHhxqOIhzmYF9zcL0hNBVe8xGod9J24jOhhlX5oJqsWPGVmyhwZEJJ4UavTBi7sft2B4pA==
X-Received: by 2002:a17:903:1248:b0:1f8:3c5d:9eb with SMTP id
 d9443c01a7336-1f9aa3b1488mr104263575ad.7.1718980906349; 
 Fri, 21 Jun 2024 07:41:46 -0700 (PDT)
Received: from [192.168.0.102] (200-207-104-144.dsl.telesp.net.br.
 [200.207.104.144]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c591bsm14816985ad.165.2024.06.21.07.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 07:41:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] target/arm: Move initialization of debug ID registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <20240620181352.3590086-1-gustavo.romero@linaro.org>
 <20240620181352.3590086-2-gustavo.romero@linaro.org>
 <2af6449a-f4c2-422c-a92b-cfb11a5ae2d5@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <c9cb3219-b55a-e05a-7253-3ff270bb58fc@linaro.org>
Date: Fri, 21 Jun 2024 11:41:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2af6449a-f4c2-422c-a92b-cfb11a5ae2d5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.465,
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

Hi Richard,

On 6/20/24 3:21 PM, Richard Henderson wrote:
> On 6/20/24 11:13, Gustavo Romero wrote:
>> @@ -1268,7 +1268,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>>       t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
>>       cpu->isar.id_aa64smfr0 = t;
>> -    /* Replicate the same data to the 32-bit id registers.  */
>> +    /*
>> +     * Replicate the same values from the 32-bit max CPU to the 32-bit ID
>> +     * registers.
>> +     */
>>       aa32_max_features(cpu);
> 
> I think the previous comment is more accurate.
> 
> There is no separate "32-bit max CPU". There is one "max CPU", which supports both 32-bit and 64-bit modes, and thus has both 32-bit and 64-bit ID registers.
I see. In v2 I reverted to the previous comment. Thanks a lot for the review.


Cheers,
Gustavo

> The rest of the patch looks good.
> 
> 
> r~

