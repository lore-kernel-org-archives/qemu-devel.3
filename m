Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64346C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjA6-0002z2-3W; Fri, 05 Apr 2024 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsjA4-0002yf-7e
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:59:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsjA1-0003r4-8U
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:59:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e0c00e7fcso2439233a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321952; x=1712926752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pUnmbhB6cyH/A3q15gyJDZupFO2j/Maq9BGTlqufpW8=;
 b=f7xkpNur0kKHxlug58BGk4Hh3zjr4I86AcPaiZtZ69pTJV5J+kkaybKAByp4cIg3HB
 x2kzJaTNDhOFzSvhzdTdQCsiKPtuI6H6UuE1eXPKmXNzEhYjYi1ahXWZWWNLAR7wSUCS
 lrx/BOqpyCgXMSMwpQzGOnNIuiavu+SfDJpryewbxzLmgjAdMfFwW/+CgryzjUQEeJ/T
 2FZPBeWd2yPN6VqqzGqoqCb1mDVrphp4Y3zuOVYeyTIzDYP4+ZVzrRpgGRQjV0R2UaM/
 IRjJMO95FSBF/cvd3aP8AISg+h7p6RiRKKdd22Sy6S3SDIK44G4CBk4wGV16+4fqpeU0
 nM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321952; x=1712926752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUnmbhB6cyH/A3q15gyJDZupFO2j/Maq9BGTlqufpW8=;
 b=eMcN14U6Aa6SA4jC3XJ+qF4vlwvU9MYbMXJTMfMAkW8BN8qqwB1tTlkhGUFNamVuP5
 qg09FRcyEDsAcICn/bAwz7gB9YYGmWaEZxgYmgq0DuYhdUGe92zvCnH8Fy6d8vU0AqdS
 rXGMz9/5E0LZneIP3QxbKh3jys34ABE4rbeusaytXX/7O96StdVmOt5M6lfZkedCE5vv
 Mnh3LF0sNxk82bmlS5Fx0twLJrvG5iY+IUg7J4tIhdCIfYRYSt+7Kx1vq4ulRnuI6agj
 f6/tmcO+njd0Qqiw8t98++kU3C+RL1E9tZzwjei26B4/53Uf+jBxb0vrdeANMx09/TAE
 h9Jg==
X-Gm-Message-State: AOJu0YyUHfeUYISok/ftdiMXvOxmv2sswkMvtgAutCSbok2auaJgtL3w
 lrm7NUMWyUUSOh0/4Bvhsd8ViT3NBZAB7RkrwWAOxVs8//+e/JNyKOu0NKjH7iOmyLK83FCuGL1
 CJaWP9XPDCqijR+3FEPk5LdgCzWnVwVn7ANV13RiB
X-Google-Smtp-Source: AGHT+IE6CVTmXM4Lu090LAcxZ8eaAncjAAoeohonrUdi+Iz2eRLuk5hNbaYKGOhh//mWN5x7dQDSXPuEsPQoPYAknBU=
X-Received: by 2002:a50:cc86:0:b0:568:a4b6:9828 with SMTP id
 q6-20020a50cc86000000b00568a4b69828mr1061157edi.30.1712321951493; Fri, 05 Apr
 2024 05:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-29-richard.henderson@linaro.org>
In-Reply-To: <20240405102459.462551-29-richard.henderson@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 5 Apr 2024 14:58:59 +0200
Message-ID: <CAJy5ezqHhxTDB+8Q=g6qrpoQzv9eBkff=ZZHNTmj41PfXO4f+w@mail.gmail.com>
Subject: Re: [PATCH 28/32] target/cris: Use cris_fetch in translate_v10.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a8f503061559050c"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x531.google.com
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

