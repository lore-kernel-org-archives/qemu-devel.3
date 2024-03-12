Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A348C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyxF-0000Nw-Pq; Tue, 12 Mar 2024 06:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjyxD-0000Ni-Ue; Tue, 12 Mar 2024 06:01:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjyx7-0000wd-80; Tue, 12 Mar 2024 06:01:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e66da40b18so2504524b3a.0; 
 Tue, 12 Mar 2024 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710237702; x=1710842502; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Al0ur0w/S/xiinjqCojn1l5ZxNElzZGZve9yDbNj5Xw=;
 b=gHpKwBGBteYBW1jLRIepkE2PCDM1Bz13F4/26tTI9GosgfBlYKIozK4w7rJvkJXWpj
 z6rPGFVE9k8mmdcfAlODyDgSRfdlUaV9aF/vqmXLvlyGue7dk+tImHMDUjsGCE6rAPrd
 GHe9jZ2suBIT/H0uOWExa/yt3BBgwObvdLInnZyEDHzbNiuaBv5VmckA3yEwBtq/FbDK
 m8CYdrDdxuiVUIg8Za+GkwZcR5S/+lWZLLoEbcISvs2oDV+sD8Y0siynOo8IdGrItGxE
 J1U4w15p7HXGTy1CC5ptynOMpSTmSwt+McS+tHAVT6mN8LfJXgv5NLAuVNt61Fcds8gj
 JANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710237702; x=1710842502;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Al0ur0w/S/xiinjqCojn1l5ZxNElzZGZve9yDbNj5Xw=;
 b=XvSs9mZCRYfSrMIX2ZNoOBOoamQfzLCJCNFebiRPJOKlscS59AAiInI70fYIcr2zd4
 +Y54eCSB4RDYsXlJfssqhoF6rkw2Dzu+vlLvD7ML7xru/8XfqChqBfoPfP0YIBnlzCXI
 smZMTeXTpzFS5xVgnJBTC2VfYWIl3Ahk47Gx1QerWdw1MJyncr62DBNIjtQ67JW5GLLi
 5pK3tUrAJkJg4vNpiajmWtrZp4b4r2otx1fZaVmrefuoBaWM/jGei4RhIi0de6LdsNcD
 rQdsPsqAOmJRUpJAuESiqGBh1zzDHvCrqBwo+Ur6YnTa+rQ1XSJLlUYVzscPdbfaAy+c
 78IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhkQ5iP7W5QSrtJItibkUEJz77J+lEidyFpc7j3WnJbw/vBrmKPcjaHZ6kYPg28bx8BumMyaitYmxMVad/iyEkFUYpJj4vYOTImsrn7R9CwXU+ZmqB2Y2WA2M=
X-Gm-Message-State: AOJu0YxM1s/8BZmsPhUxe8lpIYPKzyz7Fa8ynAq3lvGm8C+ssf3TZqO+
 oXsCVxJBTZCSI5siA76NSjmd4BfGsJEfc8swrCFCXGLgUvVtEQM7enr5+1IArbo=
X-Google-Smtp-Source: AGHT+IGoOGKhNWgzznpaoFZPKNmKJvoYJuhHgMSZxGht/O+aUbjFN/Z4o6VEEn6SkotkaT83qEe+Rg==
X-Received: by 2002:a05:6a21:3289:b0:1a3:1573:d874 with SMTP id
 yt9-20020a056a21328900b001a31573d874mr1357674pzb.51.1710237701529; 
 Tue, 12 Mar 2024 03:01:41 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 m5-20020aa78a05000000b006e6ab7cb10esm457333pfa.186.2024.03.12.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:01:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:01:35 +1000
Message-Id: <CZRONZ09DV9X.22XWTY7M4VBHO@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chinmay Rath" <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <danielhb413@gmail.com>, <clg@kaod.org>, <richard.henderson@linaro.org>,
 <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
X-Mailer: aerc 0.15.2
References: <20240307110318.170319-1-rathc@linux.ibm.com>
In-Reply-To: <20240307110318.170319-1-rathc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Mar 7, 2024 at 9:03 PM AEST, Chinmay Rath wrote:
> diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp=
-impl.c.inc
> index 189cd8c979..03b84ba79b 100644
> --- a/target/ppc/translate/fp-impl.c.inc
> +++ b/target/ppc/translate/fp-impl.c.inc
> @@ -30,96 +30,73 @@ static void gen_set_cr1_from_fpscr(DisasContext *ctx)
>  #endif
> =20
>  /***                       Floating-Point arithmetic                    =
   ***/
