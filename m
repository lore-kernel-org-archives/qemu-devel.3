Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C963E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBMP-0007nF-EU; Mon, 29 Dec 2025 06:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMG-0007mW-69
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:17 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMD-0006XI-1M
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:15 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so1715129566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007450; x=1767612250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjLc2sASKITQegxynzW6XILrc0Br7WzN379JiyGH4+A=;
 b=h7HhpQR3lTpeV09yLsXQBaQmWtgwVgi6a3+UTIsITre74vWhehNAjcyv7wAAo2v3K+
 EzjtiYSWi+mGNJWSuGqIn4UX7AryzmabdlkZJcj597RwHndSqcRVe11h8oBKjf+xjmM2
 6rk1W1enUhyqFUn4Zv8svCnKLALj2DfzSUE6RBjqUykZlYOCuRfrw6r4XaVSIEt6LzNd
 c7yQylXCb91lVpwrxCgTm9R3KUgVeEb38VSsehAa5p2xqXOOMnafjecKuyFeuBoQYlQe
 Q9PhVnDOjICWcKQMv+9uasyc5OpvIjwvW/fNhZYDPYZQmc9aXFUKbfoHOSrTNHZJqSGq
 oEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007450; x=1767612250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjLc2sASKITQegxynzW6XILrc0Br7WzN379JiyGH4+A=;
 b=MDp8LEsCAgHGE9BUoV0TXh8N1FZHMoALAUm5zGs0Ne61WKgL2g2hjW7TWpLoTJ/bj1
 qJR8GCZZOMW3clvBjTJH3hxlEgWVnqxhlmIjYvWX7D99ma5/xK9AAkXtH4FBv9hBA1nv
 QOOi76B6h2KikDiNTGZJ+nSkYTPt0gZo/vTq+B0q7+Vz0uUzGI2JwRFFAV3jqA0Djoqe
 lXuBl5y+v9GZP++wGj2IOdioBX/0AdEiebgKCDjSiorC4LcUVqdL1WhwGepFVSmlkZ9R
 nD3jZj2rE7h9n510NcscCqbv08PJwO4u1i4BLqG3/9oBnul1RODqisxV7vyFKeLgcbce
 SypA==
X-Gm-Message-State: AOJu0YxrdXh4TjA8qGjOWI2KAgAYpuKacS6J5KcD9gbeeu0RPo5ixBiG
 gcfcc/Iuc74ACiMf0D85HKo1cmWG6NtZMOuVpsDVkVlL6ee067y7fihFal3Go8djGgldX73sYfc
 8GIotCTNymhUM0gAm0kEf7D5EKeVx9NcJHKIGiUh2S7Fdf2QDo8wzxb06xA==
X-Gm-Gg: AY/fxX6Vm+r2iBN33y6ce/RuevBfIA0P4/C2cS//pRRkdK8Y0jXzmeNlFkeFLEGHySP
 O2p+aVFjquUqYdG7Yy5XbjI5U/oa4BuB1J55ImGTbmyEIpPu89xQS5Sl1A+3TOD9m5aFEQpsr/9
 GMp5A/3liHgs1vnZunPzVKutjwforhX22vbMYQDIKtNrWamU3wJNKwbER2ug0BzoEZr5E/CmznT
 BqfYEl+ZtTA12cc3APBNx+NhR+anF6H5rmI6ihvFn4VjTsXIJ03Z1FU+89/IWYTw5JA8J4Gotq2
 S2iuOf7YcJhaoV2+SOyB1D2P++PUymn730sIO8A=
X-Google-Smtp-Source: AGHT+IEPtI9CCnCjUm94NL04Xy+1/ZB4Tv6oc7m+MwvLvIUXRaPt++lJ/cs1SxqkF08d1gS7QKHcUqwrABsaPwDKWRE=
X-Received: by 2002:a17:907:7f01:b0:b71:ea7c:e501 with SMTP id
 a640c23a62f3a-b80355b2523mr3887825666b.4.1767007450123; Mon, 29 Dec 2025
 03:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20251224163005.91137-1-philmd@linaro.org>
 <20251224163005.91137-2-philmd@linaro.org>
