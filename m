Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046ECEB1070
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzz2S-0001NU-7U; Tue, 10 Mar 2026 11:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzz2J-0001N3-Kb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:19 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzz2F-00057G-9I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773156606; x=1773761406; i=lukasstraub2@web.de;
 bh=oD+2t4aBWRC5gzJ8jK7+NQMn2MHGDOLr9PRyXreahqw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ldHmA2WQ2Yw6MpiMUN5QSNkZr8ZwTaO1jgB7wTXX3YuZOnFQegi8/DtV1FL4IeAf
 5FftmhC6udHjzwtTSS+5A+7PsHZ238oo8JLG9ygan55kLBz/QccViIxRxAccQ82jA
 LknWhAYqqhbmjSfC8RntFWUg9NnI10K5PoTPF9+F21sTpzOA7B630LyD+h5qf/xlK
 ipl+6Drzndu1SUh7XgZdSWOaLN0S/r1vu/ZAT6n3ZuE9DbpmOp1eIOqUAoKtntGNu
 Q9L43QqvSEZMKqMu6wcQwjgRmBFsmhaj4NFM80FVo4QbgEgFzNKMWouaoXdJwWRe7
 T+UVJviWrmO98WqKZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1vSZxI0sZq-00fWiI; Tue, 10
 Mar 2026 16:30:06 +0100
Date: Tue, 10 Mar 2026 16:29:54 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Message-ID: <20260310162954.61da59f1@penguin>
In-Reply-To: <abAvHRJJewZOz-BW@fedora>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
 <abAvHRJJewZOz-BW@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h5W.ac=Ifqby=x3+7t_lD08";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/xi1B4N+CnmRWXqIGIf1UxFAwxYj208qUHo4nxycEsxIHyvNK97
 NJVbcVMJZOMYCA8imUnvtltmxQo6IfuTLR6br+xhow1GimaCJxSpjY39RwqqITA1qpdN3iv
 zZlzIw0EonIQlu2fZjulor02rysxtO6EW/whl8OADCSy9bgCH9/baGwjKdPKyD75mR3q0i8
 aawa5ZUNg5xqQPzPBWvpw==
UI-OutboundReport: notjunk:1;M01:P0:ia2YpSEQb44=;3UFW+NyHTAy1KZeV9opvoMB5YSw
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/h5W.ac=Ifqby=x3+7t_lD08
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 20:17:57 +0530
Arun Menon <armenon@redhat.com> wrote:

