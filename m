Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EAAEE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPG6-0003eB-Le; Wed, 11 Sep 2024 11:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPG5-0003b5-NW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:27:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPG2-00038w-6S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:27:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso6012935b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068468; x=1726673268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3MtBeUHgye42AOXvjIp7egSBQXEEcQsnrIgj2jL0eM=;
 b=fbrqyf+XyesPwjkwLk3sDkYpBMgcYZ3fhxSmTU2eL1xVs0/U6aDfe/HjxgG80fmmkp
 BXACnMY3+H344+Am87GdXG1wEo35PdvkjvAWlgXmXaihCXEo2O5X7LTlb0Z9c2awSRrz
 2KwsNA/pAQxLuMtmTpmtAbGhOEMMbXP63+jrIZpuS4JQjaWuhmVv+6j7EOmuMnCUNW7e
 iPhhq3lsrf3vyYOaKiEVzy878oQSEm0sCqztqqt38YGc9E0a/txMKLyQNwgGWp3bRB7F
 hM5xvSKgLculxpiJQvjmeoyCskj5ub64jJpC2FYMslMnO0IAZqFHg6vrRtB7y0nYixSw
 RVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068468; x=1726673268;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3MtBeUHgye42AOXvjIp7egSBQXEEcQsnrIgj2jL0eM=;
 b=sjV9BANTlOkRShZnQlhKMubgBhi3urLImiPBqeGO//EfSUTekrC1//tOWJjP5Q3zAs
 MEsqfIZ9gdzTfRhrzCimDxKagKCaVUAehIYF6B8Cg4CJqmk2aL/FlltkIigesu1mC/9q
 +wggNR9ya5pwOjF1sDB7NuBzzAGJk5YHkXiPZme5LhVbMZ1aVaudXP4vgwxrVPi32Mx4
 yJm4w1i09mRZeOkG8un8mnTLjWUpxB1Jbjk3vhlCsFbu7jbl5/uJge9E4CmswMCkSg0Y
 uC26dxHS4SUYG6oZVvQJkH3Y+XZP+Z6aPzbgpDNQxv+/1qFeNHX9CPWqFp7BkdZWq0Jn
 206Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpSh7XGi9Ysu7KyTt/pBVD7EM8eFNd7F/PnvQQ5rp3dqhmTUUQ5xudLL5cEXs8iu21S0xteu8lT4nt@nongnu.org
X-Gm-Message-State: AOJu0YzGGA1leNdS/gwFFyCXRH+mOgZH5mGiNa2G8wyxCueeV4kQw0FI
 3kbT0tmlcbKRThKzMdgK0jTLZr0Vyy8t2GEycL8jey96eT6ShD/pDdTrRw86iu8=
X-Google-Smtp-Source: AGHT+IHm3hHqHQ17jrSMNdBdjdufkA6GdS3qwTQk70IwH2tDgXNiglWaYqVeQj9CGVO5VeN+B1P2FQ==
X-Received: by 2002:a05:6a20:cf8c:b0:1cf:4569:ffb0 with SMTP id
 adf61e73a8af0-1cf5de118dbmr8887717637.0.1726068468472; 
 Wed, 11 Sep 2024 08:27:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719117257b9sm2589471b3a.13.2024.09.11.08.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:27:48 -0700 (PDT)
Message-ID: <75062fa2-db67-4136-a7bb-d9d3709b7229@linaro.org>
Date: Wed, 11 Sep 2024 08:27:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] target/ppc: replace assert(0) with
 g_assert_not_reached()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-12-pierrick.bouvier@linaro.org>
 <b26aeb05-4d26-4949-b43e-7f6320f4bfac@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b26aeb05-4d26-4949-b43e-7f6320f4bfac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 9/10/24 20:14, Richard Henderson wrote:
> On 9/10/24 15:15, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/ppc/dfp_helper.c | 8 ++++----
>>    target/ppc/mmu_helper.c | 2 +-
>>    2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
>> index 5967ea07a92..6ef31a480b7 100644
>> --- a/target/ppc/dfp_helper.c
>> +++ b/target/ppc/dfp_helper.c
>> @@ -249,7 +249,7 @@ static void dfp_set_FPRF_from_FRT_with_context(struct PPC_DFP *dfp,
>>            fprf = 0x05;
>>            break;
>>        default:
>> -        assert(0); /* should never get here */
>> +        g_assert_not_reached(); /* should never get here */
>>        }
>>        dfp->env->fpscr &= ~FP_FPRF;
>>        dfp->env->fpscr |= (fprf << FPSCR_FPRF);
>> @@ -1243,7 +1243,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
>>            } else if (decNumberIsQNaN(&dfp.b)) {                  \
>>                vt.VsrD(1) = -2;                                   \
>>            } else {                                               \
>> -            assert(0);                                         \
>> +            g_assert_not_reached();                                         \
>>            }                                                      \
> 
> Backslashes should ideally be kept aligned.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

I'll align those.
Thanks,
Pierrick