In-Reply-To: <20251224163005.91137-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:23:44 +0200
X-Gm-Features: AQt7F2oEY9FMc7I5QRwPjeVKyaTdJn43Y5x6qig9VslmpPTCQFegLuNlUqkcRNQ
Message-ID: <CAAjaMXYcW9fbh1MtvnkewLuXbFXY13F53PxSmcwb=No9Dz+tNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/tricore: Use little-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Wed, Dec 24, 2025 at 6:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build the TriCore target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
>
> Mechanical change running:
>
>   $ tgt=3Dtricore; \
>     end=3Dle; \
>     for op in data mmuidx_ra; do \
>       for ac in uw sw l q; do \
>         sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>       for ac in w l q; do \
>         sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>     done
>
> Then adapting spaces style manually to pass checkpatch.pl.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 76 deletions(-)
>
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index 2c8281a67e0..3cff5000c73 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -2451,84 +2451,84 @@ static bool cdc_zero(uint32_t *psw)
>
>  static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
>  {
> -    cpu_stl_data(env, ea, env->PCXI);
> -    cpu_stl_data(env, ea+4, psw_read(env));
> -    cpu_stl_data(env, ea+8, env->gpr_a[10]);
> -    cpu_stl_data(env, ea+12, env->gpr_a[11]);
> -    cpu_stl_data(env, ea+16, env->gpr_d[8]);
> -    cpu_stl_data(env, ea+20, env->gpr_d[9]);
> -    cpu_stl_data(env, ea+24, env->gpr_d[10]);
> -    cpu_stl_data(env, ea+28, env->gpr_d[11]);
> -    cpu_stl_data(env, ea+32, env->gpr_a[12]);
> -    cpu_stl_data(env, ea+36, env->gpr_a[13]);
> -    cpu_stl_data(env, ea+40, env->gpr_a[14]);
> -    cpu_stl_data(env, ea+44, env->gpr_a[15]);
> -    cpu_stl_data(env, ea+48, env->gpr_d[12]);
> -    cpu_stl_data(env, ea+52, env->gpr_d[13]);
> -    cpu_stl_data(env, ea+56, env->gpr_d[14]);
> -    cpu_stl_data(env, ea+60, env->gpr_d[15]);
> +    cpu_stl_le_data(env, ea, env->PCXI);
> +    cpu_stl_le_data(env, ea + 4, psw_read(env));
> +    cpu_stl_le_data(env, ea + 8, env->gpr_a[10]);
> +    cpu_stl_le_data(env, ea + 12, env->gpr_a[11]);
> +    cpu_stl_le_data(env, ea + 16, env->gpr_d[8]);
> +    cpu_stl_le_data(env, ea + 20, env->gpr_d[9]);
> +    cpu_stl_le_data(env, ea + 24, env->gpr_d[10]);
> +    cpu_stl_le_data(env, ea + 28, env->gpr_d[11]);
> +    cpu_stl_le_data(env, ea + 32, env->gpr_a[12]);
> +    cpu_stl_le_data(env, ea + 36, env->gpr_a[13]);
> +    cpu_stl_le_data(env, ea + 40, env->gpr_a[14]);
> +    cpu_stl_le_data(env, ea + 44, env->gpr_a[15]);
> +    cpu_stl_le_data(env, ea + 48, env->gpr_d[12]);
> +    cpu_stl_le_data(env, ea + 52, env->gpr_d[13]);
> +    cpu_stl_le_data(env, ea + 56, env->gpr_d[14]);
> +    cpu_stl_le_data(env, ea + 60, env->gpr_d[15]);
>  }
>
>  static void save_context_lower(CPUTriCoreState *env, uint32_t ea)
>  {
> -    cpu_stl_data(env, ea, env->PCXI);
> -    cpu_stl_data(env, ea+4, env->gpr_a[11]);
> -    cpu_stl_data(env, ea+8, env->gpr_a[2]);
> -    cpu_stl_data(env, ea+12, env->gpr_a[3]);
> -    cpu_stl_data(env, ea+16, env->gpr_d[0]);
> -    cpu_stl_data(env, ea+20, env->gpr_d[1]);
> -    cpu_stl_data(env, ea+24, env->gpr_d[2]);
> -    cpu_stl_data(env, ea+28, env->gpr_d[3]);
> -    cpu_stl_data(env, ea+32, env->gpr_a[4]);
> -    cpu_stl_data(env, ea+36, env->gpr_a[5]);
> -    cpu_stl_data(env, ea+40, env->gpr_a[6]);
> -    cpu_stl_data(env, ea+44, env->gpr_a[7]);
> -    cpu_stl_data(env, ea+48, env->gpr_d[4]);
> -    cpu_stl_data(env, ea+52, env->gpr_d[5]);
> -    cpu_stl_data(env, ea+56, env->gpr_d[6]);
> -    cpu_stl_data(env, ea+60, env->gpr_d[7]);
> +    cpu_stl_le_data(env, ea, env->PCXI);
> +    cpu_stl_le_data(env, ea + 4, env->gpr_a[11]);
> +    cpu_stl_le_data(env, ea + 8, env->gpr_a[2]);
> +    cpu_stl_le_data(env, ea + 12, env->gpr_a[3]);
> +    cpu_stl_le_data(env, ea + 16, env->gpr_d[0]);
> +    cpu_stl_le_data(env, ea + 20, env->gpr_d[1]);
> +    cpu_stl_le_data(env, ea + 24, env->gpr_d[2]);
> +    cpu_stl_le_data(env, ea + 28, env->gpr_d[3]);
> +    cpu_stl_le_data(env, ea + 32, env->gpr_a[4]);
> +    cpu_stl_le_data(env, ea + 36, env->gpr_a[5]);
> +    cpu_stl_le_data(env, ea + 40, env->gpr_a[6]);
> +    cpu_stl_le_data(env, ea + 44, env->gpr_a[7]);
> +    cpu_stl_le_data(env, ea + 48, env->gpr_d[4]);
> +    cpu_stl_le_data(env, ea + 52, env->gpr_d[5]);
> +    cpu_stl_le_data(env, ea + 56, env->gpr_d[6]);
> +    cpu_stl_le_data(env, ea + 60, env->gpr_d[7]);
>  }
>
>  static void restore_context_upper(CPUTriCoreState *env, uint32_t ea,
>                                    uint32_t *new_PCXI, uint32_t *new_PSW)
>  {
> -    *new_PCXI =3D cpu_ldl_data(env, ea);
> -    *new_PSW =3D cpu_ldl_data(env, ea+4);
> -    env->gpr_a[10] =3D cpu_ldl_data(env, ea+8);
> -    env->gpr_a[11] =3D cpu_ldl_data(env, ea+12);
> -    env->gpr_d[8]  =3D cpu_ldl_data(env, ea+16);
> -    env->gpr_d[9]  =3D cpu_ldl_data(env, ea+20);
> -    env->gpr_d[10] =3D cpu_ldl_data(env, ea+24);
> -    env->gpr_d[11] =3D cpu_ldl_data(env, ea+28);
> -    env->gpr_a[12] =3D cpu_ldl_data(env, ea+32);
> -    env->gpr_a[13] =3D cpu_ldl_data(env, ea+36);
> -    env->gpr_a[14] =3D cpu_ldl_data(env, ea+40);
> -    env->gpr_a[15] =3D cpu_ldl_data(env, ea+44);
> -    env->gpr_d[12] =3D cpu_ldl_data(env, ea+48);
> -    env->gpr_d[13] =3D cpu_ldl_data(env, ea+52);
> -    env->gpr_d[14] =3D cpu_ldl_data(env, ea+56);
> -    env->gpr_d[15] =3D cpu_ldl_data(env, ea+60);
> +    *new_PCXI =3D cpu_ldl_le_data(env, ea);
> +    *new_PSW =3D cpu_ldl_le_data(env, ea + 4);
> +    env->gpr_a[10] =3D cpu_ldl_le_data(env, ea + 8);
> +    env->gpr_a[11] =3D cpu_ldl_le_data(env, ea + 12);
> +    env->gpr_d[8]  =3D cpu_ldl_le_data(env, ea + 16);
> +    env->gpr_d[9]  =3D cpu_ldl_le_data(env, ea + 20);
> +    env->gpr_d[10] =3D cpu_ldl_le_data(env, ea + 24);
> +    env->gpr_d[11] =3D cpu_ldl_le_data(env, ea + 28);
> +    env->gpr_a[12] =3D cpu_ldl_le_data(env, ea + 32);
> +    env->gpr_a[13] =3D cpu_ldl_le_data(env, ea + 36);
> +    env->gpr_a[14] =3D cpu_ldl_le_data(env, ea + 40);
> +    env->gpr_a[15] =3D cpu_ldl_le_data(env, ea + 44);
> +    env->gpr_d[12] =3D cpu_ldl_le_data(env, ea + 48);
> +    env->gpr_d[13] =3D cpu_ldl_le_data(env, ea + 52);
> +    env->gpr_d[14] =3D cpu_ldl_le_data(env, ea + 56);
> +    env->gpr_d[15] =3D cpu_ldl_le_data(env, ea + 60);
>  }
>
>  static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
>                                    uint32_t *ra, uint32_t *pcxi)
>  {
> -    *pcxi =3D cpu_ldl_data(env, ea);
> -    *ra =3D cpu_ldl_data(env, ea+4);
> -    env->gpr_a[2] =3D cpu_ldl_data(env, ea+8);
> -    env->gpr_a[3] =3D cpu_ldl_data(env, ea+12);
> -    env->gpr_d[0] =3D cpu_ldl_data(env, ea+16);
> -    env->gpr_d[1] =3D cpu_ldl_data(env, ea+20);
> -    env->gpr_d[2] =3D cpu_ldl_data(env, ea+24);
> -    env->gpr_d[3] =3D cpu_ldl_data(env, ea+28);
> -    env->gpr_a[4] =3D cpu_ldl_data(env, ea+32);
> -    env->gpr_a[5] =3D cpu_ldl_data(env, ea+36);
> -    env->gpr_a[6] =3D cpu_ldl_data(env, ea+40);
> -    env->gpr_a[7] =3D cpu_ldl_data(env, ea+44);
> -    env->gpr_d[4] =3D cpu_ldl_data(env, ea+48);
> -    env->gpr_d[5] =3D cpu_ldl_data(env, ea+52);
> -    env->gpr_d[6] =3D cpu_ldl_data(env, ea+56);
> -    env->gpr_d[7] =3D cpu_ldl_data(env, ea+60);
> +    *pcxi =3D cpu_ldl_le_data(env, ea);
> +    *ra =3D cpu_ldl_le_data(env, ea + 4);
> +    env->gpr_a[2] =3D cpu_ldl_le_data(env, ea + 8);
> +    env->gpr_a[3] =3D cpu_ldl_le_data(env, ea + 12);
> +    env->gpr_d[0] =3D cpu_ldl_le_data(env, ea + 16);
> +    env->gpr_d[1] =3D cpu_ldl_le_data(env, ea + 20);
> +    env->gpr_d[2] =3D cpu_ldl_le_data(env, ea + 24);
> +    env->gpr_d[3] =3D cpu_ldl_le_data(env, ea + 28);
> +    env->gpr_a[4] =3D cpu_ldl_le_data(env, ea + 32);
> +    env->gpr_a[5] =3D cpu_ldl_le_data(env, ea + 36);
> +    env->gpr_a[6] =3D cpu_ldl_le_data(env, ea + 40);
> +    env->gpr_a[7] =3D cpu_ldl_le_data(env, ea + 44);
> +    env->gpr_d[4] =3D cpu_ldl_le_data(env, ea + 48);
> +    env->gpr_d[5] =3D cpu_ldl_le_data(env, ea + 52);
> +    env->gpr_d[6] =3D cpu_ldl_le_data(env, ea + 56);
> +    env->gpr_d[7] =3D cpu_ldl_le_data(env, ea + 60);
>  }
>
>  void helper_call(CPUTriCoreState *env, uint32_t next_pc)
> @@ -2566,7 +2566,7 @@ void helper_call(CPUTriCoreState *env, uint32_t nex=
t_pc)
>      ea =3D ((env->FCX & MASK_FCX_FCXS) << 12) +
>           ((env->FCX & MASK_FCX_FCXO) << 6);
>      /* new_FCX =3D M(EA, word); */
> -    new_FCX =3D cpu_ldl_data(env, ea);
> +    new_FCX =3D cpu_ldl_le_data(env, ea);
>      /* M(EA, 16 * word) =3D {PCXI, PSW, A[10], A[11], D[8], D[9], D[10],=
 D[11],
>                             A[12], A[13], A[14], A[15], D[12], D[13], D[1=
4],
>                             D[15]}; */
> @@ -2632,7 +2632,7 @@ void helper_ret(CPUTriCoreState *env)
>          A[13], A[14], A[15], D[12], D[13], D[14], D[15]} =3D M(EA, 16 * =
word); */
>      restore_context_upper(env, ea, &new_PCXI, &new_PSW);
>      /* M(EA, word) =3D FCX; */
> -    cpu_stl_data(env, ea, env->FCX);
> +    cpu_stl_le_data(env, ea, env->FCX);
>      /* FCX[19: 0] =3D PCXI[19: 0]; */
>      env->FCX =3D (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
>      /* PCXI =3D new_PCXI; */
> @@ -2662,7 +2662,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t con=
st9)
>      ea =3D ((env->FCX & 0xf0000) << 12) + ((env->FCX & 0xffff) << 6);
>
>      /* new_FCX =3D M(EA, word); */
> -    new_FCX =3D cpu_ldl_data(env, ea);
> +    new_FCX =3D cpu_ldl_le_data(env, ea);
>      /* M(EA, 16 * word) =3D {PCXI, A[11], A[2], A[3], D[0], D[1], D[2], =
D[3], A[4]
>                             , A[5], A[6], A[7], D[4], D[5], D[6], D[7]}; =
*/
>      save_context_lower(env, ea);
> @@ -2726,7 +2726,7 @@ void helper_rfe(CPUTriCoreState *env)
>        A[13], A[14], A[15], D[12], D[13], D[14], D[15]} =3D M(EA, 16 * wo=
rd); */
>      restore_context_upper(env, ea, &new_PCXI, &new_PSW);
>      /* M(EA, word) =3D FCX;*/
> -    cpu_stl_data(env, ea, env->FCX);
> +    cpu_stl_le_data(env, ea, env->FCX);
>      /* FCX[19: 0] =3D PCXI[19: 0]; */
>      env->FCX =3D (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
>      /* PCXI =3D new_PCXI; */
> @@ -2744,10 +2744,10 @@ void helper_rfm(CPUTriCoreState *env)
>      icr_set_ccpn(env, pcxi_get_pcpn(env));
>
>      /* {PCXI, PSW, A[10], A[11]} =3D M(DCX, 4 * word); */
> -    env->PCXI =3D cpu_ldl_data(env, env->DCX);
> -    psw_write(env, cpu_ldl_data(env, env->DCX+4));
> -    env->gpr_a[10] =3D cpu_ldl_data(env, env->DCX+8);
> -    env->gpr_a[11] =3D cpu_ldl_data(env, env->DCX+12);
> +    env->PCXI =3D cpu_ldl_le_data(env, env->DCX);
> +    psw_write(env, cpu_ldl_le_data(env, env->DCX + 4));
> +    env->gpr_a[10] =3D cpu_ldl_le_data(env, env->DCX + 8);
> +    env->gpr_a[11] =3D cpu_ldl_le_data(env, env->DCX + 12);
>
>      if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>          env->DBGTCR =3D 0;
> @@ -2794,7 +2794,7 @@ void helper_svlcx(CPUTriCoreState *env)
>      ea =3D ((env->FCX & MASK_FCX_FCXS) << 12) +
>           ((env->FCX & MASK_FCX_FCXO) << 6);
>      /* new_FCX =3D M(EA, word); */
> -    new_FCX =3D cpu_ldl_data(env, ea);
> +    new_FCX =3D cpu_ldl_le_data(env, ea);
>      /* M(EA, 16 * word) =3D {PCXI, PSW, A[10], A[11], D[8], D[9], D[10],=
 D[11],
>                             A[12], A[13], A[14], A[15], D[12], D[13], D[1=
4],
>                             D[15]}; */
> @@ -2837,7 +2837,7 @@ void helper_svucx(CPUTriCoreState *env)
>      ea =3D ((env->FCX & MASK_FCX_FCXS) << 12) +
>           ((env->FCX & MASK_FCX_FCXO) << 6);
>      /* new_FCX =3D M(EA, word); */
> -    new_FCX =3D cpu_ldl_data(env, ea);
> +    new_FCX =3D cpu_ldl_le_data(env, ea);
>      /* M(EA, 16 * word) =3D {PCXI, PSW, A[10], A[11], D[8], D[9], D[10],=
 D[11],
>                             A[12], A[13], A[14], A[15], D[12], D[13], D[1=
4],
>                             D[15]}; */
> @@ -2887,9 +2887,9 @@ void helper_rslcx(CPUTriCoreState *env)
>          A[13], A[14], A[15], D[12], D[13], D[14], D[15]} =3D M(EA, 16 * =
word); */
>      restore_context_lower(env, ea, &env->gpr_a[11], &new_PCXI);
>      /* M(EA, word) =3D FCX; */
> -    cpu_stl_data(env, ea, env->FCX);
> +    cpu_stl_le_data(env, ea, env->FCX);
>      /* M(EA, word) =3D FCX; */
> -    cpu_stl_data(env, ea, env->FCX);
> +    cpu_stl_le_data(env, ea, env->FCX);
>      /* FCX[19: 0] =3D PCXI[19: 0]; */
>      env->FCX =3D (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
>      /* PCXI =3D new_PCXI; */
> --
> 2.52.0
>

