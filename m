Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9395BC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgt1-0002Xt-10; Mon, 08 Jul 2024 01:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQgsx-0002X6-De
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:25:59 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQgst-0002rr-FF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:25:59 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c661e75ff6so1159777eaf.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720416353; x=1721021153;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Uu6JhmRCdRn53oqvN+C+sPcazpeb16i6PQ2iwTVNd4=;
 b=G5IFX1hVLAIZ9YhUy+Wjyg9hXEKbmCLq2uSbCoqM04byoZRGS6VV05Ynt1FPMRxwf0
 UNq4Due/OLcVTYbxd29YWuDh4zziSfUY0DICBF+MSd//JMnq3VMuihxW3XiZUfaAorQm
 bgof4ykuiP3H6E64xhG7obo6+RgEFtsdLdevbV+YD5tkcWZYTzh1CG2TWFbklYr0tlXi
 3sHSvDdy60kV4IHMjyppuiN4Yo3CFKLWV19jlHGB06gqgwhycl9XWgI5XmmHRYBgW3gP
 hzslLGb3C7KFfUqTeHLjwP6TAJqTaOCtfDaZ0HONKM7287JeGU9Aw8zLl4DhL5lsmLOy
 6JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720416353; x=1721021153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Uu6JhmRCdRn53oqvN+C+sPcazpeb16i6PQ2iwTVNd4=;
 b=jtJcSv1VDcuSAsa24gr+Hqjpr1qJFzGf4S+T+4YrpnKu+ofj0uDQkDSy3WtZ+w2Vms
 UmuXKpC3nCrSdX/40IOafo8y706iAj6Pp8WZ6DTYW0OC+hU490eTr9H4lYNOSmd7Mw+E
 nJbATg5Gl1/KD4kAmaTFX4pNgQTAwQRGo5d4YqLgOxBl+SqQgCczIP9SCK9AHd6Z+d7W
 ucnrLkFIbV1N5XQlBvyz1l+FmzpfPcszIpoyNkwR1pcT3QwwHke2bHL9ZN/xzpDhZO4a
 m9UzppY4MBIVZTvSkyRVmU3Ecf8wBIen1wZu39PKm34eXF+WwvXbj4RM0HTEi2UGomTJ
 I9LQ==
X-Gm-Message-State: AOJu0YwUVVh09BPAQodymHCy6hMzYMAf/bP6KIHBXGrDyqgGfibNrv3Y
 gTYtMjWNmk1X+S1RKN6KlgUHMwLBJwYa/2QjO3JW3LhJC+FKvebnhVXzNa7Xy3n72fGGm1tPmCf
 D4+ATONWnfARYz5mwRoOW/z21wyKWQB/ct2i5znaHJN4HtgH/1/XBAOHT
X-Google-Smtp-Source: AGHT+IECia6Sl4vyDB1iOF9R6Xp/rp6mUXwCJqXa2VBL5ec3TsnNBf0cT0xHdbNJgQN1tLNxijSde6JGREiVB+6DBtY=
X-Received: by 2002:a05:6870:40c4:b0:250:6a57:e1d3 with SMTP id
 586e51a60fabf-25e2bec97d6mr10204628fac.38.1720416352600; Sun, 07 Jul 2024
 22:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
In-Reply-To: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 8 Jul 2024 13:25:36 +0800
Message-ID: <CAK9dgmaC3DiqWmf+OWURjZ=XOQbYLFdOuUS6_cESJyRDzxiJig@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000902076061cb5a508"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc31.google.com
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

--000000000000902076061cb5a508
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smartx.com> =
wrote:

> Unexpected work by certain Windows guests equipped with the e1000
> interface can cause the network to go down and never come back up
> again unless the guest's interface is reset.
>
> To reproduce the failure:
> 1. Set up two guests with a Windows 2016 or 2019 server operating
>    system.
> 2. Set up the e1000 interface for the guests.
> 3. Pressurize the network slightly between two guests using the iPerf too=
l.
>
> The network goes down after a few days (2-5days), and the issue
> is the result of not adhering to the e1000 specification. Refer
> to the details of the specification at the following link:
>
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
>
> Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
> as following:
> This register holds a value that is an offset from the base, and
> identifies the location beyond the last descriptor hardware can
> process. Note that tail should still point to an area in the
> descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> This is because tail points to the location where software writes
> the first new descriptor.
>
> This means that if the provider=E2=80=94in this case, QEMU=E2=80=94has no=
t yet
> loaded the packet, RDT should never point to that place. When
> implementing the emulation of the e1000 interface, QEMU evaluates
> if the receive ring buffer is full once the RDT equals the RDH,
> based on the assumption that guest drivers adhere to this
> criterion strictly.
>
> We applied the following log patch to assist in analyzing the
> issue and eventually obtained the unexpected information.
>
> Log patch:
> -----------------------------------------------------------------
> |--- a/hw/net/e1000.c
> |+++ b/hw/net/e1000.c
> |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
> | {
> |     int bufs;
> |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->mac_reg=
[RDH]
> =3D %u, s->mac_reg[RDT] =3D %u\n",
> |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> |+
> |     /* Fast-path short packets */
> |     if (total_size <=3D s->rxbuf_size) {
> |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_overrun)
> |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const struct
> iovec *iov, int iovcnt)
> |         s->rxbuf_min_shift)
> |         n |=3D E1000_ICS_RXDMT0;
> |
> |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->mac_reg=
[RDH]
> =3D %u, s->mac_reg[RDT] =3D %u\n",
> |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH],
> s->mac_reg[RDT]);
> |+
> -----------------------------------------------------------------
>
> The last few logs of information when the network is down:
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
,
> s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 898, and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
,
> s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 899, and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
,
> s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
,
> s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> <- The ring is full, according to e1000_has_rxbufs, because
> of the RDT update to 900 and equals RDH ! But in reality,
> the state of the ring buffer is empty because the producer
> only used one descriptor the last time, and the ring buffer
> was not full after that.
>
> To sum up, QEMU claims that the receive ring buffer is full
> in the aforementioned scenario, placing the packet in the
> self-maintained queue and unregistering the tap device's
> readable fd handler and then waiting for the guest to consume
> the receive ring buffer. This brings down the network since
> guests have nothing to consume and never update the RDT
> location.
>
> In the above scenario, QEMU assert that the ring is full,
> put the packet on the queue, unregister the readable fd
> handler of the tap device, waiting the guest to consume
> the receive ring. While, guest have nothing to consume
> on the receive ring and never update the RDT location,
> this makes the network down.
>
> To get around this issue, just mark the overrun if RDH
> equals RDT at the end of placing the packet on the ring
> buffer for the producer.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/net/e1000.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 5012b96464..f80cb70283 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -126,6 +126,12 @@ struct E1000State_st {
>
>      QEMUTimer *flush_queue_timer;
>
> +    /*
> +     * Indicate that the receive circular buffer queue overrun
> +     * the last time hardware produced packets.
> +     */
> +    bool last_overrun;
> +
>  /* Compatibility flags for migration to/from qemu 1.3.0 and older */
>  #define E1000_FLAG_MAC_BIT 2
>  #define E1000_FLAG_TSO_BIT 3
> @@ -832,7 +838,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t
> total_size)
>      int bufs;
>      /* Fast-path short packets */
>      if (total_size <=3D s->rxbuf_size) {
> -        return s->mac_reg[RDH] !=3D s->mac_reg[RDT];
> +        if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_overrun) {
> +            return false;
> +        }
> +
> +        DBGOUT(RX, "Receive ring buffer is not full unexpectedly!\n");
>

I'll drop this DBGOUT in the next version now that "treat RX ring with RDH
=3D=3D RDT as empty"
is the expected and original conclusion in commit:

commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
Author: Dmitry Fleytman <dmitry@daynix.com>
Date:   Fri Oct 19 07:56:55 2012 +0200

    e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RDT as emp=
ty

    Real HW always treats RX ring with RDH =3D=3D RDT as empty.
    Emulation is supposed to behave the same.

    Reported-by: Chris Webb <chris.webb@elastichosts.com>
    Reported-by: Richard Davies <richard.davies@elastichosts.com>
    Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


> +        return true;
>      }
>      if (s->mac_reg[RDH] < s->mac_reg[RDT]) {
>          bufs =3D s->mac_reg[RDT] - s->mac_reg[RDH];
> @@ -840,7 +851,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t
> total_size)
>          bufs =3D s->mac_reg[RDLEN] /  sizeof(struct e1000_rx_desc) +
>              s->mac_reg[RDT] - s->mac_reg[RDH];
>      } else {
> -        return false;
> +        if (s->last_overrun) {
> +            return false;
> +        }
> +
> +        DBGOUT(RX, "Receive ring buffer is not full unexpectedly!\n");
> +        return true;
>      }
>      return total_size <=3D bufs * s->rxbuf_size;
>  }
> @@ -999,6 +1015,8 @@ e1000_receive_iov(NetClientState *nc, const struct
> iovec *iov, int iovcnt)
>
>      e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size)=
;
>
> +    s->last_overrun =3D (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT]) ? true =
: false;
> +
>      n =3D E1000_ICS_RXT0;
>      if ((rdt =3D s->mac_reg[RDT]) < s->mac_reg[RDH])
>          rdt +=3D s->mac_reg[RDLEN] / sizeof(desc);
> --
> 2.39.1
>
>

