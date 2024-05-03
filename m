Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D99DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 10:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ptx-0008Sl-L5; Fri, 03 May 2024 06:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2ptw-0008S5-RS
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2ptu-0004Pl-Kc
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714731141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8fwFIN6e2AzVvBRcz7Mss+aqBdqwZCOYdZc2K7W9cQ=;
 b=evfxMYbLlyYxGsmos7z3ZqAip388TVkFY/r0pCf7FDZmfcKM+cRowSiR7pcn3bcnj++oDo
 kgDoFVH46x/ERDRdO6axD2DREZO7ahQDl/LEMy1TVA3kiCQi1IPY4vfAb0nVo2NG1TGCmg
 hDkenDbsdCXyQvZcE5wZCl3KZBHDsTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-xiDB7ZnEOx6eNjoiBxgU2Q-1; Fri, 03 May 2024 06:12:17 -0400
X-MC-Unique: xiDB7ZnEOx6eNjoiBxgU2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B7EC80017B;
 Fri,  3 May 2024 10:12:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F7540EE0E;
 Fri,  3 May 2024 10:12:16 +0000 (UTC)
Date: Fri, 3 May 2024 11:12:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
Message-ID: <ZjS4fqE1OdpTgeMq@redhat.com>
References: <20240503071634.841103-1-mjt@tls.msk.ru>
 <ZjSbRsOpJsTdTh6l@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjSbRsOpJsTdTh6l@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

On Fri, May 03, 2024 at 09:07:34AM +0100, Daniel P. Berrangé wrote:
> On Fri, May 03, 2024 at 10:16:34AM +0300, Michael Tokarev wrote:
> > Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
> > This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
> > 
> > riscv64 in debian has been non-functioning for almost a year, after the
> > architecture has been promoted to release architecture and all binary
> > packages started to be re-built, making the port not multi-arch-co-installable
> > for a long time (in debian, multi-arch packages must be of the same version,
> > but when a package is rebuilt on one architecture it gets a version bump too).
> > Later on, debiah had a long time64_t transition which made sid unusable for
> > quite some time too.  Both such events happens in debian very rarely (like,
> > once in 10 years or so - for example, previous big transition like that was
> > libc5 => libc6 transition).  Now both of these are finished (where qemu is
> > concerned anyway).
> > 
> > Hopefully debian unstable wont be very unstable.  At the very least it is
> > better to have sporadic CI failures here than no riscv64 coverage at all.
> 
> IME of running Debian sid in CI pipelines for libvirt, it is
> way too unstable to be used as a gating job. There are periods
> weeks-long when packages fail to install, even for relatively
> mainstream arch targets like x86, let alone a new target like
> riscv.

BTW, I don't mean this to be a criticism of Debian. We've seen
the same kind of instability with all the other non-released distros
(Fedora Rawhide, OpenSUSE Tumbleweed and Alpine Edge) in libvirt CI,
such that we've finally set all of them non-gating across all our CI
deployments.

They're all good to have in CI as a smoke test to identify possible
problems coming towards you in the next stable release, but false
failures have to be expected.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


