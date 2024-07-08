Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA163C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgkp-0000iD-So; Mon, 08 Jul 2024 01:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQgkn-0000hb-Hg
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:17:33 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQgkk-0001QI-1x
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:17:33 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25e24900a82so1977151fac.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720415844; x=1721020644;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hYU6Ezi+RQGxoXLwHHQ+rOxM2scJghg6+JA4TjSTHF4=;
 b=ZYunbyd1f9CoK1K43dlNS/jQ0RMLrszqgJ1kfrWDk1ENOhoxKdXrUblQiwK0rb2oSI
 AsjQ68cdXdjS7ZZdYHhCEOnA8zWq1JmE5UwSb8rr+Jzjgk8txDqRFmKmpqdoxG1uubO6
 /3l8nk4++nwQbLJy328LAMS0SGg828rqdBj94Un22rzYTL+mxWBbW4lVQKo67ap7gyD+
 5UqZUaEmRlGaS8YYZNYWBd/7isCGQlxb8aUe8LleOSJzq1/gbbhSbjaZiGy0csCNdgwx
 zQ/H6UYGTslUjxC/r48TD/u4N/xRcbzjUmdLGWtWQZtQtdtD8aob/aLnajWykJ0ACkBh
 i+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720415844; x=1721020644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYU6Ezi+RQGxoXLwHHQ+rOxM2scJghg6+JA4TjSTHF4=;
 b=ThpFSvk7v5c0mriJKoCYGA1RTbln73GGi46gQbw7AZqM2nUH+hzVGL7HHpAQaBxUvn
 qQc50Fo7r2IAH2XMAy+yGpvNTv2OTgppBhC+N8FBUlMVwtE1F+x2edTCWNORRfRz/Qh7
 Li4vZg8TSD8jb1z1QWRl23IA2RImaPRB8QTakzy3Slg2H4xlgGgF4IUZmwUjIHRFRzWo
 g5EEikNgvYisw7xvKGjjqOatcrojIDvs0gQgVwOa8R593Y6vHN8my69hBzxPy15OyAvG
 DUoPkhUvGiu6oOLj4WwLqCwjS9ozpHaot191XEwHuggkq+n8ATkJ/jWSOCj1TMvh8dwe
 MAMQ==
X-Gm-Message-State: AOJu0YyZM67OFN7cwhO+1o2m26REJHsGoEBT+H0Nm5o0TZt6vMgatFSh
 Fxrd1nR5ru2qodZlEVtS5QqidMbP5a8Sdyuh9CLi7KT2WhE92MZM9vkuZI0YOrWcs83Z99W2mxM
 eOltc9jN2CTVoom+G/jOWO9O5m9vK56EVzs7s3A==
X-Google-Smtp-Source: AGHT+IGAHqvWLrSXy4rlSpHVUb2pnILjE/TZvAskqYVQpH3hM5A7unsa3Z51ijw/k3pI+ZEph9v+Bt7/YWWNNb/BQz8=
X-Received: by 2002:a05:6871:24d5:b0:25e:65f:a530 with SMTP id
 586e51a60fabf-25e2bea6836mr8839090fac.41.1720415843267; Sun, 07 Jul 2024
 22:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
In-Reply-To: <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 8 Jul 2024 13:17:07 +0800
Message-ID: <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000345123061cb58738"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000345123061cb58738
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smartx.com=
> wrote:
> >
> > Unexpected work by certain Windows guests equipped with the e1000
> > interface can cause the network to go down and never come back up
> > again unless the guest's interface is reset.
> >
> > To reproduce the failure:
> > 1. Set up two guests with a Windows 2016 or 2019 server operating
> >    system.
>
> I vaguely remember e1000 support for Windows has been deprecated for
> several years...
>
> That's why e1000e or igb is implemented in Qemu.
>
> > 2. Set up the e1000 interface for the guests.
> > 3. Pressurize the network slightly between two guests using the iPerf
> tool.
> >
> > The network goes down after a few days (2-5days), and the issue
> > is the result of not adhering to the e1000 specification. Refer
> > to the details of the specification at the following link:
> >
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
> >
> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
> > as following:
> > This register holds a value that is an offset from the base, and
> > identifies the location beyond the last descriptor hardware can
> > process. Note that tail should still point to an area in the
> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> > This is because tail points to the location where software writes
> > the first new descriptor.
> >
> > This means that if the provider=E2=80=94in this case, QEMU=E2=80=94has =
not yet
> > loaded the packet,
>
> What do you mean by "load" here?
>