> Hi Lukas,
>=20
> On Mon, Mar 02, 2026 at 12:45:28PM +0100, Lukas Straub wrote:
> > Add a COLO migration test for COLO migration and failover.
> >=20
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Tested-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  MAINTAINERS                        |   1 +
> >  tests/qtest/meson.build            |   7 +-
> >  tests/qtest/migration-test.c       |   1 +
> >  tests/qtest/migration/colo-tests.c | 198 +++++++++++++++++++++++++++++=
++++++++
> >  tests/qtest/migration/framework.h  |   5 +
> >  5 files changed, 211 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d2a1f4cc08223cb944b61e32a6d89e25bf82eacb..1b0ae10750036be00571b71=
04ad8426c071bb54c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3875,6 +3875,7 @@ F: migration/colo*
> >  F: migration/multifd-colo.*
> >  F: include/migration/colo.h
> >  F: include/migration/failover.h
> > +F: tests/qtest/migration/colo-tests.c
> >  F: docs/COLO-FT.txt
> > =20
> >  COLO Proxy
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 25fdbc798010b19e8ec9b6ab55e02d3fb5741398..6a46e2a767de12d978d910d=
db6de175bce9810b8 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -374,6 +374,11 @@ if gnutls.found()
> >    endif
> >  endif
> > =20
> > +migration_colo_files =3D []
> > +if get_option('replication').allowed()
> > +  migration_colo_files =3D [files('migration/colo-tests.c')]
> > +endif
> > +
> >  qtests =3D {
> >    'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c=
'),
> >    'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> > @@ -385,7 +390,7 @@ qtests =3D {
> >                               'migration/migration-util.c') + dbus_vmst=
ate1,
> >    'erst-test': files('erst-test.c'),
> >    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'=
],
> > -  'migration-test': test_migration_files + migration_tls_files,
> > +  'migration-test': test_migration_files + migration_tls_files + migra=
tion_colo_files,
> >    'pxe-test': files('boot-sector.c'),
> >    'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.=
c',
> >                            'pnv-xive2-nvpg_bar.c'),
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 08936871741535c926eeac40a7d7c3f461c72fd0..e582f05c7dc2673dbd05a93=
6df8feb6c964b5bbc 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -55,6 +55,7 @@ int main(int argc, char **argv)
> >      migration_test_add_precopy(env);
> >      migration_test_add_cpr(env);
> >      migration_test_add_misc(env);
> > +    migration_test_add_colo(env);
> > =20
> >      ret =3D g_test_run();
> > =20
> > diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration=
/colo-tests.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..598a1d3821ed0a903187327=
02027cebad47352fd
> > --- /dev/null
> > +++ b/tests/qtest/migration/colo-tests.c
> > @@ -0,0 +1,198 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * QTest testcases for COLO migration
> > + *
> > + * Copyright (c) 2025 Lukas Straub <lukasstraub2@web.de>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "migration/framework.h"
> > +#include "migration/migration-qmp.h"
> > +#include "migration/migration-util.h"
> > +#include "qemu/module.h"
> > +
> > +static int test_colo_common(MigrateCommon *args,
> > +                            bool failover_during_checkpoint,
> > +                            bool primary_failover)
> > +{
> > +    QTestState *from, *to;
> > +    void *data_hook =3D NULL;
> > +
> > +    /*
> > +     * For the COLO test, both VMs will run in parallel. Thus both VMs=
 want to
> > +     * open the image read/write at the same time. Using read-only=3Do=
n is not
> > +     * possible here, because ide-hd does not support read-only backin=
g image.
> > +     *
> > +     * So use -snapshot, where each qemu instance creates its own writ=
able
> > +     * snapshot internally while leaving the real image read-only.
> > +     */
> > +    args->start.opts_source =3D "-snapshot";
> > +    args->start.opts_target =3D "-snapshot";
> > +
> > +    /*
> > +     * COLO migration code logs many errors when the migration socket
> > +     * is shut down, these are expected so we hide them here.
> > +     */
> > +    args->start.hide_stderr =3D true;
> > +
> > +    /*
> > +     * Test with yank with out of band capability since that is how it=
 is
> > +     * used in production.
> > +     */
> > +    args->start.oob =3D true;
> > +    args->start.caps[MIGRATION_CAPABILITY_X_COLO] =3D true;
> > +
> > +    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> > +        return -1;
> > +    }
> > +
> > +    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
> > +
> > +    if (args->start_hook) {
> > +        data_hook =3D args->start_hook(from, to);
> > +    }
> > +
> > +    migrate_ensure_converge(from);
> > +    wait_for_serial("src_serial");
> > +
> > +    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> > +
> > +    wait_for_migration_status(from, "colo", NULL);
> > +    wait_for_resume(to, get_dst());
> > +
> > +    wait_for_serial("src_serial");
> > +    wait_for_serial("dest_serial");
> > +
> > +    /* wait for 3 checkpoints */
> > +    for (int i =3D 0; i < 3; i++) {
> > +        qtest_qmp_eventwait(to, "RESUME");
> > +        wait_for_serial("src_serial");
> > +        wait_for_serial("dest_serial");
> > +    }
> > +
> > +    if (failover_during_checkpoint) {
> > +        qtest_qmp_eventwait(to, "STOP");
> > +    }
> > +    if (primary_failover) {
> > +        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': 'ya=
nk-cmd', "
> > +                                            "'arguments': {'instances'=
:"
> > +                                                "[{'type': 'migration'=
}]}}");
> > +        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heart=
beat'}");
> > +        wait_for_serial("src_serial");
> > +    } else {
> > +        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank=
-cmd', "
> > +                                        "'arguments': {'instances':"
> > +                                            "[{'type': 'migration'}]}}=
");
> > +        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbe=
at'}");
> > +        wait_for_serial("dest_serial");
> > +    }
> > +
> > +    if (args->end_hook) {
> > +        args->end_hook(from, to, data_hook);
> > +    }
> > +
> > +    migrate_end(from, to, !primary_failover);
> > +
> > +    return 0;
> > +}
> > +
> > +static void test_colo_plain_common(MigrateCommon *args,
> > +                                   bool failover_during_checkpoint,
> > +                                   bool primary_failover)
> > +{
> > +    args->listen_uri =3D "tcp:127.0.0.1:0";
> > +    test_colo_common(args, failover_during_checkpoint, primary_failove=
r);
> > +}
> > +
> > +static void *hook_start_multifd(QTestState *from, QTestState *to)
> > +{
> > +    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "no=
ne");
> > +}
> > +
> > +static void test_colo_multifd_common(MigrateCommon *args,
> > +                                     bool failover_during_checkpoint,
> > +                                     bool primary_failover)
> > +{
> > +    args->listen_uri =3D "defer";
> > +    args->start_hook =3D hook_start_multifd;
> > +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> > +    test_colo_common(args, failover_during_checkpoint, primary_failove=
r);
> > +}
> > +
> > +static void test_colo_plain_primary_failover(char *name, MigrateCommon=
 *args)