--=20
Best regards

--000000000000902076061cb5a508
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 6, 202=
4 at 4:30=E2=80=AFAM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m">yong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Unexpecte=
d work by certain Windows guests equipped with the e1000<br>
interface can cause the network to go down and never come back up<br>
again unless the guest&#39;s interface is reset.<br>
<br>
To reproduce the failure:<br>
1. Set up two guests with a Windows 2016 or 2019 server operating<br>
=C2=A0 =C2=A0system.<br>
2. Set up the e1000 interface for the guests.<br>
3. Pressurize the network slightly between two guests using the iPerf tool.=
<br>
<br>
The network goes down after a few days (2-5days), and the issue<br>
is the result of not adhering to the e1000 specification. Refer<br>
to the details of the specification at the following link:<br>
<a href=3D"https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gb=
e-controllers-software-dev-manual.pdf" rel=3D"noreferrer" target=3D"_blank"=
>https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controll=
ers-software-dev-manual.pdf</a><br>
<br>
Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)<br>
as following:<br>
This register holds a value that is an offset from the base, and<br>
identifies the location beyond the last descriptor hardware can<br>
process. Note that tail should still point to an area in the<br>
descriptor ring (somewhere between RDBA and RDBA + RDLEN).<br>
This is because tail points to the location where software writes<br>
the first new descriptor.<br>
<br>
This means that if the provider=E2=80=94in this case, QEMU=E2=80=94has not =
yet<br>
loaded the packet, RDT should never point to that place. When<br>
implementing the emulation of the e1000 interface, QEMU evaluates<br>
if the receive ring buffer is full once the RDT equals the RDH,<br>
based on the assumption that guest drivers adhere to this<br>
criterion strictly.<br>
<br>
We applied the following log patch to assist in analyzing the<br>
issue and eventually obtained the unexpected information.<br>
<br>
Log patch:<br>
-----------------------------------------------------------------<br>
|--- a/hw/net/e1000.c<br>
|+++ b/hw/net/e1000.c<br>
|@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)<br>
| static bool e1000_has_rxbufs(E1000State *s, size_t total_size)<br>
| {<br>
|=C2=A0 =C2=A0 =C2=A0int bufs;<br>
|+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLEN] =
=3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br>
|+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac_reg[=
RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
|+<br>
|=C2=A0 =C2=A0 =C2=A0/* Fast-path short packets */<br>
|=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_size) {<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[RDH] =3D=3D s-&gt;mac_=
reg[RDT] &amp;&amp; s-&gt;last_overrun)<br>
|@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const struct i=
ovec *iov, int iovcnt)<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_min_shift)<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n |=3D E1000_ICS_RXDMT0;<br>
|<br>
|+=C2=A0 =C2=A0 DBGOUT(RX, &quot;rxbuf_size =3D %u, s-&gt;mac_reg[RDLEN] =
=3D %u, s-&gt;mac_reg[RDH] =3D %u, s-&gt;mac_reg[RDT] =3D %u\n&quot;,<br>
|+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size, s-&gt;mac_reg[=
RDLEN], s-&gt;mac_reg[RDH], s-&gt;mac_reg[RDT]);<br>
|+<br>
-----------------------------------------------------------------<br>
<br>
The last few logs of information when the network is down:<br>
<br>
e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 1638=
4, s-&gt;mac_reg[RDH] =3D 897, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- the receive ring buffer is checked for fullness in the<br>
e1000_has_rxbufs function, not full.<br>
<br>
e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 163=
84, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- RDT stays the same, RDH updates to 898, and 1 descriptor<br>
utilized after putting the packet to ring buffer.<br>
<br>
e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 1638=
4, s-&gt;mac_reg[RDH] =3D 898, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- the receive ring buffer is checked for fullness in the<br>
e1000_has_rxbufs function, not full.<br>
<br>
e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 163=
84, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- RDT stays the same, RDH updates to 899, and 1 descriptor<br>
utilized after putting the packet to ring buffer.<br>
<br>
e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 1638=
4, s-&gt;mac_reg[RDH] =3D 899, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- the receive ring buffer is checked for fullness in the<br>
e1000_has_rxbufs function, not full.<br>
<br>
e1000: total_size =3D 64, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 163=
84, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 885<br>
&lt;- RDT stays the same, RDH updates to 900 , and 1 descriptor<br>
utilized after putting the packet to ring buffer.<br>
<br>
e1000: total_size =3D 1, rxbuf_size =3D 2048, s-&gt;mac_reg[RDLEN] =3D 1638=
4, s-&gt;mac_reg[RDH] =3D 900, s-&gt;mac_reg[RDT] =3D 900<br>
&lt;- The ring is full, according to e1000_has_rxbufs, because<br>
of the RDT update to 900 and equals RDH ! But in reality,<br>
the state of the ring buffer is empty because the producer<br>
only used one descriptor the last time, and the ring buffer<br>
was not full after that.<br>
<br>
To sum up, QEMU claims that the receive ring buffer is full<br>
in the aforementioned scenario, placing the packet in the<br>
self-maintained queue and unregistering the tap device&#39;s<br>
readable fd handler and then waiting for the guest to consume<br>
the receive ring buffer. This brings down the network since<br>
guests have nothing to consume and never update the RDT<br>
location.<br>
<br>
In the above scenario, QEMU assert that the ring is full,<br>
put the packet on the queue, unregister the readable fd<br>
handler of the tap device, waiting the guest to consume<br>
the receive ring. While, guest have nothing to consume<br>
on the receive ring and never update the RDT location,<br>
this makes the network down.<br>
<br>
To get around this issue, just mark the overrun if RDH<br>
equals RDT at the end of placing the packet on the ring<br>
buffer for the producer.<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0hw/net/e1000.c | 22 ++++++++++++++++++++--<br>
=C2=A01 file changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/net/e1000.c b/hw/net/e1000.c<br>
index 5012b96464..f80cb70283 100644<br>
--- a/hw/net/e1000.c<br>
+++ b/hw/net/e1000.c<br>
@@ -126,6 +126,12 @@ struct E1000State_st {<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *flush_queue_timer;<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Indicate that the receive circular buffer queue over=
run<br>
+=C2=A0 =C2=A0 =C2=A0* the last time hardware produced packets.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 bool last_overrun;<br>
+<br>
=C2=A0/* Compatibility flags for migration to/from qemu 1.3.0 and older */<=
br>
=C2=A0#define E1000_FLAG_MAC_BIT 2<br>
=C2=A0#define E1000_FLAG_TSO_BIT 3<br>
@@ -832,7 +838,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t tot=
al_size)<br>
=C2=A0 =C2=A0 =C2=A0int bufs;<br>
=C2=A0 =C2=A0 =C2=A0/* Fast-path short packets */<br>
=C2=A0 =C2=A0 =C2=A0if (total_size &lt;=3D s-&gt;rxbuf_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;mac_reg[RDH] !=3D s-&gt;mac_reg[R=
DT];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;mac_reg[RDH] =3D=3D s-&gt;mac_reg[RD=
T] &amp;&amp; s-&gt;last_overrun) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(RX, &quot;Receive ring buffer is not fu=
ll unexpectedly!\n&quot;);<br></blockquote><div><br></div><div><div class=
=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">I&#39;ll drop thi</span><font face=3D"comic sans ms, sans-serif">s=
=C2=A0DBGOUT in the</font><span style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif">=C2=A0next version now that </span><font face=3D"comic sans=
 ms, sans-serif">&quot;treat RX ring with RDH =3D=3D RDT as empty&quot;</fo=
