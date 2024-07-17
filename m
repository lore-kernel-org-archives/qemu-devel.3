Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6323C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 01:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTtTq-0006hR-A3; Tue, 16 Jul 2024 21:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTtTp-0006gx-No
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTtTn-0004ls-49
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721179754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=md0c4TJ6Is0ESco34VR3xPYXsBhfBrUN0m3Smkt5J7k=;
 b=JJoPEKqDMzDYctfYjGjyZ2KBWEwYVG1uXV4GRRVRqla28NZ+7lJm+XA+5fZE3JmfLH75Ct
 eCR7ydueIkp4yClbnI4FHHgGWwm2TPncJkGnulDgh+lFiDQqnjXXBPeIo89b6g2D6E8jec
 Bj+fmmJuZFrPkvFy5pXOOFRmQYW9OJ4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-PRB94fMWMIa_EdvFHLMZCA-1; Tue, 16 Jul 2024 21:29:09 -0400
X-MC-Unique: PRB94fMWMIa_EdvFHLMZCA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-778702b9f8fso214840a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 18:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721179748; x=1721784548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=md0c4TJ6Is0ESco34VR3xPYXsBhfBrUN0m3Smkt5J7k=;
 b=XUvA/v2KVaBidnuuiPiUKKGFnhY/AKvuGvEAc+qLRxs+KJSfa9z+e9HibT3t0s1oq3
 4EZ753Sgd/D9M7cEuyR0WEoRVYLl9DZGSRXPqfQmYGjOez2xI0BGmYk//O3Wvr+HmIOc
 mNCJGMwikwbl4ag25mOu/Lge17th3fqnFCta7EdLgbkezpxLpWILegLonzYBfnVxiOec
 a3q3gFtwIFkxgtzQaZzp1ZvVF3C7CxeHIPX5sH3AzHoxf4P39nPVtWvW2+yCfhoOciSA
 aZGYyucj7VGTOk7/KJIvuJeCfAGTs3iDoSiPgXfI6WvNQHzrkv/4T0lQtHxt6C6yI53S
 SYKw==
X-Gm-Message-State: AOJu0YzN+fj94oi73y3US+TpmINFZCcSU3+bNdeDv+jbiLBZhms/58TQ
 V7l4t9MPyupvUYtNRV0PEIQ9Jj4KexXRj9tjzBjSXFA1OxW0IGJFJiyfPHwapri4OaBIBzrLgC3
 7B29iirmSPeJyY7CIzVnZW14k/sRZWDMOu1IkXpZh+HwhzeKUhQOSQpabq03J2aSa2M6vUB+tFP
 YTd58Y/BhvAjyxNAFvi+37lP0KM94=
X-Received: by 2002:a17:90b:1495:b0:2cb:4b31:1c48 with SMTP id
 98e67ed59e1d1-2cb4b311d23mr1239874a91.22.1721179748150; 
 Tue, 16 Jul 2024 18:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDoD6Q2LgfpXukioh6Hx5DK/NTxZ4YmuQdHi2siIFqFptEarA9nKW/5Y/6Nbd2aWqBVk/XNfhUSxJdUA5IDkk=