> > +{
> > +    test_colo_plain_common(args, false, true);
> > +}
> > +
> > +static void test_colo_plain_secondary_failover(char *name, MigrateComm=
on *args)
> > +{
> > +    test_colo_plain_common(args, false, false);
> > +}
> > +
> > +static void test_colo_multifd_primary_failover(char *name, MigrateComm=
on *args)
> > +{
> > +    test_colo_multifd_common(args, false, true);
> > +}
> > +
> > +static void test_colo_multifd_secondary_failover(char *name,
> > +                                                 MigrateCommon *args)
> > +{
> > +    test_colo_multifd_common(args, false, false);
> > +}
> > +
> > +static void test_colo_plain_primary_failover_checkpoint(char *name,
> > +                                                        MigrateCommon =
*args)
> > +{
> > +    test_colo_plain_common(args, true, true);
> > +}
> > +
> > +static void test_colo_plain_secondary_failover_checkpoint(char *name,
> > +                                                          MigrateCommo=
n *args)
> > +{
> > +    test_colo_plain_common(args, true, false);
> > +}
> > +
> > +static void test_colo_multifd_primary_failover_checkpoint(char *name,
> > +                                                          MigrateCommo=
n *args)
> > +{
> > +    test_colo_multifd_common(args, true, true);
> > +}
> > +
> > +static void test_colo_multifd_secondary_failover_checkpoint(char *name,
> > +                                                            MigrateCom=
mon *args)
> > +{
> > +    test_colo_multifd_common(args, true, false);
> > +}
> > +
> > +void migration_test_add_colo(MigrationTestEnv *env)
> > +{
> > +    if (!env->full_set) {
> > +        return;
> > +    }
> > +
> > +    migration_test_add("/migration/colo/plain/primary_failover",
> > +                       test_colo_plain_primary_failover);
> > +    migration_test_add("/migration/colo/plain/secondary_failover",
> > +                       test_colo_plain_secondary_failover);
> > +
> > +    migration_test_add("/migration/colo/multifd/primary_failover",
> > +                       test_colo_multifd_primary_failover);
> > +    migration_test_add("/migration/colo/multifd/secondary_failover",
> > +                       test_colo_multifd_secondary_failover);
> > +
> > +    migration_test_add("/migration/colo/plain/primary_failover_checkpo=
int",
> > +                       test_colo_plain_primary_failover_checkpoint);
> > +    migration_test_add("/migration/colo/plain/secondary_failover_check=
point",
> > +                       test_colo_plain_secondary_failover_checkpoint);
> > +
> > +    migration_test_add("/migration/colo/multifd/primary_failover_check=
point",
> > +                       test_colo_multifd_primary_failover_checkpoint);
> > +    migration_test_add("/migration/colo/multifd/secondary_failover_che=
ckpoint",
> > +                       test_colo_multifd_secondary_failover_checkpoint=
);
> > +}
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/=
framework.h
> > index 40984d04930da2d181326d9f6a742bde49018103..80eef758932ce9c301ed6c0=
f6383d18756144870 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -264,5 +264,10 @@ void migration_test_add_file(MigrationTestEnv *env=
);
> >  void migration_test_add_precopy(MigrationTestEnv *env);
> >  void migration_test_add_cpr(MigrationTestEnv *env);
> >  void migration_test_add_misc(MigrationTestEnv *env);
> > +#ifdef CONFIG_REPLICATION
> > +void migration_test_add_colo(MigrationTestEnv *env);
> > +#else
> > +static inline void migration_test_add_colo(MigrationTestEnv *env) {};
> > +#endif
> > =20
> >  #endif /* TEST_FRAMEWORK_H */
> >=20
> > --=20
> > 2.39.5
> >=20
> > =20
>=20
> I was running the qtests locally, and I encountered a timeout error.
>=20
> Command run: mkdir -p build ; cd build ; make check-qtest-x86_64;
>=20
> Following is the output:
> =3D=3D=3D=3D=3D=3D
> 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test              =
   TIMEOUT        480.05s   killed by signal 15 SIGTERM
