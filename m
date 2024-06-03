Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CEEC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0mX-0007cR-B4; Mon, 03 Jun 2024 02:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sE0mT-0007Ob-O7
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:02:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sE0mR-0007gZ-AN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:02:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so34723395ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717394569; x=1717999369; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8gpELi0GNa5Qst4IbZKZWgL1LWXLuvO/rG1Iza845E=;
 b=SpMSXqLZ1WiNwv9hD7LrhWtuOdNjpUT/ptFSYaTeO1BRssQxcOG0pD97qGEMLkbxpI
 dOP6xNkuUDNuFBRDZ82ijtBuRfLjCmNMX2b030YxF7Wrpn2qhoJn7BGim4lzimGrvP4C
 NykEYD+O9s8K/RB1Lyh8AwsqsaJMH1LpjiKQk5sjf37RNRdKMEh6YBFDiNKWtq4NiZMK
 6Fl1i6JyiYL+oiotV8tQwUhcF/1n8jFdRsdFI7erYdVR9zN+UW6sx01sQ5xdB2F0gclt
 jFKtOkfdO8cz18DgKxVvpNnSSnDYvbksTyY0dvMFx8pzRINwe3DCzGSlMpi8swqcKX0r
 1YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717394569; x=1717999369;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h8gpELi0GNa5Qst4IbZKZWgL1LWXLuvO/rG1Iza845E=;
 b=wUoVTLkIQO56WI52opJkgmh4JP6blXwSWdo2yzDIh9RCwp1CNaNZHdaf9XZX0ESDXM
 ggdm2LS7F/tCMuiRUaKMbUr/iZdhS+XYcDC7HCGgEE97757GguJnXtu0tZiRhlsMroL5
 RoRgs4s7/VcjCOXl69jq96fiyC/TIMvZO9jqFjukYIceQW1FvQZwDOeH54EjdW39Hdyz
 /JCnPZX2xuQoogziNyT1LJDbs9z5uIctfW/5appT1Ep4/z3Guo/Oli+i4C7sK7YOlkHz
 CGdIvHPS0juoJmTyTA9Of9agVwqsb5wcYW5jzTf9W2RQG3vqPM6xDQJK5hOeWaXn55i0
 LBhA==
X-Gm-Message-State: AOJu0Yxhmf0VD0xKKMoCkji0eFGwEAc/Sl1zjXanH4acczejYIRYqX63
 s2XpOKzqc7jj9fCLSfjpsmP3u8NCHi57KwZgxR7f/HMH213bwbQ4
X-Google-Smtp-Source: AGHT+IEZRfUfOdQDZYb1JtHog4pZN2xVEBwemGMZoCor0OeN704nZqf/m3oheJXFCqejuNYd9Bw3Ag==
X-Received: by 2002:a17:902:d4cd:b0:1f6:7a41:eeac with SMTP id
 d9443c01a7336-1f67a41f0dcmr24105235ad.61.1717394568988; 
 Sun, 02 Jun 2024 23:02:48 -0700 (PDT)
