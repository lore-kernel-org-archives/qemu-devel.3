Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3464FC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDFl-0000WR-MC; Fri, 26 Jul 2024 01:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXDFh-0000Jj-Vk; Fri, 26 Jul 2024 01:12:26 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXDFe-0007mi-C2; Fri, 26 Jul 2024 01:12:24 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f6ac1628dfso137168e0c.0; 
 Thu, 25 Jul 2024 22:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721970740; x=1722575540; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brSC3kyXff2AGmVQFgetzER73sqgpYpYte8JkDRAHIo=;
 b=Gg14rTvU8seP6nevOAzSkLjJ5UaWwu2OkI8/wZkTNdXQPvvult488h7U88IiEqnKi9
 vmnASuESPc24SpNxwySBgO3NcKAFhq7NfW2bMDK0lJSecwG2U77Tab1BnPMXH0nzTdZY
 d+25b1lcMRYaBHMdWMdiNCOQ+YJdFQ2MOspI3za5ryZS4XJG7k7WLoCCCRDAnwvseyXh
 IIpX6WgF5SgJXlfjRXebDLYXba92PxbuG1d/i1E6n/Hcbq7cBENTpN+N+2TI5ouTD72A
 GoVISIyikriU+NJSpSxpiX1k+zDZA011+43kGcFWqFlEwjcWMSW6Wnn35pgwg0Fup1O0
 1VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721970740; x=1722575540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brSC3kyXff2AGmVQFgetzER73sqgpYpYte8JkDRAHIo=;
 b=Y1kEblg3XEgs7BqL+w7ESM1JGQPpenRsl0j/w7HP1dPRMhoIyZEY8a1mHvbNVH20/+
 yNXqpLBTpgYO38FqjVOkhR9xHhPYoQDDFsOSpi7FnrpEoZ/xT2uVrI7f/goDbXdDhyzm
 USn/qTyS82rR9HBqcGPD51TFxB4sKXLzSkxwI89QyiYq89zJvnLJZzp+iYMZscVFF78p
 LBbW/qmlWmyqLB1LQuY2i6CL3z6fACFIKi3W8BXeJ+i9eD72nRfiFQaD/rgRoX1e/jmq
 vTBdHadEjE0D/ha9lGriy7zudCuSFy91sZ0APD4x447zvl2WX3naY21AD2QALU08BYrN
 77NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+OcjixMv0UL+5Dzh66uBk/Gac/TDznarOoNqGZuMsgZKxHhPOfM0LgjUEPV0i/HmBv6CC9X4fEfQYZIAr9zMbJomfh2s=
X-Gm-Message-State: AOJu0YxIh3puIFpUFHdeG4ocWYXLewU914PbiJYkKnQW9p+7inKUnkw6
 lWB6SHvxHGnwD9Z2X/slBhApKwEfnHNWW+jtfJTYhcbg+VjZOsH9qs5VC8CuZeLilFCrAB52P2H
 m6x2OaNf6dXgnfntSpPHKxIa13Q4=
X-Google-Smtp-Source: AGHT+IFkaG8mRXxMsAosDDecYecCNnp+Li/Ypn5UkOo8Kedslh4bRVJKD/rFURJONYABnebC/qOX4Dcf3aK+ajjV1Lc=
X-Received: by 2002:a05:6102:4bc2:b0:48f:450e:58a with SMTP id
 ada2fe7eead31-493d654d0c1mr5817916137.30.1721970740454; Thu, 25 Jul 2024
 22:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
In-Reply-To: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2024 15:11:53 +1000
Message-ID: <CAKmqyKPhCzrYxwpBF+NQi-5KgcKkhWeVNX6nwwx3ZjeE9rWEAg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Coverity complained about the possible out-of-bounds access with
> counter_virt/counter_virt_prev because these two arrays are
> accessed with privilege mode. However, these two arrays are accessed
> only when virt is enabled. Thus, the privilege mode can't be M mode.
>
> Add the asserts anyways to detect any wrong usage of these arrays
> in the future.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Fixes: Coverity CID 1558459
Fixes: Coverity CID 1558462

> ---
> The lore discussion can be found here
> https://lore.kernel.org/all/CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=3De_a95xd=
LF=3D=3DV_WQ@mail.gmail.com/
> ---
>  target/riscv/pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 3cc0b3648cad..e05ab067d2f2 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -204,6 +204,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVStat=
e *env,
>      }
>
>      if (env->virt_enabled) {
> +        g_assert(env->priv <=3D PRV_S);

Don't we need this assert for !env->virt_enabled as well?

Alistair

