Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5262AC3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSD1r-0001Kg-3G; Fri, 12 Jul 2024 05:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sSD1o-0001K3-VV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:57:24 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sSD1m-0006GM-7A
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:57:24 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-38b4e08c3e5so7747525ab.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720778241; x=1721383041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqydqafD3kBXYFTMCSsrPDm0JQ1bvA7go1HRfadFKQM=;
 b=bSHyTmsMnoTYYJY+D3bzTSc3xMkSAc3JLeWyY5RZgCh+IDt/Ughuvk+NKM9TkEy+m8
 pBbDe7TACvVnPTrMrkNRHyTUZXuz3KDJo/frgOWlIJ9JSe5ORHvOknXI4Iuun1r6aBHi
 eGPOGZkoaR8vtqllHW/6fuvojhxXd8S9yZswc8dACsPnoz8e/w9xw4JYhP0H29gfcHE0
 JGMZFYk9I5dDAbj5nRaGJQspUs84DOdI77qE5+DpJKo2IRibH4NdeOR9bZ0tRAAqoGrO
 idq1zBHRxqNmY2V6Y+vtjBRU0cAJbNcIumRAUT2IbunYRUXkIl1e84wnAbVihZS1R1XZ
 WwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720778241; x=1721383041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqydqafD3kBXYFTMCSsrPDm0JQ1bvA7go1HRfadFKQM=;
 b=wlPdnOK631zxBevjxK+0n9AE6dd+8Hp5hFpWmzsAu9G4kxIrJdythRF51saAx5ot8L
 NRZhFxJopjeYBGujoYroSQJVR0IgAO9lPqr+n5e2ncdeLKoLut430fSkIFJEq3PjrGwy
 emnXCzMuzDSR0alq/au+ovi+EZer1d5aZ5epUqJJk30hondC3nqETJFNYWgA0klRttyr
 pCE47r+OD84tTeBLH8F00REtQcolhyrJhew+N47Vlf8gbCOUI3srLxB7ZZoo/gAGzmqD
 NTC3GK/6HvSIGQh0sfaMKQIdYFXIVAb2yfyrfdFYZvguqvKtdi3cbpd5I1m/34abLCXq
 44aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4rYW0BSSMIX0+iLBIiMG4/5EBxCr1W9lP3O62aStdXPVmnql1fF/W26q1Z7tdjg1nkjIdpbhsvrkBpIt02dBEXE636C8=
X-Gm-Message-State: AOJu0YwR4rLMUNerFvs6aI1JmOahQImRDBJlyPd3VZGqL+ETi1mir7Lc
 HtSbbBHY8AmZ6cgT3czLs8FN4e6OPWNWwB58sV7xXbAGcdJV8InnIgwpnlEVgTk=
X-Google-Smtp-Source: AGHT+IHKuuueD0V711CG4W4g5gLv5lqq0F4C8vVH9XnL67iBild06iyzUtLJYyrd4OaaHNmyHOnwOg==
X-Received: by 2002:a92:ca45:0:b0:382:759d:60f1 with SMTP id
 e9e14a558f8ab-38a5848df9fmr134465915ab.18.1720778240731; 
 Fri, 12 Jul 2024 02:57:20 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b439b220esm7292862b3a.176.2024.07.12.02.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 02:57:20 -0700 (PDT)
Message-ID: <d46477b2-b0f0-4bf4-8c20-2ff2466d4d5f@ventanamicro.com>
Date: Fri, 12 Jul 2024 06:57:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, =?UTF-8?B?55Sy5LiA?=
 <lzw194868@alibaba-inc.com>
References: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x134.google.com
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



On 7/9/24 11:24 PM, LIU Zhiwei wrote:
> From: 甲一 <lzw194868@alibaba-inc.com>
> 
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
> 
> This patch set has been tested with 6.9.0 Linux Image.
> And add an avocado test in tests/avocado.

Thanks for this work and sorry for the late review.

One thing to look out as a follow-up is the 'max' CPU. It has the same name
in both 32 and 64 bits so it'll result in a conflict with the 'max' CPU for
rv64.

One easy way out is to add a new 'max32' bit CPU for riscv32, which would be an
alias for the 'max' CPU, then adding 'max32' support in rv64.


Thanks,

Daniel


> 
> # make check-avocado AVOCADO_TESTS=/home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
>    VENVPIP install -e /home/jenkins/git/qemu/python/
> /home/jenkins/git/qemu/build/pyvenv/bin/python3 -B /home/jenkins/git/qemu/python/scripts/mkvenv.py ensuregroup  --online /home/jenkins/git/qemu/pythondeps.toml avocado
> mkvenv: checking for avocado-framework(>=88.1, <93.0)
> mkvenv: checking for pycdlib>=1.11.0
> mkvenv: installing avocado-framework==88.1, pycdlib>=1.11.0
>    AVOCADO tests/avocado
> Fetching asset from /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
> Fetching asset from /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
> JOB ID     : 8c2e1ff918d3111d078a52eba9956893afaf9e1d
> JOB LOG    : /home/jenkins/git/qemu/build/tests/results/job-2024-07-10T09.55-8c2e1ff/job.log
>   (1/1) /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i: PASS (17.50 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> JOB TIME   : 29.50 s
> 
> v5:
>    Rebase to master and add tags
> 
> v4:
>    Drop UL completely in PATCH v3 2/7, 4/7, 5/7.
>    Avocado: Add "if=none" to "-drive" option in QEMU command line
> 
> v3:
>    Rebase to the master branch
> 
> v2:
>    Remove the line that was inadvertently left in PATCH v1 4/6.
>    Add an avocado test.
> 
> v1:
>    https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
> 
> TANG Tiancheng (7):
>    target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>    target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>    target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>    target/riscv: Detect sxl to set bit width for RV32 in RV64
>    target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>    target/riscv: Enable RV32 CPU support in RV64 QEMU
>    tests/avocado: Add an avocado test for riscv64
> 
>   configs/targets/riscv64-softmmu.mak |  2 +-
>   hw/riscv/boot.c                     | 35 +++++++++++++++++---------
>   hw/riscv/sifive_u.c                 |  3 ++-
>   include/hw/riscv/boot.h             |  4 ++-
>   include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++
>   target/riscv/cpu.c                  | 17 ++++++++++---
>   target/riscv/cpu.h                  |  5 +++-
>   target/riscv/cpu_helper.c           | 25 +++++++++++++------
>   target/riscv/pmp.c                  |  2 +-
>   tests/avocado/boot_linux_console.py | 38 +++++++++++++++++++++++++++++
>   10 files changed, 132 insertions(+), 28 deletions(-)
> 

