Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C7C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tab1N-0005hE-RF; Wed, 22 Jan 2025 08:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tab1I-0005aV-1O
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:43:48 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tab1G-0007GZ-3L
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:43:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21636268e43so152526165ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737553423; x=1738158223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBMiGs1OmUTeuWvpr2pmpMPGbip7Izd0wm32rJ0XrpI=;
 b=MTutQHBNPZVCwT1+Nbsr8lfM+F2sxiOYdu6HcAG3N2gssAhdM0lhhMII+pUnQ0H++E
 X/8p2i3Sh7Md+8Ut/tiF5URqGD5ikmkX6ZZuAmzd4N4e2o8veV/fxvl4W3AsfbbWV9LN
 bkrBTv449uPlYG5LrSJDdtez2Go+vvs+aQBN4KdfylAMTScYaRT+d2MfgVo8jKDBGX57
 d/GkxVY53FCQW4+Q5Ob2yi7zXU9jrzDopvqad92NNyTRdIdNX6Yqxvxg5BqH7y+QkHFd
 paEdUhMwHnYTkToQrpCx3nrCOoNbMhnaBjvZ0FsoY6mRAKDgv3s151Iygxl7FyHvdOzI
 1/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737553423; x=1738158223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FBMiGs1OmUTeuWvpr2pmpMPGbip7Izd0wm32rJ0XrpI=;
 b=bZQpHKAI4SiwH07tU+wPHjD+KIFBAG/NZVbInrS8Y0n/20gQDg7nq99X/VcDAggznz
 RMUo3rb9xbLpI50/MgNf2rWQQus3IKwhNLI9CT60hY/twe2MWlo8a+eDWFUctJwYS8+k
 fRA0jTL2C3VQcLnw7QegofBeFMZ5wqDmC6xlWca0vGOc9EBV8U83ZwdalI1+PrWzTlWc
 Pdy9VmJiTlPsaVEoYSUwpBteJ97ady8wA5ywwcOVSs/bjYcrECBtygjdwY9dtoJ7ue7I
 KjQdOehIVXQs7XGXOyAh+x52/JspLM0WwIS7du/a12KTPJE4PY4olNuvUbX/iG4yRqFA
 d6ig==
X-Gm-Message-State: AOJu0Yz+Wvqm6NraJcwU0DxM0RdRpgpQ/YAUyKhtIwe7cL5Cbj0fhfkj
 9prwuM83U8KfGClOFPVMMzy0j/Wenq+i3EUQEaIaLjMkhTvqRCjprdvsL0AYlTY=
X-Gm-Gg: ASbGncsLAq4F1G5BQhfcnYSP0mCzlUp6hgsX3eOt0QhY/TR0T65/x8cWT5PCWcENM71
 PsNsnPR/0Iv/gtTKoxoGu8f+iKCgDAyRISsevONQyzV14gbZk2FbLqUN0WdU6mwW3HvCCZVjtAF
 POh7misJ3wDnVb6eJEjfeJkxxZeTjaUKthemVO1HDZkYFbOZIHhQfGtpimwtvl8XUyJCm341Ofp
 XCd1k/0b7tPAr3XsdT7qAnDD9aar60juyRVa3R7Nq5W6Gmr2O69UnqT4VYE0QCIFg==
X-Google-Smtp-Source: AGHT+IEpDc4CAXB3ix0tcGrtsD7HWPheAAP7M2Q6Qgg/M31ULhl/tlz+UV/TG9ReP2oCo9P0OSxcSA==
X-Received: by 2002:a17:902:ec87:b0:215:bf1b:a894 with SMTP id
 d9443c01a7336-21c3555cf79mr323702255ad.24.1737553423394; 
 Wed, 22 Jan 2025 05:43:43 -0800 (PST)
