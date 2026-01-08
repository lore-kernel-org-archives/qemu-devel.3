Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC82D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoK0-0003zs-To; Thu, 08 Jan 2026 06:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdoJz-0003zg-4j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdoJx-00078M-BR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767872212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGkyrrwAzhC50N+uJLXBEmKiH+xueknHR1ubUqkYILU=;
 b=biAe/N9motCgtLaT7DZaOvpBucnct6virVYw14vW0x/TnbUnALhRJMOAY39yDhRQI31AeT
 GIiO4lFgw24pzWfo5yIFNhOSyLe5J0S2JtUmGvvlUJddUQW+yNUcA0fefNz1DA4uSz6lry
 KW3nueWuRUoXB6gTY6rCAxCjQjeHgsQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250--I5EmzlON7GoyjBQ7UbSkw-1; Thu,
 08 Jan 2026 06:36:48 -0500
X-MC-Unique: -I5EmzlON7GoyjBQ7UbSkw-1
X-Mimecast-MFC-AGG-ID: -I5EmzlON7GoyjBQ7UbSkw_1767872207
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F26C18005B9; Thu,  8 Jan 2026 11:36:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B88130002D1; Thu,  8 Jan 2026 11:36:44 +0000 (UTC)
Date: Thu, 8 Jan 2026 11:36:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
Message-ID: <aV-Wx6qXaXNnqf5R@redhat.com>
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org>
 <aV902eZnijhEnONE@redhat.com>
 <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
 <aV-Ms5PQDCiIA86v@redhat.com>
 <a5c263e3-20a0-4736-9999-eca0ef639ba8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5c263e3-20a0-4736-9999-eca0ef639ba8@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 08, 2026 at 12:14:30PM +0100, Philippe Mathieu-Daudé wrote:
> On 8/1/26 11:53, Daniel P. Berrangé wrote:
> > On Thu, Jan 08, 2026 at 11:51:00AM +0100, Philippe Mathieu-Daudé wrote:
> > > On 8/1/26 10:11, Daniel P. Berrangé wrote:
> > > > On Wed, Jan 07, 2026 at 07:05:19PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > Rather than compiling the same content for all targets (unused
> > > > > most of the time, i.e. qemu-system-avr ...), build it once per
> > > > > POSIX hosts. Check Windows host (less likely) before x86 host.
> > > > > 
> > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > ---
> > > > >    dump/win_dump-stubs.c | 21 +++++++++++++++++++++
> > > > >    dump/win_dump.c       | 12 ++++++++----
> > > > >    dump/meson.build      |  6 +++++-
> > > > >    3 files changed, 34 insertions(+), 5 deletions(-)
> > > > >    create mode 100644 dump/win_dump-stubs.c
> > > > 
> > > > snip
> > > > 
> > > > > diff --git a/dump/meson.build b/dump/meson.build
> > > > > index 4277ce9328a..0aaf3f65d9c 100644
> > > > > --- a/dump/meson.build
> > > > > +++ b/dump/meson.build
> > > > > @@ -1,2 +1,6 @@
> > > > >    system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
> > > > > -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
> > > > > +if host_os == 'windows'
> > > > > +  system_ss.add(files('win_dump.c'))
> > > > > +else
> > > > > +  system_ss.add(files('win_dump-stubs.c'))
> > > > > +endif
> > > > 
> > > > This is very wrong.
> > > > 
> > > > The win_dump.c  file has no association with Windows hosts. It is about
> > > > creating crash dumps of Windows *guests* in the Windows dump format. The
> > > > current conditional which builds it on TARGET_X86_64 is correct.
> > > 
> > > Great to know this is a *guest* feature and not a *host* one.
> > > 
> > > Something else is currently wrong, because this file is built with
> > > qemu-system-avr on macOS.
> > 
> > Why is that a problem ?
> 
> Single binary can not be linked because each target has these same symbols.

So we need a make 'win_dump_available()' into a runtime check against
the current target == x86, and then unconditionally build the rest of
the file ? How do we provide access to target specific types in such
builds as merely removing the #ifdef shows missing X86CPU / CPUX86State
types for most targets.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


