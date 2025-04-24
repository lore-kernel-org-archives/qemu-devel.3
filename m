Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA63C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7syi-0002LP-VT; Thu, 24 Apr 2025 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7syg-0002IL-HF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7sye-00013u-Fq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745487278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RlziN9R0mhYCPo6jzt+fZH2baMmy9H/m1+0bdAZU7nI=;
 b=BYAk0X424smm4tLonqjCbtsvhiAuFyN3WT4PnxaOW1m0goAHQ2fi+/DHyBJMy81OCsL9IZ
 md9i/M7Rkqj6xAM582ghiCHM9E8VGIaxc1+2eIoSOOF2ROBJ+rKqXW9agh51XoufHZ0nbU
 iRKIRW7ShtV9M6JUVF/TlqbD1aeVu2A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-locU0UCePPGs2lNjTej9SA-1; Thu,
 24 Apr 2025 05:34:29 -0400
X-MC-Unique: locU0UCePPGs2lNjTej9SA-1
X-Mimecast-MFC-AGG-ID: locU0UCePPGs2lNjTej9SA_1745487269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 943C61955DCE; Thu, 24 Apr 2025 09:34:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 347B01801747; Thu, 24 Apr 2025 09:34:26 +0000 (UTC)
Date: Thu, 24 Apr 2025 10:34:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAoFn3AnlkdPYxLf@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <CAJ+F1CLHF0VQHg0JYmaooVRJSZbDkQa01D__iX-5umUcQjJd1Q@mail.gmail.com>
 <1186263082.4663.1745408772058@webmail.proxmox.com>
 <CAJ+F1C+n-yVHA-u7=MvChwn17bHLY8_XVBiQJOtFAX5pxdbj-w@mail.gmail.com>
 <770217162.5044.1745486914133@webmail.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <770217162.5044.1745486914133@webmail.proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, Apr 24, 2025 at 11:28:34AM +0200, Dietmar Maurer wrote:
> > > > > +void vnc_h264_clear(VncState *vs)
> > > > > +{
> > > > > +    if (!vs->h264) {
> > > > > +        return;
> > > > > +    }
> > > >
> > > > unnecessary
> > >
> > > This is required. For example if you disable h264, vs->h264 is
> > > always NULL, and we unconditionally call vnc_h264_clear().
> > >
> > > Why do you think this is unnecessary?
> > 
> > and there are already checks for NULL, no need to do it twice, do it
> > where it is actually necessary.
> 
> There is no check in destroy_encoder_context(), so this will generate a core dump.
> 
> So what do you mean by "where it is actually necessary"?
> 
> The final code looks like:
> 
> void vnc_h264_clear(VncState *vs)
> {
>     // Assume we remove this check ...
>     // if (!vs->h264) {
>     //    return;
>     //}
> 
>     // will trigger a core dump
>     notifier_remove(&vs->h264->shutdown_notifier);
> 
>     // will trigger a core dump
>     destroy_encoder_context(vs->h264);
>     // will trigger a core dump
>     g_free(vs->h264->encoder_name);
> 
>     g_clear_pointer(&vs->h264, g_free);
> }
> 
> Where do you want the check for NULL exactly? At the call site?

IMHO checking in vnc_h264_clear is correct - it is the expected pattern
that deallocation functions accept NULL and act as a no-op in that case.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


