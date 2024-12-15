Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A1DE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqJs-0000We-A1; Sun, 15 Dec 2024 10:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqJp-0000WE-Lx
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqJn-0004Wu-G5
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734275639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brEHXMtcyd9n/W0DfHtSwPfsmjnvyAHB44rPWxZDxas=;
 b=Y9KQHVWUD52XsfSQFNqlbDUsoyiXhexKFCYIR0YHheeHpdfPwexWq2sxwlOdIZD/zq8is6
 oskrN33dy17b29I91UScVlrLQLs1RN4Nl3Xw2CYQozlfM/Rmf2ief7g5u3Tbm+YBVDKaef
 RwojIOevZjZLB0/5L+wLBs4BgoG6NUU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-aI1HTTdDOAerWfIcHknIYw-1; Sun, 15 Dec 2024 10:13:57 -0500
X-MC-Unique: aI1HTTdDOAerWfIcHknIYw-1
X-Mimecast-MFC-AGG-ID: aI1HTTdDOAerWfIcHknIYw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so1177845e9.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734275636; x=1734880436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=brEHXMtcyd9n/W0DfHtSwPfsmjnvyAHB44rPWxZDxas=;
 b=lbuJ8m5W1QuHUKrYWH6tqUxwEMytU2S26MhQ6vIZNQ0nzLSH0vObQCiOzWjI/7H74Q
 sjRrk9dnuPJo1YlZo4o701Ss8wrbLUY89DsV/LU6PD9CgF//KiSr/cSynD+O7QmNxyF7
 PkiZGhf1XpoAJ8a+LCZ3rjYesGY3AhBbuCU1tAdE5AHEoCDAZjlkh3F5X0arQ/jMOGz3
 fvu3XOiD+MwxZZA+2jOKBJYW51IwaybsE4ZUwt1+nHef3Ogt2nKCe3V8SW2TMhTs9r+L
 IYd9Ut8dKTrmAUx2miOUt2oMMw70sRtBbc4qmZPkdNtt/JLh/hj28LsGmUJXD8lUnnq/
 uw8g==
X-Gm-Message-State: AOJu0YyrLQlKL7TLmmNgxg7Ly9URvbiA6qC1J/CZEmcZLLVMd8MoHSxA
 FR4/5vm98Dz4b7rOLXZ3e+cO6WrdxNovEwBhLJMM5TyYhCjxapQyja7wc4kG65CtVipBoUCLXuH
 A0Znr/i3+/zjPcmTnlmWdvmnoCXDZZwRTLGeWZOppVPhaVdx1kjc6I4siwLxjtShwr94gmneNwE
 hkBjE+frL0fDcbz2fh+xknvq7LD88=
X-Gm-Gg: ASbGncvlX8FiN0B5/A8DtJ9GNdBZKC0acYL1mz9xA3OxSrtrPfnqGRVxIxGLUkYnWfX
 0efuVOAHmbHaMLk+jmt9120ZUimo3nS2jFOMp
X-Received: by 2002:a05:600c:3ace:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4362aa9d48bmr66589805e9.26.1734275636593; 
 Sun, 15 Dec 2024 07:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtUjowsgo90uDLUqM9wtYT3R1f/ywjxu/xNmjBlowVyIZ6yQtn2sAHOj0vesfzoXr3nRZsjtwTkOebE/256/w=
X-Received: by 2002:a05:600c:3ace:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4362aa9d48bmr66589735e9.26.1734275636214; Sun, 15 Dec 2024
 07:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-9-pbonzini@redhat.com>
 <98175648-fd1e-470d-a8e4-a6053cc3c35f@linaro.org>
In-Reply-To: <98175648-fd1e-470d-a8e4-a6053cc3c35f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Dec 2024 16:13:44 +0100
Message-ID: <CABgObfbV4A71dRi+hrjkTUKoq_=g2TLWBs5f0JwT=2pd0+dOWA@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/i386: make cc_op handling more explicit for
 repeated string instructions.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003d4f6b0629508392"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000003d4f6b0629508392
Content-Type: text/plain; charset="UTF-8"

Il dom 15 dic 2024, 15:45 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 12/15/24 03:06, Paolo Bonzini wrote:
> >       fn(s, ot);
> >       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
> > +    gen_update_cc_op(s);
> > +
> > +    /* Leave if REP condition fails.  */
> >       if (is_repz_nz) {
> >           int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
> > -        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
> > +        gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
>
> The comment in gen_jcc would still seem to apply:
>
>      CCPrepare cc = gen_prepare_cc(s, b, NULL);
>
>      /*
>       * Note that this must be _after_ gen_prepare_cc, because it
>       * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
>       */
>      gen_update_cc_op(s);
>
> via any path through gen_prepare_cc that reaches gen_compute_eflags.
>
> However!  Because this is JCC_Z, we will never call gen_compute_eflags, we
> will always go
> through the gen_prepare_eflags_z, which doesn't have the same problem.
>

Or more simply, fn(s, ot) must have left CC_OP_SUBx in cc_op.

This subtlety deserves a comment and maybe an assert.  Perhaps
>
>      gen_jcc_noeob(...);
>      assert(!s->cc_op_dirty);
>

Either that or an assert(s->cc_op != CC_OP_DYNAMIC) before the call to
gen_jcc_noeob().

Paolo


>
> r~
>
>

--0000000000003d4f6b0629508392
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 15 dic 2024, 15:45 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 12/15/24 03:06, Paolo Bonzini wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fn(s, ot);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gen_op_add_reg_im(s, s-&gt;aflag, R_ECX, -1)=
;<br>
&gt; +=C2=A0 =C2=A0 gen_update_cc_op(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Leave if REP condition fails.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_repz_nz) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nz =3D (s-&gt;prefix &amp;=
 PREFIX_REPNZ) ? 1 : 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_jcc(s, (JCC_Z &lt;&lt; 1) | (nz ^ 1),=
 done);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_jcc_noeob(s, (JCC_Z &lt;&lt; 1) | (nz=
 ^ 1), done);<br>
<br>
The comment in gen_jcc would still seem to apply:<br>
<br>
=C2=A0 =C2=A0 =C2=A0CCPrepare cc =3D gen_prepare_cc(s, b, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Note that this must be _after_ gen_prepare_cc, becau=
se it<br>
=C2=A0 =C2=A0 =C2=A0 * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFL=
AGS!<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0gen_update_cc_op(s);<br>
<br>
via any path through gen_prepare_cc that reaches gen_compute_eflags.<br>
<br>
However!=C2=A0 Because this is JCC_Z, we will never call gen_compute_eflags=
, we will always go <br>
through the gen_prepare_eflags_z, which doesn&#39;t have the same problem.<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">O=
r more simply, fn(s, ot) must have left CC_OP_SUBx in cc_op.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"></blockquote>=
</div></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
This subtlety deserves a comment and maybe an assert.=C2=A0 Perhaps<br>
<br>
=C2=A0 =C2=A0 =C2=A0gen_jcc_noeob(...);<br>
=C2=A0 =C2=A0 =C2=A0assert(!s-&gt;cc_op_dirty);<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Either that or an assert(s-&=
gt;cc_op !=3D CC_OP_DYNAMIC) before the call to gen_jcc_noeob().</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000003d4f6b0629508392--


