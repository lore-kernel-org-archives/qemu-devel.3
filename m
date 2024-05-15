Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA6EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Lw-0005vc-EG; Wed, 15 May 2024 03:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Lq-0005mm-6W
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:47:02 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Lm-0006ZO-53
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:47:01 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7fb8ed718acso562484241.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759215; x=1716364015; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y6Q4bNgTKdpHxo17hwweMWeQLFhqFtYFVNB5TdWm3nU=;
 b=Q/dCCL9xylNqe1pwIGrCJoB9O3lPG3uA+Dq0gIVt0DgA9KkeyRPiyb0hy7xRfvPwNu
 iixmYIgeVY1qjhcwk1f1h6RpuxWfpv/djCBMLhAwRERBb0wAJJM2FuXWHBNxYIotC+q/
 OsKgzvcbmKPVuZxW+HcpzEFHRyTCZtLT7JynA0LSL6lGaNjATXkVP8Hey3Ym2PCqmMva
 YZIF0nwmooXbHWAvfyCrFK5fiDKgGiyRsguqzU4ACrQIIwNHa2+6dq2F6pB+qr+cWpUC
 a5tzti3W+R8fHWOd6Cw+SA92NPWms7DB10IP+PQc+koouigLJ0RnH47iIJ8bcXmzfbYr
 gMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759215; x=1716364015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6Q4bNgTKdpHxo17hwweMWeQLFhqFtYFVNB5TdWm3nU=;
 b=i2s8yujsH0TMxME7YpT+bUpBBV/yMabmhWXU/hgvlMG8MX7u0MKgKEfaftQVVbdSBp
 ud35btsYNSPGKaIVOrX1CwmV61cfZe/44/klJE3bfizK2MudIk4RoGJGYFf9ieYY9Eic
 RHjS80CybQk/FOqI938pZkKrRMofjSkogcfQvyRtAJq9UvAaJNVmonlfiRZC1oPA2mhm
 /7TNukBarrBeji2HloHYtDBRqL9+tT/VwwEAMsOiivx1GC4d+7WXWO0xuwTn3dAxi4kb
 2DeG6Qf/9co24my7xpVrPYbWsAZDdzZC60+N+xwUPQQO7eyeyxfQAIVRmZCWWDHDZXm4
 6jfA==
X-Gm-Message-State: AOJu0Yy6564CpPs/9s5jcPZ3Vcq42zjKc2LDDEnv9CwU/1PkgQXGEa3P
 +J6iGlnNe1/a6T0xK8YHU8650IOcNBn+JqA4t14/TvQobPFDba6zX+E3A5XgAb/Ul9FWYTse+4N
 mVJR6oYmd3mihFzvxLR9JVOFbcvkijqp20WDCxg==
X-Google-Smtp-Source: AGHT+IFULTVku7EGVZZeHZuGzlpc7fshtrH+XKI/jF5fndLQVvh+BRFxm3PvdTb4jQgf1G60QRLRpuOJ58yRP2UGeV4=
X-Received: by 2002:a05:6122:992:b0:4da:ac09:94d3 with SMTP id
 71dfb90a1353d-4df882a1769mr13020342e0c.6.1715759215590; Wed, 15 May 2024
 00:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-4-fea.wang@sifive.com>
 <c4e44f4a-5409-4914-b4b8-f6ab3b14e71b@linux.alibaba.com>
In-Reply-To: <c4e44f4a-5409-4914-b4b8-f6ab3b14e71b@linux.alibaba.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Wed, 15 May 2024 15:46:44 +0800
Message-ID: <CAKhCfse6QrBpBKJz-sMZHHVD=bJUrdjO_6rLoS4CY7--UwyHcA@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: multipart/alternative; boundary="00000000000090d95d06187952f3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=fea.wang@sifive.com; helo=mail-ua1-x932.google.com
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

--00000000000090d95d06187952f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, I will correct it in the patch v2.

