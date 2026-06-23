Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD94CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Mv-0001V5-Jm; Tue, 23 Jun 2026 08:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc0Mr-0001Py-GM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc0Mp-0004mj-3W
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHte1D/PIxAbtMivvHxIFjT0xiyLpH/zlQ+pJoXe6CM=;
 b=PUWsqTBYrD6p9Ke1EE01VTDDm872fj6wJzRris9oEHhqCoWDrxp1f9WZtMV1CwhHR7r17D
 +XDfpj9cvJsOaPR1hOEY+DJq1JlsHPAhrlJ8dml4VgV6uaZ6LvmZzKY+G6YPYC91Z2cckp
 TCDYNO6Dbx8tJDihLHmeXU+32ptUIzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-TLIY_ro5OSeVRsV2kvjmDA-1; Tue, 23 Jun 2026 08:36:35 -0400
X-MC-Unique: TLIY_ro5OSeVRsV2kvjmDA-1
X-Mimecast-MFC-AGG-ID: TLIY_ro5OSeVRsV2kvjmDA_1782218194
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so37414415e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218194; x=1782822994; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cHte1D/PIxAbtMivvHxIFjT0xiyLpH/zlQ+pJoXe6CM=;
 b=cQq3bu74uB1wwtB/UTsg79hTVN4AulgoEtF25rySgikw2JnIodQgg3eC2AQpv7V8o+
 2x/eYlGhHH6gL58iTtJYUynGlZnjGXlxPmz1fKybUaBE6Zp9/k9nqaPvrCaswTJY38qx
 7vmOpA1DCNVibLuiu86brs8J+7bDk6vg2cMy5yjYI4jlcsFouyTOYbybZNivW+CkpgmT
 FFGtAAv8lRj81dCIm9DUIJ1enJWVc0xbA5Y6oSBupn8dbqWuy7zAx9KihaBNkR00yXVK
 KJd27aQJO4mQgBtldG5TknGK9YqxuDZFTb9UNKkme6S9QDR5mk50UStQK935PSqM9kV5
 WHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218194; x=1782822994;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cHte1D/PIxAbtMivvHxIFjT0xiyLpH/zlQ+pJoXe6CM=;
 b=q0JfmxNw3ktpeJvNtypPafW+upO/yTUEOGoR4+LEVRE6O6tmHu4eiW7yRa/TTP/V2p
 MYdYP2vgXrbHBl6/bMqqjTFH9BYwWID05mJlVnjXa2OFFjuaCB3AisKr5XojAJHlumCr
 jU5CcAyXPcByz1SJsUt+UH3Xe808fkrajTtLqVl0rAMi6rCMwbZdBKwYxCGZH0Ru/dEy
 wqOhDUx9tyMscHAnAlLBuFTBwjKYfxNzBRJjsbdRKwt433ObOB+6eEP27Tu8Q6+8XkVq
 tWOKQgHyJpnIS1BTXtZlzflk2PcouHDgzZNiYK3BPFHZasWaEbEypGYKILCZw1FoTkZ3
 fk+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M/OA5sbnKE69X5j+Hy9IfYsw8+SzZ/dSKUYr99JIduICWM2rFlrVH6etMFer5GpV2rruhWuZgAWd/@nongnu.org
X-Gm-Message-State: AOJu0YyWor++tHuhEFQXsMGAmYHRPNEf3BQO0Qpb6WRImnlYTlLkrBcQ
 FTxZXeeQ2ygtmU0epq4YvIZxk/Wixd6k4gXiiDA9Cq8glMAlvRLMdGxxUuWnC/m2i9qw2Myb3aW
 lKo9+qpdbyH6NLnhaGhu/CVUrjdrjUx8dfBVDMbCRPnXdN64ggFvGLouP
X-Gm-Gg: AfdE7clD92HqzpjZ3Z2kSCyg5UGZuocJ95+dIPJNUlXIVkynAqo5YzFIY9yQ2omNsvJ
 cd7cAECVFJEhBDKCMhVT3TaB7aVx5rcshylHRRKb5RrKesRI4MZq6D1uBu/98kTi4ThCPKhYFMh
 WjtMF1JwP6BG7tdxDm1NGmDzAdWekk7VPz5seA4Sow7TGxZmSLW/kMp5llLSZTeMx46kZWWxa/z
 NmXX5essC83+pufywm0u1yP4wooLs8nHBgaE6p9ih7rBKOHL1IEeWg5oRbaXh7detn2MSIBIRoU
 HzTucweFyWAT1Ur6KNVqyBjeQJy3akoMZGyo5tb+yE5HaOMtERMFVprxtyZ/cVLGwV5uevbnInf
 z9NISZWp6iYSgFcaKKWI14A1MYlCK8BUc