Sorry for failing to describe the details.

The guest driver retrieves the packet from the receive ring buffer
after QEMU forwards it from the tun/tap interface in the e1000
emulation.

I used "load" to express "putting packets into the receive ring buffer."


>
> > RDT should never point to that place.
>
> And "that place"?
>
If a descriptor in the receive ring buffer has not been filled with a
packet address by QEMU, the descriptor therefore doesn't have any
available packets. The location of the descriptor should not be referred
to by RDT because the location is in the range that "hardware" handles.

"that place" means the location of the descriptor in the ring buffer
that QEMU hasn't set any available packets related to.


>
> > When
> > implementing the emulation of the e1000 interface, QEMU evaluates
> > if the receive ring buffer is full once the RDT equals the RDH,
> > based on the assumption that guest drivers adhere to this
> > criterion strictly.
> >
> > We applied the following log patch to assist in analyzing the
> > issue and eventually obtained the unexpected information.
> >
> > Log patch:
> > -----------------------------------------------------------------
> > |--- a/hw/net/e1000.c
> > |+++ b/hw/net/e1000.c
> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
> > | {
> > |     int bufs;
> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> > |+
> > |     /* Fast-path short packets */
> > |     if (total_size <=3D s->rxbuf_size) {
> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_overrun=
)
> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const
> struct iovec *iov, int iovcnt)
> > |         s->rxbuf_min_shift)
> > |         n |=3D E1000_ICS_RXDMT0;
> > |
> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> > |+
> > -----------------------------------------------------------------
> >
> > The last few logs of information when the network is down:
> >
> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 163=
84,
> s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> > <- the receive ring buffer is checked for fullness in the
> > e1000_has_rxbufs function, not full.
> >
> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16=
384,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
> > utilized after putting the packet to ring buffer.
> >
> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 163=
84,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> > <- the receive ring buffer is checked for fullness in the
> > e1000_has_rxbufs function, not full.
> >
> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16=
384,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
> > utilized after putting the packet to ring buffer.
> >
> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 163=
84,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> > <- the receive ring buffer is checked for fullness in the
> > e1000_has_rxbufs function, not full.
> >
> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16=
384,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> > utilized after putting the packet to ring buffer.
> >
> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 163=
84,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> > <- The ring is full, according to e1000_has_rxbufs, because
> > of the RDT update to 900 and equals RDH !
>
> Just to make sure I understand this, RDT=3D=3DRDH means the ring is empty=
 I
> think?


> See commit:
>
> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
> Author: Dmitry Fleytman <dmitry@daynix.com>
> Date:   Fri Oct 19 07:56:55 2012 +0200
>
>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RDT as e=
mpty
>
>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
>     Emulation is supposed to behave the same.
>

Indeed, I'm confused :(,  the description in the comment claims that RX
rings with RDH =3D=3D RDT as empty, but in implementation, it treats that a=
s
overrun.

See the following 2 contexts:

1. e1000_can_receive:
static bool e1000_can_receive(NetClientState *nc)
{
    E1000State *s =3D qemu_get_nic_opaque(nc);
    // e1000_has_rxbufs return true means ring buffer has
    // available descriptors to use for QEMU.
    // false means ring buffer overrun and QEMU should queue the packet
    // and wait for the RDT update and available descriptors can be used.

    return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
        e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_queue_timer);
}

