Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060E3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU5k-000125-8M; Fri, 09 Aug 2024 14:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scU5j-0000xf-5G
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:11:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scU5h-0007ig-7d
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:11:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428243f928cso15882025e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723227111; x=1723831911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJXTJBx2vwwBFc0SAiYoyltbFsLGX3/32nAN4Xaa99I=;
 b=JmMear1BZcKJfCOXO08H0B5UiEu0tS8erWvDRizK+zsXfhjo2ozU/LDLbH06FdH+UN
 fS2YBT6cL4g83GkYjQuG5kZG1/R2TVnDdlqad4RQEAXztXtg7DmiMo5fdQyazKCWHYia
 qtPCVjYa1+44R5jl0RidZnxNF0xqNnAVtaputiHiAEHgJ2Aw9klYDc1glLAaPYSZZJ5y
 jc9mBy6pUT+kcQd+tGdIu0dNEXehrbw00SQifoJ0XC9yGWe4sEXGIF4uJlwIerDNwAnE
 ij8i3+s4aoLAknwC/oNnp8qY8aKyQFYhJvcyC3TOeNPwGtBjwnZXGAtKnALrIqAmGx0g
 ID9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723227111; x=1723831911;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJXTJBx2vwwBFc0SAiYoyltbFsLGX3/32nAN4Xaa99I=;
 b=WqDkeyqKQ+IekpgzBG0Me8VRWh7fuEwlDOFq/UPXo3KQTehvuFP7VxcuGwjaqdb7qC
 iImo0tNQZMccISwSUPktRXnOHVHDeqSyOUsZ3tgCKH4OOiBpdnbtXiZyehP0IXQ0ec12
 xGObEvsEzhq06TZjFsGL54M+DM/jGcqg6XPcIj8WOHYnJMKfgcS0XZP1QZto3iU+zYpc
 XyNX9Mei4ZDIOpILg/4q5v3uAlDPc3qfRnoItRJt41BwHKdzo5WS4o1fxGc0Dyv/AST8
 KiuGbjC5hcc1C6udkV43IZU0jlWdMDftwTPrWUjlv69UvxwUV78Kk2gAuNO4NBZkvWRH
 tkVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXgT9Gk/OPB0x9e6e84wVQ7lStHvhCFDwW47vrxdvhrNS9sgaBXbjO0ng6a2pDsrHwJ/x6l/p/but6xdGmvgh+j6Fc6ns=
X-Gm-Message-State: AOJu0YyzdULUB30xqoysAWPw5BsF8CPFbmJaA4BvodyJon434IaM0cR/
 Vz7jM4de0KkVme9G8+Wwl8+guCs5fC4TaDtf0hqf0xeUcrS1JLMt4EBY9V/36QY=
X-Google-Smtp-Source: AGHT+IHQM/FnDA3MGscKmzLY0FA/IQNqUWoPqHVwVPm2PU3MR3fxooV3s1J2JyXQS3/87XV3VaDgPw==
X-Received: by 2002:a05:6000:f:b0:368:255e:7235 with SMTP id
 ffacd0b85a97d-36d5f9a2a78mr1556317f8f.16.1723227111085; 
 Fri, 09 Aug 2024 11:11:51 -0700 (PDT)
Received: from [192.168.38.175] (54.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.54]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36ba72sm143493f8f.16.2024.08.09.11.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 11:11:50 -0700 (PDT)
Message-ID: <1c84a15e-5083-4199-a0f3-59fb3c71e421@linaro.org>
Date: Fri, 9 Aug 2024 20:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/57] target/mips: Pass ptw_mmu_idx down from
 mips_cpu_tlb_fill
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240202055036.684176-1-richard.henderson@linaro.org>
 <20240202055036.684176-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240202055036.684176-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Richard,

On 2/2/24 06:49, Richard Henderson wrote:
> Rather than adjust env->hflags so that the value computed
> by cpu_mmu_index() changes, compute the mmu_idx that we
> want directly and pass it down.
> 
> Introduce symbolic constants for MMU_{KERNEL,ERL}_IDX.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.h                   |  4 +++-
>   target/mips/tcg/sysemu/tlb_helper.c | 32 ++++++++++++-----------------
>   2 files changed, 16 insertions(+), 20 deletions(-)


> @@ -944,12 +940,10 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>            * Memory reads during hardware page table walking are performed
>            * as if they were kernel-mode load instructions.
>            */
> -        int mode = (env->hflags & MIPS_HFLAG_KSU);
> -        bool ret_walker;
> -        env->hflags &= ~MIPS_HFLAG_KSU;
> -        ret_walker = page_table_walk_refill(env, address, mmu_idx);
> -        env->hflags |= mode;
> -        if (ret_walker) {
> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
> +                           MMU_ERL_IDX : MMU_KERNEL_IDX);

Checking https://gitlab.com/qemu-project/qemu/-/issues/2470.

Parenthesis are mis-placed.

           int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL) ?
                              MMU_ERL_IDX : MMU_KERNEL_IDX;

Revisiting, we loose possible MMU_USER_IDX value but
- we don't use it
- this is sysemu code so we only expect MMU_KERNEL_IDX

Is that right?

> +
> +        if (page_table_walk_refill(env, address, ptw_mmu_idx)) {
>               ret = get_physical_address(env, &physical, &prot, address,
>                                          access_type, mmu_idx);
>               if (ret == TLBRET_MATCH) {


