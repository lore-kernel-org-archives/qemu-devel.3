Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C21C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 00:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGHa-0005Pz-FQ; Tue, 25 Jun 2024 20:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGGe-0005Bw-JK; Tue, 25 Jun 2024 20:12:10 -0400
Received: from [2607:f8b0:4864:20::133] (helo=mail-il1-x133.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGG4-0001KW-Tu; Tue, 25 Jun 2024 20:11:58 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-375af3538f2so25784285ab.3; 
 Tue, 25 Jun 2024 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719360556; x=1719965356; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I/RRyjy32rpLEN/2PREzx1XYtolfEdHqntV0lk0IC0=;
 b=hwftffw9h0dwbOPj8BPtJgIOajUJyvL0nJM1PtZFMoHLHVw8afCidS05bULJRV9wYu
 fqM1ZKAqcrFyRftezjf5BKKnPvGZzAn1JminUvSRWMaNXK0Bj80A6n/v+5mbFifpltJi
 N+UGxAdKDlqJDRtK/cZHu99Zhl0ySjtFE6zsDUGnmg+yzzTJjG/bK0KYj7Td5xgkYQb5
 +Ypps8HIxAzfork5dDGdvTqDFVExcAUuuYXQK/WI5fb/TvZ6pd78UETbJkN+51hPxSn2
 6Cp3LDo3N0naxe4BGmpIANO1F+aONWe7BksELug7Td1hr3+Ak2+L68GdPIxDRP2bKrnz
 0eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719360556; x=1719965356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2I/RRyjy32rpLEN/2PREzx1XYtolfEdHqntV0lk0IC0=;
 b=jltvUl3/GlTfHuaLO+FOzRkBwLLkK0Pd7+YNwY6COTwHyDyaGyuidTy4fbxKFPYr9c
 qspkgWNRmz/8FHvovDmu7sbJk9qPdwYcdHnueeGqT4O+kO9HWbZnFt0pUsW/H5KnxR34
 ArEamaLqcF8G8hyikCYHtdyitfbsyZPLRdKfNCU92xDpZ4Loboc9j0sgLo3hhpMM9eP+
 pdbn53Lzl4gC1LVSqCXnxIqIJKQmkYdm1PCL6AdUxHDUde8HqLrLVuZoMeficWO9WyJZ
 oF9192FPBmirUXRMamo+xq72hpzKJJ8VgNZh6qG4DcG2BaQVJRZesZId4yy3VqyHaL11
 HcuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhdVhL2ekAX5R2Q8cLgWVW7Zf8t1bupN2QrWwyBRn7XPIsZxi901sCwruvNS9sL0vMzN+aOk9ErevvondAKcd0t7KEXZo=
X-Gm-Message-State: AOJu0YzVY+3xJFAqXxp2UF6T+YtjB4x/oSl/ndHqDvDhipAZ1OGMx3nT
 bXZfns+1JpQX8X9Bv87KLgzM/ppCW0KBQwImugakL4j9cQSjRDnSq+N2/mEZro9AMGm5pV2M56P
 +Bz/oAVZqHZeC++6SctPx4jvhjcclguqr
X-Google-Smtp-Source: AGHT+IHw+pLB8jRKyJW34KshC/x2I7vDrJFKQNlz6t1ON4TmjE3KhUCioFXDPwUhs8nZS6inJOlPHnmYlEm9vL7PXTQ=
X-Received: by 2002:a05:6122:469f:b0:4ef:4b35:896f with SMTP id
 71dfb90a1353d-4ef6d82ffb5mr8197072e0c.7.1719360103067; Tue, 25 Jun 2024
 17:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
In-Reply-To: <20240619152708.135991-1-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 10:01:17 +1000
Message-ID: <CAKmqyKP4sau8vANRBnq7ua0gjjCmVsVxzOCYgbjQR7irhBeQfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::133
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPOOFED_FREEMAIL_NO_RDNS=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 20, 2024 at 1:28=E2=80=AFAM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> This series enables Control Transfer Records extension support on riscv
> platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been stable and the latest release can be found here [0=
]

Can you be explicit about the exact version. RISC-V specs have a
tendency to change and the latest release today might not be the
latest tomorrow.

v1.0.0_rc2  at https://github.com/riscv/riscv-control-transfer-records/rele=
ases/tag/v1.0.0_rc2
for example would be really helpful

>
> CTR extension depends on couple of other extensions:
>
> 1. S[m|s]csrind : The indirect CSR extension [1] which defines additional
>    ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>    RISC-V CSR address space. CTR access ctrsource, ctrtartget and ctrdata
>    CSRs using sscsrind extension.
>
> 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext to
>    S-mode.
>
> 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
>
> The series is based on Smcdeleg/Ssccfg counter delegation extension [3]
> patches. CTR itself doesn't depend on counter delegation support. This
> rebase is basically to include the Smcsrind patches.

Same comment here about specific versions

>
> Due to the dependency of these extensions, the following extensions must =
be
> enabled to use the control transfer records feature.
>
> "smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue,smctr=
=3Dtrue,ssctr=3Dtrue"

We shouldn't have this dependency if the actual spec doesn't have it.

Even if the spec does have the dependency we should the implication
rules to enable the required extensions if a user asks for CTR

Alistair

>
> Here is the link to a quick guide [5] to setup and run a basic perf demo =
on
> Linux to use CTR Ext.
>
> The Qemu patches can be found here:
> https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream_v2
>
> The opensbi patch can be found here:
> https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
>
> The Linux kernel patches can be found here:
> https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream_v2
>
> [0]: https://github.com/riscv/riscv-control-transfer-records/release
> [1]: https://github.com/riscv/riscv-indirect-csr-access
> [2]: https://github.com/riscvarchive/riscv-count-overflow/tree/main
> [3]: https://github.com/riscv/riscv-smcdeleg-ssccfg
> [4]: https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc=
.com/
> [5]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-=
on-QEMU-RISC%E2%80%90V-Virt-machine
>
> Changelog:
>
> v2: Lots of improvements based on Jason Chien's feedback including:
>   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
>   - Fixed and added more CTR extension enable checks.
>   - Fixed CTR CSR predicate functions.
>   - Fixed external trap xTE bit checks.
>   - One fix in freeze function for VS-mode.
>   - Lots of minor code improvements.
>   - Added checks in sctrclr instruction helper.
>
> v1:
>   - https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
>
>
> Rajnesh Kanwal (6):
>   target/riscv: Remove obsolete sfence.vm instruction
>   target/riscv: Add Control Transfer Records CSR definitions.
>   target/riscv: Add support for Control Transfer Records extension CSRs.
>   target/riscv: Add support to record CTR entries.
>   target/riscv: Add CTR sctrclr instruction.
>   target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
>     regs.
>
>  target/riscv/cpu.c                            |   4 +
>  target/riscv/cpu.h                            |  14 +
>  target/riscv/cpu_bits.h                       | 154 ++++++++++
>  target/riscv/cpu_cfg.h                        |   2 +
>  target/riscv/cpu_helper.c                     | 265 +++++++++++++++++
>  target/riscv/csr.c                            | 276 +++++++++++++++++-
>  target/riscv/helper.h                         |   9 +-
>  target/riscv/insn32.decode                    |   2 +-
>  .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  31 ++
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  20 ++
>  target/riscv/op_helper.c                      | 159 +++++++++-
>  target/riscv/tcg/tcg-cpu.c                    |   6 +
>  target/riscv/translate.c                      |  10 +
>  14 files changed, 960 insertions(+), 13 deletions(-)
>
> --
> 2.34.1
>
>

