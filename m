Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0D8C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 01:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTthH-0003NR-76; Tue, 16 Jul 2024 21:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sTthC-0003Md-Ry
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:43:06 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sTth8-0002Bd-2X
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:43:06 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25e3d8d9f70so3360947fac.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 18:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1721180458; x=1721785258;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3RH/1iZG0nXnsW4LvMmgC6pWeXjMZJX/QNwU9pa5iHs=;
 b=CoD+2VU6TA6PjIj5ZF2XosFoUUA+0E42zQ7wpJ8uXESlMQpy9x8TMocv49SV6JomJb
 UksL1L4nwbh8RI0KCOORgEQquQvc9GBhD6WbYLG1psu3ZEPf68i2/A3uFNaaQQOkWsp8
 b6eTUW5To8vnUrOVQzbFpQxJGS/Q/OYH7Clo6C/1lhsLwMN44Aez18H+2cIVAYRWcayf
 pxRunfaAOerJs2j62vcPPxafYKhWI4vMqoO+nNihDv3uvz37nWD0+NpGnV3KJcG8e8hm
 OVKNB6F/KXFRBdacnKxXAHAfM4cMvL/lUeLoXs/ZQIV80d8/kJfMJriPCjZouEUEm8L7
 Xd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721180458; x=1721785258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RH/1iZG0nXnsW4LvMmgC6pWeXjMZJX/QNwU9pa5iHs=;
 b=fD4gEWoCL3NOJi0IMnvCo+DihcDrI6ZkVs4y0V4z02+wyP3WOaZqyc7eljcLmNEou9
 YXUS0yTg7jBC9TzDxcAuTEYYyHxqAJyCvP+F0OfyS2Y9yIXgPYcavZqsREmwm9gYYwQH
 8z4ebaBppvdsD9Pu6HVR0QBaZLNYbGh93pvNn1zmNCMcbZ6wzwbNvYLVce53u1FowYU1
 +k48XEt8py+eRqiU45a7ObmOJ4Yb4T2tyN4j/bGIoH03XJiuLyx6kfG/1kluYleFEQYC
 SdH9MLdee3xFYpjqBWdBtkvY+XUKJdhJgd4vaIe2ImIyFBW6bDA/k4qSXRSrIyZ/Zd+l
 G9XQ==
X-Gm-Message-State: AOJu0YyQdxi/3zj1Rt3nijm74EO+NmlWk2XCjJYyReUTCuFb6trfoytA
 l/bAOc1XlnIC2BayJ8+tYFDq9PvG2D8+AJezQWK0tJyiVIzlZaR2qj7LSm+aScXfqxg0Q2OW3g2
 rAwVrO/683Zv+1W5Y0efSy0/odsDZXsM3COosmw==
X-Google-Smtp-Source: AGHT+IHCDEaUfdWA3JF/3moafo1kRAdtQncODrx6+hSC3v4c7b9PRcduisZ0gYlcn+I5JjV5zJ+DoxKWcOF6RkW4Skk=
X-Received: by 2002:a05:6871:442:b0:254:c617:a9a0 with SMTP id
 586e51a60fabf-260d927e182mr132753fac.50.1721180457302; Tue, 16 Jul 2024
 18:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
 <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
 <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
 <CAK9dgmaEs56fj4F_Bz+bBJNmoK4tXHd9WbmtHeeJj-Mu+kYtNQ@mail.gmail.com>
 <CACGkMEuuxSehLH8+1_P_CERwVm_C33FQXVjHpvBmy+uakP7uVA@mail.gmail.com>
 <CAK9dgmY2MVR8+LMG-skmdgiKGrzDMriDrEV_oYwY4kBqcp91kQ@mail.gmail.com>
 <CACGkMEuWjh6Vw_Qp49QM+tB=hH0=g1+2-XiLO+mHOfV5JNTQqQ@mail.gmail.com>
 <CAK9dgmYuq1HsEb70wN6Vsa+sPEsc7KVdKgFkpg9kmcNyigqXMQ@mail.gmail.com>
 <CACGkMEt+7Epkf9ud_44CVqitmt6RBiUc8eNryGXMoiW2H+hx2w@mail.gmail.com>
