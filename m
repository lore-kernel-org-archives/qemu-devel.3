Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94290EA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjjS-0008US-F4; Wed, 04 Feb 2026 15:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjjP-0008UJ-RK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:44:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjjM-0003Kt-TO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:44:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-480706554beso2171695e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237847; x=1770842647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0MCMHcRr6Z+WrblrY4QYv9hSxJjWyUfm8WXl3+VaCM=;
 b=HJYgWK2l8F9snDHLm/PoN49gl/l4KqYMY9FsYnknvs2sVu6+JTbJ4qnCqRis8oHbKw
 q2aDKCOnQuMDDC+mLwNkRWfaGyPJPxVOaZxJfwUe2wBgZd4msnAwTC6atiHb/Ig3mE3Y
 vr0tycE06K+DHFPP+Qs+HjcmLLjf80k+EoHPw56FzfjJAs+KGJKOBA6jLqaIqje9eMhB
 Z6EpugsRg8xwN0CMeBno6CNOIczDJCzlH+Z60NlC+cMS5q+6ADwWUqXkx9xWt8gjIlwI
 zKZbEIOgQ6Z2Apzge6KaV6XJ6h36ZvkZFq1gwSk6OFU4D9TIKxnxdg/T9IS0Q6NQcbHx
 31kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237847; x=1770842647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0MCMHcRr6Z+WrblrY4QYv9hSxJjWyUfm8WXl3+VaCM=;
 b=ZUJIcKl+nse+DzAG9ugqWoQIGC5N2hqjthZQNJhAz6AbxtVT1zYBuT4RLeHy0TAjf+
 1a3EYeztg5BdHL2jCahERV+nLRYzNUY1AyKJ/LMZdpBRpZAggukuZUDVajUJ+oDJ38/O
 /H90Ka0d5XwMZR20t6xZK270VvGvSNRP7ZlxVff8z6vD2TiqRdXB37biZoU4192QWWO/
 9Pd/qbrYZ1SnczTCSwv1s+iAXfvzrzkhGX9Vn2ih+Okax+GR7sB4xUY51Jmn6Ar3jZH4
 kAjNgBJbyttW5qYEjWB2YVJ5eXz1mierZ6hrHemHEPh6y8sJYoGJoXcNykiESZVbD+ys
 5hYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiBU2h0fHvlOGaXtozC1XGnDJEJC+YWIHhXgBfQcgEhMme2nRUsMXEJB4ZoLAmKFFW1VAQpbUJ0sSN@nongnu.org
X-Gm-Message-State: AOJu0YyxbjkssCtG4kNV507BooQA4uLqpUOskUdePDjR1hjMKTiFCN4q
 4ahLnbpVeibPE5wQY0rdo++Gfnc+sgVLXcpjtTp0Aq+UHpCLIDUEDMQZBR77e1SxqIY=
X-Gm-Gg: AZuq6aKEYNXqn64B9VhTmMi/gSmUODwKOd7CTgkZBKGVxKFj3TeIBf/WhHQZr7lnAzR
 Iu0tUqdiImpERHLfD7wsy1exrjr2XCLTrgGY6/X/XWfC29aEhDvAyky1aYAXpl0zD2AIXyU5sRf
 ajwLZ+AtEMgv0aPwjNpf3AsHL2AcxMPffwJjy1UQxZMtHZ5B3wppYp/CIRnuhFVgaoZUACMn7fw
 OUG/Ik9E7zv0vstd6KHI2VbvgaS+wsAvrebtZ+ooJ1lDjqMejy7pwn1agdFTDlOtkqDI+w2e0Kq
 /g+R59N5DkXTvPOlFUlLCMv2MB4o6bsFu+EeXl7R0C0yoerJ6bP3nZGE4ttFta0fU+E5ovb+cax
 5eqwzk1113xhWdeEwV4uiAI0up+tblWHdYI2RycpFTnrcBOiabKVwMRvi/8k8u1VGDIdUFA3+EG
 i6hVQpTTG0st4rPizEM8kztQyqp0YEEOFcObPtXw/tCFc9NFvVuyOfug==
X-Received: by 2002:a05:600c:6087:b0:483:a21:7744 with SMTP id
 5b1f17b1804b1-4830e977f1cmr55992605e9.26.1770237847261; 
 Wed, 04 Feb 2026 12:44:07 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm16825675e9.0.2026.02.04.12.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 12:44:06 -0800 (PST)
Message-ID: <58dd35c2-65af-48c5-8684-c41611437ac0@linaro.org>
Date: Wed, 4 Feb 2026 21:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] accel/tcg: Have cpu_ld*_mmu() methods consider
 the MO_SIGN flag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-3-philmd@linaro.org>
 <8f91d8f3-0d7a-4438-b261-ca8ba509be96@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f91d8f3-0d7a-4438-b261-ca8ba509be96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/2/26 02:49, Richard Henderson wrote:
> On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
>> Sign-extend the result when the MO_SIGN flag is requested
>> in TCG common CPU TLB handling.
>>
>> Remote the SPARC specific handling.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/cputlb.c         | 37 +++++++++++++++++++++++++++++++------
>>   target/sparc/ldst_helper.c |  9 ---------
>>   2 files changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 76546c66515..97782997881 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -2296,12 +2296,18 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr 
>> addr, MemOpIdx oi,
>>   {
>>       MMULookupLocals l;
>>       bool crosspage;
>> +    uint8_t ret;
>>       cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
>>       crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
>>       tcg_debug_assert(!crosspage);
>> -    return do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
>> +    ret = do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
>> +
>> +    if (l.memop & MO_SIGN) {
>> +        ret = (int8_t)ret;
>> +    }
>> +    return ret;
>>   }
> 
> Nope.  The return type is uint8_t, so this doesn't change anything at all.

Oh, right <:)


