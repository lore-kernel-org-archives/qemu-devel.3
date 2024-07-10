Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D9AC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRsI-0001Bl-8I; Wed, 10 Jul 2024 03:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sRRsD-0001AK-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sRRsB-0004az-Hd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720596977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58QBbTQ3EU6uzbKPfX+96r34foVhkX5wMAAZK9d9sf0=;
 b=ET+u+CpRtvQzfreCkK+wZfYXS7CBMoNLvxZfbRcnkglOixyhTRWEIBsmU9OzlKDqo/SC7k
 dfGmUswROp0ai4vlCp8N9sf5VT/1UHnKbm3eittrWSW5NKuElGlSesbLmVKkQX05jh5j8S
 zTa+goIcbP1jpZLHiiRmfx+YRtQ0K2A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-UgC-65GOOGOmuWKOaogwDw-1; Wed, 10 Jul 2024 03:36:15 -0400
X-MC-Unique: UgC-65GOOGOmuWKOaogwDw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c97ff21741so4518221a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 00:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720596975; x=1721201775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58QBbTQ3EU6uzbKPfX+96r34foVhkX5wMAAZK9d9sf0=;
 b=k53jNZIeIaG+DdhC1nsITb6GPMvAuGDp46/QfL5SvQnOywA3VoOo3DD242w2AY/Kj9
 P+kLtB9AkCF846ZISOUDkUevwZbNprC1C4wqas53UJdqoflHua1TzVPBoSUYqtSI3wN3
 5v3wCP2PFENyxpckKCLZcQJpkuEBxbF1QiDuJaM9+StaS4/0QK4CtJlEGj+8mpiN2ZG1
 0Is1ebF/RRizYPntlf0TB4dOT/iiZ0twe26Kzmmieuzq8o3bQvGxCkOEMdkX6MoB2ON8
 XVAvbjsWGjYGLUz66W+mMBFtf3FmYwhngcaEFT6sPg2sEwNsuDw/i6UROTY1yu9DNbV+
 +1vA==
X-Gm-Message-State: AOJu0YwP/rLbliQFD60sfh+Ukoac43Yvn+wRskNlmhNRxXOfCxO1Y4uG
 McIeKojUEZoRSOTzD7IPwtuA2JKK6J3kc88jYQbCm4GbNJxqBZ6bOG3nIMZaam0f82ZDDYx0ete
 zeD4P7PPv0CKpf+sX3PAQlx13nB5tbyxLhzSLjXAHPCa4gbRwJvJd+34EoSLUmPMpDQUPVoe+Es
 sudOHBmFsQBUcoF0VmjLsSkFoTyFw=
X-Received: by 2002:a17:90a:c8f:b0:2c9:61f9:9de1 with SMTP id
 98e67ed59e1d1-2ca35be1cc6mr3888101a91.4.1720596974526; 
 Wed, 10 Jul 2024 00:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2JPHLbX7WWqoL2bZTXMkNLvmyF4WLgXn9iy/SZWCGkg7elLKCHvieGBXdaZrLmaZ1c8dn5dTmrkD36wrkJ4w=
X-Received: by 2002:a17:90a:c8f:b0:2c9:61f9:9de1 with SMTP id
 98e67ed59e1d1-2ca35be1cc6mr3888086a91.4.1720596973918; Wed, 10 Jul 2024
 00:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
 <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
 <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
 <CAK9dgmaEs56fj4F_Bz+bBJNmoK4tXHd9WbmtHeeJj-Mu+kYtNQ@mail.gmail.com>
In-Reply-To: <CAK9dgmaEs56fj4F_Bz+bBJNmoK4tXHd9WbmtHeeJj-Mu+kYtNQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 15:36:02 +0800
Message-ID: <CACGkMEuuxSehLH8+1_P_CERwVm_C33FQXVjHpvBmy+uakP7uVA@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang <yong.huang@smartx.com> =
wrote:
>
>
>
> On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
>>
>> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@smartx.co=
m> wrote:
>> >
>> >
>> >
>> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
>> >>
>> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smartx.=
com> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
>> >> >>
>> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@sma=
rtx.com> wrote:
>> >> >> >
>> >> >> > Unexpected work by certain Windows guests equipped with the e100=
0
>> >> >> > interface can cause the network to go down and never come back u=
p
>> >> >> > again unless the guest's interface is reset.
>> >> >> >
>> >> >> > To reproduce the failure:
>> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server operatin=
g
>> >> >> >    system.
>> >> >>
>> >> >> I vaguely remember e1000 support for Windows has been deprecated f=
or
>> >> >> several years...
>> >> >>
>> >> >> That's why e1000e or igb is implemented in Qemu.
>> >> >>
>> >> >> > 2. Set up the e1000 interface for the guests.
>> >> >> > 3. Pressurize the network slightly between two guests using the =
iPerf tool.
>> >> >> >
>> >> >> > The network goes down after a few days (2-5days), and the issue
>> >> >> > is the result of not adhering to the e1000 specification. Refer
>> >> >> > to the details of the specification at the following link:
>> >> >> > https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gb=
e-controllers-software-dev-manual.pdf
>> >> >> >
>> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
>> >> >> > as following:
>> >> >> > This register holds a value that is an offset from the base, and
>> >> >> > identifies the location beyond the last descriptor hardware can
>> >> >> > process. Note that tail should still point to an area in the
>> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
>> >> >> > This is because tail points to the location where software write=
s
>> >> >> > the first new descriptor.
>> >> >> >
>> >> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=80=
=94has not yet
>> >> >> > loaded the packet,
>> >> >>
>> >> >> What do you mean by "load" here?
>> >> >
>> >> >
>> >> > Sorry for failing to describe the details.
>> >> >
>> >> > The guest driver retrieves the packet from the receive ring buffer
>> >> > after QEMU forwards it from the tun/tap interface in the e1000
>> >> > emulation.
>> >> >
>> >> > I used "load" to express "putting packets into the receive ring buf=
fer."
>> >> >
>> >> >>
>> >> >>
>> >> >> > RDT should never point to that place.
>> >> >>
>> >> >> And "that place"?
>> >> >
>> >> > If a descriptor in the receive ring buffer has not been filled with=
 a
