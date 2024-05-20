Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF55C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 22:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9BQk-0002i1-Ck; Mon, 20 May 2024 18:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9BQi-0002hF-7l
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:24:28 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9BQg-0005oR-09
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:24:27 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-47f02dfe3adso582373137.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716243865; x=1716848665; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UPTVTrOPBvvm4CM4IZOIdY1u2/mEWm0Rmcn93QmtjVo=;
 b=agXnzxaXrhb7Nhfis3mTxbtzIp16X5J9NAkX2xj2wBIkfybITLRYhhEQls3zB8TWuu
 6rNa59R5eRsS4SqT9viJVwjQHp1mo5ZeDvOvMms5iAzVN/2MUf4Ios9L0WBafX/WLQsu
 rG44jJLstbnVjJfTG+rLS9AFwZnwqbZrvgEyVp2WWs8jn7gHqqRdoUkhXuLjsy/lECJN
 3FGYWJMLG7wi3KaqQbnKVf3NYMPlP15Dr2IjgModapK5tLjCYghQxfBz4gkvHyUmhDfO
 +P40iBoC2iTUUAKxIxRT6z5jKXTjFY+7mNaDUk222/HVVdiYaaerPUNYcxhM1kOKpLd0
 b9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716243865; x=1716848665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPTVTrOPBvvm4CM4IZOIdY1u2/mEWm0Rmcn93QmtjVo=;
 b=Q9ovh/H3QbmYLTUw7IcleWBlujXS9FlIbqSzsGAw8LEVcM2SSE9jD/oF9QSqKrspAZ
 XzZKtUq0Cn7X3Vo+u+SW1Kvhu6F2jgeFjM1qhMY29fpS55VW8QrFq4ZJLOy2C1JdKA+e
 f0DVRFQvpPgM2T2noYWDGwzaxLAnAAxzvCtc7Fb7BpiWHU30cK7iQX/lWQCyOwJ7GK8T
 +4jXQOhcXcRu3Fk+x9OfDWsXwAF+hkCRgOGuhYSDuddWkR4uW/vy0wgxXfBl+BfmOpkK
 k2GyWQz1NXA+c9EF+xCxSfp+OQMD8bBITa9jdR61MoxR3df5pKHkvZus28mvfG16Pwab
 TRXg==
X-Gm-Message-State: AOJu0Yyz52DR09xXiKu2th2Oc3ZUNF/p+VJ67S10G4mNiB2fokpXogzJ
 sUoYqTApIPWu6yhhOgE1jOBgNm1cqLb6/kA0zXy4XonMJfmcoxeb9Lzv5tU6TiFgzuSsidV0ltO
 T4kFB0U+TEz1XTJibMBZVxMCcc1A=
X-Google-Smtp-Source: AGHT+IGHUgCKiUY2StvbMcsc8i3VhbWt7PHMYiCED3kRifzguSEfz++rJDGvly1ouioolBou9V/OwkUXYaX6r1KaWjE=
X-Received: by 2002:a05:6102:c86:b0:478:980a:ac5a with SMTP id
 ada2fe7eead31-48077e5ba0cmr31280122137.33.1716243864941; Mon, 20 May 2024
 15:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Mon, 20 May 2024 17:24:14 -0500
