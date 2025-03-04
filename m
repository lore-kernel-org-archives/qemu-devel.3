Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F69AC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSC2-0006H3-8E; Tue, 04 Mar 2025 08:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpSC0-0006Gs-GT
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpSBx-0000i6-Ou
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741094411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iOTcITd1b+2bjwBC5Qft0xaXveCB4sSyY+SyK7h0m8=;
 b=bC9vMlnx/bQ4POLfJWG/WZPlNSWv4VIseg8LHX6FIUdyziwRdOsCK0C8WQprkmYPgh2gtS
 kIVf3iGXsNtKsOXZ2Uu5d4sPdZH4wVD8S0yphMQLe6uXzpv+EkKpL2ch2/HNDW8HDQFKax
 EGPRPIsoDGXJgSHzWbflw37fJ/t1fPU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-lUQ9x8DuN9KSH2mrSGhAKw-1; Tue,
 04 Mar 2025 08:20:09 -0500
X-MC-Unique: lUQ9x8DuN9KSH2mrSGhAKw-1
X-Mimecast-MFC-AGG-ID: lUQ9x8DuN9KSH2mrSGhAKw_1741094408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938F41800570; Tue,  4 Mar 2025 13:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28C1180087D; Tue,  4 Mar 2025 13:20:05 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:20:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
Message-ID: <Z8b96wVB2f88csSN@redhat.com>
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
 <Z8bTy54Jgaddg6V3@redhat.com> <87tt8958tj.fsf@draig.linaro.org>
 <Z8bt7ajRVwdabG7p@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8bt7ajRVwdabG7p@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Tue, Mar 04, 2025 at 12:11:25PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 04, 2025 at 11:33:44AM +0000, Alex Bennée wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Bennée wrote:
> > >> This option is supported by both gcc (since 4.7) and clang (since
> > >> 7.0). Not only does this make the linkers job easier by reducing the
> > >> amount of ELF it needs to parse it also reduces the total build size
> > >> quite considerably. In my case a default build went from 5.8G to 3.9G.
> > >
> > > I've not come across this option before, but the docs say
> > >
> > >   ‘-gsplit-dwarf’
> > >      If DWARF debugging information is enabled, separate as much
> > >      debugging information as possible into a separate output file with
> > >      the extension ‘.dwo’.  This option allows the build system to avoid
> > >      linking files with debug information.  To be useful, this option
> > >      requires a debugger capable of reading ‘.dwo’ files.
> > >
> > > In Fedora and RHEL we build QEMU will full debug enabled, and then a feature
> > > of the distro RPM build config will post-process all ELF files to extract
> > > the debug info into files that we store under /usr/lib/debug. eg for
> > > /usr/bin/qemu-system-x86_64, we get a separate
> > > /usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
> > > tools like GDB, etc know to look for these separate files.
> > 
> > A modern gdb can certainly handle fetching the debug out of the .dwo
> > files when debugging.
> 
> See this response from one of the upstream GCC maintainers pretty much
> recommending against (on by default) use of -gsplit-dwarf:
> 
>   https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/RXA55BTO62NWWHCTUFYGEVHJKZPL5EKE/

Since lists.fp.o is being rather unreliable today...

[quote]
On Tue, Mar 04, 2025 at 11:44:18AM +0000, Daniel P. Berrangé wrote:
> The QEMU community is discussing possible use of -gsplit-dwarf as a default
> option for QEMU's build system:
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg00424.html
>
> This option causes debug symbols to be written to separate .dwo files
> instead of the .o files or final executables.

Don't.
-gsplit-dwarf is something to get faster link times at the expense of slower
debugging and more files around.
So, it can be useful for fast modify/rebuild/test cycles during development,
but is something that is really undesirable for the distro builds.
There you don't mind slightly longer link times, that is done once per
build, but having to ship larger debug info and especially when it is split
into hundreds or thousands of small files is then a price everybody who
downloads the package debuginfo pays.
debugedit can't deal with it, dwz can't either, in order to ship something
reasonable one would need to dwp the separate debug info back into the
normal debug info.

        Jakub
[/quote]

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


