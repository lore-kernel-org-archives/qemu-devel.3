Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928BDD29DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 03:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfVB8-0000Se-79; Mon, 12 Jan 2026 22:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vfVB5-0000Rr-Eu
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:34:44 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vfVB3-0001g2-SG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:34:43 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-93f5b804d4aso2930318241.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768275280; x=1768880080; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCT28Ad8KpwYd/ciU3Izfab19h6Y/2SsWQpZH+J9T7U=;
 b=Ie8hd+U9xzLZCa/v3e8S/gspf383rosXzPsWa2BfSqIHBt+edAXbnzfpP7t94Wa/Bo
 wjY/8qWGNeYk9NCIEivpfQ0Lncd/OauBFsP0a5B3oTekrzhuLXTMhBi35qHz3ex7xRBp
 pJUNvk2LOwnpZFG9YOEbOKfPHZWXf706KNrRm3ipQs7kos32qmxlHXcXHJTZPiWh5knm
 rAtWaRZBgoeX3eR+Ag8HGYObpOaApLX42/0kbKZh0FjHH/8DsXDT498hzIkUlBYDoquc
 n4vdyx4a/UZxk7PZWBt3Knr7wXCy4FB8xUSt1wdeNYMdnEvOi+wawgaZ+amRkRvGfLq8
 PcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768275280; x=1768880080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCT28Ad8KpwYd/ciU3Izfab19h6Y/2SsWQpZH+J9T7U=;
 b=PejS5WjGpf32OSI2tg+PKAPqc6qQA5DTUC7KO8coszurnIYpLQgvx772h0u578NDHn
 mhdoLkH1Icw89B831B0jIE5QXwuEbarbwsBlSY6XyXopNxhrGLgKBnTVTKjIP09qpwH6
 Xkzoa1nosiQ5mKaV/zGxeafs38hmwzFvfN7PgYBkXhkGw7q1WlXJSQ/qZQ0Me/K3Th9q
 g5T0Oa0fUElI0niPBWRSXtccwEBoUlBiyhgAw+FzKy3kyOGatUDWSAY4gRVIbjZIfRAt
 xUKKMbLTafGENzevce5SlmEI34TKSIH8lEvpMZ/IwKgC4h6sUjZ2v9hXrKvq1rciH26T
 PJzA==
X-Gm-Message-State: AOJu0YxXz9RZmOSppDpXhGaYnntTESe/CH+u8u+kzG3nr/kF2PpXDiT6
 8L5YbFXFn7o7MFiwN3hzpaYllmnYZBQHe1agMu8xXwbr7lKmV1QkfY6woJw2AK0L2leXO1VGpri
 q7mzDAqdj0QH7ygid835Y6XFoL+t+XDLpGA==
X-Gm-Gg: AY/fxX4zOVSEbHGgTqFkUbYuXuW6E3T68Oo/Qw75fD0kyPhnmpdrn76EbyOy/uS+yO7
 rOmnqz9hqVN5R36cStWpW8iMSCpDQSEgAWf/A3poxOxevE8X40aQAab1NWAgplBSLofbBPycLVm
 vbeqBgrJa6j4m4biOwCgwNtscMdtE0bmZPUvtsKfrTpotg+cySsliWoz8dtXBpAepicKDcCw0Gj
 HYztAI82TRtaJKdI0iaNSkb3XJS0a7lFTKlMdQY0aOogjGZdbMYFr6wtFkruMQPe+JGgtIQ
X-Google-Smtp-Source: AGHT+IGF6lujn3MXlocJIcYnWNuTut6rrKf+2Kq/Wz3a2foGaigMpuF11LeUYETmQ0AlOiwLe1yExmuYXMoPIOdCamE=
X-Received: by 2002:a05:6102:3908:b0:5ee:a6f8:f925 with SMTP id
 ada2fe7eead31-5eea6f90e16mr5501043137.8.1768275280282; Mon, 12 Jan 2026
 19:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
 <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
 <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
 <CAFEAcA-NSqMH_+L+jOCD-QsafFq78L5ogRmGRqVZnXdXja2WTA@mail.gmail.com>
