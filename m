Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE82C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X5v-0000LC-38; Mon, 28 Apr 2025 18:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X5s-0000KA-Mo; Mon, 28 Apr 2025 18:36:56 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X5j-0001pF-OH; Mon, 28 Apr 2025 18:36:55 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86fab198f8eso2137422241.1; 
 Mon, 28 Apr 2025 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879802; x=1746484602; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YU1DH3aqluvhAdVQAymqLLYkcRWQZXo4AWzjfVIKTjM=;
 b=O8Doqb04BUy04/BiqMmTzsG2mKwH6AHZlf0prW25iclp93qiYabAKtta3ByEkxbDly
 rqdW0tIOyMldRC3KsMlfXbRCtl9Dxyq+5cuFegZ+prdtTKp1zhrFlT7O8LJ5LV72Ewt3
 xWiIEbdX0U4MvNCPT6fYsrLicFk/q684NNw6j9U3SvGRvqz3gOs15BQ8S34CsVD67Wsd
 5Bymv+TpxdC4rG6Y5+hD47MNGTx38Le5nVE95U8/oJrcDCQWd+Bw4QototE+za9U/Hso
 ofHLGPU7Qjqn7MBbaa/n5BJ1x+atavpbQzJ51PH2miyKnpkJFQOMfTCSdba4S2fGP2yh
 zG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879802; x=1746484602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YU1DH3aqluvhAdVQAymqLLYkcRWQZXo4AWzjfVIKTjM=;
 b=R6DIaN0SfTSvYjqiLyO9HjJN9XEpkiNBSRSK9hZcppLy3fFjfLqeUX1q7eWingalu7
 mpoSXasd6CfLGIOnj1dKf0gpjqXilKZYjGUCECAI9giIuUR8pooLUmTdWhxBVY7alRit
 zTgixQfBKbgoA5POVgdoTCCTYEQQkgIes2LguV5n3a3JTRfH1wQ4xs0a1Blm+1u0J3xG
 0/wpBHzzod7ZU5SWfx9VdfKTIltDz9Rw/HkDLlDIeIdM0xb6VzoogqsDPWpslJPZDqey
 C0WpBw3XQIrLaNVUQsUygSF8uPgUEgWVvqlHIpog4U7pOfr7RWN5eTyMH6QN9Um8fgpt
 UR2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEs62NwqmgmOsOSHYtAIdR6sh8dmPDMcH8ADaQpTy8ad7G+8RRh1Pwu/wROq9jWQiIRdVAE9YBAhjr@nongnu.org
X-Gm-Message-State: AOJu0Yyi5Z9tnmLWnVYspWugdPgOSP8kk+hLOIgLhbt3wuM4ECQz5TTE
 C1VDDMyXjK0GoWTlCL6FCIqKZzhCja5YVaaa/+5sGZVe/cIXYL1GYaVW1rrCjngWAPYDPp1VuSX
 8UZRijwmJvefnQzbA822uwjzGhdE=
X-Gm-Gg: ASbGnctNs/Qg+uEPtZnXsIibOLi4ZFGv88OSwU4igny1FZpGnLvXAjOiLZ4aXciaM9Y
 oxcx0ADSvayUbdxbQkvrdH6IdtwjSgFwPfKW/rRAU/jRACCcP4UqVMeOa1YOqmIS7jf7LwSlHB9
 6O6ZlM03yxfMOp/ZL6vHwa0UNs/NT7C+ygJXNFnfLfGs4BQy8UKAmm
X-Google-Smtp-Source: AGHT+IE7J/ekkzXMSgfJ495EV/KYi8Gwvf/mkXU4QWwzNdauO/yox2LQOK11ejUjb1QOHeVlIG2mg3B+0KXyO6HaYa0=
X-Received: by 2002:a05:6102:5e85:b0:4bb:d7f0:6e70 with SMTP id
 ada2fe7eead31-4d6400af924mr6992676137.5.1745879802021; Mon, 28 Apr 2025
 15:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-5-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-5-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:36:16 +1000