--000000000000a8f503061559050c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/cris/translate.c         |  1 -
>  target/cris/translate_v10.c.inc | 30 +++++++++---------------------
>  2 files changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index bb2d6612ba..a30c67eb07 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -29,7 +29,6 @@
>  #include "tcg/tcg-op.h"
>  #include "exec/helper-proto.h"
>  #include "mmu.h"
> -#include "exec/cpu_ldst.h"
>  #include "exec/translator.h"
>  #include "crisv32-decode.h"
>  #include "qemu/qemu-print.h"
> diff --git a/target/cris/translate_v10.c.inc
> b/target/cris/translate_v10.c.inc
> index 73fc27c15d..c15ff47505 100644
> --- a/target/cris/translate_v10.c.inc
> +++ b/target/cris/translate_v10.c.inc
> @@ -165,20 +165,7 @@ static int dec10_prep_move_m(CPUCRISState *env,
> DisasContext *dc,
>
>      /* Load [$rs] onto T1.  */
>      if (is_imm) {
> -        if (memsize !=3D 4) {
> -            if (s_ext) {
> -                if (memsize =3D=3D 1)
> -                    imm =3D cpu_ldsb_code(env, dc->pc + 2);
> -                else
> -                    imm =3D cpu_ldsw_code(env, dc->pc + 2);
> -            } else {
> -                if (memsize =3D=3D 1)
> -                    imm =3D cpu_ldub_code(env, dc->pc + 2);
> -                else
> -                    imm =3D cpu_lduw_code(env, dc->pc + 2);
> -            }
> -        } else
> -            imm =3D cpu_ldl_code(env, dc->pc + 2);
> +        imm =3D cris_fetch(env, dc, dc->pc + 2, memsize, s_ext);
>
>          tcg_gen_movi_tl(dst, imm);
>
> @@ -929,10 +916,11 @@ static int dec10_dip(CPUCRISState *env, DisasContex=
t
> *dc)
>      LOG_DIS("dip pc=3D%x opcode=3D%d r%d r%d\n",
>                dc->pc, dc->opcode, dc->src, dc->dst);
>      if (dc->src =3D=3D 15) {
> -        imm =3D cpu_ldl_code(env, dc->pc + 2);
> +        imm =3D cris_fetch(env, dc, dc->pc + 2, 4, 0);
>          tcg_gen_movi_tl(cpu_PR[PR_PREFIX], imm);
> -        if (dc->postinc)
> +        if (dc->postinc) {
>              insn_len +=3D 4;
> +        }
>          tcg_gen_addi_tl(cpu_R[15], cpu_R[15], insn_len - 2);
>      } else {
>          gen_load(dc, cpu_PR[PR_PREFIX], cpu_R[dc->src], 4, 0);
> @@ -1095,10 +1083,10 @@ static unsigned int dec10_ind(CPUCRISState *env,
> DisasContext *dc)
>              if (dc->src =3D=3D 15) {
>                  LOG_DIS("jump.%d %d r%d r%d direct\n", size,
>                           dc->opcode, dc->src, dc->dst);
> -                imm =3D cpu_ldl_code(env, dc->pc + 2);
> -                if (dc->mode =3D=3D CRISV10_MODE_AUTOINC)
> +                imm =3D cris_fetch(env, dc, dc->pc + 2, size, 0);
> +                if (dc->mode =3D=3D CRISV10_MODE_AUTOINC) {
>                      insn_len +=3D size;
> -
> +                }
>                  c =3D tcg_constant_tl(dc->pc + insn_len);
>                  t_gen_mov_preg_TN(dc, dc->dst, c);
>                  dc->jmp_pc =3D imm;
> @@ -1164,7 +1152,7 @@ static unsigned int dec10_ind(CPUCRISState *env,
> DisasContext *dc)
>          case CRISV10_IND_BCC_M:
>
>              cris_cc_mask(dc, 0);
> -            simm =3D cpu_ldsw_code(env, dc->pc + 2);
> +            simm =3D cris_fetch(env, dc, dc->pc + 2, 2, 1);
>              simm +=3D 4;
>
>              LOG_DIS("bcc_m: b%s %x\n", cc_name(dc->cond), dc->pc + simm)=
;
> @@ -1185,7 +1173,7 @@ static unsigned int crisv10_decoder(CPUCRISState
> *env, DisasContext *dc)
>      unsigned int insn_len =3D 2;
>
>      /* Load a halfword onto the instruction register.  */
> -    dc->ir =3D cpu_lduw_code(env, dc->pc);
> +    dc->ir =3D cris_fetch(env, dc, dc->pc, 2, 0);
>
>      /* Now decode it.  */
>      dc->opcode   =3D EXTRACT_FIELD(dc->ir, 6, 9);
> --
> 2.34.1
>
>

--000000000000a8f503061559050c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Cc: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igl=
esias@gmail.com" target=3D"_blank">edgar.iglesias@gmail.com</a>&gt; <br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mai=
lto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0target/cris/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<=
br>
=C2=A0target/cris/translate_v10.c.inc | 30 +++++++++---------------------<b=
r>
=C2=A02 files changed, 9 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/target/cris/translate.c b/target/cris/translate.c<br>
index bb2d6612ba..a30c67eb07 100644<br>
--- a/target/cris/translate.c<br>
+++ b/target/cris/translate.c<br>
@@ -29,7 +29,6 @@<br>
=C2=A0#include &quot;tcg/tcg-op.h&quot;<br>
=C2=A0#include &quot;exec/helper-proto.h&quot;<br>
=C2=A0#include &quot;mmu.h&quot;<br>
-#include &quot;exec/cpu_ldst.h&quot;<br>
=C2=A0#include &quot;exec/translator.h&quot;<br>
=C2=A0#include &quot;crisv32-decode.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.=
inc<br>
index 73fc27c15d..c15ff47505 100644<br>
--- a/target/cris/translate_v10.c.inc<br>
+++ b/target/cris/translate_v10.c.inc<br>
@@ -165,20 +165,7 @@ static int dec10_prep_move_m(CPUCRISState *env, DisasC=
ontext *dc,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load [$rs] onto T1.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (is_imm) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memsize !=3D 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s_ext) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memsize =3D=3D=
 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =
=3D cpu_ldsb_code(env, dc-&gt;pc + 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =
=3D cpu_ldsw_code(env, dc-&gt;pc + 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memsize =3D=3D=
 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =
=3D cpu_ldub_code(env, dc-&gt;pc + 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =
=3D cpu_lduw_code(env, dc-&gt;pc + 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cpu_ldl_code(env, dc-&gt=
;pc + 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cris_fetch(env, dc, dc-&gt;pc + 2, mem=
size, s_ext);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movi_tl(dst, imm);<br>
<br>
@@ -929,10 +916,11 @@ static int dec10_dip(CPUCRISState *env, DisasContext =
*dc)<br>
=C2=A0 =C2=A0 =C2=A0LOG_DIS(&quot;dip pc=3D%x opcode=3D%d r%d r%d\n&quot;,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;pc, dc-&gt;op=
code, dc-&gt;src, dc-&gt;dst);<br>
=C2=A0 =C2=A0 =C2=A0if (dc-&gt;src =3D=3D 15) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cpu_ldl_code(env, dc-&gt;pc + 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cris_fetch(env, dc, dc-&gt;pc + 2, 4, =
0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movi_tl(cpu_PR[PR_PREFIX], imm);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc-&gt;postinc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc-&gt;postinc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn_len +=3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(cpu_R[15], cpu_R[15], ins=
n_len - 2);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_load(dc, cpu_PR[PR_PREFIX], cpu_R[dc-=
&gt;src], 4, 0);<br>
@@ -1095,10 +1083,10 @@ static unsigned int dec10_ind(CPUCRISState *env, Di=
sasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc-&gt;src =3D=3D 15) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOG_DIS(&quot=
;jump.%d %d r%d r%d direct\n&quot;, size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dc-&gt;opcode, dc-&gt;src, dc-&gt;dst);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cpu_ldl_co=
de(env, dc-&gt;pc + 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc-&gt;mode =
=3D=3D CRISV10_MODE_AUTOINC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D cris_fetch=
(env, dc, dc-&gt;pc + 2, size, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc-&gt;mode =
=3D=3D CRISV10_MODE_AUTOINC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0insn_len +=3D size;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c =3D tcg_con=
stant_tl(dc-&gt;pc + insn_len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t_gen_mov_pre=
g_TN(dc, dc-&gt;dst, c);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;jmp_pc=
 =3D imm;<br>
@@ -1164,7 +1152,7 @@ static unsigned int dec10_ind(CPUCRISState *env, Disa=
sContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CRISV10_IND_BCC_M:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cris_cc_mask(dc, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 simm =3D cpu_ldsw_code(env, dc-&=
gt;pc + 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 simm =3D cris_fetch(env, dc, dc-=
&gt;pc + 2, 2, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0simm +=3D 4;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOG_DIS(&quot;bcc_m: b%s %x=
\n&quot;, cc_name(dc-&gt;cond), dc-&gt;pc + simm);<br>
@@ -1185,7 +1173,7 @@ static unsigned int crisv10_decoder(CPUCRISState *env=
, DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0unsigned int insn_len =3D 2;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load a halfword onto the instruction register.=C2=A0=
 */<br>
-=C2=A0 =C2=A0 dc-&gt;ir =3D cpu_lduw_code(env, dc-&gt;pc);<br>
+=C2=A0 =C2=A0 dc-&gt;ir =3D cris_fetch(env, dc, dc-&gt;pc, 2, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Now decode it.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;opcode=C2=A0 =C2=A0=3D EXTRACT_FIELD(dc-&gt;ir, =
6, 9);<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000a8f503061559050c--

