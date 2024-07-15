Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0273C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 01:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTA6j-0001Hs-Ro; Sun, 14 Jul 2024 21:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sTA6f-0001G4-LC; Sun, 14 Jul 2024 21:02:21 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sTA6Z-0006rV-Sc; Sun, 14 Jul 2024 21:02:21 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-48fde151f25so1405829137.1; 
 Sun, 14 Jul 2024 18:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721005334; x=1721610134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ0/GI0+w/hJayhG9jGOJ+UrqDNV1wTZpD9FvyGVKbk=;
 b=SRmzzObep/2diSMYl+ScpPH8LGT2dmUSwF1Ullkpy+sEnKXhrr+OSiAy1LZ9/1gO14
 vzrmk1b5Y9a58QZPxgVYuTolghCtbFkVb4fZQAziLCoOQsJhNECos1JNKXWSHZIGaMgi
 ss+bX21Q8rqKpw4smefZqIk5P/tpS97x1UrhzXEb25xCTjmkYbS2fhoS5aVUHj61MUSF
 YTKtTsxG9zRS6ip1VIvSg+HkXhRvT/1RqahOoCN/S09qLlh9zUFE4HAZ4s7yjkjDlSMz
 0L12tXm+yJvSv94GQeAFHWKqufBQUS6gEo2q64EUmFpoZDeySOOidXesRvvUfiZKPBNC
 nmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721005334; x=1721610134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJ0/GI0+w/hJayhG9jGOJ+UrqDNV1wTZpD9FvyGVKbk=;
 b=S4e3wXrIh4XWs84iBDSarZiY7Ki2ZwGfs1zvW9/3Qv2hAy43TnTNmiTkR5NLVyUfCz
 O7ridm4hP4d+YaYdTqYBDcnjwsc6dJCnCstmDMu9F8zMsbS0rfwjc5NxV++uJ6W9wN/S
 w1SphyuVltvYZZAewiom9lHAnM6Zs3HQk/wMWmOUyvd+8xQP3PCLKl4y30aJJE3c5nBf
 /4JOkfSAqnSFzKduk7SUyTLNKHTIzDn3esBICLIVoFlRqDCJKnfiWY9clpZf7G7VX5cg
 tkKPCX+8Sknv9DoG9oJWxPX08qg30HuWDGDa/6tDZatbo7LkUgofEZDPnW24hEBbfxFU
 AJ8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBAIPEyj/tXl3+6pj4lmNR/wIrYaf2XSr+FqbReEng+hVhVSxL8PnANUCQcOkQxcBYrtT3Nqm5wr0q3UMGNevswtdARE0=
X-Gm-Message-State: AOJu0YwXQIXDnxmO1d9KxtS7HrdBGvIZ3jhibnxoEoDvhSK2n8m3XsbG
 VDul+XRQFq9xq/bUW1uU2wwxZjgVA3tg3/G6o7m1kXlGW1ujYWqs9+SflJdGwXs6wLKNh3X/Qbr
 89iUIgLgwCmprSpaDfrFrj9ogA0r2QwHI
X-Google-Smtp-Source: AGHT+IEJyLqVwiUdcxSJceiZR9uZKupxpadtLw2TC/8DKXx/0csJkfvSrCriKbMWH7dWB3Gr69QRVJNA5RGs6iNG7Zg=
X-Received: by 2002:a05:6102:3906:b0:48f:143a:d8e9 with SMTP id
 ada2fe7eead31-490321597afmr20762022137.20.1721005334263; Sun, 14 Jul 2024
 18:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 11:01:48 +1000
Message-ID: <CAKmqyKMZ+A3DiWm_T5ZKZqHDBt1i9hT4qo1dgv62FkLvjuxeDg@mail.gmail.com>
Subject: Re: [PATCH v8 00/13] Add RISC-V ISA extension smcntrpmf support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 12, 2024 at 8:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> This patch series adds the support for RISC-V ISA extension smcntrpmf (cy=
cle and
> privilege mode filtering) [1]. It is based on Kevin's earlier work but im=
proves
> it by actually implement privilege mode filtering by tracking the privile=
ge
> mode switches. This enables the privilege mode filtering for mhpmcounters=
 as
