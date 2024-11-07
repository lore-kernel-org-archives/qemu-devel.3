Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C70D43359
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91hh-0002bT-5a; Thu, 07 Nov 2024 07:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t91hd-0002ay-9W
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t91ha-0001Ag-QG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730982808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zqFfAMccHgASW4767qRDXMZNEZcjQNrz3CCv1lfsJXo=;
 b=gT6Q9gHPwhfHjX7A59voCSf7MIfmcGRWtC4TEz5S8OafQvOHyf35zOru8ANLZv5SuOCjt6
 vEn1MgFUz6qcixbXKbSEUiqgyPCIXipr3ewL3R5sisbN5ZIzRBOaIe84oWFle1FdkNi18h
 GiEJTk01UlSr78CGJdXzqV6ZseFajbM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-fUef2s7bPpGck87CdOusxg-1; Thu,
 07 Nov 2024 07:33:24 -0500
X-MC-Unique: fUef2s7bPpGck87CdOusxg-1
X-Mimecast-MFC-AGG-ID: fUef2s7bPpGck87CdOusxg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC2891955F10; Thu,  7 Nov 2024 12:33:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 905391953880; Thu,  7 Nov 2024 12:33:21 +0000 (UTC)
Date: Thu, 7 Nov 2024 12:33:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyyzjWY-1nPpPgSW@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 07, 2024 at 05:35:06PM +0530, Prasad Pandit wrote:
> On Wed, 6 Nov 2024 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
> > What we're thinking is having an initial exchange of information between
> > src & dst as soon as migration starts and that would sync the
> > capabilities and parameters between both sides. Which would then be
> > followed by a channel establishment phase that would open each necessary
> > channel (according to caps) in order, removing the current ambiguity.
> >
> 
> * Isn't that how it works? IIUC, libvirtd(8) sends migration command
> options to the destination and based on that the destination prepares
> for the multifd and/or postcopy migration. In case of 'Postcopy' the
> source sends 'postcopy advise' to the destination to indicate that
> postcopy might follow at the end of precopy. Also, in the discussion
> above Peter mentioned that libvirtd(8) may exchange list of features
> between source and destination to facilitate QMP clients.
> 
> * What is the handshake doing differently? (just trying to understand)

Libvirt does what it does because it has had no other choice,
not because it was good or desirable.

This kind of handshake really does not belong in libvirt. A number
of exposed migration protocol feature knobs should be considered
private to QEMU only.

It has the very negative consequence that every time QEMU wants to
provide a new feature in migration, it needs to be plumbed up through
libvirt, and often applications above, and those 3rd party projects
need to be told when & where to use the new features. The 3rd party
developers have their own project dev priorities so may not get
around to enable the new migration features for years, if ever,
undermining the work of QEMU's migration maintainers.

As examples...

If we had QEMU self-negotiation of features 10 years ago, everywhere
would already be using multifd out of the box. QEMU would have been
able to self-negotiate use of the new "multifd" protocol, and QEMU
would be well on its way to being able to delete the old single-
threaded migration code.

Similarly post-copy would have been way easier for apps, QEMU would
auto-negotiate a channel for the post-copy async page fetching. All
migrations would be running with the post-copy feature available.
All that libvirt & apps would have needed was a API to initiate the
switch to post-copy mode.

Or the hacks QEMU has put in place where we peek at incoming data
on some channels  to identify the channel type would not exist.


TL;DR: once QEMU can self-negotiate features for migration itself,
the implementation burden for libvirt & applications is greatly
reduced. QEMU migration maintainers will control their own destiny,
able to deliver improvements to users much more quickly, be able
to delete obsolete features more quickly, and be able to make
migration *automatically* enable new features & pick the optimal
defaults on their own expert knowledge, not waitnig for 3rd parties
to pay attention years later.

Some things will still need work & decisions in libvirt & apps,
but this burden should be reduced compared over the long term.
Ultimately everyone will win.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


