Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 04:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCXoC-00005m-2K; Thu, 30 May 2024 00:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCXoA-00005Z-Fb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 00:54:34 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCXo8-0004sT-JM
 for qemu-devel@nongnu.org; Thu, 30 May 2024 00:54:34 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-80ac969db43so140835241.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717044871; x=1717649671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Opw88Cx8lV3zBjamTsI9ISPdAtXBkHEAHa05Y6lP3pM=;
 b=jvWjhE3OOWoWdYQ6JxMaZM2VcsBPE6+n/ugZW9ELo2g+ryMDXqbDHp3pmfqsppS14Q
 cRw+yNve3I1djypDDprmyyV59c0O5COspL52NzSR0Jf0VNaHUMpT82Wy/P1zcV3ZccZI
 Svqyra5K8RfpsPkYioSbcIT/+r3/VQJQm74wmbqD8sqktTrrY2/g3Q535POn6BLfvvaE
 zYkD7taDXJASjoMGm3WoFzH7yj+/trA5rKQiDJjncoMDTiviC2vmu1yZW/Lbz3negDqY
 L3XEAJJChFSlxJuKjgWOhch221A4BLHphVNPGAWne3zX5TQpDuHV58CpDN/dxEq9tGDJ
 xQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717044871; x=1717649671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Opw88Cx8lV3zBjamTsI9ISPdAtXBkHEAHa05Y6lP3pM=;
 b=ejR9OOS0+qLwyZfF6kCZ5vzlD5+KwlJugz34n0IbDeyWaDfVH43bm8Ngh8vtxGqXyy
 A29v619LS7uTBZMES22O1uMVmT8KjoIRrnqK53MraOPLny85Ggr2YrAoAxkmdb7c5Fwt
 KS3hZzQGWnthdPKwrqkRPwWHHdkt2W03Rc9b76O8+ZpHgsIoG1ZaoFE9WtxJEspsbcWh
 hzhGy2OlqTBIy6CDhCCdSl9gKsy9YmcggGxNvi0zce728BAVDeX0JrhgIQqBlI6zSoSu
 IjsE6RiArRJL6U2ibT8P5w1aO/csbDZBrPfcRbGNX3v4R2+Np4izkC50fCjTIn8mf1av
 x42A==
X-Gm-Message-State: AOJu0Yzr1ajmLR9WWprRX9eLMEzU7Blxpl0f49862E9ytPa2dYCSMHLX
 aAkJkhseCl86sv6HGX18BER5DOaXAkfOsIXw/hj45IiVrd+hPPEZqCBmWumrGz2HPdWPQp2qIRr
 OhL4UZ8KXwQr0ydI+UTgrq0go/IlVJA==
X-Google-Smtp-Source: AGHT+IGTTey604ReTd/vgKZGVIG/sG+JjMOpY6A8zgVPpd0siSRgPTa7otHooOwoR4zPGPSWCgTarVID0pUT/VNDzSY=
X-Received: by 2002:a05:6102:4a45:b0:47c:3823:63dc with SMTP id
 ada2fe7eead31-48baea17aafmr1513677137.17.1717044870791; Wed, 29 May 2024
 21:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
 <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Wed, 29 May 2024 23:54:18 -0500
Message-ID: <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000964aa80619a4a95e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92b.google.com
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