Received: from localhost ([1.128.199.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f66c412fd2sm19788495ad.283.2024.06.02.23.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 23:02:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Jun 2024 16:02:42 +1000
Message-Id: <D1Q5KAF3ISC7.1TF9RGZVFDG7V@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Fabiano Rosas" <farosas@suse.de>, "Thomas
 Huth" <thuth@redhat.com>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] tests/qtest/migration-test: Add a postcopy
 memfile test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Xu" <peterx@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-5-npiggin@gmail.com> <ZlnRy0PS17qa2aqb@x1n>
In-Reply-To: <ZlnRy0PS17qa2aqb@x1n>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri May 31, 2024 at 11:34 PM AEST, Peter Xu wrote:
> On Thu, May 30, 2024 at 07:54:07PM +1000, Nicholas Piggin wrote:
> > Postcopy requires userfaultfd support, which requires tmpfs if a memory
> > file is used.
> >=20
> > This adds back support for /dev/shm memory files, but adds preallocatio=
n
> > to skip environments where that mount is limited in size.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Thanks for doing this regardless.
>
> > ---
> >  tests/qtest/migration-test.c | 77 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 69 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index 86eace354e..5078033ded 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -11,6 +11,7 @@
> >   */
> > =20
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> > =20
> >  #include "libqtest.h"
> >  #include "qapi/qmp/qdict.h"
> > @@ -553,6 +554,7 @@ typedef struct {
> >       */
> >      bool hide_stderr;
> >      bool use_memfile;
> > +    bool use_shm_memfile;
>
> Nitpick: when having both, it's slightly confusing on the name, e.g. not
> clear whether use_memfile needs to be set to true too if use_shm_memfile=
=3Dtrue.
>
> Maybe "use_tmpfs_memfile" and "use_shm_memfile"?

Could be easy to confuse. It's not actually "tmpfs", it is the fs that
is mounted on /tmp :) tmpfs *is* shmfs in Linux. The intention was just
that if you don't specify then it's because you don't have a particular
requirement other than enough space.

> >      /* only launch the target process */
> >      bool only_target;
> >      /* Use dirty ring if true; dirty logging otherwise */
> > @@ -739,7 +741,62 @@ static int test_migrate_start(QTestState **from, Q=
TestState **to,
> >          ignore_stderr =3D "";
> >      }
> > =20
> > -    if (args->use_memfile) {
> > +    if (!qtest_has_machine(machine_alias)) {
> > +        g_autofree char *msg =3D g_strdup_printf("machine %s not suppo=
rted",
> > +                                               machine_alias);
> > +        g_test_skip(msg);
> > +        return -1;
> > +    }
> > +
> > +    if (args->use_shm_memfile) {
> > +#if defined(__NR_userfaultfd) && defined(__linux__)
>
> IIUC we only need defined(__linux__) as there's nothing to do with uffd y=
et?

I thought it was polite since it uses a few other Linux (or at least
POSIX) calls directly rather than go via the abstraction layer. Probably
it would never happen that something defines __NR_userfaultfd that does
not also have open and fallocate, but no harm?

> > +        int fd;
> > +        uint64_t size;
> > +
> > +        if (getenv("GITLAB_CI")) {
> > +            /*
> > +             * Gitlab runners are limited to 64MB shm size and despite
> > +             * pre-allocation there is concern that concurrent tests
> > +             * could result in nondeterministic failures. Until all sh=
m
> > +             * usage in all CI tests is found to fail gracefully on
> > +             * ENOSPC, it is safer to avoid large allocations for now.
> > +             *
> > +             * https://lore.kernel.org/qemu-devel/875xuwg4mx.fsf@suse.=
de/
> > +             */
> > +            g_test_skip("shm tests are not supported in Gitlab CI envi=
ronment");
> > +            return -1;
> > +        }
>
> I'm not sure whether this is Fabiano's intention.  I'm wondering whether =
we
> can drop this and just let it still run there.
>
> Other tests not detecting avaiablility of shmem looks like a separate iss=
ue
> to be fixed to me, regardless of this.
>
> My wild guess is since we're doing memory_size+64K below then if test won=
't
> fail others won't either, as normally the shmem quota should normally be
> power of 2 anyway.. then it should always fit another few MBs if this one=
.
> While this test is ready to fail gracefully now.

Well if CI runners got upgraded to 256MB shm space under us, we might
start to succeed? I _think_ fallocate on tmpfs should be relatively
atomic in that it doesn't try to allocate space if the fs was too small,
but at least naive implementations can do it too, so I didn't want to
rely on it.

I'm fine to do what you and Fabiano prefer. If we commit this then later
remove this hunk, it would be easy to revert if it started to show up
fails. OTOH not too hard to add it in later either.

> > +
> > +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> > +            g_test_skip("/dev/shm does not exist or is not a directory=
");
> > +            return -1;
> > +        }
> > +
> > +        /*
> > +         * Pre-create and allocate the file here, because /dev/shm/
> > +         * is known to be limited in size in some places (e.g., Gitlab=
 CI).
> > +         */
> > +        memfile_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid())=
;
> > +        fd =3D open(memfile_path, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR=
 | S_IWUSR);
> > +        if (fd =3D=3D -1) {
> > +            g_test_skip("/dev/shm file could not be created");
> > +            return -1;
> > +        }
> > +
> > +        g_assert(qemu_strtosz(memory_size, NULL, &size) =3D=3D 0);
> > +        size +=3D 64*1024; /* QEMU may map a bit more memory for a gua=
rd page */
> > +
> > +        if (fallocate(fd, 0, 0, size) =3D=3D -1) {
> > +            unlink(memfile_path);
> > +            perror("could not alloc"); exit(1);
> > +            g_test_skip("Could not allocate machine memory in /dev/shm=
");
> > +            return -1;
> > +        }
> > +        close(fd);
> > +#else
> > +        g_test_skip("userfaultfd is not supported");
>
> "/dev/shm not available" instead?

Ah yes, that was for the userfaultfd not supported case, but indeed
since renaming it from uffd to shm, it is better to move the ifdef
guard to where you say.

> > +#endif
> > +    } else if (args->use_memfile) {
> >          memfile_path =3D g_strdup_printf("/%s/qemu-%d", tmpfs, getpid(=
));
> >          memfile_opts =3D g_strdup_printf(
> >              "-object memory-backend-file,id=3Dmem0,size=3D%s"
> > @@ -751,12 +808,6 @@ static int test_migrate_start(QTestState **from, Q=
TestState **to,
> >          kvm_opts =3D ",dirty-ring-size=3D4096";
> >      }
> > =20
> > -    if (!qtest_has_machine(machine_alias)) {
> > -        g_autofree char *msg =3D g_strdup_printf("machine %s not suppo=
rted", machine_alias);
> > -        g_test_skip(msg);
> > -        return -1;
> > -    }
> > -
> >      machine =3D resolve_machine_version(machine_alias, QEMU_ENV_SRC,
> >                                        QEMU_ENV_DST);
> > =20
> > @@ -807,7 +858,7 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
> >       * Remove shmem file immediately to avoid memory leak in test fail=
ed case.
> >       * It's valid because QEMU has already opened this file
> >       */
> > -    if (args->use_memfile) {
> > +    if (args->use_memfile || args->use_shm_memfile) {
> >          unlink(memfile_path);
> >      }
> > =20
> > @@ -1275,6 +1326,15 @@ static void test_postcopy(void)
> >      test_postcopy_common(&args);
> >  }
> > =20
> > +static void test_postcopy_memfile(void)
> > +{
>
> IMHO the defined(__NR_userfaultfd) should be here to guard if needed.
>
> Or rather, we don't need to care about uffd yet? As what we already do wi=
th
> test_postcopy().
>
> I'm guessing the test just doesn't run on !linux, while compilation alway=
s
> works with/without that.

Yeah they fall under has_uffd, so no ifdef required.

Thanks,
Nick

