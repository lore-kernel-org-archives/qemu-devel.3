Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D8FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 04:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQfZK-000123-Qq; Mon, 08 Jul 2024 00:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfZH-0000xI-GE; Mon, 08 Jul 2024 00:01:35 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfZE-0005Th-Uo; Mon, 08 Jul 2024 00:01:35 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4f2f24f6470so1098045e0c.1; 
 Sun, 07 Jul 2024 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720411291; x=1721016091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IgqoEwgv+DINvQ6vAi3HF5PHgWJa35xvqdZD/FL0eY=;
 b=ienZc6GIckm/g11f5xQi6SUL8zwf37yXrcldRV9b+ueauKHn8rp8lkXPsygcoweB5X
 BXfQdAD+vP+lOyKcnYHd/2e+xAULm9/pFrsJ+6ap0jONqJpYxzp1rBWuxyAfQB4SVDXC
 gNv9VCoyacrkEQNyAyJm9QxB2IxjmTQRFBw0XX32L4VblFH1DtJtt2KI+ci2hvCZFS9K
 Y1+FpAlQxXwl+Ptid7l/jHpbsFiL+S+buDeufAXACVzMF5mNR+xVVnvr/15s8KOYXnpN
 /EtxrJ/KZi8VUB6R7awQ0AF69My5GdMIsFbnden2Tr48sUjlC2nDb9dNR1jrRKATHshM
 j8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720411291; x=1721016091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IgqoEwgv+DINvQ6vAi3HF5PHgWJa35xvqdZD/FL0eY=;
 b=hE1IpEdzs65qmCHoG0QH89j3+pj5iJdrDTUSF/x20vWXkh6g9QBVN/J+uKKUjg0pvF
 +a77iDip//od24cMOpEmzkq5qCkoW8hitKfDLShesM8WPhA++0gHEhJwYgKqEnxD8Yp6
 Cr1FRENTXNnjQSf1ylAeXqKT/4dUlqEQ9Wuh4GESG5+w10FKh/9pQfk4ng36hb3TYZNm
 pCIi5Yh72w7rDn7xPemnM1Hck2+k0xSjC2xYWkWU6r+UfPVDv2QQYc7ydQ4EwXzqM7nB
 aqsw6DQY2y4CG86c1fvqiFjAPuZBkA9vJ83C81XIdgzv/16+7V5sXptXjqzWbuLqk3sO
 6Iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNywBu1PpsC7m6OhjWJHuCdW0aOZB3uI3EwGP85H4JDt4f/Sjwvp5AWg+qpA/+O62tfNgWGgda561uwMDciG6wOvVkzBc=
X-Gm-Message-State: AOJu0YwkfWahlBgKaSzME4zjsieYHW16RPms2AjgyFFzAoZJArKAGk/f
 WuJqTlnygYFpbl0JWz3T4rwTF+08o4qhukT0YlHWuB5yrQ6Is38k/L8/yGnn/J7F+AAT2cdPmlr
 LePH9EHvf2dOp04qjxozJCl/OBKQ=
X-Google-Smtp-Source: AGHT+IEc0zDtcRHh2+ngazxUiO6pALfm6uI9kIik4lUk/Ej/3h+4csYyU5910hARyA36PmIPNVwiGaLFKN2LP4Y8jV0=
X-Received: by 2002:a05:6122:4891:b0:4ef:6618:fd5c with SMTP id
 71dfb90a1353d-4f2f3edf456mr11772668e0c.3.1720411291165; Sun, 07 Jul 2024
 21:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240604090434.37136-1-yumin686@andestech.com>
In-Reply-To: <20240604090434.37136-1-yumin686@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 14:01:05 +1000
Message-ID: <CAKmqyKOZ=MRQOkB8C4Ofe5WER2in4_zG9pzW8AEzzkYM8ca-Jw@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
To: Yu-Ming Chang <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Alvin Chang <alvinga@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Tue, Jun 4, 2024 at 7:15=E2=80=AFPM Yu-Ming Chang via <qemu-devel@nongnu=
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
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Hi Alistair,
>     This fixed the issue of riscv_csrrw_debug().
>
> Best regards,
> Yuming
>
>  target/riscv/cpu.h       |  4 +++
>  target/riscv/csr.c       | 57 ++++++++++++++++++++++++++++++++++++----
>  target/riscv/op_helper.c |  6 ++---
>  3 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2d0c02c35b..72921bafc0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -708,6 +708,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *=
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
> @@ -740,6 +742,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVSta=
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
> index 726096444f..aa765678b9 100644
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
> @@ -4518,7 +4561,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *en=
v, int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D true;
>  #endif
> -    ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
> +    if (!write_mask) {
> +        ret =3D riscv_csrr(env, csrno, ret_value);
> +    } else {
> +        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask=
);
> +    }
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D false;
>  #endif
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