> -#define _GEN_FLOAT_ACB(name, op1, op2, set_fprf, type)                  =
      \
> -static void gen_f##name(DisasContext *ctx)                              =
      \
> -{                                                                       =
      \
> -    TCGv_i64 t0;                                                        =
      \
> -    TCGv_i64 t1;                                                        =
      \
> -    TCGv_i64 t2;                                                        =
      \
> -    TCGv_i64 t3;                                                        =
      \
> -    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i64();                                          =
        \
> -    t1 =3D tcg_temp_new_i64();                                          =
        \
> -    t2 =3D tcg_temp_new_i64();                                          =
        \
> -    t3 =3D tcg_temp_new_i64();                                          =
        \
> -    gen_reset_fpstatus();                                               =
      \
> -    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> -    get_fpr(t1, rC(ctx->opcode));                                       =
      \
> -    get_fpr(t2, rB(ctx->opcode));                                       =
      \
> -    gen_helper_f##name(t3, tcg_env, t0, t1, t2);                        =
      \
> -    set_fpr(rD(ctx->opcode), t3);                                       =
      \
> -    if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(t3);                                   =
      \
> -    }                                                                   =
      \
> -    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
> -        gen_set_cr1_from_fpscr(ctx);                                    =
      \
> -    }                                                                   =
      \
> +static bool do_helper_acb(DisasContext *ctx, arg_A *a,
> +                          void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
> +                                         TCGv_i64, TCGv_i64))
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0, t1, t2, t3;

Existing style prefers the variable declarations first I think.

> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    t2 =3D tcg_temp_new_i64();
> +    t3 =3D tcg_temp_new_i64();
> +    gen_reset_fpstatus();
> +    get_fpr(t0, a->fra);
> +    get_fpr(t1, a->frc);
> +    get_fpr(t2, a->frb);
> +    helper(t3, tcg_env, t0, t1, t2);
> +    set_fpr(a->frt, t3);
> +    gen_compute_fprf_float64(t3);
> +    if (unlikely(a->rc !=3D false)) {

This reads better without the double negative. I.e., just
  if (unlikely(a->rc)) {

Otherwise the decodetree parts look good, with those updated
and split out from the helper generation:

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> +        gen_set_cr1_from_fpscr(ctx);
> +    }
> +    return true;
>  }


> =20
> -#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                        =
      \
> -_GEN_FLOAT_ACB(name, 0x3F, op2, set_fprf, type);                        =
      \
> -_GEN_FLOAT_ACB(name##s, 0x3B, op2, set_fprf, type);
> -
> -#define _GEN_FLOAT_AB(name, op1, op2, inval, set_fprf, type)            =
      \
> -static void gen_f##name(DisasContext *ctx)                              =
      \
> -{                                                                       =
      \
> -    TCGv_i64 t0;                                                        =
      \
> -    TCGv_i64 t1;                                                        =
      \
> -    TCGv_i64 t2;                                                        =
      \
> -    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i64();                                          =
        \
> -    t1 =3D tcg_temp_new_i64();                                          =
        \
> -    t2 =3D tcg_temp_new_i64();                                          =
        \
> -    gen_reset_fpstatus();                                               =
      \
> -    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> -    get_fpr(t1, rB(ctx->opcode));                                       =
      \
> -    gen_helper_f##name(t2, tcg_env, t0, t1);                            =
      \
> -    set_fpr(rD(ctx->opcode), t2);                                       =
      \
> -    if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(t2);                                   =
      \
> -    }                                                                   =
      \
> -    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
> -        gen_set_cr1_from_fpscr(ctx);                                    =
      \
> -    }                                                                   =
      \
> +static bool do_helper_ab(DisasContext *ctx, arg_A_tab *a,
> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
> +                                        TCGv_i64))
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0, t1, t2;
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    t2 =3D tcg_temp_new_i64();
> +    gen_reset_fpstatus();
> +    get_fpr(t0, a->fra);
> +    get_fpr(t1, a->frb);
> +    helper(t2, tcg_env, t0, t1);
> +    set_fpr(a->frt, t2);
> +    gen_compute_fprf_float64(t2);
> +    if (unlikely(a->rc) !=3D false) {
> +        gen_set_cr1_from_fpscr(ctx);
> +    }
> +    return true;
>  }
> -#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                  =
      \
