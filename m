Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD4DCCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6TM-0003k6-Qb; Mon, 03 Nov 2025 21:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6TC-0003jQ-77
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6T9-0002cX-Qq
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762222101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DaEUoXQtprXRljEa/AO3eufwxiT841MmdEmlqbsAhd0=;
 b=EYS9PdZdZK8QotZoFlGgNAwE9tgMeXNNi3fBwJr9KTpNrcjYxnQePWypa38bV4/kYXflxW
 10wdtLyBe1FrD/mzPsnVUdr38Uasx9+DJQ0V2a/iVIoduMyp7UL4NnEhwTpRMcfZN+qcSI
 /E7JRrNiOUoxR2WTs+2R+f74NuhXA0w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695--FjJJP0wPseyqCgY8yknbw-1; Mon,
 03 Nov 2025 21:08:19 -0500
X-MC-Unique: -FjJJP0wPseyqCgY8yknbw-1
X-Mimecast-MFC-AGG-ID: -FjJJP0wPseyqCgY8yknbw_1762222098
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C9D1956095; Tue,  4 Nov 2025 02:08:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CD7B1800451; Tue,  4 Nov 2025 02:08:17 +0000 (UTC)
Date: Mon, 3 Nov 2025 21:08:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, hibriansong@gmail.com,
 eblake@redhat.com, qemu-block@nongnu.org
Subject: Re: [RESEND PATCH v5 00/13] aio: add the aio_add_sqe() io_uring API
Message-ID: <20251104020816.GA114652@fedora>
References: <20251030152150.470170-1-stefanha@redhat.com>
 <aQOqau-bpiJiNVHI@redhat.com> <aQiGjUW59RI12Gb_@redhat.com>
 <aQiuenOKNLPzYtGb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d9RfUKa2a2howWXm"
Content-Disposition: inline
In-Reply-To: <aQiuenOKNLPzYtGb@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--d9RfUKa2a2howWXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 02:30:34PM +0100, Kevin Wolf wrote:
> Am 03.11.2025 um 11:40 hat Kevin Wolf geschrieben:
> > Am 30.10.2025 um 19:11 hat Kevin Wolf geschrieben:
> > > Am 30.10.2025 um 16:21 hat Stefan Hajnoczi geschrieben:
> > > > v5:
> > > > - Explain how fdmon-io_uring.c differs from other fdmon implementat=
ions
> > > >   in commit message [Kevin]
> > > > - Move test-nested-aio-poll aio_get_g_source() removal into commit =
that touches test case [Kevin]
> > > > - Avoid g_source_add_poll() use-after-free in fdmon_poll_update() [=
Kevin]
> > > > - Avoid duplication in fdmon_epoll_gsource_dispatch(), use fdmon_ep=
oll_wait() [Kevin]
> > > > - Drop unnecessary revents checks in fdmon_poll_gsource_dispatch() =
[Kevin]
> > > > - Mention in commit message that fdmon-io_uring.c is the new defaul=
t [Kevin]
> > > > - Add comments explaining how to clean up resources in error paths =
[Kevin]
> > > > - Indicate error in return value from function with Error *errp arg=
 [Kevin]
