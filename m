Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E1BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 18:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRcFl-0000k2-VG; Wed, 10 Jul 2024 14:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRcFf-0000iO-0f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRcFb-00025I-9C
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720636868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Cm17neb7DC7qeV0PCLyxx1rFLLt9tjKAez6sPcbOBE=;
 b=Z7Zthqr1wPDhtemBbQwPAKNBlSqr2/WCeL0+2QmljmBBO1/QYyJOB2s7Gudr2VJtxV7LMI
 PPBLd3cFjd25XteZVfjbQhC7X/wwwPrfgxLg7v0SEwnwA6Vx/juoXnyDJSBpkQ4ZFbqFY2
 idLK54p0y2BUc4GfU/IVr09NfJi/JCw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-JbQZSotwMBu0qCpaVRGliQ-1; Wed, 10 Jul 2024 14:41:06 -0400
X-MC-Unique: JbQZSotwMBu0qCpaVRGliQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee8e904f01so576171fa.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 11:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720636864; x=1721241664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Cm17neb7DC7qeV0PCLyxx1rFLLt9tjKAez6sPcbOBE=;
 b=QEYTmBG77XiEiI5kIHwO/UeaY5MUxtU0KWkckrc5GtrxyNfMyMWc+CKPamCr0icONc
 bujoW9UZYx+vrZbUj2psMcHvmD9c9FeN/xzZLszlrioia/N3NXjJztdSTa47pUlyx+w5
 w4rsdngWnwaxghybC8nU7qsSIac3AgtpK3CnBN9Bs2agmezo8qmkMigK3jJmvcaK3Alw
 Ha4npzVjhxfxSdOFtFiGgdURcmwmYm39rewZ3Lx9D7/N0P5JzD3gxVm7JoX0qJH3NJTJ
 oO+42Hwkr7CCpWRkur5zkBxpaT1zpdhO0acM4wUSAB7RtpDDfeQK6oQ0XfGcX7Ym+emb
 q+5g==
X-Gm-Message-State: AOJu0YwXGlyMChYh4mQ+hdETngA2GfC8awhnCgkC2+JhAlzmIHUajW2Y
 b1D/7vbXiXZjfgWEOAoCaGKLMsx/XLNLYtKYo6uu+fXdMcRa3a94oblBbIL7LpN+p2tbt11oCSl
 mMNh7JE3iyVeKNisTI8d0DDdIfsb7a2S+7+2ajc/pnY2y4JMaoQpR2V+/sZWW+SIHX9pmi8tMIM
 uGjGtLh+da5AdcErqZsXkSdUwqzyU=
X-Received: by 2002:a2e:7216:0:b0:2ee:8815:8b28 with SMTP id
 38308e7fff4ca-2eeb3189e12mr39166561fa.33.1720636864522; 
 Wed, 10 Jul 2024 11:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCZ4yKNmCMcKNJLr4FUdlurkxsLYYsfEkMQnxPmuHu0Ewtd3HBnej6hIQgfgLGaxgaATA13+m/hzuCaBflmQ=
X-Received: by 2002:a2e:7216:0:b0:2ee:8815:8b28 with SMTP id
 38308e7fff4ca-2eeb3189e12mr39166451fa.33.1720636864113; Wed, 10 Jul 2024
 11:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-10-pbonzini@redhat.com>
 <293864db-8a3e-4585-abf1-da2b11990b43@linaro.org>
In-Reply-To: <293864db-8a3e-4585-abf1-da2b11990b43@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jul 2024 20:40:51 +0200
Message-ID: <CABgObfbBz9Oq=L1XCUaXGwp-7Q5FWQFp4Ld=b8Twyi0ymSrYpQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/i386/tcg: use X86Access for TSS access
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Robert Henry <rrh.henry@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000012c4b7061ce8fd12"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000012c4b7061ce8fd12
Content-Type: text/plain; charset="UTF-8"

Il mer 10 lug 2024, 18:47 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 7/9/24 23:29, Paolo Bonzini wrote:
> > This takes care of probing the vaddr range in advance, and is also faster
> > because it avoids repeated TLB lookups.  It also matches the Intel manual
> > better, as it says "Checks that the current (old) TSS, new TSS, and all
> > segment descriptors used in the task switch are paged into system
> memory";
> > note however that it's not clear how the processor checks for segment
> > descriptors, and this check is not included in the AMD manual.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/seg_helper.c | 101 ++++++++++++++++++-----------------
> >   1 file changed, 51 insertions(+), 50 deletions(-)
> >
> > diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> > index 25af9d4a4ec..77f2c65c3cf 100644
> > --- a/target/i386/tcg/seg_helper.c
> > +++ b/target/i386/tcg/seg_helper.c
> > @@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env, int
> tss_selector,
> >           raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc,
> retaddr);
> >       }
> >
> > +    /* X86Access avoids memory exceptions during the task switch */
> > +    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
> > +                    MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);
> > +
> > +    if (source == SWITCH_TSS_CALL) {
> > +        /* Probe for future write of parent task */
> > +        probe_access(env, tss_base, 2, MMU_DATA_STORE,
> > +                  cpu_mmu_index_kernel(env), retaddr);
> > +    }
> > +    access_prepare_mmu(&new, env, tss_base, tss_limit,
> > +                    MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);
>
> You're computing cpu_mmu_index_kernel 3 times.
>