X-Received: by 2002:a17:90b:1495:b0:2cb:4b31:1c48 with SMTP id
 98e67ed59e1d1-2cb4b311d23mr1239847a91.22.1721179747536; Tue, 16 Jul 2024
 18:29:07 -0700 (PDT)
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
In-Reply-To: <CAK9dgmYuq1HsEb70wN6Vsa+sPEsc7KVdKgFkpg9kmcNyigqXMQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 09:28:56 +0800
Message-ID: <CACGkMEt+7Epkf9ud_44CVqitmt6RBiUc8eNryGXMoiW2H+hx2w@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 9:24=E2=80=AFAM Yong Huang <yong.huang@smartx.com> =
wrote:
>
>
>
> On Fri, Jul 12, 2024 at 10:01=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
>>
>> On Wed, Jul 10, 2024 at 5:05=E2=80=AFPM Yong Huang <yong.huang@smartx.co=
m> wrote:
>> >
>> >
>> >
>> > On Wed, Jul 10, 2024 at 3:36=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
>> >>
>> >> On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang <yong.huang@smartx=
.com> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
>> >> >>
>> >> >> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@sma=
rtx.com> wrote:
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
>> >> >> >>
>> >> >> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@s=
martx.com> wrote:
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
>> >> >> >> >>
>> >> >> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.hua=
ng@smartx.com> wrote:
>> >> >> >> >> >
>> >> >> >> >> > Unexpected work by certain Windows guests equipped with th=
e e1000
>> >> >> >> >> > interface can cause the network to go down and never come =
back up
>> >> >> >> >> > again unless the guest's interface is reset.
>> >> >> >> >> >
>> >> >> >> >> > To reproduce the failure:
>> >> >> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server op=
erating
>> >> >> >> >> >    system.
>> >> >> >> >>
>> >> >> >> >> I vaguely remember e1000 support for Windows has been deprec=
ated for
>> >> >> >> >> several years...
>> >> >> >> >>
>> >> >> >> >> That's why e1000e or igb is implemented in Qemu.
>> >> >> >> >>
>> >> >> >> >> > 2. Set up the e1000 interface for the guests.
>> >> >> >> >> > 3. Pressurize the network slightly between two guests usin=
g the iPerf tool.
>> >> >> >> >> >
>> >> >> >> >> > The network goes down after a few days (2-5days), and the =
issue
>> >> >> >> >> > is the result of not adhering to the e1000 specification. =
Refer
>> >> >> >> >> > to the details of the specification at the following link:
>> >> >> >> >> > https://www.intel.com/content/dam/doc/manual/pci-pci-x-fam=
ily-gbe-controllers-software-dev-manual.pdf
>> >> >> >> >> >
>> >> >> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail registe=
r(RDT)
>> >> >> >> >> > as following:
>> >> >> >> >> > This register holds a value that is an offset from the bas=
e, and
>> >> >> >> >> > identifies the location beyond the last descriptor hardwar=
e can
>> >> >> >> >> > process. Note that tail should still point to an area in t=
he
>> >> >> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
>> >> >> >> >> > This is because tail points to the location where software=
 writes
>> >> >> >> >> > the first new descriptor.
>> >> >> >> >> >
>> >> >> >> >> > This means that if the provider=E2=80=94in this case, QEMU=
=E2=80=94has not yet
>> >> >> >> >> > loaded the packet,
>> >> >> >> >>
>> >> >> >> >> What do you mean by "load" here?
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > Sorry for failing to describe the details.
>> >> >> >> >
>> >> >> >> > The guest driver retrieves the packet from the receive ring b=
uffer
>> >> >> >> > after QEMU forwards it from the tun/tap interface in the e100=
0
>> >> >> >> > emulation.
>> >> >> >> >
>> >> >> >> > I used "load" to express "putting packets into the receive ri=
ng buffer."
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >> >> > RDT should never point to that place.
>> >> >> >> >>
>> >> >> >> >> And "that place"?
>> >> >> >> >
>> >> >> >> > If a descriptor in the receive ring buffer has not been fille=
d with a
>> >> >> >> > packet address by QEMU, the descriptor therefore doesn't have=
 any
>> >> >> >> > available packets. The location of the descriptor should not =
be referred
>> >> >> >> > to by RDT because the location is in the range that "hardware=
" handles.
>> >> >> >> >
>> >> >> >> > "that place" means the location of the descriptor in the ring=
 buffer
>> >> >> >> > that QEMU hasn't set any available packets related to.
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >> >> > When
>> >> >> >> >> > implementing the emulation of the e1000 interface, QEMU ev=
aluates
>> >> >> >> >> > if the receive ring buffer is full once the RDT equals the=
 RDH,
