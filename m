Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B2AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE1Js-0004Yx-N5; Mon, 03 Jun 2024 02:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE1Jr-0004YR-7z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:37:23 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE1Jm-0005Mv-LU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:37:23 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eb167e9175so189075e0c.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717396637; x=1718001437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qy8WFJ8ZfUfAEdW6TkkGFLhkCjtDAKJfPIexM1vz6hA=;
 b=AIcpvKOJVS6OZ3gJVzISq55Jur7V345HuVZ00CWJpFsGIRTSaWsOWQWIfaeJpUn3VZ
 FV4WgjwtLqgX2t/XhBUMtPdv6fp2/ZoMYxmu81cHOAJOWQMzXWnJL7YeTAK/iwH1r7T4
 FPzuwNHVMIa5JyuiGl8aYNJa2AOjFuJZyQZk9wODICVzLcmNTfOYkRkNxJkzfQRQ96Vr
 XJ2pURkKyTmEN0nTo3NITYkZJ/UnGId7ja5jMQ5XCPeMDXRo5lMJRllZ+25r0YLPjSLE
 WswjF2GlK7CTRU7w+O1LSJ4lMXsjiBiDCQZWB9AWR2gwp7AsoQxjgtnwAcs2SQE9n9RU
 eioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717396637; x=1718001437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qy8WFJ8ZfUfAEdW6TkkGFLhkCjtDAKJfPIexM1vz6hA=;
 b=R/UI9qyHqsDLJM/ZYREfEW81BTWmWM4Sr/YfuEMl8w6GoPT+UICGHJDdBDCoL5h/QV
 5kkXoLkXMVsLFWmBKbIQzmiFrKX7yF4EQLhp2AZyjB4wB6wxDdpXC644Tx3hI0uQBg6J
 YLLqP2cwWdP4RzmbfwKELHZRkrzHfxQke45VUYNGrtiC1Gq88tcZPf10GpOcbzHEv2PU
 nUj/vWnsHPJqkHLCiR83wSrIabRV/pCGK77c26nK7GFI1SJgFWiQo/y+yVrCD6GQqTCn
 yBskrCLNITVdg0tGS4S/kBYkS3LRV3C9uMt7/VlegbicyGaAZaFRNA/OHhs+9KBTwzuD
 nw6w==
X-Gm-Message-State: AOJu0YzmDpB02EpvFG/QHwmOjh2kYXhNyPO/b2K+sFrxxwC4mzoBLWHX
 tYdobSrmL+ndvrPhf0HAR/pj9Jhotb9xIk85n1z8Z9my5X3uTmpZtpYDSvWIUe4teGFd/MElkJM
 nwatrrHH/iHLO+MgOINxEJTH3JkBZNEtvh/qvjUlGGgU1GwHPaXE=
X-Google-Smtp-Source: AGHT+IGUZHRllQgZyyNCauqzDYw6fAzpfSX8N8dKYJ0we+jo5Y5uPYmFCvVZ+SyCRBqXzUHWKlfyO0DIFwrNv5r4cG4=
X-Received: by 2002:a1f:f483:0:b0:4d4:ef9:71b0 with SMTP id
 71dfb90a1353d-4eb02e126f1mr6022606e0c.7.1717396636860; Sun, 02 Jun 2024
 23:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <4d2d56aa-5758-4320-a5ef-53ebb87ab494@ventanamicro.com>
 <CAKhCfseJgRzyeg1seuZ15SR=f78E5rnbgfrzY_VeRDhPMOAhwA@mail.gmail.com>
 <20240530-0521d05b9924d724568bd6a2@orel>
In-Reply-To: <20240530-0521d05b9924d724568bd6a2@orel>
From: Fea Wang <fea.wang@sifive.com>
Date: Mon, 3 Jun 2024 14:37:05 +0800
Message-ID: <CAKhCfsc7=fUsq9+2rWNN=oYvWd0pR28ONNaYSNsqjRUx7ZY14g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] target/riscv: Support RISC-V privilege 1.13
 spec
To: Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000007a9ff70619f690ae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=fea.wang@sifive.com; helo=mail-vk1-xa32.google.com
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

--0000000000007a9ff70619f690ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel, Andrew:

