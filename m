Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB92C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 03:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCWV4-0008S0-PR; Wed, 29 May 2024 23:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sCWV3-0008RQ-4G
 for qemu-devel@nongnu.org; Wed, 29 May 2024 23:30:45 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sCWV0-0007u5-0h
 for qemu-devel@nongnu.org; Wed, 29 May 2024 23:30:43 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-80ad0bb602eso26144241.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717039840; x=1717644640; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jdo4tjkmUiqNVp7+LlkCxwwqZd0ECj+B8sj+vTLMz58=;
 b=mT3h1OOWFE7apRS7fn7XzTe9XlVQvHMQW+f7Nk5rtffH+9B+yXpscgYZv4zijTfPC9
 h9BJ84+Yv3SYIhXQyeLQpy+H/1Fo5PRn3SQSWNab/jZJAq2GljbGj3saDaxfGv0pN1IZ
 96CJil+nDeQrxgNMGG34f4CiO+5PPdvZEpO2aq5Or4eARxtPJtPhKi+ZN7L0y9B8NAuR
 uUKc/EYD/UJ6UrPmTXNkL5WQK9kGh2CYsuVHjFc7Z+u1DQ63tOcbmi8I7c1EBwOW5/8/
 LsQPB8Hdq7+D/is8XGcd8vQ5+JjRrAJiFStBPvxsA0lX3e39MLFKplGNNfZxB4uuf1Rp
 D19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717039840; x=1717644640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jdo4tjkmUiqNVp7+LlkCxwwqZd0ECj+B8sj+vTLMz58=;
 b=flNLztJr3so1TFGgNVu+QJ2WNOakyDZ4nu1xbPXAAdxprZCuIE4UKiesZalYX+GkK8
 fS6eSGomsdienKQ3fda6X3EOcYhHpU8MvpsR6ExrS2wnYedkmvrQ8kSoMK27YCHvAfkp
 Y0rui9rEEAh3o9CMAsIOOiEtb0q4j4CihNv964y+mPtzOUxOEpIX9+Qpo8HM8G+Lf7Ym
 9jawosGFVRBtF3qSnbKArdD/tfq9H36vNe+7HYrwwXDQESTmHw4tk6Vj/YUhgYgfn/t/
 J77rJ21/G4WW6lvib3T9NrlCNtWJmI5fx9f+hKxWVVerbJyQhdUzMk5c9/t9vjrv4gwt
 5PVA==
X-Gm-Message-State: AOJu0YywSIGaYCyRGSvBRpW41SiMG3VvU9Vsg4yMTPzfCitMEgcMgp0p
 M+lBRjCrGBusDtV2tnq52gFENiipj55aPirSaMe0ZgRi4bDCpueZY1F3p5eIWKuhBhzmUldAuRI
 /u7TTqWNgUVMErC6OOxhL5EbriG59wvhQfDr3oQ==
X-Google-Smtp-Source: AGHT+IFaxFdcol8HakCO1g3a5UqvW+pmTtEbd/uBxawxKzShkIbDhdrBHwHb+ZDCOOT277C74MB4xriAoHDgsPyTnjs=
X-Received: by 2002:a05:6122:181f:b0:4e4:eab4:ba2a with SMTP id
 71dfb90a1353d-4eaf2493ca3mr1155609e0c.16.1717039840458; Wed, 29 May 2024
 20:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <4d2d56aa-5758-4320-a5ef-53ebb87ab494@ventanamicro.com>
In-Reply-To: <4d2d56aa-5758-4320-a5ef-53ebb87ab494@ventanamicro.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Thu, 30 May 2024 11:30:28 +0800
Message-ID: <CAKhCfseJgRzyeg1seuZ15SR=f78E5rnbgfrzY_VeRDhPMOAhwA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] target/riscv: Support RISC-V privilege 1.13
 spec
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000c195900619a37dd2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=fea.wang@sifive.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c195900619a37dd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
thank you for your help.

I found that only the cover is without many maintainers. I used to send
patches by git send-email --dry-run --to 'qemu-devel@nongnu.org,
qemu-riscv@nongnu.org' --cc-cmd=3D'scripts/get_maintainer.pl -i' patches/*.
Do you have a better script for me?
Thank you.