>> >> >> >> >> > based on the assumption that guest drivers adhere to this
>> >> >> >> >> > criterion strictly.
>> >> >> >> >> >
>> >> >> >> >> > We applied the following log patch to assist in analyzing =
the
>> >> >> >> >> > issue and eventually obtained the unexpected information.
>> >> >> >> >> >
>> >> >> >> >> > Log patch:
>> >> >> >> >> > ----------------------------------------------------------=
-------
>> >> >> >> >> > |--- a/hw/net/e1000.c
>> >> >> >> >> > |+++ b/hw/net/e1000.c
>> >> >> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState =
*nc)
>> >> >> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total=
_size)
>> >> >> >> >> > | {
>> >> >> >> >> > |     int bufs;
>> >> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D=
 %u, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[=
RDH], s->mac_reg[RDT]);
>> >> >> >> >> > |+
>> >> >> >> >> > |     /* Fast-path short packets */
>> >> >> >> >> > |     if (total_size <=3D s->rxbuf_size) {
>> >> >> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s-=
>last_overrun)
>> >> >> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *n=
c, const struct iovec *iov, int iovcnt)
>> >> >> >> >> > |         s->rxbuf_min_shift)
>> >> >> >> >> > |         n |=3D E1000_ICS_RXDMT0;
>> >> >> >> >> > |
>> >> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D=
 %u, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[=
RDH], s->mac_reg[RDT]);
>> >> >> >> >> > |+
>> >> >> >> >> > ----------------------------------------------------------=
-------
>> >> >> >> >> >
>> >> >> >> >> > The last few logs of information when the network is down:
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[R=
DLEN] =3D 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[=
RDLEN] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- RDT stays the same, RDH updates to 898, and 1 descripto=
r
>> >> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[R=
DLEN] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[=
RDLEN] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- RDT stays the same, RDH updates to 899, and 1 descripto=
r
>> >> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[R=
DLEN] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[=
RDLEN] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
>> >> >> >> >> > <- RDT stays the same, RDH updates to 900 , and 1 descript=
or
>> >> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >> >
>> >> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[R=
DLEN] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
>> >> >> >> >> > <- The ring is full, according to e1000_has_rxbufs, becaus=
e
>> >> >> >> >> > of the RDT update to 900 and equals RDH !
>> >> >> >> >>
>> >> >> >> >> Just to make sure I understand this, RDT=3D=3DRDH means the =
ring is empty I think?
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >> >> See commit:
>> >> >> >> >>
>> >> >> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
>> >> >> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
>> >> >> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
>> >> >> >> >>
>> >> >> >> >>     e1000: drop check_rxov, always treat RX ring with RDH =
=3D=3D RDT as empty
>> >> >> >> >>
>> >> >> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as emp=
ty.
>> >> >> >> >>     Emulation is supposed to behave the same.
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > Indeed, I'm confused :(,  the description in the comment clai=
ms that RX
>> >> >> >> > rings with RDH =3D=3D RDT as empty, but in implementation, it=
 treats that as