> -_GEN_FLOAT_AB(name, 0x3F, op2, inval, set_fprf, type);                  =
      \
> -_GEN_FLOAT_AB(name##s, 0x3B, op2, inval, set_fprf, type);
> =20
> -#define _GEN_FLOAT_AC(name, op1, op2, inval, set_fprf, type)            =
      \
> -static void gen_f##name(DisasContext *ctx)                              =
      \
> -{                                                                       =
      \
> -    TCGv_i64 t0;                                                        =
      \
> -    TCGv_i64 t1;                                                        =
      \
> -    TCGv_i64 t2;                                                        =
      \
> -    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i64();                                          =
        \
> -    t1 =3D tcg_temp_new_i64();                                          =
        \
> -    t2 =3D tcg_temp_new_i64();                                          =
        \
> -    gen_reset_fpstatus();                                               =
      \
> -    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> -    get_fpr(t1, rC(ctx->opcode));                                       =
      \
> -    gen_helper_f##name(t2, tcg_env, t0, t1);                            =
      \
> -    set_fpr(rD(ctx->opcode), t2);                                       =
      \
> -    if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(t2);                                   =
      \
> -    }                                                                   =
      \
> -    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
> -        gen_set_cr1_from_fpscr(ctx);                                    =
      \
> -    }                                                                   =
      \
> +static bool do_helper_ac(DisasContext *ctx, arg_A_tac *a,
> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
> +                                        TCGv_i64))
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0, t1, t2;
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    t2 =3D tcg_temp_new_i64();
> +    gen_reset_fpstatus();
> +    get_fpr(t0, a->fra);
> +    get_fpr(t1, a->frc);
> +    helper(t2, tcg_env, t0, t1);
> +    set_fpr(a->frt, t2);
> +    gen_compute_fprf_float64(t2);
> +    if (unlikely(a->rc) !=3D false) {
> +        gen_set_cr1_from_fpscr(ctx);
> +    }
> +    return true;
>  }
> -#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                  =
      \
> -_GEN_FLOAT_AC(name, 0x3F, op2, inval, set_fprf, type);                  =
      \
> -_GEN_FLOAT_AC(name##s, 0x3B, op2, inval, set_fprf, type);
> =20
>  #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                     =
      \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
> @@ -145,64 +122,22 @@ static void gen_f##name(DisasContext *ctx)         =
                           \
>      }                                                                   =
      \
>  }
> =20
> -#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                    =
      \
> -static void gen_f##name(DisasContext *ctx)                              =
      \
> -{                                                                       =
      \
> -    TCGv_i64 t0;                                                        =
      \
> -    TCGv_i64 t1;                                                        =
      \
> -    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i64();                                          =
        \
> -    t1 =3D tcg_temp_new_i64();                                          =
        \
> -    gen_reset_fpstatus();                                               =
      \
> -    get_fpr(t0, rB(ctx->opcode));                                       =
      \
> -    gen_helper_f##name(t1, tcg_env, t0);                                =
      \
> -    set_fpr(rD(ctx->opcode), t1);                                       =
      \
> -    if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(t1);                                   =
      \
> -    }                                                                   =
      \
> -    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
> -        gen_set_cr1_from_fpscr(ctx);                                    =
      \
> -    }                                                                   =
      \
