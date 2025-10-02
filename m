Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F352FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ogl-0002cn-TH; Thu, 02 Oct 2025 15:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ogi-0002aA-CZ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:10:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OgX-0001GK-Sp
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:09:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so1334102b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759432184; x=1760036984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdz26z0PQ9gIHm/ArAOjbCtf1dgpjBY7z5K+yG+GOb0=;
 b=vY8k3420p2S23b4tXkY92qJLESy+hs0PNB4fVWfdopH4LVnwZx3cFG6I7jgh2RTOtA
 Y9AP1Hl2XSZuyWAS3U+N3tzRaM++ByIcnidRanofti00A55vEklIpmezv6FAzCdH5r0m
 Tc0Wg4Y8qWbZXQtSyUZpk1Z2qP2nlF6O45++HigmSgkM51FI2q5SLwB4jjt3nDD5pJe7
 FmhVBt0WN7Wu1HJNlCl0tjrY5EgrkfTpbqQhClhYrrarPsQ0fE4W7MA1JKR5EzynGwfl
 sCvPOEscA9fgrz2yL+GyLRUGXLqOWLTABkAPSmM5mUypezva8O4cLP/Bx1xVOJqyR29u
 AjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759432184; x=1760036984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdz26z0PQ9gIHm/ArAOjbCtf1dgpjBY7z5K+yG+GOb0=;
 b=GApuWMqHNEyOtNjEUhaU04Fr0lHh3OykijLlC8iYmwp1sEsNmX/BYEhdVUwWZDpaqJ
 03plmu+0PVfnnDpzruiuyxMc9ze1f03KB5GMd/TBbSZNIE2FSQF2QhlKjvs+JMBXptGA
 Ls8W2hOBK72TDR4dZaK5ff/JYHBpXklMMeyP9j5AWPkAZCOpVHjOQ7c0/rMTLTrHF8Tv
 AAdc3XV8rxm1uKrRevuz9FZlLqdQkLYYxUEPz+zq/tn5DN9PWpRRAdV3UCYdm7+hse3C
 oJq20kmzHLra+gBoeK+jUMdvOMMZD7wRe54agM4MpjPLJblx2fiuGr+RdhWTgFoj8gBw
 KQ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhMHQQ82C8B1hwU5GJNwcmM6XYw9h/9qmC52dhiY7UfxNPXk6rLg6+Sf6HzQZ/AaOEVeqYgvysiO2E@nongnu.org
X-Gm-Message-State: AOJu0YwaUy0BBIUE/bZUrnmHhH4SmAS45AUhoTelgZE+CAncP/EtSvug
 wuDyb19ym7laXd1CHp4bjjfQZg/G4oBI248qmUPAQygWFTcpn6mvgLzfFLZv1NTVml5VEME1kYx
 Klt7w
X-Gm-Gg: ASbGncuKZTcumSt94zWgvMq4gzn3z7akNxCd5SqBsr74TFL2k3E2LOXcS9HSKPs3vej
 1vQdwpqSh42IR1htaVpfbGzpIotf8ljliuB/wafk8N9JlF9RdO0m+F3eJTtLFvaTJuXo1MOi+g8
 gGEp+qwxqB0KZtbK+lOTRItBBv+jTZ7wAtXGKTacuSDR4OuEMW15wIzepTcI8qRNZ4I9wuG6CLR
 nzGNZh2jqtxND7dDbLVvUHSSD8dv1A1nCkbepZdawGFpCQ/98XkTiF6NmPQ4guAu7t271oCIep7
 7nC2NOTUUQks6MyvHnXNrrIyUryRYmVQ7x6XbitPoPX7Y0fwEbqBVT5ohKIiBiw2iCP+zW/sXDP
 2OHpNK2CXC/gmRXJryl64C5rQdrj0ZowzIeUHLkFvQuBhv32b34poAiEJV4EOlaI=
X-Google-Smtp-Source: AGHT+IH9GhTluu9Z/gvWGejvEZ/cs/em+6nz+6hUuq3nq9EaHod+L9H+vtI9Vif0eZIdnL6uPMvxTA==
X-Received: by 2002:a05:6a00:3e08:b0:781:157b:3d2e with SMTP id
 d2e1a72fcca58-78c98dc4e23mr697883b3a.21.1759432183957; 
 Thu, 02 Oct 2025 12:09:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053584sm2794668b3a.50.2025.10.02.12.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:09:43 -0700 (PDT)
Message-ID: <2edd23b4-42da-4018-9885-2e54f22437cf@linaro.org>
Date: Thu, 2 Oct 2025 12:09:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
 <84c9b930-5f93-4175-9605-a67054187079@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <84c9b930-5f93-4175-9605-a67054187079@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:39 AM, Philippe Mathieu-Daudé wrote:
> On 1/10/25 09:32, Anton Johansson wrote:
>> According to version 20250508 of the privileged specification,
>> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
>> when XLEN == 32 and accesses the top 32 bits of the 64-bit
>> mhpmeventn registers. Combine the two arrays of target_ulong
>> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
>>
>> This also allows for some minor code simplification where branches
>> handling either mhpmeventh[] or mhpmevent[] could be combined.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>    target/riscv/cpu.h     | 10 +++----
>>    target/riscv/csr.c     | 67 +++++++++++++++---------------------------
>>    target/riscv/machine.c |  3 +-
>>    target/riscv/pmu.c     | 53 ++++++++-------------------------
>>    4 files changed, 42 insertions(+), 91 deletions(-)
> 
> 
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 328fb674e1..d9939489e1 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -452,8 +452,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>            VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>>            VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
>>                                 vmstate_pmu_ctr_state, PMUCTRState),
>> -        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
>> -        VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
>> +        VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
> 
> Each time you change a VMStateDescription structure you need to bump its
> version.

Maybe we could agree with Alistair if we prefer a single bump for whole 
series, or bump on any change within this series.