> > > > - Add patch to unindent fdmon_io_uring_destroy() [Kevin]
> > > > - Add patch to introduce FDMonOps->dispatch() callback [Kevin]
> > > > - Drop patch with hacky BH optimization for fdmon-io_uring.c [Kevin]
> > > > - Replace cqe_handler_bh with FDMonOps->dispatch() [Kevin]
> > > > - Rename AioHandler->cqe_handler field to ->internal_cqe_handler [K=
evin]
> > > > - Consolidate fdmon-io_uring.c trace-events changes into this commit
> > > > - Reduce #ifdef HAVE_IO_URING_PREP_WRITEV2 code duplication [Kevin]
> > >=20
> > > The changes look good to me.
> > >=20
> > > However, the test cases are still failing. I just tried to see where
> > > test-aio is stuck, and while I looked for a backtrace first, I noticed
> > > that just attaching gdb to the process and immediately detaching again
> > > makes the test unstuck. Very strange.
> > >=20
> > > This is the backtrace, maybe a bit unsurpring:
> > >=20
> > > (gdb) bt
> > > #0  0x00007ffff7e6fec6 in __io_uring_submit () from /lib64/liburing.s=
o.2
> > > #1  0x00005555556f4394 in fdmon_io_uring_wait (ctx=3D0x555556409950, =
ready_list=3D0x7fffffffcda0, timeout=3D749993088) at ../util/fdmon-io_uring=
=2Ec:410
> > > #2  0x00005555556ed29f in aio_poll (ctx=3D0x555556409950, blocking=3D=
true) at ../util/aio-posix.c:699
> > > #3  0x0000555555681547 in test_timer_schedule () at ../tests/unit/tes=
t-aio.c:413
> > > #4  0x00007ffff6f30e7e in test_case_run (tc=3D0x55555640d340, test_ru=
n_name=3D0x55555640de10 "/aio/timer/schedule", path=3D<optimized out>) at .=
=2E/glib/gtestutils.c:3115
> > > #5  g_test_run_suite_internal (suite=3Dsuite@entry=3D0x5555558696d0, =
path=3Dpath@entry=3D0x0) at ../glib/gtestutils.c:3210
> > > #6  0x00007ffff6f30df3 in g_test_run_suite_internal (suite=3Dsuite@en=
try=3D0x555555867480, path=3Dpath@entry=3D0x0) at ../glib/gtestutils.c:3229
> > > #7  0x00007ffff6f30df3 in g_test_run_suite_internal (suite=3Dsuite@en=
try=3D0x555555867720, path=3Dpath@entry=3D0x0) at ../glib/gtestutils.c:3229
> > > #8  0x00007ffff6f313aa in g_test_run_suite (suite=3Dsuite@entry=3D0x5=
55555867720) at ../glib/gtestutils.c:3310
> > > #9  0x00007ffff6f31440 in g_test_run () at ../glib/gtestutils.c:2379
> > > #10 g_test_run () at ../glib/gtestutils.c:2366
> > > #11 0x000055555567e204 in main (argc=3D1, argv=3D0x7fffffffd488) at .=
=2E/tests/unit/test-aio.c:872
> > >=20
> > > And running it under strace shows that we're indeed hanging in the
> > > syscall:
> > >=20
> > > write(1, "# Start of timer tests\n", 23) =3D 23
> > > eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK)   =3D 9
> > > io_uring_enter(7, 1, 0, 0, NULL, 8)     =3D 1
> > > clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D1, tv_nsec=3D0}, 0x7ffc2=
39bec80) =3D 0
> > > io_uring_enter(7, 1, 1, IORING_ENTER_GETEVENTS, NULL, 8
> > >=20
> > > Of course, if I start the test without strace and then attach strace =
to
> > > the running process, that gets it unstuck like attaching gdb (not very
> > > surprising, I guess, it's both just ptrace).
> > >=20
> > > Finally I tried Ctrl-C while having strace logging to a file, and now
> > > the io_uring_enter() returns 1 (rather than EINTR or 0 or whatever):
> > >=20
> > > io_uring_enter(7, 1, 1, IORING_ENTER_GETEVENTS, NULL, 8) =3D 1
> > > --- SIGINT {si_signo=3DSIGINT, si_code=3DSI_KERNEL} ---
> > > +++ killed by SIGINT +++
> > >=20
> > > Not sure what to make of this.
> > >=20
> > > I think you already said you run the same kernel version, but just to=
 be
> > > sure, I'm running 6.17.5-200.fc42.x86_64.
> >=20
> > I'm at the point where I'm bisecting compiler flags...
> >=20
> > I have seen three different outcomes from test-aio:
> >=20
> > 1. It hangs. This is what I saw in my normal clang build. This configure
> >    line seems to be enough to trigger it:
> >    ../configure '--target-list=3Dx86_64-softmmu' '--cc=3Dclang' '--cxx=
=3Dclang++'
> >=20
> > 2. An assertion failure. I haven't seen this in the actual QEMU tree
> >    with clang. With gcc, it seems to happen if you use -O0:
> >    ../configure '--target-list=3Dx86_64-softmmu' '--enable-debug'
> >=20
> >    Outside of the QEMU tree with a manual Makefile, I saw this behaviour
> >    with clang and -fstack-protector-strong, but without
> >    -ftrivial-auto-var-init=3Dzero. Add the latter turns it into the han=
g.
> >=20
> > 3. It just passes. This is what I saw in my default gcc build without
> >    --enable-debug. The test also passes with --disable-stack-protector
> >    added to both configure lines in 1 and 2.
> >=20
> > Not sure yet where the flags make the difference, but I guess it does
> > hint at something going wrong on the stack.
>=20
> Ok, that was quite some debugging, but I think I have it. The problem is
> add_timeout_sqe():
>=20
> static void add_timeout_sqe(AioContext *ctx, int64_t ns)
> {
>     struct io_uring_sqe *sqe;
>     ts =3D (struct __kernel_timespec) {
>         .tv_sec =3D ns / NANOSECONDS_PER_SECOND,
>         .tv_nsec =3D ns % NANOSECONDS_PER_SECOND,
>     };
>=20
>     sqe =3D get_sqe(ctx);
>     io_uring_prep_timeout(sqe, &ts, 1, 0);
>     io_uring_sqe_set_data(sqe, NULL);
> }
>=20
> What io_uring_prep_timeout() does is that it just stores the ts pointer
> in the SQE, the timeout is never copied anywhere. Obviously, by the time
> that we submit the SQE, ts has been out of scope for a long time, so the
> kernel reads random data as a timeout.
>=20
> # bpftrace -e 'kfunc:io_timeout { printf("%s: io_timeout %lld s + %lld ns=
\n", comm, ((struct io_timeout_data *)args.req->async_data)->ts.tv_sec, ((s=
truct io_timeout_data *)args.req->async_data)->ts.tv_nsec ) }'
> Attaching 1 probe...
> test-aio: io_timeout 0 s + 140736377549872 ns
>=20
> >>> hex(140736377549872)
> '0x7fffbdca7430'
>=20
> That looked a bit suspicious for a timeout. :-)
>=20
> After fixing this, we still have the problem that io_uring_enter() can
> return early without failing with EINTR when something like a signal
> arrives. This means that a blocking aio_poll(true) can actually return
> without any progress.  Not sure if it matters in practice, but it can
> make test cases fail.
>=20
> Not completely sure when this happens, though. When running the aio-test
> under strace, kill -CONT makes it return early and fail the assertion,
> but without strace, I can't seem to reproduce the problem at the moment.
> Attaching strace or gdb to the running process that is waiting for the
> timeout also makes it return early and fail the assertion.