> >>> QTEST_QEMU_IMG=3D./qemu-img LD_LIBRARY_PATH=3D/home/arun/workdir/new/=
devel/upstream/qemu-priv/build/subprojects/slirp RUST_BACKTRACE=3D1 QTEST_Q=
EMU_BINARY=3D./qemu-system-x86_64 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_o=
n_error=3D1:print_summary=3D1:print_stacktrace=3D1 G_TEST_DBUS_DAEMON=3D/ho=
me/arun/workdir/new/devel/upstream/qemu-priv/tests/dbus-vmstate-daemon.sh A=
SAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 PYTHON=
=3D/home/arun/workdir/new/devel/upstream/qemu-priv/build/pyvenv/bin/python3=
 MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D53 QTEST_QEMU_STORAGE_DAEMON_BI=
NARY=3D./storage-daemon/qemu-storage-daemon MSAN_OPTIONS=3Dhalt_on_error=3D=
1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 /home/arun/work=
dir/new/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap -k =
--full =20
> stderr:
>=20
> TAP parsing error: Too few tests run (expected 52, got 47)
>=20
> Summary of Failures:
> 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test         TIMEO=
UT        480.05s   killed by signal 15 SIGTERM
> Ok:                64
> Fail:              0
> Skipped:           2
> Timeout:           1
> =3D=3D=3D=3D=3D=3D
>=20
> It seems that the test runner is stuck waiting for some input.
> Following is the stack trace
> =3D=3D=3D=3D=3D=3D
> > ps afx =20
>  127267 pts/0    S+     0:00  |       |   \_ make check-qtest-x86_64 -j8
>  128245 pts/0    S+     0:01  |       |       \_ /home/arun/workdir/new/d=
evel/upstream/qemu-priv/build/pyvenv/bin/python3 /home/arun/workdir
>  128276 ?        Ssl    0:07  |       |           \_ /home/arun/workdir/n=
ew/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap
>  134107 ?        Sl     0:20  |       |               \_ ./qemu-system-x8=
6_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
>  134115 ?        Sl     0:22  |       |               \_ ./qemu-system-x8=
6_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
>    5610 pts/2    Ss     0:01  |       \_ /usr/bin/bash
>=20
> =3D=3D=3D=3D=3D=3D
> gstack 128276
> Thread 2 (Thread 0x7fdd090716c0 (LWP 128279) "call_rcu"):
> #0  0x00007fdd0921434d in syscall () from /lib64/libc.so.6
> #1  0x0000557fd604563a in qemu_futex_wait (f=3D0x557fd60a0190 <rcu_call_r=
eady_event>, val=3D4294967295) at /home/arun/workdir/new/devel/upstream/qem=
u-priv/include/qemu/futex.h:47
> #2  0x0000557fd604584e in qemu_event_wait (ev=3D0x557fd60a0190 <rcu_call_=
ready_event>) at ../util/event.c:162
> #3  0x0000557fd6045fde in call_rcu_thread (opaque=3D0x0) at ../util/rcu.c=
:304
> #4  0x0000557fd600e8fb in qemu_thread_start (args=3D0x557fd6beec70) at ..=
/util/qemu-thread-posix.c:414
> #5  0x00007fdd09193464 in start_thread () from /lib64/libc.so.6
> #6  0x00007fdd092165ac in __clone3 () from /lib64/libc.so.6
>=20
> Thread 1 (Thread 0x7fdd09073240 (LWP 128276) "migration-test"):
> #0  0x00007fdd0919b982 in __syscall_cancel_arch () from /lib64/libc.so.6
> #1  0x00007fdd0918fc3c in __internal_syscall_cancel () from /lib64/libc.s=
o.6
> #2  0x00007fdd091dfb62 in clock_nanosleep@GLIBC_2.2.5 () from /lib64/libc=
.so.6
> #3  0x00007fdd091ebb37 in nanosleep () from /lib64/libc.so.6
> #4  0x00007fdd0921613a in usleep () from /lib64/libc.so.6
> #5  0x0000557fd5fd99cd in wait_for_serial (side=3D0x557fd6065f08 "dest_se=
rial") at ../tests/qtest/migration/framework.c:82
> #6  0x0000557fd5fe5865 in test_colo_common (args=3D0x557fd6bfdf50, failov=
er_during_checkpoint=3Dfalse, primary_failover=3Dtrue) at ../tests/qtest/mi=
gration/colo-tests.c:66

