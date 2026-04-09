Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8213E10FC45F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcrk-00029B-1D; Wed, 08 Apr 2026 20:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcrh-00028Q-E9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 20:03:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcrd-0006Sh-GQ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 20:03:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2adbfab4501so1674315ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 17:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775692996; cv=none;
 d=google.com; s=arc-20240605;
 b=j4lXiCmt9lsIVxUmfHs1fLsCgrNRklg7OtiXqpiyFaRl3v6IxXmkXiCWoAKFe/WWia
 nFr3LDdahBxQgg6hvPtPER8RZ9gToBb9AjpTDsuYNohI7agEK2dnUERYm+ZvnuWBrDzY
 ysc/ONH/zFFxQAUmvJGBsKPoXl6CwewC8LPCbC5heXXkxPJSwc/f13HDxkwrRCDESWSs
 EY9H8Sud0FRZGdqnuFT6uvny+5yuntE6aNnpnHnKdAy5yGAlzbZTZyuWVghMJtoQdrTH
 nggNLJO9bLu2QRKdcU+rr1Ml/j6+daccLPGVuhdi3ZA8KL8w76eXj+/Q6vo+/wqHQz5k
 KsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MmmZCom89amzIydKcUlIxGRCmvpijas64e9OekumU44=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=UIltWvBl/WjuwtWSGkrPLte6pjN9Y9TsKAGo6Hy01vxgrKzy3QsqjaL7EFNWkCJfZE
 jF8WXt0NbyeoGTotxO+g+M22s9Z4MLJPHo2mTee++uBvvG/2tcCwQZtufVYsGeRKOFdV
 VZy6jXunO5fNxMomvaOxVQeu1iCRTBYwCXDoUXTMrd6zp7ktxXO0GHTsRZLIXC7DjtEo
 AgD+zEpiaQD4qulitxiF6P8nt+wcn7EMukJsSR2cpkrWetj05AtaS+mh2Z6MLW9pFykD
 MqHVWqtieBLGcDCuv/oRCd0OUO5xZe+C65A5Hwp8OWmsWNvxyku/4/2u3BfetjxF/bBF
 vnhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775692996; x=1776297796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MmmZCom89amzIydKcUlIxGRCmvpijas64e9OekumU44=;
 b=A8Le6VVdDPiWhgTxUZNv7OXfU/JIwvmbj7fxMBNyvv4Yr87LLHAYG5XqPkMsD0jpkN
 0Luom/21LPSDpVmpVk/EcgLmgflcV21aijdD95bCziv+xyr0HUnR7V+svvoPIIYd0h1G
 HJQ/eQruotqO97jJDem5Qp0WU7aKOQpRi4VuDGhKppfPz2fli/pva0wZLBQ6bsUWCmWP
 uzIM5uKpgWAmJZnK5VdKOyWO2E1W26pNtdn9M8J7j3IpcIkD5WjEnEsmwd8g8lFbahCr
 3j6ELD19DSmnMOutiBAih+J6SEjxXuo07aohLjQPI5rDt1vTKrs9rcPN5zPN5px5gzPR
 AVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775692996; x=1776297796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmmZCom89amzIydKcUlIxGRCmvpijas64e9OekumU44=;
 b=HQNcDalqejoScokQuMwF1kJVN9LE18DtQt7Hiq5mlz8tiegGYTc4Arvu0iM6n5/4Ba
 wXgv/RyZ+x6qIDzcPpj13QqbuhQNps0mpIbpuySsAdoACQ75glLOYr+br078LmwWQe8U
 DBwqOQxvmg0TMc8YalPnSlmrwuLtbII+1ZLPZ2LVieyXjG2a/3a8ZBCpJMsshrOo3MT8
 z4AQXBMVNYJZbCyLZqlvmDt6ueNNpsvj0vtVs5c1zov355/yGTl0A0tsrJYTxQQLRsRE
 fOR/HcZTTLYlZOOoXOQW7QlABOtnZw5TIgh2iaIAAUheAr8kIggmysW0EgUEWPo46/Bg
 u49g==
X-Gm-Message-State: AOJu0YyhSyZsVD7OcrYbWNABH72heWYFZCOxJ0J3jISrdjtgrz5ADmnM
 wZXveYm1du/2hn2V8SYgKBj5nZA0uYvQnE1AHIEPrUh+knsniyZ5Lrb/NSbjDZNVQBSuQXX4jIs
 r4WTwkUtAXUNAuWHg8mFkDkhlk7pxQmg=
X-Gm-Gg: AeBDievJWgZiJuWR9aKUnQbtl3TgpkI0FdZ6XZyYdJQbCwGOlE2yB3egOUZku+S7veL
 +erkrxOIa68y64jZQy+wnV2x7uEx8IzpHDCRYBQcXFU0InDbxzNxJnAN+AXVD7XudA2XI/iDrAB
 C9y/ETD1QQ/03MpnXhf8OyVPOTiByG2prHFLtRj4gGB9GLOBphZHsOHpQEfMsg9NTFbj7PB/OLF
 PecIksR7JJyag9hYghNw0vB9H0oJ5ieqb5/PdS92Xt34B2WoQ9/tMGzfwyG/thN6eDQgV4LXZa8
 l8VMng8Zh4EP3+BkdlgUYxcwi3Pqj1YwIUJmpaU=
X-Received: by 2002:a17:902:c20b:b0:2b2:6cab:313c with SMTP id
 d9443c01a7336-2b2c73c6258mr10077085ad.20.1775692995802; Wed, 08 Apr 2026
 17:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <f84d180547f96f809684e858861086dc6dab9ed8.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <f84d180547f96f809684e858861086dc6dab9ed8.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 18:03:04 -0600
