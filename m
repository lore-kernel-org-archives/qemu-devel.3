Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A59C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HO1-0004hj-PQ; Sun, 28 Apr 2024 23:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HO0-0004h3-0Q; Sun, 28 Apr 2024 23:09:00 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HNy-0000vo-7X; Sun, 28 Apr 2024 23:08:59 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7eb7f34f36dso1986997241.1; 
 Sun, 28 Apr 2024 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714360136; x=1714964936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqBAujBgXntBxHhe5GHfg6HbCV9UNDqe943PsPJ41pc=;
 b=NUAEz5rqDMcYpXBPsr0S8M/T62Uuy0llGmjpGAo1ce9vud5DmJgVOZY1NZYO8gZ7AR
 QXltyZyPfh7lTvgZKgRndBhkh5oSIj7dz9z/Jlz9jRjVujc5VAvk0zKvDKfoBFtZ759V
 jldZmRw0rvnlGXNSKy1nZCILRzQHqFd+Ug+4Hwa+wmHB+PPVgiq0jX32Z1/zJ2n7x36n
 rzWNrv4BLLhY2UZjSdAqJq0KHAKWB2C8NFSCWc2s4OiVQq8pe/Yi6uokPSuqMwx9R2DM
 BdfOGFxxXDM6V57PlBnUSllJh5lHzk7B95UTY8a30rcHmmBGTDkZVZ1YEtkKGRuIcri9
 v/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714360136; x=1714964936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqBAujBgXntBxHhe5GHfg6HbCV9UNDqe943PsPJ41pc=;
 b=Ludl3U7TgIdnBzBSFMgaVkv11xBfDTycIUNGpJOMokmUWo1nZIBp261Zb4+PI/DBGl
 ZStLlypKa4lS9/6NornVTLSIN95ZCFXeERhaOWVzp1YWRkq/6jsToeLmsYgWavpskzJi
 +z4zv5ZLcyFAb2PkjWZjh5E24kELmBZrqgCyQyUFqGKfRo+bIPuKmQuyqfrJ80ZYTcn+
 M7R31ZCkml/1aYt3qQav43BtmG1SQmcDNqYF1eEVM9euJxm/YwQt6BCpUzPz18j9f0a2
 zq66+va3xvmHXbzMMDCVERsm417S54JhXdWJHf6tWfkVCYp5OzcF5Aulz0G1NvuImISK
 nskg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6YgS18z0Q1icWMGKkWXuSIlVWTQ0Rb2RUiWWPYlt1nLFO8UhND4rGs1QXdaUjOt412mkAJL+c+mG295DgU/ng7F1wOtQ=
X-Gm-Message-State: AOJu0YyIe/4nRKgnDRo6pkzbdP+VJn1aaOf2rrgCG03oQ5r1rC2FyVoQ
 O4r40JTVqAePb8rA6h/8BaIR6Ud42KXNCT5poRE7TASLS4hVWpLzrnJ6T8zwcomIVTMIT8hUHnH
 7LjXlyNUoSCLVlOiUXOIZD1Yro8I=
X-Google-Smtp-Source: AGHT+IGP15IBwMpgJBhRwSZr1La+OSTp69IAsMIDO0hrGXcE3jY9rzywq4YCR9qVhKEr39e2vNh0OkYNs9nofB3CXrE=
X-Received: by 2002:a05:6122:a22:b0:4d3:35ac:3553 with SMTP id
 34-20020a0561220a2200b004d335ac3553mr8700859vkn.10.1714360136180; Sun, 28 Apr
 2024 20:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
 <20240416230437.1869024-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240416230437.1869024-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:08:30 +1000
Message-ID: <CAKmqyKM2vNM6s-n-=15dirJi_VN8bivnkLD+v_=E4sDu9vvrnA@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v3 1/2] target/riscv/debug: set tval=pc in
 breakpoint exceptions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Apr 17, 2024 at 9:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're not setting (s/m)tval when triggering breakpoints of type 2
> (mcontrol) and 6 (mcontrol6). According to the debug spec section
> 5.7.12, "Match Control Type 6":
>
> "The Privileged Spec says that breakpoint exceptions that occur on
> instruction fetches, loads, or stores update the tval CSR with either
> zero or the faulting virtual address. The faulting virtual address for
> an mcontrol6 trigger with action =3D 0 is the address being accessed and
> which caused that trigger to fire."
>
> A similar text is also found in the Debug spec section 5.7.11 w.r.t.
> mcontrol.
>
> Note that what we're doing ATM is not violating the spec, but it's
> simple enough to set mtval/stval and it makes life easier for any
> software that relies on this info.
>
> Given that we always use action =3D 0, save the faulting address for the
> mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
> used as as scratch area for traps with address information. 'tval' is
> then set during riscv_cpu_do_interrupt().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 1 +
>  target/riscv/debug.c      | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fc090d729a..f9c6d7053b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              tval =3D env->bins;
>              break;
>          case RISCV_EXCP_BREAKPOINT:
> +            tval =3D env->badaddr;
>              if (cs->watchpoint_hit) {
>                  tval =3D cs->watchpoint_hit->hitaddr;
>                  cs->watchpoint_hit =3D NULL;
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..b110370ea6 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  if ((ctrl & TYPE2_EXEC) && (bp->pc =3D=3D pc)) {
>                      /* check U/S/M bit against current privilege level *=
/
>                      if ((ctrl >> 3) & BIT(env->priv)) {
> +                        env->badaddr =3D pc;
>                          return true;
>                      }
>                  }
> @@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                      if (env->virt_enabled) {
>                          /* check VU/VS bit against current privilege lev=
el */
>                          if ((ctrl >> 23) & BIT(env->priv)) {
> +                            env->badaddr =3D pc;
>                              return true;
>                          }
>                      } else {
>                          /* check U/S/M bit against current privilege lev=
el */
>                          if ((ctrl >> 3) & BIT(env->priv)) {
> +                            env->badaddr =3D pc;
>                              return true;
>                          }
>                      }
> --
> 2.44.0
>
>

