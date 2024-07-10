Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD1C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRTGK-0000EI-Ut; Wed, 10 Jul 2024 05:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sRTG1-0000Bx-C0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:05:03 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sRTFw-00057E-JT
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:05:01 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso3411596eaf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720602294; x=1721207094;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cW4b/vNdoqI8fmPg4MKcTIZMlyXB6F7LyV8uCKIiUUk=;
 b=QDn95+E8UoDmY2l5qzBSrCZVgk62nR4vQ/xp08LS+We+HqNRU1G2JpMj/3r5wWl56T
 sAzdFk3js6kG2zWyBGDo6oAX7EwmS4UejvVbAqPwA7bzDRYiu8Ef5YQrBwvB9Gzo71y7
 Ogh+az90d/K5D1YJoA5pGNE6CU8zXwx1pz1AEB3KrYyYVdnlZgZMWgV+WtfiiTjRdBUj
 3P3MjVFHjVHwkhsW82p/fg05GZO51VMdTHWf1C+vnyPddgk5GzpKuzHqMr2toLg5ikXE
 qj2nE2/5M7pBSqnX3tAoKJlZ6ed1o5Ura0IQsyst9q1tFsAFryKwfphcaBfJ4wmYBEVy
 8xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720602294; x=1721207094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cW4b/vNdoqI8fmPg4MKcTIZMlyXB6F7LyV8uCKIiUUk=;
 b=IMYME2EVtQl3XCYUY1ffdrwW7DGGW1B3x/L340dXZJPdeSZVVTSmJW09ky6SHAt539
 BszALrR47116ouWeYVrU1/h0UOr1fhhpDu3daLKAKdtuMJcqThkLSf0bF2URN6RuJBEX
 B3YvD7jHgOwZ3Mi+4tVmKWPrOznUSnNAEDAZX8tc/bldla9THK2SyCtJsUBDzK5sCFq6
 FK/Awp+xN0F1WpUOZjPlQsZLGYzDG3woq+nVtN6zHv4lWkVsHljm4ZiGmP/sPHh0SlhO
 Bmm+npez23grmqpsrz5M67yShhFtmm7+ACv2CRVVQcqXTHcd3QA5Fm6qNm3IR2ZlJXTl
 Hhjg==
X-Gm-Message-State: AOJu0YyvAeeiIuXI3/6UaQFr/tGNgKbBhIDQbZ1z0UxeN/tU3lIkjxHT
 9u2l1YhPVhGVw17ySzs34vokXq6Y9q0j7+iA6RwtvrGrVdU1lvn4hvZR5dMKn3nA4yNqkA1t9dh
 HEisTcfRPYYJZjfr+IQU2C4PAWoCxtwSvifw1sQ==
X-Google-Smtp-Source: AGHT+IElMFrJJ0mm6Q1yTFrWxw5GDJrOfwVXNzzyRJzBG3H8nkGIiBL/z+7ssdWKQ13P70c7aTUkNWWu7xuHNFvfAeg=
X-Received: by 2002:a05:6870:8a23:b0:259:8b4e:e71a with SMTP id
 586e51a60fabf-25eaebdfb5bmr4144100fac.46.1720602293641; Wed, 10 Jul 2024
 02:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
 <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
 <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
 <CAK9dgmaEs56fj4F_Bz+bBJNmoK4tXHd9WbmtHeeJj-Mu+kYtNQ@mail.gmail.com>
 <CACGkMEuuxSehLH8+1_P_CERwVm_C33FQXVjHpvBmy+uakP7uVA@mail.gmail.com>
In-Reply-To: <CACGkMEuuxSehLH8+1_P_CERwVm_C33FQXVjHpvBmy+uakP7uVA@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 10 Jul 2024 17:04:37 +0800
Message-ID: <CAK9dgmY2MVR8+LMG-skmdgiKGrzDMriDrEV_oYwY4kBqcp91kQ@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000083419a061ce0f07e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2e.google.com
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

