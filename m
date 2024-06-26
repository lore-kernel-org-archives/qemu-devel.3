Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0034EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGqC-0007eL-MD; Tue, 25 Jun 2024 20:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGq6-0007c6-8C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:48:47 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGp4-0008Oc-BP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:48:32 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-48f5ae5cf20so932163137.3; 
 Tue, 25 Jun 2024 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719362772; x=1719967572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZcH95/6aWpbDxh9dDlhrAjV7CtVT90I9hov7rHSLvk=;
 b=i3EPpibDd3hY8CTIjDPTxlkrFeF1aeZoITloyyM78RYC5xWow+8exrlM5C7dvFIrr9
 pKj4eCN9/E6hHm8s9U3HoKYB0ofIYR4WWgiWNtQ/r48xgCv3cHbm48Rz855U9qC1vCUp
 J+Tuh4HfouF/fhHOLHAzL35JeUqguDb67Vo1rEE5UjNKHtGTBKqNnuKo1CECOclJecrp
 NyCIOzYm2iNn/0ioq/ITxFueRcWw+799y3S9ZCFPV73s4dRsfhrGbrIwEymIRKPLj1H6
 /YHcohi9hM/hTLRuj7rmUTvfPGgVg1Xlw2JHCcJASoIWinxI/kWYrFC9z+snJPuZR/dX
 WEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719362772; x=1719967572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZcH95/6aWpbDxh9dDlhrAjV7CtVT90I9hov7rHSLvk=;
 b=C5mx0N4iCj733BGksmoDdF4WHrM2uZChJnzXPb7alcg9bBTpdFEkbda6PwWVneL16r
 uMhNPDqcf4pSE5r3jJYfzG0UuWuG4oq/jbsRM+ylUNGhuriXLnbYWxaXSypS3eaH5+Ae
 oKkKdMufQjeIMW3EfN/6mCVQEBIOnkz70IS3nV8HwtPH2m3eTMjsoGaqXZklMLj53nqB
 oAonm3T+c/GdHcnvr2W5nFERlAmk6EdjUDq/S6+TfSq1cCl4UhK3P6t7dRrSmUscYH3M
 Kv4qohH2vRorj2cvQVnx6uf4DoylThckKoFs3zy2oW0anrt0sVx0DZe+kjk6AkU9+Py7
 V1tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIx9f0KyZqLrbjeBq7QBSum3keA9ohKGrO9cRc2L47Q436EpnUJYvaACngf9cHXvtYJNISDA1DERvKVal8srwKPBKMfoU=
X-Gm-Message-State: AOJu0YwOG/xIqB7+LzaEO/ZKxtKyev7Vc3VhI4aR/GAomLDh/8i44h2S
 hGxPE1iuJRsPYbs+T3sWJP73ySED+OtPvWhwYngPGTYJMvH26f5sg+Vc1iYstRAa2z6HTmZxqn/
 P1JCesUGAHx89by/Z6by+0TZV/Ro=
X-Google-Smtp-Source: AGHT+IHiuJ6+oPZPZqOF+PHfHIPrbnadCcn4WpykISlLBad9HY4A5aOWSbRvOu0FDY3MG2ZRXVRpBAfaspPK6iDjyDE=
X-Received: by 2002:a67:eb02:0:b0:48f:44fe:734 with SMTP id
 ada2fe7eead31-48f52b9d88amr8772966137.27.1719362772260; Tue, 25 Jun 2024
 17:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240625114629.27793-1-frank.chang@sifive.com>
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 10:45:45 +1000
Message-ID: <CAKmqyKNuhtzzOU78phTKfq8qEMo53F1oPbu6iCYO-Nmmtr_XZg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Introduce extension implied rules
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
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

On Tue, Jun 25, 2024 at 9:48=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Currently, the implied extensions are enabled and checked in
> riscv_cpu_validate_set_extensions(). However, the order of enabling the
> implied extensions must follow a strict sequence, which is error-prone.
>
> This patchset introduce extension implied rule helpers to enable the
> implied extensions. This also eliminates the old-fashioned ordering
> requirement. For example, Zvksg implies Zvks, Zvks implies Zvksed, etc.,
> removing the need to check the implied rules of Zvksg before Zvks.
>
> The idea [1] and the implied rules [2] are referenced from LLVM.
>
> [1] https://github.com/llvm/llvm-project/blob/main/llvm/lib/TargetParser/=
RISCVISAInfo.cpp#L875
> [2] https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/RISCV/=
RISCVFeatures.td
>
> Changelog:
>
> v3:
>   - Replace the enabled bitmask of type 'uint64_t' with a dynamic bitmask
>     to support more than 64 harts.
>   - Ensure that implied rules and hash tables are initialized/created onl=
y once.
>   - Rename variables to align nomenclature with existing variables:
>       - In RISCVCPUImpliedExtsRule structure:
>         - 'implied_misas' -> 'implied_misa_exts'
>         - 'implied_exts' -> 'implied_multi_exts'
>       - 'misa_implied_rules' -> 'misa_ext_implied_rules'
>       - 'ext_implied_rules' -> 'multi_ext_implied_rules'
>       - 'riscv_misa_implied_rules' -> 'riscv_misa_ext_implied_rules'
>       - 'riscv_ext_implied_rules -> 'riscv_multi_ext_implied_rules'
>
> v2:
>   - Remove enabled bitmask from user-mode QEMU as there's no good way
>     (e.g. mhartid) to distinguish the SMP cores in user-mode QEMU.
>   - Use qatomic API to access the enabled bitmask to prevent the
>     potential enabled bit from being cleared by another hart.
>
> Frank Chang (6):
>   target/riscv: Introduce extension implied rules definition
>   target/riscv: Introduce extension implied rule helpers
>   target/riscv: Add MISA extension implied rules
>   target/riscv: Add multi extension implied rules
>   target/riscv: Add Zc extension implied rule
>   target/riscv: Remove extension auto-update check statements

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         | 396 +++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h         |  23 +++
>  target/riscv/tcg/tcg-cpu.c | 274 ++++++++++++++-----------
>  3 files changed, 574 insertions(+), 119 deletions(-)
>
> --
> 2.43.2
>
>