X-Gm-Features: AQROBzAFMr9oqD4ItV8UcHiXiGb82J2ttQBlEw4fKtooFoevvdemXxGtssrQCfo
Message-ID: <CAATN3NpFSDHkRepdeJK2bt6KgtrAFP=QG1hO6g0fO53HqQ_1Dg@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000003eba78064efbbeb7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000003eba78064efbbeb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE bfloat16 (bf16) instructions:
>
> Arithmetic operations:
> - V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output
> - V6_vmpy_sf_bf: multiply bf16 widening to sf output
> - V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output
>
> Min/Max operations:
> - V6_vmin_bf, V6_vmax_bf: bf16 min/max
>
> Comparison operations:
> - V6_vgtbf: greater-than compare
> - V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants
>
> Conversion operations:
> - V6_vcvt_bf_sf: convert sf to bf16
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           | 37 ++++++++++++
>  target/hexagon/mmvec/macros.h                |  4 ++
>  target/hexagon/mmvec/mmvec.h                 |  1 +
>  target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
>  target/hexagon/imported/mmvec/ext.idef       | 62 ++++++++++++++++++++
>  5 files changed, 119 insertions(+)
>
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h
> b/target/hexagon/mmvec/hvx_ieee_fp.h
> index ad854b905d..21883c0fad 100644
> --- a/target/hexagon/mmvec/hvx_ieee_fp.h
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.h
> @@ -9,8 +9,11 @@
>
>  #include "fpu/softfloat.h"
>
> +#define FP32_DEF_NAN 0x7FFFFFFF
> +
>  #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
>  #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
> +#define bf_to_sf(A) bfloat16_to_float32(A, &env->hvx_fp_status)
>

Better to follow the naming convention of the previous macros
    bf16_to_f32


>
>  float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
>  float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
> @@ -29,4 +32,38 @@ int16_t conv_h_hf(float16 a, float_status *fp_status);
>  uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
>  uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>
> +/* IEEE BFloat instructions */
> +
> +#define fp_mult_sf_bf(A, B) \
> +    float32_mul(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
> +
> +#define fp_add_sf_bf(A, B) \
> +    float32_add(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
> +
> +#define fp_sub_sf_bf(A, B) \
> +    float32_sub(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
> +
> +#define fp_mult_sf_bf_acc(f1, f2, f3) \
> +    float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, &env->hvx_fp_statu=
s)
> +
> +static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)
>

Use bfloat16 instead of uint16_t and float32 instead of int32_t.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000003eba78064efbbeb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE bfloat16 (bf16) instructions:<br>
<br>
Arithmetic operations:<br>
- V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output<br>
- V6_vmpy_sf_bf: multiply bf16 widening to sf output<br>
- V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output<br>
<br>
Min/Max operations:<br>
- V6_vmin_bf, V6_vmax_bf: bf16 min/max<br>
<br>
Comparison operations:<br>
- V6_vgtbf: greater-than compare<br>
- V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants<br>
<br>
Conversion operations:<br>
- V6_vcvt_bf_sf: convert sf to bf16<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 37 ++++++++++++<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++<br>
=C2=A0target/hexagon/mmvec/mmvec.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 15 +++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 62=
 ++++++++++++++++++++<br>
=C2=A05 files changed, 119 insertions(+)<br>
<br>
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_=
ieee_fp.h<br>
index ad854b905d..21883c0fad 100644<br>
--- a/target/hexagon/mmvec/hvx_ieee_fp.h<br>
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h<br>
@@ -9,8 +9,11 @@<br>
<br>
=C2=A0#include &quot;fpu/softfloat.h&quot;<br>
<br>
+#define FP32_DEF_NAN 0x7FFFFFFF<br>
+<br>
=C2=A0#define f16_to_f32(A) float16_to_float32((A), true, &amp;env-&gt;hvx_=
fp_status)<br>
=C2=A0#define f32_to_f16(A) float32_to_float16((A), true, &amp;env-&gt;hvx_=
fp_status)<br>
+#define bf_to_sf(A) bfloat16_to_float32(A, &amp;env-&gt;hvx_fp_status)<br>=
</blockquote><div><br></div><div>Better to follow the naming convention of =
the previous macros</div><div>=C2=A0 =C2=A0 bf16_to_f32</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status=
);<br>
=C2=A0float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,<br>
@@ -29,4 +32,38 @@ int16_t conv_h_hf(float16 a, float_status *fp_status);<b=
r>
=C2=A0uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);=
<br>
=C2=A0uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);=
<br>
<br>
+/* IEEE BFloat instructions */<br>
+<br>
+#define fp_mult_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 float32_mul(bf_to_sf(A), bf_to_sf(B), &amp;env-&gt;hvx_fp_st=
atus)<br>
+<br>
+#define fp_add_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 float32_add(bf_to_sf(A), bf_to_sf(B), &amp;env-&gt;hvx_fp_st=
atus)<br>
+<br>
+#define fp_sub_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 float32_sub(bf_to_sf(A), bf_to_sf(B), &amp;env-&gt;hvx_fp_st=
atus)<br>
+<br>
+#define fp_mult_sf_bf_acc(f1, f2, f3) \<br>
+=C2=A0 =C2=A0 float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, &amp;env-&=
gt;hvx_fp_status)<br>
+<br>
+static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)<br></b=
lockquote><div><br></div><div>Use bfloat16 instead of uint16_t and float32 =
instead of int32_t.</div><div>=C2=A0</div><div>Otherwise</div><div>Reviewed=
-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylor=
simpson@gmail.com</a>&gt;</div><div><br></div></div></div>

--0000000000003eba78064efbbeb7--

