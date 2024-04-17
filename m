Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFA7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx3q5-00087p-4J; Wed, 17 Apr 2024 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rx3q4-00087b-2R
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:52:32 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rx3q1-0003pZ-RE
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=A2CYA/hS9A+rMSJii290yd9UwLamXd3g49DOSBfA7iA=; b=eorRSGVwX1AoulUIMoU3sgaWjK
 Nsd/dCSyIqRZDS1J0PN5ljIwARKpy83qzKhOaotXm+e+bLn+zaJZeKR3DWcycyEuDlUivXhKWmSRq
 m5AQSgK76kA/RpKHxRW9U/iVXBH38hgi3w6TTz6+/3Nhff3CQLeyBgkMFu9qwiSco7cg5nPyUtAH5
 eoAN5rCKXJhhAZk9UWqE9wBjKTitZsgUqyV85h7/RM0SmZzNmocxP3tesavknAG3J4Wm8la4QGirb
 AfedPTlSto8h/hGGatHPol7pDdUJ7I4O+vXOMBeWQOXH18I6F61tqYhECOAgDkOacctG0hKQN3U3+
 ieB2fHu/B1cfYkSoMRiMr+fO8/lukSwgXlOf81K7M+x8ezWpXUcJT/0q9MHzWp/ELSqTKDJXJDLCk
 vDuQ9XbMvnitMdkX65LNwoogr8j5MxrsqbXPaTOcU5Uvu0n/Q2nZybtc3S2DouHl/Hsip4JB04Ku/
 UBETIXcXQfQCTEJ45QVFhvykBSdgxuCrAkCjr+6x3fkcbizX303zy3PxrPx2Fzdux92Jw0CBkpZqH
 KQBHss1Ew01YZnHGYE81ni5ER6BjopLafzTMPIsM7KtGkFIggpbJkKk+aGQq9zaexBcWtSBUjiEak
 hk0P9K46HRXTenpu+k53bK8knmef0LUohV5FTylGk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 v3 2/2] qtest/virtio-9p-test.c: remove
 g_test_slow() gate
Date: Wed, 17 Apr 2024 13:52:24 +0200
Message-ID: <4211163.r9FPef4uHI@silver>
In-Reply-To: <6dc065e2-81d8-4562-84c0-8a697c58ef71@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
 <a6b402b9-9f84-4d72-a631-09f04bb31450@tls.msk.ru>
 <6dc065e2-81d8-4562-84c0-8a697c58ef71@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wednesday, April 17, 2024 1:16:02 AM CEST Daniel Henrique Barboza wrote:
> 
> On 4/16/24 16:54, Michael Tokarev wrote:
> > 27.03.2024 17:20, Daniel Henrique Barboza :
> >> Commit 558f5c42ef gated the local tests with g_test_slow() to skip them
> >> in 'make check'. The reported issue back then was this following CI
> >> problem:
> >>
> >> https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
> >>
> >> This problem ended up being fixed after it was detected with the
> >> recently added risc-v machine nodes [1]. virtio-9p-test.c is now
> >> creating and removing temporary dirs for each test run, instead of
> >> creating a single dir for the entire qos-test scope.
> >>
> >> We're now able to run these tests with 'make check' in the CI, so let's
> >> go ahead and re-enable them.
> >>
> >> This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.
> >>
> >> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> > 
> > This makes tests being unable to complete on a tmpfs.  It looks like
> > 9pfs tests needs another tweak here.
> > 
> > # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-798502.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-798502.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M pc  -fsdev local,id=fsdev0,path='/tmp/q/master/qtest-9p-local-9LHRL2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> > Received response 7 (RLERROR) instead of 73 (RMKDIR)
> > Rlerror has errno 95 (Operation not supported)
> > **
> > ERROR:../../../build/qemu/master/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> > 
> > This is when I build it on /tmp/ which is a tmpfs.  When I build
> > it on a real filesystem, it works fine.
> > 
> > Apparently xattrs aren't supported on a tmpfs.
> 
> Hmmm not sure how to proceed here since I'm not a 9p expert by any means. I'll
> let Christian decide what to do.
> 
> If we can't figure it out we might need to re-introduce the gate again. Thanks,

It's not that tmpfs exactly doesn't support xattrs. It supports the trusted.*
and security.* namespaces since 2011, so tmpfs was limited to those two. For
the 9p 'local' backend however we also need the user.* namespace which was
just added in Linux 6.6 last year (commit 2daf18a).

Unfortunately the respective kernel option TMPFS_XATTR is still off by default
(linux/fs/Kconfig).

Back then, when we added that 'slow' gate for the 9p 'local' tests, things
were a bit different. They simply did not run in the gitlab pipeline (for
reasons described above). Now they do.

So obviously it would make sense to preserve these tests for the gitlab
pipeline this time, e.g. by skipping these tests only if the underlying test
directory does not support *.user xattrs. I'm just not sure yet where exactly
such kind of *active* check would fit best into the glib test layout, as this
can be a bit tricky with glib.

/Christian



