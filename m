Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B8BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTdf-0006zm-E4; Wed, 14 Feb 2024 23:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTdb-0006zU-Fy; Wed, 14 Feb 2024 23:46:19 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTdZ-0004nA-K1; Wed, 14 Feb 2024 23:46:19 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7d5c2502ea2so186458241.1; 
 Wed, 14 Feb 2024 20:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707972376; x=1708577176; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvMSvldopSxSpl9QKeVv/HiUEk9WsSBbTymVvGscpQ0=;
 b=c3k+o+WcdQatjvG8Anbx3/piv7A1iAquda2aJUlmx/+83sAMnK3CLVVMdtCa2OLhQW
 QP+hYDPUk0+NsCTTrGRy73v85Pmqrx//E9EeT3uJsqCs+VCsKX7uxEE4F5p6HP1evf1m
 YNFAIu6FoSPxAnpr5zQU10fVpGDUFQRDXAVv13ZiFlpg4Ris4tvd6M2CAUBECCLf28hv
 D3cup5AralarPgMHkGl87IMX0DieEf83JwK+VnrtSK6GzYoJfkw+C1uGB7bYk9xXcp+s
 Vyx1VVd6R8vtY61npdyH8xFvagUQP5YXtgTr5hrS/pGosFpev5XZhshQjFTWMefOJ67M
 A99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707972376; x=1708577176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvMSvldopSxSpl9QKeVv/HiUEk9WsSBbTymVvGscpQ0=;
 b=hFDAsrlI1PRFQsxrSb8oruEUydGW98g+OvSX+TGnQiZO4Vo3RNYwsbvImydqMlP27O
 nKEyqA5u0uTePkVqmxSdRhQ1BUZl9ZEDSBEEmWJkYMOhfD2mOauUT0xYBuq3OBzY6zXA
 qoLpyNRHwPrCTd9/exMw0K1B7FSw0787ZPHCP7tvjJQNoBNt046kZnW4aXB5fQd2/gpX
 ARssiNceXr4GelWoBGKFXCgKW8iiNnkAbg1r2CEvkhHZ1HnoGR8howLVNviaLDaLR1Lx
 0WZ7JlqBTfARh9DrVJyLo9xZeurTkiNBlVG8wivFVDEYNpBklhYLSASyvD80lfzHxawC
 tQIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV5uA59c2jkYqRXdGnQr3I9uMb1a2eXPZ6bxostduodQO+5mUJBtVaLLzztrO60Nxruyx37prbdm+G7hoXNhOvbEhQvNjGNm77Zj/4jMyhsTpd/pVNhlMLvg1sxA==
X-Gm-Message-State: AOJu0Yw334ETIKCMLwXCMg85EUpFoYgX+9uoxbQhSKXbFbfCWSvIPvxM
 KAbGdHlT0Sv82d1s1McslzNIJDIDMOXUPLEAbgjoFOJnTk+fc85B3xbFZ1wVrkOTFaDXpqJKZ6g
 sUf84HW2lwbC3QZXxKbPlW5kYpGg=
X-Google-Smtp-Source: AGHT+IHiK2c+b+EDVh99ow1b+C9gS4tqY64aadpUoRy9NzFnypm/DC1lZi4y9DwXZ2lCJTORHUu3dq1LffL48PZ/7EQ=
X-Received: by 2002:a05:6102:2c6:b0:46e:dd76:9ff9 with SMTP id
 h6-20020a05610202c600b0046edd769ff9mr797032vsh.5.1707972376174; Wed, 14 Feb
 2024 20:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20240109002554.646572-1-atishp@rivosinc.com>
 <20240109002554.646572-6-atishp@rivosinc.com>
 <CAKmqyKM2j=zeEObQuf+8kB78Ko3A-aaWBLpb24O0YVjg_FHcRA@mail.gmail.com>
 <CAHBxVyFC40ChLFXF2mDJLcs-J8sdrOk_fZP0K32Maf0DhOu6Zg@mail.gmail.com>
In-Reply-To: <CAHBxVyFC40ChLFXF2mDJLcs-J8sdrOk_fZP0K32Maf0DhOu6Zg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:45:50 +1000
Message-ID: <CAKmqyKPwD0mmLmnG7hCW9CUNHv_yKU=ph-7ejAZxebYWr9hgCg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Wed, Jan 24, 2024 at 10:15=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc=
.com> wrote:
>
> On Sun, Jan 21, 2024 at 9:04=E2=80=AFPM Alistair Francis <alistair23@gmai=
l.com> wrote:
> >
> > On Tue, Jan 9, 2024 at 10:29=E2=80=AFAM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > Privilege mode filtering can also be emulated for cycle/instret by
> > > tracking host_ticks/icount during each privilege mode switch. This
> > > patch implements that for both cycle/instret and mhpmcounters. The
> > > first one requires Smcntrpmf while the other one requires Sscofpmf
> > > to be enabled.
> > >
> > > The cycle/instret are still computed using host ticks when icount
> > > is not enabled. Otherwise, they are computed using raw icount which
> > > is more accurate in icount mode.
> > >
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  target/riscv/cpu.h        | 11 +++++
> > >  target/riscv/cpu_helper.c |  9 +++-
> > >  target/riscv/csr.c        | 95 ++++++++++++++++++++++++++++++-------=
--
> > >  target/riscv/pmu.c        | 43 ++++++++++++++++++
> > >  target/riscv/pmu.h        |  2 +
> > >  5 files changed, 136 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 34617c4c4bab..40d10726155b 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -136,6 +136,15 @@ typedef struct PMUCTRState {
> > >      target_ulong irq_overflow_left;
> > >  } PMUCTRState;
> > >
> > > +typedef struct PMUFixedCtrState {
> > > +        /* Track cycle and icount for each privilege mode */
> > > +        uint64_t counter[4];
> > > +        uint64_t counter_prev[4];
> >
> > Are these two used?
> >
>
> Yes. That's where it tracks the current/previous value cycle/instret.
> riscv_pmu_icount_update_priv/riscv_pmu_cycle_update_priv
>
> The priv mode based filtering is enabled in riscv_pmu_ctr_get_fixed_count=
ers_val
> using "counter" afterwards.

Ah! Yeah sorry was not reading this correctly

Alistair

