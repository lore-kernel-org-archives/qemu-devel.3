Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29722C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sROFp-0002GV-Ml; Tue, 09 Jul 2024 23:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sROFn-00028J-Lq
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sROFl-0006L0-DM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720583062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0W/xKhN58Mn3v6IWzL5b297/K85pcHkLfWVHqsxJtE=;
 b=e2xLnlsiTvhratb9gDWOUo1I35WV1TglTEAr8J58ap4HJRCWuF/82ka4ZWK+Kpkf1VDMA0
 RfqXYf45e/CtmIesRk0567oJsHNhcjM18JW1nhqjlSGKbjsIBpGt+47E0M4QETRyg7rlpE
 5KHDrxBv0pOJFoXtiYhbhf/SsULYh3U=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-DjilQkPyOfuAge93RR-x3w-1; Tue, 09 Jul 2024 23:43:39 -0400
X-MC-Unique: DjilQkPyOfuAge93RR-x3w-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-70360b8d160so3318642a34.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720583018; x=1721187818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0W/xKhN58Mn3v6IWzL5b297/K85pcHkLfWVHqsxJtE=;
 b=msOMawtzEZK81aVmCDFgX9K1I5WfofM0EmDev+23TpGKAbHS3ClbL/2vCKCLIeU1nr
 0EXxvMFLFVL4s+OTLybOspOSRIjK7RYbxtfGWnWAqUyD7v6ii8QmyOiX1n0izLod7j9b
 +mfXQPrP7aCzizwY3Y4HEWd4HQBhaYYtjYnRNKa3xFMQAFCpgGNjpUQdKIC/GJerBLgJ
 /OS0ouJE6QAGiLo6Hy5BC5uqPND0v6qME4wK3tKpdmLspsB/3R08vn7ZdB82ZDApwzXu
 uMGQHGVU+Ie4AluBicu54D1jrsIrTVlegiwjvuFYb3icA8lHSaGnRoJOmtclFRMEb2e8
 +VnQ==
X-Gm-Message-State: AOJu0Yyyw1cCcPpLEPObqA2ZX32y27onkK0W6ietcsJPOmV8s2kY7KZ7
 SM/eVfjcQhHC8IWv2W86LzPF1BP27iroBxfW3DIUecgqWswYAAmroRuyQaa8S8RtoMg4Og29h4Q
 6xdx05OqRRDqtkq3asJuK9F+Yc9TnhyddKpCBKEuCrVhEkhhZDiCmUChjwxsuF6QQOngWE9Qdug
 JmE0fZbI6euBiUSG3m+TpABGW+y7xuh2TjiZ4=
X-Received: by 2002:a05:6830:11c2:b0:703:79b1:75e2 with SMTP id
 46e09a7af769-70379b17a43mr3692177a34.31.1720583018306; 
 Tue, 09 Jul 2024 20:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD7Qcr1BR7hdnyUKi+Q3kAKzG5n/Q0KEf3QgCaUB+CHZEKS4DjcZyVygRlyRlMevDFtZm4eRynkDpMxpOVTO0=
X-Received: by 2002:a05:6830:11c2:b0:703:79b1:75e2 with SMTP id
 46e09a7af769-70379b17a43mr3692164a34.31.1720583017908; Tue, 09 Jul 2024
 20:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
 <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
 <CAK9dgmb0K_TfbUt-WsPubDVAA7tuJQkQtWaf95JOc0CYvgMQ8A@mail.gmail.com>
 <CACGkMEv23TZNexfKUJ8MMVeRz2+2g316UNAQvEK+91jo5PkpBw@mail.gmail.com>
 <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
In-Reply-To: <CAK9dgmbqqD_LVWONdKm-Usj18cnxqbMo6VWpCAUqjS4VnTDxnw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:43:26 +0800
Message-ID: <CACGkMEt5bmg1eh8Tiurfzxb5a1GXECu_PmTQC5a_+sve2A2NUw@mail.gmail.com>
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