2. e1000_receive_iov:
    if (!e1000_has_rxbufs(s, total_size)) {
        // e1000_has_rxbufs return false means overrun and QEMU should
        // inject RXO interrupt to guest
        e1000_receiver_overrun(s, total_size);
        return -1;
    }


>
>     Reported-by: Chris Webb <chris.webb@elastichosts.com>
>     Reported-by: Richard Davies <richard.davies@elastichosts.com>
>     Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Or did you mean we need to revert the above commit in fact?
>

Yes, this commit was overlooked by me but it is almost what I want to do
in this patch.


>
> Thanks
>
>
Thanks for the comment,

Yong

--=20
Best regards

--000000000000345123061cb58738
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 8, 202=
4 at 11:21=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com"=
>jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Sat, Jul 6=
, 2024 at 4:30=E2=80=AFAM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smar=
tx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Unexpected work by certain Windows guests equipped with the e1000<br>
&gt; interface can cause the network to go down and never come back up<br>
&gt; again unless the guest&#39;s interface is reset.<br>
&gt;<br>
&gt; To reproduce the failure:<br>
&gt; 1. Set up two guests with a Windows 2016 or 2019 server operating<br>
&gt;=C2=A0 =C2=A0 system.<br>
<br>
I vaguely remember e1000 support for Windows has been deprecated for<br>
several years...<br>
<br>
That&#39;s why e1000e or igb is implemented in Qemu.<br>
<br>
&gt; 2. Set up the e1000 interface for the guests.<br>
&gt; 3. Pressurize the network slightly between two guests using the iPerf =
tool.<br>
&gt;<br>
&gt; The network goes down after a few days (2-5days), and the issue<br>
&gt; is the result of not adhering to the e1000 specification. Refer<br>
&gt; to the details of the specification at the following link:<br>
&gt; <a href=3D"https://www.intel.com/content/dam/doc/manual/pci-pci-x-fami=
ly-gbe-controllers-software-dev-manual.pdf" rel=3D"noreferrer" target=3D"_b=
lank">https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-con=
trollers-software-dev-manual.pdf</a><br>
&gt;<br>
&gt; Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)<br>
&gt; as following:<br>
&gt; This register holds a value that is an offset from the base, and<br>
&gt; identifies the location beyond the last descriptor hardware can<br>
&gt; process. Note that tail should still point to an area in the<br>
&gt; descriptor ring (somewhere between RDBA and RDBA + RDLEN).<br>
&gt; This is because tail points to the location where software writes<br>
&gt; the first new descriptor.<br>
&gt;<br>
&gt; This means that if the provider=E2=80=94in this case, QEMU=E2=80=94has=
 not yet<br>
&gt; loaded the packet,<br>
<br>
What do you mean by &quot;load&quot; here?<br></blockquote><div><br></div><=
div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">Sorry for failing to describe the details.</div><div sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defa=
ult"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if" class=3D"gmail_default">The guest driver retrieves the packet from the =
receive ring buffer</div><div style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif" class=3D"gmail_default">after QEMU forwards it from the tun/t=
ap interface in the e1000</div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default">emulation.<br></div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t"><br></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans=
-serif"><span style=3D"color:rgb(0,0,0)">I used &quot;load&quot; to express=
 &quot;putting packets into the receive ring buffer.&quot;=C2=A0</span></fo=
nt></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; RDT should never point to that place.<br>
<br>
And &quot;that place&quot;?<br></blockquote><div><div style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"></div></div><=
div class=3D"gmail_default"><span style=3D"color:rgb(0,0,0)"><font face=3D"=
comic sans ms, sans-serif">If a descriptor in the receive ring buffer has n=
ot been filled with a</font></span></div><div class=3D"gmail_default"><span=
 style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">packet=
 address by QEMU, the descriptor therefore doesn&#39;t have any</font></spa=