>> >> >> >> > overrun.
>> >> >> >> >
>> >> >> >> > See the following 2 contexts:
>> >> >> >> >
>> >> >> >> > 1. e1000_can_receive:
>> >> >> >> > static bool e1000_can_receive(NetClientState *nc)
>> >> >> >> > {
>> >> >> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
>> >> >> >> >     // e1000_has_rxbufs return true means ring buffer has
>> >> >> >> >     // available descriptors to use for QEMU.
>> >> >> >> >     // false means ring buffer overrun and QEMU should queue =
the packet
>> >> >> >> >     // and wait for the RDT update and available descriptors =
can be used.
>> >> >> >> >
>> >> >> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
>> >> >> >> >         e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_que=
ue_timer);
>> >> >> >> > }
>> >> >> >>
>> >> >> >> Well we had in e1000_has_rx_bufs
>> >> >> >>
>> >> >> >>     if (total_size <=3D s->rxbuf_size) {
>> >> >> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
>> >> >> >>     }
>> >> >> >>
>> >> >> >> RDT!=3DRDH means RX ring has available descriptors for hardware=
?
>> >> >> >
>> >> >> >
>> >> >> > IMHO, Yes.
>> >> >>
>> >> >> Just to make sure we are on the same page, so
>> >> >>
>> >> >> RDT!=3DRDH, descriptors available for hardware
>> >> >> RDT=3D=3DRDH, descriptor ring is empty for hardware
>> >> >>
>> >> >>
>> >> >> That is currently what the code did. Seems nothing wrong, or anyth=
ing
>> >> >> I missed here?
>> >> >
>> >> >
>> >> > There are two cases for RDT =3D=3D RDH.
>> >> >
>> >> > 1. Hardware has filled all available descriptors and overrun.
>> >> >    In this case, hardware cannot add any new packets to the ring.
>> >> >
>> >> > 2. Software has consumed all descriptors, and all the descriptors
>> >> >     on the ring can be used by hardware. (Let's name this case "emp=
ty.")
>> >> >    In this case, hardware should keep putting new packets to the ri=
ng
>> >>
>> >> Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DRDH=
,
>> >> nothing is owned by hardware. And this is what Dmitry said in the
>> >> commit mentioned above.
>> >
>> >
>> > Yes, this is the main cause of network interruptions. Hardware should
>> > never touch the location of the descriptor that RDT points to. This is
>> > what the specification declares. IMHO, it also implies that the descri=
ptor
>> > referred to by the RDT has available packets.
>> >
>> > In our case, hardware has not added any new packets to the descriptor,
>> > and the expected behavior is that software never updates the RDT to
>> > the location of that descriptor. But now, it does.
>> >
>> > If hardware and software both work as expected under the e1000
>> > specification, the issue does not exist. I have no objection that the =
root
>> > cause is the Windows driver bug in e1000, and I'm not insisting that
>> > QEMU should take the responsibility for fixing that.
>> >
>> >>
>> >>
>> >> Which version of the driver did you use in the guest? (Or have you
>> >> tried to download the one from Intel website) I'm asking since e1000
>> >> support has been deprecated by Microsoft for years.
>> >
>> >
>> > I use Windows Server 2019 and the driver version is 8.4.13.0.
>>
>> Is this the one you download from the Intel website?
>
>
> No, this one is the default driver of Windows Server 2019 if my
> information is correct.
>
>>
>>
>> >
>> > Since Microsoft no longer supports e1000, as you already mentioned,
>> > this patch merely offers a workaround.
>>
>> Is there a chance to switch to use e1000e, it has been actively
>> maintained and supported.
>
>
> Yes, this is another workaround, we'll try this in the end, thanks for
> the advice.
>
>>
>>
>> > Since some users still use
>> > e1000 in production environments, it doesn't seem to have any side
>> > effects.
>>
>> We need to make sure it matches the hardware behaviour. Otherwise it
>> might break other operating systems. Looking at the history, we used
>> to break e1000 on various operating systems: windows, BSD, minix,
>> windriver ....
>
>
> Yes, I absolutely agree with you. Determining if this patch will affect
> other operating systems is therefore crucial.
>
>>
>>
>> >
>> > It would be really appreciated if the patch was given some thought.
>>
>> We would try to evaluate each patch carefully. Qemu is a function
>> emulator so we need to make sure the function matches hardware
>> behaviour before it can be merged.
>
>
> Two solutions could be applied:
>
> 1. fix the windows driver to ensure that RDT does not point to the locati=
on
>   of the descriptors hardware doesn't put any packets into. Let's name th=
is
>   state of descriptor as "invalid".
>
> 2. modify the QEMU to handle this case while not breaking other OSes.
>
> Since this patch only does a sanity check, it appears to adhere to the
> second solution, in my opinion.
>
> The patch's sole unintended consequence is that it prevents guests from
> purposefully updating the RDT to link to the "invalid" description.
>
> What do you think?

For 1), please try the e1000 driver from Intel (I remember it could be
downloaded from the Intel website).
For 2), it would be hard as it needs to be tested with a lot of
operating systems (or we can have Intel Engineers involved).

And I really suggest you shift to e1000e (or igb) if it is possible.

Thanks

>
> Yong
>
>>
>> One way is to test via real hardware or involve Intel Engineers.
>>
>>
>> Thanks
>>
>> >
>> > Thanks,
>> > Yong
>> >
>> >>
>> >>
>> >> Thanks
>> >>
>> >> >
>> >> > But at the moment, the logic of e1000_has_rx_bufs acts exactly like=
 it was
>> >> > the first case, unable to differentiate between the two scenarios.
>> >> >
>> >> >>
>> >> >>
>> >> >> Thanks
>> >> >>
>> >> >> >
>> >> >> >>
>> >> >> >> Adding more people.
>> >> >> >>
>> >> >> >> Thanks
>> >> >> >>
>> >> >> >
>> >> >> >
>> >> >> > --
>> >> >> > Best regards
>> >> >>
>> >> >
>> >> > Yong
>> >> >
>> >> > --
>> >> > Best regards
>> >>
>> >
>> >
>> > --
>> > Best regards
>>
>
>
> --
> Best regards


