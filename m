Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA7d-0002Bj-L6; Wed, 28 Oct 2026 16:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xMA7a-0002B3-VU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:19:42 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xMA7Y-0002WA-QV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:19:42 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xMA7P-00000007Qkh-0VWw; Wed, 28 Oct 2026 21:19:31 +0100
Message-ID: <c1e606e3-9ec7-4727-86cc-3b3cf9f18bd4@maciej.szmigiero.name>
Date: Wed, 28 Oct 2026 21:19:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv/vmbus: allow receiving outside the channel
 notify callback
To: Refael Mantsur <Refael-M@hotmail.com>
References: <LV5PR84MB40263D472C5CF968889420A9968D2@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <LV5PR84MB40263D472C5CF968889420A9968D2@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28.09.2026 07:59, Refael Mantsur wrote:
> hv-balloon runs its event loop, including the receive path, from contexts
> other than the VMBus channel notify callback: the QMP "balloon" handler
> (hv_balloon_to_target()), the post-init timer and the open/close/reset
> paths. Receiving is only legal between ringbuf_start_io() and
> ringbuf_end_io(), which channel_event_cb() provides for the notify path.
> When the receive ring is empty, vmbus_channel_recv_peek() returns before
> seeking, so this is usually harmless. When the guest has just posted a
> Dynamic Memory message (e.g. the periodic STATUS report, or the response
> to a previous hot-add) and the QMP "balloon" command arrives before the
> notifier runs, QEMU aborts:
>    hw/hyperv/vmbus.c:418: gpadl_iter_seek: Assertion `iter->active' failed.
> Seen with a Windows Server 2022 guest (Hyper-V Dynamic Memory driver),
> hv-balloon with a memdev and status-report=on, and a host-side controller
> issuing a few "balloon" commands within a minute while an RDP user logged
> in (the guest's committed memory jumped and hot-adds were in flight).
> Make vmbus_channel_recv_start() start the ring I/O itself when it is
> called outside the notify callback, remember that in the receive ring,
> and end it in vmbus_channel_recv_done() (or right away if recv_start()
> fails). The notify-callback path is unchanged.
> Signed-off-by: FULL NAME <refael-m@hotmail.com>

                  ^^^^^^^^^ that looks wrong

It looks like your message arrived as a quoted-printable attachment,
probably mangled by Outlook.
GIT-SEND-EMAIL(1) should normally take care of sending a patch in the
proper format.

A nit there: it would greatly help readability to divide that commit
message into separate paragraphs and have an empty line before that
Signed-off-by.

> ---
>   hw/hyperv/vmbus.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 47 insertions(+), 2 deletions(-)
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -121,6 +121,12 @@
>       uint32_t last_rd_idx;
>       /* last seen write index */
>       uint32_t last_seen_wr_idx;
> +    /*
> +     * recv_start was called outside the channel notify callback (e.g. from a
> +     * QMP-triggered device path such as hv-balloon's balloon target change),
> +     * so it started the I/O on the ring itself and recv_done must end it.
> +     */
> +    bool own_io;
>   } VMBusRecvRingBuf;
> @@ -1113,7 +1119,7 @@
>       return req;
>   }
> -int vmbus_channel_recv_start(VMBusChannel *chan)
> +static int vmbus_channel_recv_start_io(VMBusChannel *chan)
>   {
>       VMBusRecvRingBuf *ringbuf = &chan->recv_ringbuf;
>       vmbus_ring_buffer *rb;
> @@ -1132,6 +1138,33 @@
>       /* prevent reorder of the following data operation with write_index read */
>       smp_mb();                   /* barrier pair [C] */
>       return 0;
> +}
> +
> +int vmbus_channel_recv_start(VMBusChannel *chan)
> +{
> +    VMBusRecvRingBuf *ringbuf = &chan->recv_ringbuf;
> +    bool own_io = false;
> +    int ret;
> +
> +    /*
> +     * Receives normally happen within channel_event_cb(), which brackets them
> +     * with ringbuf_start_io()/ringbuf_end_io().  Device code may also receive
> +     * from other contexts (hv-balloon does from its QMP balloon handler); make
> +     * that safe instead of tripping the iter->active assertion in
> +     * gpadl_iter_seek() when a packet is pending.
> +     */
> +    if (!ringbuf->common.iter.active) {
> +        ringbuf_start_io(&ringbuf->common);
> +        own_io = true;
> +    }
> +
> +    ret = vmbus_channel_recv_start_io(chan);
> +    if (ret && own_io) {
> +        ringbuf_end_io(&ringbuf->common);
> +        own_io = false;
> +    }
> +    ringbuf->own_io = own_io;
> +    return ret;
>   }
>   void *vmbus_channel_recv_peek(VMBusChannel *chan, uint32_t size)
> @@ -1208,7 +1241,7 @@
>       ringbuf->rd_idx = ringbuf_tell(&ringbuf->common);
>   }
> -ssize_t vmbus_channel_recv_done(VMBusChannel *chan)
> +static ssize_t vmbus_channel_recv_done_io(VMBusChannel *chan)
>   {
>       VMBusRecvRingBuf *ringbuf = &chan->recv_ringbuf;
>       vmbus_ring_buffer *rb;
> @@ -1266,6 +1299,18 @@
>       ringbuf_unmap_hdr(&ringbuf->common, rb, true);
>       ringbuf->last_rd_idx = ringbuf->rd_idx;
>       return read;
> +}
> +
> +ssize_t vmbus_channel_recv_done(VMBusChannel *chan)
> +{
> +    VMBusRecvRingBuf *ringbuf = &chan->recv_ringbuf;
> +    ssize_t ret = vmbus_channel_recv_done_io(chan);
> +
> +    if (ringbuf->own_io) {
> +        ringbuf_end_io(&ringbuf->common);
> +        ringbuf->own_io = false;
> +    }
> +    return ret;
>   }
>   void vmbus_free_req(void *req)
> 

It looks like there should be an easier way to do it by adding
something like "do_recv" boolean parameter to hv_balloon_event_loop(),
skipping the hv_balloon_event_loop_recv() call there if
this parameter is false.

Then hv_balloon_event_loop() will be called with do_recv = false
from everywhere but hv_balloon_vmdev_chan_notify().

Care to submit an updated patch?

Thanks,
Maciej


