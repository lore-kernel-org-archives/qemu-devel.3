Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70E2C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfMg-0000D5-3g; Fri, 21 Mar 2025 12:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfMd-0000BI-VY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:36:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfMa-00052x-8j
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:36:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223a7065ff8so13606275ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742575010; x=1743179810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nyAxrcxJpaXDZ7GiFFU2INjbqCkqjtifUru6VAPSebo=;
 b=EaZns2yOL7io74Pk3tfdjF1kg7CL4b6Etjru5Rq0WADWdsQqfkNHbmFO+7MMejKUXb
 BUYp7hiH2nNaYaeV9FTlNoflTYg4kAEvaOqmJJH5B6DRjmDGZszHVBeT8p5ZRdrTqbfC
 TEWU4yaYtT3f0NM2S0RMp23lcU0EAF1uHwPAS/y+B/50mutwWk4XKhVdITAVlciBgmqJ
 blN2chKKHlx0oQVl9va8quo4S0XMfHWMVw/Lb0ubmC4I3U8dfziqAMVZSWNWQlg37AJk
 XmlDRh/T4nLUCJ01lT9UgCkJrSAsu6Kt2/gL+1vaWYVx4EF1iwgwE05d/VUtulsH31CS
 myzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742575010; x=1743179810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nyAxrcxJpaXDZ7GiFFU2INjbqCkqjtifUru6VAPSebo=;
 b=qa2v7/QTZc9RK5QtVyD20d9naOzwlIe2/N2y+mWUP0WFhaQEkMngXTHuABGwQ4LPwy
 OWa4+I4Qz5bhvF1WGNNJqC/Aop1exUTkyko2QLaxalqE0/ikRbaMHkt/ly048e8UKlM6
 TNB1CqgJNwExJpGqq6XUDgzATdNsYiRpaLe9kkBNHCiacIqbIDmm6Dy5rLhJdAxrd3VZ
 xQgTnhrpZ/49Cg8iP4Qx2WvyghgbbPYhXN2WBsvZY5xhNFTjLMK+akieQBVQ85OgAWww
 nxKp4UWrCSyt3tMJlhbwVGHcaEoR1tBlNW5cYcy91jHXLkM7I6Zhe9h1bpgRGrG/v1v0
 j1uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXckDEC48xI/bN9LpFiHi+JZMNBv1mjHuxKBPldoheL9AhFowesnKYhs+CE5YRP6lZpCEjYm9xP2Da@nongnu.org
X-Gm-Message-State: AOJu0Yx4JhGj0WLsEEFO7qTpTItIu7PLcZpRSq8WRwBBZrmgc+8FpsTL
 P+mX85PNN4Aw6l8rWtNHk1i6Zbu4Xu+hWsQJSlMlU0apuLaBvFBhPBissMPl+82+DrhICLyp+wk
 a
X-Gm-Gg: ASbGncuLTLvzHhdYzCSwVeV10uQ38zZgiM7ZMTGCEdHKYcvEhEQ9l0JedHQUoi2uRCr
 13XjXhwepOYHXkrVwY9N39m0FJjWJ4orwuKU1C56n6pSuKk4rHM4Qzn/s7BXzX9LBKij87UDaye
 MQfJ+qk/2KGJvLQ9PI4POn5978jsrrUdIzBUEDQiEv2Gzg8DY5gO8utoZqzFsxoh8qPj+UbJi+2
 wLvgwyTwTTPPM5CmL5TV419E5bxdeJ3sSC4fe0OtQUn6nPSaMsmkemDcko88H1S14pwwGSBe5bQ
 hgWaKeHK9QILLAK0aGwisooVK7uC51In+m5YOxKnATHIjtX+dGGjs8M8hC8ttSMB95JTzRN4yZh
 KqOCgcTZ2HrHXw99gBkY=
X-Google-Smtp-Source: AGHT+IGRZBvkhTTMFTisosTyZ2ZOdK/frO3hQGPp0saPscrfsv066xw8DoRU1w1LWAfx91qFBAAnlg==
X-Received: by 2002:a17:902:d58b:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22780c52283mr65790865ad.11.1742575010316; 
 Fri, 21 Mar 2025 09:36:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811d9f0dsm19122885ad.165.2025.03.21.09.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:36:49 -0700 (PDT)
Message-ID: <6215e901-af91-4e3a-b8ea-dba9b36cd87c@linaro.org>
Date: Fri, 21 Mar 2025 09:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/30] exec/cpu-all: remove system/memory include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> We include this header where needed. When includes set already have
> ifdef CONFIG_USER_ONLY, we add it here, else, we don't condition the
> include.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/s390x/ipl.h                       | 1 +
>   include/exec/cpu-all.h               | 3 ---
>   target/arm/internals.h               | 1 +
>   target/hppa/cpu.h                    | 1 +
>   target/i386/hvf/vmx.h                | 1 +
>   target/ppc/mmu-hash32.h              | 2 ++
>   hw/ppc/spapr_ovec.c                  | 1 +
>   target/alpha/helper.c                | 1 +
>   target/arm/hvf/hvf.c                 | 1 +
>   target/avr/helper.c                  | 1 +
>   target/i386/arch_memory_mapping.c    | 1 +
>   target/i386/helper.c                 | 1 +
>   target/i386/tcg/system/misc_helper.c | 1 +
>   target/i386/tcg/system/tcg-cpu.c     | 1 +
>   target/m68k/helper.c                 | 1 +
>   target/ppc/excp_helper.c             | 1 +
>   target/ppc/mmu-book3s-v3.c           | 1 +
>   target/ppc/mmu-hash64.c              | 1 +
>   target/ppc/mmu-radix64.c             | 1 +
>   target/riscv/cpu_helper.c            | 1 +
>   target/sparc/ldst_helper.c           | 1 +
>   target/sparc/mmu_helper.c            | 1 +
>   target/xtensa/mmu_helper.c           | 1 +
>   target/xtensa/op_helper.c            | 1 +
>   24 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

