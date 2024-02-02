Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56E9C4828D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 02:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rViuo-0007t4-Lo; Thu, 01 Feb 2024 21:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rViun-0007se-17; Thu, 01 Feb 2024 21:04:25 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rViul-0001IJ-9m; Thu, 01 Feb 2024 21:04:24 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4bd84b96feeso596992e0c.1; 
 Thu, 01 Feb 2024 18:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706839461; x=1707444261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7fGz49kNcQmxgefr/WMhW89QheBldr5o9h5T/lFdJM=;
 b=J1jnPALagUds1blTHvSIs3emJ0PEBE9D3zKcyOUD/oYs90EbbjR+9Mgtf/02wWMzls
 e8thuo3I2l1sBrkPBzwUHmkrtFTFnfu/PHIP5gZ9WEU+dAw74Pmy7Dpyr67Zj9dPYBaN
 +kECvSOc44+qq62LqS1kVTPKTKRjaL5TreOtGJ/AyCAbX9vB+pteFhQnxKuorVWdq67d
 lBrup6DpZP6UlV8MBZphH0NobW6RyjmCG0j5gm8WTtsYPT/vRzOZmZqpXz4z5yfeKv3L
 3cMbxO+X3dBMCXGG+blBAedUnRUCdtzCt+b9MJPumdCMg+aNtSTzFGKQFRXJWB1JIpcm
 4ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706839461; x=1707444261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7fGz49kNcQmxgefr/WMhW89QheBldr5o9h5T/lFdJM=;
 b=GQbFbaZx9fQNMZN+UXrNhuDo6mJ6eJpPm1pfpMwTkt5u/BScI5A2ANDaL6Z+ZtZvrL
 KNicoGPxELMGhR2sRfsCtQkZGnLYWmFohszvfLI77Z/pZ1Mx77mU0nS1Y6EFADXBo86e
 l2cLpWFjUTAs+dkbdxjF1Ps6sh5GCbut9NLtxLu/cTrVVaeBkOeSvCZE7Eg53Ocze2xi
 v5cLwUXH3OfE2ZJa+fWB6fsFnbaESgXtYruIxQKh+Z3AWMkqIF2U2Rbq1+jHo7dg6Src
 Hw5/fqkyzNUZfZ5WAEIZtp3t9tjDlWc0iM5/mpNh969B2eTRTEop6itHMpDglERNSW/f
 Ti5w==
X-Gm-Message-State: AOJu0Yy4DKB3Pt9coSHgfmEyyKf8lpwm6z42jXvPSG0SzHjO/7HXwpR4
 qibwGdmFDAyvueWyhNz0u1I7Md8WlaBvSt/TgVb37qil/TIx7WZPg+wpX8xiJr73AZVUkyUBZVE
 gR48ZAlIeh/37lstlUbmHDxN3APg=
X-Google-Smtp-Source: AGHT+IGEbvbgjzm0+Ngdm+dlg8KIVHf+3Z7wEkJJhtvEUa9GJepDZrhthuYOKej5qEXAYCpzObxWGvvwNxYF8avR1bA=
X-Received: by 2002:a05:6122:30e:b0:4bd:8029:6700 with SMTP id
 c14-20020a056122030e00b004bd80296700mr563716vko.16.1706839461525; Thu, 01 Feb
 2024 18:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20240201140047.3456114-1-me@deliversmonkey.space>
In-Reply-To: <20240201140047.3456114-1-me@deliversmonkey.space>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 2 Feb 2024 12:03:55 +1000
Message-ID: <CAKmqyKM+Buy4fH2=OuJTZsgJ9xi+VGOeTNkrE=6bss-jvaOqbg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Pointer Masking update for Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_PH_BODY_ACCOUNTS_POST=0.693, TVD_PH_BODY_META_ALL=2.546,
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

On Fri, Feb 2, 2024 at 1:11=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.c=
om> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> This patch series is rebased on https://github.com/alistair23/qemu/tree/r=
iscv-to-apply.next

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> Thanks
>
> [v5]:
> This patch series targets Zjpm v0.8 extension.
> The spec itself could be found here: https://github.com/riscv/riscv-j-ext=
ension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
> This patch series is updated after the suggested comments:
> - add "x-" to the extension names to indicate experimental
>
> [v4]:
> Patch series updated after the suggested comments:
> - removed J-letter extension as it's unused
> - renamed and fixed function to detect if address should be sign-extended
> - zeroed unused context variables and moved computation logic to another =
patch
> - bumped pointer masking version_id and minimum_version_id by 1
>
> [v3]:
> There patches are updated after Richard's comments:
> - moved new tb flags to the end
> - used tcg_gen_(s)extract to get the final address
> - properly handle CONFIG_USER_ONLY
>
> [v2]:
> As per Richard's suggestion I made pmm field part of tb_flags.
> It allowed to get rid of global variable to store pmlen.
> Also it allowed to simplify all the machinery around it.
>
> [v1]:
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
>  target/riscv/cpu.c           | 22 ++++----
>  target/riscv/cpu.h           | 47 ++++++++---------
>  target/riscv/cpu_bits.h      | 90 ++-------------------------------
>  target/riscv/cpu_cfg.h       |  3 ++
>  target/riscv/cpu_helper.c    | 97 ++++++++++++++++++++----------------
>  target/riscv/csr.c           | 41 ++++-----------
>  target/riscv/machine.c       | 22 +++-----
>  target/riscv/pmp.c           | 13 +++--
>  target/riscv/pmp.h           | 11 ++--
>  target/riscv/tcg/tcg-cpu.c   |  5 +-
>  target/riscv/translate.c     | 46 +++++++----------
>  target/riscv/vector_helper.c | 15 +++++-
>  12 files changed, 160 insertions(+), 252 deletions(-)
>
> --
> 2.34.1
>
>

