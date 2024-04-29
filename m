Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43927C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GWH-00060E-BV; Sun, 28 Apr 2024 22:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GWF-0005zj-IX; Sun, 28 Apr 2024 22:13:27 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GWD-0000Vl-Om; Sun, 28 Apr 2024 22:13:27 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47c51dd3c97so200262137.2; 
 Sun, 28 Apr 2024 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714356804; x=1714961604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrYy9AXlgOHtsTvpmL1ONf4rVXx9K2eqdYPw7UNaXao=;
 b=m3O37btIH/EGjTBNNW2nrxy6nsjn4ve0hGrfzkZy7KxgYndV9HZyUZ0g29JPipFPea
 +FfwL10cMpbMOJ9KVwO+pA58t6/Dp1ZlyW4ZbGojOHGH0pEL8B8kbCa7G+a3gjSwU+KG
 bXc6YgG0kINom4sPAHOf4gSoyd2sQRFeDIDScyW937CsIbdNPIkoJBEQssWodeWmo8nN
 0iuloVaIR+zIW8CyNCJ79B7tlGSsWznxfbpyonSTWmZjdoc923KD2sav6iwJF6n/dRgM
 BlUHxdMaiLRCLF5OCN+dJsw5pDIYw+RfRpwZDOdQ6hpIPtlZd1GUe5V2UmLoX4PB2pND
 4acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714356804; x=1714961604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrYy9AXlgOHtsTvpmL1ONf4rVXx9K2eqdYPw7UNaXao=;
 b=cyizt5laeVg68Q0S9rrTrrm27TX5d7t/RZqiyZXC71xF3AloMi++s+wUzB/pXsCg3X
 fJU8e+M1VTN4v50XZzvbF0LFzyWzC6YXY4MsSj15Hgn/iSnhzO498ROekeZeyrDvC99D
 +zKbmUDRyUy04eWyBzUebEa638iK2KIAxW2MGGU0rql27RzbA0qpOddAsK47aFqxQJrJ
 ZMJ0PownW44aF7x4QmKz48TK+cqvqV55A9jcn2gunFNRa/9pgiTIeR3uf7rtH7HtiZIH
 ilzmLDypiIfmV3lbh36bBZtAur59x1zmZKSRRPX24yvrZmWNkNqbArEWCLaGKuFDuoEW
 vCIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+eryPrNn1HgGBhCxW58b0K1FqIdhQx1xkkr+Vman+4pzevbZ8Y+qYuymll84ibbhSLMbn1hcELhKWC6CkegY9T4Xcjgk=
X-Gm-Message-State: AOJu0YzCJeGgHX1mLWyhwYlscmq06QqLR14iGNi8a/29B9JpqhCg6MYB
 Zcarfi9MTM2JqZsg06guZ78Ma2LXietV5gYn8SolyG3rpR6CZIruMRXhzYvCGyjezqpxq1B+efg
 QVP/a+dTbCXStvtCf+dNHmLAghl1tTk06
X-Google-Smtp-Source: AGHT+IGSv4/KthP8x2z4eYtETf34NnDmFyB5SgAqXbWFFuTvjBgg6/UgkuW55eRNn9Cu/O0MdeBwTBMl8VWP4ikiZSw=
X-Received: by 2002:a67:ed45:0:b0:47b:fa9c:d9d0 with SMTP id
 m5-20020a67ed45000000b0047bfa9cd9d0mr8636641vsp.20.1714356804482; Sun, 28 Apr
 2024 19:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240424142808.62936-2-ajones@ventanamicro.com>
In-Reply-To: <20240424142808.62936-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:12:58 +1000
Message-ID: <CAKmqyKNj06jrU+ESr_6zezWndz=Tvf6hebN0b8XxTVT+KwNFbQ@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Raise exceptions on wrs.nto
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, christoph.muellner@vrull.eu, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Thu, Apr 25, 2024 at 12:29=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> Implementing wrs.nto to always just return is consistent with the
> specification, as the instruction is permitted to terminate the
> stall for any reason, but it's not useful for virtualization, where
> we'd like the guest to trap to the hypervisor in order to allow
> scheduling of the lock holding VCPU. Change to always immediately
> raise exceptions when the appropriate conditions are present,
> otherwise continue to just return. Note, immediately raising
> exceptions is also consistent with the specification since the
> time limit that should expire prior to the exception is
> implementation-specific.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v3:
>  - Sending again, hoping the =C3=BC remains in M=C3=BCllner
> v2:
>  - Added #ifndef CONFIG_USER_ONLY around helper call
>
>  target/riscv/helper.h                       |  1 +
>  target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
>  target/riscv/op_helper.c                    | 11 ++++++++
>  3 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 8a635238514d..451261ce5a4f 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl=
)
>  DEF_HELPER_1(sret, tl, env)
>  DEF_HELPER_1(mret, tl, env)
>  DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  DEF_HELPER_1(tlb_flush_all, void, env)
>  /* Native Debug */
> diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/i=
nsn_trans/trans_rvzawrs.c.inc
> index 32efbff4d5a5..0eef03383889 100644
> --- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
> @@ -16,7 +16,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> -static bool trans_wrs(DisasContext *ctx)
> +static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
>  {
>      if (!ctx->cfg_ptr->ext_zawrs) {
>          return false;
> @@ -40,12 +40,23 @@ static bool trans_wrs(DisasContext *ctx)
>      return true;
>  }
>
> -#define GEN_TRANS_WRS(insn)                                     \
> -static bool trans_ ## insn(DisasContext *ctx, arg_ ## insn *a)  \
> -{                                                               \
> -    (void)a;                                                    \
> -    return trans_wrs(ctx);                                      \
> -}
> +static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
> +{
> +    if (!ctx->cfg_ptr->ext_zawrs) {
> +        return false;
> +    }
>
> -GEN_TRANS_WRS(wrs_nto)
> -GEN_TRANS_WRS(wrs_sto)
> +    /*
> +     * Depending on the mode of execution, mstatus.TW and hstatus.VTW, w=
rs.nto
> +     * should raise an exception when the implementation-specific bounde=
d time
> +     * limit has expired. Our time limit is zero, so we either return
> +     * immediately, as does our implementation of wrs.sto, or raise an
> +     * exception, as handled by the wrs.nto helper.
> +     */
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_wrs_nto(tcg_env);
> +#endif
> +
> +    /* We only get here when helper_wrs_nto() doesn't raise an exception=
. */
> +    return trans_wrs_sto(ctx, NULL);
> +}
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdbab..2baf5bc3ca19 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -380,6 +380,17 @@ void helper_wfi(CPURISCVState *env)
>      }
>  }
>
> +void helper_wrs_nto(CPURISCVState *env)
> +{
> +    if (env->virt_enabled && (env->priv =3D=3D PRV_S || env->priv =3D=3D=
 PRV_U) &&
> +        get_field(env->hstatus, HSTATUS_VTW) &&
> +        !get_field(env->mstatus, MSTATUS_TW)) {
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GE=
TPC());
> +    } else if (env->priv !=3D PRV_M && get_field(env->mstatus, MSTATUS_T=
W)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +}
> +
>  void helper_tlb_flush(CPURISCVState *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> --
> 2.44.0
>
>

