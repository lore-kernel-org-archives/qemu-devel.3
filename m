Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5D2D0D145
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWzI-0004pv-Jy; Wed, 07 Jan 2026 12:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vdWyw-0004e9-QI
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:06:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vdWys-00037S-0z
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:06:00 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6079ewkI2988925
 for <qemu-devel@nongnu.org>; Wed, 7 Jan 2026 17:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vxxmsJELyjPy6QHQv3H2P6Eu
 LJGJb9EtQu5xOYP9QrY=; b=l25d0fvkMdI/jcXKT13NCGDWu+c5c7+mlJBS5Gcz
 5etc7ksXyKDK4za3Kcqv8WudpJ4Hk1PsZB554DAB+sv6pkGSAY6F50BjakQOPgDE
 KeX6O3ocK5uytaXxZA8bvFcYXQyAPCuqI+QUclvIl3BFtg9PbQQqu6Och/FcILxC
 4IgNTIO9+gpq+xG3udkMj54NH6tYYNblL18b7CQobK/ZSov9vZAPGL5OEOfXap7K
 xeVxHwBmbH9NbPdsppkCOWQs5XWRLfA/kX+e/d+1hpo0O0iT1vGcqOclzYcEqh/1
 UrVzy/1O68oRO0hyXcqJs2A3F2Nl4BBk8iy1/J8Juqn9oA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2nscj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 17:05:57 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-63e0c5c5faeso3114284d50.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767805557; x=1768410357; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vxxmsJELyjPy6QHQv3H2P6EuLJGJb9EtQu5xOYP9QrY=;
 b=Yer7PJe7Pdts+uKxtPXnyRaS9uhBY4Cy7XS3N42S4lYBfomNrFWgvpe13chUe5FOLi
 +i+e8/HsnrjYIhd5DVyh9eV4If1PSyL0Q7lW5/nkxeHia95+csXb5Rsg5qzRicDoPv3b
 sJD4e7HbeehfdGTqvJA7vyQKfiMvII+0gKtFXd/U5yIxvzD1HhGvX1/Ov6VqjakieQOs
 eT/cb1H+lKcm42DoLvhKI9ErhE9/yIN29+rfgL71REu5mTzQK5lpfGmmHJRvbi4axin7
 oaPuW6dftgpMQ8IAMp4cuRc2MgWwmrUrhXHVHA01c8E/5ZSta4pO7ypO4XZPJbURjNHE
 q7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805557; x=1768410357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxxmsJELyjPy6QHQv3H2P6EuLJGJb9EtQu5xOYP9QrY=;
 b=tsCIfbsYBqj3iAmRHajo2F3Uz+bLiSwcl7v1wkfglyamfoQolEqR9BocGRkdSgva1O
 mco/27qWWMiZ8YtE/DFxpK0/QLJoK2JPtHke/ztp+T9f7Ay2ENnDhMradNVWjrblmt8e
 yO2oAKNSNtssGkx4p8cy51UjRBo++t0su3hSTXvl9FN25pSFnyLO939Q8HgczTttq6Yc
 wf8qqoLEIw4awHncFFWJNf9Tq1LWyHl6G1PIRIDMIkIf8+bQsmWSzPjSc0p2SnaQIy4N
 uAtcrIjPnANVBauTWguAsqT7vFP7C786qv4mLtWTm99D1P7LAKqQnyMQzP1awzr4amvB
 SUGA==
X-Gm-Message-State: AOJu0YyaCyfUtPA3mhXZ5kubcwOzhKJa9xpVEFyd5I0bJYtJo4wLEJOF
 Aw0spo9DS0blrHNmuN1LrjeH749VjbNj4eY5bRA1JQhxSz4FNo4q2BPk4PfJJYkvNyHqfbUuNVZ
 8c2btjkGemaMXA4HsUhcipo1zXXi5Rk48w6uLyoelmy38LgcYZIZiRALycbFbVAx57jraAbkQMf
 e2Jp3t8rwFHIPE0r7/1oJcpAuQm6xsOrJ0
X-Gm-Gg: AY/fxX7OmyriDEVajc4QoJO2MgqmknW6DCESWb6weP/zEcBeq1Ql3zj7sxqx0MsPmjg
 MszBO8p3GcvJIXhtrmOoigVKiZNYpoynxuyFAzhpmK6ri/r15x5ZljizjiGPBWPIcqjAvJvUUL1
 TAC+6F8xt3ZwiWzc5bXmrPKtDlzUyYAMoI841nKDlAmNA2ne9hdcJNZP2F0+TI8Mo//24g
X-Received: by 2002:a05:690e:140f:b0:646:518b:8df3 with SMTP id
 956f58d0204a3-64716b35e7bmr2821804d50.4.1767805556551; 
 Wed, 07 Jan 2026 09:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4QhwH/Jkh4NGOyFa1xzAHbRlluCXY/W5oH9+9FJ771m0Z8xKTtBF8YExjPch8O9H7fUtwgoMmQdXPua6eFtw=
X-Received: by 2002:a05:690e:140f:b0:646:518b:8df3 with SMTP id
 956f58d0204a3-64716b35e7bmr2821790d50.4.1767805556172; Wed, 07 Jan 2026
 09:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-2-philmd@linaro.org>
