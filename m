Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3209C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 10:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYjEZ-00074h-Au; Mon, 07 Jul 2025 06:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uYjEW-00071S-Pb
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:38:00 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uYjEU-0001Db-Ko
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:38:00 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so2236268fac.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751884677; x=1752489477; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0W3473qESWU4eEFuLAn+Ezs5htKD99X+YyUkM+SBz84=;
 b=aazHZ7vV3r2Vl1iKMrhQ4ulGaWg5qRezKtrMz9pYB7YpTUoUljPkcrNxQYvWYP3+WP
 XMiQIUPbuwOedGy+WSpn+FXexwCM9aq+H1eNkjWp6iUzgmLQr2uOfrwqPLMEmhm5pTx5
 41HJgZgEsFfPn2WIaYnlaiAGS+dTfW27Uf2EthoVfKMr+Qxvum3+tnHY/FH9kX/dfpNN
 WEhyhXWtoS7ZUrqYHUFzWszilIYe3iWv6ZoFBiL91SewaZm95GBbhNAEglSljZlr7EBp
 tS49rUriZVXmIIZrIcoq4KaW8GAkoBYn9VeLTZK13kHwXYEg9CVlPmfCq1IBgtEki9KT
 a08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751884677; x=1752489477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W3473qESWU4eEFuLAn+Ezs5htKD99X+YyUkM+SBz84=;
 b=gEQ94e/uFtOuZe5rslUDI0Q2SXE355lpuyLCeY1V1Y3AXbmh5M1qejcjWyOOy+Kf4+
 dmKUnCaUCnaM1VSXIRg5f9ajOgiYk5FW+eE9ipnbsaAuoJMef4DYGqhN2RjxHO1D/ssU
 /Ljkkc8yXDDY2pQx3jiF9NBK1ae46Do4uX2hVmPJCq6GN62q3+k8HhrP1ZJmjo58FP3/
 0T8ZyJXbcHiSPt0KU224UJoBk7gSlJEz1julSgIWF0Eomk++qp0PepjmRmH9/cCBMF2d
 oSQhHyc5fR65QKfli+SwCHHbiiH/71RPrsxC9Lv3KOkMOKQMWvSbLJaTHScekvvb2gSj
 9zFw==
X-Gm-Message-State: AOJu0YxptzR6CIJ8cKfp5BzwEj+e6YXq8EVAX9zbEdnAqjACB9k2KRj6
 gYebCXZhzrHUbP4qCAJUevf4svoIK2DcqXL49Vtcpu56y5eyQ0I+FnRE+jclQbpycy0WdbtIfC9
 llga0Rwz/QfK6ny/w0B5XAuTOxyX2gTOs7ALlI0Cvaw==
X-Gm-Gg: ASbGncu3RcCj7E59FfIiwR988Im6pmaqrN+83r2p3QWOwvpR6ukgyapOfM1DKJQjTT6
 Gbxam1fmpsz2TKogI/UHaoBUyan8fqasm2KJMovsKCTulcp4ecVTq4kRciGcrx503TDyPfH9bvs
 fKQWQ12ZVIOEWotLm0KD51h0rQrfb0xXY9tq3AGqr/GzhEeg==
X-Google-Smtp-Source: AGHT+IHAMsV88igw8ShyKuf8sXEoBVwZGi/qY/mCw86df4cM34hhVcuPzGQg8QVa73gMK6Inr+4y09dFnb3ksamN8+s=
X-Received: by 2002:a05:6870:e08f:b0:2f3:4720:f7ca with SMTP id
 586e51a60fabf-2f7afd02bd7mr6206192fac.2.1751884676734; Mon, 07 Jul 2025
 03:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250627132156.440214-1-max.chou@sifive.com>
 <fdffc8af-897c-4f2d-a046-2b6c2bc370c4@ventanamicro.com>
In-Reply-To: <fdffc8af-897c-4f2d-a046-2b6c2bc370c4@ventanamicro.com>
From: Max Chou <max.chou@sifive.com>
Date: Mon, 7 Jul 2025 18:37:46 +0800
X-Gm-Features: Ac12FXza_t5L1MtaKO02w03sc9Qs8EABH1oOnTKZ3xW3t4CEF-tJYtrOE9nImFc
Message-ID: <CANiaA1uoJu0vFQVrFrww4t5Sysa1XqM1esra0YEbStRxkGEoTA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Minimum VLEN needs to respect V/Zve
 extensions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000d83cd60639546fc4"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=max.chou@sifive.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000d83cd60639546fc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the question.
Yes, you are right.
And I find that I miss some patches for the part that you mentioned here.
I'll update this patchset for it.

Thanks,
Max


