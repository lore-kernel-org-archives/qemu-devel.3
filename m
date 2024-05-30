Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3DDC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCn3t-0003cx-6r; Thu, 30 May 2024 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCn3r-0003b5-O4
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:11:47 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCn3p-00047J-An
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:11:47 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-48bbf19b925so84046137.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717103504; x=1717708304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yFb09zOwnF4CcW+a0L/MI+V/tZdX54tXx2t643LhI4U=;
 b=LMrXkUz3Ddj0rXD2bS9nZOGY5hvYvzpML7BxdL+WJKQ3yIVLQPu5QUy5XrAUZzKPHb
 5jmoUwV8Y9Bxc789FSTjA3P7amZQSpuFX1gY0pnHLQ2x39qho41PJoM9R6sABY0eWh5V
 XNhBUSVCLiIownL2s1gYQaOK6QB3KxTMq245BrxncuxlHVV8Dcq5hD8/v+fpXVvN6PhF
 gihreN3bhcoAR8RINTcdqoIYf5aLaCSUOwYgWOZ3I5bqT3nFImvOEFM8z3GGKxajCOeV
 l4D73mJ+m+U2VYYFQFA6XBcqzONRTG07hrENHdeU0XIcdaUCBIRDffSOPZnXcT8vlkph
 mWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103504; x=1717708304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yFb09zOwnF4CcW+a0L/MI+V/tZdX54tXx2t643LhI4U=;
 b=sbB2mQK7E2OZL6ysF3gCWLtnt3/sxSglvX5Z8QXd2Nk89ZMOY4xuPHbVne3ND/A8oa
 eYeLuoVbvjGa02kBAV4Z/wtEY69g2vqehqCzujqguT0C4VWr2lWLJLPsWMdCKwCNYgqo
 ipClvn+hMHtTU2NikaiUGY9xZyBX1tDgqjC9ZrCpnukw759djWqgSt7z+/HyYYNRFyW/
 7QtIG/rlWy7TbfXELDTZ1D3YqBMgw8m4Sa/LE3b3hl7c4aT/jcbkogRFBG3VY3JPJvxi
 yCNHyWBbDIGJu6XhUzLvXH/P0SwcAwmyJTNsTcxQKQp1vUXdZHroeYZl/qJ556Bjuvqp
 vnzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3HarjumzsUG0fHf1rHaS3i2e8pEMzChzTnV8wOB0VJHQw3M1y5oNXcmW85mWkhiGiMojxP21AzMig1BlI371bsiFtTc=
X-Gm-Message-State: AOJu0Yz6zauQRPSR+xfKjhm+ZprE6SCZx20VhY+DP0nrNGzidHW9P3az
 dllhA1eY0RsIaiAR1YwIghFjmF44dupZzxtWB1Aesc6LHYyq+Ff5kuEcgyBquRsnMQiwtHQoSdy
 oGy5zap/W0VD2y+R5voiR5UIIrkg=
X-Google-Smtp-Source: AGHT+IGxJiSlJwRnSUchBJrtY6MuVO0PpLNMSzwVL1lNPldaHFNnv+Yf5OY/IMP3jv6+PhwRWCjjCR67ZODnM18FHxI=
X-Received: by 2002:a05:6102:495:b0:48b:a684:ff45 with SMTP id
 ada2fe7eead31-48bc20bab94mr55218137.4.1717103503863; Thu, 30 May 2024
 14:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
 <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
 <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
 <87zfs7d7i6.fsf@draig.linaro.org>
 <CACBuX0T6aPHEQzgqDJs14NvOTPj9ngQ4Avw-dZ8yn4q4fGbnqA@mail.gmail.com>
 <87mso7cdwe.fsf@draig.linaro.org>
In-Reply-To: <87mso7cdwe.fsf@draig.linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Thu, 30 May 2024 16:11:31 -0500
Message-ID: <CACBuX0QZTo+5NBdpsjFet2qVBMMpP1wfeEoFPM_xGcvH9aYNbg@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000063f4620619b2503a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.006, HTML_MESSAGE=0.001,
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

