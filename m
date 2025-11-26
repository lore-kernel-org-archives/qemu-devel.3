Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B58D111A2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOMsw-0005DD-En; Wed, 26 Nov 2025 16:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOMst-0005Ce-LE
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOMsq-0008Dg-JV
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764191823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9mxUUCP9haOU9M2Xe2oYwvyZYFFLU9M13e0kucCzUo=;
 b=IE8ZL4sK79TIsGHzehMh3Nc2yVlQ/mI2JJQQxRBWLgDTjBwEIXHzc98knFEmF8t1cbbx76
 7tLdB4QGkoCLgSWaNDj9ApXPwEJ7Eb+yrgUbRCvK5qBO4UGGKUZJVG8deb+duGFWREzsq7
 57d+4I80cxcLgK+2wHtm4djclzbYxsY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-B6IK3JswPtCTpcD_YoRouA-1; Wed,
 26 Nov 2025 16:16:58 -0500
X-MC-Unique: B6IK3JswPtCTpcD_YoRouA-1
X-Mimecast-MFC-AGG-ID: B6IK3JswPtCTpcD_YoRouA_1764191817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10BA61956059; Wed, 26 Nov 2025 21:16:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D488C19560BA; Wed, 26 Nov 2025 21:16:55 +0000 (UTC)
Date: Wed, 26 Nov 2025 15:58:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: andrey.drobyshev@virtuozzo.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <20251126205857.GA595594@fedora>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fr7EnPWcp9Y/vih6"
Content-Disposition: inline
In-Reply-To: <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--fr7EnPWcp9Y/vih6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 04:21:05PM +0200, andrey.drobyshev@virtuozzo.com wr=
ote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>=20
> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> coredumps") introduced coroutine traces in coredumps using raw stack
> unwinding.  While this works, this approach does not allow to view the
> function arguments in the corresponding stack frames.
>=20
> As an alternative, we can obtain saved registers from the coroutine's
> jmpbuf, copy the original coredump file into a temporary file, patch the
> saved registers into the tmp coredump's struct elf_prstatus and execute
> another gdb subprocess to get backtrace from the patched temporary coredu=
mp.
>=20
> While providing more detailed info, this alternative approach, however, is
> quite heavyweight as it takes significantly more time and disk space.
> So, instead of making it a new default, let's keep raw unwind the default
> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu corout=
ine'
> command which would enforce the new behaviour.

Wow, that's a big hack around GDB limitations but I don't see any harm
in offering this as an option.

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
>  scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 11 deletions(-)
>=20
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> index e98fc48a4b..b1c7f96af5 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -10,6 +10,13 @@
>  # or later.  See the COPYING file in the top-level directory.
> =20
>  import gdb
> +import os
> +import re
> +import struct
> +import shutil
> +import subprocess
> +import tempfile
> +import textwrap
> =20
>  VOID_PTR =3D gdb.lookup_type('void').pointer()
> =20
> @@ -77,6 +84,65 @@ def symbol_lookup(addr):
> =20
>      return f"{func_str} at {path}:{line}"
> =20
> +def write_regs_to_coredump(corefile, set_regs):
> +    # asm/ptrace.h
> +    pt_regs =3D ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10',
> +               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax',
> +               'rip', 'cs', 'eflags', 'rsp', 'ss']
> +
> +    with open(corefile, 'r+b') as f:
> +        gdb.write(f'patching core file {corefile}\n')
> +
> +        while f.read(4) !=3D b'CORE':
> +            pass
> +        gdb.write(f'found "CORE" at 0x{f.tell():x}\n')
> +
> +        # Looking for struct elf_prstatus and pr_reg field in it (an arr=
ay
> +        # of general purpose registers).  See sys/procfs.h
> +
> +        # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
> +        f.seek(4, 1)
> +        # lseek(f.fileno(), 112, SEEK_CUR): offsetof(struct elf_prstatus=
, pr_reg)
> +        f.seek(112, 1)
> +
> +        gdb.write(f'assume pt_regs at 0x{f.tell():x}\n')
> +        for reg in pt_regs:
> +            if reg in set_regs:
> +                gdb.write(f'write {reg} at 0x{f.tell():x}\n')
> +                f.write(struct.pack('q', set_regs[reg]))
> +            else:
> +                # lseek(f.fileno(), 8, SEEK_CUR): go to the next reg
> +                f.seek(8, 1)
> +
> +def clone_coredump(source, target, set_regs):
> +    shutil.copyfile(source, target)
> +    write_regs_to_coredump(target, set_regs)
> +
> +def dump_backtrace_patched(regs):
> +    files =3D gdb.execute('info files', False, True).split('\n')
> +    executable =3D re.match('^Symbols from "(.*)".$', files[0]).group(1)
> +    dump =3D re.search("`(.*)'", files[2]).group(1)
> +
> +    with tempfile.NamedTemporaryFile(dir=3D'/tmp', delete=3DFalse) as f:
> +        tmpcore =3D f.name
> +
> +    clone_coredump(dump, tmpcore, regs)
> +
> +    cmd =3D ['script', '-qec',
> +           'gdb -batch ' +
> +           '-ex "set complaints 0" ' +
> +           '-ex "set verbose off" ' +
> +           '-ex "set style enabled on" ' +
> +           '-ex "python print(\'----split----\')" ' +
> +           f'-ex bt {executable} {tmpcore}',
> +           '/dev/null']
> +    out =3D subprocess.check_output(cmd, stderr=3Dsubprocess.DEVNULL)

Is script(1) necessary or just something you used for debugging?