nt></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-ser=
if">is=C2=A0</font><span style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">the expected and original conclusion in commit:</span></div><div s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_de=
fault"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif" class=3D"gmail_default"><span style=3D"font-family:Arial,Helvetica,sa=
ns-serif">commit e5b8b0d4ba29fe1268ba049519a1b0</span><span style=3D"font-f=
amily:Arial,Helvetica,sans-serif">cf8552a21a</span><br style=3D"font-family=
:Arial,Helvetica,sans-serif"><span style=3D"font-family:Arial,Helvetica,san=
s-serif">Author: Dmitry Fleytman &lt;</span><a href=3D"mailto:dmitry@daynix=
.com" target=3D"_blank" style=3D"font-family:Arial,Helvetica,sans-serif">dm=
itry@daynix.com</a><span style=3D"font-family:Arial,Helvetica,sans-serif">&=
gt;</span><br style=3D"font-family:Arial,Helvetica,sans-serif"><span style=
=3D"font-family:Arial,Helvetica,sans-serif">Date:=C2=A0 =C2=A0Fri Oct 19 07=
:56:55 2012 +0200</span><br style=3D"font-family:Arial,Helvetica,sans-serif=
"><br style=3D"font-family:Arial,Helvetica,sans-serif"><span style=3D"font-=
family:Arial,Helvetica,sans-serif">=C2=A0 =C2=A0 e1000: drop check_rxov, al=
ways treat RX ring with RDH =3D=3D RDT as empty</span><br style=3D"font-fam=
ily:Arial,Helvetica,sans-serif"><br style=3D"font-family:Arial,Helvetica,sa=
ns-serif"><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=A0 =C2=
=A0 Real HW always treats RX ring with RDH =3D=3D RDT as empty.</span><br s=
tyle=3D"font-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:=
Arial,Helvetica,sans-serif">=C2=A0 =C2=A0 Emulation is supposed to behave t=
he same.</span><br style=3D"font-family:Arial,Helvetica,sans-serif"><br sty=
le=3D"font-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:Ar=
ial,Helvetica,sans-serif">=C2=A0 =C2=A0 Reported-by: Chris Webb &lt;</span>=
<a href=3D"mailto:chris.webb@elastichosts.com" target=3D"_blank" style=3D"f=
ont-family:Arial,Helvetica,sans-serif">chris.webb@elastichosts.com</a><span=
 style=3D"font-family:Arial,Helvetica,sans-serif">&gt;</span><br style=3D"f=