--000000000000964aa80619a4a95e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >
> >
> >
> > On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >>
> >> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> >> >> For the "zero length buffer" case, do you have a more detailed
> >> >> pointer to the bit of the spec that says that "cbp =3D be + 1" is a
> >> >> valid way to specify a zero length buffer? Table 4-2 in the copy I
> >> >> have says for CurrentBufferPointer "a value of 0 indicates
> >> >> a zero-length data packet or that all bytes have been transferred",
> >> >> and the sample host OS driver function QueueGeneralRequest()
> >> >> later in the spec handles a 0 length packet by setting
> >> >>   TD->HcTD.CBP =3D TD->HcTD.BE =3D 0;
> >> >> (which our emulation's code does handle).
> >> >
> >> >
> >> > Reading the spec carefully, a CBP set to 0 should always mean the
> zero-length buffer case (or that all bytes have been transferred, so the
> buffer is now zero-length - the same thing).
> >>
> >> Yeah, I can see the argument for "we should treat all cbp =3D=3D 0 as
> >> zero-length buffer, not just cbp =3D=3D be =3D=3D 0".
> >>
> >> > Table 4-2 is the correct reference, and this part is clear. It's the
> part you quoted. "Contains the physical address of the next memory locati=
on
> that will be accessed for transfer to/from the endpoint. A value of 0
> indicates a zero-length data packet or that all bytes have been
> transferred."
> >> >
> >> > Table 4-2 has this additional nugget that may be confusingly worded,
> for BufferEnd: "Contains physical address of the last byte in the buffer
> for this TD"
> >>
> >> Mmm, but for a zero length buffer there is no "last byte" to
> >> have this be the physical address of.
> >>
> >> > And here's an example buffer of length 0 -- you probably already kno=
w
> what I'm going to do here:
> >> >
> >> > char buf[0];
> >> > char * CurrentBufferPointer =3D &buf[0];
> >> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in the
> buffer"
> >> > // The OHCI Host Controller than advances CurrentBufferPointer like
> this: CurrentBufferPointer +=3D 0
> >> > // After the transfer:
> >> > // CurrentBufferPointer =3D &buf[0];
> >> > // BufferEnd =3D &buf[-1];
> >>
> >> Right, but why do you think this is valid, rather than
> >> being a guest software bug? My reading of the spec is that it's
> >> pretty clear about how to say "zero length buffer", and this
> >> isn't it.
> >>
> >> Is there some real-world guest OS that programs the OHCI
> >> controller this way that we're trying to accommodate?
> >
> >
> > qemu versions 4.2 and before allowed this behavior.
>
> So? That might just mean we had a bug and we fixed it.
> 4.2 is a very old version of QEMU and nobody seems to have
> complained in the four years since we released 5.0 about this,
> which suggests that generally guest OS drivers don't try
> to send zero-length buffers in this way.
>
> > I don't think it's valid to ask for a *popular* guest OS as a
> proof-of-concept because I'm not an expert on those.
>
> I didn't ask for "popular"; I asked for "real-world".
> What is the actual guest code you're running that falls over
> because of the behaviour change?
>
> More generally, why do you want this behaviour to be
> changed? Reasonable reasons might include:
>  * we're out of spec based on reading the documentation
>  * you're trying to run some old Windows VM/QNX/etc image,
>    and it doesn't work any more
>  * all the real hardware we tested behaves this way
>
> But don't necessarily include:
>  * something somebody wrote and only tested on QEMU happens to
>    assume the old behaviour rather than following the hw spec
>
> QEMU occasionally works around guest OS bugs, but only as
> when we really have to. It's usually better to fix the
> bug in the guest.
>

It's not, and I've already demonstrated that real hardware is consistent
with the fix in this patch.

Please check your tone.


>
> thanks
> -- PMM
>

--000000000000964aa80619a4a95e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 28, 2024 at 11:32=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, 28 May 2024 at 16:37, Cord Amfmgm &lt;<a href=3D"m=
ailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, 20 May 2024 at 23:24, Cord Amfmgm &lt;<a href=3D"mailto:dm=
amfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell &lt;<a=
 href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@l=
inaro.org</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; For the &quot;zero length buffer&quot; case, do you have =
a more detailed<br>
&gt;&gt; &gt;&gt; pointer to the bit of the spec that says that &quot;cbp =
=3D be + 1&quot; is a<br>
&gt;&gt; &gt;&gt; valid way to specify a zero length buffer? Table 4-2 in t=
he copy I<br>
&gt;&gt; &gt;&gt; have says for CurrentBufferPointer &quot;a value of 0 ind=
icates<br>
&gt;&gt; &gt;&gt; a zero-length data packet or that all bytes have been tra=
nsferred&quot;,<br>
&gt;&gt; &gt;&gt; and the sample host OS driver function QueueGeneralReques=
t()<br>
&gt;&gt; &gt;&gt; later in the spec handles a 0 length packet by setting<br=
>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0TD-&gt;HcTD.CBP =3D TD-&gt;HcTD.BE =3D 0;<br>
&gt;&gt; &gt;&gt; (which our emulation&#39;s code does handle).<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Reading the spec carefully, a CBP set to 0 should always mean=
 the zero-length buffer case (or that all bytes have been transferred, so t=
he buffer is now zero-length - the same thing).<br>
&gt;&gt;<br>
&gt;&gt; Yeah, I can see the argument for &quot;we should treat all cbp =3D=
=3D 0 as<br>
&gt;&gt; zero-length buffer, not just cbp =3D=3D be =3D=3D 0&quot;.<br>
&gt;&gt;<br>
&gt;&gt; &gt; Table 4-2 is the correct reference, and this part is clear. I=
t&#39;s the part you quoted. &quot;Contains the physical address of the nex=
t memory location that will be accessed for transfer to/from the endpoint. =
A value of 0 indicates a zero-length data packet or that all bytes have bee=
n transferred.&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Table 4-2 has this additional nugget that may be confusingly =
worded, for BufferEnd: &quot;Contains physical address of the last byte in =
the buffer for this TD&quot;<br>
&gt;&gt;<br>
&gt;&gt; Mmm, but for a zero length buffer there is no &quot;last byte&quot=
; to<br>
&gt;&gt; have this be the physical address of.<br>
&gt;&gt;<br>
&gt;&gt; &gt; And here&#39;s an example buffer of length 0 -- you probably =
already know what I&#39;m going to do here:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; char buf[0];<br>
&gt;&gt; &gt; char * CurrentBufferPointer =3D &amp;buf[0];<br>
&gt;&gt; &gt; char * BufferEnd =3D &amp;buf[-1]; // &quot;address of the la=
st byte in the buffer&quot;<br>
&gt;&gt; &gt; // The OHCI Host Controller than advances CurrentBufferPointe=
r like this: CurrentBufferPointer +=3D 0<br>
&gt;&gt; &gt; // After the transfer:<br>
&gt;&gt; &gt; // CurrentBufferPointer =3D &amp;buf[0];<br>
&gt;&gt; &gt; // BufferEnd =3D &amp;buf[-1];<br>
&gt;&gt;<br>
&gt;&gt; Right, but why do you think this is valid, rather than<br>
&gt;&gt; being a guest software bug? My reading of the spec is that it&#39;=
s<br>
&gt;&gt; pretty clear about how to say &quot;zero length buffer&quot;, and =
this<br>
&gt;&gt; isn&#39;t it.<br>
&gt;&gt;<br>
&gt;&gt; Is there some real-world guest OS that programs the OHCI<br>
&gt;&gt; controller this way that we&#39;re trying to accommodate?<br>
&gt;<br>
&gt;<br>
&gt; qemu versions 4.2 and before allowed this behavior.<br>
<br>
So? That might just mean we had a bug and we fixed it.<br>
4.2 is a very old version of QEMU and nobody seems to have<br>
complained in the four years since we released 5.0 about this,<br>
which suggests that generally guest OS drivers don&#39;t try<br>
to send zero-length buffers in this way.<br>
<br>
&gt; I don&#39;t think it&#39;s valid to ask for a *popular* guest OS as a =
proof-of-concept because I&#39;m not an expert on those.<br>
<br>
I didn&#39;t ask for &quot;popular&quot;; I asked for &quot;real-world&quot=
;.<br>
What is the actual guest code you&#39;re running that falls over<br>
because of the behaviour change?<br>
<br>
More generally, why do you want this behaviour to be<br>
changed? Reasonable reasons might include:<br>
=C2=A0* we&#39;re out of spec based on reading the documentation<br>
=C2=A0* you&#39;re trying to run some old Windows VM/QNX/etc image,<br>
=C2=A0 =C2=A0and it doesn&#39;t work any more<br>
=C2=A0* all the real hardware we tested behaves this way<br>
<br>
But don&#39;t necessarily include:<br>
=C2=A0* something somebody wrote and only tested on QEMU happens to<br>
=C2=A0 =C2=A0assume the old behaviour rather than following the hw spec<br>
<br>
QEMU occasionally works around guest OS bugs, but only as<br>
when we really have to. It&#39;s usually better to fix the<br>
bug in the guest.<br></blockquote><div><br></div><div>It&#39;s not, and I&#=
39;ve already demonstrated that real hardware is consistent with the fix in=
 this patch.</div><div><br></div><div>Please check your tone.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000964aa80619a4a95e--