Thanks again for debugging the test failures. I am sending a new
revision with the timeout variable lifetime fixed and a stronger loop
condition that retries io_uring_submit_and_wait() when the awaited CQE
is still missing.

Thoughts on what you found:

I've upgraded to Fedora 43 (kernel-6.17.5-300.fc43.x86_64) but I think
the behavior is still the same.

The difference in ptraced vs normal SIGCONT behavior is because the
signal only actually interrupts processes that are stopped or ptraced.
Otherwise SIGCONT disappears without interrupting the system call.

When ptraced, io_uring_enter()'s return value will be 1 and not -EINTR
because of how io_uring/io_uring.c:io_uring_enter() is implemented.
There are two variables: ret is the return value from submitting SQEs
and ret2 is the return value from waiting for CQEs. The first variable
takes precendence, so even though ret2 can be -EINTR, it is overriden:

                  if (!ret) {
                          ret =3D ret2;
  			...
                  }
          }
  out:
          ...
          return ret;

In our case ret is be >0, so ret2 =3D -EINTR is ignored and the
io_uring_enter(2) return value is 1. This explains the behavior when
SIGCONT is received while a ptraced io_uring_enter(2) is waiting.

I confirmed in userspace that there are no CQEs ready when
io_uring_enter(2) returns 1 after SIGCONT. This can be fixed in
userspace by retrying when the expected CQE is missing.

Regarding aio_poll(ctx, true) returning false: it happens when
aio_notify() is called while aio_poll(ctx, true) is waiting. The tests
rely on the internal details of when exactly false can be returned, so
it will help if fdmon-io_uring.c avoids returning false in situations
where other fdmon implementations wait longer.

Stefan

--d9RfUKa2a2howWXm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkJYA8ACgkQnKSrs4Gr
c8iQZwgAlM3KATs+InUeGc2m5XyBT7ZFRxlLMBeN5RmDUEDIRYYG+YojVF6LEovA
j6KAhKoJ+QOKGdvYqfSsEE05g7ydphkeD/ocio+7U/FV/dDsK6ChIPZ9i26I5SEp
J3ZhDwRJWs8pjFimuH03kpi6vBqsmNmRsAJAr0kpryH1YH6kODTKruEaFW6Q3t2W
YJhe9SgUoyweMB5gOu9Zba127sbjgjmjH0RDug0iFrannDxpXkb7Egu5SdzJ02UH
uZKtQWjGaaptJIdJ1S5NAauljYt/shxOa/QAj08nvSoAlxjABvQ+GXttctq14aBn
uKNp824WbELo2+N2jdMNEswh63fV8w==
=tbzM
-----END PGP SIGNATURE-----

--d9RfUKa2a2howWXm--


