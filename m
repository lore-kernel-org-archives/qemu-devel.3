Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A1C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sELI3-0000O0-6H; Mon, 03 Jun 2024 23:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sELI2-0000Nj-31
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:56:50 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sELI0-0007Ex-9j
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:56:49 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4e93a260becso2042509e0c.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 20:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717473407; x=1718078207; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=33a6DB8kRYe1S18YmU9j/6X5cvvTTWhqNpWd3x2aY+g=;
 b=Ae9i9sAZKGUPRtS6ESvA7aZl1xHcFrcducUDAm8+3X8WAOWUhxCGrXyuMo9OV0cdFe
 VXsgMzjYIsg4GnYqmMO9mClv3RpX/pVoS+M+6b+G8BKVByO4ZElcC1bU+CPR5LTM8/Uc
 MbFxA00ZBwU2ffxDrBgC7DSFeXiN9ESHzVecreG/l8vpRR1wEgKGVDiu3B4WJ7A4qBhk
 x5W03HAcXd1nB9NcdV1X/z/7e60EOYnxNxzGQ6Lge6t/n9Vks9HvTcfRq0NFmicOZmr0
 bxxSFznWcHyYswdXS2zVn+wHv5QgzqSsgqg9VDPazCprYL3/IVGzxI4ORBa/VOK7bbTE
 XyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717473407; x=1718078207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=33a6DB8kRYe1S18YmU9j/6X5cvvTTWhqNpWd3x2aY+g=;
 b=tFTokDNf3xEd98JXfFJIMJMtj8anc8DVfAW/MG+w+9XR14jSRcq+AUBvzHBCvSC7wx
 b6UJDFfkhFuyQ3AS66eGcSpFzuR6Zjg4VgjyB1gSRLxH7kjUTALtATEvQsA3S4xIT/Rj
 +e6rG5Ru/XBoJ0/EgqtYsJ4y94NytFlqfGHUSz8IFIkHbcuXw1QzXG6NNy9scLQ8Y0rA
 UQjBudIx1R2/+uOfbYU0I5EA2jIPaPk8H5YnjYg5Jz58Cv3fONurhD3BPbfJPdMnglNR
 008bezBwl3vLyhHX+6LtWT4PBxCFm9Exo36TSxrjwT3YnklHy/R4j93ANbrtmex7K2UJ
 r2/A==
X-Gm-Message-State: AOJu0YyPNgd2/dWv5OHGQXxUrzcHiTTQjr/hu2nChuhMy1TdpTAnatVA
 9L1qGIb1WVdt5s6CViGIFbXmzaMGn2iUdwM39qHmYCmK/2DfPCYjv6Dn038+4qdkjkDGEzs6Fxu
 TRhbQ9VKXx6Kbb0hh0oTzuT2MgZlgopbOQZ/UFw==
X-Google-Smtp-Source: AGHT+IHKg1YZ2i1fhxhwrG8nE4+/JBCiv/K8Se9V2ARSZ708nN2X7DrS9Ul+BoplOBOVMxrNTEs9hPBRgL16WHl5qm8=
X-Received: by 2002:a05:6122:182a:b0:4d8:9541:41a0 with SMTP id
 71dfb90a1353d-4eb02eec6dbmr11617233e0c.12.1717473406681; Mon, 03 Jun 2024
 20:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-4-fea.wang@sifive.com>
 <CAKmqyKPN7GUAQUggXvLbeUiuFgSRhmGpK32QGNKReiS59qbCGg@mail.gmail.com>
In-Reply-To: <CAKmqyKPN7GUAQUggXvLbeUiuFgSRhmGpK32QGNKReiS59qbCGg@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Tue, 4 Jun 2024 11:56:35 +0800
Message-ID: <CAKhCfscCHnX=6S2qtkhp0B4Cxjs3sD4R7g9N8N8ggPh3+SB6TQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000512485061a08703c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=fea.wang@sifive.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000512485061a08703c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for correcting me.
I will fix it in the next version of the patch series.

Sincerely,
Fea

On Tue, Jun 4, 2024 at 8:54=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om>
wrote:

> On Wed, May 15, 2024 at 6:01=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wr=
ote:
> >
> > Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> > SMSTATEEN0 that controls access to the hedeleg.
>
> I don't see this in the spec. I only see P1P13 in mstateen0
>
> Alistair
>
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
> > ---
> >  target/riscv/cpu_bits.h | 1 +
> >  target/riscv/csr.c      | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 74318a925c..28bd3fb0b4 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -315,6 +315,7 @@
> >  #define SMSTATEEN0_CS       (1ULL << 0)
> >  #define SMSTATEEN0_FCSR     (1ULL << 1)
> >  #define SMSTATEEN0_JVT      (1ULL << 2)
> > +#define SMSTATEEN0_P1P13    (1ULL << 56)
> >  #define SMSTATEEN0_HSCONTXT (1ULL << 57)
> >  #define SMSTATEEN0_IMSIC    (1ULL << 58)
> >  #define SMSTATEEN0_AIA      (1ULL << 59)
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 6b460ee0e8..bdbc8de0e2 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -2248,6 +2248,10 @@ static RISCVException
> write_mstateen0(CPURISCVState *env, int csrno,
> >          wr_mask |=3D SMSTATEEN0_FCSR;
> >      }
> >
> > +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> > +        wr_mask |=3D SMSTATEEN0_P1P13;
> > +    }
> > +
> >      return write_mstateen(env, csrno, wr_mask, new_val);
> >  }
> >
> > @@ -2283,6 +2287,10 @@ static RISCVException
> write_mstateen0h(CPURISCVState *env, int csrno,
> >  {
> >      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> >
> > +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> > +        wr_mask |=3D SMSTATEEN0_P1P13;
> > +    }
> > +
> >      return write_mstateenh(env, csrno, wr_mask, new_val);
> >  }
> >
> > --
> > 2.34.1
> >
> >
>

--000000000000512485061a08703c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for correcting me.<div>I will fix it in the next=
 version of the patch series.</div><div><br></div><div>Sincerely,</div><div=
>Fea</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Jun 4, 2024 at 8:54=E2=80=AFAM Alistair Francis &lt;<a hr=
ef=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, May 15, 2024=
 at 6:01=E2=80=AFPM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Based on privilege 1.13 spec, there should be a bit56 for &#39;P1P13&#=
39; in<br>
&gt; SMSTATEEN0 that controls access to the hedeleg.<br>
<br>
I don&#39;t see this in the spec. I only see P1P13 in mstateen0<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by:=C2=A0 Weiwei Li &lt;<a href=3D"mailto:liwei1518@gmail.com=
" target=3D"_blank">liwei1518@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu_bits.h | 1 +<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 | 8 ++++++++<br>
&gt;=C2=A0 2 files changed, 9 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h<br>
&gt; index 74318a925c..28bd3fb0b4 100644<br>
&gt; --- a/target/riscv/cpu_bits.h<br>
&gt; +++ b/target/riscv/cpu_bits.h<br>
&gt; @@ -315,6 +315,7 @@<br>
&gt;=C2=A0 #define SMSTATEEN0_CS=C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; 0=
)<br>
&gt;=C2=A0 #define SMSTATEEN0_FCSR=C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; 1)<br>
&gt;=C2=A0 #define SMSTATEEN0_JVT=C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; 2)<br>
&gt; +#define SMSTATEEN0_P1P13=C2=A0 =C2=A0 (1ULL &lt;&lt; 56)<br>
&gt;=C2=A0 #define SMSTATEEN0_HSCONTXT (1ULL &lt;&lt; 57)<br>
&gt;=C2=A0 #define SMSTATEEN0_IMSIC=C2=A0 =C2=A0 (1ULL &lt;&lt; 58)<br>
&gt;=C2=A0 #define SMSTATEEN0_AIA=C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; 59)<br=
>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index 6b460ee0e8..bdbc8de0e2 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -2248,6 +2248,10 @@ static RISCVException write_mstateen0(CPURISCVS=
tate *env, int csrno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wr_mask |=3D SMSTATEEN0_FCSR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv_ver &gt;=3D PRIV_VERSION_1_13_0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wr_mask |=3D SMSTATEEN0_P1P13;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return write_mstateen(env, csrno, wr_mask, new_val=
);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -2283,6 +2287,10 @@ static RISCVException write_mstateen0h(CPURISCV=
State *env, int csrno,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN=
0_HSENVCFG;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv_ver &gt;=3D PRIV_VERSION_1_13_0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wr_mask |=3D SMSTATEEN0_P1P13;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return write_mstateenh(env, csrno, wr_mask, new_va=
l);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000512485061a08703c--