Received: from [10.253.78.142] ([129.227.63.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceb9b3asm95256335ad.75.2025.01.22.05.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 05:43:42 -0800 (PST)
Message-ID: <47c1c809-c7d8-417e-9ebd-ce6c93e802f1@gmail.com>
Date: Wed, 22 Jan 2025 21:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] improve precision of throttle_pct
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, huaminxu1@jd.com,
 wangfuqiang49 <wangfuqiang49@jd.com>
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
 <1735610174-37467-3-git-send-email-fuqiang.wng@gmail.com>
 <CAK9dgmYSkpZ0TL2CJiO6FXO2ufSQK0ZUe2Y_gj571p4+7OORcg@mail.gmail.com>
From: fuqiang wang <fuqiang.wng@gmail.com>
In-Reply-To: <CAK9dgmYSkpZ0TL2CJiO6FXO2ufSQK0ZUe2Y_gj571p4+7OORcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fuqiang.wng@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2025/1/21 20:25, Yong Huang wrote:
> On Tue, Dec 31, 2024 at 9:56 AM fuqiang wang <fuqiang.wng@gmail.com> wrote:
> 
>> Using the current algorithm, there are issues with precision not being
>> handled correctly during division operations. (Even though double type
>> casting is used in the function, it does not seem to have any effect.)
>> Refer to the results of the test program from [1]. When there is a large
>> discrepancy between current and quota, there is a noticeable error.
> 
> 
>> The main derivation of the new algorithm is(For current > quota):
>>                     ring_full_time_us * current
>>      quota       = --------------------------------
>>                     ring_full_time_us + throttle_us
> 
> 
>>                     current - quota
>>      throttle_us = ----------------- * ring_full_time_us
>>                          quota
> 
> 
>> In the actual code, first calculate the value of
>> {(current-quota})\quota} and store the intermediate result as a double.
>> Then, multiply it by ring_full_time_us.
>>
>> Test scenario:
>> - generate dirty pages program: tests/migration/stress, dirtyrate is
>>    about 1500MB/s with WP enable.
>> - dirtyring size : 65536
>> - dirtylimit: 333
>>
>> To facilitate testing, merge both the new and old algorithms into the
>> same code, calculate the difference in throttle_us between them, and
>> track the value of the next non-linear adjustment after a linear
>> adjustment.
>>
>> The test results are as follows:
>>
>> - throttle_us difference:
>>    [19003, 24755, 25231, 14630, 25705]
>>
>>    average: 21864
>>
>> - next non-linear adjustment":
>>    [16764, 16368, 16357, 16591, 16347]
>>
>>    average: 16485
>>
>> Based on the test results, after merging this patch, the linear
>> adjustment value will increase, allowing the quota to be reached one
>> loop earlier.
>>
>> [1]:
>> https://github.com/cai-fuqiang/kernel_test/tree/master/dirty_throttle_pct_test
> 
> 
> Thanks for this work. This modified algorithm seems ok to me. Could you
> share
> 
> the guestperf test result or other performance tests? Such that we could
> observe
> 
> the improvement directly.
> 
Good suggestion. I will to do it in the next patch, but it seems I will 
need to wait until after the holiday. Wishing you a Happy New Year!
> 
>>
>>
>> Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
> 
> ---
>>   system/dirtylimit.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
>> index c7f663e5b9..25439e8e99 100644
>> --- a/system/dirtylimit.c
>> +++ b/system/dirtylimit.c
>> @@ -281,7 +281,7 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>>   {
>>       int64_t ring_full_time_us = 0;
>>       uint64_t sleep_pct = 0;
>> -    uint64_t throttle_pct = 0;
>> +    double throttle_pct = 0;
>>       uint64_t throttle_us = 0;
>>       int64_t throtlle_us_old = cpu->throttle_us_per_full;
>>
>> @@ -294,14 +294,14 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>>
>>       if (dirtylimit_need_linear_adjustment(quota, current)) {
>>           if (quota < current) {
>> -            throttle_pct  = (current - quota) * 100 / current;
>> +            throttle_pct  = (current - quota) / (double)quota;
>>               throttle_us =
>> -                ring_full_time_us * throttle_pct / (double)(100 -
>> throttle_pct);
>> +                ring_full_time_us * throttle_pct;
>>               cpu->throttle_us_per_full += throttle_us;
>>           } else {
>> -            throttle_pct = (quota - current) * 100 / quota;
>> +            throttle_pct = (quota - current) / (double)current;
>>               throttle_us =
>> -                ring_full_time_us * throttle_pct / (double)(100 -
>> throttle_pct);
>> +                ring_full_time_us * throttle_pct;
>>               cpu->throttle_us_per_full -= throttle_us;
>>           }
>>
>> --
>> 2.47.0
>>
>>
> Yong
> 


