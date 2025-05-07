Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA22C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCd5K-0006vX-Al; Wed, 07 May 2025 07:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCd5J-0006ut-4a
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCd59-0006FL-Mn
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746617817;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laT/CeEikK2FDd5q1sCNSmWtVERFFlhtmHHdy3hSf8c=;
 b=B8q7K8mIeu9n092dTYdrhwOg5jtjzFJPWJxqXK5ok+txvCDG5UJb+jX2NMGAK+GygpJHLI
 GWvzBMDuhT5F/9Znn2kxRpIr+WmdWNyf8MmmZZeYN6qnkk9jgUlm+wjGdq7i1PNxcM4nuc
 Z54S04y8vMIyGanW8NV2pwwLe9ndlgs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-PUFS2HmXNpaqFNSrkVqXBQ-1; Wed,
 07 May 2025 07:36:55 -0400
X-MC-Unique: PUFS2HmXNpaqFNSrkVqXBQ-1
X-Mimecast-MFC-AGG-ID: PUFS2HmXNpaqFNSrkVqXBQ_1746617814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E3B2180045C; Wed,  7 May 2025 11:36:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAEB5180045B; Wed,  7 May 2025 11:36:52 +0000 (UTC)
Date: Wed, 7 May 2025 12:36:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
Message-ID: <aBtF0AY0tmOjeTX_@redhat.com>
References: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
 <aBo6rDsbZGOfWfLP@redhat.com>
 <CACkyd_YNXivoXE3PFNmK_5QCRQV83JZRf9NUEU+0yM4FOgM4fg@mail.gmail.com>
 <aBo9Z4NjOReXwbni@redhat.com>
 <CACkyd_bWqaTFpxP22d37dX-gF+-+vbJCOeJpz_DMTd8Gh_H9zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkyd_bWqaTFpxP22d37dX-gF+-+vbJCOeJpz_DMTd8Gh_H9zA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Wed, May 07, 2025 at 01:25:34AM +0300, Elisha Hollander wrote:
> Maybe an assert is really more appropriate, but technically doing so on
> actual hardware should run flawlessly so I think the emu should work too...
> Maybe I'm wrong though

I'm still not clear which specific hardware device you're talking
about, but even if we don't want to assert, there's likely scope
for addressing the problem in that specific device rather than
changing the memfd code which has a semantic impact across all
users in qemu.

> 
> On Tue, May 6, 2025, 19:48 Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Tue, May 06, 2025 at 07:41:32PM +0300, Elisha Hollander wrote:
> > > Gave an example for a case where QEMU would try to allocate 0 bytes thus
> > > fail here in the original version of the patch.
> > >
> > > > As I mentioned earlier, let's say you don't initialize the vertical
> > > display end registers, and set the minimum scanline register, the
> > emulation
> > > will then have to allocate some display buffer, but because the vertical
> > > display end is initilized as 0 the buffer will be empty and the program
> > > break.
> >
> > Isn't this an invalid hardware configuration that should be detected
> > in the emulation code, and either force the display end to a minimum
> > value, or trigger an assert ?
> >
> > Patching a bug in a specific HW impl, by changing the qemu_memfd_alloc
> > code feels like it is probably the wrong place to address this.
> >
> > >
> > > I have no idea as for why my emails are getting messed up... :/
> > >
> > > Have to go now, will try and send it again tomorrow probably...
> > >
> > > On Tue, May 6, 2025, 19:37 Daniel P. Berrangé <berrange@redhat.com>
> > wrote:
> > >
> > > > On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:
> > > > > Sorry for former patch something is messed up with my email.
> > > >
> > > > The commit message needs to explain what problem is being solved by
> > > > making this change as allowing 0 bytes looks dubious on the surface.
> > > >
> > > > >
> > > > > Signed-off-by: donno2048 <just4now666666@gmail.com>
> > > > > ---
> > > > >  util/memfd.c | 10 ++++++----
> > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/util/memfd.c b/util/memfd.c
> > > > > index 8a2e906..e96e5af 100644
> > > > > --- a/util/memfd.c
> > > > > +++ b/util/memfd.c
> > > > > @@ -108,7 +108,7 @@ err:
> > > > >  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int
> > > > seals,
> > > > >                         int *fd, Error **errp)
> > > > >  {
> > > > > - void *ptr;
> > > > > + void *ptr = NULL;
> > > > >      int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);
> > > > >
> > > > >      /* some systems have memfd without sealing */
> > > > > @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t
> > > > size,
> > > > > unsigned int seals,
> > > > >          }
> > > > >      }
> > > > >
> > > > > - ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > > > > - if (ptr == MAP_FAILED) {
> > > > > - goto err;
> > > > > + if (size != 0) {
> > > > > + ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > > > > + if (ptr == MAP_FAILED) {
> > > > > + goto err;
> > > > > + }
> > > > >      }
> > > >
> > > > This patch is mangled.
> > > >
> > > >
> > > > With regards,
> > > > Daniel
> > > > --
> > > > |: https://berrange.com      -o-
> > > > https://www.flickr.com/photos/dberrange :|
> > > > |: https://libvirt.org         -o-
> > > > https://fstop138.berrange.com :|
> > > > |: https://entangle-photo.org    -o-
> > > > https://www.instagram.com/dberrange :|
> > > >
> > > >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> > https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> > https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> > https://www.instagram.com/dberrange :|
> >
> >

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


