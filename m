Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8552C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMzu-0002ai-O5; Wed, 12 Mar 2025 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsMzt-0002aR-Fz
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsMzr-0002mZ-NP
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741789425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbSo8yzblZXLH29tQ+kwyJb0SyzI7r+Kmpd8tJEbaYc=;
 b=gkE+JNkgqrlWGyTd4btXDQfWiJNM3B4TonOyHWtIET+8Zreyrfs1T/6GS6/SQ1gmQH9+4W
 COjlTfCN40OH8SqWZjXsYWmGwNwrBrv1FNjBKqjMsG0SGAZbydKueLh74M4/88c58y56pK
 JmvM1O5P60hAoVzPPlRmu3cGyVoqNt0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-FG8v1urUO7mhcaUf6KZmhw-1; Wed,
 12 Mar 2025 10:23:37 -0400
X-MC-Unique: FG8v1urUO7mhcaUf6KZmhw-1
X-Mimecast-MFC-AGG-ID: FG8v1urUO7mhcaUf6KZmhw_1741789416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69A0E19560B8; Wed, 12 Mar 2025 14:23:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D55518001E9; Wed, 12 Mar 2025 14:23:31 +0000 (UTC)
Date: Wed, 12 Mar 2025 14:23:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: Cross-compilation artifact is broken
Message-ID: <Z9GY3l2pTkbpMV8L@redhat.com>
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9GUldol1IQT1uiY@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
> > Hi All,
> > 
> > I cross-compiled qemu-ga from current master branch
> > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior.
> > 
> > Configure CLI:
> > ./configure --disable-docs --disable-system --disable-user
> > --cross-prefix=x86_64-w64-mingw32- --enable-guest-agent
> > --disable-guest-agent-msi --disable-qga-vss
> > Build CLI:
> > make -j8 qemu-ga
> > 
> > Linker wrote the following information but exited with 0 code:
> > 
> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> > qga/qemu-ga.exe:/4: section below image base
> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> > qga/qemu-ga.exe:/24: section below image base
> > 
> > As a result, this binary failed to start on Windows without any details,
> > just a message that the application is not compatible. I also tried to run
> > it with wine and got the error:
> > 
> > wine: failed to start
> > L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
> > Application could not be started, or no application associated with the
> > specified file.
> > ShellExecuteEx failed: Bad EXE format for
> > Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.
> > 
> > I bisected the tree and found the commit that caused the problem:
> > https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f723827d1b3fd4bc
> > 
> > Adding --disable-split-debug to the configure CLI fixes the issue.
> > 
> > $ x86_64-w64-mingw32-gcc --version
> > x86_64-w64-mingw32-gcc (GCC) 14.2.0
> > 
> > My question is, is this expected behavior or is this a bug?
> 
> Your configure args don't include "--enable-debug", so I would
> not have expected -gsplit-dwarf to have been enabled, so I'm
> surprised that commit casued a problem.

Hmm it appears that the meson  "get_option('debug')" is entirely
unconnected to QEMU's --enable-debug configure flag, which I did
not realize.

IOW, we've got -gsplit-dwarf enabled by default for everyone
building QEMU, which feels dubious. IMHO only an explicit
--enable-debug configure arg should have triggered it.

In addition since its breaking Windows builds, it appears we
need to block its usage on Windows.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