On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Yong Huang <yong.huang@smartx.com> =
wrote:
>
>
>
> On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
>>
>> On Mon, Jul 8, 2024 at 1:17=E2=80=AFPM Yong Huang <yong.huang@smartx.com=
> wrote:
>> >
>> >
>> >
>> > On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
>> >>
>> >> On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smartx=
.com> wrote:
>> >> >
>> >> > Unexpected work by certain Windows guests equipped with the e1000
>> >> > interface can cause the network to go down and never come back up
>> >> > again unless the guest's interface is reset.
>> >> >
>> >> > To reproduce the failure:
>> >> > 1. Set up two guests with a Windows 2016 or 2019 server operating
>> >> >    system.
>> >>
>> >> I vaguely remember e1000 support for Windows has been deprecated for
>> >> several years...
>> >>
>> >> That's why e1000e or igb is implemented in Qemu.
>> >>
>> >> > 2. Set up the e1000 interface for the guests.
>> >> > 3. Pressurize the network slightly between two guests using the iPe=
rf tool.
>> >> >
>> >> > The network goes down after a few days (2-5days), and the issue
>> >> > is the result of not adhering to the e1000 specification. Refer
>> >> > to the details of the specification at the following link:
>> >> > https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-c=
ontrollers-software-dev-manual.pdf
>> >> >
>> >> > Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
>> >> > as following:
>> >> > This register holds a value that is an offset from the base, and
>> >> > identifies the location beyond the last descriptor hardware can
>> >> > process. Note that tail should still point to an area in the
>> >> > descriptor ring (somewhere between RDBA and RDBA + RDLEN).
>> >> > This is because tail points to the location where software writes
>> >> > the first new descriptor.
>> >> >
>> >> > This means that if the provider=E2=80=94in this case, QEMU=E2=80=94=
has not yet
>> >> > loaded the packet,
>> >>
>> >> What do you mean by "load" here?
>> >
>> >
>> > Sorry for failing to describe the details.
>> >
>> > The guest driver retrieves the packet from the receive ring buffer
>> > after QEMU forwards it from the tun/tap interface in the e1000
>> > emulation.
>> >
>> > I used "load" to express "putting packets into the receive ring buffer=
."
>> >
>> >>
>> >>
>> >> > RDT should never point to that place.
>> >>
>> >> And "that place"?
>> >
>> > If a descriptor in the receive ring buffer has not been filled with a
>> > packet address by QEMU, the descriptor therefore doesn't have any
>> > available packets. The location of the descriptor should not be referr=
ed
>> > to by RDT because the location is in the range that "hardware" handles=
.
>> >
>> > "that place" means the location of the descriptor in the ring buffer
>> > that QEMU hasn't set any available packets related to.
>> >
>> >>
>> >>
>> >> > When
>> >> > implementing the emulation of the e1000 interface, QEMU evaluates
>> >> > if the receive ring buffer is full once the RDT equals the RDH,
>> >> > based on the assumption that guest drivers adhere to this
>> >> > criterion strictly.
>> >> >
>> >> > We applied the following log patch to assist in analyzing the
>> >> > issue and eventually obtained the unexpected information.
>> >> >
>> >> > Log patch:
>> >> > -----------------------------------------------------------------
>> >> > |--- a/hw/net/e1000.c
>> >> > |+++ b/hw/net/e1000.c
>> >> > |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
>> >> > | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
>> >> > | {
>> >> > |     int bufs;
>> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->m=
ac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->=
mac_reg[RDT]);
>> >> > |+
>> >> > |     /* Fast-path short packets */
>> >> > |     if (total_size <=3D s->rxbuf_size) {
>> >> > |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_ove=
rrun)
>> >> > |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const =
struct iovec *iov, int iovcnt)
>> >> > |         s->rxbuf_min_shift)
>> >> > |         n |=3D E1000_ICS_RXDMT0;
>> >> > |
>> >> > |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->m=
ac_reg[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
>> >> > |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->=
mac_reg[RDT]);
>> >> > |+
>> >> > -----------------------------------------------------------------
>> >> >
>> >> > The last few logs of information when the network is down:
>> >> >
>> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
>> >> > <- the receive ring buffer is checked for fullness in the
>> >> > e1000_has_rxbufs function, not full.
>> >> >
>> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> > <- RDT stays the same, RDH updates to 898, and 1 descriptor
>> >> > utilized after putting the packet to ring buffer.
>> >> >
>> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
>> >> > <- the receive ring buffer is checked for fullness in the
>> >> > e1000_has_rxbufs function, not full.
>> >> >
>> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> > <- RDT stays the same, RDH updates to 899, and 1 descriptor
>> >> > utilized after putting the packet to ring buffer.
>> >> >
>> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
>> >> > <- the receive ring buffer is checked for fullness in the
>> >> > e1000_has_rxbufs function, not full.
>> >> >
>> >> > e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =
=3D 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
>> >> > <- RDT stays the same, RDH updates to 900 , and 1 descriptor
>> >> > utilized after putting the packet to ring buffer.
>> >> >
>> >> > e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D=
 16384, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
>> >> > <- The ring is full, according to e1000_has_rxbufs, because
>> >> > of the RDT update to 900 and equals RDH !
>> >>
>> >> Just to make sure I understand this, RDT=3D=3DRDH means the ring is e=
mpty I think?
>> >>
>> >>
>> >> See commit:
>> >>
>> >> commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
>> >> Author: Dmitry Fleytman <dmitry@daynix.com>
>> >> Date:   Fri Oct 19 07:56:55 2012 +0200
>> >>
>> >>     e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RDT =
as empty
>> >>
>> >>     Real HW always treats RX ring with RDH =3D=3D RDT as empty.
>> >>     Emulation is supposed to behave the same.
>> >
>> >
>> > Indeed, I'm confused :(,  the description in the comment claims that R=
X
>> > rings with RDH =3D=3D RDT as empty, but in implementation, it treats t=
hat as
>> > overrun.
>> >
>> > See the following 2 contexts:
>> >
>> > 1. e1000_can_receive:
>> > static bool e1000_can_receive(NetClientState *nc)
>> > {
>> >     E1000State *s =3D qemu_get_nic_opaque(nc);
>> >     // e1000_has_rxbufs return true means ring buffer has
>> >     // available descriptors to use for QEMU.
>> >     // false means ring buffer overrun and QEMU should queue the packe=
t
>> >     // and wait for the RDT update and available descriptors can be us=
ed.
>> >
>> >     return e1000x_rx_ready(&s->parent_obj, s->mac_reg) &&
>> >         e1000_has_rxbufs(s, 1) && !timer_pending(s->flush_queue_timer)=
;
>> > }
>>
>> Well we had in e1000_has_rx_bufs
>>
>>     if (total_size <=3D s->rxbuf_size) {
>>         return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
>>     }
>>
>> RDT!=3DRDH means RX ring has available descriptors for hardware?
>
>
> IMHO, Yes.

Just to make sure we are on the same page, so

RDT!=3DRDH, descriptors available for hardware
RDT=3D=3DRDH, descriptor ring is empty for hardware

That is currently what the code did. Seems nothing wrong, or anything
I missed here?

Thanks

>
>>
>> Adding more people.
>>
>> Thanks
>>
>
>
> --
> Best regards


