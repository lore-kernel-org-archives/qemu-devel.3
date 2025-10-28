Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD16CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlG8-0001Pb-NU; Tue, 28 Oct 2025 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDlG2-0001Or-Vh
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:05:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDlFz-0007Mq-Ho
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:05:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4567924f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761663903; x=1762268703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gI+dIqitN4u0DNNL5JuKfWcUJoQZ5ChExIyW5psLpFo=;
 b=VTSEXhWuxku3xkpzVD1GEhKx3p1L5AN217E1AjO2WWTTvi+AsOow4d93B+vhm1tNy+
 LU50D4CV9/3L5IxNb5ri3e/6fCVm2OvwfSuM0PtvjDvR7qGhc3wy894ErvkHXpMWwbl1
 wG174fjaOHmlhIulQnHtS8k9q6WHtwNTLG48iMf+2sM9bUubP93YuEA50Zv7M22cway2
 IYRo8oGrVAf46/7sNJMxBEdaX7JbIQfDw+beuMV8NMYLZQr9UfU0NPWEe3NJ0XeQKMfd
 MLOQaGCLoi2K49vjh0ecMinbkEpm2j9CQkJb46pLiCRiL6TCfdzWkACDXfm1M6KUysGV
 EbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761663903; x=1762268703;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gI+dIqitN4u0DNNL5JuKfWcUJoQZ5ChExIyW5psLpFo=;
 b=ps109Vxd5urdUhjOOTH0Y4bUBpsx6cACxrd0fCfmm+rhNZCZAr7vxBczTXcncOGGPI
 17D8hYzQ4Pr6Xc0j7ZKOVZmfibkY5hQjOUrxjmz+Bw6U3G+AKxMvx1fqGIogXEAoPbDl
 He+C2Z+J7IMyMse14ViXF9tlQY7mMOtR+qw3x2Jg/U4U32ZBRA4d6q/SHGCTD84P/KCy
 yGUxhJA2XKHxxCrMjlK/NgHxV8LLU2oOT08/JEFAVOJEhNDghQmjUDluCWuwTgk2xPO4
 9xadN2w8IMeL+TpJf7/jzLq+IJAlYyoKMl5WzgrM2SLRvIfWMZTrxhmhPRn1BxDCNDUl
 6cWg==
X-Gm-Message-State: AOJu0YxjkIxAVWSEWtxqqFIex+/m6qFQMj+2rPJLmo6qH3xdhOI7nNlT
 UKfbPbY4qqlIb/4EYYFhGRkJcwLFfofdiclnC4clbyexKGsRATkJCT1DwCpTyYl/XG4=
X-Gm-Gg: ASbGncu93WSekUBjoye4f9R8/TsgxeIMvyKoGGnVFCeirDaloamHYJQFSPZ4caihUBg
 gLQ861sV4JQ0wbgEju6VIGhifY7C6WjiDMTHz7fPyHltg3vsUEh7ETaMi6sLRnyg+I4ELCATyHJ
 MkOnsKgXh66TBj7CIQoIDbabxcZhJ18e8TPRAzBixr/Ei06HB2mYHavv9ggRTuc2nsp15IcSk2T
 cjlaLCbb6yN7ADK03D1P6V94OjfVkQ3zy8sWv+qGVkD/sapAhDG4TAo0U++33GLMK1tb9kwknNC
 gtvETlnabef+52TX6nXA3zuSRDdOgDTFYZbG8OwQmyiumnA/VvJgcbab7Wnkk5kjpBz5gtJgL7U
 e5dql5TG+EiflDS3BjEDxvzIzMLeT/+B9munfM3Xwu8Mkr88ofz+PHQ5m2F4SgYykienqUFw9s+
 ujFyzb/RJBFvZ1UMFt
X-Google-Smtp-Source: AGHT+IEKWXrJBed/MYax/lJdKB7Tn390MplIlxHLTGPuiWsQi/VlMeIvaYUJRm51EmX5D9BDTRkvEA==
X-Received: by 2002:a05:6000:40df:b0:429:66bd:3c97 with SMTP id
 ffacd0b85a97d-429a7e8236dmr3515670f8f.46.1761663903174; 
 Tue, 28 Oct 2025 08:05:03 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df473sm20846449f8f.42.2025.10.28.08.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:05:02 -0700 (PDT)
Message-ID: <b72c66dd-11a1-47e3-b909-9c4641e4d361@linaro.org>
Date: Tue, 28 Oct 2025 16:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/37] target/arm: Consolidate definitions of PAR
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-21-richard.henderson@linaro.org>
 <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
 <686b4a77-cf53-45e8-9b75-2b8dd9c4a67f@linaro.org>
 <CAFEAcA_gczP+RbKUx_p28AWN=s279rPLYaZCXjy0Bpr0NqPnPw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_gczP+RbKUx_p28AWN=s279rPLYaZCXjy0Bpr0NqPnPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/28/25 15:41, Peter Maydell wrote:
> On Tue, 28 Oct 2025 at 14:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/20/25 15:31, Peter Maydell wrote:
>>> On Tue, 14 Oct 2025 at 21:11, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> Create a function define_par_register which handles the 3
>>>> distinct cases for PAR.  It is easier to understand with
>>>> the definitions all in one place.
>>>>
>>>> Make the aarch64 to be the primary definition, when present,
>>>> rather than being an alias of the 64-bit non-secure aa32 reg.
>>>
>>> Doesn't that break tcg-to-tcg migration across this commit?
>>
>> I don't know... possibly?
>> I guess we have a test for this somewhere, but it needs setup?
> 
> I don't have a test specifically -- I tend to use one
> of my usual lying-around "boot linux" setups that has
> a qcow2 disk file, and then connect the monitor and
> use 'savevm foo' to save, and then check that -loadvm foo
> with the new QEMU works.

You're right, it doesn't work.  It'll make the 128-bit version more complicated, but I 
guess there's no avoiding it.


r~

