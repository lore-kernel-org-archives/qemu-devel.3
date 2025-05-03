Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EFBC369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBLVe-0002Ku-JG; Sat, 03 May 2025 18:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLVc-0002KJ-E3
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:39:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLVa-0007D2-KU
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:39:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso39318675ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746311937; x=1746916737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TzZ6/rd4q6aCbwYQPJ+KXhulQgHBRP5Hhq/AeRCnMhA=;
 b=bfVLcnUsIJ2nnJm1JsnRy7185E/sIsDpJBvnr5fWA9F3uoNM8IfI5Tpn0x87NBYcVo
 nDvRrB8ImQXC7DtmCtHvgB9QTi1Kq0ba0+UgnmqBs3e3CGWWZd/BUvr8cT2XXjGRZg5H
 7Bf5vHuZsj0E8SYZGomDoU9U0y8ozjVkSy04sST1TOVeb2XK3JpdobrY4OUxdk5knnh3
 R9YEjw27N4aMsAqBwWyNbnGc7Z8/YcVeG9RQOYVwPutHgp1QhPpI4JR3GJsJfF6UV8jx
 qlFsNax4fkYL6mCeFi9Bh8VUE7KtTFg9aWOxrkuBklTsv9Mk0GiRFP53AxoLMz1l0nXT
 0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746311937; x=1746916737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TzZ6/rd4q6aCbwYQPJ+KXhulQgHBRP5Hhq/AeRCnMhA=;
 b=T+jFR/uSR8H0oZP3ITDW+Z8YkdQj8pkndGuJFBpCi57zCQoUi7e+OsMS8LOqrSjM1u
 jwDRJZvaMeb56lSFSjAWcyB9c3LjFq8jP92t2wohctVU2SxlZFMMmo+6AtuGO9SiISuk
 1QJ4SWjcJcH1UDXsT5CpbydOcUMKlD/CVKOKrStdaZXva26mjtQwTl0lpuLeAHvxUiE3
 BTObXepljm/VKFFMdaVgp2T+7vltPkra+9GR1N5nntt39XddpmeoKgAbuiHsWV6MigTT
 BjNRL3LYvm21x/ouZMH2cF7R405UstKbt2OzfcAxgC6b4QO4uFMULKXvD5PWp4JM+xgH
 N/Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV93w6cTnU5+EkD7H1yXqDgJ8GG1t40Vc0vtRhOP4Q0XiFNJPV5dvAWxHZwVQ6ygrSiHb8ZNcynAHPJ@nongnu.org
X-Gm-Message-State: AOJu0YyOVQC8S/2LRGg3JFwnodUYA5KuNBa2qs0NqCYiBo2Rq3awWlsE
 lzIU/tEv8wvgwRDd+RVrhuZWZkaoCatr8IPENK79EQAQeVjcUus+NJYGZQj8rfQ=
X-Gm-Gg: ASbGnctvnx33QHir9A/jETMpuqwac6h8Vw0sFp77sX1jdNocSuPgZ7KW4xIJXibQ3S6
 IPl8ItmAZ4x09h71pOsSf0ojm1S4IyPQdrZrAxLRzy974QbqGwAZDRz9TF1FbJTBuMNI3rn/2u7
 xp9kq3fxMKZ9k03FHFhBrK0oWhcMwWfIl/t5xk0jxswTtVnbYUYY+BrM7ZP1Xx0FBDkaDab4Ea/
 ZLbLOjZVRVodpJL8FYws+qlXIMaCOq8qNUbWc6tDbfDq52Yui4jlLm5mPmlWI664aVTBT97nSjb
 6CM0PEsUmb6JBFyPirIXUceFXsMrsmdUSVTT51bxV2H9DF1xQsrPNA==
X-Google-Smtp-Source: AGHT+IGbvuzrDbhbsKgBrbhL/DT5H2efQa2r3sIZ0UPYi0CpGdc8SJZM4M9idFIWtsGgO9FOv6TJ6Q==
X-Received: by 2002:a17:903:1c3:b0:223:7006:4db2 with SMTP id
 d9443c01a7336-22e1031fc0emr143723965ad.31.1746311937096; 
 Sat, 03 May 2025 15:38:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7aea7sm3875921b3a.8.2025.05.03.15.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:38:56 -0700 (PDT)
Message-ID: <ab094518-f0a3-4b2f-8c13-ec77b4b2e9e2@linaro.org>
Date: Sat, 3 May 2025 15:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/33] target/arm/ptw: remove TARGET_AARCH64 from
 arm_casq_ptw
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
 <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/1/25 9:24 AM, Richard Henderson wrote:
> On 4/30/25 23:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/ptw.c | 13 ++++++++-----
>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 424d1b54275..f428c9b9267 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -737,7 +737,14 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>>                                 uint64_t new_val, S1Translate *ptw,
>>                                 ARMMMUFaultInfo *fi)
>>    {
>> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
>> +#ifndef CONFIG_TCG
>> +    /* non-TCG guests only use debug-mode. */
>> +    g_assert_not_reached();
>> +#endif
>> +
>> +    /* AArch32 does not have FEAT_HADFS */
>> +    g_assert(arm_feature(env, ARM_FEATURE_AARCH64));
>> +
> 
> I don't think we need an assert here.
> 
> The ifdef for aarch64 also protects the qatomic_cmpxchg__nocheck below, because aarch64
> guest can only be built with a 64-bit host.
> 
> Are we still able to build qemu-system-arm on a 32-bit host with these changes?  It may be
> tricky to check, because the two easiest 32-bit hosts (i686, armv7) also happen to have a
> 64-bit cmpxchg.  I think "make docker-test-build@debian-mipsel-cross" will be the right test.
>

Good catch.
I was indeed building only with i686. I'll add mipsel instead.

/usr/lib/gcc-cross/mipsel-linux-gnu/12/../../../../mipsel-linux-gnu/bin/ld:
libtarget_system_arm.a.p/target_arm_ptw.c.o: undefined reference to
symbol '__atomic_compare_exchange_8@@LIBATOMIC_1.0'

> If that fails, I think you could s/TARGET_AARCH64/CONFIG_ATOMIC64/ here.
> 

I'll revert this change and simply do this replace, adding a comment as 
well.

> 
> r~


