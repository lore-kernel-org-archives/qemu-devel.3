Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E33E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBEC-0004CG-BR; Mon, 29 Dec 2025 06:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBDt-0004Av-FC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:15:38 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBDq-0005Tw-MS
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:15:36 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79af62d36bso1525206166b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006933; x=1767611733; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX7BBUXM/yltD3QMu6ZMpBLk3r+WKh8d8WSnxlNy3r8=;
 b=r/GJCWJoouFG08AOn5omyH6bFKpvWJeM1oqGUzQMfSk12221KVpTqsN6oWLTvNr54B
 9TaQmV1bJru+VzhalSE4sO7N9FV40+9ZAZx4ycA+/r2laTI+bv2islH03xD4DyrmKVbC
 i7v2R0jic3qzvp46IhNVZzYKGqlAsEsdeDLoYoYcRF7KLZi1WhKHuh0HdwwnRnE7Jcfe
 /uCt8bmJg60C3d7hOwU3SJBG25TgdNqgfhNeqywjs7BO5LGsQgjnfQgbw6Y35yT8JsiF
 P5bVmrDfR8jfhS7Lb42blRZYE8X9jLP5gx/nWSMKAMgI5gWtC3Wlw0N7POIc8Q9m71uT
 PMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006933; x=1767611733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oX7BBUXM/yltD3QMu6ZMpBLk3r+WKh8d8WSnxlNy3r8=;
 b=xMTJk/TLsL7h7F7rY1yTEGwc2vFhp+H5cWWqeONd3QeRuXpucKVefhOLAinTSIEayp
 xzT1MPaECyRx0/eKntWaI85JZ/MjwEZFS4PL/u+uq4EFE4yUzJKkZcm87ElksdEwvdGH
 Y4xzXgKnzbHxgDU5O41vLWRphq9vmRs+uUiII3mt4wpcPS81KxhzBZyqPlJNjhz1ZNw2
 +H28igKZ7r1WRFU3fcrH4bVdEVDikvw6UM1e47HKhcT9+ED5D3scbzpvBjD8RilBcOQs
 nAoFhfMgSYap5tRYgKT3NFeDr9Nc0D6X3FIM2eYT6avJBsEFraZxCJn1HvyohWByYran
 y3+Q==
X-Gm-Message-State: AOJu0YyFyyFJxmNJvET9gPWJcEveWvnzCLk87qZto4rpTtWM+7rI+lYi
 75BOWylmJBXCD5niqgd/sMYGPA9SHvE0y5P5WUPrCQs+4RHzz6zrArqqAh9/aAAdy9tA+qWWEbc
 qi0gONXtJAGGi3/ULJBi7tLJ4+9YubFRZQjaxHDMNBg==
X-Gm-Gg: AY/fxX6+qOYBU2Oi1O/yyfT5NuaiZ+01vMbwwQOKsopCXvY+qvKaW7AeBqoReWi7H/V
 qWWbJGOo8EnaOpWbwkGji8t4vLouVX/pn5AqSXNo+DgFOXAOVoIxNd5Gm42ct8Auwz7qdVsS7yP
 0SbDkUOX6Gy7/OzYlKmt+lUPopz3OtHyeRtjprsdHhJhlJ/QRuUwwKEUZq5siAsCKngKKFCcw2u
 7BBX/Mi2vxo8cz72h+pMNLELMjEKRRInDbsDV1n/+hEJw+X+LCXlzTcLhbYHa4tZn8E7x2Ailth
 usS2ffD0K+o9T5tywpVtSS3ugzfR2PaTROlODcs=
X-Google-Smtp-Source: AGHT+IEW2u2wuOP5yuFeUdFfnFUlJfZC7lqJvmJJ02LE7oCnh5y2a+aqgVcJVWIRWXJ/f536DWKLBSACXJXFzNstM6o=
X-Received: by 2002:a17:907:7e91:b0:b7a:2ba7:198c with SMTP id
 a640c23a62f3a-b80371efe93mr3550813066b.59.1767006933007; Mon, 29 Dec 2025
 03:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-4-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:15:07 +0200