--00000000000083419a061ce0f07e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:36=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang <yong.huang@smartx.com=
> wrote:
> >
> >
> >
> > On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>
> >> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@smartx.=
com>
> wrote:
> >> >
> >> >
> >> >
> >> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat.=
com>
> wrote:
> >> >>
> >> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smart=
x.com>
> wrote:
> >> >> >
> >> >> >
> >> >> >
> >> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redh=
at.com>
> wrote:
> >> >> >>
> >> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@s=
martx.com>
> wrote:
> >> >> >> >
> >> >> >> > Unexpected work by certain Windows guests equipped with the
> e1000
> >> >> >> > interface can cause the network to go down and never come back
> up
> >> >> >> > again unless the guest's interface is reset.
> >> >> >> >
> >> >> >> > To reproduce the failure:
> >> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server
> operating
> >> >> >> >    system.
> >> >> >>
> >> >> >> I vaguely remember e1000 support for Windows has been deprecated
> for
> >> >> >> several years...
> >> >> >>
> >> >> >> That's why e1000e or igb is implemented in Qemu.
> >> >> >>
> >> >> >> > 2. Set up the e1000 interface for the guests.
> >> >> >> > 3. Pressurize the network slightly between two guests using th=
e
> iPerf tool.
> >> >> >> >
> >> >> >> > The network goes down after a few days (2-5days), and the issu=
e
> >> >> >> > is the result of not adhering to the e1000 specification. Refe=
r
> >> >> >> > to the details of the specification at the following link:
> >> >> >> >
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
> >> >> >> >
> >> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RD=
T)
> >> >> >> > as following:
> >> >> >> > This register holds a value that is an offset from the base, a=
nd
> >> >> >> > identifies the location beyond the last descriptor hardware ca=
n
> >> >> >> > process. Note that tail should still point to an area in the
> >> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> >> >> >> > This is because tail points to the location where software
> writes
> >> >> >> > the first new descriptor.
> >> >> >> >
> >> >> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=
=80=94has not yet
> >> >> >> > loaded the packet,
> >> >> >>
> >> >> >> What do you mean by "load" here?
> >> >> >
> >> >> >
> >> >> > Sorry for failing to describe the details.
> >> >> >
> >> >> > The guest driver retrieves the packet from the receive ring buffe=
r
> >> >> > after QEMU forwards it from the tun/tap interface in the e1000
> >> >> > emulation.
> >> >> >
> >> >> > I used "load" to express "putting packets into the receive ring
> buffer."
> >> >> >
> >> >> >>
> >> >> >>
> >> >> >> > RDT should never point to that place.
> >> >> >>
> >> >> >> And "that place"?
> >> >> >
> >> >> > If a descriptor in the receive ring buffer has not been filled
> with a
> >> >> > packet address by QEMU, the descriptor therefore doesn't have any
> >> >> > available packets. The location of the descriptor should not be
> referred
> >> >> > to by RDT because the location is in the range that "hardware"
> handles.
> >> >> >
> >> >> > "that place" means the location of the descriptor in the ring
> buffer
> >> >> > that QEMU hasn't set any available packets related to.
> >> >> >
> >> >> >>
> >> >> >>
> >> >> >> > When
> >> >> >> > implementing the emulation of the e1000 interface, QEMU
> evaluates
> >> >> >> > if the receive ring buffer is full once the RDT equals the RDH=
,
> >> >> >> > based on the assumption that guest drivers adhere to this
> >> >> >> > criterion strictly.
> >> >> >> >
> >> >> >> > We applied the following log patch to assist in analyzing the
> >> >> >> > issue and eventually obtained the unexpected information.
> >> >> >> >
> >> >> >> > Log patch:
> >> >> >> >
> -----------------------------------------------------------------
> >> >> >> > |--- a/hw/net/e1000.c
> >> >> >> > |+++ b/hw/net/e1000.c
> >> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> >> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_siz=
e)
> >> >> >> > | {
> >> >> >> > |     int bufs;
> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH]=
,
> s->mac_reg[RDT]);
> >> >> >> > |+
> >> >> >> > |     /* Fast-path short packets */
> >> >> >> > |     if (total_size <=3D s->rxbuf_size) {
> >> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] &&
> s->last_overrun)
> >> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc,
> const struct iovec *iov, int iovcnt)
> >> >> >> > |         s->rxbuf_min_shift)
> >> >> >> > |         n |=3D E1000_ICS_RXDMT0;
> >> >> >> > |
> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u,
> s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH]=
,
> s->mac_reg[RDT]);
> >> >> >> > |+
> >> >> >> >
> -----------------------------------------------------------------
> >> >> >> >
> >> >> >> > The last few logs of information when the network is down:
> >> >> >> >
> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN=
] =3D
> 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> >> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D
> 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> >> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN=
] =3D
> 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> >> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D
> 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> >> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN=
] =3D
> 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> >> >> >> > <- the receive ring buffer is checked for fullness in the
> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D
> 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> >> >> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >
> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN=
] =3D
> 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> >> >> >> > <- The ring is full, according to e1000_has_rxbufs, because
> >> >> >> > of the RDT update to 900 and equals RDH !
> >> >> >>
> >> >> >> Just to make sure I understand this, RDT=3D=3DRDH means the ring=
 is
