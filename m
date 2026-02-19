Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD0E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt59X-0002Lt-6n; Thu, 19 Feb 2026 09:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vt590-0001r8-64
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:36:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vt58u-0003N6-24
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771511792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9+tLD2muKLycvIdV0uhMhugIZqPTPjgoKPG+t+apmro=;
 b=ZXD9BxrGHTWVPKLfZaXDRxHStpLhR2k+0F8aX9gWNwvBalvHlpRKwMEgPK1MfOeTxSGc2U
 8wnN2mOK52eWZG6ftVjKBNEMDfeyYOBfRu040hxlCta6aLsF+Wy2q00njW9LDXxlSsekDT
 OPaFG6jD6wcjkE44MElJc+Xhl+/XWZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-k8SYSz7aPXqCJ1gyiE1FeA-1; Thu,
 19 Feb 2026 09:36:25 -0500
X-MC-Unique: k8SYSz7aPXqCJ1gyiE1FeA-1
X-Mimecast-MFC-AGG-ID: k8SYSz7aPXqCJ1gyiE1FeA_1771511783
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 036911800370; Thu, 19 Feb 2026 14:36:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D391800370; Thu, 19 Feb 2026 14:36:21 +0000 (UTC)
Date: Thu, 19 Feb 2026 09:36:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: COLO concurrency issues
Message-ID: <20260219143620.GC817358@fedora>
References: <87ms1cn8n6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OfZLHe6izNeqKmof"
Content-Disposition: inline
In-Reply-To: <87ms1cn8n6.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--OfZLHe6izNeqKmof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 09:13:49AM -0300, Fabiano Rosas wrote:
> Hi, I've been following the qemu-colo.rst steps to test COLO and
> encountered a couple of issues. Unfortunately, I don't have cycles to
> investigate further. Happens with QEMU master (also tested some versions
> back until the COLO fix 0b5bf4ea76).
>=20
> 1) Deadlock at fdmon_io_uring_wait:
>=20
> (steps from qemu-colo.rst)
> - Secondary Failover
> - Secondary resume replication
> - Start the new Secondary
> - Sync
> - Wait until disk is synced, then:
>=20
>     {"execute": "stop"}
>     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
>=20
> The above results in the old secondary hanging indefinitely at:
>=20
>     do {
>         ret =3D io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
>     } while (ret =3D=3D -EINTR);
>=20
> (gdb) bt                                                                 =
                                                                           =
                         =20
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x00007f5519e0204e in ??? () at //usr/lib64/liburing.so.2
> #2  0x00007f5519e01b00 in ??? () at //usr/lib64/liburing.so.2
> #3  0x0000563c2dc06cc9 in fdmon_io_uring_wait (ctx=3D0x563c30411b00, read=
y_list=3D0x7ffd0bad8f58, timeout=3D575708467831) at ../util/fdmon-io_uring.=
c:416
> #4  0x0000563c2dc00976 in aio_poll (ctx=3D0x563c30411b00, blocking=3Dtrue=
) at ../util/aio-posix.c:699
> #5  0x0000563c2daa01c6 in bdrv_drain_all_begin () at ../block/io.c:529
> #6  0x0000563c2daa03d8 in bdrv_drain_all () at ../block/io.c:574
> #7  0x0000563c2d764aae in do_vm_stop (state=3DRUN_STATE_PAUSED, send_stop=
=3Dtrue) at ../system/cpus.c:312
> #8  0x0000563c2d765964 in vm_stop (state=3DRUN_STATE_PAUSED) at ../system=
/cpus.c:754
> #9  0x0000563c2d7f3378 in qmp_stop (errp=3D0x7ffd0bad9080) at ../monitor/=
qmp-cmds.c:62
> #10 0x0000563c2dba7a72 in qmp_marshal_stop (args=3D0x563c306ac070, ret=3D=
0x7f5518dffda8, errp=3D0x7f5518dffda0) at qapi/qapi-commands-misc.c:197
> #11 0x0000563c2dbf1316 in do_qmp_dispatch_bh (opaque=3D0x7f5518dffe40) at=
 ../qapi/qmp-dispatch.c:128
> #12 0x0000563c2dc1de48 in aio_bh_call (bh=3D0x563c3040fef0) at ../util/as=
ync.c:173
> #13 0x0000563c2dc1df64 in aio_bh_poll (ctx=3D0x563c3040c070) at ../util/a=
sync.c:220
> #14 0x0000563c2dbffff0 in aio_dispatch (ctx=3D0x563c3040c070) at ../util/=
aio-posix.c:389
> #15 0x0000563c2dc1e3cd in aio_ctx_dispatch (source=3D0x563c3040c070, call=
back=3D0x0, user_data=3D0x0) at ../util/async.c:365
> #16 0x00007f551b114f4c in g_main_dispatch (context=3D0x563c304120f0) at .=
=2E/glib/gmain.c:3476
> #17 g_main_context_dispatch_unlocked (context=3Dcontext@entry=3D0x563c304=
120f0) at ../glib/gmain.c:4284
> #18 0x00007f551b1170c9 in g_main_context_dispatch (context=3D0x563c304120=
f0) at ../glib/gmain.c:4272
> #19 0x0000563c2dc1fa0b in glib_pollfds_poll () at ../util/main-loop.c:290
> #20 0x0000563c2dc1fa85 in os_host_main_loop_wait (timeout=3D0) at ../util=
/main-loop.c:313
> #21 0x0000563c2dc1fb8a in main_loop_wait (nonblocking=3D0) at ../util/mai=
n-loop.c:592
> #22 0x0000563c2d78eb60 in qemu_main_loop () at ../system/runstate.c:903
> #23 0x0000563c2db412fc in qemu_default_main (opaque=3D0x0) at ../system/m=
ain.c:50
> #24 0x0000563c2db413ab in main (argc=3D40, argv=3D0x7ffd0bad94d8) at ../s=
ystem/main.c:93

Two ideas on how to debug further:

1. Attach to the hung QEMU process with a debugger and inspect the
block_backends global variable (see block/block-backends.c). The
question is why bdrv_drain_all_begin() is not making progress. There are
probably in-flight requests that can be observed in the
BlockDriverState->tracked_requests list. Also check the BlockDriverState
and BlockBackend in_flight fields. This will let you identify which
block device is causing the hang and what it's doing during the hang.

2. Try disabling io_uring on the host via `sudo sysctl
kernel.io_uring_disabled=3D2` and then run QEMU again. If this is an issue
with QEMU's recently-enabled io_uring event loop, then there will be no
hang with io_uring disabled.

Stefan

--OfZLHe6izNeqKmof
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmXH+QACgkQnKSrs4Gr
c8hRqggAoQFLYTLVNK81cHT7fLOBzfiYHroeGzY86085YaGO23uOCZmnS9zncOc2
sSGsOsxiMTx1iR+rRjYnF0LYCNsWyfsP1c/c+mIac9gGm5AlkTuh5svDc9OCmeJ1
f9BMmLckO7Qe7A1htPiDz+FRPs0GREivbvhVwbl5/fUi1CQ9t5tvflAGS7IANlbC
sLNfNOIKInShaQRa/TTzGkA2yKRxE+l/rFdECzsN6Qwzu0g3JnDXxB56Uwv/YjwM
3HCaJtG5tte7Yyye9OzDxZrWw+DZEueYwjzOtk+YfIpXs+yAH+zIV0n2Ir1Hz9pQ
pdITSY9k34QCo690bxuVjFfGKIHttA==
=ciRN
-----END PGP SIGNATURE-----

--OfZLHe6izNeqKmof--


