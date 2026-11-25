Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76B606A335
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VihU4jnG;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sg5TWg55
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8wi-0002Ev-C6; Wed, 25 Nov 2026 04:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xW8wd-0002De-MY
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xW8wb-00084a-G2
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795597534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysC3AHmDsIKjBvcEGPukc831sCNFmM9bY+n9x8mxpg0=;
 b=VihU4jnGGZ2XgDvqmZ7zUqWMe9g82GWfSN7Cn5MuoEUnc0QmWYilpONU15STY2HpPGnTZi
 /rTpx4NJVmr/nH6O4H6sidk/wXSQs5as57xWjuGrbhKakK9CdWOBIGgosAG+twdrEytcMj
 hANrtIfAT6XEXqjjXug36lT5qre3hZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-u7CJTaxnMVaBKzCRFf9xBw-1; Wed, 25 Nov 2026 09:05:31 +0000
X-MC-Unique: u7CJTaxnMVaBKzCRFf9xBw-1
X-Mimecast-MFC-AGG-ID: u7CJTaxnMVaBKzCRFf9xBw_1795597531
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-490c1867460so3220849f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795597530; x=1796202330; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ysC3AHmDsIKjBvcEGPukc831sCNFmM9bY+n9x8mxpg0=;
 b=sg5TWg55uGohIkXXBEL1CJKcC24asO0MWr3icGVjHuG65ZKaEuvsuLdmQlQRC/m2GQ
 uhgck/WPqpOZHwtl6GJaSx8/MHnJ08mxyTwz53LKb6Ztt5fFqXWIJMk0x5///jFM+FkP
 nZqsDL87rQfMopcAO+/P5W0I4LrDXBRjDVFV0BRYJHtdB1hH8sCyooGr125q7u2N4jQN
 VZoaWsIgMSe7KiAGbDWUAyJ4NbFh+15zN/GeWS0QdRUSyNII0gJgR5MYIrGjNzhwnCmz
 SNyeu+Omo44C802VUu7n0/+aAdGqGZH6z74CRTxJcgTF+fjBCCiDIP0+oE/attnDWRfH
 Evkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795597530; x=1796202330;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ysC3AHmDsIKjBvcEGPukc831sCNFmM9bY+n9x8mxpg0=;
 b=BCMPfoYAchjGqj1+dRceXdLywGtN2qY2CYwyYwJy5Ob9xrBBvW3QP9QxIfFSHvq+RN
 3tPttxvCEkc1bR0DuBRIJBCTzeV3VtLNnc5WEvx8QMI/j5/S6hsapn/0VdH9GoNO6umQ
 EzlaC7dtJsGGu28m9xk1Wes3U4aEvm9jtmfsnIOe6s07To3bLWCKshdxZGrjSxa8x9cL
 wHcNSLa37ebnn+KfWOsbAi/R6UPu62p7xN8YsyvyBanqCTsRZ9wIdKRe1YRqth+IIGYb
 RLDT4mfwcnQnJOblvqFIE1kEnoFV59MTnfZbmLpO5sEvoCJFZbQq/G+JPURNGhdeOo6A
 AhMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHK9lHuSacyXyjb6vAwyxO1hDqeFv644+HTuNqN7A8biDmVzWuWfg95dAoiqOMcEdmLdL6IP29Ewejs@nongnu.org
X-Gm-Message-State: APuU4Z+cr+OuWOp48MmCo3IEvk51Uo0peb21nFD9Hn6M+feucIYt9Y3i
 gqhoXCR4ManWER5iqEx0Ix+YmTYvC1WMB4QSf8tzaX1MYi8WPHNFJHRQJyBwNOSieM15fFxG8Y5
 TgBsNCV+n+z9oH1DZ+lJ0txO6+dgTJ2nV4CzFLsUNoJq6YJkS/fivMJZ4
