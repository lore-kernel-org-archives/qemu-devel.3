Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2244EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh44-0001gs-Dp; Fri, 21 Jun 2024 12:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sKh42-0001gh-Oq
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:24:39 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sKh40-0004C7-KN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:24:38 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c9b94951cfso1243048b6e.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718987075; x=1719591875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NSy+08/gALM49TOq1UTnG9oH3He4drmuunPNbyREVvg=;
 b=b2SE3skwDdQWC11CwVRNN7PoK3bujiSBo3b6Qe7s+/9n8ruemJSAagEyDj05+jGRKc
 dLtdbZMz//dP9eVec9jpmonMnAIk7ZP2HpDQA958JxsmS7K8r1S5trCGRf4cEN5qBdio
 3PMS/4JvqD8ik6r3ka1yiiaiaZtlWbsBor/n8/JZILfF7umwyW+T05zFuWmGyz2+AKpQ
 JCNbwIwO9WbGcwe9pA7EPFSnQnIUnvn0FWBIEYNKkP/UjQbl259NdN5saRna8wkeaEF5
 2fl9Wq29dydOm2UWtTrJc9AC8HtudKDDHYiC48Zf3tcBT78BPBSUOgmOR0D6PKSIw3ai
 ZcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718987075; x=1719591875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NSy+08/gALM49TOq1UTnG9oH3He4drmuunPNbyREVvg=;
 b=OevPqtWV6BDkgeIz30k2bcCL1gGNPWRlIlJElk3u2oCW9m3lnLxwqwgCpVv8MPxaig
 C3d+CU4cGy1CbIGz9mxeLjZ7kZriALDs2brPyPTOK3F7lpAasDxflzeSmyj0pI9mkqIR
 1VRm7N3/WDl1Psz4AKfdBGjNw98Yq1f4VnwhtcNWE64KfiLMkq0Khh3aQjmkJTSTmBAd
 c33A6OwSDATcwqr3JBBHqzOxPEX6uKnycTD3G57Fq7g2QOOY/ZP6yu7y0jqT86hKi80Q
 ocUESj4xchw/+JZFennrYqr7n1g2iSqgyvONwGKLIIT+esRB8rx8/+8jw8IFMZapVt1M
 8Xvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgAiNmSs0AZ51X1MYv6KiANXW52pWlN/ZCvATS6rSRXgQZ94sU7UGr2ebT7hfIPBdydns2dvKFWgBkyubSv2UEOT3TEes=
X-Gm-Message-State: AOJu0Yyng8WHIWr2Av6o5LHvFu9l83emT7XWuEtXHClH5rXRGo+VHXiN
 1xiUNPSslTSrs8cy2mKzqW4LmMgd+XWrC9U34Qw6ASq2REMWzfyPyDAPYvo8U5n7pauuKD1H8Td
 T5buRPZoSfj9QnScIEhODwVdRo+Q=
X-Google-Smtp-Source: AGHT+IFer7oKRrXE+cLe/XkewwKq1BBUcJLp6S7OPXlMtnmhNxZM7CZAUsPaFAQ+V9X4otMd6eDnrAdPFILS62pBEe4=
X-Received: by 2002:a05:6808:128f:b0:3d5:1f50:1891 with SMTP id
 5614622812f47-3d51f502930mr10367676b6e.31.1718987074917; Fri, 21 Jun 2024
 09:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
 <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
 <87msnqvtpv.fsf@draig.linaro.org>
 <CAFEAcA8-gnh3sF6yPuPOfHg=C4H2=f-VYobKcXNUdMCWpdYNNw@mail.gmail.com>
In-Reply-To: <CAFEAcA8-gnh3sF6yPuPOfHg=C4H2=f-VYobKcXNUdMCWpdYNNw@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Fri, 21 Jun 2024 11:24:23 -0500
Message-ID: <CACBuX0ScjkxnRBzmrpBwekV+WG4S0jsYgE_ch+TJ_fq_Xjbvfg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f95a84061b68ddba"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.359, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000f95a84061b68ddba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:21=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Wed, 12 Jun 2024 at 20:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > Cord Amfmgm <dmamfmgm@gmail.com> writes:
> >
> > > On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee=
@linaro.org>
> wrote:
> > >
> > >  David Hubbard <dmamfmgm@gmail.com> writes:
> > >
> > >  > From: Cord Amfmgm <dmamfmgm@gmail.com>
> > >  >
> > >  > This changes the way the ohci emulation handles a Transfer
> Descriptor with
> > >  > "Current Buffer Pointer" set to "Buffer End" + 1.
> > >  >
> > >  > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more
> than td.be
> > >  > to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> > >  > Transfer Descriptors if the td.cbp is equal to 0, while actual OHC=
I
> hardware
> > >  > accepts both cases.
> > >  >
> > >  > The qemu ohci emulation has a regression in ohci_service_td.
> Version 4.2
> > >  > and earlier matched the spec. (I haven't taken the time to bisect
> exactly
> > >  > where the logic was changed.)
> > >
> > >  I find it hard to characterise this as a regression because we've
> > >  basically gone from no checks to actually doing bounds checks:
> > >
> > >    1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variable=
s)
> > >
> > >  The argument here seems to be that real hardware is laxer than the
> specs
> > >  in what it accepts.
> > >
> > <snip>
> > >
> > >  With the updated commit message:
> > >
> > >  Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > >
> > > Please forgive my lack of experience on this mailing list. I don't se=
e
> a suggested commit message from Alex but in case that
> > > was what is being considered, here is one. Feedback welcome, also if
> this is not what is wanted, please just say it.
> > >
> >
> > Something along the lines of what you suggest here
>
> Thanks; I've picked up this patch for target-arm.next (as with
> your previous one for hcd-ohci, adjusting the Author and
> Signed-off-by lines to both read David Hubbard).
>
> I tweaked the commit message a little bit, so the middle part reads:
>
>     What this patch does is loosen the qemu ohci implementation to allow =
a
>     zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and
> with a
>     non-zero td.cbp value.
>
>     The spec is unclear whether this is valid or not -- it is not the
>     clearly documented way to send a zero length TD (which is CBP=3DBE=3D=
0),
>     but it isn't specifically forbidden. Actual hw seems to be ok with it=
.
>
> thanks
> -- PMM
>

