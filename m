Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C1DC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmbM-0003y4-Kc; Thu, 13 Jun 2024 11:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHmbL-0003xb-Fa
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:42:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHmbJ-0003D9-Et
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:42:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so878896b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718293375; x=1718898175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=shu4rCk418oF8rBuMNy0AUA60H5cVAf9u8s2a0NUHxQ=;
 b=mlmhK1UjOiVoqG/vfNBeAUEjyJMupA2v55RkxjHo2xUHT4JI9mptBUPMfEsDeITSwp
 lZuYC06Gbu8q9QoFsWpW8mGC1sVWQsMx3v6Vuxm7TUioIljIIT4EPNqcXpmjzoLx4GMn
 1JipsS/KOtuiNUFvHqXhYHvA+F85FrwwmY6BaUsuiC/Ne4eUnYH38o0GqjuPOcUW1DsQ
 QZMuaXAaVRgtie/ODBghqHfzJEe0FOs6O77TnP1KAZVvJn+PxRm2gAZwWzPqiwctuwV5
 SnIraDK2BpRV/g657DWYAfp+Ap4lvB0sHn+TuKzd8qcuXZBMT0+a6fREyvafVJ9fcKup
 Gvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718293375; x=1718898175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shu4rCk418oF8rBuMNy0AUA60H5cVAf9u8s2a0NUHxQ=;
 b=tW6xwACK87LU9eyG6XRHph6YFLlGPzuAlDBtOW7EZmA7eFTVoagol5bYsOXtlAzT5c
 N++JAetifiLKM0ZzNpdInga012QSpET8Zpqk/RMUp7vkM8gRcQU27EeRNVKWd61lvYOe
 QQ0HCacQfb72R3k+HueLizjNypNziv7xM/YNH6iFhzxfDHPMkqBTm3ZDkM6KZb3tTBnY
 BOWqJwVkDQJjyEVXeXSNWO4OGaJBWfBPWtPX6WBdiq+58/SZzuPPcDqU21y4Ux9kyrVC
 9hzKOSDx8lb50rxtlbhRWGTDqo4lXS0vOOssjxZhoQ9Vc8qTtRaNVb+17u2etoGG5ZOL
 vy3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3kU4/bpMIVkV6QqRmj935i53YULQe8kS1vp0zcgc+d8P72N6UlBnzI8JHk9YhESMEcH2ET1LRvu/ncFo8zbuy9hdEWLI=
X-Gm-Message-State: AOJu0YxL0gsby3I4PJjgcBKXzrWgOmwyzTzXoWOhIuHlS+MQS7iNOYiT
 qdFqjpJ9wgUTCcB/x9BpLB0ZSLhbY7zoJgCpS6webS4RpViLYqCxDb71dEmMhniQ/eM1SJkF3xG
 Q
X-Google-Smtp-Source: AGHT+IFj6t1qXQ3QvuV6KYQEWThAniPvZQLvVw5hb++fxxfuPMJj3jEGyHIaQ4kTwXb2jZMlzQhoqA==
X-Received: by 2002:a05:6a20:918d:b0:1b5:977d:439 with SMTP id
 adf61e73a8af0-1bae7d82b84mr338395637.5.1718293375550; 
 Thu, 13 Jun 2024 08:42:55 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb70f4asm1511664b3a.174.2024.06.13.08.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 08:42:55 -0700 (PDT)
Message-ID: <d1c27d07-7c01-48b5-866e-de8af327c8c4@ventanamicro.com>
Date: Thu, 13 Jun 2024 12:42:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613141906.1276105-1-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240613141906.1276105-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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

Richard,

On 6/13/24 11:19 AM, Max Chou wrote:
> Hi,
> 
> This RFC patch set tries to fix the issue of
> https://gitlab.com/qemu-project/qemu/-/issues/2137.

To avoid confusion on what we're doing here: this series is another optimization
effort that Max is doing for RISC-V vector. We're also working into optimizing
the front-end load/store ops like we discussed in this bug a few months ago.

This series is not meant to be some sort of replacement/alternative of the approach
we've discussed. We're aiming for both.


Thanks,

Daniel

> 
> In this new version, we added patches that
> 1. Provide a fast path to direct access the host ram for some vector
>     load/store instructions (e.g. unmasked vector unit-stride load/store
>     instructions) and perform virtual address resolution once for the
>     entire vector at beginning of helper function. (Thanks for Richard
>     Henderson's suggestion)
> 2. Replace the group elements load/store TCG ops by the group element
>     load/store flow in helper functions with some assumption (e.g. no
>     masking, continuous memory load/store, the endian of host and guest
>     architecture are the same). (Thanks for Richard Henderson's
>     suggestion)
> 3. Try inline the vector load/store related functions that corresponding
>     most of the execution time.
> 
> This version can improve the performance of the test case provided in
> https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
> - QEMU user mode (vlen=512): from ~51.8 sec. to ~4.5 sec.
> - QEMU system mode (vlen=512): from ~125.6 sec to ~6.6 sec.
> 
> Series based on riscv-to-apply.next branch (commit d82f37f).
> 
> Changes from v2:
> - Drop v2 patches 1/4/5/6
> - patch 2
>      - Provide direct access host ram flow for vector unit-stride ld/st
> - patch 3
>      - Provide direct access host ram flow for vector whole reg ld/st
> - patch 4
>      - Provide group element load/store flow for vector continuous ld/st
> - patch 5
>      - Extend v2 patch 3 to more vector ld/st functions
> 
> Previous version:
> - v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive.com/
> - v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive.com/
> 
> Max Chou (5):
>    accel/tcg: Avoid unnecessary call overhead from
>      qemu_plugin_vcpu_mem_cb
>    target/riscv: rvv: Provide a fast path using direct access to host ram
>      for unmasked unit-stride load/store
>    target/riscv: rvv: Provide a fast path using direct access to host ram
>      for unit-stride whole register load/store
>    target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
>      ld/st instructions
>    target/riscv: Inline unit-stride ld/st and corresponding functions for
>      performance
> 
>   accel/tcg/ldst_common.c.inc             |   8 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |   3 +
>   target/riscv/vector_helper.c            | 847 +++++++++++++++++++-----
>   target/riscv/vector_internals.h         |  48 ++
>   4 files changed, 738 insertions(+), 168 deletions(-)
> 