In-Reply-To: <CACGkMEt+7Epkf9ud_44CVqitmt6RBiUc8eNryGXMoiW2H+hx2w@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 17 Jul 2024 09:40:41 +0800
Message-ID: <CAK9dgmbvnbDjR7yO2JPPFPgLr38Ko2tPTmFOTi=vYT-kQ+iu3g@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000c09fc0061d678d02"
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000c09fc0061d678d02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Wed, Jul 17, 2024 at 9:24=E2=80=AFAM Yong Huang <yong.huang@smartx.com=
> wrote:
> >
> >
> >
> > On Fri, Jul 12, 2024 at 10:01=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>
> >> On Wed, Jul 10, 2024 at 5:05=E2=80=AFPM Yong Huang <yong.huang@smartx.=
com>
> wrote:
> >> >
> >> >
> >> >
> >> > On Wed, Jul 10, 2024 at 3:36=E2=80=AFPM Jason Wang <jasowang@redhat.=
com>
> wrote:
> >> >>
> >> >> On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang <yong.huang@smar=
tx.com>
> wrote:
> >> >> >
> >> >> >
> >> >> >
> >> >> > On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@red=
hat.com>
> wrote:
> >> >> >>
> >> >> >> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@s=
martx.com>
> wrote:
> >> >> >> >
> >> >> >> >
> >> >> >> >
> >> >> >> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com>
> wrote:
> >> >> >> >>
> >> >> >> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <
> yong.huang@smartx.com> wrote:
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <
> jasowang@redhat.com> wrote:
> >> >> >> >> >>
> >> >> >> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <
> yong.huang@smartx.com> wrote:
> >> >> >> >> >> >
> >> >> >> >> >> > Unexpected work by certain Windows guests equipped with
> the e1000
> >> >> >> >> >> > interface can cause the network to go down and never com=
e
> back up
> >> >> >> >> >> > again unless the guest's interface is reset.
> >> >> >> >> >> >
> >> >> >> >> >> > To reproduce the failure:
> >> >> >> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server
> operating
> >> >> >> >> >> >    system.
> >> >> >> >> >>
> >> >> >> >> >> I vaguely remember e1000 support for Windows has been
> deprecated for
> >> >> >> >> >> several years...
> >> >> >> >> >>
> >> >> >> >> >> That's why e1000e or igb is implemented in Qemu.
> >> >> >> >> >>
> >> >> >> >> >> > 2. Set up the e1000 interface for the guests.
> >> >> >> >> >> > 3. Pressurize the network slightly between two guests
> using the iPerf tool.
> >> >> >> >> >> >
> >> >> >> >> >> > The network goes down after a few days (2-5days), and th=
e
> issue
> >> >> >> >> >> > is the result of not adhering to the e1000 specification=
.
> Refer
> >> >> >> >> >> > to the details of the specification at the following lin=
k:
> >> >> >> >> >> >
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
> >> >> >> >> >> >
> >> >> >> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail
> register(RDT)
> >> >> >> >> >> > as following:
> >> >> >> >> >> > This register holds a value that is an offset from the
> base, and
> >> >> >> >> >> > identifies the location beyond the last descriptor
> hardware can
> >> >> >> >> >> > process. Note that tail should still point to an area in
> the
> >> >> >> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN=
).
> >> >> >> >> >> > This is because tail points to the location where
> software writes
> >> >> >> >> >> > the first new descriptor.
> >> >> >> >> >> >
> >> >> >> >> >> > This means that if the provider=E2=80=94in this case, QE=
MU=E2=80=94has
> not yet
> >> >> >> >> >> > loaded the packet,
> >> >> >> >> >>
> >> >> >> >> >> What do you mean by "load" here?
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > Sorry for failing to describe the details.
> >> >> >> >> >
> >> >> >> >> > The guest driver retrieves the packet from the receive ring
> buffer
> >> >> >> >> > after QEMU forwards it from the tun/tap interface in the
> e1000
> >> >> >> >> > emulation.
> >> >> >> >> >
> >> >> >> >> > I used "load" to express "putting packets into the receive
> ring buffer."
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> > RDT should never point to that place.
> >> >> >> >> >>
> >> >> >> >> >> And "that place"?
> >> >> >> >> >
> >> >> >> >> > If a descriptor in the receive ring buffer has not been
> filled with a
> >> >> >> >> > packet address by QEMU, the descriptor therefore doesn't
> have any
> >> >> >> >> > available packets. The location of the descriptor should no=
t
> be referred
> >> >> >> >> > to by RDT because the location is in the range that
> "hardware" handles.
> >> >> >> >> >
> >> >> >> >> > "that place" means the location of the descriptor in the
> ring buffer
> >> >> >> >> > that QEMU hasn't set any available packets related to.
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> > When
> >> >> >> >> >> > implementing the emulation of the e1000 interface, QEMU
> evaluates
> >> >> >> >> >> > if the receive ring buffer is full once the RDT equals
> the RDH,
> >> >> >> >> >> > based on the assumption that guest drivers adhere to thi=
s
> >> >> >> >> >> > criterion strictly.
> >> >> >> >> >> >
> >> >> >> >> >> > We applied the following log patch to assist in analyzin=
g
> the
> >> >> >> >> >> > issue and eventually obtained the unexpected information=
.
> >> >> >> >> >> >
> >> >> >> >> >> > Log patch:
> >> >> >> >> >> >
> -----------------------------------------------------------------
> >> >> >> >> >> > |--- a/hw/net/e1000.c
> >> >> >> >> >> > |+++ b/hw/net/e1000.c
> >> >> >> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientStat=
e
> *nc)
> >> >> >> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t
> total_size)
> >> >> >> >> >> > | {
> >> >> >> >> >> > |     int bufs;
> >> >> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =
=3D
> %u, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN],
> s->mac_reg[RDH], s->mac_reg[RDT]);
> >> >> >> >> >> > |+
> >> >> >> >> >> > |     /* Fast-path short packets */
> >> >> >> >> >> > |     if (total_size <=3D s->rxbuf_size) {
> >> >> >> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] &&
> s->last_overrun)
> >> >> >> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState
> *nc, const struct iovec *iov, int iovcnt)
> >> >> >> >> >> > |         s->rxbuf_min_shift)
> >> >> >> >> >> > |         n |=3D E1000_ICS_RXDMT0;
> >> >> >> >> >> > |
> >> >> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =
=3D
> %u, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> >> >> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN],
> s->mac_reg[RDH], s->mac_reg[RDT]);
> >> >> >> >> >> > |+
> >> >> >> >> >> >
> -----------------------------------------------------------------
> >> >> >> >> >> >
> >> >> >> >> >> > The last few logs of information when the network is dow=
n:
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- the receive ring buffer is checked for fullness in th=
e
> >> >> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- RDT stays the same, RDH updates to 898, and 1
> descriptor
> >> >> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- the receive ring buffer is checked for fullness in th=
e
> >> >> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- RDT stays the same, RDH updates to 899, and 1
> descriptor
> >> >> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- the receive ring buffer is checked for fullness in th=
e
> >> >> >> >> >> > e1000_has_rxbufs function, not full.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D=
 885