In-Reply-To: <CAFEAcA-NSqMH_+L+jOCD-QsafFq78L5ogRmGRqVZnXdXja2WTA@mail.gmail.com>
From: Lin Li-Hang <lihang.lin@gmail.com>
Date: Tue, 13 Jan 2026 11:34:29 +0800
X-Gm-Features: AZwV_QjXNMh_XU6-5_JjSdwxIyJ3vEMbAuRkmIveodlcOzvD5ef46PvA3moDSBE
Message-ID: <CAPR+-WF2SRjfOT_enPwXHOKQa=D_qWLCkB5-7uO1mp8verv7CA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f2488206483cabbc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=lihang.lin@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f2488206483cabbc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for your explanation.
Your statement and suggestion is better.

Cheers


On Mon, Jan 12, 2026 at 10:36=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Mon, 29 Dec 2025 at 04:19, Lin Li-Hang <lihang.lin@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > Thank you for your reply.
> >
> > I initially identified this error while reviewing the code and was
> curious why it hadn't caused any bugs.
> > After further testing, it appears the original code behaved correctly b=
y
> coincidence.
> >
> > The ASL code in the ARM ARM for FRSQRTE states:
> >
> > ```
> > elsif sign =3D=3D '1' then
> >          result =3D FPDefaultNaN(fpcr, N);
> >          if fpexc then FPProcessException(FPExc_InvalidOp, fpcr);
> > ```
> >
> > As it turns out, the sign bit must be zero by the time it reaches the
> final deposition code, which explains why the incorrect bit placement did
> not surface as a functional bug.
>
> Thanks for looking that up. I think that although this isn't a bug it's
> definitely confusing code, so the best approach will be to make our
> code match how the current Arm ARM FPRSqrtEstimate() treats the output
> sign bit, which is to say we know it's 0. In the pseudocode that
> looks like:
>   result =3D '0' : result_exp<N-54:0> : estimate<7:0>:Zeros(44)=CD=BE
> and for QEMU it should look like updating the comment so that
> instead of
> /* result =3D sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
>
> it says
> /* result =3D 0 : result_exp<4:0> : estimate<7:0> : Zeros(44) */
> and removing the unnecessary deposit64() call of f64_sign entirely.
>
> We should do this for all of rsqrte_f64, do_rsqrte_f32 and rsqrte_f16.
>
> thanks
> -- PMM
>

--000000000000f2488206483cabbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>Thanks for your ex=
planation.=C2=A0</div><div>Your statement and suggestion is better.</div><d=
iv><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr">Cheers<br></div></div></div><br></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Mon, Jan 12, 2026 at 10:36=E2=80=AFPM Peter Maydell &lt=
;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon=
, 29 Dec 2025 at 04:19, Lin Li-Hang &lt;<a href=3D"mailto:lihang.lin@gmail.=
com" target=3D"_blank">lihang.lin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Peter,<br>
&gt;<br>
&gt; Thank you for your reply.<br>
&gt;<br>
&gt; I initially identified this error while reviewing the code and was cur=
ious why it hadn&#39;t caused any bugs.<br>
&gt; After further testing, it appears the original code behaved correctly =
by coincidence.<br>
&gt;<br>
&gt; The ASL code in the ARM ARM for FRSQRTE states:<br>
&gt;<br>
&gt; ```<br>
&gt; elsif sign =3D=3D &#39;1&#39; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D FPDefaultNaN(fpcr, N);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if fpexc then FPProcessException(FPE=
xc_InvalidOp, fpcr);<br>
&gt; ```<br>
&gt;<br>
&gt; As it turns out, the sign bit must be zero by the time it reaches the =
final deposition code, which explains why the incorrect bit placement did n=
ot surface as a functional bug.<br>
<br>
Thanks for looking that up. I think that although this isn&#39;t a bug it&#=
39;s<br>
definitely confusing code, so the best approach will be to make our<br>
code match how the current Arm ARM FPRSqrtEstimate() treats the output<br>
sign bit, which is to say we know it&#39;s 0. In the pseudocode that<br>
looks like:<br>
=C2=A0 result =3D &#39;0&#39; : result_exp&lt;N-54:0&gt; : estimate&lt;7:0&=
gt;:Zeros(44)=CD=BE<br>
and for QEMU it should look like updating the comment so that<br>
instead of<br>
/* result =3D sign : result_exp&lt;4:0&gt; : estimate&lt;7:0&gt; : Zeros(44=
) */<br>
<br>
it says<br>
/* result =3D 0 : result_exp&lt;4:0&gt; : estimate&lt;7:0&gt; : Zeros(44) *=
/<br>
and removing the unnecessary deposit64() call of f64_sign entirely.<br>
<br>
We should do this for all of rsqrte_f64, do_rsqrte_f32 and rsqrte_f16.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000f2488206483cabbc--

