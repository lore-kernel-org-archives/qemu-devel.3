Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33489C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwSWY-00081M-0U; Mon, 15 Apr 2024 16:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jchan@ventanamicro.com>)
 id 1rwRPh-0003Eq-AX
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:50:45 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jchan@ventanamicro.com>)
 id 1rwRPf-0002zz-3X
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:50:44 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so2899535276.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713207041; x=1713811841; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9iIramn82qpvw/U93VcpUFaRI462D3kB0VgwEg02Tkw=;
 b=asnkMMy4W1w2p/tRTV3i+r324wAfDxTx3FrMeWu0p/xksHzCMeF45vSsEVdcerGVYl
 nYzNn19KESray+II92f2C4x2d5kB4PQHAib7x4ATAn2hlzgkoAL+TVmPgMTbGbf+dh+8
 cng2BDHxBWvW8BUj+xuQNwNVoagadd3bJp6SO5sxLoK3md24fe9DQGldDWbF3xFLH1N6
 96xeGLRFKGcxIAPfa9OWBVeRFGXCq5DIk2KtTT0mK77MWkF6wbJhKIU4ZupxQ72E4AZE
 hAyx79QNxuKyPY+2b1q+fzWcHs8oYN2xEwY0ShZeF/xXzbkI0Ww/tpWyjLpjOKoR3gRo
 rsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713207041; x=1713811841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9iIramn82qpvw/U93VcpUFaRI462D3kB0VgwEg02Tkw=;
 b=WzKsqkBYNnt5x/VA615kzaK3DVsekrrSVzC3xMms3d2+MreMc/q+vPpM6DCw79jKbh
 2Gs3YexgMpUvJ1X8DnJTMuyk5TqmMy+Nk6oajzqWurfa5Ac8RR/S2iCJ2zFBYPdCs8j0
 6j+3IvBBicpAQJOIzUG1l0heTBioQjscza5BLr7sEsle7t4/Mc2CPYnZOmQFM/BobfJB
 moSfZORUep6pYyvlu1BJQ0q2UiS7T+bvVTGwRQ9odAH5R0f1+hb79ha8X0yrDx/2423h
 FAon9aR6MLymL0d2AxrE5hvasG0zcKfQ+/JPe8NSQLWnW2yWY2GjIGUp0wKw24SX8ZEl
 Mj+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqP+xDTV+JDhdySJ5pWAsBc7OK5fjihoICi1xsoz8zRq61JYsfS+H3Vr9dUFQLy4+gwd52OxC4v+w9Qtv4aLXozZTSyGM=
X-Gm-Message-State: AOJu0YzMlW21LKQHwgO+MVlxKk8ETcPT7ttIk1NOgW2afbLARlcFAZ2v
 l67NHtansMKnlr5WdJEMjIqTUu3onqTB0avpD1q6dm24MWFKiYh5qWKo4MMNaHlJBeLk7HIHhmi
 Hakyb+VkYkQy2T8cXdNQCwD9UT+VmhcFFW6hpiw==
X-Google-Smtp-Source: AGHT+IEGCQlqQkt04tPtWjzsnrdEsmAL4ntmd6WOUdd4+vjC12yv82cBqJZ4cz15B8C4HHQL611tTxfl1bhBXI0IBQs=
X-Received: by 2002:a25:3d05:0:b0:dc6:d093:8622 with SMTP id
 k5-20020a253d05000000b00dc6d0938622mr10155604yba.15.1713207040906; Mon, 15
 Apr 2024 11:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240413105929.7030-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240413105929.7030-1-alexei.filippov@syntacore.com>
From: Joseph Chan <jchan@ventanamicro.com>
Date: Mon, 15 Apr 2024 11:50:04 -0700
Message-ID: <CA+OBw2tScc2Gt+eHy3onTnK8m7XDfjbMVZ7dBoFowq1kL8c7EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000019b27506162719d8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=jchan@ventanamicro.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Apr 2024 16:01:53 -0400
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

--00000000000019b27506162719d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI

Priv-v1.12/riscv-privileged-20211203.pdf
<https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/ris=
cv-privileged-20211203.pdf>
defines exception priorities on
Page 40, Table 3.7
Page 130, Table 8.7

There is a sentence under Table 3.7:
"When a virtual address is translated into a physical address, the address
translation algorithm
determines what specific exception may be raised."


The spec does not insist any implementation to report Exception Code 12
over 1; 13,15 over 5, 7. On the other hand, the phrases "During instruction
address translation:" and "With physical address for instruction:" gives me
the impression that when the implementation can distinguish between these
situations, then reporting 12 , 13, 15 instead of 1, 5, 7 will provide a
fine-grained reason for why things were broken.

Regards,
Joseph Chan


On Sat, Apr 13, 2024 at 3:59=E2=80=AFAM Alexei Filippov <
alexei.filippov@syntacore.com> wrote:

> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> raise_mmu_exception(), as is today, is prioritizing guest page faults by
> checking first if virt_enabled && !first_stage, and then considering the
> regular inst/load/store faults.
>
> There's no mention in the spec about guest page fault being a higher
> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
>
> "Attempting to fetch an instruction from a PMP region that does not have
> execute permissions raises an instruction access-fault exception.
> Attempting to execute a load or load-reserved instruction which accesses
> a physical address within a PMP region without read permissions raises a
> load access-fault exception. Attempting to execute a store,
> store-conditional, or AMO instruction which accesses a physical address
> within a PMP region without write permissions raises a store
> access-fault exception."
>
> So, in fact, we're doing it wrong - PMP faults should always be thrown,
> regardless of also being a first or second stage fault.
>
> The way riscv_cpu_tlb_fill() and get_physical_address() work is
> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
> reflected in the 'pmp_violation' flag. What we need is to change
> raise_mmu_exception() to prioritize it.
>
> Reported-by: Joseph Chan <jchan@ventanamicro.com>
> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU
> translation stage")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu_helper.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bc70ab5abc..196166f8dd 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState
> *env, target_ulong address,
>
>      switch (access_type) {
>      case MMU_INST_FETCH:
> -        if (env->virt_enabled && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_INST_ACCESS_FAULT;
> +        } else if (env->virt_enabled && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAUL=
T;
> +            cs->exception_index =3D RISCV_EXCP_INST_PAGE_FAULT;
>          }
>          break;
>      case MMU_DATA_LOAD:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAUL=
T;
> +            cs->exception_index =3D RISCV_EXCP_LOAD_PAGE_FAULT;
>          }
>          break;
>      case MMU_DATA_STORE:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index =3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>              cs->exception_index =3D RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FA=
ULT;
>          } else {
> -            cs->exception_index =3D pmp_violation ?
> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
> -                RISCV_EXCP_STORE_PAGE_FAULT;
> +            cs->exception_index =3D RISCV_EXCP_STORE_PAGE_FAULT;
>          }
>          break;
>      default:
> --
> 2.34.1
>
>

--00000000000019b27506162719d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FYI<div><br><a href=3D"https://github.com/riscv/riscv-isa-=
manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf">Priv-v1.=
12/riscv-privileged-20211203.pdf</a>=C2=A0 defines exception priorities on<=
br>Page 40, Table 3.7<br>Page 130, Table 8.7<br><br>There is a sentence und=
er Table 3.7:</div><div>&quot;When a virtual address is translated into a p=
hysical address, the address translation algorithm<br>determines what speci=
fic exception may be raised.&quot;</div><div><br><br>The spec does not insi=
st any<b> </b>implementation to report Exception Code 12 over 1; 13,15 over=
 5, 7. On the other hand, the phrases &quot;During instruction address tran=
slation:&quot; and &quot;With physical address for instruction:&quot; gives=
 me the impression that when the implementation can distinguish between the=
se situations, then reporting 12 , 13, 15 instead of 1, 5, 7 will provide a=
 fine-grained reason for why things were broken.</div><div><br></div><div>R=
egards,</div><div>Joseph Chan<br><br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Apr 13, 2024 at 3:59=E2=
=80=AFAM Alexei Filippov &lt;<a href=3D"mailto:alexei.filippov@syntacore.co=
m">alexei.filippov@syntacore.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">From: Daniel Henrique Barboza &lt;<a href=
=3D"mailto:dbarboza@ventanamicro.com" target=3D"_blank">dbarboza@ventanamic=
ro.com</a>&gt;<br>
<br>
raise_mmu_exception(), as is today, is prioritizing guest page faults by<br=
>
checking first if virt_enabled &amp;&amp; !first_stage, and then considerin=
g the<br>
regular inst/load/store faults.<br>
<br>
There&#39;s no mention in the spec about guest page fault being a higher<br=
>
priority that PMP faults. In fact, privileged spec section 3.7.1 says:<br>
<br>
&quot;Attempting to fetch an instruction from a PMP region that does not ha=
ve<br>
execute permissions raises an instruction access-fault exception.<br>
Attempting to execute a load or load-reserved instruction which accesses<br=
>
a physical address within a PMP region without read permissions raises a<br=
>
load access-fault exception. Attempting to execute a store,<br>
store-conditional, or AMO instruction which accesses a physical address<br>
within a PMP region without write permissions raises a store<br>
access-fault exception.&quot;<br>
<br>
So, in fact, we&#39;re doing it wrong - PMP faults should always be thrown,=
<br>
regardless of also being a first or second stage fault.<br>
<br>
The way riscv_cpu_tlb_fill() and get_physical_address() work is<br>
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and<br>
reflected in the &#39;pmp_violation&#39; flag. What we need is to change<br=
>
raise_mmu_exception() to prioritize it.<br>
<br>
Reported-by: Joseph Chan &lt;<a href=3D"mailto:jchan@ventanamicro.com" targ=
et=3D"_blank">jchan@ventanamicro.com</a>&gt;<br>
Fixes: 82d53adfbb (&quot;target/riscv/cpu_helper.c: Invalid exception on MM=
U translation stage&quot;)<br>
Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@venta=
namicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_helper.c | 22 ++++++++++++----------<br>
=C2=A01 file changed, 12 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index bc70ab5abc..196166f8dd 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState *env,=
 target_ulong address,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (access_type) {<br>
=C2=A0 =C2=A0 =C2=A0case MMU_INST_FETCH:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;virt_enabled &amp;&amp; !first_sta=
ge) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_INST_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (env-&gt;virt_enabled &amp;&amp; !fi=
rst_stage) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_INST_GUEST_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_INST_AC=
CESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_INST_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MMU_DATA_LOAD:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (two_stage &amp;&amp; !first_stage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_LOAD_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (two_stage &amp;&amp; !first_stage) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_LOAD_AC=
CESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_LOAD_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MMU_DATA_STORE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (two_stage &amp;&amp; !first_stage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_STORE_AMO_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (two_stage &amp;&amp; !first_stage) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_STORE_A=
MO_ACCESS_FAULT :<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_STORE_P=
AGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_STORE_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000019b27506162719d8--

