Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390A0C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNPq-0006Ug-JM; Tue, 21 Jan 2025 18:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNPo-0006UT-Gd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:12:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNPm-0005Dz-E8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:12:11 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216281bc30fso143643065ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737501127; x=1738105927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rkpHIASXc+dj4cwVQX9xsJgWRT8BTIJ2KbhT2XvzAE=;
 b=ovV0rX3giVFQm2H9D34+eiWsUq0ba4b2quolMcEYhuieBHGo0L4Bea3ZdyW/GgXtyv
 YuK2LKFDcuL3+FXxGAjFmgqOyKCGb81SG1QwYF9VvuNri30sVVW3LpIZCgv3F+JMwrV8
 kCfwWFimkOSpEvqss91E3Q3yDOvFiOnfOF3UnN/PjAtPUdQyj9bOxC2xLCCSLLAdHb1b
 QsGuEyql0SgwqloQ+Py/bDS6uA5EBKzUmjkaUpXHfI6QM6jp/WeVZ6MSF4YRnJ//3fyI
 K437mjt/Aa0PhPkGLT2cHv2VfbDXRtGn7gBNRa8HHV90D1ICF/JTxO9KUqgf1Mt/vjB3
 h8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737501127; x=1738105927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rkpHIASXc+dj4cwVQX9xsJgWRT8BTIJ2KbhT2XvzAE=;
 b=RMBS5yRIThgyml81M24AX7tyBWLqFnC02fyeeVtMS1D70N1unIFdP0jxsrxrwCC5W7
 jh7MNqze2OeiidmHdj4JwtXtPnbZo982I4FlDhRhhvoIxE4Ov2RPK29ztySqaJcKJKgN
 dX9NMvQVOXUGGATp/k7fvnTLkiQzGsgLOZc3RxWdhC1K8EdM6QcIiKBUFuoq6ApDxVgb
 OzePc/f5fV5We3uHfIOFNbCciPDhF6C2dzGsA6CIgNCLNJA76uSgFbCzcbELNWLA23mT
 IljnbMi9bmMFEysNA4VxZaTMpIcbNiI3qq6Gwj5b8g6I8F4n2XwTHADhXvS4n/XFp+yu
 SiCw==
X-Gm-Message-State: AOJu0YyjTgQHyw50g+ouKIyonY6Axpb1V7bmswXC/8Li6uJ23Jur4ow1
 7mA+rEkcxTQLG1jkH5tEAk/g/00X4AwNmIR/ZxATipeARlQ0ldaHnkZ0m8Io5qhgqJABsg/Jz6k
 8
X-Gm-Gg: ASbGncsslVxu+gGQbDhfMI/cqSS3+J9wYRUFrpkHsh++yp7HrOvp+62WuKFgHrw3789
 UGad9uLUMiyAfi+V903+bDuDbsJ3SDX6WwdJ032abHUHSNn5l0mbKPRbWYsqXNuS4UNHA032Jqs
 awCq3VUNtVUDN5/MPoAj0JMqwKrVmt6x33FNO5kcXLKTzQa4cmM1fbw5k/3G2iwFjgUjrZME0Ng
 Gpa3W85g4XKa3XI+Ll5Mp8cihi9K80bZVrhitHqkSetfNzrXHIueFM83oWAO3Lztfy6nQlocLOK
 aTC6mfD8tZCtNCXTOG9t92X9ncrl2zL0ct9k
X-Google-Smtp-Source: AGHT+IFGTUVVmaApGNTt1JMsJB6mPq/jByfMgBV9MBocy0XJkZs29tPGLjhv8k5uluE4h/8PUdCbUg==
X-Received: by 2002:a17:902:c943:b0:215:a18f:88a8 with SMTP id
 d9443c01a7336-21c357afde0mr284951985ad.51.1737501126655; 
 Tue, 21 Jan 2025 15:12:06 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d0b5763sm83798975ad.106.2025.01.21.15.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:12:06 -0800 (PST)
Message-ID: <1635b7be-1c20-49ab-8e21-66f06f761c3e@linaro.org>
Date: Tue, 21 Jan 2025 15:12:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/mips: Allocate CPU IRQs within CPUMIPSState
To: qemu-devel@nongnu.org
References: <20250121161817.33654-1-philmd@linaro.org>
 <20250121161817.33654-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121161817.33654-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/21/25 08:18, Philippe Mathieu-Daudé wrote:
> There are always 8 IRQs created with a MIPS CPU.
> Allocate their state once in CPUMIPSState, initialize
> them in place in cpu_mips_irq_init_cpu(). Update hw/ uses.
> 
> Move cpu_mips_irq_init_cpu() declaration from "cpu.h"
> to "internal.h", as it shouldn't be accessible from hw/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h               |  4 ++--
>   target/mips/internal.h          |  2 ++
>   hw/intc/mips_gic.c              |  4 ++--
>   hw/mips/fuloong2e.c             |  4 ++--
>   hw/mips/jazz.c                  |  6 +++---
>   hw/mips/loongson3_virt.c        |  4 ++--
>   hw/mips/malta.c                 |  4 ++--
>   hw/mips/mipssim.c               |  4 ++--
>   target/mips/system/cp0_timer.c  |  4 ++--
>   target/mips/system/interrupts.c | 11 +++--------
>   10 files changed, 22 insertions(+), 25 deletions(-)

Why move into CPUMIPSState and not MIPSCPU?
Is it because that's where irq[8] is currently?

I guess it doesn't matter much either way.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

