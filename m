Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C17606EE90
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlKT/Niy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRtj-00058W-Fs; Mon, 09 Nov 2026 11:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQRte-00057w-RF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQRtc-0005UG-3X
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794240418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmrHQpXygXL84b5ACGx2i9Q7/zGnKrsgaCzbKMW66xE=;
 b=FlKT/NiyHbdK3N7aWqcP52G8xv3LQQtI5KICaWtNZIDJzov8PBe5fb01y25gdbn8svvaXS
 +YAVxihamFkJU7NAGw8vv8Wao+MtXVslLxoMGxCIvPA8mxVl5CqAP4MWesjsGCuBFblUJP
 N+qzQc6jww7AZzax4Xfokud1HwVmqg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-O30iXFQ0M3mf6QnvOvWOtA-1; Mon,
 09 Nov 2026 11:06:57 -0500
X-MC-Unique: O30iXFQ0M3mf6QnvOvWOtA-1
X-Mimecast-MFC-AGG-ID: O30iXFQ0M3mf6QnvOvWOtA_1794240416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4652197703F; Mon,  9 Nov 2026 16:06:55 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEE0B18004F5; Mon,  9 Nov 2026 16:06:52 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:06:50 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, berrange@redhat.com, 
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/3] iotests: Add new nbd-robustness test
Message-ID: <avHvXwdCN7GksOwN@redhat.com>
References: <20261107225834.778738-5-eblake@redhat.com>
 <20261107225834.778738-8-eblake@redhat.com>
 <20261109153622.GA429574@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109153622.GA429574@shajnocz.csb>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 08:36:22AM -0700, Stefan Hajnoczi wrote:
> On Sat, Nov 07, 2026 at 04:54:38PM -0600, Eric Blake wrote:
> > Convert the proof of concept test by Sunday Jiang into an iotest. I
> > tried to get libnbd to trigger the situation, but forcing a block
> > status command when no status has been initiated is not something that
> > libnbd is willing to do. So this results in a hard-coded sequence of
> > bytes sent over a raw socket.  Swapping the order with the previous
> > patch shows the assertion failure that was previously reachable.
> > 
> > Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/4091
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  tests/qemu-iotests/tests/nbd-robustness     | 137 ++++++++++++++++++++
> >  tests/qemu-iotests/tests/nbd-robustness.out |   5 +
> >  2 files changed, 142 insertions(+)
> >  create mode 100755 tests/qemu-iotests/tests/nbd-robustness
> >  create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out
> > 
> > diff --git a/tests/qemu-iotests/tests/nbd-robustness b/tests/qemu-iotests/tests/nbd-robustness
> > new file mode 100755
> > index 00000000000..602b7060854
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/nbd-robustness
> > @@ -0,0 +1,137 @@
> > +#!/usr/bin/env python3
> > +# group: rw auto quick
> > +#
> > +# Test cases for NBD robustness against malicious clients
> > +#
> > +# Copyright (C) 2026 Red Hat, Inc.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +from contextlib import contextmanager
> > +
> > +import iotests
> > +from iotests import qemu_img_create, qemu_io
> > +
> > +import socket
> > +import struct
> > +
> > +
> > +disk = os.path.join(iotests.test_dir, 'disk')
> > +size = '4M'
> > +nbd_sock = os.path.join(iotests.sock_dir, 'nbd_sock')
> > +nbd_uri = 'nbd+unix:///{}?socket=' + nbd_sock
> > +nbd: ModuleType
> 
> nbd is never used and ModuleType is in the types stdlib package, which
> is not included here. This looks like it can be removed.

Indeed, it was leftover copy-paste from nbd-commands when I was first
trying to use libnbd to drive the reproducer, before figuring out that
libnbd can't trigger it. Will fix.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


