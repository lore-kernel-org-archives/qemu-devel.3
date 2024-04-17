Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F64C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 12:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx4Gz-00067b-Gn; Wed, 17 Apr 2024 08:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx4Gw-00066R-LL
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx4Gt-0000DS-I9
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713356413;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rA3DEF4RaDau+mPX9J/9QhM0xk/Q7+LBRMlKwWpj92U=;
 b=KC0AsZDGK09XMQzzr+6rTBOKVNncNdCWrikFrZfaOywhN9sPf01rY9uFTjrblcWAnRVvfV
 rFF1ll25a79JEZSzEGZBYjQHrY48ERkZuhEG8uQISJVSi4LyeNcbjo8KseYRt+B90Zf9q4
 rAev5GABP7UonKftGZvLWSuW/91feas=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-m9hERg89PI-_7i60cnXKiQ-1; Wed,
 17 Apr 2024 08:20:10 -0400
X-MC-Unique: m9hERg89PI-_7i60cnXKiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E707E1C4C39B;
 Wed, 17 Apr 2024 12:20:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A6542026964;
 Wed, 17 Apr 2024 12:20:08 +0000 (UTC)
Date: Wed, 17 Apr 2024 13:20:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 v3 2/2] qtest/virtio-9p-test.c: remove
 g_test_slow() gate
Message-ID: <Zh--cggRnFMswR4F@redhat.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
 <a6b402b9-9f84-4d72-a631-09f04bb31450@tls.msk.ru>
 <6dc065e2-81d8-4562-84c0-8a697c58ef71@ventanamicro.com>
 <4211163.r9FPef4uHI@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4211163.r9FPef4uHI@silver>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Wed, Apr 17, 2024 at 01:52:24PM +0200, Christian Schoenebeck wrote:
> On Wednesday, April 17, 2024 1:16:02 AM CEST Daniel Henrique Barboza wrote:
> > 
> > On 4/16/24 16:54, Michael Tokarev wrote:
> > > 27.03.2024 17:20, Daniel Henrique Barboza :
> > >> Commit 558f5c42ef gated the local tests with g_test_slow() to skip them
> > >> in 'make check'. The reported issue back then was this following CI
> > >> problem:
> > >>
> > >> https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
> > >>
> > >> This problem ended up being fixed after it was detected with the
> > >> recently added risc-v machine nodes [1]. virtio-9p-test.c is now
> > >> creating and removing temporary dirs for each test run, instead of
> > >> creating a single dir for the entire qos-test scope.
> > >>
> > >> We're now able to run these tests with 'make check' in the CI, so let's
> > >> go ahead and re-enable them.
> > >>
> > >> This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.
> > >>
> > >> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> > > 
> > > This makes tests being unable to complete on a tmpfs.  It looks like
> > > 9pfs tests needs another tweak here.
> > > 
> > > # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-798502.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-798502.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M pc  -fsdev local,id=fsdev0,path='/tmp/q/master/qtest-9p-local-9LHRL2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> > > Received response 7 (RLERROR) instead of 73 (RMKDIR)
> > > Rlerror has errno 95 (Operation not supported)
> > > **
> > > ERROR:../../../build/qemu/master/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> > > 
> > > This is when I build it on /tmp/ which is a tmpfs.  When I build
> > > it on a real filesystem, it works fine.
> > > 
> > > Apparently xattrs aren't supported on a tmpfs.
> > 
> > Hmmm not sure how to proceed here since I'm not a 9p expert by any means. I'll
> > let Christian decide what to do.
> > 
> > If we can't figure it out we might need to re-introduce the gate again. Thanks,
> 
> It's not that tmpfs exactly doesn't support xattrs. It supports the trusted.*
> and security.* namespaces since 2011, so tmpfs was limited to those two. For
> the 9p 'local' backend however we also need the user.* namespace which was
> just added in Linux 6.6 last year (commit 2daf18a).
> 
> Unfortunately the respective kernel option TMPFS_XATTR is still off by default
> (linux/fs/Kconfig).
> 
> Back then, when we added that 'slow' gate for the 9p 'local' tests, things
> were a bit different. They simply did not run in the gitlab pipeline (for
> reasons described above). Now they do.
> 
> So obviously it would make sense to preserve these tests for the gitlab
> pipeline this time, e.g. by skipping these tests only if the underlying test
> directory does not support *.user xattrs. I'm just not sure yet where exactly
> such kind of *active* check would fit best into the glib test layout, as this
> can be a bit tricky with glib

You should run a method which checks ability to use '.user' xattrs, and
if it reports failure, then skip calling g_test_add. IOW, you can put
the xattr test in the same place as the old g_test_slow() check was.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


