Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CBBC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXYd-0001k8-GJ; Tue, 06 Aug 2024 23:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXYc-0001i6-7y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:41:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXYa-0002uB-CR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:41:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ff1cd07f56so11164685ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723002106; x=1723606906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixn5VJ+kJLx+H4k8QwB1NoIOhTMwvrVH+7y5sWqgSDI=;
 b=Ogyix730LuBvv7XcOt00YR7ZnTpsgEM+cEJq0a+99ZSuV3/WdC3IuLFrGhcjLgmt0W
 TA7UoPMmxm1GZZS4mbh1dDXFc28Q/xk6vWeQp25ZtWOfaUaWOhyGqz07DRLIe5SNyge3
 vqGtWFZA9o+Lr6QqX803Cf/ws2uf0OoM+zxS2U711EDcVI4zLPfdOm29XB/LUkjQWPew
 dwUss+lbOozOBmjPiZLU4UKoapUE7pgfwIHMVt5P4HBTFgOGnLIMwDHxTtAPGyJT23VH
 d/x/7Cl+fFihEb1bc2Nrk3kEmjCsjzdrXS/CSHDAi0io8u9xeNQyOq+/EXv4XzVwAJps
 Dzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723002106; x=1723606906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixn5VJ+kJLx+H4k8QwB1NoIOhTMwvrVH+7y5sWqgSDI=;
 b=elPKF69H+rkvFaa8SyATqnbWZEDAuXemZQgE6e494Fju/m0+mXNScXbEqedvXqKGJ1
 r7N9AId2E9HSwrEB+Gs8VshXSUgzj3QEM7CHVXHPGcehPhGgFsusVGDtZHjHj7RU3CrA
 HeiLk40OaETHC3XoO6LJnlA1t7Mv2MnZYId8rWzoaZrWHqP8v6D07rqJlnu/fRMiunO1
 1np8EXQg1hIcdgwVCsy7W1emYbbCPu9it8L1100BCm7wsA+f869IFoTBHSEAG8bHUFSv
 GadfwUEEIunl9r8vaSjZEnYT3fOY9F3N1NYqSAbaLQ8+qZoxMLUlPLDJPiFRyAHZVbil
 tF6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLqlYc2Gn+LFVtSfw2wkQof5Io8jecJNmmtrLBcQWuPSE6s5k5QDoNgUNFE5yQdRXc6IHv2ZGQPPbgXCLzMpTU1aWlJWw=
X-Gm-Message-State: AOJu0YxHVwOYaL2ymLjbbN/35lhHhksxvCazr9LsQ+u+FfWLyrn3Xco4
 D1LMR50XL0z4EuHEcpaklYpyMgLvOPpjyXjjjQ1/j81kF+qSKJ5Q1vfDQFlJGqw=
X-Google-Smtp-Source: AGHT+IFpp/h/OhIxozXEVO/bsGHBoymvUOVxoH8ytFnwfQX6n1nBWeYw6VNQfTIhao5ADQnKfTRhsg==
X-Received: by 2002:a17:903:2306:b0:1ff:3c45:48dd with SMTP id
 d9443c01a7336-1ff57298462mr208354495ad.30.1723002106239; 
 Tue, 06 Aug 2024 20:41:46 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff591786b3sm95289775ad.214.2024.08.06.20.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:41:45 -0700 (PDT)
Message-ID: <e210c317-bad1-4d29-ab11-cd2e16246398@linaro.org>
Date: Wed, 7 Aug 2024 13:41:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] linux-user: Add RISC-V zicfilp support in VDSO
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-21-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-21-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/7/24 10:06, Deepak Gupta wrote:
> Add zicfilp support in VDSO. VDSO functions need lpad instruction
> so that userspace could call this function when landing pad extension is
> enabled. This solution only works when toolchain always use landing pad
> label 1.

Well, no, the lpad insns *could* use imm=0.
Why would the toolchain always use label 1?

Much more explanation is required here.

> +/* GNU_PROPERTY_RISCV64_* macros from elf.h for use in asm code.  */
> +#define FEATURE_1_AND 0xc0000000
> +
> +#define GNU_PROPERTY(type, value)	\
> +  .section .note.gnu.property, "a";	\
> +  .p2align 3;                       \
> +  .word 4;                          \
> +  .word 16;                         \
> +  .word 5;                          \
> +  .asciz "GNU";                     \
> +  .word type;                       \
> +  .word 4;                          \
> +  .word value;                      \
> +  .word 0;                          \
> +  .text
> +
> +/* Add GNU property note with the supported features to all asm code
> +   where sysdep.h is included.  */
> +#undef __VALUE_FOR_FEATURE_1_AND
> +#if defined (__riscv_zicfilp) || defined (__riscv_zicfiss)
> +#  if defined (__riscv_zicfilp)
> +#    if defined (__riscv_zicfiss)

Why are you checking __riscv_* symbols, for when the toolchain
has these features enabled on the command-line?

This is the kind of feature you want enabled always.

> +#ifdef __riscv_zicfilp
> +# define LPAD       lpad 1
> +#else
> +# define LPAD
> +#endif

Here, especially, you should be using ".insn", not omitting the lpad insn.


r~