Oh, indeed. Better than 30. :)

This appears to be conservative in that you're requiring only 2 bytes (a
> minimum) of 0x68
> to be writable.  Is it legal to place the TSS at offset 0xffe of page 0,
> with the balance
> on page 1, with page 0 writable and page 1 read-only?


Yes, paging is totally optional here. The only field that is written is the
link.

Otherwise I would think you could
> just check the entire TSS for writability.
>
> Anyway, after the MMU_DATA_STORE probe, you have proved that 'X86Access
> new' contains an
> address range that may be stored.  So you can change the SWITCH_TSS_CALL
> store below to
> access_stw() too.
>

Nice.

> -    /* NOTE: we must avoid memory exceptions during the task switch,
> > -       so we make dummy accesses before */
> > -    /* XXX: it can still fail in some cases, so a bigger hack is
> > -       necessary to valid the TLB after having done the accesses */
> > -
> > -    v1 = cpu_ldub_kernel_ra(env, env->tr.base, retaddr);
> > -    v2 = cpu_ldub_kernel_ra(env, env->tr.base + old_tss_limit_max,
> retaddr);
> > -    cpu_stb_kernel_ra(env, env->tr.base, v1, retaddr);
> > -    cpu_stb_kernel_ra(env, env->tr.base + old_tss_limit_max, v2,
> retaddr);
>
> OMG.
>

Haha, yeah X86Access is perfect here.

Paolo

Looks like a fantastic cleanup overall.
>
>
> r~
>
>

--00000000000012c4b7061ce8fd12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 10 lug 2024, 18:47 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On 7/9/24 23:29, Paolo Bonzini wrote:<br>
&gt; This takes care of probing the vaddr range in advance, and is also fas=
ter<br>
&gt; because it avoids repeated TLB lookups.=C2=A0 It also matches the Inte=
l manual<br>
&gt; better, as it says &quot;Checks that the current (old) TSS, new TSS, a=
nd all<br>
&gt; segment descriptors used in the task switch are paged into system memo=
ry&quot;;<br>
&gt; note however that it&#39;s not clear how the processor checks for segm=
ent<br>
&gt; descriptors, and this check is not included in the AMD manual.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/seg_helper.c | 101 ++++++++++++++++++-----=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 51 insertions(+), 50 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper=
.c<br>
&gt; index 25af9d4a4ec..77f2c65c3cf 100644<br>
&gt; --- a/target/i386/tcg/seg_helper.c<br>
&gt; +++ b/target/i386/tcg/seg_helper.c<br>
&gt; @@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env, int t=
ss_selector,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise_exception_err_ra(env, EX=
CP0A_TSS, tss_selector &amp; 0xfffc, retaddr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* X86Access avoids memory exceptions during the task s=
witch */<br>
&gt; +=C2=A0 =C2=A0 access_prepare_mmu(&amp;old, env, env-&gt;tr.base, old_=
tss_limit_max,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (source =3D=3D SWITCH_TSS_CALL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Probe for future write of parent task =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_access(env, tss_base, 2, MMU_DATA_S=
TORE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mm=
u_index_kernel(env), retaddr);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 access_prepare_mmu(&amp;new, env, tss_base, tss_limit,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);<br>
<br>
You&#39;re computing cpu_mmu_index_kernel 3 times.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Oh, indeed. Better than 3=
0. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This appears to be conservative in that you&#39;re requiring only 2 bytes (=
a minimum) of 0x68 <br>
to be writable.=C2=A0 Is it legal to place the TSS at offset 0xffe of page =
0, with the balance <br>
on page 1, with page 0 writable and page 1 read-only?</blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, paging is totally opt=
ional here. The only field that is written is the link.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Otherwise I would think you could <br>
just check the entire TSS for writability.<br>
<br>
Anyway, after the MMU_DATA_STORE probe, you have proved that &#39;X86Access=
 new&#39; contains an <br>
address range that may be stored.=C2=A0 So you can change the SWITCH_TSS_CA=
LL store below to <br>
access_stw() too.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Nice.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>&gt; -=C2=A0 =C2=A0 /* NOTE: we must avoid memory exceptions during the ta=
sk switch,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0so we make dummy accesses before */<br>
&gt; -=C2=A0 =C2=A0 /* XXX: it can still fail in some cases, so a bigger ha=
ck is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0necessary to valid the TLB after having do=
ne the accesses */<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 v1 =3D cpu_ldub_kernel_ra(env, env-&gt;tr.base, retaddr=
);<br>
&gt; -=C2=A0 =C2=A0 v2 =3D cpu_ldub_kernel_ra(env, env-&gt;tr.base + old_ts=
s_limit_max, retaddr);<br>
&gt; -=C2=A0 =C2=A0 cpu_stb_kernel_ra(env, env-&gt;tr.base, v1, retaddr);<b=
r>
&gt; -=C2=A0 =C2=A0 cpu_stb_kernel_ra(env, env-&gt;tr.base + old_tss_limit_=
max, v2, retaddr);<br>
<br>
OMG.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Haha, yeah X86Access is perfect here.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
Looks like a fantastic cleanup overall.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000012c4b7061ce8fd12--