60    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
61
62    wait_for_migration_status(from, "colo", NULL);
63    wait_for_resume(to, get_dst());
64
65    wait_for_serial("src_serial");
66    wait_for_serial("dest_serial");

Interesting, so the secondary guest is stuck/crahsed after entering
colo state despite having resumed.

It works fine here on master. And before the merge I have looped the
colo tests for a whole day on my machine without any failures.

How often does this happen? What is the commit you are on, host, ASAN,
MSAN, UBSAN, configure options? With kvm or without?

Can you try the following and show me the log:
(cd build && QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_BINARY=3D./qemu-system-=
x86_64 QTEST_LOG=3D- tests/qtest/migration-test --full -p /x86_64/migration=
/colo/plain)

> #7  0x0000557fd5fe5a0f in test_colo_plain_common (args=3D0x557fd6bfdf50, =
failover_during_checkpoint=3Dfalse, primary_failover=3Dtrue) at ../tests/qt=
est/migration/colo-tests.c:106
> #8  0x0000557fd5fe5ad7 in test_colo_plain_primary_failover (name=3D0x557f=
d6bfd050 "/migration/colo/plain/primary_failover", args=3D0x557fd6bfdf50) a=
t ../tests/qtest/migration/colo-tests.c:126
> #9  0x0000557fd5fdeff8 in migration_test_wrapper (data=3D0x557fd6bfd320) =
at ../tests/qtest/migration/migration-util.c:258
> #10 0x00007fdd0947bf3e in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
> #11 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
> #12 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
> #13 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
> #14 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
> #15 0x00007fdd0947c46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
> #16 0x00007fdd0947c500 in g_test_run () from /lib64/libglib-2.0.so.0
> #17 0x0000557fd5fd9490 in main (argc=3D1, argv=3D0x7fff33b51908) at ../te=
sts/qtest/migration-test.c:60
>=20
>=20
> Is there something that I am missing? Can you please look into this?=20
>=20
>=20
> Regards,
> Arun Menon
>=20


--Sig_/h5W.ac=Ifqby=x3+7t_lD08
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmwOPIACgkQNasLKJxd
sliXHBAAokz72bKZi45HuQQcO3HTBYOZqXJtH1TQUwlaiVtjz7jJ6RJ8HEIFhzfh
96+ur+cx4IPUN/NA+4/lTt378nA2+V6CPZV0hz4nsfI7EBu9lLI6jurHvV5E5wBW
5m7OX3B6sHVwRRpBANDlGF9YZ6Q7+lZ5j3WXlmNqz3T+OBLZy8Vo00ngwpILsYb2
phHB7HBHZ17mjX6FUggVJ/YHWpnRiR+cZ4ve++HYduMReHqacCwJzzvfAnIurJFN
yugJnIUa5cVdKQtdmCS9IZRPM5Ilq1TNb1yDH5B0YqzkopQG/kfzn70FOHEPYKpX
PsRbZ7aqwhhKZheo1eDMOltpqMdcbBPkE7tY9IwPBijy/Ck6zsEnW3lFy7p2VlEK
Y4Da+TygXDef2nprWCBhGhWSg+uqdjdOQSCze+Heogey7QGrcSqofgoiA55D7yGJ
jZMmHqYIq6lB5jn80kGlk35Z2/wghb2x/GtW+uynx+toxr/ZvuGBlzZnMBY+r1gB
LgKHXAWjlTwJmcxKIFczA7mbhVZ580nW7HNxKfERrEHI1lLZL7pEvGe0p3xi9Vrx
lFlQXBcDWM5ImhS08J4yFCy5TFq5hw+cAcOaxe1j3bFgtsiOW7CQtsjhYk5YAz6x
t88WtBlMJVgqSFfw9CQB8KmTqv62XYcwWLeEJfcYe/SXmpr4PpM=
=z40y
-----END PGP SIGNATURE-----

--Sig_/h5W.ac=Ifqby=x3+7t_lD08--

