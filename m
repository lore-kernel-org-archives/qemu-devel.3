Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B317EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOXE-00025b-Vi; Tue, 20 Feb 2024 06:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcOXD-00022w-2f
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:43:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcOXB-0004sX-7m
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708429416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNLtF8khbNBYYvI2PfRHikj0zkmpfthOY0y5Gq+pOEA=;
 b=jAq25FY077EehrxBdVnq/GzFQFayDYAUgO/UTLJnc+kbC9wFVHDAMZq6NF8umW84S0VZG8
 HfVk2AF1fPWWHUuGC3B7WGuVQsOhqnXfDJBRBZFS6DYRCc0DWby6QkKjqm0/r58Q8O7NLB
 rKcMvt5tJnH/7E9nh3QWP97XJCj4IVw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-tpaTnpuINcCgItXnxpOT_g-1; Tue, 20 Feb 2024 06:43:34 -0500
X-MC-Unique: tpaTnpuINcCgItXnxpOT_g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a357c92f241so190820166b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 03:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708429413; x=1709034213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNLtF8khbNBYYvI2PfRHikj0zkmpfthOY0y5Gq+pOEA=;
 b=LqESt4qPjNmAr1xBPMjZ54PTZagOFJ6qn7UHHgH+2LyJzyOX2mRtjfYGcdoM0SiKVK
 G3WvpYXXgXEvurAqPDROTxRAo18YQpj6nr9PxNUxFOrayXgOFP5BG5g4ntXNS8B71aLC
 85rQhZ9Po1QSX97x16uYJGd7uZbPD70R8s8KHuDx0O/hTquVjnFLobMmuzmjeQlzNT68
 dZOOEPcfFxTwu0FaW76HPO9bNgimfhKgSX+1leaIcuWOb4o0mNjr2RyNCgCARcX3m+aB
 Wiu0awvK3Dfbh6XgwVFqHIII7KvrBz4cmCEcPUYEhJFMZeIW4JgTA9OQNPXeeYahBt9j
 Dy8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUftiq6aJBhntTepqI3vGcsRMCy6Qv/C8j49dTmP2FvW64GRzFEqr/1k60RNvJitgyyAWIAKLPHIgwaohq6dgnlL8JqhtM=
X-Gm-Message-State: AOJu0Yzbepdp/x/Fzwfue/KFaFIltWAp44S5kiCyyAI0MEZJd2Zhh3Br
 /Ubu5maPk/jRe73M3m9hph4BMKTP+24fql5mojqvIpiNV0lYIkbs6mDRiZOLoGgYCtfXkZTsAMz
 KylhSvrpWQWxtfwLRrUrdwUxbxfobTCepsbU2aqKVvayoXlwJ58sJ/jaLCi56
X-Received: by 2002:a17:906:ae9b:b0:a3e:e84b:232 with SMTP id
 md27-20020a170906ae9b00b00a3ee84b0232mr1432278ejb.75.1708429413098; 
 Tue, 20 Feb 2024 03:43:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlKsV41ccovpESY8FLmokS1su2g0EFEd0hWd0/2A9hOs7kINal5snMBJtIjnrAoE9dgEyLYw==
X-Received: by 2002:a17:906:ae9b:b0:a3e:e84b:232 with SMTP id
 md27-20020a170906ae9b00b00a3ee84b0232mr1432269ejb.75.1708429412708; 
 Tue, 20 Feb 2024 03:43:32 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:1376:5352:3710:49bb:419e])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a170906c41700b00a3d81b90ffcsm3870512ejz.218.2024.02.20.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 03:43:32 -0800 (PST)
Date: Tue, 20 Feb 2024 06:43:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Hao Chen <chenh@yusur.tech>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 huangml@yusur.tech, zy@yusur.tech
Subject: Re: [PATCH] vhost-user: fix the issue of vhost deadlock in nested
 virtualization
Message-ID: <20240220064027-mutt-send-email-mst@kernel.org>
References: <20240126100737.2509847-1-chenh@yusur.tech>
 <20240213050258-mutt-send-email-mst@kernel.org>
 <5176a8e4-dbdc-45e0-a1f2-d9cb3b71a6b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5176a8e4-dbdc-45e0-a1f2-d9cb3b71a6b1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 12:26:49PM +0100, Maxime Coquelin wrote:
> 
> 
> On 2/13/24 11:05, Michael S. Tsirkin wrote:
> > On Fri, Jan 26, 2024 at 06:07:37PM +0800, Hao Chen wrote:
> > > I run "dpdk-vdpa" and "qemur-L2" in "qemu-L1".
> > > 
> > > In a nested virtualization environment, "qemu-L2" vhost-user socket sends
> > > a "VHOST_USER_IOTLB_MSG" message to "dpdk-vdpa" and blocks waiting for
> > > "dpdk-vdpa" to process the message.
> > > If "dpdk-vdpa" doesn't complete the processing of the "VHOST_USER_IOTLB_MSG"
> > > message and sends a message that needs to be replied in another thread,
> > > such as "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", "dpdk-vdpa" will also
> > > block and wait for "qemu-L2" to process this message. However, "qemu-L2"
> > > vhost-user's socket is blocking while waiting for a reply from "dpdk-vdpa"
> > > after processing the message "VHOSTr_USER_IOTLB_MSG", and
> > > "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" will not be processed.
> > > In this case, both "dpdk-vdpa" and "qemu-L2" are blocked on the
> > > vhost read, resulting in a deadlock.
> > > 
> > > You can modify "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" or
> > > "VHOST_USER_IOTLB_MSG" to "no need reply" to fix this issue.
> > > There are too many messages in dpdk that are similar to
> > > "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", and I would prefer the latter.
> > > 
> > > Fixes: 24e34754eb78 ("vhost-user: factor out msg head and payload")
> > > 
> > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > 
> > I would be very worried that IOTLB becomes stale and
> > guest memory is corrupted if we just proceed without waiting.
> > 
> > Maxime what do you think? How would you address the issue?
> 
> I agree with you, this is not possible.
> For example, in case of IOTLB invalidate, the frontend relies on the
> backend reply to ensure it is no more accessing the memory before
> proceeding.
> 
> The reply-ack for VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG request is
> less important, if it fails the host notifications won't work but would
> not risk corruption. Maybe on Qemu side we could fail init if processing
> the request fails, as I think that if negotiated, we can expect it to
> succeed.
> 
> What do you think about this proposal?
> 
> Regards,
> Maxime

Fundamentally, I think that if qemu blocks guest waiting for a rely
that is ok but it really has to process incoming messages meanwhile.
Same should apply to backend I think ...


> > 
> > 
> > > ---
> > >   hw/virtio/vhost-user.c | 10 ++--------
> > >   1 file changed, 2 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index f214df804b..02caa94b6c 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -2371,20 +2371,14 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
> > >   static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
> > >                                               struct vhost_iotlb_msg *imsg)
> > >   {
> > > -    int ret;
> > >       VhostUserMsg msg = {
> > >           .hdr.request = VHOST_USER_IOTLB_MSG,
> > >           .hdr.size = sizeof(msg.payload.iotlb),
> > > -        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> > > +        .hdr.flags = VHOST_USER_VERSION,
> > >           .payload.iotlb = *imsg,
> > >       };
> > > -    ret = vhost_user_write(dev, &msg, NULL, 0);
> > > -    if (ret < 0) {
> > > -        return ret;
> > > -    }
> > > -
> > > -    return process_message_reply(dev, &msg);
> > > +    return vhost_user_write(dev, &msg, NULL, 0);
> > >   }
> > > -- 
> > > 2.27.0
> > 


