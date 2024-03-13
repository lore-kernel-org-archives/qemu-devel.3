Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5146DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLir-0007Vq-Ed; Wed, 13 Mar 2024 06:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkLip-0007Po-E8
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:20:31 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkLin-0000iJ-J7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:20:31 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d45c8b056dso4920631fa.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710325227; x=1710930027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cxHzmZMqv+ah9YgoZT2bDvOA1PK8sTDFrWgPEpa6bw0=;
 b=B4yFPfVBQ69TFUlCoSsB3RErcvldOcWZ6Yka+oPutyhFcKVt/2RYZ7w79VuZw1p9x4
 PAABjONGDZM6WhpA2Tx19OvjxFVWiWtsV9X+ZpTzHu3IzqR1W778wyPCi+25SJrDdoeb
 QtOpqov419pkKN1YnHAgitSBrDJyH0HVPS3sAv43UH2RZxaR1MtKe5bKujcpUkXDV8qm
 CcT4jUQp769k32xH75dJXSV3Bj3gQHCDV/aJnNKVAFoCxXmghABi2bqA4X3UYGaEleax
 7ILVUYLjDZHeJ6AdALjEk1qyhgBUvZ8dcg50k0o5ijDJoWcuT688dqbMBaikD6XL3SCC
 +Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325227; x=1710930027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cxHzmZMqv+ah9YgoZT2bDvOA1PK8sTDFrWgPEpa6bw0=;
 b=B0eAnWiLf+LtINF4t1wSBfJca1/Z0eR/64x0MOcvqlu8gAQfzQS8HR+fF3koYm978Q
 3tn2oLqjHnTMqOBYiXD+ig9me/B2WJ2zsHvTtx5XfLBv92N4G2M/9kEYalNgg046Vv6w
 TBRQTp8M/FKujWjNWAwwOLfooaAfg7BE9pkxk3YHiImRLR6R9ur+EOSPC1AJXX1jJeIA
 MPhM6AYzIsM3ELL+w6KcvLhyJnIKfP3w2K+91piib9JHsof1QQftLA1aRILQpb/kyjhn
 wi4cm58gDxlCH6RTNbiFRohJtToqUnrc/aRBvh3bjuC8FfwP0rKzBTG8KwkkKWBtAyKZ
 xBFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjn5EOj8gcpPOf5+w00zsVr8T7OnlGbuareJYnYnmTOXBVq67TWq6ORwh8Ly9AR7R7sMVK5s5CRAId95uMqA1NbL4RRM=
X-Gm-Message-State: AOJu0YwaDUCfkoMI1E42eAooKMxp4ZYFhDXA22KW44Dt6gj/4L50jL3t
 EoHv38FAPfCD0VpEdory2T8BpBkQ/XCp4TGeJ+e6B8cU0ZeYhFUci0npGn6oUSN6XHldTOvQVh7
 HUJ6KaBchWkof6kJ2a9N0sLHyShfdpmIp0Hdm2A==
X-Google-Smtp-Source: AGHT+IGs83fswtHZLRyyWKZgjI3nzxRFySZcAFlt9x67tELk9PoOdy+dRsGmvitOyk84vYVkecRN7fTQydnVzoRUHSg=
X-Received: by 2002:a2e:998c:0:b0:2d3:624d:c53a with SMTP id
 w12-20020a2e998c000000b002d3624dc53amr920869lji.4.1710325227241; Wed, 13 Mar
 2024 03:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
 <20240313-0ac597594e930a42685aeba5@orel>
In-Reply-To: <20240313-0ac597594e930a42685aeba5@orel>
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
Date: Wed, 13 Mar 2024 15:50:16 +0530
Message-ID: <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009ee9460613881fc9"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-lj1-x229.google.com
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

--0000000000009ee9460613881fc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om>
wrote:

> On Wed, Mar 13, 2024 at 11:39:30AM +0530, Himanshu Chauhan wrote:
> > This patch adds "sdtrig" in the ISA string when sdtrig extension is
> enabled.
> > The sdtrig extension may or may not be implemented in a system.
> Therefore, the
> >            -cpu rv64,sdtrig=3D<true/false>
> > option can be used to dynamically turn sdtrig extension on or off.
> >
> > Since, the sdtrig ISA extension is a superset of debug specification,
> disable
> > the debug property when sdtrig is enabled. A warning is printed when
> this is
> > done.
> >
> > By default, the sdtrig extension is disabled and debug property enabled
> as usual.
> >
> > Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> > ---
> >  target/riscv/cpu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 2602aae9f5..ab057a0926 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> >      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> > +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
> >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> >      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> >      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> > @@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object *obj)
> >      set_default_nan_mode(1, &env->fp_status);
> >
> >  #ifndef CONFIG_USER_ONLY
> > +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> > +         warn_report("Disabling debug property since sdtrig ISA
> extension "
> > +                     "is enabled");
> > +         cpu->cfg.debug =3D 0;
>
> If sdtrig is a superset of debug, then why do we need to disable debug?
>

"debug" is not disabled. The flag is turned off. This is for unambiguity
between which spec is in force currently.
May come handy (not now but later) in if conditions.


>
> Thanks,
> drew
>
> > +    }
> > +
> >      if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
> >          riscv_trigger_reset_hold(env);
> >      }
> > @@ -1480,6 +1487,7 @@ const RISCVCPUMultiExtConfig
> riscv_cpu_extensions[] =3D {
> >      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
> >      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> >
> > +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
> >      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> >      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> >      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> > --
> > 2.34.1
> >
> >
>

--0000000000009ee9460613881fc9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 13, 2024 at 3:24=E2=80=AF=
PM Andrew Jones &lt;<a href=3D"mailto:ajones@ventanamicro.com">ajones@venta=
namicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Mar 13, 2024 at 11:39:30AM +0530, Himanshu Chauhan wrote=
:<br>
&gt; This patch adds &quot;sdtrig&quot; in the ISA string when sdtrig exten=
sion is enabled.<br>
&gt; The sdtrig extension may or may not be implemented in a system. Theref=
ore, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -cpu rv64,sdtrig=3D&lt;true/f=
alse&gt;<br>
&gt; option can be used to dynamically turn sdtrig extension on or off.<br>
&gt; <br>
&gt; Since, the sdtrig ISA extension is a superset of debug specification, =
disable<br>
&gt; the debug property when sdtrig is enabled. A warning is printed when t=
his is<br>
&gt; done.<br>
&gt; <br>
&gt; By default, the sdtrig extension is disabled and debug property enable=
d as usual.<br>
&gt; <br>
&gt; Signed-off-by: Himanshu Chauhan &lt;<a href=3D"mailto:hchauhan@ventana=
micro.com" target=3D"_blank">hchauhan@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c | 8 ++++++++<br>
&gt;=C2=A0 1 file changed, 8 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 2602aae9f5..ab057a0926 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_=
zvkt),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext=
_zhinx),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, =
ext_zhinxmin),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdt=
rig),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext=
_smaia),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ex=
t_smepmp),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0,=
 ext_smstateen),<br>
&gt; @@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object *obj)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 set_default_nan_mode(1, &amp;env-&gt;fp_status);<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.debug &amp;&amp; cpu-&gt;cfg.ext_sdtrig=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0warn_report(&quot;Disabling debug p=
roperty since sdtrig ISA extension &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;is enabled&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.debug =3D 0;<br>
<br>
If sdtrig is a superset of debug, then why do we need to disable debug?<br>=
</blockquote><div><br></div><div>&quot;debug&quot; is not disabled. The fla=
g is turned off. This is for unambiguity between which spec is in force cur=
rently.</div><div>May come handy (not now but later) in if conditions.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
drew<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (cpu-&gt;cfg.debug || cpu-&gt;cfg.ext_sdtrig) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_trigger_reset_hold(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -1480,6 +1487,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extension=
s[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;zvfhmin&quot;, ext_zvfhmi=
n, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;sstc&quot;, ext_sstc, tru=
e),<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;sdtrig&quot;, ext_sdtrig, fals=
e),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smaia&quot;, ext_smaia, f=
alse),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smepmp&quot;, ext_smepmp,=
 false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smstateen&quot;, ext_smst=
ateen, false),<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
&gt; <br>
</blockquote></div></div>

--0000000000009ee9460613881fc9--

