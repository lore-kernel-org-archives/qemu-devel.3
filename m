Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE61FC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR11s-0004eJ-Cw; Mon, 08 Jul 2024 22:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR11m-0004Kd-By
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:56:27 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR11j-0005iM-10
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:56:26 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7036f1f3434so784394a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720493781; x=1721098581;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yi0n/PHdJ0kvMphSOdL8PQEXo54lYGMgSY38D8RP3YE=;
 b=glbq+9al8vfOdfpf1Jp77T56KsAsbKhHhTs4lUWNwbP48Zi/ok6sN6j0frato/Vdel
 zkWJxUr3QJGEMWYHMrGwjm9FLVCLvgu90HkNakuvuq1mLqUYxLL9w4hlHYELagdXrxgG
 rk9FtxAn6TLn+L6Nz3xcEeyoXe+lfMzjfIKHTgS0NVxpwIBXzIbjSLPXdvyZH3d5SUGx
 FQnx+Ve/Qp2yfRtmu8MWPS8AuosZS6cAmtFzdxCc1mNDS8hPDANm0swwjEcgZieIE5RQ
 bIoR7hMmG47MHyn3Uuk4uNNeQpsayv4qlg6vVXoIEfAaJWS+HbrHGegEcRgmAicVLU3A
 ooGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493781; x=1721098581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yi0n/PHdJ0kvMphSOdL8PQEXo54lYGMgSY38D8RP3YE=;
 b=r4C7Ib5unts605fWlf1U4CGlwHNWqD1bD4thlyr3yjfYX+2yO1PGKsD59P6r2trtaE
 eDjEX7Dvo+BQbbtHU9PkF+L5S48RnAwoNOgjnv6q2qjpt0t7I4kD/NsnxHrhKDKGQqgv
 wNTuTmI0kUU/b7ItmoQEZk5Db4v4poED2OSiFv6P9e8d5vkeHyIWH7hGvxoCV8qwyrQ2
 2pH6ElEehGaiFfnpQ552NzaEGEwZlI05fe8UvqzZSttsWKK0eKI5kx19tE7WwQORaKMa
 416TBSKTi06y6ma5lywdIhY1OcLVW0h9iz9M/RNuh6zi40jm6aitZHvd5t9UUtxU7sBR
 AAOw==
X-Gm-Message-State: AOJu0YyToCEE9qRJ7i6aV5kvA0VcGGd+S1nekNsMx/jWEsaMwBD1aBjZ
 8nGWKf8weEdz5NeGo/TpyOtIpp+iKun4dE7qJrXeZ5cJvZTTymLPRSLshCJYd+LtpKyfnvtrNcw
 mGwKHBSFvYOU4mK2c+uT3NWuW3Hll1O17xiev59UydSlXul93IXu0SQ==
X-Google-Smtp-Source: AGHT+IGynVSQsK9HeqhWNGaFS6q7ZfWCViVAblZbOgIPSORONi6+73PPAbqfvRvGKj15sAEQXZ1jjKbtoIo7xmkr2DA=
X-Received: by 2002:a05:6871:24ca:b0:25e:1610:96fa with SMTP id
 586e51a60fabf-25eae9dcf6amr913879fac.25.1720493780022; Mon, 08 Jul 2024
 19:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
In-Reply-To: <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 9 Jul 2024 10:56:04 +0800
Message-ID: <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000098d5e3061cc7ac4a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x329.google.com
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

--00000000000098d5e3061cc7ac4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smartx.com>=
 wrote:
> >
> >
> >
> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >>
> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smartx.=
com>
> wrote:
> >> >
> >> > Unexpected work by certain Windows guests equipped with the e1000
> >> > interface can cause the network to go down and never come back up
> >> > again unless the guest's interface is reset.
> >> >
> >> > To reproduce the failure:
> >> > 1. Set up two guests with a Windows 2016 or 2019 server operating
> >> >    system.
> >>
> >> I vaguely remember e1000 support for Windows has been deprecated for
> >> several years...
> >>
> >> That's why e1000e or igb is implemented in Qemu.
> >>
> >> > 2. Set up the e1000 interface for the guests.
> >> > 3. Pressurize the network slightly between two guests using the iPer=
f
> tool.
> >> >
> >> > The network goes down after a few days (2-5days), and the issue
> >> > is the result of not adhering to the e1000 specification. Refer
> >> > to the details of the specification at the following link:
> >> >
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
> >> >
> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
> >> > as following:
> >> > This register holds a value that is an offset from the base, and
> >> > identifies the location beyond the last descriptor hardware can
> >> > process. Note that tail should still point to an area in the
> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> >> > This is because tail points to the location where software writes
> >> > the first new descriptor.
> >> >
> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=80=94h=
as not yet
> >> > loaded the packet,
> >>
> >> What do you mean by "load" here?
> >
> >
> > Sorry for failing to describe the details.
> >
> > The guest driver retrieves the packet from the receive ring buffer
> > after QEMU forwards it from the tun/tap interface in the e1000
> > emulation.
> >
> > I used "load" to express "putting packets into the receive ring buffer.=
"
> >
> >>
> >>
> >> > RDT should never point to that place.
> >>
> >> And "that place"?
> >
> > If a descriptor in the receive ring buffer has not been filled with a
> > packet address by QEMU, the descriptor therefore doesn't have any
> > available packets. The location of the descriptor should not be referre=
d
> > to by RDT because the location is in the range that "hardware" handles.
> >
> > "that place" means the location of the descriptor in the ring buffer
> > that QEMU hasn't set any available packets related to.
> >
> >>
> >>
> >> > When
> >> > implementing the emulation of the e1000 interface, QEMU evaluates
> >> > if the receive ring buffer is full once the RDT equals the RDH,
> >> > based on the assumption that guest drivers adhere to this
> >> > criterion strictly.
> >> >
> >> > We applied the following log patch to assist in analyzing the
> >> > issue and eventually obtained the unexpected information.
> >> >
> >> > Log patch:
> >> > -----------------------------------------------------------------
> >> > |--- a/hw/net/e1000.c
> >> > |+++ b/hw/net/e1000.c
> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
> >> > | {
> >> > |     int bufs;
> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> >> > |+
> >> > |     /* Fast-path short packets */
> >> > |     if (total_size <=3D s->rxbuf_size) {
> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_over=
run)
> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const
> struct iovec *iov, int iovcnt)
> >> > |         s->rxbuf_min_shift)
> >> > |         n |=3D E1000_ICS_RXDMT0;
> >> > |
> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> >> > |+
> >> > -----------------------------------------------------------------
> >> >
> >> > The last few logs of information when the network is down:
> >> >
> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D =
16384,
> s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> >> > <- the receive ring buffer is checked for fullness in the
> >> > e1000_has_rxbufs function, not full.
> >> >
> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
> >> > utilized after putting the packet to ring buffer.
> >> >
> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D =
16384,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> > <- the receive ring buffer is checked for fullness in the
> >> > e1000_has_rxbufs function, not full.
> >> >
> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
> >> > utilized after putting the packet to ring buffer.
> >> >
> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D =
16384,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> > <- the receive ring buffer is checked for fullness in the
> >> > e1000_has_rxbufs function, not full.
> >> >
> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> >> > utilized after putting the packet to ring buffer.
> >> >
> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D =
16384,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> >> > <- The ring is full, according to e1000_has_rxbufs, because
> >> > of the RDT update to 900 and equals RDH !
> >>
> >> Just to make sure I understand this, RDT=3D=3DRDH means the ring is em=
pty I
> think?
> >>
> >>
> >> See commit:
> >>
> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
> >> Author: Dmitry Fleytman <dmitry@daynix.com>
> >> Date:   Fri Oct 19 07:56:55 2012 +0200
> >>
> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RDT a=
s
> empty
> >>
> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
> >>     Emulation is supposed to behave the same.
> >
> >
> > Indeed, I'm confused :(,  the description in the comment claims that RX
> > rings with RDH =3D=3D RDT as empty, but in implementation, it treats th=
at as
> > overrun.
> >
> > See the following 2 contexts:
> >
> > 1. e1000_can_receive:
> > static bool e1000_can_receive(NetClientState *nc)
> > {
> >     E1000State *s =3D qemu_get_nic_opaque(nc);
> >     // e1000_has_rxbufs return true means ring buffer has
> >     // available descriptors to use for QEMU.
> >     // false means ring buffer overrun and QEMU should queue the packet
> >     // and wait for the RDT update and available descriptors can be use=
d.
> >
> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
> >         e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_queue_timer);
> > }
>
> Well we had in e1000_has_rx_bufs
>
>     if (total_size <=3D s->rxbuf_size) {
>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
>     }
>
> RDT!=3DRDH means RX ring has available descriptors for hardware?
>

IMHO, Yes.


> Adding more people.
>
> Thanks
>
>