--00000000000063f4620619b2503a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 2:12=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Cord Amfmgm <dmamfmgm@gmail.com> writes:
>
> > On Thu, May 30, 2024 at 3:33=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> >  Cord Amfmgm <dmamfmgm@gmail.com> writes:
> >
> >  > On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> >  >
> >  >  On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com>
> wrote:
> >  >  >
> >  >  > On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> >  >  >>
> >  >  >> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com>
> wrote:
> >  >  >> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> >  <snip>
> >  >  >> > And here's an example buffer of length 0 -- you probably
> already know what I'm going to do here:
> >  >  >> >
> >  >  >> > char buf[0];
> >  >  >> > char * CurrentBufferPointer =3D &buf[0];
> >  >  >> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in
> the buffer"
> >  >  >> > // The OHCI Host Controller than advances CurrentBufferPointer
> like this: CurrentBufferPointer +=3D 0
> >  >  >> > // After the transfer:
> >  >  >> > // CurrentBufferPointer =3D &buf[0];
> >  >  >> > // BufferEnd =3D &buf[-1];
> >  >  >>
> >  >  >> Right, but why do you think this is valid, rather than
> >  >  >> being a guest software bug? My reading of the spec is that it's
> >  >  >> pretty clear about how to say "zero length buffer", and this
> >  >  >> isn't it.
> >  >  >>
> >  >  >> Is there some real-world guest OS that programs the OHCI
> >  >  >> controller this way that we're trying to accommodate?
> >  >  >
> >  >  >
> >  >  > qemu versions 4.2 and before allowed this behavior.
> >  >
> >  >  So? That might just mean we had a bug and we fixed it.
> >  >  4.2 is a very old version of QEMU and nobody seems to have
> >  >  complained in the four years since we released 5.0 about this,
> >  >  which suggests that generally guest OS drivers don't try
> >  >  to send zero-length buffers in this way.
> >  >
> >  >  > I don't think it's valid to ask for a *popular* guest OS as a
> proof-of-concept because I'm not an expert on those.
> >  >
> >  >  I didn't ask for "popular"; I asked for "real-world".
> >  >  What is the actual guest code you're running that falls over
> >  >  because of the behaviour change?
> >  >
> >  >  More generally, why do you want this behaviour to be
> >  >  changed? Reasonable reasons might include:
> >  >   * we're out of spec based on reading the documentation
> >  >   * you're trying to run some old Windows VM/QNX/etc image,
> >  >     and it doesn't work any more
> >  >   * all the real hardware we tested behaves this way
> >  >
> >  >  But don't necessarily include:
> >  >   * something somebody wrote and only tested on QEMU happens to
> >  >     assume the old behaviour rather than following the hw spec
> >  >
> >  >  QEMU occasionally works around guest OS bugs, but only as
> >  >  when we really have to. It's usually better to fix the
> >  >  bug in the guest.
> >  >
> >  > It's not, and I've already demonstrated that real hardware is
> consistent with the fix in this patch.
> >  >
> >  > Please check your tone.
> >
> >  I don't think that is a particularly helpful comment for someone who i=
s
> >  taking the time to review your patches. Reading through the thread I
> >  didn't see anything that said this is how real HW behaves but I may we=
ll
> >  have missed it. However you have a number of review comments to addres=
s
> >  so I suggest you spin a v2 of the series to address them and outline t=
he
> >  reason to accept an out of spec transaction.
> >
> > I did a rework of the patch -- see my email from May 20, quoted below -=
-
> and I was under the impression it addressed all the
> > review comments. Did I miss something? I apologize if I did.
>
> Ahh I see - I'd only seen this thread continue so wasn't aware a new
> version had been posted. For future patches consider using -vN when
> sending them so we can clearly see a new revision is available.
>
> >
> >> index acd6016980..71b54914d3 100644
> >> --- a/hw/usb/hcd-ohci.c
> >> +++ b/hw/usb/hcd-ohci.c
> >> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
> >>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >>          } else {
> >> -            if (td.cbp > td.be) {
> >> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> >> +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */
> >
> >> Reading through the thread I didn't see anything that said this is how
> real HW behaves but I may well have missed it.
> >
> > This is what I wrote regarding real HW:
> >
> > Results are:
> >
> >  qemu 4.2   | qemu HEAD  | actual HW
> > ------------+------------+------------
> >  works fine | ohci_die() | works fine
> >
> > Would additional verification of the actual HW be useful?
> >
> > Peter posted the following which is more specific than "qemu 4.2" -- I
> agree this is most likely the qemu commit where this
> > thread is focused:
> >
> >> Almost certainly this was commit 1328fe0c32d54 ("hw: usb: hcd-ohci:
> >> check len and frame_number variables"), which added these bounds
> >> checks. Prior to that we did no bounds checking at all, which
> >> meant that we permitted cbp=3Dbe+1 to mean a zero length, but also
> >> that we permitted the guest to overrun host-side buffers by
> >> specifying completely bogus cbp and be values. The timeframe is
> >> more or less right (2020), at least.
> >>
> >> -- PMM
> >
> > Where does the conversation go from here? I'm under the impression I
> have provided objective answers to all the questions
> > and resolved all review comments on the code. I receive the feedback
> > that I missed something - please restate the question?
>
> I can see patch 1/2 has been queued and 2/2 is still outstanding. I'm
> having trouble finding the referenced entry in the OHCI spec. The only
> one I can see is Release 1.1, January 6th, 2000 and that doesn't have a
> section 4.3.1.2.
>
> I think discussion should continue on that thread.
>

Yes, agreed.


>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--00000000000063f4620619b2503a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 2:12=E2=80=AF=
PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benn=
ee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thu, May 30, 2024 at 3:33=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 &gt; On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell &lt;=
<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell=
@linaro.org</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 On Tue, 28 May 2024 at 16:37, Cord Amfmgm &lt;<a href=
=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt;=
 wrote:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pet=
er.maydell@linaro.org</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; On Mon, 20 May 2024 at 23:24, Cord Amfmgm &l=
t;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.co=
m</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; On Mon, May 20, 2024 at 12:05=E2=80=AFP=
M Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_=
blank">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt;=C2=A0 &lt;snip&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; And here&#39;s an example buffer of len=
gth 0 -- you probably already know what I&#39;m going to do here:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; char buf[0];<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; char * CurrentBufferPointer =3D &amp;bu=
f[0];<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; char * BufferEnd =3D &amp;buf[-1]; // &=
quot;address of the last byte in the buffer&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; // The OHCI Host Controller than advanc=
es CurrentBufferPointer like this: CurrentBufferPointer +=3D 0<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; // After the transfer:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; // CurrentBufferPointer =3D &amp;buf[0]=
;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; &gt; // BufferEnd =3D &amp;buf[-1];<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; Right, but why do you think this is valid, r=
ather than<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; being a guest software bug? My reading of th=
e spec is that it&#39;s<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; pretty clear about how to say &quot;zero len=
gth buffer&quot;, and this<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; isn&#39;t it.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; Is there some real-world guest OS that progr=
ams the OHCI<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt; controller this way that we&#39;re trying to=
 accommodate?<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; qemu versions 4.2 and before allowed this behavi=
or.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 So? That might just mean we had a bug and we fixed it=
.<br>
&gt;=C2=A0 &gt;=C2=A0 4.2 is a very old version of QEMU and nobody seems to=
 have<br>
&gt;=C2=A0 &gt;=C2=A0 complained in the four years since we released 5.0 ab=
out this,<br>
&gt;=C2=A0 &gt;=C2=A0 which suggests that generally guest OS drivers don&#3=
9;t try<br>
&gt;=C2=A0 &gt;=C2=A0 to send zero-length buffers in this way.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; I don&#39;t think it&#39;s valid to ask for a *p=
opular* guest OS as a proof-of-concept because I&#39;m not an expert on tho=
se.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 I didn&#39;t ask for &quot;popular&quot;; I asked for=
 &quot;real-world&quot;.<br>
&gt;=C2=A0 &gt;=C2=A0 What is the actual guest code you&#39;re running that=
 falls over<br>
&gt;=C2=A0 &gt;=C2=A0 because of the behaviour change?<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 More generally, why do you want this behaviour to be<=
br>
&gt;=C2=A0 &gt;=C2=A0 changed? Reasonable reasons might include:<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* we&#39;re out of spec based on reading the do=
cumentation<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* you&#39;re trying to run some old Windows VM/=
QNX/etc image,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and it doesn&#39;t work any more<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* all the real hardware we tested behaves this =
way<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 But don&#39;t necessarily include:<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* something somebody wrote and only tested on Q=
EMU happens to<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0assume the old behaviour rather than fol=
lowing the hw spec<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 QEMU occasionally works around guest OS bugs, but onl=
y as<br>
&gt;=C2=A0 &gt;=C2=A0 when we really have to. It&#39;s usually better to fi=
x the<br>
&gt;=C2=A0 &gt;=C2=A0 bug in the guest.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; It&#39;s not, and I&#39;ve already demonstrated that real h=
ardware is consistent with the fix in this patch.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Please check your tone.<br>
&gt;<br>
&gt;=C2=A0 I don&#39;t think that is a particularly helpful comment for som=
eone who is<br>
&gt;=C2=A0 taking the time to review your patches. Reading through the thre=
ad I<br>
&gt;=C2=A0 didn&#39;t see anything that said this is how real HW behaves bu=
t I may well<br>
&gt;=C2=A0 have missed it. However you have a number of review comments to =
address<br>
&gt;=C2=A0 so I suggest you spin a v2 of the series to address them and out=
line the<br>
&gt;=C2=A0 reason to accept an out of spec transaction.<br>
&gt;<br>
&gt; I did a rework of the patch -- see my email from May 20, quoted below =
-- and I was under the impression it addressed all the<br>
&gt; review comments. Did I miss something? I apologize if I did.<br>
<br>
Ahh I see - I&#39;d only seen this thread continue so wasn&#39;t aware a ne=
w<br>
version had been posted. For future patches consider using -vN when<br>
sending them so we can clearly see a new revision is available.<br>
<br>
&gt;<br>
&gt;&gt; index acd6016980..71b54914d3 100644<br>
&gt;&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt;&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt;&gt; @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, st=
ruct ohci_ed *ed)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((td.cbp &amp; 0xfffff000) !=
=3D (<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a=
> &amp; 0xfffff000)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (<a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xff=
f) + 0x1001 - (td.cbp &amp; 0xfff);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb=
_ohci_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"norefer=
rer" target=3D"_blank">td.be</a>);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp - 1 &gt; <a =
href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {=C2=
=A0 /* rely on td.cbp !=3D 0 */<br>
&gt;<br>
&gt;&gt; Reading through the thread I didn&#39;t see anything that said thi=
s is how real HW behaves but I may well have missed it.<br>
&gt;<br>
&gt; This is what I wrote regarding real HW:<br>
&gt;<br>
&gt; Results are:<br>
&gt;<br>
&gt;=C2=A0 qemu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>
&gt; ------------+------------+------------<br>
&gt;=C2=A0 works fine | ohci_die() | works fine<br>
&gt;<br>
&gt; Would additional verification of the actual HW be useful?<br>
&gt;<br>
&gt; Peter posted the following which is more specific than &quot;qemu 4.2&=
quot; -- I agree this is most likely the qemu commit where this<br>
&gt; thread is focused:<br>
&gt;<br>
&gt;&gt; Almost certainly this was commit 1328fe0c32d54 (&quot;hw: usb: hcd=
-ohci:<br>
&gt;&gt; check len and frame_number variables&quot;), which added these bou=
nds<br>
&gt;&gt; checks. Prior to that we did no bounds checking at all, which<br>
&gt;&gt; meant that we permitted cbp=3Dbe+1 to mean a zero length, but also=
<br>
&gt;&gt; that we permitted the guest to overrun host-side buffers by<br>
&gt;&gt; specifying completely bogus cbp and be values. The timeframe is<br=
>
&gt;&gt; more or less right (2020), at least.<br>
&gt;&gt; <br>
&gt;&gt; -- PMM<br>
&gt;<br>
&gt; Where does the conversation go from here? I&#39;m under the impression=
 I have provided objective answers to all the questions<br>
&gt; and resolved all review comments on the code. I receive the feedback<b=
r>
&gt; that I missed something - please restate the question?<br>
<br>
I can see patch 1/2 has been queued and 2/2 is still outstanding. I&#39;m<b=
r>
having trouble finding the referenced entry in the OHCI spec. The only<br>
one I can see is Release 1.1, January 6th, 2000 and that doesn&#39;t have a=
<br>
section 4.3.1.2.<br>
<br>
I think discussion should continue on that thread.<br></blockquote><div><br=
></div><div>Yes, agreed.</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--00000000000063f4620619b2503a--

