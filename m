Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F558CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 04:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0nN-0000tg-DF; Mon, 15 Sep 2025 00:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0nJ-0000sp-21
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:26:25 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0nB-0005UZ-7M
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:26:23 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b07c081660aso522138466b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 21:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757910372; x=1758515172; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehxXcNcjHZAVgY8AyxOEN8eciuPmK27T8vI26P3FQhs=;
 b=cTRXWLEHEpaHvAupANQ+pQcSorjqFTLTrud0iLm3OMrlr7DOT+Yfq5KtES0gW0ucql
 nleiFnZDhc0SaPq6/mKRY2ja1F1eJTjppb6+Y2ZMTue1oi1iSvQ49fE5nF/2fVj9j8zV
 IRewJEM9IrvwQuxuwdPgZjXIVLMA4sRGwtWMyFvj9jHMFg6GkJvrB66/QRAJDPwMWqUl
 jgUIJxI1RdVSJPhoQbkPGzB4x2ylPQFjKMBsqlqJp9bXCsplx7s2dZtigij1WxA32FH+
 tzc37oTxO3OA3Hcu5BYBKLjXIcDY9D+7KqQ5ROTrAdf7fF8WZzraH75MZ1uBDNelJaox
 gBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757910372; x=1758515172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehxXcNcjHZAVgY8AyxOEN8eciuPmK27T8vI26P3FQhs=;
 b=VyeWK/RwVzegwd5cxRJFsdWywOIBHE66QKufF2Sv7eZcofTW37yrSJ1Y92eX8JqbfS
 qXpEjOTbeT3b8+WDESpag3R6Aa4nSxsJw9kIjLdd8b6aXJn1JSQxT1Y20exqof/x5751
 b6S2p4P71WGpcraYkkV+un3h1ucOItcyoSojVQh+8W5ekLVA+TPf325jPh1Pw3ILLDur
 XbN1zAlCEbm4nzQasoNSWAfBVQUYb4xLil3QNL5AYd6ep5GqEeNLirw3Cv/dbcRxehZj
 iGlwS3AI34Xc9KGTxhHjq3seeC++tdUp3eYYBd9rlfzjw2hbllokGe/NTIomG5M3PEo7
 BLTQ==
X-Gm-Message-State: AOJu0YwSJ3KvqyGbU8OJa1/FYhkGZMgMwWf/BpXun5wHUvqnE0ha2Oq7
 Wre5cqKuzRh4VxAKQ3vLfkmfG1NknsEzEHjVavTxp+IqEMa9FXkdHEf1ife9CE7ZuVZTLY/ee1q
 bX3dM7dCtJCP1pomvPIhXDQxFWldI4zI=
X-Gm-Gg: ASbGncuBNt4TLRIFj2fsdReQXEK1f7DFD2B9bxBKenwSbwzAoFxmqkwnZyHM+mFshIg
 FE7gnFyJ+8nz/rd057+566FS9WnWyn5KH0z7GFWP2CuERhiSpYo05KnOFNidrgshFhvawR4JAcS
 DI1JLzUcj6g8Gs7pBZ4xLgC63E4h2H4Jucja8aw3mv7azuRCBJSDVoURt6h9xaWjY+1MJT3PhnT
 u/uFSXkKhvsBifYQXTlKBU4REE5/uDZMvjn47j10xvF+IXF
X-Google-Smtp-Source: AGHT+IEHpdW/dhee0G2mXZ8ftv6j81WKvMKqL1KjkGHGPVZyzCtyb6kBpbMwROEaXsZLZvyNGNlfHGybSS39aD/nbnw=
X-Received: by 2002:a17:907:3f2a:b0:afe:af04:33e4 with SMTP id
 a640c23a62f3a-b07c354057amr1237776366b.11.1757910372133; Sun, 14 Sep 2025
 21:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 14:25:45 +1000
X-Gm-Features: Ac12FXw0Eub9aHJj5p_6n5FD8DPbZgMTQhAnBSvi5T2v-fvB_FJ26M65t4nh2MQ
Message-ID: <CAKmqyKM2Pm-_pci0uany7cNmwCUf8UXNA6K24UYRDta29fDv=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix RISC-V timer migration issues
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Sep 11, 2025 at 7:59=E2=80=AFPM TANG Tiancheng <lyndra@linux.alibab=
a.com> wrote:
>
> This patch set fixes several timer-related migration issues in QEMU's
> RISC-V implementation that cause timer events to be lost or behave
> incorrectly after snapshot save/restore or live migration.
>
> The problems addressed are:
>
> 1. ACLINT mtimer time_delta not migrated: The time_delta field in
>    RISCVAclintMTimerState was missing from vmstate, causing incorrect
>    mtime values after snapshot restore. This resulted in guest time
>    appearing "frozen" until enough virtual time elapsed to compensate
>    for the offset error.
>
> 2. ACLINT mtimer timers array not migrated: Active timer events
>    scheduled via riscv_aclint_mtimer_write_timecmp() were not being
>    migrated, causing pending timer interrupts to be lost after restore.
>
> 3. CPU stimer/vstimer not migrated: The S-mode and VS-mode timer
>    pointers in CPURISCVState were missing from vmstate_riscv_cpu,
>    causing supervisor-level timer events to be lost.
>
> The patch set introduces a new VMSTATE_TIMER_PTR_VARRAY macro to handle
> migration of variable-length timer pointer arrays, and adds the missing
> timer fields to the appropriate vmstate structures.
>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v3:
> - Remove 'include/' of the subject at patch v2 2/4.
> - Added Reviewed-by from Peter Xu.
> - Link to v2: https://lore.kernel.org/qemu-devel/20250910-timers-v2-0-313=
59f1f6ee8@linux.alibaba.com
>
> Changes in v2:
> - Split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch,
>   and define VMSTATE_TIMER_PTR_VARRAY() in riscv_aclint.h.
> - Added Reviewed-by from Daniel Henrique Barboza.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250909-timers-v1-0-7ee=
18a9d8f4b@linux.alibaba.com
>
> ---
> TANG Tiancheng (4):
>       hw/intc: Save time_delta in RISC-V mtimer VMState
>       migration: Add support for a variable-length array of UINT32 pointe=
rs
>       hw/intc: Save timers array in RISC-V mtimer VMState
>       target/riscv: Save stimer and vstimer in CPU vmstate
>
>  hw/intc/riscv_aclint.c         |  7 +++++--
>  include/hw/intc/riscv_aclint.h |  4 ++++
>  include/migration/vmstate.h    | 10 ++++++++++
>  target/riscv/machine.c         | 25 +++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 2 deletions(-)
> ---
> base-commit: 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8
> change-id: 20250909-timers-18c2c67b1a2a
>
> Best regards,
> --
> TANG Tiancheng <lyndra@linux.alibaba.com>
>
>

