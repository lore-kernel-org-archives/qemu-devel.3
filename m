Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361D7C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcq3J-00056H-Sj; Wed, 21 Feb 2024 12:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rcq38-00052g-Ed
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:06:29 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rcq34-0004MV-0r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:06:26 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so77752231fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708535179; x=1709139979;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Lu3NGS2cV7VkwjY5TnGrts+MeZwj/RCFb6Jcq1qGl0=;
 b=O5svalCeR4dYiBUGeLKBtcjLLG7P1woiec0hXxF1juGk/D762uwcWK6rfU07dtv6bJ
 MRtoDBvDQured3sUmDdpNFk/LiQXeJjevh/KduOpUSncFQKmNP6iuCfqVJGOIX7LLH90
 OciAoAWQw56SjyAG/QOg0rhhKXZYKbhSCpROpVXdl1TT963sKqK3IV5F+0yQCSYbkuWY
 ved1d4meYexeSepaV2mTaF0hJVgvPQKR8przlgtxjggAbXy4SptwUzsYmn14IBPkqQJe
 lpAYOFwGFByzmhH1to47MdfxjsJ/ER9ZmyxN7oKDPDX6JYmMzjePGpNac9WfgEvwtWrf
 I1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535179; x=1709139979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Lu3NGS2cV7VkwjY5TnGrts+MeZwj/RCFb6Jcq1qGl0=;
 b=LJ5bqrrn3yt5Z/yWNV3zrl+f2mQZCKiuv1r3kiaMx8ej/5JgNXypBXQiWqzGY8SExy
 tk/OZ9TPOVKOyXKVxDgaCeN4Dbi/XhcPT30zNeJAoCrFkoNln3zTZSNluknbn2MKozNy
 d9y+5LxuWTVbCP/pe3anfrydWXVs7ha4l5nN5bDg9gg+4+W82jPC0F0aH3ramW4yRooG
 q7KodunniW9fwR7p2m5tZkrpsUwQpFhKyeXogialottBR1BTzLR3Zz+hxygHVlDMHn++
 xYl0LnBYWsorKGWOanKw2esei5BWr1TJabg53hJN7Ox9tvO1jYuXsLFF7DUz1mYOdNJd
 hCzA==
X-Gm-Message-State: AOJu0YyVeqNhx6bCi5/bdsB2/+dyq+BqfVFcYaHCXbaUzClD38hPhx9x
 FSOfc5fYh6fRRWgRfP31l76ZIV+FOQfSo7+khNZ8eniY/XkJ6AwGESGk+L4RZU3B8/Kpc9bi73t
 AnEX1VEuTVhgrPYy1jMDdcpjESgEX8O46xqA8BfN4+XX1/BEJiIcJeg==
X-Google-Smtp-Source: AGHT+IHtwtnmJfBx5ljR5F2YiX33Wj2S3JVD51+wGjpvq3RKjxUEoCnnM+UulLKAmTc47NIAZ+EeCzVkn+/U13lL5mY=
X-Received: by 2002:a05:651c:211c:b0:2d2:5d3f:7efd with SMTP id
 a28-20020a05651c211c00b002d25d3f7efdmr301711ljq.16.1708535179058; Wed, 21 Feb
 2024 09:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com>
In-Reply-To: <35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 21 Feb 2024 09:06:08 -0800
Message-ID: <CAHBxVyEnRcvB5iGDv8rE6oJ6L+yvM12ia+T0ZtsAx73TW5PfrQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] Add Counter delegation ISA extension support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: multipart/alternative; boundary="0000000000006f366d0611e7589a"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000006f366d0611e7589a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:58=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Atish,
>
> This series and its dependency, which I assume it's
>
> "[PATCH v4 0/5] Add ISA extension smcntrpmf support"
>
> Doesn't apply in neither master nor riscv-to-apply.next because of this
> patch:
>
"target/riscv: Use RISCVException as return type for all csr ops"
>
> That changed some functions from 'int' to "RISCVException" type. The
> conflicts
> from the v4 series are rather trivial but the conflicts for this RFC are
> annoying
> to deal with. It would be better if you could re-send both series rebased
> with
> the latest changes.
>
>
I was waiting for Alistair's ACK on the smcntrpmf series as he had some
comments. It looks like he is okay
with the series now (no further questions).  Let me respin both the series.


