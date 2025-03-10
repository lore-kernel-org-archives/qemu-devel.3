Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99DC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgNh-0003O7-GZ; Mon, 10 Mar 2025 12:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgNe-0003MF-Hh
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:53:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgNb-0005ut-3G
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:53:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-219f8263ae0so85359895ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741625604; x=1742230404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79s8+mstomonepX5d5d+DntInPkYCBzA5RgBbJU2qMM=;
 b=T1xgxSyTtuqLbzIDhduX3YQgXweZYfh1Agx4B6us4cPs4XXqow2sVeQnR958FCggpb
 MrI+1jPujhMDYFfUwTGHB3uUYdFROpOv7j+eRs2ST6z/Yo2pozoltnd0VjyiJdxDajdW
 BgbMpmB3ZJbvJXQx5xCZBDl+mmIsVHzNffyTskyUraOpJQR7v9v+WB6/R71IJzjigQlv
 MHi9ggAQo4Yk8glFWDBFDFgbf5E8tLFWPEG5kJRNhtz9bTMP0zh3JeWss388CEhkev9U
 we1DR6X3YnsTk7Sfpk7mR0bd1qOhGwBJK4q2tpJU66FgyD/aYtWzlBCsnBZ354IiSrrc
 +N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741625604; x=1742230404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79s8+mstomonepX5d5d+DntInPkYCBzA5RgBbJU2qMM=;
 b=PTqvCTJrJpIqPrKVb6U3l/T/H4Bcf+f6r0KFuASqR953bFD8DdAMvwKUI0r9kpyo6a
 Vqtq40eydOgUcvIoRhn6WFNxK+61fSkoghYxJ3rrMeLi3dIbK8HWTYasSim99N+RSe4H
 TNmbV2E1bIwkTAQaNfzW2550o2HPCdc62z6kChoBQ6BKBUvzuF3QODCXA1rPw0vSspMb
 L30Lltnis6gIQ6bEiG0vaElFNUBJ2ddpICig58t1cFwnqL06eou8DYVi+KLBU2aMh9QB
 5O6szQinj2xKtxSazg9JedOuKE8+Q/FhmZV70CCJb++VOTl9LVpY+NDKlK1dkaz6olsK
 IIsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiho46a6fn3vl+3JUUNO3NVsPYqbYYFyjHLqDLcTDHjXz29D0bjYS0h5dltlPyUEn1zDL2F2L0/q3n@nongnu.org
X-Gm-Message-State: AOJu0YyLVmxtuxaEFy+nKfYbfyYZD/Fly0J37LwOoUoT+zv+WLE3Ea7J
 uFu3Ae9n8dzqMKB2A8oJ70D0zcdaSsOJiKRRRZ9dIO9m0nWHYSr1Xnam3sBp2LWdtO3TZDxzVvB
 3
X-Gm-Gg: ASbGnctjdyKAqV+D93CrwWw54igf7pMbfBApGqPRB8FFvM1BNtr7OeAMBQMpiuzvnAd
 w7Reuy3yrg+1M/3qaaNwd7iZcYPvqtQhAPdGfDS89MdG6ZENfoOnFtZBd9P3p2svNu2/StiNhCv
 ETlAiHBdDmqcUeWu05WlWC2cjOH1ooH9MRGX8UmMSANDqscnnXJ8BBql5Zf03bsECMOy948nAKv
 bO3cxlu0bcv7bk99E4NtftLC+INAs23WOPFkZ3vyA/RsguciAz2bV86JIrH8OxOHCYArvcxf0kD
 IuOk3ThvRwFvxu22wvH9HkBrWJFj7CBErUNEgsGUgj+GZmeLom5KfNiVsH2wWF27cJIWqgDRx8s
 M3dWyApRG
X-Google-Smtp-Source: AGHT+IFJNUhJNfL9FybzRLZ7ieGbS5gea6wSS/VpsHLNRCOMmBxROeDSVG14q4XM3wni0qXv3CHv1g==
X-Received: by 2002:a05:6a00:4b14:b0:736:34ff:be7 with SMTP id
 d2e1a72fcca58-736eb87c863mr720964b3a.15.1741625604676; 
 Mon, 10 Mar 2025 09:53:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2e94e53sm2921051b3a.118.2025.03.10.09.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:53:24 -0700 (PDT)
Message-ID: <e20b6a44-b371-4154-8dc9-5f3cb4a3f570@linaro.org>
Date: Mon, 10 Mar 2025 09:53:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
 <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
 <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/10/25 09:43, Pierrick Bouvier wrote:
> On 3/10/25 09:37, Richard Henderson wrote:
>> On 3/10/25 09:14, Pierrick Bouvier wrote:
>>> On 3/10/25 09:08, Richard Henderson wrote:
>>>> On 3/9/25 21:58, Pierrick Bouvier wrote:
>>>>> For now, they are duplicate of the same macros in cpu-all.h that we
>>>>> eliminate in next commit.
>>>>>
>>>>> Keep code readable by not defining them with macros, but simply their
>>>>> implementation.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Why do you want these in bswap.h, rather than tswap.h?
>>>> They're target swaps, after all.
>>>>
>>>>
>>>> r~
>>>
>>> No preference on that, I simply added them to the same file than their explicit endianness
>>> variant. Would you prefer the endianness agnostic variant to be in tswap.h instead?
>>
>> I think I would.
> 
> Ok, I will move it.
> 
>>
>> In addition, I think we want
>>
>> #ifdef COMPILING_PER_TARGET
>> #define target_words_bigendian()  TARGET_BIG_ENDIAN
>> #else
>> bool target_words_bigendian(void);
>> #endif
>>
>> moving the conditional from around target_needs_bswap just below.
>>
>> With that, we eliminate the extra branch that you're otherwise
>> adding to target-specific code with this patch.
>>
> 
> I understand the change requested, but should we really aim in that direction? In the end, 
> if we pursue the compilation units deduplication, the branch will be present anyway.
> 
> I'm ok with your change, just asking if we really want to preserve target specific code 
> until the "end".

All of target/ is target specific.  De-duplication will not eliminate that.


r~

