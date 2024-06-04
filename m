Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC15C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJQ9-0005wp-5x; Mon, 03 Jun 2024 21:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJQ7-0005re-H3; Mon, 03 Jun 2024 21:57:03 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJQ5-0004Tt-VT; Mon, 03 Jun 2024 21:57:03 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-80ae09dce7eso168414241.2; 
 Mon, 03 Jun 2024 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717466220; x=1718071020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySfa1CDkr0sLjP7zH5puGDrbClQ4fIy+R9Wm2VOGKR4=;
 b=VJ0gPn6+YFGnsNn7NFQ4OqBa5onGvXEZgsTWdOiHQotZ/S7+F5dC+YLxSEDP8aLXi6
 jZt9f4RFsGhZG/mBhXiJpMR2HgHpjEZV0HAdgbk269UIrmFX3Is3h0mzIa3EBbXCUP3w
 JQbc09R56eh6+9XB8W6Zjn0+AGVVdS+NVA6fVNbS4sTUOt/gqAYLDnPJD12RPwhxGCtA
 l0tltP4xQN5h8ELh1anTfoFGTseEf3mIZvkEdQTouTzv0AU49LH6hIsRaaBaUHDlWe6Q
 1XbftAOz6tfNEzzqtSpiOz2TDHGBIa+dJ5AQfW89sasNRtRXj5sco6ljZutyRTP0uSgh
 bj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717466220; x=1718071020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySfa1CDkr0sLjP7zH5puGDrbClQ4fIy+R9Wm2VOGKR4=;
 b=bniawz+FGgrrDE1AbXisvrk6EomBet0lsB1vbvwwiHsBN/vj2oc6pQesajngib1d7Q
 g4gCiaVUz3gzfKvQmj3bAbcbXvFL6wkOmPy+h0XvS//4vFkOZjSTpjRkJwS9Uoa9PSsJ
 mjGDcCsuUnvXW6ME0IXTyUODi9nMxF+/AAegs+kY06ZXFK9FoxNJ8BnAAYX55+6RI7B+
 J/hHyTGwkCqngvZwxRPyPaj1+bjyQS4SuhbkK5zVMp5f+oGrAKLo0/p9Gc17U6uFLPpP
 N9mrUasDWa+Jh+nsSTX62HbbQbHsrSph7PVe9l0QhNjByEkr0u0R8OM6mW3PHu+hRCse
 Ihhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEs8UlehtY3EG5apUKjTU28LCpMfNYne2vRdBXRAgDVh3lT77Mv9KFgqguY99JdEZUBHqa7KrcRI9T5mueuedYz0O2ELA=
X-Gm-Message-State: AOJu0Yzh0uVPstfl05AF7btfFCI4T0Sh0HcO/KvlLQAUS+YD8lepv/bI
 RXnluEqEtXEz4b/qenPQZs9Y8oXO1tQPMq2J9xGGmNBugTT0Oj1kgoz7aVHSh5JJOxq28fwCWm/
 wi37D4q1yT3BkyfhhSCO8Nynt+qE=
X-Google-Smtp-Source: AGHT+IFbk+yafazl/sYZI/ewoTuvuJ7udH85/8RNvqBeNeX5M0MukuoeIhw5JmcB8lN3BH9li9YwXqznb01Cw33pEbw=
X-Received: by 2002:a67:c788:0:b0:48b:a903:bdbc with SMTP id
 ada2fe7eead31-48bc22d8bcamr10542449137.28.1717466220409; Mon, 03 Jun 2024
 18:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240520125157.311503-1-rkanwal@rivosinc.com>
 <20240520125157.311503-3-rkanwal@rivosinc.com>
In-Reply-To: <20240520125157.311503-3-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 11:56:34 +1000
Message-ID: <CAKmqyKPaRyh4vM0UgT4iDmDvJKYk1wxwLsz3Sj9PNFvqO_JMjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Move Guest irqs out of the core
 local irqs range.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Mon, May 20, 2024 at 10:52=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
>
> Qemu maps IRQs 0:15 for core interrupts and 16 onward for
> guest interrupts which are later translated to hgiep in
> `riscv_cpu_set_irq()` function.
>
> With virtual IRQ support added, software now can fully
> use the whole local interrupt range without any actual
> hardware attached.
>
> This change moves the guest interrupt range after the
> core local interrupt range to avoid clash.
>
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ fi=
ltering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ f=
iltering support.")
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 3 ++-
>  target/riscv/csr.c      | 9 ++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..a470fda9be 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -695,7 +695,8 @@ typedef enum RISCVException {
>  #define IRQ_M_EXT                          11
>  #define IRQ_S_GEXT                         12
>  #define IRQ_PMU_OVF                        13
> -#define IRQ_LOCAL_MAX                      16
> +#define IRQ_LOCAL_MAX                      64
> +/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>
>  /* mip masks */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 152796ebc0..464e0e57a3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1148,7 +1148,14 @@ static RISCVException write_stimecmph(CPURISCVStat=
e *env, int csrno,
>
>  #define VSTOPI_NUM_SRCS 5
>
> -#define LOCAL_INTERRUPTS (~0x1FFF)
> +/*
> + * All core local interrupts except the fixed ones 0:12. This macro is f=
or
> + * virtual interrupts logic so please don't change this to avoid messing=
 up
> + * the whole support, For reference see AIA spec: `5.3 Interrupt filteri=
ng and
> + * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupt=
s for
> + * VS level`.
> + */
> +#define LOCAL_INTERRUPTS   (~0x1FFFULL)
>
>  static const uint64_t delegable_ints =3D
>      S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
> --
> 2.34.1
>
>

