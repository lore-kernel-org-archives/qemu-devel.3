Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EEEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vie22-00065p-5i; Wed, 21 Jan 2026 14:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vie21-00064Q-22
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:38:21 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vie1y-0006BC-1Q
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769024291; x=1769629091; i=lukasstraub2@web.de;
 bh=hwyDnKbggR7MWJK7HDXJhmXSQ2kD2fLDHMjqLGR3i3A=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S+iH9Fxh6ZBUdjYyTRpJhYlbagccznQTVXFdXdxC4KG6P3NB/zpwC4Mn1p6NhG2r
 T8450YnGpqkPn8WET00QuXB5fHy4qE7yGYk1OesFcYdLxILvBgo3J78HdHsKNdEvv
 THL96bAwWRGVAmGn4BEFnLtdYTLVdWg3yHsv7GF1tgMe011mUjrjuJj2EHLeQxrot
 IUhc+Ur3OdQFUER1Eum+vmMwbaGj6863RrKIjBoF4BO4TB9eOAVXn9W+bYG7fmiun
 YTROAXV+Acd/fKmDDLus86/bC2+xflDFPySsPTGygCb05vFYtFjMhgPb+9oa24kWt
 BdmKANrf14nfRZNqiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kEV-1vdzCU2RmL-00DPEl; Wed, 21
 Jan 2026 20:38:11 +0100
Date: Wed, 21 Jan 2026 20:37:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] migration-test: Add COLO migration unit test
Message-ID: <20260121203751.6bc9027d@penguin>
In-Reply-To: <aW-5_BtdDDLw3ZJH@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
 <aW-5_BtdDDLw3ZJH@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b=sOcAe.VQ.DHUzIVsQtwAG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:x5eu539hJGPNFTmJBTtVdoGtz0c4sNDpsrl6lOjN0zKBCKBAxl8
 8gYdrdNnx4lHkUo8k7i+2EDYlQedgUxUFCOQ6/raGlo3MpcVmDsI36MoCaT81xL9KAn1/Cj
 NahNG5u+hByutmB93lYilYc00NmcI9887rpG/ChqMdUg1tF6RsyqRsQ/seBJU/JUFBGAHE7
 d3K9xeqFEV5s/jxUUBPjA==
UI-OutboundReport: notjunk:1;M01:P0:6Q3ihWP3WWU=;fq+tE+FNor7hNuKWb0sM6QUktlI
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/b=sOcAe.VQ.DHUzIVsQtwAG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 12:23:08 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sat, Jan 17, 2026 at 03:09:12PM +0100, Lukas Straub wrote:
> > Add a COLO migration test for COLO migration and failover.
> >=20
> > COLO does not support q35 machine at this time.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  MAINTAINERS                        |   1 +
> >  tests/qtest/meson.build            |   7 ++-
> >  tests/qtest/migration-test.c       |   1 +
> >  tests/qtest/migration/colo-tests.c | 113 +++++++++++++++++++++++++++++=
++++++++
> >  tests/qtest/migration/framework.c  |  87 +++++++++++++++++++++++++++-
> >  tests/qtest/migration/framework.h  |  10 ++++
> >  6 files changed, 217 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dbb217255c2cf35dc0ce971c2021b130fac5469b..92ca20c9d4186a08519d15b=
fe8cbd583ab061a8b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3840,6 +3840,7 @@ F: migration/colo*
> >  F: migration/multifd-colo.*
> >  F: include/migration/colo.h
> >  F: include/migration/failover.h
> > +F: tests/qtest/migration/colo-tests.c
> >  F: docs/COLO-FT.txt
> > =20
> >  COLO Proxy
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 0f053fb56de5806d3c213e3a26c0b19998ae151a..d0129af4431bb08a94a918a=
1e40a8f657059d764 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -367,6 +367,11 @@ if gnutls.found()
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
> > @@ -378,7 +383,7 @@ qtests =3D {
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
> > index 0000000000000000000000000000000000000000..5004f581e4d9e4e6f54eee6=
d70a9307b7fd123be
> > --- /dev/null
> > +++ b/tests/qtest/migration/colo-tests.c
> > @@ -0,0 +1,113 @@
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
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/=
framework.c
> > index 57d3b9b7c5a269d31659971e308367bd916d28f6..fe34e7cc7a1a4eeb8d5219f=
54733bbd8446b0e4e 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char=
 *uri, MigrateStart *args)
