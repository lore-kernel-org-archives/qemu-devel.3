Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A867EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBytD-0007Kf-AA; Tue, 28 May 2024 11:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sBytB-0007JB-5M
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:37:25 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sByt9-0004D7-2U
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:37:24 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-48a39e3923fso304396137.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716910641; x=1717515441; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F9SNlMdy/XgPX65jRFYAFl/zi5QpZ+wDvEyutcnbNcw=;
 b=NS4i9P/expqg2Me7wnSNMGM8jHVtM7Z9KgA2wIigLcT2SGhVuGaJpR1FwqraKYNQX5
 oe0XRK+filBZuD3nFIBF34gg/1VXkETfjFc8O7BNot4ChXzwH3gLLP/w5mTVP/7gOLvw
 rFp7r4jmyPBYqlwvQdClhSJXRnjAyjQzxxI2ekITnfA0trYsuCbSoDhsXT5zFw81IT+V
 8s6u5JKqRmspifvz8JqiouHhkYBnQwhWJAfc9zhM97zQ7cE8xmV1lee3LUwH3YdVHZHQ
 CRo1dxUZMCkqEF9TQlnINFYSebbbFm1acX0a0NXqWIfSbyBITUQwZue4MVZwVjRipExY
 5TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910641; x=1717515441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9SNlMdy/XgPX65jRFYAFl/zi5QpZ+wDvEyutcnbNcw=;
 b=DbF42Jbp35pm6GGsk1k6D2l2OYfGUo0QjOxnGaXO+RvaI/h4K+AoZYNfvhBt6xURWW
 1BTEE80h7ehruZP10ZvT9QAmYAjbjpItk8c+Ri/rmsaauJz4kaFrY9obac3R9gR1UlGj
 sh9uQWOHM1TE+tuvoGsStUCrtq1RWtGKZhQrSUrm+9Ltw2hQWjTuHH6kGG2bneY7E3yf
 oujq6IfbIJZYOwL0XyLElRfBdoh5ygEGPlllCxOGnt5eiXpN3Rnh8X1c2lxXO7+om4sL
 9/hT44mqU9iZYxD9VJGAc80Ds+q4XJkSeZfsbJeEvJz35SUvSPPCqGKEZ7RVHGiFVLvP
 Mlpw==
X-Gm-Message-State: AOJu0YwRLJTCmsKPhmCOQ91ZWsYGM4xkTxXA+uT2vEJBX98//pqIYfEG
 XmwhSpEHLCoDRShxNKPtVJpCqAEsq/vqHqsGdqasXD0p4GSMdSAHNa0SfUSuaGihpN0Wi5gGeJb
 bItf00cfoLjkKdjcPTOKP0zUFORjZcBXY
X-Google-Smtp-Source: AGHT+IEd+LqwoZFoiG1J5eURRWZGZN6BxjtuBJmWRktEmTeb8KUztt1G6nFXCsnqYJIJ+LfwfHpcD/XkCPrdT2liorc=
X-Received: by 2002:a05:6102:3121:b0:47c:1255:dc2d with SMTP id
 ada2fe7eead31-48a386f75f5mr11059720137.33.1716910640069; Tue, 28 May 2024
 08:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
