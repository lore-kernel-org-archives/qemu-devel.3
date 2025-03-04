Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3E4C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 11:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpQc8-0007ci-VL; Tue, 04 Mar 2025 06:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpQc7-0007cG-5n
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpQc4-00018L-L3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741088342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSFj9wdtE3/9XnQtUdiXP3KRWtDfx77ncg//5QSxAcY=;
 b=GcJ/LtFtlFvDVSjXbRmS79wQmW54ZMArnDEkRdtrXBXNIVgxcpWTs0A7ObPzSTZf7CYHV2
 8+23DT0WzKEo046MqMerN41nrjdGnFrT0vuL+nQDIIBIvj1O/xia3lhyGW9SeSz1XklS2L
 gBFvXh2/MHsrJeWto7Sh8mF/MTpACtc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-Gyu2UykKP0y_NoISY6VbZQ-1; Tue,
 04 Mar 2025 06:38:45 -0500
X-MC-Unique: Gyu2UykKP0y_NoISY6VbZQ-1
X-Mimecast-MFC-AGG-ID: Gyu2UykKP0y_NoISY6VbZQ_1741088324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125ED1944D69; Tue,  4 Mar 2025 11:38:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B98953000197; Tue,  4 Mar 2025 11:38:40 +0000 (UTC)
Date: Tue, 4 Mar 2025 11:38:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
Message-ID: <Z8bmOBezwcaeUjYk@redhat.com>
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
 <Z8bTy54Jgaddg6V3@redhat.com> <87tt8958tj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt8958tj.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 04, 2025 at 11:33:44AM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Bennée wrote:
> >> This option is supported by both gcc (since 4.7) and clang (since
> >> 7.0). Not only does this make the linkers job easier by reducing the
> >> amount of ELF it needs to parse it also reduces the total build size
> >> quite considerably. In my case a default build went from 5.8G to 3.9G.
> >
> > I've not come across this option before, but the docs say
> >
> >   ‘-gsplit-dwarf’
> >      If DWARF debugging information is enabled, separate as much
> >      debugging information as possible into a separate output file with
> >      the extension ‘.dwo’.  This option allows the build system to avoid
> >      linking files with debug information.  To be useful, this option
> >      requires a debugger capable of reading ‘.dwo’ files.
> >
> > In Fedora and RHEL we build QEMU will full debug enabled, and then a feature
> > of the distro RPM build config will post-process all ELF files to extract
> > the debug info into files that we store under /usr/lib/debug. eg for
> > /usr/bin/qemu-system-x86_64, we get a separate
> > /usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
> > tools like GDB, etc know to look for these separate files.
> 
> A modern gdb can certainly handle fetching the debug out of the .dwo
> files when debugging.
> 
> >
> > When I test our RPM build process with this -gsplit-dwarf flag added,
> > we fail to find any debug symbols in the QEMU binaries and thus the
> > whole RPM package build aborts.
> 
> Do you know if you build the kernel the same way? That has had the
> option to do split dwarf files for awhile.

The kernel use of -gsplit-dwarf is behind the CONFIG_DEBUG_INFO_SPLIT
KConfig option, and that remains unset in Fedora/RHEL builds

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


