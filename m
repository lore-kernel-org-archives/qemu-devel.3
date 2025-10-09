Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA37CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6u3V-00051d-MR; Thu, 09 Oct 2025 13:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6u3T-00051R-QA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:03:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6u3A-0007wx-Sl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:03:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so12379055e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029407; x=1760634207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4njHFwtTgYWjoLiirQjSif/JvDx7xxqikRECsyZvXmA=;
 b=cZNkHCJqBCYEwIIjI0kqLSM2qu8sem7YwW3+7kQe3PtXdscyU2+5KOW5nksvux+Ung
 gnxqzrO8L/Jv9PYWIvUleRoAKdHzHHrub5Qar9llgd6pBk84hdb7wUafzVc0j5oNn3oT
 BRldEjC6RozbOhkpgRn2DkdhUemhPH8BiIETTWVwZxJIQrqMuJi5InEzqP2v7QJT48Sy
 HhuQnux9NmSO/DNyc19hUYMBAZP8SjKNkNEauv/QcNJRwcxwbAps1ciGYhhNDeC17L3c
 NBqOQ44zU1BAjpI1PjjjYYRn2AiouIROJngUTUAHtcPuA3gna4SLSpewxJ6x5i0Tls3K
 g3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029407; x=1760634207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4njHFwtTgYWjoLiirQjSif/JvDx7xxqikRECsyZvXmA=;
 b=bnNEFESJbEdKS4fuQnBd/mkTCeiFPvs+qjQoZ/tpZ831psBnprfEvm44FgwFZiPt77
 GnEsXXOQ5G2cWe52SI2lLvg1/woBPPJS77TIMFTUJWXI6NGRDy9/NHMzws4sm9pkxh7m
 Q2r65v+6y5LiQDRn153FpHymqwha42s6uNwWmpz8J9/7jluFO8Q90IAKjQj3g0bJfGig
 1yw2zaPdZ0aUXlI7eDA+/NcbHCQHD6pk45Lg0LYjgKMPGbthtk3y/o1Gv5yr5oHw0nRu
 4hAHgS5i8DvuporAZdjWjHsKePiyzSHTP2B6kPeewL3bjCik4bwS8d2ptZ6Mna9q7C0W
 aLmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWojg6dKQ7ROgTUCDWLoAAkin+kp583a4V6CPHeiEnRPE+0bGFv8n3H4FM+xIv2tR8MzfoxDaC/VcDI@nongnu.org
X-Gm-Message-State: AOJu0Yx8oAUKUvbXQ5fFN3DGIGjshsakZlhzUKuKBB+Mvj/el/OOiRNR
 eKBEr0gbCtq1oc1wTdVj+1wQhmxEDp6IPXklqz7+lqo8xD+a2JZWeQ9G1sxoQgBXKmg=
X-Gm-Gg: ASbGncsuwNol2z/PMmNJGDon2kdGU8ezO5fDBxL9bx1EKflA+SLMzy46GUV4R//InfE
 HcFhB6l8mwSe07lwyJJdQM6HQ3eR3UmsW+pG4sCQpugROmdMV3MG2+JfSm55Hy9C7fjNeLovAcI
 aNe7huSvYWGCuB5+vdLuzQEQILH2CWZtOnweCjlfCMqnnKJMsxZQYGzHA9xKYwzbc5xGf/v5nKu
 c+X6bVg8YnTD5qjldXCSbFKesfx9l+K9VaZ5ewgV6uO1utlMZqyuCDXAAld8LXqXMn+N8/35tZm
 bEObPrHq6vx8HOsLs7/EvzLb7+mwabXJ2QAEKN8cvXmLGxR3eS1OsrFCXjdGJ6ecM74nR6bbPPQ
 yVqCh+Gc82Vi/lr1+UgsR+zCMrgNkpBT3UoCDdX2LjXhjoIbdA1N1nhwK0rdihPbJ+5CVkWEkpp
 /ZzQad8xcD4talyWdaKA==
X-Google-Smtp-Source: AGHT+IEnFOZY+450UnqRg299FQ3+YOOL3jb3ywXeYWcnmmuWpF+MhphsrrmLorHZhwu8GAOQrkhGXA==
X-Received: by 2002:a05:600c:4750:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-46fa9af3095mr62232305e9.18.1760029407141; 
 Thu, 09 Oct 2025 10:03:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482ba41sm7537825e9.4.2025.10.09.10.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:03:26 -0700 (PDT)
Message-ID: <ca183d5c-5788-4ec9-8beb-22e1311268bc@linaro.org>
Date: Thu, 9 Oct 2025 19:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tcg/mips: Check O32/N32/64 ABI definitions actually
 exist
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-5-philmd@linaro.org>
 <861610db-6bc7-4e5d-b54a-a86c5818e9ca@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <861610db-6bc7-4e5d-b54a-a86c5818e9ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 21/8/25 23:09, Richard Henderson wrote:
> On 8/21/25 00:21, Philippe Mathieu-Daudé wrote:
>> Similarly noted in libunwind: https://reviews.llvm.org/D38110#895887,
>> when _ABIO32 / _ABIN32 / _ABI64 are not defined (like on OpenBSD) we
>> get:
>>
>>    [666/1234] Compiling C object libsystem.a.p/tcg_tcg-common.c.o
>>    In file included from ../tcg/tcg-common.c:26:
>>    In file included from include/tcg/tcg.h:34:
>>    tcg/mips/tcg-target-reg-bits.h:10:18: warning: '_ABIO32' is not 
>> defined, evaluates to 0 [-Wundef]
>>    #if _MIPS_SIM == _ABIO32
>>                     ^
>>    tcg/mips/tcg-target-reg-bits.h:12:20: warning: '_ABIN32' is not 
>> defined, evaluates to 0 [-Wundef]
>>    #elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
>>                       ^
>>    2 warnings generated.
> 
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tcg/mips/tcg-target-reg-bits.h           | 5 +++--
>>   tcg/mips/tcg-target.c.inc                | 5 +++--
>>   common-user/host/mips/safe-syscall.inc.S | 4 ++--
>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg- 
>> bits.h
>> index 56fe0a725e9..a957d2312f3 100644
>> --- a/tcg/mips/tcg-target-reg-bits.h
>> +++ b/tcg/mips/tcg-target-reg-bits.h
>> @@ -7,9 +7,10 @@
>>   #ifndef TCG_TARGET_REG_BITS_H
>>   #define TCG_TARGET_REG_BITS_H
>> -#if _MIPS_SIM == _ABIO32
>> +#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
>>   # define TCG_TARGET_REG_BITS 32
>> -#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
>> +#elif (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
>> +       || (defined(_ABI64) && _MIPS_SIM == _ABI64)
>>   # define TCG_TARGET_REG_BITS 64
>>   #else
>>   # error "Unknown ABI"
> 
> 
> Alternately, remove all of this.  If we're removing 32-bit hosts, _ABI64 
> is the only valid answer (N32 has 64-bit registers but 32-bit pointers).

OK, but meanwhile can you consider this patch out of 32-bit host
removal? (I should have posted it separately for OpenBSD).