> empty I think?
> >> >> >>
> >> >> >>
> >> >> >> See commit:
> >> >> >>
> >> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
> >> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
> >> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
> >> >> >>
> >> >> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D=
 RDT
> as empty
> >> >> >>
> >> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
> >> >> >>     Emulation is supposed to behave the same.
> >> >> >
> >> >> >
> >> >> > Indeed, I'm confused :(,  the description in the comment claims
> that RX
> >> >> > rings with RDH =3D=3D RDT as empty, but in implementation, it tre=
ats
> that as
> >> >> > overrun.
> >> >> >
> >> >> > See the following 2 contexts:
> >> >> >
> >> >> > 1. e1000_can_receive:
> >> >> > static bool e1000_can_receive(NetClientState *nc)
> >> >> > {
> >> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
> >> >> >     // e1000_has_rxbufs return true means ring buffer has
> >> >> >     // available descriptors to use for QEMU.
> >> >> >     // false means ring buffer overrun and QEMU should queue the
> packet
> >> >> >     // and wait for the RDT update and available descriptors can
> be used.
> >> >> >
> >> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
> >> >> >         e1000_has_rxbufs(s, 1) &&
> !timer_pending(s->flush_queue_timer);
> >> >> > }
> >> >>
> >> >> Well we had in e1000_has_rx_bufs
> >> >>
> >> >>     if (total_size <=3D s->rxbuf_size) {
> >> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
> >> >>     }
> >> >>
> >> >> RDT!=3DRDH means RX ring has available descriptors for hardware?
> >> >
> >> >
> >> > IMHO, Yes.
> >>
> >> Just to make sure we are on the same page, so
> >>
> >> RDT!=3DRDH, descriptors available for hardware
> >> RDT=3D=3DRDH, descriptor ring is empty for hardware
> >>
> >>
> >> That is currently what the code did. Seems nothing wrong, or anything
> >> I missed here?
> >
> >
> > There are two cases for RDT =3D=3D RDH.
> >
> > 1. Hardware has filled all available descriptors and overrun.
> >    In this case, hardware cannot add any new packets to the ring.
> >
> > 2. Software has consumed all descriptors, and all the descriptors
> >     on the ring can be used by hardware. (Let's name this case "empty."=
)
> >    In this case, hardware should keep putting new packets to the ring
>
> Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DRDH,
> nothing is owned by hardware. And this is what Dmitry said in the
> commit mentioned above.
>

Yes, this is the main cause of network interruptions. Hardware should
never touch the location of the descriptor that RDT points to. This is
what the specification declares. IMHO, it also implies that the descriptor
referred to by the RDT has available packets.

In our case, hardware has not added any new packets to the descriptor,
and the expected behavior is that software never updates the RDT to
the location of that descriptor. But now, it does.

If hardware and software both work as expected under the e1000
specification, the issue does not exist. I have no objection that the root
cause is the Windows driver bug in e1000, and I'm not insisting that
QEMU should take the responsibility for fixing that.


>
> Which version of the driver did you use in the guest? (Or have you
> tried to download the one from Intel website) I'm asking since e1000
> support has been deprecated by Microsoft for years.
>

I use Windows Server 2019 and the driver version is 8.4.13.0.

Since Microsoft no longer supports e1000, as you already mentioned,
this patch merely offers a workaround. Since some users still use
e1000 in production environments, it doesn't seem to have any side
effects.

It would be really appreciated if the patch was given some thought.

