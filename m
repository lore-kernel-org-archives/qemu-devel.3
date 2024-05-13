Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2B6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UWc-0004UH-6r; Mon, 13 May 2024 08:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6UWa-0004Sh-0j
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6UWX-0000bP-OL
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715602279;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhdZWN9dHw4+iBzdn6ek08dwlaOzZasd9bg8/+EzV5s=;
 b=fC1NOscKZ+64rmEOLSOkuCNONV+Qsk0U+oZbyKhxkxuy1/9Zdl9r1e+r1FJDFNuefLt2Re
 IiEZcrVlCdrVOVLCHxGbb+TuX4Cqa6OMtoYNxZ0Ge6GHXRG//awDdrANvtOOZnuEXoZCqJ
 kevlmW80x/tyjQj1MzkTnUOVtIjodU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-s13ghqQ7NR-I9YJBIITZ8g-1; Mon, 13 May 2024 08:11:16 -0400
X-MC-Unique: s13ghqQ7NR-I9YJBIITZ8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42E4801211;
 Mon, 13 May 2024 12:11:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BAE71006B42;
 Mon, 13 May 2024 12:11:15 +0000 (UTC)
Date: Mon, 13 May 2024 13:11:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] tests/lcitool: Remove g++ from the containers
 (except for the MinGW one)
Message-ID: <ZkIDYTTtMlX20-xW@redhat.com>
References: <20240513102252.48884-1-thuth@redhat.com>
 <20240513102252.48884-3-thuth@redhat.com>
 <ZkHrXOR05UkkMn2X@redhat.com>
 <41974e51-cee5-4a62-bcab-db9b78f76aee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41974e51-cee5-4a62-bcab-db9b78f76aee@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 13, 2024 at 02:05:16PM +0200, Thomas Huth wrote:
> On 13/05/2024 12.28, Daniel P. Berrangé wrote:
> > On Mon, May 13, 2024 at 12:22:50PM +0200, Thomas Huth wrote:
> > > We don't need C++ for the normal QEMU builds anymore, so installing
> > > g++ in each and every container seems to be a waste of time and disk
> > > space. The only container that still needs it is the Fedora MinGW
> > > container that builds the only remaining C++ code in ./qga/vss-win32/
> > > and we can install it here with an extra RUN statement instead.
> > > 
> > > This way we can also add the mingw-w64-tools package quite easily
> > > which contains the x86_64-w64-mingw32-widl program that is required
> > > for compiling the vss code of the guest agent (it was missing before
> > > this change, so the VSS code was actually never compiled in the CI).
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/lcitool/projects/qemu.yml |  1 -
> > >   tests/lcitool/refresh           | 10 ++++++++--
> > >   2 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
> > > index 9173d1e36e..b63b6bd850 100644
> > > --- a/tests/lcitool/projects/qemu.yml
> > > +++ b/tests/lcitool/projects/qemu.yml
> > > @@ -22,7 +22,6 @@ packages:
> > >    - findutils
> > >    - flex
> > >    - fuse3
> > > - - g++
> > >    - gcc
> > >    - gcc-native
> > >    - gcovr
> > > diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> > > index 24a735a3f2..dda07ddcd1 100755
> > > --- a/tests/lcitool/refresh
> > > +++ b/tests/lcitool/refresh
> > > @@ -109,6 +109,11 @@ debian12_extras = [
> > >       "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
> > >   ]
> > > +fedora_mingw_extras = [ "\n"
> > > +    "RUN nosync dnf install -y mingw64-gcc-c++ mingw-w64-tools && \\\n"
> > > +    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-c++ && \\\n"
> > > +    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-g++\n\n"
> > > +]
> > >   def cross_build(prefix, targets):
> > >       conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
> > > @@ -193,8 +198,9 @@ try:
> > >       generate_dockerfile("fedora-win64-cross", "fedora-38",
> > >                           cross="mingw64",
> > > -                        trailer=cross_build("x86_64-w64-mingw32-",
> > > -                                            "x86_64-softmmu"))
> > > +                        trailer="".join(fedora_mingw_extras)
> > > +                                + cross_build("x86_64-w64-mingw32-",
> > > +                                              "x86_64-softmmu"))
> > >       #
> > >       # Cirrus packages lists for GitLab
> > 
> > A better way to handle this would be to define a separate project
> > 
> >    'tests/lcitool/projects/qemu-win-installer.yml'
> > 
> > With
> > 
> >     packages
> >       - g++
> > 
> > Then enable the extra project for win64
> > 
> >      generate_dockerfile("fedora-win64-cross", "fedora-38",
> >                          project='qemu,qemu-win-installer',
> >                          cross="mingw64",
> >                          trailer=cross_build("x86_64-w64-mingw32-",
> >                                              "x86_64-softmmu"))
> > 
> > which should result in an identical container to what we have today
> > for win64, while letting us slim the other containers.
> 
> Ok, good idea! ... but then we need to teach lcitool about mingw-w64-tools
> first, otherwise that vss code won't get built due to the missing "widl"
> tool.

Why is that a pre-requisite ?   What i've suggested will result in a
Dockerfile for win64 that is 100% identical to what we already have
in git today. So surely that will already succeed to the same extent
that CI succeeds today ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