> >> >> >> >> >> > <- RDT stays the same, RDH updates to 900 , and 1
> descriptor
> >> >> >> >> >> > utilized after putting the packet to ring buffer.
> >> >> >> >> >> >
> >> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048,
> s->mac_reg[RDLEN] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D=
 900
> >> >> >> >> >> > <- The ring is full, according to e1000_has_rxbufs,
> because
> >> >> >> >> >> > of the RDT update to 900 and equals RDH !
> >> >> >> >> >>
> >> >> >> >> >> Just to make sure I understand this, RDT=3D=3DRDH means th=
e
> ring is empty I think?
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> See commit:
> >> >> >> >> >>
> >> >> >> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
> >> >> >> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
> >> >> >> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
> >> >> >> >> >>
> >> >> >> >> >>     e1000: drop check_rxov, always treat RX ring with RDH
> =3D=3D RDT as empty
> >> >> >> >> >>
> >> >> >> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as e=
mpty.
> >> >> >> >> >>     Emulation is supposed to behave the same.
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > Indeed, I'm confused :(,  the description in the comment
> claims that RX
> >> >> >> >> > rings with RDH =3D=3D RDT as empty, but in implementation, =
it
> treats that as
> >> >> >> >> > overrun.
> >> >> >> >> >
> >> >> >> >> > See the following 2 contexts:
> >> >> >> >> >
> >> >> >> >> > 1. e1000_can_receive:
> >> >> >> >> > static bool e1000_can_receive(NetClientState *nc)
> >> >> >> >> > {
> >> >> >> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
> >> >> >> >> >     // e1000_has_rxbufs return true means ring buffer has
> >> >> >> >> >     // available descriptors to use for QEMU.
> >> >> >> >> >     // false means ring buffer overrun and QEMU should queu=
e
> the packet
> >> >> >> >> >     // and wait for the RDT update and available descriptor=
s
> can be used.
> >> >> >> >> >
> >> >> >> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
> >> >> >> >> >         e1000_has_rxbufs(s, 1) &&
> !timer_pending(s->flush_queue_timer);
> >> >> >> >> > }
> >> >> >> >>
> >> >> >> >> Well we had in e1000_has_rx_bufs
> >> >> >> >>
> >> >> >> >>     if (total_size <=3D s->rxbuf_size) {
> >> >> >> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
> >> >> >> >>     }
> >> >> >> >>
> >> >> >> >> RDT!=3DRDH means RX ring has available descriptors for hardwa=
re?
> >> >> >> >
> >> >> >> >
> >> >> >> > IMHO, Yes.
> >> >> >>
> >> >> >> Just to make sure we are on the same page, so
> >> >> >>
> >> >> >> RDT!=3DRDH, descriptors available for hardware
> >> >> >> RDT=3D=3DRDH, descriptor ring is empty for hardware
> >> >> >>
> >> >> >>
> >> >> >> That is currently what the code did. Seems nothing wrong, or
> anything
> >> >> >> I missed here?
> >> >> >
> >> >> >
> >> >> > There are two cases for RDT =3D=3D RDH.
> >> >> >
> >> >> > 1. Hardware has filled all available descriptors and overrun.
> >> >> >    In this case, hardware cannot add any new packets to the ring.
> >> >> >
> >> >> > 2. Software has consumed all descriptors, and all the descriptors
> >> >> >     on the ring can be used by hardware. (Let's name this case
> "empty.")
> >> >> >    In this case, hardware should keep putting new packets to the
> ring
> >> >>
> >> >> Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DR=
DH,
> >> >> nothing is owned by hardware. And this is what Dmitry said in the
> >> >> commit mentioned above.
> >> >
> >> >
> >> > Yes, this is the main cause of network interruptions. Hardware shoul=
d
> >> > never touch the location of the descriptor that RDT points to. This =
is
> >> > what the specification declares. IMHO, it also implies that the
> descriptor
> >> > referred to by the RDT has available packets.
> >> >
> >> > In our case, hardware has not added any new packets to the descripto=
r,
> >> > and the expected behavior is that software never updates the RDT to
> >> > the location of that descriptor. But now, it does.
> >> >
> >> > If hardware and software both work as expected under the e1000
> >> > specification, the issue does not exist. I have no objection that th=
e
> root
> >> > cause is the Windows driver bug in e1000, and I'm not insisting that
> >> > QEMU should take the responsibility for fixing that.
> >> >
> >> >>
> >> >>
> >> >> Which version of the driver did you use in the guest? (Or have you
> >> >> tried to download the one from Intel website) I'm asking since e100=
0
> >> >> support has been deprecated by Microsoft for years.
> >> >
> >> >
> >> > I use Windows Server 2019 and the driver version is 8.4.13.0.
> >>
> >> Is this the one you download from the Intel website?
> >
> >
> > No, this one is the default driver of Windows Server 2019 if my
> > information is correct.
> >
> >>
> >>
> >> >
> >> > Since Microsoft no longer supports e1000, as you already mentioned,
> >> > this patch merely offers a workaround.
> >>
> >> Is there a chance to switch to use e1000e, it has been actively
> >> maintained and supported.
> >
> >
> > Yes, this is another workaround, we'll try this in the end, thanks for
> > the advice.
> >
> >>
> >>
> >> > Since some users still use
> >> > e1000 in production environments, it doesn't seem to have any side
> >> > effects.
> >>
> >> We need to make sure it matches the hardware behaviour. Otherwise it
> >> might break other operating systems. Looking at the history, we used
> >> to break e1000 on various operating systems: windows, BSD, minix,
> >> windriver ....
> >
> >
> > Yes, I absolutely agree with you. Determining if this patch will affect
> > other operating systems is therefore crucial.
> >
> >>
> >>
> >> >
> >> > It would be really appreciated if the patch was given some thought.
> >>
> >> We would try to evaluate each patch carefully. Qemu is a function
> >> emulator so we need to make sure the function matches hardware
> >> behaviour before it can be merged.
> >
> >
> > Two solutions could be applied:
> >
> > 1. fix the windows driver to ensure that RDT does not point to the
> location
> >   of the descriptors hardware doesn't put any packets into. Let's name
> this
> >   state of descriptor as "invalid".
> >
> > 2. modify the QEMU to handle this case while not breaking other OSes.
> >
> > Since this patch only does a sanity check, it appears to adhere to the
> > second solution, in my opinion.
> >
> > The patch's sole unintended consequence is that it prevents guests from
> > purposefully updating the RDT to link to the "invalid" description.
> >
> > What do you think?
>
> For 1), please try the e1000 driver from Intel (I remember it could be
> downloaded from the Intel website).
> For 2), it would be hard as it needs to be tested with a lot of
> operating systems (or we can have Intel Engineers involved).
>
> And I really suggest you shift to e1000e (or igb) if it is possible.
>

