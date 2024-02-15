Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364B7C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYQR-0000Sj-CU; Thu, 15 Feb 2024 04:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYQO-0000SC-2k; Thu, 15 Feb 2024 04:53:00 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYQM-0001A8-E5; Thu, 15 Feb 2024 04:52:59 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7d2e15193bbso291905241.0; 
 Thu, 15 Feb 2024 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990777; x=1708595577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jJOhssCYRwnQoB4fN27AWOuxiZRSOe4ZUVa4Ngguqg=;
 b=b+bPzpjgfM/bC1XzZWcsZP5hWC97uaTY6mmKi5Jhm3bihlAK4XcyfM0Skw1tGgRLWs
 FT4Y3Yh9zmWH4mFV/IEDT0pUJMOnRaPxvmazp4IIwblS6RvmKZGh8OIdAg/7ueGGOoNe
 qm0HN4YApF63bus0ZODH/Ko9c0gdUkhV6gzbyZ86H53FHYQ6G732egeVWodDSON+UiSC
 iDXIA2IlLQYZtexd8DEq332jf5c+RK8nm09WakUVtmX77hxIloHA7jLs1r8wWAWcchZL
 vyWG8MoIhf2tUhFm3NvpLqxhBFoFpGf3+YH6JFQBGDNDV9SrZv+tCeFVVkFVeLz/POU9
 mwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990777; x=1708595577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jJOhssCYRwnQoB4fN27AWOuxiZRSOe4ZUVa4Ngguqg=;
 b=lFHbjNOVogG47fKfrJM07OncAJWWgaNYbaLZuPKPM6cmklCSLLrijjgsy0Q1YhQ4dz
 JqypgP5gbju6yPiG73I6zZUkB9tgNXAuiC3f7p8KDmCPdpcrypHjD9MTJQd7OdvYi148
 A5KYqbywU5vz2sBJIzpvm/oc5lkcveqygy8ny/KDGChJbMdAzTf0ELiMJtd/MNnr4gS4
 ANHVqD31Jj5wpwuPJvTamQC4E73AyGgGUgt2HpWbB5Ax8YxZ/KT6MUgJdi+2qMF+Kkwd
 hq6RoXk1aBzy4vIppnoOrrt2IgFeUB7wEhe6PsbDu7+7I9X7issH2bmP9fD3Zopao0Li
 Dsxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnsu8b4x9gfx7jUXZiRmCVkkk12VKjBY54U1l6w8+5ANa9g7S/CQ/d26ITPFpktS/fpuvA9IteB5S8qENiMHmQ7byUK+U=
X-Gm-Message-State: AOJu0Yz9hr+RSRUpdoafd8LYp1zhPB0mmWsGHxauXidYd5YX+Ak412V9
 F5YHmKNVS/34iQawTua5wh7xYVJlmDXhF8zGEHO/Uol0+ecU/gOUVRuNfneObD+kmHqugiGroWG
 Pw7+Yfj3RtHBJn7m8Z15nIE9Yoi8=
X-Google-Smtp-Source: AGHT+IGvN87ltAX7tgeTt8SfUtIOlzIgDnE+6+4Dm5m4viQ5ULSLk57H2DkuTvwZj3jd3nPP+fYww7Wmw2UoTnrgN0Y=
X-Received: by 2002:a05:6102:304e:b0:46e:c5df:2b51 with SMTP id
 w14-20020a056102304e00b0046ec5df2b51mr1617900vsa.17.1707990777073; Thu, 15
 Feb 2024 01:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:52:30 +1000
Message-ID: <CAKmqyKN0UX_PK5Xiar-PdzJrV=S6+LaX8a3So8uahuqC04Wpvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] riscv: named features riscv,isa, 'svade' rework
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Feb 3, 2024 at 1:23=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version we changed patch 3 as suggested by Alistair in v1
> [1]. Instead of creating individual always-true bool for each named
> feature, create a bool flag will be always 'true' to be used as config
> offset for these named extensions.
>
> Patches based on riscv-to-apply.next.
>
> Patches missing acks: patch 3.
>
> Changes from v2:
> - patch 3:
>   - 'ext_always_enabled' bool added
>   - individual always-enabled named features bools removed
> - v2 link: https://lore.kernel.org/qemu-riscv/20240126133101.61344-8-ajon=
es@ventanamicro.com/
>
>
> [1] https://lore.kernel.org/qemu-riscv/20240125195319.329181-1-dbarboza@v=
entanamicro.com/
>
> Andrew Jones (3):
>   target/riscv: Reset henvcfg to zero
>   target/riscv: Gate hardware A/D PTE bit updating
>   target/riscv: Promote svade to a normal extension
>
> Daniel Henrique Barboza (3):
>   target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
>   target/riscv: add riscv,isa to named features
>   target/riscv: add remaining named features

Do you mind rebasing? I feel bad always asking, but I think it's your
patches that cause the conflicts :P

Alistair

>
>  target/riscv/cpu.c         | 70 +++++++++++++++++++++++++++-----------
>  target/riscv/cpu_cfg.h     | 12 +++++--
>  target/riscv/cpu_helper.c  | 19 ++++++++---
>  target/riscv/csr.c         |  2 +-
>  target/riscv/tcg/tcg-cpu.c | 34 +++++++++---------
>  5 files changed, 94 insertions(+), 43 deletions(-)
>
> --
> 2.43.0
>
>