> well. However, Smcntrpmf/Sscofpmf must be enabled to leverage this.
>
> The series is also available at [2] as well.
>
> Changes in v8:
> - Moved the config option to a separate patch at the end of the series.
> - Fixed a comments recieved in v7 around setting INH bit based on availab=
le priv modes.
> - Updated the RB/AB tags.
> - Link to v7: https://lore.kernel.org/r/20240626-smcntrpmf_v7-v7-0-bb0f10=
af7fa9@rivosinc.com
>
> Changes from v6->v7:
> 1. Fixed a compilation issue.
>
> Changes from v5->v6:
> 1. Rebased on top of alister/riscv-to-apply.next (c50aabe132) and icount =
fix
>    patch[4] which may cause conflicts.
> 2. Fixed a bug in pmf logic related to VS<->HS transition and same mode
>    recording.
> 3. Merged assorted fixes PR as the changes are intertwined. [2]
> 4. Fix counter inhibit CSR behavior. This change now start counters from =
both
>    mhpmcounter and mcountinhibit writes. Previously cycle/inst timer was
>    only started on mhpmcounterx write.
> 5. Optimized the PMU timer setup code.
>
> Changes from v4->v5:
> 1. Rebased on top of master(158a054c4d1a).
> 2. Fixed a bug for VS<->HS transition.
>
> Changes from v3->v4:
> 1. Fixed the ordering of the ISA extension names in isa_edata_arr.
> 2. Added RB tags.
>
> Changes from v2->v3:
> 1. Fixed the rebasing error in PATCH2.
> 2. Added RB tags.
> 3. Addressed other review comments.
>
> Changes from v1->v2:
> 1. Implemented actual mode filtering for both icount and host ticks mode.
> 1. Addressed comments in v1.
> 2. Added Kevin's personal email address.
>
> [1] https://github.com/riscv/riscv-smcntrpmf
> [2] https://github.com/atishp04/qemu/tree/b4/smcntrpmf_v7
> [3] https://lore.kernel.org/all/20240429-countinhibit_fix-v1-0-802ec1e991=
33@rivosinc.com/
> [4] https://lore.kernel.org/qemu-riscv/20240618112649.76683-1-cleger@rivo=
sinc.com/
>
> Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Atish Patra (7):
>       target/riscv: Fix the predicate functions for mhpmeventhX CSRs
>       target/riscv: Only set INH fields if priv mode is available
>       target/riscv: Implement privilege mode filtering for cycle/instret
>       target/riscv: Save counter values during countinhibit update
>       target/riscv: Enforce WARL behavior for scounteren/hcounteren
>       target/riscv: Do not setup pmu timer if OF is disabled
>       target/riscv: Expose the Smcntrpmf config
>
> Kaiwen Xue (3):
>       target/riscv: Add cycle & instret privilege mode filtering properti=
es
>       target/riscv: Add cycle & instret privilege mode filtering definiti=
ons
>       target/riscv: Add cycle & instret privilege mode filtering support
>
> Rajnesh Kanwal (3):
>       target/riscv: Combine set_mode and set_virt functions.
>       target/riscv: Start counters from both mhpmcounter and mcountinhibi=
t
>       target/riscv: More accurately model priv mode filtering.
>
>  target/riscv/cpu.c        |   2 +
>  target/riscv/cpu.h        |  20 ++-
>  target/riscv/cpu_bits.h   |  41 +++++
>  target/riscv/cpu_cfg.h    |   1 +
>  target/riscv/cpu_helper.c |  66 +++----
>  target/riscv/csr.c        | 437 +++++++++++++++++++++++++++++++++++++---=
------
>  target/riscv/machine.c    |   5 +-
>  target/riscv/op_helper.c  |  17 +-
>  target/riscv/pmu.c        | 181 +++++++++++++++++--
>  target/riscv/pmu.h        |   4 +
>  10 files changed, 624 insertions(+), 150 deletions(-)

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> base-commit: 842a3d79a0e37cd3d685c4728308fac0d9bfd0bb
> change-id: 20240626-smcntrpmf_v7-3b275d1da117
> --
> Regards,
> Atish patra
>
>