>> >> > packet address by QEMU, the descriptor therefore doesn't have any
>> >> > available packets. The location of the descriptor should not be ref=
erred
>> >> > to by RDT because the location is in the range that "hardware" hand=
les.
>> >> >
>> >> > "that place" means the location of the descriptor in the ring buffe=
r
>> >> > that QEMU hasn't set any available packets related to.
>> >> >
>> >> >>
>> >> >>
>> >> >> > When
>> >> >> > implementing the emulation of the e1000 interface, QEMU evaluate=
s
>> >> >> > if the receive ring buffer is full once the RDT equals the RDH,
>> >> >> > based on the assumption that guest drivers adhere to this
>> >> >> > criterion strictly.
>> >> >> >
>> >> >> > We applied the following log patch to assist in analyzing the
>> >> >> > issue and eventually obtained the unexpected information.
>> >> >> >
>> >> >> > Log patch:
>> >> >> > ----------------------------------------------------------------=
-
>> >> >> > |--- a/hw/net/e1000.c
>> >> >> > |+++ b/hw/net/e1000.c
>> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
>> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
>> >> >> > | {
>> >> >> > |     int bufs;
>> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s=
->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], =
s->mac_reg[RDT]);
>> >> >> > |+
>> >> >> > |     /* Fast-path short packets */
>> >> >> > |     if (total_size <=3D s->rxbuf_size) {
>> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_=
overrun)
>> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, con=
st struct iovec *iov, int iovcnt)
>> >> >> > |         s->rxbuf_min_shift)
>> >> >> > |         n |=3D E1000_ICS_RXDMT0;
>> >> >> > |
>> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s=
->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], =
s->mac_reg[RDT]);
>> >> >> > |+
>> >> >> > ----------------------------------------------------------------=
-
>> >> >> >
>> >> >> > The last few logs of information when the network is down:
>> >> >> >
>> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
>> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >
>> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN]=
 =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
>> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >
>> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >
>> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN]=
 =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
>> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >
>> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >
>> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN]=
 =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
>> >> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
>> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >
>> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
>> >> >> > <- The ring is full, according to e1000_has_rxbufs, because
>> >> >> > of the RDT update to 900 and equals RDH !
>> >> >>
>> >> >> Just to make sure I understand this, RDT=3D=3DRDH means the ring i=
s empty I think?
>> >> >>
>> >> >>
>> >> >> See commit:
>> >> >>
>> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
>> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
>> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
>> >> >>
>> >> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D R=
DT as empty
>> >> >>
>> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
>> >> >>     Emulation is supposed to behave the same.
>> >> >
>> >> >
>> >> > Indeed, I'm confused :(,  the description in the comment claims tha=
t RX
>> >> > rings with RDH =3D=3D RDT as empty, but in implementation, it treat=
s that as
>> >> > overrun.
>> >> >
>> >> > See the following 2 contexts:
>> >> >
>> >> > 1. e1000_can_receive:
>> >> > static bool e1000_can_receive(NetClientState *nc)
>> >> > {
>> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
>> >> >     // e1000_has_rxbufs return true means ring buffer has
>> >> >     // available descriptors to use for QEMU.
>> >> >     // false means ring buffer overrun and QEMU should queue the pa=
cket
>> >> >     // and wait for the RDT update and available descriptors can be=
 used.
>> >> >
>> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
>> >> >         e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_queue_tim=
er);
>> >> > }
>> >>
>> >> Well we had in e1000_has_rx_bufs
>> >>
>> >>     if (total_size <=3D s->rxbuf_size) {
>> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
>> >>     }
>> >>
>> >> RDT!=3DRDH means RX ring has available descriptors for hardware?
>> >
>> >
>> > IMHO, Yes.
>>
>> Just to make sure we are on the same page, so
>>
>> RDT!=3DRDH, descriptors available for hardware
>> RDT=3D=3DRDH, descriptor ring is empty for hardware
>>
>>
>> That is currently what the code did. Seems nothing wrong, or anything
>> I missed here?
>
>
> There are two cases for RDT =3D=3D RDH.
>
> 1. Hardware has filled all available descriptors and overrun.
>    In this case, hardware cannot add any new packets to the ring.
>
> 2. Software has consumed all descriptors, and all the descriptors
>     on the ring can be used by hardware. (Let's name this case "empty.")
>    In this case, hardware should keep putting new packets to the ring

Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DRDH,
nothing is owned by hardware. And this is what Dmitry said in the
commit mentioned above.

Which version of the driver did you use in the guest? (Or have you
tried to download the one from Intel website) I'm asking since e1000
support has been deprecated by Microsoft for years.

Thanks

>
> But at the moment, the logic of e1000_has_rx_bufs acts exactly like it wa=
s
> the first case, unable to differentiate between the two scenarios.
>
>>
>>
>> Thanks
>>
>> >
>> >>
>> >> Adding more people.
>> >>
>> >> Thanks
>> >>
>> >
>> >
>> > --
>> > Best regards
>>
>
> Yong
>
> --
> Best regards