Okay, I get it, I appreciate the review and the recommendation. :)

Thanks

Yong


>
> Thanks
>
> >
> > Yong
> >
> >>
> >> One way is to test via real hardware or involve Intel Engineers.
> >>
> >>
> >> Thanks
> >>
> >> >
> >> > Thanks,
> >> > Yong
> >> >
> >> >>
> >> >>
> >> >> Thanks
> >> >>
> >> >> >
> >> >> > But at the moment, the logic of e1000_has_rx_bufs acts exactly
> like it was
> >> >> > the first case, unable to differentiate between the two scenarios=
.
> >> >> >
> >> >> >>
> >> >> >>
> >> >> >> Thanks
> >> >> >>
> >> >> >> >
> >> >> >> >>
> >> >> >> >> Adding more people.
> >> >> >> >>
> >> >> >> >> Thanks
> >> >> >> >>
> >> >> >> >
> >> >> >> >
> >> >> >> > --
> >> >> >> > Best regards
> >> >> >>
> >> >> >
> >> >> > Yong
> >> >> >
> >> >> > --
> >> >> > Best regards
> >> >>
> >> >
> >> >
> >> > --
> >> > Best regards
> >>
> >
> >
> > --
> > Best regards
>
>

--=20
Best regards

--000000000000c09fc0061d678d02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 17, 20=
24 at 9:29=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com"=
>jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Jul 1=
7, 2024 at 9:24=E2=80=AFAM Yong Huang &lt;<a href=3D"mailto:yong.huang@smar=
tx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Jul 12, 2024 at 10:01=E2=80=AFAM Jason Wang &lt;<a href=3D"mai=
lto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Jul 10, 2024 at 5:05=E2=80=AFPM Yong Huang &lt;<a href=3D"=
mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, Jul 10, 2024 at 3:36=E2=80=AFPM Jason Wang &lt;<a hre=
f=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&=
gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang &lt;<a=
 href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.=