Thank you for giving me the feedback.
I found a new command set to cc the related maintainer's email. It also
includes these emails for the cover letter.
git send-email --dry-run --to=3D'qemu-devel@nongnu.org,qemu-riscv@nongnu.or=
g'
--cc=3D"$(scripts/get_maintainer.pl XXXPATCH/* |sed -e 's/$/,/')" /XXXPATCH=
/*

Sincerely,
Fea

On Thu, May 30, 2024 at 6:37=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om>
wrote:

> On Thu, May 30, 2024 at 11:30:28AM GMT, Fea Wang wrote:
> > Hi Daniel,
> > thank you for your help.
> >
> > I found that only the cover is without many maintainers. I used to send
> > patches by git send-email --dry-run --to 'qemu-devel@nongnu.org,
> > qemu-riscv@nongnu.org' --cc-cmd=3D'scripts/get_maintainer.pl -i'
> patches/*.
> > Do you have a better script for me?
> > Thank you.
>
> Some maintainers frown on that because they prefer the whole series,
> even if only a few patches touch code they maintain. And, the cover
> letter is quite important to get the context. Also, depending on
> mail client and filter configurations, CC's that are per patch can
> mess up the threading, making a mess of the mailbox. I tend to
> use scripts/get_maintainer.pl to pull together a set of people/lists
> to CC as an independent step, dump the contents into a file and then
> do 'git send-email $(cat my-series.to-list) patches/my-series'
>
> git-publish can help with that too by capturing the "to list" and
> maintaining it for you.
>
> Thanks,
> drew
>
> >
> > Sincerely,
> > Fea
> >
> > On Mon, May 27, 2024 at 5:21=E2=80=AFPM Daniel Henrique Barboza <
> > dbarboza@ventanamicro.com> wrote:
> >
> > > Fea,
> > >
> > > Please try to also add all RISC-V QEMU maintainers and reviewers when
> > > sending
> > > patches. It will get your patches reviewed and queued faster.
> Otherwise the
> > > maintainers can miss you your series due to high ML traffic.
> > >
> > > You can fetch who you want to CC using the get_maintainer.pl script
> with
> > > the
> > > patch files or any source file in particular, e.g.:
> > >
> > > $ ./scripts/get_maintainer.pl -f target/riscv/cpu.c
> > > Palmer Dabbelt <palmer@dabbelt.com> (supporter:RISC-V TCG CPUs)
> > > Alistair Francis <alistair.francis@wdc.com> (supporter:RISC-V TCG
> CPUs)
> > > Bin Meng <bmeng.cn@gmail.com> (supporter:RISC-V TCG CPUs)
> > > Weiwei Li <liwei1518@gmail.com> (reviewer:RISC-V TCG CPUs)
> > > Daniel Henrique Barboza <dbarboza@ventanamicro.com> (reviewer:RISC-V
> TCG
> > > CPUs)
> > > Liu Zhiwei <zhiwei_liu@linux.alibaba.com> (reviewer:RISC-V TCG CPUs)
> > > qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
> > > qemu-devel@nongnu.org (open list:All patches CC here)
> > >
> > >
> > > I added the extra folk in the CC for this reply so don't worry about
> it.
> > >
> > >
> > > Alistair, please queue this series. It's already fully acked and I
> would
> > > like to add
> > > some bits on top of the priv_spec 1.13 support.
> > >
> > >
> > > Thanks,
> > >
> > >
> > > Daniel
> > >
> > > On 5/15/24 05:05, Fea.Wang wrote:
> > > > Based on the change log for the RISC-V privilege 1.13 spec, add the
> > > > support for ss1p13.
> > > >
> > > > Ref:
> > >
> https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.a=
doc?plain=3D1#L40-L72
> > > >
> > > > Lists what to do without clarification or document format.
> > > > * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip=
,
> > > implementation ignored)
> > > > * Added the constraint that SXLEN=E2=89=A5UXLEN.(Skip, implementati=
on
> ignored)
> > > > * Defined the misa.V field to reflect that the V extension has been
> > > implemented.(Skip, existed)
> > > > * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these
> > > patches)
> > > > * Defined the misaligned atomicity granule PMA, superseding the
> proposed
> > > Zam extension..(Skip, implementation ignored)
> > > > * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existe=
d)
> > > > * Defined hardware error and software check exception codes.(Done i=
n
> > > these patches)
> > > > * Specified synchronization requirements when changing the PBMTE
> fields
> > > in menvcfg and henvcfg.(Skip, implementation ignored)
> > > > * Incorporated Svade and Svadu extension specifications.(Skip,
> existed)
> > > >
> > > >
> > > > Fea.Wang (4):
> > > >    target/riscv: Support the version for ss1p13
> > > >    target/riscv: Add 'P1P13' bit in SMSTATEEN0
> > > >    target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
> > > >    target/riscv: Reserve exception codes for sw-check and hw-err
> > > >
> > > > Jim Shu (1):
> > > >    target/riscv: Reuse the conversion function of priv_spec
> > > >
> > > >   target/riscv/cpu.c         |  8 ++++++--
> > > >   target/riscv/cpu.h         |  5 ++++-
> > > >   target/riscv/cpu_bits.h    |  5 +++++
> > > >   target/riscv/cpu_cfg.h     |  1 +
> > > >   target/riscv/csr.c         | 39
> ++++++++++++++++++++++++++++++++++++++
> > > >   target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
> > > >   6 files changed, 63 insertions(+), 12 deletions(-)
> > > >
> > >
>

--0000000000007a9ff70619f690ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel, Andrew:<div><br></div><div>Thank you for giving=
 me the feedback.</div><div>I found a new command set to cc the related mai=
ntainer&#39;s email. It also includes these emails for the cover letter.</d=
iv><div><span style=3D"background-color:rgb(204,204,204)">git send-email --=
dry-run --to=3D&#39;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@non=
gnu.org</a>,<a href=3D"mailto:qemu-riscv@nongnu.org">qemu-riscv@nongnu.org<=
/a>&#39; --cc=3D&quot;$(scripts/<a href=3D"http://get_maintainer.pl">get_ma=
intainer.pl</a>=C2=A0</span><span style=3D"background-color:rgb(204,204,204=
)">XXXPATCH</span><span style=3D"background-color:rgb(204,204,204)">/* |sed=
 -e &#39;s/$/,/&#39;)&quot; /XXXPATCH/*</span><br></div><div><span style=3D=
"background-color:rgb(204,204,204)"><br></span></div><div>Sincerely,<br></d=
iv><div>Fea</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Thu, May 30, 2024 at 6:37=E2=80=AFPM Andrew Jones &lt;<=
a href=3D"mailto:ajones@ventanamicro.com">ajones@ventanamicro.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Ma=
y 30, 2024 at 11:30:28AM GMT, Fea Wang wrote:<br>
&gt; Hi Daniel,<br>
&gt; thank you for your help.<br>
&gt; <br>
&gt; I found that only the cover is without many maintainers. I used to sen=
d<br>
&gt; patches by git send-email --dry-run --to &#39;<a href=3D"mailto:qemu-d=
evel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a>,<br>
&gt; <a href=3D"mailto:qemu-riscv@nongnu.org" target=3D"_blank">qemu-riscv@=
nongnu.org</a>&#39; --cc-cmd=3D&#39;scripts/<a href=3D"http://get_maintaine=
r.pl" rel=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a> -i&#39; pa=
tches/*.<br>
&gt; Do you have a better script for me?<br>
&gt; Thank you.<br>
<br>
Some maintainers frown on that because they prefer the whole series,<br>
even if only a few patches touch code they maintain. And, the cover<br>
letter is quite important to get the context. Also, depending on<br>
mail client and filter configurations, CC&#39;s that are per patch can<br>
mess up the threading, making a mess of the mailbox. I tend to<br>
use scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer" target=
=3D"_blank">get_maintainer.pl</a> to pull together a set of people/lists<br=
>
to CC as an independent step, dump the contents into a file and then<br>
do &#39;git send-email $(cat my-series.to-list) patches/my-series&#39;<br>
<br>
git-publish can help with that too by capturing the &quot;to list&quot; and=
<br>
maintaining it for you.<br>
<br>
Thanks,<br>
drew<br>
<br>
&gt; <br>
&gt; Sincerely,<br>
&gt; Fea<br>
&gt; <br>
&gt; On Mon, May 27, 2024 at 5:21=E2=80=AFPM Daniel Henrique Barboza &lt;<b=
r>
&gt; <a href=3D"mailto:dbarboza@ventanamicro.com" target=3D"_blank">dbarboz=
a@ventanamicro.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Fea,<br>
&gt; &gt;<br>
&gt; &gt; Please try to also add all RISC-V QEMU maintainers and reviewers =
when<br>
&gt; &gt; sending<br>
&gt; &gt; patches. It will get your patches reviewed and queued faster. Oth=
erwise the<br>
&gt; &gt; maintainers can miss you your series due to high ML traffic.<br>
&gt; &gt;<br>
&gt; &gt; You can fetch who you want to CC using the <a href=3D"http://get_=
maintainer.pl" rel=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a> s=
cript with<br>
&gt; &gt; the<br>
&gt; &gt; patch files or any source file in particular, e.g.:<br>
&gt; &gt;<br>
&gt; &gt; $ ./scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferre=
r" target=3D"_blank">get_maintainer.pl</a> -f target/riscv/cpu.c<br>
&gt; &gt; Palmer Dabbelt &lt;<a href=3D"mailto:palmer@dabbelt.com" target=
=3D"_blank">palmer@dabbelt.com</a>&gt; (supporter:RISC-V TCG CPUs)<br>
&gt; &gt; Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" =
target=3D"_blank">alistair.francis@wdc.com</a>&gt; (supporter:RISC-V TCG CP=
Us)<br>
&gt; &gt; Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com" target=3D"_bla=
nk">bmeng.cn@gmail.com</a>&gt; (supporter:RISC-V TCG CPUs)<br>
&gt; &gt; Weiwei Li &lt;<a href=3D"mailto:liwei1518@gmail.com" target=3D"_b=
lank">liwei1518@gmail.com</a>&gt; (reviewer:RISC-V TCG CPUs)<br>
&gt; &gt; Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamic=
ro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt; (reviewer:RISC-=
V TCG<br>
&gt; &gt; CPUs)<br>
&gt; &gt; Liu Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com" ta=
rget=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt; (reviewer:RISC-V TCG C=
PUs)<br>
&gt; &gt; <a href=3D"mailto:qemu-riscv@nongnu.org" target=3D"_blank">qemu-r=
iscv@nongnu.org</a> (open list:RISC-V TCG CPUs)<br>
&gt; &gt; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-d=
evel@nongnu.org</a> (open list:All patches CC here)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I added the extra folk in the CC for this reply so don&#39;t worr=
y about it.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Alistair, please queue this series. It&#39;s already fully acked =
and I would<br>
&gt; &gt; like to add<br>
&gt; &gt; some bits on top of the priv_spec 1.13 support.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Daniel<br>
&gt; &gt;<br>
&gt; &gt; On 5/15/24 05:05, Fea.Wang wrote:<br>
&gt; &gt; &gt; Based on the change log for the RISC-V privilege 1.13 spec, =
add the<br>
&gt; &gt; &gt; support for ss1p13.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Ref:<br>
&gt; &gt; <a href=3D"https://github.com/riscv/riscv-isa-manual/blob/a7d93c9=
/src/priv-preface.adoc?plain=3D1#L40-L72" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface=
.adoc?plain=3D1#L40-L72</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Lists what to do without clarification or document format.<b=
r>
&gt; &gt; &gt; * Redefined misa.MXL to be read-only, making MXLEN a constan=
t.(Skip,<br>
&gt; &gt; implementation ignored)<br>
&gt; &gt; &gt; * Added the constraint that SXLEN=E2=89=A5UXLEN.(Skip, imple=
mentation ignored)<br>
&gt; &gt; &gt; * Defined the misa.V field to reflect that the V extension h=
as been<br>
&gt; &gt; implemented.(Skip, existed)<br>
&gt; &gt; &gt; * Defined the RV32-only medelegh and hedelegh CSRs.(Done in =
these<br>
&gt; &gt; patches)<br>
&gt; &gt; &gt; * Defined the misaligned atomicity granule PMA, superseding =
the proposed<br>
&gt; &gt; Zam extension..(Skip, implementation ignored)<br>
&gt; &gt; &gt; * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip,=
 existed)<br>
&gt; &gt; &gt; * Defined hardware error and software check exception codes.=
(Done in<br>
&gt; &gt; these patches)<br>
&gt; &gt; &gt; * Specified synchronization requirements when changing the P=
BMTE fields<br>
&gt; &gt; in menvcfg and henvcfg.(Skip, implementation ignored)<br>
&gt; &gt; &gt; * Incorporated Svade and Svadu extension specifications.(Ski=
p, existed)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fea.Wang (4):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 target/riscv: Support the version for ss1p13<br=
>
&gt; &gt; &gt;=C2=A0 =C2=A0 target/riscv: Add &#39;P1P13&#39; bit in SMSTAT=
EEN0<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 target/riscv: Add MEDELEGH, HEDELEGH csrs for R=
V32<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 target/riscv: Reserve exception codes for sw-ch=
eck and hw-err<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Jim Shu (1):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 target/riscv: Reuse the conversion function of =
priv_spec<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 8 ++++++--<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 5 ++++-<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 |=C2=A0 5 +=
++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 39 ++++++++++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c | 17 ++++++++--------=
-<br>
&gt; &gt; &gt;=C2=A0 =C2=A06 files changed, 63 insertions(+), 12 deletions(=
-)<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div>

--0000000000007a9ff70619f690ae--

