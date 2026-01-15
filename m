Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87201D46627
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVvt-0001I8-SB; Thu, 15 Jan 2026 17:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVvr-0001He-4o
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:35:11 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVvo-0004yd-Rw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768516502; x=1769121302; i=lukasstraub2@web.de;
 bh=vLjFlP1gIGLZ9EyHFpzxsJkEOQXyuFo324k9Ftih0M8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TklQfsPnbCSaPa3iS2BidvLI/FeCwX15dbBdNFFzeqCUIXseNCvkMWFxYscjGQdv
 DtF0KBvkrNiZ5a8+UPdCupJH8TOHlGZO8XUSfzl2ddnJdRGv5jYUydwAY+fct9DPT
 1TTb6oQIICx3FSmKMmXx9TnGBsJ6HZ1pW4qCwYA5eEfJlgsfBdVa5op8vqW4/DwRh
 1M9y1yNuPasaU8n6BV9QlA/YtNJ/KgNlr5H51ytAmxUKw3Wd1ydaP3tgNElaEZgDZ
 qyI05xutu+dO94BVP6ryGIGC77+bghG5hO7Beec0XblAkyxMJUdcpFa/P1GZbBhaN
 jPxkpICD9RYrXJxTkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1vMddG0kVE-00OvsB; Thu, 15
 Jan 2026 23:35:02 +0100
Date: Thu, 15 Jan 2026 23:35:00 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>
Subject: Re: [PATCH 3/3] migration-test: Add COLO migration unit test
Message-ID: <20260115233500.26fd1628@penguin>
In-Reply-To: <aV1qf5uDYYiGrqR_@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-3-f9734bc74c71@web.de>
 <aV1qf5uDYYiGrqR_@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/79x2KtsYA6nhZql6.1zPKMm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:vTzwG3B8PL8lwuB7vZaitJajbOFeb1z6V0WprXTMVlVaO0/iyx3
 dEPQxuN0OSMfeZFrKmYLR6ZqnQpryTKHpvQ3YZFOvW7R85dxZkflWZjHuoY1btIQOI5g9rg
 oLddJrUdkpdpRXqwJ2CI3QKXwCP2205iJ2aIF/PCUvLBNLjRF6txguAqcmXS+1dc8R2TO5g
 seCqpFIg1EoyfghHFGHSg==
UI-OutboundReport: notjunk:1;M01:P0:M4yOolRMomk=;W2l9CQITyBsi93vTevV1OoDlH3g
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--Sig_/79x2KtsYA6nhZql6.1zPKMm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 15:03:11 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 30, 2025 at 03:05:46PM +0100, Lukas Straub wrote:
> > Add a COLO migration test for COLO migration and failover.
> >=20
> > COLO does not support q35 machine at this time.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  tests/qtest/meson.build            |   7 ++-
> >  tests/qtest/migration-test.c       |   1 +
> >  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++=
++++++++
> >  tests/qtest/migration/framework.c  |  65 ++++++++++++++++++++-
> >  tests/qtest/migration/framework.h  |   9 +++
> >  5 files changed, 195 insertions(+), 2 deletions(-)
> >=20
> > [...]
> > +
> > +void migration_test_add_colo(MigrationTestEnv *env)
> > +{
> > +    migration_test_add("/migration/colo/plain/secondary_failover",
> > +                       test_colo_plain_secondary_failover);
> > +
> > +    migration_test_add("/migration/colo/multifd/secondary_failover",
> > +                       test_colo_multifd_secondary_failover);
> > +
> > +    if (!env->full_set) {
> > +        return;
> > +    } =20
>=20
> IMHO we can skip all COLO tests in full_set.  Don't worry, if it's merged
> at least Fabiano and myself will always run it, making sure migration
> patches will be smoked.
>=20
> Here it's about whether we will run it in everyone's CI.

Okay, I will fix this in the next version.

>=20
> > +
> > +    migration_test_add("/migration/colo/plain/primary_failover",
> > +                       test_colo_plain_primary_failover);
> > +
> > +    migration_test_add("/migration/colo/multifd/primary_failover",
> > +                       test_colo_multifd_primary_failover);
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
> > index 8c1fc6e009f16dc05a47e917167f62e0250ca992..08bca49a8980f9988be9447=
acf54b17acd56da94 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char=
 *uri, MigrateStart *args)
