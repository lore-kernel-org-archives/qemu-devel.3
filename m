Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD4FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfvj-0005UL-Bl; Mon, 06 Jan 2025 00:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfvU-000592-7O
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:45:25 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfvQ-0004al-Uo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:45:19 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so25205410a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142315; x=1736747115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O682btEOM1Rl7PEyZuuGOXhFL3ZlxKOw32XVYH9sxZE=;
 b=bn3GqKXJ28nBJNreXePWIfkUXI33cJAqj22YdmcXdSMzbR5Mp5xfLi0P27VcnP6kj6
 cDCWtzjRauSOtYyXW7zgpxQrWzCCh8sF5MtTU5wfu8GQk7+wpvKWiO39msgaa3TdeIr7
 vNT2O/HiN1MIiTvTAG/NiMEGaqvss7io6C75WFItHpBAO9YSd/X4NjBl5X5zIFwQcriI
 CQDo3jLfOz1nTDTnOF+Lm3gjVKSXs8uHZ6Az2g298OT85pvQtkcyTiJgy6eQ02bcJ8ny
 BjXoZEnit1jdMlHWRc0lqkqXCTuQu3mcOOxUN9xyeeTdbSVCULfyK6voHhG9zQ1jmNYP
 maQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142315; x=1736747115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O682btEOM1Rl7PEyZuuGOXhFL3ZlxKOw32XVYH9sxZE=;
 b=LWF22iDPIUsoh5426r6PNOuvFJ/s0M5rDkR9e0Dtt44uBeGPd5Mq1FmvK3XGTdW5d5
 X61hc0nWdRBJpowIBR1RFILdZEEfS0QpnRgNdob/l2WSOtcZT1o1yqVA9HgH8zHV/eJR
 Va561urL3OLR9g3G1bj9oXb+k5NVH7qllzh3foS05eBxjINDQ5k/hRBpcPNrhpy6Z8Ba
 NUgW29qY7fZm+foVGpnoX+ooM3KSAYRrTHKBaEZgn2gVt4RmN9AXS1+jyQC63v3aHETQ
 H4p9KG+uRlYb6vqHfXLa2e2twHhIXf4a6u88wthyEnR6UurvjBy+sQb4EbyfYVpRzGSu
 CANQ==
X-Gm-Message-State: AOJu0Yx/NmfFzS/jWHO/qFENAeCAmrt3q2+3HbuguJSIz5tfCjEPbF7J
 MSUHpiuKv6L/AwUseHI++ALYAizhayxc4ap5CDypiHocJA+A5yXbCXM16B2PhSO1KQPgOu/+KZS
 k4U2DXmYwZJ9o3fG4YKj0j0ouSmHlSurz3QNQsQ==
X-Gm-Gg: ASbGncu28iNp0+SL4qdOK+4ajkjHehtzVQ2zJmBIkyTbi81THcjWXuJysmroXQFZkgX
 Mrnfp3dVTGl+9WVpKwax/qQAF83i5UvtqmcYb0U0=
X-Google-Smtp-Source: AGHT+IHIbY5Wve+otfojHub9qczoC3Ifhr3iWOyapmhH9kXjZZbrsC5IAdv4XfldFINQhh8gqDJYhnsk/iMRjMAE6/4=
X-Received: by 2002:a05:6402:11c7:b0:5d0:b51c:8489 with SMTP id
 4fb4d7f45d1cf-5d81ddc01abmr43546356a12.12.1736142315182; Sun, 05 Jan 2025
 21:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-6-frank.chang@sifive.com>
 <CAKmqyKOUnh-iDiN7_H1rtRq_dmXT2b=5qN9iVDf-JeD7X7OGOw@mail.gmail.com>
