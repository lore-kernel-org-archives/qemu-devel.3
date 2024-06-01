Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50264C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 09:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDLQ4-0003p0-Ek; Sat, 01 Jun 2024 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sDLQ3-0003o6-3F
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 05:52:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sDLQ0-0000dk-Vy
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 05:52:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70249c5fb36so1151321b3a.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717235575; x=1717840375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xLkHeG49XqhRvm0huCaYMR+oYOHiFZZrxyDRW+PlvB4=;
 b=KA98VRx7VVJSqWPuEYv0xaZrNiDN/XgKdpKDjF9dT1/9R+ZGIY/g9S2FJjgOIRCHR2
 AIUwB/cf5N550bFnI0gPeADh+/4V0cKLBOAsgG3N3WGmhktBUpdq/DYg2232nw0sz4ZR
 JRnsDuxundnUu1WqIG5jV5emINe0+rbnHtN43D4LdUy860Y5lqGMbDxoTSBsevvVEnuQ
 yGmLlUr6RBPelQetwlUobgI05W9i4HWk4JCOhmjH79pprFAKYHXwGJCuj3iuZ8OWmAjf
 1eJDqhyuSjrbohklTnkHtBjXbLTxEKnk8y+MWzdVZ2ckgJdzYXnxiJwSRJBS9oPBSbF6
 q5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717235575; x=1717840375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLkHeG49XqhRvm0huCaYMR+oYOHiFZZrxyDRW+PlvB4=;
 b=ZVTTVYfNr/POOCu6i+17W1bbGWSdDwPLZot3N+GQj6dJZPGWon6hGfpn0FzG6Aa2ak
 5G0GFw+F1r7ItJaEfV0qggwuIBZdyo8z+QytjTWaENW65mrwXRudqf5BS1yPZbArefM2
 lyEj3cCxr/JnQS4AEe77jga+Q0aUYr4b/y/32Qzxgezx1Ywn7dpTbS0QAHPaTUAwPDnI
 NbA2Mr6AoteL7a2Q3nyZuohmgMT6OZDHZcUcHp8zEf7Ucg+fIHhPBk4fDJbSh7kbeqTz
 ctjXrvxCuAT+atoa1EnASMbAx2C7zTKaPfn88CbKQ+UtEwxT7ZsjJkp92+/BrSO227CX
 deeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJfTiROrawHktMDJmYkiC/73awXAj47bBlC5itI5eZb2qj+Fs1fiRJK7LzyzzNWzAGLJXZrIvVTQcrah3u6s6aUsq6Aa0=
X-Gm-Message-State: AOJu0YyTK8EGmqRgBmAvNkegNeAWWjdXm8CJVU0nWRUs5EsNRehiW971
 h1NE4KpuLnxmqKSZ3sSqAvOYPBkQZzSdU4F9iB3lpJBlg8X4eHt+oNdL6wY5qM0=
X-Google-Smtp-Source: AGHT+IEf2RtNOztj9YY2WgVh9IWQtHx8d/eNDlkUMrOgMlcs406nXK+LwU16VK8gfmQ+gHYY3zKnPw==
X-Received: by 2002:a05:6a20:da95:b0:1b2:565a:4d1c with SMTP id
 adf61e73a8af0-1b26f137689mr5330088637.24.1717235575108; 
 Sat, 01 Jun 2024 02:52:55 -0700 (PDT)
Received: from [192.168.68.110] (189-69-160-78.dial-up.telesp.net.br.
 [189.69.160.78]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c27ec844sm2770972a91.33.2024.06.01.02.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 02:52:54 -0700 (PDT)
Message-ID: <6ae5689d-d4d7-46b9-b1a6-3878a8bb83c7@ventanamicro.com>
Date: Sat, 1 Jun 2024 06:52:49 -0300
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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

Hi Atish,


I see that Rajnesh sent some patches that were built on top of this
work [1], and this series no longer applies neither to alistair's
risc-to-apply.next nor to master.

If you could send a rebased version of this series that would be great.


Thanks,


Daniel



[1] https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@rivosinc.com/


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