> -}
> -
> -/* fadd - fadds */
> -GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
> -/* fdiv - fdivs */
> -GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
> -/* fmul - fmuls */
> -GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
> -
> -/* fre */
> -GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT);
> -
> -/* fres */
> -GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES);
> -
> -/* frsqrte */
> -GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE);
> -
> -/* frsqrtes */
> -static void gen_frsqrtes(DisasContext *ctx)
> +static bool do_helper_bs(DisasContext *ctx, arg_A_tb *a,
> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64))
>  {
> -    TCGv_i64 t0;
> -    TCGv_i64 t1;
> -    if (unlikely(!ctx->fpu_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_FPU);
> -        return;
> -    }
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0, t1;
>      t0 =3D tcg_temp_new_i64();
>      t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
> -    get_fpr(t0, rB(ctx->opcode));
> -    gen_helper_frsqrtes(t1, tcg_env, t0);
> -    set_fpr(rD(ctx->opcode), t1);
> +    get_fpr(t0, a->frb);
> +    helper(t1, tcg_env, t0);
> +    set_fpr(a->frt, t1);
>      gen_compute_fprf_float64(t1);
> -    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
> +    if (unlikely(a->rc !=3D false)) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    return true;
>  }
> =20
>  static bool trans_FSEL(DisasContext *ctx, arg_A *a)
> @@ -228,10 +163,6 @@ static bool trans_FSEL(DisasContext *ctx, arg_A *a)
>      return true;
>  }
> =20
> -/* fsub - fsubs */
> -GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT);
> -/* Optional: */
> -
>  static bool do_helper_fsqrt(DisasContext *ctx, arg_A_tb *a,
>                              void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64)=
)
>  {
> @@ -254,19 +185,33 @@ static bool do_helper_fsqrt(DisasContext *ctx, arg_=
A_tb *a,
>      return true;
>  }
> =20
> +TRANS(FADD, do_helper_ab, gen_helper_FADD);
> +TRANS(FADDS, do_helper_ab, gen_helper_FADDS);
> +TRANS(FSUB, do_helper_ab, gen_helper_FSUB);
> +TRANS(FSUBS, do_helper_ab, gen_helper_FSUBS);
> +TRANS(FDIV, do_helper_ab, gen_helper_FDIV);
> +TRANS(FDIVS, do_helper_ab, gen_helper_FDIVS);
> +TRANS(FMUL, do_helper_ac, gen_helper_FMUL);
> +TRANS(FMULS, do_helper_ac, gen_helper_FMULS);
> +
> +TRANS(FMADD, do_helper_acb, gen_helper_FMADD);
> +TRANS(FMADDS, do_helper_acb, gen_helper_FMADDS);
> +TRANS(FMSUB, do_helper_acb, gen_helper_FMSUB);
> +TRANS(FMSUBS, do_helper_acb, gen_helper_FMSUBS);
> +
> +TRANS(FNMADD, do_helper_acb, gen_helper_FNMADD);
> +TRANS(FNMADDS, do_helper_acb, gen_helper_FNMADDS);
> +TRANS(FNMSUB, do_helper_acb, gen_helper_FNMSUB);
> +TRANS(FNMSUBS, do_helper_acb, gen_helper_FNMSUBS);
> +
> +TRANS_FLAGS(FLOAT_EXT, FRE, do_helper_bs, gen_helper_FRE);
> +TRANS_FLAGS(FLOAT_FRES, FRES, do_helper_bs, gen_helper_FRES);
> +TRANS_FLAGS(FLOAT_FRSQRTE, FRSQRTE, do_helper_bs, gen_helper_FRSQRTE);
> +TRANS_FLAGS(FLOAT_FRSQRTES, FRSQRTES, do_helper_bs, gen_helper_FRSQRTES)=
;
> +
>  TRANS(FSQRT, do_helper_fsqrt, gen_helper_FSQRT);
>  TRANS(FSQRTS, do_helper_fsqrt, gen_helper_FSQRTS);
> =20
> -/***                     Floating-Point multiply-and-add                =
   ***/
> -/* fmadd - fmadds */
> -GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT);
> -/* fmsub - fmsubs */
> -GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT);
> -/* fnmadd - fnmadds */
> -GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT);
> -/* fnmsub - fnmsubs */
> -GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT);
> -
>  /***                     Floating-Point round & convert                 =
   ***/
>  /* fctiw */
>  GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT);
> @@ -304,35 +249,29 @@ GEN_FLOAT_B(rip, 0x08, 0x0E, 1, PPC_FLOAT_EXT);
>  /* frim */
>  GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT);
> =20
> -static void gen_ftdiv(DisasContext *ctx)
> +static bool trans_FTDIV(DisasContext *ctx, arg_X_bf *a)
>  {
> -    TCGv_i64 t0;
> -    TCGv_i64 t1;
> -    if (unlikely(!ctx->fpu_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_FPU);
> -        return;
> -    }
> +    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0, t1;
>      t0 =3D tcg_temp_new_i64();
>      t1 =3D tcg_temp_new_i64();
> -    get_fpr(t0, rA(ctx->opcode));
> -    get_fpr(t1, rB(ctx->opcode));
> -    gen_helper_ftdiv(cpu_crf[crfD(ctx->opcode)], t0, t1);
> +    get_fpr(t0, a->ra);
> +    get_fpr(t1, a->rb);
> +    gen_helper_FTDIV(cpu_crf[a->bf], t0, t1);
> +    return true;
>  }
> =20
> -static void gen_ftsqrt(DisasContext *ctx)
> +static bool trans_FTSQRT(DisasContext *ctx, arg_X_bf_b *a)
>  {
> -    TCGv_i64 t0;
> -    if (unlikely(!ctx->fpu_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_FPU);
> -        return;
> -    }
> -    t0 =3D tcg_temp_new_i64();
> -    get_fpr(t0, rB(ctx->opcode));
> -    gen_helper_ftsqrt(cpu_crf[crfD(ctx->opcode)], t0);
> +    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
> +    REQUIRE_FPU(ctx);
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    get_fpr(t0, a->rb);
> +    gen_helper_FTSQRT(cpu_crf[a->bf], t0);
> +    return true;
>  }
> =20
> -
> -
>  /***                         Floating-Point compare                     =
   ***/