--=20
Best regards

--00000000000098d5e3061cc7ac4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 202=
4 at 10:41=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com"=
>jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Mon, Jul 8=
, 2024 at 1:17=E2=80=AFPM Yong Huang &lt;<a href=3D"mailto:yong.huang@smart=
x.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang &lt;<a href=3D"mail=
to:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang &lt;<a href=3D"=
mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Unexpected work by certain Windows guests equipped with the e=
1000<br>
&gt;&gt; &gt; interface can cause the network to go down and never come bac=
k up<br>
&gt;&gt; &gt; again unless the guest&#39;s interface is reset.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; To reproduce the failure:<br>
&gt;&gt; &gt; 1. Set up two guests with a Windows 2016 or 2019 server opera=
ting<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 system.<br>
&gt;&gt;<br>
&gt;&gt; I vaguely remember e1000 support for Windows has been deprecated f=
or<br>
&gt;&gt; several years...<br>
&gt;&gt;<br>
&gt;&gt; That&#39;s why e1000e or igb is implemented in Qemu.<br>
&gt;&gt;<br>
&gt;&gt; &gt; 2. Set up the e1000 interface for the guests.<br>
&gt;&gt; &gt; 3. Pressurize the network slightly between two guests using t=
he iPerf tool.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The network goes down after a few days (2-5days), and the iss=
ue<br>
&gt;&gt; &gt; is the result of not adhering to the e1000 specification. Ref=
er<br>
&gt;&gt; &gt; to the details of the specification at the following link:<br=
>
&gt;&gt; &gt; <a href=3D"https://www.intel.com/content/dam/doc/manual/pci-p=
ci-x-family-gbe-controllers-software-dev-manual.pdf" rel=3D"noreferrer" tar=
get=3D"_blank">https://www.intel.com/content/dam/doc/manual/pci-pci-x-famil=
y-gbe-controllers-software-dev-manual.pdf</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Chapter 3.2.6 describe the Receive Descriptor Tail register(R=
DT)<br>
&gt;&gt; &gt; as following:<br>
&gt;&gt; &gt; This register holds a value that is an offset from the base, =
and<br>
&gt;&gt; &gt; identifies the location beyond the last descriptor hardware c=
an<br>
&gt;&gt; &gt; process. Note that tail should still point to an area in the<=
br>
&gt;&gt; &gt; descriptor ring (somewhere between RDBA and RDBA + RDLEN).<br=
>
&gt;&gt; &gt; This is because tail points to the location where software wr=
ites<br>
&gt;&gt; &gt; the first new descriptor.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This means that if the provider=E2=80=94in this case, QEMU=E2=
=80=94has not yet<br>
&gt;&gt; &gt; loaded the packet,<br>
&gt;&gt;<br>
&gt;&gt; What do you mean by &quot;load&quot; here?<br>
&gt;<br>
&gt;<br>
&gt; Sorry for failing to describe the details.<br>
&gt;<br>
&gt; The guest driver retrieves the packet from the receive ring buffer<br>
&gt; after QEMU forwards it from the tun/tap interface in the e1000<br>
&gt; emulation.<br>
&gt;<br>
&gt; I used &quot;load&quot; to express &quot;putting packets into the rece=
ive ring buffer.&quot;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; RDT should never point to that place.<br>
&gt;&gt;<br>
&gt;&gt; And &quot;that place&quot;?<br>
&gt;<br>
&gt; If a descriptor in the receive ring buffer has not been filled with a<=
br>
&gt; packet address by QEMU, the descriptor therefore doesn&#39;t have any<=
br>
&gt; available packets. The location of the descriptor should not be referr=
ed<br>
&gt; to by RDT because the location is in the range that &quot;hardware&quo=
t; handles.<br>
&gt;<br>
&gt; &quot;that place&quot; means the location of the descriptor in the rin=
g buffer<br>
&gt; that QEMU hasn&#39;t set any available packets related to.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; When<br>
&gt;&gt; &gt; implementing the emulation of the e1000 interface, QEMU evalu=
ates<br>
&gt;&gt; &gt; if the receive ring buffer is full once the RDT equals the RD=
H,<br>
&gt;&gt; &gt; based on the assumption that guest drivers adhere to this<br>
&gt;&gt; &gt; criterion strictly.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We applied the following log patch to assist in analyzing the=
<br>
&gt;&gt; &gt; issue and eventually obtained the unexpected information.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Log patch:<br>
&gt;&gt; &gt; -------------------------------------------------------------=
----<br>
&gt;&gt; &gt; |--- a/hw/net/e1000.c<br>
&gt;&gt; &gt; |+++ b/hw/net/e1000.c<br>
&gt;&gt; &gt; |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc=
)<br>
&gt;&gt; &gt; | static bool e1000_has_rxbufs(E1000State *s, size_t total_si=
ze)<br>
&gt;&gt; &gt; | {<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0int bufs;<br>
&gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac=
_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&=
quot;,<br>
&gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, =
s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt; |+<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0/* Fast-path short packets */<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_size)=
 {<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[RDH] =3D=
=3D s-&gt;mac_reg[RDT] &amp;&amp; s-&gt;last_overrun)<br>
&gt;&gt; &gt; |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, =
const struct iovec *iov, int iovcnt)<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_min_shift)<br>
&gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n |=3D E1000_ICS_RXDMT0;<b=
r>
&gt;&gt; &gt; |<br>
&gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac=
_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&=
quot;,<br>
&gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, =
s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt; |+<br>
&gt;&gt; &gt; -------------------------------------------------------------=
----<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The last few logs of information when the network is down:<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[R=
DLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 897, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullness in the<=
br>
&gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[=
RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br=
>
&gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 898, and 1 descripto=
r<br>
&gt;&gt; &gt; utilized after putting the packet to ring buffer.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[R=
DLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullness in the<=
br>
&gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[=
RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br=
>
&gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 899, and 1 descripto=
r<br>
&gt;&gt; &gt; utilized after putting the packet to ring buffer.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[R=
DLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt; &lt;- the receive ring buffer is checked for fullness in the<=
br>
&gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[=
RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 885<br=
>
&gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 900 , and 1 descript=
or<br>
&gt;&gt; &gt; utilized after putting the packet to ring buffer.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[R=
DLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 900<br>
&gt;&gt; &gt; &lt;- The ring is full, according to e1000_has_rxbufs, becaus=
e<br>
&gt;&gt; &gt; of the RDT update to 900 and equals RDH !<br>
&gt;&gt;<br>
&gt;&gt; Just to make sure I understand this, RDT=3D=3DRDH means the ring i=
s empty I think?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; See commit:<br>
&gt;&gt;<br>
&gt;&gt; commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a<br>
&gt;&gt; Author: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@daynix.com" t=
arget=3D"_blank">dmitry@daynix.com</a>&gt;<br>
&gt;&gt; Date:=C2=A0 =C2=A0Fri Oct 19 07:56:55 2012 +0200<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0e1000: drop check_rxov, always treat RX ring wi=
th RDH =3D=3D RDT as empty<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Real HW always treats RX ring with RDH =3D=3D R=
DT as empty.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Emulation is supposed to behave the same.<br>
&gt;<br>
&gt;<br>
&gt; Indeed, I&#39;m confused :(,=C2=A0 the description in the comment clai=
ms that RX<br>
&gt; rings with RDH =3D=3D RDT as empty, but in implementation, it treats t=
hat as<br>
&gt; overrun.<br>
&gt;<br>
&gt; See the following 2 contexts:<br>
&gt;<br>
&gt; 1. e1000_can_receive:<br>
&gt; static bool e1000_can_receive(NetClientState *nc)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0E1000State *s =3D qemu_get_nic_opaque(nc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0// e1000_has_rxbufs return true means ring buffer h=
as<br>
&gt;=C2=A0 =C2=A0 =C2=A0// available descriptors to use for QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0// false means ring buffer overrun and QEMU should =
queue the packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0// and wait for the RDT update and available descri=
ptors can be used.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return e1000x_rx_ready(&amp;s-&gt;parent_obj, s-&gt=
;mac_reg) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000_has_rxbufs(s, 1) &amp;&amp; !ti=
mer_pending(s-&gt;flush_queue_timer);<br>
&gt; }<br>
<br>
Well we had in e1000_has_rx_bufs<br>
<br>
=C2=A0 =C2=A0 if (total_size &lt;=3D s-&gt;rxbuf_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;mac_reg[RDH] !=3D s-&gt;mac_reg[RD=
T];<br>
=C2=A0 =C2=A0 }<br>
<br>
RDT!=3DRDH means RX ring has available descriptors for hardware?<br></block=
quote><div><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">IMHO, Yes.</div><div style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">
<br>
Adding more people.<br>
<br>
Thanks<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000098d5e3061cc7ac4a--