Sincerely,
Fea

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:51=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> On 2024/5/10 14:58, Fea.Wang wrote:
> > Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> > SMSTATEEN0 that controls access to the hedeleg.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   target/riscv/cpu_bits.h |  1 +
> >   target/riscv/csr.c      | 10 ++++++++++
> >   2 files changed, 11 insertions(+)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 74318a925c..28bd3fb0b4 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -315,6 +315,7 @@
> >   #define SMSTATEEN0_CS       (1ULL << 0)
> >   #define SMSTATEEN0_FCSR     (1ULL << 1)
> >   #define SMSTATEEN0_JVT      (1ULL << 2)
> > +#define SMSTATEEN0_P1P13    (1ULL << 56)
> >   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
> >   #define SMSTATEEN0_IMSIC    (1ULL << 58)
> >   #define SMSTATEEN0_AIA      (1ULL << 59)
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 6b460ee0e8..d844ce770e 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -2248,6 +2248,11 @@ static RISCVException
> write_mstateen0(CPURISCVState *env, int csrno,
> >           wr_mask |=3D SMSTATEEN0_FCSR;
> >       }
> >
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> Why not use env directly?
> > +        wr_mask |=3D SMSTATEEN0_P1P13;
> > +    }
> > +
> >       return write_mstateen(env, csrno, wr_mask, new_val);
> >   }
> >
> > @@ -2283,6 +2288,11 @@ static RISCVException
> write_mstateen0h(CPURISCVState *env, int csrno,
> >   {
> >       uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> >
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> Same here.
> > +            wr_mask |=3D SMSTATEEN0_P1P13;
>
> Indent.
>
> Zhiwei
>
> > +    }
> > +
> >       return write_mstateenh(env, csrno, wr_mask, new_val);
> >   }
> >
>

--00000000000090d95d06187952f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you, I will correct it in the patch v2.<br><div><br>=
</div><div>Sincerely,<br>Fea</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_l=
iu@linux.alibaba.com">zhiwei_liu@linux.alibaba.com</a>&gt; =E6=96=BC 2024=
=E5=B9=B45=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:51=
=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
On 2024/5/10 14:58, Fea.Wang wrote:<br>
&gt; Based on privilege 1.13 spec, there should be a bit56 for &#39;P1P13&#=
39; in<br>
&gt; SMSTATEEN0 that controls access to the hedeleg.<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 11 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h<br>
&gt; index 74318a925c..28bd3fb0b4 100644<br>
&gt; --- a/target/riscv/cpu_bits.h<br>
&gt; +++ b/target/riscv/cpu_bits.h<br>
&gt; @@ -315,6 +315,7 @@<br>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_CS=C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;=
&lt; 0)<br>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_FCSR=C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; =
1)<br>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_JVT=C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; =
2)<br>
&gt; +#define SMSTATEEN0_P1P13=C2=A0 =C2=A0 (1ULL &lt;&lt; 56)<br>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_HSCONTXT (1ULL &lt;&lt; 57)<br>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_IMSIC=C2=A0 =C2=A0 (1ULL &lt;&lt; 58)<b=
r>
&gt;=C2=A0 =C2=A0#define SMSTATEEN0_AIA=C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; =
59)<br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index 6b460ee0e8..d844ce770e 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -2248,6 +2248,11 @@ static RISCVException write_mstateen0(CPURISCVS=
tate *env, int csrno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr_mask |=3D SMSTATEEN0_FCSR;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 RISCVCPU *cpu =3D env_archcpu(env);<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;env.priv_ver &gt;=3D PRIV_VERSION_1_13_0) {=
<br>
Why not use env directly?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wr_mask |=3D SMSTATEEN0_P1P13;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return write_mstateen(env, csrno, wr_mask, n=
ew_val);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -2283,6 +2288,11 @@ static RISCVException write_mstateen0h(CPURISCV=
State *env, int csrno,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMS=
TATEEN0_HSENVCFG;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 RISCVCPU *cpu =3D env_archcpu(env);<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;env.priv_ver &gt;=3D PRIV_VERSION_1_13_0) {=
<br>
Same here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wr_mask |=3D SMSTATEEN0_P1P=
13;<br>
<br>
Indent.<br>
<br>
Zhiwei<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return write_mstateenh(env, csrno, wr_mask, =
new_val);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
</blockquote></div>

--00000000000090d95d06187952f3--

