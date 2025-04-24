Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3152BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7s0U-0005cW-6N; Thu, 24 Apr 2025 04:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7s0R-0005c6-TU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7s0J-0002qB-Tu
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745483536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fLwkT6b4mluLGQjFT6GjV7Ffd2ceA7wTwxcIYbyD1KY=;
 b=U7hKsEm3/iKBKZ0Sa/HGHnVSM66UZI2Sf1h6WUJ61l3eS4VcrgKYfBBZc6OS+aQ7/xfJ+S
 /I/hg0zVZ7TjKmiG797/GDe1XUVaH7QWLwM5djcQLe5mkhPIfxAtdbf3kjZ5jld+nSFDaO
 pZgDGnFtG/KqGhQRdn8eybJGZwxv6iA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-Ncjc5AO_Pm-YPcTf_TlIYw-1; Thu,
 24 Apr 2025 04:32:11 -0400
X-MC-Unique: Ncjc5AO_Pm-YPcTf_TlIYw-1
X-Mimecast-MFC-AGG-ID: Ncjc5AO_Pm-YPcTf_TlIYw_1745483530
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AFBF19560AF; Thu, 24 Apr 2025 08:32:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 105D1195608D; Thu, 24 Apr 2025 08:32:06 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:32:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAn3A6fMVu7paAOy@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <CAJ+F1CLHF0VQHg0JYmaooVRJSZbDkQa01D__iX-5umUcQjJd1Q@mail.gmail.com>
 <1186263082.4663.1745408772058@webmail.proxmox.com>
 <CAJ+F1C+n-yVHA-u7=MvChwn17bHLY8_XVBiQJOtFAX5pxdbj-w@mail.gmail.com>
 <1814146671.4781.1745475565149@webmail.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1814146671.4781.1745475565149@webmail.proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 24, 2025 at 08:19:25AM +0200, Dietmar Maurer wrote:
> > > > > +        VNC_DEBUG("Could not add source to gst pipeline\n");
> > > > > +        goto error;
> > > > > +    }
> > > > > +
> > > > > +    gst_object_ref(vs->h264->convert);
> > > > > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
> > > >
> > > > Can you use gst_bin_add_many() ?
> > >
> > > will try to use that.
> 
> I really struggle to use those functions. Documentation states
> that gst_bin_add() can fail, but gst_bin_add_many() simply ignores
> the results of gst_bin_add() (explicitly stated in the docs)? 
> 
> Do you really want to use gst_bin_add_many() anyways?

Ignoring failure in gst_bin_add_many seems like a pretty dubious design
choice to me. Given they documented that as expected behaviour I guess
there's no chance getting gstreamer to fix that.

So I'd prefer we stick with what you've got so we handle errors correctly.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


