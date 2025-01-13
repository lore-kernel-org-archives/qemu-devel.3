Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7CEE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 03:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXAj8-0000mx-VF; Sun, 12 Jan 2025 22:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXAj2-0000m9-JH; Sun, 12 Jan 2025 22:02:48 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXAj0-00037f-AJ; Sun, 12 Jan 2025 22:02:47 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4afe1009960so1154208137.0; 
 Sun, 12 Jan 2025 19:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736737365; x=1737342165; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umLWiyFCx8qsZOmmTC5MPv2lgHRcqsUXDfRQmC2DloA=;
 b=KG95vps29iMnLTb8RRJ/qP2WYlLcx3DlW8PK9bQaAXMig8qUXZ8F5N6NqkZWE+/nyl
 2aC6h8ok35pcCQGk4yC5rbLwGpvVnMQhfXvDEU/Gxfcm+l4BOzrYiD9hGVIDBhUMQEX/
 Muvy+hGHdGaEbjUvD6uLWewqntlhBYF1dM3FyG8iG5cwaZkaZ1WsBLXE2g2M1FhvRYzJ
 WcnKhgxI1RFGVfZLInNyiJZKLFmRlo85D5m7zRExZjsA6dozCYHfG1axcrM1hyJ/aFl1
 ujbitPxZdJbyu8ulqioYqDOQF6AjazVVXx2eKQgg5ogr0BdUkZUzpxgXePQDncjsKquJ
 cqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736737365; x=1737342165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umLWiyFCx8qsZOmmTC5MPv2lgHRcqsUXDfRQmC2DloA=;
 b=Gl3N+tAtK4PuUlw+oy0mZmx95ShEuPIDK1UoBK+fNqJAlV7P3nymjIL8N5JzQgVAuw
 nibDNEd2ac2FAYvHFPISrXvfrbC45eOuywJ1rs6NMbZ+lGXprCQoo22Mz3wRLJBbQb0d
 f+JERfvIzTyoXYd/vvft447tEvWoF8imkrwbqVX5v6B3CcNJ7J1uqOd50rl9L6cBXpmo
 pzTpBOpe4iYb3NvX9AxVDtvluVKku++VEzT8MwdvtOavVGJpA3i0wo7/AJx3YYwSqy1c
 ZcbwYT1KoOtPMuw4ZqurPcCKu5QixEFsYzSR+Z4prf57yYpr4OcEvmHh2Gel/EW97Run
 z64g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVayDKS0BCXnewaHUYfB8M6anokj2xFpWXekVgmML7cT2c1cDp3D1BHaH0deYutvPlg4KYj9zLOF/U4@nongnu.org
X-Gm-Message-State: AOJu0YxRdwxaC+24rgF2/RxZbQbKSobkJVyuC/DcfedcKzGre+IvZ2cF
 Ev0nbSvnLnMclB8Gh7Pa1zKZKhnyehNEvStl/QtTCJ/BgEG2fPO041jA780CdHtupQJw6Qf3y9p
 e5PFulAJVYu0buTCpjzWYE2tDf/Q=
X-Gm-Gg: ASbGncvCO+dgTulWR8LrYdCqyVz//hNhldUbcRgnMCthO7fPYEQiqjkk6gIvzxxk9V0
 Md888WBxc6tPVd4oD5x3oK9otkI3PuW89CVpajDicbcjV0m8ihafDycCXP0gkbmrugb8=
X-Google-Smtp-Source: AGHT+IGQbAL11pLG+K0RteAptVq5E33ej0THINPWK3zWkGUXWESFFnGN/pIOc/EVGiJYRCHr6RswQ6iZ7RVeF4YL33A=
X-Received: by 2002:a05:6102:290e:b0:4b0:49ba:8278 with SMTP id
 ada2fe7eead31-4b3d0ff5da9mr17480109137.25.1736737364868; Sun, 12 Jan 2025
 19:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 13:02:18 +1000
X-Gm-Features: AbW1kvYaoUQ8CRnRd86i9blte23SCKtAutoxOOXwaEeeV5-UGxnD8i4IZDX2KpQ
Message-ID: <CAKmqyKMF7hqyUwZ6eNP+5besjfJMjtTa+EmVRsJ=rVSyXES10w@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Add RISC-V Counter delegation ISA extension
 support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Fri, Jan 10, 2025 at 6:23=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
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
> Changes in v5:
> - Rebased on top of the riscv-to-apply.next
> - Added RB/AB tags.
> - Link to v4: https://lore.kernel.org/r/20241203-counter_delegation-v4-0-=
c12a89baed86@rivosinc.com
>
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

Thanks!

Applied to riscv-to-apply.next

Alistair

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
> ---
> base-commit: b74e358af21fddb93228c4aed22520950cbe9dd7
> change-id: 20240715-counter_delegation-10ab44c7d2c0
> --
> Regards,
> Atish patra
>
>