> One more thing:
>
> On 2/16/24 21:01, Atish Patra wrote:
> > This series adds the counter delegation extension support. The counter
> > delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple
> ISA
> > extensions.
> >
> > 1. S[m|s]csrind : The indirect CSR extension[1] which defines additiona=
l
> >     5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation
> of
> >     RISC-V CSR address space.
> > 2. Smstateen: The stateen bit[60] controls the access to the registers
> >     indirectly via the above indirect registers.
> > 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
> >
> > The counter delegation extension allows Supervisor mode to program the
> > hpmevent and hpmcounters directly without needing the assistance from t=
he
> > M-mode via SBI calls. This results in a faster perf profiling and very
> > few traps. This extension also introduces a scountinhibit CSR which
> allows
> > to stop/start any counter directly from the S-mode. As the counter
> > delegation extension potentially can have more than 100 CSRs, the
> specificaiton
> > leverages the indirect CSR extension to save the precious CSR address
> range.
> >
> > Due to the dependancy of these extensions, the following extensions mus=
t
> be
> > enabled to use the counter delegation feature in S-mode.
> >
> >
> "smstateen=3Dtrue,sscofpmf=3Dtrue,ssccfg=3Dtrue,smcdeleg=3Dtrue,smcsrind=
=3Dtrue,sscsrind=3Dtrue"
> >
> > This makes the qemu command line quite tedious. In stead of that, I
> think we
> > can enable these features by default if there is no objection.
>
> It wasn't need so far but, if needed, we can add specialized setters for
> extensions
> that has multiple dependencies. Instead of the usual setter we would do
> something
> like:
>
> cpu_set_ssccfg() {
>
>      if (enabled) {
>          smstateen=3Dtrue
>          sscofpmf=3Dtrue
>          smcdeleg=3Dtrue
>          smcsrind=3Dtrue
>          sscsrind=3Dtrue
>      }
> }
>
>
> The advantage is that this setter would also work for CPUs that doesn't
> inherit defaults,
> like bare-cps and profile CPUs.
>
>
Your suggested approach looks good to me. But I was asking about concerns
about enabling these extensions
by default rather than the actual mechanism to implement it. Few of the
extensions listed here such as smstateen,smcsrind
sscsrind are independent ISA extensions which are used for other ISA
extensions as well.

It looks like you are okay with the use case also ?


> That doesn't mean we can't add defaults for rv64, but for this particular
> case I wonder if
> the 'max' CPU wouldn't be better.
>
>
Not sure what you mean here. What does 'max' cpu have to do with pmu
extensions ?


>
> Thanks,
>
>
> Daniel
>
> >
> > The first 2 patches decouple the indirect CSR usage from AIA
> implementation
> > while patch3 adds stateen bits validation for AIA.
> > The PATCH4 implements indirect CSR extensions while remaining patches
> > implement the counter delegation extensions.
> >
> > The Qemu patches can be found here:
> > https://github.com/atishp04/qemu/tree/counter_delegation_rfc
> >
> > The opensbi patch can be found here:
> > https://github.com/atishp04/opensbi/tree/counter_delegation_v1
> >
> > The Linux kernel patches can be found here:
> > https://github.com/atishp04/linux/tree/counter_delegation_rfc
> >
> > [1] https://github.com/riscv/riscv-indirect-csr-access
> > [2] https://github.com/riscv/riscv-smcdeleg-ssccfg
> >
> > Atish Patra (1):
> > target/riscv: Enable S*stateen bits for AIA
> >
> > Kaiwen Xue (7):
> > target/riscv: Add properties for Indirect CSR Access extension
> > target/riscv: Decouple AIA processing from xiselect and xireg
> > target/riscv: Support generic CSR indirect access
> > target/riscv: Add smcdeleg/ssccfg properties
> > target/riscv: Add counter delegation definitions
> > target/riscv: Add select value range check for counter delegation
> > target/riscv: Add counter delegation/configuration support
> >
> > target/riscv/cpu.c      |   8 +
> > target/riscv/cpu.h      |   1 +
> > target/riscv/cpu_bits.h |  34 +-
> > target/riscv/cpu_cfg.h  |   4 +
> > target/riscv/csr.c      | 713 +++++++++++++++++++++++++++++++++++++---
> > target/riscv/machine.c  |   1 +
> > 6 files changed, 722 insertions(+), 39 deletions(-)
> >
> > --
> > 2.34.1
> >
>