X-Gm-Gg: AZFdTZfcafc1/+r2EnrjYHyuy0PEm6RuwAVwzgcgBzCwWM3LCj1xShNMJuMof+M5N5v
 Ww9clpDCrwdHWD7HN7WNA9uNp2L+aAlfJ61oiaLp3kyy172xHAmPdcFgsQsECE+NRPto0x6bu0+
 HIXy+bqPcaB1bHqvfoxmwgzWYAl7q6OHo1bcxJb4Ho8neBbCU0Vn4uwzHVx3hqJNYL7kxCzgn7D
 X9nqIlxulcK9sCCSlo8ZJoHuiOwm5GOBE2qHAdhy9Qje01nkF0X3eSFAxM9Gy/t2tXFmXDhMwXc
 SvbQADl038GvnVPlsEAto1uF3N/PfwFRdbtWwoVLvXrp0IU6anrqPSara4qluL3zOZlG1/vrshW
 gi2dr9cFQlR9EfSxjxHbOYs1XPY8dEjhjpwjWEu13gz9z9QLI2usa9Q==
X-Received: by 2002:a05:6000:250a:b0:49e:1601:2fa1 with SMTP id
 ffacd0b85a97d-4abb514618bmr38390904f8f.33.1795597530566; 
 Wed, 25 Nov 2026 01:05:30 -0800 (PST)
X-Received: by 2002:a05:6000:250a:b0:49e:1601:2fa1 with SMTP id
 ffacd0b85a97d-4abb514618bmr38390835f8f.33.1795597529993; 
 Wed, 25 Nov 2026 01:05:29 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm31993783f8f.30.2026.11.25.01.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:05:28 -0800 (PST)
Date: Wed, 25 Nov 2026 10:05:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
Message-ID: <awakcwEP6eYCeb-A@sgarzare-redhat>
References: <20261123231319.377104-1-connorkite@gmail.com>
 <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 08:41:04AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Connor,
> 
> On 24/11/26 00:13, Connor Kite wrote:
> > When a shadow virtqueue detaches the buffer associated with a used element,
> > it adds the descriptor chain to the head of the free-elements list. However,
> > this currently happens after svq->desc_state[last_used].ndescs is set to 0
> > in vhost_svq_get_buf, introducing a bug.  Only the first element in the used
> > descriptor chain is added back into the free-elements list, with subsequent
> > elements being potentially orphaned.
> 
> Not really added to the 'head of the free-elements list', but the former
> chain tail to free_head, then makes id the new head. Suggested reword:
> 
>   vhost_svq_detach_buf() uses the head descriptor's ndescs to find the
>   last descriptor of the chain and reinsert the whole chain into the
>   free list. vhost_svq_get_buf() currently clears ndescs before calling
>   it, so multi-descriptor buffers are recycled as single descriptors and
>   the remaining descriptors are orphaned.
> 
> > 
> > Zero out ndescs only after the buffer is detached.
> > 
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 86f5f2546f03 ("vhost: use SVQ element ndescs instead of opaque data
> for desc validation")

yeah, I was going to suggest to cc stable and add a fixes tag too.

> 
> (Please check this is the correct commit introducing the
> zero-before-detach behavior).

IMO we should use

Fixes: 7291b1a5f8b0 ("vhost: factor out the detach buf logic in SVQ")

@Eugenio can you check this?

Thanks,
Stefano

> 
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> > index 462c86dc1e..1afd3edf87 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
> >                                              uint32_t *len)
> >   {
> >       uint16_t last_used;
> > +    VirtQueueElement *detached_buf;
> >       if (!vhost_svq_more_used(svq)) {
> >           return NULL;
> > @@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
> >           return NULL;
> >       }
> > +    detached_buf = vhost_svq_detach_buf(svq, last_used);
> >       svq->num_free += svq->desc_state[last_used].ndescs;
> >       svq->desc_state[last_used].ndescs = 0;
> > -    return vhost_svq_detach_buf(svq, last_used);
> > +    return detached_buf;
> >   }
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