On Wed, Jul 2, 2025 at 10:48=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 6/27/25 10:21 AM, Max Chou wrote:
> > According to the RISC-V instruction set manual, the minimum VLEN needs
> > to respect the following extensions:
> >
> >    Extension     Minimum VLEN
> > * V             128
> > * Zve64[d|f|x]   64
> > * Zve32[f|x]     32
> >
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >   target/riscv/tcg/tcg-cpu.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 163e7ce3642..187534009dd 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -416,12 +416,21 @@ static void
> riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
> >   static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig
> *cfg,
> >                                    Error **errp)
> >   {
> > +    uint32_t min_vlen;
> >       uint32_t vlen =3D cfg->vlenb << 3;
> >
> > -    if (vlen > RV_VLEN_MAX || vlen < 128) {
> > +    if (riscv_has_ext(env, RVV)) {
> > +        min_vlen =3D 128;
> > +    } else if (cfg->ext_zve64x) {
> > +        min_vlen =3D 64;
> > +    } else if (cfg->ext_zve32x) {
> > +        min_vlen =3D 32;
> > +    }
>
> At this moment this is how we're calling riscv_cpu_validate_v():
>
>      if (riscv_has_ext(env, RVV)) {
>          riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
>              return;
>          }
>      }
>
>
> riscv_has_ext(env, RVV) is always true inside the function. The code abov=
e
> will
> always result in min_vlen =3D 128 because of the 'else if' chaining.
>
> IIUC the idea of the patch, what you want is something like:
>
> > +    uint32_t min_vlen =3D 128;
> >       uint32_t vlen =3D cfg->vlenb << 3;
> >
> > -    if (vlen > RV_VLEN_MAX || vlen < 128) {
> > +    if (cfg->ext_zve64x) {
> > +        min_vlen =3D 64;
> > +    } else if (cfg->ext_zve32x) {
> > +        min_vlen =3D 32;
> > +    }
>
> I.e. init min_vlen to 128 (since RVV is always true) and then change it
> according to
> zve64x and zve32x.
>
>
> Thanks,
>
> Daniel
>
>
>
> > +
> > +    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
> >           error_setg(errp,
> >                      "Vector extension implementation only supports VLE=
N
> "
> > -                   "in the range [128, %d]", RV_VLEN_MAX);
> > +                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
> >           return;
> >       }
> >
>
>

--000000000000d83cd60639546fc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Daniel,</div><div><br></div><div>Thanks for t=
he question.</div><div>Yes, you are right.</div><div>And I find=C2=A0that I=
 miss some patches for the part that you mentioned here.</div><div>I&#39;ll=
 update this patchset for it.</div><div><br></div><div><div dir=3D"ltr" cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
Thanks,<br>Max</div></div></div><br></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 2, 20=
25 at 10:48=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarbo=
za@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddi=
ng-left:1ex"><br>
<br>
On 6/27/25 10:21 AM, Max Chou wrote:<br>
&gt; According to the RISC-V instruction set manual, the minimum VLEN needs=
<br>
&gt; to respect the following extensions:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Extension=C2=A0 =C2=A0 =C2=A0Minimum VLEN<br>
&gt; * V=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0128<br>
&gt; * Zve64[d|f|x]=C2=A0 =C2=A064<br>
&gt; * Zve32[f|x]=C2=A0 =C2=A0 =C2=A032<br>
&gt; <br>
&gt; Signed-off-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" tar=
get=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c | 13 +++++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 11 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index 163e7ce3642..187534009dd 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -416,12 +416,21 @@ static void riscv_cpu_validate_misa_priv(CPURISC=
VState *env, Error **errp)<br>
&gt;=C2=A0 =C2=A0static void riscv_cpu_validate_v(CPURISCVState *env, RISCV=
CPUConfig *cfg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 uint32_t min_vlen;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vlen =3D cfg-&gt;vlenb &lt;&lt; 3;<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (vlen &gt; RV_VLEN_MAX || vlen &lt; 128) {<br>
&gt; +=C2=A0 =C2=A0 if (riscv_has_ext(env, RVV)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_vlen =3D 128;<br>
&gt; +=C2=A0 =C2=A0 } else if (cfg-&gt;ext_zve64x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_vlen =3D 64;<br>
&gt; +=C2=A0 =C2=A0 } else if (cfg-&gt;ext_zve32x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_vlen =3D 32;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
At this moment this is how we&#39;re calling riscv_cpu_validate_v():<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (riscv_has_ext(env, RVV)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_cpu_validate_v(env, &amp;cpu-&gt;cf=
g, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (local_err !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local=
_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
riscv_has_ext(env, RVV) is always true inside the function. The code above =
will<br>
always result in min_vlen =3D 128 because of the &#39;else if&#39; chaining=
.<br>
<br>
IIUC the idea of the patch, what you want is something like:<br>
<br>
&gt; +=C2=A0 =C2=A0 uint32_t min_vlen =3D 128;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vlen =3D cfg-&gt;vlenb &lt;&lt; 3;<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (vlen &gt; RV_VLEN_MAX || vlen &lt; 128) {<br>
&gt; +=C2=A0 =C2=A0 if (cfg-&gt;ext_zve64x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_vlen =3D 64;<br>
&gt; +=C2=A0 =C2=A0 } else if (cfg-&gt;ext_zve32x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_vlen =3D 32;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I.e. init min_vlen to 128 (since RVV is always true) and then change it acc=
ording to<br>
zve64x and zve32x.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vlen &gt; RV_VLEN_MAX || vlen &lt; min_vlen) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Vector extension implementation only supports VLEN &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;in the range [128, %d]&quot;, RV_VLEN_MAX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;in the range [%d, %d]&quot;, min_vlen, RV_VLEN_MAX);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--000000000000d83cd60639546fc4--