> =20
>  /* fcmpo */
> @@ -1111,14 +1050,7 @@ TRANS(STFDX, do_lsfp_X, false, true, false)
>  TRANS(STFDUX, do_lsfp_X, true, true, false)
>  TRANS(PSTFD, do_lsfp_PLS_D, false, true, false)
> =20
> -#undef _GEN_FLOAT_ACB
> -#undef GEN_FLOAT_ACB
> -#undef _GEN_FLOAT_AB
> -#undef GEN_FLOAT_AB
> -#undef _GEN_FLOAT_AC
> -#undef GEN_FLOAT_AC
>  #undef GEN_FLOAT_B
> -#undef GEN_FLOAT_BS
> =20
>  #undef GEN_LDF
>  #undef GEN_LDUF
> diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-=
ops.c.inc
> index d4c6c4bed1..cef4b5dfcb 100644
> --- a/target/ppc/translate/fp-ops.c.inc
> +++ b/target/ppc/translate/fp-ops.c.inc
> @@ -1,36 +1,6 @@
> -#define _GEN_FLOAT_ACB(name, op, op1, op2, isfloat, set_fprf, type)     =
      \
> -GEN_HANDLER(f##name, op1, op2, 0xFF, 0x00000000, type)
> -#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                        =
      \
> -_GEN_FLOAT_ACB(name, name, 0x3F, op2, 0, set_fprf, type),               =
      \
> -_GEN_FLOAT_ACB(name##s, name, 0x3B, op2, 1, set_fprf, type)
> -#define _GEN_FLOAT_AB(name, op, op1, op2, inval, isfloat, set_fprf, type=
)     \
> -GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
> -#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                  =
      \
> -_GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type),         =
      \
> -_GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
> -#define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type=
)     \
> -GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
> -#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                  =
      \
> -_GEN_FLOAT_AC(name, name, 0x3F, op2, inval, 0, set_fprf, type),         =
      \
> -_GEN_FLOAT_AC(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
>  #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                     =
      \
>  GEN_HANDLER(f##name, 0x3F, op2, op3, 0x001F0000, type)
> -#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                    =
      \
> -GEN_HANDLER(f##name, op1, op2, 0xFF, 0x001F07C0, type)
> =20
> -GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT),
> -GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT),
> -GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT),
> -GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT),
> -GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES),
> -GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE),
> -GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT),
> -GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT),
> -GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT),
> -GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT),
> -GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT),
> -GEN_HANDLER_E(ftdiv, 0x3F, 0x00, 0x04, 1, PPC_NONE, PPC2_FP_TST_ISA206),
> -GEN_HANDLER_E(ftsqrt, 0x3F, 0x00, 0x05, 1, PPC_NONE, PPC2_FP_TST_ISA206)=
,
>  GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT),
>  GEN_HANDLER_E(fctiwu, 0x3F, 0x0E, 0x04, 0, PPC_NONE, PPC2_FP_CVT_ISA206)=
,
>  GEN_FLOAT_B(ctiwz, 0x0F, 0x00, 0, PPC_FLOAT),
> @@ -61,7 +31,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
>  GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOK=
E206),
>  GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA20=
5),
> =20
> -GEN_HANDLER(frsqrtes, 0x3B, 0x1A, 0xFF, 0x001F07C0, PPC_FLOAT_FRSQRTES),
>  GEN_HANDLER(fcmpo, 0x3F, 0x00, 0x01, 0x00600001, PPC_FLOAT),
>  GEN_HANDLER(fcmpu, 0x3F, 0x00, 0x00, 0x00600001, PPC_FLOAT),
>  GEN_HANDLER(fabs, 0x3F, 0x08, 0x08, 0x001F0000, PPC_FLOAT),