> >      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> >          memory_size =3D "150M";
> > =20
> > -        if (g_str_equal(arch, "i386")) {
> > +        if (g_str_equal(arch, "i386") || args->is_colo) { =20
>=20
> OK, one more reference..
>=20
> I'm curious, why Q35 is not supported?

There is a bug in the emulated ahci disk controller which crashes when
it's vmstate is loaded more than once.

>=20
> >              machine_alias =3D "pc";
> >          } else {
> >              machine_alias =3D "q35";
> > @@ -1068,6 +1068,69 @@ void *migrate_hook_start_precopy_tcp_multifd_com=
mon(QTestState *from,
> >      return NULL;
> >  }
> > =20
> > +int test_colo_common(MigrateCommon *args)
> > +{
> > +    QTestState *from, *to;
> > +    void *data_hook =3D NULL;
> > +
> > +    args->start.oob =3D true;
> > +    args->start.is_colo =3D true;
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
> > +    wait_for_resume(to, &dst_state);
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
> > +    if (args->colo_failover_during_checkpoint) {
> > +        qtest_qmp_eventwait(to, "STOP");
> > +    }
> > +    if (args->colo_primary_failover) {
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
> > +    migrate_end(from, to, !args->colo_primary_failover);
> > +
> > +    return 0;
> > +}
> > +
> >  QTestMigrationState *get_src(void)
> >  {
> >      return &src_state;
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/=
framework.h
> > index 2ea13e7758697550b5531737e66d6d939dd800d1..1da532569d8c5941c99d83a=
e7da88ccab2bdcbe2 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -230,6 +230,9 @@ typedef struct {
> >       */
> >      bool live;
> > =20
> > +    bool colo_primary_failover;
> > +    bool colo_failover_during_checkpoint; =20
>=20
> Let's try to not add more per-feature fields here into the test framework
> struct.  My bad to have started doing this for postcopy tests..  I'll
> prepare patches to remove the postcopy ones.  These parameters can be
> passed from the test callers, afaict.
>=20
> Thanks,
>=20
> > +
> >      /* Postcopy specific fields */
> >      void *postcopy_data;
> >      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> > @@ -248,6 +251,7 @@ void test_postcopy_common(MigrateCommon *args);
> >  void test_postcopy_recovery_common(MigrateCommon *args);
> >  int test_precopy_common(MigrateCommon *args);
> >  void test_file_common(MigrateCommon *args, bool stop_src);
> > +int test_colo_common(MigrateCommon *args);
> >  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
> >                                                      QTestState *to,
> >                                                      const char *method=
);
> > @@ -267,5 +271,10 @@ void migration_test_add_file(MigrationTestEnv *env=
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


--Sig_/79x2KtsYA6nhZql6.1zPKMm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlpa5QACgkQNasLKJxd
slimJBAAnQFa+CaybuoMhQCq+jETd5pq2+jREvC/an99Zp5SQNXPyICm35n39qPm
D2GVvEoJLMkhOew2yLLY5zUunTKqUHbMxFh8EJrJ/uty0Iy0hjke0RriSuLAUrWe
b5U0YdekBDq+x1TjlTrDugWCALhsfPg6gbsqdf27PgftLZifqY9cHed7yiFKcbRt
YS5NdRs+Wb93HT/JWrqPAaz3TVXMzO3jTUyILAJwakDos2IbP0h8Ye2m3WNwVmqC
yhklZciH7pvUlCH7Gqc6010gQ0UVJAveIMMlfaVA7gDZMP7kdoMgEOm2B0QVz21B
FMET4i+1fUinKg3ORkU+UdOEkTNC+H8m6SDaekhwcrWCEaYzizojrSYAmiu7VH/z
oEXxtD2DJvvGiPFN5iNXXZGEErFlXX/+PfGZsNu9a6wp7V4oJ+X2wAuPnI8Ivxgr
JVIXHai8wTjXvooWdap46ZW/JjMM6g/epzo6l0GgRKtLeXMDmF8DaL7RW+aQRhb5
i9MJvG0qgEKNg6L2q4zVNWWQRCiXBh6YsVkwaxlW/I2xqtczVe0iAyZOtQOB8Loy
5zF5FUAYuUHupYyf0wSArSqfSUeGt65va4mTNrTUvoqPK1jCcRvzPjJBbVDz2oFW
bqsXqzaUJKtt9g1lweLz6xEwt0Pnlti34zCqkuZJ79/36/aSGd4=
=iBPd
-----END PGP SIGNATURE-----

--Sig_/79x2KtsYA6nhZql6.1zPKMm--

