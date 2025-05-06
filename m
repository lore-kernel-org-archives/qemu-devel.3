Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2EFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLTR-00057i-Qv; Tue, 06 May 2025 12:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLTP-00057R-Op
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLTO-0003z9-0Q
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746550128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uri6Cd+j223dgdddjZ6llmyapGXFnP5Lsupck775S4=;
 b=hsrUvTAQRZAT2VNcPCtNWXZCmXhB+Q8S2xrnNT4FUJBLpK9LtaI9nuLNjbCDDSv3dXg4aG
 310b/SLm+TkbjSjxXbrs8fwCMWkNi7omEzAy4v2vhAvolSprXitJ8pE0i6xqyJAmge1NLy
 Pu6CKalR4plZ7uv2qJ4J5hVEQcDGGSg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-q_a5RknIOfmEBM1K1wkICg-1; Tue,
 06 May 2025 12:48:45 -0400
X-MC-Unique: q_a5RknIOfmEBM1K1wkICg-1
X-Mimecast-MFC-AGG-ID: q_a5RknIOfmEBM1K1wkICg_1746550124
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC6E11954B13; Tue,  6 May 2025 16:48:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A87F1956094; Tue,  6 May 2025 16:48:42 +0000 (UTC)
Date: Tue, 6 May 2025 17:48:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
Message-ID: <aBo9Z4NjOReXwbni@redhat.com>
References: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
 <aBo6rDsbZGOfWfLP@redhat.com>
 <CACkyd_YNXivoXE3PFNmK_5QCRQV83JZRf9NUEU+0yM4FOgM4fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkyd_YNXivoXE3PFNmK_5QCRQV83JZRf9NUEU+0yM4FOgM4fg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 07:41:32PM +0300, Elisha Hollander wrote:
> Gave an example for a case where QEMU would try to allocate 0 bytes thus
> fail here in the original version of the patch.
> 
> > As I mentioned earlier, let's say you don't initialize the vertical
> display end registers, and set the minimum scanline register, the emulation
> will then have to allocate some display buffer, but because the vertical
> display end is initilized as 0 the buffer will be empty and the program
> break.

Isn't this an invalid hardware configuration that should be detected
in the emulation code, and either force the display end to a minimum
value, or trigger an assert ?

Patching a bug in a specific HW impl, by changing the qemu_memfd_alloc
code feels like it is probably the wrong place to address this.

> 
> I have no idea as for why my emails are getting messed up... :/
> 
> Have to go now, will try and send it again tomorrow probably...
> 
> On Tue, May 6, 2025, 19:37 Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:
> > > Sorry for former patch something is messed up with my email.
> >
> > The commit message needs to explain what problem is being solved by
> > making this change as allowing 0 bytes looks dubious on the surface.
> >
> > >
> > > Signed-off-by: donno2048 <just4now666666@gmail.com>
> > > ---
> > >  util/memfd.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/util/memfd.c b/util/memfd.c
> > > index 8a2e906..e96e5af 100644
> > > --- a/util/memfd.c
> > > +++ b/util/memfd.c
> > > @@ -108,7 +108,7 @@ err:
> > >  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int
> > seals,
> > >                         int *fd, Error **errp)
> > >  {
> > > - void *ptr;
> > > + void *ptr = NULL;
> > >      int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);
> > >
> > >      /* some systems have memfd without sealing */
> > > @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t
> > size,
> > > unsigned int seals,
> > >          }
> > >      }
> > >
> > > - ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > > - if (ptr == MAP_FAILED) {
> > > - goto err;
> > > + if (size != 0) {
> > > + ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > > + if (ptr == MAP_FAILED) {
> > > + goto err;
> > > + }
> > >      }
> >
> > This patch is mangled.
> >
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