Message-ID: <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000eafd1c0618ea29f9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000eafd1c0618ea29f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Tue, 6 Feb 2024 at 13:25, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >
> > This changes the ohci validation to not assert if invalid
> > data is fed to the ohci controller. The poc suggested in
> > https://bugs.launchpad.net/qemu/+bug/1907042
> > and then migrated to bug #303 does the following to
> > feed it a SETUP pid and EndPt of 1:
> >
> >         uint32_t MaxPacket =3D 64;
> >         uint32_t TDFormat =3D 0;
> >         uint32_t Skip =3D 0;
> >         uint32_t Speed =3D 0;
> >         uint32_t Direction =3D 0;  /* #define OHCI_TD_DIR_SETUP 0 */
> >         uint32_t EndPt =3D 1;
> >         uint32_t FuncAddress =3D 0;
> >         ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14=
)
> >                    | (Speed << 13) | (Direction << 11) | (EndPt << 7)
> >                    | FuncAddress;
> >         ed->tailp =3D /*TDQTailPntr=3D */ 0;
> >         ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfffffff0)
> >                    | (/* ToggleCarry=3D */ 0 << 1);
> >         ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
> >
> > qemu-fuzz also caught the same issue in #1510. They are
> > both fixed by this patch.
> >
> > The if (td.cbp > td.be) logic in ohci_service_td() causes an
> > ohci_die(). My understanding of the OHCI spec 4.3.1.2
> > Table 4-2 allows td.cbp to be one byte more than td.be to
> > signal the buffer has zero length. The new check in qemu
> > appears to have been added since qemu-4.2. This patch
> > includes both fixes since they are located very close
> > together.
>
> For the "zero length buffer" case, do you have a more detailed
> pointer to the bit of the spec that says that "cbp =3D be + 1" is a
> valid way to specify a zero length buffer? Table 4-2 in the copy I
> have says for CurrentBufferPointer "a value of 0 indicates
> a zero-length data packet or that all bytes have been transferred",
> and the sample host OS driver function QueueGeneralRequest()
> later in the spec handles a 0 length packet by setting
>   TD->HcTD.CBP =3D TD->HcTD.BE =3D 0;
> (which our emulation's code does handle).
>

Reading the spec carefully, a CBP set to 0 should always mean the
zero-length buffer case (or that all bytes have been transferred, so the
buffer is now zero-length - the same thing).

Table 4-2 is the correct reference, and this part is clear. It's the part
you quoted. "Contains the physical address of the next memory location that
will be accessed for transfer to/from the endpoint. A value of 0 indicates
a zero-length data packet or that all bytes have been transferred."

Table 4-2 has this additional nugget that may be confusingly worded, for
BufferEnd: "Contains physical address of the last byte in the buffer for
this TD"

As you say, QueueGeneralRequest() handles a 0 length packet by setting CBP
=3D BE =3D 0.

There's a little bit more right below Table 4-2 in section 4.3.1.3.1:

"The CurrentBufferPointer value in the General TD is the address of the
data buffer that will be used for a data packet transfer to/from the
endpoint addressed by the ED. When the transfer is completed without an
error of any kind, the Host Controller advances the value of
CurrentBufferPointer by the number of bytes transferred"

I'll put it in the context of an example buffer of length 8. Perhaps this
is the easiest answer about Table 4-2's BufferEnd definition...

char buf[8];
char * CurrentBufferPointer =3D &buf[0];
char * BufferEnd =3D &buf[7]; // "address of the last byte in the buffer"
// The OHCI Host Controller than advances CurrentBufferPointer like this:
CurrentBufferPointer +=3D 8
// After the transfer:
// CurrentBufferPointer =3D &buf[8];
// BufferEnd =3D &buf[7];

And here's an example buffer of length 0 -- you probably already know what
I'm going to do here:

char buf[0];
char * CurrentBufferPointer =3D &buf[0];
char * BufferEnd =3D &buf[-1]; // "address of the last byte in the buffer"
// The OHCI Host Controller than advances CurrentBufferPointer like this:
CurrentBufferPointer +=3D 0
// After the transfer:
// CurrentBufferPointer =3D &buf[0];
// BufferEnd =3D &buf[-1];


> > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> > ohci_ed *ed)
> >          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >          } else {
> > -            if (td.cbp > td.be) {
> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +            if (td.cbp > td.be + 1) {
>
> I think this has an overflow if td.be is 0xffffffff.
>

Opps, yes. I will submit a revised patch. Since this change is protected
inside a condition if (td.cbp && td.be) I plan to rewrite it as:

if (td.cbp - 1 > td.be) { // rely on td.cbp !=3D 0


>
> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
> >                  ohci_die(ohci);
> >                  return 1;
> >              }
>
> (On the other hand having looked at the code I'm happy
> now that having a len of 0 passed into usb_packet_addbuf()
> is OK because we already do that for the "cbp =3D be =3D 0"
> way of specifying a zero length packet.)


I came to the same conclusion. The zero length packet is already being
passed into usb_packet_addbuf(), so this change should be ok.

--000000000000eafd1c0618ea29f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 20, 2024 at 12:05=E2=80=
=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, 6 Feb 2024 at 13:25, Cord Amfmgm &lt;<a href=3D"ma=
ilto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt; This changes the ohci validation to not assert if invalid<br>
&gt; data is fed to the ohci controller. The poc suggested in<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1907042" rel=3D"norefe=
rrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1907042</a><br=
>
&gt; and then migrated to bug #303 does the following to<br>
&gt; feed it a SETUP pid and EndPt of 1:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t MaxPacket =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t TDFormat =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Skip =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Speed =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Direction =3D 0;=C2=A0 /* #d=
efine OHCI_TD_DIR_SETUP 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t EndPt =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t FuncAddress =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;attr =3D (MaxPacket &lt;&lt; 1=
6) | (TDFormat &lt;&lt; 15) | (Skip &lt;&lt; 14)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 (Speed &lt;&lt; 13) | (Direction &lt;&lt; 11) | (EndPt &lt;&lt; 7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 FuncAddress;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;tailp =3D /*TDQTailPntr=3D */ =
0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;headp =3D ((/*TDQHeadPntr=3D *=
/ &amp;td[0]) &amp; 0xfffffff0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 (/* ToggleCarry=3D */ 0 &lt;&lt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;next_ed =3D (/* NextED=3D */ 0=
 &amp; 0xfffffff0)<br>
&gt;<br>
&gt; qemu-fuzz also caught the same issue in #1510. They are<br>
&gt; both fixed by this patch.<br>
&gt;<br>
&gt; The if (td.cbp &gt; <a href=3D"http://td.be" rel=3D"noreferrer" target=
=3D"_blank">td.be</a>) logic in ohci_service_td() causes an<br>
&gt; ohci_die(). My understanding of the OHCI spec 4.3.1.2<br>
&gt; Table 4-2 allows td.cbp to be one byte more than <a href=3D"http://td.=
be" rel=3D"noreferrer" target=3D"_blank">td.be</a> to<br>
&gt; signal the buffer has zero length. The new check in qemu<br>
&gt; appears to have been added since qemu-4.2. This patch<br>
&gt; includes both fixes since they are located very close<br>
&gt; together.<br>
<br>
For the &quot;zero length buffer&quot; case, do you have a more detailed<br=
>
pointer to the bit of the spec that says that &quot;cbp =3D be + 1&quot; is=
 a<br>
valid way to specify a zero length buffer? Table 4-2 in the copy I<br>
have says for CurrentBufferPointer &quot;a value of 0 indicates<br>
a zero-length data packet or that all bytes have been transferred&quot;,<br=
>
and the sample host OS driver function QueueGeneralRequest()<br>
later in the spec handles a 0 length packet by setting<br>
=C2=A0 TD-&gt;HcTD.CBP =3D TD-&gt;HcTD.BE =3D 0;<br>
(which our emulation&#39;s code does handle).<br></blockquote><div><br></di=
v><div>Reading the spec carefully, a CBP=C2=A0set to 0 should always mean t=
he zero-length buffer case (or that all bytes have been transferred, so the=
 buffer is now zero-length - the same thing).</div><div><br></div><div>Tabl=
e 4-2 is the correct reference, and this part is clear. It&#39;s the part y=
ou quoted. &quot;Contains the physical address of the next memory location =
that will be accessed for transfer to/from the endpoint. A value of 0 indic=
ates a zero-length data packet or that all bytes have been transferred.&quo=
t;</div><div><br></div><div>Table 4-2 has this additional nugget that may b=
e confusingly worded, for BufferEnd: &quot;Contains physical address of the=
 last byte in the buffer for this TD&quot;</div><div><br></div><div>As you =
say, QueueGeneralRequest() handles a 0 length packet by setting CBP =3D BE =
=3D 0.</div><div><br></div><div>There&#39;s a little bit more right below T=
able 4-2 in section 4.3.1.3.1:</div><div><br></div><div>&quot;The CurrentBu=
fferPointer value in the General TD is the address of the data buffer that =
will be used for a data packet transfer to/from the endpoint addressed by t=
he ED. When the transfer is completed without an error of any kind, the Hos=
t Controller advances the value of CurrentBufferPointer by the number of by=
tes transferred&quot;</div><div><br></div><div>I&#39;ll put it in the conte=
xt of an example buffer of length 8. Perhaps this is the easiest answer abo=
ut Table 4-2&#39;s BufferEnd definition...</div><div><br></div><div>char bu=
f[8];</div><div>char * CurrentBufferPointer =3D &amp;buf[0];</div><div>char=
 * BufferEnd =3D &amp;buf[7]; // &quot;address of the last byte in the buff=
er&quot;</div><div>// The OHCI Host Controller than advances CurrentBufferP=
ointer like this: CurrentBufferPointer=C2=A0<a class=3D"gmail_plusreply" id=
=3D"plusReplyChip-0">+=3D 8</a></div><div>// After the transfer:</div><div>=
// CurrentBufferPointer =3D &amp;buf[8];</div><div>// BufferEnd =3D &amp;bu=
f[7];</div><div><br></div><div>And here&#39;s an example buffer of length 0=
 -- you probably already know what I&#39;m going to do here:</div><div><br>=
</div><div><div>char buf[0];</div><div>char * CurrentBufferPointer =3D &amp=
;buf[0];</div><div>char * BufferEnd =3D &amp;buf[-1]; // &quot;address of t=
he last byte in the buffer&quot;</div><div>// The OHCI Host Controller than=
 advances CurrentBufferPointer like this: CurrentBufferPointer=C2=A0<a clas=
s=3D"gmail_plusreply" id=3D"gmail-plusReplyChip-0">+=3D 0</a></div><div>// =
After the transfer:</div><div>// CurrentBufferPointer =3D &amp;buf[0];</div=
><div>// BufferEnd =3D &amp;buf[-1];</div><div><br></div></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct=
<br>
&gt; ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((td.cbp &amp; 0xfffff000) !=3D (=
<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &am=
p; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (<a href=3D"ht=
tp://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xfff) + 0=
x1001 - (td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> + 1) {<br>
<br>
I think this has an overflow if <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a> is 0xffffffff.<br></blockquote><div><br></div>=
<div>Opps, yes. I will submit a revised patch. Since this change is protect=
ed inside a condition=C2=A0if (td.cbp &amp;&amp; <a href=3D"http://td.be">t=
d.be</a>) I plan to rewrite it as:</div><div><br></div><div>if (td.cbp - 1 =
&gt; <a href=3D"http://td.be">td.be</a>) { // rely on td.cbp !=3D 0</div><d=
iv>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_td_bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"=
_blank">td.be</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die=
(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
(On the other hand having looked at the code I&#39;m happy<br>
now that having a len of 0 passed into usb_packet_addbuf()<br>
is OK because we already do that for the &quot;cbp =3D be =3D 0&quot;<br>
way of specifying a zero length packet.)</blockquote><div><br></div><div>I =
came to the same conclusion. The zero length packet is already being passed=
 into usb_packet_addbuf(), so this change should be ok.</div><div><br></div=
></div></div>

--000000000000eafd1c0618ea29f9--