com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang =
&lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redha=
t.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jas=
on Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowa=
ng@redhat.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM =
Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">y=
ong.huang@smartx.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; On Mon, Jul 8, 2024 at 11:21=E2=80=
=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blan=
k">jasowang@redhat.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; On Sat, Jul 6, 2024 at 4:30=E2=
=80=AFAM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; Unexpected work by certai=
n Windows guests equipped with the e1000<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; interface can cause the n=
etwork to go down and never come back up<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; again unless the guest&#3=
9;s interface is reset.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; To reproduce the failure:=
<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; 1. Set up two guests with=
 a Windows 2016 or 2019 server operating<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 system.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; I vaguely remember e1000 suppo=
rt for Windows has been deprecated for<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; several years...<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; That&#39;s why e1000e or igb i=
s implemented in Qemu.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; 2. Set up the e1000 inter=
face for the guests.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; 3. Pressurize the network=
 slightly between two guests using the iPerf tool.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; The network goes down aft=
er a few days (2-5days), and the issue<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; is the result of not adhe=
ring to the e1000 specification. Refer<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; to the details of the spe=
cification at the following link:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; <a href=3D"https://www.in=
tel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-de=
v-manual.pdf" rel=3D"noreferrer" target=3D"_blank">https://www.intel.com/co=
ntent/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.p=
df</a><br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; Chapter 3.2.6 describe th=
e Receive Descriptor Tail register(RDT)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; as following:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; This register holds a val=
ue that is an offset from the base, and<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; identifies the location b=
eyond the last descriptor hardware can<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; process. Note that tail s=
hould still point to an area in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; descriptor ring (somewher=
e between RDBA and RDBA + RDLEN).<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; This is because tail poin=
ts to the location where software writes<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; the first new descriptor.=
<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; This means that if the pr=
ovider=E2=80=94in this case, QEMU=E2=80=94has not yet<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; loaded the packet,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; What do you mean by &quot;load=
&quot; here?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; Sorry for failing to describe the =
details.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; The guest driver retrieves the pac=
ket from the receive ring buffer<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; after QEMU forwards it from the tu=
n/tap interface in the e1000<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; emulation.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; I used &quot;load&quot; to express=
 &quot;putting packets into the receive ring buffer.&quot;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; RDT should never point to=
 that place.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; And &quot;that place&quot;?<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; If a descriptor in the receive rin=