--0000000000006f366d0611e7589a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 2024 at 6:58=E2=80=AF=
AM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com"=
 target=3D"_blank">dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Atish,<br>
<br>
This series and its dependency, which I assume it&#39;s<br>
<br>
&quot;[PATCH v4 0/5] Add ISA extension smcntrpmf support&quot;<br>
<br>
Doesn&#39;t apply in neither master nor riscv-to-apply.next because of this=
 patch:=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&quot;target/riscv: Use RISCVException as return type for all csr ops&quot;=
<br>
<br>
That changed some functions from &#39;int&#39; to &quot;RISCVException&quot=
; type. The conflicts<br>
from the v4 series are rather trivial but the conflicts for this RFC are an=
noying<br>
to deal with. It would be better if you could re-send both series rebased w=
ith<br>
the latest changes.<br>
<br></blockquote><div><br></div><div><div>I was waiting for Alistair&#39;s =
ACK on the smcntrpmf series as=C2=A0he had some comments. It looks like he =
is okay<br>with the series now (no further questions).=C2=A0 Let me respin=
=C2=A0both the series.=C2=A0</div><div></div></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
One more thing:<br>
<br>
On 2/16/24 21:01, Atish Patra wrote:<br>
&gt; This series adds the counter delegation extension support. The counter=
<br>
&gt; delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple=
 ISA<br>
&gt; extensions.<br>
&gt; <br>
&gt; 1. S[m|s]csrind : The indirect CSR extension[1] which defines addition=
al<br>
&gt;=C2=A0 =C2=A0 =C2=A05 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address=
 size limitation of<br>
&gt;=C2=A0 =C2=A0 =C2=A0RISC-V CSR address space.<br>
&gt; 2. Smstateen: The stateen bit[60] controls the access to the registers=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0indirectly via the above indirect registers.<br>
&gt; 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]<br>
&gt; <br>
&gt; The counter delegation extension allows Supervisor mode to program the=
<br>
&gt; hpmevent and hpmcounters directly without needing the assistance from =
the<br>
&gt; M-mode via SBI calls. This results in a faster perf profiling and very=
<br>
&gt; few traps. This extension also introduces a scountinhibit CSR which al=
lows<br>
&gt; to stop/start any counter directly from the S-mode. As the counter<br>
&gt; delegation extension potentially can have more than 100 CSRs, the spec=
ificaiton<br>
&gt; leverages the indirect CSR extension to save the precious CSR address =
range.<br>
&gt; <br>
&gt; Due to the dependancy of these extensions, the following extensions mu=
st be<br>
&gt; enabled to use the counter delegation feature in S-mode.<br>
&gt; <br>
&gt; &quot;smstateen=3Dtrue,sscofpmf=3Dtrue,ssccfg=3Dtrue,smcdeleg=3Dtrue,s=
mcsrind=3Dtrue,sscsrind=3Dtrue&quot;<br>
&gt; <br>
&gt; This makes the qemu command line quite tedious. In stead of that, I th=
ink we<br>
&gt; can enable these features by default if there is no objection.<br>
<br>
It wasn&#39;t need so far but, if needed, we can add specialized setters fo=
r extensions<br>
that has multiple dependencies. Instead of the usual setter we would do som=
ething<br>
like:<br>
<br>
cpu_set_ssccfg() {<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (enabled) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smstateen=3Dtrue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sscofpmf=3Dtrue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smcdeleg=3Dtrue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smcsrind=3Dtrue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sscsrind=3Dtrue<br>
=C2=A0 =C2=A0 =C2=A0}<br>
}<br>
<br>
<br>
The advantage is that this setter would also work for CPUs that doesn&#39;t=
 inherit defaults,<br>