X-Received: by 2002:a05:600d:8496:20b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-49240e20c76mr216180085e9.4.1782218194137; 
 Tue, 23 Jun 2026 05:36:34 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:20b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-49240e20c76mr216179455e9.4.1782218193606; 
 Tue, 23 Jun 2026 05:36:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm373505035e9.7.2026.06.23.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:36:33 -0700 (PDT)
Date: Tue, 23 Jun 2026 08:36:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <20260623083557-mutt-send-email-mst@kernel.org>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajljKftAKpkoiN7w@redhat.com>
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

On Mon, Jun 22, 2026 at 05:30:33PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > A malicious guest can craft virtqueue descriptors with arbitrary lengths.
> > control_out() calls iov_size() on the guest-supplied scatter-gather list
> > and passes the result directly to g_malloc(), allowing a guest to force
> > QEMU to attempt multi-gigabyte allocations and crash the host process.
> > 
> > Fix this by copying at most sizeof(struct virtio_console_control) into a
> > stack-local variable instead of allocating a buffer sized by the guest.
> > handle_control_message() only accesses the fixed-size id, event, and
> > value fields, so no data beyond the struct was ever needed.
> 
> Does anyone have thoughts on whether we should treat guest initiated
> unbounded allocs as a security issue ?
> 
> IIUC, this flaw would require root in the guest OS in order to craft
> the malicious virtqueue descriptors.
> 
> A self-initiated crash triggered by root would not historically
> be enough justification for CVE. We would require it to be triggered
> by unprivileged user.
> 
> Nested virt with device assignment could change that equation though
> as the L2 guest could be considered an unpriv user from the L1 POV.
> 
> Also in theory the large alloc might be large enough to consume all
> host RAM but not large enough to trigger OOM kill of QEMU. This might
> impact operation of other co-located VMs on the same host.

Don't see why not. We can treat it as low priority and no embargo.

> Anyone think this is bad enough to justify a CVE ? Or should we treat
> these OOM scenarios maerely as "hardening" bugs, where they require
> 'root' in the L1 guest ?


> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
> >  1 file changed, 7 insertions(+), 27 deletions(-)
> > 
> > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > index cd234dc6db1d..c1973f0248fc 100644
> > --- a/hw/char/virtio-serial-bus.c
> > +++ b/hw/char/virtio-serial-bus.c
> > @@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
> >  }
> >  
> >  /* Guest wants to notify us of some event */
> > -static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
> > +static void handle_control_message(VirtIOSerial *vser,
> > +                                   struct virtio_console_control *gcpkt)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> >      struct VirtIOSerialPort *port;
> >      VirtIOSerialPortClass *vsc;
> > -    struct virtio_console_control cpkt, *gcpkt;
> > +    struct virtio_console_control cpkt;
> >      uint8_t *buffer;
> >      size_t buffer_len;
> >  
> > -    gcpkt = buf;
> > -
> > -    if (len < sizeof(cpkt)) {
> > -        /* The guest sent an invalid control packet */
> > -        return;
> > -    }
> > -
> >      cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
> >      cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
> >  
> > @@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
> >  
> >  static void control_out(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> > +    struct virtio_console_control cpkt;
> >      VirtQueueElement *elem;
> >      VirtIOSerial *vser;
> > -    uint8_t *buf;
> >      size_t len;
> >  
> >      vser = VIRTIO_SERIAL(vdev);
> >  
> > -    len = 0;
> > -    buf = NULL;
> >      for (;;) {
> > -        size_t cur_len;
> > -
> >          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> >          if (!elem) {
> >              break;
> >          }
> >  
> > -        cur_len = iov_size(elem->out_sg, elem->out_num);
> > -        /*
> > -         * Allocate a new buf only if we didn't have one previously or
> > -         * if the size of the buf differs
> > -         */
> > -        if (cur_len > len) {
> > -            g_free(buf);
> > -
> > -            buf = g_malloc(cur_len);
> > -            len = cur_len;
> > +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
> > +        if (len == sizeof(cpkt)) {
> > +            handle_control_message(vser, &cpkt);
> >          }
> > -        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
> >  
> > -        handle_control_message(vser, buf, cur_len);
> >          virtqueue_push(vq, elem, 0);
> >          g_free(elem);
> >      }
> > -    g_free(buf);
> >      virtio_notify(vdev, vq);
> >  }
> >  
> > -- 
> > 2.54.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


