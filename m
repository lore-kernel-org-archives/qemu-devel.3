Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CC0C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 22:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seij4-0008Ur-AG; Thu, 15 Aug 2024 18:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seiis-0008U9-I7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:13:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seiiq-0000LN-EW
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:13:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso1232110b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723760010; x=1724364810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ddau1tHnfYkaqlIMRRVFzhMFkHOKUhEkClI0bL83jg=;
 b=EtbCGWzbnU0GNwAXOtPEHz1iTcouRQHqQmMTCo4IXqitGVvE0r3Zr1c40bNY/RpXo6
 yLjk0AJgJh3Rz9mHSK7XtW+BuOr8/jA9vRIqhDs9c1dLawrNCsV4OBN2cnWmDaO4OH6V
 RH136ywFoRVZeZh6HXF0K9dJLOTJZ9bEjlPQMlp50rPtoXImxR1HIrtqw3yuVc8ds1gi
 BjCYlZGPOrOKUgpZmAeU6HKmdi5eyys4KlqwGQlgadG25ey6ahyLGsT8DDjWJsSC34I6
 ba5q3daMh2tNvZW5+hmboTzJbhxe9aKjzNS7c1Obj23cI4WNO6YYf37c43fFtP7LPn2Y
 ysiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723760010; x=1724364810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ddau1tHnfYkaqlIMRRVFzhMFkHOKUhEkClI0bL83jg=;
 b=RA1SIfpLnzsqbHA7m/FvdfNvZXpli7hW/fXio0gZH5xMxD6quyCQNQseScCG/NxAZ0
 dzF6LgR8gyxA3t5QS4ngZCO901UlDzABJjhf7S4Ano5PaOC/QJV+kzAoWBN1rLzen0mU
 tS4rIDsog7jNia7zuc3HsrpW+2WXkWSAR2H/BUPwBgvZT1Ik8p4tVNBxDHValFCGjS0E
 yp9GxPoQLcXUKJEKCFEURfHdqe37ZGjhNMscVHhcT9ODyxid4hJTJIg6oTj5Ys0bEJ8w
 xE5S6hXZYUidXhKJNurb7pry3D1iWqro2iOh/PdGl/HM8rGrkmDzaulGWdruvgPnnCR6
 p99A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe8Z9hMYZdqu6JMo2OcMAZ3mtY2cIz2HQnoQRTr1FBbJXQNvb3poJjD5E9IuhXLnGwjFBOuaH9ME6NcDDybQl/SBTpeg8=
X-Gm-Message-State: AOJu0Yy4q8VjsDElwROUtK0aU5bdFkhNufMfVbDZ+0bmGY+09hYKvhLO
 Tbp18ocHPtIRPCc5b4ujuEQG/6uTBkAqWesGriabzDjJh9Kss1imt8pHQxJz7LA=
X-Google-Smtp-Source: AGHT+IG7GanMXjuWEny2lBuKR/cuOL83stFSzph0uYkpz0Ypy0ytR0cgqoEEXBLCmBXhRy6LCG5ytw==
X-Received: by 2002:a05:6a00:2d9f:b0:710:4d08:e094 with SMTP id
 d2e1a72fcca58-713c4dfbe65mr1520453b3a.2.1723760009763; 
 Thu, 15 Aug 2024 15:13:29 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef5229sm1464605b3a.107.2024.08.15.15.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 15:13:29 -0700 (PDT)
Message-ID: <a0927867-1a5b-4e9a-8236-33f528c2c19c@linaro.org>
Date: Fri, 16 Aug 2024 08:13:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] accel/tcg: Remove dead code from
 rr_cpu_thread_fn()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240815143634.3413679-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240815143634.3413679-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/24 00:36, Peter Maydell wrote:
> The main loop in rr_cpu_thread_fn() can never terminate, so the
> code at the end of the function to clean up the RCU subsystem is
> dead code. Replace it with g_assert_not_reached().
> 
> (This is different from the other cpu_thread_fn for e.g. MTTCG or
> for the KVM accelerator -- those can exit, if the vCPU they
> are responsible for is unplugged. But the RR cpu thread fn
> handles all CPUs in the system in a round-robin way, so even
> if one is unplugged it keeps looping.)
> 
> Resolves: Coverity CID 1547782
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 48c38714bd6..38ab16244e3 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,9 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
>           rr_deal_with_unplugged_cpus();
>       }
>   
> -    rcu_remove_force_rcu_notifier(&force_rcu);
> -    rcu_unregister_thread();
> -    return NULL;
> +    g_assert_not_reached();
>   }
>   
>   void rr_start_vcpu_thread(CPUState *cpu)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

