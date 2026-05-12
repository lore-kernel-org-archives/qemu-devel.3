Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2370ACD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrr3-0000MZ-1G; Tue, 12 May 2026 14:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMrqc-0000Iw-5p
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMrqZ-0008SZ-0O
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778610523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5tbVYE/DPwdXmUTzfFLYyMnIDSRliFHz56I8ub7yco=;
 b=JHAyccq+xCnoM3iLO89KugjXE9FYC2aePQ1N2QiTUtEeDwecLCgSawYKMC5qog6EFLNrd6
 WucLwsrpoGOOmTlhQ3BHdyzBO1SoF1zscNnRHlQook72nV9cwJ5XXvx4xhZ94b0qXtqNbp
 3F+mbC9ExQaDf9b/pS+qNpHyBl9cEhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-1fE60azeNAihUla3xSR9hA-1; Tue,
 12 May 2026 14:28:40 -0400
X-MC-Unique: 1fE60azeNAihUla3xSR9hA-1
X-Mimecast-MFC-AGG-ID: 1fE60azeNAihUla3xSR9hA_1778610518
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43ABD180034C; Tue, 12 May 2026 18:28:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51B181955D84; Tue, 12 May 2026 18:28:37 +0000 (UTC)
Date: Tue, 12 May 2026 14:28:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: kwolf@redhat.com
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH 0/2] block: fix two missed-wakeup hangs on shutdown path
Message-ID: <20260512182834.GA912491@fedora>
References: <20260424103917.248668-1-den@openvz.org>
 <055dc8bf-f5f8-44e3-b1da-b21e05b70d94@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/NjcVVcE5GJxgp92"
Content-Disposition: inline
In-Reply-To: <055dc8bf-f5f8-44e3-b1da-b21e05b70d94@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--/NjcVVcE5GJxgp92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 11:53:37PM +0200, Denis V. Lunev wrote:
> On 4/24/26 12:39, Denis V. Lunev wrote:
> > Problem
> > -------
> >
> > The qemu shutdown / blockdev-close path can deadlock permanently on
> > upstream master.  The main thread enters ppoll(timeout=-1) holding
> > BQL, no other thread has a wake source that points back at it, and
> > qemu has to be SIGKILLed.  The hang has no timeout -- it is a hard
> > deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
> > iothread path that needs BQL stall with it.
> >
> > Two independent missed-wakeup races in the block layer contribute.
> > Both share the same shape: a waiter arms on one side, the waker
> > reads stale state on its fast path and silently skips the kick, and
> > nothing else on the AioContext will fire to recover.  They are
> > different bugs in different subsystems and each patch stands on its
> > own; they are posted together because they surface through the same
> > test and the same symptom and are easiest to diagnose side by side.
> >
> > Depending on which race fires, the main thread backtrace at the
> > moment of hang is one of:
> >
> >   ppoll -> aio_poll -> bdrv_graph_wrlock -> blk_remove_bs
> >       (patch 1 -- block/graph-lock)
> >
> >   ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
> >       (patch 2 -- block/qcow2 cache_clean_timer)
> >
> > Race diagrams and the exact stale-state read are in each patch's
> > commit message.
> >
> > Reproducer
> > ----------
> >
> > Environment used for the numbers below: 4-vCPU VM guest,
> > kernel 6.12.x, upstream master at bb230769b4.  On modern bare-metal
> > the window is narrow enough that the hangs rarely reproduce without
> > a VM -- a VM guest under full CPU saturation is what makes the
> > timing reliable.  Downstream trees that still use plain
> > bdrv_graph_wrlock() in blk_remove_bs() hit the graph-lock race on
> > the first iteration without any stress at all.
> >
> >     # reproducer
> >     stress-ng --cpu "$(nproc)" --timeout 0 &
> >     for r in $(seq 20); do
> >         timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
> >     done
> >     kill %1
> >
> > With `stress-ng --cpu $(nproc)` both races surface.  With
> > `stress-ng --cpu $(($(nproc) - 1))` or without a stressor neither
> > reproduces reliably across 20 iterations.
> >
> > When a race fires, the Python QMP client times out on vm.run_job()
> > after 5 s, the qemu process keeps running but never makes forward
> > progress, and the outer `timeout 120` eventually kills it.  attach
> > gdb before the timeout kills qemu to capture the stack and
> > distinguish which of the two races fired.
> >
> > Results
> > -------
> >
> > Same guest, 20 iterations of the loop above:
> >
> >   upstream master:            10/20 FAIL (first fail at iter #2)
> >   master + both patches:      20/20 PASS
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Hanna Reitz <hreitz@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Fiona Ebner <f.ebner@proxmox.com>
> > Cc: Hanna Czenczek <hreitz@redhat.com>
> >
> > Denis V. Lunev (2):
> >   block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
> >   block/qcow2: fix hangup in cache_clean_timer cancellation
> >
> >  block/graph-lock.c | 12 +++++-------
> >  block/qcow2.c      | 28 +++++++++++++++++-----------
> >  2 files changed, 22 insertions(+), 18 deletions(-)
> >
> > --
> > 2.51.0
> ping

Hi Kevin,
This looks like a series for your block tree. If I can help in some way,
please let me know.

Stefan

--/NjcVVcE5GJxgp92
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoDcVEACgkQnKSrs4Gr
c8glYAgApA5gaY0vXtJn18F/HI5H9wlB3nj8spx7bHWbxcEew3wvhgaoEX0UaAQq
rivyk9erY+zM+2+uGra2QbsOgCmI+TclE7Dnon2QT9gOpMXi8wf94zIxOvudv8o2
qeH9AKMu9nrsYVD2HvaxfFs0NTI2TnqvevNRuI4/mW2aSZVj0ikwe/wILKcL/LRk
kVpGKEE/l8jO5m8+rv9DKG+LvL0GY6EOAwBA0851124xyYD08q36L3Hm/SjGhzea
GY2DDDkY617YqTzs/y0E09QmFF5qyUE7MBkL4zXG9CpQB1ejTgreTISq9o1ZvPWr
piOXkgPdlc9PS06rlr/vhWsycuCIgw==
=2pyC
-----END PGP SIGNATURE-----

--/NjcVVcE5GJxgp92--


