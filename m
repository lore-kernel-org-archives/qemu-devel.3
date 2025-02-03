Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D705C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 21:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf3hc-00089a-Dz; Mon, 03 Feb 2025 16:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tf3ha-00089K-FW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tf3hY-0002Oy-LU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738616991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBX+/zwQzvqQMG1tC0xTB15d/WS2GGDrqYOr7ErxtpI=;
 b=i8ZV61ciGzjVuN5qkJrvW3TS9xp6ADE4/YC6If8HvpSjN1L528l073AgMbHHD3HQAMmlXI
 gsA5oRQEbW/YRhJx1IqXb6YKw+95SC3+/wwhFZFrNpq2w7CFgSs5I2qb8NTtkAHVcUeyJw
 8Tienn25w0sQ6MEe1IDpgP3LOxwdVmY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-Xr0SjuJ5O7WnHcBdS5DcCQ-1; Mon,
 03 Feb 2025 16:09:48 -0500
X-MC-Unique: Xr0SjuJ5O7WnHcBdS5DcCQ-1
X-Mimecast-MFC-AGG-ID: Xr0SjuJ5O7WnHcBdS5DcCQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD738195608A; Mon,  3 Feb 2025 21:09:46 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.118])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDAEF18008DC; Mon,  3 Feb 2025 21:09:43 +0000 (UTC)
Date: Mon, 3 Feb 2025 22:09:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 14/15] iotests: Add qsd-migrate case
Message-ID: <Z6Ewle1d0HETQZGV@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-5-kwolf@redhat.com>
 <epcn5rh2hc3qvkild7gaei5g2of3tsztifbx6rt36srri6zeli@dn6r6ajjucf4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <epcn5rh2hc3qvkild7gaei5g2of3tsztifbx6rt36srri6zeli@dn6r6ajjucf4>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.02.2025 um 20:35 hat Eric Blake geschrieben:
> On Fri, Jan 31, 2025 at 10:50:50AM +0100, Kevin Wolf wrote:
> > Test that it's possible to migrate a VM that uses an image on shared
> > storage through qemu-storage-daemon.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/tests/qsd-migrate     | 132 +++++++++++++++++++++++
> >  tests/qemu-iotests/tests/qsd-migrate.out |  51 +++++++++
> >  2 files changed, 183 insertions(+)
> >  create mode 100755 tests/qemu-iotests/tests/qsd-migrate
> >  create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out
> > 
> > diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
> > new file mode 100755
> > index 0000000000..687bda6f93
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/qsd-migrate
> > @@ -0,0 +1,132 @@
> > +#!/usr/bin/env python3
> > +# group: rw quick
> 
> > +
> > +with iotests.FilePath('disk.img') as path, \
> > +     iotests.FilePath('nbd-src.sock', base_dir=iotests.sock_dir) as nbd_src, \
> > +     iotests.FilePath('nbd-dst.sock', base_dir=iotests.sock_dir) as nbd_dst, \
> > +     iotests.FilePath('migrate.sock', base_dir=iotests.sock_dir) as mig_sock, \
> > +     iotests.VM(path_suffix="-src") as vm_src, \
> > +     iotests.VM(path_suffix="-dst") as vm_dst:
> > +
> 
> > +
> > +    iotests.log('\nTest I/O on the source')
> > +    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'write -P 0x11 0 4k',
> > +                       use_log=True, qdev=True)
> > +    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
> > +                       use_log=True, qdev=True)
> > +
> > +    iotests.log('\nStarting migration...')
> 
> 
> Is it worth adding a test that qemu_io fails to write on the
> destination while it is inactive (to ensure we are properly rejecting
> modification of an inactive image)?

The problem with that is that the failure mode for qemu_io (which acts
as if it were a device, not an external interface) is an assertion
failure.

The other test (in patch 15) tests writes on the NBD export, which fails
gracefully.

> > +
> > +    mig_caps = [
> > +        {'capability': 'events', 'state': True},
> > +        {'capability': 'pause-before-switchover', 'state': True},
> > +    ]
> > +    vm_src.qmp_log('migrate-set-capabilities', capabilities=mig_caps)
> > +    vm_dst.qmp_log('migrate-set-capabilities', capabilities=mig_caps)
> > +    vm_src.qmp_log('migrate', uri=f'unix:{mig_sock}',
> > +                   filters=[iotests.filter_qmp_testfiles])
> > +
> > +    vm_src.event_wait('MIGRATION',
> > +                      match={'data': {'status': 'pre-switchover'}})
> > +
> > +    iotests.log('\nPre-switchover: Reconfigure QSD instances')
> > +
> > +    iotests.log(qsd_src.qmp('blockdev-set-active', {'active': False}))
> > +    iotests.log(qsd_dst.qmp('blockdev-set-active', {'active': True}))
> 
> Also, should you attempt a read on both src and dst while both sides
> are inactive, to prove that reads can take a snapshot in the middle of
> the handover?

I think this could be done without any problems.

Kevin