like bare-cps and profile CPUs.<br>
<br></blockquote><div><br></div><div>Your suggested approach looks good to =
me. But I was asking about concerns about enabling these extensions <br>by =
default rather than the actual mechanism to implement it. Few of the extens=
ions listed here such as smstateen,smcsrind<br>sscsrind are independent ISA=
 extensions which are used for other ISA extensions as well.<br><br>It look=
s like you are okay with the use case also ?</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
That doesn&#39;t mean we can&#39;t add defaults for rv64, but for this part=
icular case I wonder if<br>
the &#39;max&#39; CPU wouldn&#39;t be better.<br>
<br></blockquote><div><br></div><div>Not sure what you mean here. What does=
 &#39;max&#39; cpu have to do with pmu extensions ?</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
<br>
Daniel<br>
<br>
&gt; <br>
&gt; The first 2 patches decouple the indirect CSR usage from AIA implement=
ation<br>
&gt; while patch3 adds stateen bits validation for AIA.<br>
&gt; The PATCH4 implements indirect CSR extensions while remaining patches<=
br>
&gt; implement the counter delegation extensions.<br>
&gt; <br>
&gt; The Qemu patches can be found here:<br>
&gt; <a href=3D"https://github.com/atishp04/qemu/tree/counter_delegation_rf=
c" rel=3D"noreferrer" target=3D"_blank">https://github.com/atishp04/qemu/tr=
ee/counter_delegation_rfc</a><br>
&gt; <br>
&gt; The opensbi patch can be found here:<br>
&gt; <a href=3D"https://github.com/atishp04/opensbi/tree/counter_delegation=
_v1" rel=3D"noreferrer" target=3D"_blank">https://github.com/atishp04/opens=
bi/tree/counter_delegation_v1</a><br>
&gt; <br>
&gt; The Linux kernel patches can be found here:<br>
&gt; <a href=3D"https://github.com/atishp04/linux/tree/counter_delegation_r=
fc" rel=3D"noreferrer" target=3D"_blank">https://github.com/atishp04/linux/=
tree/counter_delegation_rfc</a><br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/riscv/riscv-indirect-csr-access" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-indirect-c=
sr-access</a><br>
&gt; [2] <a href=3D"https://github.com/riscv/riscv-smcdeleg-ssccfg" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/riscv/riscv-smcdeleg-ssccf=
g</a><br>
&gt; <br>
&gt; Atish Patra (1):<br>
&gt; target/riscv: Enable S*stateen bits for AIA<br>
&gt; <br>
&gt; Kaiwen Xue (7):<br>
&gt; target/riscv: Add properties for Indirect CSR Access extension<br>
&gt; target/riscv: Decouple AIA processing from xiselect and xireg<br>
&gt; target/riscv: Support generic CSR indirect access<br>
&gt; target/riscv: Add smcdeleg/ssccfg properties<br>
&gt; target/riscv: Add counter delegation definitions<br>
&gt; target/riscv: Add select value range check for counter delegation<br>
&gt; target/riscv: Add counter delegation/configuration support<br>
&gt; <br>
&gt; target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<br>
&gt; target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; target/riscv/cpu_bits.h |=C2=A0 34 +-<br>
&gt; target/riscv/cpu_cfg.h=C2=A0 |=C2=A0 =C2=A04 +<br>
&gt; target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 | 713 +++++++++++++++++++++++++=
++++++++++++---<br>
&gt; target/riscv/machine.c=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; 6 files changed, 722 insertions(+), 39 deletions(-)<br>
&gt; <br>
&gt; --<br>
&gt; 2.34.1<br>
&gt; <br>
</blockquote></div></div>

--0000000000006f366d0611e7589a--

