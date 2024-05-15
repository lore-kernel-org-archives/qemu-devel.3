Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A342C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Mh-0006LL-Ib; Wed, 15 May 2024 03:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79MW-0006DB-5O
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:47:44 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ML-00088x-DX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:47:39 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4df3f7b93a7so1754774e0c.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759251; x=1716364051; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vNNK7jPhjciFYCXoIXi/Y4d0IMpqc5AGmZTEQEP+ATA=;
 b=ZYV0ngcpKbMoMVDL5HYzsEga1R8DTesFRgvyltGR4pwH60QbbOfV/ZX6+V0zjZxzpz
 abatZcEgIYh5URdcniepMeZ9Roqjn1fLOlSXs9LmtBewzussKTwFQVQPbXH6NhKAfW8+
 +6xqBC+RujIc76TQKTj2qsFR1pySbGRDKl8UGx7cPhADqw4UfV6EUSw3PkBwjkDVhTvp
 UnQ0WRcdFqdwUP437nKllqDaqU+9YPQkd2ccePugr4VCKhTgrPXhjDRfk9lk2R8qfHVu
 7LEFaWl8uhZJZoEyNOOr3tPr2pouHHIVr1bsH30rGSYoY/oi5Lf8cujVNSrIV+uYgWmg
 AAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759251; x=1716364051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vNNK7jPhjciFYCXoIXi/Y4d0IMpqc5AGmZTEQEP+ATA=;
 b=Q5Da/M43ROP2MypCBLmpMfUbSvmbhlqhMwwrcTIJJnJNgJPovwUptxIxB1ZXl0ETRb
 yA5n7CmOHcAb/JSIdzj1hq7gA1LW13RgQJ2Xa1wHYS7yFpxaxPXn4OlhmOROZple6I7W
 e0OHIEUT8fAt/Hh0ujThdidt8cNpFhe+uIg1lO/P/Iap8qmhI1H3nJOUk7w4ERoqX1Vg
 g4yaj4CZ2koKEKKzO8Dp4y+fxo9ysbqOBCrqFbHnAdx/k/71JCC1Dbjm+0jS99OH9LMr
 D0FTQkWj7zoe1tc4aGu87v1l7ky5m7tD0oVpGsxgCCqIwhZ2BFJvOyyZ/mkZoogjJkN5
 31tw==
X-Gm-Message-State: AOJu0YykWONWkK40c533oYk5P6niOvJb+LHu3KK8k9V+AcNt+CRWHqmJ
 UxGlxN8ImADiBy8qz6kEpXmztdQAmErCnfWk02it60RijEJXmz3lrzn5nkzPVg2CYbr6/QKI80A
 6TidO1Ei2m38ZO+djwUce9lW53QiNLRC8osGSlQ==
X-Google-Smtp-Source: AGHT+IHrVYZJq5ayRDUYUwqMuhbLr0bm/GtdVKD9/VYnrcYv4wcIyzn7LHBOXm3kgiybugYz41ffBYQ9JqiCSIDV+oI=
X-Received: by 2002:a05:6122:2215:b0:4d3:cff6:79f0 with SMTP id
 71dfb90a1353d-4df882c0c5emr12148880e0c.4.1715759251424; Wed, 15 May 2024
 00:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-5-fea.wang@sifive.com>
 <c9969b2a-db87-4694-9fe9-bad7aa6bf749@linux.alibaba.com>
In-Reply-To: <c9969b2a-db87-4694-9fe9-bad7aa6bf749@linux.alibaba.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Wed, 15 May 2024 15:47:20 +0800
Message-ID: <CAKhCfse6As75Zd6nTxQ+Q54NVxuF-G8PzLv2qDQ-_y4pWqVYvw@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: multipart/alternative; boundary="000000000000b3a95c0618795445"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=fea.wang@sifive.com; helo=mail-vk1-xa2a.google.com
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

--000000000000b3a95c0618795445
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I will correct it in the patch v2. Thank you.