Sincerely,
Fea

On Mon, May 27, 2024 at 5:21=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Fea,
>
> Please try to also add all RISC-V QEMU maintainers and reviewers when
> sending
> patches. It will get your patches reviewed and queued faster. Otherwise t=
he
> maintainers can miss you your series due to high ML traffic.
>
> You can fetch who you want to CC using the get_maintainer.pl script with
> the
> patch files or any source file in particular, e.g.:
>
> $ ./scripts/get_maintainer.pl -f target/riscv/cpu.c
> Palmer Dabbelt <palmer@dabbelt.com> (supporter:RISC-V TCG CPUs)
> Alistair Francis <alistair.francis@wdc.com> (supporter:RISC-V TCG CPUs)
> Bin Meng <bmeng.cn@gmail.com> (supporter:RISC-V TCG CPUs)
> Weiwei Li <liwei1518@gmail.com> (reviewer:RISC-V TCG CPUs)
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> (reviewer:RISC-V TCG
> CPUs)
> Liu Zhiwei <zhiwei_liu@linux.alibaba.com> (reviewer:RISC-V TCG CPUs)
> qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
>
> I added the extra folk in the CC for this reply so don't worry about it.
>
>
> Alistair, please queue this series. It's already fully acked and I would
> like to add
> some bits on top of the priv_spec 1.13 support.
>
>
> Thanks,
>
>
> Daniel
>
> On 5/15/24 05:05, Fea.Wang wrote:
> > Based on the change log for the RISC-V privilege 1.13 spec, add the
> > support for ss1p13.
> >
> > Ref:
> https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.a=
doc?plain=3D1#L40-L72
> >
> > Lists what to do without clarification or document format.
> > * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip,
> implementation ignored)
> > * Added the constraint that SXLEN=E2=89=A5UXLEN.(Skip, implementation i=
gnored)
> > * Defined the misa.V field to reflect that the V extension has been
> implemented.(Skip, existed)
> > * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these
> patches)
> > * Defined the misaligned atomicity granule PMA, superseding the propose=
d
> Zam extension..(Skip, implementation ignored)
> > * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed)
> > * Defined hardware error and software check exception codes.(Done in
> these patches)
> > * Specified synchronization requirements when changing the PBMTE fields
> in menvcfg and henvcfg.(Skip, implementation ignored)
> > * Incorporated Svade and Svadu extension specifications.(Skip, existed)
> >
> >
> > Fea.Wang (4):
> >    target/riscv: Support the version for ss1p13
> >    target/riscv: Add 'P1P13' bit in SMSTATEEN0
> >    target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
> >    target/riscv: Reserve exception codes for sw-check and hw-err
> >
> > Jim Shu (1):
> >    target/riscv: Reuse the conversion function of priv_spec
> >
> >   target/riscv/cpu.c         |  8 ++++++--
> >   target/riscv/cpu.h         |  5 ++++-
> >   target/riscv/cpu_bits.h    |  5 +++++
> >   target/riscv/cpu_cfg.h     |  1 +
> >   target/riscv/csr.c         | 39 +++++++++++++++++++++++++++++++++++++=
+
> >   target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
> >   6 files changed, 63 insertions(+), 12 deletions(-)
> >
>

--000000000000c195900619a37dd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Daniel,<div>thank you for your help.</div><div><br=
></div><div>I found that only the cover is without many maintainers. I used=
 to send patches by <span style=3D"background-color:rgb(238,238,238)">git s=
end-email --dry-run --to &#39;<a href=3D"mailto:qemu-devel@nongnu.org">qemu=
-devel@nongnu.org</a>,<a href=3D"mailto:qemu-riscv@nongnu.org">qemu-riscv@n=
ongnu.org</a>&#39; --cc-cmd=3D&#39;scripts/<a href=3D"http://get_maintainer=
.pl">get_maintainer.pl</a> -i&#39; patches/*</span>. Do you have a better s=
cript for me?</div><div>Thank you.</div><div><br></div><div>Sincerely,</div=
><div>Fea</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, May 27, 2024 at 5:21=E2=80=AFPM Daniel Henrique Bar=
boza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Fea,<br>
<br>
Please try to also add all RISC-V QEMU maintainers and reviewers when sendi=
ng<br>
patches. It will get your patches reviewed and queued faster. Otherwise the=
<br>
maintainers can miss you your series due to high ML traffic.<br>
<br>
You can fetch who you want to CC using the <a href=3D"http://get_maintainer=
.pl" rel=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a> script with=
 the<br>
