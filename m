Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CEEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3Nu-0002D3-26; Tue, 26 Mar 2024 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rp3Ns-0002Cl-K0
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:46:20 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rp3No-00056o-W8
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711446374; x=1712051174; i=deller@gmx.de;
 bh=NUrMDPjKSCQEldPSWHKFIAQq+w45+qWPJa928kOTj5Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=A6T/YN6kLUoLydDZyQzVt3eM7RllJuTVHi2itt4FZ3QUfg/AHvIwOe9sl4pswOec
 QO9ZrY/UApkLXA2foB/U+T4GrgfLunNRRJeJY8ym12U47qMZTij7xRc4rkdSVmJPi
 E7izdYaDRy1mrWR70lNhnHWDaFcb3seS54ko9l2zoxRk6/sZj9oV+gOjdmzzu/qIw
 miGuglgjRx1+hYufRmGaSd09blgpxCqbEUMAWneSAuz7haTxYAIk1/8LqszcUy/Kc
 CqObKIQ92071OL0WTF3orwEf/rMB1QYUPokUHG10mJQfq5ryCVyjK/JvEoHwVo8nU
 eSirb43HSO5mJNGquw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1sj4qg08Vg-00uFXR; Tue, 26
 Mar 2024 10:46:14 +0100
Message-ID: <11ad662e-1da3-4061-b39c-4a289d151852@gmx.de>
Date: Tue, 26 Mar 2024 10:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: Squash d for pa1.x during decode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240326064405.320551-1-richard.henderson@linaro.org>
 <20240326064405.320551-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240326064405.320551-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E4LEkJLpH0ia8dUdhL1M7iAR51lisLKdY6E0lCyhHW45QzJHufb
 0ni9i0cTVWH8TA3v0aiLKpDF+P/j10wPfgtya6v9expmq/5XzvASvvqKTzWX5ZUZG2H/0ZQ
 8JL4ARQRuonmO/VwnTEMY6oo7PrFxlzxHsguyWwmWzRoSJHIMEcoV/6WbTObC1DOmxUe7fb
 yfCAoOIYaupggsEPs5BRg==
UI-OutboundReport: notjunk:1;M01:P0:RAMFZf253+w=;QLixgNmD0UNALZpBz5mwm8Xq04D
 ECxQXDSxW6ZjkSN/nI9B29WVBeUV4fwMsnrNK3HeJpi5V0/4HU0KNlQONfi6QytzViEHfjjCq
 kkK2dAUEh6RwrijgjaWKaV1Ou+7nXVGz9x6KHNZ3vDa3D3Rm7nsf5e/d2FEftypfS4Ni1Jivk
 EYtnE1sGW1lpRG+VcOHP+75FkgyLfa3WKvtTky11LonwMMuK3yLsz7ffI3uFOnwiAZmeUuLrv
 j5/vaIf5mRuBAzov3kslf11q0a4drVmYKDDfJwdEW3hCmR8OaTA0VHzgg8oAnWTG0E2DIdoyU
 OQc5BW4639m6CWiRBZhBzrUiRcGjDZb1LPcrSb8fewY3Ae0yan/HqYtQNXxs6lmEBLbinBhm5
 VKFOe2yD0iEvZGDSvlWuYrnmPmERxWK1u510vjdcwPtFxfA4GZMPKadYAxERzfiQH6PP6Sxm/
 wNgJ6nrP/6iguHOlcVGlbsw4vx1l/HC+eoLrOy1yx6rftRes6sPUbyv/l4n0GsoZb0U0Fk4p4
 t1uDsrRiEGqMJJEyKyOj53ognxdI2DIS/5JIA+Ii2kMq8to+CPXf1Oh+0u2O9DEmMG6dj9nuJ
 I/ju7jkuaNvFEyCa/csu7uJMQzOFIlgMQknWqtR17OlLrN+u65qt+fasuuwsJV81DcpfSC7wP
 +r1K+InopZr7dK1osR/U2ZxtWvfAiPFBtX/vQGM/ZfNCHYvooKNKGrL/DkOGE95xgYsmrVk3g
 ehplSJzMxAtgt0itGKnQiJKW+EZStNCD/Xr3dwOsvWnC98Wmx43n1iPZduK6ZQ0t1IoJepeYv
 qyzhTe8oy33dtubH7eADNPZr92O92x8FRnIl/JKbg9UUc=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/26/24 07:44, Richard Henderson wrote:
