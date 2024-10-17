Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6886D374A5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rp9-0001TL-KF; Thu, 17 Oct 2024 10:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t1Row-0001S8-Of
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:49:47 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t1Rou-0006E9-T5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:49:46 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so12897111fa.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729176580; x=1729781380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r62nnLCkuDM/Z6qpnbUBKPxbjg3b9wlo1mmXrcAbnnc=;
 b=dILreH+fPUdLsoshfZB9OWbttKqv7fOYHCU1KAZ4kjQCyfxBw2PWViNYV6Zvx4SzXo
 QdLTBSoLXHcaf+RFB7dSiCC/icn8DmJYWTSgSJEkDpwDTYaVulnK6ARRbS1QDnbRgsic
 PVh1JmnlcIxSezaUVm3FzEnByRa1pmrF0ox6DEWQPIFg+1Vo/5jMtSP3PD/V5UlutZ9/
 e+bjT0VzJpFgOo5JmWB3m3fr5Mn3VMBXOAz6sPW/bzHPekYMablvZaqffEkopodeaYqQ
 3gfU9ZYOBYpDFRTcUESqkZA2qpRxgT6d5cKyonrrXs6tTMNNGmY4XYLU5G6uAAK45Krr
 To/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176580; x=1729781380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r62nnLCkuDM/Z6qpnbUBKPxbjg3b9wlo1mmXrcAbnnc=;
 b=Uyz1F1GF19EgAtr0sYDsG0+FFkTIYfeeV7XVlqbP01dhPdiBMXLE1abm9CiJRAG5+0
 ChXKljME3UN/lXCSedzi/RBNbP48NLK+KiXucSS+Eat65j7y1N5Q9En8JVdNff8WVzJa
 YinvtkOgD/kn7ETk9XqvisMMk74w6XhR/jkM1mfbV/hbIC8y8VagQ3oesyc3WSAUDD/C
 reABS7SJ39pAYDORrTDAQsl/Lk1BYSGopI6miIJ9K1+/k0ct6C4KdzL3UinD72vnu2Y5
 AxsD38Viesbd1m6wtYdNOCCgfoT6kCUPU9Sif5oncHrEHMS+QaYDemaEoOxemrZdUAX4
 uMuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF/N9m5DurgRpQe4SngInCUn0dC+R78VdL1aN8dnAVYTAozrau4f8OkqZ50b39LEgrc18coU/eMdYg@nongnu.org
X-Gm-Message-State: AOJu0Yzk+eWI4112qMTs78+M7H3/iIGgAmNkGuhxVLzW0dH6UvhBZnZe
 XQdeUF1oOHMYvs8Gnv2qEIS78Er7YCNJC/BupLpvd2ZfEcyvqI2CmPTHuNzix6TQb1TcUUVcWDp
 uNEX66QMxbQjSs/e9tjFJE3rITgeue1kJLVdEAA==
X-Google-Smtp-Source: AGHT+IGwnuVxRApSWU7BNyC4HbA6HTk2R3pX0DIXM00zqBvTU4N3O4o0rZobbLeq9YSL0ep3ld7qVHG4l1lVU7C8DU4=
X-Received: by 2002:a2e:4601:0:b0:2fb:599a:a900 with SMTP id
 38308e7fff4ca-2fb61b4789fmr45930771fa.15.1729176580349; Thu, 17 Oct 2024
 07:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241014181948.1974405-1-frank.chang@sifive.com>
 <20241014181948.1974405-3-frank.chang@sifive.com>
 <1b9a53b3-79d0-4ba2-9450-35e28ecfbd79@rivosinc.com>
In-Reply-To: <1b9a53b3-79d0-4ba2-9450-35e28ecfbd79@rivosinc.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 17 Oct 2024 22:49:29 +0800
Message-ID: <CAE_xrPiMxUYRdAH7XXmb9Qmv6f1bJwFQL+OBHEV7OiD7E=WQrQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] target/riscv: Handle Smrnmi interrupt and exception
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Tommy Wu <tommy.wu@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000d395940624ad4b17"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x22b.google.com
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

