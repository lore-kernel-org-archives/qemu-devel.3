Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84743E7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 02:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW4Ti-0007el-G5; Thu, 09 Jan 2025 21:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4Tg-0007eV-PK; Thu, 09 Jan 2025 21:10:24 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4Tf-0005oD-1J; Thu, 09 Jan 2025 21:10:24 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4aff5b3845eso696413137.2; 
 Thu, 09 Jan 2025 18:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736475021; x=1737079821; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fokgb8byJHrnsuWJKS+hvCH3KDkpzhPn5ly+xa0X34c=;
 b=dW31SYFyb4tLij/KPWqVLP21AB7fQbaeFvGwUy8Q6dhkRBYNswRFPzFqcQwq+V7U0T
 BG5E8PnH8VjggMbCgAVxRj2t5LiqRGplTv4XshJEPhUVFwuo4y1n7WmYP8oJbxjgL35R
 +G3OED9JEV84eXmTwIO6xZJNoigPIiuPwnWDrqZ2cGx/5iZxKBMdGcAb0QiUBJzbwvW0
 2leLgBqB+YPQLOi4jIrtKl+6w/RclLp+6Pr9ppwFxDtoUu9OaTZRuwXEDA5YWpNc3QXN
 11YsO/aFb9s3wwd2dXQd3g4mf1/rUZizTepfhuLgUWqi9AnBLDcCaQwwg64QDzm0zF6W
 Jvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736475022; x=1737079822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fokgb8byJHrnsuWJKS+hvCH3KDkpzhPn5ly+xa0X34c=;
 b=wR/1TDqHmwtO1VqKQxNH8GeRqbdNO9ctoQWE87sqH2YPUgYuYzCkk3N7aWG7mIhSC/
 SAAZ7uaOLSPuXxUIXL3N8Nimu2BB9JJMcqqky2AejDunzldxDJYbuMoq+0xud48JKKU6
 509Xtm1VhCzt0ajD+9kz6p4Vrg3t0O6sPdIEz+ZC0/SMZsg5PyThxBde9k7nSDtTyP6W
 97RVTubmwN9rcGvyi+CXbFH2sYsqGfTa99HXSxF1rTXWEfcrLrYZQ5NJUIk8D0Tlcky7
 7LWIBqU0S939yGmCBZb5HNIqzDaUNbR9wFBfEndY41ksuh1iLyf+wvD5h/PnXinJ/abv
 JAAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/sHbGDRcbOuaAZ1lOT14cbT/AatoANPgFWcIxiBjw1G/2WrGpiVo/c4z7TRCBVWF6xdz6Cbb0bUoh@nongnu.org
X-Gm-Message-State: AOJu0YzwCmIaNFhK9PiBFFQoZApmkLo4VnBDIuDS+DiNv7Idy6CHOw3v
 GFVWz1gvQ/cT1l/a/PD6VjguMOGLX2wNP/6pKQv3riMb1P9+ZlVoKGhfHF7SfgY+sKfAAv0lkNa
 Y1QKiv2vN4TTM4OVhLGocZ/ox/es=
X-Gm-Gg: ASbGncvVGfJr9JdSFCw5jyWlJyCacpCu5bwHbsEeAYLHLIJZwcDlClhlZjxgxaUq6iM
 13F0FzcxAdMYczp6wwGCVGDyr2ynb4aq2+RExqBtqigX7ob4hu7xjqh4aAZMaYJSlaXE=
X-Google-Smtp-Source: AGHT+IH6AgsTHXtjedDs1NtycqO3Fhp80G2IqcaQtOfXRyv+pa0W5Ym0/4ruJmweX0k3WxlSsJJISMqp85lw6cSz8mA=
X-Received: by 2002:a05:6102:2ac5:b0:4b2:af93:4313 with SMTP id
 ada2fe7eead31-4b3d10480b9mr9133592137.17.1736475021549; Thu, 09 Jan 2025
 18:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 12:09:55 +1000
X-Gm-Features: AbW1kvYZ9Hx4yAAkkQUOmXl3mghMruTIloQD_4XmiiwDChSKO6t4cVtGpNinTzA
Message-ID: <CAKmqyKMBSoTR7-UexAu2qrur5bOgWBGOOQOPXgrh+k6LC3vG-A@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Add RISC-V Counter delegation ISA extension
 support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Dec 4, 2024 at 9:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> This series adds the counter delegation extension support. The counter
> delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple IS=
A
> extensions.
>
> 1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
>    5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>    RISC-V CSR address space.
> 2. Smstateen: The stateen bit[60] controls the access to the registers
>    indirectly via the above indirect registers.
> 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
>
> The counter delegation extension allows Supervisor mode to program the
> hpmevent and hpmcounters directly without needing the assistance from the
> M-mode via SBI calls. This results in a faster perf profiling and very
> few traps. This extension also introduces a scountinhibit CSR which allow=
s
> to stop/start any counter directly from the S-mode. As the counter
> delegation extension potentially can have more than 100 CSRs, the specifi=
caiton
> leverages the indirect CSR extension to save the precious CSR address ran=
ge.
>
> Due to the dependancy of these extensions, the following extensions must =
be
> enabled to use the counter delegation feature in S-mode.
>
> "smstateen=3Dtrue,sscofpmf=3Dtrue,ssccfg=3Dtrue,smcdeleg=3Dtrue,smcsrind=
=3Dtrue,sscsrind=3Dtrue"
>
> This makes the qemu command line quite tedious. The previous version, I t=
ried
> to introduce a preferred rule to enable all but it was decided that an us=
er
> should opt to use max cpu if they don't want to enable all the dependant =
ISA
> extensions by hand. This series got rid of the preferred rule and added 2
> patches for specifiying the mandatory ISA extensions via implied rule.
>
> The first 2 patches decouple the indirect CSR usage from AIA implementati=
on
> while patch3 adds stateen bits validation for AIA.
> The PATCH4 implements indirect CSR extensions while remaining patches
> implement the counter delegation extensions.
>
> The Qemu patches can be found here:
> https://github.com/atishp04/qemu/tree/b4/counter_delegation_v4
> The Linux kernel patches can be found here (WIP version due to onging ups=
tream
> dependant patches):
> https://github.com/atishp04/linux/tree/b4/counter_delegation_v2
>
> [1] https://github.com/riscv/riscv-indirect-csr-access
> [2] https://github.com/riscv/riscv-smcdeleg-ssccfg
>
> Cc: kaiwenxue1@gmail.com
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Changes in v4:
> - Fixed the comments recieved on v3.
> - code style comments and removed 1 redundant if else block.
> - Link to v3: https://lore.kernel.org/r/20241117-counter_delegation-v3-0-=
476d6f36e3c8@rivosinc.com
>
> Changes in v3:
> 1. Updated the priv version in extensions
> 2. Fixed minor issues pointed out in v2.
> 3. Dropped preferred rule and added an implied rule for AIA and counter
>    delegation.
> - Link to v2: https://lore.kernel.org/r/20240723-counter_delegation-v2-0-=
c4170a5348ca@rivosinc.com
>
> Changes from previous RFC version:
>
> 1. Renamed sxcsrind to csrind to align with other function names.
> 2. Enable sscofpmf by default for virt machine.
> 3. Introduced a preferred extension enabling rule strategy for generic
> mult-extension dependencies.
> 4. Enables all PMU related extensions if ssccfg extension is set.
>
> RFC Link:
> https://lore.kernel.org/all/35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanam=
icro.com/T/
>
> ---
> Atish Patra (5):
>       target/riscv: Enable S*stateen bits for AIA
>       target/riscv: Add properties for counter delegation ISA extensions
>       target/riscv: Invoke pmu init after feature enable
>       target/riscv: Add implied rule for counter delegation extensions
>       target/riscv: Add configuration for S[m|s]csrind, Smcdeleg/Ssccfg
>
> Kaiwen Xue (6):
>       target/riscv: Add properties for Indirect CSR Access extension
>       target/riscv: Decouple AIA processing from xiselect and xireg
>       target/riscv: Support generic CSR indirect access
>       target/riscv: Add counter delegation definitions
>       target/riscv: Add select value range check for counter delegation
>       target/riscv: Add counter delegation/configuration support
>
>  target/riscv/cpu.c         |  20 +-
>  target/riscv/cpu.h         |   1 +
>  target/riscv/cpu_bits.h    |  34 ++-
>  target/riscv/cpu_cfg.h     |   4 +
>  target/riscv/csr.c         | 718 +++++++++++++++++++++++++++++++++++++++=
+++---
>  target/riscv/machine.c     |   1 +
>  target/riscv/tcg/tcg-cpu.c |  28 +-
>  7 files changed, 753 insertions(+), 53 deletions(-)

This has all been Acked now, do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

> ---
> base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0
> change-id: 20240715-counter_delegation-10ab44c7d2c0
> --
> Regards,
> Atish patra
>
>