Thanks,
Yong


>
> Thanks
>
> >
> > But at the moment, the logic of e1000_has_rx_bufs acts exactly like it
> was
> > the first case, unable to differentiate between the two scenarios.
> >
> >>
> >>
> >> Thanks
> >>
> >> >
> >> >>
> >> >> Adding more people.
> >> >>
> >> >> Thanks
> >> >>
> >> >
> >> >
> >> > --
> >> > Best regards
> >>
> >
> > Yong
> >
> > --
> > Best regards
>
>

--=20
Best regards

--00000000000083419a061ce0f07e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 10, 20=
24 at 3:36=E2=80=AFPM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com"=
>jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Jul 1=
0, 2024 at 2:26=E2=80=AFPM Yong Huang &lt;<a href=3D"mailto:yong.huang@smar=
tx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang &lt;<a href=3D"mai=
lto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang &lt;<a href=3D"=
mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang &lt;<a hre=
f=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&=
gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang &lt;<a =
href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang &=
lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat=
.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Unexpected work by certain Windows guests e=
quipped with the e1000<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; interface can cause the network to go down =
and never come back up<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; again unless the guest&#39;s interface is r=
eset.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; To reproduce the failure:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 1. Set up two guests with a Windows 2016 or=
 2019 server operating<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 system.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; I vaguely remember e1000 support for Windows has=
 been deprecated for<br>
&gt;&gt; &gt;&gt; &gt;&gt; several years...<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; That&#39;s why e1000e or igb is implemented in Q=
emu.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 2. Set up the e1000 interface for the guest=
s.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 3. Pressurize the network slightly between =
two guests using the iPerf tool.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; The network goes down after a few days (2-5=
days), and the issue<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; is the result of not adhering to the e1000 =
specification. Refer<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; to the details of the specification at the =
following link:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; <a href=3D"https://www.intel.com/content/da=
m/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf" rel=
=3D"noreferrer" target=3D"_blank">https://www.intel.com/content/dam/doc/man=
ual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf</a><br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Chapter 3.2.6 describe the Receive Descript=
or Tail register(RDT)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; as following:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; This register holds a value that is an offs=
et from the base, and<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; identifies the location beyond the last des=
criptor hardware can<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; process. Note that tail should still point =
to an area in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; descriptor ring (somewhere between RDBA and=
 RDBA + RDLEN).<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; This is because tail points to the location=
 where software writes<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; the first new descriptor.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; This means that if the provider=E2=80=94in =
this case, QEMU=E2=80=94has not yet<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; loaded the packet,<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; What do you mean by &quot;load&quot; here?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Sorry for failing to describe the details.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The guest driver retrieves the packet from the recei=
ve ring buffer<br>
&gt;&gt; &gt;&gt; &gt; after QEMU forwards it from the tun/tap interface in=
 the e1000<br>
&gt;&gt; &gt;&gt; &gt; emulation.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; I used &quot;load&quot; to express &quot;putting pac=
kets into the receive ring buffer.&quot;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; RDT should never point to that place.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; And &quot;that place&quot;?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; If a descriptor in the receive ring buffer has not b=
een filled with a<br>
&gt;&gt; &gt;&gt; &gt; packet address by QEMU, the descriptor therefore doe=
sn&#39;t have any<br>
&gt;&gt; &gt;&gt; &gt; available packets. The location of the descriptor sh=
ould not be referred<br>
&gt;&gt; &gt;&gt; &gt; to by RDT because the location is in the range that =
&quot;hardware&quot; handles.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &quot;that place&quot; means the location of the des=
criptor in the ring buffer<br>
&gt;&gt; &gt;&gt; &gt; that QEMU hasn&#39;t set any available packets relat=
ed to.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; When<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; implementing the emulation of the e1000 int=
erface, QEMU evaluates<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; if the receive ring buffer is full once the=
 RDT equals the RDH,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; based on the assumption that guest drivers =
