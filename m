Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6AFC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0Q4-0004YI-0q; Mon, 03 Jun 2024 01:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE0Q1-0004XO-04; Mon, 03 Jun 2024 01:39:41 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE0Py-0003h7-Sg; Mon, 03 Jun 2024 01:39:40 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4eb14d993c6so334229e0c.0; 
 Sun, 02 Jun 2024 22:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717393176; x=1717997976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpaNIvgmXaMoxkZs4RTo2kXjPZIjPrpWne//4kxJh5Q=;
 b=ipfeeatsdhluQIngBMooGqqbGXE7LgdQ07PLxBfBE8V+B2VEogt/d+dJppPFuDtigU
 nBrI0YRXYd7DbVdP/eoSyskLwBwoxxnqEZXJGCQ1yazx/F4YjYhVN2R2i07DRJfz4HhR
 gur+Yb5aW784Nmq2vqg0F7v0IF9wHBd8wpHz5FrOfLaHm1IRiiuY1uwxUtmFWHH8xU+D
 CWY84yU186JSVUv9moog5RWfY+YoDQOAImh08nKmjE+d0WXAFZa+yAzyoAgk26RUb63t
 GLqMjiiRTWK9cvbsLxIMe0KxROKCg4xC+AHwoAMI6pzstEYaZad3C1QwOjseqmQ2R+po
 D5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393176; x=1717997976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpaNIvgmXaMoxkZs4RTo2kXjPZIjPrpWne//4kxJh5Q=;
 b=ABKSFQvwCrf66l9KTjiMIaEhrZ/U3PwNPMgh40uW6yF9kNA70w/xdtSrDonJam+8Ae
 PMwOz2UziXE8M2Pp8RCtN6rj689lyKIg/28MX8IntuidhRDkl5RZjDB9eKQZi7f3wm6p
 quShmJBg2E4U2Gd16a444miOAeWgF4RuLaWIXYONGQ+HHssREWCH2e2glsig179M/Yt2
 XaQ01l7rMDIygSDLyHzrCg3nrrjp7KP0ZtGZG/xd7WwTV1M5s831PUfKWVgtx98u7qTQ
 szWG7vVYfdDwUgq5tgRkZeTtKFizdeMwCycQLxjMJeV52TuQA8lHVW1SW6p5sF3earGu
 dhTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb8lVqFuHh8exPZPsTFV9V73q3QXH6jf2frMMEKxt9W4+E50T/Y3Pos0VYP5Jmf7/93A5q5OA9SnQdjBjsMdB4jq9+1Ck=
X-Gm-Message-State: AOJu0Yw1/bnEtz3SZVS3A7F72OKnroQif81hC2ntibqMxEkIOJMTOYOq
 ek1LdhdII4UDc3Onn2EIyqIj3NYdekNPasLWXusf0q8ErvF4t57nQs8IMbiYZCnJlhTDAp//HPt
 QEobg/8Tx+g5dFSIrHsqCu4KPgQI=
X-Google-Smtp-Source: AGHT+IEjjDIwLQzhl0iOImD8J5P/9urCGatyDz4hATafiild1NTs0aHQn2x0ue4OXbllNo9MvbsMF4ead2hiWOczHiQ=
X-Received: by 2002:a1f:ddc2:0:b0:4e4:ef76:3843 with SMTP id
 71dfb90a1353d-4eb02d6d349mr6873784e0c.2.1717393175423; Sun, 02 Jun 2024
 22:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240403070823.80897-1-yumin686@andestech.com>
In-Reply-To: <20240403070823.80897-1-yumin686@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jun 2024 15:39:09 +1000
Message-ID: <CAKmqyKPE2-4oys9tEGQy5UBQT=ppYFitqv3UCZ=gzoce8qtZ6A@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
To: Yu-Ming Chang <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Wed, Apr 3, 2024 at 5:10=E2=80=AFPM Yu-Ming Chang via <qemu-devel@nongnu=
.org> wrote:
>
> Both CSRRS and CSRRC always read the addressed CSR and cause any read sid=
e
> effects regardless of rs1 and rd fields. Note that if rs1 specifies a reg=
ister
> holding a zero value other than x0, the instruction will still attempt to=
 write
> the unmodified value back to the CSR and will cause any attendant side ef=
fects.
>
> So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specif=
ies
> a register holding a zero value, an illegal instruction exception should =
be
> raised.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>

This fails the GitLab CI tests

https://gitlab.com/qemu-project/qemu/-/jobs/6953349448

