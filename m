Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A67C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1IAc-0003y1-Mp; Sun, 28 Apr 2024 23:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IAb-0003xj-8B; Sun, 28 Apr 2024 23:59:13 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IAZ-0000pK-FO; Sun, 28 Apr 2024 23:59:12 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4dcc7c1055bso1209445e0c.0; 
 Sun, 28 Apr 2024 20:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714363150; x=1714967950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugfN/k1w62oyHRFJ6i8Fh1SgrVuhil+rU8X+1uM7s4A=;
 b=f1rEp7Hs8GtXictuWjDO2MSBVa1pLhy4M3vz4x+Dgkr4SQB4JefmKSMD0WkCL06lGd
 1LZ9vj0va73FnlksBLHXXlvoohqBrGlEYmCJEIU2oBP71QpQDbLgaO0CoLEqJJT9Iqhf
 3qCwlK8uuRQwNS4Nn7IW6bMZBWneZ3UwOOdArPG/uWR9yumufcRmgWfk/mnHqlrfa46G
 l1CH2UvPOWd5Y1TSYnwP5j+dxA4g/8pf3XNikQA9NqJwnWaK+dlG/EXVrQAQFlCbcIO+
 8wyv4/QeILHTkmZFo4J7GoEeMQ8dt18vYF2R/s1o7vkzUihUDYTU3a2vHspKZgMy3hUT
 1H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714363150; x=1714967950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugfN/k1w62oyHRFJ6i8Fh1SgrVuhil+rU8X+1uM7s4A=;
 b=se1A4nVuOBSXz/iQhlVEqgBViH/gP9GkAeJ4BycKPOdL7CSICnyeYYtMslIUdCG/S9
 +ygNx310SNfnTp07Ov2dbuZOjv4UBDIokbcMopBXc+XyuNVWg82Saar8q90Ol+X7J7x9
 aY0To4eWNgKOEZsdTla1gWnwxonszzOc21Qklox3PSdTYTiLYUxZKyKuXcV/10GLrWfE
 Gd0olbvlqcFN5GYzDMyWuRf07lys2RcO0kknTdTaHE7/+gAjevYhGAml2K9+fIes1Fbp
 CQHtIPJBhLdg2BbZg/YwmPfc2UEVVmVlGkxxflSE9ibN7t7LKj6g9nuFMKgI8q4EgMr9
 R/2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6S1Gq0oVww/UesePsafRPWbTf9dlIY1kfF1DDFZCWidGCQIenbr76tICErk4/DZ/fFVDwV1gU+Va90FeytpsxifQzkK8=
X-Gm-Message-State: AOJu0YwYQi75Bpbk7039f2LhiQJOhIG6dloxJggq+wIRalhVl9dcSgU8
 dqdmDVpovOyozI5tYQ6YIWSCB+3sa8WdRyB2j8RwqVmMUPhCgppyMABsFVK9NpHrnD95PVO9QRC
 HC6emlKqqjSPOzpps+TlvuVmgJyU=
X-Google-Smtp-Source: AGHT+IEqAeyqbgqPBn1EKYlGGQxxmmMmDsKL+VQNd1kJJU/CDB7Hx4pY5vcnil0cWCFItcoFVqGUjSMK03XDG9aVLRI=
X-Received: by 2002:a05:6122:1789:b0:4d1:4e40:bd6f with SMTP id
 o9-20020a056122178900b004d14e40bd6fmr10243709vkf.10.1714363149799; Sun, 28
 Apr 2024 20:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240403070823.80897-1-yumin686@andestech.com>
In-Reply-To: <20240403070823.80897-1-yumin686@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:58:43 +1000
Message-ID: <CAKmqyKNX5+4yCrBuusaZ+-+h0k_kBV0i8vCFBCz2HBq=cTicKA@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
To: Yu-Ming Chang <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