adhere to this<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; criterion strictly.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; We applied the following log patch to assis=
t in analyzing the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; issue and eventually obtained the unexpecte=
d information.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Log patch:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; -------------------------------------------=
----------------------<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |--- a/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+++ b/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |@@ -836,6 +836,9 @@ e1000_set_link_status(=
NetClientState *nc)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; | static bool e1000_has_rxbufs(E1000State *=
s, size_t total_size)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; | {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0int bufs;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size=
 =3D %u, s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_=
reg[RDT] =3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s-&gt;rxbuf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[R=
DT]);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0/* Fast-path short pac=
kets */<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D=
 s-&gt;rxbuf_size) {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;mac_reg[RDH] =3D=3D s-&gt;mac_reg[RDT] &amp;&amp; s-&gt;last_overrun)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |@@ -1022,6 +1025,9 @@ e1000_receive_iov(Ne=
tClientState *nc, const struct iovec *iov, int iovcnt)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx=
buf_min_shift)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n |=3D E=
1000_ICS_RXDMT0;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size=
 =3D %u, s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_=
reg[RDT] =3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s-&gt;rxbuf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[R=
DT]);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; -------------------------------------------=
----------------------<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; The last few logs of information when the n=
etwork is down:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 204=
8, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 897, s-&gt;mac_re=
g[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked fo=
r fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 20=
48, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_r=
eg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 89=
8, and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring b=
uffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 204=
8, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_re=
g[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked fo=
r fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 20=
48, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_r=
eg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 89=
9, and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring b=
uffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 204=
8, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_re=
g[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring buffer is checked fo=
r fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64, rxbuf_size =3D 20=
48, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_r=
eg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same, RDH updates to 90=
0 , and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting the packet to ring b=
uffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, rxbuf_size =3D 204=
8, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_re=
g[RDT] =3D 900<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- The ring is full, according to e1000_=
has_rxbufs, because<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; of the RDT update to 900 and equals RDH !<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Just to make sure I understand this, RDT=3D=3DRD=
H means the ring is empty I think?<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; See commit:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a<=
br>
&gt;&gt; &gt;&gt; &gt;&gt; Author: Dmitry Fleytman &lt;<a href=3D"mailto:dm=
itry@daynix.com" target=3D"_blank">dmitry@daynix.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Date:=C2=A0 =C2=A0Fri Oct 19 07:56:55 2012 +0200=
<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0e1000: drop check_rxov, alway=
s treat RX ring with RDH =3D=3D RDT as empty<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Real HW always treats RX ring=
 with RDH =3D=3D RDT as empty.<br>
&gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Emulation is supposed to beha=
ve the same.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Indeed, I&#39;m confused :(,=C2=A0 the description i=
n the comment claims that RX<br>
&gt;&gt; &gt;&gt; &gt; rings with RDH =3D=3D RDT as empty, but in implement=
ation, it treats that as<br>
&gt;&gt; &gt;&gt; &gt; overrun.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; See the following 2 contexts:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 1. e1000_can_receive:<br>
&gt;&gt; &gt;&gt; &gt; static bool e1000_can_receive(NetClientState *nc)<br=
>
&gt;&gt; &gt;&gt; &gt; {<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0E1000State *s =3D qemu_get_nic_op=
aque(nc);<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// e1000_has_rxbufs return true m=
eans ring buffer has<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// available descriptors to use f=
or QEMU.<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// false means ring buffer overru=
n and QEMU should queue the packet<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// and wait for the RDT update an=
d available descriptors can be used.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0return e1000x_rx_ready(&amp;s-&gt=
;parent_obj, s-&gt;mac_reg) &amp;&amp;<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000_has_rxbufs(s,=
 1) &amp;&amp; !timer_pending(s-&gt;flush_queue_timer);<br>
&gt;&gt; &gt;&gt; &gt; }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Well we had in e1000_has_rx_bufs<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_siz=
e) {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;mac_reg[RDH=
] !=3D s-&gt;mac_reg[RDT];<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; RDT!=3DRDH means RX ring has available descriptors for ha=
rdware?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; IMHO, Yes.<br>
&gt;&gt;<br>
&gt;&gt; Just to make sure we are on the same page, so<br>
&gt;&gt;<br>
&gt;&gt; RDT!=3DRDH, descriptors available for hardware<br>
&gt;&gt; RDT=3D=3DRDH, descriptor ring is empty for hardware<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; That is currently what the code did. Seems nothing wrong, or anyth=
ing<br>
&gt;&gt; I missed here?<br>
&gt;<br>
&gt;<br>
&gt; There are two cases for RDT =3D=3D RDH.<br>
&gt;<br>
&gt; 1. Hardware has filled all available descriptors and overrun.<br>
&gt;=C2=A0 =C2=A0 In this case, hardware cannot add any new packets to the =
ring.<br>
&gt;<br>
&gt; 2. Software has consumed all descriptors, and all the descriptors<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the ring can be used by hardware. (Let&#39;s nam=
e this case &quot;empty.&quot;)<br>
&gt;=C2=A0 =C2=A0 In this case, hardware should keep putting new packets to=
 the ring<br>
<br>
Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DRDH,<br>
nothing is owned by hardware. And this is what Dmitry said in the<br>
commit mentioned above.<br></blockquote><div><br></div><div><div class=3D"g=
mail_default"><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms,=
 sans-serif">Yes, this is the main cause of network interruptions. Hardware=
 should</font></span></div><div class=3D"gmail_default"><span style=3D"colo=
r:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">never touch the loca=
tion of the descriptor that RDT points to. This is</font></span></div><div =
class=3D"gmail_default"><span style=3D"color:rgb(0,0,0)"><font face=3D"comi=
c sans ms, sans-serif">what the specification declares. IMHO, it also impli=
es that the descriptor</font></span></div><div class=3D"gmail_default"><spa=
n style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">refer=
red to by the RDT has available packets.</font></span><div class=3D"gmail_d=
efault" style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif"=
>=C2=A0</font></div><div class=3D"gmail_default" style=3D"color:rgb(0,0,0)"=
><font face=3D"comic sans ms, sans-serif">In our case, hardware has not add=
ed any new packets to the descriptor,</font></div><div class=3D"gmail_defau=
lt" style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">and=
 the expected behavior is that software never updates the RDT to</font></di=
v><div class=3D"gmail_default" style=3D"color:rgb(0,0,0)"><font face=3D"com=
ic sans ms, sans-serif">the location of that descriptor. But now, it does.<=
span class=3D"gmail-Apple-converted-space">=C2=A0</span></font></div><div c=
lass=3D"gmail_default" style=3D"color:rgb(0,0,0)"><font face=3D"comic sans =
ms, sans-serif">=C2=A0</font></div><div class=3D"gmail_default" style=3D"co=
lor:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">If hardware and so=
ftware both work as expected under the e1000</font></div><div class=3D"gmai=
l_default" style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-ser=
if">specification, the issue does not exist. I have no objection that the r=
oot</font></div><div class=3D"gmail_default" style=3D"color:rgb(0,0,0)"><fo=
nt face=3D"comic sans ms, sans-serif">cause is the Windows driver bug in e1=
000, and I&#39;m not insisting that</font></div><div class=3D"gmail_default=
" style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">QEMU =
should take the responsibility for fixing that.</font></div></div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt"><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=A0</span><br=
></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(2=
04,204,204);padding-left:1ex">
<br>
Which version of the driver did you use in the guest? (Or have you<br>
tried to download the one from Intel website) I&#39;m asking since e1000<br=
>
support has been deprecated by Microsoft for years.<br></blockquote><div><b=
r></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
" class=3D"gmail_default">I use Windows Server 2019 and the driver version =
is 8.4.13.0.=C2=A0</div></div><div style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Since Mic=
rosoft no longer supports e1000, as you already mentioned,</div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">this patch merely offers a workaround. Since some users still use</div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default">e1000 in production environments, it doesn&#39;t seem to have a=
ny side</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
" class=3D"gmail_default">effects.<br><br>It would be really appreciated if=
 the patch was given some thought.<br></div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defa=
ult">Thanks,</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif" class=3D"gmail_default">Yong</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
<br>
&gt;<br>
&gt; But at the moment, the logic of e1000_has_rx_bufs acts exactly like it=
 was<br>
&gt; the first case, unable to differentiate between the two scenarios.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Adding more people.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Best regards<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; --<br>
&gt; Best regards<br>
<br>
</blockquote></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default"><br></div></div><div><br></div><span c=
lass=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gma=
il_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Bes=
t regards</font></div></div></div>

--00000000000083419a061ce0f07e--