> The cond_need_ext predicate was created while we still had a
> 32-bit compilation mode.  It now makes more sense to treat D
> as an absolute indicator of a 64-bit operation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Helge


> ---
>   target/hppa/insns.decode | 20 +++++++++++++-------
>   target/hppa/translate.c  | 38 ++++++++++++++++++++------------------
>   2 files changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index f58455dfdb..6a74cf23cd 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -57,6 +57,9 @@
>   %neg_to_m       0:1      !function=3Dneg_to_m
>   %a_to_m         2:1      !function=3Dneg_to_m
>   %cmpbid_c       13:2     !function=3Dcmpbid_c
> +%d_5            5:1      !function=3Dpa20_d
> +%d_11           11:1     !function=3Dpa20_d
> +%d_13           13:1     !function=3Dpa20_d
>
>   ####
>   # Argument set definitions
> @@ -84,15 +87,16 @@
>   # Format definitions
>   ####
>
> -@rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
> +@rr_cf_d        ...... r:5 ..... cf:4 ...... . t:5      &rr_cf_d d=3D%d=
_5
>   @rrr            ...... r2:5 r1:5 .... ....... t:5       &rrr
>   @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
> -@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
> +@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... . t:5      &rrr_cf_d d=3D%=
d_5
>   @rrr_sh         ...... r2:5 r1:5 ........ sh:2 . t:5    &rrr_sh
> -@rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
> -@rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d_sh sh=
=3D0
> +@rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_d_sh d=
=3D%d_5
> +@rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... . t:5      &rrr_cf_d_sh d=
=3D%d_5 sh=3D0
>   @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=3D%l=
owsign_11
> -@rri_cf_d       ...... r:5  t:5  cf:4 d:1 ...........   &rri_cf_d i=3D%=
lowsign_11
> +@rri_cf_d       ...... r:5  t:5  cf:4 . ...........     \
> +                &rri_cf_d d=3D%d_11 i=3D%lowsign_11
>
>   @rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
>                   &rrb_c_f disp=3D%assemble_12
> @@ -368,8 +372,10 @@ fmpysub_d       100110 ..... ..... ..... ..... 1 ..=
...  @mpyadd
>   # Conditional Branches
>   ####
>
> -bb_sar          110000 00000 r:5 c:1 1 d:1 ........... n:1 . disp=3D%as=
semble_12
> -bb_imm          110001 p:5   r:5 c:1 1 d:1 ........... n:1 . disp=3D%as=
semble_12
> +bb_sar          110000 00000 r:5 c:1 1 . ........... n:1 . \
> +                disp=3D%assemble_12 d=3D%d_13
> +bb_imm          110001 p:5   r:5 c:1 1 . ........... n:1 . \
> +                disp=3D%assemble_12 d=3D%d_13
>
>   movb            110010 ..... ..... ... ........... . .  @rrb_cf f=3D0
>   movbi           110011 ..... ..... ... ........... . .  @rib_cf f=3D0
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 99c5c4cbca..a70d644c0b 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -200,6 +200,14 @@ static int cmpbid_c(DisasContext *ctx, int val)
>       return val ? val : 4; /* 0 =3D=3D "*<<" */
>   }
>
> +/*
> + * In many places pa1.x did not decode the bit that later became
> + * the pa2.0 D bit.  Suppress D unless the cpu is pa2.0.
> + */
> +static int pa20_d(DisasContext *ctx, int val)
> +{
> +    return ctx->is_pa20 & val;
> +}
>
>   /* Include the auto-generated decoder.  */
>   #include "decode-insns.c.inc"
> @@ -693,12 +701,6 @@ static bool cond_need_cb(int c)
>       return c =3D=3D 4 || c =3D=3D 5;
>   }
>
> -/* Need extensions from TCGv_i32 to TCGv_i64. */
> -static bool cond_need_ext(DisasContext *ctx, bool d)
> -{
> -    return !(ctx->is_pa20 && d);
> -}
> -
>   /*
>    * Compute conditional for arithmetic.  See Page 5-3, Table 5-1, of
>    * the Parisc 1.1 Architecture Reference Manual for details.
> @@ -715,7 +717,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned=
 cf, bool d,
>           cond =3D cond_make_f();
>           break;
>       case 1: /* =3D / <>        (Z / !Z) */
> -        if (cond_need_ext(ctx, d)) {
> +        if (!d) {
>               tmp =3D tcg_temp_new_i64();
>               tcg_gen_ext32u_i64(tmp, res);
>               res =3D tmp;
> @@ -725,7 +727,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned=
 cf, bool d,
>       case 2: /* < / >=3D        (N ^ V / !(N ^ V) */
>           tmp =3D tcg_temp_new_i64();
>           tcg_gen_xor_i64(tmp, res, sv);
> -        if (cond_need_ext(ctx, d)) {
> +        if (!d) {
>               tcg_gen_ext32s_i64(tmp, tmp);
>           }
>           cond =3D cond_make_0_tmp(TCG_COND_LT, tmp);
> @@ -742,7 +744,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned=
 cf, bool d,
>            */
>           tmp =3D tcg_temp_new_i64();
>           tcg_gen_eqv_i64(tmp, res, sv);
> -        if (cond_need_ext(ctx, d)) {
> +        if (!d) {
>               tcg_gen_sextract_i64(tmp, tmp, 31, 1);
>               tcg_gen_and_i64(tmp, tmp, res);
>               tcg_gen_ext32u_i64(tmp, tmp);
> @@ -760,13 +762,13 @@ static DisasCond do_cond(DisasContext *ctx, unsign=
ed cf, bool d,
>           tmp =3D tcg_temp_new_i64();
>           tcg_gen_neg_i64(tmp, cb_msb);
>           tcg_gen_and_i64(tmp, tmp, res);
> -        if (cond_need_ext(ctx, d)) {
> +        if (!d) {
>               tcg_gen_ext32u_i64(tmp, tmp);
>           }
>           cond =3D cond_make_0_tmp(TCG_COND_EQ, tmp);
>           break;
>       case 6: /* SV / NSV      (V / !V) */
> -        if (cond_need_ext(ctx, d)) {
> +        if (!d) {
>               tmp =3D tcg_temp_new_i64();
>               tcg_gen_ext32s_i64(tmp, sv);
>               sv =3D tmp;
> @@ -827,7 +829,7 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsi=
gned cf, bool d,
>       if (cf & 1) {
>           tc =3D tcg_invert_cond(tc);
>       }
> -    if (cond_need_ext(ctx, d)) {
> +    if (!d) {
>           TCGv_i64 t1 =3D tcg_temp_new_i64();
>           TCGv_i64 t2 =3D tcg_temp_new_i64();
>
> @@ -904,7 +906,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsi=
gned cf, bool d,
>           g_assert_not_reached();
>       }
>
> -    if (cond_need_ext(ctx, d)) {
> +    if (!d) {
>           TCGv_i64 tmp =3D tcg_temp_new_i64();
>
>           if (ext_uns) {
> @@ -979,7 +981,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool=
 d, TCGv_i64 res)
>   static TCGv_i64 get_carry(DisasContext *ctx, bool d,
>                             TCGv_i64 cb, TCGv_i64 cb_msb)
>   {
> -    if (cond_need_ext(ctx, d)) {
> +    if (!d) {
>           TCGv_i64 t =3D tcg_temp_new_i64();
>           tcg_gen_extract_i64(t, cb, 32, 1);
>           return t;
> @@ -3448,12 +3450,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_=
bb_sar *a)
>
>       tmp =3D tcg_temp_new_i64();
>       tcg_r =3D load_gpr(ctx, a->r);
> -    if (cond_need_ext(ctx, a->d)) {
> +    if (a->d) {
> +        tcg_gen_shl_i64(tmp, tcg_r, cpu_sar);
> +    } else {
>           /* Force shift into [32,63] */
>           tcg_gen_ori_i64(tmp, cpu_sar, 32);
>           tcg_gen_shl_i64(tmp, tcg_r, tmp);
> -    } else {
> -        tcg_gen_shl_i64(tmp, tcg_r, cpu_sar);
>       }
>
>       cond =3D cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
> @@ -3470,7 +3472,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb=
_imm *a)
>
>       tmp =3D tcg_temp_new_i64();
>       tcg_r =3D load_gpr(ctx, a->r);
> -    p =3D a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
> +    p =3D a->p | (a->d ? 0 : 32);
>       tcg_gen_shli_i64(tmp, tcg_r, p);
>
>       cond =3D cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);