patch files or any source file in particular, e.g.:<br>
<br>
$ ./scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer" target=
=3D"_blank">get_maintainer.pl</a> -f target/riscv/cpu.c<br>
Palmer Dabbelt &lt;<a href=3D"mailto:palmer@dabbelt.com" target=3D"_blank">=
palmer@dabbelt.com</a>&gt; (supporter:RISC-V TCG CPUs)<br>
Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" target=3D"=
_blank">alistair.francis@wdc.com</a>&gt; (supporter:RISC-V TCG CPUs)<br>
Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com" target=3D"_blank">bmeng.=
cn@gmail.com</a>&gt; (supporter:RISC-V TCG CPUs)<br>
Weiwei Li &lt;<a href=3D"mailto:liwei1518@gmail.com" target=3D"_blank">liwe=
i1518@gmail.com</a>&gt; (reviewer:RISC-V TCG CPUs)<br>
Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com" ta=
rget=3D"_blank">dbarboza@ventanamicro.com</a>&gt; (reviewer:RISC-V TCG CPUs=
)<br>
Liu Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com" target=3D"_b=
lank">zhiwei_liu@linux.alibaba.com</a>&gt; (reviewer:RISC-V TCG CPUs)<br>
<a href=3D"mailto:qemu-riscv@nongnu.org" target=3D"_blank">qemu-riscv@nongn=
u.org</a> (open list:RISC-V TCG CPUs)<br>
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a> (open list:All patches CC here)<br>
<br>
<br>
I added the extra folk in the CC for this reply so don&#39;t worry about it=
.<br>
<br>
<br>
Alistair, please queue this series. It&#39;s already fully acked and I woul=
d like to add<br>
some bits on top of the priv_spec 1.13 support.<br>
<br>
<br>
Thanks,<br>
<br>
<br>
Daniel<br>
<br>
On 5/15/24 05:05, Fea.Wang wrote:<br>
&gt; Based on the change log for the RISC-V privilege 1.13 spec, add the<br=
>
&gt; support for ss1p13.<br>
&gt; <br>
&gt; Ref:<a href=3D"https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/=
src/priv-preface.adoc?plain=3D1#L40-L72" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.=
adoc?plain=3D1#L40-L72</a><br>
&gt; <br>
&gt; Lists what to do without clarification or document format.<br>
&gt; * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, i=
mplementation ignored)<br>
&gt; * Added the constraint that SXLEN=E2=89=A5UXLEN.(Skip, implementation =
ignored)<br>
&gt; * Defined the misa.V field to reflect that the V extension has been im=
plemented.(Skip, existed)<br>
&gt; * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patc=
hes)<br>
&gt; * Defined the misaligned atomicity granule PMA, superseding the propos=
ed Zam extension..(Skip, implementation ignored)<br>
&gt; * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed)<=
br>
&gt; * Defined hardware error and software check exception codes.(Done in t=
hese patches)<br>
&gt; * Specified synchronization requirements when changing the PBMTE field=
s in menvcfg and henvcfg.(Skip, implementation ignored)<br>
&gt; * Incorporated Svade and Svadu extension specifications.(Skip, existed=
)<br>
&gt; <br>
&gt; <br>
&gt; Fea.Wang (4):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Support the version for ss1p13<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add &#39;P1P13&#39; bit in SMSTATEEN0<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32<br>
&gt;=C2=A0 =C2=A0 target/riscv: Reserve exception codes for sw-check and hw=
-err<br>
&gt; <br>
&gt; Jim Shu (1):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Reuse the conversion function of priv_spec<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 8 ++++++--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 ++++-<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 +=
+++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------<br>
&gt;=C2=A0 =C2=A06 files changed, 63 insertions(+), 12 deletions(-)<br>
&gt; <br>
</blockquote></div>

--000000000000c195900619a37dd2--