X-Gm-Features: AQt7F2q_yKVhpMpl-vRmoyjQkBrE6MOlXqs_TjNgD1wAELpCNEc-O5Qgofid3Qo
Message-ID: <CAAjaMXY=GyHpnX34ch+BM_6TF5CkhdM3htph_3c16K37mQDdbw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] target/sparc: Replace MO_TE -> MO_BE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build the SPARC targets using big endianness order,
> therefore the MO_TE definitions expand to the big endian
> one. Use the latter which is more explicit.
>
> Mechanical change running:
>
>   $ sed -i -e s/MO_TE/MO_BE/ \
>         $(git grep -wl MO_TE target/sparc/)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/sparc/ldst_helper.c |  6 ++--
>  target/sparc/translate.c   | 58 +++++++++++++++++++-------------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 2c63eb9e036..a87a0b3eee0 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1169,7 +1169,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_=
ulong addr, uint32_t oi)
>          break;
>      case MO_16:
>          ret =3D cpu_ldw_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) !=3D MO_TE) {
> +        if ((mop & MO_BSWAP) !=3D MO_BE) {
>              ret =3D bswap16(ret);
>          }
>          if (mop & MO_SIGN) {
> @@ -1178,7 +1178,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_=
ulong addr, uint32_t oi)
>          break;
>      case MO_32:
>          ret =3D cpu_ldl_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) !=3D MO_TE) {
> +        if ((mop & MO_BSWAP) !=3D MO_BE) {
>              ret =3D bswap32(ret);
>          }
>          if (mop & MO_SIGN) {
> @@ -1187,7 +1187,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_=
ulong addr, uint32_t oi)
>          break;
>      case MO_64:
>          ret =3D cpu_ldq_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) !=3D MO_TE) {
> +        if ((mop & MO_BSWAP) !=3D MO_BE) {
>              ret =3D bswap64(ret);
>          }
>          break;
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index d6b599b71fe..23079697f52 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1764,7 +1764,7 @@ static DisasASI resolve_asi(DisasContext *dc, int a=
si, MemOp memop)
>          case ASI_FL16_SL:
>          case ASI_FL16_P:
>          case ASI_FL16_PL:
> -            memop =3D MO_TEUW;
> +            memop =3D MO_BEUW;
>              type =3D GET_ASI_SHORT;
>              break;
>          }
> @@ -2215,7 +2215,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>               * byte swapped.  We perform one 128-bit LE load, so must sw=
ap
>               * the order of the writebacks.
>               */
> -            if ((mop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((mop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_extr_i128_i64(lo, hi, t);
>              } else {
>                  tcg_gen_extr_i128_i64(hi, lo, t);
> @@ -2235,7 +2235,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>              /* Note that LE ldda acts as if each 32-bit register
>                 result is byte swapped.  Having just performed one
>                 64-bit bswap, we need now to swap the writebacks.  */
> -            if ((da->memop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((da->memop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_extr_i64_tl(lo, hi, tmp);
>              } else {
>                  tcg_gen_extr_i64_tl(hi, lo, tmp);
> @@ -2252,7 +2252,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>              gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi))=
;
>
>              /* See above.  */
> -            if ((da->memop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((da->memop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_extr_i64_tl(lo, hi, tmp);
>              } else {
>                  tcg_gen_extr_i64_tl(hi, lo, tmp);
> @@ -2277,7 +2277,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>              gen_helper_ld_asi(tmp, tcg_env, addr, r_asi, r_mop);
>
>              /* See above.  */
> -            if ((da->memop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((da->memop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_extr_i64_tl(lo, hi, tmp);
>              } else {
>                  tcg_gen_extr_i64_tl(hi, lo, tmp);
> @@ -2310,7 +2310,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>               * byte swapped.  We perform one 128-bit LE store, so must s=
wap
>               * the order of the construction.
>               */
> -            if ((mop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((mop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_concat_i64_i128(t, lo, hi);
>              } else {
>                  tcg_gen_concat_i64_i128(t, hi, lo);
> @@ -2329,7 +2329,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>              /* Note that LE stda acts as if each 32-bit register result =
is
>                 byte swapped.  We will perform one 64-bit LE store, so no=
w
>                 we must swap the order of the construction.  */
> -            if ((da->memop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((da->memop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_concat_tl_i64(t64, lo, hi);
>              } else {
>                  tcg_gen_concat_tl_i64(t64, hi, lo);
> @@ -2345,7 +2345,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>           * See comments for GET_ASI_COPY above.
>           */
>          {
> -            MemOp mop =3D MO_TE | MO_128 | MO_ATOM_IFALIGN_PAIR;
> +            MemOp mop =3D MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR;
>              TCGv_i64 t8 =3D tcg_temp_new_i64();
>              TCGv_i128 t16 =3D tcg_temp_new_i128();
>              TCGv daddr =3D tcg_temp_new();
> @@ -2368,7 +2368,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI=
 *da, TCGv addr, int rd)
>              TCGv_i64 t64 =3D tcg_temp_new_i64();
>
>              /* See above.  */
> -            if ((da->memop & MO_BSWAP) =3D=3D MO_TE) {
> +            if ((da->memop & MO_BSWAP) =3D=3D MO_BE) {
>                  tcg_gen_concat_tl_i64(t64, lo, hi);
>              } else {
>                  tcg_gen_concat_tl_i64(t64, hi, lo);
> @@ -4428,13 +4428,13 @@ static bool do_ld_gpr(DisasContext *dc, arg_r_r_r=
i_asi *a, MemOp mop)
>      return advance_pc(dc);
>  }
>
> -TRANS(LDUW, ALL, do_ld_gpr, a, MO_TEUL)
> +TRANS(LDUW, ALL, do_ld_gpr, a, MO_BEUL)
>  TRANS(LDUB, ALL, do_ld_gpr, a, MO_UB)
> -TRANS(LDUH, ALL, do_ld_gpr, a, MO_TEUW)
> +TRANS(LDUH, ALL, do_ld_gpr, a, MO_BEUW)
>  TRANS(LDSB, ALL, do_ld_gpr, a, MO_SB)
> -TRANS(LDSH, ALL, do_ld_gpr, a, MO_TESW)
> -TRANS(LDSW, 64, do_ld_gpr, a, MO_TESL)
> -TRANS(LDX, 64, do_ld_gpr, a, MO_TEUQ)
> +TRANS(LDSH, ALL, do_ld_gpr, a, MO_BESW)
> +TRANS(LDSW, 64, do_ld_gpr, a, MO_BESL)
> +TRANS(LDX, 64, do_ld_gpr, a, MO_BEUQ)
>
>  static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
>  {
> @@ -4451,10 +4451,10 @@ static bool do_st_gpr(DisasContext *dc, arg_r_r_r=
i_asi *a, MemOp mop)
>      return advance_pc(dc);
>  }
>
> -TRANS(STW, ALL, do_st_gpr, a, MO_TEUL)
> +TRANS(STW, ALL, do_st_gpr, a, MO_BEUL)
>  TRANS(STB, ALL, do_st_gpr, a, MO_UB)
> -TRANS(STH, ALL, do_st_gpr, a, MO_TEUW)
> -TRANS(STX, 64, do_st_gpr, a, MO_TEUQ)
> +TRANS(STH, ALL, do_st_gpr, a, MO_BEUW)
> +TRANS(STX, 64, do_st_gpr, a, MO_BEUQ)
>
>  static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
>  {
> @@ -4468,7 +4468,7 @@ static bool trans_LDD(DisasContext *dc, arg_r_r_ri_=
asi *a)
>      if (addr =3D=3D NULL) {
>          return false;
>      }
> -    da =3D resolve_asi(dc, a->asi, MO_TEUQ);
> +    da =3D resolve_asi(dc, a->asi, MO_BEUQ);
>      gen_ldda_asi(dc, &da, addr, a->rd);
>      return advance_pc(dc);
>  }
> @@ -4485,7 +4485,7 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_=
asi *a)
>      if (addr =3D=3D NULL) {
>          return false;
>      }
> -    da =3D resolve_asi(dc, a->asi, MO_TEUQ);
> +    da =3D resolve_asi(dc, a->asi, MO_BEUQ);
>      gen_stda_asi(dc, &da, addr, a->rd);
>      return advance_pc(dc);
>  }
> @@ -4516,7 +4516,7 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri=
_asi *a)
>      if (addr =3D=3D NULL) {
>          return false;
>      }
> -    da =3D resolve_asi(dc, a->asi, MO_TEUL);
> +    da =3D resolve_asi(dc, a->asi, MO_BEUL);
>
>      dst =3D gen_dest_gpr(dc, a->rd);
>      src =3D gen_load_gpr(dc, a->rd);
> @@ -4544,8 +4544,8 @@ static bool do_casa(DisasContext *dc, arg_r_r_ri_as=
i *a, MemOp mop)
>      return advance_pc(dc);
>  }
>
> -TRANS(CASA, CASA, do_casa, a, MO_TEUL)
> -TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
> +TRANS(CASA, CASA, do_casa, a, MO_BEUL)
> +TRANS(CASXA, 64, do_casa, a, MO_BEUQ)
>
>  static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
>  {
> @@ -4561,7 +4561,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_=
asi *a, MemOp sz)
>      if (sz =3D=3D MO_128 && gen_trap_float128(dc)) {
>          return true;
>      }
> -    da =3D resolve_asi(dc, a->asi, MO_TE | sz);
> +    da =3D resolve_asi(dc, a->asi, MO_BE | sz);
>      gen_ldf_asi(dc, &da, sz, addr, a->rd);
>      gen_update_fprs_dirty(dc, a->rd);
>      return advance_pc(dc);
> @@ -4590,7 +4590,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_=
asi *a, MemOp sz)
>      if (sz =3D=3D MO_128 && gen_trap_float128(dc)) {
>          return true;
>      }
> -    da =3D resolve_asi(dc, a->asi, MO_TE | sz);
> +    da =3D resolve_asi(dc, a->asi, MO_BE | sz);
>      gen_stf_asi(dc, &da, sz, addr, a->rd);
>      return advance_pc(dc);
>  }
> @@ -4629,7 +4629,7 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ=
 *a)
>      /* Store the single element from the queue. */
>      TCGv_i64 fq =3D tcg_temp_new_i64();
>      tcg_gen_ld_i64(fq, tcg_env, offsetof(CPUSPARCState, fq.d));
> -    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN_4);
> +    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN_4);
>
>      /* Mark the queue empty, transitioning to fp_execute state. */
>      tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
> @@ -4655,7 +4655,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_r=
i *a)
>      }
>
>      tmp =3D tcg_temp_new_i32();
> -    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
> +    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_BEUL | MO_ALIGN);
>
>      tcg_gen_extract_i32(cpu_fcc[0], tmp, FSR_FCC0_SHIFT, 2);
>      /* LDFSR does not change FCC[1-3]. */
> @@ -4679,7 +4679,7 @@ static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri =
*a, bool entire)
>      }
>
>      t64 =3D tcg_temp_new_i64();
> -    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
> +    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN);
>
>      lo =3D tcg_temp_new_i32();
>      hi =3D cpu_fcc[3];
> @@ -4722,8 +4722,8 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *=
a, MemOp mop)
>      return advance_pc(dc);
>  }
>
> -TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
> -TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
> +TRANS(STFSR, ALL, do_stfsr, a, MO_BEUL)
> +TRANS(STXFSR, 64, do_stfsr, a, MO_BEUQ)
>
>  static bool do_fc(DisasContext *dc, int rd, int32_t c)
>  {
> --
> 2.52.0
>

