Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60C7C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5bB-00081u-UV; Thu, 11 Jul 2024 22:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sS5bA-0007uw-3f
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sS5b6-0001Gv-Vp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720749675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oL8NiGfIQB54gh6KW484MgAOkCZVAouLf3hqbBp12AU=;
 b=YEhYZkhn9RPOBTd8ZJC2wpve31fQMLNBUUZY/YGUyY1C7rWzU6wXtr/6Ot5R1IYmwLolDF
 zoB6/bEOnmIrbBEp0OlADPaph3p+fsn9Ma2LhZdcSvv80PpZAGEnQqqV+7tLT3i9HwHntL
 0d0kPNdoEuurUh2dWNi7EqsIoEbt9Y8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_SUbiy_FN5KZvV3G4l37Vw-1; Thu, 11 Jul 2024 22:01:14 -0400
X-MC-Unique: _SUbiy_FN5KZvV3G4l37Vw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c969c4a90cso1454617a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 19:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720749673; x=1721354473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oL8NiGfIQB54gh6KW484MgAOkCZVAouLf3hqbBp12AU=;
 b=A6AAn8SxzYNetyZ1DVfdyaVCkjiUqWl2gqX0fqHSDnSeGGloQPoVuckVkNHhR8aBV5
 yJMfHWhOzqQ88B1jpn4Mpoj9JFRoCd63uD7LsvDpKatT/v9tFOJEGYgJ/qYzvS/wsPrH
 jpgNe+8X9PtRQp3bLHa3Y2m5sQAkxamAR+5p8x6dhi623o+LPtPAvic2Urh0IVbXUzw6
 nqMTdC/+oWbHZArWwCrUbWDWyFJlya2sSQNPPie1Tw4H6qA7NLhzGWfb59g7lh56Ee1/
 thBnQ6EaC/Ym4+IEOVaunpNAegL4pYyqTJiqvPyzUO7GcIS1WAB0ioVta71q3b8cNqYz
 VsXA==
X-Gm-Message-State: AOJu0YwZDgTY+qwm2yrEIcRQjienox9VwdtxHvqwQjew9tjqEKJlNr3g
 JlOkLA3tUjevXHinOicaU6Hq7rmMI0x1iTKFg952h5lc7YJDWpjEKG58vTVP/NbgI8FNaLiTWz+
 5Qf8hrJKhUhkT8TMZbHAosXHeocV/KBG5u/XYz1czahh9sqvBoGsS5qj7n9XZ8cBSydKNxDfS2B
 W1GuXdfYQpLP4t+u0tPEuWokYd19IysHxAO6o=
X-Received: by 2002:a17:90a:e510:b0:2c9:88af:300c with SMTP id
 98e67ed59e1d1-2ca35c28611mr9107108a91.18.1720749672660; 
 Thu, 11 Jul 2024 19:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxzDP20L1GhMNZrhy24aLh8KoKN5ul5FDrDVZn2jOzWL6MPoxYiIAUk7LXpt3/WJIaOG2mNUscxk+SKP7YXJY=