n></div><div class=3D"gmail_default"><span style=3D"color:rgb(0,0,0)"><font=
 face=3D"comic sans ms, sans-serif">available packets. The location of the =
descriptor should not be referred</font></span></div><div class=3D"gmail_de=
fault"><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-s=
erif">to by RDT because the location is in the range that &quot;hardware&qu=
ot; handles.=C2=A0</font></span><br></div><div><br></div><div><div class=3D=
"gmail_default"><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans m=
s, sans-serif">&quot;that place&quot; means the location of the descriptor =
in the ring buffer</font></span></div><div class=3D"gmail_default"><span st=
yle=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">that QEMU=
 hasn&#39;t set any available packets related to.</font></span></div></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; When<br>
&gt; implementing the emulation of the e1000 interface, QEMU evaluates<br>
&gt; if the receive ring buffer is full once the RDT equals the RDH,<br>
&gt; based on the assumption that guest drivers adhere to this<br>
&gt; criterion strictly.<br>
&gt;<br>
&gt; We applied the following log patch to assist in analyzing the<br>
&gt; issue and eventually obtained the unexpected information.<br>
&gt;<br>
&gt; Log patch:<br>
&gt; -----------------------------------------------------------------<br>
&gt; |--- a/hw/net/e1000.c<br>
&gt; |+++ b/hw/net/e1000.c<br>
&gt; |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)<br>
&gt; | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)<br>
&gt; | {<br>
&gt; |=C2=A0 =C2=A0 =C2=A0int bufs;<br>
&gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLE=
N] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br=
>
&gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac=
_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt; |+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0/* Fast-path short packets */<br>
&gt; |=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_size) {<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[RDH] =3D=3D s-&gt=
;mac_reg[RDT] &amp;&amp; s-&gt;last_overrun)<br>
&gt; |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const str=
uct iovec *iov, int iovcnt)<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_min_shift)<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n |=3D E1000_ICS_RXDMT0;<br>
&gt; |<br>
&gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLE=
N] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br=
>
&gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac=
_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt; |+<br>
&gt; -----------------------------------------------------------------<br>
&gt;<br>
&gt; The last few logs of information when the network is down:<br>
&gt;<br>
&gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D=
 16384, s-&gt;mac_reg[RDH] =3D 897, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- the receive ring buffer is checked for fullness in the<br>
&gt; e1000_has_rxbufs function, not full.<br>
&gt;<br>
&gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =
=3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- RDT stays the same, RDH updates to 898, and 1 descriptor<br>
&gt; utilized after putting the packet to ring buffer.<br>
&gt;<br>
&gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D=
 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- the receive ring buffer is checked for fullness in the<br>
&gt; e1000_has_rxbufs function, not full.<br>
&gt;<br>
&gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =
=3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- RDT stays the same, RDH updates to 899, and 1 descriptor<br>
&gt; utilized after putting the packet to ring buffer.<br>
&gt;<br>
&gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D=
 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- the receive ring buffer is checked for fullness in the<br>
&gt; e1000_has_rxbufs function, not full.<br>
&gt;<br>
&gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =
=3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 885<br>
&gt; &lt;- RDT stays the same, RDH updates to 900 , and 1 descriptor<br>
&gt; utilized after putting the packet to ring buffer.<br>
&gt;<br>
&gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D=
 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 900<br>
&gt; &lt;- The ring is full, according to e1000_has_rxbufs, because<br>
&gt; of the RDT update to 900 and equals RDH !<br>
<br>
Just to make sure I understand this, RDT=3D=3DRDH means the ring is empty I=
 think?=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex">
