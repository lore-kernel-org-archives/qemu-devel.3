Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBUg-0002R7-Dp; Fri, 11 Jul 2025 07:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uaBUd-0002PE-Vv
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uaBUb-0002Sj-3W
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752231633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLCWNxUXPPMawzGWT7m+bukimor9vbjEs2nl2e45Qfk=;
 b=a50aQC1CGjHeydR7jAixaNR4knSJSJbWGXQXNv6smaFwRnGrT4tIRuQJpvqG4LG9yC7vgG
 Vtqwj2tN57WqDeKxowYwp0p4hjETgSIPbirciml0+itr6aho6YPS7Lf5bVTBbspBbcpuo8
 utdbmTzsKtUCFkhW0NXfUBTPoVkxvpY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-ZPruonX7Mbqxx-J9LEPlBQ-1; Fri,
 11 Jul 2025 07:00:31 -0400
X-MC-Unique: ZPruonX7Mbqxx-J9LEPlBQ-1
X-Mimecast-MFC-AGG-ID: ZPruonX7Mbqxx-J9LEPlBQ_1752231630
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CD019560AA; Fri, 11 Jul 2025 11:00:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 083D91977000; Fri, 11 Jul 2025 11:00:27 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:00:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
Message-ID: <aHDuyBl4rc4eWvIn@redhat.com>
References: <20250617203435.41490-1-shentey@gmail.com>
 <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jul 11, 2025 at 11:45:08AM +0100, Peter Maydell wrote:
> On Tue, 17 Jun 2025 at 21:35, Bernhard Beschow <shentey@gmail.com> wrote:
> >
> > When compiling QEMU against fuse3-3.17.1 with --enable-werror the build fails
> > with:
> >
> >   In file included from ../src/block/export/fuse.c:33:
> >   /usr/include/fuse3/fuse.h:959:5: error: redundant redeclaration of ‘fuse_main_real_versioned’ [-Werror=redundant-decls]
> >     959 | int fuse_main_real_versioned(int argc, char *argv[],
> >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >   /usr/include/fuse3/fuse.h:885:5: note: previous declaration of ‘fuse_main_real_versioned’ with type ‘int(int,  char **, const struct fuse_operations *, size_t,  struct libfuse_version *, void *)’ {aka ‘int(int,  char **, const struct fuse_operations *, long unsigned int,  struct libfuse_version *, void *)’}
> >     885 | int fuse_main_real_versioned(int argc, char *argv[],
> >         |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >   cc1: all warnings being treated as errors
> >
> > That is, a fuse header triggers a warning within itself. Since QEMU adds the
> > fuse3 include path via `-I`, the compiler thinks that the header is part of the
> > QEMU project, and thus raises a warning. The compiler can be told to ignore
> > warnings within 3rd party headers by adding these paths via `-isystem`. Fix the
> > above build failure by marking fuse as system dependency. While at it mark
> > every 3rd-party dependency as system dependency to prevent similar issues in the
> > future but skip glib since that results in glib include paths to be omitted from
> > bindgen in case of a Rust build.
> 
> The problem with this is that -isystem does not only do "suppress
> warnings in these headers" -- it also alters the search order
> for includes, in a way that can sometimes cause problems:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70129
> So this isn't completely risk-free, though I think meson tries to
> avoid some of this by doing something a bit more complex than a
> pure 's/-I/-isystem/'.
> 
> We would also lose the warnings about e.g. use of deprecated
> functions in our dependencies.
> 
> All that said, this might still be the best tradeoff.

FWIW, the actual bug mentioned here is a clear regression & mistake in
libfuse3 3.17.1 only, that they really should fix. I've filed this:

  https://github.com/libfuse/libfuse/issues/1282

and will likely send a PR too later.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