g buffer has not been filled with a<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; packet address by QEMU, the descri=
ptor therefore doesn&#39;t have any<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; available packets. The location of=
 the descriptor should not be referred<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; to by RDT because the location is =
in the range that &quot;hardware&quot; handles.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &quot;that place&quot; means the l=
ocation of the descriptor in the ring buffer<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; that QEMU hasn&#39;t set any avail=
able packets related to.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; When<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; implementing the emulatio=
n of the e1000 interface, QEMU evaluates<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; if the receive ring buffe=
r is full once the RDT equals the RDH,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; based on the assumption t=
hat guest drivers adhere to this<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; criterion strictly.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; We applied the following =
log patch to assist in analyzing the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; issue and eventually obta=
ined the unexpected information.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; Log patch:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; -------------------------=
----------------------------------------<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |--- a/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+++ b/hw/net/e1000.c<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |@@ -836,6 +836,9 @@ e100=
0_set_link_status(NetClientState *nc)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; | static bool e1000_has_r=
xbufs(E1000State *s, size_t total_size)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; | {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0int =
bufs;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX=
, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =
=3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[R=
DH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0/* F=
ast-path short packets */<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0if (=
total_size &lt;=3D s-&gt;rxbuf_size) {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (s-&gt;mac_reg[RDH] =3D=3D s-&gt;mac_reg[RDT] &amp;&amp; s-&gt=
;last_overrun)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |@@ -1022,6 +1025,9 @@ e1=
000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;rxbuf_min_shift)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0n |=3D E1000_ICS_RXDMT0;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 DBGOUT(RX=
, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLEN] =3D %u, s-&gt;mac_reg[RDH] =
=3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac_reg[RDLEN], s-&gt;mac_reg[R=
DH], s-&gt;mac_reg[RDT]);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; |+<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; -------------------------=
----------------------------------------<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; The last few logs of info=
rmation when the network is down:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, =
rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D=
 897, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring bu=
ffer is checked for fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function=
, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64,=
 rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =
=3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same,=
 RDH updates to 898, and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting th=
e packet to ring buffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, =
rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D=
 898, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring bu=
ffer is checked for fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function=
, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64,=
 rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =
=3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same,=
 RDH updates to 899, and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting th=
e packet to ring buffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, =
rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D=
 899, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- the receive ring bu=
ffer is checked for fullness in the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000_has_rxbufs function=
, not full.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 64,=
 rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =
=3D 900, s-&gt;mac_reg[RDT] =3D 885<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- RDT stays the same,=
 RDH updates to 900 , and 1 descriptor<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; utilized after putting th=
e packet to ring buffer.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; e1000: total_size =3D 1, =
rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 16384, s-&gt;mac_reg[RDH] =3D=
 900, s-&gt;mac_reg[RDT] =3D 900<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;- The ring is full, a=
ccording to e1000_has_rxbufs, because<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; of the RDT update to 900 =
and equals RDH !<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Just to make sure I understand=
 this, RDT=3D=3DRDH means the ring is empty I think?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; See commit:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; commit e5b8b0d4ba29fe1268ba049=
519a1b0cf8552a21a<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Author: Dmitry Fleytman &lt;<a=
 href=3D"mailto:dmitry@daynix.com" target=3D"_blank">dmitry@daynix.com</a>&=
gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Date:=C2=A0 =C2=A0Fri Oct 19 0=
7:56:55 2012 +0200<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0e1000: drop=
 check_rxov, always treat RX ring with RDH =3D=3D RDT as empty<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Real HW alw=
ays treats RX ring with RDH =3D=3D RDT as empty.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Emulation i=
s supposed to behave the same.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; Indeed, I&#39;m confused :(,=C2=A0=
 the description in the comment claims that RX<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; rings with RDH =3D=3D RDT as empty=
, but in implementation, it treats that as<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; overrun.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; See the following 2 contexts:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; 1. e1000_can_receive:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; static bool e1000_can_receive(NetC=
lientState *nc)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0E1000State *s =
=3D qemu_get_nic_opaque(nc);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// e1000_has_rx=
bufs return true means ring buffer has<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// available de=
scriptors to use for QEMU.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// false means =
ring buffer overrun and QEMU should queue the packet<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0// and wait for=
 the RDT update and available descriptors can be used.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0return e1000x_r=
x_ready(&amp;s-&gt;parent_obj, s-&gt;mac_reg) &amp;&amp;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
1000_has_rxbufs(s, 1) &amp;&amp; !timer_pending(s-&gt;flush_queue_timer);<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; }<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Well we had in e1000_has_rx_bufs<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=
=3D s-&gt;rxbuf_size) {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 s-&gt;mac_reg[RDH] !=3D s-&gt;mac_reg[RDT];<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; RDT!=3DRDH means RX ring has available =
descriptors for hardware?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; IMHO, Yes.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Just to make sure we are on the same page, so<br=
>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; RDT!=3DRDH, descriptors available for hardware<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt; RDT=3D=3DRDH, descriptor ring is empty for hardw=
are<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; That is currently what the code did. Seems nothi=
ng wrong, or anything<br>
&gt;&gt; &gt;&gt; &gt;&gt; I missed here?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; There are two cases for RDT =3D=3D RDH.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 1. Hardware has filled all available descriptors and=
 overrun.<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 In this case, hardware cannot add any n=
ew packets to the ring.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 2. Software has consumed all descriptors, and all th=
e descriptors<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0on the ring can be used by hardwa=
re. (Let&#39;s name this case &quot;empty.&quot;)<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 In this case, hardware should keep putt=
ing new packets to the ring<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Well this seems not what spec said. See Figure 3-2, when =
RDT=3D=3DRDH,<br>
&gt;&gt; &gt;&gt; nothing is owned by hardware. And this is what Dmitry sai=
d in the<br>
&gt;&gt; &gt;&gt; commit mentioned above.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, this is the main cause of network interruptions. Hardwar=
e should<br>
&gt;&gt; &gt; never touch the location of the descriptor that RDT points to=
. This is<br>
&gt;&gt; &gt; what the specification declares. IMHO, it also implies that t=
he descriptor<br>
&gt;&gt; &gt; referred to by the RDT has available packets.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; In our case, hardware has not added any new packets to the de=
scriptor,<br>
&gt;&gt; &gt; and the expected behavior is that software never updates the =
RDT to<br>
&gt;&gt; &gt; the location of that descriptor. But now, it does.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If hardware and software both work as expected under the e100=
0<br>
&gt;&gt; &gt; specification, the issue does not exist. I have no objection =
that the root<br>
&gt;&gt; &gt; cause is the Windows driver bug in e1000, and I&#39;m not ins=
isting that<br>
&gt;&gt; &gt; QEMU should take the responsibility for fixing that.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Which version of the driver did you use in the guest? (Or=
 have you<br>
&gt;&gt; &gt;&gt; tried to download the one from Intel website) I&#39;m ask=
ing since e1000<br>
&gt;&gt; &gt;&gt; support has been deprecated by Microsoft for years.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I use Windows Server 2019 and the driver version is 8.4.13.0.=
<br>
&gt;&gt;<br>
&gt;&gt; Is this the one you download from the Intel website?<br>
&gt;<br>
&gt;<br>
&gt; No, this one is the default driver of Windows Server 2019 if my<br>
&gt; information is correct.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Since Microsoft no longer supports e1000, as you already ment=
ioned,<br>
&gt;&gt; &gt; this patch merely offers a workaround.<br>
&gt;&gt;<br>
&gt;&gt; Is there a chance to switch to use e1000e, it has been actively<br=
>
&gt;&gt; maintained and supported.<br>
&gt;<br>
&gt;<br>
&gt; Yes, this is another workaround, we&#39;ll try this in the end, thanks=
 for<br>
&gt; the advice.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; Since some users still use<br>
&gt;&gt; &gt; e1000 in production environments, it doesn&#39;t seem to have=
 any side<br>
&gt;&gt; &gt; effects.<br>
&gt;&gt;<br>
&gt;&gt; We need to make sure it matches the hardware behaviour. Otherwise =
it<br>
&gt;&gt; might break other operating systems. Looking at the history, we us=
ed<br>
&gt;&gt; to break e1000 on various operating systems: windows, BSD, minix,<=
br>
&gt;&gt; windriver ....<br>
&gt;<br>
&gt;<br>
&gt; Yes, I absolutely agree with you. Determining if this patch will affec=
t<br>
&gt; other operating systems is therefore crucial.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; It would be really appreciated if the patch was given some th=
ought.<br>
&gt;&gt;<br>
&gt;&gt; We would try to evaluate each patch carefully. Qemu is a function<=
br>
&gt;&gt; emulator so we need to make sure the function matches hardware<br>
&gt;&gt; behaviour before it can be merged.<br>
&gt;<br>
&gt;<br>
&gt; Two solutions could be applied:<br>
&gt;<br>
&gt; 1. fix the windows driver to ensure that RDT does not point to the loc=
ation<br>
&gt;=C2=A0 =C2=A0of the descriptors hardware doesn&#39;t put any packets in=
to. Let&#39;s name this<br>
&gt;=C2=A0 =C2=A0state of descriptor as &quot;invalid&quot;.<br>
&gt;<br>
&gt; 2. modify the QEMU to handle this case while not breaking other OSes.<=
br>
&gt;<br>
&gt; Since this patch only does a sanity check, it appears to adhere to the=
<br>
&gt; second solution, in my opinion.<br>
&gt;<br>
&gt; The patch&#39;s sole unintended consequence is that it prevents guests=
 from<br>
&gt; purposefully updating the RDT to link to the &quot;invalid&quot; descr=
iption.<br>
&gt;<br>
&gt; What do you think?<br>
<br>
For 1), please try the e1000 driver from Intel (I remember it could be<br>
downloaded from the Intel website).<br>
For 2), it would be hard as it needs to be tested with a lot of<br>
operating systems (or we can have Intel Engineers involved).<br>
<br>
And I really suggest you shift to e1000e (or igb) if it is possible.<br></b=
lockquote><div><br></div><div><div style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif" class=3D"gmail_default">Okay, I get it, I appreciate the=
 review and the recommendation. :)</div></div><div style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_de=
fault">Thanks</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">
<br>
Thanks<br>
<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; One way is to test via real hardware or involve Intel Engineers.<b=
r>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Yong<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; But at the moment, the logic of e1000_has_rx_bufs ac=
ts exactly like it was<br>
&gt;&gt; &gt;&gt; &gt; the first case, unable to differentiate between the =
two scenarios.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Thanks<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Adding more people.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Thanks<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; --<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Best regards<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Yong<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; --<br>
&gt;&gt; &gt;&gt; &gt; Best regards<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Best regards<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best regards<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000c09fc0061d678d02--

