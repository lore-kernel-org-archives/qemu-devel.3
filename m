Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF7C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpT8-0004vD-Sf; Tue, 02 Jul 2024 22:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpT6-0004uU-W2; Tue, 02 Jul 2024 22:11:37 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpT1-0001Fg-W7; Tue, 02 Jul 2024 22:11:36 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-80fc4fe7a8eso87200241.1; 
 Tue, 02 Jul 2024 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719972690; x=1720577490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0624SED19MH2GAXvUspCZsb/HyW6e4GyU/sDf8pjYtA=;
 b=Hfo9wHScLZOndIn/Wm46OqeR+mG5p1C4ONtn6NgaYL42o+nZ8+X4lIcL5A243VWVe6
 zcgYMkKPvpg79cwtfaj8JdyEL4Yxe0Frqs6o0fN2XifKCK2Mc0UKO6zz1ExcmDcQyfMI
 +tiiDctFNAy3vEn8W4X/aMGTwqCiKiGK+bZ/b4LT+Vy5a+WlqesAbUsDRs//ADyKDKD2
 F/2EqKAVoX2JTQnbEHfyt8Wh1buG4cT0i5cbz3EHpJlOdwqSts4z4nxEA6pfoh3HGPye
 ySpNu/i0K4vLH8wr/2bcQAKcMys6AQXKl9az1RRdult/HdqAphf1qvHmDmEvxtD8/brN
 26tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719972690; x=1720577490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0624SED19MH2GAXvUspCZsb/HyW6e4GyU/sDf8pjYtA=;
 b=T8DwDJxyiqTzLkQEOy55gyEvO3DsaxP7hWKeVDZzm9RMrbzHjoa1gHzn9zTQiO/XX4
 +b6vhW64VUNMDEFywMptOmvS8NIRExAloe8VxAEjyoqLamt1jEEy3Kk4aMJdOc2fWQ1R
 APlOwS1jUyKgsXVngCko2QLZ6WPFYl7fHDJain2S+N6UoMdqbsjfZi7MEQ9q4ruO5gTB
 J/sziRLGzRWvoQZS/nZ7sH1lB05swCndcxaaRamkk+0uZZgxEJC8dy/1l7CMLImxklDw
 02VUEG5CJQLedM6fJzR9qLrm+kMcyG2kHcllguQ5QnCNZnGSwf5XtwmpWIdmnA/nYeRj
 m2hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9N/jlhddfmaiEbfDHu6mkrp6wP98v13CzxG1n4CsmAMsfyuvmpfgU1vMcWve8gfYYyS3x2IEbfIjq0J2Uu7D4AP21Dmw=
X-Gm-Message-State: AOJu0YwFX6AfnAh8IM4PirR/muMGcJfk6LVpzGZrpc25VFqIljDw/w5u
 RNtX73Vb9xZwz+atpyTpuwEYWjBHeA35hsMCxT/z2oZ+YWWtuUr8namYB4UqqxAnug0XirHgSO6
 GgyByz34ol/goJgbc1a18ejQkOXwwq5GQ
X-Google-Smtp-Source: AGHT+IGcSz/NIXd/gxN4yZ3i8LrGaPZqJoo3AqMhOuyQIgL/wjgvMu2AtKsTD8gt3Xf20HpDU9V1Whnbm0tWrZOQdaM=
X-Received: by 2002:a05:6102:a4e:b0:48f:42a7:2c60 with SMTP id
 ada2fe7eead31-48fdf007718mr211767137.7.1719972690004; Tue, 02 Jul 2024
 19:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:11:04 +1000
Message-ID: <CAKmqyKOWWr1L4TokcQ0myQLexLO53G0XQ8O3xRbAU+rQ7T72_w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] target/riscv: Support zimop/zcmop/zama16b/zabha
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Jul 3, 2024 at 11:48=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> All the patches in this patch set have been reviewed or acked.
>
> v2->v3:
>     1. Add review tags.
>     2. Reword the patch 10 in commit log
>
> v1->v2:
>     1. Fix the isa orders.
>     2. Make zimop/zcmop/zama16b/zabha depend on priviledged 1.13
>     3. Add review tags.
>
> The v2 patch set is here
> https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00489.html
>
> The v1 patch set is here
>     1. zimop/zcmop
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.htm=
l
>     2. zama16b
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.htm=
l
>     3. zabha
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00214.htm=
l
>
> LIU Zhiwei (11):
>   target/riscv: Add zimop extension
>   disas/riscv: Support zimop disassemble
>   target/riscv: Add zcmop extension
>   disas/riscv: Support zcmop disassemble
>   target/riscv: Support Zama16b extension
>   target/riscv: Move gen_amo before implement Zabha
>   target/riscv: Add AMO instructions for Zabha
>   target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
>   target/riscv: Add amocas.[b|h] for Zabha
>   target/riscv: Expose zabha extension as a cpu property
>   disas/riscv: Support zabha disassemble

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  disas/riscv.c                               | 183 ++++++++++++++++++++
>  target/riscv/cpu.c                          |   8 +
>  target/riscv/cpu_cfg.h                      |   4 +
>  target/riscv/insn16.decode                  |   1 +
>  target/riscv/insn32.decode                  |  33 ++++
>  target/riscv/insn_trans/trans_rva.c.inc     |  51 ++----
>  target/riscv/insn_trans/trans_rvd.c.inc     |  14 +-
>  target/riscv/insn_trans/trans_rvf.c.inc     |  14 +-
>  target/riscv/insn_trans/trans_rvi.c.inc     |   6 +
>  target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++
>  target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
>  target/riscv/insn_trans/trans_rvzcmop.c.inc |  29 ++++
>  target/riscv/insn_trans/trans_rvzimop.c.inc |  37 ++++
>  target/riscv/tcg/tcg-cpu.c                  |   5 +
>  target/riscv/translate.c                    |  38 ++++
>  15 files changed, 531 insertions(+), 50 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc
>
> --
> 2.25.1
>
>

