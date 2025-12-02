Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D338D12668
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQW4j-0001GW-Ft; Tue, 02 Dec 2025 14:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vQW4i-0001GO-0x
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vQW4f-0008KH-Tj
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764703806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cpNraFvPB85O+/FnHMRPjEY49VYP9wLwaQ37CZFVHjw=;
 b=fyN/ff5+b4Ls4q8hy9YRlvU9PYwZ9t9MKF8A+aUBYWn3CZ9QbBpD0O04ryBX0yh29QTZYp
 rMTWLDtvkJ38dGVLFNGXE14euem5AkOIGXusSsw2yROP4jfrXesHpCRGQ5SWZN8yCx6B3h
 upQddOjh/SEe//p295hJztXYc/3tQtg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-2NKGn3ZsOoCPkMdY34L_aQ-1; Tue,
 02 Dec 2025 14:30:05 -0500
X-MC-Unique: 2NKGn3ZsOoCPkMdY34L_aQ-1
X-Mimecast-MFC-AGG-ID: 2NKGn3ZsOoCPkMdY34L_aQ_1764703804
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EED819560B2; Tue,  2 Dec 2025 19:30:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.249])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84630180087B; Tue,  2 Dec 2025 19:30:02 +0000 (UTC)
Date: Tue, 2 Dec 2025 14:30:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH v2 4/4] scripts/qemugdb: coroutine: Add option for
 obtaining detailed trace in coredump
Message-ID: <20251202193001.GB964933@fedora>
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
 <20251202163119.363969-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t7rcOUcg6c9O3YfR"
Content-Disposition: inline
In-Reply-To: <20251202163119.363969-5-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--t7rcOUcg6c9O3YfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 06:31:19PM +0200, Andrey Drobyshev wrote:
> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> coredumps") introduced coroutine traces in coredumps using raw stack
> unwinding.  While this works, this approach does not allow to view the
> function arguments in the corresponding stack frames.
>=20
> As an alternative, we can obtain saved registers from the coroutine's
> jmpbuf, patch them into the coredump's struct elf_prstatus in place, and
> execute another gdb subprocess to get backtrace from the patched temporary
> coredump.
>=20
> While providing more detailed info, this alternative approach, however, is
> more invasive as it might potentially corrupt the coredump file. We do ta=
ke
> precautions by saving the original registers values into a separate binary
> blob /path/to/coredump.ptregs, so that it can be restores in the next
> GDB session.  Still, instead of making it a new deault, let's keep raw un=
wind
> the default behaviour, but add the '--detailed' option for 'qemu bt' and
> 'qemu coroutine' command which would enforce the new behaviour.
>=20
> That's how this looks:
>=20
>   (gdb) qemu coroutine 0x7fda9335a508
>   #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/corouti=
ne-ucontext.c:321
>   #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu=
-coroutine.c:293
>   #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
>   #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
>   #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
>   #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
>   #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
>   #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread=
-posix.c:393
>=20
>   (gdb) qemu coroutine 0x7fda9335a508 --detailed
>   patching core file /tmp/tmpq4hmk2qc
>   found "CORE" at 0x10c48
>   assume pt_regs at 0x10cbc
>   write r15 at 0x10cbc
>   write r14 at 0x10cc4
>   write r13 at 0x10ccc
>   write r12 at 0x10cd4
>   write rbp at 0x10cdc
>   write rbx at 0x10ce4
>   write rip at 0x10d3c
>   write rsp at 0x10d54
>=20
>   #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=3D0x7fda9335a508=
, to_=3D0x7fda8400c280, action=3DCOROUTINE_ENTER) at ../util/coroutine-ucon=
text.c:321
>   #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=3D0x5602bf7147c=
0, co=3D0x7fda8400c280) at ../util/qemu-coroutine.c:293
>   #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=3D0x5602bf7147c0) a=
t ../util/async.c:547
>   #3  0x00005602bdb3b518 in aio_bh_call (bh=3D0x5602bf714a40) at ../util/=
async.c:172
>   #4  0x00005602bdb3b79a in aio_bh_poll (ctx=3D0x5602bf7147c0) at ../util=
/async.c:219
>   #5  0x00005602bdb10f22 in aio_poll (ctx=3D0x5602bf7147c0, blocking=3Dtr=
ue) at ../util/aio-posix.c:719
>   #6  0x00005602bd8fb1ac in iothread_run (opaque=3D0x5602bf42b100) at ../=
iothread.c:63
>   #7  0x00005602bdb18a24 in qemu_thread_start (args=3D0x5602bf7164a0) at =
=2E./util/qemu-thread-posix.c:393
>   #8  0x00007fda9e89f7f2 in start_thread (arg=3D<optimized out>) at pthre=
ad_create.c:443
>   #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_6=
4/clone3.S:81
>=20
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Peter Xu <peterx@redhat.com>
> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  scripts/qemugdb/coroutine.py | 243 +++++++++++++++++++++++++++++++++--
>  1 file changed, 233 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> index e98fc48a4b..280c02c12d 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -10,9 +10,116 @@
>  # or later.  See the COPYING file in the top-level directory.
> =20
>  import gdb
> +import os
> +import pty
> +import re
> +import struct
> +import textwrap
> +
> +from collections import OrderedDict
> +from copy import deepcopy
> =20
>  VOID_PTR =3D gdb.lookup_type('void').pointer()
> =20
> +# Registers in the same order they're present in ELF coredump file.
> +# See asm/ptrace.h
> +PT_REGS =3D ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10', 'r9=
',
> +           'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax', 'rip', '=
cs',
> +           'eflags', 'rsp', 'ss']
> +
> +coredump =3D None
> +
> +
> +class Coredump:
> +    _ptregs_suff =3D '.ptregs'
> +
> +    def __init__(self, coredump, executable):
> +        gdb.events.exited.connect(self._cleanup)

It's not clear to me that this cleanup mechanism is reliable:

- The restore_regs() method is called from invoke(), but not in a
  `finally` block that would guarantee it runs even when an exception is
  thrown. Maybe _cleanup() can be called without a prior restore_regs()
  call. It would be inconvenient to lose the original register values.

- I'm not sure if gdb.events.exited (when GDB's inferior terminates) is
  the correct event to ensure cleanup. The worst case is that the
  temporary file is leaked, which is not a serious problem.

But then this is a debugging script and it's probably fine:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t7rcOUcg6c9O3YfR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkvPjkACgkQnKSrs4Gr
c8iARAf9EFtYqUQYi/147eKt6tppX/cJo1NfU+sL6c7oAcxZiDMxb9upt8Jcj1Js
4LtP+PNbq7WIywmhkQvhvVrdufCG4ntTIB6zVDKfah89MKpRegueJjU5eF47iAUa
agTGgaWMXCC0a6p9GBKk5QGjAdAoref+cqR/FjU9GHWxPl/ZqIEAlBlVVLiwdMQy
30EzO0DG4+7zeWqVYYd2erJ/Si8ucL1kMwvqIu0qbheeuGzM+lyjNGKjJsDlzplh
4wsf3EvSILZRRx36LlbLLulgtPtlMrPgbYe5HbtlqRoDFrjquCff0IMZvipkTMdy
PR3mJULZB+YB8fJCZHIAhnbmw1sSTg==
=4DYz
-----END PGP SIGNATURE-----

--t7rcOUcg6c9O3YfR--