ont-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:Arial,Hel=
vetica,sans-serif">=C2=A0 =C2=A0 Reported-by: Richard Davies &lt;</span><a =
href=3D"mailto:richard.davies@elastichosts.com" target=3D"_blank" style=3D"=
font-family:Arial,Helvetica,sans-serif">richard.davies@elastichosts.com</a>=
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;</span><br style=
=3D"font-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:Aria=
l,Helvetica,sans-serif">=C2=A0 =C2=A0 Signed-off-by: Dmitry Fleytman &lt;</=
span><a href=3D"mailto:dmitry@daynix.com" target=3D"_blank" style=3D"font-f=
amily:Arial,Helvetica,sans-serif">dmitry@daynix.com</a><span style=3D"font-=
family:Arial,Helvetica,sans-serif">&gt;</span><br style=3D"font-family:Aria=
l,Helvetica,sans-serif"><span style=3D"font-family:Arial,Helvetica,sans-ser=
if">=C2=A0 =C2=A0 Signed-off-by: Stefan Hajnoczi &lt;</span><a href=3D"mail=
to:stefanha@redhat.com" target=3D"_blank" style=3D"font-family:Arial,Helvet=
ica,sans-serif">stefanha@redhat.com</a><span style=3D"font-family:Arial,Hel=
vetica,sans-serif">&gt;</span></div></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[RDH] &lt; s-&gt;mac_reg[RDT]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufs =3D s-&gt;mac_reg[RDT] - s-&gt;mac_r=
eg[RDH];<br>
@@ -840,7 +851,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t tot=
al_size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufs =3D s-&gt;mac_reg[RDLEN] /=C2=A0 siz=
eof(struct e1000_rx_desc) +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mac_reg[RDT] - s-&gt;=
mac_reg[RDH];<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;last_overrun) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(RX, &quot;Receive ring buffer is not fu=
ll unexpectedly!\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return total_size &lt;=3D bufs * s-&gt;rxbuf_size;<br>
=C2=A0}<br>
@@ -999,6 +1015,8 @@ e1000_receive_iov(NetClientState *nc, const struct iov=
ec *iov, int iovcnt)<br>
<br>
=C2=A0 =C2=A0 =C2=A0e1000x_update_rx_total_stats(s-&gt;mac_reg, pkt_type, s=
ize, total_size);<br>
<br>
+=C2=A0 =C2=A0 s-&gt;last_overrun =3D (s-&gt;mac_reg[RDH] =3D=3D s-&gt;mac_=
reg[RDT]) ? true : false;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0n =3D E1000_ICS_RXT0;<br>
=C2=A0 =C2=A0 =C2=A0if ((rdt =3D s-&gt;mac_reg[RDT]) &lt; s-&gt;mac_reg[RDH=
])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdt +=3D s-&gt;mac_reg[RDLEN] / sizeof(de=
sc);<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000902076061cb5a508--