X-Received: by 2002:a17:90a:e510:b0:2c9:88af:300c with SMTP id
 98e67ed59e1d1-2ca35c28611mr9107080a91.18.1720749672020; Thu, 11 Jul 2024
 19:01:12 -0700 (PDT)
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
In-Reply-To: <CAK9dgmY2MVR8+LMG-skmdgiKGrzDMriDrEV_oYwY4kBqcp91kQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Jul 2024 10:00:58 +0800
Message-ID: <CACGkMEuWjh6Vw_Qp49QM+tB=hH0=g1+2-XiLO+mHOfV5JNTQqQ@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Jul 10, 2024 at 5:05=E2=80=AFPM Yong Huang <yong.huang@smartx.com> =
wrote:
>
>
>
> On Wed, Jul 10, 2024 at 3:36=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
>>
>> On Wed, Jul 10, 2024 at 2:26=E2=80=AFPM Yong Huang <yong.huang@smartx.co=
m> wrote:
>> >
>> >
>> >
>> > On Wed, Jul 10, 2024 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
>> >>
>> >> On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@smartx=
.com> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
>> >> >>
>> >> >> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smar=
tx.com> wrote:
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
>> >> >> >>
>> >> >> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@=
smartx.com> wrote:
>> >> >> >> >
>> >> >> >> > Unexpected work by certain Windows guests equipped with the e=
1000
>> >> >> >> > interface can cause the network to go down and never come bac=
k up
>> >> >> >> > again unless the guest's interface is reset.
>> >> >> >> >
>> >> >> >> > To reproduce the failure:
>> >> >> >> > 1. Set up two guests with a Windows 2016 or 2019 server opera=
ting
>> >> >> >> >    system.
>> >> >> >>
>> >> >> >> I vaguely remember e1000 support for Windows has been deprecate=
d for
>> >> >> >> several years...
>> >> >> >>
>> >> >> >> That's why e1000e or igb is implemented in Qemu.
>> >> >> >>
>> >> >> >> > 2. Set up the e1000 interface for the guests.
>> >> >> >> > 3. Pressurize the network slightly between two guests using t=
he iPerf tool.
>> >> >> >> >
>> >> >> >> > The network goes down after a few days (2-5days), and the iss=
ue
>> >> >> >> > is the result of not adhering to the e1000 specification. Ref=
er
>> >> >> >> > to the details of the specification at the following link:
>> >> >> >> > https://www.intel.com/content/dam/doc/manual/pci-pci-x-family=
-gbe-controllers-software-dev-manual.pdf
>> >> >> >> >
>> >> >> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(R=
DT)
>> >> >> >> > as following:
>> >> >> >> > This register holds a value that is an offset from the base, =
and
>> >> >> >> > identifies the location beyond the last descriptor hardware c=
an
>> >> >> >> > process. Note that tail should still point to an area in the
>> >> >> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
>> >> >> >> > This is because tail points to the location where software wr=
ites
>> >> >> >> > the first new descriptor.
>> >> >> >> >
>> >> >> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=
=80=94has not yet
>> >> >> >> > loaded the packet,
>> >> >> >>
>> >> >> >> What do you mean by "load" here?
>> >> >> >
>> >> >> >
>> >> >> > Sorry for failing to describe the details.
>> >> >> >
>> >> >> > The guest driver retrieves the packet from the receive ring buff=
er
>> >> >> > after QEMU forwards it from the tun/tap interface in the e1000
>> >> >> > emulation.
>> >> >> >
>> >> >> > I used "load" to express "putting packets into the receive ring =
buffer."
>> >> >> >
>> >> >> >>
>> >> >> >>
>> >> >> >> > RDT should never point to that place.
>> >> >> >>
>> >> >> >> And "that place"?
>> >> >> >
>> >> >> > If a descriptor in the receive ring buffer has not been filled w=
ith a
>> >> >> > packet address by QEMU, the descriptor therefore doesn't have an=
y
>> >> >> > available packets. The location of the descriptor should not be =
referred
>> >> >> > to by RDT because the location is in the range that "hardware" h=
andles.
>> >> >> >
>> >> >> > "that place" means the location of the descriptor in the ring bu=
ffer
>> >> >> > that QEMU hasn't set any available packets related to.
>> >> >> >
>> >> >> >>
>> >> >> >>
>> >> >> >> > When
>> >> >> >> > implementing the emulation of the e1000 interface, QEMU evalu=
ates
>> >> >> >> > if the receive ring buffer is full once the RDT equals the RD=
H,
>> >> >> >> > based on the assumption that guest drivers adhere to this
>> >> >> >> > criterion strictly.
>> >> >> >> >
>> >> >> >> > We applied the following log patch to assist in analyzing the
>> >> >> >> > issue and eventually obtained the unexpected information.
>> >> >> >> >
>> >> >> >> > Log patch:
>> >> >> >> > -------------------------------------------------------------=
----
>> >> >> >> > |--- a/hw/net/e1000.c
>> >> >> >> > |+++ b/hw/net/e1000.c
>> >> >> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc=
)
>> >> >> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_si=
ze)
>> >> >> >> > | {
>> >> >> >> > |     int bufs;
>> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u=
, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH=
], s->mac_reg[RDT]);
>> >> >> >> > |+
>> >> >> >> > |     /* Fast-path short packets */
>> >> >> >> > |     if (total_size <=3D s->rxbuf_size) {
>> >> >> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->la=
st_overrun)
>> >> >> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, =
const struct iovec *iov, int iovcnt)
>> >> >> >> > |         s->rxbuf_min_shift)
>> >> >> >> > |         n |=3D E1000_ICS_RXDMT0;
>> >> >> >> > |
>> >> >> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u=
, s->mac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> >> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH=
], s->mac_reg[RDT]);
>> >> >> >> > |+
>> >> >> >> > -------------------------------------------------------------=
----
>> >> >> >> >
>> >> >> >> > The last few logs of information when the network is down:
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDL=
EN] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
>> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDL=
EN] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
>> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- the receive ring buffer is checked for fullness in the
>> >> >> >> > e1000_has_rxbufs function, not full.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDL=
EN] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
>> >> >> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
>> >> >> >> > utilized after putting the packet to ring buffer.
>> >> >> >> >
>> >> >> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLE=
N] =3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
>> >> >> >> > <- The ring is full, according to e1000_has_rxbufs, because
>> >> >> >> > of the RDT update to 900 and equals RDH !
>> >> >> >>
>> >> >> >> Just to make sure I understand this, RDT=3D=3DRDH means the rin=
g is empty I think?
>> >> >> >>
>> >> >> >>
>> >> >> >> See commit:
>> >> >> >>
>> >> >> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
>> >> >> >> Author: Dmitry Fleytman <dmitry@daynix.com>
>> >> >> >> Date:   Fri Oct 19 07:56:55 2012 +0200
>> >> >> >>
>> >> >> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=
=3D RDT as empty
>> >> >> >>
>> >> >> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
>> >> >> >>     Emulation is supposed to behave the same.
>> >> >> >
>> >> >> >
>> >> >> > Indeed, I'm confused :(,  the description in the comment claims =
that RX
>> >> >> > rings with RDH =3D=3D RDT as empty, but in implementation, it tr=
eats that as
>> >> >> > overrun.
>> >> >> >
>> >> >> > See the following 2 contexts:
>> >> >> >
>> >> >> > 1. e1000_can_receive:
>> >> >> > static bool e1000_can_receive(NetClientState *nc)
>> >> >> > {
>> >> >> >     E1000State *s =3D qemu_get_nic_opaque(nc);
>> >> >> >     // e1000_has_rxbufs return true means ring buffer has
>> >> >> >     // available descriptors to use for QEMU.
>> >> >> >     // false means ring buffer overrun and QEMU should queue the=
 packet
>> >> >> >     // and wait for the RDT update and available descriptors can=
 be used.
>> >> >> >
>> >> >> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
>> >> >> >         e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_queue_=
timer);
>> >> >> > }
>> >> >>
>> >> >> Well we had in e1000_has_rx_bufs
>> >> >>
>> >> >>     if (total_size <=3D s->rxbuf_size) {
>> >> >>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
>> >> >>     }
>> >> >>
>> >> >> RDT!=3DRDH means RX ring has available descriptors for hardware?
>> >> >
>> >> >
>> >> > IMHO, Yes.
>> >>
>> >> Just to make sure we are on the same page, so
>> >>
>> >> RDT!=3DRDH, descriptors available for hardware
>> >> RDT=3D=3DRDH, descriptor ring is empty for hardware
>> >>
>> >>
>> >> That is currently what the code did. Seems nothing wrong, or anything
>> >> I missed here?
>> >
>> >
>> > There are two cases for RDT =3D=3D RDH.
>> >
>> > 1. Hardware has filled all available descriptors and overrun.
>> >    In this case, hardware cannot add any new packets to the ring.
>> >
>> > 2. Software has consumed all descriptors, and all the descriptors
>> >     on the ring can be used by hardware. (Let's name this case "empty.=
")
>> >    In this case, hardware should keep putting new packets to the ring
>>
>> Well this seems not what spec said. See Figure 3-2, when RDT=3D=3DRDH,
>> nothing is owned by hardware. And this is what Dmitry said in the
>> commit mentioned above.
>
>
> Yes, this is the main cause of network interruptions. Hardware should
> never touch the location of the descriptor that RDT points to. This is
> what the specification declares. IMHO, it also implies that the descripto=
r
> referred to by the RDT has available packets.
>
> In our case, hardware has not added any new packets to the descriptor,
> and the expected behavior is that software never updates the RDT to
> the location of that descriptor. But now, it does.
>
> If hardware and software both work as expected under the e1000
> specification, the issue does not exist. I have no objection that the roo=
t
> cause is the Windows driver bug in e1000, and I'm not insisting that
> QEMU should take the responsibility for fixing that.
>
>>
>>
>> Which version of the driver did you use in the guest? (Or have you
>> tried to download the one from Intel website) I'm asking since e1000
>> support has been deprecated by Microsoft for years.
>
>
> I use Windows Server 2019 and the driver version is 8.4.13.0.

Is this the one you download from the Intel website?

>
> Since Microsoft no longer supports e1000, as you already mentioned,
> this patch merely offers a workaround.

Is there a chance to switch to use e1000e, it has been actively
maintained and supported.

> Since some users still use
> e1000 in production environments, it doesn't seem to have any side
> effects.

We need to make sure it matches the hardware behaviour. Otherwise it
might break other operating systems. Looking at the history, we used
to break e1000 on various operating systems: windows, BSD, minix,
windriver ....

>
> It would be really appreciated if the patch was given some thought.

We would try to evaluate each patch carefully. Qemu is a function
emulator so we need to make sure the function matches hardware
behaviour before it can be merged.

One way is to test via real hardware or involve Intel Engineers.

Thanks

>
> Thanks,
> Yong
>
>>
>>
>> Thanks
>>
>> >
>> > But at the moment, the logic of e1000_has_rx_bufs acts exactly like it=
 was
>> > the first case, unable to differentiate between the two scenarios.
>> >
>> >>
>> >>
>> >> Thanks
>> >>
>> >> >
>> >> >>
>> >> >> Adding more people.
>> >> >>
>> >> >> Thanks
>> >> >>
>> >> >
>> >> >
>> >> > --
>> >> > Best regards
>> >>
>> >
>> > Yong
>> >
>> > --
>> > Best regards
>>
>
>
> --
> Best regards


