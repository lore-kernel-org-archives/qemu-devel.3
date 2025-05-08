Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC4C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7t0-0005Nz-4y; Thu, 08 May 2025 16:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7sv-0005NW-95
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:30:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7st-0006dS-Ag
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:30:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30aa8a259e0so1418299a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746736222; x=1747341022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Owc7RU/pQjq3QnKiVQJoGg4WVKo13wdIgEsMCgVYBFQ=;
 b=F6Ig0QpwB7svGjVmMQCsr4e/VoM/lYD25tukIHLOD9FJCkj4LRqCo6LVSgMhsYqkIm
 LcEw8dQIhL0IL+j/zo6ZxCLD4Kcnl1QTY2lHB9J4JVyX1nTpB0/2CoQkdi8uiM0v1HkZ
 hUSpUh3kuXaQerjuPYtl0iJUJARU8wbCjEo09tUw8j/fohtYlLrdYXepQatC0c/RKcWE
 PT6U/5jNKTITF0ZkzbFCY7iKkBn2bVs9a4K1hF098G5qk/q7Scd0BVrbiVfvcU0jnvV/
 6qqZKY9q9qzbk69m7WIUu9kCH1fypIsRTCcCp4aKB+6uaqvNH8spnAKEnT/B+SmZljBy
 1LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746736222; x=1747341022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Owc7RU/pQjq3QnKiVQJoGg4WVKo13wdIgEsMCgVYBFQ=;
 b=uwpO44il7zx4U12pNjzhMaHavms//L4P/oHyoGtAczkBoHQn4Gcm0UURbGClLg2MGO
 Rifv5yvtF8SndnLjM6NkhU8UB1ptaTGde8BZKAcASgrzr1darPYXO+WfWsuF30CyVUMl
 +6/LovskuDeabZ3z1K4bDVoQmkPCZ5oH7uYppwplC8SpuY3WaDl6gsK+0Rb9F4jK46fm
 t3axkaE7wRUD9yMSXSjppyx/9jrsKSYDvEllapoP2BGFpOPnagvT6eILYfWO6N14XwSS
 i7j+vVF6jVFm0sc8URGEoD9D/yihzVVAbi7B9zHjLtaOvdoFX4dj3HpoaiukYV+MAzsc
 PUbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBRR5iWo89TaRx76bDKJuUXweS5LtADtrMv0FSIBzikRxHjeRfLlsVdJKJxBMv3JSibafde01ChFVT@nongnu.org
X-Gm-Message-State: AOJu0YxvCTHj2MruuPOxqCdqGUykJpyVltgwptA5hfk6NCqEcH1LuK+l
 Ffu+C/LQ7e8MY/SLY1zuGitnh/44ElVKtiM+aLhJ+OXZG5/ILWHhvKsoMdjYseI=
X-Gm-Gg: ASbGncuzHuv+oeNxSq7Zw56KGgiHpWUy3Qu33r7ugce42A6RWnmIc00VMwzuSZkwapL
 GBpxZBTItCFry5jhny2A+2C/tESXugyNeYjAHGfvvKRp61C8wkocO2Iz31RuMRRwDCOTsbL4ySA
 sGBH7jmSBhuzu1givg2bB/xO3sxo6+t01wBmkgyCixhrHLKHeyLfUILFe8UtzxmXy6IoCr/uCOb
 CbcHLbUUVHwybKuPtNf6v0Bm5CIfuFNyoKBk7czhCtzC3VoxDVZKz3/YGIX5rvka4NVsahD5Ld5
 i5YOJ4ksly1KOad8iALmdAwk/979onu2sXQ3gWcwd4ELIs80XGx6zg==
X-Google-Smtp-Source: AGHT+IFkzTRO20FTEEnkUlCbxN5eAdj2BQEyHkX3gXpUdzjxk2W7wEZ9CzuakAP4/uQiynAFn31WMg==
X-Received: by 2002:a17:90b:1d02:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-30c3caf9720mr1378934a91.6.1746736221729; 
 Thu, 08 May 2025 13:30:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39e61056sm417919a91.39.2025.05.08.13.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:30:21 -0700 (PDT)
Message-ID: <40d21813-d9b6-42f5-a439-634a8e3ccf98@linaro.org>
Date: Thu, 8 May 2025 13:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] qemu/target-info: implement missing helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-9-pierrick.bouvier@linaro.org>
 <34d4719e-e8e9-4f2d-ad57-bb4043cb540f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <34d4719e-e8e9-4f2d-ad57-bb4043cb540f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 5/7/25 11:40 PM, Philippe Mathieu-Daudé wrote:
> On 8/5/25 01:14, Pierrick Bouvier wrote:
>> Add runtime helpers for target and config queries.
>>
>> Note: This will be reimplemented later [1] using proper information in
>> TargetInfo. Meanwhile, just add a simple implementation.
>>
>> [1] https://patchew.org/QEMU/20250424222112.36194-1-philmd@linaro.org/20250424222112.36194-19-philmd@linaro.org/
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build                |   2 +-
>>    include/qemu/target-info.h |  14 +++++
>>    target-info.c              | 117 +++++++++++++++++++++++++++++++++++++
>>    3 files changed, 132 insertions(+), 1 deletion(-)
> 
> 
>> +bool target_mips(void)
> 
> I know this is the same lowercase name, but maybe we could consider
> directly using target_mips32() instead of keeping the technical debt
> of having TARGET_MIPS defined for both 32 and 64-bit targets.
> Thankfully we cleared that with recent targets (i.e. LoongArch or
> RISC-V -- AVR is a bit different, since 8-bit AVR and AVR32 are
> distinct architectures).
> 
> For x86 we often use 'x86' as any of (i386, x86_64, amd64), maybe
> we can introduce target_x86() too.
> 
>> +{
>> +#ifdef TARGET_MIPS
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_mips64(void)
>> +{
>> +#ifdef TARGET_MIPS64
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_loongarch64(void)
>> +{
>> +#ifdef TARGET_LOONGARCH64
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_riscv32(void)
>> +{
>> +#ifdef TARGET_RISCV32
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_riscv64(void)
>> +{
>> +#ifdef TARGET_RISCV64
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_ppc(void)
> 
> Ditto, target_ppc32()?
> 
>> +{
>> +#ifdef TARGET_PPC
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_ppc64(void)
>> +{
>> +#ifdef TARGET_ppc64
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>> +bool target_has_kvm(void)
>> +{
>> +#ifdef CONFIG_KVM
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
> 

I simply tried to reflect existing TARGET_* (so there is no 
TARGET_PPC32, which is incoherent with having TARGET_RISCV{,32,64}).

For the long term, I think we should aim for a 1-1 mapping with 
SysEmuTarget instead, which is *coherent*. As well, we'll probably want 
a way to identify target base architecture, like target_base_arm(), 
target_base_i386(), ..., which will include 32 and 64 bits variants.

Since patches for TargetInfo bringing target_arch() are not there yet, I 
didn't want to bring all the material for a new bike shed, so I simply 
followed existing TARGET_*. I hope we can have this whole conversation 
on another dedicated series, once upstream TargetInfo will contain a 
target_arch field.