--000000000000d395940624ad4b17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Thu, Oct 17, 2024 at 10:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:

>
>
> On 14/10/2024 20:19, frank.chang@sifive.com wrote:
> > @@ -1679,6 +1718,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      target_ulong mtval2 =3D 0;
> >      int sxlen =3D 0;
> >      int mxlen =3D 0;
> > + bool nnmi_excep =3D false;
> > +
> > + if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> > + env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false);
> > + env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPV,
> > + env->virt_enabled);
> > + env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_MNPP,
> > + env->priv);
> > + env->mncause =3D cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1))=
;
> > + env->mnepc =3D env->pc;
> > + env->pc =3D env->rnmi_irqvec;
> > + riscv_cpu_set_mode(env, PRV_M, virt);
>
> Hi Frank,
>
> Does it make sense to use the virt value here since if we are going to
> PRV_M mode, then virt should be false ?
>

Yes, you are right.
We need to pass virt_en to false as we are going to switch to M-mode.
Otherwise, we may hit the assertion in:
riscv_pmu_cycle_update_priv(), and riscv_pmu_icount_update_priv()
The TLB will also not be flushed properly on the virt mode changed.

I will fix it in the next patchset.

Thanks,
Frank Chang


>
> Thanks,
>
> Cl=C3=A9ment
>
>
> > + return;
> > + }
>
>

--000000000000d395940624ad4b17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Cl=C3=A9ment,</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 2024=
 at 10:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger &lt;<a href=3D"mailto:cleger@r=
ivosinc.com">cleger@rivosinc.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
<br>
On 14/10/2024 20:19, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_b=
lank">frank.chang@sifive.com</a> wrote:<br>
&gt; @@ -1679,6 +1718,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mtval2 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int sxlen =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mxlen =3D 0;<br>
&gt; + bool nnmi_excep =3D false;<br>
&gt; +<br>
&gt; + if (cpu-&gt;cfg.ext_smrnmi &amp;&amp; env-&gt;rnmip &amp;&amp; async=
) {<br>
&gt; + env-&gt;mnstatus =3D set_field(env-&gt;mnstatus, MNSTATUS_NMIE, fals=
e);<br>
&gt; + env-&gt;mnstatus =3D set_field(env-&gt;mnstatus, MNSTATUS_MNPV,<br>
&gt; + env-&gt;virt_enabled);<br>
&gt; + env-&gt;mnstatus =3D set_field(env-&gt;mnstatus, MNSTATUS_MNPP,<br>
&gt; + env-&gt;priv);<br>
&gt; + env-&gt;mncause =3D cause | ((target_ulong)1U &lt;&lt; (TARGET_LONG_=
BITS - 1));<br>
&gt; + env-&gt;mnepc =3D env-&gt;pc;<br>
&gt; + env-&gt;pc =3D env-&gt;rnmi_irqvec;<br>
&gt; + riscv_cpu_set_mode(env, PRV_M, virt);<br>
<br>
Hi Frank,<br>
<br>
Does it make sense to use the virt value here since if we are going to<br>
PRV_M mode, then virt should be false ?<br></blockquote><div><br></div><div=
>Yes, you are right.</div><div>We need to pass virt_en to false as we are g=
oing to switch to M-mode.</div><div>Otherwise, we may hit the assertion in:=
<br></div><div>riscv_pmu_cycle_update_priv(), and=C2=A0riscv_pmu_icount_upd=
ate_priv()<br></div><div>The TLB will also not be flushed properly on the v=
irt mode changed.</div><div><br></div><div>I will fix it in the next patchs=
et.</div><div><br></div><div>Thanks,</div><div>Frank Chang</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
Cl=C3=A9ment<br>
<br>
<br>
&gt; + return;<br>
&gt; + }<br>
<br>
</blockquote></div></div>

--000000000000d395940624ad4b17--

