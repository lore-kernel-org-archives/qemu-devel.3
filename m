Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D32CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdIC-0003pM-Vn; Thu, 27 Nov 2025 09:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOdIA-0003kB-PY
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOdI7-0004ln-Ph
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764254893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13VBl8bB8P7jHnKNPvJHB8tBj4c/ZGf2NjT+yiU0Ceo=;
 b=egMhk+nUo7NrJKJ9rTnGibb2KNbg08czs2tqSuSVNKtae6/ldM10s6mRallomIK01VG0Xy
 Bwe9tniTIitmf5Z4D/9W+HDFtcUMa4LX6TpOlKDZobRQ0yJFNTMzhU2yJ1bPNteLi0uuBF
 JOBwCYHTK5hkRLkAAmRN8+CMZAZ8CWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-aqS2xRJfO3iC54mF0SUZ7g-1; Thu,
 27 Nov 2025 09:48:10 -0500
X-MC-Unique: aqS2xRJfO3iC54mF0SUZ7g-1
X-Mimecast-MFC-AGG-ID: aqS2xRJfO3iC54mF0SUZ7g_1764254889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1E6A18002C5; Thu, 27 Nov 2025 14:48:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AE351955F24; Thu, 27 Nov 2025 14:48:07 +0000 (UTC)
Date: Thu, 27 Nov 2025 09:48:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <20251127144806.GB609942@fedora>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <20251126205857.GA595594@fedora>
 <d5e75db3-5c5c-43d5-844c-b13a69c21d51@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="85j8q37kgv3z/Y0w"
Content-Disposition: inline
In-Reply-To: <d5e75db3-5c5c-43d5-844c-b13a69c21d51@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--85j8q37kgv3z/Y0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 03:14:43PM +0200, Andrey Drobyshev wrote:
> On 11/26/25 10:58 PM, Stefan Hajnoczi wrote:
> > On Tue, Nov 25, 2025 at 04:21:05PM +0200, andrey.drobyshev@virtuozzo.co=
m wrote:
> >> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>
> >> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> >> coredumps") introduced coroutine traces in coredumps using raw stack
> >> unwinding.  While this works, this approach does not allow to view the
> >> function arguments in the corresponding stack frames.
> >>
> >> As an alternative, we can obtain saved registers from the coroutine's
> >> jmpbuf, copy the original coredump file into a temporary file, patch t=
he
> >> saved registers into the tmp coredump's struct elf_prstatus and execute
> >> another gdb subprocess to get backtrace from the patched temporary cor=
edump.
> >>
> >> While providing more detailed info, this alternative approach, however=
, is
> >> quite heavyweight as it takes significantly more time and disk space.
> >> So, instead of making it a new default, let's keep raw unwind the defa=
ult
> >> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu cor=
outine'
> >> command which would enforce the new behaviour.
> >=20
> > Wow, that's a big hack around GDB limitations but I don't see any harm
> > in offering this as an option.
> >=20
> >>
> >> That's how this looks:
> >>
> >>   (gdb) qemu coroutine 0x7fda9335a508
> >>   #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coro=
utine-ucontext.c:321
> >>   #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/q=
emu-coroutine.c:293
> >>   #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:=
547
> >>   #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
> >>   #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
> >>   #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
> >>   #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
> >>   #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thr=
ead-posix.c:393
> >>
> >>   (gdb) qemu coroutine 0x7fda9335a508 --detailed
> >>   patching core file /tmp/tmpq4hmk2qc
> >>   found "CORE" at 0x10c48
> >>   assume pt_regs at 0x10cbc
> >>   write r15 at 0x10cbc
> >>   write r14 at 0x10cc4
> >>   write r13 at 0x10ccc
> >>   write r12 at 0x10cd4
> >>   write rbp at 0x10cdc
> >>   write rbx at 0x10ce4
> >>   write rip at 0x10d3c
> >>   write rsp at 0x10d54
> >>
> >>   #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=3D0x7fda9335a=
508, to_=3D0x7fda8400c280, action=3DCOROUTINE_ENTER) at ../util/coroutine-u=
context.c:321
> >>   #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=3D0x5602bf71=
47c0, co=3D0x7fda8400c280) at ../util/qemu-coroutine.c:293
> >>   #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=3D0x5602bf7147c0=
) at ../util/async.c:547
> >>   #3  0x00005602bdb3b518 in aio_bh_call (bh=3D0x5602bf714a40) at ../ut=
il/async.c:172
> >>   #4  0x00005602bdb3b79a in aio_bh_poll (ctx=3D0x5602bf7147c0) at ../u=
til/async.c:219
> >>   #5  0x00005602bdb10f22 in aio_poll (ctx=3D0x5602bf7147c0, blocking=
=3Dtrue) at ../util/aio-posix.c:719
> >>   #6  0x00005602bd8fb1ac in iothread_run (opaque=3D0x5602bf42b100) at =
=2E./iothread.c:63
> >>   #7  0x00005602bdb18a24 in qemu_thread_start (args=3D0x5602bf7164a0) =
at ../util/qemu-thread-posix.c:393
> >>   #8  0x00007fda9e89f7f2 in start_thread (arg=3D<optimized out>) at pt=
hread_create.c:443
> >>   #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x8=
6_64/clone3.S:81
> >>
> >> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> CC: Peter Xu <peterx@redhat.com>
> >> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> >>  scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
> >>  1 file changed, 115 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.=
py
> >> index e98fc48a4b..b1c7f96af5 100644
> >> --- a/scripts/qemugdb/coroutine.py
> >> +++ b/scripts/qemugdb/coroutine.py
> >> @@ -10,6 +10,13 @@
> >>  # or later.  See the COPYING file in the top-level directory.
> >> =20
> >>  import gdb
> >> +import os
> >> +import re
> >> +import struct
> >> +import shutil
> >> +import subprocess
> >> +import tempfile
> >> +import textwrap
> >> =20
> >>  VOID_PTR =3D gdb.lookup_type('void').pointer()
> >> =20
> >> @@ -77,6 +84,65 @@ def symbol_lookup(addr):
> >> =20
> >>      return f"{func_str} at {path}:{line}"
> >> =20
> >> +def write_regs_to_coredump(corefile, set_regs):
> >> +    # asm/ptrace.h
> >> +    pt_regs =3D ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r1=
0',
> >> +               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_r=
ax',
> >> +               'rip', 'cs', 'eflags', 'rsp', 'ss']
> >> +
> >> +    with open(corefile, 'r+b') as f:
> >> +        gdb.write(f'patching core file {corefile}\n')
> >> +
> >> +        while f.read(4) !=3D b'CORE':
> >> +            pass
> >> +        gdb.write(f'found "CORE" at 0x{f.tell():x}\n')
> >> +
> >> +        # Looking for struct elf_prstatus and pr_reg field in it (an =
array
> >> +        # of general purpose registers).  See sys/procfs.h
> >> +
> >> +        # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
> >> +        f.seek(4, 1)
> >> +        # lseek(f.fileno(), 112, SEEK_CUR): offsetof(struct elf_prsta=
tus, pr_reg)
> >> +        f.seek(112, 1)
> >> +
> >> +        gdb.write(f'assume pt_regs at 0x{f.tell():x}\n')
> >> +        for reg in pt_regs:
> >> +            if reg in set_regs:
> >> +                gdb.write(f'write {reg} at 0x{f.tell():x}\n')
> >> +                f.write(struct.pack('q', set_regs[reg]))
> >> +            else:
> >> +                # lseek(f.fileno(), 8, SEEK_CUR): go to the next reg
> >> +                f.seek(8, 1)
> >> +
> >> +def clone_coredump(source, target, set_regs):
> >> +    shutil.copyfile(source, target)
> >> +    write_regs_to_coredump(target, set_regs)
> >> +
> >> +def dump_backtrace_patched(regs):
> >> +    files =3D gdb.execute('info files', False, True).split('\n')
> >> +    executable =3D re.match('^Symbols from "(.*)".$', files[0]).group=
(1)
> >> +    dump =3D re.search("`(.*)'", files[2]).group(1)
> >> +
> >> +    with tempfile.NamedTemporaryFile(dir=3D'/tmp', delete=3DFalse) as=
 f:
> >> +        tmpcore =3D f.name
> >> +
> >> +    clone_coredump(dump, tmpcore, regs)
> >> +
> >> +    cmd =3D ['script', '-qec',
> >> +           'gdb -batch ' +
> >> +           '-ex "set complaints 0" ' +
> >> +           '-ex "set verbose off" ' +
> >> +           '-ex "set style enabled on" ' +
> >> +           '-ex "python print(\'----split----\')" ' +
> >> +           f'-ex bt {executable} {tmpcore}',
> >> +           '/dev/null']
> >> +    out =3D subprocess.check_output(cmd, stderr=3Dsubprocess.DEVNULL)
> >=20
> > Is script(1) necessary or just something you used for debugging?
> >=20
> > On Fedora 43 the script(1) utility isn't installed by default. Due to
> > its generic name it's also a little hard to find the package name
> > online. It would be nice to print a help message pointing to the
> > packages. From what I can tell, script(1) is available in
> > util-linux-script on Red Hat-based distros, bsdutils on Debian-based
> > distros, and util-linux on Arch.
> >=20
> > [...]
> My sole purpose for using script(1) was to make GDB subprocess produce
> colored stack trace output, just like what we get when calling 'bt' in a
> regular GDB session.  I just find it easier to read.  So, unless there's
> an easier way to achieve that same result, I'd prefer to keep using
> script(1).

Have you tried the pty Python standard library module?
https://docs.python.org/3/library/pty.html

>=20
> But your point is of course valid -- I didn't think of the case when
> script(1) program might not be installed.  Since we're just decorating
> the output here, instead of failing with a help message I'd suggest
> simply checking whether script(1) binary is present in the system with
> smth like shutil.which(), and only using it if it is.  I'll update the
> patch accordingly, if there're no objections.
>=20
> Andrey
>=20

--85j8q37kgv3z/Y0w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkoZKYACgkQnKSrs4Gr
c8hueQgAkhp6CvEUtcE4botV9MCP7VwvlieHZdFO2Vz0N5pPWBEatkLhaLIC/F6v
JBxVGTWt00ehYEPpRsxmedNdgjomg7OwgIrgt+crUjCAoFy9xxdqCQ6TUdW5yg+B
I3PI5qzxHar4wTgi8jxSISm77gsVRKh3imp/NlFu8wk928bYfj6xFV4HPfDOH24R
YmE6EvjikwtWUdit3VVfpj5K8EywnLVge97KYSjvE7QdJUmrYRZvr/ZVO9JR62aZ
GYUnCrjDxaByd/++rBdgIfmc+mxwBAQu6UarpjVVneY+g99QuXMliULoZ1fwuIKm
idJ1RbQNWrDQhuQcxAkd7N9PLu6v9Q==
=4mTs
-----END PGP SIGNATURE-----

--85j8q37kgv3z/Y0w--