In-Reply-To: <CAKmqyKOUnh-iDiN7_H1rtRq_dmXT2b=5qN9iVDf-JeD7X7OGOw@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 6 Jan 2025 13:45:04 +0800
Message-ID: <CAE_xrPgpWVvMEM_6MEAAGmxD-6C4W+8T-NkrGmzKLJYZisBPQg@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] target/riscv: Add Smrnmi cpu extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000f9f901062b03212b"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x536.google.com
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

--000000000000f9f901062b03212b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 12:15=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Tommy Wu <tommy.wu@sifive.com>
> >
> > This adds the properties for ISA extension Smrnmi.
> >
> > Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set
> > mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
> > interrupts will be disabled. Since our current OpenSBI does not
> > support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
> > now. We can re-enable it once OpenSBI includes proper support for it.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >  target/riscv/cpu.c         | 2 ++
> >  target/riscv/tcg/tcg-cpu.c | 6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 6c46a2f076..b0d9e93170 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> >      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> >      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> > +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> >      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> >      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> >      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> > @@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig
> riscv_cpu_extensions[] =3D {
> >
> >      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> >      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> > +    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
> >      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> >      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
> >      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index cbf2cf1963..c4070c948e 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -1421,6 +1421,12 @@ static void riscv_init_max_cpu_extensions(Object
> *obj)
> >      if (env->misa_mxl !=3D MXL_RV32) {
> >          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
> >      }
> > +
> > +    /*
> > +     * ext_smrnmi requires OpenSBI changes that our current
> > +     * image does not have. Disable it for now.
> > +     */
> > +    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>
> Should we log this to users so they know?
>
> Alistair
>

Sure, I've added it in the v12 patchset.

Regards,
Frank Chang


>
> >  }
> >
> >  static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> > --
> > 2.34.1
> >
> >
>

--000000000000f9f901062b03212b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jan 6, 2025 at 12:15=E2=80=AFPM A=
listair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmai=
l.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 31, 2024 at 1=
:28=E2=80=AFPM &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_bla=
nk">frank.chang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" target=3D"_b=
lank">tommy.wu@sifive.com</a>&gt;<br>
&gt;<br>
&gt; This adds the properties for ISA extension Smrnmi.<br>
&gt;<br>
&gt; Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set<br=
>
&gt; mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all<br>
&gt; interrupts will be disabled. Since our current OpenSBI does not<br>
&gt; support Smrnmi yet, let&#39;s disable Smrnmi for the &#39;max&#39; typ=
e CPU for<br>
&gt; now. We can re-enable it once OpenSBI includes proper support for it.<=
br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" tar=
get=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@=
ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ve=
ntanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 6 ++++++<br>
&gt;=C2=A0 2 files changed, 8 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 6c46a2f076..b0d9e93170 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext=
_smaia),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0,=
 ext_smcntrpmf),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ex=
t_smepmp),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smr=
nmi),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0,=
 ext_smstateen),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext=
_ssaia),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, h=
as_priv_1_11),<br>
&gt; @@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extension=
s[] =3D {<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smaia&quot;, ext_smaia, f=
alse),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smepmp&quot;, ext_smepmp,=
 false),<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smrnmi&quot;, ext_smrnmi, fals=
e),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smstateen&quot;, ext_smst=
ateen, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;ssaia&quot;, ext_ssaia, f=
alse),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;svade&quot;, ext_svade, f=
alse),<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index cbf2cf1963..c4070c948e 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -1421,6 +1421,12 @@ static void riscv_init_max_cpu_extensions(Objec=
t *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;misa_mxl !=3D MXL_RV32) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isa_ext_update_enabled(cpu, CPU_CFG_=
OFFSET(ext_zcf), false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* ext_smrnmi requires OpenSBI changes that our cu=
rrent<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* image does not have. Disable it for now.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi),=
 false);<br>
<br>
Should we log this to users so they know?<br>
<br>
Alistair<br></blockquote><div><br></div><div><div>Sure, I&#39;ve added it i=
n the v12 patchset.</div><div><br></div><div>Regards,</div><div>Frank Chang=
</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000f9f901062b03212b--

