Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C348FC47DB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 02:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVMPX-0007G7-AJ; Wed, 31 Jan 2024 21:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVMPV-0007Fq-S4; Wed, 31 Jan 2024 21:02:37 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVMPT-0006Ny-U1; Wed, 31 Jan 2024 21:02:37 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46b2e88a808so162489137.0; 
 Wed, 31 Jan 2024 18:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706752953; x=1707357753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU10jKjpHLrMn1M9rCn0l6ewu1910EPFvmlq9YgmiBk=;
 b=LbHhbficgCsKK1mcgvjvVJb2/INyi68VT+9O+nILpRNeSjNxS0UU/9bnqf1jFMHzok
 JnMmalmqvs3Bo1trUBxB8Co9pM2lgxAIhF2HLOblXIBnNxO3oeAGKnlO+r6Z7dBNXQpR
 R7RaoBULyaNg+jEPKvE1UEvvSfPFvjVOJrbkHi5iR0kzpETFuglk0+OBLaKehKuH0aZ+
 27U9prj3O2AEl+ZZ78ibeX8cR1YHU1Irl/27itxp/Gi9MXxVjCbeLx0Eqx5Quqbfgfxh
 f/+o2wBLSonU2SLPD/ocbHfwLv0hpQ0SRMdDa7fKJ/Sgx4aNWzxsDGeonSN3K5xy8rOl
 Pf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706752953; x=1707357753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LU10jKjpHLrMn1M9rCn0l6ewu1910EPFvmlq9YgmiBk=;
 b=dPUlQVIK61QZ0mR0JANe3v1Dpoz8tFSJb1FYkLworg9nqMCkzd2dvKVjKkuYxgscHS
 /Ceqwl9eCEYDH/tkjHTeurbiurQYXmrjLIcty9yP74I/gTQdaLv1gXlinlBtZyBSPtES
 dEqWZRlqOV1Z1YhxOAiFMy514GnNsRhE4Se1hkaNBNou5dexKBJUK1YUcxDZvudhAEax
 f2jbU8tk8kmbvoi6QaMR5vm+I5dDN5ukN4fZ0I84WtyPrK1Ql1L7fjg7yxH0z+uE1RGs
 Tee22nIsi6YMtAw8Yf3xsZ7j18wvtTIZxllpUd/MNYpPapxLS9ixs84vovkkVF4d7bCi
 JtXg==
X-Gm-Message-State: AOJu0YyrCwjUbGaaQ+YgMYjKzM08YCxZn/hbzf+tJewB3XIe6Jh2Ix5P
 OrwifOs913CX/XS6s6KCBHlsHUMB+Ss2t0nVTkCPVpnZiafk5ZbMjQDxut8m37S8MpU9L64b+LL
 0Z6+dUGoi4AC8+5VIaHoe/FguBXs=
X-Google-Smtp-Source: AGHT+IGjiqrmLriMQ5vYEfob5BTRNv8uirAO6DMAxGHbcDbP+AFxRdDqEhj24jc2cmcPHz9APnvmEc4IB5C9PPHEviM=
X-Received: by 2002:a05:6102:1958:b0:469:94f8:1249 with SMTP id
 jl24-20020a056102195800b0046994f81249mr3463444vsb.16.1706752953432; Wed, 31
 Jan 2024 18:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20240129192207.2946870-1-me@deliversmonkey.space>
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 12:02:06 +1000
Message-ID: <CAKmqyKMoumWhQKkT4UW8h-UPah-8Z39gGzmTnza-BPktpct-LA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Pointer Masking update for Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_PH_BODY_ACCOUNTS_POST=0.602, TVD_PH_BODY_META_ALL=2.567,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jan 30, 2024 at 5:23=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> This patch series targets Zjpm v0.8 extension.
> The spec itself could be found here: https://github.com/riscv/riscv-j-ext=
ension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
> This patch series is updated after the suggested comments:
> - add "x-" to the extension names to indicate experimental

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

>
> [v4]:
> Patch series updated after the suggested comments:
> - removed J-letter extension as it's unused
> - renamed and fixed function to detect if address should be sign-extended
> - zeroed unused context variables and moved computation logic to another =
patch
> - bumped pointer masking version_id and minimum_version_id by 1
>
> Thanks
>
> [v3]:
> There patches are updated after Richard's comments:
> - moved new tb flags to the end
> - used tcg_gen_(s)extract to get the final address
> - properly handle CONFIG_USER_ONLY
>
> Thanks
>
> [v2]:
> As per Richard's suggestion I made pmm field part of tb_flags.
> It allowed to get rid of global variable to store pmlen.
> Also it allowed to simplify all the machinery around it.
>
> Thanks
>
> [v1]:
> Hi all,
>
> It looks like Zjpm v0.8 is almost frozen and we don't expect it change dr=
astically anymore.
> Compared to the original implementation with explicit base and mask CSRs,=
 we now only have
> several fixed options for number of masked bits which are set using exist=
ing CSRs.
> The changes have been tested with handwritten assembly tests and LLVM HWA=
SAN
> test suite.
>
> Thanks
>
> Alexey Baturo (6):
>   target/riscv: Remove obsolete pointer masking extension code.
>   target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>     of Zjpm v0.8
>   target/riscv: Add helper functions to calculate current number of
>     masked bits for pointer masking
>   target/riscv: Add pointer masking tb flags
>   target/riscv: Update address modify functions to take into account
>     pointer masking
>   target/riscv: Enable updates for pointer masking variables and thus
>     enable pointer masking extension
>
>  target/riscv/cpu.c           |  22 ++-
>  target/riscv/cpu.h           |  46 +++--
>  target/riscv/cpu_bits.h      |  90 +---------
>  target/riscv/cpu_cfg.h       |   3 +
>  target/riscv/cpu_helper.c    |  97 +++++-----
>  target/riscv/csr.c           | 337 ++---------------------------------
>  target/riscv/machine.c       |  20 +--
>  target/riscv/pmp.c           |  13 +-
>  target/riscv/pmp.h           |  11 +-
>  target/riscv/tcg/tcg-cpu.c   |   5 +-
>  target/riscv/translate.c     |  46 ++---
>  target/riscv/vector_helper.c |  15 +-
>  12 files changed, 158 insertions(+), 547 deletions(-)
>
> --
> 2.34.1
>
>