Sincerely,
Fea

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:49=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> On 2024/5/10 14:58, Fea.Wang wrote:
> > Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
> > and HEDELEGH for exception codes 32-47 for reserving and exception code=
s
> > 48-63 for custom use. Add the CSR number though the implementation is
> > just reading zero and writing ignore. Besides, for accessing HEDELEGH, =
it
> > should be controlled by mstateen0 'P1P13' bit.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   target/riscv/cpu_bits.h |  2 ++
> >   target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
> >   2 files changed, 33 insertions(+)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 28bd3fb0b4..f888025c59 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -156,6 +156,8 @@
> >
> >   /* 32-bit only */
> >   #define CSR_MSTATUSH        0x310
> > +#define CSR_MEDELEGH        0x312
> > +#define CSR_HEDELEGH        0x612
> >
> >   /* Machine Trap Handling */
> >   #define CSR_MSCRATCH        0x340
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index d844ce770e..4d7313f456 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -3227,6 +3227,33 @@ static RISCVException write_hedeleg(CPURISCVStat=
e
> *env, int csrno,
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
> > +                                   target_ulong *val)
> > +{
> > +    RISCVException ret;
> > +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    /* Reserved, now read zero */
> > +    *val =3D 0;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
> > +                                    target_ulong val)
> > +{
> > +    RISCVException ret;
> > +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    /* Reserved, now write ignore */
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
> >                                       uint64_t *ret_val,
> >                                       uint64_t new_val, uint64_t wr_mas=
k)
> > @@ -4674,6 +4701,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >
> >       [CSR_MSTATUSH]    =3D { "mstatush",   any32, read_mstatush,
> >                             write_mstatush
>      },
> > +    [CSR_MEDELEGH]    =3D { "medelegh",   any32, read_zero, write_igno=
re,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_13_0
>     },
> > +    [CSR_HEDELEGH]    =3D { "hedelegh",   any32, read_hedelegh,
> write_hedelegh,
>
> Using hmode32 instead of any32.
>
> Otherwise,
>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> > +                          .min_priv_ver =3D PRIV_VERSION_1_13_0
>     },
> >
> >       /* Machine Trap Handling */
> >       [CSR_MSCRATCH] =3D { "mscratch", any,  read_mscratch, write_mscra=
tch,
>

--000000000000b3a95c0618795445
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, I will correct it in the patch v2. Thank you.<br><div>=
<br></div><div>Sincerely,<br>Fea</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">LIU Zhiwei &lt;<a href=3D"mailto:zhiw=
ei_liu@linux.alibaba.com">zhiwei_liu@linux.alibaba.com</a>&gt; =E6=96=BC 20=
24=E5=B9=B45=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:49=
=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
On 2024/5/10 14:58, Fea.Wang wrote:<br>
&gt; Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH<br=
>
&gt; and HEDELEGH for exception codes 32-47 for reserving and exception cod=
es<br>
&gt; 48-63 for custom use. Add the CSR number though the implementation is<=
br>
&gt; just reading zero and writing ignore. Besides, for accessing HEDELEGH,=
 it<br>
&gt; should be controlled by mstateen0 &#39;P1P13&#39; bit.<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 | 31 ++++++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 33 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h<br>
&gt; index 28bd3fb0b4..f888025c59 100644<br>
&gt; --- a/target/riscv/cpu_bits.h<br>
&gt; +++ b/target/riscv/cpu_bits.h<br>
&gt; @@ -156,6 +156,8 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* 32-bit only */<br>
&gt;=C2=A0 =C2=A0#define CSR_MSTATUSH=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x310<br>
&gt; +#define CSR_MEDELEGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x312<br>
&gt; +#define CSR_HEDELEGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x612<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Machine Trap Handling */<br>
&gt;=C2=A0 =C2=A0#define CSR_MSCRATCH=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x340<br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index d844ce770e..4d7313f456 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -3227,6 +3227,33 @@ static RISCVException write_hedeleg(CPURISCVSta=
te *env, int csrno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static RISCVException read_hedelegh(CPURISCVState *env, int csrno,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *val)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVException ret;<br>
&gt; +=C2=A0 =C2=A0 ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D RISCV_EXCP_NONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Reserved, now read zero */<br>
&gt; +=C2=A0 =C2=A0 *val =3D 0;<br>
&gt; +=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static RISCVException write_hedelegh(CPURISCVState *env, int csrno,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong val)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVException ret;<br>
&gt; +=C2=A0 =C2=A0 ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D RISCV_EXCP_NONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Reserved, now write ignore */<br>
&gt; +=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static RISCVException rmw_hvien64(CPURISCVState *env, int =
csrno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64=
_t *ret_val,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64=
_t new_val, uint64_t wr_mask)<br>
&gt; @@ -4674,6 +4701,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
=3D {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MSTATUSH]=C2=A0 =C2=A0 =3D { &quot;msta=
tush&quot;,=C2=A0 =C2=A0any32, read_mstatush,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_mstatush=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 [CSR_MEDELEGH]=C2=A0 =C2=A0 =3D { &quot;medelegh&quot;,=
=C2=A0 =C2=A0any32, read_zero, write_ignore,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .min_priv_ver =3D PRIV_VERSION_1_13_0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 [CSR_HEDELEGH]=C2=A0 =C2=A0 =3D { &quot;hedelegh&quot;,=
=C2=A0 =C2=A0any32, read_hedelegh, write_hedelegh,<br>
<br>
Using hmode32 instead of any32.<br>
<br>
Otherwise,<br>
<br>
Reviewed-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com"=
 target=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .min_priv_ver =3D PRIV_VERSION_1_13_0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Machine Trap Handling */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MSCRATCH] =3D { &quot;mscratch&quot;, a=
ny,=C2=A0 read_mscratch, write_mscratch,<br>
</blockquote></div>

--000000000000b3a95c0618795445--