ERROR:../tests/plugin/insn.c:58:vcpu_init: assertion failed: (count > 0)
timeout: the monitored command dumped core
Aborted
make[1]: *** [Makefile:178: run-plugin-catch-syscalls-with-libinsn.so] Erro=
r 134
make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56:
run-tcg-tests-riscv64-linux-user] Error 2

#0  riscv_gdb_get_csr (cs=3D<optimized out>, buf=3D0x5555558e7f50, n=3D3072=
)
     at ../src/target/riscv/gdbstub.c:183
#1  0x00007ffff7fb7841 in vcpu_init (id=3D<optimized out>,
     vcpu_index=3D<optimized out>) at ../src/tests/plugin/insn.c:57
#2  0x000055555569ef1a in plugin_vcpu_cb__simple (cpu=3D0x5555558fb820,
     ev=3D<optimized out>) at ../src/plugins/core.c:111


After

182             result =3D riscv_csrrw_debug(env, n, &val, 0, 0);

result =3D=3D 2.

I haven't had much luck reproducing this locally, so I don't have a
great idea of why it isn't working. I suspect you need to ignore the
checks for debug accesses

Alistair

> ---
> Hi maintainers,
>     Do I need to make any further improvements to this patch?
>
> Best regards,
> Yuming
>
>  target/riscv/cpu.h       |  4 ++++
>  target/riscv/csr.c       | 51 ++++++++++++++++++++++++++++++++++++----
>  target/riscv/op_helper.c |  6 ++---
>  3 files changed, 53 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b944..99006bdb45 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -710,6 +710,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *=
pc,
>  void riscv_cpu_update_mask(CPURISCVState *env);
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                          target_ulong *ret_value);
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk);
> @@ -742,6 +744,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVSta=
te *env, int csrno,
>                                            target_ulong new_value,
>                                            target_ulong write_mask);
>
> +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> +                               Int128 *ret_value);
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
>                                  Int128 *ret_value,
>                                  Int128 new_value, Int128 write_mask);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..35662e1777 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4312,7 +4312,7 @@ static RISCVException rmw_seed(CPURISCVState *env, =
int csrno,
>
>  static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>                                                 int csrno,
> -                                               bool write_mask)
> +                                               bool write)
>  {
>      /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fail=
s */
>      bool read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
> @@ -4334,7 +4334,7 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>      }
>
>      /* read / write check */
> -    if (write_mask && read_only) {
> +    if (write && read_only) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> @@ -4421,11 +4421,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVSt=
ate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                           target_ulong *ret_value)
> +{
> +    RISCVException ret =3D riscv_csrrw_check(env, csrno, false);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
> +}
> +
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk)
>  {
> -    RISCVException ret =3D riscv_csrrw_check(env, csrno, write_mask);
> +    RISCVException ret =3D riscv_csrrw_check(env, csrno, true);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> @@ -4473,13 +4484,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVS=
tate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> +                               Int128 *ret_value)
> +{
> +    RISCVException ret;
> +
> +    ret =3D riscv_csrrw_check(env, csrno, false);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    if (csr_ops[csrno].read128) {
> +        return riscv_csrrw_do128(env, csrno, ret_value,
> +                                 int128_zero(), int128_zero());
> +    }
> +
> +    /*
> +     * Fall back to 64-bit version for now, if the 128-bit alternative i=
sn't
> +     * at all defined.
> +     * Note, some CSRs don't need to extend to MXLEN (64 upper bits non
> +     * significant), for those, this fallback is correctly handling the
> +     * accesses
> +     */
> +    target_ulong old_value;
> +    ret =3D riscv_csrrw_do64(env, csrno, &old_value,
> +                           (target_ulong)0,
> +                           (target_ulong)0);
> +    if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
> +        *ret_value =3D int128_make64(old_value);
> +    }
> +    return ret;
> +}
> +
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
>                                  Int128 *ret_value,
>                                  Int128 new_value, Int128 write_mask)
>  {
>      RISCVException ret;
>
> -    ret =3D riscv_csrrw_check(env, csrno, int128_nz(write_mask));
> +    ret =3D riscv_csrrw_check(env, csrno, true);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdb..b95d47e9ac 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
>      }
>
>      target_ulong val =3D 0;
> -    RISCVException ret =3D riscv_csrrw(env, csr, &val, 0, 0);
> +    RISCVException ret =3D riscv_csrr(env, csr, &val);
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> @@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
>  target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
>  {
>      Int128 rv =3D int128_zero();
> -    RISCVException ret =3D riscv_csrrw_i128(env, csr, &rv,
> -                                          int128_zero(),
> -                                          int128_zero());
> +    RISCVException ret =3D riscv_csrr_i128(env, csr, &rv);
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> --
> 2.34.1
>
>

