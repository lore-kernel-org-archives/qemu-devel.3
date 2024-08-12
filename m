Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E038C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 01:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJp7-0007fQ-AU; Sun, 11 Aug 2024 21:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJp5-0007eQ-2d
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:26:11 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJp0-0000mw-9u
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:26:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db13410adfso2682388b6e.2
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723425965; x=1724030765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6xT2THnXZqj93xFd52KDjea4XxaO7e57BkQcBd06AY=;
 b=t4hK/Zi5iIR+uLBSTvv4t52ZbvcZEzr+yLiSicLj8L/3Rw4cnKFoL8G3KtzGecfIon
 /5/yOYGKUtMefgEaQ6sfyOUHNkd23jd3fPmW8btH5j1uTvXq9o2WvFnPGt2oRQOM8ous
 CELOH8GyPFoNY5S+H/zxsKvuujpBFnB5VysSDxP8JzkHWMVMjOWJDF0MVP5UKYnF5ddK
 rLbUB+N4h2375nZ/uDYV18HBQ6jmK1EkcrGe7W9ha0MMGhetImRVZHVG4JKkZLjAvqDV
 Y/pH8PK1Zwiq4FAnzLTQgdTQJBWVZ7xd45sTQg+uzaTCW4IGVobbI0UKKYzZW5j+w12d
 E1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723425965; x=1724030765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6xT2THnXZqj93xFd52KDjea4XxaO7e57BkQcBd06AY=;
 b=byP9aOih2ub/402FakbnzevAFryvsBjp6PFKkTHmU6pfnr2ss/c+c8Q6SIOPVnTSuG
 ntNVGVVyy1icYhgBTRnfmlqo0e8B25qwMDF8THCYHdptCLR1F9h5QigImMhtdo0q4hez
 THl7pbfYHxZklsdDh+QHS49YgjAXsLLytplS57lgYtfHiGavO1orvNc7FJYNrY8mPaRh
 siEtgUAGO6bJe7jOUwQsq90HoDp6L9di2aDZNdbvlQHVm/PYK+kb5CCwwyOAEBK/+fRB
 Hf9Uo6MLG7rOUcX6NhoxMe+vp14LwYE0oi6SSJ9XAmLOKTYHe93VjgJuSJmu8YEdCzqU
 J+ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuLqCsEGfrZXLsQ8YsU4B0378OkGXR0GdjPAAsN2bYNG7ZX3jiKvE3jGVYtmsGC9BjU4xXivMgWeNXl/KmWum6KhjLnvg=
X-Gm-Message-State: AOJu0Yzn4Nmp9xseYFjkM95SjRtb7U+C4/ClsilG+YQw3WI6UxhHWdZH
 1sAosq3bdrvTd5gz9K7Ri9C2dZtTCjEh6+/F/mFr3Ji7ocUHVxF5rdjJz/9/DZc=
X-Google-Smtp-Source: AGHT+IHWU7C9wV+RRYuQwBMdDwpEQM0LmvViyQBNQ72oskn/Dn8blFtDckXRngV8n1pNfs3I78tRXQ==
X-Received: by 2002:a05:6808:210b:b0:3d6:32d2:2c10 with SMTP id
 5614622812f47-3dc416dca7emr12352830b6e.31.1723425964546; 
 Sun, 11 Aug 2024 18:26:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c3dbea1f8fsm3164675a12.78.2024.08.11.18.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 18:26:03 -0700 (PDT)
Message-ID: <c098afe9-d09d-400d-8f2b-9278744a4ad4@linaro.org>
Date: Mon, 12 Aug 2024 11:25:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] accel/tcg: clear all TBs from a page when it is
 written to
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240809074725.320801-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240809074725.320801-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 8/9/24 17:47, Nicholas Piggin wrote:
> This is not a clean patch, but does fix a problem I hit with TB
> invalidation due to the target software writing to memory with TBs.
> 
> Lockup messages are triggering in Linux due to page clearing taking a
> long time when a code page has been freed, because it takes a lot of
> notdirty notifiers, which massively slows things down. Linux might
> possibly have a bug here too because it seems to hang indefinitely in
> some cases, but even if it didn't, the latency of clearing these pages
> is very high.
> 
> This showed when running KVM on the emulated machine, starting and
> stopping guests. That causes lots of instruction pages to be freed.
> Usually if you're just running Linux, executable pages remain in
> pagecache so you get fewer of these bombs in the kernel memory
> allocator. But page reclaim, JITs, deleting executable files, etc.,
> could trigger it too.
> 
> Invalidating all TBs from the page on any hit seems to avoid the problem
> and generally speeds things up.
> 
> How important is the precise invalidation? These days I assume the
> tricky kind of SMC that frequently writes code close to where it's
> executing is pretty rare and might not be something we really care about
> for performance. Could we remove sub-page TB invalidation entirely?

Happens on x86 and s390 regularly enough, so we can't remove it.

> @@ -1107,6 +1107,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>       TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
>   #endif /* TARGET_HAS_PRECISE_SMC */
>   
> +    start &= TARGET_PAGE_MASK;
> +    last |= ~TARGET_PAGE_MASK;
> +
>       /* Range may not cross a page. */
>       tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);

This would definitely break SMC.

However, there's a better solution.  We're already iterating over all of the TBs on the 
current page only.  Move *everything* except the tb_phys_invalidate__locked call into the 
SMC ifdef, and unconditionally invalidate every TB selected in the loop.

We experimented with something like this for aarch64, which used to spend a lot of the 
kernel startup time invalidating code pages from the (somewhat bloated) EDK2 bios.  But it 
turned out the bigger problem was address space randomization, and with CF_PCREL the 
problem appeared to go away.

I don't think we've done any kvm-under-tcg performance testing, but lockup messages would 
certainly be something to look for...


r~