In-Reply-To: <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Tue, 28 May 2024 10:37:08 -0500
Message-ID: <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d0014c0619856844"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000d0014c0619856844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org>
> wrote:
> >> For the "zero length buffer" case, do you have a more detailed
> >> pointer to the bit of the spec that says that "cbp =3D be + 1" is a
> >> valid way to specify a zero length buffer? Table 4-2 in the copy I
> >> have says for CurrentBufferPointer "a value of 0 indicates
> >> a zero-length data packet or that all bytes have been transferred",
> >> and the sample host OS driver function QueueGeneralRequest()
> >> later in the spec handles a 0 length packet by setting
> >>   TD->HcTD.CBP =3D TD->HcTD.BE =3D 0;
> >> (which our emulation's code does handle).
> >
> >
> > Reading the spec carefully, a CBP set to 0 should always mean the
> zero-length buffer case (or that all bytes have been transferred, so the
> buffer is now zero-length - the same thing).
>
> Yeah, I can see the argument for "we should treat all cbp =3D=3D 0 as
> zero-length buffer, not just cbp =3D=3D be =3D=3D 0".
>
> > Table 4-2 is the correct reference, and this part is clear. It's the
> part you quoted. "Contains the physical address of the next memory locati=
on
> that will be accessed for transfer to/from the endpoint. A value of 0
> indicates a zero-length data packet or that all bytes have been
> transferred."
> >
> > Table 4-2 has this additional nugget that may be confusingly worded, fo=
r
> BufferEnd: "Contains physical address of the last byte in the buffer for
> this TD"
>
> Mmm, but for a zero length buffer there is no "last byte" to
> have this be the physical address of.
>
> > And here's an example buffer of length 0 -- you probably already know
> what I'm going to do here:
> >
> > char buf[0];
> > char * CurrentBufferPointer =3D &buf[0];
> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in the buff=
er"
> > // The OHCI Host Controller than advances CurrentBufferPointer like
> this: CurrentBufferPointer +=3D 0
> > // After the transfer:
> > // CurrentBufferPointer =3D &buf[0];
> > // BufferEnd =3D &buf[-1];
>
> Right, but why do you think this is valid, rather than
> being a guest software bug? My reading of the spec is that it's
> pretty clear about how to say "zero length buffer", and this
> isn't it.
>
> Is there some real-world guest OS that programs the OHCI
> controller this way that we're trying to accommodate?
>

qemu versions 4.2 and before allowed this behavior.

I don't think it's valid to ask for a *popular* guest OS as a
proof-of-concept because I'm not an expert on those. The spec says "last
byte" which can (not "should" just "can") be interpreted as "cbp - 1".
Therefore, I raised this patch request to re-enable the previous qemu
behavior, in the sense of ""be conservative in what you do, be liberal in
what you accept from others" -
https://en.wikipedia.org/wiki/Robustness_principle

It is *not* valid to say the spec disallows "cbp - 1" to mean "empty
buffer." That is what I am arguing :)


>
> thanks
> -- PMM
>

--000000000000d0014c0619856844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 28, 2024 at 9:03=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, 20 May 2024 at 23:24, Cord Amfmgm &lt;<a href=3D"mail=
to:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<=
br>
&gt; On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org=
</a>&gt; wrote:<br>
&gt;&gt; For the &quot;zero length buffer&quot; case, do you have a more de=
tailed<br>
&gt;&gt; pointer to the bit of the spec that says that &quot;cbp =3D be + 1=
&quot; is a<br>
&gt;&gt; valid way to specify a zero length buffer? Table 4-2 in the copy I=
<br>
&gt;&gt; have says for CurrentBufferPointer &quot;a value of 0 indicates<br=
>
&gt;&gt; a zero-length data packet or that all bytes have been transferred&=
quot;,<br>
&gt;&gt; and the sample host OS driver function QueueGeneralRequest()<br>
&gt;&gt; later in the spec handles a 0 length packet by setting<br>
&gt;&gt;=C2=A0 =C2=A0TD-&gt;HcTD.CBP =3D TD-&gt;HcTD.BE =3D 0;<br>
&gt;&gt; (which our emulation&#39;s code does handle).<br>
&gt;<br>
&gt;<br>
&gt; Reading the spec carefully, a CBP set to 0 should always mean the zero=
-length buffer case (or that all bytes have been transferred, so the buffer=
 is now zero-length - the same thing).<br>
<br>
Yeah, I can see the argument for &quot;we should treat all cbp =3D=3D 0 as<=
br>
zero-length buffer, not just cbp =3D=3D be =3D=3D 0&quot;.<br>
<br>
&gt; Table 4-2 is the correct reference, and this part is clear. It&#39;s t=
he part you quoted. &quot;Contains the physical address of the next memory =
location that will be accessed for transfer to/from the endpoint. A value o=
f 0 indicates a zero-length data packet or that all bytes have been transfe=
rred.&quot;<br>
&gt;<br>
&gt; Table 4-2 has this additional nugget that may be confusingly worded, f=
or BufferEnd: &quot;Contains physical address of the last byte in the buffe=
r for this TD&quot;<br>
<br>
Mmm, but for a zero length buffer there is no &quot;last byte&quot; to<br>
have this be the physical address of.<br>
<br>
&gt; And here&#39;s an example buffer of length 0 -- you probably already k=
now what I&#39;m going to do here:<br>
&gt;<br>
&gt; char buf[0];<br>
&gt; char * CurrentBufferPointer =3D &amp;buf[0];<br>
&gt; char * BufferEnd =3D &amp;buf[-1]; // &quot;address of the last byte i=
n the buffer&quot;<br>
&gt; // The OHCI Host Controller than advances CurrentBufferPointer like th=
is: CurrentBufferPointer +=3D 0<br>
&gt; // After the transfer:<br>
&gt; // CurrentBufferPointer =3D &amp;buf[0];<br>
&gt; // BufferEnd =3D &amp;buf[-1];<br>
<br>
Right, but why do you think this is valid, rather than<br>
being a guest software bug? My reading of the spec is that it&#39;s<br>
pretty clear about how to say &quot;zero length buffer&quot;, and this<br>
isn&#39;t it.<br>
<br>
Is there some real-world guest OS that programs the OHCI<br>
controller this way that we&#39;re trying to accommodate?<br></blockquote><=
div><br></div><div>qemu versions 4.2 and before allowed this behavior.</div=
><div><br></div><div>I don&#39;t think it&#39;s valid to ask for a *popular=
* guest=C2=A0OS as a proof-of-concept because I&#39;m not an expert on thos=
e. The spec says &quot;last byte&quot; which can (not &quot;should&quot; ju=
st &quot;can&quot;) be interpreted as &quot;cbp - 1&quot;. Therefore, I rai=
sed this patch request to re-enable the previous qemu behavior, in the sens=
e of &quot;&quot;be conservative in what you do, be liberal in what you acc=
ept from others&quot; -=C2=A0<a href=3D"https://en.wikipedia.org/wiki/Robus=
tness_principle">https://en.wikipedia.org/wiki/Robustness_principle</a></di=
v><div><br></div><div>It is *not* valid to say the spec disallows &quot;cbp=
 - 1&quot; to mean &quot;empty buffer.&quot; That is what I am arguing :)</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000d0014c0619856844--

