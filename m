Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B83CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc14m-0005OR-8G; Tue, 23 Jun 2026 09:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc14j-0005F9-0P
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc14h-0000A6-6Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782220918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bxren5Tg/q14ssji391As81Wg+07CMYH07jWoQV4Dm8=;
 b=Pxm2fUN3f0C4zjgUNaQdVzoCGz8HKzVkz0uBj8pmkg5irPHqCIR1Ud6jT1kIfgtQDZ27Et
 42978xg0e/I9WJGtfIj/EPGq7xWlPFYEYyWC4JDG/3UENL/AYR2WJdI9hszs5zYX5d6IMS
 eadzFFRvJPtmcVnHE+ixh/JnPZiFljU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-BJIalF5oPCqEzSrV4ogk8Q-1; Tue, 23 Jun 2026 09:21:55 -0400
X-MC-Unique: BJIalF5oPCqEzSrV4ogk8Q-1
X-Mimecast-MFC-AGG-ID: BJIalF5oPCqEzSrV4ogk8Q_1782220914
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c081f1976d2so497895966b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782220914; x=1782825714; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bxren5Tg/q14ssji391As81Wg+07CMYH07jWoQV4Dm8=;
 b=YRS6L7jUSH77CEMHkGWUusQUaf3zyItsnl4H9IF+9MunwPfzYBFN9E7flEAcb4QQoc
 FD1q/heoJhgwI+RXnh0CqFj/5xD3/Be3J1/x2jpnCO4ISEhpSnkiXyABiv2ZXNqyJLag
 qcAUfPIfYssbUEO5Ry6FP6Cc+1EEefWeqCmEhFDxpsSpv7jOyDjbzyMfWQLEUBgOImtu
 HyLKQi2dZBe4B3l4LMgobp6rhJfJz8XNMZYIYiwMkih6reRjzELE+BQlI6Wh29sJ35br
 K44J4KDHvJkpEtuoQIeDvlq3VeGU7qVv7ppXHAFLMw37wYuKxYnoCX2SUeSc0PsXP0xe
 xShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220914; x=1782825714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bxren5Tg/q14ssji391As81Wg+07CMYH07jWoQV4Dm8=;
 b=YNbo/38zcinqW+KxYX3vF4ab85uI99wfjRTj1saOWYUDsCw0utTQDalD5AttREDKm3
 yh4PatBZQmBBMJxNWRu46Kvw228wZutliaakLUWVQAxG1jzKntjWfpqC8sftIA1800G1
 0PF/pp5m9RvA4vZuXuRFJqWv6UlIwtmygsirWwfKiMPseDHyMw1kVpUmiWyjgeGDj0UT
 nsM6SSivG5NCJ2gyOmnKYNV7gVgtxESQkHYA8SnRiRwTLPjkTOabYHTBHnpoKU9oCejd
 sMW4UPHn9Upxl0cWpSvccf5vLM6lKis2RLYZ/VNC986aw8WbdgXKu4CENP8Tx2sReKEo
 mtYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bUYgoZdknPd7XH0VUmHTt8SE1Bzc8JMu1sbtGXdRY91OYZUG4Ehw30J5XP1X8kycuTp7l3uTgZWCl@nongnu.org
X-Gm-Message-State: AOJu0YxAcAJHWfThEC2AM7snhPTU+qxbYOoMBRqQePZ1Xrcn9FpKrxy9
 g2VsEh7G+accTX+zNRKY5Hc17fwks1jLJYdpdyuxeI+bPrFzlHvJHaJPStf3ivK+hqimtsLzFqe
 HhPD0RPHQ72smcvcJoQ3OO2uzAJM/KUXY3/5AZtLRH1hBUlZgRs+xDd6l
X-Gm-Gg: AfdE7ckRJfFAIW7SkP4AJmixAMmB/KjliILGpsQdtPNjGVRx9gMAfWKKnwmLeYfohtU
 8UID9+2SnOWVOQSG8QNf78pF1KvOWxayXTBstExuieAddCPsMrbifHU4uEcpsLGd6Tob8IOHJaL
 fwEa3TgHob5kCjdkufmTLx6A3nxn33j73JzcKCzHOJZNob7Zg5CvSeNiYa5Q61I460sX00W79/x
 Mlsjb0XXcNZb5kEPNKhGMK5okYxhHIgBbGxfK1iFcUg2rBKHbY7HsuikDm0k51S8XBw/lKbpRHW
 eEOkDVk/RW5SPtoDA5R5d5GScxXkPfjvpYKVwgj+X1GEadjQxBRJ+aR6JaK7S7OBEeaa1r+WxQy
 q78e7caqFpkpfbkVWm8orA+yfORLQWmC0
X-Received: by 2002:a17:907:3e9b:b0:c07:5319:4c39 with SMTP id
 a640c23a62f3a-c097adfe5d3mr1025551566b.6.1782220913613; 
 Tue, 23 Jun 2026 06:21:53 -0700 (PDT)
