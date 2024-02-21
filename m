Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47492C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcocb-0006i5-Ef; Wed, 21 Feb 2024 10:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcoZb-0002ea-Tn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:31:51 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rco3U-0007eq-53
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:58:41 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2997c5fe6abso506856a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708527518; x=1709132318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wyKGb7aupxH/I0YN4RmuhGFBq+ozkV6FJIxca5nyg/k=;
 b=HhCj3tixCGk2bvfX2lRpPK2NNsRInzH/uB+nAFJCox6YwhEJ+3RszJnjCHF2ijKHPG
 9DpkOX0iRZ5elEWPEjlxDnBQ798Ik0n0aUwplBTcIQhGUQ1YuGiw2EpGHYSHSIeEc00m
 VPXzrEeVPBn6T70lHn67RRR0OndoaBnTuosw06LGK7a/q5CENqHCxLcmO4dxMXC4SrYd
 jW6gvCIGJPYKHAdCFrYVTrErFLPhNeKxwkWH8I/q+WgkX4A1UkufMDnb1sNCkyOBtYv7
 po6spcF1ts+d3iYOxRtbMtQ670hKUfDdbQ3UFRsyogZFfBiLexXy/VhSfPcoIPYAd6Hg
 /VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708527518; x=1709132318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyKGb7aupxH/I0YN4RmuhGFBq+ozkV6FJIxca5nyg/k=;
 b=KPM0ECm87xfQ384RpaUoxKxoP2NrszF25umqKbpKk0qpxRGu+2hNTnAsBrO0aEkeMW
 xAaj0ND6VTLKdqjh7SpkWEWHGrAUnT5frjQvI/0P7cDl84b2sdn9urbDdX/arR2b9oZ6
 BrNhJGmIbLUxPJKcL+m5Ee0ZEfypmnI0OuwQusRLIWO0yIG+Bo7eFa1GyyOw98JRbKWh
 /PAUJUQYw5DhAnh+v7+YKT1zGV5MDgPHDRdIfdd7Y7Kif5CkvfNz+/RiVm+8WBOqV6il
 pXGATEP4V2rZRyPdLQmD1pY97bSGVBeI7cC0xh5/yrqeKP93ZJfUVfCF+qFd3tRxq7zG
 zItA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaWbrhmAwK79sNf/gLM694cnZVAHVvajmB33MkLnp3WtVikKaXDbRoqovc5UuMxBI9YZOWPcZq1jR+Jx3zINRC+bgUoKg=
X-Gm-Message-State: AOJu0Yy0uJPPZvIWflzYcOqnXAkt8O/itH81EAJA8/LEDyxZ2/gDeKMT
 vdfJtGMbx5xksnFX89w33hY9ZApVMH7tFTrvfBN8w0mpa/jtxVSsTQ4opSEK8GY=
X-Google-Smtp-Source: AGHT+IHXPSxlJG1PoMSsxFPcDXh152TtsRHepouoWKmixxeuSLmiw6R5hnrCEaLVg4OiaBdQ2ccqHA==
X-Received: by 2002:a17:90b:33d1:b0:299:592a:7d19 with SMTP id
 lk17-20020a17090b33d100b00299592a7d19mr10191947pjb.3.1708527518581; 
 Wed, 21 Feb 2024 06:58:38 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 q69-20020a17090a17cb00b0029954a48c38sm10199016pja.38.2024.02.21.06.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 06:58:38 -0800 (PST)
Message-ID: <35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com>
Date: Wed, 21 Feb 2024 11:58:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] Add Counter delegation ISA extension support
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240217000134.3634191-1-atishp@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Atish,

This series and its dependency, which I assume it's

"[PATCH v4 0/5] Add ISA extension smcntrpmf support"

Doesn't apply in neither master nor riscv-to-apply.next because of this patch:

"target/riscv: Use RISCVException as return type for all csr ops"

That changed some functions from 'int' to "RISCVException" type. The conflicts
from the v4 series are rather trivial but the conflicts for this RFC are annoying
to deal with. It would be better if you could re-send both series rebased with
the latest changes.

One more thing:

On 2/16/24 21:01, Atish Patra wrote:
> This series adds the counter delegation extension support. The counter
> delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple ISA
> extensions.
> 
> 1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
>     5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>     RISC-V CSR address space.
> 2. Smstateen: The stateen bit[60] controls the access to the registers
>     indirectly via the above indirect registers.
> 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
> 
> The counter delegation extension allows Supervisor mode to program the
> hpmevent and hpmcounters directly without needing the assistance from the
> M-mode via SBI calls. This results in a faster perf profiling and very
> few traps. This extension also introduces a scountinhibit CSR which allows
> to stop/start any counter directly from the S-mode. As the counter
> delegation extension potentially can have more than 100 CSRs, the specificaiton
> leverages the indirect CSR extension to save the precious CSR address range.
> 
> Due to the dependancy of these extensions, the following extensions must be
> enabled to use the counter delegation feature in S-mode.
> 
> "smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"
> 
> This makes the qemu command line quite tedious. In stead of that, I think we
> can enable these features by default if there is no objection.

It wasn't need so far but, if needed, we can add specialized setters for extensions
that has multiple dependencies. Instead of the usual setter we would do something
like:

cpu_set_ssccfg() {

     if (enabled) {
         smstateen=true
         sscofpmf=true
         smcdeleg=true
         smcsrind=true
         sscsrind=true
     }
}


The advantage is that this setter would also work for CPUs that doesn't inherit defaults,
like bare-cps and profile CPUs.

That doesn't mean we can't add defaults for rv64, but for this particular case I wonder if
the 'max' CPU wouldn't be better.


Thanks,


Daniel

> 
> The first 2 patches decouple the indirect CSR usage from AIA implementation
> while patch3 adds stateen bits validation for AIA.
> The PATCH4 implements indirect CSR extensions while remaining patches
> implement the counter delegation extensions.
> 
> The Qemu patches can be found here:
> https://github.com/atishp04/qemu/tree/counter_delegation_rfc
> 
> The opensbi patch can be found here:
> https://github.com/atishp04/opensbi/tree/counter_delegation_v1
> 
> The Linux kernel patches can be found here:
> https://github.com/atishp04/linux/tree/counter_delegation_rfc
> 
> [1] https://github.com/riscv/riscv-indirect-csr-access
> [2] https://github.com/riscv/riscv-smcdeleg-ssccfg
> 
> Atish Patra (1):
> target/riscv: Enable S*stateen bits for AIA
> 
> Kaiwen Xue (7):
> target/riscv: Add properties for Indirect CSR Access extension
> target/riscv: Decouple AIA processing from xiselect and xireg
> target/riscv: Support generic CSR indirect access
> target/riscv: Add smcdeleg/ssccfg properties
> target/riscv: Add counter delegation definitions
> target/riscv: Add select value range check for counter delegation
> target/riscv: Add counter delegation/configuration support
> 
> target/riscv/cpu.c      |   8 +
> target/riscv/cpu.h      |   1 +
> target/riscv/cpu_bits.h |  34 +-
> target/riscv/cpu_cfg.h  |   4 +
> target/riscv/csr.c      | 713 +++++++++++++++++++++++++++++++++++++---
> target/riscv/machine.c  |   1 +
> 6 files changed, 722 insertions(+), 39 deletions(-)
> 
> --
> 2.34.1
> 