X-Gm-Features: ATxdqUEArozoHbdSAj_Otsz-dRnb5P2J_KFfZ0V23TYozbHAj6g3e63DRa2k9Sg
Message-ID: <CAKmqyKMD7mx83-AUnw+DfstR4X2VNevhJuazafHN91XfGGM_-A@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/riscv: Pass ra to riscv_csrrw
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Sat, Apr 26, 2025 at 1:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h       | 8 ++++----
>  hw/riscv/riscv_hart.c    | 2 +-
>  target/riscv/csr.c       | 8 ++++----
>  target/riscv/op_helper.c | 4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4d41a66d72..2c0524d0be 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -816,8 +816,8 @@ RISCVException riscv_csrr(CPURISCVState *env, int csr=
no,
>                            target_ulong *ret_value);
>
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> -                           target_ulong *ret_value,
> -                           target_ulong new_value, target_ulong write_ma=
sk);
> +                           target_ulong *ret_value, target_ulong new_val=
ue,
> +                           target_ulong write_mask, uintptr_t ra);
>  RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
>                                   target_ulong *ret_value,
>                                   target_ulong new_value,
> @@ -826,13 +826,13 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env=
, int csrno,
>  static inline void riscv_csr_write(CPURISCVState *env, int csrno,
>                                     target_ulong val)
>  {
> -    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BI=
TS));
> +    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BI=
TS), 0);
>  }
>
>  static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
>  {
>      target_ulong val =3D 0;
> -    riscv_csrrw(env, csrno, &val, 0, 0);
> +    riscv_csrrw(env, csrno, &val, 0, 0, 0);
>      return val;
>  }
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d156668..2ebbf41b18 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -72,7 +72,7 @@ static void csr_call(char *cmd, uint64_t cpu_num, int c=
srno, uint64_t *val)
>          ret =3D riscv_csrr(env, csrno, (target_ulong *)val);
>      } else if (strcmp(cmd, "set_csr") =3D=3D 0) {
>          ret =3D riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> -                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
> +                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
>      }
>
>      g_assert(ret =3D=3D RISCV_EXCP_NONE);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d62d1aaaee..097640e25d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5574,15 +5574,15 @@ RISCVException riscv_csrr(CPURISCVState *env, int=
 csrno,
>  }
>
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> -                           target_ulong *ret_value,
> -                           target_ulong new_value, target_ulong write_ma=
sk)
> +                           target_ulong *ret_value, target_ulong new_val=
ue,
> +                           target_ulong write_mask, uintptr_t ra)
>  {
>      RISCVException ret =3D riscv_csrrw_check(env, csrno, true);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
>
> -    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask=
, 0);
> +    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask=
, ra);
>  }
>
>  static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
> @@ -5704,7 +5704,7 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env=
, int csrno,
>      if (!write_mask) {
>          ret =3D riscv_csrr(env, csrno, ret_value);
>      } else {
> -        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask=
);
> +        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask=
, 0);
>      }
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D false;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 5b0db2c45a..aee16e2e3a 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -71,7 +71,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
>  void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
>  {
>      target_ulong mask =3D env->xl =3D=3D MXL_RV32 ? UINT32_MAX : (target=
_ulong)-1;
> -    RISCVException ret =3D riscv_csrrw(env, csr, NULL, src, mask);
> +    RISCVException ret =3D riscv_csrrw(env, csr, NULL, src, mask, GETPC(=
));
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> @@ -82,7 +82,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
>                            target_ulong src, target_ulong write_mask)
>  {
>      target_ulong val =3D 0;
> -    RISCVException ret =3D riscv_csrrw(env, csr, &val, src, write_mask);
> +    RISCVException ret =3D riscv_csrrw(env, csr, &val, src, write_mask, =
GETPC());
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> --
> 2.43.0
>
>