<br>
See commit:<br>
<br>
commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a<br>
Author: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@daynix.com" target=3D"=
_blank">dmitry@daynix.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Fri Oct 19 07:56:55 2012 +0200<br>
<br>
=C2=A0 =C2=A0 e1000: drop check_rxov, always treat RX ring with RDH =3D=3D =
RDT as empty<br>
<br>
=C2=A0 =C2=A0 Real HW always treats RX ring with RDH =3D=3D RDT as empty.<b=
r>
=C2=A0 =C2=A0 Emulation is supposed to behave the same.<br></blockquote><di=
v><br></div><div><div class=3D"gmail_default"><span style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">Indeed, I&#39;m confused :(, =C2=A0the =
description in the commen</span><font face=3D"comic sans ms, sans-serif">t=
=C2=A0claims that RX</font></div><div class=3D"gmail_default"><font face=3D=
"comic sans ms, sans-serif">rings with RDH =3D=3D RDT as=C2=A0</font><span =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">empty, but in im=
plementation, it treats=C2=A0that as</span></div><div class=3D"gmail_defaul=
t"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">overrun=
.</span></div><div class=3D"gmail_default"><span style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmail_defau=
lt"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">See th=
e following 2 contexts:</span></div><div class=3D"gmail_default"><span styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></span></div><di=
v class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">1.=C2=A0=
e1000_can_receive:</font></div><div class=3D"gmail_default"><font face=3D"c=
omic sans ms, sans-serif">static bool e1000_can_receive(NetClientState *nc)=
<br>{<br>=C2=A0 =C2=A0 E1000State *s =3D qemu_get_nic_opaque(nc);<br>=C2=A0=
 =C2=A0 //=C2=A0</font><span style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">e1000_has_rxbufs return true means ring buffer has</span></div=
><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=
=A0 =C2=A0 // available descriptors to use for QEMU.</font></div><div class=
=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 /=
/ false means ring buffer overrun and QEMU should queue the packet</font></=
div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
=C2=A0 =C2=A0 // and wait for the RDT update and available=C2=A0descriptors=
 can be used.</font></div><div class=3D"gmail_default"><font face=3D"comic =
sans ms, sans-serif"><br>=C2=A0 =C2=A0 return e1000x_rx_ready(&amp;s-&gt;pa=
rent_obj, s-&gt;mac_reg) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 e1000_ha=
s_rxbufs(s, 1) &amp;&amp; !timer_pending(s-&gt;flush_queue_timer);<br>}</fo=
nt><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></s=
pan></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmail_default">=
<font face=3D"comic sans ms, sans-serif">2.=C2=A0e1000_receive_iov:</font><=
/div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
=C2=A0 =C2=A0 if (!e1000_has_rxbufs(s, total_size)) {</font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 //=C2=A0</font><span style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">e1000_has_rxbufs return false means overrun and QEMU sho=
uld</span></div><div class=3D"gmail_default"><font face=3D"comic sans ms, s=
ans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 // inject RXO interrupt to guest</fo=
nt><font face=3D"comic sans ms, sans-serif"><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 e1000_receiver_overrun(s, total_size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>=C2=A0 =C2=A0 }</font></div></div><div>=C2=A0<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">
<br>
=C2=A0 =C2=A0 Reported-by: Chris Webb &lt;<a href=3D"mailto:chris.webb@elas=
tichosts.com" target=3D"_blank">chris.webb@elastichosts.com</a>&gt;<br>
=C2=A0 =C2=A0 Reported-by: Richard Davies &lt;<a href=3D"mailto:richard.dav=
ies@elastichosts.com" target=3D"_blank">richard.davies@elastichosts.com</a>=
&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@d=
aynix.com" target=3D"_blank">dmitry@daynix.com</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>
<br>
Or did you mean we need to revert the above commit in fact?<br></blockquote=
><div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">Yes, this commit was overlooked by me but=
 it is almost what I want to do</div><div style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif" class=3D"gmail_default">in this patch.</div></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
<br>
</blockquote></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default"><br></div></div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks fo=
r the comment,</div><div style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt"><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic san=
s ms, sans-serif">Best regards</font></div></div></div>

--000000000000345123061cb58738--