In-Reply-To: <20251224160708.89085-2-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 11:05:40 -0600
X-Gm-Features: AQt7F2oSPxLXuNgx6tmhFIv4TCfC54RoQTauyhQITDS9GMuSTc1dNCXrKGxf9no
Message-ID: <CAEqNhNZt3aGo9NyZqboyRrPz9DK6rG3V718V_imiGi=XqD5RyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/hexagon: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000353aec0647cf4ee0"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEzNSBTYWx0ZWRfXxS4ElshUvBo7
 fZew8tJ3g/NLj1j0LFLE5FyUESJlyd+c4nUVcRq3cInOWZONdbg1JZq1J7cPhZRveC4BZyuhjDq
 oMjw2CvN1ajXvqNhzO8qCJM9IcQDNfStx1hXhBsfhOh02zgIWnh6AjTX94kak8gkT9+NB7PR03B
 hHNLe54ZMOEnYvTeBKQbjcXyQlTsc3ftTAUyRTTj6sJwjRAaB0cbeRtSnyF60pP5UjNZJ4Qz5Aj
 6C/lkNPCfSFPo13mJe8ZfGWaqxFsr1vpOW1eQOvAR9zgJS9hOjwiyTB9gXjIRNZmjXZwNI06Ty1
 ALlwmpYPqVcHyfjmOEswy5K7ZMqKPKdUVDs5lWQ7uyi6hh+YdSAh2bjEiwH8dowamM3QACtePSN
 Y/DGjKdaB4yhklF4+2SF3BvB5xxL7KyKuogLHVVBoADsooGqSQrzOz0ZWGjeLunGFeAkZrM7jkL
 so2gUMdc430G0qXwnnA==
X-Authority-Analysis: v=2.4 cv=CYEFJbrl c=1 sm=1 tr=0 ts=695e9275 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=fIa1KnOOv_DP7zG4_SMA:9 a=QEXdDO2ut3YA:10 a=4dN6xpogHmLD9u_Te1kA:9
 a=PbZoswaFZibY5DkV:21 a=lqcHg5cX4UMA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: L1RMJBEz_Ceot1N1_zjRYRmtrs2tPhcX
X-Proofpoint-ORIG-GUID: L1RMJBEz_Ceot1N1_zjRYRmtrs2tPhcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070135
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000353aec0647cf4ee0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 10:07=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> translator_ldl() is defined in "exec/translator.h" as:
>
>   198 static inline uint32_t
>   199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   200 {
>   201     return translator_ldl_end(env, db, pc, MO_TE);
>   202 }
>
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since Hexagon use little-endian order.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

 target/hexagon/translate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8fce219c0de..c37035c4774 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env,
> DisasContext *ctx,
>      memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
>      for (nwords =3D 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++=
) {
>          words[nwords] =3D
> -            translator_ldl(env, &ctx->base,
> -                           ctx->base.pc_next + nwords * sizeof(uint32_t)=
);
> +            translator_ldl_end(env, &ctx->base,
> +                               ctx->base.pc_next + nwords *
> sizeof(uint32_t),
> +                               MO_LE);
>          found_end =3D is_packet_end(words[nwords]);
>      }
>      if (!found_end) {
> @@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env,
> DisasContext *ctx)
>      int nwords;
>
>      for (nwords =3D 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++=
) {
> -        uint32_t word =3D translator_ldl(env, &ctx->base,
> -                            ctx->base.pc_next + nwords *
> sizeof(uint32_t));
> +        uint32_t word =3D translator_ldl_end(env, &ctx->base,
> +                                           ctx->base.pc_next
> +                                           + nwords * sizeof(uint32_t),
> +                                           MO_LE);
>          found_end =3D is_packet_end(word);
>      }
>      uint32_t next_ptr =3D  ctx->base.pc_next + nwords * sizeof(uint32_t)=
;
> --
> 2.52.0
>
>

--000000000000353aec0647cf4ee0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 24, 2025 at=
 10:07=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">translator_ldl() is defined in &quot;exec/tran=
slator.h&quot; as:<br>
<br>
=C2=A0 198 static inline uint32_t<br>
=C2=A0 199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc=
)<br>
=C2=A0 200 {<br>
=C2=A0 201=C2=A0 =C2=A0 =C2=A0return translator_ldl_end(env, db, pc, MO_TE)=
;<br>
=C2=A0 202 }<br>
<br>
Directly use the inlined form, expanding MO_TE -&gt; MO_LE<br>
since Hexagon use little-endian order.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.ca=
in@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><div class=3D=
"gmail_default" style=3D"font-family:monospace"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/translate.c | 11 +++++++----<br>
=C2=A01 file changed, 7 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 8fce219c0de..c37035c4774 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env, Disa=
sContext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));<=
br>
=C2=A0 =C2=A0 =C2=A0for (nwords =3D 0; !found_end &amp;&amp; nwords &lt; PA=
CKET_WORDS_MAX; nwords++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0words[nwords] =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translator_ldl(env, &amp;ctx-&gt=
;base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;base.pc_next + nwords * sizeof(uint32_t));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translator_ldl_end(env, &amp;ctx=
-&gt;base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;base.pc_next + nwords * sizeo=
f(uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MO_LE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found_end =3D is_packet_end(words[nwords]=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (!found_end) {<br>
@@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, Dis=
asContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0int nwords;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (nwords =3D 0; !found_end &amp;&amp; nwords &lt; PA=
CKET_WORDS_MAX; nwords++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t word =3D translator_ldl(env, &amp;ctx=
-&gt;base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.pc_next + nwords * sizeof(uint32_t));=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t word =3D translator_ldl_end(env, &amp=
;ctx-&gt;base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ctx-&gt;base.pc_next<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+ nwords * sizeof(uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MO_LE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found_end =3D is_packet_end(word);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0uint32_t next_ptr =3D=C2=A0 ctx-&gt;base.pc_next + nwor=
ds * sizeof(uint32_t);<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--000000000000353aec0647cf4ee0--