X-Received: by 2002:a17:907:3e9b:b0:c07:5319:4c39 with SMTP id
 a640c23a62f3a-c097adfe5d3mr1025545766b.6.1782220912849; 
 Tue, 23 Jun 2026 06:21:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f56aasm34928008f8f.6.2026.06.23.06.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:21:52 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:21:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <20260623091744-mutt-send-email-mst@kernel.org>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
 <20260623083557-mutt-send-email-mst@kernel.org>
 <ajqB9ujvC6MXSRpG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajqB9ujvC6MXSRpG@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 23, 2026 at 01:54:14PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jun 23, 2026 at 08:36:30AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 22, 2026 at 05:30:33PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > > > A malicious guest can craft virtqueue descriptors with arbitrary lengths.
> > > > control_out() calls iov_size() on the guest-supplied scatter-gather list
> > > > and passes the result directly to g_malloc(), allowing a guest to force
> > > > QEMU to attempt multi-gigabyte allocations and crash the host process.
> > > > 
> > > > Fix this by copying at most sizeof(struct virtio_console_control) into a
> > > > stack-local variable instead of allocating a buffer sized by the guest.
> > > > handle_control_message() only accesses the fixed-size id, event, and
> > > > value fields, so no data beyond the struct was ever needed.
> > > 
> > > Does anyone have thoughts on whether we should treat guest initiated
> > > unbounded allocs as a security issue ?
> > > 
> > > IIUC, this flaw would require root in the guest OS in order to craft
> > > the malicious virtqueue descriptors.
> > > 
> > > A self-initiated crash triggered by root would not historically
> > > be enough justification for CVE. We would require it to be triggered
> > > by unprivileged user.
> > > 
> > > Nested virt with device assignment could change that equation though
> > > as the L2 guest could be considered an unpriv user from the L1 POV.
> > > 
> > > Also in theory the large alloc might be large enough to consume all
> > > host RAM but not large enough to trigger OOM kill of QEMU. This might
> > > impact operation of other co-located VMs on the same host.
> > 
> > Don't see why not. We can treat it as low priority and no embargo.
> 
> Is there any point in assigning "low" severity  CVEs ? I'm not
> convinced downstream vendors have capacity to deal with "low"
> CVEs anymore even if we published them.

Let's ask some downstreams)

qemu security policy really should spell out what is, or is not,
considered worth a CVE.

> > 
> > > Anyone think this is bad enough to justify a CVE ? Or should we treat
> > > these OOM scenarios maerely as "hardening" bugs, where they require
> > > 'root' in the L1 guest ?
> > 
> > 
> > > > Cc: qemu-stable@nongnu.org
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > ---
> > > >  hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
> > > >  1 file changed, 7 insertions(+), 27 deletions(-)
> > > > 
> > > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > > index cd234dc6db1d..c1973f0248fc 100644
> > > > --- a/hw/char/virtio-serial-bus.c
> > > > +++ b/hw/char/virtio-serial-bus.c
> > > > @@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
> > > >  }
> > > >  
> > > >  /* Guest wants to notify us of some event */
> > > > -static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
> > > > +static void handle_control_message(VirtIOSerial *vser,
> > > > +                                   struct virtio_console_control *gcpkt)
> > > >  {
> > > >      VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> > > >      struct VirtIOSerialPort *port;
> > > >      VirtIOSerialPortClass *vsc;
> > > > -    struct virtio_console_control cpkt, *gcpkt;
> > > > +    struct virtio_console_control cpkt;
> > > >      uint8_t *buffer;
> > > >      size_t buffer_len;
> > > >  
> > > > -    gcpkt = buf;
> > > > -
> > > > -    if (len < sizeof(cpkt)) {
> > > > -        /* The guest sent an invalid control packet */
> > > > -        return;
> > > > -    }
> > > > -
> > > >      cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
> > > >      cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
> > > >  
> > > > @@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
> > > >  
> > > >  static void control_out(VirtIODevice *vdev, VirtQueue *vq)
> > > >  {
> > > > +    struct virtio_console_control cpkt;
> > > >      VirtQueueElement *elem;
> > > >      VirtIOSerial *vser;
> > > > -    uint8_t *buf;
> > > >      size_t len;
> > > >  
> > > >      vser = VIRTIO_SERIAL(vdev);
> > > >  
> > > > -    len = 0;
> > > > -    buf = NULL;
> > > >      for (;;) {
> > > > -        size_t cur_len;
> > > > -
> > > >          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > >          if (!elem) {
> > > >              break;
> > > >          }
> > > >  
> > > > -        cur_len = iov_size(elem->out_sg, elem->out_num);
> > > > -        /*
> > > > -         * Allocate a new buf only if we didn't have one previously or
> > > > -         * if the size of the buf differs
> > > > -         */
> > > > -        if (cur_len > len) {
> > > > -            g_free(buf);
> > > > -
> > > > -            buf = g_malloc(cur_len);
> > > > -            len = cur_len;
> > > > +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
> > > > +        if (len == sizeof(cpkt)) {
> > > > +            handle_control_message(vser, &cpkt);
> > > >          }
> > > > -        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
> > > >  
> > > > -        handle_control_message(vser, buf, cur_len);
> > > >          virtqueue_push(vq, elem, 0);
> > > >          g_free(elem);
> > > >      }
> > > > -    g_free(buf);
> > > >      virtio_notify(vdev, vq);
> > > >  }
> > > >  
> > > > -- 
> > > > 2.54.0
> > > > 
> > > > 
> > > 
> > > With regards,
> > > Daniel
> > > -- 
> > > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