That tweak looks great.

Thank you for your patience working with me to get this patch into a good
shape.

This was my first attempt to contribute to qemu - really appreciate it.

--000000000000f95a84061b68ddba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 10:21=E2=80=AFAM =
Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell=
@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, 12 Jun 2024 at 20:36, Alex Benn=C3=A9e &lt;<a href=3D"ma=
ilto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&g=
t; wrote:<br>
&gt;<br>
&gt; Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank=
">dmamfmgm@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e &lt;<a h=
ref=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.=
org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com" tar=
get=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail=
.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; This changes the way the ohci emulation handles a Tran=
sfer Descriptor with<br>
&gt; &gt;=C2=A0 &gt; &quot;Current Buffer Pointer&quot; set to &quot;Buffer=
 End&quot; + 1.<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be on=
e byte more than <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_bla=
nk">td.be</a><br>
&gt; &gt;=C2=A0 &gt; to signal the buffer has zero length. Currently qemu o=
nly accepts zero-length<br>
&gt; &gt;=C2=A0 &gt; Transfer Descriptors if the td.cbp is equal to 0, whil=
e actual OHCI hardware<br>
&gt; &gt;=C2=A0 &gt; accepts both cases.<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; The qemu ohci emulation has a regression in ohci_servi=
ce_td. Version 4.2<br>
&gt; &gt;=C2=A0 &gt; and earlier matched the spec. (I haven&#39;t taken the=
 time to bisect exactly<br>
&gt; &gt;=C2=A0 &gt; where the logic was changed.)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 I find it hard to characterise this as a regression because=
 we&#39;ve<br>
&gt; &gt;=C2=A0 basically gone from no checks to actually doing bounds chec=
ks:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_n=
umber variables)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 The argument here seems to be that real hardware is laxer t=
han the specs<br>
&gt; &gt;=C2=A0 in what it accepts.<br>
&gt; &gt;<br>
&gt; &lt;snip&gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 With the updated commit message:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.be=
nnee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Please forgive my lack of experience on this mailing list. I don&=
#39;t see a suggested commit message from Alex but in case that<br>
&gt; &gt; was what is being considered, here is one. Feedback welcome, also=
 if this is not what is wanted, please just say it.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Something along the lines of what you suggest here<br>
<br>
Thanks; I&#39;ve picked up this patch for target-arm.next (as with<br>
your previous one for hcd-ohci, adjusting the Author and<br>
Signed-off-by lines to both read David Hubbard).<br>
<br>
I tweaked the commit message a little bit, so the middle part reads:<br>
<br>
=C2=A0 =C2=A0 What this patch does is loosen the qemu ohci implementation t=
o allow a<br>
=C2=A0 =C2=A0 zero-length packet if <a href=3D"http://td.be" rel=3D"norefer=
rer" target=3D"_blank">td.be</a> (Buffer End) is set to td.cbp - 1, and wit=
h a<br>
=C2=A0 =C2=A0 non-zero td.cbp value.<br>
<br>
=C2=A0 =C2=A0 The spec is unclear whether this is valid or not -- it is not=
 the<br>
=C2=A0 =C2=A0 clearly documented way to send a zero length TD (which is CBP=
=3DBE=3D0),<br>
=C2=A0 =C2=A0 but it isn&#39;t specifically forbidden. Actual hw seems to b=
e ok with it.<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>That tweak looks great.</div><di=
v><br></div><div>Thank you for your patience working with me to get this pa=
tch into a good shape.</div><div><br></div><div>This was my first attempt t=
o contribute to qemu - really appreciate it.</div></div></div>

--000000000000f95a84061b68ddba--