> >      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> >          memory_size =3D "150M";
> > =20
> > -        if (g_str_equal(arch, "i386")) {
> > +        if (g_str_equal(arch, "i386") || args->force_pc_machine) { =20
>=20
> The naming is better, thanks.  Said that, force_pc_machine is unwanted
> either.. if we can drop it.  I asked this in v1:
>=20
> https://lore.kernel.org/qemu-devel/aWltRH6Nra-Tji7w@x1.local/
>=20
> Can we explore that possibility?

Never mind. I found the issue and will remove this in the next version.

>=20
> >              machine_alias =3D "pc";
> >          } else {
> >              machine_alias =3D "q35";
> > @@ -1066,6 +1066,91 @@ void *migrate_hook_start_precopy_tcp_multifd_com=
mon(QTestState *from,
> >      return NULL;
> >  }
> > =20
> > +int test_colo_common(MigrateCommon *args, bool failover_during_checkpo=
int,
> > +                     bool primary_failover)
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
> > +     * COLO currently does not work with Q35 machine
> > +     */
> > +    args->start.force_pc_machine =3D true;
> > +
> > +    args->start.oob =3D true; =20
>=20
> Just curious: is OOB required in COLO for some reason?  I understand yank
> you used below uses OOB, so the question is behind that, on what can be
> blocked in main thread, and special in COLO.
>=20
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
> > +    wait_for_resume(to, &dst_state); =20
>=20
> We can move this whole function into colo-tests.c.  Here you may want to
> use get_dst() instead.

Okey, will do that.

>=20
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
> >  QTestMigrationState *get_src(void)
> >  {
> >      return &src_state;
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/=
framework.h
> > index 2ef0f57962605c9e3bc7b7de48e52351e5389138..75088c5fb098a0f95acb1e2=
3585d3b6e8307451e 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -139,6 +139,9 @@ typedef struct {
> >      /* Do not connect to target monitor and qtest sockets in qtest_ini=
t */
> >      bool defer_target_connect;
> > =20
> > +    /* Use pc machine for x86_64 */
> > +    bool force_pc_machine;
> > +
> >      /*
> >       * Migration capabilities to be set in both source and
> >       * destination. For unilateral capabilities, use
> > @@ -248,6 +251,8 @@ void test_postcopy_common(MigrateCommon *args);
> >  void test_postcopy_recovery_common(MigrateCommon *args);
> >  int test_precopy_common(MigrateCommon *args);
> >  void test_file_common(MigrateCommon *args, bool stop_src);
> > +int test_colo_common(MigrateCommon *args, bool failover_during_checkpo=
int,
> > +                     bool colo_primary_failover);
> >  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
> >                                                      QTestState *to,
> >                                                      const char *method=
);
> > @@ -267,5 +272,10 @@ void migration_test_add_file(MigrationTestEnv *env=
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
> >  =20
>=20


--Sig_/b=sOcAe.VQ.DHUzIVsQtwAG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlxKw8ACgkQNasLKJxd
slj21g//SOVAw/w8BTitzT95EWy0BgaEFxXhF4TKp8Uix5fNNwdVKijxjLq3VYH3
Pyf4ZopJIgbVzf8/g+qw2klsAX99oaJDgxl0ujUwQI9x7IL7QTJAQOf6EwnhgIXN
yIozkZP792FxvCBmCqhFqHsh5Q2GWZVlgu9GuqRfSDniycy4E/12RdA2DHZ9gsvJ
chjq6xXjuq21idipCwjctdrY20Bj6ga8KsXrguBYvuDPPDW1a4GyRZBA4LZju8ox
uaEk/+8pd9yyul9ojdhq1Sjov/Pd21KFvosC1TZABYR7tryUYY1fcDPXwJlZCI70
Iyvsb6Hmr9/8zG8yIp9ltCyfbvsCXxASHUR/aOmRdRKcufL/2yemxBak4fDFVeTE
OUFYiL6oZMX7gbTEIdeyjp0FbY6/5IBKXA3OPjePFZ/3IZ7lisqJjpOAZy8TAHVH
p4L2MEE96jEvmWxXbjcqg3t+zAJL8cU0Ke8Z7bSDKlDN2Wm5l1eqequcscC+X1uC
h3EgOe1E1BunUvNaLr92e/7aDpJGVM8RjhYg12uQxDaWBABAgVINhtNIG5IZm3dn
Eie2E1hsHE25rR6HSoGUbLNACKx9bfY6VG8qBbYNIXAj0sauEUncF4Eaiq3kk02V
fJ5BBbYSEf3ObOUXvYwJomWgG7JXfHKBVKzhG+IvdYb6b4obfoE=
=4M17
-----END PGP SIGNATURE-----

--Sig_/b=sOcAe.VQ.DHUzIVsQtwAG--

