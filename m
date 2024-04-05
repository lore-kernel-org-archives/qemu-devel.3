Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CA2C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj6t-0008Gq-Du; Fri, 05 Apr 2024 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsj6r-0008FO-DB
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:55:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsj6o-0001N8-Cj
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:55:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1a1c0ec9so2094495a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321752; x=1712926552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BtjCcAZ4bClQxgwPFN2vKZPUXaPjuMmD5nX2/KMfIco=;
 b=iq4gt3vCo9eLheVvwSdbFihdokJVmaTZBGPb/v7xHCinEGK06FdYVjg4AKzkxfH+qo
 n3qBSbhhq72Yum7oXm5TIMSkBCVvueCq9+bizQLXy63BEJvlWnZTHJYeWdL2kq64WcUG
 Zc2/R0xkjpy6ywiP/etMPC/N8eEkHnjRPJd85ej6lJER32punADYKn/GH8G4tU4ZZVIB
 nZdWB7wf2z2Lpy3NtAGgtD+VlcB4NDtmDn3jSc3SHgFmO0+jOwMy2rQdKR3+MjSyS1PT
 +XYNqy+1d/AIDMyZBt9diPkIunciQ/y1OKM9oqzoO3TqFlLvZ2Fr9lq9MzxM42gsd7Ab
 TgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321752; x=1712926552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtjCcAZ4bClQxgwPFN2vKZPUXaPjuMmD5nX2/KMfIco=;
 b=ayCtOKw1DQt3i0aQSAXyQWoFmhzBnNESqsy3pbH1Dn7/KfYhK2CVU8uERwpvEvCEOi
 3+esEw28zk+w6TNWJQs1qh7YRvlt8oWL+HSzmObAiEH9i+RrbS0QSxpsHC4oOyskRdhE
 etvrH81z6LtUG4YxWRvCZQJmwasLHmnywoSQ29S3mcm3cdWqnO1NVw43eApwTFdXGRc1
 ho2VzHeXEzqizM1BwUHzCiRUPHnTaxESZXA/2n/5DqLdY3zEc0AnlD+nBxa+Eds1caEy
 rTAXymYpauvv+Z2Cl6m+3YRSuVuD+Wr5pUFzFlsnBfZjkcCcdn7EzA3BeyaOoqyemmon
 1iGg==
X-Gm-Message-State: AOJu0Yzojp6FZeBxqL/Pp+8AgIDVEhvkNld1MW781FPwd+D6vMktir1y
 mVLe5QRKVgCA4EKrlOC10CvZ4jt4HARMvVvkm0qG3faB421AdIIdbQku6MREMY3gjte9+pOzkuj
 ubYrP5kg8sRS+qKBYVyIlkkJPPc/xgtIf+lS7r5wu
X-Google-Smtp-Source: AGHT+IEcU93QwSIJmhxlFJSTED1wYAAVW0aBFC0ukOVleyLpe/K/y+xjJjidrSQ+GIwW6KNsJEzTeDjUcFda9G/ZosU=
X-Received: by 2002:a50:8e59:0:b0:56d:b6dc:c8fe with SMTP id
 25-20020a508e59000000b0056db6dcc8femr1027827edx.0.1712321751359; Fri, 05 Apr
 2024 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-28-richard.henderson@linaro.org>
In-Reply-To: <20240405102459.462551-28-richard.henderson@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 5 Apr 2024 14:55:38 +0200
Message-ID: <CAJy5ezp8Emdtjv67S4_ecbfZQ+QaG+0-fsJ5aMXpvP5DtikrgQ@mail.gmail.com>
Subject: Re: [PATCH 27/32] target/cris: Use translator_ld* in cris_fetch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bb29b6061558f902"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x533.google.com
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

--000000000000bb29b6061558f902
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/cris/translate.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index b5410189d4..bb2d6612ba 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -222,37 +222,28 @@ static int sign_extend(unsigned int val, unsigned
> int width)
>  }
>
>  static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr=
,
> -              unsigned int size, unsigned int sign)
> +                      unsigned int size, bool sign)
>  {
>      int r;
>
>      switch (size) {
>      case 4:
> -    {
> -        r =3D cpu_ldl_code(env, addr);
> +        r =3D translator_ldl(env, &dc->base, addr);
>          break;
> -    }
>      case 2:
> -    {
> +        r =3D translator_lduw(env, &dc->base, addr);
>          if (sign) {
> -            r =3D cpu_ldsw_code(env, addr);
> -        } else {
> -            r =3D cpu_lduw_code(env, addr);
> +            r =3D (int16_t)r;
>          }
>          break;
> -    }
>      case 1:
> -    {
> +        r =3D translator_ldub(env, &dc->base, addr);
>          if (sign) {
> -            r =3D cpu_ldsb_code(env, addr);
> -        } else {
> -            r =3D cpu_ldub_code(env, addr);
> +            r =3D (int8_t)r;
>          }
>          break;
> -    }
>      default:
> -        cpu_abort(CPU(dc->cpu), "Invalid fetch size %d\n", size);
> -        break;
> +        g_assert_not_reached();
>      }
>      return r;
>  }
> @@ -2868,7 +2859,7 @@ static unsigned int crisv32_decoder(CPUCRISState
> *env, DisasContext *dc)
>      int i;
>
>      /* Load a halfword onto the instruction register.  */
> -        dc->ir =3D cris_fetch(env, dc, dc->pc, 2, 0);
> +    dc->ir =3D cris_fetch(env, dc, dc->pc, 2, 0);
>
>      /* Now decode it.  */
>      dc->opcode   =3D EXTRACT_FIELD(dc->ir, 4, 11);
> --
> 2.34.1
>
>

--000000000000bb29b6061558f902
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Cc: Edgar E. Iglesias &lt;=
<a href=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">edgar.iglesia=
s@gmail.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt=
;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0target/cris/translate.c | 25 ++++++++-----------------<br>
=C2=A01 file changed, 8 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/target/cris/translate.c b/target/cris/translate.c<br>
index b5410189d4..bb2d6612ba 100644<br>
--- a/target/cris/translate.c<br>
+++ b/target/cris/translate.c<br>
@@ -222,37 +222,28 @@ static int sign_extend(unsigned int val, unsigned int=
 width)<br>
=C2=A0}<br>
<br>
=C2=A0static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t a=
ddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int size, unsign=
ed int sign)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned int size, bool sign)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int r;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (size) {<br>
=C2=A0 =C2=A0 =C2=A0case 4:<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D cpu_ldl_code(env, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D translator_ldl(env, &amp;dc-&gt;base, ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
-=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D translator_lduw(env, &amp;dc-&gt;base, a=
ddr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sign) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D cpu_ldsw_code(env, addr);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D cpu_lduw_code(env, addr);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D (int16_t)r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case 1:<br>
-=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D translator_ldub(env, &amp;dc-&gt;base, a=
ddr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sign) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D cpu_ldsb_code(env, addr);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D cpu_ldub_code(env, addr);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D (int8_t)r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(CPU(dc-&gt;cpu), &quot;Invalid fetch=
 size %d\n&quot;, size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
@@ -2868,7 +2859,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env=
, DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load a halfword onto the instruction register.=C2=A0=
 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;ir =3D cris_fetch(env, dc, dc-&gt;pc, 2=
, 0);<br>
+=C2=A0 =C2=A0 dc-&gt;ir =3D cris_fetch(env, dc, dc-&gt;pc, 2, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Now decode it.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;opcode=C2=A0 =C2=A0=3D EXTRACT_FIELD(dc-&gt;ir, =
4, 11);<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000bb29b6061558f902--