On Fedora 43 the script(1) utility isn't installed by default. Due to
its generic name it's also a little hard to find the package name
online. It would be nice to print a help message pointing to the
packages. From what I can tell, script(1) is available in
util-linux-script on Red Hat-based distros, bsdutils on Debian-based
distros, and util-linux on Arch.

> +    out =3D out.split(b'----split----')[1].decode('utf-8')
> +
> +    os.remove(tmpcore)
> +
> +    gdb.write(out)
> +
>  def dump_backtrace(regs):
>      '''
>      Backtrace dump with raw registers, mimic GDB command 'bt'.
> @@ -120,7 +186,7 @@ def dump_backtrace_live(regs):
> =20
>      selected_frame.select()
> =20
> -def bt_jmpbuf(jmpbuf):
> +def bt_jmpbuf(jmpbuf, detailed=3DFalse):
>      '''Backtrace a jmpbuf'''
>      regs =3D get_jmpbuf_regs(jmpbuf)
>      try:
> @@ -128,8 +194,12 @@ def bt_jmpbuf(jmpbuf):
>          # but only works with live sessions.
>          dump_backtrace_live(regs)
>      except:
> -        # If above doesn't work, fallback to poor man's unwind
> -        dump_backtrace(regs)
> +        if detailed:
> +            # Obtain detailed trace by patching regs in copied coredump
> +            dump_backtrace_patched(regs)
> +        else:
> +            # If above doesn't work, fallback to poor man's unwind
> +            dump_backtrace(regs)
> =20
>  def co_cast(co):
>      return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
> @@ -140,26 +210,60 @@ def coroutine_to_jmpbuf(co):
> =20
> =20
>  class CoroutineCommand(gdb.Command):
> -    '''Display coroutine backtrace'''
> +    __doc__ =3D textwrap.dedent("""\
> +        Display coroutine backtrace
> +
> +        Usage: qemu coroutine COROPTR [--detailed]
> +        Show backtrace for a coroutine specified by COROPTR
> +
> +          --detailed       obtain detailed trace by copying coredump, pa=
tching
> +                           regs in it, and runing gdb subprocess to get
> +                           backtrace from the patched coredump
> +        """)
> +
>      def __init__(self):
>          gdb.Command.__init__(self, 'qemu coroutine', gdb.COMMAND_DATA,
>                               gdb.COMPLETE_NONE)
> =20
> +    def _usage(self):
> +        gdb.write('usage: qemu coroutine <coroutine-pointer> [--detailed=
]\n')
> +        return
> +
>      def invoke(self, arg, from_tty):
>          argv =3D gdb.string_to_argv(arg)
> -        if len(argv) !=3D 1:
> -            gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
> -            return
> +        argc =3D len(argv)
> +        if argc =3D=3D 0 or argc > 2 or (argc =3D=3D 2 and argv[1] !=3D =
'--detailed'):
> +            return self._usage()
> +        detailed =3D True if argc =3D=3D 2 else False
> =20
> -        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
> +        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
> +                  detailed=3Ddetailed)
> =20
>  class CoroutineBt(gdb.Command):
> -    '''Display backtrace including coroutine switches'''
> +    __doc__ =3D textwrap.dedent("""\
> +        Display backtrace including coroutine switches
> +
> +        Usage: qemu bt [--detailed]
> +
> +          --detailed       obtain detailed trace by copying coredump, pa=
tching
> +                           regs in it, and runing gdb subprocess to get
> +                           backtrace from the patched coredump
> +        """)
> +
>      def __init__(self):
>          gdb.Command.__init__(self, 'qemu bt', gdb.COMMAND_STACK,
>                               gdb.COMPLETE_NONE)
> =20
> +    def _usage(self):
> +        gdb.write('usage: qemu bt [--detailed]\n')
> +        return
> +
>      def invoke(self, arg, from_tty):
> +        argv =3D gdb.string_to_argv(arg)
> +        argc =3D len(argv)
> +        if argc > 1 or (argc =3D=3D 1 and argv[0] !=3D '--detailed'):
> +            return self._usage()
> +        detailed =3D True if argc =3D=3D 1 else False
> =20
>          gdb.execute("bt")
> =20
> @@ -178,8 +282,8 @@ def invoke(self, arg, from_tty):
>              co_ptr =3D co["base"]["caller"]
>              if co_ptr =3D=3D 0:
>                  break
> -            gdb.write("Coroutine at " + str(co_ptr) + ":\n")
> -            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr))
> +            gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
> +            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=3Ddetailed)
> =20
>  class CoroutineSPFunction(gdb.Function):
>      def __init__(self):
> --=20
> 2.43.5
>=20

--fr7EnPWcp9Y/vih6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmknahAACgkQnKSrs4Gr
c8hwegf+MBjNOtwwvaRvVCrXLyGKBgkdVpQHRVC/M9n5AuFmPMPBq7hPlO/6Ijh9
gLGkbk90Nhcv1blMi839S9FXpVu6J3U9i+5fNgoV79PDd/byv8xXE/OXpTFY6bcG
60K94clXjh9ApoWrc3RqcxJavIr5YOxEbY+4XGsTXFtJclcQDihkVwkrKZlK0I2W
URs9UBYAFbIwQtFrAKClJQYVDizPSDpwJubTA5CHHUSjua2dpy0b7EDmkwqjTRYc
9xBroXnDgvJ1ODeqMpkTr6uxb9YkhKzrmHkNcfZAxBIMpU/P8IP+7sTore/nUOLy
xnbN2y9uDDkzJW5/3e0jK6gwjloGDQ==
=lxOV
-----END PGP SIGNATURE-----

--fr7EnPWcp9Y/vih6--


