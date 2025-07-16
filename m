Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A143AC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyHR-0002I6-6j; Wed, 16 Jul 2025 05:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubyH8-0001tg-2K
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubyH1-0006mz-D9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752657476;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8EVCdXI3eE0edlmJ6lCToQVaufJVvfU/CjCtEbllrk=;
 b=iclWXSqIJwmwPcYRD+7x7C0PhuRonXmW/MQ4tmInGL2fzmfJqK1PzV99TKXDa9/6O1Tag3
 P9r0nquz2XhCINFQCeVy/1+mMkiMA2EHd2u1eCSxfXTyuDd/UXd8aon6hbTgHKwycVUN0D
 92yiWYpRpNYNJXEE90R7v0yx57LO5fE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-4hrpGFhvMxCCqT985q3Fuw-1; Wed,
 16 Jul 2025 05:17:54 -0400
X-MC-Unique: 4hrpGFhvMxCCqT985q3Fuw-1
X-Mimecast-MFC-AGG-ID: 4hrpGFhvMxCCqT985q3Fuw_1752657473
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01241800C30; Wed, 16 Jul 2025 09:17:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.68])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 027FD1800D82; Wed, 16 Jul 2025 09:17:49 +0000 (UTC)
Date: Wed, 16 Jul 2025 10:17:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
Message-ID: <aHduNT4YwnxqEmKY@redhat.com>
References: <20250617203435.41490-1-shentey@gmail.com>
 <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
 <aHDuyBl4rc4eWvIn@redhat.com> <aHZbZN4MIKL7-pu6@redhat.com>
 <29215B68-1090-4D85-A710-67CBB3317430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29215B68-1090-4D85-A710-67CBB3317430@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 08:13:09AM +0000, Bernhard Beschow wrote:
> 
> 
> Am 15. Juli 2025 13:45:08 UTC schrieb "Daniel P. Berrangé" <berrange@redhat.com>:
> >On Fri, Jul 11, 2025 at 12:00:24PM +0100, Daniel P. Berrangé wrote:
> >> On Fri, Jul 11, 2025 at 11:45:08AM +0100, Peter Maydell wrote:
> >> > On Tue, 17 Jun 2025 at 21:35, Bernhard Beschow <shentey@gmail.com> wrote:
> >> > >
> >> > > When compiling QEMU against fuse3-3.17.1 with --enable-werror the build fails
> >> > > with:
> >> > >
> >> > >   In file included from ../src/block/export/fuse.c:33:
> >> > >   /usr/include/fuse3/fuse.h:959:5: error: redundant redeclaration of ‘fuse_main_real_versioned’ [-Werror=redundant-decls]
> >> > >     959 | int fuse_main_real_versioned(int argc, char *argv[],
> >> > >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >> > >   /usr/include/fuse3/fuse.h:885:5: note: previous declaration of ‘fuse_main_real_versioned’ with type ‘int(int,  char **, const struct fuse_operations *, size_t,  struct libfuse_version *, void *)’ {aka ‘int(int,  char **, const struct fuse_operations *, long unsigned int,  struct libfuse_version *, void *)’}
> >> > >     885 | int fuse_main_real_versioned(int argc, char *argv[],
> >> > >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >> > >   cc1: all warnings being treated as errors
> >> > >
> >> > > That is, a fuse header triggers a warning within itself. Since QEMU adds the
> >> > > fuse3 include path via `-I`, the compiler thinks that the header is part of the
> >> > > QEMU project, and thus raises a warning. The compiler can be told to ignore
> >> > > warnings within 3rd party headers by adding these paths via `-isystem`. Fix the
> >> > > above build failure by marking fuse as system dependency. While at it mark
> >> > > every 3rd-party dependency as system dependency to prevent similar issues in the
> >> > > future but skip glib since that results in glib include paths to be omitted from
> >> > > bindgen in case of a Rust build.
> >> > 
> >> > The problem with this is that -isystem does not only do "suppress
> >> > warnings in these headers" -- it also alters the search order
> >> > for includes, in a way that can sometimes cause problems:
> >> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70129
> >> > So this isn't completely risk-free, though I think meson tries to
> >> > avoid some of this by doing something a bit more complex than a
> >> > pure 's/-I/-isystem/'.
> >> > 
> >> > We would also lose the warnings about e.g. use of deprecated
> >> > functions in our dependencies.
> >> > 
> >> > All that said, this might still be the best tradeoff.
> >> 
> >> FWIW, the actual bug mentioned here is a clear regression & mistake in
> >> libfuse3 3.17.1 only, that they really should fix. I've filed this:
> >> 
> >>   https://github.com/libfuse/libfuse/issues/1282
> >> 
> >> and will likely send a PR too later.
> >
> >The issue turned out to already be fixed in libfuse git master. So given
> >that the problem only appears in one single release, IMHO, the best thing
> >is to ignore it. Any distro which ships the broken libfuse should either
> >update it, or cherry-pick the trivial header file bugfix from git.
> 
> The idea of this patch is also to insulate ourselves from similar
> issues in the future. Moreover,  `-isystem` might be helpful in
> other ways, such as for static analysis tools. For example,
> clang-tidy ignores any issues caused by headers included via
> -isystem. So IMO this patch is still worth for consideration
> (but I'm not attached to it).

I still feel like this is more trouble than is worth. You've already had to
special case exclude 'glib' from this conversion, which is our biggest dep
when it comes to external headers, to place bindgen & this sounds liable to
extend to other deps as we expand the use of rust.

The problems like the one we see with fuse are pretty infrequent and haven't
been a significant source of pain for QEMU historically IME.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


